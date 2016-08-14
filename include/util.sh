#!/bin/bash

#-----------------------UTILIDADES ----------------------------


# **
# * Dado un fichero Zip lo descomprime
# * @var String $1 --> Nombre del fichero zip
# * @var String $2 --> Categoría
 _descomprimeZip(){
   local nombre=$1
   local categoria=$2
   unzip -o -d /home/$usuario/RetroPie/roms/$categoria/ /home/$usuario/RetroPie/roms/$categoria/$nombre.zip  >> log.txt 2>&1
   chgrp -R $usuario /home/$usuario/RetroPie/roms/$categoria/$nombre
   chown -R $usuario /home/$usuario/RetroPie/roms/$categoria/$nombre
   rm /home/$usuario/RetroPie/roms/$categoria/$nombre.zip >> log.txt 2>&1 
 }

_actualizarScript(){
  _msgActualizarScript
  git pull >> log.txt
  exec ./RetroPie-scene_setup.sh 
}

#Copia las roms y los archivos .sh
_copiaRoms(){
  local categoria=$1
  local extension=$2
  echo "$(date +%H:%M:%S) - Copiamos los archivos .$extension" >> log.txt  
  cp /home/$usuario/tmp/*.* /home/$usuario/RetroPie/roms/$categoria >> log.txt 2>&1
  echo "$(date +%H:%M:%S) - Terminamos de copiar los archivos .$extension" >> log.txt 2>&1
  chown $usuario /home/$usuario/RetroPie/roms/$categoria >> log.txt 2>&1
  chgrp $usuario /home/$usuario/RetroPie/roms/$categoria >> log.txt 2>&1
  chown $usuario /home/$usuario/RetroPie/roms/$categoria/*.* >> log.txt 2>&1
  chgrp $usuario /home/$usuario/RetroPie/roms/$categoria/*.* >> log.txt 2>&1
  _borrarTemporales
}

#Copia las roms y los archivos .sh de un archivo zip
_copiaRomsZip(){
  local categoria=$1
  echo "$(date +%H:%M:%S) - Copiamos los archivos" >> log.txt  
  unzip -q -o /home/$usuario/tmp/roms.zip -d /home/$usuario/tmp
  cp /home/$usuario/tmp/*.* /home/$usuario/RetroPie/roms/$categoria >> log.txt 2>&1
  echo "$(date +%H:%M:%S) - Terminamos de copiar los archivos" >> log.txt 2>&1
  chown $usuario /home/$usuario/RetroPie/roms/$categoria >> log.txt 2>&1
  chgrp $usuario /home/$usuario/RetroPie/roms/$categoria >> log.txt 2>&1
  chown $usuario /home/$usuario/RetroPie/roms/$categoria/*.* >> log.txt 2>&1
  chgrp $usuario /home/$usuario/RetroPie/roms/$categoria/*.* >> log.txt 2>&1
  _borrarTemporales
}

#Copia las carátulas de los juegos
_copiaCovers(){
  local categoria=$1
  echo "$(date +%H:%M:%S) - Copiamos las carátulas y el gamelist.xml" >> log.txt  
  cp /home/$usuario/tmp/*.jpg /home/$usuario/.emulationstation/downloaded_images/$categoria >> log.txt 2>&1
  cp /home/$usuario/tmp/*.xml /home/$usuario/.emulationstation/gamelists/$categoria >> log.txt 2>&1
  echo "$(date +%H:%M:%S) - Terminamos de copiar los archivos" >> log.txt  
  chown $usuario /home/$usuario/.emulationstation/downloaded_images/$categoria >> log.txt 2>&1
  chgrp $usuario /home/$usuario/.emulationstation/downloaded_images/$categoria >> log.txt 2>&1
  chown $usuario /home/$usuario/.emulationstation/downloaded_images/$categoria/*.* >> log.txt 2>&1
  chgrp $usuario /home/$usuario/.emulationstation/downloaded_images/$categoria/*.* >> log.txt 2>&1
  chown $usuario /home/$usuario/.emulationstation/gamelists/$categoria >> log.txt 2>&1
  chgrp $usuario /home/$usuario/.emulationstation/gamelists/$categoria >> log.txt 2>&1
  chown $usuario /home/$usuario/.emulationstation/gamelists/$categoria/*.* >> log.txt 2>&1
  chgrp $usuario /home/$usuario/.emulationstation/gamelists/$categoria/*.* >> log.txt 2>&1
  _borrarTemporales
}

#Copia las carátulas de los juegos que están en zip
_copiaCoversZip(){
  local categoria=$1
  echo "$(date +%H:%M:%S) - Copiamos las carátulas y el gamelist.xml" >> log.txt
  unzip -q -o /home/$usuario/tmp/covers.zip -d /home/$usuario/tmp  
  cp /home/$usuario/tmp/*.jpg /home/$usuario/.emulationstation/downloaded_images/$categoria >> log.txt 2>&1
  cp /home/$usuario/tmp/*.xml /home/$usuario/.emulationstation/gamelists/$categoria >> log.txt 2>&1
  echo "$(date +%H:%M:%S) - Terminamos de copiar los archivos" >> log.txt  
  chown $usuario /home/$usuario/.emulationstation/downloaded_images/$categoria >> log.txt 2>&1
  chgrp $usuario /home/$usuario/.emulationstation/downloaded_images/$categoria >> log.txt 2>&1
  chown $usuario /home/$usuario/.emulationstation/downloaded_images/$categoria/*.* >> log.txt 2>&1
  chgrp $usuario /home/$usuario/.emulationstation/downloaded_images/$categoria/*.* >> log.txt 2>&1
  chown $usuario /home/$usuario/.emulationstation/gamelists/$categoria >> log.txt 2>&1
  chgrp $usuario /home/$usuario/.emulationstation/gamelists/$categoria >> log.txt 2>&1
  chown $usuario /home/$usuario/.emulationstation/gamelists/$categoria/*.* >> log.txt 2>&1
  chgrp $usuario /home/$usuario/.emulationstation/gamelists/$categoria/*.* >> log.txt 2>&1
  _borrarTemporales
}

#Dar permiso a los ficheros descargados
_darPermisos(){
  echo "$(date +%H:%M:%S) - Damos permisos a los ficheros descargados" >> log.txt  
  sudo chown $usuario /home/$usuario/tmp/*.* >> log.txt 2>&1
  sudo chgrp $usuario /home/$usuario/tmp/*.* >> log.txt 2>&1
  sudo chmod 777 /home/$usuario/tmp/*.* >> log.txt 2>&1
}  

#Borramos fiheros temporales
_borrarTemporales(){
  echo "$(date +%H:%M:%S) - Borramos ficheros temporales" >> log.txt  
  sudo rm /home/$usuario/tmp/*.* >> log.txt 2>&1
  sudo rmdir /home/$usuario/tmp >> log.txt 2>&1
}

#Crea los directorios necesarios
_crearDirectorios(){
  
  local dir=$1
  #Comprobamos si existen los directorios si no existen los creamos
  if [ ! -d /etc/emulationstation/themes/simple/$dir/ ];
  then
    date +%H:%M:%S | echo "Se crea directorio $dir en /etc/emulationstation/themes/simple/$dir" >> log.txt 
    mkdir /etc/emulationstation/themes/simple/$dir >> log.txt 2>&1
  else
    echo "$(date +%H:%M:%S) - El directorio /etc/emulationstation/themes/simple/$dir ya está creado" >> log.txt 
  fi
  
  if [ ! -d /etc/emulationstation/themes/simple/$dir/art/ ];
  then
    date +%H:%M:%S | echo "Se crea directorio art en /etc/emulationstation/themes/simple/$dir" >> log.txt 
    mkdir /etc/emulationstation/themes/simple/$dir/art >> log.txt 2>&1
  else
    echo "$(date +%H:%M:%S) - El directorio /etc/emulationstation/themes/simple/$dir/art ya está creado" >> log.txt 
  fi
  
  if [ ! -d /home/$usuario/RetroPie/roms/$dir/ ];
  then
    echo "$(date +%H:%M:%S) - Se crea directorio $dir en /home/pi/RetroPie/roms/$dir" >> log.txt 
    mkdir "/home/$usuario/RetroPie/roms/$dir" >> log.txt 2>&1
    sudo chown $usuario homebrew/ >> log.txt 2>&1
    sudo chgrp $usuario homebrew/ >> log.txt 2>&1
  else
    echo "$(date +%H:%M:%S) - El directorio home/pi/RetroPie/roms/$dir ya está creado" >> log.txt
  fi

  if [ ! -d /home/$usuario/.emulationstation/downloaded_images/ ];
  then
    echo "$(date +%H:%M:%S) - Se crea directorio downloaded_images en /home/$usuario/.emulationstation" >> log.txt 
    mkdir /home/$usuario/.emulationstation/downloaded_images >> log.txt 2>&1
    sudo chown $usuario /home/$usuario/.emulationstation/downloaded_images >> log.txt 2>&1
    sudo chgrp $usuario /home/$usuario/.emulationstation/downloaded_images >> log.txt 2>&1
  else
    echo "$(date +%H:%M:%S) - Ya está creado el directorio downloaded_images en /home/$usuario/.emulationstation" >> log.txt
  fi
  
   if [ ! -d /home/$usuario/.emulationstation/downloaded_images/$dir/ ];
    then
    echo "$(date +%H:%M:%S) - Se crea directorio $dir en /home/$usuario/.emulationstation/downloaded_images" >> log.txt 
    mkdir /home/$usuario/.emulationstation/downloaded_images/$dir > log.txt 2>&1
    sudo chown $usuario /home/$usuario/.emulationstation/downloaded_images/$dir >> log.txt 2>&1
    sudo chgrp $usuario /home/$usuario/.emulationstation/downloaded_images/$dir >> log.txt 2>&1
  else
    echo "$(date +%H:%M:%S) - El directorio home/pi/RetroPie/roms/$dir ya está creado" >> log.txt
  fi

   if [ ! -d /home/$usuario/.emulationstation/gamelists/ ];
    then
    echo "$(date +%H:%M:%S) - Se crea directorio gamelist en /home/$usuario/.emulationstation" >> log.txt 
    mkdir /home/$usuario/.emulationstation/gamelists >> log.txt 2>&1
    sudo chown $usuario /home/$usuario/.emulationstation/gamelists >> log.txt 2>&1
    sudo chgrp $usuario /home/$usuario/.emulationstation/gamelists >> log.txt 2>&1
  else
    echo "$(date +%H:%M:%S) - El directorio /home/$usuario/.emulationstation/gamelists ya está creado" >> log.txt
  fi

  if [ ! -d /home/$usuario/.emulationstation/gamelists/$dir/ ];
    then
    echo "$(date +%H:%M:%S) - Se crea directorio $dir en /home/$usuario/.emulationstation/gamelists" >> log.txt 
    mkdir /home/$usuario/.emulationstation/gamelists/$dir
    sudo chown $usuario /home/$usuario/.emulationstation/gamelists/$dir >> log.txt 2>&1
    sudo chgrp $usuario /home/$usuario/.emulationstation/gamelists/$dir >> log.txt 2>&1
  else
    echo "$(date +%H:%M:%S) - El directorio /home/$usuario/.emulationstation/gamelists ya está creado" >> log.txt
  fi


}

#Copia los elementos del tema
_copiaElementosTema(){
  echo "$(date +%H:%M:%S) - Copiamos los elementos del tema" >> log.txt  
  local categoria=$1
  local filename="_art_blur.jpg"
  cp /home/$usuario/tmp/$categoria.png /etc/emulationstation/themes/simple/$categoria/art/ >> log.txt 2>&1 
  cp /home/$usuario/tmp/$categoria$filename /etc/emulationstation/themes/simple/$categoria/art >> log.txt 2>&1 
  cp /home/$usuario/tmp/theme.xml /etc/emulationstation/themes/simple/$categoria >> log.txt 2>&1 
  echo "$(date +%H:%M:%S) - Terminamos de copiar los elementos" >> log.txt  
  _borrarTemporales
}


#Descarga todos los archivos necesarios para crear la categoría
_descargaElementos(){
  local elemento="$3"
  echo "$(date +%H:%M:%S) - Descarga de $elemento para el tema" >> log.txt  
  echo "$(date +%H:%M:%S) - Nos creamos directorio temporal" >> log.txt
  echo "---------------------- DESCARGA ---------------------" >> log.txt
  echo " " >> log.txt
  
  #Si el directorio /home/pi/tmp no esta creado, o creamos
  if [ ! -d /home/$usuario/tmp/ ];
  then   
    mkdir /home/$usuario/tmp >> log.txt 2>&1 
  fi
 
  local uri="$1"
  local archivos=$2
  local incremento=$((100 / $archivos))
  local porcentaje=$incremento
  (
    while read line
    do     
      wget -a download.txt -N -P /home/$usuario/tmp  $line
      echo $porcentaje
      echo "###"
      echo "$porcentaje %"
      echo "###"
      local porcentaje=$(( $porcentaje + $incremento))
    done < "$1"
  )|
  dialog --title "Descargando $elemento" --gauge "Por favor espere ...." 10 60 0
  echo "---------------------- DESCARGA ---------------------" >> log.txt
  echo " " >> log.txt
  echo "$(date +%H:%M:%S) - Finalizada la descarga" >> log.txt
  _darPermisos
}

#Descarga todos los archivos necesarios para creas la categoría (usando un archivo zip)
_descargaZip(){
  local elemento="$2"
  echo "$(date +%H:%M:%S) - Descarga de $elemento para el tema" >> log.txt  
  echo "$(date +%H:%M:%S) - Nos creamos directorio temporal" >> log.txt
  echo "---------------------- DESCARGA ---------------------" >> log.txt
  echo " " >> log.txt
  
  #Si el directorio /home/pi/tmp no esta creado, o creamos
  if [ ! -d /home/$usuario/tmp/ ];
  then   
    mkdir /home/$usuario/tmp >> log.txt 2>&1 
  fi
  #Leemos fichero de recursos
  while read line
  do     
      local uri=$line
  done < "$1"
  wget -a download.txt -N -P /home/$usuario/tmp --progress=dot "$uri" 2>&1 |  grep "%" | sed -u -e "s,\.,,g" | awk '{print $2}' | sed -u -e "s,\%,,g" | dialog --title "Descargando $elemento" --gauge "Por favor espere ...." 10 60 0
}

#Añade una nueva categoría a emulation Station
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
            <path>/home/'"$usuario"'/RetroPie/roms/'"$categoria"'</path>\
            <extension>.sh .SH</extension>\
            <command>%ROM%</command>\
            <platform>pc</platform>\
            <theme></theme>\
            <directlaunch/>\
         </system>'

  sed -i '/<\/systemList>/i\'"$CONTENT" /etc/emulationstation/es_systems.cfg >> log.txt 2>&1
  echo "$(date +%H:%M:%S) - Fin de la modificación del fichero de configuración" >> log.txt
  else
   echo "$(date +%H:%M:%S) - Se ha añadido la categoría con anterioridad" >> log.txt
  fi
  _msgCreacionCategoria
 }


#-------------------- FIN UTILIDADES ---------------------------
#---------------------------------------------------------------
