import { useApi, LoadingState, ErrorState, Card, fmt } from "../components/ui";
import { HistogramChart, LineChart } from "../components/ChartComponents";
import { api } from "../api";

export default function ScreenEstatisticas() {
  return (
    <div className="screen-pad screen-anim">
      <div className="screen-header">
        <div>
          <div className="screen-eyebrow">05 · Análise</div>
          <div className="screen-title">Estatísticas avançadas</div>
        </div>
      </div>

      <div className="grid grid-2" style={{ marginBottom: 16 }}>
        <TendenciaCard />
        <DistribuicaoCard />
      </div>

      <div className="grid grid-2" style={{ marginBottom: 16 }}>
        <AnovaTrimetresCard />
        <IntervaloConfiancaCard />
      </div>

      <div className="grid grid-2">
        <AnovaCanaisCard />
        <DescritivasCard />
      </div>
    </div>
  );
}

/* ─── Tendência de faturamento ─── */
function TendenciaCard() {
  const { data, loading, error } = useApi(() => api.analytics.tendencia());
  const d = data || {};

  const labels = [
    ...(d.historico_labels || d.labels_historico || []),
    ...(d.previsao_labels || d.labels_previsao || []),
  ];
  const historico = d.historico || d.valores_historico || [];
  const tendencia = d.tendencia || d.valores_tendencia || [];
  const datasets = [
    { label: "Histórico", data: historico, borderColor: "#2563eb", backgroundColor: "rgba(37,99,235,0.08)", fill: true, tension: 0.4, pointRadius: 2, borderWidth: 2 },
    ...(tendencia.length > 0 ? [{ label: "Tendência (regressão)", data: tendencia, borderColor: "#d97706", fill: false, tension: 0, pointRadius: 0, borderWidth: 1.5, borderDash: [5, 5] }] : []),
  ];

  return (
    <Card title="Tendência de faturamento" sub="REGRESSÃO LINEAR · PROJEÇÃO 3 MESES">
      {loading ? <LoadingState /> : error ? <ErrorState msg={error} /> : (
        <>
          {labels.length > 0
            ? <LineChart labels={labels} datasets={datasets} height={220} yFormat={(v) => "R$" + Math.round(v / 1000) + "k"} />
            : <p style={{ color: "var(--fg-4)", fontSize: 13, padding: "20px 0" }}>Sem dados de tendência.</p>
          }
          {d.r_squared !== undefined && (
            <div className="row" style={{ gap: 16, marginTop: 16, paddingTop: 16, borderTop: "1px solid var(--line)" }}>
              <StatBox label="R²" value={(d.r_squared ?? 0).toFixed(4)} />
              <StatBox label="Slope" value={(d.slope ?? 0).toFixed(2)} />
              <StatBox label="Intercepto" value={(d.intercept ?? 0).toFixed(0)} />
            </div>
          )}
        </>
      )}
    </Card>
  );
}

/* ─── Distribuição de vendas ─── */
function DistribuicaoCard() {
  const { data, loading, error } = useApi(() => api.analytics.distribuicaoVendas());
  const d = data || {};
  const histBins = d.bins || d.faixas || [];
  const histFreqs = d.frequencias || d.counts || [];

  return (
    <Card title="Distribuição de vendas" sub="HISTOGRAMA + SHAPIRO-WILK">
      {loading ? <LoadingState /> : error ? <ErrorState msg={error} /> : (
        <>
          {histBins.length > 0
            ? <HistogramChart labels={histBins.map(String)} data={histFreqs} height={200} />
            : <p style={{ color: "var(--fg-4)", fontSize: 13, padding: "20px 0" }}>Sem dados.</p>
          }
          <div style={{ display: "grid", gridTemplateColumns: "repeat(auto-fill, minmax(120px, 1fr))", gap: 10, marginTop: 16 }}>
            {d.media !== undefined && <StatBox label="Média" value={fmt.brl(d.media ?? 0)} />}
            {d.mediana !== undefined && <StatBox label="Mediana" value={fmt.brl(d.mediana ?? 0)} />}
            {d.desvio_padrao !== undefined && <StatBox label="Desvio padrão" value={fmt.brl(d.desvio_padrao ?? 0)} />}
            {d.shapiro_p !== undefined && (
              <StatBox label="Shapiro p" value={(d.shapiro_p ?? 0).toFixed(4)}
                highlight={(d.shapiro_p ?? 0) > 0.05}
                sub={(d.shapiro_p ?? 0) > 0.05 ? "Normal" : "Não normal"} />
            )}
          </div>
        </>
      )}
    </Card>
  );
}

/* ─── ANOVA trimestres ─── */
function AnovaTrimetresCard() {
  const { data, loading, error } = useApi(() => api.analytics.anovaTrimetres());
  const d = data || {};
  const grupos = d.grupos_media || d.medias_por_trimestre || {};

  return (
    <Card title="ANOVA — Faturamento por Trimestre" sub="ONE-WAY ANOVA · COMPARAÇÃO ENTRE Q1–Q4">
      {loading ? <LoadingState /> : error ? <ErrorState msg={error} /> : (
        <div className="stack" style={{ gap: 16 }}>
          <div style={{ display: "grid", gridTemplateColumns: "repeat(auto-fill, minmax(120px, 1fr))", gap: 10 }}>
            <StatBox label="F-statistic" value={(d.f_statistic ?? 0).toFixed(3)} />
            <StatBox label="P-valor" value={(d.p_value ?? 0).toFixed(4)} highlight={(d.p_value ?? 1) < 0.05} />
            <StatBox label="Significativo?" value={(d.p_value ?? 1) < 0.05 ? "Sim ✓" : "Não"} highlight={(d.p_value ?? 1) < 0.05} />
          </div>
          {Object.keys(grupos).length > 0 && (
            <div style={{ display: "grid", gridTemplateColumns: "repeat(auto-fill, minmax(100px, 1fr))", gap: 8 }}>
              {Object.entries(grupos).map(([k, v]) => (
                <div key={k} style={{ background: "var(--bg-1)", borderRadius: 6, padding: "8px 10px" }}>
                  <div style={{ fontSize: 10, fontWeight: 700, color: "var(--fg-4)", marginBottom: 4 }}>{k}</div>
                  <div className="mono" style={{ fontSize: 12, fontWeight: 700, color: "var(--fg)" }}>{fmt.brl(v)}</div>
                </div>
              ))}
            </div>
          )}
          <p style={{ fontSize: 12, color: "var(--fg-3)" }}>
            {(d.p_value ?? 1) < 0.05
              ? "Há diferença significativa de faturamento entre trimestres."
              : "Não há diferença significativa entre trimestres (p ≥ 0.05)."}
          </p>
        </div>
      )}
    </Card>
  );
}

/* ─── Intervalo de confiança ─── */
function IntervaloConfiancaCard() {
  const { data, loading, error } = useApi(() => api.analytics.intervaloConfianca());
  const d = data || {};

  return (
    <Card title="Intervalo de Confiança da Receita" sub="95% · RECEITA MENSAL">
      {loading ? <LoadingState /> : error ? <ErrorState msg={error} /> : (
        <div className="stack" style={{ gap: 16 }}>
          <div style={{ display: "grid", gridTemplateColumns: "repeat(3, 1fr)", gap: 10 }}>
            <StatBox label="Média" value={fmt.brl(d.media ?? 0)} />
            <StatBox label="IC Inferior" value={fmt.brl(d.ic_inferior ?? d.lower ?? 0)} />
            <StatBox label="IC Superior" value={fmt.brl(d.ic_superior ?? d.upper ?? 0)} />
          </div>
          {d.n && <StatBox label="N amostras" value={d.n} />}

          {/* Visual IC bar */}
          {(d.ic_inferior ?? 0) > 0 && (
            <div style={{ marginTop: 8 }}>
              <div style={{ position: "relative", height: 28, background: "var(--bg-2)", borderRadius: 99 }}>
                <div style={{
                  position: "absolute",
                  left: "10%", right: "10%",
                  top: 0, bottom: 0,
                  background: "var(--accent-bg)",
                  border: "2px solid var(--accent)",
                  borderRadius: 99,
                  display: "flex", alignItems: "center", justifyContent: "center",
                }}>
                  <div style={{ width: 4, height: 20, background: "var(--accent)", borderRadius: 99 }} />
                </div>
              </div>
              <div className="row between" style={{ marginTop: 4, fontSize: 10, color: "var(--fg-4)", fontFamily: "var(--mono)" }}>
                <span>{fmt.brl(d.ic_inferior ?? d.lower ?? 0)}</span>
                <span style={{ color: "var(--accent)" }}>μ = {fmt.brl(d.media ?? 0)}</span>
                <span>{fmt.brl(d.ic_superior ?? d.upper ?? 0)}</span>
              </div>
            </div>
          )}

          <p style={{ fontSize: 12, color: "var(--fg-3)" }}>
            Com 95% de confiança, a receita mensal está dentro deste intervalo.
          </p>
        </div>
      )}
    </Card>
  );
}

/* ─── ANOVA canais ─── */
function AnovaCanaisCard() {
  const { data, loading, error } = useApi(() => api.analytics.anovaCanais());
  const d = data || {};
  const grupos = d.grupos_media || d.medias_por_canal || {};

  return (
    <Card title="ANOVA — Canais de Venda" sub="ONE-WAY ANOVA · FATURAMENTO POR CANAL">
      {loading ? <LoadingState /> : error ? <ErrorState msg={error} /> : (
        <div className="stack" style={{ gap: 16 }}>
          <div style={{ display: "grid", gridTemplateColumns: "repeat(auto-fill, minmax(120px, 1fr))", gap: 10 }}>
            <StatBox label="F-statistic" value={(d.f_statistic ?? 0).toFixed(3)} />
            <StatBox label="P-valor" value={(d.p_value ?? 0).toFixed(4)} highlight={(d.p_value ?? 1) < 0.05} />
            <StatBox label="Significativo?" value={(d.p_value ?? 1) < 0.05 ? "Sim ✓" : "Não"} highlight={(d.p_value ?? 1) < 0.05} />
          </div>
          {Object.keys(grupos).length > 0 && (
            <div style={{ display: "grid", gridTemplateColumns: "1fr", gap: 6 }}>
              {Object.entries(grupos).map(([k, v]) => (
                <div key={k} className="row between" style={{ fontSize: 12 }}>
                  <span style={{ color: "var(--fg-2)" }}>{k}</span>
                  <span className="mono" style={{ color: "var(--fg)", fontWeight: 600 }}>{fmt.brl(v)}</span>
                </div>
              ))}
            </div>
          )}
          <p style={{ fontSize: 12, color: "var(--fg-3)" }}>
            {(d.p_value ?? 1) < 0.05
              ? "Diferença significativa de faturamento entre canais de venda."
              : "Sem diferença significativa entre canais (p ≥ 0.05)."}
          </p>
        </div>
      )}
    </Card>
  );
}

/* ─── Descritivas por produto ─── */
function DescritivasCard() {
  const { data, loading, error } = useApi(() => api.analytics.descritivasProdutos());
  const rows = Array.isArray(data) ? data : (data?.produtos ?? data?.items ?? []);

  return (
    <Card title="Estatísticas descritivas por produto" sub="MÉDIA · MEDIANA · DESVIO">
      {loading ? <LoadingState /> : error ? <ErrorState msg={error} /> : (
        <div className="scroll-x">
          <table className="table">
            <thead>
              <tr>
                <th>Produto</th>
                <th className="num">Média</th>
                <th className="num">Mediana</th>
                <th className="num">Desvio</th>
                <th className="num">Mín</th>
                <th className="num">Máx</th>
              </tr>
            </thead>
            <tbody>
              {rows.length === 0 && (
                <tr><td colSpan={6} style={{ padding: 40, textAlign: "center", color: "var(--fg-4)" }}>Sem dados.</td></tr>
              )}
              {rows.map((r, i) => (
                <tr key={i}>
                  <td style={{ color: "var(--fg)" }}>{r.nome_produto ?? r.produto ?? "—"}</td>
                  <td className="num"><span className="mono">{fmt.brl(r.media ?? 0)}</span></td>
                  <td className="num"><span className="mono">{fmt.brl(r.mediana ?? 0)}</span></td>
                  <td className="num"><span className="mono">{fmt.brl(r.desvio_padrao ?? r.desvio ?? 0)}</span></td>
                  <td className="num"><span className="mono">{fmt.brl(r.minimo ?? r.min ?? 0)}</span></td>
                  <td className="num"><span className="mono">{fmt.brl(r.maximo ?? r.max ?? 0)}</span></td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </Card>
  );
}

/* ─── Helper ─── */
function StatBox({ label, value, highlight, sub }) {
  return (
    <div style={{ background: "var(--bg-1)", borderRadius: 6, padding: "10px 12px" }}>
      <div style={{ fontSize: 10, fontWeight: 700, color: "var(--fg-4)", textTransform: "uppercase", letterSpacing: "0.08em", marginBottom: 4 }}>{label}</div>
      <div className="mono" style={{ fontSize: 16, fontWeight: 700, color: highlight ? "var(--pos)" : "var(--fg)" }}>{value}</div>
      {sub && <div style={{ fontSize: 10, color: "var(--fg-4)", marginTop: 2 }}>{sub}</div>}
    </div>
  );
}
