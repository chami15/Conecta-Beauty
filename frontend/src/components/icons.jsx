const Icon = ({ d, size = 16, stroke = 1.5, children, style, ...rest }) => (
  <svg
    width={size} height={size}
    viewBox="0 0 24 24"
    fill="none"
    stroke="currentColor"
    strokeWidth={stroke}
    strokeLinecap="round"
    strokeLinejoin="round"
    style={style}
    {...rest}
  >
    {d ? <path d={d} /> : children}
  </svg>
);

export const I = {
  home:         (p) => <Icon {...p}><path d="M3 11l9-7 9 7v9a1 1 0 0 1-1 1h-5v-6h-6v6H4a1 1 0 0 1-1-1z" /></Icon>,
  building:     (p) => <Icon {...p}><path d="M4 21V5a1 1 0 0 1 1-1h9a1 1 0 0 1 1 1v16M15 21V9h4a1 1 0 0 1 1 1v11M3 21h18M8 8h3M8 12h3M8 16h3" /></Icon>,
  coins:        (p) => <Icon {...p}><circle cx="8" cy="10" r="5"/><path d="M14 5a5 5 0 1 1 0 10M8 7v6M6 9h4"/></Icon>,
  box:          (p) => <Icon {...p}><path d="M3.5 7.5l8.5-4 8.5 4-8.5 4z"/><path d="M3.5 7.5v9l8.5 4 8.5-4v-9M12 11.5v9"/></Icon>,
  search:       (p) => <Icon {...p}><circle cx="11" cy="11" r="7"/><path d="m20 20-3.5-3.5"/></Icon>,
  plus:         (p) => <Icon {...p}><path d="M12 5v14M5 12h14"/></Icon>,
  pencil:       (p) => <Icon {...p}><path d="M4 20h4l10-10-4-4L4 16zM13.5 6.5l4 4"/></Icon>,
  trash:        (p) => <Icon {...p}><path d="M4 7h16M9 7V4h6v3M6 7l1 13h10l1-13M10 11v6M14 11v6"/></Icon>,
  filter:       (p) => <Icon {...p}><path d="M4 5h16l-6 8v6l-4-2v-4z"/></Icon>,
  download:     (p) => <Icon {...p}><path d="M12 4v12M7 11l5 5 5-5M5 20h14"/></Icon>,
  bell:         (p) => <Icon {...p}><path d="M6 9a6 6 0 1 1 12 0c0 5 2 7 2 7H4s2-2 2-7M10 20a2 2 0 0 0 4 0"/></Icon>,
  more:         (p) => <Icon {...p}><circle cx="5" cy="12" r="1"/><circle cx="12" cy="12" r="1"/><circle cx="19" cy="12" r="1"/></Icon>,
  close:        (p) => <Icon {...p}><path d="M6 6l12 12M18 6 6 18"/></Icon>,
  arrowUp:      (p) => <Icon {...p}><path d="M12 19V5M6 11l6-6 6 6"/></Icon>,
  arrowDown:    (p) => <Icon {...p}><path d="M12 5v14M6 13l6 6 6-6"/></Icon>,
  arrowRight:   (p) => <Icon {...p}><path d="M5 12h14M13 6l6 6-6 6"/></Icon>,
  arrowLeft:    (p) => <Icon {...p}><path d="M19 12H5M11 6l-6 6 6 6"/></Icon>,
  calendar:     (p) => <Icon {...p}><rect x="3" y="5" width="18" height="16" rx="2"/><path d="M3 9h18M8 3v4M16 3v4"/></Icon>,
  chart:        (p) => <Icon {...p}><path d="M4 19V5M4 19h16M8 16v-5M12 16V8M16 16v-7"/></Icon>,
  line:         (p) => <Icon {...p}><path d="M3 17l5-6 4 3 8-9"/></Icon>,
  trending:     (p) => <Icon {...p}><path d="M3 17l6-6 4 4 8-8M14 7h7v7"/></Icon>,
  trendingDown: (p) => <Icon {...p}><path d="M3 7l6 6 4-4 8 8M14 17h7v-7"/></Icon>,
  package:      (p) => <Icon {...p}><path d="M3 7l9-4 9 4-9 4zM3 7v10l9 4M21 7v10l-9 4M7 9.5l10 4.5"/></Icon>,
  truck:        (p) => <Icon {...p}><path d="M3 6h11v10H3zM14 10h4l3 3v3h-7"/><circle cx="7" cy="18" r="1.5"/><circle cx="17" cy="18" r="1.5"/></Icon>,
  user:         (p) => <Icon {...p}><circle cx="12" cy="8" r="4"/><path d="M4 21c1-4 4-6 8-6s7 2 8 6"/></Icon>,
  users:        (p) => <Icon {...p}><circle cx="9" cy="8" r="4"/><path d="M2 21c1-4 3-6 7-6s6 2 7 6M16 4a4 4 0 0 1 0 8M17 14c3 .5 5 2.5 5 7"/></Icon>,
  store:        (p) => <Icon {...p}><path d="M4 9V6a1 1 0 0 1 1-1h14a1 1 0 0 1 1 1v3M4 9h16M4 9l-1 4h18l-1-4M5 13v8h14v-8M9 21v-5h6v5"/></Icon>,
  receipt:      (p) => <Icon {...p}><path d="M5 3h14v18l-3-2-3 2-3-2-3 2-2-1.5zM9 8h6M9 12h6M9 16h4"/></Icon>,
  alert:        (p) => <Icon {...p}><path d="M12 3 2 20h20zM12 10v4M12 17v.5"/></Icon>,
  check:        (p) => <Icon {...p}><path d="M5 12l4 4 10-10"/></Icon>,
  refresh:      (p) => <Icon {...p}><path d="M4 12a8 8 0 0 1 14-5l3 3M20 12a8 8 0 0 1-14 5l-3-3M21 5v5h-5M3 19v-5h5"/></Icon>,
  pin:          (p) => <Icon {...p}><path d="M12 17v5M9 3h6l-1 4 3 3-3 1-1 5h-2l-1-5-3-1 3-3z"/></Icon>,
  star:         (p) => <Icon {...p}><path d="m12 3 2.7 6 6.3.6-4.8 4.4 1.4 6.5L12 17l-5.6 3.5 1.4-6.5L3 9.6l6.3-.6z"/></Icon>,
  map:          (p) => <Icon {...p}><path d="M9 4 3 6v15l6-2 6 2 6-2V4l-6 2zM9 4v15M15 6v15"/></Icon>,
  layers:       (p) => <Icon {...p}><path d="m12 3 9 5-9 5-9-5zM3 13l9 5 9-5M3 18l9 5 9-5"/></Icon>,
  brain:        (p) => <Icon {...p}><path d="M9 3a5 5 0 0 0-5 5 5 5 0 0 0 5 5v8M15 3a5 5 0 0 1 5 5 5 5 0 0 1-5 5v8M9 8h6M9 13h6"/></Icon>,
  scatter:      (p) => <Icon {...p}><circle cx="7" cy="8" r="2"/><circle cx="14" cy="5" r="2"/><circle cx="5" cy="16" r="2"/><circle cx="17" cy="13" r="2"/><circle cx="11" cy="19" r="2"/></Icon>,
  sigma:        (p) => <Icon {...p}><path d="M18 5H6l6 7-6 7h12"/></Icon>,
  cpu:          (p) => <Icon {...p}><rect x="4" y="4" width="16" height="16" rx="2"/><rect x="9" y="9" width="6" height="6"/><path d="M9 1v3M15 1v3M9 20v3M15 20v3M1 9h3M1 15h3M20 9h3M20 15h3"/></Icon>,
};

export default I;
