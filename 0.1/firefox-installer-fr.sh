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
# Jimmy "nmussy" (Translator): jimmygaussen@gmail.com
#
# We have no relationship with Firefox(mozilla.org/firefox) or Mozilla(mozilla.org).

ROOT_UID=0
len=$(echo $LANG | cut -d '_' -f 1)
arq=$(getconf LONG_BIT)

clear
echo "Salut ! Et bienvenue sur Firefox Installer, un script pensé pour rendre l'installation de Firefox simple sur Debian."

if [ "$UID" -ne "$ROOT_UID" ]
then
  echo "Pour lancer ce script, vous devez le lancer en super utilistaeur (root)."
	sleep 5
	exit
else
	echo "Souvenez-vous que seul root peut lancer ce script."
fi
read -p "Firefox Installer va créer le dossier .firefox-installer dans $HOME. Est-ce que ça vous va ? (oui/non) : " resd
case $resd in
	[Oo]* ) cwd=$HOME;;
	* ) read -p "Voulez-vous entrer le dossier manuellement ? (oui/non) : " resdd
	case $resdd in
		[Oo]* ) read -p "Dossier: (Exemple: /home/foo) :" cwd;;
		* ) echo "Arrêt du script..."
		exit;;
	esac
esac
if [ $(ls -a $cwd | grep ".firefox-installer" | wc -l) == 1 ]
then
	read -p "Le dossier $cwd/.firefox-installer existe déjà, voulez-vous le supprimer pour pouvoir continuer ? (oui/non) : " resb
	case $resb in
		[Oo]* ) echo "$cwd/.firefox-installer a été supprimé.";;
		* ) echo "Arrêt du script..."
		exit;;
	esac
	rm -rf $cwd/.firefox-installer
fi
mkdir $cwd/.firefox-installer
echo "Le dossier $cwd/.firefox-installer a été créé."
cd $cwd/.firefox-installer
echo "Information du système : "
echo "Langue : $len"
echo "Architecture : $arq"

read -p "Est-ce que ça vous va ? (oui/non) : " res
case $res in
	[Oo]* ) echo "Très bien, continuons.";;
	* ) 
	echo "S'il vous plaît, veuillez entrer les informations manuellement :"
	read -p "Langue (fr/en/es/it/de) : " len
	case $len in
  	[Ff][Rr]* ) len=fr ;;
		[Ee][Nn]* ) len=en ;;
		[Ee][Ss]* ) len=es ;;
		[Ii][Tt]* ) len=it ;;
		[Dd][Ee]* ) len=de ;;
		* ) read -p "La langue n'est pas supportée par le script. Voulez-vous utiliser la version française ? (oui/non) : " resi
		case $resd in
			[Oo]* ) len=fr;;
			[Nn]* ) echo "Arrêt du script..."
			exit;;
		esac
	esac
	read -p "Architecture (32/64) : " arq
	case $arq in
		3* ) arq=32;;
		6* ) arq=64;;
		* ) echo "Architecture inconnue. Nous allons utiliser la version 32 bit par mesure de sécurité."
		arq=32;;
	esac
esac
case $len in
	fr ) 
		if [ "$arq" == 32 ]
		then
			echo "Le téléchargement commencera dans 5 secondes..."
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-i686/fr/firefox-*.tar.bz2
		else
			echo "Le téléchargement commencera dans 5 secondes..."
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/fr/firefox-*.tar.bz2
		fi ;;
	en ) 
		if [ "$arq" == 32 ]
		then
			echo "Le téléchargement commencera dans 5 secondes..."
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-i686/en-US/firefox-*.tar.bz2
		else
			echo "Le téléchargement commencera dans 5 secondes..."
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/en-US/firefox-*.tar.bz2
		fi ;;
	es ) 
		if [ "$arq" == 32 ]
		then
			echo "Le téléchargement commencera dans 5 secondes..."
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-i686/es-ES/firefox-*.tar.bz2
		else
			echo "Le téléchargement commencera dans 5 secondes..."
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/es-ES/firefox-*.tar.bz2
		fi ;;
	it ) 
		if [ "$arq" == 32 ]
		then
			echo "Le téléchargement commencera dans 5 secondes..."
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-i686/it/firefox-*.tar.bz2
		else
			echo "Le téléchargement commencera dans 5 secondes..."
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/it/firefox-*.tar.bz2
		fi ;;
	de ) 
		if [ "$arq" == 32 ]
		then
			echo "Le téléchargement commencera dans 5 secondes..."
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-i686/de/firefox-*.tar.bz2
		else
			echo "Le téléchargement commencera dans 5 secondes..."
			sleep 5 
			wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/de/firefox-*.tar.bz2
		fi ;;
esac

archi=$(ls | grep firefox-*.tar.bz2)
echo "Extraction d'$archi..."
tar -jxf firefox-*.tar.bz2

echo "Début de l'installation..."
echo "Copie de \"firefox\" vers /opt..."
cp -rf firefox /opt
echo "Création du lien symbolique dans /usr/bin..."
if [ $(ls /usr/bin | grep firefox | wc -l) == 1 ]
then
	rm /usr/bin/firefox
fi
ln -s /opt/firefox/firefox /usr/bin/firefox
cp /opt/firefox/browser/icons/mozicon128.png /usr/share/pixmaps/firefox.png
echo "Ajout de Firefox dans le menu"
touch /usr/share/applications/firefox.desktop
echo -e "\n[Desktop Entry]\nName=Mozilla Firefox\nComment=Firefox-Browser\nExec=/usr/bin/firefox\nIcon=/usr/share/pixmaps/firefox.png\nTerminal=false" > /usr/share/applications/firefox.desktop
echo -e "Type=Application\nCategories=Network;\nStartupNotify=false;\nName[en_US]=Mozilla Firefox" >> /usr/share/applications/firefox.desktop
update-menus
echo "L'installation est terminée."
