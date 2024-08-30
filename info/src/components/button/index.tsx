import styles from "./button.module.css";

export default function Button({
  className,
  ...props
}: React.ButtonHTMLAttributes<HTMLButtonElement>) {
  return (
    <button
      className={["font-body-medium", styles.button, className].join(" ")}
      {...props}
    />
  );
}
