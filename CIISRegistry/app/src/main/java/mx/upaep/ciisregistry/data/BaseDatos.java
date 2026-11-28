package mx.upaep.ciisregistry.data;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

/**
 * BaseDatos
 * Base de datos SQLite de la app (archivo "ciis.db" dentro del teléfono).
 * Extiende SQLiteOpenHelper: Android llama a onCreate() la primera vez para crear las tablas.
 *
 * Tablas:
 *   usuarios         cuentas para iniciar sesión (la contraseña se guarda como hash, nunca tal cual)
 *   estudiantes      alumnos que registra la coordinación
 *   proyectos        proyectos que registra la coordinación
 *   aliados          aliados que registra la coordinación
 *   implementaciones lo que registra el alumno en "Registrar implementación" (con la ruta de su foto)
 *
 * Para escribir se usa ContentValues + insert / insertWithOnConflict.
 * Para leer se usa rawQuery("SELECT ...") y se recorre el Cursor.
 */
public class BaseDatos extends SQLiteOpenHelper {

    private static final String NOMBRE = "ciis.db";
    private static final int VERSION = 2; // 2: se agregaron las cuentas de prueba de alumnos y aliado

    public BaseDatos(Context context) {
        super(context, NOMBRE, null, VERSION);
    }

    /** Se ejecuta una sola vez, cuando la base todavía no existe: crea las tablas. */
    @Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL("CREATE TABLE usuarios ("
                + "correo TEXT PRIMARY KEY, "
                + "rol TEXT NOT NULL, "          // ALUMNO, ALIADO o COORDINADOR
                + "referencia TEXT, "            // matrícula del alumno o id del aliado
                + "hash TEXT, "                  // contraseña cifrada (vacía si no ha activado su cuenta)
                + "sal TEXT)");

        db.execSQL("CREATE TABLE estudiantes ("
                + "matricula TEXT PRIMARY KEY, "
                + "nombre TEXT, correo TEXT, programa TEXT, generacion INTEGER, "
                + "frecuencia TEXT, estatus TEXT, proyecto_id INTEGER, rol TEXT)");

        db.execSQL("CREATE TABLE proyectos ("
                + "id INTEGER PRIMARY KEY, "
                + "nombre TEXT, descripcion TEXT, ods TEXT, saps TEXT, comunidad TEXT, municipio TEXT, "
                + "beneficiarios INTEGER, inicio TEXT, fin TEXT, color INTEGER, "
                + "archivado INTEGER, busca_apoyo INTEGER, "
                + "objetivos TEXT)");             // lista de objetivos en texto (JSON)

        db.execSQL("CREATE TABLE aliados ("
                + "id INTEGER PRIMARY KEY, "
                + "nombre TEXT, tipo TEXT, correo TEXT, "
                + "proyectos TEXT)");             // ids de proyectos separados por coma, ej. "1,3,100"

        db.execSQL("CREATE TABLE implementaciones ("
                + "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                + "proyecto_id INTEGER, matricula TEXT, tipo TEXT, actividad TEXT, lugar TEXT, "
                + "fecha TEXT, beneficiarios INTEGER, comentario TEXT, "
                + "foto_ruta TEXT)");             // dónde quedó guardada la foto (archivo JPG)

        insertarCuentasDePrueba(db);
    }

    /**
     * Cuentas de prueba (contraseñas guardadas como hash, ver el README para saber cuáles son):
     *   Coordinación: coordi01@gmail.com, coordi02@gmail.com
     *   Alumnos:      alumno01@gmail.com (Ana López, A0375), alumno02@gmail.com (Isabel Rojas, A0521)
     *   Aliado:       aliado01@gmail.com (Fundación Bepensa, id 1)
     */
    private void insertarCuentasDePrueba(SQLiteDatabase db) {
        insertarUsuario(db, "coordi01@gmail.com", "COORDINADOR", "",
                "edllKlPwIIQVFAEe2t3CUY5oacnE3n//Z2Ax+4Q8LWo=", "TN4dpstadeFjrQ3jKli0Bg==");
        insertarUsuario(db, "coordi02@gmail.com", "COORDINADOR", "",
                "NrxZ5o5PNWEaPaxS/RSMGI9jLhjrWJ6x/IAoHhXUpdQ=", "bkmWwu4VHHonl3pjaKvILg==");
        insertarUsuario(db, "alumno01@gmail.com", "ALUMNO", "A0375",
                "JgGxJ/ykQodLNboagNOjs26yviGKkfPgcq33kSlnsTM=", "VpA2bETdNjU3cF+rEGAugg==");
        insertarUsuario(db, "alumno02@gmail.com", "ALUMNO", "A0521",
                "3O+f6Vr4hnobQhcwH9/PnCh/7k6vWktbSZkLav2rNiw=", "UhGjZa3wDaKA+u4BDaX0dQ==");
        insertarUsuario(db, "aliado01@gmail.com", "ALIADO", "1",
                "77OSdquCFXTLylx2aPm+JzaFkXYTLgkaEqFjQW+OS4Y=", "cp9M+Tr258Y/+yGn4GwKag==");
    }

    /**
     * Se ejecuta cuando la app ya tenía una versión anterior de la base.
     * De la versión 1 a la 2 solo se agregan las cuentas de prueba; no se borra nada.
     */
    @Override
    public void onUpgrade(SQLiteDatabase db, int versionVieja, int versionNueva) {
        if (versionVieja < 2) {
            insertarCuentasDePrueba(db);
        }
    }

    /* ==================== USUARIOS ==================== */

    private void insertarUsuario(SQLiteDatabase db, String correo, String rol, String referencia, String hash, String sal) {
        ContentValues valores = new ContentValues();
        valores.put("correo", correo.toLowerCase());
        valores.put("rol", rol);
        valores.put("referencia", referencia);
        valores.put("hash", hash);
        valores.put("sal", sal);
        // REPLACE: si el correo ya existe, se actualiza
        db.insertWithOnConflict("usuarios", null, valores, SQLiteDatabase.CONFLICT_REPLACE);
    }

    /** Guarda (o actualiza) una cuenta. hash y sal van vacíos si todavía no activa su cuenta. */
    public void guardarUsuario(String correo, String rol, String referencia, String hash, String sal) {
        insertarUsuario(getWritableDatabase(), correo, rol, referencia, hash, sal);
    }

    /** Busca una cuenta por correo. Regresa null si no existe. Columnas: correo, rol, referencia, hash, sal */
    public String[] buscarUsuario(String correo) {
        SQLiteDatabase db = getReadableDatabase();
        Cursor c = db.rawQuery("SELECT correo, rol, referencia, hash, sal FROM usuarios WHERE correo = ?",
                new String[]{correo.trim().toLowerCase()});
        String[] fila = null;
        if (c.moveToFirst()) {
            fila = new String[]{c.getString(0), c.getString(1), c.getString(2), c.getString(3), c.getString(4)};
        }
        c.close();
        return fila;
    }

    /* ==================== ESTUDIANTES, PROYECTOS Y ALIADOS ==================== */

    /** proyectoId en -1 significa "sin proyecto". */
    public void guardarEstudiante(String matricula, String nombre, String correo, String programa, int generacion,
                                  String frecuencia, String estatus, int proyectoId, String rol) {
        ContentValues v = new ContentValues();
        v.put("matricula", matricula);
        v.put("nombre", nombre);
        v.put("correo", correo);
        v.put("programa", programa);
        v.put("generacion", generacion);
        v.put("frecuencia", frecuencia);
        v.put("estatus", estatus);
        v.put("proyecto_id", proyectoId);
        v.put("rol", rol);
        getWritableDatabase().insertWithOnConflict("estudiantes", null, v, SQLiteDatabase.CONFLICT_REPLACE);
    }

    public void guardarProyecto(int id, String nombre, String descripcion, String ods, String saps, String comunidad,
                                String municipio, int beneficiarios, String inicio, String fin, int color,
                                boolean archivado, boolean buscaApoyo, String objetivosJson) {
        ContentValues v = new ContentValues();
        v.put("id", id);
        v.put("nombre", nombre);
        v.put("descripcion", descripcion);
        v.put("ods", ods);
        v.put("saps", saps);
        v.put("comunidad", comunidad);
        v.put("municipio", municipio);
        v.put("beneficiarios", beneficiarios);
        v.put("inicio", inicio);
        v.put("fin", fin);
        v.put("color", color);
        v.put("archivado", archivado ? 1 : 0);   // SQLite no tiene booleanos: 1 = sí, 0 = no
        v.put("busca_apoyo", buscaApoyo ? 1 : 0);
        v.put("objetivos", objetivosJson);
        getWritableDatabase().insertWithOnConflict("proyectos", null, v, SQLiteDatabase.CONFLICT_REPLACE);
    }

    /** proyectos: ids separados por coma, por ejemplo "1,3,100". */
    public void guardarAliado(int id, String nombre, String tipo, String correo, String proyectos) {
        ContentValues v = new ContentValues();
        v.put("id", id);
        v.put("nombre", nombre);
        v.put("tipo", tipo);
        v.put("correo", correo);
        v.put("proyectos", proyectos);
        getWritableDatabase().insertWithOnConflict("aliados", null, v, SQLiteDatabase.CONFLICT_REPLACE);
    }

    /* ==================== IMPLEMENTACIONES ==================== */

    /** Inserta una implementación y regresa su id (o -1 si falló). */
    public long insertarImplementacion(int proyectoId, String matricula, String tipo, String actividad, String lugar,
                                       String fecha, int beneficiarios, String comentario, String fotoRuta) {
        ContentValues v = new ContentValues();
        v.put("proyecto_id", proyectoId);
        v.put("matricula", matricula);
        v.put("tipo", tipo);
        v.put("actividad", actividad);
        v.put("lugar", lugar);
        v.put("fecha", fecha);               // formato AAAA-MM-DD
        v.put("beneficiarios", beneficiarios);
        v.put("comentario", comentario);
        v.put("foto_ruta", fotoRuta);
        return getWritableDatabase().insert("implementaciones", null, v);
    }

    /* ==================== LECTURA ==================== */

    /**
     * Lee todas las filas de una tabla.
     * Quien llama debe recorrer el Cursor con moveToNext() y cerrarlo con close().
     */
    public Cursor leerTodo(String tabla) {
        return getReadableDatabase().rawQuery("SELECT * FROM " + tabla, null);
    }
}
