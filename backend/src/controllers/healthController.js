import { checkDatabase } from "../repositories/healthRepository.js";

export async function getHealth(_request, response) {
  try {
    if (!(await checkDatabase())) throw new Error("DB check failed");
    response.status(200).json({ status: "ok", database: "connected" });
  } catch {
    response
      .status(503)
      .json({ status: "unavailable", database: "disconnected" });
  }
}
