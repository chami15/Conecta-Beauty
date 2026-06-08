import { useState, useEffect, useMemo } from "react";
import { I } from "../components/icons";
import {
  Card, KPI, ManageDropdown, AnalysisFilter, CrudToolbar, DataTable,
  Drawer, Field, Insight, BarList, Heatmap, SearchSelect,
  useApi, LoadingState, ErrorState, Pagination, DonutLegend,
  Donut, fmt,
} from "../components/ui";
import { BarChart } from "../components/ChartComponents";
import { api } from "../api";
import { YEAR_OPTIONS, createAnalysisFilter, formatAnalysisWindow, toApiTimeParams } from "../utils/time";
import "../css/Administrativo.css";

export default function Administrativo() {
  const [route, setRoute] = useState("dashboard");
  const [selected, setSelected] = useState(new Set());
  const [drawerOpen, setDrawerOpen] = useState(false);
  const [drawerMode, setDrawerMode] = useState("create");
  const [drawerRow, setDrawerRow] = useState(null);
  const [formData, setFormData] = useState({});
  const [filter, setFilter] = useState(createAnalysisFilter(String(YEAR_OPTIONS[0] ?? "")));
  const [page, setPage] = useState(1);
  const [crudReload, setCrudReload] = useState(0);
  const [saveError, setSaveError] = useState(null);
  const [crudError, setCrudError] = useState(null);

  const toggle = (id) => { const n = new Set(selected); n.has(id) ? n.delete(id) : n.add(id); setSelected(n); };
  useEffect(() => { setSelected(new Set()); setPage(1); setCrudError(null); }, [route]);

  const openCreate = () => {
    setFormData({});
    setSaveError(null);
    setCrudError(null);
    setDrawerMode("create");
    setDrawerRow(null);
    setDrawerOpen(true);
  };

  const openEdit = (row) => {
    setFormData(row ?? {});
    setSaveError(null);
    setCrudError(null);
    setDrawerMode("edit");
    setDrawerRow(row);
    setDrawerOpen(true);
  };

  const handleEditToolbar = async () => {
    if (selected.size !== 1) return;
    const [id] = [...selected];
    try {
      const row = route === "canais"
        ? await api.admin.canais.get(id)
        : await api.admin[route]?.get(id);
      openEdit(row);
    } catch (e) {
      setCrudError("Nao foi possivel carregar o registro para edicao.");
    }
  };

  const handleSave = async () => {
    setSaveError(null);
    try {
      let body = { ...formData };

      if (route === "clientes") {
        if (body.fk_localizacao) body.fk_localizacao = parseInt(body.fk_localizacao) || null;
      } else if (route === "produtos") {
        body.custo_unitario = parseFloat(body.custo_unitario) || 0;
        if (body.peso_kg) body.peso_kg = parseFloat(body.peso_kg) || null;
        body.estoque_min = parseInt(body.estoque_min) || 0;
        body.estoque_max = body.estoque_max ? parseInt(body.estoque_max) : null;
        body.ativo = body.ativo !== "false" && body.ativo !== false;
        if (body.id_categoria) body.id_categoria = parseInt(body.id_categoria) || null;
        if (body.id_fornecedor) body.id_fornecedor = parseInt(body.id_fornecedor) || null;
      } else if (route === "fornecedores") {
        if (body.id_localizacao) body.id_localizacao = parseInt(body.id_localizacao) || null;
      } else if (route === "canais") {
        body.ativo = body.ativo !== "false" && body.ativo !== false;
        if (!body.tipo_canal) body.tipo_canal = "Online";
      }

      if (drawerMode === "create") {
        await api.admin[route].create(body);
      } else {
        await api.admin[route].update(drawerRow?.id, body);
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
        await api.admin[route]?.delete(id);
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
    { id: "clientes", label: "Clientes", icon: <I.users size={15} /> },
    { id: "produtos", label: "Produtos", icon: <I.box size={15} /> },
    { id: "fornecedores", label: "Fornecedores", icon: <I.truck size={15} /> },
    { id: "canais", label: "Canais de venda", icon: <I.store size={15} /> },
  ];

  const titleMap = { dashboard: "Visão administrativa", clientes: "Clientes", produtos: "Produtos", fornecedores: "Fornecedores", canais: "Canais de venda" };

  const drawerTitle = {
    clientes: drawerMode === "edit" ? "Editar cliente" : "Novo cliente",
    produtos: drawerMode === "edit" ? "Editar produto" : "Novo produto",
    fornecedores: drawerMode === "edit" ? "Editar fornecedor" : "Novo fornecedor",
    canais: drawerMode === "edit" ? "Editar canal" : "Novo canal",
  }[route] || "Registro";

  return (
    <>
      <div className="screen-pad screen-anim">
        <div className="screen-header">
          <div>
            <div className="screen-eyebrow">02 · Administrativo</div>
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
          ? <AdminDashboard filter={filter} onOpenCanais={() => setRoute("canais")} />
          : <AdminCrud
              entity={route}
              page={page}
              onPage={setPage}
              reload={crudReload}
              actionError={crudError}
              selected={selected}
              toggle={toggle}
              setSelected={setSelected}
              onAdd={openCreate}
              onEdit={handleEditToolbar}
              onRowEdit={openEdit}
              onDelete={handleDelete}
            />
        }
      </div>

      <Drawer
        open={drawerOpen}
        onClose={() => setDrawerOpen(false)}
        eyebrow={drawerMode === "edit" ? "EDITAR REGISTRO" : "NOVO REGISTRO"}
        title={drawerTitle}
        footer={
          <>
            <button className="btn ghost" onClick={() => setDrawerOpen(false)}>Cancelar</button>
            <button className="btn primary" onClick={handleSave}><I.check size={13} /> Salvar</button>
          </>
        }
      >
        {saveError && (
          <div style={{ padding: "10px 14px", background: "rgba(255,84,112,0.1)", border: "1px solid rgba(255,84,112,0.3)", borderRadius: 6, color: "var(--neg)", fontSize: 12, marginBottom: 16 }}>
            {saveError}
          </div>
        )}
        <AdminForm entity={route} data={formData} onChange={setFormData} />
      </Drawer>
    </>
  );
}

/* ─── Dashboard ─── */
function AdminDashboard({ filter, onOpenCanais }) {
  const timeParams = toApiTimeParams(filter);
  const kpis    = useApi(() => api.admin.kpis(timeParams), [filter.scope, filter.year, filter.month]);
  const canais  = useApi(() => api.admin.canaisPorVenda(timeParams), [filter.scope, filter.year, filter.month]);
  const regioes = useApi(() => api.admin.clientesPorRegiao(timeParams), [filter.scope, filter.year, filter.month]);
  const anova   = useApi(() => api.analytics.anovaCanais(timeParams), [filter.scope, filter.year, filter.month]);

  const k = kpis.data || {};

  const prodLider = k.produto_lider;
  const meCliente = k.melhor_cliente;
  const topForn   = k.top_fornecedor;
  const canal1    = k.canal_numero1;

  const canaisData   = canais.data || [];
  const canaisLabels = canaisData.map((c) => c.canal ?? c.canal_venda ?? c.nome ?? "");
  const canaisValues = canaisData.map((c) => c.faturamento ?? c.total ?? 0);
  const totalCanais = canaisValues.reduce((acc, value) => acc + value, 0);
  const leaderShare = totalCanais > 0 ? ((canaisValues[0] ?? 0) / totalCanais) * 100 : 0;
  const gapTop2 = (canaisValues[0] ?? 0) - (canaisValues[1] ?? 0);

  /* Heatmap: transform flat list [{regiao, estado, faturamento}] → matrix */
  const regList  = Array.isArray(regioes.data) ? regioes.data : [];
  const heatRows = useMemo(() => [...new Set(regList.map((r) => r.regiao))], [regList]);
  const heatCols = useMemo(() => [...new Set(regList.map((r) => r.estado))], [regList]);
  const heatVals = useMemo(() =>
    heatRows.map((reg) =>
      heatCols.map((est) => {
        const found = regList.find((r) => r.regiao === reg && r.estado === est);
        return found ? Math.round(found.faturamento) : 0;
      })
    ), [regList, heatRows, heatCols]);

  const heatRowsFinal = heatRows.length ? heatRows : ["Sudeste", "Sul", "Nordeste", "Centro-O.", "Norte"];
  const heatColsFinal = heatCols.length ? heatCols : ["SP", "RJ", "MG", "RS", "PR", "BA"];
  const heatValsFinal = heatVals.length ? heatVals : [[0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0]];

  return (
    <>
      {kpis.loading ? <LoadingState /> : kpis.error ? <ErrorState msg={kpis.error} /> : (
        <div className="grid grid-4" style={{ marginBottom: 16 }}>
          <Card compact>
            <KPI text label="Produto líder" value={prodLider?.nome ?? "—"}
              deltaLabel={prodLider ? fmt.brl(prodLider.faturamento) : ""} />
          </Card>
          <Card compact>
            <KPI text label="Melhor cliente (LTV)" value={meCliente?.nome ?? "—"}
              deltaLabel={meCliente ? fmt.brl(meCliente.faturamento) : ""} />
          </Card>
          <Card compact>
            <KPI text label="Top fornecedor" value={topForn?.nome ?? "—"}
              deltaLabel={topForn ? fmt.brl(topForn.faturamento) : ""} />
          </Card>
          <Card compact>
            <KPI text label="Canal nº 1" value={canal1?.nome ?? "—"}
              deltaLabel={canal1 ? `${canal1.qtd_pedidos} pedidos` : ""} />
          </Card>
        </div>
      )}

      <div className="grid grid-12" style={{ marginBottom: 16 }}>
        <div className="col-7">
          <Card title="Canais de venda" sub="FATURAMENTO POR CANAL">
            {canais.loading ? <LoadingState /> : canais.error ? <ErrorState msg={canais.error} /> : (
              <>
                {canaisLabels.length > 0
                  ? <BarChart
                      labels={canaisLabels}
                      datasets={[{ label: "Faturamento", data: canaisValues, backgroundColor: canaisValues.map((_, i) => i === 0 ? "#22d47a" : "#5b8eff"), borderRadius: 4 }]}
                      height={220}
                      yFormat={(v) => "R$" + Math.round(v / 1000) + "k"}
                    />
                  : <p style={{ color: "var(--fg-4)", fontSize: 13, padding: "20px 0" }}>Sem dados de canais.</p>
                }
                {canaisLabels.length > 0 && (
                  <div className="row" style={{ gap: 16, marginTop: 16, paddingTop: 16, borderTop: "1px solid var(--line)" }}>
                    <StatMini label="Canal líder" value={canaisLabels[0] ?? "—"} />
                    <StatMini label="Participação" value={`${leaderShare.toFixed(1)}%`} />
                    <StatMini label="Diferença p/ 2º" value={fmt.brl(gapTop2)} />
                    <StatMini label="Janela" value={formatAnalysisWindow(filter)} />
                  </div>
                )}
              </>
            )}
            {!anova.loading && !anova.error && anova.data?.anova && (
              <div className="stats-inline" style={{ marginTop: 12 }}>
                <div className="stats-inline-item">
                  <span className="stats-inline-label">Análise estatística</span>
                  <span className={`stats-inline-value ${anova.data.anova.significativo ? "sig" : "warn"}`}>
                    {anova.data.anova.significativo
                      ? "Canais têm desempenho estatisticamente diferente ✓"
                      : "Desempenho similar entre canais de venda"
                    }
                  </span>
                </div>
                {(anova.data.anova.p_value ?? 1) < 0.05 && (
                  <>
                    <div style={{ width: 1, height: 14, background: "var(--line-2)" }} />
                    <div className="stats-inline-item">
                      <span className="stats-inline-label">Confiança</span>
                      <span className="stats-inline-value sig">
                        {(100 - (anova.data.anova.p_value ?? 0) * 100).toFixed(0)}%
                      </span>
                    </div>
                  </>
                )}
              </div>
            )}
            {!anova.loading && !anova.error && anova.data?.anova?.p_value != null && (
              <Insight tone={anova.data.anova.significativo ? "pos" : "warn"} icon={<I.sigma size={14} />} title="Como ler este gráfico" action={null}>
                {anova.data.anova.significativo
                  ? `Há diferença estatística entre os canais. P-valor: ${(anova.data.anova.p_value ?? 0).toFixed(4)}.`
                  : `Os canais variam pouco entre si neste recorte. P-valor: ${(anova.data.anova.p_value ?? 0).toFixed(4)}.`
                }
              </Insight>
            )}
            <div className="divider" style={{ marginTop: 12 }} />
            <div className="row between">
              <span style={{ fontSize: 12, color: "var(--fg-3)" }}>Faturamento por canal de venda.</span>
              <button className="btn ghost" style={{ fontSize: 12 }} onClick={onOpenCanais}>Ver detalhes <I.arrowRight size={12} /></button>
            </div>
          </Card>
        </div>

        <div className="col-5">
          <Card title="Clientes por região" sub="LTV ACUMULADO">
            {regioes.loading ? <LoadingState /> : regioes.error ? <ErrorState msg={regioes.error} /> : (
              <>
                <Heatmap
                  rows={heatRowsFinal}
                  cols={heatColsFinal}
                  format={(v) => v > 1000 ? Math.round(v / 1000) + "k" : v}
                  color="var(--accent)"
                  values={heatValsFinal}
                />
                <div className="divider" />
                <Insight tone="pos" icon={<I.pin size={14} />} title="Maior concentração no Sudeste">
                  SP lidera o LTV acumulado dos clientes.
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
function AdminCrud({ entity, page, onPage, reload, selected, toggle, setSelected, onAdd, onEdit, onRowEdit, onDelete, actionError }) {
  const [search, setSearch] = useState("");
  const [filters, setFilters] = useState({});

  useEffect(() => {
    setSearch("");
    setFilters({});
  }, [entity]);

  const queryPage = search ? 1 : page;
  const querySize = search ? 100 : 20;

  const { data, loading, error } = useApi(
    () => entity === "canais" ? api.admin.canais.list() : api.admin[entity]?.list(queryPage, querySize),
    [entity, queryPage, querySize, reload]
  );

  const rawRows = Array.isArray(data) ? data : (data?.items ?? data?.data ?? []);

  const rows = useMemo(() => {
    const q = search.toLowerCase();
    return rawRows.filter((r) => {
      if (q && !JSON.stringify(r).toLowerCase().includes(q)) return false;
      if ((entity === "clientes" || entity === "fornecedores") && filters.estado && r.estado !== filters.estado) return false;
      if ((entity === "produtos" || entity === "canais") && filters.ativo) {
        const ativo = Boolean(r.ativo);
        if (filters.ativo === "ativos" && !ativo) return false;
        if (filters.ativo === "inativos" && ativo) return false;
      }
      return true;
    }).sort((a, b) => Number(b.id ?? 0) - Number(a.id ?? 0));
  }, [rawRows, search, entity, filters]);

  const total = search ? rows.length : (data?.total ?? rawRows.length);
  const hasActiveFilters = Object.values(filters).some(Boolean);

  const cols = useMemo(() => {
    if (entity === "clientes") return [
      { key: "nome", label: "Cliente", render: (r) => (
        <div>
          <div style={{ color: "var(--fg)" }}>{r.nome ?? r.nome_cliente ?? "—"}</div>
          <div className="mono" style={{ fontSize: 11, color: "var(--fg-4)", marginTop: 2 }}>{r.documento ?? ""}</div>
        </div>
      )},
      { key: "localizacao", label: "Localização", render: (r) => <span style={{ color: "var(--fg-2)" }}>{r.cidade ?? ""}{r.estado ? " · " + r.estado : ""}</span> },
      { key: "telefone", label: "Telefone", render: (r) => <span className="mono" style={{ color: "var(--fg-3)", fontSize: 12 }}>{r.telefone ?? "—"}</span> },
    ];
    if (entity === "produtos") return [
      { key: "nome", label: "Produto", render: (r) => (
        <div className="row" style={{ gap: 10 }}>
          <span style={{ width: 30, height: 30, borderRadius: 6, background: "var(--bg-1)", border: "1px solid var(--line)", display: "grid", placeItems: "center" }}>
            <I.box size={13} style={{ color: "var(--fg-3)" }} />
          </span>
          <div>
            <div style={{ color: "var(--fg)" }}>{r.nome_produto ?? r.nome ?? "—"}</div>
            <div className="mono" style={{ fontSize: 11, color: "var(--fg-4)", marginTop: 2 }}>{r.sku ?? ""}</div>
          </div>
        </div>
      )},
      { key: "custo_unitario", label: "Custo", num: true, width: 120, render: (r) => fmt.brl(r.custo_unitario ?? 0) },
      { key: "estoque_min", label: "Estoque mín.", num: true, width: 110, render: (r) => <span className="mono">{r.estoque_min ?? 0}</span> },
      { key: "ativo", label: "Status", width: 100, render: (r) => (
        <span className={"chip " + (r.ativo ? "pos" : "neg")}>{r.ativo ? "Ativo" : "Inativo"}</span>
      )},
    ];
    if (entity === "fornecedores") return [
      { key: "nome", label: "Fornecedor", render: (r) => (
        <div>
          <div style={{ color: "var(--fg)" }}>{r.nome_fornecedor ?? r.nome ?? "—"}</div>
          <div className="mono" style={{ fontSize: 11, color: "var(--fg-4)", marginTop: 2 }}>{r.cnpj ?? ""}</div>
        </div>
      )},
      { key: "telefone", label: "Telefone", render: (r) => <span className="mono" style={{ color: "var(--fg-3)", fontSize: 12 }}>{r.telefone ?? "—"}</span> },
    ];
    return [
      { key: "nome", label: "Canal de venda", render: (r) => (
        <div className="row" style={{ gap: 10 }}>
          <span style={{ width: 30, height: 30, borderRadius: 6, background: "var(--bg-1)", border: "1px solid var(--line)", display: "grid", placeItems: "center" }}>
            <I.store size={14} style={{ color: "var(--fg-2)" }} />
          </span>
          <div>
            <div style={{ color: "var(--fg)" }}>{r.canal_venda ?? r.nome ?? "—"}</div>
            <div style={{ fontSize: 11, color: "var(--fg-4)", marginTop: 2 }}>{r.tipo_canal ?? ""}</div>
          </div>
        </div>
      )},
      { key: "ativo", label: "Status", width: 100, render: (r) => (
        <span className={"chip " + (r.ativo ? "pos" : "neg")}>{r.ativo ? "Ativo" : "Pausado"}</span>
      )},
    ];
  }, [entity]);

  const filterContent = useMemo(() => {
    const estados = [...new Set(rawRows.map((row) => row.estado).filter(Boolean))].sort();

    if (entity === "clientes" || entity === "fornecedores") {
      return (
        <Field label="Estado">
          <select value={filters.estado ?? ""} onChange={(e) => setFilters((prev) => ({ ...prev, estado: e.target.value }))}>
            <option value="">Todos</option>
            {estados.map((estado) => <option key={estado} value={estado}>{estado}</option>)}
          </select>
        </Field>
      );
    }

    if (entity === "produtos" || entity === "canais") {
      return (
        <Field label="Status">
          <select value={filters.ativo ?? ""} onChange={(e) => setFilters((prev) => ({ ...prev, ativo: e.target.value }))}>
            <option value="">Todos</option>
            <option value="ativos">Ativos</option>
            <option value="inativos">Inativos</option>
          </select>
        </Field>
      );
    }

    return null;
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

/* ─── Forms (controlled) ─── */
function AdminForm({ entity, data = {}, onChange }) {
  const set = (field) => (e) => onChange((prev) => ({ ...prev, [field]: e.target.value }));
  const localizacoes = useApi(() => api.admin.localizacoes("", 100), []);
  const categorias = useApi(() => api.admin.categorias("", 100), []);
  const fornecedores = useApi(() => api.admin.fornecedores.list(1, 100), []);

  const localizacaoOptions = (localizacoes.data ?? []).map((item) => ({
    value: item.id,
    label: `${item.cidade} · ${item.estado}${item.regiao ? ` · ${item.regiao}` : ""}`,
  }));
  const categoriaOptions = (categorias.data ?? []).map((item) => ({
    value: item.id,
    label: `${item.categoria}${item.subcategoria ? ` · ${item.subcategoria}` : ""}`,
  }));
  const fornecedorOptions = (fornecedores.data?.data ?? fornecedores.data?.items ?? fornecedores.data ?? []).map((item) => ({
    value: item.id,
    label: item.nome_fornecedor ?? item.nome ?? `Fornecedor ${item.id}`,
  }));

  if (entity === "clientes") return (
    <>
      <Field label="Nome completo"><input value={data.nome ?? ""} onChange={set("nome")} placeholder="Ex.: Studio Allure SP" /></Field>
      <div className="grid grid-2" style={{ gap: 12 }}>
        <Field label="Documento"><input value={data.documento ?? ""} onChange={set("documento")} placeholder="CPF / CNPJ" /></Field>
        <Field label="Sexo">
          <select value={data.sexo ?? ""} onChange={set("sexo")}>
            <option value="">Selecione</option>
            <option value="F">Feminino</option>
            <option value="M">Masculino</option>
            <option value="O">Outro</option>
          </select>
        </Field>
      </div>
      <Field label="Telefone"><input value={data.telefone ?? ""} onChange={set("telefone")} placeholder="(11) 9 0000-0000" /></Field>
      <Field label="Localizacao">
        <SearchSelect
          value={data.fk_localizacao ?? ""}
          onChange={(value) => onChange((prev) => ({ ...prev, fk_localizacao: value }))}
          options={localizacaoOptions}
          placeholder="Buscar cidade ou estado"
        />
      </Field>
      <Field label="Endereço completo"><textarea rows={2} value={data.endereco_completo ?? ""} onChange={set("endereco_completo")} placeholder="Rua, número, bairro, cidade, estado" /></Field>
    </>
  );
  if (entity === "produtos") return (
    <>
      <Field label="Nome do produto"><input value={data.nome_produto ?? ""} onChange={set("nome_produto")} placeholder="Ex.: Cadeira Bella Reclinável" /></Field>
      <Field label="Descrição"><textarea rows={2} value={data.descricao ?? ""} onChange={set("descricao")} /></Field>
      <div className="grid grid-2" style={{ gap: 12 }}>
        <Field label="Custo unitário"><input value={data.custo_unitario ?? ""} onChange={set("custo_unitario")} placeholder="R$ 0,00" /></Field>
        <Field label="Peso (kg)"><input value={data.peso_kg ?? ""} onChange={set("peso_kg")} placeholder="0,00" /></Field>
      </div>
      <div className="grid grid-2" style={{ gap: 12 }}>
        <Field label="Estoque mín."><input type="number" value={data.estoque_min ?? 0} onChange={set("estoque_min")} /></Field>
        <Field label="Estoque máx."><input type="number" value={data.estoque_max ?? ""} onChange={set("estoque_max")} /></Field>
      </div>
      <div className="grid grid-2" style={{ gap: 12 }}>
        <Field label="Categoria">
          <SearchSelect
            value={data.id_categoria ?? ""}
            onChange={(value) => onChange((prev) => ({ ...prev, id_categoria: value }))}
            options={categoriaOptions}
            placeholder="Buscar categoria"
          />
        </Field>
        <Field label="Fornecedor">
          <SearchSelect
            value={data.id_fornecedor ?? ""}
            onChange={(value) => onChange((prev) => ({ ...prev, id_fornecedor: value }))}
            options={fornecedorOptions}
            placeholder="Buscar fornecedor"
          />
        </Field>
      </div>
      <Field label="Ativo">
        <select value={String(data.ativo ?? true)} onChange={set("ativo")}><option value="true">Ativo</option><option value="false">Inativo</option></select>
      </Field>
    </>
  );
  if (entity === "fornecedores") return (
    <>
      <Field label="Nome fornecedor"><input value={data.nome_fornecedor ?? ""} onChange={set("nome_fornecedor")} placeholder="Ex.: MD Industrial" /></Field>
      <div className="grid grid-2" style={{ gap: 12 }}>
        <Field label="CNPJ"><input value={data.cnpj ?? ""} onChange={set("cnpj")} placeholder="00.000.000/0000-00" /></Field>
        <Field label="Telefone"><input value={data.telefone ?? ""} onChange={set("telefone")} /></Field>
      </div>
      <Field label="Localizacao">
        <SearchSelect
          value={data.id_localizacao ?? ""}
          onChange={(value) => onChange((prev) => ({ ...prev, id_localizacao: value }))}
          options={localizacaoOptions}
          placeholder="Buscar cidade ou estado"
        />
      </Field>
      <Field label="Endereço completo"><textarea rows={2} value={data.endereco_completo ?? ""} onChange={set("endereco_completo")} /></Field>
    </>
  );
  return (
    <>
      <Field label="Nome do canal"><input value={data.canal_venda ?? ""} onChange={set("canal_venda")} /></Field>
      <Field label="Tipo de canal">
        <select value={data.tipo_canal ?? ""} onChange={set("tipo_canal")}>
          <option value="">Selecione</option><option>Online</option><option>Físico</option><option>Híbrido</option><option>Marketplace</option>
        </select>
      </Field>
      <Field label="Status">
        <select value={String(data.ativo ?? true)} onChange={set("ativo")}><option value="true">Ativo</option><option value="false">Pausado</option></select>
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
