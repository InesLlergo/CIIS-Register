package mx.upaep.ciisregistry.ui.screens

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Archive
import androidx.compose.material.icons.filled.Assessment
import androidx.compose.material.icons.filled.Close
import androidx.compose.material.icons.filled.Download
import androidx.compose.material.icons.filled.Event
import androidx.compose.material.icons.filled.FolderOpen
import androidx.compose.material.icons.filled.Handshake
import androidx.compose.material.icons.filled.PersonAdd
import androidx.compose.material.icons.filled.School
import androidx.compose.material.icons.filled.Unarchive
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import mx.upaep.ciisregistry.data.Estatus
import mx.upaep.ciisregistry.data.Estudiante
import mx.upaep.ciisregistry.data.Limites
import mx.upaep.ciisregistry.data.Mentor
import mx.upaep.ciisregistry.data.Repo
import mx.upaep.ciisregistry.data.Reportes
import mx.upaep.ciisregistry.data.fechaLarga
import mx.upaep.ciisregistry.data.guardarReporteCsv
import mx.upaep.ciisregistry.ui.components.Aviso
import mx.upaep.ciisregistry.ui.components.AvisoDialogo
import mx.upaep.ciisregistry.ui.components.BarraAvance
import mx.upaep.ciisregistry.ui.components.BarraSesion
import mx.upaep.ciisregistry.ui.components.BotonPrimario
import mx.upaep.ciisregistry.ui.components.BotonSecundario
import mx.upaep.ciisregistry.ui.components.CampoFecha
import mx.upaep.ciisregistry.ui.components.CampoLista
import mx.upaep.ciisregistry.ui.components.CampoTexto
import mx.upaep.ciisregistry.ui.components.Contenido
import mx.upaep.ciisregistry.ui.components.Encabezado
import mx.upaep.ciisregistry.ui.components.FilaDato
import mx.upaep.ciisregistry.ui.components.ItemLista
import mx.upaep.ciisregistry.ui.components.Pestanas
import mx.upaep.ciisregistry.ui.components.Tarjeta
import mx.upaep.ciisregistry.ui.components.TarjetaDato
import mx.upaep.ciisregistry.ui.components.TarjetaProyecto
import mx.upaep.ciisregistry.ui.components.TituloSeccion
import mx.upaep.ciisregistry.ui.theme.Ciis
import java.time.LocalDate
import java.time.format.TextStyle
import java.util.Locale

class NavCoord(
    val salir: () -> Unit,
    val proyecto: (Int) -> Unit,
    val alta: (String) -> Unit, // "estudiante" | "aliado" | "mentor" | "proyecto" | "mentoria"
    val reportes: () -> Unit,
)

private val faltan = Aviso("Faltan datos obligatorios", "Completa todos los campos antes de registrar.")

/* ---------- SesiónCoord / CoordProyectos / CoordRegistro ---------- */
@Composable
fun CoordHomeScreen(nav: NavCoord) {
    var tab by rememberSaveable { mutableStateOf(1) }
    Column(Modifier.fillMaxSize().background(Ciis.Fondo)) {
        BarraSesion("coordinador", nav.salir)
        Pestanas(listOf("Proyectos", "General", "Registro"), tab) { tab = it }
        when (tab) {
            0 -> CoordProyectos(nav)
            1 -> CoordGeneral(nav)
            else -> CoordRegistro(nav)
        }
    }
}

@Composable
private fun CoordGeneral(nav: NavCoord) {
    val activos = Repo.proyectosActivos()
    val promedio = if (activos.isEmpty()) 0 else activos.sumOf { it.avance } / activos.size
    val mes = Repo.hoy.withDayOfMonth(1)
    Contenido {
        Encabezado("Hola, ${Repo.coordinador.nombre.split(" ")[1]}", Repo.coordinador.puesto)
        Row(horizontalArrangement = Arrangement.spacedBy(12.dp)) {
            TarjetaDato(activos.size.toString(), "Proyectos activos", Modifier.weight(1f), Ciis.Rojo)
            TarjetaDato(Repo.estudiantes.count { it.estatus == "Activo" }.toString(), "Estudiantes activos", Modifier.weight(1f))
        }
        Row(horizontalArrangement = Arrangement.spacedBy(12.dp)) {
            TarjetaDato(Repo.aliados.size.toString(), "Aliados", Modifier.weight(1f))
            TarjetaDato("$promedio%", "Avance promedio", Modifier.weight(1f))
        }
        Tarjeta {
            TituloSeccion("Próximas mentorías")
            val prox = Repo.proximasMentorias().take(3)
            if (prox.isEmpty()) Text("No hay mentorías próximas.", color = Ciis.Suave)
            prox.forEach { m ->
                ItemLista(fechaLarga(m.fecha) + " · " + m.hora, "${Repo.estudiante(m.matricula)?.nombre ?: m.matricula} con ${m.mentor}", Icons.Filled.Event, Ciis.Ambar)
            }
            Text(
                "Mentorías este mes: ${Repo.mentorias.count { !it.cancelada && !it.fecha.isBefore(mes) && it.fecha.isBefore(mes.plusMonths(1)) }}",
                style = MaterialTheme.typography.bodySmall, color = Ciis.Suave,
            )
        }
        BotonPrimario("Ver reportes", icono = Icons.Filled.Assessment, onClick = nav.reportes)
        BotonSecundario("Asignar mentoría", icono = Icons.Filled.Event) { nav.alta("mentoria") }
    }
}

@Composable
private fun CoordProyectos(nav: NavCoord) {
    var filtro by rememberSaveable { mutableStateOf("Todos") }
    val opciones = listOf("Todos") + Estatus.entries.map { it.texto }
    Contenido {
        Encabezado("Proyectos", "${Repo.proyectosActivos().size} proyectos activos")
        CampoLista("Filtrar por estatus", opciones, filtro, { filtro = it })
        Repo.proyectos.filter { filtro == "Todos" || it.estatus.texto == filtro }
            .sortedBy { it.archivado }
            .forEach { p -> TarjetaProyecto(p, onClick = { nav.proyecto(p.id) }) }
    }
}

@Composable
private fun CoordRegistro(nav: NavCoord) {
    Contenido {
        Encabezado("Registro", "¿Qué deseas dar de alta?")
        ItemLista("Estudiante", "Registra a un estudiante y su seguimiento", Icons.Filled.School, onClick = { nav.alta("estudiante") })
        ItemLista("Aliado", "Organización que apoya proyectos", Icons.Filled.Handshake, Ciis.Azul, onClick = { nav.alta("aliado") })
        ItemLista("Mentor", "Mentor y su tema de mentoría", Icons.Filled.PersonAdd, Ciis.Verde, onClick = { nav.alta("mentor") })
        ItemLista("Proyecto", "Crea un proyecto con sus integrantes", Icons.Filled.FolderOpen, Ciis.Ambar, onClick = { nav.alta("proyecto") })
        ItemLista("Asignar mentoría", "Agenda una mentoría a un estudiante", Icons.Filled.Event, Ciis.Morado, onClick = { nav.alta("mentoria") })
    }
}

/* ---------- DetalleProyecto/claro (coordinador) ---------- */
@Composable
fun CoordDetalleScreen(id: Int, onVolver: () -> Unit) {
    val p = Repo.proyecto(id) ?: return
    Column(Modifier.fillMaxSize().background(Ciis.Fondo)) {
        Contenido {
            DetalleProyecto(p, "Volver", onVolver)
            if (p.archivado) BotonSecundario("Reactivar proyecto", icono = Icons.Filled.Unarchive) { p.archivado = false }
            else BotonSecundario("Archivar proyecto", icono = Icons.Filled.Archive) { p.archivado = true }
        }
    }
}

/* ---------- Pantalla base de los formularios de alta ---------- */
@Composable
private fun Formulario(titulo: String, subtitulo: String, onVolver: () -> Unit, aviso: Aviso?, onCerrarAviso: () -> Unit, content: @Composable () -> Unit) {
    Column(Modifier.fillMaxSize().background(Ciis.Fondo)) {
        Contenido {
            Encabezado(titulo, subtitulo, volver = "Registro", onVolver = onVolver)
            content()
            Spacer(Modifier.height(8.dp))
        }
    }
    AvisoDialogo(aviso, onCerrar = onCerrarAviso)
}

/* ---------- AltaEstudiante/claro ---------- */
@Composable
fun AltaEstudianteScreen(onVolver: () -> Unit, onExito: () -> Unit) {
    var matricula by rememberSaveable { mutableStateOf("") }
    var nombre by rememberSaveable { mutableStateOf("") }
    var correo by rememberSaveable { mutableStateOf("") }
    var generacion by rememberSaveable { mutableStateOf(Repo.hoy.year.toString()) }
    var programa by rememberSaveable { mutableStateOf("") }
    var frecuencia by rememberSaveable { mutableStateOf("") }
    var estatus by rememberSaveable { mutableStateOf("Activo") }
    var proyecto by rememberSaveable { mutableStateOf("") }
    var rol by rememberSaveable { mutableStateOf("") }
    var aviso by remember { mutableStateOf<Aviso?>(null) }
    val sinProyecto = "Sin proyecto por ahora"

    Formulario("Alta de estudiante", "Llena los datos para registrar a un estudiante.", onVolver, aviso, { aviso = null }) {
        TituloSeccion("Datos personales")
        CampoTexto("Matrícula *", matricula, { matricula = it.uppercase() }, ayuda = "Inicia con A y hasta 9 números. Ej. A0375.")
        CampoTexto("Nombre completo *", nombre, { nombre = it })
        CampoTexto("Correo institucional *", correo, { correo = it }, teclado = KeyboardType.Email, ayuda = "Con este correo el estudiante activará su cuenta.")
        CampoTexto("Generación de ingreso *", generacion, { generacion = it.filter(Char::isDigit).take(4) }, teclado = KeyboardType.Number)
        CampoLista("Programa *", Repo.programas, programa, { programa = it })
        TituloSeccion("Seguimiento")
        CampoLista("Frecuencia de sesión *", Repo.frecuencias, frecuencia, { frecuencia = it })
        CampoLista("Estatus *", listOf("Activo", "En pausa"), estatus, { estatus = it })
        CampoLista("Persona de acompañamiento", listOf(Repo.coordinador.nombre), Repo.coordinador.nombre, {})
        TituloSeccion("Proyecto")
        CampoLista("Proyecto (opcional)", listOf(sinProyecto) + Repo.proyectosActivos().map { it.nombre }, proyecto, { proyecto = it })
        CampoLista("Rol en el proyecto", Repo.rolesProyecto, rol, { rol = it })
        Text("El coordinador queda asignado automáticamente como persona de acompañamiento.", style = MaterialTheme.typography.bodySmall, color = Ciis.Suave)
        BotonPrimario("Registrar estudiante") {
            val m = matricula.trim()
            val p = Repo.proyectosActivos().firstOrNull { it.nombre == proyecto }
            aviso = when {
                m.isEmpty() || nombre.isBlank() || correo.isBlank() || generacion.isEmpty() || programa.isEmpty() || frecuencia.isEmpty() -> faltan
                !Regex("^A[0-9]{1,9}$").matches(m) -> Aviso("Matrícula no válida", "La matrícula debe iniciar con A y tener hasta 9 números. Ej. A0375.")
                Repo.estudiante(m) != null -> Aviso("Matrícula ya registrada", "Ya existe un estudiante con la matrícula $m.")
                !android.util.Patterns.EMAIL_ADDRESS.matcher(correo.trim()).matches() -> Aviso("Correo no válido", "Escribe un correo válido, por ejemplo nombre@upaep.mx.")
                Repo.correoEnUso(correo) -> Aviso("Correo ya registrado", "Ese correo ya pertenece a otra persona.")
                p != null && rol.isEmpty() -> Aviso("Falta el rol", "Elige el rol del estudiante en el proyecto.")
                else -> {
                    Repo.registrarEstudiante(
                        Estudiante(m, nombre.trim(), correo.trim(), programa, generacion.toInt(), frecuencia, estatus, p?.id, if (p != null) rol else ""),
                    )
                    onExito(); null
                }
            }
        }
    }
}

/* ---------- AltaAliado/claro ---------- */
@Composable
fun AltaAliadoScreen(onVolver: () -> Unit, onExito: () -> Unit) {
    var nombre by rememberSaveable { mutableStateOf("") }
    var tipo by rememberSaveable { mutableStateOf("") }
    var correo by rememberSaveable { mutableStateOf("") }
    var proyecto by rememberSaveable { mutableStateOf("") }
    var aviso by remember { mutableStateOf<Aviso?>(null) }
    val ninguno = "Ninguno por ahora"
    Formulario("Alta de aliado", "Registra una organización que apoya proyectos.", onVolver, aviso, { aviso = null }) {
        CampoTexto("Nombre del aliado *", nombre, { nombre = it })
        CampoLista("Tipo de aliado *", Repo.tiposAliado, tipo, { tipo = it })
        CampoTexto("Correo de contacto *", correo, { correo = it }, teclado = KeyboardType.Email, ayuda = "Con este correo el aliado activará su cuenta.")
        CampoLista("Proyecto que apoyará (opcional)", listOf(ninguno) + Repo.proyectosActivos().map { it.nombre }, proyecto, { proyecto = it })
        Text("El aliado podrá sumar más proyectos desde su cuenta (máximo ${Limites.PROYECTOS_POR_ALIADO}).", style = MaterialTheme.typography.bodySmall, color = Ciis.Suave)
        BotonPrimario("Registrar aliado") {
            aviso = when {
                nombre.isBlank() || tipo.isEmpty() || correo.isBlank() -> faltan
                Repo.aliados.any { it.nombre.equals(nombre.trim(), true) } -> Aviso("Aliado ya registrado", "${nombre.trim()} ya existe en el sistema.")
                !android.util.Patterns.EMAIL_ADDRESS.matcher(correo.trim()).matches() -> Aviso("Correo no válido", "Escribe un correo válido.")
                Repo.correoEnUso(correo) -> Aviso("Correo ya registrado", "Ese correo ya pertenece a otra persona.")
                else -> {
                    Repo.agregarAliado(nombre.trim(), tipo, correo.trim(), Repo.proyectosActivos().firstOrNull { it.nombre == proyecto }?.id)
                    onExito(); null
                }
            }
        }
    }
}

/* ---------- AltaMentor/claro ---------- */
@Composable
fun AltaMentorScreen(onVolver: () -> Unit, onExito: () -> Unit) {
    var nombre by rememberSaveable { mutableStateOf("") }
    var tema by rememberSaveable { mutableStateOf("") }
    var temaNuevo by rememberSaveable { mutableStateOf("") }
    var correo by rememberSaveable { mutableStateOf("") }
    var aviso by remember { mutableStateOf<Aviso?>(null) }
    val temas = Repo.mentores.map { it.tema }.distinct()
    Formulario("Alta de mentor", "Registra a un mentor y su tema.", onVolver, aviso, { aviso = null }) {
        CampoTexto("Nombre del mentor(a) *", nombre, { nombre = it })
        CampoLista("Tema de mentoría *", temas, tema, { tema = it; temaNuevo = "" })
        CampoTexto("…o escribe un tema nuevo", temaNuevo, { temaNuevo = it; if (it.isNotEmpty()) tema = "" })
        CampoTexto("Correo del mentor", correo, { correo = it }, teclado = KeyboardType.Email, ayuda = "Se usa para invitarlo en Calendar.")
        Text("Después asígnalo a estudiantes desde «Asignar mentoría».", style = MaterialTheme.typography.bodySmall, color = Ciis.Suave)
        BotonPrimario("Registrar mentor") {
            val t = temaNuevo.trim().ifEmpty { tema }
            aviso = when {
                nombre.isBlank() || t.isEmpty() -> faltan
                Repo.mentores.any { it.nombre.equals(nombre.trim(), true) } -> Aviso("Mentor ya registrado", "Ya existe un mentor con ese nombre.")
                temaNuevo.isNotBlank() && temas.any { it.equals(temaNuevo.trim(), true) } -> Aviso("El tema ya existe", "«${temaNuevo.trim()}» ya está en la lista; selecciónalo en lugar de escribirlo.")
                else -> { Repo.mentores.add(Mentor(nombre.trim(), t, correo.trim())); onExito(); null }
            }
        }
    }
}

/* ---------- AsignarMentoria/claro ---------- */
@Composable
fun AsignarMentoriaScreen(onVolver: () -> Unit, onExito: () -> Unit) {
    var estudiante by rememberSaveable { mutableStateOf("") }
    var mentor by rememberSaveable { mutableStateOf("") }
    var hora by rememberSaveable { mutableStateOf("") }
    var fecha by remember { mutableStateOf<LocalDate?>(null) }
    var aviso by remember { mutableStateOf<Aviso?>(null) }
    val etiquetas = Repo.estudiantes.filter { it.estatus == "Activo" }.associateBy { "${it.matricula} — ${it.nombre}" }
    Formulario("Asignar mentoría", "Elige qué mentor se hará cargo del estudiante.", onVolver, aviso, { aviso = null }) {
        CampoLista("Estudiante *", etiquetas.keys.toList(), estudiante, { estudiante = it })
        CampoLista("Mentor *", Repo.mentores.map { "${it.nombre} · ${it.tema}" }, mentor, { mentor = it })
        CampoLista("Hora *", Repo.horas, hora, { hora = it })
        CampoFecha("Fecha *", fecha, { fecha = it })
        Text("Al guardar podrás agregarla a Calendar con el correo del mentor.", style = MaterialTheme.typography.bodySmall, color = Ciis.Suave)
        BotonPrimario("Asignar mentoría") {
            val e = etiquetas[estudiante]
            val m = Repo.mentores.firstOrNull { "${it.nombre} · ${it.tema}" == mentor }
            val f = fecha
            aviso = when {
                e == null || m == null || f == null || hora.isEmpty() -> faltan
                e.proyectoId == null -> Aviso("Estudiante sin proyecto", "Solo se pueden asignar mentorías a estudiantes con un proyecto.")
                f.isBefore(Repo.hoy) -> Aviso("Fecha no válida", "La fecha de la mentoría no puede ser anterior a hoy.")
                Repo.mentorOcupado(m.nombre, f, hora) -> Aviso("Mentor no disponible", "${m.nombre} ya tiene una mentoría el ${fechaLarga(f)} a las $hora.")
                else -> { Repo.agendar(f, hora, e.matricula, m); onExito(); null }
            }
        }
    }
}

/* ---------- AltaProyecto/claro ---------- */
@Composable
fun AltaProyectoScreen(onVolver: () -> Unit, onExito: () -> Unit) {
    var nombre by rememberSaveable { mutableStateOf("") }
    var descripcion by rememberSaveable { mutableStateOf("") }
    var ods by rememberSaveable { mutableStateOf("") }
    var saps by rememberSaveable { mutableStateOf("") }
    var comunidad by rememberSaveable { mutableStateOf("") }
    var municipio by rememberSaveable { mutableStateOf("") }
    var beneficiarios by rememberSaveable { mutableStateOf("") }
    var inicio by remember { mutableStateOf<LocalDate?>(null) }
    var fin by remember { mutableStateOf<LocalDate?>(null) }
    var elegido by rememberSaveable { mutableStateOf("") }
    val integrantes = remember { mutableStateListOf<Estudiante>() }
    var aviso by remember { mutableStateOf<Aviso?>(null) }
    // Se listan todos los estudiantes activos; si uno ya tiene proyecto, se avisa al agregarlo (como en ciis-web).
    val candidatos = Repo.estudiantes.filter { it.estatus == "Activo" && it !in integrantes }
        .associateBy { e -> "${e.matricula} — ${e.nombre}" + (Repo.proyecto(e.proyectoId)?.let { " · ${it.nombre}" } ?: "") }

    Formulario("Alta de proyecto", "Crea un proyecto y asigna a los estudiantes.", onVolver, aviso, { aviso = null }) {
        TituloSeccion("Datos del proyecto")
        CampoTexto("Nombre del proyecto *", nombre, { nombre = it.take(50) })
        CampoTexto("Descripción breve *", descripcion, { descripcion = it.take(50) }, ayuda = "Máximo 50 caracteres.")
        CampoLista("ODS *", Repo.ods, ods, { ods = it })
        CampoLista("Clasificación SAPS *", Repo.clasificacionesSaps, saps, { saps = it })
        TituloSeccion("Implementación")
        CampoTexto("Comunidad *", comunidad, { comunidad = it })
        CampoTexto("Municipio *", municipio, { municipio = it })
        CampoTexto("Beneficiarios esperados *", beneficiarios, { beneficiarios = it.filter(Char::isDigit) }, teclado = KeyboardType.Number)
        CampoFecha("Fecha de inicio *", inicio, { inicio = it })
        CampoFecha("Fecha de fin (opcional)", fin, { fin = it })
        TituloSeccion("Integrantes")
        CampoLista("Estudiante", candidatos.keys.toList(), elegido, { elegido = it }, marcador = if (candidatos.isEmpty()) "No hay estudiantes activos" else "Elige…")
        BotonSecundario("Agregar integrante") {
            val e = candidatos[elegido]
            val otro = Repo.proyecto(e?.proyectoId)
            when {
                e == null -> aviso = Aviso("Elige un estudiante", "Selecciona al estudiante que quieres agregar.")
                otro != null -> aviso = Aviso("El estudiante ya tiene proyecto", "${e.nombre} ya participa en «${otro.nombre}».")
                else -> { integrantes.add(e); elegido = "" }
            }
        }
        integrantes.forEachIndexed { i, e ->
            ItemLista(
                e.nombre, if (i == 0) "Líder de equipo · ${e.matricula}" else "Integrante · ${e.matricula}", Icons.Filled.School,
                derecha = { IconButton(onClick = { integrantes.remove(e) }) { Icon(Icons.Filled.Close, "Quitar", tint = Ciis.Suave) } },
            )
        }
        Text("Cada estudiante solo puede estar en un proyecto. El primero será el líder del equipo.", style = MaterialTheme.typography.bodySmall, color = Ciis.Suave)
        BotonPrimario("Registrar proyecto") {
            val i = inicio
            val f = fin
            aviso = when {
                nombre.isBlank() || descripcion.isBlank() || ods.isEmpty() || saps.isEmpty() || comunidad.isBlank() ||
                    municipio.isBlank() || beneficiarios.isEmpty() || i == null -> faltan
                Repo.proyectos.any { it.nombre.equals(nombre.trim(), true) } -> Aviso("Proyecto ya registrado", "Ya existe un proyecto con ese nombre en el sistema.")
                f != null && !f.isAfter(i) -> Aviso("Fechas no válidas", "La fecha de fin debe ser posterior a la fecha de inicio.")
                integrantes.isEmpty() -> Aviso("Faltan integrantes", "Agrega al menos un estudiante al proyecto.")
                else -> {
                    Repo.agregarProyecto(
                        nombre.trim(), descripcion.trim(), ods, saps, comunidad.trim(), municipio.trim(),
                        beneficiarios.toIntOrNull() ?: 0, i, f, integrantes.map { it.matricula },
                    )
                    onExito(); null
                }
            }
        }
    }
}

/* ---------- CoordReportes/claro ---------- */
@Composable
fun ReportesScreen(onVolver: () -> Unit, onDescargado: (String) -> Unit) {
    val context = LocalContext.current
    val periodos = listOf("Este mes", "Últimos 3 meses", "Últimos 6 meses", "Este año")
    var periodo by rememberSaveable { mutableStateOf("Últimos 6 meses") }
    var proyecto by rememberSaveable { mutableStateOf("Todos") }
    var aviso by remember { mutableStateOf<Aviso?>(null) }
    val es = Locale("es", "MX")

    val desde = when (periodo) {
        "Este mes" -> Repo.hoy.withDayOfMonth(1)
        "Últimos 3 meses" -> Repo.hoy.minusMonths(3)
        "Últimos 6 meses" -> Repo.hoy.minusMonths(6)
        else -> Repo.hoy.withDayOfYear(1)
    }
    val lista = Repo.proyectosActivos().filter { proyecto == "Todos" || it.nombre == proyecto }
    val alumnos = Repo.estudiantes.filter { e -> lista.any { it.id == e.proyectoId } }
    val promedio = if (lista.isEmpty()) 0 else lista.sumOf { it.avance } / lista.size
    val meses = (4 downTo 0).map { Repo.hoy.withDayOfMonth(1).minusMonths(it.toLong()) }
    val porMes = meses.map { m ->
        m to Repo.mentorias.count { !it.cancelada && !it.fecha.isBefore(m) && it.fecha.isBefore(m.plusMonths(1)) &&
            alumnos.any { a -> a.matricula == it.matricula } }
    }
    val mentoriasPeriodo = Repo.mentorias.count { !it.cancelada && !it.fecha.isBefore(desde) && alumnos.any { a -> a.matricula == it.matricula } }

    Column(Modifier.fillMaxSize().background(Ciis.Fondo)) {
        Contenido {
            Encabezado("Reportes", "Progreso de los estudiantes en sus proyectos.", volver = "General", onVolver = onVolver)
            Tarjeta {
                CampoLista("Periodo", periodos, periodo, { periodo = it })
                CampoLista("Proyecto", listOf("Todos") + Repo.proyectosActivos().map { it.nombre }, proyecto, { proyecto = it })
                Row(horizontalArrangement = Arrangement.spacedBy(12.dp)) {
                    TarjetaDato("$promedio%", "Avance promedio", Modifier.weight(1f), Ciis.Rojo)
                    TarjetaDato(mentoriasPeriodo.toString(), "Mentorías en el periodo", Modifier.weight(1f))
                }
            }
            Tarjeta {
                TituloSeccion("Avance por proyecto")
                lista.forEach { p ->
                    Row { Text(p.nombre, Modifier.weight(1f), fontSize = 14.sp); Text("${p.avance}%", fontWeight = FontWeight.Bold, fontSize = 14.sp) }
                    BarraAvance(p.avance, color = p.color)
                }
            }
            Tarjeta {
                TituloSeccion("Estatus de estudiantes")
                val grupos = listOf(
                    Triple("Activos", Repo.estudiantes.count { it.estatus == "Activo" }, Ciis.Verde),
                    Triple("En pausa", Repo.estudiantes.count { it.estatus == "En pausa" }, Ciis.Ambar),
                    Triple("Baja", Repo.estudiantes.count { it.estatus == "Baja" }, Ciis.Rojo),
                )
                val total = grupos.sumOf { it.second }.coerceAtLeast(1)
                Row(Modifier.fillMaxWidth().height(18.dp).clip(RoundedCornerShape(9.dp))) {
                    grupos.filter { it.second > 0 }.forEach { (_, n, c) -> Box(Modifier.weight(n.toFloat() / total).fillMaxHeight().background(c)) }
                }
                grupos.forEach { (t, n, c) -> Leyenda("$t ($n)", c) }
            }
            Tarjeta {
                TituloSeccion("Mentorías por mes")
                val max = porMes.maxOf { it.second }.coerceAtLeast(1)
                Row(Modifier.fillMaxWidth().height(150.dp), horizontalArrangement = Arrangement.SpaceEvenly, verticalAlignment = Alignment.Bottom) {
                    porMes.forEach { (m, n) ->
                        Column(horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.Bottom, modifier = Modifier.fillMaxHeight()) {
                            Text(n.toString(), fontWeight = FontWeight.Bold, fontSize = 13.sp)
                            Box(
                                Modifier.width(30.dp).fillMaxHeight(0.75f * n / max + 0.02f)
                                    .clip(RoundedCornerShape(topStart = 6.dp, topEnd = 6.dp)).background(Ciis.Rojo),
                            )
                            Text(m.month.getDisplayName(TextStyle.SHORT, es).replace(".", "").replaceFirstChar { it.uppercase() }, fontSize = 12.sp, color = Ciis.Suave)
                        }
                    }
                }
            }
            Tarjeta {
                TituloSeccion("Progreso por estudiante")
                if (alumnos.isEmpty()) Text("Sin estudiantes en este filtro.", color = Ciis.Suave)
                alumnos.forEach { e -> FilaDato(e.nombre, "${Repo.proyecto(e.proyectoId)?.avance ?: 0}%") }
            }
            BotonPrimario("Descargar reporte (Excel)", icono = Icons.Filled.Download) {
                val evidenciasPeriodo = lista.sumOf { p -> p.evidencias.count { !it.fecha.isBefore(desde) } }
                if (lista.isEmpty() || alumnos.isEmpty() || (mentoriasPeriodo == 0 && evidenciasPeriodo == 0)) {
                    aviso = Aviso("Sin datos para el periodo", "No hay avances registrados en el periodo elegido.")
                } else {
                    val mes = Repo.hoy.month.getDisplayName(TextStyle.SHORT, es).replace(".", "").lowercase()
                    val filas = buildList {
                        add(listOf("Reporte de progreso CIIS", "Periodo: $periodo", "Generado: ${fechaLarga(Repo.hoy)}"))
                        add(emptyList())
                        add(listOf("Proyecto", "ODS", "Estatus", "Avance %", "Objetivos cumplidos", "Objetivos totales"))
                        lista.forEach { add(listOf(it.nombre, it.ods, it.estatus.texto, it.avance.toString(), it.hechos.toString(), it.objetivos.size.toString())) }
                        add(emptyList())
                        add(listOf("Matrícula", "Estudiante", "Proyecto", "Rol", "Estatus", "Avance %"))
                        alumnos.forEach { e ->
                            val p = Repo.proyecto(e.proyectoId)
                            add(listOf(e.matricula, e.nombre, p?.nombre ?: "", e.rol, e.estatus, (p?.avance ?: 0).toString()))
                        }
                        add(emptyList())
                        add(listOf("Mes", "Mentorías"))
                        porMes.forEach { (m, n) -> add(listOf(m.month.getDisplayName(TextStyle.FULL, es) + " " + m.year, n.toString())) }
                    }
                    val archivo = guardarReporteCsv(context, "reporte_progreso_$mes${Repo.hoy.year}.csv", filas)
                    if (archivo != null) onDescargado(archivo)
                    else aviso = Aviso("No se pudo guardar", "Ocurrió un problema al guardar el archivo. Inténtalo de nuevo.")
                }
            }
            Text("El archivo incluye las mismas tablas del reporte y se abre en Excel.", style = MaterialTheme.typography.bodySmall, color = Ciis.Suave)

            // Los mismos reportes del sitio web; cada uno se descarga como CSV (Excel)
            Tarjeta {
                TituloSeccion("Más reportes (CSV / Excel)")
                Text("Los mismos reportes del sitio web. Toca uno para descargarlo.", style = MaterialTheme.typography.bodySmall, color = Ciis.Suave)
                Reportes.lista.forEach { r ->
                    val filas = r.filas()
                    ItemLista(
                        r.titulo, "${r.descripcion} · ${filas.size - 1} filas", Icons.Filled.Download, Ciis.Ambar,
                        onClick = {
                            if (filas.size <= 1) {
                                aviso = Aviso("Sin datos", "Este reporte no tiene información para mostrar.")
                            } else {
                                val archivo = guardarReporteCsv(context, r.archivo(), filas)
                                if (archivo != null) onDescargado(archivo)
                                else aviso = Aviso("No se pudo guardar", "Ocurrió un problema al guardar el archivo. Inténtalo de nuevo.")
                            }
                        },
                    )
                }
            }
        }
    }
    AvisoDialogo(aviso) { aviso = null }
}

@Composable
private fun Leyenda(texto: String, color: Color) {
    Row(verticalAlignment = Alignment.CenterVertically) {
        Box(Modifier.size(10.dp).clip(CircleShape).background(color))
        Spacer(Modifier.width(8.dp))
        Text(texto, fontSize = 14.sp)
    }
}
