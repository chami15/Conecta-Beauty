import { useState, useEffect, useMemo } from "react";
import { I } from "../components/icons";
import {
  Card, KPI, ManageDropdown, AnalysisFilter, CrudToolbar, DataTable,
  Drawer, Field, Insight, SearchSelect,
  useApi, LoadingState, ErrorState, Pagination, DreLine, fmt,
} from "../components/ui";
import { RevenueVsExpenseChart, DoughnutChart } from "../components/ChartComponents";
import { api } from "../api";
import { YEAR_OPTIONS, createAnalysisFilter, formatAnalysisWindow, toApiTimeParams } from "../utils/time";
import "../css/Financeiro.css";

export default function Financeiro({ dateFrom, dateTo }) {
  const [route, setRoute] = useState("dashboard");
  const [selected, setSelected] = useState(new Set());
  const [drawerOpen, setDrawerOpen] = useState(false);
  const [drawerMode, setDrawerMode] = useState("create");
  const [drawerRow, setDrawerRow] = useState(null);
  const [filter, setFilter] = useState(createAnalysisFilter(String(YEAR_OPTIONS[0] ?? "")));
  const [page, setPage] = useState(1);
  const [formData, setFormData] = useState({});
  const [crudReload, setCrudReload] = useState(0);
  const [saveError, setSaveError] = useState(null);
  const [crudError, setCrudError] = useState(null);

  const toggle = (id) => { const n = new Set(selected); n.has(id) ? n.delete(id) : n.add(id); setSelected(n); };
  useEffect(() => { setSelected(new Set()); setPage(1); setCrudError(null); }, [route]);

  const openCreate = () => {
    setDrawerMode("create");
    setDrawerRow(null);
    setFormData({});
    setSaveError(null);
    setCrudError(null);
    setDrawerOpen(true);
  };

  const openEdit = (row) => {
    setDrawerMode("edit");
    setDrawerRow(row);
    setFormData(row ?? {});
    setSaveError(null);
    setCrudError(null);
    setDrawerOpen(true);
  };

  const handleEditToolbar = async () => {
    if (selected.size !== 1) return;
    const [id] = [...selected];
    try {
      const row = route === "formas"
        ? await api.financeiro.formasPagamento.get(id)
        : await api.financeiro.transacoes.get(id);
      openEdit(row);
    } catch (e) {
      setCrudError("Nao foi possivel carregar o registro para edicao.");
    }
  };

  const handleSave = async () => {
    setSaveError(null);
    try {
      let body = { ...formData };
      if (route === "transacoes") {
        body.numero_transacao = parseInt(body.numero_transacao) || 0;
        body.valor_total_transacao = parseFloat(body.valor_total_transacao) || 0;
        body.fk_forma_pagamento = body.fk_forma_pagamento ? parseInt(body.fk_forma_pagamento) : null;
        if (!body.tipo_transacao) body.tipo_transacao = "Credito";
        if (!body.status_transacao) body.status_transacao = "Prevista";
      } else if (route === "receber") {
        body.numero_transacao = parseInt(body.numero_transacao) || Math.floor(Date.now() / 1000);
        body.valor_total_transacao = parseFloat(body.valor_total_transacao) || 0;
        body.tipo_transacao = "Credito";
        body.status_transacao = body.status_transacao || "Prevista";
        body.fk_forma_pagamento = body.fk_forma_pagamento ? parseInt(body.fk_forma_pagamento) : null;
      } else if (route === "pagar") {
        body.numero_transacao = parseInt(body.numero_transacao) || Math.floor(Date.now() / 1000);
        body.valor_total_transacao = parseFloat(body.valor_total_transacao) || 0;
        body.tipo_transacao = "Debito";
        body.status_transacao = body.status_transacao || "Prevista";
        body.fk_forma_pagamento = body.fk_forma_pagamento ? parseInt(body.fk_forma_pagamento) : null;
      }

      if (drawerMode === "create") {
        if (route === "formas") await api.financeiro.formasPagamento.create(body);
        else await api.financeiro.transacoes.create(body);
      } else {
        const id = drawerRow?.id;
        if (route === "formas") await api.financeiro.formasPagamento.update(id, body);
        else await api.financeiro.transacoes.update(id, body);
      }
      setDrawerOpen(false);
      setCrudError(null);
      setSelected(new Set());
      setPage(1);
      setCrudReload((r) => r + 1);
    } catch (e) {
      setSaveError(e.message);
    }
  };

  const handleDelete = async () => {
    const failed = [];
    for (const id of selected) {
      try {
        if (route === "formas") await api.financeiro.formasPagamento.delete(id);
        else await api.financeiro.transacoes.delete(id);
      } catch (e) {
        failed.push(id);
      }
    }
    setSelected(new Set());
    setCrudError(failed.length ? `Nao foi possivel excluir ${failed.length} registro(s).` : null);
    setPage(1);
    setCrudReload((r) => r + 1);
  };

  const sideItems = [
    { id: "dashboard", label: "Dashboard", icon: <I.chart size={15} /> },
    { section: "Gerenciar" },
    { id: "transacoes", label: "Transações", icon: <I.receipt size={15} /> },
    { id: "receber", label: "A receber", icon: <I.arrowDown size={15} /> },
    { id: "pagar", label: "A pagar", icon: <I.arrowUp size={15} /> },
    { id: "formas", label: "Formas de pagto.", icon: <I.coins size={15} /> },
  ];

  const titleMap = {
    dashboard: "Visão financeira", transacoes: "Transações",
    receber: "Contas a receber", pagar: "Contas a pagar", formas: "Formas de pagamento",
  };

  const drawerTitle = {
    transacoes: drawerMode === "edit" ? "Editar transação" : "Nova transação",
    receber: drawerMode === "edit" ? "Editar conta" : "Nova conta a receber",
    pagar: drawerMode === "edit" ? "Editar conta" : "Nova conta a pagar",
    formas: drawerMode === "edit" ? "Editar forma" : "Nova forma de pagamento",
  }[route] || "Novo registro";

  return (
    <>
      <div className="screen-pad screen-anim">
        <div className="screen-header">
          <div>
            <div className="screen-eyebrow">03 · Financeiro</div>
            <div className="screen-title">{titleMap[route]}</div>
          </div>
          <div className="row" style={{ gap: 8 }}>
            {route !== "dashboard" && (
              <button className="btn ghost" onClick={() => setRoute("dashboard")}>
                <I.arrowLeft size={13} /> Voltar ao dashboard
              </button>
            )}
            <ManageDropdown items={sideItems} value={route} onChange={setRoute} />
            {route === "dashboard" && <AnalysisFilter value={filter} onChange={setFilter} yearOptions={YEAR_OPTIONS} />}
          </div>
        </div>

        {route === "dashboard"
          ? <FinanceiroDashboard filter={filter} />
          : <FinanceiroCrud entity={route} page={page} onPage={setPage}
              selected={selected} toggle={toggle} setSelected={setSelected}
              reload={crudReload}
              actionError={crudError}
              onAdd={openCreate}
              onEdit={handleEditToolbar}
              onRowEdit={openEdit}
              onDelete={handleDelete}
            />
        }
      </div>

      <Drawer open={drawerOpen} onClose={() => setDrawerOpen(false)} eyebrow={drawerMode === "edit" ? "EDITAR" : "NOVO REGISTRO"} title={drawerTitle}
        footer={
          <>
            <button className="btn ghost" onClick={() => setDrawerOpen(false)}>Cancelar</button>
            {saveError && <span style={{ color: "var(--neg)", fontSize: 12, flex: 1, textAlign: "center" }}>{saveError}</span>}
            <button className="btn primary" onClick={handleSave}><I.check size={13} /> Salvar</button>
          </>
        }
      >
        <FinanceiroForm entity={route} data={formData} onChange={setFormData} />
      </Drawer>
    </>
  );
}

/* ─── Dashboard ─── */
function FinanceiroDashboard({ filter }) {
  const timeParams = toApiTimeParams(filter);
  const kpis  = useApi(() => api.financeiro.kpis(timeParams), [filter.scope, filter.year, filter.month]);
  const rvd   = useApi(() => api.financeiro.receitaVsDespesa(timeParams), [filter.scope, filter.year, filter.month]);
  const mix   = useApi(() => api.financeiro.mixPagamento(timeParams), [filter.scope, filter.year, filter.month]);
  const anova = useApi(() => api.analytics.anovaTrimetres(timeParams), [filter.scope, filter.year, filter.month]);
  const ic    = useApi(() => api.analytics.intervaloConfianca(timeParams), [filter.scope, filter.year, filter.month]);
  const ml    = useApi(() => api.ml.previsao(3).catch(() => null), []);

  const [dreOpen, setDreOpen] = useState({ receita: true, lucro: true, resultado: true });

  const k = kpis.data || {};
  const receita = k.receita_total ?? k.receita ?? 0;
  const despesas = k.despesas_total ?? k.despesas ?? 0;
  const resultado = receita - despesas;
  const inadimplencia = k.inadimplencia_pct ?? k.inadimplencia ?? 0;

  const rvdArr = Array.isArray(rvd.data) ? rvd.data : [];
  const rvdLabels = rvdArr.map((r) => r.nome_mes || String(r.mes));
  const rvdReceita = rvdArr.map((r) => r.receita ?? 0);
  const rvdDespesa = rvdArr.map((r) => r.despesas ?? 0);

  const mixData = mix.data || [];
  const COLORS = ["var(--pos)", "#9ec5ff", "var(--warn)", "#a78bfa", "var(--fg-3)", "var(--fg-4)"];

  const toggle = (key) => setDreOpen((s) => ({ ...s, [key]: !s[key] }));

  return (
    <>
      {kpis.loading ? <LoadingState /> : kpis.error ? <ErrorState msg={kpis.error} /> : (
        <div className="grid grid-4" style={{ marginBottom: 16 }}>
          <Card compact>
            <KPI label="Receita" currency="R$" value={fmt.brlC(receita)}
              delta={k.variacao_receita ?? null} />
          </Card>
          <Card compact>
            <KPI label="Despesas" currency="R$" value={fmt.brlC(despesas)}
              delta={k.variacao_despesas ?? null} />
          </Card>
          <Card compact>
            <KPI label="Resultado líquido" currency="R$" value={fmt.brlC(resultado)}
              delta={k.variacao_resultado ?? null} />
          </Card>
          <Card compact>
            <KPI label="Inadimplência" value={inadimplencia.toFixed ? inadimplencia.toFixed(1) : inadimplencia} unit="%"
              delta={k.variacao_inadimplencia ?? null} deltaLabel="em atraso" />
          </Card>
        </div>
      )}

      <div className="grid grid-12" style={{ marginBottom: 16 }}>
        <div className="col-8">
          <Card title="Receita vs Despesa" sub="MENSAL"
            action={
              <>
                <span className="chip pos"><span style={{ width: 8, height: 2, background: "var(--pos)", display: "inline-block" }} /> Receita</span>
                <span className="chip neg"><span style={{ width: 8, height: 2, background: "var(--neg)", display: "inline-block" }} /> Despesa</span>
              </>
            }
          >
            {rvd.loading ? <LoadingState /> : rvd.error ? <ErrorState msg={rvd.error} /> : (
              <>
                <RevenueVsExpenseChart labels={rvdLabels} revenue={rvdReceita} expense={rvdDespesa} height={260} />
                <div className="row" style={{ gap: 16, marginTop: 16, paddingTop: 16, borderTop: "1px solid var(--line)" }}>
                  <StatMini label="Receita no recorte" value={fmt.brl(receita)} />
                  <StatMini label="Despesa no recorte" value={fmt.brl(despesas)} />
                  <StatMini label="Margem" value={`${receita > 0 ? ((resultado / receita) * 100).toFixed(1) : "0.0"}%`} />
                  <StatMini label="Janela" value={formatAnalysisWindow(filter)} />
                </div>
              </>
            )}
            {(!anova.loading && !anova.error && anova.data?.anova) && (
              <div className="stats-inline" style={{ marginTop: 12 }}>
                <div className="stats-inline-item">
                  <span className="stats-inline-label">Sazonalidade trimestral</span>
                  <span className={`stats-inline-value ${anova.data.anova.significativo ? "sig" : "warn"}`}>
                    {anova.data.anova.significativo
                      ? "Há variação significativa entre trimestres ✓"
                      : "Receita estável entre trimestres"
                    }
                  </span>
                </div>
                {!ic.loading && !ic.error && ic.data?.intervalo_confianca && (
                  <>
                    <div style={{ width: 1, height: 14, background: "var(--line-2)" }} />
                    <div className="stats-inline-item">
                      <span className="stats-inline-label">Receita mensal esperada</span>
                      <span className="stats-inline-value" style={{ color: "var(--accent-2)" }}>
                        {fmt.brl(ic.data.intervalo_confianca.ic_lower ?? 0)} – {fmt.brl(ic.data.intervalo_confianca.ic_upper ?? 0)}
                      </span>
                    </div>
                  </>
                )}
              </div>
            )}
            {!ml.loading && ml.data?.previsoes?.length > 0 && (
              <div className="ml-forecast-row" style={{ marginTop: 12 }}>
                <div className="ml-forecast-label">
                  <I.cpu size={12} /> Projeção IA
                </div>
                {ml.data.previsoes.slice(0, 3).map((item) => (
                  <div key={`${item.ano}-${item.mes}`} className="ml-forecast-item">
                    <span className="ml-forecast-month">{item.nome_mes}/{item.ano}</span>
                    <span className="ml-forecast-val">{fmt.brl(item.faturamento_previsto ?? 0)}</span>
                  </div>
                ))}
              </div>
            )}
          </Card>
        </div>

        <div className="col-4">
          <Card title="DRE simplificado" sub="ACUMULADO">
            <div style={{ gap: 0 }}>

              {/* Receita Bruta section */}
              <button onClick={() => toggle("receita")} style={{
                display: "flex", alignItems: "center", justifyContent: "space-between",
                width: "100%", padding: "9px 0",
                cursor: "pointer", background: "transparent",
                border: "none", borderBottom: "1px solid var(--line)",
              }}>
                <span style={{ fontSize: 12, fontWeight: 700, color: "var(--fg)" }}>Receita bruta</span>
                <div className="row" style={{ gap: 8 }}>
                  <span className="mono" style={{ fontSize: 12, fontWeight: 700, color: "var(--fg)" }}>{fmt.brl(receita)}</span>
                  <I.arrowDown size={11} style={{ color: "var(--fg-4)", transform: dreOpen.receita ? "rotate(180deg)" : "none", transition: "transform 0.15s" }} />
                </div>
              </button>
              {dreOpen.receita && (
                <>
                  <DreLine label="(−) Impostos" value={-(receita * 0.1)} indent />
                  <DreLine label="(−) Devoluções" value={-(receita * 0.02)} indent />
                </>
              )}

              {/* Receita Líquida / Lucro Bruto section */}
              <button onClick={() => toggle("lucro")} style={{
                display: "flex", alignItems: "center", justifyContent: "space-between",
                width: "100%", padding: "9px 0",
                cursor: "pointer", background: "transparent",
                border: "none", borderBottom: "1px solid var(--line)",
              }}>
                <span style={{ fontSize: 12, fontWeight: 700, color: "var(--fg)" }}>Receita líquida → Lucro bruto</span>
                <div className="row" style={{ gap: 8 }}>
                  <span className="mono" style={{ fontSize: 12, fontWeight: 700, color: "var(--pos)" }}>{fmt.brl(receita * 0.5)}</span>
                  <I.arrowDown size={11} style={{ color: "var(--fg-4)", transform: dreOpen.lucro ? "rotate(180deg)" : "none", transition: "transform 0.15s" }} />
                </div>
              </button>
              {dreOpen.lucro && (
                <>
                  <DreLine label="Receita líquida" value={receita * 0.88} bold />
                  <DreLine label="(−) CMV" value={-(receita * 0.38)} indent />
                </>
              )}

              {/* Resultado Líquido section */}
              <button onClick={() => toggle("resultado")} style={{
                display: "flex", alignItems: "center", justifyContent: "space-between",
                width: "100%", padding: "9px 0",
                cursor: "pointer", background: "transparent",
                border: "none", borderBottom: "1px solid var(--line)",
              }}>
                <span style={{ fontSize: 12, fontWeight: 700, color: "var(--fg)" }}>Resultado líquido</span>
                <div className="row" style={{ gap: 8 }}>
                  <span className="mono" style={{ fontSize: 12, fontWeight: 700, color: resultado >= 0 ? "var(--pos)" : "var(--neg)" }}>{fmt.brl(resultado)}</span>
                  <I.arrowDown size={11} style={{ color: "var(--fg-4)", transform: dreOpen.resultado ? "rotate(180deg)" : "none", transition: "transform 0.15s" }} />
                </div>
              </button>
              {dreOpen.resultado && (
                <>
                  <DreLine label="Lucro bruto" value={receita * 0.5} bold pos />
                  <DreLine label="(−) Despesas op." value={-despesas * 0.4} indent />
                  <DreLine label="(−) Logística" value={-despesas * 0.15} indent />
                </>
              )}
            </div>
          </Card>
        </div>
      </div>

      <div className="grid grid-12">
        <div className="col-12">
          <Card title="Mix de formas de pagamento" sub="RECEITA DO PERÍODO">
            {mix.loading ? <LoadingState /> : mix.error ? <ErrorState msg={mix.error} /> : (
              <div className="row" style={{ gap: 32, alignItems: "center", flexWrap: "wrap" }}>
                <DoughnutChart
                  labels={mixData.map((m) => m.forma_pagamento ?? m.forma ?? "—")}
                  data={mixData.map((m) => m.faturamento ?? m.total ?? m.valor ?? 0)}
                  colors={COLORS.slice(0, mixData.length)}
                  size={180}
                  centerLabel="Formas"
                  centerValue={mixData.length > 0 ? String(mixData.length) : ""}
                />
                <div className="stack" style={{ flex: 1, minWidth: 180, gap: 12 }}>
                  {mixData.map((m, i) => (
                    <div key={i} className="row between" style={{ fontSize: 12 }}>
                      <div className="row" style={{ gap: 8 }}>
                        <span style={{ width: 10, height: 10, borderRadius: 3, background: COLORS[i % COLORS.length], display: "inline-block", flexShrink: 0 }} />
                        <span style={{ color: "var(--fg-2)" }}>{m.forma_pagamento ?? m.forma ?? "—"}</span>
                      </div>
                      <div className="row" style={{ gap: 8 }}>
                        {m.percentual != null && (
                          <span className="mono" style={{ fontSize: 11, color: "var(--fg-4)" }}>{Number(m.percentual).toFixed(1)}%</span>
                        )}
                        <span className="mono" style={{ color: "var(--fg)" }}>{fmt.brl(m.faturamento ?? m.total ?? m.valor ?? 0)}</span>
                      </div>
                    </div>
                  ))}
                  {mixData.length === 0 && <p style={{ color: "var(--fg-4)", fontSize: 13 }}>Sem dados de pagamento.</p>}
                </div>
              </div>
            )}
          </Card>
        </div>
      </div>
    </>
  );
}

/* ─── CRUD views ─── */
function FinanceiroCrud({ entity, page, onPage, selected, toggle, setSelected, onAdd, onEdit, onRowEdit, onDelete, reload, actionError }) {
  const [search, setSearch] = useState("");
  const [filters, setFilters] = useState({});
  const [dateFilter, setDateFilter] = useState({ from: "", to: "" });

  useEffect(() => {
    setSearch("");
    setFilters({});
  }, [entity]);

  const queryPage = search ? 1 : page;
  const querySize = search ? 500 : 20;

  const fetcher = useMemo(() => {
    if (entity === "transacoes") return () => api.financeiro.transacoes.list(queryPage, querySize);
    if (entity === "receber")   return () => api.financeiro.aReceber(queryPage, querySize);
    if (entity === "pagar")     return () => api.financeiro.aPagar(queryPage, querySize);
    return () => api.financeiro.formasPagamento.list();
  }, [entity, queryPage, querySize]);

  const { data, loading, error } = useApi(fetcher, [entity, queryPage, querySize, reload]);

  const rawRows = Array.isArray(data) ? data : (data?.items ?? data?.data ?? []);

  const rows = useMemo(() => {
    const q = search.toLowerCase();
    return rawRows.filter((r) => {
      const str = JSON.stringify(r).toLowerCase();
      if (q && !str.includes(q)) return false;
      if (filters.status && r.status_transacao !== filters.status) return false;
      if (entity === "transacoes" && filters.tipo && r.tipo_transacao !== filters.tipo) return false;
      if (filters.year) {
        const sourceDate = r.data_pagamento ?? r.data_hora_lancamento;
        if (!sourceDate || String(new Date(sourceDate).getFullYear()) !== String(filters.year)) return false;
      }
      if (filters.month) {
        const sourceDate = r.data_pagamento ?? r.data_hora_lancamento;
        if (!sourceDate || String(new Date(sourceDate).getMonth() + 1).padStart(2, "0") !== String(filters.month).padStart(2, "0")) return false;
      }
      return true;
    }).sort((a, b) => Number(b.id ?? 0) - Number(a.id ?? 0));
  }, [rawRows, search, filters, entity]);

  const total = search ? rows.length : (data?.total ?? rawRows.length);
  const hasActiveFilters = Object.values(filters).some(Boolean);

  const cols = useMemo(() => {
    if (entity === "transacoes") return [
      { key: "numero_transacao", label: "Nº", width: 80, render: (r) => <span className="mono" style={{ color: "var(--fg-3)" }}>#{r.numero_transacao ?? r.id}</span> },
      { key: "historico", label: "Histórico", render: (r) => (
        <div>
          <div style={{ color: "var(--fg)" }}>{r.historico ?? r.descricao ?? "—"}</div>
          <div style={{ fontSize: 11, color: "var(--fg-4)", marginTop: 2 }}>{r.categoria ?? ""}</div>
        </div>
      )},
      { key: "tipo_transacao", label: "Tipo", width: 110, render: (r) => (
        <span className={"chip " + (r.tipo_transacao === "Credito" || r.tipo_transacao === "Crédito" ? "pos" : "neg")}>
          {r.tipo_transacao === "Credito" || r.tipo_transacao === "Crédito" ? <I.arrowUp size={10} stroke={2.5} /> : <I.arrowDown size={10} stroke={2.5} />}
          {r.tipo_transacao}
        </span>
      )},
      { key: "valor_total_transacao", label: "Valor", num: true, width: 140, render: (r) => (
        <span className="mono" style={{ color: (r.tipo_transacao === "Credito" || r.tipo_transacao === "Crédito") ? "var(--pos)" : "var(--fg)" }}>
          {(r.tipo_transacao === "Credito" || r.tipo_transacao === "Crédito") ? "+" : "−"} {fmt.brl(r.valor_total_transacao ?? r.valor ?? 0)}
        </span>
      )},
      { key: "data_pagamento", label: "Periodo", width: 120, render: (r) => <span className="mono" style={{ color: "var(--fg-3)" }}>{fmt.monthYear(r.data_pagamento)}</span> },
      { key: "status_transacao", label: "Status", width: 120, render: (r) => (
        <span className={"chip " + (r.status_transacao === "Paga" ? "pos" : r.status_transacao === "Prevista" ? "warn" : r.status_transacao === "Cancelada" ? "neg" : "")}>{r.status_transacao ?? "—"}</span>
      )},
    ];
    if (entity === "receber") return [
      { key: "cliente", label: "Cliente", render: (r) => <span style={{ color: "var(--fg)" }}>{r.nome ?? r.cliente ?? r.historico ?? "—"}</span> },
      { key: "valor_total_transacao", label: "Valor", num: true, width: 140, render: (r) => fmt.brl(r.valor_total_transacao ?? r.valor ?? 0) },
      { key: "data_pagamento", label: "Periodo", width: 130, render: (r) => <span className="mono">{fmt.monthYear(r.data_pagamento)}</span> },
      { key: "status_transacao", label: "Status", width: 130, render: (r) => (
        <span className={"chip " + (r.status_transacao === "Paga" ? "pos" : r.status_transacao === "Prevista" ? "warn" : "neg")}>{r.status_transacao ?? "—"}</span>
      )},
    ];
    if (entity === "pagar") return [
      { key: "historico", label: "Fornecedor / Descrição", render: (r) => <span style={{ color: "var(--fg)" }}>{r.historico ?? r.descricao ?? "—"}</span> },
      { key: "valor_total_transacao", label: "Valor", num: true, width: 140, render: (r) => fmt.brl(r.valor_total_transacao ?? r.valor ?? 0) },
      { key: "data_pagamento", label: "Periodo", width: 130, render: (r) => <span className="mono">{fmt.monthYear(r.data_pagamento)}</span> },
      { key: "status_transacao", label: "Status", width: 130, render: (r) => (
        <span className={"chip " + (r.status_transacao === "Paga" ? "pos" : r.status_transacao === "Prevista" ? "warn" : "neg")}>{r.status_transacao ?? "—"}</span>
      )},
    ];
    return [
      { key: "forma_pagamento", label: "Forma de pagamento", render: (r) => (
        <div className="row" style={{ gap: 10 }}>
          <span style={{ width: 30, height: 30, borderRadius: 6, background: "var(--bg-1)", border: "1px solid var(--line)", display: "grid", placeItems: "center" }}>
            <I.receipt size={13} style={{ color: "var(--fg-3)" }} />
          </span>
          <span style={{ color: "var(--fg)" }}>{r.forma_pagamento ?? r.nome ?? "—"}</span>
        </div>
      )},
    ];
  }, [entity]);

  const filterContent = useMemo(() => {
    if (entity === "formas") return null;

    const statusOptions = [...new Set(rawRows.map((row) => row.status_transacao).filter(Boolean))];
    const tipoOptions = [...new Set(rawRows.map((row) => row.tipo_transacao).filter(Boolean))];
    const yearOptions = [...new Set(rawRows.map((row) => {
      const sourceDate = row.data_pagamento ?? row.data_hora_lancamento;
      return sourceDate ? String(new Date(sourceDate).getFullYear()) : null;
    }).filter(Boolean))].sort().reverse();

    return (
      <>
        <Field label="Status">
          <select value={filters.status ?? ""} onChange={(e) => setFilters((prev) => ({ ...prev, status: e.target.value }))}>
            <option value="">Todos</option>
            {statusOptions.map((status) => <option key={status} value={status}>{status}</option>)}
          </select>
        </Field>
        {entity === "transacoes" && (
          <Field label="Tipo">
            <select value={filters.tipo ?? ""} onChange={(e) => setFilters((prev) => ({ ...prev, tipo: e.target.value }))}>
              <option value="">Todos</option>
              {tipoOptions.map((tipo) => <option key={tipo} value={tipo}>{tipo}</option>)}
            </select>
          </Field>
        )}
        <Field label="Ano">
          <select value={filters.year ?? ""} onChange={(e) => setFilters((prev) => ({ ...prev, year: e.target.value, month: e.target.value ? prev.month : "" }))}>
            <option value="">Todos</option>
            {yearOptions.map((year) => <option key={year} value={year}>{year}</option>)}
          </select>
        </Field>
        <Field label="Mes">
          <select value={filters.month ?? ""} onChange={(e) => setFilters((prev) => ({ ...prev, month: e.target.value }))}>
            <option value="">Todos</option>
            {Array.from({ length: 12 }).map((_, index) => {
              const value = String(index + 1).padStart(2, "0");
              return <option key={value} value={value}>{value}</option>;
            })}
          </select>
        </Field>
      </>
    );
  }, [entity, filters, rawRows]);

  return (
    <Card flush>
      <div style={{ padding: 16 }}>
        <CrudToolbar
          searchPlaceholder={`Buscar em ${entity}...`}
          onSearch={setSearch}
          selectedCount={selected.size}
          onAdd={onAdd}
          onEdit={onEdit}
          onDelete={onDelete}
          filterContent={filterContent}
          filterActive={hasActiveFilters}
          onClearFilters={() => setFilters({})}
          extraFilters={
            <>
              {(entity === "transacoes" || entity === "receber" || entity === "pagar") && (
                <>
                  <input type="date" value={dateFilter.from} onChange={(e) => setDateFilter((f) => ({ ...f, from: e.target.value }))}
                    style={{ padding: "7px 10px", border: "1px solid var(--line)", borderRadius: "var(--r)", fontSize: 12, color: "var(--fg)" }} />
                  <span style={{ color: "var(--fg-4)", fontSize: 12 }}>→</span>
                  <input type="date" value={dateFilter.to} onChange={(e) => setDateFilter((f) => ({ ...f, to: e.target.value }))}
                    style={{ padding: "7px 10px", border: "1px solid var(--line)", borderRadius: "var(--r)", fontSize: 12, color: "var(--fg)" }} />
                </>
              )}
              <button className="btn"><I.download size={13} /> Exportar</button>
            </>
          }
        />
        {actionError && <ErrorState msg={actionError} />}
        {loading ? <LoadingState /> : error ? <ErrorState msg={error} /> : (
          <>
            <DataTable columns={cols} rows={rows} selected={selected} onToggle={toggle}
              onRowEdit={onRowEdit}
              onToggleAll={() => {
                if (selected.size === rows.length) setSelected(new Set());
                else setSelected(new Set(rows.map((r) => r.id)));
              }}
            />
            {!search && <Pagination page={page} total={total} pageSize={20} onPage={onPage} />}
          </>
        )}
      </div>
    </Card>
  );
}

/* ─── Forms ─── */
function FinanceiroForm({ entity, data = {}, onChange }) {
  const set = (field) => (e) => onChange((prev) => ({ ...prev, [field]: e.target.value }));
  const formas = useApi(() => api.financeiro.formasPagamento.list(), []);
  const formaOptions = (formas.data ?? []).map((item) => ({
    value: item.id ?? item.id_forma_pagamento,
    label: item.forma_pagamento ?? item.nome ?? `Forma ${item.id}`,
  }));

  if (entity === "transacoes") return (
    <>
      <Field label="Número da transação"><input type="number" value={data.numero_transacao ?? ""} onChange={set("numero_transacao")} /></Field>
      <Field label="Tipo">
        <select value={data.tipo_transacao ?? "Credito"} onChange={set("tipo_transacao")}>
          <option value="Credito">Crédito (receita)</option>
          <option value="Debito">Débito (despesa)</option>
        </select>
      </Field>
      <Field label="Histórico">
        <input value={data.historico ?? ""} onChange={set("historico")} placeholder="Ex.: Recebimento pedido #1284" />
      </Field>
      <div className="grid grid-2" style={{ gap: 12 }}>
        <Field label="Valor total">
          <input value={data.valor_total_transacao ?? ""} onChange={set("valor_total_transacao")} placeholder="R$ 0,00" />
        </Field>
        <Field label="Forma de pagamento">
          <select value={data.fk_forma_pagamento ?? ""} onChange={set("fk_forma_pagamento")}>
            <option value="">Selecione</option>
            <option value="1">PIX</option>
            <option value="2">Crédito</option>
            <option value="3">Boleto</option>
            <option value="4">Débito</option>
            <option value="5">Dinheiro</option>
            <option value="6">Transferência</option>
          </select>
        </Field>
      </div>
      <div className="grid grid-2" style={{ gap: 12 }}>
        <Field label="Data pagamento">
          <input type="date" value={data.data_pagamento ?? ""} onChange={set("data_pagamento")} />
        </Field>
        <Field label="Status">
          <select value={data.status_transacao ?? "Prevista"} onChange={set("status_transacao")}>
            <option value="Prevista">Prevista</option>
            <option value="Confirmada">Confirmada</option>
            <option value="Paga">Paga</option>
            <option value="Cancelada">Cancelada</option>
          </select>
        </Field>
      </div>
    </>
  );
  if (entity === "receber" || entity === "pagar") return (
    <>
      <Field label={entity === "receber" ? "Cliente / Descrição" : "Fornecedor / Descrição"}>
        <input value={data.historico ?? ""} onChange={set("historico")} />
      </Field>
      <div className="grid grid-2" style={{ gap: 12 }}>
        <Field label="Valor">
          <input value={data.valor_total_transacao ?? ""} onChange={set("valor_total_transacao")} placeholder="R$ 0,00" />
        </Field>
        <Field label="Vencimento">
          <input type="date" value={data.data_pagamento ?? ""} onChange={set("data_pagamento")} />
        </Field>
      </div>
      <Field label="Status">
        <select value={data.status_transacao ?? "Prevista"} onChange={set("status_transacao")}>
          <option value="Prevista">Prevista</option>
          <option value="Confirmada">Confirmada</option>
          <option value="Paga">Paga</option>
          <option value="Cancelada">Cancelada</option>
        </select>
      </Field>
    </>
  );
  return (
    <>
      <Field label="Forma de pagamento">
        <select value={data.forma_pagamento ?? ""} onChange={set("forma_pagamento")}>
          <option value="">Selecione</option>
          <option value="PIX">PIX</option>
          <option value="Crédito">Crédito</option>
          <option value="Boleto">Boleto</option>
          <option value="Débito">Débito</option>
          <option value="Dinheiro">Dinheiro</option>
          <option value="Transferência">Transferência</option>
        </select>
      </Field>
    </>
  );
}

function StatMini({ label, value }) {
  return (
    <div style={{ flex: 1 }}>
      <div className="mono" style={{ fontSize: 10, color: "var(--fg-3)", textTransform: "uppercase", letterSpacing: "0.14em" }}>{label}</div>
      <div style={{ fontSize: 16, fontWeight: 700, color: "var(--fg)", marginTop: 4 }}>{value}</div>
    </div>
  );
}
