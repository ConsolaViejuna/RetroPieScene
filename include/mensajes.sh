#!/bin/bash

#-----------------------------
#-- Mensajes de información --
#-----------------------------

#Mensaje de inicio
_msgInicio(){
    dialog --infobox "             RetroPie Script Scene v0.5.2
                      \n Disfruta la scene Española en tu Raspberry Pi" 4 50 ; sleep 2

}

#Mensaje de información al instalar la enciclopedia homebrew
_msgEnciclopediaHomebrew(){
   dialog --title "Enciclopedia Homebrew" \
          --msgbox "Se va a proceder a instalar la categoría Enciclopedia Homebrew en tu sistema, donde se añadirán los juegos de los desarrolladores que NO disponen de categoría (ya que de momento tienen menos de 3 juegos). La Enciclopedia Homebrew es un libro que nace con la intención de llenar el hueco que hacía falta acerca de todos aquellos videojuegos actuales que se desarrollan para sistemas que ya hace muchos años que dejaron de publicar juegos oficiales. Los creadores de este genial proyecto son @blackmores_ de un pasado mejor IvánZX de ZxDev15 e @ignprigar de pb48k." 0 0
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
          --msgbox "Se va a proceder a instalar la categoría Esp Soft en tu sistema, se añadirán todos los juegos de este fantástico grupo de desarrolladores. Esp Soft  es un grupo de programadores que se fundó en año 2004, programan juegos para el maravilloso Amstrad CPC. Todo empezó en los foros de Miarroba, al publicar un tutorial para programar juegos en ASM, siguió con la conversión de el famoso juego columns de Sega para Amstrad. En su catalogo podemos encontrar desde estupendos juegos conversacionales a estupendas aventuras. Pásate por http://espsoft.blogspot.com.es y http://www.asmtrad.es y conoce más de cerca sus juegos y su historia" 0 0
}

#Mensaje de información al instalar la categoría Errazking
_msgErrazking(){
   dialog --title "Errazking" \
          --msgbox "Se va a proceder a instalar la categoría Errazking en tu sistema, se añadirán todos los juegos de este fantástico desarrollador. Su heramienta preferida es el SEUCK, un software para hacer juegos en Commodore 64, lo maneja cómo nadie, y su arte haciendo sprites no tiene precio. Entre sus juegos podemos encontrar pinballs, pasando por arcades, juegos de deportes y de mamporros, te recomiendo que los juegues todos, te sorprenderá, no todo es lo que parece. Puedes seguirlo en Youtube donde te enseña a hacer un video juego desde cero, también gasta Twitter @errazking." 0 0
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
  --msgbox "Se ha terminado de instalar la categoría $descripcion, ahora inicia Emulation Station para disfrutar" 0 0
}

#Mensaje directorios creados
_msgActualizarScript(){
    dialog --infobox "Actualizando script ..." 4 40
}

#-------------------- FIN MENSAJES DE INFORMACIÓN --------------
#---------------------------------------------------------------

