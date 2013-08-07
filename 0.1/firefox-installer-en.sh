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

clear
echo "Hello! And welcome to the Firefox Installer, a script designed to make the Firefox installation easier on Debian."

if [ "$UID" -ne "$ROOT_UID" ]
then
	echo "To run this script you must run it as a super user (root)."
	sleep 5
	exit
else
	echo "Remember that only root can run this script."
fi
read -p "Firefox installer will create the folder .firefox-installer in $HOME. Is this ok? (yes/no) : " resd
case $resd in
	[Yy]* ) cwd=$HOME;;
	* ) read -p "Do you want to manually create the directory? (yes/no) : " resdd
	case $resdd in
		[Yy]* ) read -p "Directory: (Example: /home/foo) :" cwd;;
		* ) echo "Exiting from the script..."
		exit;;
	esac
esac
if [ $(ls -a $cwd | grep ".firefox-installer" | wc -l) == 1 ]
then
	read -p "The directory $cwd/.firefox-installer already exists, do you want to delete it and continue? (yes/no) :" resb
	case $resb in
		[Yy]* ) echo "$cwd/.firefox-installer deleted.";;
		* ) echo "Exiting from the script..."
		exit;;
	esac
	rm -rf "$cwd/.firefox-installer"
fi
mkdir "$cwd/.firefox-installer"
echo "Directory $cwd/.firefox-installer created."
cd "$cwd/.firefox-installer"
echo "System information:"
echo "Language: $len"
echo "Architecture: $arq"

read -p "Is this ok? (yes/no) : " res
case $res in
	[Yy]* ) echo "So, let's continue.";;
	* ) 
	echo "Please, manually enter the information:"
	read -p "Language (en/es/fr/it/de) : " len
	case $len in
		[Ee][Nn]* ) len=en ;;
		[Ee][Ss]* ) len=es ;;
		[Ff][Rr]* ) len=fr ;;
		[Ii][Tt]* ) len=it ;;
		[Dd][Ee]* ) len=de ;;
		* ) read -p "That Language is not currently supported by the script. Do you want to use the English version instead? (yes/no) : " resi
		case $resd in
			[Yy]* ) len=en;;
			[Nn]* ) echo "Exiting from the script..."
			exit;;
		esac
	esac
	read -p "Architecture (32/64) : " arq
	case $arq in
		3* ) arq=32;;
		6* ) arq=64;;
		* ) echo "Unknown architecture. We are going to use the 32-bit version for security."
		arq=32;;
	esac
esac
case $len in
	en ) 
		if [ "$arq" == 32 ]
		then
			echo "The download will begin in 5 seconds..."
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-i686/en-US/firefox-*.tar.bz2
		else
			echo "The download will begin in 5 seconds..."
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/en-US/firefox-*.tar.bz2
		fi ;;
	es ) 
		if [ "$arq" == 32 ]
		then
			echo "The download will begin in 5 seconds..."
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-i686/es-ES/firefox-*.tar.bz2
		else
			echo "The download will begin in 5 seconds..."
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/es-ES/firefox-*.tar.bz2
		fi ;;
	fr ) 
		if [ "$arq" == 32 ]
		then
			echo "The download will begin in 5 seconds..."
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-i686/fr/firefox-*.tar.bz2
		else
			echo "The download will begin in 5 seconds..."
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/fr/firefox-*.tar.bz2
		fi ;;
	it ) 
		if [ "$arq" == 32 ]
		then
			echo "The download will begin in 5 seconds..."
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-i686/it/firefox-*.tar.bz2
		else
			echo "The download will begin in 5 seconds..."
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/it/firefox-*.tar.bz2
		fi ;;
	de ) 
		if [ "$arq" == 32 ]
		then
			echo "The download will begin in 5 seconds..."
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-i686/de/firefox-*.tar.bz2
		else
			echo "The download will begin in 5 seconds..."
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/de/firefox-*.tar.bz2
		fi ;;
esac

archi=$(ls | grep firefox-*.tar.bz2)
echo "Extracting $archi..."
tar -jxf firefox-*.tar.bz2

echo "Starting installation..."
echo "Copying \"firefox\" to /opt..."
cp -rf firefox /opt
echo "Creating the symbolic link in /usr/bin..."
if [ $(ls /usr/bin | grep firefox | wc -l) == 1 ]
then
	rm /usr/bin/firefox
fi
ln -s /opt/firefox/firefox /usr/bin/firefox
cp /opt/firefox/browser/icons/mozicon128.png /usr/share/pixmaps/firefox.png
echo "Adding Firefox to menu"
touch /usr/share/applications/firefox.desktop
echo -e "\n[Desktop Entry]\nName=Mozilla Firefox\nComment=Firefox-Browser\nExec=/usr/bin/firefox\nIcon=/usr/share/pixmaps/firefox.png\nTerminal=false" > /usr/share/applications/firefox.desktop
echo -e "Type=Application\nCategories=Network;\nStartupNotify=false;\nName[en_US]=Mozilla Firefox" >> /usr/share/applications/firefox.desktop
update-menus
echo "Installation Complete."
