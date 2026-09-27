import express from "express";
import cors from "cors";
import { env } from "./config/env.js";
import { healthRoutes } from "./routes/healthRoutes.js";

export const app = express();

if (env.frontendOrigin) {
  app.use(cors({ origin: env.frontendOrigin }));
}
app.use(express.json());
app.use("/health", healthRoutes);

app.use((_request, response) => {
  response.status(404).json({ error: "Ruta no encontrada" });
});

app.use((error, _request, response, _next) => {
  console.error("Error en la API:", error.message);
  response.status(500).json({ error: "Error interno del servidor" });
});
