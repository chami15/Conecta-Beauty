"""
Operações CRUD para MongoDB
Gerencia inserção, atualização, exclusão e busca de dados
"""
from Dados.mongo import db
from datetime import datetime
import pandas as pd


class CRUDOperations:
    """Classe para operações CRUD no MongoDB"""
    
    def __init__(self):
        self.db = db
    
    # ==================== CLIENTES ====================
    
    def adicionar_cliente(self, nome, sexo, cidade, estado, telefone):
        """Adiciona novo cliente ao banco"""
        try:
            # Gerar próximo ID
            ultimo_cliente = self.db.Clientes.find_one(sort=[("id_cliente", -1)])
            proximo_id = (ultimo_cliente['id_cliente'] + 1) if ultimo_cliente else 1
            
            cliente = {
                "id_cliente": proximo_id,
                "nome": nome,
                "sexo": sexo,
                "cidade": cidade,
                "estado2": estado,
                "telefone": telefone,
                "data_cadastro": datetime.now()
            }
            result = self.db.Clientes.insert_one(cliente)
            return {"success": True, "id": proximo_id}
        except Exception as e:
            return {"success": False, "error": str(e)}
    
    def atualizar_cliente(self, id_cliente, dados):
        """Atualiza dados de um cliente"""
        try:
            if isinstance(id_cliente, str):
                id_cliente = int(id_cliente)
            
            result = self.db.Clientes.update_one(
                {"id_cliente": id_cliente},
                {"$set": dados}
            )
            return {"success": True, "modified": result.modified_count}
        except Exception as e:
            return {"success": False, "error": str(e)}
    
    def excluir_cliente(self, id_cliente):
        """Exclui um cliente do banco"""
        try:
            if isinstance(id_cliente, str):
                id_cliente = int(id_cliente)
            
            result = self.db.Clientes.delete_one({"id_cliente": id_cliente})
            return {"success": True, "deleted": result.deleted_count}
        except Exception as e:
            return {"success": False, "error": str(e)}
    
    def buscar_clientes(self, filtro=None):
        """Busca clientes com filtro opcional"""
        try:
            query = filtro if filtro else {}
            clientes = list(self.db.Clientes.find(query))
            df = pd.DataFrame(clientes)
            if not df.empty and '_id' in df.columns:
                df = df.drop('_id', axis=1)
            return df
        except Exception as e:
            print(f"Erro ao buscar clientes: {e}")
            return pd.DataFrame()
    
    def buscar_cliente_por_id(self, id_cliente):
        """Busca um cliente específico por ID"""
        try:
            if isinstance(id_cliente, str):
                id_cliente = int(id_cliente)
            
            cliente = self.db.Clientes.find_one({"id_cliente": id_cliente})
            return cliente
        except Exception as e:
            print(f"Erro ao buscar cliente: {e}")
            return None
    
    # ==================== PRODUTOS ====================
    
    def adicionar_produto(self, nome_produto, categoria, fornecedor, valor_unitario):
        """Adiciona novo produto ao banco"""
        try:
            # Gerar próximo ID - tentar ambos os nomes de coluna
            ultimo_produto = self.db.Produtos.find_one(sort=[("Id Produto", -1)])
            if ultimo_produto is None:
                ultimo_produto = self.db.Produtos.find_one(sort=[("id_produto", -1)])
            
            if ultimo_produto:
                proximo_id = ultimo_produto.get('Id Produto', ultimo_produto.get('id_produto', 0)) + 1
            else:
                proximo_id = 1
            
            produto = {
                "Id Produto": proximo_id,
                "Nome Produto": nome_produto,
                "Categoria Produto": categoria,
                "Fornecedor": fornecedor,
                "Valor Unitário": float(valor_unitario),
                "data_cadastro": datetime.now()
            }
            result = self.db.Produtos.insert_one(produto)
            return {"success": True, "id": proximo_id}
        except Exception as e:
            return {"success": False, "error": str(e)}
    
    def atualizar_produto(self, id_produto, dados):
        """Atualiza dados de um produto"""
        try:
            if isinstance(id_produto, str):
                id_produto = int(id_produto)
            
            # Mapear nomes de campos para o formato do banco
            dados_banco = {}
            if 'nome_produto' in dados:
                dados_banco['Nome Produto'] = dados['nome_produto']
            if 'categoria' in dados:
                dados_banco['Categoria Produto'] = dados['categoria']
            if 'fornecedor' in dados:
                dados_banco['Fornecedor'] = dados['fornecedor']
            if 'valor_unitario' in dados:
                dados_banco['Valor Unitário'] = float(dados['valor_unitario'])
            
            # Tentar atualizar com ambos os nomes de coluna ID
            result = self.db.Produtos.update_one(
                {"Id Produto": id_produto},
                {"$set": dados_banco}
            )
            
            # Se não encontrou, tentar com o nome alternativo
            if result.matched_count == 0:
                result = self.db.Produtos.update_one(
                    {"id_produto": id_produto},
                    {"$set": dados_banco}
                )
            
            return {"success": True, "modified": result.modified_count}
        except Exception as e:
            return {"success": False, "error": str(e)}
    
    def excluir_produto(self, id_produto):
        """Exclui um produto do banco"""
        try:
            if isinstance(id_produto, str):
                id_produto = int(id_produto)
            
            # Tentar excluir com o nome correto do banco
            result = self.db.Produtos.delete_one({"Id Produto": id_produto})
            
            # Se não encontrou, tentar com o nome alternativo
            if result.deleted_count == 0:
                result = self.db.Produtos.delete_one({"id_produto": id_produto})
            
            return {"success": True, "deleted": result.deleted_count}
        except Exception as e:
            return {"success": False, "error": str(e)}
    
    def buscar_produtos(self, filtro=None):
        """Busca produtos com filtro opcional"""
        try:
            query = filtro if filtro else {}
            produtos = list(self.db.Produtos.find(query))
            df = pd.DataFrame(produtos)
            if not df.empty and '_id' in df.columns:
                df = df.drop('_id', axis=1)
            return df
        except Exception as e:
            print(f"Erro ao buscar produtos: {e}")
            return pd.DataFrame()
    
    def buscar_produto_por_id(self, id_produto):
        """Busca um produto específico por ID"""
        try:
            if isinstance(id_produto, str):
                id_produto = int(id_produto)
            
            # Tentar primeiro com o nome usado no banco (Id Produto)
            produto = self.db.Produtos.find_one({"Id Produto": id_produto})
            
            # Se não encontrar, tentar com o nome alternativo (id_produto)
            if produto is None:
                produto = self.db.Produtos.find_one({"id_produto": id_produto})
            
            return produto
        except Exception as e:
            print(f"Erro ao buscar produto: {e}")
            return None
    
    # ==================== PEDIDOS ====================
    
    def adicionar_pedido(self, id_cliente, data_pedido, valor_total, forma_pagamento, canal_venda):
        """Adiciona novo pedido ao banco"""
        try:
            # Gerar próximo ID - tentar ambos os nomes
            ultimo_pedido = self.db.Pedidos.find_one(sort=[("Id Pedido", -1)])
            if ultimo_pedido is None:
                ultimo_pedido = self.db.Pedidos.find_one(sort=[("id_pedido", -1)])
            
            if ultimo_pedido:
                proximo_id = ultimo_pedido.get('Id Pedido', ultimo_pedido.get('id_pedido', 0)) + 1
            else:
                proximo_id = 1
            
            pedido = {
                "Id Pedido": proximo_id,
                "Id Cliente": int(id_cliente),
                "Data Pedido": data_pedido,
                "Valor Total": float(valor_total),
                "Forma de Pagamento": forma_pagamento,
                "Canal de Venda": canal_venda
            }
            result = self.db.Pedidos.insert_one(pedido)
            return {"success": True, "id": proximo_id}
        except Exception as e:
            return {"success": False, "error": str(e)}
    
    def atualizar_pedido(self, id_pedido, dados):
        """Atualiza dados de um pedido"""
        try:
            if isinstance(id_pedido, str):
                id_pedido = int(id_pedido)
            
            # Mapear nomes de campos para o formato do banco
            dados_banco = {}
            if 'id_cliente' in dados:
                dados_banco['Id Cliente'] = int(dados['id_cliente'])
            if 'data_pedido' in dados:
                dados_banco['Data Pedido'] = dados['data_pedido']
            if 'valor_total' in dados:
                dados_banco['Valor Total'] = float(dados['valor_total'])
            if 'forma_pagamento' in dados:
                dados_banco['Forma de Pagamento'] = dados['forma_pagamento']
            if 'canal_venda' in dados:
                dados_banco['Canal de Venda'] = dados['canal_venda']
            
            # Tentar atualizar com o nome correto
            result = self.db.Pedidos.update_one(
                {"Id Pedido": id_pedido},
                {"$set": dados_banco}
            )
            
            # Se não encontrou, tentar com o nome alternativo
            if result.matched_count == 0:
                result = self.db.Pedidos.update_one(
                    {"id_pedido": id_pedido},
                    {"$set": dados_banco}
                )
            
            return {"success": True, "modified": result.modified_count}
        except Exception as e:
            return {"success": False, "error": str(e)}
    
    def excluir_pedido(self, id_pedido):
        """Exclui um pedido do banco"""
        try:
            if isinstance(id_pedido, str):
                id_pedido = int(id_pedido)
            
            # Tentar excluir com o nome correto do banco
            result = self.db.Pedidos.delete_one({"Id Pedido": id_pedido})
            
            # Se não encontrou, tentar com o nome alternativo
            if result.deleted_count == 0:
                result = self.db.Pedidos.delete_one({"id_pedido": id_pedido})
            
            return {"success": True, "deleted": result.deleted_count}
        except Exception as e:
            return {"success": False, "error": str(e)}
    
    def buscar_pedidos(self, filtro=None):
        """Busca pedidos com filtro opcional"""
        try:
            query = filtro if filtro else {}
            pedidos = list(self.db.Pedidos.find(query))
            df = pd.DataFrame(pedidos)
            if not df.empty and '_id' in df.columns:
                df = df.drop('_id', axis=1)
            return df
        except Exception as e:
            print(f"Erro ao buscar pedidos: {e}")
            return pd.DataFrame()
    
    def buscar_pedido_por_id(self, id_pedido):
        """Busca um pedido específico por ID"""
        try:
            if isinstance(id_pedido, str):
                id_pedido = int(id_pedido)
            
            # Tentar primeiro com o nome usado no banco (Id Pedido)
            pedido = self.db.Pedidos.find_one({"Id Pedido": id_pedido})
            
            # Se não encontrar, tentar com o nome alternativo
            if pedido is None:
                pedido = self.db.Pedidos.find_one({"id_pedido": id_pedido})
            
            return pedido
        except Exception as e:
            print(f"Erro ao buscar pedido: {e}")
            return None
    
    # ==================== VENDAS ====================
    
    def adicionar_venda(self, id_pedido, id_produto, id_cor, quantidade, subtotal):
        """Adiciona nova venda ao banco"""
        try:
            # Gerar próximo ID
            ultima_venda = self.db.Vendas.find_one(sort=[("id_venda", -1)])
            proximo_id = (ultima_venda['id_venda'] + 1) if ultima_venda else 1
            
            venda = {
                "id_venda": proximo_id,
                "id_pedido": int(id_pedido),
                "id_produto": int(id_produto),
                "id_cor": int(id_cor),
                "quantidade": int(quantidade),
                "subtotal": float(subtotal)
            }
            result = self.db.Vendas.insert_one(venda)
            return {"success": True, "id": proximo_id}
        except Exception as e:
            return {"success": False, "error": str(e)}
    
    def atualizar_venda(self, id_venda, dados):
        """Atualiza dados de uma venda"""
        try:
            if isinstance(id_venda, str):
                id_venda = int(id_venda)
            
            # Converter tipos numéricos
            for campo in ['id_pedido', 'id_produto', 'id_cor', 'quantidade']:
                if campo in dados:
                    dados[campo] = int(dados[campo])
            
            if 'subtotal' in dados:
                dados['subtotal'] = float(dados['subtotal'])
            
            result = self.db.Vendas.update_one(
                {"id_venda": id_venda},
                {"$set": dados}
            )
            return {"success": True, "modified": result.modified_count}
        except Exception as e:
            return {"success": False, "error": str(e)}
    
    def excluir_venda(self, id_venda):
        """Exclui uma venda do banco"""
        try:
            if isinstance(id_venda, str):
                id_venda = int(id_venda)
            
            result = self.db.Vendas.delete_one({"id_venda": id_venda})
            return {"success": True, "deleted": result.deleted_count}
        except Exception as e:
            return {"success": False, "error": str(e)}
    
    def buscar_vendas(self, filtro=None):
        """Busca vendas com filtro opcional"""
        try:
            query = filtro if filtro else {}
            vendas = list(self.db.Vendas.find(query))
            df = pd.DataFrame(vendas)
            if not df.empty and '_id' in df.columns:
                df = df.drop('_id', axis=1)
            return df
        except Exception as e:
            print(f"Erro ao buscar vendas: {e}")
            return pd.DataFrame()
    
    # ==================== CORES ====================
    
    def buscar_cores(self):
        """Busca todas as cores disponíveis"""
        try:
            cores = list(self.db.CorProduto.find())
            df = pd.DataFrame(cores)
            if not df.empty and '_id' in df.columns:
                df = df.drop('_id', axis=1)
            return df
        except Exception as e:
            print(f"Erro ao buscar cores: {e}")
            return pd.DataFrame()
