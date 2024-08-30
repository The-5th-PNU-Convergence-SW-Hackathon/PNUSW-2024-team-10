"use client";

import getDateTime from "@/utilities/getDateTime";
import { useLocale } from "../locale/locale";
import styles from "./time.module.css";

export default function Time({ date }: { date: Date }) {
  const locale = useLocale();

  return (
    <time
      dateTime={date.toISOString()}
      className={[styles.time, "font-body-medium"].join(" ")}
    >
      {getDateTime[locale](date)}
    </time>
  );
}
