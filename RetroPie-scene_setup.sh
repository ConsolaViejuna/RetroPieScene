#!/bin/sh

tempfile1=/tmp/dialog_1_$$
tempfile2=/tmp/dialog_2_$$
tempfile3=/tmp/dialog_3_$$

trap "rm -f $tempfile1 $tempfile2 $tempfile3" 0 1 2 5 15

#-----------------------------
#-- Mensajes de información --
#-----------------------------

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

#Mensaje de información al instalar la enciclopedia homebrew
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
   dialog --title "A sample application" \
           --menu "Por favor, elija una opción:" 15 80 5 \
                   1 "Instalar categoría Enciclopedia Hombrew" \
                   2 "Instalar categoría The Mojon Twins y sus juegos" \
                   3 "Salir" 2> $tempfile3

   retv=$?
   choice=$(cat $tempfile3)
   [ $retv -eq 1 -o $retv -eq 255 ] && exit

   case $choice in
       1) _enciclopediaHomebrew
           ;;
       2) _mojonTwins
           ;; 
       3) clear
          exit ;;

   esac
}

#Crea los directorios necesarios
_crearDirectorios(){
  #Comprobamos si existen los directorios si no existen los creamos
  if [ ! -d /etc/emulationstation/themes/simple/homebrew/ ];
  then
     mkdir /etc/emulationstation/themes/simple/homebrew
  fi
  
  if [ ! -d /home/pi/RetroPie/roms/homebrew/ ];
  then
     mkdir /home/pi/RetroPie/roms/homebrew
  fi
}

#Descarga todos los archivos necesarios para crear la categoría
_descargaElementos(){
(
  wget -q "https://3.bp.blogspot.com/-rMC18PXTXlA/VwJHz9pxLrI/AAAAAAABECc/Y1Yfzv23Cfc_wEGSWCzDUkTYDVv47ap4g/s1600/galactic_tomb_bann_blog.jpg"
  echo 50
  echo "###"
  echo "50 %"
  echo "###"
  wget -q "https://3.bp.blogspot.com/-NjpNds76miw/Vv4wbYZ9qiI/AAAAAAABD78/aVfd6FINf9cjPEexEDJmdJ4oJqwX7aC_g/s320/pack20esp.jpg"
  echo 100
  echo "###"
  echo "100 %"
  echo "###"
  ) |
  dialog --title "Descargando imágenes" --gauge "Por favor espere ...." 10 60 0
}

_enciclopediaHomebrew(){
   #Mensaje de información
   _msgEnciclopediaHomebrew
 
   #Miramos si está instalado el tema simple  
   if [ -d /etc/emulationstation/themes/simple/ ];
   then
       _msgTemaSimpleInstalado
       _msgCreacionDirectorios
       #Creamos los directorios necesarios
       _crearDirectorios
       _descargaElementos
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


