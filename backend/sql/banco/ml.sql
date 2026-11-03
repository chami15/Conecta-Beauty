CREATE SCHEMA IF NOT EXISTS ml; --schema para as bases e os resultados dos modelos de machine learning

-- Um pedido por linha, com as variáveis usadas pelo K-Means de segmentação.
-- Montada a partir das tabelas fato, então inclui os pedidos do ERP e os dos canais
-- externos carregados pelo scripts/datalake/carregar_dw.py.
-- O frete fica de fora das variáveis do modelo: Instagram e Facebook não informam frete,
-- e tratar a ausência como zero faria o K-Means separar os pedidos por canal.
CREATE OR REPLACE VIEW ml.pedidos_padronizados AS
SELECT p.numero_pedido AS pedido_id,
       p.data_hora_pedido AS data_pedido,
       cv.canal_venda AS canal,
       COALESCE(p.valor_total, SUM(v.valor_total)) AS valor_total,
       p.valor_frete,
       SUM(v.quantidade) AS quantidade_itens,
       COUNT(DISTINCT v.fk_produto) AS produtos_distintos,
       SUM(v.valor_total) / NULLIF(SUM(v.quantidade), 0) AS preco_medio_item
FROM financeiro.fato_pedido p
JOIN financeiro.fato_venda v ON v.numero_pedido = p.numero_pedido
JOIN administrativo.dim_canal_venda cv ON cv.id_canal_venda = p.fk_canal_venda
GROUP BY p.numero_pedido, p.data_hora_pedido, cv.canal_venda, p.valor_total, p.valor_frete;

-- Segmento de cada pedido, regravado a cada treino do K-Means (POST /api/ml/kmeans/treinar).
-- É a tabela que o Power BI lê para a página de segmentação (liga em fato_pedido.numero_pedido).
CREATE TABLE IF NOT EXISTS ml.segmento_pedido(
    pedido_id INT PRIMARY KEY,
    cluster INT NOT NULL,
    segmento VARCHAR(60) NOT NULL,
    atualizado_em TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_segmento_pedido_cluster ON ml.segmento_pedido(cluster);
