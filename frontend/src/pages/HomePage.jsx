import React from "react";
import { Link } from "react-router-dom";
import { useEffect, useState } from "react";
import { fetchHealth } from "../services/api.js";

const benefits = [
  {
    number: "01",
    title: "Todo en un lugar",
    body: "Consulta equipos, solicitudes y material de apoyo desde una plataforma compartida.",
  },
  {
    number: "02",
    title: "Disponibilidad clara",
    body: "Conoce qué recursos puedes solicitar para tus actividades académicas.",
  },
  {
    number: "03",
    title: "Mejor seguimiento",
    body: "Mantén un historial ordenado de préstamos y del estado de cada equipo.",
  },
];

export function HomePage() {
  const [apiStatus, setApiStatus] = useState("Comprobando servicio…");

  useEffect(() => {
    fetchHealth()
      .then(() => setApiStatus("Servicio y base de datos disponibles"))
      .catch(() => setApiStatus("Servicio en preparación"));
  }, []);

  return (
    <>
      <section className="hero container">
        <div className="hero-copy">
          <span className="eyebrow">
            <span className="eyebrow-dot" /> Recursos para crear, enseñar y
            aprender
          </span>
          <h1>
            El equipo que necesitas, <em>cuando lo necesitas.</em>
          </h1>
          <p>
            Un espacio para organizar el préstamo de cámaras, micrófonos y otros
            recursos audiovisuales de la UAO. Menos incertidumbre, más tiempo
            para tus proyectos.
          </p>
          <div className="actions">
            <Link className="button button-primary" to="/registro">
              Crear una cuenta <span aria-hidden="true">↗</span>
            </Link>
            <Link className="button button-outline" to="/login">
              Ya tengo cuenta
            </Link>
          </div>
          <p className="hero-note">
            Para estudiantes, docentes y encargados de los equipos. ·{" "}
            {apiStatus}
          </p>
        </div>
        <div className="hero-art" aria-hidden="true">
          <div className="art-grid" />
          <div className="art-ring art-ring-one" />
          <div className="art-ring art-ring-two" />
          <div className="art-center">
            <div className="art-lens">
              <div />
            </div>
          </div>
          <div className="art-tag art-tag-top">
            EQUIPOS MULTIMEDIA <span>↗</span>
          </div>
          <div className="art-tag art-tag-bottom">
            <span className="status-dot" /> ORGANIZACIÓN MÁS SIMPLE
          </div>
        </div>
      </section>
      <section className="benefits-section">
        <div className="container">
          <div className="section-heading">
            <span className="eyebrow">¿POR QUÉ ESTA PLATAFORMA?</span>
            <h2>Recursos listos para tus ideas.</h2>
            <p>
              La información del inventario y las solicitudes se organiza en un
              mismo lugar para facilitar el trabajo de toda la comunidad.
            </p>
          </div>
          <div className="benefits-grid">
            {benefits.map((benefit) => (
              <article className="benefit" key={benefit.number}>
                <span className="benefit-number">{benefit.number}</span>
                <h3>{benefit.title}</h3>
                <p>{benefit.body}</p>
              </article>
            ))}
          </div>
        </div>
      </section>
      <section className="container final-cta">
        <div>
          <span className="eyebrow">EMPIEZA AQUÍ</span>
          <h2>Tu próximo proyecto comienza con los recursos adecuados.</h2>
        </div>
        <Link className="button button-light" to="/registro">
          Registrarme <span aria-hidden="true">↗</span>
        </Link>
      </section>
    </>
  );
}
