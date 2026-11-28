package mx.upaep.ciisregistry;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.view.View;

import androidx.appcompat.app.AppCompatActivity;

/**
 * MainActivity · Splash
 * Es la primera pantalla de la app: Android la abre al tocar el ícono
 * (en AndroidManifest.xml tiene el intent-filter MAIN / LAUNCHER).
 *
 * Muestra el logo de CIIS Registry sobre fondo rojo, como el splash de ciis-web,
 * y después de un momento usa un INTENT EXPLÍCITO para abrir AppActivity,
 * que empieza en la bienvenida. Tocar la pantalla la salta.
 */
public class MainActivity extends AppCompatActivity {

    private static final String TAG = "CIIS";
    private static final long DURACION_SPLASH = 1600; // ms, igual que la animación del sitio

    private final Handler handler = new Handler(Looper.getMainLooper());
    private final Runnable irABienvenida = new Runnable() {
        @Override
        public void run() {
            abrirApp();
        }
    };
    private boolean abierta = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Log.d(TAG, "MainActivity: onCreate");

        // Listener: tocar el splash lo salta
        View splash = findViewById(R.id.splash);
        splash.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                abrirApp();
            }
        });
    }

    /** Intent explícito: decimos exactamente qué Activity abrir. */
    @SuppressWarnings("deprecation")
    private void abrirApp() {
        if (abierta) return;
        abierta = true;
        handler.removeCallbacks(irABienvenida);

        Intent intent = new Intent();
        String packageName = "mx.upaep.ciisregistry";
        String className = "mx.upaep.ciisregistry.AppActivity";
        intent.setClassName(packageName, className);
        startActivity(intent);
        overridePendingTransition(android.R.anim.fade_in, android.R.anim.fade_out);
        // Cerramos el splash para que "Atrás" no regrese a él
        finish();
    }

    // Ciclo de vida: mensajes en el Logcat (filtrar por "CIIS")
    @Override
    protected void onStart() {
        super.onStart();
        Log.d(TAG, "MainActivity: onStart");
    }

    @Override
    protected void onResume() {
        super.onResume();
        Log.d(TAG, "MainActivity: onResume");
        // El conteo empieza cuando el splash está visible
        if (!abierta) handler.postDelayed(irABienvenida, DURACION_SPLASH);
    }

    @Override
    protected void onPause() {
        super.onPause();
        Log.d(TAG, "MainActivity: onPause");
        // Si el usuario sale durante el splash, no abrimos nada en segundo plano
        handler.removeCallbacks(irABienvenida);
    }

    @Override
    protected void onStop() {
        super.onStop();
        Log.d(TAG, "MainActivity: onStop");
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        Log.d(TAG, "MainActivity: onDestroy");
    }
}
