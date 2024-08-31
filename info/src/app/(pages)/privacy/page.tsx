import SimpleNotionPageGenerator from "@/components/notion";

export default function PolicyPage() {
  const id = process.env.PRIVACY_ID;
  if (!id) {
    throw new Error("No privacy ID provided");
  }

  return <SimpleNotionPageGenerator title="개인정보 처리방침" id={id} />;
}
