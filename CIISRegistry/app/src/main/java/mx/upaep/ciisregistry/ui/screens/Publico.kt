package mx.upaep.ciisregistry.ui.screens

import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.width
import androidx.compose.material.icons.filled.FolderOpen
import androidx.compose.material.icons.filled.Key
import androidx.compose.material.icons.filled.Visibility
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.foundation.pager.HorizontalPager
import androidx.compose.foundation.pager.rememberPagerState
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material.icons.filled.Lightbulb
import androidx.compose.material.icons.filled.MarkEmailRead
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
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
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.asImageBitmap
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import mx.upaep.ciisregistry.data.Repo
import mx.upaep.ciisregistry.data.ResultadoActivar
import mx.upaep.ciisregistry.data.ResultadoLogin
import mx.upaep.ciisregistry.data.Rol
import mx.upaep.ciisregistry.ui.components.Aviso
import mx.upaep.ciisregistry.ui.components.AvisoDialogo
import mx.upaep.ciisregistry.ui.components.BotonPrimario
import mx.upaep.ciisregistry.ui.components.BotonSecundario
import mx.upaep.ciisregistry.ui.components.CampoTexto
import mx.upaep.ciisregistry.ui.components.Logo
import mx.upaep.ciisregistry.ui.theme.Ciis

/* ---------- Bienvenida/claro (como en el Figma) ---------- */
@Composable
fun BienvenidaScreen(onIniciar: () -> Unit, onVerProyectos: () -> Unit) {
    Column(Modifier.fillMaxSize().background(Ciis.Fondo).navigationBarsPadding()) {
        // Barra blanca de arriba con el logo
        Box(
            Modifier.fillMaxWidth().background(Ciis.Tarjeta).statusBarsPadding().padding(horizontal = 22.dp, vertical = 16.dp),
        ) { Logo(tam = 16) }

        Column(
            Modifier.fillMaxWidth().weight(1f).padding(horizontal = 32.dp),
            horizontalAlignment = Alignment.CenterHorizontally,
        ) {
            Spacer(Modifier.weight(1f))
            Text("¡BIENVENIDO!", color = Ciis.Rojo, fontSize = 36.sp, fontWeight = FontWeight.Black)
            Spacer(Modifier.height(20.dp))
            Text(
                "¡Controla, modifica, sigue y termina\ntu propio proyecto!",
                color = Ciis.Suave, fontSize = 15.sp, textAlign = TextAlign.Center,
            )
            Spacer(Modifier.height(44.dp))
            BotonBienvenida("Visualiza un proyecto", Icons.Filled.Visibility, Ciis.Rojo, onVerProyectos)
            Spacer(Modifier.height(14.dp))
            BotonBienvenida("Iniciar sesión", Icons.Filled.Key, Ciis.Pizarra, onIniciar)
            Spacer(Modifier.height(52.dp))
            // Etiqueta con borde
            Row(
                Modifier.clip(RoundedCornerShape(50)).border(1.dp, Ciis.Pizarra, RoundedCornerShape(50))
                    .padding(horizontal = 16.dp, vertical = 7.dp),
                verticalAlignment = Alignment.CenterVertically,
            ) {
                Icon(Icons.Filled.FolderOpen, null, tint = Ciis.Pizarra, modifier = Modifier.size(16.dp))
                Spacer(Modifier.width(8.dp))
                Text("Manejo de proyectos innovadores", color = Ciis.Pizarra, fontSize = 13.sp, fontWeight = FontWeight.SemiBold)
            }
            Spacer(Modifier.weight(1.2f))
        }
    }
}

/** Botón de la bienvenida: ícono amarillo a la izquierda y texto blanco. */
@Composable
private fun BotonBienvenida(texto: String, icono: androidx.compose.ui.graphics.vector.ImageVector, color: Color, onClick: () -> Unit) {
    Row(
        Modifier.fillMaxWidth(0.82f).height(50.dp).clip(RoundedCornerShape(10.dp)).background(color)
            .clickable(onClick = onClick).padding(horizontal = 14.dp),
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Box(Modifier.size(28.dp).clip(CircleShape).background(Ciis.Amarillo), contentAlignment = Alignment.Center) {
            Icon(icono, null, tint = Ciis.Pizarra, modifier = Modifier.size(17.dp))
        }
        Text(
            texto, color = Color.White, fontWeight = FontWeight.Bold, fontSize = 16.sp,
            textAlign = TextAlign.Center, modifier = Modifier.weight(1f).padding(end = 28.dp),
        )
    }
}

/* ---------- Proyectos y evidencias (carrusel público: nombre + foto) ---------- */
@Composable
fun ProyectosPublicosScreen(onVolver: () -> Unit) {
    val lista = Repo.proyectosActivos()
    val pager = rememberPagerState { lista.size }
    Column(Modifier.fillMaxSize().background(Ciis.Fondo).statusBarsPadding().navigationBarsPadding()) {
        Row(Modifier.padding(8.dp), verticalAlignment = Alignment.CenterVertically) {
            IconButton(onClick = onVolver) { Icon(Icons.AutoMirrored.Filled.ArrowBack, "Volver") }
            Logo(tam = 20)
        }
        Column(Modifier.padding(horizontal = 20.dp)) {
            Text("Proyectos", style = MaterialTheme.typography.headlineMedium)
            Text("Desliza para conocer los proyectos →", color = Ciis.Suave)
        }
        Spacer(Modifier.height(16.dp))
        HorizontalPager(
            state = pager, contentPadding = PaddingValues(horizontal = 28.dp), pageSpacing = 14.dp,
            modifier = Modifier.weight(1f),
        ) { i ->
            val p = lista[i]
            val foto = p.evidencias.lastOrNull { it.foto != null }?.foto
            Column(
                Modifier.fillMaxSize().padding(vertical = 6.dp).shadow(4.dp, RoundedCornerShape(22.dp), clip = false)
                    .clip(RoundedCornerShape(22.dp)).background(Ciis.Tarjeta),
            ) {
                Box(
                    Modifier.fillMaxWidth().weight(1f).background(Brush.verticalGradient(listOf(p.color.copy(alpha = 0.55f), p.color))),
                    contentAlignment = Alignment.Center,
                ) {
                    if (foto != null) Image(foto.asImageBitmap(), p.nombre, contentScale = ContentScale.Crop, modifier = Modifier.fillMaxSize())
                    else Column(horizontalAlignment = Alignment.CenterHorizontally) {
                        Text(p.nombre.take(1), color = Color.White, fontSize = 96.sp, fontWeight = FontWeight.Black)
                        Text("Foto de ejemplo", color = Color.White.copy(alpha = 0.85f))
                    }
                }
                Column(Modifier.padding(18.dp)) {
                    Text(p.nombre, style = MaterialTheme.typography.titleLarge)
                    Text("Proyecto ${i + 1} de ${lista.size}", color = Ciis.Suave)
                }
            }
        }
        Box(Modifier.padding(20.dp)) { BotonSecundario("Volver a bienvenida", onClick = onVolver) }
    }
}

/* ---------- InicioSesion/claro + ErrorInicioSesion/claro ---------- */
@Composable
fun LoginScreen(onEntrar: (Rol) -> Unit, onOlvide: () -> Unit, onActivar: () -> Unit, onVolver: () -> Unit) {
    var usuario by rememberSaveable { mutableStateOf("") }
    var contrasena by rememberSaveable { mutableStateOf("") }
    var aviso by remember { mutableStateOf<Aviso?>(null) }
    var conError by rememberSaveable { mutableStateOf(false) }

    fun intentar() {
        aviso = when {
            usuario.isBlank() || contrasena.isBlank() -> Aviso("Campos vacíos", "Escribe tu correo y tu contraseña.")
            else -> when (Repo.iniciarSesion(usuario, contrasena)) {
                ResultadoLogin.OK -> null.also { onEntrar(Repo.rol!!) }
                ResultadoLogin.SIN_ACTIVAR -> Aviso(
                    "Cuenta sin activar",
                    "Tu correo ya está registrado, pero aún no creas tu contraseña. Toca «¿Primera vez? Activa tu cuenta».",
                )
                ResultadoLogin.INACTIVA -> Aviso("Cuenta inactiva", "Tu registro no está activo. Habla con la coordinación del CIIS.")
                ResultadoLogin.INCORRECTO -> Aviso("Error al iniciar sesión", "El correo o la contraseña no son correctos. Inténtalo de nuevo.")
            }
        }
        conError = aviso != null
    }

    Column(
        Modifier.fillMaxSize().background(Ciis.Fondo).statusBarsPadding().navigationBarsPadding()
            .verticalScroll(rememberScrollState()).padding(24.dp),
        verticalArrangement = Arrangement.spacedBy(14.dp),
    ) {
        Row(verticalAlignment = Alignment.CenterVertically) {
            IconButton(onClick = onVolver) { Icon(Icons.AutoMirrored.Filled.ArrowBack, "Volver") }
            Logo(tam = 20)
        }
        Text("Seguimiento de Innovación e Impacto", color = Ciis.Suave)
        Text("Accede a tu cuenta", style = MaterialTheme.typography.headlineMedium)
        Text("Usa tu correo registrado por la coordinación.", color = Ciis.Suave)
        CampoTexto("Correo", usuario, { usuario = it; conError = false }, teclado = KeyboardType.Email, error = conError)
        CampoTexto("Contraseña", contrasena, { contrasena = it; conError = false }, teclado = KeyboardType.Password, oculto = true, error = conError)
        BotonPrimario("Iniciar sesión", onClick = ::intentar)
        Text(
            "¿No logras ingresar?", color = Ciis.Rojo, fontWeight = FontWeight.SemiBold,
            modifier = Modifier.align(Alignment.CenterHorizontally).clip(RoundedCornerShape(8.dp)).clickable(onClick = onOlvide).padding(8.dp),
        )
        Text(
            "¿Primera vez? Activa tu cuenta", color = Ciis.Rojo, fontWeight = FontWeight.SemiBold,
            modifier = Modifier.align(Alignment.CenterHorizontally).clip(RoundedCornerShape(8.dp)).clickable(onClick = onActivar).padding(8.dp),
        )
        Text(
            "Alumnos y aliados: primero la coordinación te registra; después activas tu cuenta con tu correo.",
            style = MaterialTheme.typography.bodySmall, color = Ciis.Suave, textAlign = TextAlign.Center, modifier = Modifier.fillMaxWidth(),
        )
    }
    AvisoDialogo(aviso) { aviso = null }
}

/* ---------- Activar cuenta (alumnos y aliados registrados por la coordinación) ---------- */
@Composable
fun ActivarScreen(onVolver: () -> Unit) {
    var correo by rememberSaveable { mutableStateOf("") }
    var verificado by rememberSaveable { mutableStateOf(false) }
    var contrasena by rememberSaveable { mutableStateOf("") }
    var confirmar by rememberSaveable { mutableStateOf("") }
    var aviso by remember { mutableStateOf<Aviso?>(null) }
    var listo by rememberSaveable { mutableStateOf(false) }

    fun avisoDe(r: ResultadoActivar): Aviso? = when (r) {
        ResultadoActivar.OK -> null
        ResultadoActivar.NO_REGISTRADO -> Aviso(
            "Correo no registrado",
            "Solo pueden activar su cuenta los alumnos y aliados que registró la coordinación. Revisa tu correo o habla con el CIIS.",
        )
        ResultadoActivar.YA_ACTIVA -> Aviso("Tu cuenta ya está activa", "Inicia sesión con tu contraseña. Si la olvidaste, usa «¿No logras ingresar?».")
        ResultadoActivar.INACTIVA -> Aviso("Cuenta inactiva", "Tu registro no está activo. Habla con la coordinación del CIIS.")
    }

    Column(
        Modifier.fillMaxSize().background(Ciis.Fondo).statusBarsPadding().navigationBarsPadding()
            .verticalScroll(rememberScrollState()).padding(24.dp),
        verticalArrangement = Arrangement.spacedBy(14.dp),
    ) {
        Row(verticalAlignment = Alignment.CenterVertically) {
            IconButton(onClick = onVolver) { Icon(Icons.AutoMirrored.Filled.ArrowBack, "Volver") }
            Logo(tam = 20)
        }
        Text("Activa tu cuenta", style = MaterialTheme.typography.headlineMedium)
        if (!verificado) {
            Text("Escribe el correo con el que te registró la coordinación.", color = Ciis.Suave)
            CampoTexto("Correo", correo, { correo = it }, teclado = KeyboardType.Email)
            BotonPrimario("Continuar") {
                aviso = when {
                    correo.isBlank() -> Aviso("Campos vacíos", "Escribe tu correo.")
                    !android.util.Patterns.EMAIL_ADDRESS.matcher(correo.trim()).matches() -> Aviso("Correo no válido", "Escribe un correo válido, por ejemplo nombre@upaep.mx.")
                    else -> avisoDe(Repo.puedeActivar(correo))
                }
                if (aviso == null) verificado = true
            }
        } else {
            Text("Crea la contraseña para ${correo.trim()}.", color = Ciis.Suave)
            CampoTexto("Contraseña nueva", contrasena, { contrasena = it }, teclado = KeyboardType.Password, oculto = true,
                ayuda = "Mínimo 8 caracteres, con letras y números.")
            CampoTexto("Confirma la contraseña", confirmar, { confirmar = it }, teclado = KeyboardType.Password, oculto = true)
            BotonPrimario("Activar cuenta") {
                aviso = when {
                    contrasena.isEmpty() || confirmar.isEmpty() -> Aviso("Campos vacíos", "Escribe y confirma tu contraseña.")
                    contrasena.length < 8 || contrasena.none(Char::isLetter) || contrasena.none(Char::isDigit) ->
                        Aviso("Contraseña muy débil", "Usa al menos 8 caracteres, con letras y números.")
                    contrasena != confirmar -> Aviso("Las contraseñas no coinciden", "Escribe la misma contraseña en los dos campos.")
                    else -> avisoDe(Repo.activarCuenta(correo, contrasena))
                }
                if (aviso == null) {
                    listo = true
                    aviso = Aviso("¡Cuenta activada!", "Ya puedes iniciar sesión con tu correo y tu contraseña nueva.", exito = true)
                }
            }
            BotonSecundario("Usar otro correo") { verificado = false; contrasena = ""; confirmar = "" }
        }
    }
    AvisoDialogo(aviso, boton = if (listo) "Iniciar sesión" else "Regresar") {
        aviso = null
        if (listo) onVolver()
    }
}

/* ---------- SesiónNoLograda/claro → RecuperarCuenta/claro ---------- */
@Composable
fun RecuperarScreen(onVolver: () -> Unit) {
    var correo by rememberSaveable { mutableStateOf("") }
    var enviado by rememberSaveable { mutableStateOf(false) }
    var error by remember { mutableStateOf<String?>(null) }
    Column(
        Modifier.fillMaxSize().background(Ciis.Fondo).statusBarsPadding().navigationBarsPadding()
            .verticalScroll(rememberScrollState()).padding(24.dp),
        verticalArrangement = Arrangement.spacedBy(14.dp),
    ) {
        Logo(tam = 20)
        Text("Seguimiento de Innovación e Impacto", color = Ciis.Suave)
        Text(
            "‹ Regresar a Inicio de Sesión", color = Ciis.Rojo, fontWeight = FontWeight.SemiBold,
            modifier = Modifier.clip(RoundedCornerShape(8.dp)).clickable(onClick = onVolver).padding(vertical = 6.dp),
        )
        Text("Acceso a tu cuenta", style = MaterialTheme.typography.headlineMedium)
        if (!enviado) {
            Text("Ingrese su correo para reestablecer su contraseña:", color = Ciis.Suave)
            CampoTexto("Cuenta / Correo institucional", correo, { correo = it; error = null }, teclado = KeyboardType.Email, error = error != null)
            if (error != null) Text(error!!, color = Ciis.Rojo)
            BotonPrimario("Reestablecer cuenta") {
                error = if (android.util.Patterns.EMAIL_ADDRESS.matcher(correo.trim()).matches()) null else "Escribe un correo válido."
                if (error == null) enviado = true
            }
        } else {
            Column(
                Modifier.fillMaxWidth().clip(RoundedCornerShape(16.dp)).background(Ciis.Tarjeta).padding(20.dp),
                horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.spacedBy(10.dp),
            ) {
                // El envío automático de correo todavía no está programado (ver README)
                Icon(Icons.Filled.MarkEmailRead, null, tint = Ciis.Ambar, modifier = Modifier.size(56.dp))
                Text("Función en desarrollo", fontWeight = FontWeight.Bold)
                Text(
                    "Por ahora la app no puede enviar el correo para recuperar tu cuenta. " +
                        "Pide a la coordinación del CIIS que te ayude a restablecer tu contraseña.",
                    color = Ciis.Suave, textAlign = TextAlign.Center,
                )
            }
            BotonPrimario("Regresar a Inicio de Sesión", onClick = onVolver)
        }
    }
}

