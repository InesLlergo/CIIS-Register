<div align="center">

# 🔴 🟡 ⬛ Sistema de Gestión e Impacto Social - BD CIIS App (UPAEP)

![UPAEP Theme](https://img.shields.io/badge/UI%20Theme-Red%20%7C%20Yellow%20%7C%20Dark-DC2626?style=for-the-badge)
![Status](https://img.shields.io/badge/Estado-En%20Desarrollo-F59E08?style=for-the-badge)
![Platform](https://img.shields.io/badge/Plataforma-Android%20%7C%20Web-111827?style=for-the-badge&logo=android)
![Database](https://img.shields.io/badge/Base%20de%20Datos-MySQL-blue?style=for-the-badge&logo=mysql)

---

### 📌 *Plataforma de seguimiento y trazabilidad de proyectos comunitarios, estudiantes y mentorías institucionales UPAEP.*

</div>

---

##  Descripción General

La **BD CIIS App** es una plataforma institucional diseñada para la gestión, acompañamiento y evaluación de proyectos de impacto social en comunidades. Su objetivo principal es optimizar los procesos administrativos, reducir el uso de papeleo en un **75%**, centralizar el flujo de información y ofrecer herramientas avanzadas de trazabilidad de datos sociodemográficos y rendimiento estudiantil.

---

##  Paleta de Colores Institucional

El diseño de la interfaz y la representación del estado de los proyectos (sistema de semáforo) se basa estrictamente en la identidad visual UPAEP:

| Color | Hexadecimal | Aplicación / Indicador |
| :--- | :--- | :--- |
| 🔴 **Rojo** | `#DC2626` | Alertas, estados críticos y acento primario |
| 🟡 **Amarillo** | `#F59E08` | Advertencias, tareas pendientes y transiciones |
| ⬛ **Negro / Oscuro** | `#111827` | Fondos de alto contraste, headers y texto principal |
| 🩶 **Gris** | `#4B5563` | Elementos secundarios y estados inactivosa |

---

## Modelo de Entidad-Relación (E-R)

El sistema administra la relación entre **Estudiantes**, **Proyectos**, **Comunidades**, **Aliados**, **Programas** y **Mentorías**.

```
 +------------------+        +-------------------+        +--------------------+
 |    ESTUDIANTE    |------->|     PARTICIPAR    |<-------|      PROYECTO      |
 +------------------+        +-------------------+        +--------------------+
          |                                                         |
          v                                                         v
 +------------------+                                     +--------------------+
 |    MENTORÍA      |                                     |     COMUNIDAD      |
 +------------------+                                     +--------------------+
```

---

## Requerimientos No Funcionales (RNF)

<details>
<summary><b>🔍 Haz clic para ver los Requerimientos No Funcionales</b></summary>

<br>

| Categoría | Especificación |
| :--- | :--- |
| **Protección y Acceso** | Uso de acuerdos de privacidad. Autenticación mediante roles (Coordinador, Alumno, General). |
| **Rendimiento** | Reducción del papeleo en un 75%. Generación de reportes consolidados en menos de 5 minutos. |
| **Capacidad** | Soporte para **100 alumnos por semestre** y volumen dinámico de proyectos (Activos, Inactivos, Retomados). |
| **Usabilidad & UI** | Interfaz intuitiva basada en estándares de Google Calendar y alineada a la identidad visual UPAEP. |
| **Compatibilidad Móvil** | App nativa para **Android** con diseño adaptable a múltiples resoluciones de pantalla. |
| **Conectividad** | Tolerancia a fallos de red. Modo offline con almacenamiento local para trabajo de campo. |
| **Infraestructura** | Presupuesto cero. Integración directa con MySQL mediante API sin alterar el esquema base. |

</details>

---

##  Requerimientos Funcionales (RF)

###  1. Autenticación y Control de Acceso
* **RF01 - Inicio de Sesión por Roles:** Validación directa en MySQL.
* **RF02 - Restricción de Visibilidad:**
  *  **Coordinador:** Acceso total y control global.
  *  **Alumno:** Edición y seguimiento exclusivo de su proyecto asignado.
  *  **General:** Vista pública limitada a metas cumplidas e impacto social.
* **RF03 - Cierre de Sesión Seguro:** Salida limpia para resguardar información fuera de la red campus.

###  2. Gestión de Proyectos
* **RF04 - Captura Simplificada:** Formularios interactivos con botones y desplegables para evitar duplicidad de datos.
* **RF05 - Validación de Campos:** Alertas en tiempo real (*warnings*) sobre campos obligatorios omitidos.
* **RF06 - Control de Ciclo de Vida:** Control de fases (*Activo, No activo, Retomado, Concluido*).
* **RF07 - Asignación de Estudiantes:** Vinculación directa de alumnos a proyectos específicos.
* **RF08 - Datos Sociodemográficos:** Registro por municipio, comunidad y tipo/número de beneficiarios.

###  3. Tracking y Tableros
* **RF09 - Dashboard Principal:** Centro de mando visual para estatus general y avance.
* **RF10 - Indicadores Visuales:** Sistema de semáforo con los colores institucionales (`#DC2626`, `#F59E08`, `#111827`, `#4B5563`).
* **RF11 - Calendario Integrado:** Agenda cronológica estilo *Google Calendar*.

###  4. Consultas y Reportabilidad
* **RF12 - Exclusividad de Reportes:** Permisos exclusivos de emisión de reportes asignados a la coordinación.
* **RF13 - Generación Acelerada:** Reportes consolidados listos en menos de 5 minutos.
* **RF14 - Buscador y Filtros Rápidos:** Búsquedas avanzadas por municipio, comunidad, beneficiario y periodo semestral.

###  5. Operatividad Móvil
* **RF15 - Modo Offline:** Almacenamiento local para zonas rurales o trabajo de campo sin internet, sincronizando automáticamente al recuperar señal.
* **RF16 - Diseño Responsivo:** Adaptación gráfica a cualquier tamaño de pantalla Android.

---

<div align="center">

###  UPAEP - Centro de Impacto e Impacto Social (CIIS)

</div>
