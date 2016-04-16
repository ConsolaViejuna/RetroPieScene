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
    dialog --infobox "             RetroPie Script Scene v0.2
                      \n Disfruta la scene Española en tu Raspberry Pi" 4 50 ; sleep 2

}

#Mensaje de información al instalar la enciclopedia homebrew
_msgEnciclopediaHomebrew(){
   dialog --title "Enciclopedia Homebrew" \
          --msgbox "Se va a proceder a instalar la categoría Enciclopedia Homebrew en tu sistema, donde podrás añadir todos los juegos que aparecen en este libro. La Enciclopedia Homebrew es un libro que nace con la intención de llenar el hueco que hacía falta acerca de todos aquellos videojuegos actuales que se desarrollan para sistemas que ya hace muchos años que dejaron de publicar juegos oficiales. Los creadores de este genial proyecto son @blackmores_ de un pasado mejor IvánZX de ZxDev15 e @ignprigar de pb48k." 0 0
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

#Mensaje creando nueva categoria
_msgCreacionCategoria(){
    dialog --infobox "Se ha creado una nueva categoría en Emulationstation ..." 3 60
}

#Mensaje de finalizacion
_msgFin(){
  local descripcion="$1"
  dialog --title "Trabajo finalizado" \
  --msgbox "\n Se ha terminado de instalar la categoría $descripcion,
            \n ahora inicia Emulation Station para disfrutar" 0 0
}

#Mensaje directorios creados
_msgActualizarScript(){
    dialog --infobox "Actualizando script ..." 4 40
}

#-------------------- FIN MENSAJES DE INFORMACIÓN --------------
#---------------------------------------------------------------



#-----------------------UTILIDADES ----------------------------
_actualizarScript(){
  _msgActualizarScript
  git pull >> log.txt
}


#-------------------- FIN UTILIDADES ---------------------------
#---------------------------------------------------------------



#-----------------------AÑADIR ROMS ----------------------------

#Copia las roms y los archivos .sh
_copiaRoms(){
  local categoria=$1
  local extension=$2
  echo "$(date +%H:%M:%S) - Copiamos los archivos .$extension" >> log.txt  
  cp /home/pi/tmp/*.$extension /home/pi/RetroPie/roms/$categoria
  echo "$(date +%H:%M:%S) - Terminamos de copiar los archivos .$extension" >> log.txt  
  chown pi /home/pi/RetroPie/roms/$categoria/*.*
  chgrp pi /home/pi/RetroPie/roms/$categoria/*.*

  _borrarTemporales
}

#-------------------- FIN AÑADIR ROMS --------------------------
#---------------------------------------------------------------




#------------ CONFIGURAR TEMA EN EMULATION STATION -------------

#Crea los directorios necesarios
_crearDirectorios(){
  
  local dir=$1
  #Comprobamos si existen los directorios si no existen los creamos
  if [ ! -d /etc/emulationstation/themes/simple/$dir/ ];
  then
    date +%H:%M:%S | echo "Se crea directorio $dir en /etc/emulationstation/themes/simple/$dir" >> log.txt 
    mkdir /etc/emulationstation/themes/simple/$dir
  else
    echo "$(date +%H:%M:%S) - El directorio /etc/emulationstation/themes/simple/$dir ya está creado" >> log.txt 
  fi
  
  if [ ! -d /etc/emulationstation/themes/simple/$dir/art/ ];
  then
    date +%H:%M:%S | echo "Se crea directorio art en /etc/emulationstation/themes/simple/$dir" >> log.txt 
    mkdir /etc/emulationstation/themes/simple/$dir/art 
  else
    echo "$(date +%H:%M:%S) - El directorio /etc/emulationstation/themes/simple/$dir/art ya está creado" >> log.txt 
  fi
  
  if [ ! -d /home/pi/RetroPie/roms/$dir/ ];
  then
    echo "$(date +%H:%M:%S) - Se crea directorio $dir en /home/pi/RetroPie/roms/$dir" >> log.txt 
    mkdir /home/pi/RetroPie/roms/$dir >> log.txt
    sudo chown pi homebrew/
    sudo chgrp pi homebrew/
  else
    echo "$(date +%H:%M:%S) - El directorio home/pi/RetroPie/roms/$dir ya está creado" >> log.txt
  fi
}

#Copia los elementos del tema
_copiaElementosTema(){
  echo "$(date +%H:%M:%S) - Copiamos los elementos del tema" >> log.txt  
  local categoria=$1
  local filename="_art_blur.jpg"
  cp /home/pi/tmp/$categoria.png /etc/emulationstation/themes/simple/$categoria/art/ 
  cp /home/pi/tmp/$categoria$filename /etc/emulationstation/themes/simple/$categoria/art 
  cp /home/pi/tmp/theme.xml /etc/emulationstation/themes/simple/$categoria 
  echo "$(date +%H:%M:%S) - Terminamos de copiar los elementos" >> log.txt  
  _borrarTemporales
}

#Dar permiso a los ficheros descargados
_darPermisos(){
  echo "$(date +%H:%M:%S) - Damos permisos a los ficheros descargados" >> log.txt  
  sudo chown pi /home/pi/tmp/*.* 
  sudo chgrp pi /home/pi/tmp/*.* 
  sudo chmod 777 /home/pi/tmp/*.*
}  

#Borramos fiheros temporales
_borrarTemporales(){
  echo "$(date +%H:%M:%S) - Borramos ficheros temporales" >> log.txt  
  sudo rm /home/pi/tmp/*.*
  sudo rmdir /home/pi/tmp
}

#Descarga todos los archivos necesarios para crear la categoría
_descargaElementos(){
  local elemento="$3"
  echo "$(date +%H:%M:%S) - Descarga de $elemento para el tema" >> log.txt  
  echo "$(date +%H:%M:%S) - Nos creamos directorio temporal" >> log.txt
  
  #Si el directorio /home/pi/tmp no esta creado, o creamos
  if [ ! -d /home/pi/tmp/ ];
  then   
    mkdir /home/pi/tmp 
  fi
 
  local uri="$1"
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
    done < "$1"
  )|
  dialog --title "Descargando $elemento" --gauge "Por favor espere ...." 10 60 0
  echo "$(date +%H:%M:%S) - Finalizada la descarga" >> log.txt
  _darPermisos
}


#------------ FIN CONFIGURAR TEMA EN EMULATION STATION ------------------
#------------------------------------------------------------------------



#------------ AÑADIR NUEVA CATEGORÍA A EMULATIONSTATION------------------

_modificaCfg(){
  local categoria=$1
  local nombreCategoria="$2"
  echo $categoria
  echo "$nombreCategoria"
  if ! grep -q $categoria "/etc/emulationstation/es_systems.cfg" ; then
    echo "$(date +%H:%M:%S) - Añadimos categoria al fichero es_system.cfg" >> log.txt
CONTENT='         <system>\
            <name>'"$categoria"'</name>\
            <fullname>'"$descripcion"'</fullname>\
            <path>/home/pi/RetroPie/roms/'"$categoria"'</path>\
            <extension>.sh .SH</extension>\
            <command>%ROM%</command>\
            <platform>pc</platform>\
            <theme></theme>\
            <directlaunch/>\
         </system>'

  sed -i '/<\/systemList>/i\'"$CONTENT" /etc/emulationstation/es_systems.cfg
  echo "$(date +%H:%M:%S) - Fin de la modificación del fichero de configuración" >> log.txt
  else
   echo "$(date +%H:%M:%S) - Se ha añadido la categoría con anterioridad" >> log.txt
  fi
  _msgCreacionCategoria
 }

#-----------FIN AÑADIR NUEVA CATEGORÍA A EMULATIONSTATION ---------------
#------------------------------------------------------------------------


#------------- OPERACIONES SOBRE EL MENÚ --------------------------------

#Muestra el menú principal
_main () {
   
  _msgInicio 
  dialog --title "RetroPie Scene Script by @ConsolaViejuna" \
           --menu "Por favor, elija una opción:" 15 80 5 \
                   1 "Instalar categoría Enciclopedia Hombrew" \
                   2 "Actualizar script" \
                   3 "Salir" 2> $tempfile3

   retv=$?
   choice=$(cat $tempfile3)
   [ $retv -eq 1 -o $retv -eq 255 ] && exit

   case $choice in
       1) _enciclopediaHomebrew
          _main
           ;;
       2)_actualizarScript
         _main
           ;;
       3) clear
          _salir ;;

   esac
}

#Salir del menú
_salir(){
  
  echo "$(date +%H:%M:%S) - Cambiamos permisos a los ficheros" >> log.txt
  sudo chown pi:pi log.txt >> log.txt
  sudo chmod 775 log.txt >> log.txt
  echo "$(date +%H:%M:%S) - Fin" >> log.txt
  exit
}

#Instala opción hombrew
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
       _descargaElementos "homebrewArt.uri" 3 imágenes
       #Copiamos los elementos
       _copiaElementosTema homebrew
       #Volvemos al menú principal
       _modificaCfg homebrew "Enciclopedia Homebrew" 
       _descargaElementos "homebrewSh.uri" 3 "comandos sh"   
       _copiaRoms homebrew sh        
       _msgFin "Enciclopedia Hombrew"
   else
     _msgTemaNoInstalado
     clear
     exit  
   fi
}

#Instalar opción mojon twins
_mojonTwins(){
  #Mensaje de información
  _msgMojonTwins

}


#---------- FIN OPERACIONES SOBRE EL MENÚ ------------------------
#------------------------------------------------------------------


#------------------- SCRIPT PRINCIPAL -------------------------------
#Ejecución de script
if [ "$(whoami)" != "root" ]; then
  _msgNoRoot
  clear
  exit
else
  _main
fi

