import NotionView from "./notion";
import { isValidApp } from "@/utilities/isValidApp";
import FlutterChannelProvider from "./channel";
import { CustomNotionAPI } from "@/constants/notion";

interface HomeProps {
  searchParams: {
    [key: string]: string;
  };
}

export default async function Home({ searchParams }: HomeProps) {
  const collection_id = process.env.COLLECTION_ID;
  if (!collection_id) {
    throw new Error("No collection ID provided");
  }

  if (!isValidApp()) {
    return null;
  }

  const notion = new CustomNotionAPI();
  const infoPage = await notion.getPageWithCollection(collection_id, {
    customFilters: Object.entries(searchParams).map(([key, value]) => ({
      property: key,
      filter: {
        operator: "enum_contains",
        value: value.split(",").map((name) => ({
          type: "exact",
          value: name,
        })),
      },
    })),
  });

  if (Object.keys(infoPage.collection).length === 0) {
    return null;
  }

  const collection = Object.values(infoPage.collection)[0].value;
  const collectionView = Object.values(infoPage.collection_view)[0].value;

  return (
    <FlutterChannelProvider
      collection={collection}
      collectionView={collectionView}
    >
      <NotionView recordMap={infoPage} />
    </FlutterChannelProvider>
  );
}
