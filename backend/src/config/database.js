import mysql from "mysql2/promise";
import { env, requireDatabaseConfig } from "./env.js";

requireDatabaseConfig();

export const pool = mysql.createPool({
  host: env.dbHost,
  port: env.dbPort,
  user: env.dbUser,
  password: env.dbPassword,
  database: env.dbName,
  waitForConnections: true,
  connectionLimit: 5,
  connectTimeout: 5000,
});
