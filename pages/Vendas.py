"""
Conecta Beauty - Página de Vendas
CRUD completo + Dashboard com análises
"""
import streamlit as st
import sys
from pathlib import Path
import pandas as pd
from datetime import datetime

# Adicionar pasta principal ao path
sys.path.append(str(Path(__file__).parent.parent))

from utils.styles import apply_custom_style, get_page_header, get_kpi_card
from utils.crud_operations import CRUDOperations
from utils.chart_loader import load_chart

# Configuração da página
st.set_page_config(
    layout="wide",
    page_title="Conecta Beauty - Vendas",
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
    "Gerenciamento de Vendas",
    "CRUD completo e análises detalhadas"
), unsafe_allow_html=True)

# Inicializar CRUD
crud = CRUDOperations()

# Tabs principais
tab_tabela, tab_dashboard = st.tabs(["📊 Tabela de Vendas", "📈 Dashboard"])

# ==================== TAB: TABELA ====================
with tab_tabela:
    st.markdown("### Gerenciar Vendas")
    
    # Filtros e botão adicionar
    col1, col2, col3, col_add = st.columns([2, 2, 2, 1])
    
    with col1:
        filtro_canal = st.text_input("Buscar por canal", placeholder="Canal de venda...")
    
    with col2:
        filtro_forma_pagamento = st.text_input("Buscar por pagamento", placeholder="Forma de pagamento...")
    
    with col3:
        st.markdown("<br>", unsafe_allow_html=True)
    
    with col_add:
        st.markdown("<br>", unsafe_allow_html=True)
        if st.button("➕ Adicionar", use_container_width=True, type="primary"):
            st.session_state.show_add_venda = True
    
    # Formulário de adicionar
    if st.session_state.get('show_add_venda', False):
        with st.form("form_adicionar_venda"):
            st.markdown("#### Nova Venda")
            
            col1, col2 = st.columns(2)
            
            # Buscar clientes para dropdown
            df_clientes = crud.buscar_clientes()
            clientes_dict = {f"{row['nome']} (ID: {row['id_cliente']})": row['id_cliente'] 
                            for _, row in df_clientes.iterrows()}
            
            with col1:
                cliente_selecionado = st.selectbox("Cliente*", options=list(clientes_dict.keys()))
                novo_data = st.date_input("Data do Pedido*", value=datetime.now())
                novo_canal = st.selectbox("Canal de Venda*", 
                                         options=["Site", "Loja Física", "WhatsApp", "Instagram", "Marketplace"])
            
            with col2:
                novo_valor = st.number_input("Valor Total (R$)*", min_value=0.0, step=0.01, format="%.2f")
                novo_forma_pagamento = st.selectbox("Forma de Pagamento*",
                                                    options=["Pix", "Cartão Crédito", "Cartão Débito", 
                                                            "Boleto", "Dinheiro"])
            
            col_submit, col_cancel = st.columns([1, 1])
            
            with col_submit:
                submit = st.form_submit_button("✅ Salvar Venda", use_container_width=True)
            with col_cancel:
                cancel = st.form_submit_button("❌ Cancelar", use_container_width=True)
            
            if submit:
                if cliente_selecionado and novo_valor > 0:
                    id_cliente_selecionado = clientes_dict[cliente_selecionado]
                    
                    result = crud.adicionar_pedido(
                        id_cliente=id_cliente_selecionado,
                        data_pedido=novo_data.strftime('%Y-%m-%d'),
                        valor_total=novo_valor,
                        forma_pagamento=novo_forma_pagamento,
                        canal_venda=novo_canal
                    )
                    
                    if result['success']:
                        st.success(f"✅ Venda adicionada com sucesso! ID: {result['id']}")
                        st.session_state.show_add_venda = False
                        st.rerun()
                    else:
                        st.error(f"❌ Erro ao adicionar venda: {result['error']}")
                else:
                    st.error("❌ Preencha todos os campos obrigatórios (*)!")
            
            if cancel:
                st.session_state.show_add_venda = False
                st.rerun()
    
    st.markdown("---")
    
    # Buscar e exibir vendas
    try:
        # Aplicar filtros
        filtro = {}
        if filtro_canal:
            filtro['Canal de Venda'] = {'$regex': filtro_canal, '$options': 'i'}
        if filtro_forma_pagamento:
            filtro['Forma de Pagamento'] = {'$regex': filtro_forma_pagamento, '$options': 'i'}
        
        df_vendas = crud.buscar_pedidos(filtro)
        
        if not df_vendas.empty:
            # Buscar nomes dos clientes
            df_clientes = crud.buscar_clientes()
            
            # Tentar fazer merge - identificar colunas de ID do cliente
            try:
                # Procurar coluna de ID do cliente em vendas
                id_col_vendas = next((col for col in df_vendas.columns if 'cliente' in col.lower() and 'id' in col.lower()), None)
                id_col_clientes = next((col for col in df_clientes.columns if 'cliente' in col.lower() and 'id' in col.lower()), None)
                nome_col = next((col for col in df_clientes.columns if col.lower() == 'nome'), None)
                
                if id_col_vendas and id_col_clientes and nome_col:
                    df_vendas = df_vendas.merge(
                        df_clientes[[id_col_clientes, nome_col]], 
                        left_on=id_col_vendas,
                        right_on=id_col_clientes,
                        how='left'
                    )
                    df_vendas['nome_cliente'] = df_vendas[nome_col]
                else:
                    df_vendas['nome_cliente'] = 'N/A'
            except Exception as e:
                print(f"Erro no merge: {e}")
                df_vendas['nome_cliente'] = 'N/A'
            
            # Função para converter valor para float
            def converter_valor(val):
                try:
                    if pd.isna(val):
                        return 0.0
                    if isinstance(val, (int, float)):
                        return float(val)
                    val_str = str(val).replace('R$', '').replace('.', '').replace(',', '.').strip()
                    return float(val_str)
                except:
                    return 0.0
            
            # Preparar exibição
            st.markdown(f"**Total de vendas encontradas:** {len(df_vendas)}")
            
            # Exibir vendas
            for idx, row in df_vendas.iterrows():
                col_data, col_edit, col_delete = st.columns([8, 1, 1])
                
                # Buscar valores com nomes possíveis
                id_pedido = row.get('Id Pedido', row.get('id_pedido', 0))
                nome_cliente = row.get('nome_cliente', 'N/A')
                data_pedido = row.get('Data Pedido', row.get('data_pedido', 'N/A'))
                valor_total = row.get('Valor Total', row.get('valor_total', 0))
                forma_pag = row.get('Forma de Pagamento', row.get('forma_pagamento', 'N/A'))
                canal = row.get('Canal de Venda', row.get('canal_venda', 'N/A'))
                
                # Formatar data
                try:
                    if data_pedido != 'N/A':
                        data_formatada = pd.to_datetime(data_pedido).strftime('%d/%m/%Y')
                    else:
                        data_formatada = 'N/A'
                except:
                    data_formatada = str(data_pedido)
                
                # Formatar valor
                valor_formatado = f"R$ {converter_valor(valor_total):,.2f}".replace(",", "X").replace(".", ",").replace("X", ".")
                
                with col_data:
                    st.write(f"**Pedido #{id_pedido}** | Cliente: {nome_cliente} | {data_formatada} | {valor_formatado} | {forma_pag} | {canal}")
                
                with col_edit:
                    if st.button("✏️", key=f"edit_v_{id_pedido}", help="Editar venda"):
                        st.session_state.editing_venda = id_pedido
                
                with col_delete:
                    if st.button("🗑️", key=f"delete_v_{id_pedido}", help="Excluir venda"):
                        result = crud.excluir_pedido(id_pedido)
                        if result['success']:
                            st.success(f"✅ Venda #{id_pedido} excluída!")
                            st.rerun()
                        else:
                            st.error(f"❌ Erro: {result['error']}")
                
                # Formulário de edição
                if st.session_state.get('editing_venda') == id_pedido:
                    st.markdown("#### Editar Venda")
                    
                    venda_atual = crud.buscar_pedido_por_id(id_pedido)
                    
                    if venda_atual is None:
                        st.error("❌ Venda não encontrada!")
                        st.session_state.editing_venda = None
                        st.rerun()
                    
                    with st.form(f"form_edit_v_{id_pedido}"):
                        # Função auxiliar para converter valor
                        def converter_valor_edit(val):
                            try:
                                if isinstance(val, (int, float)):
                                    return float(val)
                                val_str = str(val).replace('R$', '').replace('.', '').replace(',', '.').strip()
                                return float(val_str)
                            except:
                                return 0.0
                        
                        col1, col2 = st.columns(2)
                        
                        with col1:
                            # Buscar data com ambos os nomes possíveis
                            data_atual = venda_atual.get('Data Pedido', venda_atual.get('data_pedido', pd.Timestamp.now()))
                            edit_data = st.date_input("Data", value=pd.to_datetime(data_atual))
                            
                            # Buscar canal com ambos os nomes possíveis
                            canal_atual = venda_atual.get('Canal de Venda', venda_atual.get('canal_venda', 'Site'))
                            opcoes_canal = ["Site", "Loja Física", "WhatsApp", "Instagram", "Marketplace"]
                            edit_canal = st.selectbox("Canal", 
                                                     options=opcoes_canal,
                                                     index=opcoes_canal.index(canal_atual) if canal_atual in opcoes_canal else 0)
                        
                        with col2:
                            # Buscar valor com ambos os nomes possíveis
                            valor_atual = venda_atual.get('Valor Total', venda_atual.get('valor_total', 0))
                            edit_valor = st.number_input("Valor Total (R$)", 
                                                        value=converter_valor_edit(valor_atual), 
                                                        min_value=0.0, step=0.01, format="%.2f")
                            
                            # Buscar forma de pagamento com ambos os nomes possíveis
                            forma_atual = venda_atual.get('Forma de Pagamento', venda_atual.get('forma_pagamento', 'Pix'))
                            opcoes_pagamento = ["Pix", "Cartão Crédito", "Cartão Débito", "Boleto", "Dinheiro"]
                            edit_forma_pagamento = st.selectbox("Forma de Pagamento",
                                                               options=opcoes_pagamento,
                                                               index=opcoes_pagamento.index(forma_atual) if forma_atual in opcoes_pagamento else 0)
                        
                        col_submit, col_cancel = st.columns([1, 1])
                        
                        with col_submit:
                            submit_btn = st.form_submit_button("✅ Salvar", use_container_width=True)
                        
                        with col_cancel:
                            cancel_btn = st.form_submit_button("❌ Cancelar", use_container_width=True)
                        
                        if submit_btn:
                            dados_atualizados = {
                                'data_pedido': edit_data.strftime('%Y-%m-%d'),
                                'valor_total': edit_valor,
                                'forma_pagamento': edit_forma_pagamento,
                                'canal_venda': edit_canal
                            }
                            
                            result = crud.atualizar_pedido(id_pedido, dados_atualizados)
                            
                            if result['success']:
                                st.success("✅ Venda atualizada!")
                                st.session_state.editing_venda = None
                                st.rerun()
                            else:
                                st.error(f"❌ Erro: {result['error']}")
                        
                        if cancel_btn:
                            st.session_state.editing_venda = None
                            st.rerun()
                
                st.markdown("---")
        
        else:
            st.info("❌ Nenhuma venda encontrada.")
    
    except Exception as e:
        st.error(f"❌ Erro ao carregar vendas: {str(e)}")
        st.info("💡 Dica: Verifique a conexão com o MongoDB")

# ==================== TAB: DASHBOARD ====================
with tab_dashboard:
    st.markdown("### Análises de Vendas")
    st.markdown("<div class='chart-container'>", unsafe_allow_html=True)

    try:
        # Buscar dados para KPIs
        from Dados.analises import AnaliseDados
        analise = AnaliseDados()
        totais = analise.analise_total_vendas_geral()
        
        # KPIs Totais em cards individuais
        st.markdown("#### Indicadores Principais")
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
                "Itens Vendidos",
                f"{totais['total_itens_vendidos']:,}"
            ), unsafe_allow_html=True)
        
        st.markdown("<br>", unsafe_allow_html=True)
        
        # Vendas por ano
        st.markdown("<div class='chart-container'>", unsafe_allow_html=True)
        st.markdown("#### Evolução de Vendas por Ano")
        load_chart("vendas_ano.html", height=500)
        st.markdown("</div>", unsafe_allow_html=True)
        st.markdown("<div class='chart-container'>", unsafe_allow_html=True)

        col1, col2 = st.columns(2)
        
        with col1:
            
            st.markdown("#### Vendas por Canal")
            load_chart("vendas_canal.html", height=400)
            st.markdown("</div>", unsafe_allow_html=True)
        
        with col2:
            
            st.markdown("#### Vendas por Forma de Pagamento")
            load_chart("vendas_forma_pagamento.html", height=400)
            st.markdown("</div>", unsafe_allow_html=True)
        
        # Sazonalidade heatmap
        st.markdown("<div class='chart-container'>", unsafe_allow_html=True)
        st.markdown("#### Heatmap de Sazonalidade")
        load_chart("sazonalidade_heatmap.html", height=500)
        st.markdown("</div>", unsafe_allow_html=True)
    
    except Exception as e:
        st.error(f"❌ Erro ao carregar dashboard de vendas: {str(e)}")
        st.info("💡 Verifique se há dados de vendas/pedidos no banco de dados")
