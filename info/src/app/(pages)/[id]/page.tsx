import { NotionAPI } from "notion-client";
import styles from "./page.module.css";
import NotionView from "./notion";
import { Color, PageBlock } from "notion-types";
import Label from "@/components/label";
import Time from "@/components/time";
import { isValidApp } from "@/utilities/isValidApp";
import Header from "@/components/header";

import type { Metadata, ResolvingMetadata } from "next";
import { notFound } from "next/navigation";

interface PageProps {
  params: PageParams;
}

interface PageParams {
  id: string;
}

interface TagType {
  name: string;
  color?: Color;
}

interface HeronPageBlock extends PageBlock {
  properties?: {
    title: [[string]];
    [key: string]: [[string]];
  };
}

async function getPage(id: string) {
  const collection_id = process.env.COLLECTION_ID;
  if (!collection_id) {
    throw new Error("No collection ID provided");
  }

  const notion = new NotionAPI();
  const recordMap = await notion.getPage(id);

  const collections = Object.values(recordMap.collection);
  if (collections.length < 1) {
    throw new Error("No collection found");
  }

  const parentId = collections[0].value.parent_id.replace(/-/g, "");
  if (parentId !== collection_id) {
    throw new Error("Collection ID does not match");
  }

  const page: HeronPageBlock | undefined = Object.values(recordMap.block).find(
    (o) => o.value.type === "page"
  )?.value as HeronPageBlock;

  const title = page.properties?.title[0][0];
  const createdTime = new Date(page.created_time);

  const properties = { ...page.properties };
  delete properties.title;

  const tags: TagType[] = [];
  const schema = collections[0].value?.schema;

  Object.entries(schema).forEach(([key, value]) => {
    if (value.type === "multi_select" || value.type === "select") {
      if (key in properties) {
        const name = properties[key][0][0];
        const color = value.options?.find((o) => o.value === name)?.color;

        tags.push({ name, color: color });
      }
    }
  });

  return { title, createdTime, tags, recordMap };
}

export async function generateMetadata(
  { params }: PageProps,
  parent: ResolvingMetadata
): Promise<Metadata> {
  const { title } = await getPage(params.id);

  return {
    title,
    description: "article from Heron",
  };
}

export default async function DetailPage({ params }: PageProps) {
  // const t = useTranslations("ArticlePage");

  const isApp = isValidApp();

  const { title, createdTime, tags, recordMap } = await getPage(params.id);

  return (
    <>
      {!isApp && (
        <>
          <Header />
          <div style={{ height: 84 }} />
        </>
      )}
      <article className={styles.main}>
        <header className={styles.header}>
          <div className={styles.title_line}>
            <h1 className={[styles.title, "font-headline-small"].join(" ")}>
              {title}
            </h1>
            {tags.map((tag, i) => (
              <div className={styles.tag} key={i}>
                <Label name={tag.name} color={tag.color} />
              </div>
            ))}
          </div>
          <Time date={createdTime} />
        </header>
        <NotionView recordMap={recordMap} />
      </article>
    </>
  );
}
