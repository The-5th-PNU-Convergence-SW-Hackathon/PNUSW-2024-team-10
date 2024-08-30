"use client";

import { createContext, useContext } from "react";

type Locale = "ko" | "en";

const LocaleContext = createContext<Locale>("en");

export function LocaleProvider({
  children,
  locale,
}: {
  children: React.ReactNode;
  locale: Locale;
}) {
  return (
    <LocaleContext.Provider value={locale}>{children}</LocaleContext.Provider>
  );
}

export function useLocale() {
  return useContext(LocaleContext);
}
