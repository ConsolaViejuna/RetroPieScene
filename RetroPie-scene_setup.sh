#!/bin/sh

tempfile1=/tmp/dialog_1_$$
tempfile2=/tmp/dialog_2_$$
tempfile3=/tmp/dialog_3_$$

trap "rm -f $tempfile1 $tempfile2 $tempfile3" 0 1 2 5 15

#-----------------------------
#-- Mensajes de información --
#-----------------------------

#Mensaje de inicio
_msgInicio(){
    dialog --infobox "             RetroPie Script Scene v0.1
                      \n Disfruta la scene Española en tu Raspberry Pi" 4 50 ; sleep 2

}

#Mensaje de información al instalar la enciclopedia homebrew
_msgEnciclopediaHomebrew(){
   dialog --title "Enciclopedia Homebrew" \
          --msgbox "\n Se va a proceder a instalar la categoría Enciclopedia Homebrew en tu
                    \n sistema, donde podrás añadir todos los juegos que aparecen en este libro.
                    \n La Enciclopedia Homebrew es s un libro que nace con la intención de llenar 
                    \n el hueco que hacía falta acerca de todos aquellos videojuegos actuales que 
                    \n se desarrollan para sistemas que ya hace muchos años que dejaron de 
                    \n publicar juegos oficiales. Los creadores de este genial proyecto son Atila, 
                    \n Iván e Ignacio. Más información en: http://www.unpasadomejor.com" 13 80
}

#Mensaje de información al instalar la categoría Mojon Twins
_msgMojonTwins(){
   dialog --title "Mojon Twins" \
          --msgbox "\n Se va a proceder a instalar la categoría Mojon Twins en tu sistema, 
                    \n se añadirán todos los juegos mojoneros de este fantástico grupo de
                    \n desarrolladores.
                    \n The Mojon Twins es un grupo de programadores entusiastas de sistemas
                    \n retro, realizan un porrón de juegos para diferentes sistemas la mar
                    \n de molones, de temática diversa y cómo base el buen humor. Además
                    \n han diseñado diversos motores para hacer juegos y los han puesto
                    \n a disposición de la comunidad.
                    \n Pásate por htpp://www.mojontwins.com y mira que de cosas apañadas
                    \n tienen" 18 80
}

#Mensaje de información al instalar la categoría Esp Soft
_msgEspSoft(){
   dialog --title "Esp Soft" \
          --msgbox "\n Se va a proceder a instalar la categoría Esp Soft en tu sistema, 
                    \n se añadirán todos los juegos de este fantástico grupo de
                    \n desarrolladores.
                    \n Esp Soft  es un grupo de programadores que se fundó en año 2004
                    \n todo empezó en los foros al publicar un tutorial para programar
                    \n juegos en ASM, siguió con la conversión de el famoso juego columns 
                    \n para Amstrad. En su catalogo podemos encontrar desde estupendos
                    \n juegos conversacionales a estupendas aventuras.
                    \n Pásate por http://espsoft.blogspot.com.es y http://www.asmtrad.es
                    \n y conoce más de cerca sus juegos y su historia" 18 80
}

#Mensaje indicando que el tema no se ha instalado
_msgTemaNoInstalado(){
    dialog --title "Error" \
          --msgbox "\n El tema \"Simple\" no está instalado en tu sistema, por favor instala
                    \n este tema a través del script que proporciona RetroPie (RetroPie_setup.sh)" 8 80
}  

#Mensaje indicando que tema "Simple" está instalado
_msgTemaSimpleInstalado(){
    dialog --infobox "El tema \"Simple\" está instalado ..." 3 50 ; sleep 2
}

#Mensaje creando directorios
_msgCreacionDirectorios(){
    dialog --infobox "Ahora se crearán todos los directorios necesarios ..." 3 60
}

#Mensaje directorios creados
_msgCreacionDirectorios(){
    dialog --infobox "Directorios creados ..." 3 60
}

#Mensaje indicando que se necesita ser root para ejecutar el script
_msgNoRoot(){
    dialog --title "Error" \
          --msgbox "\n Este script se deberá de ejecutar con permises de Superusuario" 8 90
}

#-----------------------------
#-- Funciones ----------------
#-----------------------------

_main () {
   
  _msgInicio 
  dialog --title "RetroPie Scene Script by @ConsolaViejuna" \
           --menu "Por favor, elija una opción:" 15 80 5 \
                   1 "Instalar categoría Enciclopedia Hombrew" \
                   2 "Instalar categoría The Mojon Twins y sus juegos" \
		   3 "Instalar categoría Esp Soft y sus juegos" \
                   4 "Salir" 2> $tempfile3

   retv=$?
   choice=$(cat $tempfile3)
   [ $retv -eq 1 -o $retv -eq 255 ] && exit

   case $choice in
       1) _enciclopediaHomebrew
           ;;
       2) _mojonTwins
           ;; 
       3) _msgEspSoft
           ;; 
       4) clear
          _salir ;;

   esac
}

_salir(){
  
  echo "$(date +%H:%M:%S) - Cambiamos permisos a los ficheros" >> log.txt
  sudo chown pi:pi log.txt >> log.txt
  sudo chmod 775 log.txt >> log.txt
  echo "$(date +%H:%M:%S) - Fin" >> log.txt
  exit
}

#Crea los directorios necesarios
_crearDirectorios(){
  
  local dir=$1
  #Comprobamos si existen los directorios si no existen los creamos
  if [ ! -d /etc/emulationstation/themes/simple/$dir/ ];
  then
    date +%H:%M:%S | echo "Se crea directorio $dir en /etc/emulationstation/themes/simple/$dir" >> log.txt 
    mkdir /etc/emulationstation/themes/simple/$dir >> log.txt
  else
    echo "$(date +%H:%M:%S) - El directorio /etc/emulationstation/themes/simple/$dir ya está creado" >> log.txt 
  fi
  
  if [ ! -d /home/pi/RetroPie/roms/$dir/ ];
  then
    echo "$(date +%H:%M:%S) - Se crea directorio $dir en /home/pi/RetroPie/roms/$dir" >> log.txt 
    mkdir /home/pi/RetroPie/roms/$dir >> log.txt
  else
    echo "$(date +%H:%M:%S) - El directorio home/pi/RetroPie/roms/$dir ya está creado" >> log.txt
  fi
}

#Copia los elementos del tema
_copiaElementosTema(){
  echo "$(date +%H:%M:%S) - Copiamos los elementos del tema" >> log.txt  
  local categoria=$1
  sudo cp /home/pi/tmp/$categoria.png /etc/EmulationStation/themes/simple/$categoria/art/
  sudo cp /home/pi/tmp/$categoria_art_blur.jpg /etc/EmulationStation/themes/$categoria/simple/art/
  sudo cp /home/pi/tmp/theme.xml /etc/EmulationStation/themes/$categoria/simple/
}

#Dar permiso a los ficheros descargados
_darPermisos(){
  echo "$(date +%H:%M:%S) - Damos permisos a los ficheros descargados" >> log.txt  
  sudo chown pi /home/pi/tmp/*.* 
  sudo chgrp pi /home/pi/tmp/*.* 
}


#Descarga todos los archivos necesarios para crear la categoría
_descargaElementos(){
  echo "$(date +%H:%M:%S) - Descarga de imágenes para el tema" >> log.txt  
  echo "$(date +%H:%M:%S) - Nos creamos directorio temporal" >> log.txt
  
  #Si el directorio /home/pi/tmp no esta creado, lo creamos
  if [ ! -d /home/pi/tmp/ ];
  then   
    mkdir /home/pi/tmp >> log.txt
  fi
 
  local uri=$1
  local archivos=$2
  local incremento=$((100 / $archivos))
  local porcentaje=$incremento
  (
    while read line
    do 
      wget -q -N -P /home/pi/tmp  $line >> log.txt
      echo $porcentaje
      echo "###"
      echo "$porcentaje %"
      echo "###"
      local porcentaje=$(( $porcentaje + $incremento))
    done < $1
  )|
  dialog --title "Descargando imágenes" --gauge "Por favor espere ...." 10 60 0
  echo "$(date +%H:%M:%S) - Finalizada la descarga" >> log.txt
  _darPermisos
}

_enciclopediaHomebrew(){
   #Mensaje de información
   _msgEnciclopediaHomebrew
 
   #Miramos si está instalado el tema simple  
   if [ -d /etc/emulationstation/themes/simple/ ];
   then
       echo "$(date +%H:%M:%S) Iniciando script ..." >> log.txt
       _msgTemaSimpleInstalado
       _msgCreacionDirectorios
       #Creamos los directorios necesarios
       _crearDirectorios homebrew
       #Descargamos los elementos necesarios del tema
       _descargaElementos homebrewArt.uri 3
       #Copiamos los elementos
       _copiaElementosTema
       #Volvemos al menú principal
       #_main
   else
     _msgTemaNoInstalado
     clear
     exit  
   fi
}

_mojonTwins(){
  #Mensaje de información
  _msgMojonTwins

}

#Ejecución de script
if [ "$(whoami)" != "root" ]; then
  _msgNoRoot
  clear
  exit
else
  _main
fi


