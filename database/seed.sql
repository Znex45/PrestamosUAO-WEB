-- Catálogos de prueba. No crea usuarios ni contraseñas.
INSERT INTO rol (nombre_rol, descripcion) VALUES
  ('Estudiante', 'Solicita equipos para actividades académicas'),
  ('Docente', 'Solicita equipos para docencia'),
  ('Administrador', 'Gestiona el inventario y las solicitudes')
ON DUPLICATE KEY UPDATE descripcion = VALUES(descripcion);

INSERT INTO estado_equipo (nombre_estado, descripcion) VALUES
  ('Disponible', 'Equipo apto para solicitud'),
  ('Reservado', 'Asignado a una solicitud aprobada'),
  ('Prestado', 'Equipo entregado temporalmente'),
  ('Mantenimiento', 'Equipo no disponible por revisión')
ON DUPLICATE KEY UPDATE descripcion = VALUES(descripcion);

INSERT INTO estado_solicitud (nombre_estado, descripcion) VALUES
  ('Pendiente', 'Aún no revisada'),
  ('Aprobada', 'Autorizada por un administrador'),
  ('Rechazada', 'No autorizada'),
  ('Cancelada', 'Cancelada antes de finalizar'),
  ('En préstamo', 'Equipos entregados'),
  ('Finalizada', 'Equipos devueltos y solicitud cerrada')
ON DUPLICATE KEY UPDATE descripcion = VALUES(descripcion);

INSERT INTO categoria_equipo (nombre_categoria, descripcion) VALUES
  ('Cámaras', 'Equipos de captura de imagen'),
  ('Micrófonos', 'Equipos de captura de audio'),
  ('Trípodes', 'Soportes para equipos'),
  ('Luces', 'Equipos de iluminación'),
  ('Grabadoras', 'Grabadoras de audio o video'),
  ('Tabletas digitalizadoras', 'Dispositivos de entrada gráfica'),
  ('Kits de audio', 'Conjuntos de accesorios de audio')
ON DUPLICATE KEY UPDATE descripcion = VALUES(descripcion);
