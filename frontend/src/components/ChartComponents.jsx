import ReactApexChart from "react-apexcharts";

const FONT = "'Space Scroll', 'Space Grotesk', system-ui, sans-serif";
const MONO = "'The Brief', 'JetBrains Mono', monospace";

/* Shared dark-theme base */
const base = {
  chart: {
    background: "transparent",
    foreColor: "#8090c0",
    fontFamily: FONT,
    toolbar: {
      show: true,
      tools: { download: true, selection: false, zoom: true, zoomin: true, zoomout: true, pan: false, reset: true },
      export: { csv: { filename: "conecta-beauty" }, png: { filename: "conecta-beauty" } },
    },
    zoom: { enabled: true },
    animations: { enabled: true, speed: 350, animateGradually: { enabled: true, delay: 40 } },
  },
  grid: {
    borderColor: "rgba(255,255,255,0.06)",
    strokeDashArray: 3,
    padding: { top: 0, right: 12, bottom: 0, left: 8 },
    xaxis: { lines: { show: false } },
    yaxis: { lines: { show: true } },
  },
  tooltip: {
    theme: "dark",
    shared: true,
    intersect: false,
    style: { fontFamily: FONT, fontSize: "12px" },
  },
  legend: { show: false },
  dataLabels: { enabled: false },
  xaxis: {
    axisBorder: { show: false },
    axisTicks: { show: false },
    labels: { style: { colors: "#8090c0", fontFamily: MONO, fontSize: "10px" } },
  },
  yaxis: {
    labels: { style: { colors: "#8090c0", fontFamily: MONO, fontSize: "10px" } },
  },
};

/* ── LineChart (generic) ── */
export const LineChart = ({ labels = [], datasets = [], height = 260, yFormat, tooltipFormat }) => {
  const series = datasets.map((d) => ({ name: d.label || "", data: d.data || [] }));
  const options = {
    ...base,
    chart: { ...base.chart, type: "line" },
    colors: datasets.map((d) => d.borderColor || "#5b8eff"),
    stroke: {
      curve: "smooth",
      width: datasets.map((d) => d.borderWidth || 2),
      dashArray: datasets.map((d) => (d.borderDash ? 4 : 0)),
    },
    markers: { size: 0, hover: { size: 5 } },
    xaxis: { ...base.xaxis, categories: labels },
    yaxis: { ...base.yaxis, labels: { ...base.yaxis.labels, formatter: yFormat || ((v) => v) } },
    tooltip: { ...base.tooltip, y: { formatter: tooltipFormat || ((v) => v) } },
  };
  if (!series.length || !series[0].data.length) return <div style={{ height }} />;
  return <ReactApexChart options={options} series={series} type="line" height={height} />;
};

/* ── BarChart (generic) ── */
export const BarChart = ({ labels = [], datasets = [], height = 240, yFormat, horizontal = false, stacked = false }) => {
  const hasPerBarColors = datasets.length === 1 && Array.isArray(datasets[0].backgroundColor);
  const series = datasets.map((d) => ({ name: d.label || "", data: d.data || [] }));
  const colors = hasPerBarColors
    ? datasets[0].backgroundColor
    : datasets.map((d) => (typeof d.backgroundColor === "string" ? d.backgroundColor : "#5b8eff"));
  const options = {
    ...base,
    chart: { ...base.chart, type: "bar", stacked },
    colors,
    plotOptions: {
      bar: { horizontal, borderRadius: 4, columnWidth: "60%", distributed: hasPerBarColors },
    },
    xaxis: { ...base.xaxis, categories: labels },
    yaxis: { ...base.yaxis, labels: { ...base.yaxis.labels, formatter: yFormat || ((v) => v) } },
    tooltip: { ...base.tooltip, shared: !hasPerBarColors, y: { formatter: yFormat || ((v) => v) } },
    legend: { show: false },
  };
  if (!series.length || !series[0].data.length) return <div style={{ height }} />;
  return <ReactApexChart options={options} series={series} type="bar" height={height} />;
};

/* ── DoughnutChart ── */
export const DoughnutChart = ({ labels = [], data = [], colors = [], size = 200, centerLabel, centerValue }) => {
  const palette = colors.length ? colors : ["#22d47a", "#9ec5ff", "#ffbe2e", "#a78bfa", "#8090c0", "#4e5e90"];
  const options = {
    chart: { type: "donut", background: "transparent", fontFamily: FONT, toolbar: { show: false }, animations: { enabled: true, speed: 350 } },
    colors: palette,
    labels,
    plotOptions: {
      pie: {
        donut: {
          size: "72%",
          labels: {
            show: true,
            name: {
              show: !!centerLabel,
              color: "#8090c0",
              fontFamily: MONO,
              fontSize: "10px",
              offsetY: centerValue ? -6 : 0,
              formatter: () => centerLabel || "",
            },
            value: {
              show: !!centerValue,
              color: "#eef2ff",
              fontFamily: MONO,
              fontSize: "17px",
              fontWeight: 700,
              offsetY: 4,
              formatter: () => centerValue || "",
            },
            total: {
              show: true,
              label: centerLabel || "",
              color: "#8090c0",
              fontFamily: MONO,
              fontSize: "10px",
              formatter: () => centerValue || "",
            },
          },
        },
      },
    },
    stroke: { width: 0 },
    legend: { show: false },
    dataLabels: { enabled: false },
    tooltip: { theme: "dark", style: { fontFamily: FONT, fontSize: "12px" } },
  };
  if (!data.length) return <div style={{ width: size, height: size, flexShrink: 0 }} />;
  return (
    <div style={{ width: size, height: size, flexShrink: 0 }}>
      <ReactApexChart options={options} series={data} type="donut" height={size} />
    </div>
  );
};

/* ── RevenueVsExpenseChart ── */
export const RevenueVsExpenseChart = ({ labels, revenue, expense, height = 260 }) => {
  const series = [
    { name: "Receita", data: revenue || [] },
    { name: "Despesa", data: expense || [] },
  ];
  const options = {
    ...base,
    chart: { ...base.chart, type: "area" },
    colors: ["#22d47a", "#ff5470"],
    fill: {
      type: "gradient",
      gradient: { shadeIntensity: 1, opacityFrom: 0.38, opacityTo: 0.03, stops: [0, 85, 100] },
    },
    stroke: { curve: "smooth", width: 2, dashArray: [0, 5] },
    markers: { size: 0, hover: { size: 5 } },
    xaxis: { ...base.xaxis, categories: labels || [] },
    yaxis: {
      ...base.yaxis,
      labels: {
        ...base.yaxis.labels,
        formatter: (v) => "R$" + (Math.abs(v) >= 1000 ? Math.round(v / 1000) + "k" : v),
      },
    },
    tooltip: {
      ...base.tooltip,
      y: { formatter: (v) => "R$ " + (v || 0).toLocaleString("pt-BR", { minimumFractionDigits: 0 }) },
    },
    legend: { show: true, labels: { colors: "#8090c0" }, fontFamily: FONT, fontSize: "11px" },
  };
  if (!(revenue || []).length) return <div style={{ height }} />;
  return <ReactApexChart options={options} series={series} type="area" height={height} />;
};

/* ── FaturamentoDiarioChart ── */
export const FaturamentoDiarioChart = ({ labels, atual, anterior, height = 260 }) => {
  const series = [
    { name: "Atual", data: atual || [] },
    ...(anterior && anterior.length ? [{ name: "Anterior", data: anterior }] : []),
  ];
  const options = {
    ...base,
    chart: { ...base.chart, type: "area" },
    colors: ["#22d47a", "#94a3b8"],
    fill: {
      type: "gradient",
      gradient: { shadeIntensity: 1, opacityFrom: 0.4, opacityTo: 0.02, stops: [0, 85, 100] },
    },
    stroke: { curve: "smooth", width: [2.5, 1.5], dashArray: [0, 4] },
    markers: { size: 0, hover: { size: 5 } },
    xaxis: { ...base.xaxis, categories: labels || [] },
    yaxis: {
      ...base.yaxis,
      labels: {
        ...base.yaxis.labels,
        formatter: (v) => "R$" + (Math.abs(v) >= 1000 ? Math.round(v / 1000) + "k" : v),
      },
    },
    tooltip: {
      ...base.tooltip,
      y: { formatter: (v) => "R$ " + (v || 0).toLocaleString("pt-BR", { minimumFractionDigits: 0 }) },
    },
    legend: { show: (anterior || []).length > 0, labels: { colors: "#8090c0" }, fontFamily: FONT, fontSize: "11px" },
  };
  if (!(atual || []).length) return <div style={{ height }} />;
  return <ReactApexChart options={options} series={series} type="area" height={height} />;
};

/* ── MovimentacoesChart ── */
export const MovimentacoesChart = ({ labels, entradas, saidas, height = 260 }) => {
  const series = [
    { name: "Entradas", data: entradas || [] },
    { name: "Saídas", data: saidas || [] },
  ];
  const options = {
    ...base,
    chart: { ...base.chart, type: "area" },
    colors: ["#22d47a", "#ff5470"],
    fill: {
      type: "gradient",
      gradient: { shadeIntensity: 1, opacityFrom: 0.35, opacityTo: 0.03, stops: [0, 85, 100] },
    },
    stroke: { curve: "smooth", width: 2 },
    markers: { size: 0, hover: { size: 5 } },
    xaxis: { ...base.xaxis, categories: labels || [] },
    yaxis: {
      ...base.yaxis,
      labels: { ...base.yaxis.labels, formatter: (v) => v + " un" },
    },
    tooltip: { ...base.tooltip, y: { formatter: (v) => v + " unidades" } },
    legend: { show: true, labels: { colors: "#8090c0" }, fontFamily: FONT, fontSize: "11px" },
  };
  if (!(entradas || []).length) return <div style={{ height }} />;
  return <ReactApexChart options={options} series={series} type="area" height={height} />;
};

/* ── HistogramChart ── */
export const HistogramChart = ({ labels, data, height = 200 }) => {
  const options = {
    ...base,
    chart: { ...base.chart, type: "bar", toolbar: { show: false }, zoom: { enabled: false } },
    colors: ["rgba(37,99,235,0.7)"],
    plotOptions: { bar: { borderRadius: 3, columnWidth: "90%" } },
    xaxis: { ...base.xaxis, categories: labels || [] },
    yaxis: { ...base.yaxis, labels: { ...base.yaxis.labels, formatter: (v) => v + "×" } },
    tooltip: { ...base.tooltip, shared: false, y: { formatter: (v) => v + " ocorrências" } },
  };
  if (!(data || []).length) return <div style={{ height }} />;
  return <ReactApexChart options={options} series={[{ name: "Frequência", data: data || [] }]} type="bar" height={height} />;
};

/* ── MLForecastChart ── */
export const MLForecastChart = ({ labels, historico, previsao, height = 300 }) => {
  const series = [
    { name: "Histórico", data: historico || [] },
    { name: "Previsão", data: previsao || [] },
  ];
  const options = {
    ...base,
    chart: { ...base.chart, type: "line" },
    colors: ["#5b8eff", "#d97706"],
    stroke: { curve: "smooth", width: [2, 2], dashArray: [0, 5] },
    markers: { size: [2, 5], strokeWidth: 0, hover: { size: 6 } },
    xaxis: { ...base.xaxis, categories: labels || [] },
    yaxis: {
      ...base.yaxis,
      labels: {
        ...base.yaxis.labels,
        formatter: (v) => "R$" + (Math.abs(v) >= 1000 ? Math.round(v / 1000) + "k" : v),
      },
    },
    tooltip: {
      ...base.tooltip,
      y: { formatter: (v) => "R$ " + (v || 0).toLocaleString("pt-BR", { minimumFractionDigits: 0 }) },
    },
    legend: { show: true, labels: { colors: "#8090c0" }, fontFamily: FONT, fontSize: "11px" },
  };
  if (!(historico || []).length) return <div style={{ height }} />;
  return <ReactApexChart options={options} series={series} type="line" height={height} />;
};
