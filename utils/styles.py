"""
Estilos customizados para a aplicação Conecta Beauty
Paleta de cores profissional e design harmonioso
"""

def get_custom_css():
    """Retorna o CSS customizado para a aplicação"""
    return """
    <style>
    /* ========== PALETA DE CORES ========== */
    :root {
        --primary-color: #1E3A5F;
        --secondary-color: #4A90E2;
        --accent-color: #F39C12;
        --background-color: #F8F9FA;
        --text-color: #2C3E50;
        --success-color: #27AE60;
        --error-color: #E74C3C;
        --card-bg: #FFFFFF;
        --border-color: #E0E0E0;
    }
    
    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');
    
    /* ========== LAYOUT GERAL ========== */
    html, body, [class*="css"] {
        font-family: 'Inter', sans-serif;
    }
    
    .main {
        background: linear-gradient(to bottom, #0f2942 0%, #1a3d5c 100%);
        color: #FFFFFF;
    }
    
    /* ========== SIDEBAR ========== */
    [data-testid="stSidebar"] {
        background: linear-gradient(180deg, var(--primary-color) 0%, #2C4A6F 100%);
    }
    
    [data-testid="stSidebar"] .css-1d391kg {
        color: white !important;
    }
    
    [data-testid="stSidebar"] h1, [data-testid="stSidebar"] h2, [data-testid="stSidebar"] h3,
    [data-testid="stSidebar"] p, [data-testid="stSidebar"] label {
        color: white !important;
    }
    
    /* ========== HEADER ========== */
    .app-header {
        background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
        padding: 2rem;
        border-radius: 15px;
        color: white;
        margin-bottom: 2rem;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    
    .app-header h1 {
        margin: 0;
        font-size: 2.5rem;
        font-weight: 700;
    }
    
    .app-header p {
        margin: 0.5rem 0 0 0;
        font-size: 1.1rem;
        opacity: 0.9;
    }
    
    /* ========== CARDS KPI ========== */
    .kpi-card {
        background: linear-gradient(135deg, #4A90E2 0%, #5BA3F5 100%);
        padding: 1.5rem;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        border-left: 4px solid #F39C12;
        transition: transform 0.2s, box-shadow 0.2s;
        height: 100%;
    }
    
    .kpi-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    }
    
    .kpi-label {
        font-size: 0.9rem;
        color: #FFFFFF;
        opacity: 0.95;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin-bottom: 0.5rem;
        font-weight: 600;
    }
    
    .kpi-value {
        font-size: 2rem;
        font-weight: 700;
        color: #FFFFFF;
        margin: 0;
        text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
    }
    
    .kpi-delta {
        font-size: 0.9rem;
        margin-top: 0.5rem;
    }
    
    .kpi-delta.positive {
        color: var(--success-color);
    }
    
    .kpi-delta.negative {
        color: var(--error-color);
    }
    
    /* ========== TABELAS ========== */
    .dataframe {
        border: none !important;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
    }
    
    .dataframe thead tr th {
        background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%) !important;
        color: white !important;
        font-weight: 600 !important;
        padding: 1rem !important;
        border: none !important;
    }
    
    .dataframe tbody tr {
        background-color: white;
        transition: background-color 0.2s;
    }
    
    .dataframe tbody tr:hover {
        background-color: rgba(74, 144, 226, 0.05);
    }
    
    .dataframe tbody tr td {
        padding: 0.8rem !important;
        border-bottom: 1px solid var(--border-color) !important;
    }
    
    /* ========== BOTÕES ========== */
    .stButton > button {
        background: linear-gradient(135deg, var(--secondary-color) 0%, #357ABD 100%);
        color: white;
        border: none;
        padding: 0.6rem 1.5rem;
        border-radius: 8px;
        font-weight: 600;
        transition: all 0.3s;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    
    .stButton > button:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        background: linear-gradient(135deg, #357ABD 0%, var(--secondary-color) 100%);
    }
    
    .stButton > button:active {
        transform: translateY(0);
    }
    
    /* ========== INPUTS ========== */
    .stTextInput > div > div > input,
    .stSelectbox > div > div > select,
    .stNumberInput > div > div > input,
    .stDateInput > div > div > input {
        border: 2px solid rgba(74, 144, 226, 0.3);
        border-radius: 8px;
        padding: 0.6rem;
        transition: border-color 0.3s;
        background-color: rgba(255, 255, 255, 0.1);
        color: #FFFFFF !important;
    }
    
    .stTextInput > div > div > input:focus,
    .stSelectbox > div > div > select:focus,
    .stNumberInput > div > div > input:focus,
    .stDateInput > div > div > input:focus {
        border-color: var(--secondary-color);
        box-shadow: 0 0 0 3px rgba(74, 144, 226, 0.2);
        background-color: rgba(255, 255, 255, 0.15);
    }
    
    .stTextInput label, .stSelectbox label, .stNumberInput label, .stDateInput label {
        color: #FFFFFF !important;
        font-weight: 600;
    }
    
    /* ========== GRÁFICOS ========== */
    .chart-container {
        background: linear-gradient(135deg, #1a3d5c 0%, #244d6f 100%);
        padding: 1rem;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
        margin-bottom: 1rem;
        border: 1px solid rgba(74, 144, 226, 0.3);
    }
    
    .chart-title {
        font-size: 1.3rem;
        font-weight: 600;
        color: #FFFFFF;
        margin-bottom: 0.5rem;
        padding-bottom: 0.5rem;
        border-bottom: 2px solid var(--secondary-color);
    }
    
    /* ========== TABS ========== */
    .stTabs [data-baseweb="tab-list"] {
        gap: 8px;
        background-color: transparent;
    }
    
    .stTabs [data-baseweb="tab"] {
        background-color: rgba(74, 144, 226, 0.2);
        border-radius: 8px 8px 0 0;
        padding: 0.8rem 1.5rem;
        font-weight: 600;
        border: 2px solid rgba(74, 144, 226, 0.3);
        border-bottom: none;
        color: #FFFFFF !important;
    }
    
    .stTabs [aria-selected="true"] {
        background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
        color: white !important;
        border-color: var(--secondary-color);
    }
    
    .stTabs [data-baseweb="tab"] p {
        color: #FFFFFF !important;
    }
    
    /* ========== EXPANDER ========== */
    .streamlit-expanderHeader {
        background: rgba(74, 144, 226, 0.2);
        border: 2px solid rgba(74, 144, 226, 0.3);
        border-radius: 8px;
        font-weight: 600;
        color: #FFFFFF !important;
    }
    
    .streamlit-expanderHeader:hover {
        background: rgba(74, 144, 226, 0.3);
        border-color: var(--secondary-color);
    }
    
    .streamlit-expanderContent {
        background: rgba(30, 58, 95, 0.3);
        border: 1px solid rgba(74, 144, 226, 0.2);
        border-radius: 0 0 8px 8px;
    }
    
    /* ========== MÉTRICAS ========== */
    [data-testid="stMetricValue"] {
        font-size: 2rem;
        font-weight: 700;
        color: #FFFFFF;
    }
    
    /* ========== TÍTULOS E TEXTOS ========== */
    h1, h2, h3, h4, h5, h6 {
        color: #FFFFFF !important;
    }
    
    p, span, label, div {
        color: #FFFFFF !important;
    }
    
    .stMarkdown {
        color: #FFFFFF !important;
    }
    
    [data-testid="stMetricDelta"] {
        font-size: 1rem;
        font-weight: 600;
    }
    
    /* ========== CHAT ========== */
    .chat-message {
        padding: 1rem;
        border-radius: 10px;
        margin-bottom: 1rem;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
    }
    
    .chat-message.user {
        background-color: #E8F4FD;
        border-left: 4px solid var(--secondary-color);
    }
    
    .chat-message.assistant {
        background-color: white;
        border-left: 4px solid var(--accent-color);
    }
    
    /* ========== SCROLLBAR ========== */
    ::-webkit-scrollbar {
        width: 10px;
        height: 10px;
    }
    
    ::-webkit-scrollbar-track {
        background: var(--background-color);
    }
    
    ::-webkit-scrollbar-thumb {
        background: var(--secondary-color);
        border-radius: 5px;
    }
    
    ::-webkit-scrollbar-thumb:hover {
        background: var(--primary-color);
    }
    
    /* ========== ANIMAÇÕES ========== */
    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    .fade-in {
        animation: fadeIn 0.5s ease-out;
    }
    
    /* ========== MENSAGENS E ALERTAS ========== */
    .stAlert {
        background: rgba(74, 144, 226, 0.15);
        border: 1px solid rgba(74, 144, 226, 0.3);
        color: #FFFFFF !important;
    }
    
    .stSuccess {
        background: rgba(39, 174, 96, 0.15);
        border: 1px solid rgba(39, 174, 96, 0.3);
    }
    
    .stError {
        background: rgba(231, 76, 60, 0.15);
        border: 1px solid rgba(231, 76, 60, 0.3);
    }
    
    .stWarning {
        background: rgba(243, 156, 18, 0.15);
        border: 1px solid rgba(243, 156, 18, 0.3);
    }
    
    .stInfo {
        background: rgba(74, 144, 226, 0.15);
        border: 1px solid rgba(74, 144, 226, 0.3);
    }
    </style>
    """


def get_page_header(title: str, subtitle: str = "") -> str:
    """Cria um header customizado para as páginas"""
    subtitle_html = f"<p>{subtitle}</p>" if subtitle else ""
    return f"""
    <div class="app-header fade-in">
        <h1>{title}</h1>
        {subtitle_html}
    </div>
    """


def get_kpi_card(label: str, value: str, delta: str = "", delta_positive: bool = True) -> str:
    """Cria um card KPI customizado"""
    delta_class = "positive" if delta_positive else "negative"
    delta_html = f'<div class="kpi-delta {delta_class}">{delta}</div>' if delta else ""
    
    return f"""
    <div class="kpi-card">
        <div class="kpi-label">{label}</div>
        <div class="kpi-value">{value}</div>
        {delta_html}
    </div>
    """


def apply_custom_style():
    """Aplica o CSS customizado na página (import necessário: import streamlit as st)"""
    import streamlit as st
    st.markdown(get_custom_css(), unsafe_allow_html=True)
