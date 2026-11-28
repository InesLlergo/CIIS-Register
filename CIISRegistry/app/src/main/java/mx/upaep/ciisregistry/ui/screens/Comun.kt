package mx.upaep.ciisregistry.ui.screens

import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.CheckBox
import androidx.compose.material.icons.filled.CheckBoxOutlineBlank
import androidx.compose.material.icons.filled.Event
import androidx.compose.material.icons.filled.Handshake
import androidx.compose.material.icons.filled.Person
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.asImageBitmap
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import mx.upaep.ciisregistry.data.Evidencia
import mx.upaep.ciisregistry.data.Implementacion
import mx.upaep.ciisregistry.data.Objetivo
import mx.upaep.ciisregistry.data.Proyecto
import mx.upaep.ciisregistry.data.Repo
import mx.upaep.ciisregistry.data.fechaCorta
import mx.upaep.ciisregistry.data.fechaLarga
import mx.upaep.ciisregistry.ui.components.BarraAvance
import mx.upaep.ciisregistry.ui.components.ChipEstatus
import mx.upaep.ciisregistry.ui.components.Encabezado
import mx.upaep.ciisregistry.ui.components.FilaDato
import mx.upaep.ciisregistry.ui.components.ItemLista
import mx.upaep.ciisregistry.ui.components.Tarjeta
import mx.upaep.ciisregistry.ui.components.TituloSeccion
import mx.upaep.ciisregistry.ui.theme.Ciis

/** DetalleProyecto/claro y DetalleProyectoAliado/claro (mismo contenido). */
@Composable
fun DetalleProyecto(p: Proyecto, volver: String, onVolver: () -> Unit) {
    Encabezado(p.nombre, p.descripcion, volver = volver, onVolver = onVolver)
    // Foto del proyecto (como en el sitio web): la evidencia más reciente o el color del proyecto
    Box(
        Modifier.fillMaxWidth().aspectRatio(16f / 9f).clip(RoundedCornerShape(16.dp)).background(p.color),
        contentAlignment = Alignment.Center,
    ) {
        val foto = p.fotoProyecto
        if (foto != null) Image(foto.asImageBitmap(), "Foto del proyecto", contentScale = ContentScale.Crop, modifier = Modifier.fillMaxSize())
        else Text("Aún sin foto del proyecto", color = androidx.compose.ui.graphics.Color.White, fontWeight = FontWeight.SemiBold)
    }
    TarjetaAvance(p)
    Tarjeta {
        TituloSeccion("Datos del proyecto")
        FilaDato("ODS", p.ods)
        FilaDato("Clasificación SAPS", p.saps)
        FilaDato("Estatus", p.estatus.texto)
    }
    TarjetaImplementacion(p)
    Tarjeta {
        TituloSeccion("Participantes")
        val integ = Repo.integrantes(p)
        if (integ.isEmpty()) Text("Sin integrantes todavía.", color = Ciis.Suave)
        integ.forEach { ItemLista(it.nombre, "${it.rol} · ${it.matricula}", Icons.Filled.Person) }
    }
    Tarjeta {
        TituloSeccion("Aliados")
        val al = Repo.aliadosDe(p)
        if (al.isEmpty()) Text("Este proyecto aún no tiene aliados.", color = Ciis.Suave)
        al.forEach { ItemLista(it.nombre, "Tipo de aliado: ${it.tipo}", Icons.Filled.Handshake, Ciis.Azul) }
    }
    Tarjeta {
        TituloSeccion("Mentorías")
        val ms = Repo.mentoriasDeProyecto(p)
        if (ms.isEmpty()) Text("Sin mentorías registradas.", color = Ciis.Suave)
        ms.forEach { ItemLista(fechaLarga(it.fecha) + " · " + it.hora, "${it.mentor} · ${it.tema}", Icons.Filled.Event, Ciis.Ambar) }
    }
    Tarjeta {
        TituloSeccion("Implementaciones registradas")
        val imps = Repo.implementacionesDe(p)
        if (imps.isEmpty()) Text("El equipo aún no registra implementaciones.", color = Ciis.Suave)
        else ListaImplementaciones(imps)
    }
    if (p.evidencias.isNotEmpty()) Tarjeta {
        TituloSeccion("Evidencias")
        GaleriaEvidencias(p.evidencias)
    }
}

@Composable
fun TarjetaAvance(p: Proyecto) {
    Tarjeta {
        Row(verticalAlignment = Alignment.CenterVertically) {
            TituloSeccion("Avance", Modifier.weight(1f))
            ChipEstatus(p.estatus)
        }
        Text("${p.avance}%", style = MaterialTheme.typography.headlineLarge, color = Ciis.Rojo)
        BarraAvance(p.avance)
        Text("${p.hechos} de ${p.objetivos.size} objetivos · ${p.periodo}", style = MaterialTheme.typography.bodySmall, color = Ciis.Suave)
    }
}

@Composable
fun TarjetaImplementacion(p: Proyecto) {
    Tarjeta {
        TituloSeccion("Implementación")
        FilaDato("Comunidad", p.comunidad)
        FilaDato("Municipio", p.municipio)
        FilaDato("Beneficiarios", p.beneficiarios.toString())
        FilaDato("Inicio", fechaCorta(p.inicio))
        FilaDato("Fin", p.fin?.let { fechaCorta(it) } ?: "Sin definir")
    }
}

@Composable
fun FilaObjetivo(o: Objetivo, n: Int, editable: Boolean) {
    Row(
        Modifier.fillMaxWidth().clip(RoundedCornerShape(10.dp))
            .then(if (editable) Modifier.background(Ciis.Fondo) else Modifier),
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Icon(
            if (o.cumplido) Icons.Filled.CheckBox else Icons.Filled.CheckBoxOutlineBlank, null,
            tint = if (o.cumplido) Ciis.Verde else Ciis.Suave, modifier = Modifier.size(26.dp),
        )
        Spacer(Modifier.width(10.dp))
        Column(Modifier.weight(1f)) {
            Text("Objetivo $n · ${if (o.cumplido) "cumplido" else "pendiente"}", style = MaterialTheme.typography.bodySmall, color = Ciis.Suave)
            Text(o.texto, fontWeight = FontWeight.SemiBold)
        }
    }
}

@Composable
fun GaleriaEvidencias(lista: List<Evidencia>) {
    lista.reversed().chunked(2).forEach { fila ->
        Row(horizontalArrangement = Arrangement.spacedBy(10.dp)) {
            fila.forEach { e ->
                Column(Modifier.weight(1f)) {
                    Box(
                        Modifier.fillMaxWidth().aspectRatio(1f).clip(RoundedCornerShape(12.dp)).background(Ciis.Borde),
                        contentAlignment = Alignment.Center,
                    ) {
                        if (e.foto != null) Image(e.foto.asImageBitmap(), e.comentario, contentScale = ContentScale.Crop, modifier = Modifier.fillMaxSize())
                    }
                    Text(e.comentario.ifBlank { "Sin comentario" }, style = MaterialTheme.typography.bodySmall, maxLines = 2)
                    Text("${e.autor} · ${fechaCorta(e.fecha)}", style = MaterialTheme.typography.bodySmall, color = Ciis.Suave)
                }
            }
            if (fila.size == 1) Spacer(Modifier.weight(1f))
        }
    }
}

/** Lista de implementaciones con su foto en miniatura (se usa en alumno, aliado y coordinador). */
@Composable
fun ListaImplementaciones(lista: List<Implementacion>) {
    lista.forEach { imp ->
        Row(
            Modifier.fillMaxWidth().clip(RoundedCornerShape(12.dp)).background(Ciis.Fondo).padding(10.dp),
            verticalAlignment = Alignment.CenterVertically,
        ) {
            Box(Modifier.size(56.dp).clip(RoundedCornerShape(10.dp)).background(Ciis.Borde), contentAlignment = Alignment.Center) {
                if (imp.foto != null) Image(imp.foto.asImageBitmap(), imp.actividad, contentScale = ContentScale.Crop, modifier = Modifier.fillMaxSize())
            }
            Spacer(Modifier.width(12.dp))
            Column(Modifier.weight(1f)) {
                Text(imp.actividad, fontWeight = FontWeight.SemiBold, maxLines = 2)
                Text("${imp.tipo} · ${imp.lugar}", style = MaterialTheme.typography.bodySmall, color = Ciis.Suave)
                Text("${fechaCorta(imp.fecha)} · ${imp.beneficiarios} personas", style = MaterialTheme.typography.bodySmall, color = Ciis.Suave)
                if (imp.comentario.isNotBlank()) Text("“${imp.comentario}”", style = MaterialTheme.typography.bodySmall, maxLines = 2)
            }
        }
    }
}
