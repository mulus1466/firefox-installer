#!/bin/bash
#
# This is free and unencumbered software released into the public domain.
#
# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.
#
# In jurisdictions that recognize copyright laws, the author or authors
# of this software dedicate any and all copyright interest in the
# software to the public domain. We make this dedication for the benefit
# of the public at large and to the detriment of our heirs and
# successors. We intend this dedication to be an overt act of
# relinquishment in perpetuity of all present and future rights to this
# software under copyright law.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
# For more information, please refer to [http://unlicense.org]
#
# Contacto: 
# Martin "Zironid" (Programador): zironid@lavabit.com
# David "dfas98" (Traductor): dfas98@gmail.com
#
# No tenemos ningún tipo de relación con Firefox(mozilla.org/firefox) o Mozilla(mozilla.org).

ROOT_UID=0
len=$(echo $LANG | cut -d '_' -f 1)
arq=$(getconf LONG_BIT)

clear
echo "¡Hola! Y bienvenido a Firefox Installer, un script diseñado para que la instalación de Firefox en Debian sea más sencilla."

if [ "$UID" -ne "$ROOT_UID" ]
then
	echo "Para usar éste script tienes que ejecutarlo como super usuario (root)."
	sleep 5
	exit
else
	echo "Recuerda que sólo root puede usar éste script."
fi
read -p "Firefox installer creará la carpeta .firefox-installer en $HOME. ¿Está bien? (sí/no) : " resd
case $resd in
	[Ss]* ) cwd=$HOME;;
	* ) read -p "¿Desea introducir el directorio manualmente? (sí/no) : " resdd
	case $resdd in
		[Ss]* ) read -p "Directorio: (Ejemplo: /home/foo) :" cwd;;
		* ) echo "Saliendo del script..."
		exit;;
	esac
esac
if [ $(ls -a $cwd | grep ".firefox-installer" | wc -l) == 1 ]
then
	read -p "El directorio $cwd/.firefox-installer ya existe, desea borrarlo para poder continuar? (si/no) :" resb
	case $resb in
		[Ss]* ) echo "$cwd/.firefox-installer eliminado.";;
		* ) echo "Saliendo del script..."
		exit;;
	esac
	rm -rf $cwd/.firefox-installer
fi
mkdir $cwd/.firefox-installer
echo "Directorio $cwd/.firefox-installer creado."
cd $cwd/.firefox-installer
echo "Información del sistema:"
echo "Lenguaje: $len"
echo "Arquitectura: $arq"

read -p "¿Es esto correcto? (si/no) : " res
case $res in
	[Ss]* ) echo "Entonces, continuemos.";;
	* ) 
	echo "Por favor, introduzca la información manualmente:"
	read -p "Lenguaje (en/es/fr/it/de) : " len
	case $len in
		[Ee][Nn]* ) len=en ;;
		[Ee][Ss]* ) len=es ;;
		[Ff][Rr]* ) len=fr ;;
		[Ii][Tt]* ) len=it ;;
		[Dd][Ee]* ) len=de ;;
		* ) read -p "Lenguaje no soportado por el script. ¿Desea usar la versión en Inglés? : " resi
		case $resd in
			[Ss]* ) len=en;;
			[Nn]* ) echo "Saliendo del instalador..."
			exit;;
		esac
	esac
	read -p "Arquitectura (32/64) : " arq
	case $arq in
		3* ) arq=32;;
		6* ) arq=64;;
		* ) echo "Arquitectura desconocida. Se usará la versión de 32 bits por razones de seguridad."
		arq=32;;
	esac
esac
case $len in
	en ) 
		if [ "$arq" == 32 ]
		then
			echo "La descarga empezará en 5 segundos..."
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-i686/en-US/firefox-*.tar.bz2
		else
			echo "La descarga empezará en 5 segundos..."
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/en-US/firefox-*.tar.bz2
		fi ;;
	es ) 
		if [ "$arq" == 32 ]
		then
			echo "La descarga empezará en 5 segundos..."
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-i686/es-ES/firefox-*.tar.bz2
		else
			echo "La descarga empezará en 5 segundos..."
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/es-ES/firefox-*.tar.bz2
		fi ;;
	fr ) 
		if [ "$arq" == 32 ]
		then
			echo "La descarga empezará en 5 segundos..."
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-i686/fr/firefox-*.tar.bz2
		else
			echo "La descarga empezará en 5 segundos..."
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/fr/firefox-*.tar.bz2
		fi ;;
	it ) 
		if [ "$arq" == 32 ]
		then
			echo "La descarga empezará en 5 segundos..."
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-i686/it/firefox-*.tar.bz2
		else
			echo "La descarga empezará en 5 segundos..."
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/it/firefox-*.tar.bz2
		fi ;;
	de ) 
		if [ "$arq" == 32 ]
		then
			echo "La descarga empezará en 5 segundos..."
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-i686/de/firefox-*.tar.bz2
		else
			echo "La descarga empezará en 5 segundos..."
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/de/firefox-*.tar.bz2
		fi ;;
esac

archi=$(ls | grep firefox-*.tar.bz2)
echo "Extrallendo $archi..."
tar -jxf firefox-*.tar.bz2

echo "Iniciando instalación..."
echo "Copiando \"firefox\" a /opt..."
cp -rf firefox /opt
echo "creando enlace simbólico en /usr/bin..."
if [ $(ls /usr/bin | grep firefox | wc -l) == 1 ]
then
	rm /usr/bin/firefox
fi
ln -s /opt/firefox/firefox /usr/bin/firefox
cp /opt/firefox/browser/icons/mozicon128.png /usr/share/pixmaps/firefox.png
echo "Añadiendo Firefox al menú"
touch /usr/share/applications/firefox.desktop
echo -e "\n[Desktop Entry]\nName=Mozilla Firefox\nComment=Firefox-Browser\nExec=/usr/bin/firefox\nIcon=/usr/share/pixmaps/firefox.png\nTerminal=false" > /usr/share/applications/firefox.desktop
echo -e "Type=Application\nCategories=Network;\nStartupNotify=false;\nName[en_US]=Mozilla Firefox" >> /usr/share/applications/firefox.desktop
update-menus 
echo "Instalación finalizada."
