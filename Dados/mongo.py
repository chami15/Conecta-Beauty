from pymongo import MongoClient

# Substitua pela sua URI
uri = "mongodb+srv://conectabeauty1:conecta123@conectabeauty.kdivkqt.mongodb.net/?"

try:
    client = MongoClient(uri)
    client.admin.command('ping')  # comando para testar a conexão
    print("✅ Conexão com o MongoDB bem-sucedida!")
except Exception as e:
    print("❌ Erro ao conectar:", e)


import os
from dotenv import load_dotenv

load_dotenv()

client = MongoClient(os.getenv("MONGO_URI"))
db = client[os.getenv("DB_NAME")]

print("Coleções disponíveis:")
print(db.list_collection_names())



