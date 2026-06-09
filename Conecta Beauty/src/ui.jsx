/* Shared UI primitives */
const { useState, useEffect, useMemo, useRef, useCallback } = React;

/* ---------- formatting ---------- */
const fmt = {
  brl: (n) => "R$ " + (n||0).toLocaleString("pt-BR", { minimumFractionDigits: 2, maximumFractionDigits: 2 }),
  brlC: (n) => (n||0).toLocaleString("pt-BR", { minimumFractionDigits: 0, maximumFractionDigits: 0 }),
  int: (n) => (n||0).toLocaleString("pt-BR"),
  pct: (n, d = 1) => (n>=0?"+":"") + (n||0).toFixed(d) + "%",
  pctRaw: (n, d = 1) => (n||0).toFixed(d) + "%",
};

/* ---------- card ---------- */
const Card = ({ title, sub, action, children, flush = false, style, className = "", titleAccent }) => (
  <div className={"card " + (flush?"flush ":"") + className} style={style}>
    {(title || action) && (
      <div className="card-header" style={flush ? { padding: "20px 20px 0", marginBottom: 16 } : null}>
        <div>
          {title && <div className="card-title">{title}</div>}
          {sub && <div className="card-sub">{sub}</div>}
        </div>
        <div className="row" style={{ gap: 6 }}>{action}</div>
      </div>
    )}
    {children}
  </div>
);

/* ---------- KPI ---------- */
const KPI = ({ label, value, currency, unit, delta, deltaLabel, sparkline, footnote, big = false }) => {
  const isPos = (delta ?? 0) >= 0;
  return (
    <div className="kpi">
      <div className="kpi-label">{label}</div>
      <div className="kpi-value" style={ big ? { fontSize: 40 } : null }>
        {currency && <span className="currency">{currency}</span>}
        <span>{value}</span>
        {unit && <span className="unit">{unit}</span>}
      </div>
      <div className="kpi-foot">
        {delta !== undefined && (
          <span className={"delta " + (isPos ? "pos" : "neg")}>
            {isPos ? <I.arrowUp size={10} stroke={2.4}/> : <I.arrowDown size={10} stroke={2.4}/>}
            {fmt.pct(delta).replace(/^[+-]/, m => m)}
          </span>
        )}
        {deltaLabel && <span>{deltaLabel}</span>}
        {footnote && !deltaLabel && <span>{footnote}</span>}
      </div>
      {sparkline && <div style={{ marginTop: 4 }}>{sparkline}</div>}
    </div>
  );
};

/* ---------- segmented nav ---------- */
const SegmentedNav = ({ items, value, onChange }) => {
  const refs = useRef({});
  const [ind, setInd] = useState({ left: 4, width: 0 });

  useEffect(() => {
    const el = refs.current[value];
    if (el) {
      setInd({ left: el.offsetLeft, width: el.offsetWidth });
    }
  }, [value, items.length]);

  return (
    <div className="seg">
      <div className="seg-indicator" style={{ left: ind.left, width: ind.width }} />
      {items.map(item => (
        <button
          key={item.id}
          ref={el => (refs.current[item.id] = el)}
          className={"seg-btn " + (value === item.id ? "active" : "")}
          onClick={() => onChange(item.id)}
        >
          <span className="dot" />
          {item.label}
        </button>
      ))}
    </div>
  );
};

/* ---------- period selector ---------- */
const PeriodSelector = ({ value, onChange, options }) => (
  <div className="period">
    {options.map(opt => (
      <button
        key={opt}
        className={value === opt ? "active" : ""}
        onClick={() => onChange(opt)}
      >{opt}</button>
    ))}
  </div>
);

/* ---------- toolbar (CRUD) ---------- */
const CrudToolbar = ({
  searchPlaceholder = "Buscar...",
  onAdd, onEdit, onDelete,
  selectedCount = 0,
  extraFilters = null,
  addLabel = "Adicionar",
}) => {
  const [q, setQ] = useState("");
  return (
    <div className="toolbar">
      <div className="toolbar-search">
        <I.search size={14} />
        <input
          placeholder={searchPlaceholder}
          value={q}
          onChange={e => setQ(e.target.value)}
        />
        <span className="kbd">⌘K</span>
      </div>

      {extraFilters}

      <div className="toolbar-divider" />

      <button className="btn" onClick={onEdit} disabled={selectedCount === 0} style={selectedCount===0?{opacity:.45, cursor:"default"}:null}>
        <I.pencil size={13} />
        Editar
      </button>
      <button className="btn neg" onClick={onDelete} disabled={selectedCount === 0} style={selectedCount===0?{opacity:.45, cursor:"default"}:null}>
        <I.trash size={13} />
        Excluir {selectedCount > 0 && <span style={{ opacity: .7 }}>({selectedCount})</span>}
      </button>
      <button className="btn primary" onClick={onAdd}>
        <I.plus size={13} stroke={2.2}/>
        {addLabel}
      </button>
    </div>
  );
};

/* ---------- drawer ---------- */
const Drawer = ({ open, onClose, title, eyebrow, children, footer }) => {
  useEffect(() => {
    const onKey = (e) => { if (e.key === "Escape" && open) onClose?.(); };
    window.addEventListener("keydown", onKey);
    return () => window.removeEventListener("keydown", onKey);
  }, [open, onClose]);

  return (
    <>
      <div className={"drawer-backdrop " + (open ? "open" : "")} onClick={onClose} />
      <div className={"drawer " + (open ? "open" : "")}>
        <div className="drawer-head">
          <div>
            {eyebrow && <div className="card-sub" style={{ marginBottom: 4 }}>{eyebrow}</div>}
            <div className="drawer-title">{title}</div>
          </div>
          <button className="icon-btn" onClick={onClose}><I.close size={16}/></button>
        </div>
        <div className="drawer-body">{children}</div>
        {footer && <div className="drawer-foot">{footer}</div>}
      </div>
    </>
  );
};

/* ---------- field ---------- */
const Field = ({ label, children, hint }) => (
  <div className="field">
    <label>{label}</label>
    {children}
    {hint && <div className="hint">{hint}</div>}
  </div>
);

/* ---------- selectable row check ---------- */
const Check = ({ on, onClick }) => (
  <button className={"check " + (on ? "on" : "")} onClick={onClick}>
    {on && <I.check size={10} stroke={3} style={{ color: "white" }}/>}
  </button>
);

/* ---------- table ---------- */
const DataTable = ({ columns, rows, selectable = true, selected = new Set(), onToggle, onToggleAll, emptyText = "Nenhum registro." }) => {
  const allOn = selectable && rows.length > 0 && rows.every(r => selected.has(r.id));
  return (
    <div className="scroll-x">
      <table className="table">
        <thead>
          <tr>
            {selectable && (
              <th style={{ width: 36 }}>
                <Check on={allOn} onClick={onToggleAll}/>
              </th>
            )}
            {columns.map(c => (
              <th key={c.key} className={c.num?"num":""} style={c.width?{width: c.width}:null}>{c.label}</th>
            ))}
            <th style={{ width: 60 }}></th>
          </tr>
        </thead>
        <tbody>
          {rows.length === 0 ? (
            <tr><td colSpan={columns.length + (selectable?2:1)} style={{ padding: 40, textAlign: "center", color: "var(--fg-4)" }}>{emptyText}</td></tr>
          ) : rows.map(r => (
            <tr key={r.id} className={selected.has(r.id) ? "selected" : ""}>
              {selectable && (
                <td><Check on={selected.has(r.id)} onClick={() => onToggle(r.id)}/></td>
              )}
              {columns.map(c => (
                <td key={c.key} className={c.num?"num":""}>{c.render ? c.render(r) : r[c.key]}</td>
              ))}
              <td>
                <div className="row row-actions" style={{ gap: 2, justifyContent: "flex-end" }}>
                  <button className="icon-btn" style={{ width: 26, height: 26 }}><I.pencil size={12}/></button>
                  <button className="icon-btn" style={{ width: 26, height: 26 }}><I.more size={14}/></button>
                </div>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

/* ---------- alert / insight strip ---------- */
const Insight = ({ tone = "accent", icon, title, children, action }) => {
  const toneColor = tone === "neg" ? "var(--neg)" : tone === "pos" ? "var(--pos)" : tone === "warn" ? "var(--warn)" : "var(--fg)";
  return (
    <div style={{
      padding: "12px 14px",
      display: "flex", alignItems: "flex-start", gap: 12,
      background: "var(--bg-1)",
      border: "1px solid var(--line)",
      borderLeft: `2px solid ${toneColor}`,
      borderRadius: 6,
    }}>
      <div style={{ color: toneColor, display: "grid", placeItems: "center", paddingTop: 1, flexShrink: 0 }}>
        {icon || <I.alert size={14}/>}
      </div>
      <div style={{ flex: 1 }}>
        <div style={{ fontSize: 13, fontWeight: 500, color: "var(--fg)" }}>{title}</div>
        <div style={{ fontSize: 12, color: "var(--fg-3)", marginTop: 2, lineHeight: 1.4 }}>{children}</div>
      </div>
      {action}
    </div>
  );
};

/* ---------- inner sidebar ---------- */
const SideNav = ({ items, value, onChange, collapsed, onToggle }) => {
  return (
    <aside className={"sidebar " + (collapsed ? "collapsed" : "")}>
      <button className="sidebar-toggle" onClick={onToggle} title={collapsed ? "Expandir" : "Recolher"}>
        {collapsed ? <I.arrowRight size={14}/> : <I.arrowLeft size={14}/>}
      </button>
      {items.map((it, i) => {
        if (it.section) {
          return <div key={i} className="nav-section">{it.section}</div>;
        }
        return (
          <button
            key={it.id}
            className={"nav-item " + (value === it.id ? "active" : "")}
            onClick={() => onChange(it.id)}
            title={collapsed ? it.label : undefined}
          >
            <span className="nav-ico">{it.icon}</span>
            <span className="lbl">{it.label}</span>
          </button>
        );
      })}
    </aside>
  );
};

Object.assign(window, {
  fmt, Card, KPI, SegmentedNav, PeriodSelector, CrudToolbar, Drawer, Field, Check, DataTable, Insight, SideNav,
});
