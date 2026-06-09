import { useState } from "react";
import { I } from "../components/icons";
import {
  Card, KPI, Gauge, Donut, BarList, Insight, AnalysisFilter,
  HealthLine, DonutLegend, Stat,
  useApi, LoadingState, ErrorState, fmt,
} from "../components/ui";
import { FaturamentoDiarioChart } from "../components/ChartComponents";
import { api } from "../api";
import { YEAR_OPTIONS, createAnalysisFilter, formatAnalysisWindow, toApiTimeParams } from "../utils/time";
import "../css/Inicio.css";

function aggregateByMonth(rows = []) {
  const grouped = new Map();
  rows.forEach((row) => {
    if (!row?.data) return;
    const date = new Date(`${row.data}T00:00:00`);
    const key = `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, "0")}`;
    const current = grouped.get(key) ?? 0;
    grouped.set(key, current + Number(row.faturamento ?? 0));
  });

  return [...grouped.entries()].map(([key, value]) => ({
    label: new Date(`${key}-01T00:00:00`).toLocaleDateString("pt-BR", { month: "short" }),
    value,
  }));
}

export default function Inicio() {
  const [filter, setFilter] = useState(createAnalysisFilter(String(YEAR_OPTIONS[0] ?? "")));
  const timeParams = toApiTimeParams(filter);

  const kpis     = useApi(() => api.inicio.kpis(timeParams), [filter.scope, filter.year, filter.month]);
  const fat      = useApi(() => api.inicio.faturamentoDiario(timeParams), [filter.scope, filter.year, filter.month]);
  const pedidos  = useApi(() => api.inicio.pedidosPorStatus(timeParams), [filter.scope, filter.year, filter.month]);
  const topProds = useApi(() => api.inicio.topProdutos(timeParams), [filter.scope, filter.year, filter.month]);
  const saude    = useApi(() => api.inicio.saude(), []);
  /* ML — ignora silenciosamente se modelo não treinado (404) */
  const mlPrev   = useApi(() => api.ml.previsao(3).catch(() => null), []);

  /* ─── KPI values ─── */
  const k = kpis.data || {};
  const faturamento   = k.faturamento_total ?? 0;
  const totalPedidos  = k.total_pedidos ?? 0;
  const ticketMedio   = k.ticket_medio ?? 0;
  const clientesAtivos = k.clientes_ativos ?? 0;
  const deltaPedidos  = k.variacao_pedidos ?? null;
  const deltaFat      = k.variacao_faturamento ?? null;

  /* ─── Faturamento diário ───
     Backend retorna: [{data, faturamento}]  (lista plana)
     Chart espera:    {dias, atual, anterior}
  */
  const fatRaw = fat.data;
  let fatLabels = [], fatAtual = [], fatAnterior = [];
  if (Array.isArray(fatRaw)) {
    if (filter.scope === "year" || filter.scope === "all") {
      const monthly = aggregateByMonth(fatRaw);
      fatLabels = monthly.map((item) => item.label);
      fatAtual = monthly.map((item) => item.value);
    } else {
      fatLabels  = fatRaw.map((r) => r.data ? String(r.data).slice(5) : "");
      fatAtual   = fatRaw.map((r) => r.faturamento ?? 0);
    }
    fatAnterior = [];
  } else if (fatRaw) {
    fatLabels  = (fatRaw.dias || []).map(String);
    fatAtual   = fatRaw.atual || [];
    fatAnterior = fatRaw.anterior || [];
  }

  /* ─── Pedidos por status ───
     Backend retorna: [{status, quantidade}]  (lista plana)
     Frontend espera: {confirmados, enviados, pendentes, atrasados}
  */
  const pedRaw = pedidos.data;
  let ped = { confirmados: 0, enviados: 0, pendentes: 0, atrasados: 0 };
  if (Array.isArray(pedRaw)) {
    pedRaw.forEach((r) => {
      const s = (r.status ?? "").toLowerCase();
      const q = r.quantidade ?? 0;
      if (s.includes("confirm"))  ped.confirmados += q;
      else if (s.includes("envi") || s.includes("rota") || s.includes("transit")) ped.enviados += q;
      else if (s.includes("pendent") || s.includes("aguard")) ped.pendentes += q;
      else if (s.includes("atras") || s.includes("cancel") || s.includes("devolv")) ped.atrasados += q;
      else ped.pendentes += q;
    });
  } else if (pedRaw) {
    ped = { ...ped, ...pedRaw };
  }
  const pedSegmentos = [
    { value: ped.confirmados, color: "var(--pos)" },
    { value: ped.enviados,    color: "#9ec5ff" },
    { value: ped.pendentes,   color: "var(--warn)" },
    { value: ped.atrasados,   color: "var(--neg)" },
  ];
  const totalEmAberto = ped.confirmados + ped.enviados + ped.pendentes + ped.atrasados;

  /* ─── Top produtos ─── */
  const tops = (topProds.data || []).map((p) => ({
    label: p.nome_produto ?? p.produto ?? "—",
    sub:   p.categoria ?? "",
    value: p.faturamento ?? p.receita ?? 0,
    delta: p.variacao ?? null,
    color: (p.variacao ?? 0) >= 0 ? "var(--pos)" : "var(--neg)",
  }));

  /* ─── Saúde ───
     Backend retorna: {score_geral, componentes: {vendas, margem, estoque, ...}}
     Frontend espera: score (número), components (array com {label, score})
  */
  const sau   = saude.data || {};
  const score = sau.score ?? sau.score_geral ?? sau.saude_geral ?? 0;
  const compRaw = sau.componentes || sau.components;
  const components = Array.isArray(compRaw)
    ? compRaw
    : compRaw && typeof compRaw === "object"
      ? Object.entries(compRaw).map(([k, v]) => ({
          label: k.charAt(0).toUpperCase() + k.slice(1),
          score: v,
        }))
      : [];

  /* ─── ML previsão ─── */
  const prev     = mlPrev.data || {};
  const prevVals = (prev.previsoes || []).map((item) => item.faturamento_previsto ?? 0);
  const prevLbls = (prev.previsoes || []).map((item) => `${item.nome_mes}/${item.ano}`);

  // Fitted (in-sample) values aligned positionally with fatAtual for year/all scope
  let ajustadoAligned = null;
  if (
    !mlPrev.loading && (prev.historico || []).some(h => h.faturamento_ajustado != null) &&
    (filter.scope === "year" || filter.scope === "all") &&
    Array.isArray(fatRaw)
  ) {
    const fittedMap = new Map(
      (prev.historico || [])
        .filter(h => h.faturamento_ajustado != null)
        .map(h => [`${h.ano}-${h.mes}`, h.faturamento_ajustado])
    );
    const seenKeys = new Set();
    const monthKeys = [];
    fatRaw.forEach(row => {
      if (!row?.data) return;
      const parts = String(row.data).split("-");
      const key = `${Number(parts[0])}-${Number(parts[1])}`;
      if (!seenKeys.has(key)) { seenKeys.add(key); monthKeys.push(key); }
    });
    monthKeys.sort((a, b) => {
      const [ay, am] = a.split("-").map(Number);
      const [by, bm] = b.split("-").map(Number);
      return ay !== by ? ay - by : am - bm;
    });
    const mapped = monthKeys.map(key => fittedMap.get(key) ?? null);
    if (mapped.some(v => v != null)) ajustadoAligned = mapped;
  }

  const showML = !mlPrev.loading && prevVals.length > 0 &&
    (filter.scope === "year" || filter.scope === "all");

  const statusFor = (v) => v >= 75 ? "pos" : v >= 55 ? "warn" : "neg";

  return (
    <div className="screen-pad screen-anim">
      {/* HEADER */}
      <div className="screen-header">
        <div>
          <div className="screen-eyebrow">01 · Painel executivo</div>
          <div className="screen-title">Resumo · {formatAnalysisWindow(filter)}</div>
        </div>
        <AnalysisFilter value={filter} onChange={setFilter} yearOptions={YEAR_OPTIONS} />
      </div>

      {/* KPIs */}
      {kpis.loading ? <LoadingState /> : kpis.error ? <ErrorState msg={kpis.error} /> : (
        <div className="grid grid-4" style={{ marginBottom: 16 }}>
          <Card compact>
            <KPI label="Faturamento" currency="R$"
              value={fmt.brlC(faturamento)}
              delta={deltaFat}
            />
          </Card>
          <Card compact>
            <KPI label="Pedidos" value={fmt.int(totalPedidos)}
              delta={deltaPedidos}
            />
          </Card>
          <Card compact>
            <KPI label="Ticket médio" currency="R$"
              value={fmt.brlC(ticketMedio)}
            />
          </Card>
          <Card compact>
            <KPI label="Clientes ativos" value={fmt.int(clientesAtivos)} />
          </Card>
        </div>
      )}

      {/* FATURAMENTO + SAÚDE */}
      <div className="grid grid-12" style={{ marginBottom: 16 }}>
        <div className="col-8">
          <Card title="Faturamento mensal"
            sub="PERÍODO SELECIONADO"
            action={
              <>
                <span className="chip pos">
                  <span style={{ width: 8, height: 2, background: "var(--pos)", display: "inline-block" }} /> Atual
                </span>
                {showML && (
                  <span className="chip" style={{ color: "#fbbf24" }}>
                    <span style={{ width: 10, borderTop: "2px dashed #fbbf24", display: "inline-block", verticalAlign: "middle" }} /> Previsão IA
                  </span>
                )}
              </>
            }
          >
            {fat.loading ? <LoadingState /> : fat.error ? <ErrorState msg={fat.error} /> : (
              <>
                <FaturamentoDiarioChart
                  labels={fatLabels}
                  atual={fatAtual}
                  anterior={fatAnterior}
                  ajustado={ajustadoAligned}
                  previsao={showML ? { labels: prevLbls, values: prevVals } : null}
                  height={260}
                />
                {fatAtual.length > 0 && (
                  <div className="row" style={{ gap: 16, marginTop: 16, paddingTop: 16, borderTop: "1px solid var(--line)" }}>
                    <Stat label="Melhor dia"   value={"R$" + fmt.brlC(Math.max(...fatAtual))} pos />
                    <Stat label="Pior dia"     value={"R$" + fmt.brlC(Math.min(...fatAtual))} />
                    <Stat label="Média diária" value={"R$" + fmt.brlC(fatAtual.reduce((a, b) => a + b, 0) / fatAtual.length)} />
                    <Stat label="Total"        value={"R$" + fmt.brlC(fatAtual.reduce((a, b) => a + b, 0))} pos />
                  </div>
                )}

              </>
            )}
          </Card>
        </div>

        <div className="col-4">
          <Card title="Saúde da empresa" sub="ÍNDICE COMPOSTO">
            {saude.loading ? <LoadingState /> : saude.error ? <ErrorState msg={saude.error} /> : (
              <>
                <div style={{ display: "grid", placeItems: "center", padding: "8px 0 16px" }}>
                  <Gauge value={Math.round(score)} max={100} label="Score geral" status={statusFor(score)} />
                </div>
                <div className="stack" style={{ gap: 10 }}>
                  {components.length > 0
                    ? components.map((c, i) => (
                        <HealthLine key={i}
                          label={c.label ?? c.nome ?? c.componente}
                          value={Math.round(c.score ?? c.valor ?? 0)}
                          status={statusFor(c.score ?? c.valor ?? 0)} />
                      ))
                    : <p style={{ color: "var(--fg-4)", fontSize: 13, padding: "20px 0", textAlign: "center" }}>Sem dados disponíveis para o período selecionado.</p>
                  }
                </div>
              </>
            )}
          </Card>
        </div>
      </div>

      {/* PEDIDOS + TOP PRODUTOS */}
      <div className="grid grid-12">
        <div className="col-6">
          <Card title="Pedidos por status" sub="EM ABERTO">
            {pedidos.loading ? <LoadingState /> : pedidos.error ? <ErrorState msg={pedidos.error} /> : (
              <div className="row" style={{ alignItems: "center", gap: 24 }}>
                <Donut size={140} centerLabel="Em aberto" centerValue={totalEmAberto} segments={pedSegmentos} />
                <div className="stack" style={{ flex: 1, gap: 8 }}>
                  <DonutLegend color="var(--pos)"  label="Confirmados" value={ped.confirmados ?? 0} />
                  <DonutLegend color="#9ec5ff"      label="Enviados"    value={ped.enviados    ?? 0} />
                  <DonutLegend color="var(--warn)"  label="Pendentes"   value={ped.pendentes   ?? 0} />
                  <DonutLegend color="var(--neg)"   label="Atrasados"   value={ped.atrasados   ?? 0} />
                </div>
              </div>
            )}
          </Card>
        </div>

        <div className="col-6">
          <Card title="Top 5 produtos" sub="POR FATURAMENTO">
            {topProds.loading ? <LoadingState /> : topProds.error ? <ErrorState msg={topProds.error} /> : (
              tops.length > 0
                ? <BarList showRank color="var(--pos)" items={tops} />
                : <p style={{ color: "var(--fg-4)", fontSize: 13, padding: "20px 0" }}>Sem dados de produtos.</p>
            )}
          </Card>
        </div>
      </div>
    </div>
  );
}
