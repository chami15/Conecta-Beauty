"""
Acesso padronizado a um container do Data Lake (ADLS Gen2) ou a uma pasta local.

Os scripts de carga usam a mesma interface nos dois casos: o Data Lake e o uso
normal; a pasta local serve para testar sem rede e para rodar com o arquivo
gerado em scripts/seed/output.
"""
import os
from pathlib import Path


class Armazenamento:
    def listar(self, prefixo: str, sufixo: str) -> list[str]:
        raise NotImplementedError

    def ler(self, caminho: str) -> bytes:
        raise NotImplementedError

    def gravar(self, caminho: str, dados: bytes) -> None:
        raise NotImplementedError


class ArmazenamentoLocal(Armazenamento):
    def __init__(self, pasta):
        self.pasta = Path(pasta)

    def listar(self, prefixo, sufixo):
        base = self.pasta / prefixo
        if not base.exists():
            return []
        return sorted(
            str(p.relative_to(self.pasta)).replace(os.sep, "/")
            for p in base.rglob("*") if p.is_file() and p.name.endswith(sufixo)
        )

    def ler(self, caminho):
        return (self.pasta / caminho).read_bytes()

    def gravar(self, caminho, dados):
        destino = self.pasta / caminho
        destino.parent.mkdir(parents=True, exist_ok=True)
        destino.write_bytes(dados)


class ArmazenamentoLake(Armazenamento):
    def __init__(self, container: str):
        from azure.storage.filedatalake import DataLakeServiceClient

        connection_string = os.getenv("DATALAKE_CONNECTION_STRING")
        if not connection_string:
            raise RuntimeError("DATALAKE_CONNECTION_STRING nao configurada no .env")
        servico = DataLakeServiceClient.from_connection_string(connection_string)
        self.container = servico.get_file_system_client(container)

    def listar(self, prefixo, sufixo):
        return sorted(
            p.name for p in self.container.get_paths(path=prefixo, recursive=True)
            if not p.is_directory and p.name.endswith(sufixo)
        )

    def ler(self, caminho):
        return self.container.get_file_client(caminho).download_file().readall()

    def gravar(self, caminho, dados):
        arquivo = self.container.get_file_client(caminho)
        arquivo.create_file()
        arquivo.append_data(dados, offset=0, length=len(dados))
        arquivo.flush_data(len(dados))


def abrir(container: str, pasta_local: str | None) -> Armazenamento:
    """Pasta local se informada, senao o container do Data Lake."""
    return ArmazenamentoLocal(pasta_local) if pasta_local else ArmazenamentoLake(container)
