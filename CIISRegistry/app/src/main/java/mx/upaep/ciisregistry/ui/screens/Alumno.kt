package mx.upaep.ciisregistry.ui.screens

import android.graphics.Bitmap
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.AddAPhoto
import androidx.compose.material.icons.filled.CameraAlt
import androidx.compose.material.icons.filled.Event
import androidx.compose.material.icons.filled.EventBusy
import androidx.compose.material.icons.filled.Handshake
import androidx.compose.material.icons.filled.Person
import androidx.compose.material.icons.filled.PhotoLibrary
import androidx.compose.material.icons.filled.SupervisorAccount
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.asImageBitmap
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import mx.upaep.ciisregistry.data.Estatus
import mx.upaep.ciisregistry.data.Evidencia
import mx.upaep.ciisregistry.data.Mentoria
import mx.upaep.ciisregistry.data.Objetivo
import mx.upaep.ciisregistry.data.Repo
import mx.upaep.ciisregistry.data.fechaLarga
import mx.upaep.ciisregistry.ui.components.Aviso
import mx.upaep.ciisregistry.ui.components.AvisoDialogo
import mx.upaep.ciisregistry.ui.components.BarraSesion
import mx.upaep.ciisregistry.ui.components.BotonPrimario
import mx.upaep.ciisregistry.ui.components.BotonSecundario
import mx.upaep.ciisregistry.ui.components.CampoFecha
import mx.upaep.ciisregistry.ui.components.CampoLista
import mx.upaep.ciisregistry.ui.components.CampoTexto
import mx.upaep.ciisregistry.ui.components.ChipEstatus
import mx.upaep.ciisregistry.ui.components.ConfirmarDialogo
import mx.upaep.ciisregistry.ui.components.Contenido
import mx.upaep.ciisregistry.ui.components.Encabezado
import mx.upaep.ciisregistry.ui.components.FilaDato
import mx.upaep.ciisregistry.ui.components.FotoRedonda
import mx.upaep.ciisregistry.ui.components.ItemLista
import mx.upaep.ciisregistry.ui.components.Pestanas
import mx.upaep.ciisregistry.ui.components.Tarjeta
import mx.upaep.ciisregistry.ui.components.TarjetaProyecto
import mx.upaep.ciisregistry.ui.components.TituloSeccion
import mx.upaep.ciisregistry.ui.components.rememberSelectorFoto
import mx.upaep.ciisregistry.ui.theme.Ciis

/** Acciones de navegación que usan las pantallas del alumno. */
class NavAlumno(
    val salir: () -> Unit,
    val miProyecto: () -> Unit,
    val subirEvidencia: () -> Unit,
    val fotoPerfil: () -> Unit,
    val agendar: () -> Unit,
    val asesoriaCancelada: () -> Unit,
    /** Abre RegistrarImplementacionActivity (la pasa MainActivity). */
    val registrarImplementacion: () -> Unit = {},
)

private fun iniciales(nombre: String) = nombre.split(" ").filter { it.isNotBlank() }.take(2).joinToString("") { it.take(1) }

/* ---------- SesiónAlumno / AlumnoProgreso / AlumnoMentorias ---------- */
@Composable
fun AlumnoHomeScreen(nav: NavAlumno) {
    var tab by rememberSaveable { mutableStateOf(0) }
    Column(Modifier.fillMaxSize().background(Ciis.Fondo)) {
        BarraSesion("alumno", nav.salir)
        Pestanas(listOf("General", "Progreso", "Mentorías"), tab) { tab = it }
        when (tab) {
            0 -> AlumnoGeneral(nav) { tab = 1 }
            1 -> AlumnoProgreso(nav)
            else -> AlumnoMentorias(nav)
        }
    }
}

@Composable
private fun AlumnoGeneral(nav: NavAlumno, verProgreso: () -> Unit) {
    val e = Repo.alumno
    val p = Repo.proyecto(e.proyectoId)
    Contenido {
        Tarjeta {
            Row(verticalAlignment = Alignment.CenterVertically) {
                Box(Modifier.clickable(onClick = nav.fotoPerfil)) {
                    FotoRedonda(e.foto, iniciales(e.nombre))
                    Box(
                        Modifier.align(Alignment.BottomEnd).size(26.dp).clip(RoundedCornerShape(13.dp)).background(Ciis.Rojo),
                        contentAlignment = Alignment.Center,
                    ) { Icon(Icons.Filled.CameraAlt, "Cambiar foto", tint = Ciis.Tarjeta, modifier = Modifier.size(15.dp)) }
                }
                Spacer(Modifier.width(14.dp))
                Column {
                    TituloSeccion("Mi perfil")
                    Text(e.nombre, fontWeight = FontWeight.SemiBold)
                }
            }
            FilaDato("Matrícula", e.matricula)
            FilaDato("Correo", e.correo)
            FilaDato("Programa", e.programa)
            FilaDato("Generación", e.generacion.toString())
            FilaDato("Frecuencia de sesión", e.frecuencia)
            FilaDato("Estatus", e.estatus)
            FilaDato("Rol en el proyecto", e.rol.ifBlank { "—" })
            // Opción nueva del perfil: registrar una implementación con foto de la cámara
            if (p != null) {
                Spacer(Modifier.height(4.dp))
                ItemLista(
                    "Registrar implementación",
                    "Sube lo que hizo tu equipo con foto de evidencia",
                    Icons.Filled.AddAPhoto,
                    onClick = nav.registrarImplementacion,
                )
            }
        }
        if (p != null) {
            val mias = Repo.implementacionesDe(p)
            if (mias.isNotEmpty()) Tarjeta {
                TituloSeccion("Implementaciones registradas")
                ListaImplementaciones(mias.take(3))
                if (mias.size > 3) Text("y ${mias.size - 3} más en la pestaña Progreso", style = MaterialTheme.typography.bodySmall, color = Ciis.Suave)
            }
        }
        TituloSeccion("Mi proyecto")
        if (p != null) {
            TarjetaProyecto(p, onClick = nav.miProyecto)
            Tarjeta { FilaDato("Integrantes activos", Repo.integrantes(p).count { it.estatus == "Activo" }.toString()) }
        } else Tarjeta { Text("Aún no tienes un proyecto asignado. Tu coordinador(a) te asignará uno.", color = Ciis.Suave) }
        Tarjeta {
            TituloSeccion("Persona de acompañamiento")
            ItemLista(Repo.coordinador.nombre, "${Repo.coordinador.puesto} · ${Repo.coordinador.area}", Icons.Filled.SupervisorAccount)
        }
        if (p != null) BotonPrimario("Subir evidencia", icono = Icons.Filled.CameraAlt, onClick = nav.subirEvidencia)
        BotonSecundario("Ver mi progreso", onClick = verProgreso)
    }
}

@Composable
private fun AlumnoProgreso(nav: NavAlumno) {
    val e = Repo.alumno
    val p = Repo.proyecto(e.proyectoId)
    var nuevo by remember { mutableStateOf("") }
    Contenido {
        if (p == null) {
            Tarjeta { Text("Cuando tengas proyecto, aquí verás su avance.", color = Ciis.Suave) }
            return@Contenido
        }
        Column {
            Text(p.nombre, style = MaterialTheme.typography.headlineMedium)
            Text(p.ods, color = Ciis.Suave)
        }
        TarjetaAvance(p)
        Tarjeta {
            TituloSeccion("Objetivos del equipo")
            Text("Marca los objetivos que ya cumplieron. El avance se calcula solo.", style = MaterialTheme.typography.bodySmall, color = Ciis.Suave)
            p.objetivos.forEachIndexed { i, o ->
                Box(Modifier.clip(RoundedCornerShape(10.dp)).clickable(enabled = !p.archivado) { o.cumplido = !o.cumplido }) {
                    FilaObjetivo(o, i + 1, editable = true)
                }
            }
            CampoTexto("Nuevo objetivo", nuevo, { nuevo = it })
            BotonSecundario("Agregar objetivo", icono = Icons.Filled.Add) {
                if (nuevo.isNotBlank()) { p.objetivos.add(Objetivo(nuevo.trim(), false)); nuevo = "" }
            }
        }
        TarjetaImplementacion(p)
        Tarjeta {
            TituloSeccion("Implementaciones del equipo")
            val imps = Repo.implementacionesDe(p)
            if (imps.isEmpty()) Text("Aún no registran implementaciones.", color = Ciis.Suave)
            else ListaImplementaciones(imps)
            BotonSecundario("Registrar implementación", icono = Icons.Filled.AddAPhoto, onClick = nav.registrarImplementacion)
        }
        Tarjeta {
            TituloSeccion("Equipo")
            Repo.integrantes(p).forEach { ItemLista(it.nombre, it.rol, Icons.Filled.Person) }
        }
        Tarjeta {
            TituloSeccion("Aliados que apoyan")
            val al = Repo.aliadosDe(p)
            if (al.isEmpty()) Text("Aún no hay aliados.", color = Ciis.Suave)
            al.forEach { ItemLista(it.nombre, "Tipo de aliado: ${it.tipo}", Icons.Filled.Handshake, Ciis.Azul) }
        }
        BotonSecundario("Ver mi proyecto y evidencias", onClick = nav.miProyecto)
    }
}

@Composable
private fun AlumnoMentorias(nav: NavAlumno) {
    val e = Repo.alumno
    val todas = Repo.mentoriasDe(e.matricula)
    val futuras = todas.filter { !it.fecha.isBefore(Repo.hoy) }
    val proxima = futuras.firstOrNull()
    var cancelar by remember { mutableStateOf<Mentoria?>(null) }
    Contenido {
        Tarjeta {
            TituloSeccion("Próxima mentoría")
            if (proxima != null) {
                Text(fechaLarga(proxima.fecha), style = MaterialTheme.typography.titleLarge, color = Ciis.Rojo)
                Text("${proxima.mentor} · ${proxima.tema}", fontWeight = FontWeight.SemiBold)
                Text("Hora: ${proxima.hora}", color = Ciis.Suave)
                BotonSecundario("Cancelar asesoría", icono = Icons.Filled.EventBusy) { cancelar = proxima }
            } else Text("No tienes mentorías próximas.", color = Ciis.Suave)
        }
        BotonPrimario("Agendar asesoría", icono = Icons.Filled.Event, onClick = nav.agendar)
        Text("Frecuencia de sesiones: ${e.frecuencia}", color = Ciis.Suave)
        TituloSeccion("Historial")
        val resto = todas.filter { it != proxima }.sortedByDescending { it.fecha }
        if (resto.isEmpty()) Text("Sin más mentorías.", color = Ciis.Suave)
        resto.forEach { m ->
            val pasada = m.fecha.isBefore(Repo.hoy)
            ItemLista(
                fechaLarga(m.fecha) + " · " + m.hora, "${m.mentor} · ${m.tema}", Icons.Filled.Event,
                if (pasada) Ciis.Suave else Ciis.Ambar,
                derecha = { Text(if (pasada) "Realizada" else "Agendada", style = MaterialTheme.typography.bodySmall, color = Ciis.Suave) },
                onClick = if (pasada) null else ({ cancelar = m }),
            )
        }
    }
    val c = cancelar
    if (c != null) {
        ConfirmarDialogo(
            "¿Cancelar la asesoría?",
            "${fechaLarga(c.fecha)} a las ${c.hora} con ${c.mentor}. Se avisará al mentor por correo.",
            si = "Sí, cancelar", no = "No, conservarla",
            onSi = { c.cancelada = true; cancelar = null; nav.asesoriaCancelada() },
            onNo = { cancelar = null },
        )
    }
}

/* ---------- Mi proyecto (Proyectos y evidencias) ---------- */
@Composable
fun AlumnoProyectoScreen(onVolver: () -> Unit, onSubir: () -> Unit) {
    val e = Repo.alumno
    val p = Repo.proyecto(e.proyectoId) ?: return
    Column(Modifier.fillMaxSize().background(Ciis.Fondo)) {
        Contenido {
            Encabezado("Mi proyecto", volver = "Volver", onVolver = onVolver)
            Tarjeta {
                Text(p.nombre, style = MaterialTheme.typography.titleLarge)
                Text(p.ods, color = Ciis.Suave)
                Row(horizontalArrangement = Arrangement.spacedBy(8.dp), verticalAlignment = Alignment.CenterVertically) {
                    ChipEstatus(p.estatus)
                    Text(e.rol, fontWeight = FontWeight.SemiBold)
                }
                Text("${Repo.integrantes(p).count { it.estatus == "Activo" }} integrantes activos", color = Ciis.Suave)
            }
            TarjetaAvance(p)
            Tarjeta {
                TituloSeccion("Objetivos")
                p.objetivos.forEachIndexed { i, o -> FilaObjetivo(o, i + 1, editable = false) }
            }
            Tarjeta {
                Row(verticalAlignment = Alignment.CenterVertically) {
                    TituloSeccion("Evidencias del equipo", Modifier.weight(1f))
                }
                if (p.evidencias.isEmpty()) Text("Todavía no hay evidencias. ¡Sube la primera!", color = Ciis.Suave)
                else GaleriaEvidencias(p.evidencias)
                BotonPrimario("Subir evidencia", icono = Icons.Filled.CameraAlt, enabled = p.estatus != Estatus.ARCHIVADO, onClick = onSubir)
            }
        }
    }
}

/* ---------- Subir evidencia ---------- */
@Composable
fun SubirEvidenciaScreen(onVolver: () -> Unit, onEnviada: () -> Unit) {
    val e = Repo.alumno
    val p = Repo.proyecto(e.proyectoId) ?: return
    var foto by remember { mutableStateOf<Bitmap?>(null) }
    var comentario by rememberSaveable { mutableStateOf("") }
    var aviso by remember { mutableStateOf<Aviso?>(null) }
    val selector = rememberSelectorFoto { foto = it }
    Column(Modifier.fillMaxSize().background(Ciis.Fondo)) {
        Contenido {
            Encabezado("Subir evidencia", "Proyecto: ${p.nombre}", volver = "Volver", onVolver = onVolver)
            Text("Toma o elige una foto de tu avance", fontWeight = FontWeight.SemiBold)
            Row(horizontalArrangement = Arrangement.spacedBy(10.dp)) {
                BotonSecundario("Tomar foto", Modifier.weight(1f), Icons.Filled.CameraAlt, selector.camara)
                BotonSecundario("Galería", Modifier.weight(1f), Icons.Filled.PhotoLibrary, selector.galeria)
            }
            TituloSeccion("Vista previa")
            Box(
                Modifier.fillMaxWidth().aspectRatio(4f / 3f).clip(RoundedCornerShape(16.dp)).background(Ciis.Tarjeta)
                    .border(1.dp, Ciis.Borde, RoundedCornerShape(16.dp)),
                contentAlignment = Alignment.Center,
            ) {
                val f = foto
                if (f != null) Image(f.asImageBitmap(), "Vista previa", contentScale = ContentScale.Crop, modifier = Modifier.fillMaxSize())
                else Text("Aquí aparecerá tu foto", color = Ciis.Suave)
            }
            CampoTexto("Comentario (opcional): ¿qué avanzaron hoy?", comentario, { comentario = it }, lineas = 3)
            BotonPrimario("Enviar evidencia") {
                val f = foto
                if (f == null) aviso = Aviso("Falta la foto", "Toma o elige una foto antes de enviar la evidencia.")
                else {
                    p.evidencias.add(Evidencia(f, comentario.trim(), e.nombre.split(" ").first(), Repo.hoy))
                    onEnviada()
                }
            }
            Spacer(Modifier.height(8.dp))
        }
    }
    AvisoDialogo(aviso) { aviso = null }
}

/* ---------- FotoPerfil/claro (sensor: cámara o galería) ---------- */
@Composable
fun FotoPerfilScreen(onVolver: () -> Unit) {
    val e = Repo.alumno
    var foto by remember { mutableStateOf(e.foto) }
    val selector = rememberSelectorFoto { foto = it }
    Column(Modifier.fillMaxSize().background(Ciis.Fondo)) {
        Contenido {
            Encabezado("Foto de perfil", "Toma una foto o elige una de tu galería.", volver = "Volver", onVolver = onVolver)
            Box(Modifier.fillMaxWidth(), contentAlignment = Alignment.Center) { FotoRedonda(foto, iniciales(e.nombre), 180.dp) }
            BotonSecundario("Tomar foto", icono = Icons.Filled.CameraAlt, onClick = selector.camara)
            BotonSecundario("Elegir de la galería", icono = Icons.Filled.PhotoLibrary, onClick = selector.galeria)
            BotonPrimario("Guardar foto", enabled = foto != null) { e.foto = foto; onVolver() }
        }
    }
}

/* ---------- AgendarAsesoria/claro ---------- */
@Composable
fun AgendarAsesoriaScreen(onVolver: () -> Unit, onAgendada: () -> Unit) {
    val e = Repo.alumno
    var mentor by rememberSaveable { mutableStateOf("") }
    var fecha by remember { mutableStateOf<java.time.LocalDate?>(null) }
    var hora by rememberSaveable { mutableStateOf("") }
    var nota by rememberSaveable { mutableStateOf("") }
    var aviso by remember { mutableStateOf<Aviso?>(null) }
    val m = Repo.mentores.firstOrNull { it.nombre == mentor }
    Column(Modifier.fillMaxSize().background(Ciis.Fondo)) {
        Contenido {
            Encabezado("Agendar asesoría", "Elige con qué mentor quieres tu asesoría.", volver = "Mentorías", onVolver = onVolver)
            CampoLista("Mentor *", Repo.mentores.map { it.nombre }, mentor, { mentor = it })
            CampoTexto("Tema", m?.tema ?: "", {}, ayuda = "Se llena según el mentor.")
            CampoFecha("Fecha *", fecha, { fecha = it })
            CampoLista("Hora *", Repo.horas, hora, { hora = it })
            CampoTexto("¿Qué quieres revisar? (opcional)", nota, { nota = it }, lineas = 2)
            BotonPrimario("Agendar asesoría") {
                val f = fecha
                aviso = when {
                    m == null || f == null || hora.isEmpty() -> Aviso("Faltan datos obligatorios", "Completa todos los campos antes de agendar.")
                    f.isBefore(Repo.hoy) -> Aviso("Fecha no válida", "La fecha de la mentoría no puede ser anterior a hoy.")
                    Repo.mentorOcupado(m.nombre, f, hora) -> Aviso("Mentor no disponible", "${m.nombre} ya tiene una mentoría el ${fechaLarga(f)} a las $hora. Elige otro horario.")
                    else -> { Repo.agendar(f, hora, e.matricula, m, nota); onAgendada(); null }
                }
            }
        }
    }
    AvisoDialogo(aviso) { aviso = null }
}
