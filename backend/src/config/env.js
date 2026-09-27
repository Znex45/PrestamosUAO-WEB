import dotenv from "dotenv";

dotenv.config({ path: new URL("../../.env", import.meta.url) });

export const env = {
  port: Number(process.env.PORT || 3001),
  dbHost: process.env.DB_HOST,
  dbPort: Number(process.env.DB_PORT || 3306),
  dbUser: process.env.DB_USER,
  dbPassword: process.env.DB_PASSWORD,
  dbName: process.env.DB_NAME,
  frontendOrigin: process.env.FRONTEND_ORIGIN,
};

export function requireDatabaseConfig() {
  const missing = [
    ["DB_HOST", env.dbHost],
    ["DB_USER", env.dbUser],
    ["DB_PASSWORD", env.dbPassword],
    ["DB_NAME", env.dbName],
  ]
    .filter(([, value]) => !value)
    .map(([name]) => name);

  if (missing.length) {
    throw new Error(`Faltan variables de base de datos: ${missing.join(", ")}`);
  }
}
