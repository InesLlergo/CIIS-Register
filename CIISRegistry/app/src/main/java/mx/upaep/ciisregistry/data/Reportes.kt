package mx.upaep.ciisregistry.data

/* =====================================================================
   Reportes descargables: los mismos que ofrece el sitio web (coord/reportes.php).
   Cada reporte es una tabla (filas y columnas) que se guarda como CSV y se abre en Excel.
   ===================================================================== */

class Reporte(
    val clave: String,
    val titulo: String,
    val descripcion: String,
    val filas: () -> List<List<String>>,
) {
    /** Nombre del archivo, por ejemplo reporte_proyectos_20261127.csv */
    fun archivo(): String = "reporte_${clave}_${Repo.hoy.toString().replace("-", "")}.csv"
}

object Reportes {

    val lista: List<Reporte> get() = listOf(
        Reporte("avance", "Avance por objetivos", "Porcentaje de objetivos cumplidos y evidencias por proyecto.") {
            listOf(listOf("Proyecto", "ODS", "Estatus", "Objetivos", "Cumplidos", "Avance %", "Evidencias")) +
                Repo.proyectos.sortedBy { it.nombre }.map {
                    listOf(it.nombre, it.ods, it.estatus.texto, it.objetivos.size.toString(), it.hechos.toString(),
                        it.avance.toString(), it.evidencias.size.toString())
                }
        },
        Reporte("proyectos", "Proyectos operativos", "Comunidad, beneficiarios, integrantes y aliados de cada proyecto.") {
            listOf(listOf("Proyecto", "Comunidad", "Municipio", "Beneficiarios", "Integrantes", "Aliados", "Inicio", "Fin", "Estatus")) +
                Repo.proyectos.map { p ->
                    listOf(p.nombre, p.comunidad, p.municipio, p.beneficiarios.toString(), Repo.integrantes(p).size.toString(),
                        Repo.aliadosDe(p).joinToString("; ") { it.nombre }, p.inicio.toString(), p.fin?.toString() ?: "",
                        p.estatus.texto)
                }
        },
        Reporte("estudiantes", "Resumen de estudiantes", "Programa, proyecto y mentorías de cada estudiante.") {
            listOf(listOf("Matrícula", "Nombre", "Correo", "Programa", "Estatus", "Proyecto", "Rol", "Mentorías")) +
                Repo.estudiantes.sortedBy { it.matricula }.map { e ->
                    listOf(e.matricula, e.nombre, e.correo, e.programa, e.estatus, Repo.proyecto(e.proyectoId)?.nombre ?: "",
                        e.rol, Repo.mentoriasDe(e.matricula).size.toString())
                }
        },
        Reporte("mentores", "Mentorías por mentor", "Total de mentorías y estudiantes atendidos por cada mentor.") {
            listOf(listOf("Mentor", "Tema", "Total de mentorías", "Estudiantes atendidos")) +
                Repo.mentores.map { m ->
                    val suyas = Repo.mentorias.filter { it.mentor == m.nombre && !it.cancelada }
                    listOf(m.nombre, m.tema, suyas.size.toString(), suyas.map { it.matricula }.distinct().size.toString())
                }
        },
        Reporte("implementaciones", "Implementaciones", "Lo que registraron los alumnos: actividad, lugar, fecha y beneficiarios.") {
            listOf(listOf("Proyecto", "Fecha", "Tipo", "Actividad", "Lugar", "Beneficiarios", "Alumno", "Comentario")) +
                Repo.implementaciones.sortedByDescending { it.fecha }.map { i ->
                    listOf(Repo.proyecto(i.proyectoId)?.nombre ?: "", i.fecha.toString(), i.tipo, i.actividad, i.lugar,
                        i.beneficiarios.toString(), Repo.estudiante(i.matricula)?.nombre ?: i.matricula, i.comentario)
                }
        },
    )
}
