"""
Carregador de gráficos
Renderiza gráficos Plotly diretamente no Streamlit
"""
import streamlit as st
import sys
from pathlib import Path

# Adicionar pasta principal ao path
sys.path.append(str(Path(__file__).parent.parent))

import Dados.charts as charts


# Mapeamento de nomes de gráficos para funções
GRAFICOS_DISPONIVEIS = {
    # Clientes
    'clientes_sexo': charts.grafico_clientes_sexo,
    'clientes_regiao': charts.grafico_clientes_regiao,
    'clientes_valiosos': charts.grafico_clientes_valiosos,
    
    # Produtos
    'top_produtos': charts.grafico_top_produtos,
    'vendas_segmento': charts.grafico_vendas_segmento,
    'cores_vendidas': charts.grafico_cores_vendidas,
    'top_cosmeticos': charts.grafico_top_cosmeticos,
    'top_cadeiras_lavatorios': charts.grafico_top_cadeiras_lavatorios,
    'top3_segmento': charts.grafico_top3_segmento,
    
    # Vendas
    'vendas_ano': charts.grafico_vendas_ano,
    'vendas_canal': charts.grafico_vendas_canal,
    'vendas_forma_pagamento': charts.grafico_vendas_forma_pagamento,
    'sazonalidade_heatmap': charts.grafico_sazonalidade_heatmap,
    'canal_venda_pareto': charts.grafico_canal_venda_pareto,
    'kpi_totais': charts.grafico_kpi_totais
}


def load_chart(chart_name, height=600):
    """
    Carrega e renderiza um gráfico Plotly diretamente
    
    Args:
        chart_name: Nome do gráfico (com ou sem extensão .html)
        height: Altura do gráfico em pixels (não usado, mantido para compatibilidade)
    
    Returns:
        True se o gráfico foi carregado com sucesso, False caso contrário
    """
    try:
        # Remover extensão .html se existir
        chart_name = chart_name.replace('.html', '')
        
        if chart_name in GRAFICOS_DISPONIVEIS:
            # Gerar gráfico usando a função correspondente
            fig = GRAFICOS_DISPONIVEIS[chart_name]()
            
            # Renderizar no Streamlit
            st.plotly_chart(fig, use_container_width=True, config={'displayModeBar': False})
            return True
        else:
            st.warning(f"⚠️ Gráfico '{chart_name}' não encontrado!")
            st.info(f"Gráficos disponíveis: {', '.join(GRAFICOS_DISPONIVEIS.keys())}")
            return False
        
    except Exception as e:
        st.error(f"❌ Erro ao carregar gráfico '{chart_name}': {str(e)}")
        return False


def load_multiple_charts(chart_names, columns=2, height=600):
    """
    Carrega múltiplos gráficos em layout de colunas
    
    Args:
        chart_names: Lista de nomes de gráficos
        columns: Número de colunas no layout
        height: Altura dos gráficos (não usado, mantido para compatibilidade)
    """
    cols = st.columns(columns)
    
    for idx, chart_name in enumerate(chart_names):
        with cols[idx % columns]:
            load_chart(chart_name, height=height)


def list_available_charts():
    """Lista todos os gráficos disponíveis"""
    return list(GRAFICOS_DISPONIVEIS.keys())


def chart_exists(chart_name):
    """Verifica se um gráfico existe"""
    chart_name = chart_name.replace('.html', '')
    return chart_name in GRAFICOS_DISPONIVEIS
