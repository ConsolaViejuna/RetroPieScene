#!/bin/bash
. ./include/mensajes.sh
. ./include/util.sh

tempfile1=/tmp/dialog_1_$$
tempfile2=/tmp/dialog_2_$$
tempfile3=/tmp/dialog_3_$$

trap "rm -f $tempfile1 $tempfile2 $tempfile3" 0 1 2 5 15


#------------- OPERACIONES SOBRE EL MENÚ --------------------------------

#Muestra el menú principal
_main () {
   
  _msgInicio 
  dialog --title "RetroPie Scene Script by @ConsolaViejuna" \
           --menu "Por favor, elija una opción:" 15 80 5 \
                   1 "Instalar categoría Enciclopedia Hombrew" \
                   2 "Instalar categoría Esp Soft" \
                   3 "Instalar categoría The Mojon Twins" \
                   4 "Instalar categoría Errazking" \
                   5 "Actualizar script" \
                   6 "Salir" 2> $tempfile3

   retv=$?
   choice=$(cat $tempfile3)
   [ $retv -eq 1 -o $retv -eq 255 ] && exit

   case $choice in
       1) _enciclopediaHomebrew
          _main
           ;;
       2) _espSoft
          _main
           ;;
       3) _mojonTwins
           ;;
       4) _errazking
       	   ;;
       5) _actualizarScript
	  _main	
           ;;
       6) clear
          _salir ;;

   esac
}

#Salir del menú
_salir(){
  
  echo "$(date +%H:%M:%S) - Cambiamos permisos a los ficheros" >> log.txt
  sudo chown $usuario log.txt 
  sudo chmod 775 log.txt 
  echo "$(date +%H:%M:%S) - Fin" >> log.txt
  exit
}

#Instala opción homebrew
_enciclopediaHomebrew(){
   #Mensaje de información
   _msgEnciclopediaHomebrew
 
   #Miramos si está instalado el tema simple  
   if [ -d /etc/emulationstation/themes/simple/ ];
   then
       echo "$(date +%H:%M:%S) Iniciando script ..." > log.txt
       _msgTemaSimpleInstalado
       _msgCreacionDirectorios
       #Creamos los directorios necesarios
       _crearDirectorios homebrew
       #Descargamos los elementos necesarios del tema
       _descargaElementos "./homebrew/homebrewArt.uri" 3 imágenes
       #Copiamos los elementos
       _copiaElementosTema homebrew
       #Volvemos al menú principal
       _modificaCfg homebrew "Enciclopedia Homebrew" 
       #Descargamos roms y archivos sh
       _descargaZip "./homebrew/homebrewRoms.uri" "roms"
       _copiaRomsZip "homebrew"
       _descargaZip "./homebrew/homebrewCover.uri" "carátulas"
       _copiaCoversZip "homebrew"
       _msgFin "Enciclopedia Hombrew"
   else
     _msgTemaNoInstalado
     clear
     exit  
   fi
}

#Instala opción Esp Soft
_espSoft(){
   #Mensaje de información
   _msgEspSoft
 
   #Miramos si está instalado el tema simple  
   if [ -d /etc/emulationstation/themes/simple/ ];
   then
       echo "$(date +%H:%M:%S) Iniciando script ..." >> log.txt
       _msgTemaSimpleInstalado
       _msgCreacionDirectorios
       #Creamos los directorios necesarios
       _crearDirectorios espsoft
       #Descargamos los elementos necesarios del tema
       _descargaElementos "./espsoft/espSoftArt.uri" 3 imágenes
       #Copiamos los elementos
       _copiaElementosTema espsoft
       #Volvemos al menú principal
       _modificaCfg espsoft "Esp Soft" 
       #Descargamos roms
       _descargaElementos "./espsoft/espSoftRoms.uri" 22 "roms"
       _copiaRoms espsoft dsk 
       _descargaElementos "./espsoft/espSoftSh.uri" 20 "archivos .sh"  
       _copiaRoms espsoft sh
       _descargaElementos "./espsoft/espSoftCover.uri" 21 "carátulas"
       _copiaCovers espsoft
       _msgFin "Esp Soft"
   else
     _msgTemaNoInstalado
     clear
     exit  
   fi
}


#Instala opción The Mojon Twins
_mojonTwins(){
   #Mensaje de información
   _msgMojonTwins
 
   #Miramos si está instalado el tema simple  
   if [ -d /etc/emulationstation/themes/simple/ ];
   then
       echo "$(date +%H:%M:%S) Iniciando script ..." >> log.txt
       _msgTemaSimpleInstalado
       _msgCreacionDirectorios
       #Creamos los directorios necesarios
       _crearDirectorios mojontwins
       #Descargamos los elementos necesarios del tema
       _descargaElementos "./mojontwins/mojonTwinsArt.uri" 3 imágenes
       #Copiamos los elementos
       _copiaElementosTema mojontwins
       #Volvemos al menú principal
       _modificaCfg mojontwins "The Mojon Twins" 
       #Descargamos roms
       _descargaElementos "./mojontwins/mojonTwinsRoms.uri" 72 "roms"
       _copiaRoms mojontwins * 
       _descargaElementos "./mojontwins/mojonTwinsSh.uri" 70 "archivos .sh"  
       _copiaRoms mojontwins sh
       _descargaElementos "./mojontwins/mojonTwinsCover.uri" 56 "carátulas"
       _copiaCovers mojontwins
       _descomprimeZip "lala" "mojontwins"
       _msgFin "The Mojon Twins"
   else
     _msgTemaNoInstalado
     clear
     exit  
   fi
}

#Instala opción Errazking
_errazking(){
   #Mensaje de información
   _msgErrazking
 
   #Miramos si está instalado el tema simple  
   if [ -d /etc/emulationstation/themes/simple/ ];
   then
       echo "$(date +%H:%M:%S) Iniciando script ..." >> log.txt
       _msgTemaSimpleInstalado
       _msgCreacionDirectorios
       #Creamos los directorios necesarios
       _crearDirectorios errazking
       #Descargamos los elementos necesarios del tema
       _descargaElementos "./errazking/errazkingArt.uri" 3 imágenes
       #Copiamos los elementos
       _copiaElementosTema errazking
       #Volvemos al menú principal
       _modificaCfg errazking "Errazking" 
       #Descargamos roms y archivos sh
       _descargaZip "./errazking/errazkingRoms.uri" "roms"
       _copiaRomsZip "errazking"
       _descargaZip "./errazking/errazkingCover.uri" "carátulas"
       _copiaCoversZip "errazking"
       _msgFin "Errazking"
   else
     _msgTemaNoInstalado
     clear
     exit  
   fi
}


#---------- FIN OPERACIONES SOBRE EL MENÚ ------------------------
#------------------------------------------------------------------


#------------------- SCRIPT PRINCIPAL -------------------------------
#Ejecución de script
usuario=$1
if [ -z "$usuario" ]; then
usuario="pi"
fi
if [ "$(whoami)" != "root" ]; then
  _msgNoRoot
  clear
  exit
else
 
  _main
fi

