import SimpleNotionPageGenerator from "@/components/notion";

export default function TermsPage() {
  const id = process.env.TERMS_ID;
  if (!id) {
    throw new Error("No terms ID provided");
  }

  return <SimpleNotionPageGenerator title="이용약관" id={id} />;
}
