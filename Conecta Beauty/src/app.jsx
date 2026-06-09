/* App root — top bar with brand + text nav + date, screen router */

const NAV_ITEMS = [
  { id: "inicio",         label: "Início" },
  { id: "administrativo", label: "Administrativo" },
  { id: "financeiro",     label: "Financeiro" },
  { id: "estoque",        label: "Estoque" },
];

const App = () => {
  const [screen, setScreen] = useState("inicio");

  useEffect(() => {
    const fromHash = window.location.hash.replace("#", "").split("/")[0];
    if (NAV_ITEMS.some(n => n.id === fromHash)) setScreen(fromHash);
  }, []);
  useEffect(() => {
    window.location.hash = screen;
  }, [screen]);

  return (
    <div className="shell">
      {/* TOPBAR */}
      <div className="topbar">
        <div className="brand">
          <div className="brand-mark">C</div>
          <div className="brand-name">
            Conecta Beauty <span className="muted">ERP</span>
          </div>
        </div>

        <nav className="topnav">
          {NAV_ITEMS.map(item => (
            <a
              key={item.id}
              className={screen === item.id ? "active" : ""}
              onClick={() => setScreen(item.id)}
            >
              {item.label}
            </a>
          ))}
        </nav>

        <div className="topbar-spacer"/>

        <div className="topbar-actions">
          <div className="date-chip">
            <I.calendar size={13}/>
            <span>23 Mai 2026</span>
          </div>
        </div>
      </div>

      {/* SCREEN BODY */}
      <div className="screen" key={screen}>
        {screen === "inicio"         && <ScreenInicio/>}
        {screen === "administrativo" && <ScreenAdministrativo/>}
        {screen === "financeiro"     && <ScreenFinanceiro/>}
        {screen === "estoque"        && <ScreenEstoque/>}
      </div>
    </div>
  );
};

ReactDOM.createRoot(document.getElementById("root")).render(<App/>);
