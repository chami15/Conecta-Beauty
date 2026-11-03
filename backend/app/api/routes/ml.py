from fastapi import APIRouter, HTTPException, Query
from app.ml import predictor
from app.ml.treinar import treinar_modelo as _treinar_modelo
from app.ml import kmeans

router = APIRouter(prefix="/api/ml", tags=["Machine Learning"])


# ------------------------- MLP: previsão de faturamento -------------------------
@router.get("/status")
def status_modelo():
    """Verifica se o modelo MLP treinado está disponível."""
    disponivel = predictor.modelo_disponivel()
    return {
        "modelo_disponivel": disponivel,
        "mensagem": "Modelo pronto para previsões." if disponivel
        else "Modelo não treinado. Execute POST /api/ml/treinar primeiro.",
    }


@router.post("/treinar")
def treinar_modelo():
    """Treina (ou re-treina) o MLPRegressor com os dados atuais do banco."""
    try:
        resultado = _treinar_modelo()
        predictor.recarregar()
        return resultado
    except ValueError as e:
        raise HTTPException(422, str(e))
    except Exception as e:
        raise HTTPException(500, str(e))


@router.get("/previsao")
def previsao_faturamento(
    horizonte: int = Query(3, ge=1, le=12, description="Meses à frente para prever"),
):
    """Retorna a previsão de faturamento para os próximos N meses usando MLP."""
    try:
        return predictor.prever(horizonte=horizonte)
    except FileNotFoundError as e:
        raise HTTPException(404, str(e))
    except Exception as e:
        raise HTTPException(500, str(e))


# ------------------------- K-Means: segmentação de pedidos ----------------------
@router.get("/kmeans/status")
def status_kmeans():
    """Verifica conexão, tabela de pedidos e disponibilidade do modelo K-Means."""
    return kmeans.status_kmeans_banco()


@router.post("/kmeans/treinar")
def treinar_kmeans(
    n_clusters: int = Query(4, ge=2, le=10, description="Quantidade de grupos"),
):
    """Treina K-Means com os pedidos disponíveis na tabela ml.pedidos_padronizados."""
    try:
        resultado = kmeans.treinar_kmeans_banco(n_clusters=n_clusters)
        # A resposta do treino inclui a classificação de todos os pedidos.
        return resultado
    except (ValueError, TypeError) as e:
        raise HTTPException(422, str(e))
    except ConnectionError as e:
        raise HTTPException(503, str(e))
    except Exception as e:
        raise HTTPException(500, f"Erro ao treinar K-Means: {e}")


@router.get("/kmeans/resultados")
def resultados_kmeans(
    offset: int = Query(0, ge=0, description="Índice inicial da página de pedidos"),
    limite: int = Query(1000, ge=1, le=1000, description="Máximo de pedidos retornados (1 a 1000)"),
):
    """Retorna resumo dos grupos e uma página com pedido_id/cluster."""
    try:
        return kmeans.consultar_resultados_banco(offset=offset, limite=limite)
    except FileNotFoundError as e:
        raise HTTPException(404, str(e))
    except (ValueError, TypeError) as e:
        raise HTTPException(422, str(e))
    except ConnectionError as e:
        raise HTTPException(503, str(e))
    except Exception as e:
        raise HTTPException(500, f"Erro ao consultar K-Means: {e}")