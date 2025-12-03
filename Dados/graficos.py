import plotly.graph_objects as go
import plotly.express as px
from plotly.subplots import make_subplots
import pandas as pd
import numpy as np
from .analises import AnaliseDados
from typing import Dict, List
import re


class GraficosVendas:
    """Classe para geração de gráficos interativos com Plotly"""
    
    def __init__(self):
        """Inicializa a classe e carrega as análises"""
        print("Carregando análises para geração de gráficos...")
        self.analise = AnaliseDados()
        self.cores_tema = {
            'primaria': '#4A90E2',
            'secundaria': '#F39C12',
            'sucesso': '#27AE60',
            'perigo': '#E74C3C',
            'aviso': '#ff9800',
            'info': '#17a2b8',
            'destaque': ['#4A90E2', '#F39C12', '#27AE60', '#E74C3C', '#9467bd', 
                        '#8c564b', '#e377c2', '#7f7f7f', '#bcbd22', '#17becf']
        }
        # Configurações de layout padrão para harmonizar com o tema escuro
        self.layout_padrao = {
            'paper_bgcolor': 'rgba(0,0,0,0)',
            'plot_bgcolor': 'rgba(0,0,0,0)',
            'font': {'color': '#FFFFFF', 'size': 12},
            'xaxis': {'gridcolor': 'rgba(255,255,255,0.1)', 'color': '#FFFFFF'},
            'yaxis': {'gridcolor': 'rgba(255,255,255,0.1)', 'color': '#FFFFFF'}
        }
        print("Análises carregadas com sucesso!\n")
    
    def _aplicar_layout_padrao(self, fig: go.Figure) -> go.Figure:
        """Aplica layout padrão para harmonizar com tema escuro"""
        fig.update_layout(
            paper_bgcolor='rgba(0,0,0,0)',
            plot_bgcolor='rgba(0,0,0,0)',
            font={'color': '#FFFFFF', 'size': 12}
        )
        fig.update_xaxes(gridcolor='rgba(255,255,255,0.1)', color='#FFFFFF')
        fig.update_yaxes(gridcolor='rgba(255,255,255,0.1)', color='#FFFFFF')
        return fig
    
    @staticmethod
    def _extrair_valor_monetario(valor_str: str) -> float:
        """Extrai valor numérico de string formatada como moeda"""
        if pd.isna(valor_str) or valor_str == "":
            return 0.0
        # Remove R$, espaços, pontos e substitui vírgula por ponto
        valor_limpo = str(valor_str).replace("R$", "").replace(" ", "").replace(".", "").replace(",", ".")
        try:
            return float(valor_limpo)
        except:
            return 0.0
    
    @staticmethod
    def _extrair_percentual(percentual_str: str) -> float:
        """Extrai valor numérico de string formatada como percentual"""
        if pd.isna(percentual_str) or percentual_str == "":
            return 0.0
        valor_limpo = str(percentual_str).replace("%", "").replace(",", ".")
        try:
            return float(valor_limpo)
        except:
            return 0.0
    
    # ==================== GRÁFICOS DE CLIENTES ====================
    
    def grafico_clientes_por_sexo(self) -> go.Figure:
        """1. Gráfico de Pizza - Distribuição de clientes por sexo"""
        df = self.analise.analise_clientes_por_sexo()
        
        # Extrair valores numéricos
        df['percentual_num'] = df['percentual'].apply(self._extrair_percentual)
        
        fig = go.Figure(data=[go.Pie(
            labels=df['sexo'],
            values=df['quantidade'],
            hole=0.4,
            marker=dict(colors=self.cores_tema['destaque']),
            textposition='auto',
            textinfo='label+percent',
            hovertemplate='<b>%{label}</b><br>' +
                         'Quantidade: %{value}<br>' +
                         'Percentual: %{percent}<br>' +
                         '<extra></extra>'
        )])
        
        fig.update_layout(
            title={
                'text': 'Distribuição de Clientes por Sexo',
                'x': 0.5,
                'xanchor': 'center',
                'font': {'size': 20, 'family': 'Arial Black', 'color': '#FFFFFF'}
            },
            showlegend=True,
            height=500
        )
        
        return self._aplicar_layout_padrao(fig)
    
    def grafico_clientes_por_regiao(self, top_n: int = 15) -> go.Figure:
        """2. Gráfico de Barras Horizontais - Clientes por região"""
        df = self.analise.analise_clientes_por_regiao().head(top_n)
        
        # Criar label combinado
        df['regiao_completa'] = df['cidade'] + ', ' + df['estado2']
        df = df.sort_values('quantidade', ascending=True)
        
        fig = go.Figure()
        
        fig.add_trace(go.Bar(
            y=df['regiao_completa'],
            x=df['quantidade'],
            orientation='h',
            marker=dict(
                color=df['quantidade'],
                colorscale='Blues',
                showscale=True,
                colorbar=dict(title="Qtd")
            ),
            text=df['quantidade'],
            textposition='outside',
            hovertemplate='<b>%{y}</b><br>' +
                         'Clientes: %{x}<br>' +
                         '<extra></extra>'
        ))
        
        fig.update_layout(
            title={
                'text': f'Top {top_n} Regiões com Mais Clientes',
                'x': 0.5,
                'xanchor': 'center',
                'font': {'size': 20, 'family': 'Arial Black', 'color': '#FFFFFF'}
            },
            xaxis_title='Quantidade de Clientes',
            yaxis_title='Cidade, Estado',
            height=600,
            showlegend=False,
            margin=dict(l=200)
        )
        
        return self._aplicar_layout_padrao(fig)
    
    def grafico_canal_venda_cliente(self, top_n: int = 15) -> go.Figure:
        """3. Gráfico Pareto - Canal de venda por cliente"""
        df = self.analise.analise_compras_por_canal_cliente().head(top_n)
        
        # Extrair valores monetários
        df['valor_num'] = df['valor_total'].apply(self._extrair_valor_monetario)
        df = df.sort_values('valor_num', ascending=False)
        
        # Calcular percentual acumulado
        df['percentual_acumulado'] = (df['valor_num'].cumsum() / df['valor_num'].sum() * 100)
        
        # Criar subplot com eixos secundários
        fig = make_subplots(specs=[[{"secondary_y": True}]])
        
        # Barras
        fig.add_trace(
            go.Bar(
                x=df['nome'],
                y=df['valor_num'],
                name='Valor Total',
                marker=dict(color=self.cores_tema['primaria']),
                hovertemplate='<b>%{x}</b><br>' +
                             'Valor: R$ %{y:,.2f}<br>' +
                             '<extra></extra>'
            ),
            secondary_y=False
        )
        
        # Linha de Pareto
        fig.add_trace(
            go.Scatter(
                x=df['nome'],
                y=df['percentual_acumulado'],
                name='% Acumulado',
                mode='lines+markers',
                marker=dict(color=self.cores_tema['perigo'], size=8),
                line=dict(width=3),
                hovertemplate='<b>%{x}</b><br>' +
                             '% Acumulado: %{y:.1f}%<br>' +
                             '<extra></extra>'
            ),
            secondary_y=True
        )
        
        # Adicionar linha de 80%
        fig.add_hline(
            y=80, 
            line_dash="dash", 
            line_color="red",
            annotation_text="80%",
            secondary_y=True
        )
        
        fig.update_layout(
            title={
                'text': f'Análise de Pareto - Top {top_n} Clientes por Canal',
                'x': 0.5,
                'xanchor': 'center',
                'font': {'size': 20, 'family': 'Arial Black', 'color': '#FFFFFF'}
            },
            xaxis_title='Cliente',
            height=600,
            hovermode='x unified',
            legend=dict(orientation="h", yanchor="bottom", y=1.02, xanchor="right", x=1)
        )
        
        fig.update_xaxes(tickangle=-45)
        fig.update_yaxes(title_text="Valor Total (R$)", secondary_y=False)
        fig.update_yaxes(title_text="Percentual Acumulado (%)", secondary_y=True, range=[0, 110])
        
        return self._aplicar_layout_padrao(fig)
    
    def grafico_clientes_valiosos(self, top_n: int = 20) -> go.Figure:
        """4. Cartão/KPI - Top clientes mais valiosos"""
        df = self.analise.analise_clientes_mais_valiosos(top_n)
        
        # Extrair valores
        df['valor_num'] = df['valor_total'].apply(self._extrair_valor_monetario)
        df['ticket_num'] = df['ticket_medio'].apply(self._extrair_valor_monetario)
        df = df.sort_values('valor_num', ascending=True)
        
        fig = go.Figure()
        
        fig.add_trace(go.Bar(
            y=df['nome'],
            x=df['valor_num'],
            orientation='h',
            marker=dict(
                color=df['valor_num'],
                colorscale='Greens',
                showscale=True,
                colorbar=dict(title="Valor (R$)")
            ),
            text=[f"R$ {v:,.0f}" for v in df['valor_num']],
            textposition='outside',
            hovertemplate='<b>%{y}</b><br>' +
                         'Valor Total: R$ %{x:,.2f}<br>' +
                         'Pedidos: %{customdata[0]}<br>' +
                         'Itens: %{customdata[1]}<br>' +
                         '<extra></extra>',
            customdata=df[['total_pedidos', 'itens_comprados']].values
        ))
        
        fig.update_layout(
            title={
                'text': f'Top {top_n} Clientes Mais Valiosos',
                'x': 0.5,
                'xanchor': 'center',
                'font': {'size': 20, 'family': 'Arial Black', 'color': '#FFFFFF'}
            },
            xaxis_title='Valor Total (R$)',
            yaxis_title='Cliente',
            height=700,
            showlegend=False,
            margin=dict(l=220)
        )
        
        return self._aplicar_layout_padrao(fig)
    
    # ==================== GRÁFICOS DE PRODUTOS ====================
    
    def grafico_top_produtos(self, top_n: int = 10) -> go.Figure:
        """5. Gráfico de Barras Horizontais - Top produtos mais vendidos"""
        df = self.analise.analise_top_produtos_mais_vendidos(top_n)
        
        # Extrair valores
        df['valor_num'] = df['valor_total'].apply(self._extrair_valor_monetario)
        df = df.sort_values('qtd_vendida', ascending=True)
        
        fig = go.Figure()
        
        fig.add_trace(go.Bar(
            y=df['nome_produto'],
            x=df['qtd_vendida'],
            orientation='h',
            marker=dict(
                color=df['qtd_vendida'],
                colorscale='Oranges',
                showscale=True,
                colorbar=dict(title="Qtd")
            ),
            text=df['qtd_vendida'],
            textposition='outside',
            hovertemplate='<b>%{y}</b><br>' +
                         'Quantidade: %{x}<br>' +
                         'Categoria: %{customdata[0]}<br>' +
                         'Valor Total: %{customdata[1]}<br>' +
                         '<extra></extra>',
            customdata=df[['categoria', 'valor_total']].values
        ))
        
        fig.update_layout(
            title={
                'text': f'Top {top_n} Produtos Mais Vendidos',
                'x': 0.5,
                'xanchor': 'center',
                'font': {'size': 20, 'family': 'Arial Black', 'color': '#FFFFFF'}
            },
            xaxis_title='Quantidade Vendida',
            yaxis_title='Produto',
            height=600,
            showlegend=False,
            margin=dict(l=250)
        )
        
        return self._aplicar_layout_padrao(fig)
    
    def grafico_vendas_por_segmento(self) -> go.Figure:
        """6. Gráfico de Barras Horizontais - Vendas por segmento"""
        df = self.analise.analise_vendas_por_segmento()
        
        # Extrair valores
        df['valor_num'] = df['valor_total'].apply(self._extrair_valor_monetario)
        df = df.sort_values('valor_num', ascending=True)
        
        fig = go.Figure()
        
        fig.add_trace(go.Bar(
            y=df['categoria'],
            x=df['valor_num'],
            orientation='h',
            marker=dict(
                color=df['valor_num'],
                colorscale='Viridis',
                showscale=True,
                colorbar=dict(title="Valor (R$)")
            ),
            text=[f"R$ {v:,.0f}" for v in df['valor_num']],
            textposition='outside',
            hovertemplate='<b>%{y}</b><br>' +
                         'Valor Total: R$ %{x:,.2f}<br>' +
                         'Itens Vendidos: %{customdata[0]}<br>' +
                         'Produtos Diferentes: %{customdata[1]}<br>' +
                         'Pedidos: %{customdata[2]}<br>' +
                         '<extra></extra>',
            customdata=df[['qtd_itens_vendidos', 'produtos_diferentes', 'pedidos']].values
        ))
        
        fig.update_layout(
            title={
                'text': 'Vendas por Segmento/Categoria',
                'x': 0.5,
                'xanchor': 'center',
                'font': {'size': 20, 'family': 'Arial Black', 'color': '#FFFFFF'}
            },
            xaxis_title='Valor Total (R$)',
            yaxis_title='Categoria',
            height=600,
            showlegend=False,
            margin=dict(l=180)
        )
        
        return self._aplicar_layout_padrao(fig)
    
    def grafico_cores_vendidas(self, top_n: int = 10) -> go.Figure:
        """7. Gráfico de Barras Horizontais - Cores mais vendidas"""
        df = self.analise.analise_cores_mais_vendidas().head(top_n)
        
        # Extrair valores
        df['valor_num'] = df['valor_total'].apply(self._extrair_valor_monetario)
        df = df.sort_values('qtd_vendida', ascending=True)
        
        fig = go.Figure()
        
        fig.add_trace(go.Bar(
            y=df['cor'],
            x=df['qtd_vendida'],
            orientation='h',
            marker=dict(
                color=df['qtd_vendida'],
                colorscale='Rainbow',
                showscale=True,
                colorbar=dict(title="Qtd")
            ),
            text=df['qtd_vendida'],
            textposition='outside',
            textfont=dict(color='white'),
            hovertemplate='<b>%{y}</b><br>' +
                         'Quantidade: %{x}<br>' +
                         'Valor: %{customdata[0]}<br>' +
                         '<extra></extra>',
            customdata=df[['valor_total']].values
        ))
        
        fig.update_layout(
            title={
                'text': f'Top {top_n} Cores Mais Vendidas',
                'x': 0.5,
                'xanchor': 'center',
                'font': {'size': 20, 'family': 'Arial Black', 'color': '#FFFFFF'}
            },
            xaxis_title='Quantidade Vendida',
            yaxis_title='Cor',
            height=600,
            showlegend=False,
            margin=dict(l=150)
        )
        
        return self._aplicar_layout_padrao(fig)
    
    def grafico_top_cosmeticos(self, top_n: int = 5) -> go.Figure:
        """8. Gráfico de Barras Horizontais - Top cosméticos"""
        df = self.analise.analise_top_cosmeticos(top_n)
        
        # Extrair valores
        df['valor_num'] = df['valor_total'].apply(self._extrair_valor_monetario)
        df = df.sort_values('valor_num', ascending=True)
        
        fig = go.Figure()
        
        fig.add_trace(go.Bar(
            y=df['nome_produto'],
            x=df['valor_num'],
            orientation='h',
            marker=dict(
                color=self.cores_tema['destaque'][:len(df)],
                line=dict(width=2, color='white')
            ),
            text=[f"R$ {v:,.0f}" for v in df['valor_num']],
            textposition='outside',
            hovertemplate='<b>%{y}</b><br>' +
                         'Valor Total: R$ %{x:,.2f}<br>' +
                         'Quantidade: %{customdata[0]}<br>' +
                         '<extra></extra>',
            customdata=df[['qtd_vendida']].values
        ))
        
        fig.update_layout(
            title={
                'text': f'Top {top_n} Produtos de Cosméticos',
                'x': 0.5,
                'xanchor': 'center',
                'font': {'size': 20, 'family': 'Arial Black'}
            },
            xaxis_title='Valor Total (R$)',
            yaxis_title='Produto',
            height=500,
            showlegend=False,
            paper_bgcolor='rgba(0,0,0,0)',
            plot_bgcolor='rgba(0,0,0,0)',
            font=dict(size=12),
            margin=dict(l=200)
        )
        
        return self._aplicar_layout_padrao(fig)
    
    def grafico_top_cadeiras_lavatorios(self, top_n: int = 5) -> go.Figure:
        """9. Gráfico de Colunas - Top cadeiras e lavatórios"""
        df = self.analise.analise_top_cadeiras_lavatorios(top_n)
        
        # Extrair valores
        df['valor_num'] = df['valor_total'].apply(self._extrair_valor_monetario)
        df = df.sort_values('valor_num', ascending=False)
        
        fig = go.Figure()
        
        fig.add_trace(go.Bar(
            x=df['nome_produto'],
            y=df['valor_num'],
            marker=dict(
                color=self.cores_tema['destaque'][:len(df)],
                line=dict(width=2, color='white')
            ),
            text=[f"R$ {v:,.0f}" for v in df['valor_num']],
            textposition='outside',
            hovertemplate='<b>%{x}</b><br>' +
                         'Valor Total: R$ %{y:,.2f}<br>' +
                         'Quantidade: %{customdata[0]}<br>' +
                         'Categoria: %{customdata[1]}<br>' +
                         '<extra></extra>',
            customdata=df[['qtd_vendida', 'categoria']].values
        ))
        
        fig.update_layout(
            title={
                'text': f'Top {top_n} Cadeiras e Lavatórios',
                'x': 0.5,
                'xanchor': 'center',
                'font': {'size': 20, 'family': 'Arial Black'}
            },
            xaxis_title='Produto',
            yaxis_title='Valor Total (R$)',
            height=600,
            showlegend=False,
            paper_bgcolor='rgba(0,0,0,0)',
            plot_bgcolor='rgba(0,0,0,0)',
            font=dict(size=11)
        )
        
        fig.update_xaxes(tickangle=-45)
        
        return self._aplicar_layout_padrao(fig)
    
    # ==================== GRÁFICOS DE VENDAS ====================
    
    def grafico_vendas_por_ano(self) -> go.Figure:
        """10. Gráfico de Linha - Vendas por ano"""
        df = self.analise.analise_vendas_por_ano()
        
        # Extrair valores
        df['valor_num'] = df['valor_total'].apply(self._extrair_valor_monetario)
        df['ticket_num'] = df['ticket_medio'].apply(self._extrair_valor_monetario)
        
        # Criar subplot com eixo secundário
        fig = make_subplots(specs=[[{"secondary_y": True}]])
        
        # Linha de valor total
        fig.add_trace(
            go.Scatter(
                x=df['ano'],
                y=df['valor_num'],
                name='Valor Total',
                mode='lines+markers',
                marker=dict(size=12, color=self.cores_tema['primaria']),
                line=dict(width=3),
                hovertemplate='<b>Ano %{x:.0f}</b><br>' +
                             'Valor Total: R$ %{y:,.2f}<br>' +
                             '<extra></extra>'
            ),
            secondary_y=False
        )
        
        # Linha de quantidade de pedidos
        fig.add_trace(
            go.Scatter(
                x=df['ano'],
                y=df['total_pedidos'],
                name='Total de Pedidos',
                mode='lines+markers',
                marker=dict(size=10, color=self.cores_tema['secundaria']),
                line=dict(width=2, dash='dash'),
                hovertemplate='<b>Ano %{x:.0f}</b><br>' +
                             'Pedidos: %{y}<br>' +
                             '<extra></extra>'
            ),
            secondary_y=True
        )
        
        fig.update_layout(
            title={
                'text': 'Evolução de Vendas por Ano',
                'x': 0.5,
                'xanchor': 'center',
                'font': {'size': 20, 'family': 'Arial Black'}
            },
            xaxis_title='Ano',
            height=600,
            hovermode='x unified',
            paper_bgcolor='rgba(0,0,0,0)',
            plot_bgcolor='rgba(0,0,0,0)',
            font=dict(size=12),
            legend=dict(orientation="h", yanchor="bottom", y=1.02, xanchor="right", x=1)
        )
        
        fig.update_yaxes(title_text="Valor Total (R$)", secondary_y=False)
        fig.update_yaxes(title_text="Quantidade de Pedidos", secondary_y=True)
        
        return self._aplicar_layout_padrao(fig)
    
    def grafico_vendas_por_canal(self) -> go.Figure:
        """11. Gráfico de Barras Horizontais - Vendas por canal"""
        df = self.analise.analise_vendas_por_canal()
        
        # Extrair valores
        df['valor_num'] = df['valor_total'].apply(self._extrair_valor_monetario)
        df['ticket_num'] = df['ticket_medio'].apply(self._extrair_valor_monetario)
        df = df.sort_values('valor_num', ascending=True)
        
        fig = go.Figure()
        
        fig.add_trace(go.Bar(
            y=df['canal_venda'],
            x=df['valor_num'],
            orientation='h',
            marker=dict(
                color=df['valor_num'],
                colorscale='Teal',
                showscale=True,
                colorbar=dict(title="Valor (R$)")
            ),
            text=[f"R$ {v:,.0f}" for v in df['valor_num']],
            textposition='outside',
            hovertemplate='<b>%{y}</b><br>' +
                         'Valor Total: R$ %{x:,.2f}<br>' +
                         'Pedidos: %{customdata[0]}<br>' +
                         'Ticket Médio: %{customdata[1]}<br>' +
                         '<extra></extra>',
            customdata=df[['total_pedidos', 'ticket_medio']].values
        ))
        
        fig.update_layout(
            title={
                'text': 'Vendas por Canal de Venda',
                'x': 0.5,
                'xanchor': 'center',
                'font': {'size': 20, 'family': 'Arial Black'}
            },
            xaxis_title='Valor Total (R$)',
            yaxis_title='Canal de Venda',
            height=500,
            showlegend=False,
            paper_bgcolor='rgba(0,0,0,0)',
            plot_bgcolor='rgba(0,0,0,0)',
            font=dict(size=12),
            margin=dict(l=150)
        )
        
        return self._aplicar_layout_padrao(fig)
    
    def grafico_vendas_por_forma_pagamento(self) -> go.Figure:
        """12. Gráfico de Barras Verticais - Vendas por forma de pagamento"""
        df = self.analise.analise_vendas_por_forma_pagamento().head(10)
        
        # Extrair valores
        df['valor_num'] = df['valor_total'].apply(self._extrair_valor_monetario)
        df = df.sort_values('valor_num', ascending=False)
        
        fig = go.Figure()
        
        fig.add_trace(go.Bar(
            x=df['forma_pagamento'],
            y=df['valor_num'],
            marker=dict(
                color=df['valor_num'],
                colorscale='Reds',
                showscale=True,
                colorbar=dict(title="Valor (R$)")
            ),
            text=[f"R$ {v:,.0f}" for v in df['valor_num']],
            textposition='outside',
            hovertemplate='<b>%{x}</b><br>' +
                         'Valor Total: R$ %{y:,.2f}<br>' +
                         'Pedidos: %{customdata[0]}<br>' +
                         '<extra></extra>',
            customdata=df[['total_pedidos']].values
        ))
        
        fig.update_layout(
            title={
                'text': 'Vendas por Forma de Pagamento',
                'x': 0.5,
                'xanchor': 'center',
                'font': {'size': 20, 'family': 'Arial Black'}
            },
            xaxis_title='Forma de Pagamento',
            yaxis_title='Valor Total (R$)',
            height=600,
            showlegend=False,
            paper_bgcolor='rgba(0,0,0,0)',
            plot_bgcolor='rgba(0,0,0,0)',
            font=dict(size=11)
        )
        
        fig.update_xaxes(tickangle=-45)
        
        return self._aplicar_layout_padrao(fig)
    
    def grafico_kpi_totais(self) -> go.Figure:
        """13. Cartões de KPI - Totais gerais"""
        dados = self.analise.analise_total_vendas_geral()
        
        # Extrair valor total
        valor_total_num = self._extrair_valor_monetario(dados['valor_total_vendas'])
        ticket_medio_num = self._extrair_valor_monetario(dados['ticket_medio'])
        
        # Criar KPIs
        fig = make_subplots(
            rows=2, cols=3,
            subplot_titles=(
                'Valor Total', 'Total de Pedidos', 'Itens Vendidos',
                'Ticket Médio', 'Clientes Únicos', 'Produtos Diferentes'
            ),
            specs=[[{'type': 'indicator'}, {'type': 'indicator'}, {'type': 'indicator'}],
                   [{'type': 'indicator'}, {'type': 'indicator'}, {'type': 'indicator'}]]
        )
        
        # KPI 1: Valor Total
        fig.add_trace(go.Indicator(
            mode="number",
            value=valor_total_num,
            number={'prefix': "R$ ", 'valueformat': ",.0f"},
            domain={'x': [0, 1], 'y': [0, 1]}
        ), row=1, col=1)
        
        # KPI 2: Total de Pedidos
        fig.add_trace(go.Indicator(
            mode="number",
            value=dados['total_pedidos'],
            number={'valueformat': ","},
            domain={'x': [0, 1], 'y': [0, 1]}
        ), row=1, col=2)
        
        # KPI 3: Itens Vendidos
        fig.add_trace(go.Indicator(
            mode="number",
            value=dados['total_itens_vendidos'],
            number={'valueformat': ","},
            domain={'x': [0, 1], 'y': [0, 1]}
        ), row=1, col=3)
        
        # KPI 4: Ticket Médio
        fig.add_trace(go.Indicator(
            mode="number",
            value=ticket_medio_num,
            number={'prefix': "R$ ", 'valueformat': ",.2f"},
            domain={'x': [0, 1], 'y': [0, 1]}
        ), row=2, col=1)
        
        # KPI 5: Clientes Únicos
        fig.add_trace(go.Indicator(
            mode="number",
            value=dados['clientes_unicos'],
            number={'valueformat': ","},
            domain={'x': [0, 1], 'y': [0, 1]}
        ), row=2, col=2)
        
        # KPI 6: Produtos Diferentes
        fig.add_trace(go.Indicator(
            mode="number",
            value=dados['produtos_diferentes_vendidos'],
            number={'valueformat': ","},
            domain={'x': [0, 1], 'y': [0, 1]}
        ), row=2, col=3)
        
        fig.update_layout(
            title={
                'text': 'Indicadores Gerais de Vendas',
                'x': 0.5,
                'xanchor': 'center',
                'font': {'size': 22, 'family': 'Arial Black'}
            },
            height=600,
            paper_bgcolor='rgba(0,0,0,0)',
            font=dict(size=14)
        )
        
        return self._aplicar_layout_padrao(fig)
    
    def grafico_top3_segmento(self) -> go.Figure:
        """14. Gráfico de Barras Ordenadas - Top 3 por segmento"""
        df = self.analise.analise_top3_por_segmento()
        
        # Extrair valores
        df['valor_num'] = df['valor_total'].apply(self._extrair_valor_monetario)
        
        # Criar label com categoria e produto
        df['produto_completo'] = df['categoria'] + ' - ' + df['nome_produto'].str[:30]
        df = df.sort_values(['categoria', 'valor_num'], ascending=[True, False])
        
        # Criar cores por categoria
        categorias_unicas = df['categoria'].unique()
        cores_categorias = {cat: self.cores_tema['destaque'][i % len(self.cores_tema['destaque'])] 
                           for i, cat in enumerate(categorias_unicas)}
        df['cor'] = df['categoria'].map(cores_categorias)
        
        fig = go.Figure()
        
        for categoria in categorias_unicas:
            df_cat = df[df['categoria'] == categoria]
            
            fig.add_trace(go.Bar(
                y=df_cat['produto_completo'],
                x=df_cat['valor_num'],
                name=categoria,
                orientation='h',
                marker=dict(color=cores_categorias[categoria]),
                text=[f"R$ {v:,.0f}" for v in df_cat['valor_num']],
                textposition='outside',
                hovertemplate='<b>%{y}</b><br>' +
                             'Valor: R$ %{x:,.2f}<br>' +
                             'Ranking: %{customdata[0]}<br>' +
                             '<extra></extra>',
                customdata=df_cat[['ranking']].values
            ))
        
        fig.update_layout(
            title={
                'text': 'Top 3 Produtos por Segmento',
                'x': 0.5,
                'xanchor': 'center',
                'font': {'size': 20, 'family': 'Arial Black'}
            },
            xaxis_title='Valor Total (R$)',
            yaxis_title='Produto',
            height=900,
            paper_bgcolor='rgba(0,0,0,0)',
            plot_bgcolor='rgba(0,0,0,0)',
            font=dict(size=10),
            margin=dict(l=300),
            legend=dict(orientation="v", yanchor="top", y=1, xanchor="left", x=1.02)
        )
        
        return self._aplicar_layout_padrao(fig)
    
    def grafico_sazonalidade_heatmap(self) -> go.Figure:
        """15. Heatmap - Sazonalidade por ano e mês"""
        df = self.analise.analise_sazonalidade()
        
        # Extrair valores
        df['valor_num'] = df['valor_total'].apply(self._extrair_valor_monetario)
        df['indice_num'] = df['indice_sazonalidade'].apply(lambda x: float(str(x).replace(',', '.')))
        
        # Criar pivot table para o heatmap
        pivot_valor = df.pivot_table(
            values='valor_num',
            index='mes_nome',
            columns='ano',
            aggfunc='sum',
            fill_value=0
        )
        
        # Ordenar meses corretamente
        ordem_meses = ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
                      'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro']
        pivot_valor = pivot_valor.reindex([m for m in ordem_meses if m in pivot_valor.index])
        
        fig = go.Figure(data=go.Heatmap(
            z=pivot_valor.values,
            x=[f"{int(ano)}" if pd.notna(ano) else "" for ano in pivot_valor.columns],
            y=pivot_valor.index,
            colorscale='RdYlGn',
            text=[[f"R$ {val:,.0f}" if val > 0 else "" for val in row] for row in pivot_valor.values],
            texttemplate='%{text}',
            textfont={"size": 10},
            colorbar=dict(title="Valor (R$)"),
            hovertemplate='<b>%{y} - %{x}</b><br>' +
                         'Valor: R$ %{z:,.2f}<br>' +
                         '<extra></extra>'
        ))
        
        fig.update_layout(
            title={
                'text': 'Sazonalidade de Vendas por Ano e Mês',
                'x': 0.5,
                'xanchor': 'center',
                'font': {'size': 20, 'family': 'Arial Black'}
            },
            xaxis_title='Ano',
            yaxis_title='Mês',
            height=700,
            paper_bgcolor='rgba(0,0,0,0)',
            plot_bgcolor='rgba(0,0,0,0)',
            font=dict(size=12)
        )
        
        return self._aplicar_layout_padrao(fig)
    
    # ==================== MÉTODOS AUXILIARES ====================
    
    def gerar_todos_graficos(self) -> Dict[str, go.Figure]:
        """Gera todos os gráficos e retorna em um dicionário"""
        print("Gerando todos os gráficos...\n")
        
        graficos = {
            # Clientes
            'clientes_sexo': self.grafico_clientes_por_sexo(),
            'clientes_regiao': self.grafico_clientes_por_regiao(),
            'canal_venda_pareto': self.grafico_canal_venda_cliente(),
            'clientes_valiosos': self.grafico_clientes_valiosos(),
            
            # Produtos
            'top_produtos': self.grafico_top_produtos(),
            'vendas_segmento': self.grafico_vendas_por_segmento(),
            'cores_vendidas': self.grafico_cores_vendidas(),
            'top_cosmeticos': self.grafico_top_cosmeticos(),
            'top_cadeiras_lavatorios': self.grafico_top_cadeiras_lavatorios(),
            
            # Vendas
            'vendas_ano': self.grafico_vendas_por_ano(),
            'vendas_canal': self.grafico_vendas_por_canal(),
            'vendas_forma_pagamento': self.grafico_vendas_por_forma_pagamento(),
            'kpi_totais': self.grafico_kpi_totais(),
            'top3_segmento': self.grafico_top3_segmento(),
            'sazonalidade_heatmap': self.grafico_sazonalidade_heatmap()
        }
        
        print("✅ Todos os gráficos foram gerados com sucesso!")
        return graficos
    
    def salvar_graficos_html(self, pasta_destino: str = "graficos_html"):
        """Salva todos os gráficos como arquivos HTML"""
        import os
        
        if not os.path.exists(pasta_destino):
            os.makedirs(pasta_destino)
        
        graficos = self.gerar_todos_graficos()
        
        for nome, fig in graficos.items():
            caminho = os.path.join(pasta_destino, f"{nome}.html")
            fig.write_html(caminho)
            print(f"💾 Salvo: {caminho}")
        
        print(f"\n✅ Todos os gráficos foram salvos em '{pasta_destino}/'")
    
    def exibir_grafico(self, nome_grafico: str):
        """Exibe um gráfico específico"""
        graficos_disponiveis = {
            'clientes_sexo': self.grafico_clientes_por_sexo,
            'clientes_regiao': self.grafico_clientes_por_regiao,
            'canal_venda_pareto': self.grafico_canal_venda_cliente,
            'clientes_valiosos': self.grafico_clientes_valiosos,
            'top_produtos': self.grafico_top_produtos,
            'vendas_segmento': self.grafico_vendas_por_segmento,
            'cores_vendidas': self.grafico_cores_vendidas,
            'top_cosmeticos': self.grafico_top_cosmeticos,
            'top_cadeiras_lavatorios': self.grafico_top_cadeiras_lavatorios,
            'vendas_ano': self.grafico_vendas_por_ano,
            'vendas_canal': self.grafico_vendas_por_canal,
            'vendas_forma_pagamento': self.grafico_vendas_por_forma_pagamento,
            'kpi_totais': self.grafico_kpi_totais,
            'top3_segmento': self.grafico_top3_segmento,
            'sazonalidade_heatmap': self.grafico_sazonalidade_heatmap
        }
        
        if nome_grafico in graficos_disponiveis:
            fig = graficos_disponiveis[nome_grafico]()
            fig.show()
        else:
            print(f"Gráfico '{nome_grafico}' não encontrado!")
            print(f"Gráficos disponíveis: {list(graficos_disponiveis.keys())}")
    
    def fechar_conexao(self):
        """Fecha a conexão com o banco de dados"""
        self.analise.fechar_conexao()


# Exemplo de uso
if __name__ == "__main__":
    # Criar instância
    graficos = GraficosVendas()
    
    # Opção 1: Gerar e exibir todos os gráficos
    todos_graficos = graficos.gerar_todos_graficos()
    
    # Opção 2: Salvar todos os gráficos como HTML
    # graficos.salvar_graficos_html()
    
    # Opção 3: Exibir um gráfico específico
    # graficos.exibir_grafico('clientes_sexo')
    # graficos.exibir_grafico('vendas_ano')
    # graficos.exibir_grafico('sazonalidade_heatmap')
    
    # Salvar gráficos como HTML ao invés de exibir diretamente
    print("\nSalvando gráficos...")
    graficos.salvar_graficos_html()
    
    # Fechar conexão
    graficos.fechar_conexao()
    
    print("\n✅ Processo concluído!")
    print("📁 Acesse a pasta 'graficos_html' para visualizar os gráficos gerados.")

