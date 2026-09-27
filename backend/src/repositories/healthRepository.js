import { pool } from "../config/database.js";

export async function checkDatabase() {
  const [rows] = await pool.query("SELECT 1 AS alive");
  return rows[0]?.alive === 1;
}
