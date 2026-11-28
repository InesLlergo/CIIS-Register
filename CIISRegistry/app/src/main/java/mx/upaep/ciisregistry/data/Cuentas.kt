package mx.upaep.ciisregistry.data

import android.content.Context
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.toArgb
import org.json.JSONArray
import org.json.JSONObject
import java.security.MessageDigest
import java.security.SecureRandom
import java.util.Base64
import javax.crypto.SecretKeyFactory
import javax.crypto.spec.PBEKeySpec

/* =====================================================================
   Cuentas de acceso y guardado en el teléfono.

   - Coordinación: solo coordi01@gmail.com y coordi02@gmail.com entran directo.
   - Alumnos y aliados: la coordinación los registra (Alta de estudiante / aliado)
     y después cada persona activa su cuenta creando su contraseña.
   - Las contraseñas nunca se guardan tal cual: se guarda un hash PBKDF2 con sal.
   - Lo que registra la coordinación y las implementaciones de los alumnos se guardan
     en la base SQLite del teléfono (BaseDatos.java), así que siguen ahí al cerrar la app.
     Los datos de ejemplo no se modifican.
   ===================================================================== */

/** Una cuenta de acceso. [ref] es la matrícula (alumno) o el id del aliado. */
class Cuenta(val correo: String, val rol: Rol, val ref: String, var hash: String? = null, var sal: String? = null) {
    val activa: Boolean get() = hash != null
}

enum class ResultadoLogin { OK, INCORRECTO, SIN_ACTIVAR, INACTIVA }
enum class ResultadoActivar { OK, NO_REGISTRADO, YA_ACTIVA, INACTIVA }

internal object Claves {
    private const val VUELTAS = 12000

    fun nuevaSal(): String = ByteArray(16).also { SecureRandom().nextBytes(it) }.let { Base64.getEncoder().encodeToString(it) }

    fun hash(contrasena: String, sal: String): String {
        val spec = PBEKeySpec(contrasena.toCharArray(), Base64.getDecoder().decode(sal), VUELTAS, 256)
        val bytes = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256").generateSecret(spec).encoded
        spec.clearPassword()
        return Base64.getEncoder().encodeToString(bytes)
    }

    fun coincide(contrasena: String, cuenta: Cuenta): Boolean {
        val h = cuenta.hash ?: return false
        val s = cuenta.sal ?: return false
        return MessageDigest.isEqual(hash(contrasena, s).toByteArray(), h.toByteArray())
    }
}

/**
 * Puente entre Repo (Kotlin) y la base SQLite (BaseDatos.java).
 * Aquí se convierten los objetos de la app en filas de las tablas y al revés.
 */
internal object Almacen {
    private var db: BaseDatos? = null

    /** Carpeta privada de la app, donde se guardan las fotos de las implementaciones. */
    var carpetaFotos: java.io.File? = null
        private set

    val listo: Boolean get() = db != null

    fun abrir(context: Context): BaseDatos {
        val base = BaseDatos(context.applicationContext)
        db = base
        carpetaFotos = context.applicationContext.filesDir
        return base
    }

    fun base(): BaseDatos? = db

    /* ---------- Cuenta <-> fila de "usuarios" ---------- */

    fun cuentaDeFila(f: Array<String?>) = Cuenta(
        f[0] ?: "", Rol.valueOf(f[1] ?: "ALUMNO"), f[2] ?: "",
        f[3]?.ifEmpty { null }, f[4]?.ifEmpty { null },
    )

    fun guardarCuenta(c: Cuenta) {
        db?.guardarUsuario(c.correo, c.rol.name, c.ref, c.hash ?: "", c.sal ?: "")
    }

    /* ---------- Objetivos <-> texto (columna "objetivos") ---------- */

    fun objetivosAJson(p: Proyecto): String =
        JSONArray().apply { p.objetivos.forEach { put(JSONObject().put("t", it.texto).put("c", it.cumplido)) } }.toString()

    fun objetivosDeJson(texto: String?): List<Objetivo> {
        val a = runCatching { JSONArray(texto ?: "[]") }.getOrDefault(JSONArray())
        return (0 until a.length()).map { a.getJSONObject(it).let { j -> Objetivo(j.getString("t"), j.getBoolean("c")) } }
    }

    /* ---------- Guardar filas ---------- */

    fun guardarProyecto(p: Proyecto) {
        db?.guardarProyecto(
            p.id, p.nombre, p.descripcion, p.ods, p.saps, p.comunidad, p.municipio, p.beneficiarios,
            p.inicio.toString(), p.fin?.toString() ?: "", p.color.toArgb(), p.archivado, p.buscaApoyo, objetivosAJson(p),
        )
    }

    fun guardarEstudiante(e: Estudiante) {
        db?.guardarEstudiante(
            e.matricula, e.nombre, e.correo, e.programa, e.generacion, e.frecuencia, e.estatus, e.proyectoId ?: -1, e.rol,
        )
    }

    fun guardarAliado(a: Aliado) {
        db?.guardarAliado(a.id, a.nombre, a.tipo, a.correo, a.proyectos.joinToString(","))
    }

    fun enteros(texto: String?): List<Int> = (texto ?: "").split(",").mapNotNull { it.trim().toIntOrNull() }
}
