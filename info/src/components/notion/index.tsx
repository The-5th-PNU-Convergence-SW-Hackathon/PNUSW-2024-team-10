import { NotionAPI } from "notion-client";
import { NotionRenderer } from "./renderer";
import styles from "./notion.module.css";
import { isValidApp } from "@/utilities/isValidApp";
import Header from "../header";

interface SimpleNotionPageGeneratorProps {
  title: string;
  id: string;
}

export default async function SimpleNotionPageGenerator({
  title,
  id,
}: SimpleNotionPageGeneratorProps) {
  const notion = new NotionAPI();
  const recordMap = await notion.getPage(id);

  const isApp = isValidApp();

  return (
    <>
      {!isApp && (
        <>
          <Header />
          <div style={{ height: 84 }} />
        </>
      )}
      <article className={styles.article}>
        {!isApp && <h1 className="notion-page font-headline-large">{title}</h1>}
        <div style={{ height: 8 }} />
        <NotionRenderer recordMap={recordMap} fullPage={false} />
      </article>
    </>
  );
}
