import fs from "node:fs/promises";
import net from "node:net";
import { spawn } from "node:child_process";
import { setTimeout as delay } from "node:timers/promises";

// Esta configuración es opcional y local a cada computador; no contiene claves.
const configUrl = new URL("../.local/mysql.json", import.meta.url);

async function isListening(host, port) {
  return new Promise((resolve) => {
    const socket = net.createConnection({ host, port });
    const finish = (value) => { socket.destroy(); resolve(value); };
    socket.setTimeout(1000);
    socket.once("connect", () => finish(true));
    socket.once("error", () => finish(false));
    socket.once("timeout", () => finish(false));
  });
}

async function start() {
  let config;
  try {
    config = JSON.parse(await fs.readFile(configUrl, "utf8"));
  } catch (error) {
    if (error.code === "ENOENT") return; // Otros equipos usan su instalación MySQL.
    throw error;
  }
  const { executable, defaultsFile, host, port } = config;
  if (host !== "127.0.0.1" || !Number.isInteger(port) || port < 1 || port > 65535) {
    throw new Error("La configuración de MySQL local no es válida.");
  }
  if (await isListening(host, port)) {
    console.log(`MySQL local disponible en ${host}:${port}.`);
    return;
  }
  await fs.access(executable);
  await fs.access(defaultsFile);
  const child = spawn(executable, [`--defaults-file=${defaultsFile}`], {
    detached: true, windowsHide: true, stdio: "ignore",
  });
  let startError;
  child.on("error", (error) => { startError = error; });
  child.unref();
  for (let attempt = 0; attempt < 40; attempt++) {
    if (startError) throw startError;
    if (child.exitCode !== null) throw new Error("MySQL terminó antes de iniciar; revisa su registro de errores.");
    if (await isListening(host, port)) {
      console.log(`MySQL local iniciado en ${host}:${port}.`);
      return;
    }
    await delay(500);
  }
  throw new Error("MySQL no respondió; revisa el registro indicado en my.ini.");
}

start().catch((error) => {
  console.error(`No se pudo iniciar MySQL local: ${error.message}`);
  process.exitCode = 1;
});
