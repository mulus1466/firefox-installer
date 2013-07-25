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
# Contact: 
# Martin "Zironid" (Programmer): zironid@lavabit.com
# David "dfas98" (Translator): dfas98@gmail.com
#
# We have no relationship with Firefox(mozilla.org/firefox) or Mozilla(mozilla.org).

source en.tf
ROOT_UID=0
len=$(echo $LANG | cut -d '_' -f 1)
arq=$(getconf LONG_BIT)

clear
echo "$mes1."

if [ "$UID" -ne "$ROOT_UID" ]
then
	echo "$mes2."
	sleep 5
	exit
else
	echo "$mes3."
fi
read -p "$mes4 : " resd
case $resd in
	[Yy]* ) cwd=$HOME;;
	* ) read -p "$mes5 : " resdd
	case $resdd in
		[Yy]* ) read -p "$mes6 : " cwd;;
		* ) echo "$mes7"
		exit;;
	esac
esac
if [ $(ls -a $cwd | grep ".firefox-installer" | wc -l) == 1 ]
then
	read -p "$mes8 : " resb
	case $resb in
		[Yy]* ) echo "$cwd/.firefox-installer $mes24.";;
		* ) echo "$mes7"
		exit;;
	esac
	rm -rf $cwd/.firefox-installer
fi
mkdir $cwd/.firefox-installer
echo "$mes25 $cwd/.firefox-installer $mes26."
cd $cwd/.firefox-installer
echo "$mes9 : "
echo "$mes10 : $len"
echo "$mes11 : $arq"

read -p "$mes12 : " res
case $res in
	[Yy]* ) echo "$mes13.";;
	* ) 
	echo "$mes14 : "
	read -p "$mes15 : " len
	case $len in
		[Ee][Nn]* ) len=en ;;
		[Ee][Ss]* ) len=es ;;
		[Ff][Rr]* ) len=fr ;;
		[Ii][Tt]* ) len=it ;;
		[Dd][Ee]* ) len=de ;;
		* ) read -p "$mes16 : " resi
		case $resd in
			[Yy]* ) len=en;;
			[Nn]* ) echo "$mes7"
			exit;;
		esac
	esac
	read -p "$mes17 : " arq
	case $arq in
		3* ) arq=32;;
		6* ) arq=64;;
		* ) echo "$mes18."
		arq=32;;
	esac
esac
case $len in
	en ) 
		if [ "$arq" == 32 ]
		then
			echo "$mes19"
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-i686/en-US/firefox-*.tar.bz2
		else
			echo "$mes19"
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/en-US/firefox-*.tar.bz2
		fi ;;
	es ) 
		if [ "$arq" == 32 ]
		then
			echo "$mes19"
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-i686/es-ES/firefox-*.tar.bz2
		else
			echo "$mes19"
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/es-ES/firefox-*.tar.bz2
		fi ;;
	fr ) 
		if [ "$arq" == 32 ]
		then
			echo "$mes19"
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-i686/fr/firefox-*.tar.bz2
		else
			echo "$mes19"
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/fr/firefox-*.tar.bz2
		fi ;;
	it ) 
		if [ "$arq" == 32 ]
		then
			echo "$mes19"
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-i686/it/firefox-*.tar.bz2
		else
			echo "$mes19"
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/it/firefox-*.tar.bz2
		fi ;;
	de ) 
		if [ "$arq" == 32 ]
		then
			echo "$mes19"
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-i686/de/firefox-*.tar.bz2
		else
			echo "$mes19"
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/de/firefox-*.tar.bz2
		fi ;;
esac

archi=$(ls | grep firefox-*.tar.bz2)
echo "$mes20 $archi..."
tar -jxf firefox-*.tar.bz2

echo "$mes21"
echo "$mes22 \"firefox\" $mes23 /opt..."
cp -rf firefox /opt
echo "$mes27 /usr/bin..."
if [ $(ls /usr/bin | grep firefox | wc -l) == 1 ]
then
	rm /usr/bin/firefox
fi
ln -s /opt/firefox/firefox /usr/bin/firefox
cp /opt/firefox/browser/icons/mozicon128.png /usr/share/pixmaps/firefox.png
echo "$mes28"
touch /usr/share/applications/firefox.desktop
echo -e "\n[Desktop Entry]\nName=Mozilla Firefox\nComment=Firefox-Browser\nExec=/usr/bin/firefox\nIcon=/usr/share/pixmaps/firefox.png\nTerminal=false" > /usr/share/applications/firefox.desktop
echo -e "Type=Application\nCategories=Network;\nStartupNotify=false;\nName[en_US]=Mozilla Firefox" >> /usr/share/applications/firefox.desktop
update-menus
echo "$mes29."
