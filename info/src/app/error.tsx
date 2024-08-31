"use client";

import { useRouter } from "next/navigation";
import "./error.css";
import Button from "@/components/button";

export default function ErrorPage() {
  const router = useRouter();

  return (
    <div className="error">
      <h1 className="font-title-large">Invalid Access</h1>
      <p>The page you are looking for does not exist or is no longer accessible. Please check the URL or return to the homepage.</p>
      <Button onClick={() => router.back()}>Return to the previous page</Button>
    </div>
  );
}