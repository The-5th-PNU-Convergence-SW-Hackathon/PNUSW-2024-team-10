import { getRequestConfig } from "next-intl/server";
import { headers } from "next/headers";

const supportedLocales = ["en", "ko"];

export default getRequestConfig(async () => {
  const header = headers();

  const userLocales = header
    .get("Accept-Language")
    ?.split(",")
    .map((l) => l.split(";")[0])
    .map((l) => l.split("-")[0]);
    
  const locale = userLocales?.find((l) => supportedLocales.includes(l)) || "en";

  return {
    locale,
    messages: (await import(`../messages/${locale}.json`)).default,
  };
});
