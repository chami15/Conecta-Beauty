/* Tela ESTOQUE — sidebar Dashboard + saldo/movimentações/fretes/transportadoras */

const ScreenEstoque = () => {
  const [route, setRoute] = useState("dashboard");
  const [collapsed, setCollapsed] = useState(false);
  const [selected, setSelected] = useState(new Set());
  const [drawerOpen, setDrawerOpen] = useState(false);
  const [period, setPeriod] = useState("30d");

  useEffect(() => { setSelected(new Set()); }, [route]);

  const toggle = (id) => {
    const n = new Set(selected);
    n.has(id) ? n.delete(id) : n.add(id);
    setSelected(n);
  };

  const sideItems = [
    { id: "dashboard", label: "Dashboard", icon: <I.chart size={15}/> },
    { section: "Gerenciar" },
    { id: "produtos", label: "Saldo SKUs", icon: <I.box size={15}/> },
    { id: "movimentacoes", label: "Movimentações", icon: <I.layers size={15}/> },
    { id: "fretes", label: "Fretes", icon: <I.package size={15}/> },
    { id: "transportadoras", label: "Transportadoras", icon: <I.truck size={15}/> },
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
              <div className="screen-eyebrow">04 · Estoque</div>
              <div className="screen-title">
                {route === "dashboard" ? "Visão de estoque" : ({
                  produtos: "Saldo de SKUs",
                  movimentacoes: "Movimentações",
                  fretes: "Fretes",
                  transportadoras: "Transportadoras",
                }[route])}
              </div>
            </div>
            {route === "dashboard" && (
              <PeriodSelector value={period} onChange={setPeriod} options={["7d", "30d", "Trim", "Ano"]}/>
            )}
          </div>

          {route === "dashboard"
            ? <EstoqueDashboard/>
            : <EstoqueCrud entity={route} selected={selected} toggle={toggle} setSelected={setSelected}
                           onAdd={() => setDrawerOpen(true)} onEdit={() => setDrawerOpen(true)}/>
          }
        </div>
      </div>

      <Drawer
        open={drawerOpen}
        onClose={() => setDrawerOpen(false)}
        eyebrow="NOVO REGISTRO"
        title={({ produtos: "Ajustar saldo", movimentacoes: "Nova movimentação", fretes: "Novo frete", transportadoras: "Nova transportadora" }[route] || "Novo registro")}
        footer={
          <>
            <button className="btn ghost" onClick={() => setDrawerOpen(false)}>Cancelar</button>
            <button className="btn primary"><I.check size={13}/> Salvar</button>
          </>
        }
      >
        <EstoqueForm entity={route}/>
      </Drawer>
    </>
  );
};

const EstoqueDashboard = () => (
  <>
    <div className="grid grid-4" style={{ marginBottom: 16 }}>
      <Card>
        <KPI
          label="Itens em estoque"
          value="1.284"
          unit="un"
          delta={-4.2}
          deltaLabel="saídas > entradas"
          sparkline={<Sparkline data={[1410,1390,1380,1340,1320,1310,1300,1290,1284]} width={200} height={32} color="var(--neg)" fill={false}/>}
        />
      </Card>
      <Card>
        <KPI
          label="Valor em estoque"
          currency="R$"
          value="284.910"
          delta={-1.8}
          deltaLabel="capital imobilizado"
          sparkline={<Sparkline data={[298,296,294,291,290,288,287,286,285]} width={200} height={32} color="var(--neg)" fill={false}/>}
        />
      </Card>
      <Card>
        <KPI
          label="Giro médio"
          value="2,4"
          unit="x"
          delta={8.1}
          deltaLabel="cobertura média: 18d"
          sparkline={<Sparkline data={[1.8,1.9,2.0,2.1,2.1,2.2,2.3,2.4]} width={200} height={32} color="var(--pos)"/>}
        />
      </Card>
      <Card>
        <KPI
          label="SKUs em alerta"
          value="6"
          delta={50}
          deltaLabel="risco · vs 4 em Abril"
          sparkline={<MiniBars data={[1,2,2,3,4,4,5,6]} width={200} height={36} color="var(--neg)"/>}
        />
      </Card>
    </div>

    <div className="grid grid-12" style={{ marginBottom: 16 }}>
      <div className="col-7">
        <Card title="Movimentações" sub="ÚLTIMOS 30 DIAS · ENTRADA VS SAÍDA"
          action={
            <>
              <span className="chip pos"><span style={{ width: 8, height: 2, background: "var(--pos)", display: "inline-block" }}/> Entrada</span>
              <span className="chip neg"><span style={{ width: 8, height: 2, background: "var(--neg)", display: "inline-block" }}/> Saída</span>
            </>
          }
        >
          <LineChart
            width={780} height={260}
            data={[28,32,18,42,38,55,48,62,71,68,82,74,91,108,98,112,128,118,134,142,128,148,162,154,168,178,168,184,192,184]}
            compare={[48,52,38,62,58,75,68,82,91,88,102,94,111,128,118,132,148,138,154,162,148,168,182,174,188,198,188,204,212,204]}
            labels={Array.from({ length: 30 }, (_, i) => String(i+1))}
            yFormat={(v) => Math.round(v) + " un"}
            color="var(--pos)"
            compareColor="var(--neg)"
            annot={{ index: 18, label: "Pico de saídas", sub: "campanha Mãe · dia 19", side: "left" }}
          />
          <div className="row" style={{ gap: 16, marginTop: 16, paddingTop: 16, borderTop: "1px solid var(--line)" }}>
            <Stat label="Entradas (mês)" value="3.428 un" sub="42 movimentações" pos/>
            <Stat label="Saídas (mês)" value="3.892 un" sub="entropia: −464 un" neg/>
            <Stat label="Maior categoria" value="Cadeiras" sub="58% das saídas"/>
            <Stat label="Custo médio movido" value="R$ 184" sub="por unidade"/>
          </div>
        </Card>
      </div>

      <div className="col-5">
        <Card title="Performance de transportadoras" sub="MAIO · SLA REAL VS CONTRATADO">
          <BarList
            format={(v) => v.toFixed(1) + " ★"}
            max={5}
            items={[
              { label: "TransMóveis Express", sub: "Sudeste · 184 fretes · 0,4d atraso", value: 4.6, delta: 5.2, color: "var(--pos)" },
              { label: "Logística Bella", sub: "Sul · 92 fretes · no prazo", value: 4.4, delta: 2.1, color: "var(--pos)" },
              { label: "Rota Brasil", sub: "Nacional · 64 fretes · 1,8d atraso", value: 3.6, delta: -1.4, color: "var(--warn)" },
              { label: "Rapidão Sul", sub: "Sul · 38 fretes · 5,2d atraso", value: 2.4, delta: -18.7, color: "var(--neg)" },
              { label: "Norte Cargo", sub: "N/NE · 24 fretes · avaria 4,2%", value: 2.8, delta: -8.3, color: "var(--neg)" },
            ]}
          />
          <div className="divider"/>
          <Insight tone="neg" icon={<I.truck size={14}/>} title="Rapidão Sul fora do SLA">
            Atraso médio 5x maior que o contratado · sugerir migração para Logística Bella.
          </Insight>
        </Card>
      </div>
    </div>

    <div className="grid grid-12">
      <div className="col-7">
        <Card title="SKUs em ponto crítico" sub="ABAIXO DO MÍNIMO OU COBERTURA < 7 DIAS"
          action={<button className="btn"><I.plus size={13}/> Sugerir compra</button>}>
          <div className="stack" style={{ gap: 10 }}>
            {[
              { nome: "Cadeira Bella Reclinável", sku: "CB-RECL-001", saldo: 8, min: 20, cobertura: 4, demanda: "Alta · 21 un/sem" },
              { nome: "Bancada Lúmen 1.40m", sku: "BC-LMN-140", saldo: 6, min: 15, cobertura: 5, demanda: "Média · 11 un/sem" },
              { nome: "Lavatório Onix Premium", sku: "LV-ONX-PRM", saldo: 3, min: 10, cobertura: 6, demanda: "Alta · 14 un/sem" },
              { nome: "Espelho Halo LED 80cm", sku: "ES-HALO-80", saldo: 12, min: 18, cobertura: 7, demanda: "Alta · 26 un/sem" },
            ].map((p, i) => <CriticalSku key={i} {...p}/>)}
          </div>
        </Card>
      </div>

      <div className="col-5">
        <Card title="Calor de movimentação" sub="POR CATEGORIA · MÊS">
          <Heatmap
            rows={["Cadeiras", "Bancadas", "Lavatórios", "Espelhos", "Acessórios"]}
            cols={["S1", "S2", "S3", "S4"]}
            format={(v) => v}
            color="var(--pos)"
            values={[
              [42, 58, 71, 82],
              [28, 32, 38, 44],
              [22, 28, 24, 31],
              [18, 24, 32, 38],
              [12, 14, 16, 18],
            ]}
          />
          <div className="divider"/>
          <Insight tone="pos" icon={<I.trending size={14}/>} title="Cadeiras +95% nas últimas 4 semanas">
            Tendência consistente · ajustar estoque mínimo para 30 un.
          </Insight>
        </Card>
      </div>
    </div>
  </>
);

const EstoqueCrud = ({ entity, selected, toggle, setSelected, onAdd, onEdit }) => {
  const rows = useMemo(() => {
    if (entity === "produtos") return ESTOQUE_PRODUTOS;
    if (entity === "movimentacoes") return MOVIMENTACOES;
    if (entity === "fretes") return FRETES;
    return TRANSPORTADORAS;
  }, [entity]);

  const cols = useMemo(() => {
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
      { key: "categoria", label: "Categoria", width: 130 },
      { key: "saldo", label: "Saldo", num: true, width: 90, render: (r) => (
        <span className="mono" style={{ color: r.saldo <= r.minimo ? "var(--neg)" : r.saldo <= r.minimo*1.5 ? "var(--warn)" : "var(--fg)" }}>{r.saldo}</span>
      )},
      { key: "minmax", label: "Mín / Máx", num: true, width: 110, render: (r) => <span className="mono" style={{ color: "var(--fg-3)" }}>{r.minimo} / {r.maximo}</span> },
      { key: "nivel", label: "Nível", width: 130, render: (r) => (
        <StockLevel saldo={r.saldo} min={r.minimo} max={r.maximo}/>
      )},
      { key: "giro", label: "Giro", num: true, width: 90, render: (r) => (
        <span className="mono" style={{ color: r.giro >= 2.5 ? "var(--pos)" : r.giro >= 1.5 ? "var(--fg-2)" : "var(--neg)" }}>{r.giro.toFixed(1)}x</span>
      )},
      { key: "cobertura", label: "Cobertura", num: true, width: 110, render: (r) => (
        <span className="mono" style={{ color: r.cobertura <= 7 ? "var(--neg)" : r.cobertura <= 15 ? "var(--warn)" : "var(--fg-2)" }}>{r.cobertura}d</span>
      )},
    ];
    if (entity === "movimentacoes") return [
      { key: "data", label: "Data", width: 110, render: (r) => <span className="mono" style={{ color: "var(--fg-3)" }}>{r.data}</span> },
      { key: "produto", label: "Produto" },
      { key: "tipo", label: "Tipo movimento", width: 200, render: (r) => (
        <span className={"chip " + (r.natureza==="ENTRADA"?"pos":"neg")}>
          {r.natureza==="ENTRADA" ? <I.arrowDown size={10} stroke={2.5}/> : <I.arrowUp size={10} stroke={2.5}/>}
          {r.tipo}
        </span>
      )},
      { key: "qtd", label: "Qtd", num: true, width: 90, render: (r) => (
        <span className="mono" style={{ color: r.natureza==="ENTRADA"?"var(--pos)":"var(--neg)" }}>
          {r.natureza==="ENTRADA"?"+":"−"}{r.qtd}
        </span>
      )},
      { key: "valor", label: "Valor", num: true, width: 130, render: (r) => fmt.brl(r.valor) },
      { key: "saldo", label: "Saldo após", num: true, width: 110, render: (r) => <span className="mono">{r.saldoAtual}</span> },
    ];
    if (entity === "fretes") return [
      { key: "pedido", label: "Pedido", width: 100, render: (r) => <span className="mono" style={{ color: "var(--fg-2)" }}>#{r.pedido}</span> },
      { key: "transportadora", label: "Transportadora" },
      { key: "rota", label: "Rota", render: (r) => <span style={{ color: "var(--fg-2)" }}>{r.origem} <span className="muted-2">→</span> {r.destino}</span> },
      { key: "peso", label: "Peso", num: true, width: 90, render: (r) => <span className="mono">{r.peso}kg</span> },
      { key: "valor", label: "Frete", num: true, width: 110, render: (r) => fmt.brl(r.valor) },
      { key: "prazo", label: "Prazo / SLA", width: 150, render: (r) => (
        <span className="mono" style={{ color: r.atraso > 0 ? "var(--neg)" : "var(--fg-2)" }}>
          {r.prazo}d · {r.atraso > 0 ? `+${r.atraso}d atraso` : "no prazo"}
        </span>
      )},
      { key: "status", label: "Status", width: 130, render: (r) => (
        <span className={"chip " + (r.status==="Entregue"?"pos":r.status==="Em trânsito"?"":r.status==="Atrasado"?"neg":"warn")}>{r.status}</span>
      )},
    ];
    return [
      { key: "nome", label: "Transportadora", render: (r) => (
        <div className="row" style={{ gap: 10 }}>
          <span style={{ width: 30, height: 30, borderRadius: 6, background: "var(--bg-1)", border: "1px solid var(--line)", display: "grid", placeItems: "center" }}>
            <I.truck size={13} style={{ color: "var(--fg-3)" }}/>
          </span>
          <div>
            <div style={{ color: "var(--fg)" }}>{r.nome}</div>
            <div className="mono" style={{ fontSize: 11, color: "var(--fg-4)", marginTop: 2 }}>{r.cnpj}</div>
          </div>
        </div>
      )},
      { key: "fretes", label: "Fretes (mês)", num: true, render: (r) => fmt.int(r.fretes) },
      { key: "prazo", label: "Prazo médio", num: true, width: 130, render: (r) => <span className="mono">{r.prazo}d</span> },
      { key: "atraso", label: "Atraso médio", num: true, width: 130, render: (r) => (
        <span className="mono" style={{ color: r.atraso > 2 ? "var(--neg)" : r.atraso > 0 ? "var(--warn)" : "var(--pos)" }}>{r.atraso.toFixed(1)}d</span>
      )},
      { key: "avaria", label: "Taxa avaria", num: true, width: 130, render: (r) => (
        <span className="mono" style={{ color: r.avaria > 3 ? "var(--neg)" : r.avaria > 1.5 ? "var(--warn)" : "var(--pos)" }}>{r.avaria.toFixed(1)}%</span>
      )},
      { key: "rating", label: "Rating", width: 100, render: (r) => (
        <div className="row" style={{ gap: 4 }}>
          {Array.from({ length: 5 }).map((_, i) => (
            <I.star key={i} size={11} stroke={1.5} style={{ color: i < r.rating ? "var(--warn)" : "var(--line-3)", fill: i < r.rating ? "var(--warn)" : "transparent" }}/>
          ))}
        </div>
      )},
    ];
  }, [entity]);

  const addLabel = entity === "movimentacoes" ? "Nova movimentação" : "Adicionar";

  return (
    <Card flush>
      <div style={{ padding: 16 }}>
        <CrudToolbar
          searchPlaceholder={`Buscar em ${entity}...`}
          selectedCount={selected.size}
          onAdd={onAdd}
          onEdit={onEdit}
          addLabel={addLabel}
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

const EstoqueForm = ({ entity }) => {
  if (entity === "movimentacoes") return (
    <>
      <Field label="Produto"><select><option>Cadeira Bella Reclinável</option><option>Bancada Lúmen 1.40m</option><option>Lavatório Onix Premium</option></select></Field>
      <Field label="Tipo de movimentação">
        <select>
          <option>Compra (entrada)</option>
          <option>Venda (saída)</option>
          <option>Devolução Cliente (entrada)</option>
          <option>Devolução Fornecedor (saída)</option>
          <option>Perda/Quebra (saída)</option>
          <option>Ajuste Inventário + (entrada)</option>
          <option>Ajuste Inventário − (saída)</option>
          <option>Transferência</option>
        </select>
      </Field>
      <div className="grid grid-2" style={{ gap: 12 }}>
        <Field label="Quantidade"><input type="number"/></Field>
        <Field label="Valor unitário"><input placeholder="R$ 0,00"/></Field>
      </div>
      <Field label="Fornecedor (se compra)"><input/></Field>
      <Field label="Observações"><textarea rows="2"/></Field>
      <Field label="" hint="Saldo será calculado automaticamente pelo trigger.">
        <div style={{ padding: 12, background: "var(--bg-1)", border: "1px solid var(--line)", borderRadius: 6 }}>
          <div className="row between" style={{ fontSize: 12 }}>
            <span className="muted">Saldo atual:</span>
            <span className="mono" style={{ color: "var(--fg)" }}>184 un</span>
          </div>
          <div className="row between" style={{ fontSize: 12, marginTop: 6 }}>
            <span className="muted">Saldo após:</span>
            <span className="mono" style={{ color: "var(--pos)" }}>+ ? un</span>
          </div>
        </div>
      </Field>
    </>
  );
  if (entity === "produtos") return (
    <>
      <Field label="Produto"><select><option>Cadeira Bella Reclinável</option></select></Field>
      <div className="grid grid-2" style={{ gap: 12 }}>
        <Field label="Estoque mínimo"><input type="number"/></Field>
        <Field label="Estoque máximo"><input type="number"/></Field>
      </div>
      <Field label="Localização (depósito)"><input placeholder="Galpão SP · Rua A · Prateleira 12"/></Field>
    </>
  );
  if (entity === "fretes") return (
    <>
      <Field label="Pedido"><input placeholder="#1284"/></Field>
      <Field label="Transportadora"><select><option>TransMóveis Express</option><option>Logística Bella</option></select></Field>
      <div className="grid grid-2" style={{ gap: 12 }}>
        <Field label="Origem"><input/></Field>
        <Field label="Destino"><input/></Field>
      </div>
      <div className="grid grid-3" style={{ gap: 12 }}>
        <Field label="Peso (kg)"><input/></Field>
        <Field label="Valor frete"><input/></Field>
        <Field label="Prazo (d)"><input type="number"/></Field>
      </div>
    </>
  );
  return (
    <>
      <Field label="Nome"><input/></Field>
      <Field label="CNPJ"><input/></Field>
      <Field label="Telefone"><input/></Field>
      <div className="grid grid-2" style={{ gap: 12 }}>
        <Field label="Frete base / kg"><input placeholder="R$ 0,00"/></Field>
        <Field label="Prazo médio (d)"><input type="number"/></Field>
      </div>
    </>
  );
};

const StockLevel = ({ saldo, min, max }) => {
  const pct = Math.max(0, Math.min(100, (saldo / max) * 100));
  const minPct = (min / max) * 100;
  const color = saldo <= min ? "var(--neg)" : saldo <= min * 1.5 ? "var(--warn)" : "var(--pos)";
  return (
    <div style={{ position: "relative", width: 110 }}>
      <div className="bar"><i style={{ width: `${pct}%`, background: color }}/></div>
      <div style={{
        position: "absolute",
        left: `${minPct}%`,
        top: -2, bottom: -2,
        width: 1,
        background: "var(--fg-3)",
        opacity: 0.6,
      }}/>
    </div>
  );
};

const CriticalSku = ({ nome, sku, saldo, min, cobertura, demanda }) => (
  <div style={{
    display: "grid", gridTemplateColumns: "1fr auto auto auto",
    gap: 16, alignItems: "center",
    padding: "12px 14px",
    background: "var(--bg-1)",
    border: "1px solid var(--line)",
    borderRadius: 6,
  }}>
    <div>
      <div style={{ color: "var(--fg)", fontSize: 13 }}>{nome}</div>
      <div className="mono" style={{ fontSize: 11, color: "var(--fg-4)", marginTop: 2 }}>{sku} · {demanda}</div>
    </div>
    <div style={{ textAlign: "right", minWidth: 80 }}>
      <div className="mono" style={{ fontSize: 16, color: "var(--neg)", fontWeight: 600 }}>{saldo}</div>
      <div className="mono" style={{ fontSize: 10, color: "var(--fg-4)" }}>min {min}</div>
    </div>
    <div style={{ textAlign: "right", minWidth: 80 }}>
      <div className="mono" style={{ fontSize: 14, color: "var(--warn)" }}>{cobertura}d</div>
      <div className="mono" style={{ fontSize: 10, color: "var(--fg-4)" }}>cobertura</div>
    </div>
    <button className="btn primary"><I.plus size={12}/> Comprar</button>
  </div>
);

const ESTOQUE_PRODUTOS = [
  { id: 1, nome: "Cadeira Bella Reclinável", sku: "CB-RECL-001", categoria: "Cadeiras", saldo: 8, minimo: 20, maximo: 80, giro: 3.8, cobertura: 4 },
  { id: 2, nome: "Bancada Lúmen 1.40m", sku: "BC-LMN-140", categoria: "Bancadas", saldo: 6, minimo: 15, maximo: 60, giro: 2.4, cobertura: 5 },
  { id: 3, nome: "Lavatório Onix Premium", sku: "LV-ONX-PRM", categoria: "Lavatórios", saldo: 3, minimo: 10, maximo: 40, giro: 2.9, cobertura: 6 },
  { id: 4, nome: "Espelho Halo LED 80cm", sku: "ES-HALO-80", categoria: "Espelhos", saldo: 12, minimo: 18, maximo: 72, giro: 3.2, cobertura: 7 },
  { id: 5, nome: "Carrinho Estética Pro", sku: "CR-EST-PRO", categoria: "Acessórios", saldo: 42, minimo: 20, maximo: 80, giro: 1.6, cobertura: 22 },
  { id: 6, nome: "Cadeira Vintage Cobre", sku: "CB-VTG-CBR", categoria: "Cadeiras", saldo: 28, minimo: 12, maximo: 48, giro: 0.9, cobertura: 38 },
  { id: 7, nome: "Bancada Studio 1.80m", sku: "BC-STD-180", categoria: "Bancadas", saldo: 18, minimo: 8, maximo: 32, giro: 2.1, cobertura: 18 },
];

const MOVIMENTACOES = [
  { id: 1, data: "23/05/2026", produto: "Cadeira Bella Reclinável", tipo: "Venda", natureza: "SAÍDA", qtd: 3, valor: 4_170, saldoAtual: 8 },
  { id: 2, data: "22/05/2026", produto: "Bancada Lúmen 1.40m", tipo: "Compra", natureza: "ENTRADA", qtd: 12, valor: 19_440, saldoAtual: 18 },
  { id: 3, data: "22/05/2026", produto: "Lavatório Onix Premium", tipo: "Venda", natureza: "SAÍDA", qtd: 2, valor: 6_380, saldoAtual: 3 },
  { id: 4, data: "21/05/2026", produto: "Espelho Halo LED 80cm", tipo: "Devolução Cliente", natureza: "ENTRADA", qtd: 1, valor: 380, saldoAtual: 12 },
  { id: 5, data: "21/05/2026", produto: "Cadeira Vintage Cobre", tipo: "Perda/Quebra", natureza: "SAÍDA", qtd: 1, valor: 1_480, saldoAtual: 28 },
  { id: 6, data: "20/05/2026", produto: "Carrinho Estética Pro", tipo: "Ajuste Inventário +", natureza: "ENTRADA", qtd: 4, valor: 1_640, saldoAtual: 42 },
];

const FRETES = [
  { id: 1, pedido: 1284, transportadora: "TransMóveis Express", origem: "São Paulo, SP", destino: "Curitiba, PR", peso: 84, valor: 480, prazo: 5, atraso: 0, status: "Em trânsito" },
  { id: 2, pedido: 1283, transportadora: "Logística Bella", origem: "São Paulo, SP", destino: "Recife, PE", peso: 142, valor: 1_280, prazo: 9, atraso: 0, status: "Em trânsito" },
  { id: 3, pedido: 1267, transportadora: "Rapidão Sul", origem: "São Paulo, SP", destino: "Porto Alegre, RS", peso: 96, valor: 720, prazo: 7, atraso: 5, status: "Atrasado" },
  { id: 4, pedido: 1271, transportadora: "TransMóveis Express", origem: "São Paulo, SP", destino: "Salvador, BA", peso: 64, valor: 580, prazo: 12, atraso: 0, status: "Entregue" },
];

const TRANSPORTADORAS = [
  { id: 1, nome: "TransMóveis Express", cnpj: "12.345.678/0001-01", fretes: 184, prazo: 6, atraso: 0.4, avaria: 0.8, rating: 5 },
  { id: 2, nome: "Logística Bella", cnpj: "98.765.432/0001-02", fretes: 92, prazo: 8, atraso: 0.2, avaria: 1.2, rating: 4 },
  { id: 3, nome: "Rota Brasil", cnpj: "55.111.222/0001-03", fretes: 64, prazo: 10, atraso: 1.8, avaria: 2.4, rating: 3 },
  { id: 4, nome: "Rapidão Sul", cnpj: "33.444.555/0001-04", fretes: 38, prazo: 7, atraso: 5.2, avaria: 2.1, rating: 2 },
  { id: 5, nome: "Norte Cargo", cnpj: "22.444.666/0001-05", fretes: 24, prazo: 12, atraso: 3.4, avaria: 4.2, rating: 2 },
];

window.ScreenEstoque = ScreenEstoque;
