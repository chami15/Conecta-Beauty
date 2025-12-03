"""
Conecta Beauty - Página de Produtos
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
    page_title="Conecta Beauty - Produtos",
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
    "Gerenciamento de Produtos",
    "CRUD completo e análises detalhadas"
), unsafe_allow_html=True)

# Inicializar CRUD
crud = CRUDOperations()

# Tabs principais
tab_tabela, tab_dashboard = st.tabs(["📊 Tabela de Produtos", "📈 Dashboard"])

# ==================== TAB: TABELA ====================
with tab_tabela:
    st.markdown("### Gerenciar Produtos")
    
    # Filtros e botão adicionar
    col1, col2, col3, col_add = st.columns([2, 2, 2, 1])
    
    with col1:
        filtro_nome = st.text_input("Buscar por nome", placeholder="Nome do produto...")
    
    with col2:
        filtro_categoria = st.text_input("Buscar por categoria", placeholder="Categoria...")
    
    with col3:
        st.markdown("<br>", unsafe_allow_html=True)
    
    with col_add:
        st.markdown("<br>", unsafe_allow_html=True)
        if st.button("➕ Adicionar", use_container_width=True, type="primary"):
            st.session_state.show_add_product = True
    
    # Formulário de adicionar
    if st.session_state.get('show_add_product', False):
        with st.form("form_adicionar_produto"):
            st.markdown("#### Novo Produto")
            
            col1, col2 = st.columns(2)
            
            with col1:
                novo_nome = st.text_input("Nome do Produto*")
                novo_categoria = st.text_input("Categoria*")
            
            with col2:
                novo_fornecedor = st.text_input("Fornecedor*")
                novo_valor = st.number_input("Valor Unitário (R$)*", min_value=0.0, step=0.01, format="%.2f")
            
            col_submit, col_cancel = st.columns([1, 1])
            
            with col_submit:
                submit = st.form_submit_button("✅ Salvar Produto", use_container_width=True)
            with col_cancel:
                cancel = st.form_submit_button("❌ Cancelar", use_container_width=True)
            
            if submit:
                if novo_nome and novo_categoria and novo_fornecedor and novo_valor > 0:
                    result = crud.adicionar_produto(
                        nome_produto=novo_nome,
                        categoria=novo_categoria,
                        fornecedor=novo_fornecedor,
                        valor_unitario=novo_valor
                    )
                    
                    if result['success']:
                        st.success(f"✅ Produto '{novo_nome}' adicionado com sucesso! ID: {result['id']}")
                        st.session_state.show_add_product = False
                        st.rerun()
                    else:
                        st.error(f"❌ Erro ao adicionar produto: {result['error']}")
                else:
                    st.error("❌ Preencha todos os campos obrigatórios (*)!")
            
            if cancel:
                st.session_state.show_add_product = False
                st.rerun()
    
    st.markdown("---")
    
    # Buscar e exibir produtos
    try:
        # Aplicar filtros
        filtro = {}
        if filtro_nome:
            filtro['Nome Produto'] = {'$regex': filtro_nome, '$options': 'i'}
        if filtro_categoria:
            filtro['Categoria Produto'] = {'$regex': filtro_categoria, '$options': 'i'}
        
        df_produtos = crud.buscar_produtos(filtro)
        
        if not df_produtos.empty:
            # Debug: mostrar colunas disponíveis e primeiro registro
            print(f"Colunas disponíveis: {df_produtos.columns.tolist()}")
            print(f"Primeiro registro: {df_produtos.iloc[0].to_dict()}")
            
            # Formatar dados para exibição
            df_display = df_produtos.copy()
            
            # Função para converter valor para float
            def converter_valor(val):
                try:
                    if pd.isna(val):
                        return 0.0
                    if isinstance(val, (int, float)):
                        return float(val)
                    # Se for string, remover formatação brasileira
                    val_str = str(val).replace('R$', '').replace('.', '').replace(',', '.').strip()
                    return float(val_str)
                except:
                    return 0.0
            
            # Formatar valor - guardar original antes
            df_display['valor_formatado'] = df_display.apply(
                lambda row: f"R$ {converter_valor(row.get('Valor Unitário', row.get('valor_unitario', 0))):,.2f}".replace(",", "X").replace(".", ",").replace("X", "."),
                axis=1
            )
            
            st.markdown(f"**Total de produtos encontrados:** {len(df_display)}")
            
            # Exibir produtos com ações
            for idx, row in df_display.iterrows():
                col_data, col_edit, col_delete = st.columns([8, 1, 1])
                
                # Usar os nomes exatos do banco
                nome = row.get('Nome Produto', 'N/A')
                categoria = row.get('Categoria Produto', 'N/A')
                fornecedor = row.get('Fornecedor', 'N/A')
                valor = row.get('valor_formatado', 'R$ 0,00')
                id_produto = row.get('Id Produto', 0)
                
                with col_data:
                    st.write(f"**{nome}** | {categoria} | {fornecedor} | {valor}")
                
                with col_edit:
                    if st.button("✏️", key=f"edit_p_{id_produto}", help="Editar produto"):
                        st.session_state.editing_product = id_produto
                
                with col_delete:
                    if st.button("🗑️", key=f"delete_p_{id_produto}", help="Excluir produto"):
                        result = crud.excluir_produto(id_produto)
                        if result['success']:
                            st.success(f"✅ Produto '{nome}' excluído!")
                            st.rerun()
                        else:
                            st.error(f"❌ Erro: {result['error']}")
                
                # Formulário de edição
                if st.session_state.get('editing_product') == id_produto:
                    st.markdown("#### ✏️ Editar Produto")
                    
                    produto_atual = crud.buscar_produto_por_id(id_produto)
                    
                    if produto_atual is None:
                        st.error("❌ Produto não encontrado!")
                        st.session_state.editing_product = None
                        st.rerun()
                    
                    with st.form(f"form_edit_p_{id_produto}"):
                        # Função auxiliar para converter valor
                        def converter_valor_edit(val):
                            try:
                                if isinstance(val, (int, float)):
                                    return float(val)
                                val_str = str(val).replace('R$', '').replace('.', '').replace(',', '.').strip()
                                return float(val_str)
                            except:
                                return 0.0
                        
                        # Usar os nomes exatos do banco
                        nome_atual = produto_atual.get('Nome Produto', '')
                        cat_atual = produto_atual.get('Categoria Produto', '')
                        forn_atual = produto_atual.get('Fornecedor', '')
                        val_atual = converter_valor_edit(produto_atual.get('Valor Unitário', 0))
                        
                        col1, col2 = st.columns(2)
                        
                        with col1:
                            edit_nome = st.text_input("Nome", value=nome_atual)
                            edit_categoria = st.text_input("Categoria", value=cat_atual)
                        
                        with col2:
                            edit_fornecedor = st.text_input("Fornecedor", value=forn_atual)
                            edit_valor = st.number_input("Valor Unitário (R$)", 
                                                         value=val_atual, 
                                                         min_value=0.0, step=0.01, format="%.2f")
                        
                        col_submit, col_cancel = st.columns([1, 1])
                        
                        with col_submit:
                            submit_btn = st.form_submit_button("✅ Salvar", use_container_width=True)
                        
                        with col_cancel:
                            cancel_btn = st.form_submit_button("❌ Cancelar", use_container_width=True)
                        
                        if submit_btn:
                            dados_atualizados = {
                                'nome_produto': edit_nome,
                                'categoria': edit_categoria,
                                'fornecedor': edit_fornecedor,
                                'valor_unitario': edit_valor
                            }
                            
                            result = crud.atualizar_produto(id_produto, dados_atualizados)
                            
                            if result['success']:
                                st.success("✅ Produto atualizado!")
                                st.session_state.editing_product = None
                                st.rerun()
                            else:
                                st.error(f"❌ Erro: {result['error']}")
                        
                        if cancel_btn:
                            st.session_state.editing_product = None
                            st.rerun()
                
                st.markdown("---")
        
        else:
            st.info("ℹ❌ Nenhum produto encontrado.")
    
    except Exception as e:
        st.error(f"❌ Erro ao carregar produtos: {str(e)}")
        st.info("💡 Dica: Verifique a conexão com o MongoDB")

# ==================== TAB: DASHBOARD ====================
with tab_dashboard:
    st.markdown("### Análises de Produtos")
    st.markdown("<div class='chart-container'>", unsafe_allow_html=True)

    try:
        # Top produtos
        
        st.markdown("#### Top Produtos Mais Vendidos")
        load_chart("top_produtos.html", height=500)
        st.markdown("</div>", unsafe_allow_html=True)
        st.markdown("<div class='chart-container'>", unsafe_allow_html=True)
        col1, col2 = st.columns(2)
        
        with col1:
            
            st.markdown("#### Vendas por Segmento")
            load_chart("vendas_segmento.html", height=400)
            st.markdown("</div>", unsafe_allow_html=True)
        
        with col2:
            
            st.markdown("#### Cores Mais Vendidas")
            load_chart("cores_vendidas.html", height=400)
            st.markdown("</div>", unsafe_allow_html=True)
        
        col1, col2 = st.columns(2)
        
        with col1:
            
            st.markdown("#### Top Cosméticos")
            load_chart("top_cosmeticos.html", height=400)
            st.markdown("</div>", unsafe_allow_html=True)
        
        with col2:
            
            st.markdown("#### Top Cadeiras e Lavatórios")
            load_chart("top_cadeiras_lavatorios.html", height=400)
            st.markdown("</div>", unsafe_allow_html=True)
        
        # Top 3 por segmento
        st.markdown("<div class='chart-container'>", unsafe_allow_html=True)
        st.markdown("### Top 3 por Segmento")
        load_chart("top3_segmento.html", height=500)
        st.markdown("</div>", unsafe_allow_html=True)
    
    except Exception as e:
        st.error(f"❌ Erro ao carregar dashboard de produtos: {str(e)}")
        st.info("💡 Verifique se há dados de produtos no banco de dados")
