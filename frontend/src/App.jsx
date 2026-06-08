import React, { useState, useEffect } from "react";
import Inicio from "./screens/Inicio";
import Administrativo from "./screens/Administrativo";
import Financeiro from "./screens/Financeiro";
import Estoque from "./screens/Estoque";

class ErrorBoundary extends React.Component {
  constructor(props) { super(props); this.state = { error: null }; }
  static getDerivedStateFromError(e) { return { error: e }; }
  componentDidCatch(e, info) { console.error("[ErrorBoundary]", e, info); }
  render() {
    if (this.state.error) {
      return (
        <div style={{
          padding: 32, display: "flex", flexDirection: "column", gap: 12,
          color: "#eef2ff", fontFamily: "monospace",
        }}>
          <div style={{ color: "#ff5470", fontWeight: 700, fontSize: 16 }}>
            Erro ao renderizar a tela
          </div>
          <pre style={{
            background: "rgba(0,0,0,0.5)", border: "1px solid rgba(255,84,112,0.3)",
            borderRadius: 8, padding: 16, fontSize: 12, lineHeight: 1.6,
            whiteSpace: "pre-wrap", color: "#c7d4f4", maxWidth: 700,
          }}>
            {String(this.state.error)}
            {"\n\nAbra F12 → Console para o stack trace completo."}
          </pre>
          <button
            onClick={() => this.setState({ error: null })}
            style={{
              alignSelf: "flex-start", padding: "8px 16px", cursor: "pointer",
              background: "#142068", border: "1px solid rgba(255,255,255,0.15)",
              borderRadius: 6, color: "#eef2ff", fontSize: 13,
            }}
          >
            Tentar novamente
          </button>
        </div>
      );
    }
    return this.props.children;
  }
}

const NAV_ITEMS = [
  { id: "inicio",         label: "Início" },
  { id: "administrativo", label: "Administrativo" },
  { id: "financeiro",     label: "Financeiro" },
  { id: "estoque",        label: "Estoque" },
];

export default function App() {
  const [screen, setScreen] = useState("inicio");

  useEffect(() => {
    const fromHash = window.location.hash.replace("#", "").split("/")[0];
    if (NAV_ITEMS.some((n) => n.id === fromHash)) setScreen(fromHash);
  }, []);

  useEffect(() => {
    window.location.hash = screen;
  }, [screen]);

  useEffect(() => {
    const onMove = (e) => {
      document.documentElement.style.setProperty("--mx", `${e.clientX}px`);
      document.documentElement.style.setProperty("--my", `${e.clientY}px`);
    };
    window.addEventListener("mousemove", onMove);
    return () => window.removeEventListener("mousemove", onMove);
  }, []);

  return (
    <div className="shell">
      <div className="topbar">
        <div className="topbar-brand">
          <svg width="28" height="28" viewBox="0 0 28 28" fill="none" xmlns="http://www.w3.org/2000/svg">
            <defs>
              <linearGradient id="cb-grad" x1="26" y1="2" x2="4" y2="26" gradientUnits="userSpaceOnUse">
                <stop offset="0%" stopColor="#22d47a"/>
                <stop offset="100%" stopColor="#5b8eff"/>
              </linearGradient>
              <filter id="cb-glow" x="-40%" y="-40%" width="180%" height="180%">
                <feGaussianBlur in="SourceGraphic" stdDeviation="1.4" result="blur"/>
                <feMerge>
                  <feMergeNode in="blur"/>
                  <feMergeNode in="SourceGraphic"/>
                </feMerge>
              </filter>
            </defs>
            {/* dim track ring */}
            <path d="M 22.7 9 A 10 10 0 1 0 22.7 19"
              stroke="rgba(91,142,255,0.18)" strokeWidth="4.5" strokeLinecap="butt" fill="none"/>
            {/* main gradient arc */}
            <path d="M 22.7 9 A 10 10 0 1 0 22.7 19"
              stroke="url(#cb-grad)" strokeWidth="3" strokeLinecap="round" fill="none"
              filter="url(#cb-glow)"/>
            {/* glowing tip dots */}
            <circle cx="22.7" cy="9"  r="2.2" fill="#22d47a" filter="url(#cb-glow)"/>
            <circle cx="22.7" cy="19" r="2.2" fill="#5b8eff" filter="url(#cb-glow)"/>
          </svg>
          <span>onecta Beauty</span>
        </div>
        <nav className="topnav">
          {NAV_ITEMS.map((item) => (
            <a
              key={item.id}
              className={screen === item.id ? "active" : ""}
              onClick={() => setScreen(item.id)}
            >
              {item.label}
            </a>
          ))}
        </nav>
      </div>

      <div className="screen" key={screen}>
        <ErrorBoundary key={screen}>
          {screen === "inicio"         && <Inicio />}
          {screen === "administrativo" && <Administrativo />}
          {screen === "financeiro"     && <Financeiro />}
          {screen === "estoque"        && <Estoque />}
        </ErrorBoundary>
      </div>
    </div>
  );
}
