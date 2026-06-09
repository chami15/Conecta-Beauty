const BASE = "";

function withQuery(path, query = {}) {
  const search = new URLSearchParams();
  Object.entries(query).forEach(([key, value]) => {
    if (value !== undefined && value !== null && value !== "") {
      search.set(key, String(value));
    }
  });
  const qs = search.toString();
  return qs ? `${path}?${qs}` : path;
}

async function get(path) {
  const res = await fetch(BASE + path);
  if (!res.ok) throw new Error(`${res.status} ${res.statusText}`);
  return res.json();
}

async function post(path, body) {
  const res = await fetch(BASE + path, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(body),
  });
  if (!res.ok) throw new Error(`${res.status} ${res.statusText}`);
  return res.json();
}

async function put(path, body) {
  const res = await fetch(BASE + path, {
    method: "PUT",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(body),
  });
  if (!res.ok) throw new Error(`${res.status} ${res.statusText}`);
  return res.json();
}

async function del(path) {
  const res = await fetch(BASE + path, { method: "DELETE" });
  if (!res.ok) throw new Error(`${res.status} ${res.statusText}`);
  return res.json();
}

// ─── Início ──────────────────────────────────────────────
export const api = {
  inicio: {
    kpis: (filters) => get(withQuery("/api/inicio/kpis", filters)),
    faturamentoDiario: (filters) => get(withQuery("/api/inicio/faturamento-diario", filters)),
    pedidosPorStatus: (filters) => get(withQuery("/api/inicio/pedidos-por-status", filters)),
    topProdutos: (filters) => get(withQuery("/api/inicio/top-produtos", filters)),
    saude: () => get("/api/inicio/saude"),
  },

  // ─── Administrativo ────────────────────────────────────
  admin: {
    kpis: (filters) => get(withQuery("/api/admin/kpis", filters)),
    canaisPorVenda: (filters) => get(withQuery("/api/admin/canais-por-venda", filters)),
    clientesPorRegiao: (filters) => get(withQuery("/api/admin/clientes-por-regiao", filters)),
    atualizarCubos: () => post("/api/admin/atualizar-cubos"),
    localizacoes: (search = "", limit = 50) => get(withQuery("/api/admin/localizacoes", { search, limit })),
    categorias: (search = "", limit = 50) => get(withQuery("/api/admin/categorias", { search, limit })),

    clientes: {
      list: (page = 1, size = 20) => get(`/api/admin/clientes?page=${page}&page_size=${size}`),
      get: (id) => get(`/api/admin/clientes/${id}`),
      create: (body) => post("/api/admin/clientes", body),
      update: (id, body) => put(`/api/admin/clientes/${id}`, body),
      delete: (id) => del(`/api/admin/clientes/${id}`),
    },

    produtos: {
      list: (page = 1, size = 20) => get(`/api/admin/produtos?page=${page}&page_size=${size}`),
      get: (id) => get(`/api/admin/produtos/${id}`),
      create: (body) => post("/api/admin/produtos", body),
      update: (id, body) => put(`/api/admin/produtos/${id}`, body),
      delete: (id) => del(`/api/admin/produtos/${id}`),
    },

    fornecedores: {
      list: (page = 1, size = 20) => get(`/api/admin/fornecedores?page=${page}&page_size=${size}`),
      get: (id) => get(`/api/admin/fornecedores/${id}`),
      create: (body) => post("/api/admin/fornecedores", body),
      update: (id, body) => put(`/api/admin/fornecedores/${id}`, body),
      delete: (id) => del(`/api/admin/fornecedores/${id}`),
    },

    canais: {
      list: () => get("/api/admin/canais"),
      get: (id) => get(`/api/admin/canais/${id}`),
      create: (body) => post("/api/admin/canais", body),
      update: (id, body) => put(`/api/admin/canais/${id}`, body),
      delete: (id) => del(`/api/admin/canais/${id}`),
    },
  },

  // ─── Financeiro ────────────────────────────────────────
  financeiro: {
    kpis: (filters) => get(withQuery("/api/financeiro/kpis", filters)),
    receitaVsDespesa: (filters) => get(withQuery("/api/financeiro/receita-vs-despesa", filters)),
    mixPagamento: (filters) => get(withQuery("/api/financeiro/mix-pagamento", filters)),

    transacoes: {
      list: (page = 1, size = 20) => get(`/api/financeiro/transacoes?page=${page}&page_size=${size}`),
      get: (id) => get(`/api/financeiro/transacoes/${id}`),
      create: (body) => post("/api/financeiro/transacoes", body),
      update: (id, body) => put(`/api/financeiro/transacoes/${id}`, body),
      delete: (id) => del(`/api/financeiro/transacoes/${id}`),
    },

    aReceber: (page = 1, size = 20) => get(`/api/financeiro/a-receber?page=${page}&page_size=${size}`),
    aPagar: (page = 1, size = 20) => get(`/api/financeiro/a-pagar?page=${page}&page_size=${size}`),

    formasPagamento: {
      list: () => get("/api/financeiro/formas-pagamento"),
      get: (id) => get(`/api/financeiro/formas-pagamento/${id}`),
      create: (body) => post("/api/financeiro/formas-pagamento", body),
      update: (id, body) => put(`/api/financeiro/formas-pagamento/${id}`, body),
      delete: (id) => del(`/api/financeiro/formas-pagamento/${id}`),
    },
  },

  // ─── Estoque ───────────────────────────────────────────
  estoque: {
    kpis: () => get("/api/estoque/kpis"),
    movimentacoesPorDia: (filters) => get(withQuery("/api/estoque/movimentacoes-por-dia", filters)),
    performanceTransportadoras: (filters) => get(withQuery("/api/estoque/performance-transportadoras", filters)),
    skusPontoCritico: () => get("/api/estoque/skus-ponto-critico"),
    calorMovimentacao: (filters) => get(withQuery("/api/estoque/calor-movimentacao", filters)),

    saldos: (page = 1, size = 20) => get(`/api/estoque/saldos?page=${page}&page_size=${size}`),
    tiposMovimentacao: () => get("/api/estoque/tipos-movimentacao"),

    movimentacoes: {
      list: (page = 1, size = 20) => get(`/api/estoque/movimentacoes?page=${page}&page_size=${size}`),
      get: (id) => get(`/api/estoque/movimentacoes/${id}`),
      create: (body) => post("/api/estoque/movimentacoes", body),
      delete: (id) => del(`/api/estoque/movimentacoes/${id}`),
    },

    fretes: {
      list: (page = 1, size = 20) => get(`/api/estoque/fretes?page=${page}&page_size=${size}`),
      get: (id) => get(`/api/estoque/fretes/${id}`),
      create: (body) => post("/api/estoque/fretes", body),
      update: (id, body) => put(`/api/estoque/fretes/${id}`, body),
      delete: (id) => del(`/api/estoque/fretes/${id}`),
    },

    transportadoras: {
      list: () => get("/api/estoque/transportadoras"),
      get: (id) => get(`/api/estoque/transportadoras/${id}`),
      create: (body) => post("/api/estoque/transportadoras", body),
      update: (id, body) => put(`/api/estoque/transportadoras/${id}`, body),
      delete: (id) => del(`/api/estoque/transportadoras/${id}`),
    },
  },

  // ─── Analytics / Estatísticas ─────────────────────────
  analytics: {
    tendencia: (filters) => get(withQuery("/api/analytics/inicio/tendencia", filters)),
    distribuicaoVendas: (filters) => get(withQuery("/api/analytics/inicio/distribuicao-vendas", filters)),
    anovaTrimetres: (filters) => get(withQuery("/api/analytics/financeiro/anova-trimestres", filters)),
    intervaloConfianca: (filters) => get(withQuery("/api/analytics/financeiro/intervalo-confianca", filters)),
    anovaCanais: (filters) => get(withQuery("/api/analytics/admin/anova-canais", filters)),
    correlacaoEstoque: (filters) => get(withQuery("/api/analytics/estoque/correlacao", filters)),
    descritivasProdutos: (filters) => get(withQuery("/api/analytics/estoque/descritivas", filters)),
  },

  // ─── ML ────────────────────────────────────────────────
  ml: {
    status: () => get("/api/ml/status"),
    treinar: () => post("/api/ml/treinar"),
    previsao: (horizonte = 3) => get(`/api/ml/previsao?horizonte=${horizonte}`),
  },
};
