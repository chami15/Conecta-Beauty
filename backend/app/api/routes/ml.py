from fastapi import APIRouter, HTTPException, Query
from app.ml import predictor
from app.ml.treinar import treinar_modelo as _treinar_modelo

router = APIRouter(prefix="/api/ml", tags=["Machine Learning"])


@router.get("/status")
def status_modelo():
    """Verifica se o modelo treinado está disponível."""
    disponivel = predictor.modelo_disponivel()
    return {
        "modelo_disponivel": disponivel,
        "mensagem": (
            "Modelo pronto para previsões."
            if disponivel
            else "Modelo não treinado. Execute POST /api/ml/treinar primeiro."
        ),
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
    """
    Retorna a previsão de faturamento para os próximos N meses
    usando o MLPRegressor treinado, junto com o histórico real.
    """
    try:
        return predictor.prever(horizonte=horizonte)
    except FileNotFoundError as e:
        raise HTTPException(404, str(e))
    except Exception as e:
        raise HTTPException(500, str(e))
