# RetroPieScene
Script para añadir la scene española de juegos retro para sistemas antiguos.

Requisitos:
-----------
- Raspberry Pi
- Retropie 3.6
- Conexión a internet
- Linux

Ejecución para Raspberry Pi:
----------------------------
- Cierra el interfaz EmulationsStation (Quit EmulationStation).
- Conectaté por ssh o ejecuta las siguientes instrucciones:
- git clone https://github.com/ConsolaViejuna/RetroPieScene.git
- cd RetroPieScene
- sudo ./RetroPie-scene_setup.sh
- Si ya tienes el script descargado entra en el script y actualiza el script (Hay una opción de menú, automáticamente se recarga).

Ejecución en Linux:
-------------------
- Deberás de tener instalado RetroPie en Linux, RetroPie debe quedar instalado en el home de la forma ~/RetroPie/
- Para instalar en Linux: https://github.com/retropie/retropie-setup/wiki/RetroPie-Ubuntu-15.10-x86-Flavor
- Cierra el interfaz EmulationsStation (Quit EmulationStation).
- git clone https://github.com/ConsolaViejuna/RetroPieScene.git
- cd RetroPieScene
- sudo ./RetroPie-scene_setup.sh nombreDeUsuario
- Si ya tienes el script descargado entra en el script y actualiza el script (Hay una opción de menú, automáticamente se recarga).

Histórico de cambios:
---------------------

v 0.3.1
--------
 - Se soluciona problema con el home en debian

v 0.3.0
--------
 - Se añade categoría Esp Soft con sus juegos y su descripción.
 - Se habilita el script para instalar en linux.

v 0.2.2
--------
 - Se soluciona problema al actualizar el script.

v 0.2
------
 - Versión incial del es script
 - Se añade opción instalar categoría enciclopedia hombrew
 - Se añade opción actualizar el scrip
