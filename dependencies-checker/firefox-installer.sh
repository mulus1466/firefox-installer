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

ROOT_UID=0
len=$(echo $LANG | cut -d '_' -f 1)
arq=$(getconf LONG_BIT)

dia=$(ls /usr/bin | grep -x dialog | wc -l)
wge=$(ls /usr/bin | grep -x wget | wc -l)
men=$(ls /usr/bin | grep -x update-menus | wc -l)

dire="/tmp/dire.txt"
INPUT="/tmp/menu.sh"

>$INPUT
>$dire

case $dia in
	0 )
	echo "The program \"dialog\" (a dependencie of this script) is not installed, do you want to install it? (yes/no) :" $yn
	case $yn in
		[Yy]* ) apt-get install dialog ;;
		* )
		echo "Exiting from the script..."
		exit ;;
	esac ;;
	1 ) ;;
#	* )echo "Exiting from the script..."
#	exit ;;
esac

case $wge in
	0 )
	echo "The program \"wget\" (a dependencie of this script) is not installed, do you want to install it? (yes/no) :" $yn
	case $yn in
		[Yy]* ) apt-get install wget ;;
		* )
		echo "Exiting from the script..."
		exit ;;
	esac ;;
	1 ) ;;
#	* )echo "Exiting from the script..."
#	exit ;;
esac

case $men in
	0 )
	echo "The program \"menu\" (a dependencie of this script) is not installed, do you want to install it? (yes/no) :" $yn
	case $yn in
		[Yy]* ) apt-get install menu ;;
		* )
		echo "Exiting from the script..."
		exit ;;
	esac ;;
	1 ) ;;
#	* )echo "Exiting from the script..."
#	exit ;;
esac

dialog --title 'Firefox Installer' --menu "Chouse a language for the instalation :" 12 65 2 English "English" Spanish "Español" 2>"${INPUT}"

idi=$(<"${INPUT}")

if [ "$idi" == "English" ]
then
	source en.tf
elif [ "$idi" == "Spanish" ]
then
	source es.tf
else
	source en.tf
fi

dialog --colors --title 'Firefox Installer' --msgbox "$mes1." 12 65

if [ "$UID" -ne "$ROOT_UID" ]
then
	dialog --colors --title 'Firefox Installer' --msgbox "$mes2." 12 65
	exit
fi

dialog --colors --title 'Firefox Installer' --yesno "$mes3." 12 65

if [ "$?" == 0 ]
then
	cwd=$HOME
elif [ "$?" == 1 ]
then
	dialog --colors --title 'Firefox Installer' --yesno "$mes4." 12 65
	if [ "$?" == 0 ]
	then
		dialog --colors --title 'Firefox Installer' --inputbox "$mes5" 12 65 2>$dire
		cwd=$(<$dire)
	else
		dialog --colors --title 'Firefox Installer' --infobox "$mes6" 12 65
	fi
else
	dialog --colors --title 'Firefox Installer' --infobox "$mes6" 12 65
fi

if [ $(ls -a $cwd | grep .firefox-installer | wc -l) == 1 ]
then
	dialog --colors --title 'Firefox Installer' --yesno "$mes7" 12 65
	if [ "$?" != 0 ]
	then
		dialog --colors --title 'Firefox Installer' --infobox "$mes6" 12 65
		exit
	fi
	rm -rf $cwd/.firefox-installer
else
	exit
fi

mkdir $cwd/.firefox-installer
cd $cwd/.firefox-installer

if [ "$len" == "en" ]
then
	len=English
elif [ "$len" == "es" ]
then
	len=Spanish
elif [ "$len" == "fr" ]
then
	len=French
elif [ "$len" == "it" ]
then
	len=Italian
else
	len=German
fi
dialog --colors --title 'Firefox Installer' --yesno "$mes8 :\n$mes9 : $len\n$mes10 : $arq\n\n$mes11" 12 65

case $? in
	0 ) dialog --colors --title 'Firefox Installer' --infobox "$mes12" 12 65 ;;
	* )
	dialog --colors --title 'Firefox Installer' --menu "$mes13 :\n $mes14 :" 12 65 5\
	English "English"\
	Spanish "Español"\
	French  "Français"\
	Italian "Italiano"\
	German  "Deutsch" 2>>"${INPUT}"
	len=$(<"${INPUT}")
	
	dialog --colors --title 'Firefox Installer' --menu "$mes15 :" 12 65 2\
	32 "32 bits system"\
	64 "64 bits system" 2>>"${INPUT}"
	arq=$(<"${INPUT}")
esac

dialog --colors --title 'Firefox Installer' --infobox "$mes16" 12 65
case $len in
	English ) 
		if [ "$arq" == 32 ]
		then
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-i686/en-US/firefox-*.tar.bz2
		else
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/en-US/firefox-*.tar.bz2
		fi ;;
	Spanish ) 
		if [ "$arq" == 32 ]
		then
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-i686/es-ES/firefox-*.tar.bz2
		else
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/es-ES/firefox-*.tar.bz2
		fi ;;
	French ) 
		if [ "$arq" == 32 ]
		then
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-i686/fr/firefox-*.tar.bz2
		else
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/fr/firefox-*.tar.bz2
		fi ;;
	Italian ) 
		if [ "$arq" == 32 ]
		then
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-i686/it/firefox-*.tar.bz2
		else
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/it/firefox-*.tar.bz2
		fi ;;
	German ) 
		if [ "$arq" == 32 ]
		then
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-i686/de/firefox-*.tar.bz2
		else
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/de/firefox-*.tar.bz2
		fi ;;
esac

archi=$(ls | grep firefox-*.tar.bz2)
dialog --colors --title 'Firefox Installer' --infobox "$mes17 $archi" 12 65
tar -jxf firefox-*.tar.bz2

dialog --colors --title 'Firefox Installer' --infobox "$mes18" 12 65
cp -rf firefox /opt
if [ $(ls /usr/bin | grep firefox | wc -l) == 1 ]
then
	rm /usr/bin/firefox
fi
ln -s /opt/firefox/firefox /usr/bin/firefox
cp /opt/firefox/browser/icons/mozicon128.png /usr/share/pixmaps/firefox.png
touch /usr/share/applications/firefox.desktop
echo -e "\n[Desktop Entry]\nName=Mozilla Firefox\nComment=Firefox-Browser\nExec=/usr/bin/firefox\nIcon=/usr/share/pixmaps/firefox.png\nTerminal=false" > /usr/share/applications/firefox.desktop
echo -e "Type=Application\nCategories=Network;\nStartupNotify=false;\nName[en_US]=Mozilla Firefox" >> /usr/share/applications/firefox.desktop
update-menus
dialog --colors --title 'Firefox Installer' --infobox "$mes19" 12 65

rm $dire $INPUT 