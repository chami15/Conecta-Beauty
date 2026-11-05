import { useState } from "react";
import { I } from "../components/icons";
import { Card, useApi, LoadingState, ErrorState, fmt } from "../components/ui";
import { BarChart } from "../components/ChartComponents";
import { api } from "../api";

const CORES = ["#5b8eff", "#22d47a", "#f5a524", "#ff5470", "#a78bfa", "#2dd4bf"];

export default function ScreenKmeans() {
  const [nClusters, setNClusters] = useState(3);
  const [treinando, setTreinando] = useState(false);
  const [trainResult, setTrainResult] = useState(null);
  const [trainError, setTrainError] = useState(null);

  const status = useApi(() => api.ml.kmeans.status(), []);
  const resultados = useApi(() => api.ml.kmeans.resultados(0, 10), []);
  const avaliacao = useApi(() => api.ml.kmeans.avaliar(), []);

  const treinar = async () => {
    setTreinando(true);
    setTrainResult(null);
    setTrainError(null);
    try {
      const result = await api.ml.kmeans.treinar(nClusters);
      setTrainResult(result);
      status.reload();
      resultados.reload();
    } catch (e) {
      setTrainError(e.message);
    } finally {
      setTreinando(false);
    }
  };

  const st = status.data || {};
  const res = resultados.data || {};
  const clusters = res.clusters || [];
  const aval = avaliacao.data || [];

  return (
    <div className="screen-pad screen-anim">
      <div className="screen-header">
        <div>
          <div className="screen-eyebrow">07 · Machine Learning</div>
          <div className="screen-title">Segmentação de pedidos</div>
        </div>
        <div className="row" style={{ gap: 8 }}>
          <select value={nClusters} onChange={(e) => setNClusters(Number(e.target.value))}
            style={{ padding: "7px 12px", border: "1px solid var(--line)", borderRadius: "var(--r)", fontSize: 13, color: "var(--fg)", background: "var(--bg-1)" }}>
            {[2, 3, 4, 5, 6].map((k) => <option key={k} value={k}>{k} grupos</option>)}
          </select>
          <button className="btn primary" onClick={treinar} disabled={treinando} style={{ minWidth: 140 }}>
            {treinando ? <><div className="spinner" style={{ width: 14, height: 14, borderWidth: 2 }} /> Treinando...</> : <><I.refresh size={13} /> Treinar modelo</>}
          </button>
        </div>
      </div>

      {/* Status card */}
      <div style={{ marginBottom: 16 }}>
        {status.loading ? <LoadingState label="Verificando modelo..." /> : (
          <div className="ml-status-card">
            <div className="ml-status-dot" style={{ background: st.modelo_disponivel ? "var(--pos)" : "var(--neg)" }} />
            <div style={{ flex: 1 }}>
              <div style={{ fontSize: 13, fontWeight: 600, color: "var(--fg)" }}>
                {!st.banco_conectado ? "Banco indisponível"
                  : !st.tabela_disponivel ? "View ml.pedidos_padronizados não encontrada"
                  : st.modelo_disponivel ? "Modelo disponível e pronto" : "Modelo não treinado"}
              </div>
              <div style={{ fontSize: 12, color: "var(--fg-3)", marginTop: 2 }}>
                {st.tabela_disponivel ? `${fmt.int(st.total_pedidos)} pedidos disponíveis para o modelo`
                  : "Execute backend/sql/banco/ml.sql no banco."}
              </div>
            </div>
          </div>
        )}
      </div>

      {trainError && (
        <div className="error-state" style={{ marginBottom: 16 }}>
          <I.alert size={14} /> Erro no treinamento: {trainError}
        </div>
      )}
      {trainResult && (
        <div style={{ marginBottom: 16, padding: "14px 16px", background: "var(--pos-bg)", border: "1px solid var(--pos)", borderRadius: "var(--r)", fontSize: 13, color: "var(--pos)" }}>
          <strong>Modelo treinado com sucesso!</strong>
          <span style={{ marginLeft: 12, color: "var(--fg-3)" }}>Silhouette: {trainResult.silhouette_score ?? "—"}</span>
          <span style={{ marginLeft: 12, color: "var(--fg-3)" }}>{fmt.int(trainResult.pedidos_gravados)} pedidos gravados em ml.segmento_pedido</span>
        </div>
      )}

      {/* Segment cards */}
      {resultados.loading ? <LoadingState label="Aplicando modelo..." /> : resultados.error ? (
        <div style={{ marginBottom: 16 }}>
          <ErrorState msg={resultados.error} />
          <p style={{ marginTop: 12, fontSize: 13, color: "var(--fg-3)" }}>
            Treine o modelo usando o botão "Treinar modelo".
          </p>
        </div>
      ) : (
        <>
          <div className="grid grid-12" style={{ marginBottom: 16 }}>
            {clusters.map((c, i) => (
              <div key={c.cluster} className={clusters.length > 3 ? "col-3" : "col-4"}>
                <Card title={c.segmento} sub={`GRUPO ${c.cluster + 1} · ${fmt.pctRaw(c.percentual)} DOS PEDIDOS`}
                  style={{ borderTop: `3px solid ${CORES[i % CORES.length]}` }}>
                  <div className="stack" style={{ gap: 8 }}>
                    <InfoRow label="Pedidos" value={fmt.int(c.quantidade_pedidos)} />
                    <InfoRow label="Ticket médio" value={fmt.brl(c.ticket_medio)} />
                    <InfoRow label="Faturamento" value={fmt.brl(c.faturamento)} />
                    <InfoRow label="Unidades por pedido" value={c.itens_medio.toLocaleString("pt-BR")} />
                    <InfoRow label="Produtos distintos" value={c.produtos_distintos_medio.toLocaleString("pt-BR")} />
                    <InfoRow label="Preço médio do item" value={fmt.brl(c.preco_medio_item)} />
                    <InfoRow label="Frete médio (quando informado)" value={c.frete_medio == null ? "—" : fmt.brl(c.frete_medio)} />
                  </div>
                </Card>
              </div>
            ))}
          </div>

          <div className="grid grid-12" style={{ marginBottom: 16 }}>
            <div className="col-6">
              <Card title="Faturamento por segmento" sub="SOMA DO VALOR DOS PEDIDOS">
                <BarChart
                  labels={clusters.map((c) => `Grupo ${c.cluster + 1}`)}
                  datasets={[{ label: "Faturamento", data: clusters.map((c) => c.faturamento), backgroundColor: clusters.map((_, i) => CORES[i % CORES.length]) }]}
                  yFormat={(v) => fmt.brl(v)}
                  height={240}
                />
              </Card>
            </div>
            <div className="col-6">
              <Card title="Escolha do número de grupos" sub="SILHOUETTE POR K · QUANTO MAIOR, MAIS SEPARADOS">
                {avaliacao.loading ? <LoadingState label="Avaliando..." /> : avaliacao.error ? <ErrorState msg={avaliacao.error} /> : (
                  <BarChart
                    labels={aval.map((a) => `k = ${a.k}`)}
                    datasets={[{ label: "Silhouette", data: aval.map((a) => a.silhouette_score), backgroundColor: aval.map((a) => (a.k === res.n_clusters ? "#22d47a" : "#5b8eff")) }]}
                    yFormat={(v) => (v == null ? "—" : Number(v).toFixed(3))}
                    height={240}
                  />
                )}
              </Card>
            </div>
          </div>

          <div className="grid grid-12">
            <div className="col-8">
              <Card title="Pedidos classificados" sub={`PRIMEIROS 10 DE ${fmt.int(res.paginacao?.total)}`}>
                <table className="table" style={{ width: "100%", fontSize: 13 }}>
                  <thead><tr><th style={{ textAlign: "left" }}>Pedido</th><th style={{ textAlign: "left" }}>Segmento</th></tr></thead>
                  <tbody>
                    {(res.pedidos || []).map((p) => (
                      <tr key={p.pedido_id}><td className="mono">{p.pedido_id}</td><td>{p.segmento}</td></tr>
                    ))}
                  </tbody>
                </table>
              </Card>
            </div>
            <div className="col-4">
              <Card title="Sobre o modelo" sub="K-MEANS · SCIKIT-LEARN">
                <div className="stack" style={{ gap: 12 }}>
                  <InfoRow label="Algoritmo" value="K-Means (não supervisionado)" />
                  <InfoRow label="Grupos" value={res.n_clusters ?? "—"} />
                  <InfoRow label="Pedidos" value={fmt.int(res.total_pedidos)} />
                  <InfoRow label="Silhouette" value={res.silhouette_score ?? "—"} />
                  <InfoRow label="Variáveis" value="Valor, unidades, produtos, preço médio" />
                  <InfoRow label="Escalonamento" value="log1p + StandardScaler" />
                  <div style={{ padding: "10px 12px", background: "var(--bg-1)", borderRadius: 6, marginTop: 4 }}>
                    <div style={{ fontSize: 11, color: "var(--fg-3)", lineHeight: 1.6 }}>
                      O modelo agrupa pedidos com perfil de compra parecido. O frete não entra nas variáveis porque
                      Instagram e Facebook não o informam. O segmento de cada pedido é gravado em ml.segmento_pedido,
                      usado no Power BI.
                    </div>
                  </div>
                </div>
              </Card>
            </div>
          </div>
        </>
      )}
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
