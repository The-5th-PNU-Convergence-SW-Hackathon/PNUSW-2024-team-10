import { Color } from "notion-types";
import styles from "./label.module.css";
import "@/styles/notion.css";

interface TagProps {
  name: string;
  color?: Color;
}

export default function Label({ name, color = "gray" }: TagProps) {
  return (
    <span
      className={["font-body-small", styles.tag].join(" ")}
      style={{
        backgroundColor: `var(--notion-item-${color})`,
      }}
    >
      {name.toUpperCase()}
    </span>
  );
}
