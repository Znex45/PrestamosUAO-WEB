import dotenv from "dotenv";
import fs from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";
import mysql from "mysql2/promise";

const databaseDir = path.dirname(fileURLToPath(import.meta.url));
dotenv.config({ path: path.resolve(databaseDir, "../backend/.env") });
const name = process.env.DB_NAME;
if (!name || !/^[a-zA-Z][a-zA-Z0-9_]*$/.test(name)) {
  throw new Error("DB_NAME debe ser un identificador MySQL válido.");
}
for (const key of ["DB_HOST", "DB_USER", "DB_PASSWORD"]) {
  if (!process.env[key]) throw new Error(`Falta ${key} en backend/.env`);
}

const connection = await mysql.createConnection({
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT || 3306),
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  multipleStatements: true,
});

try {
  await connection.query(
    `CREATE DATABASE IF NOT EXISTS \`${name}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci`,
  );
  await connection.changeUser({ database: name });
  const [existing] = await connection.query("SHOW TABLES LIKE 'usuario'");
  if (existing.length) {
    const [passwordColumn] = await connection.query(
      "SELECT COLUMN_NAME FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = ? AND TABLE_NAME = 'usuario' AND COLUMN_NAME = 'password_hash'",
      [name],
    );
    if (!passwordColumn.length) {
      throw new Error(
        "La base contiene el esquema anterior. Utiliza una base nueva y vacía para la versión web.",
      );
    }
  }
  await connection.query(
    await fs.readFile(path.join(databaseDir, "schema.sql"), "utf8"),
  );
  await connection.query(
    await fs.readFile(path.join(databaseDir, "seed.sql"), "utf8"),
  );
  console.log(`Esquema y catálogos aplicados en ${name}.`);
} finally {
  await connection.end();
}
