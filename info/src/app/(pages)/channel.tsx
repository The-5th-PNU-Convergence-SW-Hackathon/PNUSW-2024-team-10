"use client";

import { webviewChannel } from "@/constants/webview";
import { useSearchParams } from "next/navigation";
import {
  Collection,
  CollectionPropertySchema,
  CollectionPropertySchemaMap,
  CollectionView,
} from "notion-types";
import { PropsWithChildren, useEffect } from "react";

interface FlutterChannelProviderProps extends PropsWithChildren {
  collection: Collection;
  collectionView: CollectionView;
}

export default function FlutterChannelProvider({
  children,
  collection,
  collectionView,
}: FlutterChannelProviderProps) {
  const queries = useSearchParams();

  useEffect(() => {
    const properties = Object.entries(collection.schema)
      .filter(
        ([_, value]) => value.type === "select" || value.type === "multi_select"
      )
      .map(([key, value]) => {
        const filtersOfProperty: string[] =
          queries.get(key)?.split(",") ??
          collectionView.format?.property_filters
            ?.filter(
              ({ filter }: any) =>
                filter.property === key &&
                filter.filter.operator === "enum_contains" &&
                filter.filter.value.type === "exact" &&
                "value" in filter.filter.value
            )
            .map(({ filter }: any) => filter.filter.value.value) ??
          [];

        const options = value.options?.map((option) => {
          const selected =
            filtersOfProperty.length > 0
              ? filtersOfProperty.includes(option.value)
              : true;
          return { ...option, selected };
        });

        return [key, { ...value, options }] as [
          string,
          CollectionPropertySchema
        ];
      })
      .reduce((acc, [key, value]) => {
        acc[key] = value;
        return acc;
      }, {} as CollectionPropertySchemaMap);

    window[webviewChannel]?.postMessage(JSON.stringify(properties));
  }, [collection, collectionView]); // eslint-disable-line react-hooks/exhaustive-deps

  return children;
}

declare global {
  interface Window {
    [webviewChannel]?: {
      postMessage: (message: string) => void;
    };
  }
}
