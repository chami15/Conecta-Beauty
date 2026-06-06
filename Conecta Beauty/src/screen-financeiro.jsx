/* Tela FINANCEIRO — sidebar Dashboard + transações/contas/formas */

const ScreenFinanceiro = () => {
  const [route, setRoute] = useState("dashboard");
  const [collapsed, setCollapsed] = useState(false);
  const [selected, setSelected] = useState(new Set());
  const [drawerOpen, setDrawerOpen] = useState(false);
  const [period, setPeriod] = useState("Maio");

  useEffect(() => { setSelected(new Set()); }, [route]);

  const toggle = (id) => {
    const n = new Set(selected);
    n.has(id) ? n.delete(id) : n.add(id);
    setSelected(n);
  };

  const sideItems = [
    { id: "dashboard", label: "Dashboard", icon: <I.chart size={15}/> },
    { section: "Gerenciar" },
    { id: "transacoes", label: "Transações", icon: <I.receipt size={15}/> },
    { id: "receber", label: "A receber", icon: <I.arrowDown size={15}/> },
    { id: "pagar", label: "A pagar", icon: <I.arrowUp size={15}/> },
    { id: "formas", label: "Formas pagto.", icon: <I.coins size={15}/> },
  ];

  return (
    <>
      <div className="with-sidebar">
        <SideNav
          items={sideItems} value={route} onChange={setRoute}
          collapsed={collapsed} onToggle={() => setCollapsed(!collapsed)}
        />
        <div className="inner-body screen-anim">
          <div className="screen-header">
            <div>
              <div className="screen-eyebrow">03 · Financeiro</div>
              <div className="screen-title">
                {route === "dashboard" ? "Visão financeira" : ({
                  transacoes: "Transações", receber: "Contas a receber", pagar: "Contas a pagar", formas: "Formas de pagamento"
                }[route])}
              </div>
            </div>
            {route === "dashboard" && (
              <PeriodSelector value={period} onChange={setPeriod} options={["Hoje", "7d", "Maio", "Trim", "YTD"]}/>
            )}
          </div>

          {route === "dashboard"
            ? <FinanceiroDashboard/>
            : <FinanceiroCrud entity={route} selected={selected} toggle={toggle} setSelected={setSelected}
                              onAdd={() => setDrawerOpen(true)} onEdit={() => setDrawerOpen(true)}/>
          }
        </div>
      </div>

      <Drawer
        open={drawerOpen}
        onClose={() => setDrawerOpen(false)}
        eyebrow="NOVO REGISTRO"
        title={({ transacoes: "Nova transação", receber: "Nova conta a receber", pagar: "Nova conta a pagar", formas: "Nova forma de pagamento" }[route] || "Novo registro")}
        footer={
          <>
            <button className="btn ghost" onClick={() => setDrawerOpen(false)}>Cancelar</button>
            <button className="btn primary"><I.check size={13}/> Salvar</button>
          </>
        }
      >
        <FinanceiroForm entity={route}/>
      </Drawer>
    </>
  );
};

const FinanceiroDashboard = () => {
  const receitaSerie = [62, 58, 71, 67, 75, 82, 78, 85, 91, 88, 94, 102, 98, 105, 112, 108, 116, 122, 118, 125, 132, 128, 135, 142, 139, 148, 154, 151, 162, 168];
  const despesaSerie = [42, 44, 41, 47, 45, 52, 48, 55, 51, 58, 54, 62, 58, 65, 61, 68, 64, 72, 68, 75, 71, 78, 74, 82, 78, 85, 81, 88, 84, 91];
  const dias = Array.from({ length: 30 }, (_, i) => String(i + 1));

  return (
    <>
      <div className="grid grid-4" style={{ marginBottom: 16 }}>
        <Card>
          <KPI
            label="Receita"
            currency="R$"
            value="487.290"
            delta={23.4}
            deltaLabel="meta R$ 449k · superada"
            sparkline={<Sparkline data={receitaSerie} width={200} height={32} color="var(--pos)"/>}
          />
        </Card>
        <Card>
          <KPI
            label="Despesas"
            currency="R$"
            value="324.810"
            delta={8.7}
            deltaLabel="alta puxada por logística"
            sparkline={<Sparkline data={despesaSerie} width={200} height={32} color="var(--neg)"/>}
          />
        </Card>
        <Card>
          <KPI
            label="Resultado líquido"
            currency="R$"
            value="162.480"
            delta={61.2}
            deltaLabel="melhor mês em 14 meses"
            sparkline={<MiniBars data={[42,38,55,48,62,71,68,82,74,91,108,162]} width={200} height={36} color="var(--pos)"/>}
          />
        </Card>
        <Card>
          <KPI
            label="Inadimplência"
            value="2,8"
            unit="%"
            delta={-1.4}
            deltaLabel="−R$ 12k em atraso"
            sparkline={<Sparkline data={[5.2,4.8,4.6,4.2,4.0,3.7,3.4,3.1,2.9,2.8]} width={200} height={32} color="var(--pos)" fill={false}/>}
          />
        </Card>
      </div>

      <div className="grid grid-12" style={{ marginBottom: 16 }}>
        <div className="col-8">
          <Card
            title="Receita vs Despesa"
            sub="MAIO · DIÁRIO"
            action={
              <>
                <span className="chip pos"><span style={{ width: 8, height: 2, background: "var(--pos)", display: "inline-block" }}/> Receita</span>
                <span className="chip neg"><span style={{ width: 8, height: 2, background: "var(--neg)", display: "inline-block" }}/> Despesa</span>
              </>
            }
          >
            <LineChart
              width={780} height={260}
              data={receitaSerie} compare={despesaSerie} labels={dias}
              yFormat={(v) => "R$" + Math.round(v) + "k"}
              color="var(--pos)"
              compareColor="var(--neg)"
              annot={{ index: 24, label: "Resultado bateu meta", sub: "no dia 25", side: "left" }}
            />
            <div className="row" style={{ gap: 16, marginTop: 16, paddingTop: 16, borderTop: "1px solid var(--line)" }}>
              <Stat label="Margem bruta" value="56,2%" sub="+3.1 p.p. vs Abr" pos/>
              <Stat label="Margem líquida" value="33,3%" sub="+8.4 p.p. vs Abr" pos/>
              <Stat label="Burn diário" value="R$ 10.8k" sub="média Mai"/>
              <Stat label="Runway" value="14,2 m" sub="se receita zerasse" pos/>
            </div>
          </Card>
        </div>

        <div className="col-4">
          <Card title="DRE simplificado" sub="MAIO · ACUMULADO">
            <div className="stack" style={{ gap: 0 }}>
              <DreLine label="Receita bruta" value={487290} bold/>
              <DreLine label="(−) Impostos" value={-48720} indent/>
              <DreLine label="(−) Devoluções" value={-9846} indent/>
              <DreLine label="Receita líquida" value={428724} bold/>
              <DreLine label="(−) CMV" value={-187200} indent/>
              <DreLine label="Lucro bruto" value={241524} bold pos/>
              <DreLine label="(−) Despesas op." value={-78920} indent/>
              <DreLine label="(−) Logística" value={-32140} indent/>
              <DreLine label="(−) Marketing" value={-12480} indent/>
              <DreLine label="Resultado líquido" value={117984} bold pos highlight/>
            </div>
          </Card>
        </div>
      </div>

      <div className="grid grid-12">
        <div className="col-5">
          <Card title="Mix de formas de pagamento" sub="RECEITA · MAIO">
            <div className="row" style={{ gap: 24 }}>
              <Donut
                size={150}
                centerLabel="Receita"
                centerValue="R$ 487k"
                segments={[
                  { value: 184, color: "var(--pos)" },
                  { value: 142, color: "#9ec5ff" },
                  { value: 89,  color: "var(--warn)" },
                  { value: 47,  color: "var(--fg-3)" },
                  { value: 25,  color: "var(--fg-4)" },
                ]}
              />
              <div className="stack" style={{ flex: 1, gap: 10 }}>
                <DonutLegend2 color="var(--pos)" label="PIX" value="R$ 184k" share="38%" delta={12.1}/>
                <DonutLegend2 color="#9ec5ff" label="Crédito" value="R$ 142k" share="29%" delta={4.2}/>
                <DonutLegend2 color="var(--warn)" label="Boleto" value="R$ 89k" share="18%" delta={-3.4}/>
                <DonutLegend2 color="var(--fg-3)" label="Débito" value="R$ 47k" share="10%" delta={1.1}/>
                <DonutLegend2 color="var(--fg-4)" label="Outros" value="R$ 25k" share="5%" delta={-0.8}/>
              </div>
            </div>
          </Card>
        </div>

        <div className="col-7">
          <Card title="Sinais financeiros" sub="ESTE MÊS · ATENÇÃO">
            <div className="grid grid-2" style={{ gap: 10 }}>
              <Insight tone="neg" icon={<I.alert size={14}/>} title="R$ 12.480 vencidos há +15 dias">
                3 clientes · Studio Onix RJ representa 62% do bolo.
              </Insight>
              <Insight tone="warn" icon={<I.truck size={14}/>} title="Logística cresceu 24% (vs Abr)">
                Custo médio por frete subiu R$ 18 — revisar Rapidão Sul.
              </Insight>
              <Insight tone="pos" icon={<I.trending size={14}/>} title="Margem líquida em recorde de 14 meses">
                +8.4 p.p. vs Abril · combinação de mix + ticket.
              </Insight>
              <Insight tone="accent" icon={<I.coins size={14}/>} title="Caixa atual: 14,2 meses de operação">
                Janela boa para considerar expansão controlada.
              </Insight>
            </div>
          </Card>
        </div>
      </div>
    </>
  );
};

const FinanceiroCrud = ({ entity, selected, toggle, setSelected, onAdd, onEdit }) => {
  const rows = useMemo(() => {
    if (entity === "transacoes") return TRANSACOES;
    if (entity === "receber") return CONTAS_RECEBER;
    if (entity === "pagar") return CONTAS_PAGAR;
    return FORMAS_PAGAMENTO;
  }, [entity]);

  const cols = useMemo(() => {
    if (entity === "transacoes") return [
      { key: "num", label: "Nº", width: 80, render: (r) => <span className="mono" style={{ color: "var(--fg-3)" }}>#{r.num}</span> },
      { key: "descricao", label: "Histórico", render: (r) => (
        <div>
          <div style={{ color: "var(--fg)" }}>{r.descricao}</div>
          <div style={{ fontSize: 11, color: "var(--fg-4)", marginTop: 2 }}>{r.categoria}</div>
        </div>
      )},
      { key: "tipo", label: "Tipo", width: 110, render: (r) => (
        <span className={"chip " + (r.tipo==="Crédito"?"pos":"neg")}>
          {r.tipo==="Crédito" ? <I.arrowUp size={10} stroke={2.5}/> : <I.arrowDown size={10} stroke={2.5}/>}
          {r.tipo}
        </span>
      )},
      { key: "forma", label: "Forma" },
      { key: "valor", label: "Valor", num: true, width: 140, render: (r) => (
        <span className="mono" style={{ color: r.tipo==="Crédito"?"var(--pos)":"var(--fg)" }}>
          {r.tipo==="Crédito" ? "+" : "−"} {fmt.brl(r.valor)}
        </span>
      )},
      { key: "data", label: "Data", width: 110, render: (r) => <span className="mono" style={{ color: "var(--fg-3)" }}>{r.data}</span> },
      { key: "status", label: "Status", width: 120, render: (r) => (
        <span className={"chip " + (r.status==="Paga"?"pos":r.status==="Prevista"?"warn":r.status==="Cancelada"?"neg":"")}>{r.status}</span>
      )},
    ];
    if (entity === "receber") return [
      { key: "cliente", label: "Cliente", render: (r) => (
        <div>
          <div style={{ color: "var(--fg)" }}>{r.cliente}</div>
          <div className="mono" style={{ fontSize: 11, color: "var(--fg-4)", marginTop: 2 }}>Pedido #{r.pedido}</div>
        </div>
      )},
      { key: "valor", label: "Valor", num: true, width: 140, render: (r) => fmt.brl(r.valor) },
      { key: "vencimento", label: "Vencimento", width: 120, render: (r) => <span className="mono">{r.vencimento}</span> },
      { key: "dias", label: "Dias", num: true, width: 110, render: (r) => (
        <span className="mono" style={{ color: r.dias < 0 ? "var(--neg)" : r.dias < 7 ? "var(--warn)" : "var(--fg-2)" }}>
          {r.dias < 0 ? `${Math.abs(r.dias)}d atraso` : `${r.dias}d`}
        </span>
      )},
      { key: "status", label: "Status", width: 130, render: (r) => (
        <span className={"chip " + (r.status==="Em dia"?"":r.status==="A vencer"?"warn":"neg")}>{r.status}</span>
      )},
    ];
    if (entity === "pagar") return [
      { key: "fornecedor", label: "Fornecedor / Categoria", render: (r) => (
        <div>
          <div style={{ color: "var(--fg)" }}>{r.fornecedor}</div>
          <div style={{ fontSize: 11, color: "var(--fg-4)", marginTop: 2 }}>{r.categoria}</div>
        </div>
      )},
      { key: "valor", label: "Valor", num: true, width: 140, render: (r) => fmt.brl(r.valor) },
      { key: "vencimento", label: "Vencimento", width: 120, render: (r) => <span className="mono">{r.vencimento}</span> },
      { key: "dias", label: "Dias", num: true, width: 110, render: (r) => (
        <span className="mono" style={{ color: r.dias < 0 ? "var(--neg)" : r.dias < 5 ? "var(--warn)" : "var(--fg-2)" }}>
          {r.dias < 0 ? `${Math.abs(r.dias)}d atraso` : `${r.dias}d`}
        </span>
      )},
      { key: "status", label: "Status", width: 130, render: (r) => (
        <span className={"chip " + (r.status==="Pago"?"pos":r.status==="A vencer"?"warn":"neg")}>{r.status}</span>
      )},
    ];
    return [
      { key: "nome", label: "Forma de pagamento", render: (r) => (
        <div className="row" style={{ gap: 10 }}>
          <span style={{ width: 30, height: 30, borderRadius: 6, background: "var(--bg-1)", border: "1px solid var(--line)", display: "grid", placeItems: "center" }}>
            <I.receipt size={13} style={{ color: "var(--fg-3)" }}/>
          </span>
          <div style={{ color: "var(--fg)" }}>{r.nome}</div>
        </div>
      )},
      { key: "transacoes", label: "Transações (mês)", num: true, render: (r) => fmt.int(r.transacoes) },
      { key: "valor", label: "Volume (mês)", num: true, render: (r) => fmt.brl(r.valor) },
      { key: "share", label: "Share", num: true, width: 110, render: (r) => (
        <div className="row" style={{ gap: 8, justifyContent: "flex-end" }}>
          <div className="bar" style={{ width: 60 }}><i style={{ width: `${r.share}%`, background: "var(--pos)" }}/></div>
          <span className="mono">{r.share}%</span>
        </div>
      )},
      { key: "taxa", label: "Custo médio", num: true, width: 110, render: (r) => <span className="mono">{r.taxa}%</span> },
    ];
  }, [entity]);

  return (
    <Card flush>
      <div style={{ padding: 16 }}>
        <CrudToolbar
          searchPlaceholder={`Buscar em ${entity}...`}
          selectedCount={selected.size}
          onAdd={onAdd}
          onEdit={onEdit}
          extraFilters={
            <>
              <button className="btn"><I.calendar size={13}/> Período</button>
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

const FinanceiroForm = ({ entity }) => {
  if (entity === "transacoes") return (
    <>
      <Field label="Tipo">
        <select><option>Crédito (receita)</option><option>Débito (despesa)</option></select>
      </Field>
      <Field label="Histórico"><input placeholder="Ex.: Recebimento pedido #1284"/></Field>
      <div className="grid grid-2" style={{ gap: 12 }}>
        <Field label="Valor"><input placeholder="R$ 0,00"/></Field>
        <Field label="Forma de pagamento"><select><option>PIX</option><option>Crédito</option><option>Boleto</option><option>Débito</option><option>Dinheiro</option><option>Transferência</option></select></Field>
      </div>
      <div className="grid grid-2" style={{ gap: 12 }}>
        <Field label="Data pagamento"><input type="date"/></Field>
        <Field label="Status"><select><option>Prevista</option><option>Confirmada</option><option>Paga</option><option>Cancelada</option></select></Field>
      </div>
      <Field label="Categoria"><select><option>Vendas</option><option>Compras</option><option>Logística</option><option>Marketing</option><option>Impostos</option><option>Pessoal</option></select></Field>
    </>
  );
  if (entity === "receber" || entity === "pagar") return (
    <>
      <Field label={entity==="receber"?"Cliente":"Fornecedor"}><input/></Field>
      <Field label="Descrição"><input/></Field>
      <div className="grid grid-2" style={{ gap: 12 }}>
        <Field label="Valor"><input placeholder="R$ 0,00"/></Field>
        <Field label="Vencimento"><input type="date"/></Field>
      </div>
    </>
  );
  return (
    <>
      <Field label="Nome da forma de pagamento"><input/></Field>
      <Field label="Custo médio (%)"><input placeholder="0,00"/></Field>
    </>
  );
};

const DreLine = ({ label, value, bold, indent, pos, highlight }) => (
  <div style={{
    display: "flex", justifyContent: "space-between",
    padding: "9px 0",
    borderBottom: "1px solid var(--line)",
    paddingLeft: indent ? 12 : 0,
    background: highlight ? "rgba(255,255,255,0.06)" : "transparent",
    marginInline: highlight ? -12 : 0,
    paddingInline: highlight ? 12 : (indent ? 12 : 0),
    borderRadius: highlight ? 4 : 0,
    marginTop: highlight ? 6 : 0,
  }}>
    <span style={{
      fontSize: 12,
      color: bold ? "var(--fg)" : "var(--fg-3)",
      fontWeight: bold ? 600 : 400,
    }}>{label}</span>
    <span className="mono" style={{
      fontSize: 12,
      color: highlight ? "var(--pos)" : bold && pos ? "var(--pos)" : bold ? "var(--fg)" : value < 0 ? "var(--neg)" : "var(--fg-2)",
      fontWeight: bold ? 600 : 400,
    }}>
      {value < 0 ? "−" : ""} {fmt.brl(Math.abs(value))}
    </span>
  </div>
);

const DonutLegend2 = ({ color, label, value, share, delta }) => (
  <div className="row between" style={{ fontSize: 12 }}>
    <div className="row" style={{ gap: 8 }}>
      <span style={{ width: 8, height: 8, borderRadius: 2, background: color, display: "inline-block" }}/>
      <div>
        <div style={{ color: "var(--fg)" }}>{label}</div>
        <div className="mono" style={{ fontSize: 10, color: "var(--fg-4)" }}>{share} · {value}</div>
      </div>
    </div>
    {delta !== undefined && (
      <span className={"delta " + (delta>=0?"pos":"neg")} style={{ fontSize: 10 }}>
        {delta>=0?"+":""}{delta.toFixed(1)}%
      </span>
    )}
  </div>
);

const TRANSACOES = [
  { id: 1, num: 1284, descricao: "Recebimento pedido #1284", categoria: "Vendas · E-commerce", tipo: "Crédito", forma: "PIX", valor: 4_390, data: "23/05/2026", status: "Paga" },
  { id: 2, num: 1283, descricao: "Pagamento MD Industrial", categoria: "Compras · Fornecedor", tipo: "Débito", forma: "Boleto", valor: 28_400, data: "22/05/2026", status: "Paga" },
  { id: 3, num: 1282, descricao: "Frete Rapidão Sul", categoria: "Logística", tipo: "Débito", forma: "Transferência", valor: 3_280, data: "22/05/2026", status: "Paga" },
  { id: 4, num: 1281, descricao: "Recebimento Studio Allure", categoria: "Vendas · B2B", tipo: "Crédito", forma: "PIX", valor: 13_142, data: "21/05/2026", status: "Paga" },
  { id: 5, num: 1280, descricao: "Campanha Meta Ads", categoria: "Marketing", tipo: "Débito", forma: "Crédito", valor: 4_800, data: "21/05/2026", status: "Paga" },
  { id: 6, num: 1279, descricao: "Boleto vencido — Salão Onix", categoria: "Vendas · pendente", tipo: "Crédito", forma: "Boleto", valor: 7_440, data: "15/05/2026", status: "Prevista" },
  { id: 7, num: 1278, descricao: "ICMS Maio", categoria: "Impostos", tipo: "Débito", forma: "Transferência", valor: 18_290, data: "10/05/2026", status: "Prevista" },
];

const CONTAS_RECEBER = [
  { id: 1, cliente: "Studio Allure SP", pedido: 1284, valor: 13_142, vencimento: "30/05/2026", dias: 7, status: "Em dia" },
  { id: 2, cliente: "Salão Onix Premium", pedido: 1267, valor: 7_440, vencimento: "15/05/2026", dias: -8, status: "Atrasado" },
  { id: 3, cliente: "Beauty Lab Recife", pedido: 1271, valor: 5_290, vencimento: "28/05/2026", dias: 5, status: "A vencer" },
  { id: 4, cliente: "Casa Bella Beleza", pedido: 1273, valor: 4_180, vencimento: "02/06/2026", dias: 10, status: "Em dia" },
];

const CONTAS_PAGAR = [
  { id: 1, fornecedor: "MD Industrial Móveis", categoria: "Compras", valor: 28_400, vencimento: "30/05/2026", dias: 7, status: "A vencer" },
  { id: 2, fornecedor: "Linha Forma Componentes", categoria: "Compras", valor: 12_800, vencimento: "28/05/2026", dias: 5, status: "A vencer" },
  { id: 3, fornecedor: "Energia · ENEL", categoria: "Operacional", valor: 3_420, vencimento: "20/05/2026", dias: -3, status: "Atrasado" },
  { id: 4, fornecedor: "Aluguel Galpão SP", categoria: "Operacional", valor: 8_400, vencimento: "05/06/2026", dias: 13, status: "A vencer" },
];

const FORMAS_PAGAMENTO = [
  { id: 1, nome: "PIX", transacoes: 184, valor: 184_200, share: 38, taxa: 0.0 },
  { id: 2, nome: "Crédito", transacoes: 142, valor: 142_800, share: 29, taxa: 3.2 },
  { id: 3, nome: "Boleto", transacoes: 64, valor: 89_400, share: 18, taxa: 1.8 },
  { id: 4, nome: "Débito", transacoes: 84, valor: 47_290, share: 10, taxa: 1.4 },
  { id: 5, nome: "Transferência", transacoes: 28, valor: 18_400, share: 4, taxa: 0.0 },
  { id: 6, nome: "Dinheiro", transacoes: 12, valor: 5_200, share: 1, taxa: 0.0 },
];

window.ScreenFinanceiro = ScreenFinanceiro;
