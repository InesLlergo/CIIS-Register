package mx.upaep.ciisregistry.ui.theme

import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.sp

/** Paleta del modo claro del Figma "App_layout". */
object Ciis {
    val Fondo = Color(0xFFF5F5F5)
    val Tarjeta = Color(0xFFFFFFFF)
    val Texto = Color(0xFF1F2433)
    val Suave = Color(0xFF7A7F8C)
    val Rojo = Color(0xFFD32F2F)
    val RojoOscuro = Color(0xFFB51E22)
    val RojoSuave = Color(0xFFFCE9E9)
    val Ambar = Color(0xFFF2A30F)
    val AmbarSuave = Color(0xFFFFF3DC)
    val Borde = Color(0xFFE3E3E8)
    val Verde = Color(0xFF2E9B57)
    val VerdeSuave = Color(0xFFE5F4E4)
    val Morado = Color(0xFF5D5A85)
    val MoradoSuave = Color(0xFFECEBF5)
    val Azul = Color(0xFF5B74CF)
    val BarraFondo = Color(0xFFECECF0)
    val Pizarra = Color(0xFF4A5163)
    val Amarillo = Color(0xFFFFC83D)
}

private val Colores = lightColorScheme(
    primary = Ciis.Rojo,
    onPrimary = Color.White,
    primaryContainer = Ciis.RojoSuave,
    onPrimaryContainer = Ciis.RojoOscuro,
    secondary = Ciis.Ambar,
    onSecondary = Color(0xFF3B2A00),
    background = Ciis.Fondo,
    onBackground = Ciis.Texto,
    surface = Ciis.Tarjeta,
    onSurface = Ciis.Texto,
    surfaceVariant = Ciis.Fondo,
    onSurfaceVariant = Ciis.Suave,
    outline = Ciis.Borde,
    error = Ciis.Rojo,
)

// El Figma usa Alegreya Sans; aquí se usa la fuente del sistema (ver README para cambiarla).
private val Fuente = FontFamily.SansSerif

private val Tipos = Typography(
    headlineLarge = TextStyle(fontFamily = Fuente, fontWeight = FontWeight.Black, fontSize = 30.sp, lineHeight = 36.sp),
    headlineMedium = TextStyle(fontFamily = Fuente, fontWeight = FontWeight.Bold, fontSize = 24.sp, lineHeight = 30.sp),
    titleLarge = TextStyle(fontFamily = Fuente, fontWeight = FontWeight.Bold, fontSize = 22.sp, lineHeight = 28.sp),
    titleMedium = TextStyle(fontFamily = Fuente, fontWeight = FontWeight.Bold, fontSize = 18.sp, lineHeight = 24.sp),
    titleSmall = TextStyle(fontFamily = Fuente, fontWeight = FontWeight.SemiBold, fontSize = 16.sp, lineHeight = 22.sp),
    bodyLarge = TextStyle(fontFamily = Fuente, fontWeight = FontWeight.Normal, fontSize = 16.sp, lineHeight = 22.sp),
    bodyMedium = TextStyle(fontFamily = Fuente, fontWeight = FontWeight.Normal, fontSize = 14.sp, lineHeight = 20.sp),
    bodySmall = TextStyle(fontFamily = Fuente, fontWeight = FontWeight.Normal, fontSize = 12.sp, lineHeight = 16.sp),
    labelLarge = TextStyle(fontFamily = Fuente, fontWeight = FontWeight.Bold, fontSize = 16.sp, lineHeight = 20.sp),
    labelMedium = TextStyle(fontFamily = Fuente, fontWeight = FontWeight.SemiBold, fontSize = 13.sp, lineHeight = 18.sp),
)

@Composable
fun CiisTheme(content: @Composable () -> Unit) {
    MaterialTheme(colorScheme = Colores, typography = Tipos, content = content)
}
