"use client";

import { NotionRenderer } from "react-notion-x";
import { ExtendedRecordMap } from "notion-types";
import Image from "next/image";
import Link from "next/link";
import "@/styles/notion.css";
import dynamic from "next/dynamic";
import Label from "@/components/label";
import styles from "./page.module.css";
import Time from "@/components/time";

const Collection = dynamic(
  () =>
    import("react-notion-x/build/third-party/collection").then(
      (m) => m.Collection
    ),
  { ssr: false }
);

export default function NotionView({
  recordMap,
}: {
  recordMap: ExtendedRecordMap;
}) {

  return (
    <NotionRenderer
      className={styles.main}
      recordMap={recordMap}
      fullPage={false}
      darkMode={false}
      pageTitle={false}
      components={{
        Collection,
        nextImage: Image,
        PageLink: (props: any) => <a draggable="false" {...props} />,
        Link: Link,
        nextLink: Link,
        propertyTitleValue: (value) => {
          if (
            !value.data ||
            value.data.length === 0 ||
            value.data[0].length === 0
          ) {
            return null;
          }

          const title = value.data[0][0] ?? ("" as string);
          return (
            <h2 className="notion-list-item-title-value font-title-medium">
              {title}
            </h2>
          );
        },
        propertySelectValue: ({ value, color }) => {
          return <Label key={value} name={value} color={color} />;
        },
        propertyCreatedTimeValue: (value) => {
          const time = value.block.created_time as number;
          const date = new Date(time);

          return <Time date={date} />;
        },
      }}
    />
  );
}
