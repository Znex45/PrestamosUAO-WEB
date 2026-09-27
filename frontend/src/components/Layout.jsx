import React from "react";
import { NavLink, Outlet } from "react-router-dom";

export function Layout() {
  return (
    <div className="site-shell">
      <header className="site-header">
        <NavLink className="brand" to="/" aria-label="Préstamos UAO, inicio">
          <span className="brand-mark">U</span>
          <span>
            Préstamos <strong>UAO</strong>
          </span>
        </NavLink>
        <nav aria-label="Navegación principal">
          <NavLink to="/">Inicio</NavLink>
          <NavLink to="/login">Ingresar</NavLink>
          <NavLink className="nav-cta" to="/registro">
            Crear cuenta
          </NavLink>
        </nav>
      </header>
      <main>
        <Outlet />
      </main>
      <footer className="site-footer">
        <span>Proyecto académico · Gestión de equipos multimedia</span>
        <span>Universidad Autónoma de Occidente</span>
      </footer>
    </div>
  );
}
