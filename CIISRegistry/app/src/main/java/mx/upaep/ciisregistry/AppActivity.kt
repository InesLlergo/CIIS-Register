package mx.upaep.ciisregistry

import android.content.Intent
import android.os.Bundle
import android.widget.Toast
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.EventAvailable
import androidx.compose.material.icons.filled.EventBusy
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.material.icons.filled.TaskAlt
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.navigation.NavHostController
import androidx.navigation.NavType
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import androidx.navigation.navArgument
import mx.upaep.ciisregistry.data.Repo
import mx.upaep.ciisregistry.data.Rol
import mx.upaep.ciisregistry.data.abrirEnCalendario
import mx.upaep.ciisregistry.data.compartirReporte
import mx.upaep.ciisregistry.ui.components.PantallaExito
import mx.upaep.ciisregistry.ui.screens.ActivarScreen
import mx.upaep.ciisregistry.ui.screens.AgendarAsesoriaScreen
import mx.upaep.ciisregistry.ui.screens.AliadoDetalleScreen
import mx.upaep.ciisregistry.ui.screens.AliadoHomeScreen
import mx.upaep.ciisregistry.ui.screens.AlumnoHomeScreen
import mx.upaep.ciisregistry.ui.screens.AlumnoProyectoScreen
import mx.upaep.ciisregistry.ui.screens.AltaAliadoScreen
import mx.upaep.ciisregistry.ui.screens.AltaEstudianteScreen
import mx.upaep.ciisregistry.ui.screens.AltaMentorScreen
import mx.upaep.ciisregistry.ui.screens.AltaProyectoScreen
import mx.upaep.ciisregistry.ui.screens.AsignarMentoriaScreen
import mx.upaep.ciisregistry.ui.screens.BienvenidaScreen
import mx.upaep.ciisregistry.ui.screens.CoordDetalleScreen
import mx.upaep.ciisregistry.ui.screens.CoordHomeScreen
import mx.upaep.ciisregistry.ui.screens.FotoPerfilScreen
import mx.upaep.ciisregistry.ui.screens.LoginScreen
import mx.upaep.ciisregistry.ui.screens.NavAlumno
import mx.upaep.ciisregistry.ui.screens.NavCoord
import mx.upaep.ciisregistry.ui.screens.ProyectosPublicosScreen
import mx.upaep.ciisregistry.ui.screens.RecuperarScreen
import mx.upaep.ciisregistry.ui.screens.ReportesScreen
import mx.upaep.ciisregistry.ui.screens.SubirEvidenciaScreen
import mx.upaep.ciisregistry.ui.theme.Ciis
import mx.upaep.ciisregistry.ui.theme.CiisTheme

/**
 * AppActivity
 * -----------
 * Pantallas principales de la app (bienvenida, inicio de sesión, alumno, aliado y coordinador).
 * Se abre desde MainActivity (el splash) con un Intent explícito y empieza en la bienvenida.
 *
 * Cuando el alumno toca "Registrar implementación", esta Activity abre
 * RegistrarImplementacionActivity, también con un Intent explícito.
 */
class AppActivity : ComponentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        // La sesión vive en memoria: si Android cerró la app en segundo plano, se perdió.
        // En ese caso no restauramos la pantalla anterior y empezamos desde la bienvenida.
        super.onCreate(if (Repo.rol == null) null else savedInstanceState)
        enableEdgeToEdge()
        Repo.iniciar(applicationContext) // carga lo que registró la coordinación
        setContent {
            CiisTheme {
                Box(Modifier.fillMaxSize().background(Ciis.Fondo)) {
                    CiisApp(abrirRegistroImplementacion = { abrirRegistroImplementacion() })
                }
            }
        }
    }

    override fun onStop() {
        super.onStop()
        Repo.guardar() // p. ej. objetivos marcados en proyectos nuevos
    }

    /** Intent explícito: abre la pantalla de registro de implementación (Java + XML). */
    private fun abrirRegistroImplementacion() {
        val intent = Intent(this, RegistrarImplementacionActivity::class.java)
        startActivity(intent)
    }
}

/** Rutas de la app. Cada una corresponde a una o varias pantallas del Figma. */
object Rutas {
    const val BIENVENIDA = "bienvenida"
    const val PROYECTOS = "proyectos"
    const val LOGIN = "login"
    const val RECUPERAR = "recuperar"
    const val ACTIVAR = "activar"

    const val ALUMNO = "alumno"
    const val ALUMNO_PROYECTO = "alumno/proyecto"
    const val ALUMNO_EVIDENCIA = "alumno/evidencia"
    const val ALUMNO_EVIDENCIA_OK = "alumno/evidencia/ok"
    const val ALUMNO_FOTO = "alumno/foto"
    const val ALUMNO_AGENDAR = "alumno/agendar"
    const val ALUMNO_AGENDADA = "alumno/agendada"
    const val ALUMNO_CANCELADA = "alumno/cancelada"

    const val ALIADO = "aliado"
    const val ALIADO_PROYECTO = "aliado/proyecto/{id}"
    const val ALIADO_OK = "aliado/ok"

    const val COORD = "coord"
    const val COORD_PROYECTO = "coord/proyecto/{id}"
    const val COORD_ALTA = "coord/alta/{tipo}"
    const val COORD_OK = "coord/ok/{tipo}"
    const val COORD_REPORTES = "coord/reportes"
    const val COORD_REPORTE_OK = "coord/reporte/{archivo}"
}

private fun NavHostController.irInicioDeRol(rol: Rol) {
    val destino = when (rol) {
        Rol.ALUMNO -> Rutas.ALUMNO
        Rol.ALIADO -> Rutas.ALIADO
        Rol.COORDINADOR -> Rutas.COORD
    }
    navigate(destino) { popUpTo(Rutas.BIENVENIDA) { inclusive = false } }
}

private fun NavHostController.salir() {
    Repo.cerrarSesion()
    navigate(Rutas.BIENVENIDA) { popUpTo(graph.id) { inclusive = true } }
}

/**
 * Navegación de toda la parte hecha en Compose.
 * @param abrirRegistroImplementacion la pone MainActivity; abre RegistrarImplementacionActivity.
 */
@Composable
fun CiisApp(abrirRegistroImplementacion: () -> Unit = {}) {
    val nav = rememberNavController()
    val context = LocalContext.current

    NavHost(navController = nav, startDestination = Rutas.BIENVENIDA) {
        /* ---------- públicas ---------- */
        composable(Rutas.BIENVENIDA) {
            BienvenidaScreen(onIniciar = { nav.navigate(Rutas.LOGIN) }, onVerProyectos = { nav.navigate(Rutas.PROYECTOS) })
        }
        composable(Rutas.PROYECTOS) { ProyectosPublicosScreen(onVolver = { nav.popBackStack() }) }
        composable(Rutas.LOGIN) {
            LoginScreen(
                onEntrar = { rol -> nav.irInicioDeRol(rol) },
                onOlvide = { nav.navigate(Rutas.RECUPERAR) },
                onActivar = { nav.navigate(Rutas.ACTIVAR) },
                onVolver = { nav.popBackStack() },
            )
        }
        composable(Rutas.RECUPERAR) { RecuperarScreen(onVolver = { nav.popBackStack() }) }
        composable(Rutas.ACTIVAR) { ActivarScreen(onVolver = { nav.popBackStack() }) }

        /* ---------- alumno ---------- */
        composable(Rutas.ALUMNO) {
            AlumnoHomeScreen(
                NavAlumno(
                    salir = { nav.salir() },
                    miProyecto = { nav.navigate(Rutas.ALUMNO_PROYECTO) },
                    subirEvidencia = { nav.navigate(Rutas.ALUMNO_EVIDENCIA) },
                    fotoPerfil = { nav.navigate(Rutas.ALUMNO_FOTO) },
                    agendar = { nav.navigate(Rutas.ALUMNO_AGENDAR) },
                    asesoriaCancelada = { nav.navigate(Rutas.ALUMNO_CANCELADA) },
                    registrarImplementacion = abrirRegistroImplementacion,
                ),
            )
        }
        composable(Rutas.ALUMNO_PROYECTO) {
            AlumnoProyectoScreen(onVolver = { nav.popBackStack() }, onSubir = { nav.navigate(Rutas.ALUMNO_EVIDENCIA) })
        }
        composable(Rutas.ALUMNO_EVIDENCIA) {
            SubirEvidenciaScreen(
                onVolver = { nav.popBackStack() },
                onEnviada = { nav.navigate(Rutas.ALUMNO_EVIDENCIA_OK) { popUpTo(Rutas.ALUMNO_EVIDENCIA) { inclusive = true } } },
            )
        }
        composable(Rutas.ALUMNO_EVIDENCIA_OK) {
            PantallaExito(
                "¡Evidencia enviada!", "Tu maestro(a) podrá verla en tu proyecto.",
                primario = "Ver mi proyecto",
                onPrimario = { nav.navigate(Rutas.ALUMNO_PROYECTO) { popUpTo(Rutas.ALUMNO) } },
                secundario = "Volver a mi página",
                onSecundario = { nav.popBackStack(Rutas.ALUMNO, inclusive = false) },
                icono = Icons.Filled.TaskAlt,
            )
        }
        composable(Rutas.ALUMNO_FOTO) { FotoPerfilScreen(onVolver = { nav.popBackStack() }) }
        composable(Rutas.ALUMNO_AGENDAR) {
            AgendarAsesoriaScreen(
                onVolver = { nav.popBackStack() },
                onAgendada = { nav.navigate(Rutas.ALUMNO_AGENDADA) { popUpTo(Rutas.ALUMNO_AGENDAR) { inclusive = true } } },
            )
        }
        composable(Rutas.ALUMNO_AGENDADA) {
            PantallaExito(
                "¡Asesoría agendada!", "Tu mentor recibirá la invitación. La verás en tu pestaña Mentorías.",
                primario = "Volver a mis mentorías",
                onPrimario = { nav.popBackStack(Rutas.ALUMNO, inclusive = false) },
                secundario = "Agregar a Calendar",
                onSecundario = {
                    val m = Repo.ultimaMentoria
                    if (m == null || !abrirEnCalendario(context, m)) Toast.makeText(context, "No hay app de calendario", Toast.LENGTH_SHORT).show()
                },
                icono = Icons.Filled.EventAvailable,
            )
        }
        composable(Rutas.ALUMNO_CANCELADA) {
            PantallaExito(
                "Asesoría cancelada", "Se avisó al mentor. Puedes agendar otra cuando quieras.",
                primario = "Volver a mis mentorías",
                onPrimario = { nav.popBackStack(Rutas.ALUMNO, inclusive = false) },
                secundario = "Agendar otra asesoría",
                onSecundario = { nav.navigate(Rutas.ALUMNO_AGENDAR) { popUpTo(Rutas.ALUMNO) } },
                icono = Icons.Filled.EventBusy,
            )
        }

        /* ---------- aliado ---------- */
        composable(Rutas.ALIADO) {
            AliadoHomeScreen(
                onSalir = { nav.salir() },
                onProyecto = { id -> nav.navigate("aliado/proyecto/$id") },
                onApoyoConfirmado = { nav.navigate(Rutas.ALIADO_OK) },
            )
        }
        composable(Rutas.ALIADO_PROYECTO, arguments = listOf(navArgument("id") { type = NavType.IntType })) { e ->
            AliadoDetalleScreen(e.arguments?.getInt("id") ?: 0, onVolver = { nav.popBackStack() })
        }
        composable(Rutas.ALIADO_OK) {
            PantallaExito(
                "¡Gracias por tu apoyo!", "El proyecto se agregó a tu lista de proyectos que apoyas.",
                primario = "Volver a mi página",
                onPrimario = { nav.popBackStack(Rutas.ALIADO, inclusive = false) },
                icono = Icons.Filled.Favorite,
            )
        }

        /* ---------- coordinador ---------- */
        composable(Rutas.COORD) {
            CoordHomeScreen(
                NavCoord(
                    salir = { nav.salir() },
                    proyecto = { id -> nav.navigate("coord/proyecto/$id") },
                    alta = { tipo -> nav.navigate("coord/alta/$tipo") },
                    reportes = { nav.navigate(Rutas.COORD_REPORTES) },
                ),
            )
        }
        composable(Rutas.COORD_PROYECTO, arguments = listOf(navArgument("id") { type = NavType.IntType })) { e ->
            CoordDetalleScreen(e.arguments?.getInt("id") ?: 0, onVolver = { nav.popBackStack() })
        }
        composable(Rutas.COORD_ALTA) { e ->
            val tipo = e.arguments?.getString("tipo") ?: "estudiante"
            val volver: () -> Unit = { nav.popBackStack() }
            val exito: () -> Unit = { nav.navigate("coord/ok/$tipo") { popUpTo(Rutas.COORD) } }
            when (tipo) {
                "aliado" -> AltaAliadoScreen(volver, exito)
                "mentor" -> AltaMentorScreen(volver, exito)
                "proyecto" -> AltaProyectoScreen(volver, exito)
                "mentoria" -> AsignarMentoriaScreen(volver, exito)
                else -> AltaEstudianteScreen(volver, exito)
            }
        }
        composable(Rutas.COORD_OK) { e ->
            val tipo = e.arguments?.getString("tipo") ?: ""
            val esMentoria = tipo == "mentoria"
            val mensaje = when (tipo) {
                "estudiante", "aliado" -> "Ya puede activar su cuenta en Iniciar sesión → «¿Primera vez? Activa tu cuenta», con el correo registrado."
                else -> "Los datos se guardaron correctamente."
            }
            PantallaExito(
                "¡Registro exitoso!", mensaje,
                primario = if (esMentoria) "Agregar a Calendar" else "Registrar otro",
                onPrimario = {
                    if (esMentoria) {
                        val m = Repo.ultimaMentoria
                        if (m == null || !abrirEnCalendario(context, m)) Toast.makeText(context, "No hay app de calendario", Toast.LENGTH_SHORT).show()
                    } else nav.navigate("coord/alta/$tipo") { popUpTo(Rutas.COORD) }
                },
                secundario = "Ir al inicio",
                onSecundario = { nav.popBackStack(Rutas.COORD, inclusive = false) },
            )
        }
        composable(Rutas.COORD_REPORTES) {
            ReportesScreen(
                onVolver = { nav.popBackStack() },
                onDescargado = { archivo -> nav.navigate("coord/reporte/$archivo") },
            )
        }
        composable(Rutas.COORD_REPORTE_OK) { e ->
            val archivo = e.arguments?.getString("archivo") ?: "reporte.csv"
            PantallaExito(
                "Reporte listo", "$archivo se guardó en la carpeta Descargas de tu teléfono. Ábrelo con Excel o compártelo.",
                primario = "Compartir archivo",
                onPrimario = {
                    // Intent implícito ACTION_SEND: correo, WhatsApp, Drive…
                    if (!compartirReporte(context)) Toast.makeText(context, "Búscalo en la carpeta Descargas", Toast.LENGTH_LONG).show()
                },
                secundario = "Volver a reportes",
                onSecundario = { nav.popBackStack() },
            )
        }
    }
}
