# Remote Airplane Mode Reset

Este proyecto proporciona una forma de restablecer la conexión de red de su dispositivo Android (alternar el modo avión) de forma remota mediante una solicitud HTTP. Está construido alrededor de una macro de MacroDroid que ejecuta un servidor HTTP local en el puerto 8080. Cualquier cliente (por ejemplo, un navegador, curl o un widget de panel) puede enviar una solicitud GET a `http://<ip_del_dispositivo>:8080/plane` para activar la macro.

## Cómo funciona

- La macro inicia un servidor HTTP dentro de MacroDroid.
- Cuando recibe una solicitud en `/plane`, ejecuta una secuencia:
  1. Enciende la pantalla.
  2. Reproduce un sonido de inicio.
  3. Activa el modo avión.
  4. Espera un breve momento.
  5. Desactiva el modo avión.
  6. Vuelve a activar los datos móviles.
  7. Opcionalmente, si la variable local `Punto de acceso` es verdadera, también alterna el punto de acceso Wi‑Fi.
  8. Reproduce un sonido de éxito.

La macro es autónoma y no requiere ninguna aplicación externa además de MacroDroid.

## Instalación

1. **Instale MacroDroid**  
   Obténgalo de [Google Play Store](https://play.google.com/store/apps/details?id=com.arlosoft.macrodroid).

2. **Conceda los permisos necesarios** (ADB hack o Shizuku)  
   La macro necesita permisos elevados para alternar el modo avión y cambiar la configuración del sistema. Elija un método:
   - **ADB Hack** (recomendado)  
     Siga la guía: [ADB Hack – Concesión de capacidades adicionales](https://macrodroidforum.com/index.php?threads/adb-hack-granting-extra-capabilities-via-the-adb-tool.48)  
     Conceda al menos estos permisos:
     - `WRITE_SECURE_SETTINGS`
     - `READ_EXTERNAL_STORAGE`
     - `WRITE_EXTERNAL_STORAGE`
     - `MODIFY_PHONE_STATE`
     - `CHANGE_WIFI_STATE`
     - `CHANGE_NETWORK_STATE`
       > [!note]
       > Puede usar el script bash que se encuentra en `scripts/grant.sh` para mayor comodidad

   - **Shizuku**  
     Consulte esta [guía en video](https://www.youtube.com/watch?v=_WLbhtpC5ls) para usar Shizuku y conceder los mismos permisos.

3. **Descargue el archivo de la macro**  
   Obtenga la última versión desde la página de [GitHub Releases](https://github.com/rodnye/airplane-mode.macrodroid/releases).  
   El archivo contiene un archivo `.macro` y activos de audio opcionales.

4. **Copie la macro a su dispositivo**  
   Coloque el archivo `.macro` (y la carpeta `assets/`, si desea los sonidos) en el directorio:  
   `/sdcard/MacroDroid/`

5. **Importe la macro**  
   Abra MacroDroid, vaya a la pestaña **Macros**, pulse el botón **+** (o **Importar**) y seleccione `Recuperar_conexión.macro`.  
   La macro aparecerá en su lista.

¡Eso es todo! La macro ya está activa y escuchará las solicitudes HTTP.

## Uso

Una vez que la macro esté en ejecución, envíe una solicitud HTTP GET a:

```
http://<ip_de_su_dispositivo>:8080/plane
```

Puede usar:

- Un navegador web en la misma red.
- `curl` desde otro ordenador: `curl http://192.168.1.100:8080/plane`
- El widget genmon opcional (ver más abajo).

La macro responderá con `OK` y realizará la secuencia de restablecimiento.

## Componentes opcionales

### Widget Genmon (panel XFCE)

La carpeta `genmon/` contiene un script (`statusbar.genmon.sh`) que se puede usar con el complemento Genmon en XFCE. Muestra el estado actual del ping y proporciona un icono en el que se puede hacer clic para enviar la señal de restablecimiento.

- El script muestra el tiempo de ping a 8.8.8.8.
- Al hacer clic en el icono, se ejecuta `scripts/signal.service.sh`, que envía la solicitud HTTP y actualiza el estado.
- Requiere que los scripts auxiliares se coloquen en `../scripts/` en relación con el script genmon.

### Scripts auxiliares

El directorio `scripts/` incluye dos scripts bash:

- **ping.service.sh** – Se ejecuta continuamente, hace ping a 8.8.8.8 cada segundo y escribe el resultado en `/dev/shm/ping_output.txt`. El widget genmon lo usa para mostrar la latencia.

- **signal.service.sh** – Envía la solicitud HTTP a la macro usando `curl`. Actualiza un archivo de estado (`/dev/shm/airplanemode_status.txt`) para mostrar "sended" mientras la solicitud está en progreso y "ready" después de completarse. También muestra notificaciones de escritorio mediante `alert`.

Estos scripts están pensados para entornos de escritorio (por ejemplo, Linux con XFCE) y no son necesarios para que la macro funcione.

---

Para más detalles, visite el [repositorio de GitHub](https://github.com/rodnye/airplane-mode.macrodroid).
Follow the guide: [ADB Hack – Granting extra capabilities](https://macrodroidforum.com/index.php?threads/adb-hack-granting-extra-capabilities-via-the-adb-tool.48)  
 Grant at least these permissions: - `WRITE_SECURE_SETTINGS` - `READ_EXTERNAL_STORAGE` - `WRITE_EXTERNAL_STORAGE` - `MODIFY_PHONE_STATE` - `CHANGE_WIFI_STATE` - `CHANGE_NETWORK_STATE`

- **Shizuku**  
  See this [video guide](https://www.youtube.com/watch?v=_WLbhtpC5ls) for using Shizuku to grant the same permissions.

3. **Download the macro file**  
   Get the latest release from the [GitHub Releases](https://github.com/rodnye/airplane-mode.macrodroid/releases) page.  
   The archive contains a `.macro` file and optional audio assets.

4. **Copy the macro to your device**  
   Place the `.macro` file (and the `assets/` folder, if you want sounds) into the directory:  
   `/sdcard/MacroDroid/`

5. **Import the macro**  
   Open MacroDroid, go to the **Macros** tab, tap the **+** (or **Import**) button, and select `Recuperar_conexión.macro`.  
   The macro will appear in your list.

That’s it! The macro is now active and will listen for HTTP requests.

## Usage

Once the macro is running, send an HTTP GET request to:

```
http://<your_device_ip>:8080/plane
```

You can use:

- A web browser on the same network.
- `curl` from another computer: `curl http://192.168.1.100:8080/plane`
- The optional genmon widget (see below).

The macro will respond with `OK` and perform the reset sequence.

## Optional Components

### Genmon Widget (XFCE panel)

The `genmon/` folder contains a script (`statusbar.genmon.sh`) that can be used with the Genmon plugin in XFCE. It shows the current ping status and provides a clickable icon to send the reset signal.

- The script displays the ping time to 8.8.8.8.
- Clicking the icon runs `scripts/signal.service.sh`, which sends the HTTP request and updates the status.
- It requires the helper scripts to be placed in `../scripts/` relative to the genmon script.

### Helper Scripts

The `scripts/` directory includes two bash scripts:

- **ping.service.sh** – Runs continuously, pings 8.8.8.8 every second, and writes the result to `/dev/shm/ping_output.txt`. This is used by the genmon widget to display latency.

- **signal.service.sh** – Sends the HTTP request to the macro using `curl`. It updates a status file (`/dev/shm/airplanemode_status.txt`) to show “sended” while the request is in progress and “ready” after completion. It also shows desktop notifications via `alert`.

These scripts are meant for desktop environments (e.g., Linux with XFCE) and are not required for the macro to function.

---

For more details, visit the [GitHub repository](https://github.com/rodnye/airplane-mode.macrodroid).
