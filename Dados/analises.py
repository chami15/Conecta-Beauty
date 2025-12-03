import pandas as pd
import numpy as np
from .transformacao import Transformacao
from datetime import datetime
from typing import Dict, Any


def formatar_moeda(valor):
    """Formata valor numérico para formato brasileiro R$ 9.999,99"""
    if pd.isna(valor):
        return "R$ 0,00"
    return f"R$ {valor:,.2f}".replace(",", "X").replace(".", ",").replace("X", ".")


class AnaliseDados:
    """Classe para análise de dados de vendas, produtos e clientes"""
    
    def __init__(self):
        """Inicializa a classe e carrega todos os dados transformados"""
        self.transformacao = Transformacao()
        self._carregar_dados()
        self._preparar_dados()
    
    def _carregar_dados(self):
        """Carrega todos os dados das coleções"""
        print("Carregando dados...")
        self.df_clientes = self.transformacao.transformar_clientes()
        self.df_vendas = self.transformacao.transformar_vendas()
        self.df_produtos = self.transformacao.transformar_produtos()
        self.df_cor_produto = self.transformacao.transformar_cor_produto()
        self.df_pedidos = self.transformacao.transformar_pedidos()
        print("Dados carregados com sucesso!\n")
    
    def _preparar_dados(self):
        """Prepara e normaliza os dados para análise"""
        # Padronizar nomes de colunas
        self.df_produtos.columns = ['id_produto', 'nome_produto', 'categoria', 'fornecedor', 'valor_unitario']
        self.df_cor_produto.columns = ['id_cor', 'nome_cor']
        self.df_pedidos.columns = ['id_pedido', 'id_cliente', 'data_pedido', 'valor_total', 'forma_pagamento', 'canal_venda']
        
        # Converter data_pedido para datetime
        self.df_pedidos['data_pedido'] = pd.to_datetime(self.df_pedidos['data_pedido'], errors='coerce')
        
        # Extrair informações de data
        self.df_pedidos['ano'] = self.df_pedidos['data_pedido'].dt.year
        self.df_pedidos['mes'] = self.df_pedidos['data_pedido'].dt.month
        self.df_pedidos['mes_nome'] = self.df_pedidos['data_pedido'].dt.strftime('%B')
        self.df_pedidos['ano_mes'] = self.df_pedidos['data_pedido'].dt.to_period('M')
        
        # Criar dataframe consolidado (vendas + pedidos + produtos + clientes + cores)
        self.df_completo = self._criar_dataframe_consolidado()
    
    def _criar_dataframe_consolidado(self) -> pd.DataFrame:
        """Cria um dataframe consolidado com todas as informações"""
        # Merge vendas com pedidos
        df = self.df_vendas.merge(
            self.df_pedidos,
            left_on='id_pedido',
            right_on='id_pedido',
            how='left'
        )
        
        # Merge com produtos
        df = df.merge(
            self.df_produtos,
            left_on='id_produto',
            right_on='id_produto',
            how='left'
        )
        
        # Merge com cores
        df = df.merge(
            self.df_cor_produto,
            left_on='id_cor',
            right_on='id_cor',
            how='left'
        )
        
        # Merge com clientes
        df = df.merge(
            self.df_clientes,
            left_on='id_cliente',
            right_on='id_cliente',
            how='left'
        )
        
        return df
    
    # ==================== ANÁLISES DE CLIENTES ====================
    
    def analise_clientes_por_sexo(self) -> pd.DataFrame:
        """Análise de distribuição de clientes por sexo"""
        analise = self.df_clientes['sexo'].value_counts().reset_index()
        analise.columns = ['sexo', 'quantidade']
        analise['percentual'] = (analise['quantidade'] / analise['quantidade'].sum() * 100).round(2)
        analise['percentual'] = analise['percentual'].apply(lambda x: f"{x:.2f}%")
        return analise
    
    def analise_clientes_por_regiao(self) -> pd.DataFrame:
        """Análise de distribuição de clientes por região/cidade"""
        analise = self.df_clientes.groupby(['estado2', 'cidade']).size().reset_index(name='quantidade')
        analise = analise.sort_values('quantidade', ascending=False)
        analise['percentual'] = (analise['quantidade'] / analise['quantidade'].sum() * 100).round(2)
        analise['percentual'] = analise['percentual'].apply(lambda x: f"{x:.2f}%")
        return analise
    
    def analise_compras_por_canal_cliente(self) -> pd.DataFrame:
        """Análise de compras por canal (loja física ou instagram) por cliente"""
        analise = self.df_completo.groupby(['id_cliente', 'nome', 'sexo', 'canal_venda']).agg({
            'id_pedido': 'nunique',
            'subtotal': 'sum'
        }).reset_index()
        analise.columns = ['id_cliente', 'nome', 'sexo', 'canal_venda', 'total_pedidos', 'valor_total']
        analise = analise.sort_values('valor_total', ascending=False)
        analise['valor_total'] = analise['valor_total'].apply(formatar_moeda)
        return analise
    
    def analise_tipo_mercadoria_por_cliente(self) -> pd.DataFrame:
        """Análise de preferência de categoria de produtos por cliente"""
        analise = self.df_completo.groupby(['id_cliente', 'nome', 'sexo', 'categoria']).agg({
            'quantidade': 'sum',
            'subtotal': 'sum'
        }).reset_index()
        analise.columns = ['id_cliente', 'nome', 'sexo', 'categoria', 'qtd_itens', 'valor_total']
        analise = analise.sort_values(['id_cliente', 'valor_total'], ascending=[True, False])
        analise['valor_total'] = analise['valor_total'].apply(formatar_moeda)
        return analise
    
    def analise_clientes_mais_valiosos(self, top_n: int = 20) -> pd.DataFrame:
        """Identifica os clientes mais valiosos (maior valor de compras)"""
        analise = self.df_completo.groupby(['id_cliente', 'nome', 'sexo', 'cidade']).agg({
            'id_pedido': 'nunique',
            'subtotal': 'sum',
            'quantidade': 'sum'
        }).reset_index()
        analise.columns = ['id_cliente', 'nome', 'sexo', 'cidade', 'total_pedidos', 'valor_total', 'itens_comprados']
        analise['ticket_medio'] = (analise['valor_total'] / analise['total_pedidos']).round(2)
        analise = analise.sort_values('valor_total', ascending=False).head(top_n)
        analise['valor_total'] = analise['valor_total'].apply(formatar_moeda)
        analise['ticket_medio'] = analise['ticket_medio'].apply(formatar_moeda)
        return analise
    
    # ==================== ANÁLISES DE PRODUTOS ====================
    
    def analise_top_produtos_mais_vendidos(self, top_n: int = 10) -> pd.DataFrame:
        """Top N produtos mais vendidos"""
        analise = self.df_completo.groupby(['id_produto', 'nome_produto', 'categoria']).agg({
            'quantidade': 'sum',
            'subtotal': 'sum'
        }).reset_index()
        analise.columns = ['id_produto', 'nome_produto', 'categoria', 'qtd_vendida', 'valor_total']
        analise = analise.sort_values('qtd_vendida', ascending=False).head(top_n)
        analise['percentual_vendas'] = (analise['qtd_vendida'] / analise['qtd_vendida'].sum() * 100).round(2)
        analise['valor_total'] = analise['valor_total'].apply(formatar_moeda)
        analise['percentual_vendas'] = analise['percentual_vendas'].apply(lambda x: f"{x:.2f}%")
        return analise
    
    def analise_vendas_por_segmento(self) -> pd.DataFrame:
        """Total de vendas por segmento/categoria"""
        analise = self.df_completo.groupby('categoria').agg({
            'quantidade': 'sum',
            'subtotal': 'sum',
            'id_produto': 'nunique',
            'id_pedido': 'nunique'
        }).reset_index()
        analise.columns = ['categoria', 'qtd_itens_vendidos', 'valor_total', 'produtos_diferentes', 'pedidos']
        analise = analise.sort_values('valor_total', ascending=False)
        analise['percentual_faturamento'] = (analise['valor_total'] / analise['valor_total'].sum() * 100).round(2)
        analise['ticket_medio'] = (analise['valor_total'] / analise['pedidos']).round(2)
        analise['valor_total'] = analise['valor_total'].apply(formatar_moeda)
        analise['percentual_faturamento'] = analise['percentual_faturamento'].apply(lambda x: f"{x:.2f}%")
        analise['ticket_medio'] = analise['ticket_medio'].apply(formatar_moeda)
        return analise
    
    def analise_cores_mais_vendidas(self) -> pd.DataFrame:
        """Análise das cores mais vendidas"""
        analise = self.df_completo.groupby('nome_cor').agg({
            'quantidade': 'sum',
            'subtotal': 'sum',
            'id_pedido': 'nunique'
        }).reset_index()
        analise.columns = ['cor', 'qtd_vendida', 'valor_total', 'pedidos']
        analise = analise.sort_values('qtd_vendida', ascending=False)
        analise['percentual'] = (analise['qtd_vendida'] / analise['qtd_vendida'].sum() * 100).round(2)
        analise['valor_total'] = analise['valor_total'].apply(formatar_moeda)
        analise['percentual'] = analise['percentual'].apply(lambda x: f"{x:.2f}%")
        return analise
    
    def analise_top_cosmeticos(self, top_n: int = 5) -> pd.DataFrame:
        """Top N produtos de cosméticos mais vendidos"""
        df_cosmeticos = self.df_completo[
            self.df_completo['categoria'].str.contains('Cosm|Colora|Cabelo|Beleza', case=False, na=False)
        ]
        
        analise = df_cosmeticos.groupby(['id_produto', 'nome_produto', 'categoria']).agg({
            'quantidade': 'sum',
            'subtotal': 'sum'
        }).reset_index()
        analise.columns = ['id_produto', 'nome_produto', 'categoria', 'qtd_vendida', 'valor_total']
        analise = analise.sort_values('valor_total', ascending=False).head(top_n)
        analise['valor_total'] = analise['valor_total'].apply(formatar_moeda)
        return analise
    
    def analise_top_cadeiras_lavatorios(self, top_n: int = 5) -> pd.DataFrame:
        """Top N produtos de cadeiras e lavatórios mais vendidos"""
        df_filtrado = self.df_completo[
            self.df_completo['categoria'].str.contains('Cadeira|Lavat|Mobili', case=False, na=False)
        ]
        
        analise = df_filtrado.groupby(['id_produto', 'nome_produto', 'categoria']).agg({
            'quantidade': 'sum',
            'subtotal': 'sum'
        }).reset_index()
        analise.columns = ['id_produto', 'nome_produto', 'categoria', 'qtd_vendida', 'valor_total']
        analise = analise.sort_values('valor_total', ascending=False).head(top_n)
        analise['valor_total'] = analise['valor_total'].apply(formatar_moeda)
        return analise
    
    def analise_rentabilidade_produtos(self) -> pd.DataFrame:
        """Análise de rentabilidade: produtos com maior valor de vendas"""
        analise = self.df_completo.groupby(['id_produto', 'nome_produto', 'categoria', 'valor_unitario']).agg({
            'quantidade': 'sum',
            'subtotal': 'sum'
        }).reset_index()
        analise.columns = ['id_produto', 'nome_produto', 'categoria', 'preco_unitario', 'qtd_vendida', 'faturamento']
        analise['percentual_faturamento'] = (analise['faturamento'] / analise['faturamento'].sum() * 100).round(2)
        analise = analise.sort_values('faturamento', ascending=False)
        analise['preco_unitario'] = analise['preco_unitario'].apply(formatar_moeda)
        analise['faturamento'] = analise['faturamento'].apply(formatar_moeda)
        analise['percentual_faturamento'] = analise['percentual_faturamento'].apply(lambda x: f"{x:.2f}%")
        return analise
    
    # ==================== ANÁLISES DE VENDAS ====================
    
    def analise_vendas_por_ano(self) -> pd.DataFrame:
        """Análise de vendas totais por ano"""
        analise = self.df_pedidos.groupby('ano').agg({
            'id_pedido': 'count',
            'valor_total': 'sum',
            'id_cliente': 'nunique'
        }).reset_index()
        analise.columns = ['ano', 'total_pedidos', 'valor_total', 'clientes_unicos']
        analise['ticket_medio'] = (analise['valor_total'] / analise['total_pedidos']).round(2)
        
        # Calcular crescimento ano a ano
        analise['crescimento_valor'] = analise['valor_total'].pct_change() * 100
        analise['crescimento_pedidos'] = analise['total_pedidos'].pct_change() * 100
        
        analise['valor_total'] = analise['valor_total'].apply(formatar_moeda)
        analise['ticket_medio'] = analise['ticket_medio'].apply(formatar_moeda)
        analise['crescimento_valor'] = analise['crescimento_valor'].apply(lambda x: f"{x:.2f}%" if pd.notna(x) else "-")
        analise['crescimento_pedidos'] = analise['crescimento_pedidos'].apply(lambda x: f"{x:.2f}%" if pd.notna(x) else "-")
        
        return analise
    
    def analise_vendas_mensal(self, ano: int = None) -> pd.DataFrame:
        """Análise de vendas por mês/ano (com filtro opcional por ano)"""
        df = self.df_pedidos.copy()
        
        # Filtrar por ano se fornecido
        if ano is not None:
            df = df[df['ano'] == ano]
        
        analise = df.groupby(['ano', 'mes', 'mes_nome']).agg({
            'id_pedido': 'count',
            'valor_total': 'sum',
            'id_cliente': 'nunique'
        }).reset_index()
        analise.columns = ['ano', 'mes', 'mes_nome', 'total_pedidos', 'valor_total', 'clientes_unicos']
        analise['ticket_medio'] = (analise['valor_total'] / analise['total_pedidos']).round(2)
        analise = analise.sort_values(['ano', 'mes'])
        analise['valor_total'] = analise['valor_total'].apply(formatar_moeda)
        analise['ticket_medio'] = analise['ticket_medio'].apply(formatar_moeda)
        return analise
    
    def comparar_meses_entre_anos(self, mes: int, ano1: int, ano2: int) -> Dict[str, Any]:
        """Compara vendas de um mês específico entre dois anos"""
        df_ano1 = self.df_pedidos[(self.df_pedidos['ano'] == ano1) & (self.df_pedidos['mes'] == mes)]
        df_ano2 = self.df_pedidos[(self.df_pedidos['ano'] == ano2) & (self.df_pedidos['mes'] == mes)]
        
        valor_total_ano1 = df_ano1['valor_total'].sum()
        valor_total_ano2 = df_ano2['valor_total'].sum()
        ticket_medio_ano1 = df_ano1['valor_total'].mean()
        ticket_medio_ano2 = df_ano2['valor_total'].mean()
        
        resultado = {
            f'{ano1}': {
                'total_pedidos': len(df_ano1),
                'valor_total': formatar_moeda(valor_total_ano1),
                'ticket_medio': formatar_moeda(ticket_medio_ano1),
                'clientes_unicos': df_ano1['id_cliente'].nunique()
            },
            f'{ano2}': {
                'total_pedidos': len(df_ano2),
                'valor_total': formatar_moeda(valor_total_ano2),
                'ticket_medio': formatar_moeda(ticket_medio_ano2),
                'clientes_unicos': df_ano2['id_cliente'].nunique()
            }
        }
        
        # Calcular variação
        resultado['variacao'] = {
            'pedidos_percentual': f"{((len(df_ano2) - len(df_ano1)) / len(df_ano1) * 100 if len(df_ano1) > 0 else 0):.2f}%",
            'valor_percentual': f"{((valor_total_ano2 - valor_total_ano1) / valor_total_ano1 * 100 if valor_total_ano1 > 0 else 0):.2f}%",
            'ticket_medio_percentual': f"{((ticket_medio_ano2 - ticket_medio_ano1) / ticket_medio_ano1 * 100 if ticket_medio_ano1 > 0 else 0):.2f}%"
        }
        
        return resultado
    
    def analise_vendas_por_canal(self) -> pd.DataFrame:
        """Análise de vendas por canal (Instagram vs Loja Física)"""
        analise = self.df_pedidos.groupby('canal_venda').agg({
            'id_pedido': 'count',
            'valor_total': 'sum',
            'id_cliente': 'nunique'
        }).reset_index()
        analise.columns = ['canal_venda', 'total_pedidos', 'valor_total', 'clientes_unicos']
        analise['ticket_medio'] = (analise['valor_total'] / analise['total_pedidos']).round(2)
        analise['percentual_pedidos'] = (analise['total_pedidos'] / analise['total_pedidos'].sum() * 100).round(2)
        analise['percentual_valor'] = (analise['valor_total'] / analise['valor_total'].sum() * 100).round(2)
        analise['valor_total'] = analise['valor_total'].apply(formatar_moeda)
        analise['ticket_medio'] = analise['ticket_medio'].apply(formatar_moeda)
        analise['percentual_pedidos'] = analise['percentual_pedidos'].apply(lambda x: f"{x:.2f}%")
        analise['percentual_valor'] = analise['percentual_valor'].apply(lambda x: f"{x:.2f}%")
        return analise
    
    def analise_vendas_canal_por_mes(self) -> pd.DataFrame:
        """Análise de vendas por canal e mês"""
        analise = self.df_pedidos.groupby(['ano', 'mes', 'mes_nome', 'canal_venda']).agg({
            'id_pedido': 'count',
            'valor_total': 'sum'
        }).reset_index()
        analise.columns = ['ano', 'mes', 'mes_nome', 'canal_venda', 'total_pedidos', 'valor_total']
        analise = analise.sort_values(['ano', 'mes'])
        analise['valor_total'] = analise['valor_total'].apply(formatar_moeda)
        return analise
    
    def analise_vendas_por_forma_pagamento(self) -> pd.DataFrame:
        """Análise de vendas por forma de pagamento"""
        analise = self.df_pedidos.groupby('forma_pagamento').agg({
            'id_pedido': 'count',
            'valor_total': 'sum',
            'id_cliente': 'nunique'
        }).reset_index()
        analise.columns = ['forma_pagamento', 'total_pedidos', 'valor_total', 'clientes_unicos']
        analise['ticket_medio'] = (analise['valor_total'] / analise['total_pedidos']).round(2)
        analise['percentual_pedidos'] = (analise['total_pedidos'] / analise['total_pedidos'].sum() * 100).round(2)
        analise['percentual_valor'] = (analise['valor_total'] / analise['valor_total'].sum() * 100).round(2)
        analise = analise.sort_values('valor_total', ascending=False)
        analise['valor_total'] = analise['valor_total'].apply(formatar_moeda)
        analise['ticket_medio'] = analise['ticket_medio'].apply(formatar_moeda)
        analise['percentual_pedidos'] = analise['percentual_pedidos'].apply(lambda x: f"{x:.2f}%")
        analise['percentual_valor'] = analise['percentual_valor'].apply(lambda x: f"{x:.2f}%")
        return analise
    
    def analise_vendas_por_representante(self) -> pd.DataFrame:
        """Análise de média de vendas por representante (baseado em clientes atendidos)"""
        # Identificar possíveis representantes nos dados de clientes ou pedidos
        # Como não temos coluna de representante explícita, vamos analisar por região/vendedor
        analise = self.df_completo.groupby(['id_cliente', 'nome']).agg({
            'id_pedido': 'nunique',
            'subtotal': 'sum',
            'quantidade': 'sum'
        }).reset_index()
        analise.columns = ['id_cliente', 'nome_cliente', 'total_pedidos', 'valor_total', 'itens_vendidos']
        analise['ticket_medio'] = (analise['valor_total'] / analise['total_pedidos']).round(2)
        
        # Estatísticas gerais
        media_valor = analise['valor_total'].mean()
        mediana_valor = analise['valor_total'].median()
        media_ticket = analise['ticket_medio'].mean()
        
        stats = {
            'media_valor_cliente': formatar_moeda(media_valor),
            'mediana_valor_cliente': formatar_moeda(mediana_valor),
            'media_pedidos_cliente': f"{analise['total_pedidos'].mean():.2f}",
            'media_ticket': formatar_moeda(media_ticket)
        }
        
        analise['valor_total'] = analise['valor_total'].apply(formatar_moeda)
        analise['ticket_medio'] = analise['ticket_medio'].apply(formatar_moeda)
        
        return analise, stats
    
    def analise_total_vendas_geral(self, ano: int = None, mes: int = None) -> Dict[str, Any]:
        """Análise consolidada de vendas (com filtro opcional por ano e mês)"""
        # Filtrar dados se ano/mês fornecidos
        df_pedidos = self.df_pedidos.copy()
        df_vendas = self.df_vendas.copy()
        
        if ano is not None:
            df_pedidos = df_pedidos[df_pedidos['ano'] == ano]
            # Filtrar vendas pelos pedidos do ano
            pedidos_ids = df_pedidos['id_pedido'].unique()
            df_vendas = df_vendas[df_vendas['id_pedido'].isin(pedidos_ids)]
        
        if mes is not None and ano is not None:
            df_pedidos = df_pedidos[df_pedidos['mes'] == mes]
            # Filtrar vendas pelos pedidos do mês
            pedidos_ids = df_pedidos['id_pedido'].unique()
            df_vendas = df_vendas[df_vendas['id_pedido'].isin(pedidos_ids)]
        
        # Calcular métricas
        total_vendas = df_pedidos['valor_total'].sum()
        total_pedidos = len(df_pedidos)
        total_itens = df_vendas['quantidade'].sum() if len(df_vendas) > 0 else 0
        ticket_medio = df_pedidos['valor_total'].mean() if total_pedidos > 0 else 0
        clientes_unicos = df_pedidos['id_cliente'].nunique()
        produtos_diferentes = df_vendas['id_produto'].nunique() if len(df_vendas) > 0 else 0
        media_itens = (total_itens / total_pedidos) if total_pedidos > 0 else 0
        
        return {
            'valor_total_vendas': formatar_moeda(total_vendas),
            'total_pedidos': total_pedidos,
            'total_itens_vendidos': int(total_itens),
            'ticket_medio': formatar_moeda(ticket_medio),
            'clientes_unicos': clientes_unicos,
            'produtos_diferentes_vendidos': produtos_diferentes,
            'media_itens_por_pedido': f"{media_itens:.2f}"
        }
    
    def analise_top3_por_segmento(self) -> pd.DataFrame:
        """Top 3 produtos de cada segmento com valor total de vendas"""
        # Agrupar por categoria e produto
        df_ranking = self.df_completo.groupby(['categoria', 'id_produto', 'nome_produto']).agg({
            'quantidade': 'sum',
            'subtotal': 'sum'
        }).reset_index()
        
        # Ordenar e pegar top 3 de cada categoria
        df_ranking['ranking'] = df_ranking.groupby('categoria')['subtotal'].rank(ascending=False, method='first')
        top3 = df_ranking[df_ranking['ranking'] <= 3].sort_values(['categoria', 'ranking'])
        
        top3.columns = ['categoria', 'id_produto', 'nome_produto', 'qtd_vendida', 'valor_total', 'ranking']
        
        # Total por segmento
        total_por_segmento = df_ranking.groupby('categoria')['subtotal'].sum().reset_index()
        total_por_segmento.columns = ['categoria', 'total_segmento']
        
        top3 = top3.merge(total_por_segmento, on='categoria')
        top3['percentual_do_segmento'] = (top3['valor_total'] / top3['total_segmento'] * 100).round(2)
        
        top3['valor_total'] = top3['valor_total'].apply(formatar_moeda)
        top3['total_segmento'] = top3['total_segmento'].apply(formatar_moeda)
        top3['percentual_do_segmento'] = top3['percentual_do_segmento'].apply(lambda x: f"{x:.2f}%")
        
        return top3
    
    def analise_sazonalidade(self) -> pd.DataFrame:
        """Análise de sazonalidade das vendas por mês e ano"""
        analise = self.df_pedidos.groupby(['ano', 'mes']).agg({
            'valor_total': ['sum', 'mean', 'count'],
            'id_cliente': 'nunique'
        }).reset_index()
        
        analise.columns = ['ano', 'mes', 'valor_total', 'ticket_medio', 'total_pedidos', 'clientes_unicos']
        
        # Adicionar nome do mês
        meses = {1: 'Janeiro', 2: 'Fevereiro', 3: 'Março', 4: 'Abril', 5: 'Maio', 6: 'Junho',
                 7: 'Julho', 8: 'Agosto', 9: 'Setembro', 10: 'Outubro', 11: 'Novembro', 12: 'Dezembro'}
        analise['mes_nome'] = analise['mes'].map(meses)
        
        # Calcular índice de sazonalidade por ano (média do mês / média geral do ano)
        analise['indice_sazonalidade'] = analise.groupby('ano')['valor_total'].transform(
            lambda x: (x / x.mean() * 100).round(2)
        )
        
        # Ordenar por ano e mês
        analise = analise.sort_values(['ano', 'mes'])
        
        analise['valor_total'] = analise['valor_total'].apply(formatar_moeda)
        analise['ticket_medio'] = analise['ticket_medio'].apply(formatar_moeda)
        analise['indice_sazonalidade'] = analise['indice_sazonalidade'].apply(lambda x: f"{x:.2f}")
        
        return analise
    
    def analise_mix_produtos_por_pedido(self) -> pd.DataFrame:
        """Análise do mix de produtos por pedido"""
        analise = self.df_vendas.groupby('id_pedido').agg({
            'id_produto': 'count',
            'quantidade': 'sum',
            'subtotal': 'sum'
        }).reset_index()
        analise.columns = ['id_pedido', 'produtos_diferentes', 'quantidade_total', 'valor_total']
        
        # Estatísticas do mix
        media_valor = analise['valor_total'].mean()
        
        stats = {
            'media_produtos_por_pedido': f"{analise['produtos_diferentes'].mean():.2f}",
            'mediana_produtos_por_pedido': f"{analise['produtos_diferentes'].median():.2f}",
            'media_quantidade_por_pedido': f"{analise['quantidade_total'].mean():.2f}",
            'media_valor_por_pedido': formatar_moeda(media_valor)
        }
        
        analise['valor_total'] = analise['valor_total'].apply(formatar_moeda)
        
        return analise, stats
    
    def fechar_conexao(self):
        """Fecha a conexão com o banco de dados"""
        self.transformacao.fechar_conexao()
    
    def executar_todas_analises(self):
        """Executa todas as análises e exibe os resultados"""
        print("=" * 80)
        print("ANÁLISES DE CLIENTES".center(80))
        print("=" * 80)
        
        print("\n1. Distribuição por Sexo:")
        print(self.analise_clientes_por_sexo())
        
        print("\n2. Distribuição por Região (Top 10):")
        print(self.analise_clientes_por_regiao().head(10))
        
        print("\n3. Compras por Canal:")
        print(self.analise_compras_por_canal_cliente().head(10))
        
        print("\n4. Top 20 Clientes Mais Valiosos:")
        print(self.analise_clientes_mais_valiosos(20))
        
        print("\n" + "=" * 80)
        print("ANÁLISES DE PRODUTOS".center(80))
        print("=" * 80)
        
        print("\n5. Top 10 Produtos Mais Vendidos:")
        print(self.analise_top_produtos_mais_vendidos(10))
        
        print("\n6. Vendas por Segmento:")
        print(self.analise_vendas_por_segmento())
        
        print("\n7. Cores Mais Vendidas:")
        print(self.analise_cores_mais_vendidas())
        
        print("\n8. Top 5 Cosméticos:")
        print(self.analise_top_cosmeticos(5))
        
        print("\n9. Top 5 Cadeiras e Lavatórios:")
        print(self.analise_top_cadeiras_lavatorios(5))
        
        print("\n" + "=" * 80)
        print("ANÁLISES DE VENDAS".center(80))
        print("=" * 80)
        
        print("\n10. Vendas por Ano:")
        print(self.analise_vendas_por_ano())
        
        print("\n11. Vendas por Canal:")
        print(self.analise_vendas_por_canal())
        
        print("\n12. Vendas por Forma de Pagamento:")
        print(self.analise_vendas_por_forma_pagamento())
        
        print("\n13. Totais Gerais:")
        totais = self.analise_total_vendas_geral()
        for key, value in totais.items():
            print(f"{key}: {value}")
        
        print("\n14. Top 3 por Segmento:")
        print(self.analise_top3_por_segmento())
        
        print("\n15. Sazonalidade por Ano e Mês:")
        df_sazonalidade = self.analise_sazonalidade()
        
        # Exibir de forma organizada por ano
        anos_disponiveis = df_sazonalidade['ano'].unique()
        for ano in sorted(anos_disponiveis):
            if pd.notna(ano):
                print(f"\n--- Ano {int(ano)} ---")
                df_ano = df_sazonalidade[df_sazonalidade['ano'] == ano]
                print(df_ano.to_string(index=False))
        
        print("\n" + "=" * 80)


# Exemplo de uso
if __name__ == "__main__":
    # Criar instância da análise
    analise = AnaliseDados()
    
    # Executar todas as análises
    analise.executar_todas_analises()
    
    # Ou executar análises específicas
    # print("\nComparação Abril 2023 vs 2024:")
    # print(analise.comparar_meses_entre_anos(4, 2023, 2024))
    
    # Fechar conexão
    analise.fechar_conexao()
    
    print("\nAnálises concluídas!")
