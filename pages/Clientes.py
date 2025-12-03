"""
Conecta Beauty - Página de Clientes
CRUD completo + Dashboard com análises
"""
import streamlit as st
import sys
from pathlib import Path
import pandas as pd

# Adicionar pasta principal ao path
sys.path.append(str(Path(__file__).parent.parent))

from utils.styles import apply_custom_style, get_page_header
from utils.crud_operations import CRUDOperations
from utils.chart_loader import load_chart

# Configuração da página
st.set_page_config(
    layout="wide",
    page_title="Conecta Beauty - Clientes",
    page_icon="859c6ffa-5842-4e6d-9f38-8a4fc7288d97-removebg-preview.png",
    initial_sidebar_state="expanded"
)

# Aplicar estilos
apply_custom_style()

# Sidebar
with st.sidebar:
    st.image("859c6ffa-5842-4e6d-9f38-8a4fc7288d97-removebg-preview.png", use_container_width=True)
    st.markdown("""
    <div style='text-align: center; padding: 1rem 0;'>
        <h2 style='color: white; margin: 0.5rem 0;'>Conecta Beauty</h2>
    </div>
    """, unsafe_allow_html=True)
    
    if st.button("Voltar ao Início", use_container_width=True):
        st.switch_page("Inicio.py")

# Header
st.markdown(get_page_header(
    "Gerenciamento de Clientes",
    "CRUD completo e análises detalhadas"
), unsafe_allow_html=True)

# Inicializar CRUD
crud = CRUDOperations()

# Tabs principais
tab_tabela, tab_dashboard = st.tabs(["📊 Tabela de Clientes", "📈 Dashboard"])

# ==================== TAB: TABELA ====================
with tab_tabela:
    st.markdown("### Gerenciar Clientes")
    
    # Botão adicionar no canto superior direito
    col_search, col_spacer, col_add = st.columns([3, 1, 1])
    
    with col_search:
        filtro_nome = st.text_input(" Buscar por nome", placeholder="Digite o nome do cliente...")
    
    with col_add:
        st.markdown("<br>", unsafe_allow_html=True)
        if st.button("➕ Adicionar Cliente", use_container_width=True, type="primary"):
            st.session_state.show_add_form = True
    
    # Formulário de adicionar (aparece quando botão é clicado)
    if st.session_state.get('show_add_form', False):
        with st.form("form_adicionar_cliente"):
            st.markdown("#### Novo Cliente")
            
            col1, col2 = st.columns(2)
            
            with col1:
                novo_nome = st.text_input("Nome Completo*", key="novo_nome")
                novo_sexo = st.selectbox("Sexo*", ["F", "M"], format_func=lambda x: "Feminino" if x == "F" else "Masculino", key="novo_sexo")
                novo_cidade = st.text_input("Cidade*", key="novo_cidade")
            
            with col2:
                novo_estado = st.text_input("Estado (UF)*", max_chars=2, key="novo_estado")
                novo_telefone = st.text_input("Telefone", placeholder="(11) 99999-9999", key="novo_telefone")
            
            col_submit, col_cancel = st.columns([1, 1])
            
            with col_submit:
                submit = st.form_submit_button("✅ Salvar Cliente", use_container_width=True)
            with col_cancel:
                cancel = st.form_submit_button("❌ Cancelar", use_container_width=True)
            
            if submit:
                if novo_nome and novo_cidade and novo_estado:
                    result = crud.adicionar_cliente(
                        nome=novo_nome,
                        sexo=novo_sexo,
                        cidade=novo_cidade,
                        estado=novo_estado.upper(),
                        telefone=novo_telefone
                    )
                    
                    if result['success']:
                        st.success(f"✅ Cliente '{novo_nome}' adicionado com sucesso! ID: {result['id']}")
                        st.session_state.show_add_form = False
                        st.rerun()
                    else:
                        st.error(f"❌ Erro ao adicionar cliente: {result['error']}")
                else:
                    st.error("❌ Preencha todos os campos obrigatórios (*)!")
            
            if cancel:
                st.session_state.show_add_form = False
                st.rerun()
    
    st.markdown("---")
    
    # Buscar e exibir clientes
    try:
        # Aplicar filtro se houver
        filtro = {}
        if filtro_nome:
            filtro['nome'] = {'$regex': filtro_nome, '$options': 'i'}
        
        df_clientes = crud.buscar_clientes(filtro)
        
        if not df_clientes.empty:
            # Formatar dados para exibição
            df_display = df_clientes.copy()
            
            # Converter sexo para exibição
            df_display['sexo'] = df_display['sexo'].map({'F': 'Feminino', 'M': 'Masculino'})
            
            # Remover campos desnecessários
            colunas_exibir = ['id_cliente', 'nome', 'sexo', 'cidade', 'estado2', 'telefone']
            df_display = df_display[[col for col in colunas_exibir if col in df_display.columns]]
            
            # Renomear colunas
            df_display.columns = ['ID', 'Nome', 'Sexo', 'Cidade', 'Estado', 'Telefone']
            
            st.markdown(f"**Total de clientes encontrados:** {len(df_display)}")
            
            # Adicionar colunas de ação
            for idx, row in df_display.iterrows():
                col_data, col_edit, col_delete = st.columns([8, 1, 1])
                
                with col_data:
                    st.write(f"**{row['Nome']}** | {row['Sexo']} | {row['Cidade']}/{row['Estado']} | {row['Telefone']}")
                
                with col_edit:
                    if st.button("✏️", key=f"edit_{row['ID']}", help="Editar cliente"):
                        st.session_state.editing_client = row['ID']
                
                with col_delete:
                    if st.button("🗑️", key=f"delete_{row['ID']}", help="Excluir cliente"):
                        result = crud.excluir_cliente(row['ID'])
                        if result['success']:
                            st.success(f"✅ Cliente '{row['Nome']}' excluído com sucesso!")
                            st.rerun()
                        else:
                            st.error(f"❌ Erro ao excluir: {result['error']}")
                
                # Formulário de edição (aparece quando botão editar é clicado)
                if st.session_state.get('editing_client') == row['ID']:
                    st.markdown("#### ✏️ Editar Cliente")
                    
                    cliente_atual = crud.buscar_cliente_por_id(row['ID'])
                    
                    if cliente_atual is None:
                        st.error("❌ Cliente não encontrado!")
                        st.session_state.editing_client = None
                        st.rerun()
                    
                    with st.form(f"form_edit_{row['ID']}"):
                        col1, col2 = st.columns(2)
                        
                        with col1:
                            edit_nome = st.text_input("Nome", value=cliente_atual['nome'])
                            edit_sexo = st.selectbox("Sexo", ["F", "M"], 
                                                    index=0 if cliente_atual['sexo'] == 'F' else 1,
                                                    format_func=lambda x: "Feminino" if x == "F" else "Masculino")
                            edit_cidade = st.text_input("Cidade", value=cliente_atual['cidade'])
                        
                        with col2:
                            edit_estado = st.text_input("Estado", value=cliente_atual['estado2'])
                            edit_telefone = st.text_input("Telefone", value=cliente_atual.get('telefone', ''))
                        
                        col_submit, col_cancel = st.columns([1, 1])
                        
                        with col_submit:
                            submit_btn = st.form_submit_button("✅ Salvar", use_container_width=True)
                        
                        with col_cancel:
                            cancel_btn = st.form_submit_button("❌ Cancelar", use_container_width=True)
                        
                        if submit_btn:
                            dados_atualizados = {
                                'nome': edit_nome,
                                'sexo': edit_sexo,
                                'cidade': edit_cidade,
                                'estado2': edit_estado.upper(),
                                'telefone': edit_telefone
                            }
                            
                            result = crud.atualizar_cliente(row['ID'], dados_atualizados)
                            
                            if result['success']:
                                st.success("✅ Cliente atualizado!")
                                st.session_state.editing_client = None
                                st.rerun()
                            else:
                                st.error(f"❌ Erro: {result['error']}")
                        
                        if cancel_btn:
                            st.session_state.editing_client = None
                            st.rerun()
                
                st.markdown("---")
        
        else:
            st.info("ℹ️ Nenhum cliente encontrado.")
    
    except Exception as e:
        st.error(f"❌ Erro ao carregar clientes: {str(e)}")

# ==================== TAB: DASHBOARD ====================
with tab_dashboard:
    st.markdown("### Análises de Clientes")
    st.markdown("<div class='chart-container'>", unsafe_allow_html=True)
    col1, col2 = st.columns(2)
    
    with col1:

        st.markdown("#### Distribuição por Sexo")
        load_chart("clientes_sexo.html", height=400)
        st.markdown("</div>", unsafe_allow_html=True)
    
    with col2:
        st.markdown("#### Distribuição por Região")
        load_chart("clientes_regiao.html", height=400)
        st.markdown("</div>", unsafe_allow_html=True)
    
    # Clientes valiosos
    st.markdown("<div class='chart-container'>", unsafe_allow_html=True)
    st.markdown("### Clientes Mais Valiosos")
    load_chart("clientes_valiosos.html", height=500)
    st.markdown("</div>", unsafe_allow_html=True)
