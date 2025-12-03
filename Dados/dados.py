import streamlit as st
from pymongo import MongoClient
from dotenv import load_dotenv
import os
import pandas as pd

# ---- Carregar variáveis de ambiente ----
load_dotenv()
MONGO_URI = os.getenv("MONGO_URI")
DB_NAME = os.getenv("DB_NAME")

# ---- Função para conectar ao MongoDB ----
@st.cache_resource
def conectar_mongo():
    client = MongoClient(MONGO_URI)
    db = client[DB_NAME]
    return db

# ---- Conectar ----
db = conectar_mongo()
colecao = db["Clientes"]  # troque para o nome da sua coleção

# ---- Interface Streamlit ----
st.title("📊 Visualização de Dados - MongoDB + Streamlit")

# Botão para atualizar os dados
if st.button("🔄 Atualizar dados"):
    st.cache_data.clear()

# Função para buscar dados do MongoDB
@st.cache_data
def buscar_dados():
    dados = list(colecao.find({}, {"_id": 0}))  # Ignora o campo _id
    return pd.DataFrame(dados)

# Mostrar os dados
df = buscar_dados()

if df.empty:
    st.warning("Nenhum dado encontrado na coleção.")
else:
    st.subheader("👥 Usuários cadastrados:")
    st.dataframe(df, use_container_width=True)

    # Estatísticas simples
    if "idade" in df.columns:
        st.subheader("📈 Estatísticas:")
        st.write(df["idade"].describe())
