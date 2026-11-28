package mx.upaep.ciisregistry.data

import android.content.ContentValues
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.Environment
import android.provider.CalendarContract
import android.provider.MediaStore
import java.io.File
import java.time.LocalTime
import java.time.ZoneId

/** Abre la app de Calendario con la mentoría lista para guardar e invita al mentor por correo. */
fun abrirEnCalendario(context: Context, m: Mentoria): Boolean {
    val inicio = m.fecha.atTime(LocalTime.parse(m.hora)).atZone(ZoneId.systemDefault()).toInstant().toEpochMilli()
    val alumno = Repo.estudiante(m.matricula)
    val correos = listOfNotNull(Repo.mentor(m.mentor)?.correo?.takeIf { it.isNotBlank() }, alumno?.correo).joinToString(",")
    val intent = Intent(Intent.ACTION_INSERT).apply {
        data = CalendarContract.Events.CONTENT_URI
        putExtra(CalendarContract.Events.TITLE, "Mentoría CIIS · ${m.tema}")
        putExtra(CalendarContract.Events.DESCRIPTION, "Mentor: ${m.mentor}\nEstudiante: ${alumno?.nombre ?: m.matricula}\n${m.nota}".trim())
        putExtra(CalendarContract.EXTRA_EVENT_BEGIN_TIME, inicio)
        putExtra(CalendarContract.EXTRA_EVENT_END_TIME, inicio + 60 * 60 * 1000)
        putExtra(Intent.EXTRA_EMAIL, correos)
    }
    return runCatching { context.startActivity(intent) }.isSuccess
}

/** Dirección (Uri) del último reporte guardado, para poder compartirlo. */
var ultimoReporte: android.net.Uri? = null
    private set

/**
 * Guarda el reporte como CSV (se abre en Excel) en la carpeta Descargas.
 * Regresa el nombre del archivo o null si falló.
 */
fun guardarReporteCsv(context: Context, nombre: String, filas: List<List<String>>): String? = runCatching {
    val texto = "﻿" + filas.joinToString("\r\n") { fila -> fila.joinToString(",") { "\"" + it.replace("\"", "\"\"") + "\"" } }
    val bytes = texto.toByteArray(Charsets.UTF_8)
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
        val valores = ContentValues().apply {
            put(MediaStore.MediaColumns.DISPLAY_NAME, nombre)
            put(MediaStore.MediaColumns.MIME_TYPE, "text/csv")
            put(MediaStore.MediaColumns.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS)
        }
        val uri = context.contentResolver.insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, valores) ?: error("sin uri")
        context.contentResolver.openOutputStream(uri)?.use { it.write(bytes) } ?: error("sin salida")
        ultimoReporte = uri
    } else {
        ultimoReporte = null
        // Android 8–9: carpeta Descargas propia de la app (no pide permisos)
        val dir = context.getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS) ?: context.filesDir
        File(dir, nombre).writeBytes(bytes)
    }
    nombre
}.getOrNull()

/**
 * Intent implícito: abre la ventana de "Compartir" de Android (correo, WhatsApp, Drive…)
 * con el archivo del reporte. Regresa false si no se puede.
 */
fun compartirReporte(context: Context): Boolean {
    val uri = ultimoReporte ?: return false
    val intent = Intent(Intent.ACTION_SEND).apply {
        type = "text/csv"
        putExtra(Intent.EXTRA_STREAM, uri)
        putExtra(Intent.EXTRA_SUBJECT, "Reporte CIIS Registry")
        addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
    }
    return runCatching { context.startActivity(Intent.createChooser(intent, "Compartir reporte")) }.isSuccess
}
