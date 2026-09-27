-- Esquema nuevo. Ejecutar sobre una base MySQL 8 vacía dedicada a la aplicación web.
-- Los archivos físicos viven fuera de MySQL; archivo_multimedia sólo guarda metadatos.

CREATE TABLE IF NOT EXISTS rol (
  id_rol INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre_rol VARCHAR(50) NOT NULL UNIQUE,
  descripcion VARCHAR(255) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS usuario (
  id_usuario INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  codigo VARCHAR(50) NOT NULL UNIQUE,
  nombres VARCHAR(100) NOT NULL,
  apellidos VARCHAR(100) NOT NULL,
  correo VARCHAR(190) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  telefono VARCHAR(20) NULL,
  programa VARCHAR(100) NULL,
  activo BOOLEAN NOT NULL DEFAULT TRUE,
  creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  id_rol INT UNSIGNED NOT NULL,
  CONSTRAINT fk_usuario_rol FOREIGN KEY (id_rol) REFERENCES rol(id_rol),
  INDEX idx_usuario_rol (id_rol)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS categoria_equipo (
  id_categoria INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre_categoria VARCHAR(100) NOT NULL UNIQUE,
  descripcion VARCHAR(255) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS estado_equipo (
  id_estado_equipo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre_estado VARCHAR(50) NOT NULL UNIQUE,
  descripcion VARCHAR(255) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS equipo (
  id_equipo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  codigo_interno VARCHAR(50) NOT NULL UNIQUE,
  nombre VARCHAR(100) NOT NULL,
  marca VARCHAR(100) NULL,
  modelo VARCHAR(100) NULL,
  descripcion TEXT NULL,
  fecha_compra DATE NULL,
  activo BOOLEAN NOT NULL DEFAULT TRUE,
  id_categoria INT UNSIGNED NOT NULL,
  id_estado_equipo INT UNSIGNED NOT NULL,
  CONSTRAINT fk_equipo_categoria FOREIGN KEY (id_categoria) REFERENCES categoria_equipo(id_categoria),
  CONSTRAINT fk_equipo_estado FOREIGN KEY (id_estado_equipo) REFERENCES estado_equipo(id_estado_equipo),
  INDEX idx_equipo_categoria (id_categoria),
  INDEX idx_equipo_disponibilidad (id_estado_equipo, activo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS estado_solicitud (
  id_estado_solicitud INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre_estado VARCHAR(50) NOT NULL UNIQUE,
  descripcion VARCHAR(255) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS solicitud_prestamo (
  id_solicitud INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  fecha_solicitud TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  observacion TEXT NULL,
  id_usuario INT UNSIGNED NOT NULL,
  id_estado_solicitud INT UNSIGNED NOT NULL,
  CONSTRAINT fk_solicitud_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
  CONSTRAINT fk_solicitud_estado FOREIGN KEY (id_estado_solicitud) REFERENCES estado_solicitud(id_estado_solicitud),
  CONSTRAINT chk_solicitud_fechas CHECK (fecha_fin >= fecha_inicio),
  INDEX idx_solicitud_usuario_fecha (id_usuario, fecha_solicitud),
  INDEX idx_solicitud_estado (id_estado_solicitud)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS detalle_solicitud (
  id_detalle INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  id_solicitud INT UNSIGNED NOT NULL,
  id_equipo INT UNSIGNED NOT NULL,
  observacion_detalle TEXT NULL,
  CONSTRAINT fk_detalle_solicitud FOREIGN KEY (id_solicitud) REFERENCES solicitud_prestamo(id_solicitud),
  CONSTRAINT fk_detalle_equipo FOREIGN KEY (id_equipo) REFERENCES equipo(id_equipo),
  CONSTRAINT uq_detalle_equipo UNIQUE (id_solicitud, id_equipo),
  INDEX idx_detalle_equipo (id_equipo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS archivo_multimedia (
  id_archivo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre_original VARCHAR(255) NOT NULL,
  nombre_almacenado VARCHAR(255) NOT NULL,
  tipo_mime VARCHAR(150) NOT NULL,
  tamano_bytes BIGINT UNSIGNED NOT NULL,
  ruta_archivo VARCHAR(1024) NOT NULL,
  descripcion TEXT NULL,
  principal BOOLEAN NOT NULL DEFAULT FALSE,
  fecha_subida TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  id_equipo INT UNSIGNED NOT NULL,
  id_usuario_carga INT UNSIGNED NOT NULL,
  CONSTRAINT fk_archivo_equipo FOREIGN KEY (id_equipo) REFERENCES equipo(id_equipo),
  CONSTRAINT fk_archivo_autor FOREIGN KEY (id_usuario_carga) REFERENCES usuario(id_usuario),
  INDEX idx_archivo_equipo (id_equipo),
  INDEX idx_archivo_autor (id_usuario_carga)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
