/* SVG-based charts — hand-drawn, minimalist with micro-annotations. */

/* helper: build smooth path from points */
function smoothPath(points) {
  if (points.length === 0) return "";
  if (points.length === 1) return `M${points[0][0]},${points[0][1]}`;
  let d = `M${points[0][0]},${points[0][1]}`;
  for (let i = 0; i < points.length - 1; i++) {
    const [x0, y0] = points[i];
    const [x1, y1] = points[i+1];
    const mx = (x0 + x1) / 2;
    d += ` C${mx},${y0} ${mx},${y1} ${x1},${y1}`;
  }
  return d;
}

/* ---------- Sparkline ---------- */
const Sparkline = ({ data, width = 120, height = 32, color = "var(--accent)", showDot = true, fill = true }) => {
  if (!data || data.length === 0) return null;
  const min = Math.min(...data);
  const max = Math.max(...data);
  const range = max - min || 1;
  const pad = 2;
  const pts = data.map((v, i) => [
    pad + (i / (data.length - 1)) * (width - pad * 2),
    height - pad - ((v - min) / range) * (height - pad * 2),
  ]);
  const id = useMemo(() => "spk-" + Math.random().toString(36).slice(2, 8), []);
  return (
    <svg width={width} height={height} viewBox={`0 0 ${width} ${height}`} preserveAspectRatio="none" style={{ display: "block", width: "100%", maxWidth: width, height: "auto" }}>
      <defs>
        <linearGradient id={id} x1="0" x2="0" y1="0" y2="1">
          <stop offset="0%" stopColor={color} stopOpacity="0.35"/>
          <stop offset="100%" stopColor={color} stopOpacity="0"/>
        </linearGradient>
      </defs>
      {fill && (
        <path
          d={smoothPath(pts) + ` L${pts[pts.length-1][0]},${height} L${pts[0][0]},${height} Z`}
          fill={`url(#${id})`}
        />
      )}
      <path d={smoothPath(pts)} stroke={color} strokeWidth="1.5" fill="none" strokeLinecap="round" vectorEffect="non-scaling-stroke"/>
      {showDot && (
        <circle cx={pts[pts.length-1][0]} cy={pts[pts.length-1][1]} r="2.5" fill={color}/>
      )}
    </svg>
  );
};

/* ---------- Annotated Line Chart (the "money" chart) ----------
   - faint grid
   - faint comparison series (prev year/month dashed)
   - bold current series
   - annotation marker on the most relevant point
   - axis labels minimal
*/
const LineChart = ({
  width = 640,
  height = 240,
  data,
  compare,
  labels,
  yFormat = (n) => n,
  annot,
  color = "var(--accent)",
  compareColor = "var(--fg-4)",
}) => {
  const padL = 44, padR = 24, padT = 20, padB = 28;
  const allVals = [...(data || []), ...(compare || [])];
  const min = Math.min(...allVals);
  const max = Math.max(...allVals);
  const range = (max - min) * 1.15 || 1;
  const yMin = min - (max - min) * 0.05;
  const innerW = width - padL - padR;
  const innerH = height - padT - padB;

  const toX = (i, len) => padL + (i / (len - 1)) * innerW;
  const toY = (v) => padT + innerH - ((v - yMin) / range) * innerH;

  const ptsCur = data.map((v, i) => [toX(i, data.length), toY(v)]);
  const ptsCmp = compare ? compare.map((v, i) => [toX(i, compare.length), toY(v)]) : null;

  const id = useMemo(() => "lc-" + Math.random().toString(36).slice(2, 8), []);

  // y-axis ticks (5)
  const ticks = [];
  for (let i = 0; i <= 4; i++) {
    const v = yMin + (range / 1.15) * (i / 4) + (i === 0 ? 0 : 0);
    const tv = min + (max - min) * (i / 4);
    ticks.push({ y: toY(tv), v: tv });
  }

  return (
    <svg width={width} height={height} style={{ display: "block", width: "100%", height: "auto" }} viewBox={`0 0 ${width} ${height}`}>
      <defs>
        <linearGradient id={id} x1="0" x2="0" y1="0" y2="1">
          <stop offset="0%" stopColor={color} stopOpacity="0.28"/>
          <stop offset="100%" stopColor={color} stopOpacity="0"/>
        </linearGradient>
      </defs>

      {/* grid */}
      {ticks.map((t, i) => (
        <g key={i}>
          <line x1={padL} x2={width - padR} y1={t.y} y2={t.y} className="grid-line"/>
          <text x={padL - 8} y={t.y + 3} textAnchor="end" className="axis-label">{yFormat(t.v)}</text>
        </g>
      ))}

      {/* compare series */}
      {ptsCmp && (
        <path d={smoothPath(ptsCmp)} stroke={compareColor} strokeWidth="1" fill="none" strokeDasharray="3 4" strokeLinecap="round"/>
      )}

      {/* current series - fill + line */}
      <path
        d={smoothPath(ptsCur) + ` L${ptsCur[ptsCur.length-1][0]},${padT + innerH} L${ptsCur[0][0]},${padT + innerH} Z`}
        fill={`url(#${id})`}
      />
      <path d={smoothPath(ptsCur)} stroke={color} strokeWidth="2" fill="none" strokeLinecap="round"/>

      {/* end dot */}
      <circle cx={ptsCur[ptsCur.length-1][0]} cy={ptsCur[ptsCur.length-1][1]} r="3.5" fill={color}/>
      <circle cx={ptsCur[ptsCur.length-1][0]} cy={ptsCur[ptsCur.length-1][1]} r="7" fill={color} opacity="0.18"/>

      {/* x labels */}
      {labels && labels.map((l, i) => (
        i % Math.ceil(labels.length / 8) === 0 || i === labels.length - 1 ? (
          <text key={i} x={toX(i, labels.length)} y={height - 10} textAnchor="middle" className="axis-label">{l}</text>
        ) : null
      ))}

      {/* annotation */}
      {annot && (() => {
        const i = annot.index;
        const x = toX(i, data.length);
        const y = toY(data[i]);
        const labelX = x + (annot.side === "left" ? -10 : 10);
        const labelY = y - 22;
        const anchor = annot.side === "left" ? "end" : "start";
        return (
          <g>
            <line x1={x} x2={x} y1={y} y2={labelY + 6} stroke="var(--fg-3)" strokeWidth="1" strokeDasharray="2 3"/>
            <circle cx={x} cy={y} r="3" fill="var(--bg)" stroke="var(--accent-2)" strokeWidth="1.5"/>
            <text x={labelX} y={labelY} textAnchor={anchor} className="annot-text" style={{ fill: "var(--fg)" }}>{annot.label}</text>
            <text x={labelX} y={labelY + 12} textAnchor={anchor} className="annot-text">{annot.sub}</text>
          </g>
        );
      })()}
    </svg>
  );
};

/* ---------- Horizontal Bar List ---------- */
const BarList = ({ items, max, color = "var(--accent)", format = fmt.brl, showRank = false }) => {
  const maxV = max || Math.max(...items.map(i => i.value));
  return (
    <div className="stack" style={{ gap: 14 }}>
      {items.map((it, idx) => (
        <div key={idx}>
          <div className="row between" style={{ marginBottom: 6 }}>
            <div className="row" style={{ gap: 10 }}>
              {showRank && (
                <span className="mono" style={{ fontSize: 11, color: "var(--fg-4)", width: 18 }}>
                  {String(idx+1).padStart(2,"0")}
                </span>
              )}
              <div>
                <div style={{ fontSize: 13, color: "var(--fg)" }}>{it.label}</div>
                {it.sub && <div style={{ fontSize: 11, color: "var(--fg-4)", marginTop: 2 }}>{it.sub}</div>}
              </div>
            </div>
            <div className="row" style={{ gap: 8 }}>
              {it.delta !== undefined && (
                <span className={"delta " + (it.delta >= 0 ? "pos" : "neg")} style={{ fontSize: 10 }}>
                  {it.delta >= 0 ? "+" : ""}{it.delta.toFixed(1)}%
                </span>
              )}
              <span className="mono" style={{ fontSize: 12, color: "var(--fg-2)" }}>
                {format(it.value)}
              </span>
            </div>
          </div>
          <div className="bar">
            <i style={{
              width: `${(it.value / maxV) * 100}%`,
              background: it.color || color,
            }}/>
          </div>
        </div>
      ))}
    </div>
  );
};

/* ---------- Donut / Ring ---------- */
const Donut = ({ segments, size = 140, stroke = 14, centerLabel, centerValue }) => {
  const r = (size - stroke) / 2;
  const c = 2 * Math.PI * r;
  const total = segments.reduce((s, x) => s + x.value, 0);
  let acc = 0;
  return (
    <div style={{ position: "relative", width: size, height: size }}>
      <svg width={size} height={size} style={{ transform: "rotate(-90deg)" }}>
        <circle cx={size/2} cy={size/2} r={r} stroke="var(--bg-1)" strokeWidth={stroke} fill="none"/>
        {segments.map((s, i) => {
          const len = (s.value / total) * c;
          const off = c - acc;
          acc += len;
          return (
            <circle
              key={i}
              cx={size/2} cy={size/2} r={r}
              stroke={s.color}
              strokeWidth={stroke}
              strokeDasharray={`${len} ${c - len}`}
              strokeDashoffset={off}
              fill="none"
              strokeLinecap="butt"
            />
          );
        })}
      </svg>
      <div style={{
        position: "absolute", inset: 0,
        display: "grid", placeItems: "center",
        textAlign: "center", pointerEvents: "none",
      }}>
        <div>
          <div className="mono" style={{ fontSize: 11, color: "var(--fg-3)", textTransform: "uppercase", letterSpacing: "0.14em" }}>{centerLabel}</div>
          <div className="mono" style={{ fontSize: 22, color: "var(--fg)", marginTop: 2 }}>{centerValue}</div>
        </div>
      </div>
    </div>
  );
};

/* ---------- Mini bar (vertical) ---------- */
const MiniBars = ({ data, width = 200, height = 56, color = "var(--accent)", highlightLast = true }) => {
  const max = Math.max(...data);
  const gap = 3;
  const bw = (width - gap * (data.length - 1)) / data.length;
  return (
    <svg width={width} height={height} viewBox={`0 0 ${width} ${height}`} preserveAspectRatio="none" style={{ display: "block", width: "100%", maxWidth: width, height: "auto" }}>
      {data.map((v, i) => {
        const h = (v / max) * (height - 4);
        const isLast = highlightLast && i === data.length - 1;
        return (
          <rect
            key={i}
            x={i * (bw + gap)}
            y={height - h}
            width={bw}
            height={h}
            rx={Math.min(2, bw/3)}
            fill={isLast ? color : "var(--line-3)"}
            opacity={isLast ? 1 : 0.7}
          />
        );
      })}
    </svg>
  );
};

/* ---------- Heatmap (region map placeholder, value matrix) ---------- */
const Heatmap = ({ rows, cols, values, format = (v) => v, color = "var(--accent)" }) => {
  const max = Math.max(...values.flat());
  return (
    <div className="scroll-x">
      <table style={{ borderCollapse: "separate", borderSpacing: 4, fontFamily: "var(--mono)", fontSize: 11 }}>
        <thead>
          <tr>
            <th></th>
            {cols.map((c, i) => (
              <th key={i} style={{ color: "var(--fg-3)", fontWeight: 400, padding: "4px 0", textAlign: "center" }}>{c}</th>
            ))}
          </tr>
        </thead>
        <tbody>
          {rows.map((r, i) => (
            <tr key={i}>
              <td style={{ color: "var(--fg-3)", paddingRight: 8 }}>{r}</td>
              {cols.map((_, j) => {
                const v = values[i][j];
                const op = (v / max) * 0.95 + 0.05;
                return (
                  <td key={j}>
                    <div style={{
                      width: 44, height: 28, borderRadius: 4,
                      background: color,
                      opacity: op,
                      display: "grid", placeItems: "center",
                      color: op > 0.55 ? "white" : "var(--fg-2)",
                      fontSize: 10,
                    }}>{format(v)}</div>
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

/* ---------- Gauge (semicircle for "health" of company) ---------- */
const Gauge = ({ value, max = 100, label, size = 180, status }) => {
  const r = 70;
  const cx = size / 2;
  const cy = size * 0.66;
  const start = Math.PI;
  const end = 0;
  const pct = Math.max(0, Math.min(1, value / max));
  const angle = start + (end - start) * pct;
  const x1 = cx + r * Math.cos(start);
  const y1 = cy + r * Math.sin(start);
  const x2 = cx + r * Math.cos(end);
  const y2 = cy + r * Math.sin(end);
  const xv = cx + r * Math.cos(angle);
  const yv = cy + r * Math.sin(angle);

  // Use a darker arc background then accent up to value
  const color = status === "neg" ? "var(--neg)" : status === "warn" ? "var(--warn)" : "var(--pos)";

  // For arc we need to draw two paths: total + active
  const dTotal = `M ${x1} ${y1} A ${r} ${r} 0 0 1 ${x2} ${y2}`;
  const dActive = `M ${x1} ${y1} A ${r} ${r} 0 0 1 ${xv} ${yv}`;

  return (
    <div style={{ width: size, position: "relative" }}>
      <svg width={size} height={size * 0.66 + 10} style={{ display: "block" }}>
        <path d={dTotal} stroke="var(--bg-1)" strokeWidth="14" fill="none" strokeLinecap="round"/>
        <path d={dActive} stroke={color} strokeWidth="14" fill="none" strokeLinecap="round"/>
        <circle cx={xv} cy={yv} r="6" fill="var(--bg)" stroke={color} strokeWidth="2.5"/>
      </svg>
      <div style={{ textAlign: "center", marginTop: -28 }}>
        <div className="mono" style={{ fontSize: 32, color: "var(--fg)", letterSpacing: "-0.02em" }}>{value}<span style={{ color: "var(--fg-3)", fontSize: 14 }}>/{max}</span></div>
        <div className="mono" style={{ fontSize: 10, color: "var(--fg-3)", textTransform: "uppercase", letterSpacing: "0.14em", marginTop: 4 }}>{label}</div>
      </div>
    </div>
  );
};

Object.assign(window, {
  Sparkline, LineChart, BarList, Donut, MiniBars, Heatmap, Gauge,
});
