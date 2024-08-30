import { headers } from "next/headers";

export default function getBrightness() {
  const header = headers();
  const brightness = header.get("X-Heron-Brightness");

  return brightness;
}