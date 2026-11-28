package mx.upaep.ciisregistry;

import android.Manifest;
import android.app.AlertDialog;
import android.app.DatePickerDialog;
import android.content.ActivityNotFoundException;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.provider.MediaStore;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDate;
import java.util.List;

import mx.upaep.ciisregistry.data.BaseDatos;
import mx.upaep.ciisregistry.data.Estudiante;
import mx.upaep.ciisregistry.data.Implementacion;
import mx.upaep.ciisregistry.data.Proyecto;
import mx.upaep.ciisregistry.data.Repo;
import mx.upaep.ciisregistry.data.Rol;
import mx.upaep.ciisregistry.data.RepoKt;

/**
 * RegistrarImplementacionActivity
 * Pantalla donde el alumno registra una IMPLEMENTACIÓN de su proyecto
 * (lo que hizo el equipo en la comunidad) y sube una foto como evidencia.
 *
 * Se abre desde "Mi perfil" del alumno con un Intent explícito.
 *
 * Usa:
 *  - Listeners: OnClickListener, OnItemSelectedListener, TextWatcher,
 *    OnCheckedChangeListener y OnDateSetListener.
 *  - SQLite: al guardar, inserta la fila en la tabla "implementaciones" (BaseDatos.java)
 *    y guarda la foto como archivo JPG.
 *  - Permisos: al tocar la imagen (o Cámara / Galería) se piden al sistema los permisos
 *    de CÁMARA y de FOTOS con ActivityCompat.requestPermissions().
 *  - Intents implícitos:
 *      * Cámara  -> MediaStore.ACTION_IMAGE_CAPTURE (abre la app de Cámara)
 *      * Galería -> Intent.ACTION_PICK (abre las fotos del teléfono para elegir una)
 */
public class RegistrarImplementacionActivity extends AppCompatActivity {

    // Códigos para saber de dónde regresa la foto en onActivityResult
    private static final int CODIGO_CAMARA = 1;
    private static final int CODIGO_GALERIA = 2;
    private static final int CODIGO_PERMISOS = 3;

    // Qué quería hacer el usuario cuando le pedimos el permiso
    private static final int ACCION_CAMARA = 1;
    private static final int ACCION_GALERIA = 2;
    private static final int ACCION_ELEGIR = 3;
    private int accionPendiente = 0;

    // Vistas del layout
    private Spinner spTipo;
    private EditText etActividad;
    private EditText etLugar;
    private TextView txtFecha;
    private EditText etBeneficiarios;
    private ImageView imgFoto;
    private Button btnCamara;
    private Button btnGaleria;
    private EditText etComentario;
    private TextView txtContador;
    private CheckBox cbConfirmo;
    private Button btnGuardar;
    private Button btnCancelar;
    private TextView txtVolver;

    // Datos que va eligiendo el alumno
    private String tipoElegido;
    private LocalDate fechaElegida = LocalDate.now();
    private Bitmap foto = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_registrar_implementacion);

        // Solo un alumno con sesión puede registrar (si Android cerró la app, la sesión se perdió)
        if (Repo.INSTANCE.getRol() != Rol.ALUMNO) {
            finish();
            return;
        }

        // Revisamos que el alumno tenga proyecto
        Estudiante alumno = Repo.INSTANCE.getAlumno();
        Proyecto proyecto = Repo.INSTANCE.proyecto(alumno.getProyectoId());
        if (proyecto == null) {
            Toast.makeText(this, "Primero necesitas tener un proyecto asignado", Toast.LENGTH_LONG).show();
            finish();
            return;
        }

        // 1) Buscamos cada vista por su id
        spTipo = findViewById(R.id.spTipo);
        etActividad = findViewById(R.id.etActividad);
        etLugar = findViewById(R.id.etLugar);
        txtFecha = findViewById(R.id.txtFecha);
        etBeneficiarios = findViewById(R.id.etBeneficiarios);
        imgFoto = findViewById(R.id.imgFoto);
        btnCamara = findViewById(R.id.btnCamara);
        btnGaleria = findViewById(R.id.btnGaleria);
        etComentario = findViewById(R.id.etComentario);
        txtContador = findViewById(R.id.txtContador);
        cbConfirmo = findViewById(R.id.cbConfirmo);
        btnGuardar = findViewById(R.id.btnGuardar);
        btnCancelar = findViewById(R.id.btnCancelar);
        txtVolver = findViewById(R.id.txtVolver);

        // 2) Datos iniciales
        TextView txtProyecto = findViewById(R.id.txtProyecto);
        txtProyecto.setText("Proyecto: " + proyecto.getNombre());
        etLugar.setText(proyecto.getComunidad());
        txtFecha.setText(RepoKt.fechaLarga(fechaElegida));

        // Si se giró el teléfono, recuperamos la foto que ya se había tomado
        if (savedInstanceState != null) {
            Bitmap guardada = savedInstanceState.getParcelable("foto");
            if (guardada != null) {
                mostrarFoto(guardada);
            }
        }

        // 3) Spinner con los tipos de actividad
        final List<String> tipos = Repo.INSTANCE.getTiposImplementacion();
        tipoElegido = tipos.get(0);
        ArrayAdapter<String> adaptador = new ArrayAdapter<>(this, android.R.layout.simple_spinner_item, tipos);
        adaptador.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spTipo.setAdapter(adaptador);

        spTipo.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                tipoElegido = tipos.get(position);
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {
                // Se queda el tipo anterior
            }
        });

        // 4) Fecha: al tocarla se abre un calendario
        txtFecha.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                abrirCalendario();
            }
        });

        // 5) Botón Cámara -> Intent implícito para tomar foto
        //    Antes de abrirla se pide permiso de CÁMARA al sistema (si no se ha dado)
        btnCamara.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (tienePermiso(Manifest.permission.CAMERA)) {
                    abrirCamara();
                } else {
                    accionPendiente = ACCION_CAMARA;
                    ActivityCompat.requestPermissions(RegistrarImplementacionActivity.this,
                            new String[]{Manifest.permission.CAMERA}, CODIGO_PERMISOS);
                }
            }
        });

        // Tocar el símbolo de la imagen: pide permisos de cámara y galería y deja elegir
        imgFoto.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (tienePermiso(Manifest.permission.CAMERA) && galeriaPermitida()) {
                    mostrarOpcionesFoto();
                } else {
                    accionPendiente = ACCION_ELEGIR;
                    ActivityCompat.requestPermissions(RegistrarImplementacionActivity.this,
                            new String[]{Manifest.permission.CAMERA, permisoGaleria()}, CODIGO_PERMISOS);
                }
            }
        });

        // 6) Botón Galería -> Intent implícito para elegir una foto del teléfono
        //    (como ACTION_VIEW de la clase, pero ACTION_PICK además nos regresa la foto elegida)
        //    Antes de abrirla se pide permiso para ver las FOTOS del teléfono
        btnGaleria.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (galeriaPermitida()) {
                    abrirGaleria();
                } else {
                    accionPendiente = ACCION_GALERIA;
                    ActivityCompat.requestPermissions(RegistrarImplementacionActivity.this,
                            new String[]{permisoGaleria()}, CODIGO_PERMISOS);
                }
            }
        });

        // 7) Contador de caracteres del comentario
        etComentario.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {
            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
            }

            @Override
            public void afterTextChanged(Editable s) {
                txtContador.setText(s.length() + "/200");
            }
        });

        // 8) El botón Guardar solo se activa si marcan la casilla
        cbConfirmo.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                btnGuardar.setEnabled(isChecked);
            }
        });

        // 9) Guardar
        btnGuardar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                guardar();
            }
        });

        // 10) Cancelar y Volver: cierran la pantalla sin guardar
        View.OnClickListener cerrar = new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        };
        btnCancelar.setOnClickListener(cerrar);
        txtVolver.setOnClickListener(cerrar);
    }

    /* ==================== PERMISOS, CÁMARA Y GALERÍA ==================== */

    /** ¿El usuario ya dio este permiso? */
    private boolean tienePermiso(String permiso) {
        return ContextCompat.checkSelfPermission(this, permiso) == PackageManager.PERMISSION_GRANTED;
    }

    /**
     * ¿Podemos ver las fotos? En Android 14 el usuario puede dar acceso solo a
     * "algunas fotos"; eso también cuenta como permitido.
     */
    private boolean galeriaPermitida() {
        if (tienePermiso(permisoGaleria())) return true;
        return Build.VERSION.SDK_INT >= 34
                && tienePermiso("android.permission.READ_MEDIA_VISUAL_USER_SELECTED");
    }

    /** El permiso de la galería cambió de nombre en Android 13. */
    private String permisoGaleria() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            return Manifest.permission.READ_MEDIA_IMAGES;     // Android 13 o más nuevo
        }
        return Manifest.permission.READ_EXTERNAL_STORAGE;     // Android 8 a 12
    }

    /**
     * Android responde aquí después de la ventanita de "¿Permitir...?".
     * Si el usuario aceptó, hacemos lo que había pedido (cámara, galería o elegir).
     */
    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode != CODIGO_PERMISOS) return;

        boolean camara = tienePermiso(Manifest.permission.CAMERA);
        boolean galeria = galeriaPermitida();

        if (accionPendiente == ACCION_CAMARA && camara) {
            abrirCamara();
        } else if (accionPendiente == ACCION_GALERIA && galeria) {
            abrirGaleria();
        } else if (accionPendiente == ACCION_ELEGIR && (camara || galeria)) {
            mostrarOpcionesFoto();
        } else {
            Toast.makeText(this, "Sin permiso no se puede agregar la foto. Puedes activarlo en Ajustes > Apps > CIIS Registry > Permisos.",
                    Toast.LENGTH_LONG).show();
        }
        accionPendiente = 0;
    }

    /** Ventana para elegir de dónde sale la foto del proyecto. */
    private void mostrarOpcionesFoto() {
        String[] opciones = {"Tomar foto con la cámara", "Elegir de la galería"};
        new AlertDialog.Builder(this)
                .setTitle("Foto del proyecto")
                .setItems(opciones, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int cual) {
                        if (cual == 0) {
                            btnCamara.performClick();   // revisa el permiso de cámara
                        } else {
                            btnGaleria.performClick();  // revisa el permiso de galería
                        }
                    }
                })
                .setNegativeButton("Cancelar", null)
                .show();
    }

    /** Intent implícito: abre la app de Cámara. */
    private void abrirCamara() {
        Intent intent = new Intent();
        intent.setAction(MediaStore.ACTION_IMAGE_CAPTURE); // Tomar foto
        try {
            startActivityForResult(intent, CODIGO_CAMARA);
        } catch (ActivityNotFoundException e) {
            Toast.makeText(this, "No hay app de cámara", Toast.LENGTH_SHORT).show();
        }
    }

    /** Intent implícito: abre la galería para elegir una foto. */
    private void abrirGaleria() {
        Intent intent = new Intent();
        intent.setAction(Intent.ACTION_PICK); // Elegir
        intent.setData(MediaStore.Images.Media.EXTERNAL_CONTENT_URI); // fotografías del móvil
        try {
            startActivityForResult(intent, CODIGO_GALERIA);
        } catch (ActivityNotFoundException e) {
            Toast.makeText(this, "No hay app de galería", Toast.LENGTH_SHORT).show();
        }
    }

    /** Abre el calendario del sistema para elegir la fecha. */
    private void abrirCalendario() {
        DatePickerDialog dialogo = new DatePickerDialog(this, new DatePickerDialog.OnDateSetListener() {
            @Override
            public void onDateSet(DatePicker view, int anio, int mes, int dia) {
                // El mes llega de 0 a 11, por eso sumamos 1
                fechaElegida = LocalDate.of(anio, mes + 1, dia);
                txtFecha.setText(RepoKt.fechaLarga(fechaElegida));
            }
        }, fechaElegida.getYear(), fechaElegida.getMonthValue() - 1, fechaElegida.getDayOfMonth());

        // No se permiten fechas futuras: la implementación ya ocurrió
        dialogo.getDatePicker().setMaxDate(System.currentTimeMillis());
        dialogo.show();
    }

    /** Aquí regresan la Cámara y la Galería con la foto. */
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode != RESULT_OK || data == null) {
            return; // El usuario regresó sin elegir foto
        }

        if (requestCode == CODIGO_CAMARA && data.getExtras() != null) {
            // La cámara regresa una foto pequeña en el extra "data"
            Bitmap tomada = (Bitmap) data.getExtras().get("data");
            if (tomada != null) {
                mostrarFoto(tomada);
            }
        } else if (requestCode == CODIGO_GALERIA && data.getData() != null) {
            // La galería regresa la dirección (Uri) de la foto elegida
            Bitmap elegida = leerFoto(data.getData());
            if (elegida != null) {
                mostrarFoto(elegida);
            } else {
                Toast.makeText(this, "No se pudo abrir la foto", Toast.LENGTH_SHORT).show();
            }
        }
    }

    /** Lee la foto de la galería en tamaño reducido para no gastar memoria. */
    private Bitmap leerFoto(Uri uri) {
        try {
            BitmapFactory.Options opciones = new BitmapFactory.Options();
            opciones.inSampleSize = 4; // 4 veces más pequeña
            InputStream entrada = getContentResolver().openInputStream(uri);
            Bitmap bitmap = BitmapFactory.decodeStream(entrada, null, opciones);
            if (entrada != null) {
                entrada.close();
            }
            return bitmap;
        } catch (Exception e) {
            return null;
        }
    }

    /** Muestra la foto en el ImageView. */
    private void mostrarFoto(Bitmap bitmap) {
        foto = bitmap;
        imgFoto.setScaleType(ImageView.ScaleType.CENTER_CROP); // la foto llena el cuadro
        imgFoto.setImageBitmap(bitmap);
    }

    /** Guarda la foto si se gira el teléfono (la pantalla se vuelve a crear). */
    @Override
    protected void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);
        if (foto != null) {
            outState.putParcelable("foto", foto);
        }
    }

    /**
     * Guarda el Bitmap como archivo JPG en getFilesDir() y regresa su ruta.
     * En SQLite solo se guarda la ruta (texto), no la imagen completa.
     */
    private String guardarFotoEnArchivo(Bitmap bitmap) {
        File archivo = new File(getFilesDir(), "implementacion_" + System.currentTimeMillis() + ".jpg");
        try {
            FileOutputStream salida = new FileOutputStream(archivo);
            bitmap.compress(Bitmap.CompressFormat.JPEG, 90, salida);
            salida.close();
            return archivo.getAbsolutePath();
        } catch (IOException e) {
            return null;
        }
    }

    /** Revisa los campos y guarda la implementación en SQLite. */
    private void guardar() {
        String actividad = etActividad.getText().toString().trim();
        String lugar = etLugar.getText().toString().trim();
        String textoBeneficiarios = etBeneficiarios.getText().toString().trim();
        String comentario = etComentario.getText().toString().trim();

        if (actividad.isEmpty()) {
            etActividad.setError("Escribe qué hicieron");
            return;
        }
        if (lugar.isEmpty()) {
            etLugar.setError("Escribe el lugar");
            return;
        }
        if (textoBeneficiarios.isEmpty() || Integer.parseInt(textoBeneficiarios) <= 0) {
            etBeneficiarios.setError("Escribe cuántas personas");
            return;
        }
        if (foto == null) {
            Toast.makeText(this, "Agrega la foto del proyecto (toca la imagen)", Toast.LENGTH_SHORT).show();
            return;
        }

        int beneficiarios = Integer.parseInt(textoBeneficiarios);
        Estudiante alumno = Repo.INSTANCE.getAlumno();
        Proyecto proyecto = Repo.INSTANCE.proyecto(alumno.getProyectoId());
        if (proyecto == null) {
            Toast.makeText(this, "No tienes proyecto asignado", Toast.LENGTH_SHORT).show();
            return;
        }

        // 1) La foto se guarda como archivo JPG en la carpeta privada de la app
        String rutaFoto = guardarFotoEnArchivo(foto);

        // 2) Se inserta la fila en la tabla "implementaciones" de SQLite
        BaseDatos db = new BaseDatos(this);
        long id = db.insertarImplementacion(
                proyecto.getId(), alumno.getMatricula(), tipoElegido, actividad, lugar,
                fechaElegida.toString(), beneficiarios, comentario, rutaFoto);
        db.close();

        if (id == -1) {
            Toast.makeText(this, "No se pudo guardar", Toast.LENGTH_SHORT).show();
            return;
        }

        // 3) Se agrega a la lista de la app para que aparezca en el perfil, Progreso y el detalle del proyecto
        Implementacion nueva = new Implementacion((int) id, proyecto.getId(), alumno.getMatricula(), tipoElegido,
                actividad, lugar, fechaElegida, beneficiarios, comentario, foto);
        Repo.INSTANCE.agregarImplementacion(nueva);

        Toast.makeText(this, "¡Implementación registrada!", Toast.LENGTH_LONG).show();
        finish(); // Regresa a "Mi perfil"
    }
}
