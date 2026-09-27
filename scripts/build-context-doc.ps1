$ErrorActionPreference = 'Stop'
$output = Join-Path $PSScriptRoot '..\docs\Documento de contexto BD.docx'
$word = New-Object -ComObject Word.Application
$word.Visible = $false
$word.DisplayAlerts = 0

try {
    $doc = $word.Documents.Add()
    $doc.PageSetup.PageWidth = $word.InchesToPoints(8.5)
    $doc.PageSetup.PageHeight = $word.InchesToPoints(11)
    $doc.PageSetup.TopMargin = $word.InchesToPoints(0.8)
    $doc.PageSetup.BottomMargin = $word.InchesToPoints(0.8)
    $doc.PageSetup.LeftMargin = $word.InchesToPoints(0.85)
    $doc.PageSetup.RightMargin = $word.InchesToPoints(0.85)
    $doc.Styles.Item(-1).Font.Name = 'Aptos'
    $doc.Styles.Item(-1).Font.Size = 10.5
    $doc.Styles.Item(-1).ParagraphFormat.SpaceAfter = 7
    $doc.Styles.Item(-63).Font.Name = 'Aptos Display'
    $doc.Styles.Item(-63).Font.Size = 19
    $doc.Styles.Item(-63).Font.Color = 0
    $doc.Styles.Item(-2).Font.Name = 'Aptos Display'
    $doc.Styles.Item(-2).Font.Size = 13
    $doc.Styles.Item(-2).Font.Color = 0
    $doc.Styles.Item(-2).ParagraphFormat.SpaceBefore = 15
    $doc.Styles.Item(-2).ParagraphFormat.SpaceAfter = 6

    function Add-Paragraph([string]$value, [int]$style = -1) {
        $selection = $word.Selection
        $selection.Style = $doc.Styles.Item($style)
        $selection.Font.Name = 'Arial'
        $selection.Font.Color = 0
        if ($style -eq -63) {
            $selection.Font.Size = 19
            $selection.Font.Bold = $true
            $selection.ParagraphFormat.SpaceAfter = 13
        } elseif ($style -eq -2) {
            $selection.Font.Size = 13
            $selection.Font.Bold = $true
            $selection.ParagraphFormat.SpaceBefore = 16
            $selection.ParagraphFormat.SpaceAfter = 7
        } else {
            $selection.Font.Size = 10.5
            $selection.Font.Bold = $false
            $selection.ParagraphFormat.SpaceAfter = 8
        }
        $selection.TypeText($value)
        $selection.TypeParagraph()
    }

    function New-Page { $word.Selection.InsertBreak(7) }

    Add-Paragraph 'Contexto del sistema web de préstamos de equipos multimedia y audiovisuales' -63
    Add-Paragraph 'Universidad Autónoma de Occidente · Documento de contexto para el Avance 1' -1
    Add-Paragraph 'Este documento define el problema, el alcance y la arquitectura del sistema web propuesto para gestionar el préstamo de recursos audiovisuales de la UAO. El Avance 1 entrega el modelo de datos, la base del cliente y del servidor, la comprobación de conexión con MySQL y las vistas públicas maquetadas; los flujos de autenticación y préstamos se desarrollarán en entregas posteriores.'

    Add-Paragraph '1. Planteamiento del problema' -2
    Add-Paragraph 'Los equipos multimedia de uso académico, como cámaras, micrófonos, trípodes, luces y grabadoras, requieren un registro confiable de disponibilidad y de solicitudes. Cuando la información se dispersa entre personas o archivos, resulta difícil saber qué equipo puede prestarse, quién lo solicitó y cuál es su estado actual. Los manuales y demás archivos relacionados también necesitan una ubicación y trazabilidad claras.'

    Add-Paragraph '2. Contexto' -2
    Add-Paragraph 'El sistema se plantea para una unidad académica de la UAO que administra recursos compartidos para estudiantes y docentes. Los encargados necesitan mantener el inventario y revisar solicitudes; quienes solicitan recursos necesitan consultar disponibilidad y hacer seguimiento. Es un proyecto formativo con un alcance incremental que usa MySQL, una API REST y una interfaz web accesible desde distintos tamaños de pantalla.'

    Add-Paragraph '3. Objetivo general' -2
    Add-Paragraph 'Diseñar e implementar progresivamente una aplicación web para gestionar usuarios, inventario audiovisual, solicitudes de préstamo y archivos asociados, con información persistente y responsabilidades separadas entre cliente, servidor y almacenamiento.'

    Add-Paragraph '4. Objetivos específicos' -2
    Add-Paragraph 'Modelar entidades, relaciones y restricciones del dominio en MySQL; preparar la autenticación mediante un campo de hash de contraseña; construir un frontend React y Vite y un backend Node.js y Express; exponer una API REST capaz de comprobar la conexión real a la base de datos; y preparar la persistencia dual de archivos físicos y metadatos sin guardar binarios en SQL.'

    Add-Paragraph '5. Usuarios' -2
    Add-Paragraph 'Estudiantes y docentes consultarán recursos y, en una fase posterior, crearán solicitudes. Los administradores o encargados mantendrán categorías, equipos, estados y archivos, además de revisar y resolver solicitudes. Cada usuario tendrá un único rol.'

    New-Page
    Add-Paragraph '6. Alcance funcional' -2
    Add-Paragraph 'El producto completo contemplará registro e inicio de sesión, roles, consulta de disponibilidad, inventario de equipos, solicitudes con uno o varios equipos, aprobación o rechazo, historial y archivos relacionados. En el Avance 1 se entregan la landing, las pantallas de login y registro maquetadas, el esquema relacional y el endpoint GET /health conectado a MySQL. Las acciones de los formularios, los CRUD, las rutas privadas y la subida de archivos se reservan para el Avance 2 y la entrega final.'

    Add-Paragraph '7. Restricciones' -2
    Add-Paragraph 'La aplicación activa se ejecuta con tecnologías web. La interfaz y el servidor se comunican por HTTP y JSON. Las credenciales se configuran mediante variables de entorno fuera de Git. Las contraseñas de futuros usuarios se almacenarán únicamente como hash; el esquema no incluye contraseñas en texto plano. MySQL guarda datos y metadatos; los ficheros se almacenarán en disco del servidor o en un servicio externo. GitHub Pages, si se utiliza después, alojará solamente el frontend estático.'

    Add-Paragraph '8. Reglas de negocio' -2
    Add-Paragraph 'Cada equipo tiene una categoría y un estado actual. Cada solicitud pertenece a un usuario, tiene un estado y puede incluir varios equipos. Un equipo puede aparecer en distintas solicitudes históricas, pero solo una vez dentro de la misma solicitud. Antes de aprobar o entregar un equipo se debe validar su disponibilidad y evitar asignaciones simultáneas. Los archivos están asociados a un equipo y registran al usuario que los cargó. Las operaciones administrativas quedarán sujetas a autenticación y rol en el Avance 2.'

    Add-Paragraph '9. Justificación' -2
    Add-Paragraph 'Una plataforma compartida facilita localizar recursos disponibles, ordenar las solicitudes y mantener un historial verificable. El diseño desacoplado permite evolucionar la interfaz sin cambiar el motor de datos, y prepara un flujo de préstamos que puede ampliarse con autenticación, permisos y almacenamiento de archivos.'

    Add-Paragraph '10. Resultado esperado' -2
    Add-Paragraph 'Al completar el curso, estudiantes y docentes podrán solicitar recursos desde la web y los administradores podrán gestionar inventario, decisiones de préstamo y material de apoyo. En esta primera entrega se valida la estructura técnica: repositorio separado, esquema MySQL y conexión comprobada por la API, junto con tres vistas públicas adaptables.'

    New-Page
    Add-Paragraph '11. Arquitectura web propuesta' -2
    Add-Paragraph 'React + Vite presenta las rutas públicas y, más adelante, las vistas privadas. Mediante HTTP y JSON consume la API REST de Node.js + Express. El servidor concentra validación y reglas de negocio y consulta MySQL con SQL explícito. La URL de la API y los datos de conexión se configuran mediante variables de entorno. GET /health ejecuta SELECT 1 en MySQL y devuelve 200 al conectar o 503 si no está disponible.'

    Add-Paragraph '12. Persistencia dual' -2
    Add-Paragraph 'La tabla archivo_multimedia almacena nombre original, nombre de almacenamiento, tipo MIME, tamaño, ruta o URL, fecha, autor, equipo asociado, descripción e indicador de archivo principal. El contenido físico se guardará fuera de MySQL; la implementación del endpoint multipart/form-data y la estrategia concreta de almacenamiento corresponden al Avance 2.'

    Add-Paragraph '13. Historias de usuario principales' -2
    Add-Paragraph 'HU01. Como estudiante o docente, quiero consultar equipos disponibles para conocer qué recursos puedo solicitar.'
    Add-Paragraph 'HU02. Como usuario, quiero registrarme para acceder al sistema de préstamos.'
    Add-Paragraph 'HU03. Como usuario registrado, quiero iniciar sesión para acceder a las funciones privadas.'
    Add-Paragraph 'HU04. Como usuario, quiero solicitar uno o varios equipos para una actividad académica.'
    Add-Paragraph 'HU05. Como administrador, quiero gestionar equipos y su disponibilidad para mantener actualizado el inventario.'
    Add-Paragraph 'HU06. Como administrador, quiero aprobar o rechazar solicitudes según la disponibilidad.'
    Add-Paragraph 'HU07. Como administrador, quiero asociar archivos y manuales a equipos para facilitar su consulta.'

    $doc.SaveAs2([System.IO.Path]::GetFullPath($output), 16)
    $doc.Close(0)
    Write-Output ([System.IO.Path]::GetFullPath($output))
} finally {
    $word.Quit()
    [System.Runtime.InteropServices.Marshal]::FinalReleaseComObject($word) | Out-Null
}


