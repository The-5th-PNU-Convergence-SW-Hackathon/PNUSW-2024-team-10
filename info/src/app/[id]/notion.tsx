"use client";

import { NotionRenderer } from "react-notion-x";
import { ExtendedRecordMap } from "notion-types";
import Image from "next/image";
import Link from "next/link";
import "@/styles/notion.css";
import dynamic from "next/dynamic";

const Collection = dynamic(() =>
  import('react-notion-x/build/third-party/collection').then(
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
      recordMap={recordMap}
      fullPage={false}
      darkMode={false}
      components={{
        Collection,
        nextImage: Image,
        nextLink: Link,
      }}
    />
  );
}