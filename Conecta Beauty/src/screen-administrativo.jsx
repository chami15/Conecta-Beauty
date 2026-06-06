/* Tela ADMINISTRATIVO — sidebar Dashboard + entidades CRUD */

const ScreenAdministrativo = () => {
  const [route, setRoute] = useState("dashboard");
  const [collapsed, setCollapsed] = useState(false);
  const [selected, setSelected] = useState(new Set());
  const [drawerOpen, setDrawerOpen] = useState(false);
  const [period, setPeriod] = useState("30d");

  const toggle = (id) => {
    const n = new Set(selected);
    n.has(id) ? n.delete(id) : n.add(id);
    setSelected(n);
  };

  useEffect(() => { setSelected(new Set()); }, [route]);

  const sideItems = [
    { id: "dashboard", label: "Dashboard", icon: <I.chart size={15}/> },
    { section: "Gerenciar" },
    { id: "clientes", label: "Clientes", icon: <I.users size={15}/> },
    { id: "produtos", label: "Produtos", icon: <I.box size={15}/> },
    { id: "fornecedores", label: "Fornecedores", icon: <I.truck size={15}/> },
    { id: "canais", label: "Canais de venda", icon: <I.store size={15}/> },
  ];

  return (
    <>
      <div className="with-sidebar">
        <SideNav
          items={sideItems}
          value={route}
          onChange={setRoute}
          collapsed={collapsed}
          onToggle={() => setCollapsed(!collapsed)}
        />
        <div className="inner-body screen-anim">
          <div className="screen-header">
            <div>
              <div className="screen-eyebrow">02 · Administrativo</div>
              <div className="screen-title">
                {route === "dashboard" ? "Visão administrativa" : ({
                  clientes: "Clientes", produtos: "Produtos", fornecedores: "Fornecedores", canais: "Canais de venda"
                }[route])}
              </div>
            </div>
            {route === "dashboard" && (
              <PeriodSelector value={period} onChange={setPeriod} options={["7d", "30d", "Trim", "Ano", "Tudo"]}/>
            )}
          </div>

          {route === "dashboard"
            ? <AdminDashboard/>
            : <AdminCrud entity={route} selected={selected} toggle={toggle} setSelected={setSelected}
                         onAdd={() => setDrawerOpen(true)} onEdit={() => setDrawerOpen(true)}/>
          }
        </div>
      </div>

      <Drawer
        open={drawerOpen}
        onClose={() => setDrawerOpen(false)}
        eyebrow="NOVO REGISTRO"
        title={({ clientes: "Novo cliente", produtos: "Novo produto", fornecedores: "Novo fornecedor", canais: "Novo canal" }[route] || "Novo registro")}
        footer={
          <>
            <button className="btn ghost" onClick={() => setDrawerOpen(false)}>Cancelar</button>
            <button className="btn primary"><I.check size={13}/> Salvar</button>
          </>
        }
      >
        <AdminForm entity={route}/>
      </Drawer>
    </>
  );
};

/* ---------- DASHBOARD VIEW ---------- */
const AdminDashboard = () => (
  <>
    <div className="grid grid-4" style={{ marginBottom: 16 }}>
      <Card>
        <KPI
          label="Produto líder"
          value="Cadeira Bella"
          delta={18.4}
          deltaLabel="42 un · R$ 58.4k em 30d"
          sparkline={<Sparkline data={[8,9,11,10,13,15,14,17,19,21]} width={200} height={32} color="var(--pos)"/>}
        />
      </Card>
      <Card>
        <KPI
          label="Melhor cliente (LTV)"
          value="Studio Allure"
          delta={9.2}
          deltaLabel="R$ 184k · 14 pedidos"
          sparkline={<MiniBars data={[2,3,5,4,6,7,5,8,9,11]} width={200} height={32} color="var(--pos)"/>}
        />
      </Card>
      <Card>
        <KPI
          label="Top fornecedor"
          value="MD Industrial"
          delta={-1.4}
          deltaLabel="38% das compras · 12d"
          sparkline={<Sparkline data={[14,13,15,14,12,13,12,11,12,12]} width={200} height={32} color="var(--warn)" fill={false}/>}
        />
      </Card>
      <Card>
        <KPI
          label="Canal nº 1"
          value="E-commerce"
          delta={38.1}
          deltaLabel="42% do faturamento"
          sparkline={<Sparkline data={[12,14,13,16,18,17,21,25,28,32,38,42]} width={200} height={32} color="var(--pos)"/>}
        />
      </Card>
    </div>

    <div className="grid grid-12" style={{ marginBottom: 16 }}>
      <div className="col-7">
        <Card title="Canais de venda" sub="FATURAMENTO POR CANAL · ÚLTIMOS 12 MESES">
          <BarList
            format={fmt.brl}
            color="var(--pos)"
            items={[
              { label: "E-commerce próprio", sub: "Online · +38% no mês", value: 184200, delta: 38.1, color: "var(--pos)" },
              { label: "Loja física Centro", sub: "Físico · São Paulo, SP", value: 142800, delta: 6.4, color: "var(--pos)" },
              { label: "Mercado Livre", sub: "Marketplace · volume alto", value: 89400, delta: 14.2, color: "var(--pos)" },
              { label: "Magalu / Madeira", sub: "Marketplace", value: 38100, delta: -8.3, color: "var(--neg)" },
              { label: "B2B Salões parceiros", sub: "Híbrido · contratos anuais", value: 32790, delta: 22.7, color: "var(--pos)" },
            ]}
          />
          <div className="divider"/>
          <div className="row between">
            <span className="muted" style={{ fontSize: 12 }}>
              E-commerce ultrapassou loja física pela 1ª vez em Abril.
            </span>
            <button className="btn ghost">Detalhar <I.arrowRight size={12}/></button>
          </div>
        </Card>
      </div>

      <div className="col-5">
        <Card title="Melhores clientes por região" sub="LTV ACUMULADO · POR ESTADO">
          <Heatmap
            rows={["Sudeste", "Sul", "Nordeste", "Centro-O.", "Norte"]}
            cols={["SP", "RJ", "MG", "RS", "PR", "BA"]}
            format={(v) => v + "k"}
            color="var(--pos)"
            values={[
              [184, 92, 64, 18, 22, 14],
              [12,  8,  6,  84, 76, 8],
              [22,  18, 14, 6,  10, 96],
              [8,   4,  6,  12, 8,  6],
              [4,   2,  2,  3,  4,  6],
            ]}
          />
          <div className="divider"/>
          <Insight tone="pos" icon={<I.pin size={14}/>} title="Bahia subiu 3 posições no ranking">
            Maior crescimento regional · revisar logística pra N/NE.
          </Insight>
        </Card>
      </div>
    </div>
  </>
);

/* ---------- CRUD VIEW ---------- */
const AdminCrud = ({ entity, selected, toggle, setSelected, onAdd, onEdit }) => {
  const rows = useMemo(() => {
    if (entity === "clientes") return CLIENTES;
    if (entity === "produtos") return PRODUTOS;
    if (entity === "fornecedores") return FORNECEDORES;
    return CANAIS;
  }, [entity]);

  const cols = useMemo(() => {
    if (entity === "clientes") return [
      { key: "nome", label: "Cliente", render: (r) => (
        <div>
          <div style={{ color: "var(--fg)" }}>{r.nome}</div>
          <div className="mono" style={{ fontSize: 11, color: "var(--fg-4)", marginTop: 2 }}>{r.doc}</div>
        </div>
      )},
      { key: "regiao", label: "Região / Cidade", render: (r) => (
        <div>
          <div>{r.cidade} · {r.estado}</div>
          <div style={{ fontSize: 11, color: "var(--fg-4)", marginTop: 2 }}>{r.regiao}</div>
        </div>
      )},
      { key: "pedidos", label: "Pedidos", num: true, width: 90 },
      { key: "ticket", label: "Ticket médio", num: true, width: 130, render: (r) => fmt.brl(r.ticket) },
      { key: "ltv", label: "LTV", num: true, width: 130, render: (r) => fmt.brl(r.ltv) },
      { key: "ultima", label: "Última compra", width: 130, render: (r) => <span className="mono" style={{ color: "var(--fg-3)" }}>{r.ultima}</span> },
      { key: "status", label: "Status", width: 120, render: (r) => (
        <span className={"chip " + (r.status==="VIP"?"accent":r.status==="Ativo"?"pos":r.status==="Inativo"?"neg":"warn")}>{r.status}</span>
      )},
    ];
    if (entity === "produtos") return [
      { key: "nome", label: "Produto", render: (r) => (
        <div className="row" style={{ gap: 10 }}>
          <span style={{ width: 30, height: 30, borderRadius: 6, background: "var(--bg-1)", border: "1px solid var(--line)", display: "grid", placeItems: "center" }}>
            <I.box size={13} style={{ color: "var(--fg-3)" }}/>
          </span>
          <div>
            <div style={{ color: "var(--fg)" }}>{r.nome}</div>
            <div className="mono" style={{ fontSize: 11, color: "var(--fg-4)", marginTop: 2 }}>SKU · {r.sku}</div>
          </div>
        </div>
      )},
      { key: "categoria", label: "Categoria" },
      { key: "preco", label: "Preço", num: true, width: 130, render: (r) => fmt.brl(r.preco) },
      { key: "custo", label: "Custo", num: true, width: 120, render: (r) => fmt.brl(r.custo) },
      { key: "margem", label: "Margem", num: true, width: 100, render: (r) => (
        <span className="mono" style={{ color: r.margem >= 30 ? "var(--pos)" : r.margem >= 20 ? "var(--warn)" : "var(--neg)" }}>{fmt.pctRaw(r.margem)}</span>
      )},
      { key: "ativo", label: "Status", width: 100, render: (r) => (
        <span className={"chip " + (r.ativo?"pos":"neg")}>{r.ativo?"Ativo":"Inativo"}</span>
      )},
    ];
    if (entity === "fornecedores") return [
      { key: "nome", label: "Fornecedor", render: (r) => (
        <div>
          <div style={{ color: "var(--fg)" }}>{r.nome}</div>
          <div className="mono" style={{ fontSize: 11, color: "var(--fg-4)", marginTop: 2 }}>{r.cnpj}</div>
        </div>
      )},
      { key: "regiao", label: "Localização" },
      { key: "produtos", label: "SKUs", num: true, width: 90 },
      { key: "compras", label: "Compras 12m", num: true, width: 140, render: (r) => fmt.brl(r.compras) },
      { key: "leadtime", label: "Lead time", num: true, width: 110, render: (r) => <span className="mono">{r.leadtime}d</span> },
      { key: "rating", label: "Rating", width: 100, render: (r) => (
        <div className="row" style={{ gap: 4 }}>
          {Array.from({ length: 5 }).map((_, i) => (
            <I.star key={i} size={11} stroke={1.5} style={{ color: i < r.rating ? "var(--warn)" : "var(--line-3)", fill: i < r.rating ? "var(--warn)" : "transparent" }}/>
          ))}
        </div>
      )},
    ];
    return [
      { key: "nome", label: "Canal de venda", render: (r) => (
        <div className="row" style={{ gap: 10 }}>
          <span style={{ width: 30, height: 30, borderRadius: 6, background: "var(--bg-1)", border: "1px solid var(--line)", display: "grid", placeItems: "center", color: "var(--fg-2)" }}>
            <I.store size={14}/>
          </span>
          <div>
            <div style={{ color: "var(--fg)" }}>{r.nome}</div>
            <div style={{ fontSize: 11, color: "var(--fg-4)", marginTop: 2 }}>{r.tipo}</div>
          </div>
        </div>
      )},
      { key: "vendas", label: "Vendas (mês)", num: true, render: (r) => fmt.brl(r.vendas) },
      { key: "share", label: "Share", num: true, width: 110, render: (r) => (
        <div className="row" style={{ gap: 8, justifyContent: "flex-end" }}>
          <div className="bar" style={{ width: 60 }}><i style={{ width: `${r.share}%`, background: "var(--pos)" }}/></div>
          <span className="mono">{r.share}%</span>
        </div>
      )},
      { key: "ativo", label: "Status", width: 100, render: (r) => (
        <span className={"chip " + (r.ativo?"pos":"neg")}>{r.ativo?"Ativo":"Pausado"}</span>
      )},
    ];
  }, [entity]);

  const label = { clientes: "clientes", produtos: "produtos", fornecedores: "fornecedores", canais: "canais" }[entity];

  return (
    <Card flush>
      <div style={{ padding: 16 }}>
        <CrudToolbar
          searchPlaceholder={`Buscar em ${label}...`}
          selectedCount={selected.size}
          onAdd={onAdd}
          onEdit={onEdit}
          extraFilters={
            <>
              <button className="btn"><I.filter size={13}/> Filtros</button>
              <button className="btn"><I.download size={13}/> Exportar</button>
            </>
          }
        />
        <DataTable
          columns={cols}
          rows={rows}
          selected={selected}
          onToggle={toggle}
          onToggleAll={() => {
            if (selected.size === rows.length) setSelected(new Set());
            else setSelected(new Set(rows.map(r => r.id)));
          }}
        />
      </div>
    </Card>
  );
};

const AdminForm = ({ entity }) => {
  if (entity === "clientes") return (
    <>
      <Field label="Nome completo"><input placeholder="Ex.: Maria Silva"/></Field>
      <div className="grid grid-2" style={{ gap: 12 }}>
        <Field label="Documento"><input placeholder="CPF / CNPJ"/></Field>
        <Field label="Sexo">
          <select><option>Feminino</option><option>Masculino</option><option>Outro</option></select>
        </Field>
      </div>
      <Field label="Telefone"><input placeholder="(11) 9 0000-0000"/></Field>
      <Field label="Endereço completo"><textarea rows="2" placeholder="Rua, número, bairro, cidade, estado"/></Field>
      <div className="grid grid-2" style={{ gap: 12 }}>
        <Field label="Cidade"><input/></Field>
        <Field label="Estado"><input maxLength="2"/></Field>
      </div>
      <Field label="Região" hint="Calculado a partir do estado">
        <select><option>Sudeste</option><option>Sul</option><option>Nordeste</option><option>Centro-Oeste</option><option>Norte</option></select>
      </Field>
    </>
  );
  if (entity === "produtos") return (
    <>
      <Field label="Nome do produto"><input placeholder="Ex.: Cadeira Bella Reclinável"/></Field>
      <Field label="Descrição"><textarea rows="2"/></Field>
      <div className="grid grid-2" style={{ gap: 12 }}>
        <Field label="Categoria">
          <select><option>Cadeiras</option><option>Bancadas</option><option>Lavatórios</option><option>Espelhos</option><option>Acessórios</option></select>
        </Field>
        <Field label="Fornecedor"><select><option>MD Industrial</option><option>Linha Forma</option><option>Móveis Bella</option></select></Field>
      </div>
      <div className="grid grid-2" style={{ gap: 12 }}>
        <Field label="Custo unitário"><input placeholder="R$ 0,00"/></Field>
        <Field label="Preço de venda"><input placeholder="R$ 0,00"/></Field>
      </div>
      <div className="grid grid-3" style={{ gap: 12 }}>
        <Field label="Estoque mín."><input placeholder="0"/></Field>
        <Field label="Estoque máx."><input placeholder="0"/></Field>
        <Field label="Peso (kg)"><input placeholder="0,00"/></Field>
      </div>
    </>
  );
  if (entity === "fornecedores") return (
    <>
      <Field label="Nome fantasia"><input placeholder="Ex.: MD Industrial"/></Field>
      <div className="grid grid-2" style={{ gap: 12 }}>
        <Field label="CNPJ"><input placeholder="00.000.000/0000-00"/></Field>
        <Field label="Telefone"><input/></Field>
      </div>
      <Field label="Endereço completo"><textarea rows="2"/></Field>
      <Field label="Lead time médio (dias)"><input placeholder="ex.: 12"/></Field>
    </>
  );
  return (
    <>
      <Field label="Nome do canal"><input/></Field>
      <Field label="Tipo de canal">
        <select><option>Online</option><option>Físico</option><option>Híbrido</option><option>Marketplace</option></select>
      </Field>
      <Field label="Status">
        <select><option>Ativo</option><option>Pausado</option></select>
      </Field>
    </>
  );
};

/* Placeholder data */
const CLIENTES = [
  { id: 1, nome: "Studio Allure SP", doc: "12.345.678/0001-90", cidade: "São Paulo", estado: "SP", regiao: "Sudeste", pedidos: 14, ticket: 13_142, ltv: 184_000, ultima: "12/05/2026", status: "VIP" },
  { id: 2, nome: "Salão Onix Premium", doc: "98.765.432/0001-11", cidade: "Curitiba", estado: "PR", regiao: "Sul", pedidos: 9, ticket: 8_440, ltv: 76_000, ultima: "08/05/2026", status: "VIP" },
  { id: 3, nome: "Beauty Lab Recife", doc: "55.111.222/0001-33", cidade: "Recife", estado: "PE", regiao: "Nordeste", pedidos: 7, ticket: 5_290, ltv: 37_000, ultima: "30/04/2026", status: "Ativo" },
  { id: 4, nome: "Casa Bella Beleza", doc: "22.444.666/0001-77", cidade: "Belo Horizonte", estado: "MG", regiao: "Sudeste", pedidos: 11, ticket: 4_180, ltv: 46_000, ultima: "02/05/2026", status: "Ativo" },
  { id: 5, nome: "Magnólia Hair Studio", doc: "44.888.999/0001-55", cidade: "Porto Alegre", estado: "RS", regiao: "Sul", pedidos: 4, ticket: 6_710, ltv: 26_800, ultima: "15/03/2026", status: "Em risco" },
  { id: 6, nome: "Espaço Halo Brasília", doc: "66.222.111/0001-44", cidade: "Brasília", estado: "DF", regiao: "Centro-Oeste", pedidos: 6, ticket: 7_220, ltv: 43_300, ultima: "21/04/2026", status: "Ativo" },
  { id: 7, nome: "Lumen Beauty Lounge", doc: "11.555.999/0001-22", cidade: "Salvador", estado: "BA", regiao: "Nordeste", pedidos: 12, ticket: 8_000, ltv: 96_000, ultima: "10/05/2026", status: "VIP" },
  { id: 8, nome: "Vivace Esmaltes", doc: "33.777.888/0001-99", cidade: "Manaus", estado: "AM", regiao: "Norte", pedidos: 2, ticket: 1_980, ltv: 3_960, ultima: "06/01/2026", status: "Inativo" },
];

const PRODUTOS = [
  { id: 1, nome: "Cadeira Bella Reclinável", sku: "CB-RECL-001", categoria: "Cadeiras", preco: 1390, custo: 820, margem: 41.0, ativo: true },
  { id: 2, nome: "Bancada Lúmen 1.40m", sku: "BC-LMN-140", categoria: "Bancadas", preco: 2480, custo: 1620, margem: 34.7, ativo: true },
  { id: 3, nome: "Lavatório Onix Premium", sku: "LV-ONX-PRM", categoria: "Lavatórios", preco: 3190, custo: 2380, margem: 25.4, ativo: true },
  { id: 4, nome: "Espelho Halo LED 80cm", sku: "ES-HALO-80", categoria: "Espelhos", preco: 690, custo: 380, margem: 44.9, ativo: true },
  { id: 5, nome: "Carrinho Estética Pro", sku: "CR-EST-PRO", categoria: "Acessórios", preco: 540, custo: 410, margem: 24.1, ativo: true },
  { id: 6, nome: "Cadeira Vintage Cobre", sku: "CB-VTG-CBR", categoria: "Cadeiras", preco: 1890, custo: 1480, margem: 21.7, ativo: false },
];

const FORNECEDORES = [
  { id: 1, nome: "MD Industrial Móveis", cnpj: "12.345.678/0001-01", regiao: "São Paulo · SP", produtos: 14, compras: 348_000, leadtime: 12, rating: 5 },
  { id: 2, nome: "Linha Forma Componentes", cnpj: "98.765.432/0001-02", regiao: "Curitiba · PR", produtos: 8, compras: 184_000, leadtime: 9, rating: 4 },
  { id: 3, nome: "Móveis Bella Ltda", cnpj: "55.111.222/0001-03", regiao: "Bento Gonçalves · RS", produtos: 6, compras: 142_000, leadtime: 18, rating: 4 },
  { id: 4, nome: "Onix Acabamentos", cnpj: "33.444.555/0001-04", regiao: "São Paulo · SP", produtos: 4, compras: 76_000, leadtime: 14, rating: 3 },
];

const CANAIS = [
  { id: 1, nome: "E-commerce próprio", tipo: "Online", vendas: 184_200, share: 42, ativo: true },
  { id: 2, nome: "Loja física Centro SP", tipo: "Físico", vendas: 142_800, share: 32, ativo: true },
  { id: 3, nome: "Mercado Livre", tipo: "Marketplace", vendas: 89_400, share: 20, ativo: true },
  { id: 4, nome: "Magalu Marketplace", tipo: "Marketplace", vendas: 18_100, share: 4, ativo: true },
  { id: 5, nome: "B2B Salões parceiros", tipo: "Híbrido", vendas: 32_790, share: 7, ativo: true },
  { id: 6, nome: "Showroom RJ", tipo: "Físico", vendas: 0, share: 0, ativo: false },
];

window.ScreenAdministrativo = ScreenAdministrativo;
