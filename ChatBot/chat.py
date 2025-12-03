# ================= 1 request =================
import requests
import json
from pprint import pprint


AGENT_ID = 'conectabeauty-analytics-agent'
ENDPOINT = f'http://127.0.0.3:9999/agents/{AGENT_ID}/runs'

# =================== 2 - conexão com o agno (SERVER) ===================
def get_response_stream(message: str):
    """Envia mensagem para o agente e recebe resposta em streaming"""
    response = requests.post(
        url=ENDPOINT,
        data={  
            'message': message,
            'stream': 'true'  
        },
        stream=True
    )
    
    # Verificar se houve erro
    if response.status_code != 200:
        print(f"❌ Erro {response.status_code}: {response.text}")
        return None
    
    # 2.1 - Processar resposta em streaming
    for line in response.iter_lines():
        if line:
            if line.startswith(b'data: '):
                data = line[6:]
                try: 
                    event = json.loads(data)
                    yield event
                except json.JSONDecodeError:
                    continue

# =================== 3 - Printa a resposta ===================
"""
RunStarted
ToolCallStarted
ToolCallCompleted
RunContent
RunContentCompleted
RunCompleted
"""
def print_response_stream(response):
   for event in get_response_stream(message):
       event_type = event.get("event", "")
       if event_type == "RunStarted":
           print("Iniciando execução do agente...") 
       elif event_type == "RunContent":
           content = event.get("content", "")
           if content:
               print(content, end='', flush=True)
       elif event_type == "ToolCallStarted":
           tool = event.get("Tool Calls", {})
           tool_name = tool.get("Name", "unknown")
           tool_args = tool.get("args", {})
           print(f"Tool iniciada: {tool_name}")
           print(f'Argumentos: {json.dumps(tool_args, indent=2)}')
       elif event_type == "ToolCallCompleted":
           tool_name = event.get("tool", {}).get("Name")
           print(f"Tool concluída: {tool_name}")
       elif event_type == "RunCompleted":
              print("\nExecução do agente concluída.")
              metrics = event.get("metrics", {})
              if metrics:
                  print(f"Metricas: {json.dumps(metrics, indent=2)}")
           

           
    

# =================== 4 - Run ===================
if __name__ == "__main__":
   message = input("Digite sua pergunta para o agente: ")
   print_response_stream(message)
   while True:
    message = input("Digite sua pergunta para o agente: ")
    print_response_stream(message)