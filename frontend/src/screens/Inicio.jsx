import { useState } from "react";
import { I } from "../components/icons";
import {
  Card, KPI, Gauge, Donut, BarList, Insight, AnalysisFilter,
  HealthLine, DonutLegend, Stat,
  useApi, LoadingState, ErrorState, fmt,
} from "../components/ui";
import { FaturamentoDiarioChart } from "../components/ChartComponents";
import { api } from "../api";
import { MONTH_OPTIONS, YEAR_OPTIONS, createAnalysisFilter, formatAnalysisWindow, toApiTimeParams } from "../utils/time";
import "../css/Inicio.css";

/* Rótulos padronizados: "Jan/2026" nos meses e "09/06" nos dias. */
const rotuloMes = (ano, mes) => `${MONTH_OPTIONS[mes - 1].label}/${ano}`;
const rotuloDia = (data) => (data ? `${String(data).slice(8, 10)}/${String(data).slice(5, 7)}` : "");
const ordemMes = (ano, mes) => ano * 12 + mes;

function aggregateByMonth(rows = []) {
  const grouped = new Map();
  rows.forEach((row) => {
    if (!row?.data) return;
    const [ano, mes, dia] = String(row.data).split("-").map(Number);
    const atual = grouped.get(ordemMes(ano, mes)) ?? { ano, mes, real: 0, ultimoDia: 0 };
    atual.real += Number(row.faturamento ?? 0);
    atual.ultimoDia = Math.max(atual.ultimoDia, dia);
    grouped.set(ordemMes(ano, mes), atual);
  });

  return [...grouped.entries()]
    .sort(([a], [b]) => a - b)
    .map(([ordem, item]) => ({ ...item, ordem, label: rotuloMes(item.ano, item.mes), ml: null }));
}

/* O último mês dos dados costuma estar em andamento (vendas só até o dia X): fica marcado
   com "*" e fora de melhor/pior/média, para não parecer uma queda de faturamento.
   O modelo de ML só treina com meses completos, então um mês depois do último mês do modelo
   está incompleto; sem o modelo, vale o último dia com venda. */
function marcarMesParcial(serie, ml) {
  const ultimo = serie[serie.length - 1];
  if (!ultimo) return serie;
  const historico = ml?.historico || [];
  const fimModelo = historico.length ? historico[historico.length - 1] : null;
  const parcial = fimModelo
    ? ultimo.ordem > ordemMes(fimModelo.ano, fimModelo.mes)
    : ultimo.ultimoDia < new Date(ultimo.ano, ultimo.mes, 0).getDate();
  if (parcial) {
    ultimo.parcial = true;
    ultimo.label += "*";
  }
  return serie;
}

/* Junta à série mensal o valor do ML de cada mês:
   - meses do histórico: o que o modelo previu a partir dos 3 meses anteriores reais;
   - meses seguintes: a previsão, só quando o período exibido chega ao último mês do modelo
     (filtrando 2023, por exemplo, não faz sentido emendar a previsão de 2026). */
function juntarPrevisaoML(serie, ml) {
  const historico = ml?.historico || [];
  if (!serie.length || !historico.length) return serie;

  const porMes = new Map(serie.map((p) => [p.ordem, p]));
  historico.forEach((h) => {
    const ponto = porMes.get(ordemMes(h.ano, h.mes));
    if (ponto && h.faturamento_ajustado != null) ponto.ml = h.faturamento_ajustado;
  });

  const ultimoModelo = historico[historico.length - 1];
  if (serie[serie.length - 1].ordem < ordemMes(ultimoModelo.ano, ultimoModelo.mes)) return serie;

  (ml.previsoes || []).forEach((f) => {
    const ordem = ordemMes(f.ano, f.mes);
    const ponto = porMes.get(ordem);
    if (ponto) ponto.ml = f.faturamento_previsto;  // mês em andamento: real até agora x previsto
    else serie.push({ ano: f.ano, mes: f.mes, ordem, label: rotuloMes(f.ano, f.mes), real: null, ml: f.faturamento_previsto });
  });
  return serie;
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
  const mensal = filter.scope === "year" || filter.scope === "all";
  let serie = [], fatAnterior = [];
  if (Array.isArray(fatRaw)) {
    serie = mensal
      ? juntarPrevisaoML(marcarMesParcial(aggregateByMonth(fatRaw), mlPrev.data), mlPrev.loading ? null : mlPrev.data)
      : fatRaw.map((r) => ({ label: rotuloDia(r.data), real: r.faturamento ?? 0, ml: null }));
  } else if (fatRaw) {
    serie = (fatRaw.dias || []).map((d, i) => ({ label: String(d), real: fatRaw.atual?.[i] ?? 0, ml: null }));
    fatAnterior = fatRaw.anterior || [];
  }
  const fatLabels = serie.map((p) => p.label);
  const fatAtual  = serie.map((p) => p.real);
  const fatML     = serie.map((p) => p.ml);
  const showML    = fatML.some((v) => v != null);
  const reais     = fatAtual.filter((v) => v != null);
  const parcial   = serie.find((p) => p.parcial);
  const completos = serie.filter((p) => p.real != null && !p.parcial).map((p) => p.real);
  const unidade   = mensal ? { melhor: "Melhor mês", pior: "Pior mês", media: "Média mensal" }
                           : { melhor: "Melhor dia", pior: "Pior dia", media: "Média diária" };

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
          <Card title={mensal ? "Faturamento mensal" : "Faturamento diário"}
            sub={showML ? "REAL X PREVISÃO DO MODELO (MLP)" : "PERÍODO SELECIONADO"}
            action={
              <>
                <span className="chip pos">
                  <span style={{ width: 8, height: 2, background: "var(--pos)", display: "inline-block" }} /> Real
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
                  ajustado={showML ? fatML : null}
                  height={260}
                />
                {completos.length > 0 && (
                  <div className="row" style={{ gap: 16, marginTop: 16, paddingTop: 16, borderTop: "1px solid var(--line)" }}>
                    <Stat label={unidade.melhor} value={"R$" + fmt.brlC(Math.max(...completos))} pos />
                    <Stat label={unidade.pior}   value={"R$" + fmt.brlC(Math.min(...completos))} />
                    <Stat label={unidade.media}  value={"R$" + fmt.brlC(completos.reduce((a, b) => a + b, 0) / completos.length)} />
                    <Stat label="Total"          value={"R$" + fmt.brlC(reais.reduce((a, b) => a + b, 0))} pos />
                  </div>
                )}
                {parcial && (
                  <div style={{ marginTop: 8, fontSize: 11, color: "var(--fg-3)" }}>
                    * {parcial.label.slice(0, -1)} com vendas até o dia {parcial.ultimoDia}: fora de melhor, pior e média.
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
