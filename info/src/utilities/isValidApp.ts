import { headers } from "next/headers";

export function isValidApp() {
  const header = headers();
  const userAgent = header.get("User-Agent");

  const appIdentifier = process.env.APP_BUNDLE_ID;

  return appIdentifier && userAgent?.includes(appIdentifier);
}