import React from "react";
import { Link } from "react-router-dom";

export function RegisterPage() {
  function handleSubmit(event) {
    event.preventDefault();
    const form = event.currentTarget;
    const password = form.elements.password;
    const confirmation = form.elements.confirmPassword;
    confirmation.setCustomValidity(
      password.value === confirmation.value
        ? ""
        : "Las contraseñas no coinciden.",
    );
    form.reportValidity();
  }

  return (
    <section className="auth-page container">
      <div className="auth-aside">
        <span className="eyebrow">ÚNETE A LA PLATAFORMA</span>
        <h1>Un espacio para tus proyectos.</h1>
        <p>
          Crea tu perfil para preparar futuras solicitudes de equipos
          audiovisuales.
        </p>
        <div className="aside-line" />
        <span>Estudiantes y docentes de la UAO</span>
      </div>
      <div className="auth-card">
        <span className="eyebrow">CREAR CUENTA</span>
        <h2>Regístrate</h2>
        <p className="form-intro">Completa tus datos para comenzar.</p>
        <form onSubmit={handleSubmit}>
          <div className="form-grid">
            <div>
              <label htmlFor="register-first-name">Nombres</label>
              <input
                id="register-first-name"
                name="firstName"
                autoComplete="given-name"
                placeholder="Tus nombres"
                required
              />
            </div>
            <div>
              <label htmlFor="register-last-name">Apellidos</label>
              <input
                id="register-last-name"
                name="lastName"
                autoComplete="family-name"
                placeholder="Tus apellidos"
                required
              />
            </div>
          </div>
          <label htmlFor="register-code">Código institucional</label>
          <input
            id="register-code"
            name="code"
            placeholder="Tu código"
            required
          />
          <label htmlFor="register-email">Correo electrónico</label>
          <input
            id="register-email"
            name="email"
            type="email"
            autoComplete="email"
            placeholder="nombre@uao.edu.co"
            required
          />
          <div className="form-grid">
            <div>
              <label htmlFor="register-password">Contraseña</label>
              <input
                id="register-password"
                name="password"
                type="password"
                autoComplete="new-password"
                minLength="8"
                placeholder="Mínimo 8 caracteres"
                required
                onInput={(event) =>
                  event.currentTarget.form.elements.confirmPassword.setCustomValidity(
                    "",
                  )
                }
              />
            </div>
            <div>
              <label htmlFor="register-confirm">Confirmar contraseña</label>
              <input
                id="register-confirm"
                name="confirmPassword"
                type="password"
                autoComplete="new-password"
                minLength="8"
                placeholder="Repítela"
                required
                onInput={(event) => event.currentTarget.setCustomValidity("")}
              />
            </div>
          </div>
          <button className="button button-primary form-submit" type="submit">
            Crear cuenta <span aria-hidden="true">↗</span>
          </button>
          <p className="form-note" role="status">
            El registro de usuarios se habilitará en el Avance 2.
          </p>
        </form>
        <p className="form-switch">
          ¿Ya tienes cuenta? <Link to="/login">Inicia sesión</Link>
        </p>
      </div>
    </section>
  );
}
