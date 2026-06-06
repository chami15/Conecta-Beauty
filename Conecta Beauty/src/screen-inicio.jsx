/* Tela INÍCIO — Resumo executivo mensal */

const ScreenInicio = () => {
  const [period, setPeriod] = useState("Maio");

  const vendasSerie = [42, 38, 51, 47, 55, 62, 58, 65, 71, 68, 74, 82, 78, 85, 91, 88, 96, 102, 98, 105, 112, 108, 115, 122, 119, 128, 134, 131, 142, 148];
  const vendasCompare = [38, 35, 41, 39, 44, 48, 46, 52, 55, 54, 58, 62, 60, 66, 71, 68, 73, 78, 76, 82, 86, 84, 89, 93, 91, 97, 102, 100, 108, 112];
  const dias = Array.from({ length: 30 }, (_, i) => String(i + 1));

  return (
    <div className="screen-pad screen-anim">
      {/* HEADER */}
      <div className="screen-header">
        <div>
          <div className="screen-eyebrow">01 · Painel executivo</div>
          <div className="screen-title">Resumo mensal</div>
        </div>
        <PeriodSelector
          value={period} onChange={setPeriod}
          options={["Hoje", "7d", "30d", "Maio", "YTD", "12m"]}
        />
      </div>

      {/* TOP KPI ROW */}
      <div className="grid grid-4" style={{ marginBottom: 16 }}>
        <Card>
          <KPI
            label="Faturamento"
            currency="R$"
            value="487.290"
            delta={23.4}
            deltaLabel="vs Mai/25 · R$ 394.860"
            sparkline={<Sparkline data={vendasSerie} width={220} height={36} color="var(--pos)"/>}
          />
        </Card>
        <Card>
          <KPI
            label="Pedidos"
            value="312"
            delta={11.8}
            deltaLabel="vs mês anterior"
            sparkline={<MiniBars data={[18, 22, 28, 24, 30, 35, 32, 38, 41, 39, 44, 48]} width={220} height={36} color="var(--pos)"/>}
          />
        </Card>
        <Card>
          <KPI
            label="Ticket médio"
            currency="R$"
            value="1.561"
            delta={4.2}
            deltaLabel="média 12m: R$ 1.498"
            sparkline={<Sparkline data={[1420, 1440, 1390, 1480, 1510, 1495, 1530, 1545, 1561]} width={220} height={36} color="var(--pos)"/>}
          />
        </Card>
        <Card>
          <KPI
            label="Clientes ativos"
            value="1.842"
            delta={-2.3}
            deltaLabel="38 perderam atividade"
            sparkline={<Sparkline data={[1900, 1920, 1910, 1895, 1880, 1870, 1860, 1855, 1842]} width={220} height={36} color="var(--neg)"/>}
          />
        </Card>
      </div>

      {/* MAIN CHART + HEALTH */}
      <div className="grid grid-12" style={{ marginBottom: 16 }}>
        <div className="col-8">
          <Card
            title="Faturamento diário"
            sub="MAIO · COMPARADO COM MAIO/2025"
            action={
              <>
                <span className="chip pos"><span style={{ width: 8, height: 2, background: "var(--pos)", display: "inline-block" }}/> 2026</span>
                <span className="chip"><span style={{ width: 8, height: 2, borderTop: "1px dashed var(--fg-3)", display: "inline-block" }}/> 2025</span>
              </>
            }
          >
            <LineChart
              width={780} height={260}
              data={vendasSerie} compare={vendasCompare} labels={dias}
              yFormat={(v) => "R$" + Math.round(v) + "k"}
              color="var(--pos)"
              compareColor="var(--fg-4)"
              annot={{ index: 22, label: "Pico no dia 23", sub: "R$ 24.8k · campanha Mãe", side: "left" }}
            />
            <div className="row" style={{ gap: 16, marginTop: 16, paddingTop: 16, borderTop: "1px solid var(--line)" }}>
              <Stat label="Melhor dia" value="R$ 24.8k" sub="dia 23"/>
              <Stat label="Pior dia" value="R$ 7.1k" sub="dia 02"/>
              <Stat label="Variação" value="+23,4%" sub="vs Mai/25" pos/>
              <Stat label="Projeção mês" value="R$ 521k" sub="+R$ 38k vs meta" pos/>
            </div>
          </Card>
        </div>
        <div className="col-4">
          <Card title="Saúde da empresa" sub="ÍNDICE COMPOSTO · MAIO">
            <div style={{ display: "grid", placeItems: "center", padding: "8px 0 16px" }}>
              <Gauge value={78} max={100} label="Score saudável" status="pos"/>
            </div>
            <div className="stack" style={{ gap: 10 }}>
              <HealthLine label="Vendas" value={88} status="pos"/>
              <HealthLine label="Margem" value={71} status="warn"/>
              <HealthLine label="Estoque" value={64} status="warn"/>
              <HealthLine label="Inadimplência" value={92} status="pos"/>
              <HealthLine label="Logística" value={75} status="pos"/>
            </div>
          </Card>
        </div>
      </div>

      {/* SECONDARY */}
      <div className="grid grid-12">
        <div className="col-4">
          <Card title="Pedidos por status" sub="EM ABERTO · TEMPO REAL">
            <div className="row" style={{ alignItems: "center", gap: 24 }}>
              <Donut
                size={140}
                centerLabel="Em aberto"
                centerValue="187"
                segments={[
                  { value: 84, color: "var(--pos)" },
                  { value: 56, color: "#9ec5ff" },
                  { value: 31, color: "var(--warn)" },
                  { value: 16, color: "var(--neg)" },
                ]}
              />
              <div className="stack" style={{ flex: 1, gap: 8 }}>
                <DonutLegend color="var(--pos)" label="Confirmados" value="84"/>
                <DonutLegend color="#9ec5ff" label="Enviados" value="56"/>
                <DonutLegend color="var(--warn)" label="Pendentes" value="31"/>
                <DonutLegend color="var(--neg)" label="Atrasados" value="16"/>
              </div>
            </div>
          </Card>
        </div>

        <div className="col-4">
          <Card title="Alertas" sub="AGORA · 3 NOVOS">
            <div className="stack" style={{ gap: 10 }}>
              <Insight tone="neg" icon={<I.alert size={14}/>} title="6 SKUs abaixo do estoque mínimo">
                Cadeiras Bella, Bancadas Lúmen e Lavatórios Onix — risco de ruptura em 9 dias.
              </Insight>
              <Insight tone="warn" icon={<I.truck size={14}/>} title="2 fretes com atraso > 5 dias">
                Transportadora Rapidão Sul · revisar SLA antes do fim do mês.
              </Insight>
              <Insight tone="pos" icon={<I.trending size={14}/>} title="E-commerce cresceu 38% em Maio">
                Canal pode receber +R$ 18k de mídia para sustentar a curva.
              </Insight>
            </div>
          </Card>
        </div>

        <div className="col-4">
          <Card title="Top 5 produtos" sub="POR FATURAMENTO · MAIO">
            <BarList
              showRank
              color="var(--pos)"
              items={[
                { label: "Cadeira Bella Reclinável", sub: "Cadeiras", value: 58420, delta: 18.4, color: "var(--pos)" },
                { label: "Bancada Lúmen 1.40m", sub: "Bancadas", value: 47210, delta: 9.7, color: "var(--pos)" },
                { label: "Lavatório Onix Premium", sub: "Lavatórios", value: 39880, delta: -3.2, color: "var(--neg)" },
                { label: "Espelho Halo LED", sub: "Espelhos", value: 28930, delta: 22.1, color: "var(--pos)" },
                { label: "Carrinho Estética Pro", sub: "Acessórios", value: 18450, delta: 5.6, color: "var(--pos)" },
              ]}
            />
          </Card>
        </div>
      </div>
    </div>
  );
};

const Stat = ({ label, value, sub, pos, neg }) => (
  <div style={{ flex: 1 }}>
    <div className="mono" style={{ fontSize: 10, color: "var(--fg-3)", textTransform: "uppercase", letterSpacing: "0.16em", fontWeight: 500 }}>{label}</div>
    <div style={{ fontFamily: "var(--sans)", fontSize: 18, fontWeight: 600, color: pos ? "var(--pos)" : neg ? "var(--neg)" : "var(--fg)", marginTop: 4, letterSpacing: "-0.01em", fontVariantNumeric: "tabular-nums" }}>{value}</div>
    <div style={{ fontSize: 11, color: "var(--fg-3)", marginTop: 2 }}>{sub}</div>
  </div>
);

const HealthLine = ({ label, value, status }) => {
  const color = status === "neg" ? "var(--neg)" : status === "warn" ? "var(--warn)" : "var(--pos)";
  return (
    <div>
      <div className="row between" style={{ marginBottom: 4, fontSize: 12 }}>
        <span style={{ color: "var(--fg-2)" }}>{label}</span>
        <span className="mono" style={{ color: "var(--fg-3)" }}>{value}/100</span>
      </div>
      <div className="bar"><i style={{ width: `${value}%`, background: color }}/></div>
    </div>
  );
};

const DonutLegend = ({ color, label, value }) => (
  <div className="row between" style={{ fontSize: 12 }}>
    <div className="row" style={{ gap: 8 }}>
      <span style={{ width: 8, height: 8, borderRadius: 2, background: color, display: "inline-block" }}/>
      <span style={{ color: "var(--fg-2)" }}>{label}</span>
    </div>
    <span className="mono" style={{ color: "var(--fg)" }}>{value}</span>
  </div>
);

window.ScreenInicio = ScreenInicio;
Object.assign(window, { Stat, HealthLine, DonutLegend });
