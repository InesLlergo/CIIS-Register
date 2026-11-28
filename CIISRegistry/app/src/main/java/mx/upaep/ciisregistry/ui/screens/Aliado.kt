package mx.upaep.ciisregistry.ui.screens

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Handshake
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import mx.upaep.ciisregistry.data.Limites
import mx.upaep.ciisregistry.data.Repo
import mx.upaep.ciisregistry.ui.components.Aviso
import mx.upaep.ciisregistry.ui.components.AvisoDialogo
import mx.upaep.ciisregistry.ui.components.BarraSesion
import mx.upaep.ciisregistry.ui.components.BotonPrimario
import mx.upaep.ciisregistry.ui.components.BotonSecundario
import mx.upaep.ciisregistry.ui.components.Contenido
import mx.upaep.ciisregistry.ui.components.Encabezado
import mx.upaep.ciisregistry.ui.components.FilaDato
import mx.upaep.ciisregistry.ui.components.ItemLista
import mx.upaep.ciisregistry.ui.components.Pestanas
import mx.upaep.ciisregistry.ui.components.Tarjeta
import mx.upaep.ciisregistry.ui.components.TarjetaDato
import mx.upaep.ciisregistry.ui.components.TarjetaProyecto
import mx.upaep.ciisregistry.ui.theme.Ciis

/* ---------- SesiónAliado / AliadoProyectos / AliadoApoyos ---------- */
@Composable
fun AliadoHomeScreen(onSalir: () -> Unit, onProyecto: (Int) -> Unit, onApoyoConfirmado: () -> Unit) {
    var tab by rememberSaveable { mutableStateOf(0) }
    Column(Modifier.fillMaxSize().background(Ciis.Fondo)) {
        BarraSesion("aliado", onSalir)
        Pestanas(listOf("General", "Proyectos", "Apoyos"), tab) { tab = it }
        when (tab) {
            0 -> AliadoGeneral(irProyectos = { tab = 1 }, irApoyos = { tab = 2 })
            1 -> AliadoProyectos(onProyecto)
            else -> AliadoApoyos(onApoyoConfirmado)
        }
    }
}

@Composable
private fun AliadoGeneral(irProyectos: () -> Unit, irApoyos: () -> Unit) {
    val a = Repo.aliado
    val mios = Repo.proyectos.filter { it.id in a.proyectos }
    val promedio = if (mios.isEmpty()) 0 else mios.sumOf { it.avance } / mios.size
    val estudiantes = mios.sumOf { Repo.integrantes(it).size }
    Contenido {
        Tarjeta {
            ItemLista(a.nombre, "Tipo de aliado: ${a.tipo}", Icons.Filled.Handshake, Ciis.Azul)
            FilaDato("Correo de contacto", a.correo)
        }
        Row(horizontalArrangement = Arrangement.spacedBy(12.dp)) {
            TarjetaDato(mios.size.toString(), "Proyectos que apoyas", Modifier.weight(1f), Ciis.Rojo)
            TarjetaDato("$promedio%", "Avance promedio", Modifier.weight(1f))
        }
        Row(horizontalArrangement = Arrangement.spacedBy(12.dp)) {
            TarjetaDato(estudiantes.toString(), "Estudiantes en tus proyectos", Modifier.weight(1f))
            TarjetaDato(mios.sumOf { it.beneficiarios }.toString(), "Beneficiarios esperados", Modifier.weight(1f))
        }
        BotonPrimario("Ver proyectos que apoyas", onClick = irProyectos)
        BotonSecundario("Apoyar un proyecto nuevo", onClick = irApoyos)
    }
}

@Composable
private fun AliadoProyectos(onProyecto: (Int) -> Unit) {
    val a = Repo.aliado
    val mios = Repo.proyectos.filter { it.id in a.proyectos }
    Contenido {
        Encabezado("Proyectos que apoyas", "Toca un proyecto para ver su avance.")
        if (mios.isEmpty()) Text("Todavía no apoyas proyectos.", color = Ciis.Suave)
        mios.forEach { p -> TarjetaProyecto(p, onClick = { onProyecto(p.id) }) }
    }
}

@Composable
private fun AliadoApoyos(onConfirmado: () -> Unit) {
    val a = Repo.aliado
    var aviso by remember { mutableStateOf<Aviso?>(null) }
    val limite = Aviso("Límite de ${Limites.PROYECTOS_POR_ALIADO} proyectos", "Este aliado ya apoya ${Limites.PROYECTOS_POR_ALIADO} proyectos, el máximo permitido.")
    Contenido {
        Encabezado("Proyectos que buscan apoyo", "Elige un proyecto para apoyarlo como aliado.")
        val lista = Repo.proyectosQueBuscanApoyo(a)
        if (lista.isEmpty()) Text("Ya apoyas todos los proyectos activos. ¡Gracias!", color = Ciis.Suave)
        lista.forEach { p ->
            TarjetaProyecto(p, pie = {
                BotonPrimario("Apoyar este proyecto") {
                    when {
                        p.id in a.proyectos -> aviso = Aviso("Ya apoyas este proyecto", "Este proyecto ya está en tu lista de proyectos.")
                        a.proyectos.size >= Limites.PROYECTOS_POR_ALIADO -> aviso = limite
                        else -> { a.proyectos.add(p.id); Repo.guardar(); onConfirmado() }
                    }
                }
            })
        }
        Text(
            "Un aliado puede apoyar hasta ${Limites.PROYECTOS_POR_ALIADO} proyectos a la vez.",
            style = MaterialTheme.typography.bodySmall, color = Ciis.Suave,
        )
    }
    AvisoDialogo(aviso) { aviso = null }
}

/* ---------- DetalleProyectoAliado/claro ---------- */
@Composable
fun AliadoDetalleScreen(id: Int, onVolver: () -> Unit) {
    val p = Repo.proyecto(id) ?: return
    Column(Modifier.fillMaxSize().background(Ciis.Fondo)) {
        Contenido { DetalleProyecto(p, "Volver", onVolver) }
    }
}
