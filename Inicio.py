"""
Conecta Beauty - Sistema de Analytics
Página Principal (Home)
"""
import streamlit as st
import sys
from pathlib import Path

# Adicionar pasta utils ao path
sys.path.append(str(Path(__file__).parent))

from utils.styles import apply_custom_style, get_page_header, get_kpi_card
from utils.chart_loader import load_chart
from Dados.analises import AnaliseDados

# Configuração da página
st.set_page_config(
    layout="wide",
    page_title="Inicio",
    page_icon="859c6ffa-5842-4e6d-9f38-8a4fc7288d97-removebg-preview.png",
    initial_sidebar_state="expanded"
)

# Aplicar estilos customizados
apply_custom_style()

# Sidebar
with st.sidebar:
    st.image("859c6ffa-5842-4e6d-9f38-8a4fc7288d97-removebg-preview.png", use_container_width=True)
    st.markdown("""
    <div style='text-align: center; padding: 1rem 0;'>
        <h2 style='color: white; margin: 0.5rem 0;'>Conecta Beauty</h2>
        <p style='color: rgba(255,255,255,0.8); font-size: 0.9rem;'>Sistema de Analytics</p>
    </div>
    """, unsafe_allow_html=True)
    
    st.markdown("---")
    
    st.markdown("""
    <div style='color: white; padding: 1rem;'>
        <h3 style='color: white; margin-bottom: 1rem;'>Navegação</h3>
        <p style='margin: 0.5rem 0;'>• Clientes</p>
        <p style='margin: 0.5rem 0;'>• Produtos</p>
        <p style='margin: 0.5rem 0;'>• Vendas</p>
        <p style='margin: 0.5rem 0;'>• Chat de Analises</p>
    </div>
    """, unsafe_allow_html=True)

# Header
st.markdown(get_page_header(
    "Dashboard Conecta Beauty",
    "Análise completa de vendas, produtos e clientes"
), unsafe_allow_html=True)

# Carregar dados
@st.cache_resource
def carregar_analises():
    return AnaliseDados()

try:
    with st.spinner("Carregando dados..."):
        analise = carregar_analises()
        totais = analise.analise_total_vendas_geral()
    
    # KPIs principais
    st.subheader("Indicadores Principais")
    
    col1, col2, col3, col4 = st.columns(4)
    
    with col1:
        st.markdown(get_kpi_card(
            "Faturamento Total",
            totais['valor_total_vendas']
        ), unsafe_allow_html=True)
    
    with col2:
        st.markdown(get_kpi_card(
            "Total de Pedidos",
            f"{totais['total_pedidos']:,}"
        ), unsafe_allow_html=True)
    
    with col3:
        st.markdown(get_kpi_card(
            "Ticket Médio",
            totais['ticket_medio']
        ), unsafe_allow_html=True)
    
    with col4:
        st.markdown(get_kpi_card(
            "Clientes Únicos",
            f"{totais['clientes_unicos']:,}"
        ), unsafe_allow_html=True)
    
    # Gráficos principais
    st.subheader("Análises Visuais")
    st.markdown("<div class='chart-container'>", unsafe_allow_html=True)

    col1, col2 = st.columns(2)
    
    with col1:
        
        st.markdown("#### Vendas por Ano")
        load_chart("vendas_ano.html", height=400)
        st.markdown("</div>", unsafe_allow_html=True)
    
    with col2:
        
        st.markdown("#### Top Produtos")
        load_chart("top_produtos.html", height=400)
        st.markdown("</div>", unsafe_allow_html=True)
    
    # Análise de Pareto
    st.markdown("<div class='chart-container'>", unsafe_allow_html=True)
    st.markdown("### Análise de Pareto - Canais de Venda")
    load_chart("canal_venda_pareto.html", height=500)
    st.markdown("</div>", unsafe_allow_html=True)
    
    # Cards de navegação rápida
    st.subheader("Acesso Rápido às Páginas")
    
    col1, col2, col3, col4 = st.columns(4)
    
    with col1:
        if st.button("Clientes", use_container_width=True, help="Gerenciar e analisar clientes"):
            st.switch_page("pages/Clientes.py")
    
    with col2:
        if st.button("Produtos", use_container_width=True, help="Gerenciar e analisar produtos"):
            st.switch_page("pages/Produtos.py")
    
    with col3:
        if st.button("Vendas", use_container_width=True, help="Gerenciar e analisar vendas"):
            st.switch_page("pages/Vendas.py")
    
    with col4:
        if st.button("Chat de analises", use_container_width=True, help="Conversar com assistente de IA"):
            st.switch_page("pages/Chat_Analises.py")
    
    # Informações adicionais
    with st.expander("ℹ️ Informações do Sistema"):
        col1, col2 = st.columns(2)
        
        with col1:
            st.markdown("**Estatísticas Gerais:**")
            st.markdown(f"- Total de itens vendidos: **{totais['total_itens_vendidos']:,}**")
            st.markdown(f"- Produtos diferentes vendidos: **{totais['produtos_diferentes_vendidos']:,}**")
            st.markdown(f"- Média de itens por pedido: **{totais['media_itens_por_pedido']}**")
        
        with col2:
            st.markdown("**Páginas Disponíveis:**")
            st.markdown("-  **Clientes**: CRUD completo + Dashboard com análises")
            st.markdown("-  **Produtos**: CRUD completo + Dashboard com análises")
            st.markdown("-  **Vendas**: CRUD completo + Dashboard com análises")
            st.markdown("-  **Chat de Analises**: Assistente inteligente com histórico")

except Exception as e:
    st.error(f"❌ Erro ao carregar dashboard: {str(e)}")
    st.exception(e)
