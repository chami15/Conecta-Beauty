import { useState } from "react";
import { SegmentedNav } from "../components/ui";
import ScreenML from "./ScreenML";
import ScreenKmeans from "./ScreenKmeans";

const ABAS = [
  { id: "previsao",     label: "Previsão de faturamento" },
  { id: "segmentacao",  label: "Segmentação de pedidos" },
];

export default function MachineLearning() {
  const [aba, setAba] = useState("previsao");
  return (
    <div>
      <div style={{ padding: "16px 24px 0" }}>
        <SegmentedNav items={ABAS} value={aba} onChange={setAba} />
      </div>
      {aba === "previsao" ? <ScreenML /> : <ScreenKmeans />}
    </div>
  );
}
