import Image from "next/image";
import Button from "../button";
import styles from "./header.module.css";

export default function Header() {
  return (
    <header draggable="false" className={styles.header}>
      <div>
        <Image
          src="/icons/apple-icon-180x180.png"
          alt="logo"
          width={24}
          height={24}
        />
        <h1 className="font-title-large" style={{ marginLeft: 8 }}>
          Heron
        </h1>
        <div style={{ flex: 1 }} />
        <Button>Install App</Button>
      </div>
    </header>
  );
}
