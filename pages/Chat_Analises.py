"""
Conecta Beauty - Chat IA
Interface de conversação com agente de análise
"""
import streamlit as st
import sys
from pathlib import Path
import requests
import uuid

# Adicionar pasta principal ao path
sys.path.append(str(Path(__file__).parent.parent))

from utils.styles import apply_custom_style, get_page_header

# Configuração da página
st.set_page_config(
    layout="wide",
    page_title="Conecta Beauty - Chat IA",
    page_icon="859c6ffa-5842-4e6d-9f38-8a4fc7288d97-removebg-preview.png",
    initial_sidebar_state="expanded"
)

# Aplicar estilos
apply_custom_style()

# Configuração do agente
AGENT_ID = 'conectabeauty-analytics-agent'
AGENT_URL = f"http://127.0.0.3:9999/agents/{AGENT_ID}/runs"

# Inicializar session state
if 'session_id' not in st.session_state:
    st.session_state.session_id = None  # Será criado na primeira mensagem
    print(f"🆔 Aguardando primeira mensagem para criar sessão")

if 'messages' not in st.session_state:
    st.session_state.messages = []

def send_message_to_agent(message, session_id, max_retries=3):
    """Envia mensagem para o agente e retorna resposta com retry automático"""
    for attempt in range(max_retries):
        try:
            # Enviar com session_id para persistência
            data = {
                'message': message,
                'stream': 'false'
            }
            
            # Adicionar session_id se existir
            if session_id:
                data['session_id'] = session_id
            
            response = requests.post(AGENT_URL, data=data, timeout=90)
            response.raise_for_status()
            
            result = response.json()
            
            # IMPORTANTE: Salvar o session_id retornado pelo agente
            if 'session_id' in result:
                st.session_state.session_id = result['session_id']
            
            return {
                'success': True,
                'content': result.get('content', 'Sem resposta do agente.'),
                'tools': result.get('tools', []),
                'session_id': result.get('session_id')
            }
        
        except requests.exceptions.Timeout:
            if attempt < max_retries - 1:
                continue  # Tentar novamente
            return {
                'success': False,
                'error': 'Tempo de resposta esgotado após múltiplas tentativas. Tente novamente.'
            }
        except requests.exceptions.ConnectionError:
            return {
                'success': False,
                'error': 'Não foi possível conectar ao agente. Verifique se o agente está rodando em http://127.0.0.3:9999'
            }
        except requests.exceptions.RequestException as e:
            if attempt < max_retries - 1 and '500' in str(e):
                continue  # Tentar novamente em caso de erro 500
            return {
                'success': False,
                'error': f'Erro na comunicação com o agente: {str(e)}'
            }
        except Exception as e:
            return {
                'success': False,
                'error': f'Erro inesperado: {str(e)}'
            }

def limpar_conversa():
    """Inicia nova sessão (limpa session_id para ser recriado)"""
    st.session_state.session_id = None
    st.session_state.messages = []
    print(f"🆔 Sessão limpa - nova sessão será criada na próxima mensagem")

# Sidebar com histórico de conversas
with st.sidebar:
    st.image("859c6ffa-5842-4e6d-9f38-8a4fc7288d97-removebg-preview.png", use_container_width=True)
    st.markdown("""
    <div style='text-align: center; padding: 1rem 0;'>
        <h2 style='color: white; margin: 0.5rem 0;'>Conecta Beauty</h2>
    </div>
    """, unsafe_allow_html=True)
    
    if st.button("Voltar ao Início", use_container_width=True):
        st.switch_page("Inicio.py")
    
    st.markdown("---")
    
    # Verificar status do agente
    try:
        status_response = requests.get("http://127.0.0.3:9999/health", timeout=2)
        if status_response.status_code == 200:
            st.success("✅ Agente Online")
        else:
            st.warning("⚠️ Agente com problemas")
    except:
        st.error("🔴 Agente Offline")
        st.caption("Execute: `python agent.py`")
    
    st.markdown("---")
    
    # Botão limpar conversa
    if st.button("🔄 Nova Conversa", use_container_width=True, type="primary"):
        limpar_conversa()
        st.rerun()
    
    # Info da sessão
    with st.expander("ℹ️ Info da Sessão"):
        st.caption(f"**Session ID:**")
        if st.session_state.session_id:
            st.code(st.session_state.session_id[:8] + "...", language=None)
        else:
            st.code("Nenhuma sessão ativa", language=None)
        st.caption(f"**Mensagens:** {len(st.session_state.messages)}")

# Header
st.markdown(get_page_header(
    "Chat IA - Análise de Dados",
    "Converse com o assistente inteligente sobre seus dados"
), unsafe_allow_html=True)

# Informações sobre o agente
with st.expander("ℹ️ Sobre o Assistente IA", expanded=False):
    st.markdown("""
    ### 🤖 Capacidades do Assistente
    
    O assistente possui as seguintes ferramentas:
    
    1. **📊 Analisar Clientes** - Análises detalhadas sobre a base de clientes
    2. **📦 Analisar Produtos** - Informações sobre produtos e categorias
    3. **💰 Analisar Vendas** - Análises de vendas, faturamento e tendências
    4. **💵 Obter Cotação** - Consulta preços de produtos
    5. **🔍 Buscar Produto** - Busca produtos no catálogo
    6. **📢 Recomendar Campanha** - Sugere campanhas de marketing
    7. **🎯 Analisar Mix de Produtos** - Análise de mix e desempenho
    
    ### 💡 Exemplos de perguntas:
    
    - "Quantos clientes temos cadastrados?"
    - "Quais os produtos mais vendidos?"
    - "Qual foi o faturamento de 2022?"
    - "Qual mês vendeu mais esse ano?" _(mantém contexto!)_
    - "Quanto custa esse produto?" _(lembra do produto mencionado!)_
    
    ### 🧠 Memória Persistente
    
    ✅ O agente **lembra** das últimas 20 interações automaticamente
    ✅ Você pode fazer **perguntas de acompanhamento** sem repetir contexto
    ✅ Use **"esse ano", "esse produto", "dele"** e o agente entenderá
    """)

st.markdown("---")

# Área de chat
chat_container = st.container()

# Exibir mensagens
with chat_container:
    if len(st.session_state.messages) == 0:
        st.info("Olá! Sou seu assistente de análise de dados. Como posso ajudar você hoje?")
    
    for message in st.session_state.messages:
        with st.chat_message(message['role']):
            st.markdown(message['content'])
            
            # Exibir ferramentas usadas
            if message['role'] == 'assistant' and 'tools' in message and message['tools']:
                with st.expander("Ferramentas Utilizadas"):
                    for tool in message['tools']:
                        st.write(f"- **{tool.get('name', 'Ferramenta')}**")

# Input do usuário
user_input = st.chat_input("Digite sua pergunta...")

if user_input:
    # Adicionar mensagem do usuário
    st.session_state.messages.append({
        'role': 'user',
        'content': user_input
    })
    
    # Exibir mensagem do usuário
    with st.chat_message("user"):
        st.markdown(user_input)
    
    # Enviar para o agente
    with st.chat_message("assistant"):
        with st.spinner("Pensando..."):
            response = send_message_to_agent(user_input, st.session_state.session_id)
        
        if response['success']:
            st.markdown(response['content'])
            
            # Exibir ferramentas usadas
            if response['tools']:
                with st.expander("Ferramentas Utilizadas"):
                    for tool in response['tools']:
                        st.write(f"- **{tool.get('name', 'Ferramenta')}**")
            
            # Mostrar session_id se foi criado
            if response.get('session_id') and not st.session_state.session_id:
                st.info(f"✅ Sessão criada: {response['session_id'][:8]}...")
            
            # Adicionar resposta do assistente
            st.session_state.messages.append({
                'role': 'assistant',
                'content': response['content'],
                'tools': response['tools']
            })
        else:
            error_message = f"❌ Erro: {response['error']}"
            st.error(error_message)
            
            # Adicionar mensagem de erro
            st.session_state.messages.append({
                'role': 'assistant',
                'content': error_message
            })
    
    st.rerun()

# Rodapé
st.markdown("---")
st.markdown("""
<div style='text-align: center; color: #666; padding: 1rem;'> 
    <p>🔄 Use "Nova Conversa" para iniciar uma sessão limpa.</p>
</div>
""", unsafe_allow_html=True)
