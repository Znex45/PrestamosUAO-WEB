const baseUrl = import.meta.env.VITE_API_URL?.replace(/\/$/, "");

export async function fetchHealth() {
  if (!baseUrl)
    throw new Error("Configura VITE_API_URL para consultar el servidor.");
  const response = await fetch(`${baseUrl}/health`, {
    headers: { Accept: "application/json" },
  });
  if (!response.ok)
    throw new Error("El servidor o la base de datos no están disponibles.");
  return response.json();
}
