import { app } from "../backend/src/app.js";
import { pool } from "../backend/src/config/database.js";

const server = app.listen(0);
try {
  await new Promise((resolve) => server.once("listening", resolve));
  const response = await fetch(`http://127.0.0.1:${server.address().port}/health`);
  const result = await response.json();
  console.log(`HTTP ${response.status}`, result);
  if (response.status !== 200) process.exitCode = 1;
} finally {
  await new Promise((resolve) => server.close(resolve));
  await pool.end();
}
