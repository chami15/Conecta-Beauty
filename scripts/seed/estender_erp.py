"""
Estende os dados do ERP (que terminam em 09/06/2026) ate --fim, copiando as vendas do
mesmo periodo do ano anterior com as datas um ano a frente: cada mes novo repete a
sazonalidade do mesmo mes do ano passado.

Copia, mantendo as ligacoes entre elas:
    financeiro.fato_pedido               (pedidos do ERP; os dos canais externos ficam de fora)
    financeiro.fato_venda                (itens dos pedidos copiados)
    estoque.fato_pedido_frete            (frete dos pedidos copiados)
    financeiro.fato_transacao_financeira ("Venda pedido #N" e "CMV pedido #N" dos pedidos copiados)
    estoque.fato_movimentacao_estoque    (compras e vendas do periodo; o trigger recalcula o saldo
                                          e recusa saida sem estoque - essas sao puladas e contadas)

Os pedidos copiados ganham numeros novos e cada linha criada fica registrada em
financeiro.controle_extensao_erp, para --desfazer remover exatamente o que foi criado.

Por seguranca, sem --executar tudo roda e e desfeito no fim (rollback): mostra os numeros
exatos sem gravar nada. Com --executar, grava em uma unica transacao.

Ordem recomendada (o gerador dos canais externos usa o volume mensal do ERP):
    cd backend
    python ../scripts/datalake/carregar_dw.py --desfazer --executar   # tira a carga antiga dos canais
    python ../scripts/seed/estender_erp.py                             # simulacao
    python ../scripts/seed/estender_erp.py --executar
    python ../scripts/seed/gerar_pedidos_canais.py --enviar-bronze
    cd .. && python scripts/datalake/pipeline.py --executar --treinar-ml
"""
import argparse
import os
import sys
from datetime import date, timedelta

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "datalake"))

# carregar_dw ja le o backend/.env e sabe conectar, criar datas na dim_tempo e atualizar os cubos
from carregar_dw import atualizar_cubos, conectar, garantir_datas

FIM_PADRAO = "2026-11-30"
DESLOCAMENTO = 365  # dias: 2025-06-10 + 365 = 2026-06-10 (2026 nao e bissexto)

DDL_CONTROLE = """
CREATE TABLE IF NOT EXISTS financeiro.controle_extensao_erp(
    tabela VARCHAR(60) NOT NULL,
    id INT NOT NULL,
    criado_em TIMESTAMP NOT NULL DEFAULT NOW(),
    PRIMARY KEY (tabela, id)
)
"""

# Pedidos do ERP no periodo de origem, com o numero novo (depois do maior numero existente).
MAPA_PEDIDOS = """
CREATE TEMP TABLE mapa_pedido ON COMMIT DROP AS
SELECT p.numero_pedido AS origem,
       (SELECT MAX(numero_pedido) FROM financeiro.fato_pedido)
         + ROW_NUMBER() OVER (ORDER BY p.data_hora_pedido, p.numero_pedido) AS novo
FROM financeiro.fato_pedido p
WHERE p.data_hora_pedido >= %(origem_ini)s AND p.data_hora_pedido < %(origem_fim)s {so_erp}
"""
# Pedidos dos canais externos (carregados pelo carregar_dw.py) nao sao copiados.
SO_ERP = "AND NOT EXISTS (SELECT 1 FROM financeiro.controle_carga_canais c WHERE c.numero_pedido = p.numero_pedido)"

COPIAS = {
    "financeiro.fato_pedido": """
        INSERT INTO financeiro.fato_pedido (numero_pedido, fk_tempo, fk_cliente, fk_canal_venda, fk_forma_pagamento,
                                            qtd_itens, valor_total, valor_frete, status_pedido, data_hora_pedido)
        SELECT m.novo, t.id_tempo, p.fk_cliente, p.fk_canal_venda, p.fk_forma_pagamento,
               p.qtd_itens, p.valor_total, p.valor_frete, p.status_pedido, p.data_hora_pedido + %(desloc)s
        FROM financeiro.fato_pedido p
        JOIN mapa_pedido m ON m.origem = p.numero_pedido
        JOIN geral.dim_tempo t ON t.data = (p.data_hora_pedido + %(desloc)s)::date
        RETURNING id_pedido""",
    "financeiro.fato_venda": """
        INSERT INTO financeiro.fato_venda (numero_pedido, numero_item, fk_tempo, fk_cliente, fk_produto, fk_canal_venda,
                                           fk_forma_pagamento, quantidade, valor_unitario, valor_total, data_hora_venda)
        SELECT m.novo, v.numero_item, t.id_tempo, v.fk_cliente, v.fk_produto, v.fk_canal_venda,
               v.fk_forma_pagamento, v.quantidade, v.valor_unitario, v.valor_total, v.data_hora_venda + %(desloc)s
        FROM financeiro.fato_venda v
        JOIN mapa_pedido m ON m.origem = v.numero_pedido
        JOIN geral.dim_tempo t ON t.data = (v.data_hora_venda + %(desloc)s)::date
        RETURNING id_venda""",
    "estoque.fato_pedido_frete": """
        INSERT INTO estoque.fato_pedido_frete (numero_pedido, fk_tempo_envio, fk_tempo_entrega, fk_transportadora,
                                               fk_localizacao_origem, fk_localizacao_destino, peso_total_kg,
                                               volume_total_m3, distancia_km, valor_frete, prazo_entrega_dias,
                                               data_hora_entrega, status_frete, dias_atraso, houve_avaria)
        SELECT m.novo, te_novo.id_tempo, tr_novo.id_tempo, f.fk_transportadora,
               f.fk_localizacao_origem, f.fk_localizacao_destino, f.peso_total_kg,
               f.volume_total_m3, f.distancia_km, f.valor_frete, f.prazo_entrega_dias,
               f.data_hora_entrega + %(desloc)s, f.status_frete, f.dias_atraso, f.houve_avaria
        FROM estoque.fato_pedido_frete f
        JOIN mapa_pedido m ON m.origem = f.numero_pedido
        LEFT JOIN geral.dim_tempo te ON te.id_tempo = f.fk_tempo_envio
        LEFT JOIN geral.dim_tempo te_novo ON te_novo.data = te.data + %(desloc)s
        LEFT JOIN geral.dim_tempo tr ON tr.id_tempo = f.fk_tempo_entrega
        LEFT JOIN geral.dim_tempo tr_novo ON tr_novo.data = tr.data + %(desloc)s
        RETURNING id_frete""",
    "financeiro.fato_transacao_financeira": """
        INSERT INTO financeiro.fato_transacao_financeira (numero_transacao, fk_data_pagamento, fk_forma_pagamento,
                                                          tipo_transacao, valor_total_transacao, status_transacao,
                                                          historico, data_hora_lancamento)
        SELECT (SELECT MAX(numero_transacao) FROM financeiro.fato_transacao_financeira)
                 + ROW_NUMBER() OVER (ORDER BY x.data_hora_lancamento, x.id_transacao),
               tp_novo.id_tempo, x.fk_forma_pagamento, x.tipo_transacao, x.valor_total_transacao,
               x.status_transacao, regexp_replace(x.historico, '#[0-9]+', '#' || m.novo),
               x.data_hora_lancamento + %(desloc)s
        FROM financeiro.fato_transacao_financeira x
        JOIN mapa_pedido m ON m.origem = substring(x.historico FROM 'pedido #([0-9]+)')::int
        LEFT JOIN geral.dim_tempo tp ON tp.id_tempo = x.fk_data_pagamento
        LEFT JOIN geral.dim_tempo tp_novo ON tp_novo.data = tp.data + %(desloc)s
        RETURNING id_transacao""",
}

# Uma movimentacao por vez, em ordem de data: o trigger trg_atualizar_saldo calcula o saldo a
# partir da anterior e recusa saida que deixaria o estoque negativo. A recusada e pulada.
MOVIMENTACOES = """
CREATE TEMP TABLE resultado_mov (id INT, pulada BOOLEAN) ON COMMIT DROP;
DO $$
DECLARE
    r RECORD;
    novo_id INT;
BEGIN
    FOR r IN
        SELECT mv.*, t.id_tempo AS fk_tempo_novo
        FROM estoque.fato_movimentacao_estoque mv
        JOIN geral.dim_tempo t ON t.data = (mv.data_hora_movimentacao + INTERVAL '{desloc} days')::date
        WHERE mv.data_hora_movimentacao >= '{origem_ini}' AND mv.data_hora_movimentacao < '{origem_fim}'
        ORDER BY mv.data_hora_movimentacao, mv.id_movimentacao
    LOOP
        BEGIN
            INSERT INTO estoque.fato_movimentacao_estoque (fk_tempo, fk_produto, fk_tipo_movimentacao, fk_fornecedor,
                                                           quantidade, valor_unitario, valor_total,
                                                           saldo_anterior, saldo_atual, data_hora_movimentacao)
            VALUES (r.fk_tempo_novo, r.fk_produto, r.fk_tipo_movimentacao, r.fk_fornecedor,
                    r.quantidade, r.valor_unitario, r.valor_total, 0, 0,
                    r.data_hora_movimentacao + INTERVAL '{desloc} days')
            RETURNING id_movimentacao INTO novo_id;
            INSERT INTO resultado_mov VALUES (novo_id, FALSE);
        EXCEPTION WHEN raise_exception OR check_violation THEN
            INSERT INTO resultado_mov VALUES (NULL, TRUE);
        END;
    END LOOP;
END $$;
"""


def tabela_existe(cur, nome):
    cur.execute("SELECT to_regclass(%s) IS NOT NULL", (nome,))
    return cur.fetchone()[0]


def registrar(cur, tabela, ids):
    if ids:
        cur.execute("INSERT INTO financeiro.controle_extensao_erp (tabela, id) SELECT %s, unnest(%s::int[])",
                    (tabela, ids))


def estender(conexao, fim, executar):
    cur = conexao.cursor()
    cur.execute(DDL_CONTROLE)
    cur.execute("SELECT COUNT(*) FROM financeiro.controle_extensao_erp")
    if cur.fetchone()[0]:
        raise SystemExit("O ERP ja foi estendido. Para refazer, rode antes com --desfazer --executar.")

    canais_externos = tabela_existe(cur, "financeiro.controle_carga_canais")
    so_erp = SO_ERP if canais_externos else ""
    cur.execute(f"SELECT MAX(p.data_hora_pedido)::date FROM financeiro.fato_pedido p WHERE TRUE {so_erp}")
    ultimo_erp = cur.fetchone()[0]
    inicio = ultimo_erp + timedelta(days=1)
    if fim < inicio:
        raise SystemExit(f"O ERP ja vai ate {ultimo_erp:%d/%m/%Y}: nada a estender ate {fim:%d/%m/%Y}.")
    if (fim - inicio).days >= DESLOCAMENTO:
        raise SystemExit("Periodo maior que um ano: rode em etapas (a copia usa o ano anterior como origem).")

    desloc = timedelta(days=DESLOCAMENTO)
    params = {"origem_ini": inicio - desloc, "origem_fim": fim - desloc + timedelta(days=1), "desloc": desloc}

    print("===== EXTENSAO DO ERP =====")
    print(f"Ultimo dia com venda do ERP:  {ultimo_erp:%d/%m/%Y}")
    print(f"Periodo novo:                 {inicio:%d/%m/%Y} a {fim:%d/%m/%Y}")
    print(f"Copiado de:                   {params['origem_ini']:%d/%m/%Y} a {fim - desloc:%d/%m/%Y}")

    cur.execute("SELECT id_tempo, data FROM geral.dim_tempo")
    dim = {"tempo": {data: id_ for id_, data in cur.fetchall()}}
    datas_novas = garantir_datas(cur, [inicio + timedelta(days=i) for i in range((fim - inicio).days + 31)], dim)

    cur.execute(MAPA_PEDIDOS.format(so_erp=so_erp), params)

    criados = {}
    for tabela, consulta in COPIAS.items():
        cur.execute(consulta, params)
        ids = [linha[0] for linha in cur.fetchall()]
        registrar(cur, tabela, ids)
        criados[tabela] = len(ids)

    cur.execute(MOVIMENTACOES.format(desloc=DESLOCAMENTO, origem_ini=params["origem_ini"],
                                     origem_fim=params["origem_fim"]))
    cur.execute("SELECT id FROM resultado_mov WHERE NOT pulada")
    ids_mov = [linha[0] for linha in cur.fetchall()]
    registrar(cur, "estoque.fato_movimentacao_estoque", ids_mov)
    cur.execute("SELECT COUNT(*) FROM resultado_mov WHERE pulada")
    puladas = cur.fetchone()[0]

    cur.execute("""SELECT COUNT(*), COALESCE(SUM(v.valor_total), 0) FROM financeiro.fato_venda v
                   JOIN financeiro.controle_extensao_erp c ON c.tabela = 'financeiro.fato_venda' AND c.id = v.id_venda""")
    _, faturamento = cur.fetchone()

    print(f"Datas criadas na dim_tempo:   {datas_novas}")
    print(f"Pedidos:                      {criados['financeiro.fato_pedido']}")
    print(f"Itens de venda:               {criados['financeiro.fato_venda']} (R$ {faturamento:,.2f})")
    print(f"Fretes:                       {criados['estoque.fato_pedido_frete']}")
    print(f"Transacoes financeiras:       {criados['financeiro.fato_transacao_financeira']}")
    print(f"Movimentacoes de estoque:     {len(ids_mov)} (puladas por falta de saldo: {puladas})")

    if executar:
        conexao.commit()
        print("\nExtensao gravada (transacao confirmada).")
    else:
        conexao.rollback()
        print("\nSimulacao: tudo foi desfeito, nada ficou gravado. Use --executar para gravar.")
    return executar


def desfazer(conexao, executar):
    cur = conexao.cursor()
    if not tabela_existe(cur, "financeiro.controle_extensao_erp"):
        print("Nada a desfazer: o ERP nunca foi estendido.")
        return
    cur.execute("SELECT tabela, COUNT(*) FROM financeiro.controle_extensao_erp GROUP BY 1 ORDER BY 1")
    contagem = cur.fetchall()
    print("===== DESFAZER EXTENSAO DO ERP =====")
    for tabela, qtd in contagem:
        print(f"  {tabela:<40} {qtd}")
    if not executar:
        print("\nSimulacao: nada foi alterado. Use --executar para desfazer de verdade.")
        return
    # Filhas antes do pedido; a movimentacao de estoque nao depende do pedido.
    chaves = {"financeiro.fato_venda": "id_venda", "estoque.fato_pedido_frete": "id_frete",
              "financeiro.fato_transacao_financeira": "id_transacao",
              "estoque.fato_movimentacao_estoque": "id_movimentacao", "financeiro.fato_pedido": "id_pedido"}
    for tabela, chave in chaves.items():
        cur.execute(f"""DELETE FROM {tabela} WHERE {chave} IN
                        (SELECT id FROM financeiro.controle_extensao_erp WHERE tabela = %s)""", (tabela,))
    cur.execute("DELETE FROM financeiro.controle_extensao_erp")
    conexao.commit()
    print("Extensao removida. (As datas criadas na dim_tempo ficam: sao inofensivas.)")


def main():
    parser = argparse.ArgumentParser(description="Estende os dados do ERP copiando o ano anterior")
    parser.add_argument("--fim", type=date.fromisoformat, default=date.fromisoformat(FIM_PADRAO),
                        help=f"ultimo dia dos dados novos, AAAA-MM-DD (padrao: {FIM_PADRAO})")
    parser.add_argument("--executar", action="store_true", help="grava de verdade (sem isso, so simula)")
    parser.add_argument("--desfazer", action="store_true", help="remove o que este script criou")
    parser.add_argument("--atualizar-cubos", action="store_true", help="atualiza os cubos OLAP ao final")
    args = parser.parse_args()

    conexao = conectar()
    try:
        if args.desfazer:
            desfazer(conexao, args.executar)
        elif estender(conexao, args.fim, args.executar) and args.atualizar_cubos:
            atualizar_cubos(conexao)
    except BaseException:
        conexao.rollback()
        raise
    finally:
        conexao.close()


if __name__ == "__main__":
    main()
