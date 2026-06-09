import { useState } from "react";
import { I } from "../components/icons";
import { Card, useApi, LoadingState, ErrorState, fmt } from "../components/ui";
import { MLForecastChart } from "../components/ChartComponents";
import { api } from "../api";

export default function ScreenML() {
  const [horizonte, setHorizonte] = useState(3);
  const [treinando, setTreinando] = useState(false);
  const [trainResult, setTrainResult] = useState(null);
  const [trainError, setTrainError] = useState(null);

  const status = useApi(() => api.ml.status(), []);
  const previsao = useApi(() => api.ml.previsao(horizonte), [horizonte]);

  const treinar = async () => {
    setTreinando(true);
    setTrainResult(null);
    setTrainError(null);
    try {
      const result = await api.ml.treinar();
      setTrainResult(result);
      status.reload();
      previsao.reload();
    } catch (e) {
      setTrainError(e.message);
    } finally {
      setTreinando(false);
    }
  };

  /* Forecast data */
  const prev = previsao.data || {};
  const histLabels = (prev.historico || []).map((item) => `${item.nome_mes}/${item.ano}`);
  const prevLabels = (prev.previsoes || []).map((item) => `${item.nome_mes}/${item.ano}`);
  const allLabels = [...histLabels, ...prevLabels];

  const histVals = (prev.historico || []).map((item) => item.faturamento_real ?? 0);
  const prevVals = (prev.previsoes || []).map((item) => item.faturamento_previsto ?? 0);
  const historicoPadded = [...histVals, ...Array(prevVals.length).fill(null)];
  const previsaoPadded = [...Array(histVals.length).fill(null), ...prevVals];

  return (
    <div className="screen-pad screen-anim">
      <div className="screen-header">
        <div>
          <div className="screen-eyebrow">06 · Machine Learning</div>
          <div className="screen-title">Previsão de faturamento</div>
        </div>
        <div className="row" style={{ gap: 8 }}>
          <select value={horizonte} onChange={(e) => setHorizonte(Number(e.target.value))}
            style={{ padding: "7px 12px", border: "1px solid var(--line)", borderRadius: "var(--r)", fontSize: 13, color: "var(--fg)", background: "#fff" }}>
            {[1, 2, 3, 6, 12].map((h) => <option key={h} value={h}>{h} {h === 1 ? "mês" : "meses"}</option>)}
          </select>
          <button className="btn primary" onClick={treinar} disabled={treinando} style={{ minWidth: 140 }}>
            {treinando ? <><div className="spinner" style={{ width: 14, height: 14, borderWidth: 2 }} /> Treinando...</> : <><I.refresh size={13} /> Re-treinar modelo</>}
          </button>
        </div>
      </div>

      {/* Status card */}
      <div style={{ marginBottom: 16 }}>
        {status.loading ? <LoadingState label="Verificando modelo..." /> : (
          <div className="ml-status-card">
            <div className="ml-status-dot" style={{ background: status.data?.modelo_disponivel ? "var(--pos)" : "var(--neg)" }} />
            <div style={{ flex: 1 }}>
              <div style={{ fontSize: 13, fontWeight: 600, color: "var(--fg)" }}>
                {status.data?.modelo_disponivel ? "Modelo disponível e pronto" : "Modelo não treinado"}
              </div>
              <div style={{ fontSize: 12, color: "var(--fg-3)", marginTop: 2 }}>
                {status.data?.mensagem ?? "—"}
              </div>
            </div>
            {!status.data?.modelo_disponivel && (
              <button className="btn primary" onClick={treinar} disabled={treinando}>
                <I.cpu size={13} /> Treinar agora
              </button>
            )}
          </div>
        )}
      </div>

      {/* Train result / error */}
      {trainError && (
        <div className="error-state" style={{ marginBottom: 16 }}>
          <I.alert size={14} /> Erro no treinamento: {trainError}
        </div>
      )}
      {trainResult && (
        <div style={{ marginBottom: 16, padding: "14px 16px", background: "var(--pos-bg)", border: "1px solid var(--pos)", borderRadius: "var(--r)", fontSize: 13, color: "var(--pos)" }}>
          <strong>Modelo treinado com sucesso!</strong>
          {trainResult.rmse_cv !== undefined && <span style={{ marginLeft: 12, color: "var(--fg-3)" }}>RMSE CV: {trainResult.rmse_cv.toFixed(2)}</span>}
          {trainResult.mae_cv !== undefined && <span style={{ marginLeft: 12, color: "var(--fg-3)" }}>MAE CV: {trainResult.mae_cv.toFixed(2)}</span>}
        </div>
      )}

      {/* Forecast chart */}
      <div className="grid grid-12" style={{ marginBottom: 16 }}>
        <div className="col-8">
          <Card title="Previsão de faturamento" sub={`PRÓXIMOS ${horizonte} ${horizonte === 1 ? "MÊS" : "MESES"} · MLPREGRESSOR`}>
            {previsao.loading ? <LoadingState label="Gerando previsão..." /> : previsao.error ? (
              <div>
                <ErrorState msg={previsao.error} />
                <p style={{ marginTop: 12, fontSize: 13, color: "var(--fg-3)" }}>
                  Treine o modelo primeiro usando o botão "Re-treinar modelo".
                </p>
              </div>
            ) : allLabels.length > 0 ? (
              <>
                <MLForecastChart
                  labels={allLabels}
                  historico={historicoPadded}
                  previsao={previsaoPadded}
                  height={300}
                />
                {/* Previsão summary */}
                {prevVals.length > 0 && (
                  <div className="row" style={{ gap: 16, marginTop: 16, paddingTop: 16, borderTop: "1px solid var(--line)" }}>
                    <div style={{ flex: 1 }}>
                      <div className="mono" style={{ fontSize: 10, color: "var(--fg-3)", textTransform: "uppercase", letterSpacing: "0.16em", fontWeight: 600 }}>Próximo mês</div>
                      <div style={{ fontSize: 20, fontWeight: 700, color: "var(--warn)", marginTop: 4 }}>{fmt.brl(prevVals[0])}</div>
                    </div>
                    {prevVals.length > 1 && (
                      <div style={{ flex: 1 }}>
                        <div className="mono" style={{ fontSize: 10, color: "var(--fg-3)", textTransform: "uppercase", letterSpacing: "0.16em", fontWeight: 600 }}>Pico previsto</div>
                        <div style={{ fontSize: 20, fontWeight: 700, color: "var(--warn)", marginTop: 4 }}>{fmt.brl(Math.max(...prevVals))}</div>
                      </div>
                    )}
                    <div style={{ flex: 1 }}>
                      <div className="mono" style={{ fontSize: 10, color: "var(--fg-3)", textTransform: "uppercase", letterSpacing: "0.16em", fontWeight: 600 }}>Média prevista</div>
                      <div style={{ fontSize: 20, fontWeight: 700, color: "var(--warn)", marginTop: 4 }}>
                        {fmt.brl(prevVals.reduce((a, b) => a + b, 0) / prevVals.length)}
                      </div>
                    </div>
                  </div>
                )}
              </>
            ) : (
              <div className="empty-state">
                <I.brain size={40} style={{ opacity: 0.3 }} />
                <p>Treine o modelo para ver as previsões.</p>
              </div>
            )}
          </Card>
        </div>

        <div className="col-4">
          <Card title="Sobre o modelo" sub="MLPREGRESSOR · SCIKIT-LEARN">
            <div className="stack" style={{ gap: 12 }}>
              <InfoRow label="Algoritmo" value="MLP Regressor (rede neural)" />
              <InfoRow label="Camadas" value="64 → 32 neurônios" />
              <InfoRow label="Features" value="Lags (3), mês sin/cos, tempo" />
              <InfoRow label="Validação" value="TimeSeriesSplit (5 folds)" />
              <InfoRow label="Escalonamento" value="StandardScaler" />
              <InfoRow label="Horizonte" value={`${horizonte} ${horizonte === 1 ? "mês" : "meses"}`} />

              <div style={{ padding: "10px 12px", background: "var(--bg-1)", borderRadius: 6, marginTop: 4 }}>
                <div style={{ fontSize: 11, color: "var(--fg-3)", lineHeight: 1.6 }}>
                  O modelo usa os últimos 3 meses (lags), além de features cíclicas de sazonalidade (sin/cos do mês) e índice de tempo normalizado para aprender a tendência.
                </div>
              </div>
            </div>
          </Card>

          {/* Previsão por mês */}
          {prevVals.length > 0 && (
            <Card title="Previsão mensal" sub={`${horizonte} MESES À FRENTE`} style={{ marginTop: 16 }}>
              <div className="stack" style={{ gap: 8 }}>
                {prevVals.map((v, i) => (
                  <div key={i} className="row between" style={{ fontSize: 13 }}>
                    <span style={{ color: "var(--fg-3)" }}>{prevLabels[i] || `Mês +${i + 1}`}</span>
                    <span className="mono" style={{ color: "var(--warn)", fontWeight: 700 }}>{fmt.brl(v)}</span>
                  </div>
                ))}
              </div>
            </Card>
          )}
        </div>
      </div>
    </div>
  );
}

function InfoRow({ label, value }) {
  return (
    <div className="row between" style={{ fontSize: 12 }}>
      <span style={{ color: "var(--fg-3)" }}>{label}</span>
      <span style={{ color: "var(--fg)", fontWeight: 500 }}>{value}</span>
    </div>
  );
}
