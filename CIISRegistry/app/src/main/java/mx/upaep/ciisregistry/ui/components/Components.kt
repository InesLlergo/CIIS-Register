package mx.upaep.ciisregistry.ui.components

import android.graphics.Bitmap
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.layout.widthIn
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material.icons.automirrored.filled.KeyboardArrowRight
import androidx.compose.material.icons.automirrored.filled.Logout
import androidx.compose.material.icons.filled.CalendarMonth
import androidx.compose.material.icons.filled.CheckCircle
import androidx.compose.material.icons.filled.ErrorOutline
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.DatePicker
import androidx.compose.material3.DatePickerDialog
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.ExposedDropdownMenuBox
import androidx.compose.material3.ExposedDropdownMenuDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.MenuAnchorType
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.OutlinedTextFieldDefaults
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.rememberDatePickerState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.asImageBitmap
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.text.SpanStyle
import androidx.compose.ui.text.buildAnnotatedString
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.withStyle
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.compose.ui.window.Dialog
import mx.upaep.ciisregistry.data.Estatus
import mx.upaep.ciisregistry.data.Proyecto
import mx.upaep.ciisregistry.ui.theme.Ciis
import java.time.Instant
import java.time.LocalDate
import java.time.ZoneOffset

/* ---------------- Marca ---------------- */

@Composable
fun Logo(modifier: Modifier = Modifier, tam: Int = 22, claro: Boolean = false) {
    Text(
        buildAnnotatedString {
            withStyle(SpanStyle(fontWeight = FontWeight.Black, color = if (claro) Color.White else Ciis.Rojo)) { append("CIIS ") }
            withStyle(SpanStyle(fontWeight = FontWeight.Medium, color = if (claro) Color.White else Ciis.Texto)) { append("REGISTRY") }
        },
        fontSize = tam.sp,
        letterSpacing = 1.sp,
        modifier = modifier,
    )
}

/** Encabezado de las pantallas con sesión: logo, rol y botón para salir. */
@Composable
fun BarraSesion(rol: String, onSalir: () -> Unit) {
    Row(
        Modifier.fillMaxWidth().background(Ciis.Tarjeta).statusBarsPadding().padding(start = 20.dp, end = 8.dp, top = 10.dp, bottom = 6.dp),
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Column(Modifier.weight(1f)) {
            Logo(tam = 20)
            Text(rol, style = MaterialTheme.typography.bodySmall, color = Ciis.Suave)
        }
        IconButton(onClick = onSalir) { Icon(Icons.AutoMirrored.Filled.Logout, "Cerrar sesión", tint = Ciis.Suave) }
    }
}

/** Pestañas superiores (General · Progreso · Mentorías, etc.). */
@Composable
fun Pestanas(opciones: List<String>, seleccion: Int, onSelect: (Int) -> Unit) {
    Row(
        Modifier.fillMaxWidth().background(Ciis.Tarjeta).padding(horizontal = 16.dp).padding(bottom = 10.dp),
        horizontalArrangement = Arrangement.spacedBy(8.dp),
    ) {
        opciones.forEachIndexed { i, t ->
            val sel = i == seleccion
            Box(
                Modifier.weight(1f).clip(RoundedCornerShape(12.dp))
                    .background(if (sel) Ciis.Rojo else Ciis.Fondo)
                    .clickable { onSelect(i) }.padding(vertical = 10.dp),
                contentAlignment = Alignment.Center,
            ) {
                Text(t, color = if (sel) Color.White else Ciis.Texto, fontWeight = FontWeight.Bold, fontSize = 15.sp)
            }
        }
    }
}

/* ---------------- Contenedores ---------------- */

/** Contenido desplazable con el relleno estándar del Figma (20 dp a los lados). */
@Composable
fun Contenido(modifier: Modifier = Modifier, content: @Composable ColumnScope.() -> Unit) {
    Column(
        modifier.fillMaxSize().verticalScroll(rememberScrollState()).padding(horizontal = 20.dp, vertical = 16.dp).navigationBarsPadding(),
        verticalArrangement = Arrangement.spacedBy(14.dp),
        content = content,
    )
}

@Composable
fun Tarjeta(modifier: Modifier = Modifier, padding: Dp = 16.dp, onClick: (() -> Unit)? = null, content: @Composable ColumnScope.() -> Unit) {
    val base = modifier.fillMaxWidth().shadow(3.dp, RoundedCornerShape(16.dp), clip = false)
        .clip(RoundedCornerShape(16.dp)).background(Ciis.Tarjeta)
    Column(
        (if (onClick != null) base.clickable(onClick = onClick) else base).padding(padding),
        verticalArrangement = Arrangement.spacedBy(8.dp),
        content = content,
    )
}

@Composable
fun TituloSeccion(texto: String, modifier: Modifier = Modifier) {
    Text(texto, style = MaterialTheme.typography.titleMedium, color = Ciis.Texto, modifier = modifier)
}

@Composable
fun Encabezado(titulo: String, subtitulo: String? = null, volver: String? = null, onVolver: (() -> Unit)? = null) {
    Column(verticalArrangement = Arrangement.spacedBy(4.dp)) {
        if (volver != null && onVolver != null) {
            Row(
                Modifier.clip(RoundedCornerShape(8.dp)).clickable(onClick = onVolver).padding(vertical = 4.dp, horizontal = 2.dp),
                verticalAlignment = Alignment.CenterVertically,
            ) {
                Icon(Icons.AutoMirrored.Filled.ArrowBack, null, tint = Ciis.Rojo, modifier = Modifier.size(18.dp))
                Spacer(Modifier.width(4.dp))
                Text(volver, color = Ciis.Rojo, fontWeight = FontWeight.SemiBold)
            }
        }
        Text(titulo, style = MaterialTheme.typography.headlineMedium, color = Ciis.Texto)
        if (subtitulo != null) Text(subtitulo, style = MaterialTheme.typography.bodyMedium, color = Ciis.Suave)
    }
}

/* ---------------- Botones (Botón/Primario, Botón/Secundario) ---------------- */

@Composable
fun BotonPrimario(texto: String, modifier: Modifier = Modifier, icono: ImageVector? = null, color: Color = Ciis.Rojo, enabled: Boolean = true, onClick: () -> Unit) {
    Button(
        onClick = onClick, enabled = enabled,
        modifier = modifier.fillMaxWidth().heightIn(min = 48.dp),
        shape = RoundedCornerShape(12.dp),
        colors = ButtonDefaults.buttonColors(containerColor = color, contentColor = if (color == Ciis.Ambar) Color(0xFF3B2A00) else Color.White),
    ) {
        if (icono != null) { Icon(icono, null, Modifier.size(20.dp)); Spacer(Modifier.width(8.dp)) }
        Text(texto, fontWeight = FontWeight.Bold, fontSize = 16.sp)
    }
}

@Composable
fun BotonSecundario(texto: String, modifier: Modifier = Modifier, icono: ImageVector? = null, onClick: () -> Unit) {
    OutlinedButton(
        onClick = onClick,
        modifier = modifier.fillMaxWidth().heightIn(min = 50.dp),
        shape = RoundedCornerShape(12.dp),
        border = BorderStroke(1.5.dp, Ciis.Rojo),
        colors = ButtonDefaults.outlinedButtonColors(containerColor = Ciis.Tarjeta, contentColor = Ciis.Rojo),
    ) {
        if (icono != null) { Icon(icono, null, Modifier.size(20.dp)); Spacer(Modifier.width(8.dp)) }
        Text(texto, fontWeight = FontWeight.Bold, fontSize = 16.sp)
    }
}

/* ---------------- Campos (Campo/Texto, Campo/Lista) ---------------- */

@Composable
fun CampoTexto(
    etiqueta: String, valor: String, onCambio: (String) -> Unit, modifier: Modifier = Modifier,
    ayuda: String? = null, teclado: KeyboardType = KeyboardType.Text, lineas: Int = 1,
    oculto: Boolean = false, error: Boolean = false,
) {
    Column(modifier.fillMaxWidth()) {
        Text(etiqueta, style = MaterialTheme.typography.labelMedium, color = Ciis.Texto)
        Spacer(Modifier.height(6.dp))
        OutlinedTextField(
            value = valor, onValueChange = onCambio, singleLine = lineas == 1, minLines = lineas,
            isError = error,
            visualTransformation = if (oculto) androidx.compose.ui.text.input.PasswordVisualTransformation() else androidx.compose.ui.text.input.VisualTransformation.None,
            keyboardOptions = KeyboardOptions(keyboardType = teclado),
            shape = RoundedCornerShape(12.dp),
            colors = campoColores(),
            modifier = Modifier.fillMaxWidth(),
        )
        if (ayuda != null) Text(ayuda, style = MaterialTheme.typography.bodySmall, color = Ciis.Suave, modifier = Modifier.padding(top = 4.dp))
    }
}

@Composable
private fun campoColores(texto: Color = Ciis.Texto) = OutlinedTextFieldDefaults.colors(
    focusedTextColor = texto, unfocusedTextColor = texto,
    focusedBorderColor = Ciis.Rojo, unfocusedBorderColor = Ciis.Borde,
    focusedContainerColor = Ciis.Tarjeta, unfocusedContainerColor = Ciis.Tarjeta,
    cursorColor = Ciis.Rojo,
)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun CampoLista(
    etiqueta: String, opciones: List<String>, seleccion: String, onSelect: (String) -> Unit,
    modifier: Modifier = Modifier, marcador: String = "Elige…",
) {
    var abierto by remember { mutableStateOf(false) }
    Column(modifier.fillMaxWidth()) {
        Text(etiqueta, style = MaterialTheme.typography.labelMedium, color = Ciis.Texto)
        Spacer(Modifier.height(6.dp))
        ExposedDropdownMenuBox(expanded = abierto, onExpandedChange = { abierto = it }) {
            OutlinedTextField(
                value = seleccion.ifEmpty { marcador }, onValueChange = {}, readOnly = true, singleLine = true,
                trailingIcon = { ExposedDropdownMenuDefaults.TrailingIcon(expanded = abierto) },
                shape = RoundedCornerShape(12.dp),
                colors = campoColores(if (seleccion.isEmpty()) Ciis.Suave else Ciis.Texto),
                modifier = Modifier.fillMaxWidth().menuAnchor(MenuAnchorType.PrimaryNotEditable, true),
            )
            ExposedDropdownMenu(expanded = abierto, onDismissRequest = { abierto = false }) {
                opciones.forEach { o ->
                    DropdownMenuItem(text = { Text(o) }, onClick = { onSelect(o); abierto = false })
                }
            }
        }
    }
}

/** Campo de fecha con calendario. */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun CampoFecha(etiqueta: String, fecha: LocalDate?, onFecha: (LocalDate) -> Unit, modifier: Modifier = Modifier) {
    var abierto by remember { mutableStateOf(false) }
    Column(modifier.fillMaxWidth()) {
        Text(etiqueta, style = MaterialTheme.typography.labelMedium, color = Ciis.Texto)
        Spacer(Modifier.height(6.dp))
        Row(
            Modifier.fillMaxWidth().heightIn(min = 56.dp).clip(RoundedCornerShape(12.dp)).background(Ciis.Tarjeta)
                .border(1.dp, Ciis.Borde, RoundedCornerShape(12.dp)).clickable { abierto = true }.padding(horizontal = 16.dp),
            verticalAlignment = Alignment.CenterVertically,
        ) {
            Text(
                fecha?.let { mx.upaep.ciisregistry.data.fechaLarga(it) } ?: "Elige una fecha",
                color = if (fecha == null) Ciis.Suave else Ciis.Texto, modifier = Modifier.weight(1f),
            )
            Icon(Icons.Filled.CalendarMonth, null, tint = Ciis.Suave)
        }
    }
    if (abierto) {
        val estado = rememberDatePickerState(
            initialSelectedDateMillis = (fecha ?: LocalDate.now()).atStartOfDay().toInstant(ZoneOffset.UTC).toEpochMilli(),
        )
        DatePickerDialog(
            onDismissRequest = { abierto = false },
            confirmButton = {
                TextButton(onClick = {
                    estado.selectedDateMillis?.let { onFecha(Instant.ofEpochMilli(it).atZone(ZoneOffset.UTC).toLocalDate()) }
                    abierto = false
                }) { Text("Aceptar") }
            },
            dismissButton = { TextButton(onClick = { abierto = false }) { Text("Cancelar") } },
        ) { DatePicker(state = estado) }
    }
}

/* ---------------- Tarjetas y filas ---------------- */

@Composable
fun ChipEstatus(e: Estatus) {
    val (fondo, texto) = when (e) {
        Estatus.EN_PROGRESO -> Ciis.RojoSuave to Ciis.Rojo
        Estatus.TERMINADO -> Ciis.VerdeSuave to Ciis.Verde
        Estatus.ARCHIVADO -> Ciis.MoradoSuave to Ciis.Morado
        Estatus.NO_INICIADO -> Color(0xFFF0F0F2) to Ciis.Suave
    }
    Chip(e.texto, fondo, texto)
}

@Composable
fun Chip(texto: String, fondo: Color, color: Color) {
    Row(
        Modifier.clip(RoundedCornerShape(50)).background(fondo).padding(horizontal = 10.dp, vertical = 4.dp),
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Box(Modifier.size(7.dp).clip(CircleShape).background(color))
        Spacer(Modifier.width(6.dp))
        Text(texto, color = color, fontSize = 12.sp, fontWeight = FontWeight.Bold)
    }
}

@Composable
fun BarraAvance(pct: Int, modifier: Modifier = Modifier, color: Color = Ciis.Rojo) {
    Box(modifier.fillMaxWidth().height(10.dp).clip(RoundedCornerShape(6.dp)).background(Ciis.BarraFondo)) {
        Box(Modifier.fillMaxWidth(pct.coerceIn(0, 100) / 100f).height(10.dp).clip(RoundedCornerShape(6.dp)).background(color))
    }
}

/** Tarjeta/Proyecto: nombre, ODS, estatus y avance. */
@Composable
fun TarjetaProyecto(p: Proyecto, onClick: (() -> Unit)? = null, pie: (@Composable () -> Unit)? = null) {
    Tarjeta(onClick = onClick) {
        Row(verticalAlignment = Alignment.CenterVertically) {
            // Foto del proyecto (la evidencia más reciente, como en el sitio web) o su inicial
            val foto = p.fotoProyecto
            Box(Modifier.size(44.dp).clip(RoundedCornerShape(12.dp)).background(p.color), contentAlignment = Alignment.Center) {
                if (foto != null) Image(foto.asImageBitmap(), p.nombre, contentScale = ContentScale.Crop, modifier = Modifier.fillMaxSize())
                else Text(p.nombre.take(1), color = Color.White, fontWeight = FontWeight.Black, fontSize = 20.sp)
            }
            Spacer(Modifier.width(12.dp))
            Column(Modifier.weight(1f)) {
                Text(p.nombre, style = MaterialTheme.typography.titleSmall, color = Ciis.Texto)
                Text(p.ods, style = MaterialTheme.typography.bodySmall, color = Ciis.Suave)
            }
            if (onClick != null) Icon(Icons.AutoMirrored.Filled.KeyboardArrowRight, null, tint = Ciis.Suave)
        }
        Row(verticalAlignment = Alignment.CenterVertically) {
            ChipEstatus(p.estatus)
            Spacer(Modifier.weight(1f))
            Text("${p.avance}% · ${p.periodo}", style = MaterialTheme.typography.bodySmall, color = Ciis.Suave)
        }
        BarraAvance(p.avance)
        pie?.invoke()
    }
}

/** Tarjeta/Dato: número grande con su etiqueta. */
@Composable
fun TarjetaDato(valor: String, etiqueta: String, modifier: Modifier = Modifier, color: Color = Ciis.Texto) {
    Column(
        modifier.shadow(3.dp, RoundedCornerShape(16.dp), clip = false).clip(RoundedCornerShape(16.dp))
            .background(Ciis.Tarjeta).padding(14.dp),
    ) {
        Text(valor, fontSize = 26.sp, fontWeight = FontWeight.Black, color = color)
        Text(etiqueta, style = MaterialTheme.typography.bodySmall, color = Ciis.Suave)
    }
}

/** Item/Lista: icono, título, subtítulo y flecha opcional. */
@Composable
fun ItemLista(
    titulo: String, subtitulo: String? = null, icono: ImageVector? = null, colorIcono: Color = Ciis.Rojo,
    derecha: (@Composable () -> Unit)? = null, onClick: (() -> Unit)? = null,
) {
    Row(
        Modifier.fillMaxWidth().clip(RoundedCornerShape(12.dp)).background(Ciis.Fondo)
            .then(if (onClick != null) Modifier.clickable(onClick = onClick) else Modifier)
            .padding(horizontal = 12.dp, vertical = 10.dp),
        verticalAlignment = Alignment.CenterVertically,
    ) {
        if (icono != null) {
            Box(Modifier.size(40.dp).clip(CircleShape).background(colorIcono.copy(alpha = 0.12f)), contentAlignment = Alignment.Center) {
                Icon(icono, null, tint = colorIcono, modifier = Modifier.size(22.dp))
            }
            Spacer(Modifier.width(12.dp))
        }
        Column(Modifier.weight(1f)) {
            Text(titulo, fontWeight = FontWeight.SemiBold, color = Ciis.Texto)
            if (subtitulo != null) Text(subtitulo, style = MaterialTheme.typography.bodySmall, color = Ciis.Suave)
        }
        if (derecha != null) derecha()
        else if (onClick != null) Icon(Icons.AutoMirrored.Filled.KeyboardArrowRight, null, tint = Ciis.Suave)
    }
}

/** Fila/Dato: etiqueta a la izquierda y valor a la derecha. */
@Composable
fun FilaDato(etiqueta: String, valor: String) {
    Row(Modifier.fillMaxWidth().padding(vertical = 2.dp)) {
        Text(etiqueta, color = Ciis.Suave, style = MaterialTheme.typography.bodyMedium, modifier = Modifier.weight(1f))
        Spacer(Modifier.width(12.dp))
        Text(valor, color = Ciis.Texto, fontWeight = FontWeight.SemiBold, style = MaterialTheme.typography.bodyMedium, textAlign = TextAlign.End, modifier = Modifier.weight(1.3f))
    }
}

@Composable
fun FotoRedonda(foto: Bitmap?, iniciales: String, tam: Dp = 72.dp) {
    Box(Modifier.size(tam).clip(CircleShape).background(Ciis.RojoSuave), contentAlignment = Alignment.Center) {
        if (foto != null) Image(foto.asImageBitmap(), "Foto de perfil", contentScale = ContentScale.Crop, modifier = Modifier.fillMaxSize())
        else Text(iniciales, color = Ciis.Rojo, fontWeight = FontWeight.Black, fontSize = (tam.value / 2.8f).sp)
    }
}

/* ---------------- Avisos (pantallas de error y éxito del Figma) ---------------- */

data class Aviso(val titulo: String, val mensaje: String, val exito: Boolean = false)

@Composable
fun AvisoDialogo(aviso: Aviso?, boton: String = "Regresar", onCerrar: () -> Unit) {
    if (aviso == null) return
    Dialog(onDismissRequest = onCerrar) {
        Column(
            Modifier.widthIn(max = 360.dp).clip(RoundedCornerShape(20.dp)).background(Ciis.Tarjeta).padding(24.dp),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.spacedBy(12.dp),
        ) {
            val color = if (aviso.exito) Ciis.Verde else Ciis.Rojo
            Box(Modifier.size(64.dp).clip(CircleShape).background(color.copy(alpha = 0.12f)), contentAlignment = Alignment.Center) {
                Icon(if (aviso.exito) Icons.Filled.CheckCircle else Icons.Filled.ErrorOutline, null, tint = color, modifier = Modifier.size(36.dp))
            }
            Text(aviso.titulo, style = MaterialTheme.typography.titleLarge, textAlign = TextAlign.Center, color = Ciis.Texto)
            Text(aviso.mensaje, style = MaterialTheme.typography.bodyMedium, textAlign = TextAlign.Center, color = Ciis.Suave)
            Spacer(Modifier.height(4.dp))
            BotonPrimario(boton, onClick = onCerrar)
        }
    }
}

/** Diálogo de confirmación (p. ej. cancelar asesoría). */
@Composable
fun ConfirmarDialogo(titulo: String, mensaje: String, si: String, no: String, onSi: () -> Unit, onNo: () -> Unit) {
    Dialog(onDismissRequest = onNo) {
        Column(
            Modifier.widthIn(max = 360.dp).clip(RoundedCornerShape(20.dp)).background(Ciis.Tarjeta).padding(24.dp),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.spacedBy(12.dp),
        ) {
            Box(Modifier.size(64.dp).clip(CircleShape).background(Ciis.AmbarSuave), contentAlignment = Alignment.Center) {
                Icon(Icons.Filled.ErrorOutline, null, tint = Ciis.Ambar, modifier = Modifier.size(36.dp))
            }
            Text(titulo, style = MaterialTheme.typography.titleLarge, textAlign = TextAlign.Center, color = Ciis.Texto)
            Text(mensaje, style = MaterialTheme.typography.bodyMedium, textAlign = TextAlign.Center, color = Ciis.Suave)
            BotonPrimario(si, onClick = onSi)
            BotonSecundario(no, onClick = onNo)
        }
    }
}

/** Pantalla de éxito a pantalla completa (RegistroExitoso, ApoyoConfirmado, AsesoriaAgendada…). */
@Composable
fun PantallaExito(
    titulo: String, mensaje: String, primario: String, onPrimario: () -> Unit,
    secundario: String? = null, onSecundario: (() -> Unit)? = null, icono: ImageVector = Icons.Filled.CheckCircle,
) {
    Column(
        Modifier.fillMaxSize().background(Ciis.Fondo).padding(28.dp).navigationBarsPadding(),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center,
    ) {
        Box(Modifier.size(110.dp).clip(CircleShape).background(Ciis.VerdeSuave), contentAlignment = Alignment.Center) {
            Icon(icono, null, tint = Ciis.Verde, modifier = Modifier.size(64.dp))
        }
        Spacer(Modifier.height(24.dp))
        Text(titulo, style = MaterialTheme.typography.headlineMedium, textAlign = TextAlign.Center, color = Ciis.Texto)
        Spacer(Modifier.height(8.dp))
        Text(mensaje, style = MaterialTheme.typography.bodyLarge, textAlign = TextAlign.Center, color = Ciis.Suave)
        Spacer(Modifier.height(32.dp))
        BotonPrimario(primario, onClick = onPrimario)
        if (secundario != null && onSecundario != null) {
            Spacer(Modifier.height(12.dp))
            BotonSecundario(secundario, onClick = onSecundario)
        }
    }
}
