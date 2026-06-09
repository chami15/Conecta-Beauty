export const MONTH_OPTIONS = [
  { value: 1, label: "Jan" },
  { value: 2, label: "Fev" },
  { value: 3, label: "Mar" },
  { value: 4, label: "Abr" },
  { value: 5, label: "Mai" },
  { value: 6, label: "Jun" },
  { value: 7, label: "Jul" },
  { value: 8, label: "Ago" },
  { value: 9, label: "Set" },
  { value: 10, label: "Out" },
  { value: 11, label: "Nov" },
  { value: 12, label: "Dez" },
];

export const YEAR_OPTIONS = Array.from(
  { length: new Date().getFullYear() - 2020 },
  (_, index) => 2021 + index,
).reverse();

export function createAnalysisFilter(initialYear = "") {
  return {
    scope: initialYear ? "year" : "all",
    year: initialYear,
    month: "",
  };
}

export function toApiTimeParams(filter) {
  if (!filter || filter.scope === "all") {
    return {};
  }

  const year = Number(filter.year);
  if (!Number.isFinite(year) || year <= 0) {
    return {};
  }

  if (filter.scope === "month") {
    const month = Number(filter.month);
    if (!Number.isFinite(month) || month < 1 || month > 12) {
      return { ano: year };
    }
    return { ano: year, mes: month };
  }

  return { ano: year };
}

export function formatAnalysisWindow(filter) {
  if (!filter || filter.scope === "all") {
    return "Todo o histórico";
  }

  if (filter.scope === "month" && filter.year && filter.month) {
    const month = MONTH_OPTIONS.find((item) => item.value === Number(filter.month));
    return `${month?.label ?? "Mês"} de ${filter.year}`;
  }

  if (filter.year) {
    return `Ano ${filter.year}`;
  }

  return "Todo o histórico";
}
