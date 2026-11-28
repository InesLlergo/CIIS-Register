package mx.upaep.ciisregistry.ui.components

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.net.Uri
import android.widget.Toast
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.result.PickVisualMediaRequest
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.runtime.Composable
import androidx.compose.ui.platform.LocalContext
import androidx.core.content.ContextCompat

/** Acciones para obtener una foto con la cámara o de la galería (sensor de cámara del Figma). */
class SelectorFoto(val camara: () -> Unit, val galeria: () -> Unit)

@Composable
fun rememberSelectorFoto(onFoto: (Bitmap) -> Unit): SelectorFoto {
    val context = LocalContext.current
    // Cámara del sistema (devuelve una foto pequeña)
    val camara = rememberLauncherForActivityResult(ActivityResultContracts.TakePicturePreview()) { bmp ->
        if (bmp != null) onFoto(bmp)
    }
    // Como la app declara el permiso CAMERA, primero hay que pedirlo al sistema
    val permisoCamara = rememberLauncherForActivityResult(ActivityResultContracts.RequestPermission()) { concedido ->
        if (concedido) camara.launch(null)
        else Toast.makeText(context, "Sin permiso de cámara no se puede tomar la foto. Actívalo en Ajustes.", Toast.LENGTH_LONG).show()
    }
    // Galería: selector de fotos del sistema
    val galeria = rememberLauncherForActivityResult(ActivityResultContracts.PickVisualMedia()) { uri ->
        if (uri != null) cargarFoto(context, uri)?.let(onFoto)
    }
    return SelectorFoto(
        camara = {
            if (ContextCompat.checkSelfPermission(context, Manifest.permission.CAMERA) == PackageManager.PERMISSION_GRANTED) camara.launch(null)
            else permisoCamara.launch(Manifest.permission.CAMERA)
        },
        galeria = { galeria.launch(PickVisualMediaRequest(ActivityResultContracts.PickVisualMedia.ImageOnly)) },
    )
}

/** Lee la imagen reducida (máx. ~1200 px) para no llenar la memoria. */
fun cargarFoto(context: Context, uri: Uri, maximo: Int = 1200): Bitmap? = runCatching {
    val opciones = BitmapFactory.Options().apply { inJustDecodeBounds = true }
    context.contentResolver.openInputStream(uri)?.use { BitmapFactory.decodeStream(it, null, opciones) }
    var escala = 1
    while (opciones.outWidth / escala > maximo || opciones.outHeight / escala > maximo) escala *= 2
    val finales = BitmapFactory.Options().apply { inSampleSize = escala }
    context.contentResolver.openInputStream(uri)?.use { BitmapFactory.decodeStream(it, null, finales) }
}.getOrNull()
