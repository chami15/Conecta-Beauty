"""
Charts - Funções de gráficos otimizadas para Streamlit
Retorna objetos plotly.graph_objects.Figure diretamente
"""
import plotly.graph_objects as go
import plotly.express as px
from plotly.subplots import make_subplots
import pandas as pd
import streamlit as st
from .analises import AnaliseDados


# Paleta de cores harmônica (azul escuro, azul claro, laranja)
CORES = {
    'primaria': '#1E3A5F',      # Azul escuro
    'secundaria': '#4A90E2',    # Azul claro
    'accent': '#F39C12',        # Laranja
    'destaque': ['#4A90E2', '#F39C12', '#2ECC71', '#E74C3C', '#9B59B6', 
                 '#1ABC9C', '#F1C40F', '#E67E22', '#95A5A6', '#34495E']
}

# Configuração padrão dos gráficos
LAYOUT_CONFIG = {
    'paper_bgcolor': 'rgba(26, 61, 92, 0.3)',  # Fundo azul escuro semi-transparente
    'plot_bgcolor': 'rgba(36, 77, 111, 0.2)',  # Fundo do gráfico azul mais claro
    'font': {'color': '#FFFFFF', 'size': 12, 'family': 'Inter, sans-serif'},
    'title': {'x': 0.5, 'xanchor': 'center', 'font': {'size': 18, 'color': '#FFFFFF'}},
    'showlegend': True,
    'legend': {'font': {'color': '#FFFFFF'}},
    'xaxis': {'gridcolor': 'rgba(74, 144, 226, 0.2)', 'color': '#FFFFFF'},
    'yaxis': {'gridcolor': 'rgba(74, 144, 226, 0.2)', 'color': '#FFFFFF'}
}


@st.cache_data
def _extrair_valor_monetario(valor_str: str) -> float:
    """Extrai valor numérico de string formatada como moeda"""
    if pd.isna(valor_str) or valor_str == "":
        return 0.0
    valor_limpo = str(valor_str).replace("R$", "").replace(" ", "").replace(".", "").replace(",", ".")
    try:
        return float(valor_limpo)
    except:
        return 0.0


@st.cache_data
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

@st.cache_data
def grafico_clientes_sexo():
    """Gráfico de Pizza - Distribuição de clientes por sexo"""
    analise = AnaliseDados()
    df = analise.analise_clientes_por_sexo()
    
    fig = go.Figure(data=[go.Pie(
        labels=df['sexo'],
        values=df['quantidade'],
        hole=0.4,
        marker=dict(colors=[CORES['secundaria'], CORES['accent']]),
        textposition='auto',
        textinfo='label+percent',
        textfont=dict(size=14, color='white'),
        hovertemplate='<b>%{label}</b><br>Quantidade: %{value}<br>Percentual: %{percent}<extra></extra>'
    )])
    
    fig.update_layout(**LAYOUT_CONFIG, height=400, title_text='Distribuição por Sexo')
    return fig


@st.cache_data
def grafico_clientes_regiao(top_n=15):
    """Gráfico de Barras Horizontais - Clientes por região"""
    analise = AnaliseDados()
    df = analise.analise_clientes_por_regiao().head(top_n)
    df['regiao'] = df['cidade'] + ', ' + df['estado2']
    df = df.sort_values('quantidade', ascending=True)
    
    fig = go.Figure()
    fig.add_trace(go.Bar(
        y=df['regiao'],
        x=df['quantidade'],
        orientation='h',
        marker=dict(color=CORES['secundaria'], line=dict(width=1, color=CORES['primaria'])),
        text=df['quantidade'],
        textposition='outside',
        textfont=dict(color='white'),
        hovertemplate='<b>%{y}</b><br>Clientes: %{x}<extra></extra>'
    ))
    
    fig.update_layout(**LAYOUT_CONFIG, height=500, title_text=f'Top {top_n} Regiões',
                      xaxis_title='Quantidade', margin=dict(l=200))
    return fig


@st.cache_data
def grafico_clientes_valiosos(top_n=20):
    """Gráfico de Barras - Top clientes mais valiosos"""
    analise = AnaliseDados()
    df = analise.analise_clientes_mais_valiosos(top_n)
    df['valor_num'] = df['valor_total'].apply(_extrair_valor_monetario)
    df = df.sort_values('valor_num', ascending=True)
    
    fig = go.Figure()
    fig.add_trace(go.Bar(
        y=df['nome'],
        x=df['valor_num'],
        orientation='h',
        marker=dict(color=CORES['accent'], line=dict(width=1, color=CORES['primaria'])),
        text=[f"R$ {v:,.0f}" for v in df['valor_num']],
        textposition='outside',
        textfont=dict(color='white'),
        hovertemplate='<b>%{y}</b><br>Valor: R$ %{x:,.2f}<br>Pedidos: %{customdata[0]}<extra></extra>',
        customdata=df[['total_pedidos']].values
    ))
    
    fig.update_layout(**LAYOUT_CONFIG, height=600, title_text=f'Top {top_n} Clientes Valiosos',
                      xaxis_title='Valor Total (R$)', margin=dict(l=220))
    return fig


# ==================== GRÁFICOS DE PRODUTOS ====================

@st.cache_data
def grafico_top_produtos(top_n=10):
    """Gráfico de Barras - Top produtos mais vendidos"""
    analise = AnaliseDados()
    df = analise.analise_top_produtos_mais_vendidos(top_n)
    df = df.sort_values('qtd_vendida', ascending=True)
    
    fig = go.Figure()
    fig.add_trace(go.Bar(
        y=df['nome_produto'],
        x=df['qtd_vendida'],
        orientation='h',
        marker=dict(color=CORES['secundaria'], line=dict(width=1, color=CORES['primaria'])),
        text=df['qtd_vendida'],
        textposition='outside',
        textfont=dict(color='white'),
        hovertemplate='<b>%{y}</b><br>Quantidade: %{x}<br>Categoria: %{customdata[0]}<extra></extra>',
        customdata=df[['categoria']].values
    ))
    
    fig.update_layout(**LAYOUT_CONFIG, height=500, title_text=f'Top {top_n} Produtos',
                      xaxis_title='Quantidade Vendida', margin=dict(l=250))
    return fig


@st.cache_data
def grafico_vendas_segmento():
    """Gráfico de Barras - Vendas por segmento"""
    analise = AnaliseDados()
    df = analise.analise_vendas_por_segmento()
    df['valor_num'] = df['valor_total'].apply(_extrair_valor_monetario)
    df = df.sort_values('valor_num', ascending=True)
    
    fig = go.Figure()
    fig.add_trace(go.Bar(
        y=df['categoria'],
        x=df['valor_num'],
        orientation='h',
        marker=dict(color=CORES['accent'], line=dict(width=1, color=CORES['primaria'])),
        text=[f"R$ {v:,.0f}" for v in df['valor_num']],
        textposition='outside',
        textfont=dict(color='white'),
        hovertemplate='<b>%{y}</b><br>Valor: R$ %{x:,.2f}<br>Itens: %{customdata[0]}<extra></extra>',
        customdata=df[['qtd_itens_vendidos']].values
    ))
    
    fig.update_layout(**LAYOUT_CONFIG, height=500, title_text='Vendas por Segmento',
                      xaxis_title='Valor Total (R$)', margin=dict(l=180))
    return fig


@st.cache_data
@st.cache_data
def grafico_cores_vendidas(top_n=10):
    """Gráfico de Barras Horizontais - Cores mais vendidas"""
    analise = AnaliseDados()
    df = analise.analise_cores_mais_vendidas().head(top_n)
    df['valor_num'] = df['valor_total'].apply(_extrair_valor_monetario)
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
            colorbar=dict(title=dict(text="Qtd", font=dict(color='white')), tickfont=dict(color='white'))
        ),
        text=df['qtd_vendida'],
        textposition='outside',
        textfont=dict(color='white'),
        hovertemplate='<b>%{y}</b><br>Quantidade: %{x}<br>Valor: %{customdata[0]}<extra></extra>',
        customdata=df[['valor_total']].values
    ))
    
    fig.update_layout(**LAYOUT_CONFIG, height=450, title_text=f'Top {top_n} Cores', 
                      xaxis_title='Quantidade Vendida', yaxis_title='Cor', margin=dict(l=150))
    return fig


@st.cache_data
def grafico_top_cosmeticos(top_n=5):
    """Gráfico de Barras - Top cosméticos"""
    analise = AnaliseDados()
    df = analise.analise_top_cosmeticos(top_n)
    df['valor_num'] = df['valor_total'].apply(_extrair_valor_monetario)
    df = df.sort_values('valor_num', ascending=True)
    
    fig = go.Figure()
    fig.add_trace(go.Bar(
        y=df['nome_produto'],
        x=df['valor_num'],
        orientation='h',
        marker=dict(color=CORES['secundaria'], line=dict(width=1, color=CORES['primaria'])),
        text=[f"R$ {v:,.0f}" for v in df['valor_num']],
        textposition='outside',
        textfont=dict(color='white'),
        hovertemplate='<b>%{y}</b><br>Valor: R$ %{x:,.2f}<br>Quantidade: %{customdata[0]}<extra></extra>',
        customdata=df[['qtd_vendida']].values
    ))
    
    fig.update_layout(**LAYOUT_CONFIG, height=400, title_text=f'Top {top_n} Cosméticos',
                      xaxis_title='Valor Total (R$)', margin=dict(l=200))
    return fig


@st.cache_data
def grafico_top_cadeiras_lavatorios(top_n=5):
    """Gráfico de Colunas - Top cadeiras e lavatórios"""
    analise = AnaliseDados()
    df = analise.analise_top_cadeiras_lavatorios(top_n)
    df['valor_num'] = df['valor_total'].apply(_extrair_valor_monetario)
    df = df.sort_values('valor_num', ascending=False)
    
    fig = go.Figure()
    fig.add_trace(go.Bar(
        x=df['nome_produto'],
        y=df['valor_num'],
        marker=dict(color=CORES['accent'], line=dict(width=1, color=CORES['primaria'])),
        text=[f"R$ {v:,.0f}" for v in df['valor_num']],
        textposition='outside',
        textfont=dict(color='white'),
        hovertemplate='<b>%{x}</b><br>Valor: R$ %{y:,.2f}<br>Quantidade: %{customdata[0]}<extra></extra>',
        customdata=df[['qtd_vendida']].values
    ))
    
    layout_config = {k: v for k, v in LAYOUT_CONFIG.items() if k != 'xaxis'}
    fig.update_layout(**layout_config, height=450, title_text=f'Top {top_n} Cadeiras/Lavatórios',
                      yaxis_title='Valor Total (R$)')
    fig.update_xaxes(tickangle=-45, gridcolor='rgba(74, 144, 226, 0.2)', color='#FFFFFF')
    return fig


@st.cache_data
def grafico_top3_segmento():
    """Gráfico de Barras - Top 3 por segmento"""
    analise = AnaliseDados()
    df = analise.analise_top3_por_segmento()
    df['valor_num'] = df['valor_total'].apply(_extrair_valor_monetario)
    df['produto_cat'] = df['categoria'] + ' - ' + df['nome_produto'].str[:30]
    df = df.sort_values(['categoria', 'valor_num'], ascending=[True, False])
    
    categorias_unicas = df['categoria'].unique()
    cores_cat = {cat: CORES['destaque'][i % len(CORES['destaque'])] for i, cat in enumerate(categorias_unicas)}
    
    fig = go.Figure()
    for categoria in categorias_unicas:
        df_cat = df[df['categoria'] == categoria]
        fig.add_trace(go.Bar(
            y=df_cat['produto_cat'],
            x=df_cat['valor_num'],
            name=categoria,
            orientation='h',
            marker=dict(color=cores_cat[categoria], line=dict(width=1, color=CORES['primaria'])),
            text=[f"R$ {v:,.0f}" for v in df_cat['valor_num']],
            textposition='outside',
            textfont=dict(color='white'),
            hovertemplate='<b>%{y}</b><br>Valor: R$ %{x:,.2f}<extra></extra>'
        ))
    
    fig.update_layout(**LAYOUT_CONFIG, height=800, title_text='Top 3 por Segmento',
                      xaxis_title='Valor Total (R$)', margin=dict(l=300), barmode='group')
    return fig


# ==================== GRÁFICOS DE VENDAS ====================

@st.cache_data
def grafico_vendas_ano():
    """Gráfico de Linha - Vendas por ano"""
    analise = AnaliseDados()
    df = analise.analise_vendas_por_ano()
    df['valor_num'] = df['valor_total'].apply(_extrair_valor_monetario)
    
    fig = make_subplots(specs=[[{"secondary_y": True}]])
    
    fig.add_trace(
        go.Scatter(
            x=df['ano'], y=df['valor_num'], name='Valor Total',
            mode='lines+markers', marker=dict(size=10, color=CORES['secundaria']),
            line=dict(width=3, color=CORES['secundaria']),
            hovertemplate='Ano %{x}<br>Valor: R$ %{y:,.2f}<extra></extra>'
        ),
        secondary_y=False
    )
    
    fig.add_trace(
        go.Scatter(
            x=df['ano'], y=df['total_pedidos'], name='Pedidos',
            mode='lines+markers', marker=dict(size=8, color=CORES['accent']),
            line=dict(width=2, dash='dash', color=CORES['accent']),
            hovertemplate='Ano %{x}<br>Pedidos: %{y}<extra></extra>'
        ),
        secondary_y=True
    )
    
    fig.update_layout(**LAYOUT_CONFIG, height=500, title_text='Evolução de Vendas',
                      hovermode='x unified')
    fig.update_yaxes(title_text="Valor Total (R$)", secondary_y=False, color='white')
    fig.update_yaxes(title_text="Quantidade de Pedidos", secondary_y=True, color='white')
    return fig


@st.cache_data
def grafico_vendas_canal():
    """Gráfico de Barras - Vendas por canal"""
    analise = AnaliseDados()
    df = analise.analise_vendas_por_canal()
    df['valor_num'] = df['valor_total'].apply(_extrair_valor_monetario)
    df = df.sort_values('valor_num', ascending=True)
    
    fig = go.Figure()
    fig.add_trace(go.Bar(
        y=df['canal_venda'],
        x=df['valor_num'],
        orientation='h',
        marker=dict(color=CORES['secundaria'], line=dict(width=1, color=CORES['primaria'])),
        text=[f"R$ {v:,.0f}" for v in df['valor_num']],
        textposition='outside',
        textfont=dict(color='white'),
        hovertemplate='<b>%{y}</b><br>Valor: R$ %{x:,.2f}<br>Pedidos: %{customdata[0]}<extra></extra>',
        customdata=df[['total_pedidos']].values
    ))
    
    fig.update_layout(**LAYOUT_CONFIG, height=450, title_text='Vendas por Canal',
                      xaxis_title='Valor Total (R$)', margin=dict(l=150))
    return fig


@st.cache_data
def grafico_vendas_forma_pagamento():
    """Gráfico de Barras - Vendas por forma de pagamento"""
    analise = AnaliseDados()
    df = analise.analise_vendas_por_forma_pagamento().head(10)
    df['valor_num'] = df['valor_total'].apply(_extrair_valor_monetario)
    df = df.sort_values('valor_num', ascending=False)
    
    fig = go.Figure()
    fig.add_trace(go.Bar(
        x=df['forma_pagamento'],
        y=df['valor_num'],
        marker=dict(color=CORES['accent'], line=dict(width=1, color=CORES['primaria'])),
        text=[f"R$ {v:,.0f}" for v in df['valor_num']],
        textposition='outside',
        textfont=dict(color='white'),
        hovertemplate='<b>%{x}</b><br>Valor: R$ %{y:,.2f}<br>Pedidos: %{customdata[0]}<extra></extra>',
        customdata=df[['total_pedidos']].values
    ))
    
    layout_config = {k: v for k, v in LAYOUT_CONFIG.items() if k != 'xaxis'}
    fig.update_layout(**layout_config, height=500, title_text='Vendas por Forma de Pagamento',
                      yaxis_title='Valor Total (R$)')
    fig.update_xaxes(tickangle=-45, gridcolor='rgba(74, 144, 226, 0.2)', color='#FFFFFF')
    return fig


@st.cache_data
def grafico_sazonalidade_heatmap():
    """Heatmap - Sazonalidade por ano e mês"""
    analise = AnaliseDados()
    df = analise.analise_sazonalidade()
    df['valor_num'] = df['valor_total'].apply(_extrair_valor_monetario)
    
    pivot = df.pivot_table(values='valor_num', index='mes_nome', columns='ano', aggfunc='sum', fill_value=0)
    ordem_meses = ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
                   'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro']
    pivot = pivot.reindex([m for m in ordem_meses if m in pivot.index])
    
    fig = go.Figure(data=go.Heatmap(
        z=pivot.values,
        x=[f"{int(ano)}" if pd.notna(ano) else "" for ano in pivot.columns],
        y=pivot.index,
        colorscale=[[0, CORES['primaria']], [0.5, CORES['secundaria']], [1, CORES['accent']]],
        text=[[f"R$ {val:,.0f}" if val > 0 else "" for val in row] for row in pivot.values],
        texttemplate='%{text}',
        textfont={"size": 10, "color": "white"},
        colorbar=dict(title=dict(text="Valor (R$)", font=dict(color='white')), tickfont=dict(color='white')),
        hovertemplate='<b>%{y} - %{x}</b><br>Valor: R$ %{z:,.2f}<extra></extra>'
    ))
    
    fig.update_layout(**LAYOUT_CONFIG, height=600, title_text='Sazonalidade de Vendas',
                      xaxis_title='Ano', yaxis_title='Mês')
    return fig


@st.cache_data
def grafico_canal_venda_pareto(top_n=15):
    """Gráfico Pareto - Canal de venda por cliente"""
    analise = AnaliseDados()
    df = analise.analise_compras_por_canal_cliente().head(top_n)
    df['valor_num'] = df['valor_total'].apply(_extrair_valor_monetario)
    df = df.sort_values('valor_num', ascending=False)
    df['percentual_acumulado'] = (df['valor_num'].cumsum() / df['valor_num'].sum() * 100)
    
    fig = make_subplots(specs=[[{"secondary_y": True}]])
    
    fig.add_trace(
        go.Bar(
            x=df['nome'], y=df['valor_num'], name='Valor Total',
            marker=dict(color=CORES['secundaria']),
            hovertemplate='<b>%{x}</b><br>Valor: R$ %{y:,.2f}<extra></extra>'
        ),
        secondary_y=False
    )
    
    fig.add_trace(
        go.Scatter(
            x=df['nome'], y=df['percentual_acumulado'], name='% Acumulado',
            mode='lines+markers', marker=dict(color=CORES['accent'], size=8),
            line=dict(width=3, color=CORES['accent']),
            hovertemplate='<b>%{x}</b><br>% Acumulado: %{y:.1f}%<extra></extra>'
        ),
        secondary_y=True
    )
    
    fig.add_hline(y=80, line_dash="dash", line_color="red", annotation_text="80%", secondary_y=True)
    
    layout_config = {k: v for k, v in LAYOUT_CONFIG.items() if k != 'xaxis'}
    fig.update_layout(**layout_config, height=500, title_text=f'Análise de Pareto - Top {top_n} Clientes',
                      hovermode='x unified')
    fig.update_xaxes(tickangle=-45, gridcolor='rgba(74, 144, 226, 0.2)', color='#FFFFFF')
    fig.update_yaxes(title_text="Valor Total (R$)", secondary_y=False, color='white')
    fig.update_yaxes(title_text="% Acumulado", secondary_y=True, range=[0, 110], color='white')
    return fig


@st.cache_data
def grafico_kpi_totais():
    """KPI Cards - Totais gerais"""
    analise = AnaliseDados()
    dados = analise.analise_total_vendas_geral()
    valor_total = _extrair_valor_monetario(dados['valor_total_vendas'])
    ticket_medio = _extrair_valor_monetario(dados['ticket_medio'])
    
    fig = make_subplots(
        rows=2, cols=3,
        subplot_titles=('Valor Total', 'Pedidos', 'Itens Vendidos',
                       'Ticket Médio', 'Clientes', 'Produtos'),
        specs=[[{'type': 'indicator'}, {'type': 'indicator'}, {'type': 'indicator'}],
               [{'type': 'indicator'}, {'type': 'indicator'}, {'type': 'indicator'}]],
        vertical_spacing=0.15,
        horizontal_spacing=0.1
    )
    
    fig.add_trace(go.Indicator(
        mode="number", 
        value=valor_total,
        number={'prefix': "R$ ", 'valueformat': ",.0f", 'font': {'size': 32, 'color': 'white'}},
        domain={'x': [0, 1], 'y': [0, 1]}
    ), row=1, col=1)
    
    fig.add_trace(go.Indicator(
        mode="number",
        value=dados['total_pedidos'],
        number={'valueformat': ",", 'font': {'size': 32, 'color': 'white'}},
        domain={'x': [0, 1], 'y': [0, 1]}
    ), row=1, col=2)
    
    fig.add_trace(go.Indicator(
        mode="number",
        value=dados['total_itens_vendidos'],
        number={'valueformat': ",", 'font': {'size': 32, 'color': 'white'}},
        domain={'x': [0, 1], 'y': [0, 1]}
    ), row=1, col=3)
    
    fig.add_trace(go.Indicator(
        mode="number",
        value=ticket_medio,
        number={'prefix': "R$ ", 'valueformat': ",.2f", 'font': {'size': 32, 'color': 'white'}},
        domain={'x': [0, 1], 'y': [0, 1]}
    ), row=2, col=1)
    
    fig.add_trace(go.Indicator(
        mode="number",
        value=dados['clientes_unicos'],
        number={'valueformat': ",", 'font': {'size': 32, 'color': 'white'}},
        domain={'x': [0, 1], 'y': [0, 1]}
    ), row=2, col=2)
    
    fig.add_trace(go.Indicator(
        mode="number",
        value=dados['produtos_diferentes_vendidos'],
        number={'valueformat': ",", 'font': {'size': 32, 'color': 'white'}},
        domain={'x': [0, 1], 'y': [0, 1]}
    ), row=2, col=3)
    
    fig.update_layout(
        **{k: v for k, v in LAYOUT_CONFIG.items() if k != 'xaxis' and k != 'yaxis'},
        height=500,
        title_text='Indicadores Gerais',
        annotations=[dict(font=dict(color='white')) for _ in range(6)]
    )
    return fig
