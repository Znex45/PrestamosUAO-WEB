# Referencia del sistema anterior y decisiones de migración

El repositorio partía de una aplicación Windows Forms en .NET 8 que utilizaba `MySql.Data`. Las pantallas administraban usuarios, equipos, solicitudes y archivos mediante SQL explícito. La conexión y tres accesos administrativos estaban definidos directamente en el código. Esas credenciales de prueba no forman parte de la aplicación web.

Se revisaron además los dos volcados SQL proporcionados, `prestamo_equipos.sql` y `prestamo_equipos_2.sql`. Ambos describen ocho tablas MySQL y **no contienen filas de datos**. Presentan diferencias de nombres de columnas, y el segundo contiene campos de inventario y usuario más cercanos a los formularios C#. La aplicación de escritorio apuntaba a una base llamada `EquiposUAO`; los volcados citan `prestamos_equipos` y `equipos`. Por esa discrepancia, no se ejecutó una conversión automática sobre ninguna base anterior.

## Equivalencias principales

| Concepto anterior | Modelo web |
| --- | --- |
| `usuario` sin contraseña | `usuario` con `codigo` y `correo` únicos y `password_hash` obligatorio |
| Login con administradores fijos | Futuro registro e inicio de sesión contra MySQL; no se migran contraseñas en texto plano |
| `solicitud_prestamo.estado_solicitud` como texto | Catálogo `estado_solicitud` referenciado por `id_estado_solicitud` |
| `detalle_solicitud` | Relación entre solicitud y equipo con unicidad del par |
| `archivo_multimedia` con ruta y tipo | Metadatos completos, autor, tamaño, fecha y ruta; archivo físico fuera de MySQL |
| Código de inventario opcional | `equipo.codigo_interno` obligatorio y único |

La validación de disponibilidad y el cambio de estado, presentes conceptualmente en `FormSolicitudes.cs`, se implementarán en transacciones del backend durante el Avance 2. La obligación de incluir al menos un equipo por solicitud también se validará en ese flujo; el esquema por sí solo no puede garantizarla al crear primero la cabecera de una transacción.

El nuevo esquema se aplica a la base dedicada `prestamos_uao_web` mediante `npm run db:init`. La base antigua queda intacta. Si contiene datos de valor, la migración posterior deberá realizarse con un respaldo y mapeo explícito de roles, estados, usuarios, equipos, solicitudes y archivos. A cada usuario migrado se le deberá establecer una contraseña nueva mediante el flujo seguro de registro o recuperación que se implemente en el Avance 2.

Los archivos C# y recursos de Windows Forms fueron retirados del árbol activo una vez validada la versión web. Se pueden recuperar del historial Git anterior si se necesita consultar una implementación antigua; este trabajo no reescribió ese historial.
