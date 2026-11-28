package mx.upaep.ciisregistry.data

import android.graphics.Bitmap
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.compose.ui.graphics.Color
import java.time.LocalDate
import java.time.LocalTime
import java.time.format.DateTimeFormatter
import java.util.Locale

/* =====================================================================
   Datos del prototipo. Los datos de ejemplo viven en memoria; lo que registra
   la coordinación (alumnos, aliados, proyectos y cuentas) y las implementaciones de los alumnos
   se guardan en la base SQLite del teléfono (ver BaseDatos.java y Cuentas.kt).
   Para conectarlo a la base "ciis", reemplaza Repo por llamadas a una API.
   ===================================================================== */

enum class Rol { ALUMNO, ALIADO, COORDINADOR }

enum class Estatus(val texto: String) {
    NO_INICIADO("No iniciado"), EN_PROGRESO("En progreso"), TERMINADO("Terminado"), ARCHIVADO("Archivado")
}

class Objetivo(val texto: String, cumplido: Boolean) {
    var cumplido by mutableStateOf(cumplido)
}

class Evidencia(val foto: Bitmap?, val comentario: String, val autor: String, val fecha: LocalDate)

/**
 * Registro de implementación: una actividad que el equipo hizo en la comunidad
 * (taller, visita, entrega…) con su foto de evidencia.
 * Se captura en RegistrarImplementacionActivity y se muestra en las pantallas de Compose.
 */
class Implementacion(
    val id: Int,
    val proyectoId: Int,
    val matricula: String,
    val tipo: String,
    val actividad: String,
    val lugar: String,
    val fecha: LocalDate,
    val beneficiarios: Int,
    val comentario: String,
    val foto: Bitmap?,
)

class Proyecto(
    val id: Int,
    val nombre: String,
    val descripcion: String,
    val ods: String,
    val saps: String,
    val comunidad: String,
    val municipio: String,
    val beneficiarios: Int,
    val inicio: LocalDate,
    val fin: LocalDate?,
    val color: Color,
    objetivos: List<Objetivo>,
    archivado: Boolean = false,
    val buscaApoyo: Boolean = false,
) {
    val objetivos = mutableStateListOf<Objetivo>().apply { addAll(objetivos) }
    val evidencias = mutableStateListOf<Evidencia>()

    /** Foto del proyecto: la evidencia más reciente con foto (igual que imagen_proyecto() del sitio web). */
    val fotoProyecto: Bitmap? get() = evidencias.lastOrNull { it.foto != null }?.foto
    var archivado by mutableStateOf(archivado)

    val hechos: Int get() = objetivos.count { it.cumplido }

    /** Regla del Figma: No iniciado 0 %, En progreso según objetivos, Archivado 0 %, Terminado 100 %. */
    val estatus: Estatus
        get() = when {
            archivado -> Estatus.ARCHIVADO
            objetivos.isEmpty() || hechos == 0 -> Estatus.NO_INICIADO
            hechos == objetivos.size -> Estatus.TERMINADO
            else -> Estatus.EN_PROGRESO
        }

    val avance: Int
        get() = when (estatus) {
            Estatus.ARCHIVADO, Estatus.NO_INICIADO -> 0
            Estatus.TERMINADO -> 100
            Estatus.EN_PROGRESO -> hechos * 100 / objetivos.size
        }

    val periodo: String get() = "${fechaCorta(inicio)} – ${fin?.let { fechaCorta(it) } ?: "sin fecha de fin"}"
}

class Estudiante(
    val matricula: String,
    val nombre: String,
    val correo: String,
    val programa: String,
    val generacion: Int,
    val frecuencia: String,
    estatus: String = "Activo",
    proyectoId: Int? = null,
    rol: String = "",
) {
    var estatus by mutableStateOf(estatus)
    var proyectoId by mutableStateOf(proyectoId)
    var rol by mutableStateOf(rol)
    var foto by mutableStateOf<Bitmap?>(null)
}

class Aliado(val id: Int, val nombre: String, val tipo: String, val correo: String, proyectos: List<Int>) {
    val proyectos = mutableStateListOf<Int>().apply { addAll(proyectos) }
}

data class Mentor(val nombre: String, val tema: String, val correo: String = "")

class Mentoria(
    val id: Int,
    val fecha: LocalDate,
    val hora: String,
    val matricula: String,
    val mentor: String,
    val tema: String,
    val nota: String = "",
) {
    var cancelada by mutableStateOf(false)
}

data class Coordinador(val nombre: String, val puesto: String, val area: String, val correo: String)

object Limites {
    const val PROYECTOS_POR_ALIADO = 10
}

object Repo {
    val hoy: LocalDate get() = LocalDate.now()

    val coordinador = Coordinador("Mtra. Laura Gómez Díaz", "Coordinadora de Innovación Social", "CIIS", "laura.gomez@upaep.mx")

    val proyectos = mutableStateListOf<Proyecto>()
    val estudiantes = mutableStateListOf<Estudiante>()
    val aliados = mutableStateListOf<Aliado>()
    val mentores = mutableStateListOf<Mentor>()
    val mentorias = mutableStateListOf<Mentoria>()

    /** Programas institucionales: los mismos de la tabla "programa" de la base ciis (sitio web). */
    val programas = listOf(
        "BL-UAF", "UAF", "BL", "Beca Liderazgo", "Voluntaria", "Voluntario", "Voluntarios", "Sin programa",
    )
    val frecuencias = listOf("Semanal", "Quincenal", "Mensual")
    val rolesProyecto = listOf("Líder de equipo", "Integrante", "Becario", "Voluntario", "Apoyo")
    val tiposAliado = listOf("Empresa", "Fundación", "Escuela", "Gobierno", "Institución", "OSC", "Área interna")
    val ods = (1..17).map { "ODS $it" }
    val clasificacionesSaps = listOf(
        "Gestión de impacto social", "Salud comunitaria y bienestar", "Innovación educativa comunitaria",
        "Desarrollo humano y social", "Trabajo y competitividad sostenible", "Bioética y ciencias de la vida",
    )
    val horas = listOf("09:00", "10:00", "11:00", "12:00", "13:00", "16:00", "17:00", "18:00")

    /* ---------- Cuentas e inicio de sesión ---------- */

    /* Las cuentas de coordinación (coordi01 y coordi02) se crean en la tabla "usuarios"
       dentro de BaseDatos.onCreate(). */

    /** Alumnos y aliados que registró la coordinación. Entran después de activar su cuenta. */
    val cuentas = mutableStateListOf<Cuenta>()

    // Sesión actual
    var rol by mutableStateOf<Rol?>(null)
    var correoSesion by mutableStateOf("")
    var matriculaSesion by mutableStateOf("")
    var aliadoSesion by mutableStateOf(0)

    /** Busca la cuenta en la tabla "usuarios" de SQLite (SELECT ... WHERE correo = ?). */
    fun cuenta(correo: String): Cuenta? {
        val fila = Almacen.base()?.buscarUsuario(correo)
        if (fila != null) return Almacen.cuentaDeFila(fila)
        return cuentas.firstOrNull { it.correo.equals(correo.trim(), ignoreCase = true) }
    }

    /** ¿Ese correo ya lo usa alguien (cuenta, estudiante o aliado)? */
    fun correoEnUso(correo: String): Boolean {
        val c = correo.trim()
        return cuenta(c) != null || estudiantes.any { it.correo.equals(c, true) } || aliados.any { it.correo.equals(c, true) }
    }

    /** Un alumno solo puede entrar si su registro está Activo. */
    private fun cuentaHabilitada(c: Cuenta): Boolean =
        c.rol != Rol.ALUMNO || estudiante(c.ref)?.estatus == "Activo"

    /** Inicio de sesión: consulta el correo en la tabla "usuarios" y compara la contraseña con su hash. */
    fun iniciarSesion(correo: String, contrasena: String): ResultadoLogin {
        val c = cuenta(correo) ?: return ResultadoLogin.INCORRECTO
        if (!c.activa) return ResultadoLogin.SIN_ACTIVAR
        if (!Claves.coincide(contrasena, c)) return ResultadoLogin.INCORRECTO
        if (!cuentaHabilitada(c)) return ResultadoLogin.INACTIVA
        correoSesion = c.correo
        when (c.rol) {
            Rol.ALUMNO -> matriculaSesion = c.ref
            Rol.ALIADO -> aliadoSesion = c.ref.toInt()
            Rol.COORDINADOR -> Unit
        }
        rol = c.rol
        return ResultadoLogin.OK
    }

    /** Primer paso de "Activa tu cuenta": revisa que la coordinación haya registrado ese correo. */
    fun puedeActivar(correo: String): ResultadoActivar {
        val c = cuentas.firstOrNull { it.correo.equals(correo.trim(), true) } ?: return ResultadoActivar.NO_REGISTRADO
        return when {
            c.activa -> ResultadoActivar.YA_ACTIVA
            !cuentaHabilitada(c) -> ResultadoActivar.INACTIVA
            else -> ResultadoActivar.OK
        }
    }

    /** Segundo paso: guarda la contraseña nueva (como hash). */
    fun activarCuenta(correo: String, contrasena: String): ResultadoActivar {
        val r = puedeActivar(correo)
        if (r != ResultadoActivar.OK) return r
        val c = cuentas.first { it.correo.equals(correo.trim(), true) }
        val sal = Claves.nuevaSal()
        c.sal = sal
        c.hash = Claves.hash(contrasena, sal)
        Almacen.guardarCuenta(c) // actualiza la fila en la tabla "usuarios"
        return ResultadoActivar.OK
    }

    fun cerrarSesion() { rol = null; correoSesion = "" }

    val alumno: Estudiante get() = estudiantes.first { it.matricula == matriculaSesion }
    val aliado: Aliado get() = aliados.first { it.id == aliadoSesion }

    fun proyecto(id: Int?): Proyecto? = proyectos.firstOrNull { it.id == id }
    fun integrantes(p: Proyecto) = estudiantes.filter { it.proyectoId == p.id }
    fun aliadosDe(p: Proyecto) = aliados.filter { p.id in it.proyectos }
    fun mentoriasDe(matricula: String) = mentorias.filter { it.matricula == matricula && !it.cancelada }.sortedBy { it.fecha }
    fun mentoriasDeProyecto(p: Proyecto) = mentorias.filter { !it.cancelada && estudiantes.any { e -> e.matricula == it.matricula && e.proyectoId == p.id } }
    fun proximasMentorias() = mentorias.filter { !it.cancelada && !it.fecha.isBefore(hoy) }.sortedBy { it.fecha }
    fun proyectosActivos() = proyectos.filter { !it.archivado }
    fun estudiantesSinProyecto() = estudiantes.filter { it.proyectoId == null && it.estatus == "Activo" }
    fun proyectosQueBuscanApoyo(a: Aliado) = proyectos.filter { !it.archivado && it.id !in a.proyectos }

    /** Los ids desde aquí son de registros nuevos (los de ejemplo usan ids menores). */
    private const val ID_NUEVOS = 100
    private var sigProyecto = ID_NUEVOS
    private var sigAliado = ID_NUEVOS
    private var sigMentoria = 100

    fun agregarProyecto(
        nombre: String, descripcion: String, ods: String, saps: String, comunidad: String, municipio: String,
        beneficiarios: Int, inicio: LocalDate, fin: LocalDate?, integrantes: List<String>,
    ): Proyecto {
        val p = Proyecto(
            id = sigProyecto++, nombre = nombre, descripcion = descripcion, ods = ods, saps = saps,
            comunidad = comunidad, municipio = municipio, beneficiarios = beneficiarios, inicio = inicio, fin = fin,
            color = paleta[proyectos.size % paleta.size], objetivos = emptyList(), buscaApoyo = true,
        )
        proyectos.add(p)
        integrantes.forEachIndexed { i, m ->
            estudiantes.firstOrNull { it.matricula == m }?.apply {
                proyectoId = p.id
                rol = if (i == 0) "Líder de equipo" else "Integrante"
            }
        }
        guardar()
        return p
    }

    fun agregarAliado(nombre: String, tipo: String, correo: String, proyecto: Int?) {
        val a = Aliado(sigAliado++, nombre, tipo, correo, listOfNotNull(proyecto))
        aliados.add(a)
        cuentas.add(Cuenta(correo, Rol.ALIADO, a.id.toString()))
        guardar()
    }

    /** Alta de estudiante: crea su registro y su cuenta (sin contraseña hasta que la active). */
    fun registrarEstudiante(e: Estudiante) {
        estudiantes.add(e)
        cuentas.add(Cuenta(e.correo, Rol.ALUMNO, e.matricula))
        guardar()
    }

    /* ---------- Guardado en SQLite (BaseDatos.java) ---------- */

    /** Lo llama AppActivity al abrir: abre la base de datos y carga lo guardado. */
    fun iniciar(context: android.content.Context) {
        if (Almacen.listo) return
        val db = Almacen.abrir(context)
        runCatching { cargar(db) }
            .onFailure { android.util.Log.e("CIIS", "No se pudieron cargar los datos de SQLite", it) }
    }

    /**
     * Guarda en SQLite lo que registró la coordinación:
     * cuentas, proyectos nuevos, estudiantes nuevos (o de ejemplo asignados a un proyecto nuevo)
     * y aliados nuevos (o de ejemplo que apoyan un proyecto nuevo).
     */
    fun guardar() {
        if (!Almacen.listo) return
        val registrados = cuentas.filter { it.rol == Rol.ALUMNO }.map { it.ref }.toSet()
        cuentas.forEach { Almacen.guardarCuenta(it) }
        proyectos.filter { it.id >= ID_NUEVOS }.forEach { Almacen.guardarProyecto(it) }
        estudiantes.filter { it.matricula in registrados || (it.proyectoId ?: 0) >= ID_NUEVOS }.forEach { Almacen.guardarEstudiante(it) }
        aliados.filter { a -> a.id >= ID_NUEVOS || a.proyectos.any { it >= ID_NUEVOS } }.forEach { Almacen.guardarAliado(it) }
    }

    /** Lee cada tabla con un Cursor y pasa las filas a las listas de la app. */
    private fun cargar(db: BaseDatos) {
        // usuarios (alumnos y aliados; la coordinación se busca directo en la tabla al iniciar sesión)
        db.leerTodo("usuarios").use { c ->
            while (c.moveToNext()) {
                val cuenta = Cuenta(
                    c.getString(c.getColumnIndexOrThrow("correo")),
                    Rol.valueOf(c.getString(c.getColumnIndexOrThrow("rol"))),
                    c.getString(c.getColumnIndexOrThrow("referencia")) ?: "",
                    c.getString(c.getColumnIndexOrThrow("hash"))?.ifEmpty { null },
                    c.getString(c.getColumnIndexOrThrow("sal"))?.ifEmpty { null },
                )
                if (cuenta.rol != Rol.COORDINADOR && cuentas.none { it.correo.equals(cuenta.correo, true) }) cuentas.add(cuenta)
            }
        }
        // proyectos
        db.leerTodo("proyectos").use { c ->
            while (c.moveToNext()) {
                val id = c.getInt(c.getColumnIndexOrThrow("id"))
                if (proyecto(id) != null) continue
                proyectos.add(
                    Proyecto(
                        id, c.getString(c.getColumnIndexOrThrow("nombre")), c.getString(c.getColumnIndexOrThrow("descripcion")),
                        c.getString(c.getColumnIndexOrThrow("ods")), c.getString(c.getColumnIndexOrThrow("saps")),
                        c.getString(c.getColumnIndexOrThrow("comunidad")), c.getString(c.getColumnIndexOrThrow("municipio")),
                        c.getInt(c.getColumnIndexOrThrow("beneficiarios")),
                        LocalDate.parse(c.getString(c.getColumnIndexOrThrow("inicio"))),
                        c.getString(c.getColumnIndexOrThrow("fin"))?.takeIf { it.isNotEmpty() }?.let(LocalDate::parse),
                        Color(c.getInt(c.getColumnIndexOrThrow("color"))),
                        Almacen.objetivosDeJson(c.getString(c.getColumnIndexOrThrow("objetivos"))),
                        c.getInt(c.getColumnIndexOrThrow("archivado")) == 1,
                        c.getInt(c.getColumnIndexOrThrow("busca_apoyo")) == 1,
                    ),
                )
            }
        }
        // estudiantes: si ya existe (de ejemplo) solo se actualiza su proyecto; si no, se agrega
        db.leerTodo("estudiantes").use { c ->
            while (c.moveToNext()) {
                val matricula = c.getString(c.getColumnIndexOrThrow("matricula"))
                val pid = c.getInt(c.getColumnIndexOrThrow("proyecto_id")).takeIf { it >= 0 && proyecto(it) != null }
                val rolProyecto = c.getString(c.getColumnIndexOrThrow("rol")) ?: ""
                val existente = estudiante(matricula)
                if (existente != null) {
                    existente.proyectoId = pid; existente.rol = rolProyecto
                } else {
                    estudiantes.add(
                        Estudiante(
                            matricula, c.getString(c.getColumnIndexOrThrow("nombre")), c.getString(c.getColumnIndexOrThrow("correo")),
                            c.getString(c.getColumnIndexOrThrow("programa")), c.getInt(c.getColumnIndexOrThrow("generacion")),
                            c.getString(c.getColumnIndexOrThrow("frecuencia")), c.getString(c.getColumnIndexOrThrow("estatus")),
                            pid, rolProyecto,
                        ),
                    )
                }
            }
        }
        // aliados: si ya existe (de ejemplo) se le suman los proyectos; si no, se agrega
        db.leerTodo("aliados").use { c ->
            while (c.moveToNext()) {
                val id = c.getInt(c.getColumnIndexOrThrow("id"))
                val ids = Almacen.enteros(c.getString(c.getColumnIndexOrThrow("proyectos"))).filter { proyecto(it) != null }
                val existente = aliados.firstOrNull { it.id == id }
                if (existente != null) ids.filter { it !in existente.proyectos }.forEach { existente.proyectos.add(it) }
                else aliados.add(
                    Aliado(id, c.getString(c.getColumnIndexOrThrow("nombre")), c.getString(c.getColumnIndexOrThrow("tipo")),
                        c.getString(c.getColumnIndexOrThrow("correo")), ids),
                )
            }
        }
        // implementaciones (con su foto guardada como archivo JPG)
        db.leerTodo("implementaciones").use { c ->
            while (c.moveToNext()) {
                val ruta = c.getString(c.getColumnIndexOrThrow("foto_ruta"))
                val foto = ruta?.let { android.graphics.BitmapFactory.decodeFile(it) }
                agregarImplementacion(
                    Implementacion(
                        c.getInt(c.getColumnIndexOrThrow("id")), c.getInt(c.getColumnIndexOrThrow("proyecto_id")),
                        c.getString(c.getColumnIndexOrThrow("matricula")), c.getString(c.getColumnIndexOrThrow("tipo")),
                        c.getString(c.getColumnIndexOrThrow("actividad")), c.getString(c.getColumnIndexOrThrow("lugar")),
                        LocalDate.parse(c.getString(c.getColumnIndexOrThrow("fecha"))),
                        c.getInt(c.getColumnIndexOrThrow("beneficiarios")),
                        c.getString(c.getColumnIndexOrThrow("comentario")) ?: "", foto,
                    ),
                )
            }
        }
        sigProyecto = maxOf(sigProyecto, (proyectos.maxOfOrNull { it.id } ?: 0) + 1)
        sigAliado = maxOf(sigAliado, (aliados.maxOfOrNull { it.id } ?: 0) + 1)
    }

    /** Última mentoría agendada (para ofrecer "Agregar a Calendar"). */
    var ultimaMentoria by mutableStateOf<Mentoria?>(null)

    fun agendar(fecha: LocalDate, hora: String, matricula: String, mentor: Mentor, nota: String = "") {
        val m = Mentoria(sigMentoria++, fecha, hora, matricula, mentor.nombre, mentor.tema, nota)
        mentorias.add(m)
        ultimaMentoria = m
    }

    /* ---------- Implementaciones (registro del alumno) ---------- */

    /** Lista observable: cuando se agrega una, las pantallas de Compose se actualizan solas. */
    val implementaciones = mutableStateListOf<Implementacion>()

    val tiposImplementacion = listOf("Taller", "Visita a la comunidad", "Entrega de materiales", "Reunión con beneficiarios", "Otra actividad")

    fun implementacionesDe(p: Proyecto) = implementaciones.filter { it.proyectoId == p.id }.sortedByDescending { it.fecha }

    /** Carpeta donde RegistrarImplementacionActivity guarda las fotos (JPG). */
    fun carpetaFotos(): java.io.File? = Almacen.carpetaFotos

    /** Base de datos SQLite (la usa RegistrarImplementacionActivity para insertar). */
    fun baseDatos(): BaseDatos? = Almacen.base()

    /**
     * Agrega una implementación a la lista en memoria (después de guardarla en SQLite).
     * Si trae foto, también la suma a las evidencias del proyecto, para que el coordinador
     * y los aliados la vean en el detalle del proyecto.
     */
    fun agregarImplementacion(imp: Implementacion) {
        if (implementaciones.any { it.id == imp.id }) return
        implementaciones.add(imp)
        val p = proyecto(imp.proyectoId) ?: return
        if (imp.foto != null) {
            val autor = estudiante(imp.matricula)?.nombre?.split(" ")?.first() ?: imp.matricula
            p.evidencias.add(Evidencia(imp.foto, "${imp.tipo}: ${imp.actividad}", autor, imp.fecha))
        }
    }

    fun mentor(nombre: String) = mentores.firstOrNull { it.nombre == nombre }
    fun estudiante(matricula: String) = estudiantes.firstOrNull { it.matricula == matricula }

    fun mentorOcupado(mentor: String, fecha: LocalDate, hora: String) =
        mentorias.any { it.mentor == mentor && it.fecha == fecha && it.hora == hora && !it.cancelada }

    private val paleta = listOf(
        Color(0xFF6FBF73), Color(0xFF3B8FD9), Color(0xFFB05AB0), Color(0xFFF0A53A),
        Color(0xFF3AA58C), Color(0xFF5B74CF), Color(0xFFE05A6D), Color(0xFFC9794A),
    )

    private fun objetivos(nombres: List<String>, hechos: Int) = nombres.mapIndexed { i, n -> Objetivo(n, i < hechos) }
    private fun genericos(total: Int, hechos: Int) = objetivos((1..total).map { "Objetivo $it" }, hechos)

    init {
        val h = LocalDate.now()
        proyectos.addAll(
            listOf(
                Proyecto(
                    1, "Huertos comunitarios", "Huertos de traspatio con familias de la comunidad",
                    "ODS 2 · Hambre cero", "Gestión de impacto social", "San Andrés Cholula", "San Andrés Cholula",
                    40, LocalDate.of(2026, 2, 15), LocalDate.of(2026, 12, 15), paleta[0],
                    objetivos(
                        listOf(
                            "Diagnóstico con 10 familias", "Taller de composta", "Preparar camas de cultivo",
                            "Siembra de hortalizas", "Sistema de riego por goteo", "Primera cosecha",
                            "Recetario con lo cosechado", "Entrega de huertos a las familias",
                        ), 5,
                    ),
                ),
                Proyecto(
                    2, "Agua limpia para todos", "Filtros caseros de agua para escuelas rurales",
                    "ODS 6 · Agua limpia", "Salud comunitaria y bienestar", "Santa María Tonantzintla", "San Andrés Cholula",
                    120, LocalDate.of(2026, 3, 1), LocalDate.of(2027, 1, 30), paleta[1], genericos(11, 5),
                ),
                Proyecto(
                    3, "Robótica para niñas", "Talleres de robótica para primarias públicas",
                    "ODS 5 · Igualdad de género", "Innovación educativa comunitaria", "Centro", "Puebla",
                    60, LocalDate.of(2026, 1, 20), LocalDate.of(2026, 12, 10), paleta[5], genericos(5, 4),
                ),
                Proyecto(
                    4, "Energía solar comunitaria", "Paneles solares para el centro comunitario",
                    "ODS 7 · Energía asequible", "Trabajo y competitividad sostenible", "San Miguel Canoa", "Puebla",
                    200, LocalDate.of(2026, 5, 4), LocalDate.of(2027, 5, 4), paleta[3], genericos(5, 1),
                ),
                Proyecto(
                    5, "Reciclaje escolar", "Separación de residuos en secundarias",
                    "ODS 12 · Producción responsable", "Desarrollo humano y social", "Amalucan", "Puebla",
                    300, LocalDate.of(2026, 4, 10), LocalDate.of(2026, 12, 20), paleta[4], genericos(20, 7),
                ),
                Proyecto(
                    6, "Puentes digitales", "Alfabetización digital para adultos mayores",
                    "ODS 4 · Educación de calidad", "Innovación educativa comunitaria", "La Paz", "Puebla",
                    35, LocalDate.of(2026, 11, 3), null, paleta[2], genericos(6, 0), buscaApoyo = true,
                ),
                Proyecto(
                    7, "Escuela verde", "Azoteas verdes en escuelas",
                    "ODS 11 · Ciudades sostenibles", "Gestión de impacto social", "Xonacatepec", "Puebla",
                    90, LocalDate.of(2025, 8, 18), LocalDate.of(2026, 6, 30), paleta[6], genericos(4, 2), archivado = true,
                ),
            ),
        )

        estudiantes.addAll(
            listOf(
                Estudiante("A0375", "Ana López Pérez", "alumno01@gmail.com", "BL-UAF", 2024, "Quincenal", proyectoId = 1, rol = "Líder de equipo"),
                Estudiante("A0412", "Carlos Ramírez Soto", "carlos.ramirez@upaep.mx", "BL", 2024, "Quincenal", proyectoId = 1, rol = "Integrante"),
                Estudiante("A0418", "Sofía Torres Medina", "sofia.torres@upaep.mx", "Beca Liderazgo", 2025, "Quincenal", proyectoId = 1, rol = "Integrante"),
                Estudiante("A0433", "Diego Hernández Ruiz", "diego.hernandez@upaep.mx", "Voluntario", 2023, "Mensual", proyectoId = 1, rol = "Becario"),
                Estudiante("A0441", "Valeria Cruz Lima", "valeria.cruz@upaep.mx", "Voluntaria", 2025, "Quincenal", proyectoId = 1, rol = "Voluntario"),
                Estudiante("A0502", "Mariana Flores Gil", "mariana.flores@upaep.mx", "Beca Liderazgo", 2023, "Semanal", proyectoId = 2, rol = "Líder de equipo"),
                Estudiante("A0510", "Jorge Vega Paz", "jorge.vega@upaep.mx", "UAF", 2024, "Semanal", proyectoId = 2, rol = "Integrante"),
                Estudiante("A0521", "Isabel Rojas Peña", "alumno02@gmail.com", "BL-UAF", 2025, "Quincenal", proyectoId = 3, rol = "Líder de equipo"),
                Estudiante("A0533", "Lucía Luna Ortiz", "lucia.luna@upaep.mx", "Voluntarios", 2024, "Quincenal", proyectoId = 3, rol = "Integrante"),
                Estudiante("A0540", "Raúl Pineda Cano", "raul.pineda@upaep.mx", "BL-UAF", 2023, "Mensual", "En pausa", proyectoId = 4, rol = "Líder de equipo"),
                Estudiante("A0555", "Gabriela Ruiz Mora", "gabriela.ruiz@upaep.mx", "BL", 2024, "Quincenal", proyectoId = 5, rol = "Líder de equipo"),
                Estudiante("A0560", "Tomás Aguilar León", "tomas.aguilar@upaep.mx", "Voluntario", 2022, "Mensual", "Baja"),
                Estudiante("A0571", "Paula Méndez Ríos", "paula.mendez@upaep.mx", "Voluntaria", 2025, "Quincenal"),
                Estudiante("A0578", "Luis Ortega Vela", "luis.ortega@upaep.mx", "UAF", 2025, "Semanal"),
                Estudiante("A0584", "Fernanda Salas Rey", "fernanda.salas@upaep.mx", "Beca Liderazgo", 2025, "Quincenal"),
            ),
        )

        aliados.addAll(
            listOf(
                Aliado(1, "Fundación Bepensa", "Fundación", "aliado01@gmail.com", listOf(1, 3)),
                Aliado(2, "Ayuntamiento de Puebla", "Gobierno", "contacto@pueblacapital.gob.mx", listOf(1, 2, 4)),
                Aliado(3, "Empresa Solar MX", "Empresa", "hola@solarmx.com", listOf(4)),
                Aliado(4, "Red Educativa Puebla", "OSC", "red@educapuebla.org", (1..10).toList()),
            ),
        )

        mentores.addAll(
            listOf(
                Mentor("Dr. Luis Canché", "Modelo de negocio", "luis.canche@upaep.mx"),
                Mentor("Mtra. Paola Ríos", "Medición de impacto", "paola.rios@upaep.mx"),
                Mentor("Ing. Jorge Sosa", "Prototipado", "jorge.sosa@upaep.mx"),
                Mentor("Lic. Marta Díaz", "Comunicación y redes", "marta.diaz@upaep.mx"),
            ),
        )

        val m = mentores
        mentorias.addAll(
            listOf(
                Mentoria(1, h.plusDays(2), "10:00", "A0375", m[0].nombre, m[0].tema),
                Mentoria(2, h.plusDays(16), "12:00", "A0375", m[1].nombre, m[1].tema),
                Mentoria(3, h.minusDays(12), "10:00", "A0375", m[2].nombre, m[2].tema),
                Mentoria(4, h.minusDays(26), "16:00", "A0375", m[0].nombre, m[0].tema),
                Mentoria(5, h.minusDays(40), "11:00", "A0375", m[3].nombre, m[3].tema),
                Mentoria(6, h.plusDays(1), "09:00", "A0502", m[1].nombre, m[1].tema),
                Mentoria(7, h.plusDays(3), "17:00", "A0521", m[2].nombre, m[2].tema),
            ),
        )
    }
}

// ---------- utilidades de fechas en español ----------
private val es = Locale("es", "MX")
fun fechaCorta(d: LocalDate): String = d.format(DateTimeFormatter.ofPattern("d MMM yyyy", es)).replace(".", "")
fun fechaLarga(d: LocalDate): String =
    d.format(DateTimeFormatter.ofPattern("EEEE d MMM yyyy", es)).replace(".", "").replaceFirstChar { it.uppercase() }

fun horaValida(h: String): Boolean = runCatching { LocalTime.parse(h) }.isSuccess
