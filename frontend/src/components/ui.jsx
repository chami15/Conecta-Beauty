import { useState, useEffect, useRef, useMemo } from "react";
import { I } from "./icons";
import { MONTH_OPTIONS } from "../utils/time";

/* ── Formatting ── */
export const fmt = {
  brl:    (n) => "R$ " + (n || 0).toLocaleString("pt-BR", { minimumFractionDigits: 2, maximumFractionDigits: 2 }),
  brlC:   (n) => (n || 0).toLocaleString("pt-BR", { minimumFractionDigits: 0, maximumFractionDigits: 0 }),
  int:    (n) => (n || 0).toLocaleString("pt-BR"),
  pct:    (n, d = 1) => (n >= 0 ? "+" : "") + (n || 0).toFixed(d) + "%",
  pctRaw: (n, d = 1) => (n || 0).toFixed(d) + "%",
  date:   (s) => s ? new Date(s).toLocaleDateString("pt-BR") : "—",
  monthYear: (s) => s ? new Date(`${s}T00:00:00`).toLocaleDateString("pt-BR", { month: "2-digit", year: "numeric" }) : "—",
};

/* ── Loading / Error ── */
export const LoadingState = ({ label = "Carregando..." }) => (
  <div className="loading-state">
    <div className="spinner" />
    <span>{label}</span>
  </div>
);

export const SearchSelect = ({
  value,
  onChange,
  options = [],
  placeholder = "Pesquisar...",
  emptyLabel = "Nenhuma opcao encontrada.",
}) => {
  const [query, setQuery] = useState("");
  const [open, setOpen] = useState(false);
  const ref = useRef(null);
  const selectedOption = options.find((option) => String(option.value) === String(value));

  useEffect(() => {
    setQuery(selectedOption?.label ?? "");
  }, [selectedOption?.label]);

  useEffect(() => {
    if (!open) return undefined;
    const handleClickOutside = (event) => {
      if (ref.current && !ref.current.contains(event.target)) {
        setOpen(false);
        setQuery(selectedOption?.label ?? "");
      }
    };
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, [open, selectedOption?.label]);

  const filtered = options.filter((option) => option.label.toLowerCase().includes(query.toLowerCase()));

  return (
    <div className="search-select" ref={ref}>
      <input
        value={query}
        placeholder={placeholder}
        onFocus={() => setOpen(true)}
        onChange={(e) => {
          setQuery(e.target.value);
          setOpen(true);
          if (!e.target.value) onChange?.("");
        }}
      />
      <button className="search-select-toggle" type="button" onClick={() => setOpen((state) => !state)}>
        <I.arrowDown size={12} style={{ transform: open ? "rotate(180deg)" : "none", transition: "transform 0.15s" }} />
      </button>
      {open && (
        <div className="search-select-menu">
          {filtered.length > 0 ? filtered.map((option) => (
            <button
              key={`${option.value}-${option.label}`}
              type="button"
              className="search-select-option"
              onClick={() => {
                onChange?.(option.value);
                setQuery(option.label);
                setOpen(false);
              }}
            >
              <span>{option.label}</span>
              {String(option.value) === String(value) && <I.check size={12} style={{ color: "var(--accent)" }} />}
            </button>
          )) : (
            <div className="search-select-empty">{emptyLabel}</div>
          )}
        </div>
      )}
    </div>
  );
};

export const ErrorState = ({ msg }) => (
  <div className="error-state">
    <I.alert size={14} /> {msg || "Erro ao carregar dados."}
  </div>
);

export function useApi(fn, deps = []) {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const load = async () => {
    setLoading(true);
    setError(null);
    try {
      const result = await fn();
      setData(result);
    } catch (e) {
      setError(e.message);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => { load(); }, deps);

  return { data, loading, error, reload: load };
}

/* ── Card ── */
export const Card = ({ title, sub, action, children, flush = false, compact = false, style, className = "" }) => (
  <div className={"card " + (flush ? "flush " : "") + className} style={compact ? { padding: "10px 20px 14px", display: "flex", flexDirection: "column", justifyContent: "center", minHeight: 92, borderTop: "3px solid var(--accent)", overflow: "hidden", ...style } : style}>
    {(title || action) && (
      <div className="card-header" style={flush ? { padding: "20px 20px 0", marginBottom: 16 } : null}>
        <div>
          {title && <div className="card-title">{title}</div>}
          {sub && <div className="card-sub">{sub}</div>}
        </div>
        <div className="row" style={{ gap: 6, flexShrink: 0 }}>{action}</div>
      </div>
    )}
    {children}
  </div>
);

/* ── KPI ── */
export const KPI = ({ label, value, currency, unit, delta, deltaLabel, footnote, text = false }) => {
  const isPos = (delta ?? 0) >= 0;
  const hasFoot = delta != null || deltaLabel || footnote;
  return (
    <div className="kpi">
      <div className="kpi-label">{label}</div>
      <div className={text ? "kpi-value kpi-value--text" : "kpi-value"}>
        {!text && currency && <span className="currency">{currency}</span>}
        <span>{value}</span>
        {!text && unit && <span className="unit">{unit}</span>}
      </div>
      {hasFoot && (
        <div className="kpi-foot">
          {delta != null && (
            <span className={"delta " + (isPos ? "pos" : "neg")}>
              {isPos ? <I.arrowUp size={10} stroke={2.4} /> : <I.arrowDown size={10} stroke={2.4} />}
              {fmt.pct(delta).replace(/^[+-]/, (m) => m)}
            </span>
          )}
          {deltaLabel && <span>{deltaLabel}</span>}
          {footnote && !deltaLabel && <span>{footnote}</span>}
        </div>
      )}
    </div>
  );
};

/* ── Sparkline (SVG) ── */
function smoothPath(points) {
  if (!points.length) return "";
  if (points.length === 1) return `M${points[0][0]},${points[0][1]}`;
  let d = `M${points[0][0]},${points[0][1]}`;
  for (let i = 0; i < points.length - 1; i++) {
    const [x0, y0] = points[i], [x1, y1] = points[i + 1];
    const mx = (x0 + x1) / 2;
    d += ` C${mx},${y0} ${mx},${y1} ${x1},${y1}`;
  }
  return d;
}

const TIP_STYLE = {
  position: "fixed",
  background: "var(--bg-1, #1a2240)",
  border: "1px solid rgba(255,255,255,0.12)",
  borderRadius: 4,
  padding: "3px 8px",
  fontSize: 10,
  fontFamily: "var(--mono, monospace)",
  color: "var(--fg, #eef2ff)",
  pointerEvents: "none",
  zIndex: 9999,
  whiteSpace: "nowrap",
  boxShadow: "0 2px 10px rgba(0,0,0,0.5)",
  transform: "translateX(-50%)",
};

export const Sparkline = ({ data, width = 120, height = 32, color = "var(--accent)", showDot = true, fill = true, format }) => {
  const id = useMemo(() => "spk-" + Math.random().toString(36).slice(2, 7), []);
  const [tip, setTip] = useState(null);
  const svgRef = useRef(null);

  if (!data || !data.length) return null;
  const min = Math.min(...data), max = Math.max(...data), range = max - min || 1;
  const pad = 2;
  const pts = data.map((v, i) => [
    pad + (i / (data.length - 1 || 1)) * (width - pad * 2),
    height - pad - ((v - min) / range) * (height - pad * 2),
  ]);

  const fmtVal = format || ((v) => "R$ " + (v || 0).toLocaleString("pt-BR", { maximumFractionDigits: 0 }));

  const handleMove = (e) => {
    if (!svgRef.current) return;
    const rect = svgRef.current.getBoundingClientRect();
    const xRatio = (e.clientX - rect.left) / rect.width;
    const idx = Math.min(data.length - 1, Math.max(0, Math.round(xRatio * (data.length - 1))));
    setTip({ idx, val: data[idx], x: e.clientX, y: e.clientY });
  };

  return (
    <div style={{ position: "relative" }}>
      <svg ref={svgRef} width={width} height={height} viewBox={`0 0 ${width} ${height}`}
        preserveAspectRatio="none"
        style={{ display: "block", width: "100%", maxWidth: width, height: "auto", cursor: "crosshair" }}
        onMouseMove={handleMove}
        onMouseLeave={() => setTip(null)}>
        <defs>
          <linearGradient id={id} x1="0" x2="0" y1="0" y2="1">
            <stop offset="0%" stopColor={color} stopOpacity="0.35" />
            <stop offset="100%" stopColor={color} stopOpacity="0" />
          </linearGradient>
        </defs>
        {fill && <path d={smoothPath(pts) + ` L${pts[pts.length - 1][0]},${height} L${pts[0][0]},${height} Z`} fill={`url(#${id})`} />}
        <path d={smoothPath(pts)} stroke={color} strokeWidth="1.5" fill="none" strokeLinecap="round" />
        {showDot && !tip && <circle cx={pts[pts.length - 1][0]} cy={pts[pts.length - 1][1]} r="2.5" fill={color} />}
        {tip && (
          <>
            <line x1={pts[tip.idx][0]} y1={0} x2={pts[tip.idx][0]} y2={height}
              stroke={color} strokeWidth="0.6" strokeDasharray="2,2" opacity="0.5" />
            <circle cx={pts[tip.idx][0]} cy={pts[tip.idx][1]} r="3" fill={color} />
          </>
        )}
      </svg>
      {tip && (
        <div style={{ ...TIP_STYLE, left: tip.x, top: tip.y - 32 }}>
          {fmtVal(tip.val)}
        </div>
      )}
    </div>
  );
};

/* ── Mini bars ── */
export const MiniBars = ({ data, width = 200, height = 56, color = "var(--accent)", highlightLast = true, format }) => {
  const [tip, setTip] = useState(null);
  const max = Math.max(...data);
  const gap = 3;
  const bw = (width - gap * (data.length - 1)) / data.length;
  const fmtVal = format || ((v) => "R$ " + (v || 0).toLocaleString("pt-BR", { maximumFractionDigits: 0 }));

  return (
    <div style={{ position: "relative" }}>
      <svg width={width} height={height} viewBox={`0 0 ${width} ${height}`} preserveAspectRatio="none"
        style={{ display: "block", width: "100%", maxWidth: width, height: "auto", cursor: "default" }}
        onMouseLeave={() => setTip(null)}>
        {data.map((v, i) => {
          const h = (v / max) * (height - 4);
          const isLast = highlightLast && i === data.length - 1;
          const isHov = tip?.idx === i;
          return (
            <rect key={i} x={i * (bw + gap)} y={height - h} width={bw} height={h}
              rx={Math.min(2, bw / 3)}
              fill={isHov || isLast ? color : "var(--line-3)"}
              opacity={isHov ? 1 : isLast ? 1 : 0.7}
              onMouseEnter={(e) => setTip({ idx: i, val: v, x: e.clientX, y: e.clientY })}
              onMouseMove={(e) => setTip((t) => t?.idx === i ? { ...t, x: e.clientX, y: e.clientY } : t)}
            />
          );
        })}
      </svg>
      {tip && (
        <div style={{ ...TIP_STYLE, left: tip.x, top: tip.y - 32 }}>
          {fmtVal(tip.val)}
        </div>
      )}
    </div>
  );
};

/* ── Gauge ── */
export const Gauge = ({ value, max = 100, label, size = 180, status }) => {
  const r = 70, cx = size / 2, cy = size * 0.62;
  const start = Math.PI, end = 0;
  const pct = Math.max(0, Math.min(1, value / max));
  const angle = start + (end - start) * pct;
  const x1 = cx + r * Math.cos(start), y1 = cy - r * Math.sin(start);
  const x2 = cx + r * Math.cos(end),   y2 = cy - r * Math.sin(end);
  const xv = cx + r * Math.cos(angle), yv = cy - r * Math.sin(angle);
  const color = status === "neg" ? "var(--neg)" : status === "warn" ? "var(--warn)" : "var(--pos)";
  const svgH = cy + 16;
  return (
    <div style={{ width: size, display: "grid" }}>
      <svg width={size} height={svgH} style={{ display: "block", gridArea: "1/1" }}>
        <path d={`M ${x1} ${y1} A ${r} ${r} 0 0 1 ${x2} ${y2}`} stroke="var(--bg-2)" strokeWidth="14" fill="none" strokeLinecap="round" />
        <path d={`M ${x1} ${y1} A ${r} ${r} 0 0 1 ${xv} ${yv}`} stroke={color} strokeWidth="14" fill="none" strokeLinecap="round" />
        <circle cx={xv} cy={yv} r="6" fill="var(--bg)" stroke={color} strokeWidth="2.5" />
      </svg>
      <div style={{ gridArea: "1/1", alignSelf: "end", textAlign: "center", paddingBottom: 6 }}>
        <div className="mono" style={{ fontSize: 32, color: "var(--fg)", letterSpacing: "-0.02em", lineHeight: 1 }}>
          {value}<span style={{ color: "var(--fg-3)", fontSize: 14 }}>/{max}</span>
        </div>
        <div className="mono" style={{ fontSize: 10, color: "var(--fg-3)", textTransform: "uppercase", letterSpacing: "0.14em", marginTop: 4 }}>{label}</div>
      </div>
    </div>
  );
};

/* ── Heatmap ── */
export const Heatmap = ({ rows, cols, values, format = (v) => v, color = "var(--accent)" }) => {
  const max = Math.max(...values.flat()) || 1;
  return (
    <div className="scroll-x">
      <table className="heatmap-table">
        <thead>
          <tr>
            <th />
            {cols.map((c, i) => <th key={i}>{c}</th>)}
          </tr>
        </thead>
        <tbody>
          {rows.map((r, i) => (
            <tr key={i}>
              <td style={{ color: "var(--fg-3)", paddingRight: 8, fontSize: 11, fontFamily: "var(--mono)" }}>{r}</td>
              {cols.map((_, j) => {
                const v = values[i]?.[j] ?? 0;
                const op = (v / max) * 0.9 + 0.1;
                return (
                  <td key={j}>
                    <div className="heatmap-cell" style={{ background: color, opacity: op, color: op > 0.5 ? "white" : "var(--fg-2)" }}>
                      {format(v)}
                    </div>
                  </td>
                );
              })}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

/* ── Donut ── */
export const Donut = ({ segments, size = 140, stroke = 14, centerLabel, centerValue }) => {
  const r = (size - stroke) / 2;
  const c = 2 * Math.PI * r;
  const total = segments.reduce((s, x) => s + x.value, 0);
  let acc = 0;
  return (
    <div style={{ position: "relative", width: size, height: size, flexShrink: 0 }}>
      <svg width={size} height={size} style={{ transform: "rotate(-90deg)" }}>
        <circle cx={size / 2} cy={size / 2} r={r} stroke="var(--bg-2)" strokeWidth={stroke} fill="none" />
        {total > 0 && segments.map((s, i) => {
          const len = (s.value / total) * c;
          const off = c - acc;
          acc += len;
          return (
            <circle key={i} cx={size / 2} cy={size / 2} r={r}
              stroke={s.color} strokeWidth={stroke}
              strokeDasharray={`${len} ${c - len}`} strokeDashoffset={off}
              fill="none" strokeLinecap="butt" />
          );
        })}
      </svg>
      <div style={{ position: "absolute", inset: 0, display: "grid", placeItems: "center", textAlign: "center", pointerEvents: "none" }}>
        <div>
          <div className="mono" style={{ fontSize: 10, color: "var(--fg-3)", textTransform: "uppercase", letterSpacing: "0.12em" }}>{centerLabel}</div>
          <div className="mono" style={{ fontSize: 18, color: "var(--fg)", marginTop: 2, fontWeight: 700 }}>{centerValue}</div>
        </div>
      </div>
    </div>
  );
};

/* ── Bar list ── */
export const BarList = ({ items, max: maxProp, color = "var(--accent)", format = fmt.brl, showRank = false }) => {
  const maxV = maxProp || Math.max(...items.map((i) => i.value));
  return (
    <div className="stack" style={{ gap: 14 }}>
      {items.map((it, idx) => (
        <div key={idx}>
          <div className="row between" style={{ marginBottom: 6 }}>
            <div className="row" style={{ gap: 10 }}>
              {showRank && <span className="mono" style={{ fontSize: 11, color: "var(--fg-4)", width: 18 }}>{String(idx + 1).padStart(2, "0")}</span>}
              <div>
                <div style={{ fontSize: 13, color: "var(--fg)" }}>{it.label}</div>
                {it.sub && <div style={{ fontSize: 11, color: "var(--fg-4)", marginTop: 2 }}>{it.sub}</div>}
              </div>
            </div>
            <div className="row" style={{ gap: 8 }}>
              {it.delta != null && (
                <span className={"delta " + (it.delta >= 0 ? "pos" : "neg")} style={{ fontSize: 10 }}>
                  {it.delta >= 0 ? "+" : ""}{Number(it.delta).toFixed(1)}%
                </span>
              )}
              <span className="mono" style={{ fontSize: 12, color: "var(--fg-2)" }}>{format(it.value)}</span>
            </div>
          </div>
          <div className="bar">
            <i style={{ width: `${(it.value / maxV) * 100}%`, background: it.color || color }} />
          </div>
        </div>
      ))}
    </div>
  );
};

/* ── Insight strip ── */
export const Insight = ({ tone = "accent", icon, title, children, action }) => {
  const toneColor = tone === "neg" ? "var(--neg)" : tone === "pos" ? "var(--pos)" : tone === "warn" ? "var(--warn)" : "var(--accent)";
  return (
    <div style={{
      padding: "12px 14px", display: "flex", alignItems: "flex-start", gap: 12,
      background: "var(--bg-1)", border: "1px solid var(--line)",
      borderLeft: `2px solid ${toneColor}`, borderRadius: 6,
    }}>
      <div style={{ color: toneColor, display: "grid", placeItems: "center", paddingTop: 1, flexShrink: 0 }}>
        {icon || <I.alert size={14} />}
      </div>
      <div style={{ flex: 1 }}>
        <div style={{ fontSize: 13, fontWeight: 500, color: "var(--fg)" }}>{title}</div>
        <div style={{ fontSize: 12, color: "var(--fg-3)", marginTop: 2, lineHeight: 1.4 }}>{children}</div>
      </div>
      {action}
    </div>
  );
};

/* ── Period selector ── */
export const PeriodSelector = ({ value, onChange, options }) => (
  <div className="period">
    {options.map((opt) => (
      <button key={opt} className={value === opt ? "active" : ""} onClick={() => onChange(opt)}>{opt}</button>
    ))}
  </div>
);

export const AnalysisFilter = ({ value, onChange, yearOptions = [], monthOptions = MONTH_OPTIONS }) => {
  const scope = value?.scope ?? "all";
  const year = value?.year ?? "";
  const month = value?.month ?? "";

  const setScope = (nextScope) => {
    onChange?.((prev) => ({
      ...prev,
      scope: nextScope,
      month: nextScope === "month" ? prev.month : "",
    }));
  };

  const setYear = (nextYear) => {
    onChange?.((prev) => ({
      ...prev,
      year: nextYear,
      month: prev.scope === "month" ? prev.month : "",
    }));
  };

  const setMonth = (nextMonth) => {
    onChange?.((prev) => ({ ...prev, month: nextMonth }));
  };

  return (
    <div className="analysis-filter">
      <div className="period">
        {[
          { id: "all", label: "Tudo" },
          { id: "year", label: "Ano" },
          { id: "month", label: "Mês" },
        ].map((item) => (
          <button
            key={item.id}
            className={scope === item.id ? "active" : ""}
            onClick={() => setScope(item.id)}
          >
            {item.label}
          </button>
        ))}
      </div>

      {(scope === "year" || scope === "month") && (
        <select className="filter-select" value={year} onChange={(e) => setYear(e.target.value)}>
          <option value="">Selecionar ano</option>
          {yearOptions.map((option) => (
            <option key={option} value={option}>{option}</option>
          ))}
        </select>
      )}

      {scope === "month" && (
        <select className="filter-select" value={month} onChange={(e) => setMonth(e.target.value)} disabled={!year}>
          <option value="">Selecionar mês</option>
          {monthOptions.map((option) => (
            <option key={option.value} value={option.value}>{option.label}</option>
          ))}
        </select>
      )}
    </div>
  );
};

/* ── Segmented nav ── */
export const SegmentedNav = ({ items, value, onChange }) => {
  const refs = useRef({});
  const [ind, setInd] = useState({ left: 4, width: 0 });
  useEffect(() => {
    const el = refs.current[value];
    if (el) setInd({ left: el.offsetLeft, width: el.offsetWidth });
  }, [value, items.length]);
  return (
    <div className="seg">
      <div className="seg-indicator" style={{ left: ind.left, width: ind.width }} />
      {items.map((item) => (
        <button key={item.id} ref={(el) => (refs.current[item.id] = el)}
          className={"seg-btn " + (value === item.id ? "active" : "")}
          onClick={() => onChange(item.id)}>
          {item.label}
        </button>
      ))}
    </div>
  );
};

/* ── Manage Dropdown ── */
export const ManageDropdown = ({ items, value, onChange }) => {
  const [open, setOpen] = useState(false);
  const ref = useRef(null);

  useEffect(() => {
    const handler = (e) => { if (ref.current && !ref.current.contains(e.target)) setOpen(false); };
    document.addEventListener("mousedown", handler);
    return () => document.removeEventListener("mousedown", handler);
  }, []);

  const current = items.find((it) => !it.section && it.id === value);

  return (
    <div ref={ref} style={{ position: "relative" }}>
      <button className="btn" onClick={() => setOpen((o) => !o)} style={{ gap: 8, minWidth: 160 }}>
        {current?.icon && <span style={{ color: "var(--accent)", display: "flex" }}>{current.icon}</span>}
        <span style={{ flex: 1, textAlign: "left" }}>{current?.label ?? "Gerenciar"}</span>
        <I.arrowDown size={11} style={{ opacity: 0.5, transform: open ? "rotate(180deg)" : "none", transition: "transform 0.15s", flexShrink: 0 }} />
      </button>
      {open && (
        <div style={{
          position: "absolute", top: "calc(100% + 6px)", left: 0, minWidth: 190,
          background: "var(--bg-1)", border: "1px solid var(--line-2)",
          borderRadius: "var(--r2)", boxShadow: "0 8px 32px rgba(0,0,0,0.45)",
          zIndex: 50, overflow: "hidden",
        }}>
          {items.map((it, i) => {
            if (it.section) return (
              <div key={i} style={{ padding: "10px 12px 4px", fontSize: 10, fontWeight: 700, color: "var(--fg-4)", textTransform: "uppercase", letterSpacing: "0.08em" }}>
                {it.section}
              </div>
            );
            const active = value === it.id;
            return (
              <button key={it.id} onClick={() => { onChange(it.id); setOpen(false); }} style={{
                display: "flex", alignItems: "center", gap: 10, width: "100%",
                padding: "9px 12px", fontSize: 13, cursor: "pointer",
                color: active ? "var(--fg)" : "var(--fg-2)",
                background: active ? "var(--accent-bg)" : "transparent",
                border: "none", transition: "background 0.1s",
              }}>
                <span style={{ color: active ? "var(--accent)" : "var(--fg-4)", display: "flex" }}>{it.icon}</span>
                {it.label}
                {active && <I.check size={12} style={{ marginLeft: "auto", color: "var(--accent)" }} />}
              </button>
            );
          })}
        </div>
      )}
    </div>
  );
};

/* ── Sidebar ── */
export const SideNav = ({ items, value, onChange, collapsed, onToggle }) => (
  <aside className={"sidebar " + (collapsed ? "collapsed" : "")}>
    <button className="sidebar-toggle" onClick={onToggle} title={collapsed ? "Expandir" : "Recolher"}>
      {collapsed ? <I.arrowRight size={13} /> : <I.arrowLeft size={13} />}
    </button>
    {items.map((it, i) => {
      if (it.section) return <div key={i} className="nav-section">{it.section}</div>;
      return (
        <button key={it.id} className={"nav-item " + (value === it.id ? "active" : "")}
          onClick={() => onChange(it.id)} title={collapsed ? it.label : undefined}>
          <span className="nav-ico">{it.icon}</span>
          <span className="lbl">{it.label}</span>
        </button>
      );
    })}
  </aside>
);

/* ── Drawer ── */
export const Drawer = ({ open, onClose, title, eyebrow, children, footer }) => {
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
          <button className="icon-btn" onClick={onClose}><I.close size={16} /></button>
        </div>
        <div className="drawer-body">{children}</div>
        {footer && <div className="drawer-foot">{footer}</div>}
      </div>
    </>
  );
};

/* ── Form Field ── */
export const Field = ({ label, children, hint }) => (
  <div className="field">
    {label && <label>{label}</label>}
    {children}
    {hint && <div className="hint">{hint}</div>}
  </div>
);

/* ── Check ── */
export const Check = ({ on, onClick }) => (
  <button className={"check " + (on ? "on" : "")} onClick={onClick}>
    {on && <I.check size={10} stroke={3} style={{ color: "white" }} />}
  </button>
);

/* ── CRUD Toolbar ── */
export const CrudToolbar = ({
  searchPlaceholder = "Buscar...",
  onSearch,
  onAdd,
  onEdit,
  onDelete,
  selectedCount = 0,
  filterContent = null,
  filterActive = false,
  onClearFilters = null,
  addLabel = "Adicionar",
}) => {
  const [q, setQ] = useState("");
  const [filtersOpen, setFiltersOpen] = useState(false);
  const filterRef = useRef(null);
  useEffect(() => {
    if (!filtersOpen) return undefined;
    const handleClickOutside = (event) => {
      if (filterRef.current && !filterRef.current.contains(event.target)) {
        setFiltersOpen(false);
      }
    };
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, [filtersOpen]);

  const handleChange = (e) => {
    setQ(e.target.value);
    onSearch?.(e.target.value);
  };
  return (
    <div className="toolbar" style={{ marginBottom: 12 }}>
      <div className="toolbar-search">
        <I.search size={14} />
        <input placeholder={searchPlaceholder} value={q} onChange={handleChange} />
        <span className="kbd">⌘K</span>
      </div>
      {filterContent && (
        <div className="toolbar-filter-wrap" ref={filterRef}>
          <button
            className="btn"
            onClick={() => setFiltersOpen((open) => !open)}
            style={filterActive ? { borderColor: "var(--accent)", color: "var(--accent)" } : null}
          >
            <I.filter size={13} /> Filtros
          </button>
          {filtersOpen && (
            <div className="toolbar-filter-popover">
              <div className="toolbar-filter-head">
                <span>Filtrar registros</span>
                {onClearFilters && (
                  <button className="btn ghost" onClick={onClearFilters} style={{ fontSize: 11, padding: "6px 8px" }}>
                    Limpar
                  </button>
                )}
              </div>
              <div className="toolbar-filter-body">{filterContent}</div>
            </div>
          )}
        </div>
      )}
      <div className="toolbar-divider" />
      {onEdit && (
        <button className="btn" onClick={onEdit} disabled={selectedCount !== 1}>
          <I.pencil size={13} /> Editar
        </button>
      )}
      {onDelete && (
        <button className="btn neg" onClick={onDelete} disabled={selectedCount === 0}>
          <I.trash size={13} /> Excluir {selectedCount > 0 && <span style={{ opacity: 0.7 }}>({selectedCount})</span>}
        </button>
      )}
      <button className="btn primary" onClick={onAdd}>
        <I.plus size={13} stroke={2.2} /> {addLabel}
      </button>
    </div>
  );
};

/* ── DataTable ── */
export const DataTable = ({ columns, rows, selectable = true, selected = new Set(), onToggle, onToggleAll, onRowEdit, emptyText = "Nenhum registro." }) => {
  const allOn = selectable && rows.length > 0 && rows.every((r) => selected.has(r.id));
  return (
    <div className="scroll-x">
      <table className="table">
        <thead>
          <tr>
            {selectable && <th style={{ width: 36 }}><Check on={allOn} onClick={onToggleAll} /></th>}
            {columns.map((c) => (
              <th key={c.key} className={c.num ? "num" : ""} style={c.width ? { width: c.width } : null}>{c.label}</th>
            ))}
            <th style={{ width: 64 }} />
          </tr>
        </thead>
        <tbody>
          {rows.length === 0 ? (
            <tr><td colSpan={columns.length + (selectable ? 2 : 1)} style={{ padding: 40, textAlign: "center", color: "var(--fg-4)" }}>{emptyText}</td></tr>
          ) : rows.map((r) => (
            <tr key={r.id} className={selected.has(r.id) ? "selected" : ""}>
              {selectable && <td><Check on={selected.has(r.id)} onClick={() => onToggle?.(r.id)} /></td>}
              {columns.map((c) => (
                <td key={c.key} className={c.num ? "num" : ""}>{c.render ? c.render(r) : r[c.key]}</td>
              ))}
              <td>
                <div className="row-actions">
                  <button className="icon-btn" style={{ width: 26, height: 26 }} onClick={() => onRowEdit?.(r)}><I.pencil size={12} /></button>
                  <button className="icon-btn" style={{ width: 26, height: 26 }}><I.more size={14} /></button>
                </div>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

/* ── Stat mini cell ── */
export const Stat = ({ label, value, sub, pos, neg }) => (
  <div style={{ flex: 1 }}>
    <div className="mono" style={{ fontSize: 10, color: "var(--fg-3)", textTransform: "uppercase", letterSpacing: "0.16em", fontWeight: 600 }}>{label}</div>
    <div style={{ fontFamily: "var(--sans)", fontSize: 18, fontWeight: 700, color: pos ? "var(--pos)" : neg ? "var(--neg)" : "var(--fg)", marginTop: 4, letterSpacing: "-0.01em", fontVariantNumeric: "tabular-nums" }}>{value}</div>
    {sub && <div style={{ fontSize: 11, color: "var(--fg-3)", marginTop: 2 }}>{sub}</div>}
  </div>
);

/* ── Health line ── */
export const HealthLine = ({ label, value, status }) => {
  const color = status === "neg" ? "var(--neg)" : status === "warn" ? "var(--warn)" : "var(--pos)";
  return (
    <div>
      <div className="row between" style={{ marginBottom: 4, fontSize: 12 }}>
        <span style={{ color: "var(--fg-2)" }}>{label}</span>
        <span className="mono" style={{ color: "var(--fg-3)" }}>{value}/100</span>
      </div>
      <div className="bar"><i style={{ width: `${value}%`, background: color }} /></div>
    </div>
  );
};

/* ── Donut legend ── */
export const DonutLegend = ({ color, label, value }) => (
  <div className="row between" style={{ fontSize: 12 }}>
    <div className="row" style={{ gap: 8 }}>
      <span style={{ width: 8, height: 8, borderRadius: 2, background: color, display: "inline-block" }} />
      <span style={{ color: "var(--fg-2)" }}>{label}</span>
    </div>
    <span className="mono" style={{ color: "var(--fg)" }}>{value}</span>
  </div>
);

/* ── DRE line ── */
export const DreLine = ({ label, value, bold, indent, pos, highlight }) => (
  <div style={{
    display: "flex", justifyContent: "space-between",
    padding: "9px 0", borderBottom: "1px solid var(--line)",
    paddingLeft: indent ? 12 : 0,
    background: highlight ? "var(--bg-1)" : "transparent",
    marginInline: highlight ? -12 : 0,
    paddingInline: highlight ? 12 : (indent ? 12 : 0),
    borderRadius: highlight ? 4 : 0,
    marginTop: highlight ? 6 : 0,
  }}>
    <span style={{ fontSize: 12, color: bold ? "var(--fg)" : "var(--fg-3)", fontWeight: bold ? 700 : 400 }}>{label}</span>
    <span className="mono" style={{
      fontSize: 12,
      color: highlight ? "var(--pos)" : bold && pos ? "var(--pos)" : bold ? "var(--fg)" : (value < 0 ? "var(--neg)" : "var(--fg-2)"),
      fontWeight: bold ? 700 : 400,
    }}>
      {value < 0 ? "−" : ""} {fmt.brl(Math.abs(value))}
    </span>
  </div>
);

/* ── Pagination ── */
export const Pagination = ({ page, total, pageSize, onPage }) => {
  const pages = Math.ceil(total / pageSize);
  if (pages <= 1) return null;
  return (
    <div className="pagination">
      <span>{((page - 1) * pageSize) + 1}–{Math.min(page * pageSize, total)} de {total}</span>
      <div className="row">
        <button className="btn" disabled={page <= 1} onClick={() => onPage(page - 1)}>
          <I.arrowLeft size={13} />
        </button>
        <span className="mono" style={{ fontSize: 12, padding: "0 8px" }}>{page}/{pages}</span>
        <button className="btn" disabled={page >= pages} onClick={() => onPage(page + 1)}>
          <I.arrowRight size={13} />
        </button>
      </div>
    </div>
  );
};

/* ── Star rating (percentage-based) ── */
export const StarRating = ({ pct = 0, size = 12 }) => {
  const filled = Math.round((pct / 100) * 5);
  const color = pct >= 80 ? "var(--pos)" : pct >= 50 ? "var(--warn)" : "var(--neg)";
  return (
    <div className="row" style={{ gap: 3 }}>
      {Array.from({ length: 5 }).map((_, i) => (
        <I.star key={i} size={size} stroke={1.5}
          style={{ color: i < filled ? color : "var(--line-2)", fill: i < filled ? color : "transparent" }} />
      ))}
      <span className="mono" style={{ fontSize: 10, color, marginLeft: 4, fontWeight: 700 }}>
        {pct.toFixed(0)}%
      </span>
    </div>
  );
};

/* ── Stock level bar ── */
export const StockLevel = ({ saldo, min, max }) => {
  const pct = Math.max(0, Math.min(100, (saldo / max) * 100));
  const minPct = (min / max) * 100;
  const color = saldo <= min ? "var(--neg)" : saldo <= min * 1.5 ? "var(--warn)" : "var(--pos)";
  return (
    <div className="stock-level">
      <div className="bar"><i style={{ width: `${pct}%`, background: color }} /></div>
      <div className="stock-level-marker" style={{ left: `${minPct}%` }} />
    </div>
  );
};
