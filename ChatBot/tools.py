# tools.py
import sys
from pathlib import Path

# Adicionar a raiz do projeto ao path
sys.path.insert(0, str(Path(__file__).parent.parent))

from agno.tools import tool
from typing import Optional
from Dados.analises import AnaliseDados
import pandas as pd


# -------------------------------------------
# Instância global das análises (reutiliza conexão)
# -------------------------------------------
_analise_instance = None

def get_analise():
    """Singleton para reutilizar conexão com MongoDB"""
    global _analise_instance
    if _analise_instance is None:
        _analise_instance = AnaliseDados()
    return _analise_instance


# -------------------------------------------
# 1. ANÁLISES DE CLIENTES
# -------------------------------------------
@tool
def analisar_clientes(tipo: str, top_n: int = 10) -> str:
    """
    Realiza análises sobre clientes da ConectaBeauty.
    
    Args:
        tipo: Tipo de análise - 'sexo', 'regiao', 'canal_venda', 'valiosos'
        top_n: Número de resultados (para análises com ranking)
    
    Returns:
        String com dados formatados
    """
    analise = get_analise()
    
    if tipo == 'sexo':
        df = analise.analise_clientes_por_sexo()
        return df.to_string(index=False)
    
    elif tipo == 'regiao':
        df = analise.analise_clientes_por_regiao().head(top_n)
        return df.to_string(index=False)
    
    elif tipo == 'canal_venda':
        df = analise.analise_compras_por_canal_cliente().head(top_n)
        return df.to_string(index=False)
    
    elif tipo == 'valiosos':
        df = analise.analise_clientes_mais_valiosos(top_n)
        return df.to_string(index=False)
    
    else:
        return f"Tipo '{tipo}' não reconhecido. Use: sexo, regiao, canal_venda, valiosos"


# -------------------------------------------
# 2. ANÁLISES DE PRODUTOS
# -------------------------------------------
@tool
def analisar_produtos(tipo: str, top_n: int = 10) -> str:
    """
    Realiza análises sobre produtos da ConectaBeauty.
    
    Args:
        tipo: Tipo de análise - 'top_vendidos', 'segmento', 'cores', 'cosmeticos', 'cadeiras', 'rentabilidade'
        top_n: Quantidade de resultados
    
    Returns:
        String com dados formatados
    """
    analise = get_analise()
    
    if tipo == 'top_vendidos':
        df = analise.analise_top_produtos_mais_vendidos(top_n)
        return df.to_string(index=False)
    
    elif tipo == 'segmento':
        df = analise.analise_vendas_por_segmento()
        return df.to_string(index=False)
    
    elif tipo == 'cores':
        df = analise.analise_cores_mais_vendidas().head(top_n)
        return df.to_string(index=False)
    
    elif tipo == 'cosmeticos':
        df = analise.analise_top_cosmeticos(top_n)
        return df.to_string(index=False)
    
    elif tipo == 'cadeiras':
        df = analise.analise_top_cadeiras_lavatorios(top_n)
        return df.to_string(index=False)
    
    elif tipo == 'rentabilidade':
        df = analise.analise_rentabilidade_produtos().head(top_n)
        return df.to_string(index=False)
    
    else:
        return f"Tipo '{tipo}' não reconhecido"


# -------------------------------------------
# 3. ANÁLISES DE VENDAS
# -------------------------------------------
@tool
def analisar_vendas(tipo: str, ano: Optional[int] = None, mes: Optional[int] = None) -> str:
    """
    Realiza análises sobre vendas da ConectaBeauty.
    
    Args:
        tipo: Tipo de análise:
            - 'ano': Vendas totais por ano (todos os anos)
            - 'mensal': Vendas por mês (use 'ano' para filtrar um ano específico)
            - 'canal': Vendas por canal (opcionalmente filtrado por ano/mes)
            - 'pagamento': Vendas por forma de pagamento
            - 'representante': Vendas por representante
            - 'total': Totalizadores gerais (OBRIGATÓRIO passar 'ano' para filtrar)
            - 'sazonalidade': Análise de padrões sazonais
            - 'comparar_meses': Comparar mesmo mês entre anos (requer 'mes')
        ano: Ano para filtro (número inteiro: 2021-2025). CRÍTICO para tipo='total' e tipo='mensal'
        mes: Mês para filtro (número 1-12). Usado em tipo='canal' e tipo='comparar_meses'
    
    Returns:
        String com dados formatados
    
    Exemplos de uso correto:
        analisar_vendas(tipo='total', ano=2022) → faturamento total de 2022
        analisar_vendas(tipo='mensal', ano=2022) → vendas mês a mês de 2022
        analisar_vendas(tipo='ano') → vendas por ano (todos os anos)
        analisar_vendas(tipo='canal', ano=2023, mes=5) → vendas por canal em maio/2023
    """
    analise = get_analise()
    
    if tipo == 'ano':
        df = analise.analise_vendas_por_ano()
        return df.to_string(index=False)
    
    elif tipo == 'mensal':
        df = analise.analise_vendas_mensal(ano=ano)
        return df.to_string(index=False)
    
    elif tipo == 'canal':
        if mes and ano:
            df = analise.analise_vendas_canal_por_mes(ano, mes)
        else:
            df = analise.analise_vendas_por_canal()
        return df.to_string(index=False)
    
    elif tipo == 'pagamento':
        df = analise.analise_vendas_por_forma_pagamento()
        return df.to_string(index=False)
    
    elif tipo == 'representante':
        df = analise.analise_vendas_por_representante()
        return df.to_string(index=False)
    
    elif tipo == 'total':
        dados = analise.analise_total_vendas_geral(ano=ano, mes=mes)
        return "\n".join([f"{k}: {v}" for k, v in dados.items()])
    
    elif tipo == 'sazonalidade':
        df = analise.analise_sazonalidade()
        return df.to_string(index=False)
    
    elif tipo == 'comparar_meses':
        if not mes:
            return "Para comparar meses, forneça o parâmetro 'mes' (1-12)"
        df = analise.comparar_meses_entre_anos(mes)
        return df.to_string(index=False)
    
    else:
        return f"Tipo '{tipo}' não reconhecido"


# -------------------------------------------
# 4. RECOMENDAÇÃO DE CAMPANHAS
# -------------------------------------------
@tool
def recomendar_campanha(categoria: Optional[str] = None, periodo: str = "trimestre") -> str:
    """
    Gera recomendações de campanhas de marketing baseadas em análises de vendas.
    
    Args:
        categoria: Categoria de produtos (Cosmeticos, Cadeiras, etc) - opcional
        periodo: Período para análise - 'trimestre', 'semestre', 'ano'
    
    Returns:
        String com recomendações detalhadas
    """
    analise = get_analise()
    
    # Coleta dados para recomendação
    top_produtos = analise.analise_top_produtos_mais_vendidos(5)
    sazonalidade = analise.analise_sazonalidade()
    vendas_canal = analise.analise_vendas_por_canal()
    clientes_sexo = analise.analise_clientes_por_sexo()
    
    recomendacao = "=== RECOMENDAÇÃO DE CAMPANHA ===\n\n"
    
    # Top produtos
    recomendacao += "📊 TOP 5 PRODUTOS MAIS VENDIDOS:\n"
    recomendacao += top_produtos.to_string(index=False)
    recomendacao += "\n\n"
    
    # Canal preferido
    recomendacao += "🛒 CANAL DE VENDA PREFERIDO:\n"
    recomendacao += vendas_canal.head(3).to_string(index=False)
    recomendacao += "\n\n"
    
    # Perfil do cliente
    recomendacao += "👥 PERFIL DOS CLIENTES:\n"
    recomendacao += clientes_sexo.to_string(index=False)
    recomendacao += "\n\n"
    
    recomendacao += "💡 SUGESTÕES:\n"
    recomendacao += "1. Focar nos produtos listados acima (maior demanda)\n"
    recomendacao += "2. Priorizar o canal de venda principal para divulgação\n"
    recomendacao += "3. Adaptar linguagem ao perfil demográfico predominante\n"
    recomendacao += "4. Considerar combos/kits com produtos complementares\n"
    recomendacao += "5. Avaliar sazonalidade para timing ideal da campanha\n"
    
    return recomendacao


# -------------------------------------------
# 5. MIX DE PRODUTOS
# -------------------------------------------
@tool
def analisar_mix_produtos(top_n: int = 10) -> str:
    """
    Analisa os mixes de produtos mais comuns nos pedidos.
    Útil para criar combos e estratégias de cross-sell.
    
    Args:
        top_n: Quantidade de combinações a retornar
    
    Returns:
        String com dados formatados
    """
    analise = get_analise()
    df = analise.analise_mix_produtos_por_pedido().head(top_n)
    return df.to_string(index=False)


# -------------------------------------------
# 6. COTAÇÃO DE PRODUTOS
# -------------------------------------------
@tool
def obter_cotacao_produto(nome_produto: Optional[str] = None, id_produto: Optional[int] = None, quantidade: int = 1) -> str:
    """
    Retorna a cotação (preço) de um produto específico da loja.
    Pode buscar por nome ou ID do produto.
    
    Args:
        nome_produto: Nome do produto (busca parcial, case-insensitive)
        id_produto: ID exato do produto
        quantidade: Quantidade para calcular o total (padrão: 1)
    
    Returns:
        String com informações de cotação do produto
    """
    analise = get_analise()
    
    # Buscar no dataframe de produtos (nome correto: df_produtos)
    produtos_df = analise.df_produtos
    
    if produtos_df.empty:
        return "Erro: Não foi possível carregar os dados de produtos."
    
    # Filtrar por ID ou nome
    if id_produto is not None:
        produto = produtos_df[produtos_df['id_produto'] == id_produto]
    elif nome_produto:
        # Busca case-insensitive e parcial
        produto = produtos_df[produtos_df['nome_produto'].str.contains(nome_produto, case=False, na=False)]
    else:
        return "Erro: Forneça o nome_produto ou id_produto para buscar a cotação."
    
    if produto.empty:
        busca = nome_produto if nome_produto else f"ID {id_produto}"
        return f"Produto não encontrado: {busca}\n\nDica: Use analisar_produtos(tipo='top_vendidos') para ver produtos disponíveis."
    
    # Se encontrou múltiplos, listar opções
    if len(produto) > 1:
        resultado = f"Encontrados {len(produto)} produtos correspondentes:\n\n"
        for _, p in produto.head(10).iterrows():
            preco = p.get('valor_unitario', 0)
            resultado += f"• ID {p['id_produto']}: {p['nome_produto']} - R$ {preco:,.2f}\n"
        resultado += "\nEspecifique melhor o produto ou use o ID para cotação exata."
        return resultado
    
    # Produto único encontrado
    p = produto.iloc[0]
    preco_unitario = float(p.get('valor_unitario', 0))
    id_prod = p['id_produto']
    nome = p['nome_produto']
    categoria = p.get('categoria', 'N/A')
    
    # Calcular total
    preco_total = preco_unitario * quantidade
    
    # Buscar informações de vendas (nome correto: df_vendas)
    vendas_df = analise.df_vendas
    vendas_produto = vendas_df[vendas_df['id_produto'] == id_prod]
    
    qtd_vendida = len(vendas_produto)
    
    # Montar resposta direta e objetiva
    cotacao = f"💰 **COTAÇÃO**\n\n"
    cotacao += f"**Produto:** {nome}\n"
    cotacao += f"**Preço Unitário:** R$ {preco_unitario:,.2f}\n"
    
    if quantidade > 1:
        cotacao += f"**Quantidade:** {quantidade} unidades\n"
        cotacao += f"**Valor Total:** R$ {preco_total:,.2f}\n"
    
    if qtd_vendida > 0:
        cotacao += f"\n_({qtd_vendida} vendas registradas)_"
    
    return cotacao


# -------------------------------------------
# 7. BUSCAR INFORMAÇÕES DE PRODUTO
# -------------------------------------------
@tool
def buscar_produto(criterio: str, top_n: int = 5) -> str:
    """
    Busca produtos por nome, categoria ou características.
    Útil quando não sabe o nome exato.
    
    Args:
        criterio: Termo de busca (nome parcial, categoria, etc)
        top_n: Quantidade de resultados
    
    Returns:
        Lista de produtos encontrados com preços
    """
    analise = get_analise()
    produtos_df = analise.df_produtos
    
    if produtos_df.empty:
        return "Erro: Não foi possível carregar os dados de produtos."
    
    # Buscar em nome e categoria
    mask = (
        produtos_df['nome_produto'].str.contains(criterio, case=False, na=False) |
        produtos_df.get('categoria', pd.Series()).str.contains(criterio, case=False, na=False)
    )
    
    resultado = produtos_df[mask].head(top_n)
    
    if resultado.empty:
        return f"Nenhum produto encontrado para: '{criterio}'\n\nTente termos mais genéricos ou use analisar_produtos(tipo='top_vendidos')."
    
    resposta = f"🔍 **Produtos encontrados para '{criterio}':**\n\n"
    
    for idx, p in resultado.iterrows():
        preco = p.get('valor_unitario', 0)
        resposta += f"• **{p['nome_produto']}** (ID: {p['id_produto']})\n"
        resposta += f"  {p.get('categoria', 'N/A')} - R$ {preco:,.2f}\n\n"
    
    return resposta


# -------------------------------------------
# TOOL ROUTER
# -------------------------------------------
def get_tool_router():
    """Retorna lista de todas as tools disponíveis para o agente"""
    return [
        analisar_clientes,
        analisar_produtos,
        analisar_vendas,
        recomendar_campanha,
        analisar_mix_produtos,
        obter_cotacao_produto,
        buscar_produto,
    ]

