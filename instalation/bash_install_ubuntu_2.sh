#!/usr/bin/env bash

##
## Variáveis
##

PROGRAMAS_PARA_INSTALAR=(
  snapd
  flatpak
  variety
  simplenote
  audacity
  flameshot 
)


PPA_GRAPHICS_DRIVERS="ppa:graphics-drivers/ppa"


DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"

URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_4K_VIDEO_DOWNLOADER="https://dl.4kdownload.com/app/4kvideodownloader_4.9.2-1_amd64.deb"

##
## pre-conf ##
##

sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock;
sudo dpkg --add-architecture i386

sudo apt update -y

##
## Atualizar repositório ##
##

#sudo apt-add-repository "$PPA_GRAPHICS_DRIVERS" -y

sudo apt update -y

##
## Downloads programas externos
##

mkdir "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GOOGLE_CHROME"       -P "$DIRETORIO_DOWNLOADS"
#wget -c "$URL_WPS_OFFICE"	    -p "$DIRETORIO_DOWNLOADS"
#wget -c "$URL_SIMPLE_NOTE"         -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_4K_VIDEO_DOWNLOADER" -P "$DIRETORIO_DOWNLOADS"

sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

## 
## Instalar programas no apt
##

for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    sudo apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done

##
## Flatpack e snap
##

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.obsproject.Studio
flatpak install flathub com.spotify.Client

#sudo snap install spotify
#sudo snap install wps-office


## pós instalação

sudo apt update && sudo apt dist-upgrade -y
flatpack update
sudo apt autoclean
sudo apt autoremove -y



