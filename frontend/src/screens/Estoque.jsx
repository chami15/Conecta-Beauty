import { useState, useEffect, useMemo } from "react";
import { I } from "../components/icons";
import {
  Card, KPI, ManageDropdown, AnalysisFilter, CrudToolbar, DataTable,
  Drawer, Field, Insight, Heatmap, SearchSelect,
  useApi, LoadingState, ErrorState, Pagination, StarRating, StockLevel, fmt,
} from "../components/ui";
import { MovimentacoesChart } from "../components/ChartComponents";
import { api } from "../api";
import { YEAR_OPTIONS, createAnalysisFilter, formatAnalysisWindow, toApiTimeParams } from "../utils/time";
import "../css/Estoque.css";

export default function Estoque({ dateFrom, dateTo }) {
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
      let row;
      if (route === "movimentacoes") row = await api.estoque.movimentacoes.get(id);
      else if (route === "fretes") row = await api.estoque.fretes.get(id);
      else if (route === "transportadoras") row = await api.estoque.transportadoras.get(id);
      else row = null;
      openEdit(row);
    } catch (e) {
      setCrudError("Nao foi possivel carregar o registro para edicao.");
    }
  };

  const handleSave = async () => {
    setSaveError(null);
    try {
      let body = { ...formData };

      if (route === "movimentacoes") {
        body.fk_produto = parseInt(body.fk_produto) || 0;
        body.fk_tipo_movimentacao = parseInt(body.fk_tipo_movimentacao) || 0;
        body.quantidade = parseInt(body.quantidade) || 0;
        body.valor_unitario = parseFloat(body.valor_unitario) || 0;
        body.fk_fornecedor = body.fk_fornecedor ? parseInt(body.fk_fornecedor) : null;
        await api.estoque.movimentacoes.create(body);
      } else if (route === "fretes") {
        if (drawerMode === "create") {
          body.numero_pedido = parseInt(body.numero_pedido) || 0;
          body.fk_transportadora = parseInt(body.fk_transportadora) || 0;
          body.fk_localizacao_origem = parseInt(body.fk_localizacao_origem) || 0;
          body.fk_localizacao_destino = parseInt(body.fk_localizacao_destino) || 0;
          body.peso_total_kg = parseFloat(body.peso_total_kg) || 0;
          body.valor_frete = parseFloat(body.valor_frete) || 0;
          body.prazo_entrega_dias = body.prazo_entrega_dias ? parseInt(body.prazo_entrega_dias) : null;
          body.houve_avaria = body.houve_avaria === true || body.houve_avaria === "true";
          if (!body.status_frete) body.status_frete = "Aguardando";
          await api.estoque.fretes.create(body);
        } else {
          const updateBody = {
            status_frete: body.status_frete || "Aguardando",
            dias_atraso: body.dias_atraso ? parseInt(body.dias_atraso) : null,
            houve_avaria: body.houve_avaria === true || body.houve_avaria === "true",
            fk_transportadora: parseInt(body.fk_transportadora) || 0,
            peso_total_kg: parseFloat(body.peso_total_kg) || 0,
            valor_frete: parseFloat(body.valor_frete) || 0,
            prazo_entrega_dias: body.prazo_entrega_dias ? parseInt(body.prazo_entrega_dias) : null,
          };
          await api.estoque.fretes.update(drawerRow?.id, updateBody);
        }
      } else if (route === "transportadoras") {
        body.media_entrega = parseInt(body.media_entrega) || 7;
        body.frete_kg_base = body.frete_kg_base ? parseFloat(body.frete_kg_base) : null;
        body.ativo = body.ativo !== "false" && body.ativo !== false;
        if (drawerMode === "create") await api.estoque.transportadoras.create(body);
        else await api.estoque.transportadoras.update(drawerRow?.id, body);
      } else {
        setDrawerOpen(false);
        return;
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
        if (route === "movimentacoes") await api.estoque.movimentacoes.delete(id);
        else if (route === "fretes") await api.estoque.fretes.delete(id);
        else if (route === "transportadoras") await api.estoque.transportadoras.delete(id);
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
    { id: "produtos", label: "Saldo SKUs", icon: <I.box size={15} /> },
    { id: "movimentacoes", label: "Movimentações", icon: <I.layers size={15} /> },
    { id: "fretes", label: "Fretes", icon: <I.package size={15} /> },
    { id: "transportadoras", label: "Transportadoras", icon: <I.truck size={15} /> },
  ];

  const titleMap = {
    dashboard: "Visão de estoque", produtos: "Saldo de SKUs",
    movimentacoes: "Movimentações", fretes: "Fretes", transportadoras: "Transportadoras",
  };

  const drawerTitleMap = {
    produtos: "Ajustar saldo",
    movimentacoes: drawerMode === "edit" ? "Editar movimentação" : "Nova movimentação",
    fretes: drawerMode === "edit" ? "Editar frete" : "Novo frete",
    transportadoras: drawerMode === "edit" ? "Editar transportadora" : "Nova transportadora",
  };

  return (
    <>
      <div className="screen-pad screen-anim">
        <div className="screen-header">
          <div>
            <div className="screen-eyebrow">04 · Estoque</div>
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
          ? <EstoqueDashboard filter={filter} />
          : <EstoqueCrud entity={route} page={page} onPage={setPage}
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

      <Drawer open={drawerOpen} onClose={() => setDrawerOpen(false)} eyebrow={drawerMode === "edit" ? "EDITAR" : "NOVO REGISTRO"}
        title={drawerTitleMap[route] || "Registro"}
        footer={
          <>
            <button className="btn ghost" onClick={() => setDrawerOpen(false)}>Cancelar</button>
            {saveError && <span style={{ color: "var(--neg)", fontSize: 12, flex: 1, textAlign: "center" }}>{saveError}</span>}
            <button className="btn primary" onClick={handleSave}><I.check size={13} /> Salvar</button>
          </>
        }
      >
        <EstoqueForm entity={route} data={formData} onChange={setFormData} drawerMode={drawerMode} />
      </Drawer>
    </>
  );
}

/* ─── Dashboard ─── */
function EstoqueDashboard({ filter }) {
  const timeParams = toApiTimeParams(filter);
  const kpis     = useApi(() => api.estoque.kpis());
  const movChart = useApi(() => api.estoque.movimentacoesPorDia(timeParams), [filter.scope, filter.year, filter.month]);
  const perf     = useApi(() => api.estoque.performanceTransportadoras(timeParams), [filter.scope, filter.year, filter.month]);
  const calor    = useApi(() => api.estoque.calorMovimentacao(timeParams), [filter.scope, filter.year, filter.month]);
  const corr     = useApi(() => api.analytics.correlacaoEstoque(timeParams), [filter.scope, filter.year, filter.month]);

  const [perfExpanded, setPerfExpanded] = useState(false);

  const k = kpis.data || {};

  const movRaw = movChart.data || [];
  const movLabels = Array.isArray(movRaw)
    ? movRaw.map((r) => String(r.data ?? "").slice(5))
    : (movRaw.dias || movRaw.labels || []).map(String);
  const movEntradas = Array.isArray(movRaw)
    ? movRaw.map((r) => r.entradas ?? 0)
    : movRaw.entradas || movRaw.entrada || [];
  const movSaidas = Array.isArray(movRaw)
    ? movRaw.map((r) => r.saidas ?? 0)
    : movRaw.saidas || movRaw.saida || [];

  /* Sort transportadoras best → worst */
  const perfRaw = (perf.data || []).map((t) => ({
    ...t,
    pct: t.taxa_no_prazo_pct ?? t.rating_calculado ?? t.rating ?? 0,
    label: t.transportadora ?? t.nome_transportadora ?? t.nome ?? "—",
    sub: `${t.qtd_fretes ?? t.total_fretes ?? 0} fretes · ${(t.prazo_medio_dias ?? t.atraso_medio ?? 0).toFixed(1)}d prazo`,
  })).sort((a, b) => b.pct - a.pct);
  const perfVisible = perfExpanded ? perfRaw : perfRaw.slice(0, 3);

  const calorList = Array.isArray(calor.data) ? calor.data : [];
  const heatRows = useMemo(() => {
    if (calorList.length === 0) return ["Cadeiras", "Bancadas", "Lavatórios", "Espelhos", "Acessórios"];
    return [...new Set(calorList.map((r) => r.produto))];
  }, [calorList]);
  const heatCols = useMemo(() => {
    if (calorList.length === 0) return ["S1", "S2", "S3", "S4"];
    return [...new Set(calorList.map((r) => r.nome_mes))];
  }, [calorList]);
  const heatVals = useMemo(() => {
    if (calorList.length === 0) return heatRows.map(() => heatCols.map(() => 0));
    return heatRows.map((prod) =>
      heatCols.map((mes) => {
        const found = calorList.find((r) => r.produto === prod && r.nome_mes === mes);
        return found ? Math.round(found.qtd_movimentada) : 0;
      })
    );
  }, [calorList, heatRows, heatCols]);

  const corrData = corr.data?.correlacao;
  const corrMsg = corrData
    ? corrData.significativo
      ? `Correlação ${corrData.forca ?? "moderada"} entre entradas e saídas — estoque acompanha a demanda`
      : "Sem correlação estatisticamente significativa entre entradas e saídas"
    : null;

  return (
    <>
      {kpis.loading ? <LoadingState /> : kpis.error ? <ErrorState msg={kpis.error} /> : (
        <div className="grid grid-4" style={{ marginBottom: 16 }}>
          <Card compact>
            <KPI label="Itens em estoque" value={fmt.int(k.itens_em_estoque ?? k.total_itens ?? 0)} unit="un" />
          </Card>
          <Card compact>
            <KPI label="Valor em estoque" currency="R$" value={fmt.brlC(k.valor_em_estoque ?? k.valor_estoque ?? 0)}
              deltaLabel="capital imobilizado" />
          </Card>
          <Card compact>
            <KPI label="Giro médio" value={(k.giro_medio ?? 0).toFixed(1)} unit="x"
              deltaLabel={`total SKUs: ${k.total_skus ?? "?"}`} />
          </Card>
          <Card compact>
            <KPI label="SKUs em alerta" value={fmt.int(k.skus_em_alerta ?? k.skus_alerta ?? 0)}
              deltaLabel="abaixo do mínimo" />
          </Card>
        </div>
      )}

      <div className="grid grid-12" style={{ marginBottom: 16 }}>
        <div className="col-7">
          <Card title="Movimentações" sub="ENTRADA VS SAÍDA"
            action={
              <>
                <span className="chip pos"><span style={{ width: 8, height: 2, background: "var(--pos)", display: "inline-block" }} /> Entrada</span>
                <span className="chip neg"><span style={{ width: 8, height: 2, background: "var(--neg)", display: "inline-block" }} /> Saída</span>
              </>
            }
          >
            {movChart.loading ? <LoadingState /> : movChart.error ? <ErrorState msg={movChart.error} /> : (
              <>
                <MovimentacoesChart labels={movLabels} entradas={movEntradas} saidas={movSaidas} height={260} />
                {movEntradas.length > 0 && (
                  <div className="row" style={{ gap: 16, marginTop: 16, paddingTop: 16, borderTop: "1px solid var(--line)" }}>
                    <div style={{ flex: 1 }}>
                      <div className="mono" style={{ fontSize: 10, color: "var(--fg-3)", textTransform: "uppercase", letterSpacing: "0.16em", fontWeight: 600 }}>Entradas</div>
                      <div style={{ fontSize: 18, fontWeight: 700, color: "var(--pos)", marginTop: 4 }}>{fmt.int(movEntradas.reduce((a, b) => a + b, 0))} un</div>
                    </div>
                    <div style={{ flex: 1 }}>
                      <div className="mono" style={{ fontSize: 10, color: "var(--fg-3)", textTransform: "uppercase", letterSpacing: "0.16em", fontWeight: 600 }}>Saídas</div>
                      <div style={{ fontSize: 18, fontWeight: 700, color: "var(--neg)", marginTop: 4 }}>{fmt.int(movSaidas.reduce((a, b) => a + b, 0))} un</div>
                    </div>
                    <div style={{ flex: 1 }}>
                      <div className="mono" style={{ fontSize: 10, color: "var(--fg-3)", textTransform: "uppercase", letterSpacing: "0.16em", fontWeight: 600 }}>Saldo líquido</div>
                      <div style={{ fontSize: 18, fontWeight: 700, color: movEntradas.reduce((a, b) => a + b, 0) >= movSaidas.reduce((a, b) => a + b, 0) ? "var(--pos)" : "var(--neg)", marginTop: 4 }}>
                        {fmt.int(movEntradas.reduce((a, b) => a + b, 0) - movSaidas.reduce((a, b) => a + b, 0))} un
                      </div>
                    </div>
                    <div style={{ flex: 1 }}>
                      <div className="mono" style={{ fontSize: 10, color: "var(--fg-3)", textTransform: "uppercase", letterSpacing: "0.16em", fontWeight: 600 }}>Janela</div>
                      <div style={{ fontSize: 18, fontWeight: 700, color: "var(--fg)", marginTop: 4 }}>
                        {formatAnalysisWindow(filter)}
                      </div>
                    </div>
                  </div>
                )}
                {corrMsg && !corr.loading && (
                  <div className="stats-inline" style={{ marginTop: 12 }}>
                    <div className="stats-inline-item">
                      <span className="stats-inline-label">Análise estatística</span>
                      <span className={`stats-inline-value ${corrData?.significativo ? "sig" : "warn"}`}>
                        {corrMsg}
                      </span>
                    </div>
                    {corrData?.r != null && (
                      <>
                        <div style={{ width: 1, height: 14, background: "var(--line-2)" }} />
                        <div className="stats-inline-item">
                          <span className="stats-inline-label">Coeficiente r</span>
                          <span className={`stats-inline-value ${corrData.significativo ? "sig" : "warn"}`}>
                            {Number(corrData.r).toFixed(3)}
                          </span>
                        </div>
                      </>
                    )}
                  </div>
                )}
              </>
            )}
          </Card>
        </div>

        <div className="col-5">
          <Card title="Performance de transportadoras" sub="% DE ENTREGAS NO PRAZO">
            {perf.loading ? <LoadingState /> : perf.error ? <ErrorState msg={perf.error} /> : (
              <>
                {perfRaw.length === 0 && (
                  <p style={{ color: "var(--fg-4)", fontSize: 13, padding: "20px 0" }}>Sem dados de transportadoras.</p>
                )}
                <div className="stack" style={{ gap: 14 }}>
                  {perfVisible.map((t, i) => (
                    <div key={i}>
                      <div className="row between" style={{ marginBottom: 6 }}>
                        <div>
                          <div style={{ fontSize: 13, color: "var(--fg)" }}>{t.label}</div>
                          <div style={{ fontSize: 11, color: "var(--fg-4)", marginTop: 2 }}>{t.sub}</div>
                        </div>
                        <StarRating pct={t.pct} />
                      </div>
                      <div className="bar">
                        <i style={{
                          width: `${Math.min(100, t.pct)}%`,
                          background: t.pct >= 80 ? "var(--pos)" : t.pct >= 50 ? "var(--warn)" : "var(--neg)",
                        }} />
                      </div>
                    </div>
                  ))}
                </div>
                {perfRaw.length > 3 && (
                  <button className="btn ghost" onClick={() => setPerfExpanded((e) => !e)}
                    style={{ marginTop: 12, width: "100%", justifyContent: "center", fontSize: 12 }}>
                    {perfExpanded ? "Ver menos" : `Ver mais ${perfRaw.length - 3} transportadoras`}
                    <I.arrowDown size={11} style={{ transform: perfExpanded ? "rotate(180deg)" : "none", transition: "transform 0.15s" }} />
                  </button>
                )}
              </>
            )}
          </Card>
        </div>
      </div>

      <div className="grid grid-12">
        <div className="col-12">
          <Card title="Movimentação de produto" sub="QUANTIDADE POR PRODUTO · POR MÊS">
            {calor.loading ? <LoadingState /> : calor.error ? <ErrorState msg={calor.error} /> : (
              <>
                <Heatmap rows={heatRows} cols={heatCols} format={(v) => v} color="var(--accent)" values={heatVals} />
                <div className="divider" />
                <Insight tone="pos" icon={<I.trending size={14} />} title="Acompanhe tendências por produto">
                  Meses com alta demanda exigem reposição antecipada.
                </Insight>
              </>
            )}
          </Card>
        </div>
      </div>
    </>
  );
}

/* ─── CRUD Views ─── */
function EstoqueCrud({ entity, page, onPage, selected, toggle, setSelected, onAdd, onEdit, onRowEdit, onDelete, reload, actionError }) {
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
    if (entity === "produtos")        return () => api.estoque.saldos(queryPage, querySize);
    if (entity === "movimentacoes")   return () => api.estoque.movimentacoes.list(queryPage, querySize);
    if (entity === "fretes")          return () => api.estoque.fretes.list(queryPage, querySize);
    return () => api.estoque.transportadoras.list();
  }, [entity, queryPage, querySize]);

  const { data, loading, error } = useApi(fetcher, [entity, queryPage, querySize, reload]);
  const rawRows = Array.isArray(data) ? data : (data?.items ?? data?.data ?? []);
  const yearOptions = [...new Set(rawRows.map((row) => {
    const sourceDate = row.data_movimentacao ?? row.data_envio ?? row.data_entrega;
    return sourceDate ? String(new Date(sourceDate).getFullYear()) : null;
  }).filter(Boolean))].sort().reverse();

  const filterContent = useMemo(() => {
    if (entity === "produtos") {
      return (
        <Field label="Situacao">
          <select value={filters.situacao ?? ""} onChange={(e) => setFilters((prev) => ({ ...prev, situacao: e.target.value }))}>
            <option value="">Todas</option>
            <option value="CRITICO">Critico</option>
            <option value="EXCESSO">Excesso</option>
            <option value="NORMAL">Normal</option>
          </select>
        </Field>
      );
    }

    if (entity === "movimentacoes") {
      const naturezas = [...new Set(rawRows.map((row) => row.natureza).filter(Boolean))];
      return (
        <>
          <Field label="Natureza">
            <select value={filters.natureza ?? ""} onChange={(e) => setFilters((prev) => ({ ...prev, natureza: e.target.value }))}>
              <option value="">Todas</option>
              {naturezas.map((natureza) => <option key={natureza} value={natureza}>{natureza}</option>)}
            </select>
          </Field>
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
    }

    if (entity === "fretes") {
      const statusOptions = [...new Set(rawRows.map((row) => row.status_frete).filter(Boolean))];
      return (
        <>
          <Field label="Status">
            <select value={filters.status ?? ""} onChange={(e) => setFilters((prev) => ({ ...prev, status: e.target.value }))}>
              <option value="">Todos</option>
              {statusOptions.map((status) => <option key={status} value={status}>{status}</option>)}
            </select>
          </Field>
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
    }

    if (entity === "transportadoras") {
      return (
        <Field label="Status">
          <select value={filters.ativo ?? ""} onChange={(e) => setFilters((prev) => ({ ...prev, ativo: e.target.value }))}>
            <option value="">Todas</option>
            <option value="ativas">Ativas</option>
            <option value="inativas">Inativas</option>
          </select>
        </Field>
      );
    }

    return null;
  }, [entity, filters, rawRows, yearOptions]);

  const rows = useMemo(() => {
    const q = search.toLowerCase();
    return rawRows.filter((r) => {
      const str = JSON.stringify(r).toLowerCase();
      if (q && !str.includes(q)) return false;
      if (entity === "produtos" && filters.situacao && (r.situacao ?? "NORMAL") !== filters.situacao) return false;
      if (entity === "movimentacoes" && filters.natureza && r.natureza !== filters.natureza) return false;
      if (entity === "fretes" && filters.status && r.status_frete !== filters.status) return false;
      if (filters.year) {
        const sourceDate = r.data_movimentacao ?? r.data_envio ?? r.data_entrega;
        if (!sourceDate || String(new Date(sourceDate).getFullYear()) !== String(filters.year)) return false;
      }
      if (filters.month) {
        const sourceDate = r.data_movimentacao ?? r.data_envio ?? r.data_entrega;
        if (!sourceDate || String(new Date(sourceDate).getMonth() + 1).padStart(2, "0") !== String(filters.month).padStart(2, "0")) return false;
      }
      if (entity === "transportadoras" && filters.ativo) {
        const ativo = Boolean(r.ativo);
        if (filters.ativo === "ativas" && !ativo) return false;
        if (filters.ativo === "inativas" && ativo) return false;
      }
      return true;
    }).sort((a, b) => Number(b.id ?? 0) - Number(a.id ?? 0));
  }, [rawRows, search, filters, entity]);

  const total = search ? rows.length : (data?.total ?? rawRows.length);
  const hasActiveFilters = Object.values(filters).some(Boolean);

  const cols = useMemo(() => {
    if (entity === "produtos") return [
      { key: "nome", label: "Produto", render: (r) => (
        <div className="row" style={{ gap: 10 }}>
          <span style={{ width: 30, height: 30, borderRadius: 6, background: "var(--bg-1)", border: "1px solid var(--line)", display: "grid", placeItems: "center" }}>
            <I.box size={13} style={{ color: "var(--fg-3)" }} />
          </span>
          <div>
            <div style={{ color: "var(--fg)" }}>{r.nome_produto ?? r.produto ?? "—"}</div>
            <div className="mono" style={{ fontSize: 11, color: "var(--fg-4)", marginTop: 2 }}>{r.sku ?? ""}</div>
          </div>
        </div>
      )},
      { key: "categoria", label: "Categoria", width: 130, render: (r) => <span>{r.categoria ?? "—"}</span> },
      { key: "saldo_atual", label: "Saldo", num: true, width: 90, render: (r) => (
        <span className="mono" style={{ color: (r.saldo_atual ?? r.saldo ?? 0) <= (r.estoque_min ?? 0) ? "var(--neg)" : "var(--fg)" }}>{r.saldo_atual ?? r.saldo ?? 0}</span>
      )},
      { key: "nivel", label: "Nível", width: 130, render: (r) => (
        <StockLevel saldo={r.saldo_atual ?? r.saldo ?? 0} min={r.estoque_min ?? 0} max={r.estoque_max ?? Math.max((r.saldo_atual ?? 0) * 2, 1)} />
      )},
    ];
    if (entity === "movimentacoes") return [
      { key: "data_movimentacao", label: "Periodo", width: 110, render: (r) => <span className="mono" style={{ color: "var(--fg-3)" }}>{fmt.monthYear(r.data_movimentacao)}</span> },
      { key: "produto", label: "Produto", render: (r) => <span style={{ color: "var(--fg)" }}>{r.nome_produto ?? r.produto ?? "—"}</span> },
      { key: "tipo", label: "Tipo", width: 200, render: (r) => (
        <span className={"chip " + (r.natureza === "ENTRADA" ? "pos" : "neg")}>
          {r.natureza === "ENTRADA" ? <I.arrowDown size={10} stroke={2.5} /> : <I.arrowUp size={10} stroke={2.5} />}
          {r.tipo_movimentacao ?? r.tipo ?? r.natureza}
        </span>
      )},
      { key: "quantidade", label: "Qtd", num: true, width: 90, render: (r) => (
        <span className="mono" style={{ color: r.natureza === "ENTRADA" ? "var(--pos)" : "var(--neg)" }}>
          {r.natureza === "ENTRADA" ? "+" : "−"}{r.quantidade ?? r.qtd ?? 0}
        </span>
      )},
      { key: "valor_unitario", label: "Valor unit.", num: true, width: 120, render: (r) => fmt.brl(r.valor_unitario ?? r.valor ?? 0) },
    ];
    if (entity === "fretes") return [
      { key: "numero_pedido", label: "Pedido", width: 100, render: (r) => <span className="mono" style={{ color: "var(--fg-2)" }}>#{r.numero_pedido ?? r.pedido ?? r.id}</span> },
      { key: "transportadora", label: "Transportadora", render: (r) => <span>{r.nome_transportadora ?? r.transportadora ?? "—"}</span> },
      { key: "peso_total_kg", label: "Peso", num: true, width: 90, render: (r) => <span className="mono">{r.peso_total_kg ?? r.peso ?? 0}kg</span> },
      { key: "valor_frete", label: "Frete", num: true, width: 110, render: (r) => fmt.brl(r.valor_frete ?? r.valor ?? 0) },
      { key: "prazo_entrega_dias", label: "Prazo", num: true, width: 110, render: (r) => (
        <span className="mono" style={{ color: (r.dias_atraso ?? 0) > 0 ? "var(--neg)" : "var(--fg-2)" }}>
          {r.prazo_entrega_dias ?? r.prazo ?? "?"}d{(r.dias_atraso ?? 0) > 0 ? ` +${r.dias_atraso}d atraso` : ""}
        </span>
      )},
      { key: "status_frete", label: "Status", width: 130, render: (r) => (
        <span className={"chip " + (r.status_frete === "Entregue" ? "pos" : r.status_frete === "Em Trânsito" ? "" : r.status_frete === "Devolvido" || r.status_frete === "Extraviado" ? "neg" : "warn")}>
          {r.status_frete ?? "—"}
        </span>
      )},
    ];
    return [
      { key: "nome", label: "Transportadora", render: (r) => (
        <div className="row" style={{ gap: 10 }}>
          <span style={{ width: 30, height: 30, borderRadius: 6, background: "var(--bg-1)", border: "1px solid var(--line)", display: "grid", placeItems: "center" }}>
            <I.truck size={13} style={{ color: "var(--fg-3)" }} />
          </span>
          <div>
            <div style={{ color: "var(--fg)" }}>{r.nome_transportadora ?? r.nome ?? "—"}</div>
            <div className="mono" style={{ fontSize: 11, color: "var(--fg-4)", marginTop: 2 }}>{r.cnpj ?? ""}</div>
          </div>
        </div>
      )},
      { key: "fretes", label: "Fretes (mês)", num: true, render: (r) => fmt.int(r.total_fretes ?? r.fretes ?? 0) },
      { key: "media_entrega", label: "Prazo médio", num: true, width: 130, render: (r) => <span className="mono">{r.media_entrega ?? r.prazo ?? 0}d</span> },
      { key: "ativo", label: "Status", width: 100, render: (r) => (
        <span className={"chip " + (r.ativo ? "pos" : "neg")}>{r.ativo ? "Ativo" : "Inativo"}</span>
      )},
    ];
  }, [entity]);

  const addLabel = entity === "movimentacoes" ? "Nova movimentação" : "Adicionar";

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
          addLabel={addLabel}
          filterContent={filterContent}
          filterActive={hasActiveFilters}
          onClearFilters={() => setFilters({})}
          extraFilters={
            <>
              {entity === "movimentacoes" && (
                <>
                  <input type="date" value={dateFilter.from} onChange={(e) => setDateFilter((f) => ({ ...f, from: e.target.value }))}
                    style={{ padding: "7px 10px", border: "1px solid var(--line)", borderRadius: "var(--r)", fontSize: 12, color: "var(--fg)" }} />
                  <span style={{ color: "var(--fg-4)", fontSize: 12 }}>→</span>
                  <input type="date" value={dateFilter.to} onChange={(e) => setDateFilter((f) => ({ ...f, to: e.target.value }))}
                    style={{ padding: "7px 10px", border: "1px solid var(--line)", borderRadius: "var(--r)", fontSize: 12, color: "var(--fg)" }} />
                </>
              )}
              <button className="btn"><I.filter size={13} /> Filtros</button>
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
function EstoqueForm({ entity, data = {}, onChange, drawerMode }) {
  const set = (field) => (e) => onChange((prev) => ({ ...prev, [field]: e.target.value }));
  const produtos = useApi(() => api.admin.produtos.list(1, 100), []);
  const fornecedores = useApi(() => api.admin.fornecedores.list(1, 100), []);
  const tipos = useApi(() => api.estoque.tiposMovimentacao(), []);
  const transportadoras = useApi(() => api.estoque.transportadoras.list(), []);
  const localizacoes = useApi(() => api.admin.localizacoes("", 100), []);

  const produtoOptions = (produtos.data?.data ?? produtos.data?.items ?? produtos.data ?? []).map((item) => ({
    value: item.id,
    label: `${item.nome_produto ?? item.nome ?? "Produto"}${item.sku ? ` · ${item.sku}` : ""}`,
  }));
  const fornecedorOptions = (fornecedores.data?.data ?? fornecedores.data?.items ?? fornecedores.data ?? []).map((item) => ({
    value: item.id,
    label: item.nome_fornecedor ?? item.nome ?? `Fornecedor ${item.id}`,
  }));
  const tipoOptions = (tipos.data ?? []).map((item) => ({
    value: item.id ?? item.id_tipo_movimentacao,
    label: `${item.tipo_movimentacao ?? item.tipo ?? "Tipo"} · ${item.natureza ?? ""}`.trim(),
  }));
  const transportadoraOptions = (transportadoras.data ?? []).map((item) => ({
    value: item.id ?? item.id_transportadora,
    label: item.nome_transportadora ?? item.nome ?? `Transportadora ${item.id}`,
  }));
  const localizacaoOptions = (localizacoes.data ?? []).map((item) => ({
    value: item.id,
    label: `${item.cidade} · ${item.estado}${item.regiao ? ` · ${item.regiao}` : ""}`,
  }));

  const produtosData = produtos.data?.data ?? produtos.data?.items ?? produtos.data ?? [];
  const selectedProdutoData = produtosData.find((item) => String(item.id) === String(data.fk_produto ?? ""));
  const valorUnitarioAtual = Number(data.valor_unitario ?? 0);
  const quantidadeAtual = Number(data.quantidade ?? 0);
  const valorTotalMovimentacao = valorUnitarioAtual * quantidadeAtual;

  useEffect(() => {
    if (entity !== "movimentacoes") return;
    if (!selectedProdutoData) return;
    onChange((prev) => {
      if (Number(prev.valor_unitario ?? 0) > 0) return prev;
      const custo = Number(selectedProdutoData.custo_unitario ?? 0);
      return { ...prev, valor_unitario: custo ? String(custo) : prev.valor_unitario };
    });
  }, [entity, selectedProdutoData, onChange]);

  if (entity === "movimentacoes") return (
    <>
      <Field label="Produto">
        <SearchSelect
          value={data.fk_produto ?? ""}
          onChange={(value) => onChange((prev) => ({ ...prev, fk_produto: value }))}
          options={produtoOptions}
          placeholder="Buscar produto por nome"
        />
      </Field>
      <Field label="Data"><input type="date" value={data.data_movimentacao ?? ""} onChange={set("data_movimentacao")} /></Field>
      <Field label="Tipo de movimentacao">
        <SearchSelect
          value={data.fk_tipo_movimentacao ?? ""}
          onChange={(value) => onChange((prev) => ({ ...prev, fk_tipo_movimentacao: value }))}
          options={tipoOptions}
          placeholder="Buscar tipo de movimentacao"
        />
      </Field>
      <div className="grid grid-2" style={{ gap: 12 }}>
        <Field label="Quantidade"><input type="number" value={data.quantidade ?? ""} onChange={set("quantidade")} /></Field>
        <Field label="Valor unitário"><input value={data.valor_unitario ?? ""} onChange={set("valor_unitario")} placeholder="R$ 0,00" /></Field>
      </div>
      <div className="grid grid-2" style={{ gap: 12 }}>
        <Field label="Produto selecionado">
          <input value={selectedProdutoData?.nome_produto ?? ""} readOnly placeholder="Selecione um produto" />
        </Field>
        <Field label="Valor total da movimentacao">
          <input value={valorTotalMovimentacao ? fmt.brl(valorTotalMovimentacao) : ""} readOnly placeholder="Calculado automaticamente" />
        </Field>
      </div>
      <Field label="Fornecedor (opcional)">
        <SearchSelect
          value={data.fk_fornecedor ?? ""}
          onChange={(value) => onChange((prev) => ({ ...prev, fk_fornecedor: value }))}
          options={fornecedorOptions}
          placeholder="Buscar fornecedor"
          emptyLabel="Nenhum fornecedor encontrado."
        />
      </Field>
    </>
  );
  if (entity === "fretes") return (
    <>
      {drawerMode === "create" && (
        <>
          <Field label="Nº do pedido"><input type="number" value={data.numero_pedido ?? ""} onChange={set("numero_pedido")} /></Field>
          <div className="grid grid-2" style={{ gap: 12 }}>
            <Field label="Localizacao origem">
              <SearchSelect
                value={data.fk_localizacao_origem ?? ""}
                onChange={(value) => onChange((prev) => ({ ...prev, fk_localizacao_origem: value }))}
                options={localizacaoOptions}
                placeholder="Buscar cidade ou estado"
              />
            </Field>
            <Field label="Localizacao destino">
              <SearchSelect
                value={data.fk_localizacao_destino ?? ""}
                onChange={(value) => onChange((prev) => ({ ...prev, fk_localizacao_destino: value }))}
                options={localizacaoOptions}
                placeholder="Buscar cidade ou estado"
              />
            </Field>
          </div>
          <div className="grid grid-2" style={{ gap: 12 }}>
            <Field label="Data envio"><input type="date" value={data.data_envio ?? ""} onChange={set("data_envio")} /></Field>
            <Field label="Data entrega"><input type="date" value={data.data_entrega ?? ""} onChange={set("data_entrega")} /></Field>
          </div>
        </>
      )}
      <Field label="Transportadora">
        <SearchSelect
          value={data.fk_transportadora ?? ""}
          onChange={(value) => onChange((prev) => ({ ...prev, fk_transportadora: value }))}
          options={transportadoraOptions}
          placeholder="Buscar transportadora"
        />
      </Field>
      <div className="grid grid-3" style={{ gap: 12 }}>
        <Field label="Peso (kg)"><input value={data.peso_total_kg ?? ""} onChange={set("peso_total_kg")} /></Field>
        <Field label="Valor frete"><input value={data.valor_frete ?? ""} onChange={set("valor_frete")} /></Field>
        <Field label="Prazo (d)"><input type="number" value={data.prazo_entrega_dias ?? ""} onChange={set("prazo_entrega_dias")} /></Field>
      </div>
      <Field label="Status">
        <select value={data.status_frete ?? "Aguardando"} onChange={set("status_frete")}>
          <option value="Aguardando">Aguardando</option>
          <option value="Coletado">Coletado</option>
          <option value="Em Trânsito">Em Trânsito</option>
          <option value="Entregue">Entregue</option>
          <option value="Devolvido">Devolvido</option>
          <option value="Extraviado">Extraviado</option>
        </select>
      </Field>
    </>
  );
  if (entity === "transportadoras") return (
    <>
      <Field label="Nome"><input value={data.nome_transportadora ?? ""} onChange={set("nome_transportadora")} /></Field>
      <div className="grid grid-2" style={{ gap: 12 }}>
        <Field label="CNPJ"><input value={data.cnpj ?? ""} onChange={set("cnpj")} /></Field>
        <Field label="Telefone"><input value={data.telefone ?? ""} onChange={set("telefone")} /></Field>
      </div>
      <div className="grid grid-2" style={{ gap: 12 }}>
        <Field label="Prazo médio (d)"><input type="number" value={data.media_entrega ?? ""} onChange={set("media_entrega")} /></Field>
        <Field label="Frete base / kg"><input value={data.frete_kg_base ?? ""} onChange={set("frete_kg_base")} /></Field>
      </div>
      <Field label="Status">
        <select value={data.ativo === false || data.ativo === "false" ? "false" : "true"} onChange={set("ativo")}>
          <option value="true">Ativo</option>
          <option value="false">Inativo</option>
        </select>
      </Field>
    </>
  );
  return (
    <p style={{ color: "var(--fg-3)", fontSize: 13 }}>
      O saldo de SKUs é calculado automaticamente com base nas movimentações registradas.
      Para ajustar o saldo, registre uma nova movimentação de entrada ou saída.
    </p>
  );
}
