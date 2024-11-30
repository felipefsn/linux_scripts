#!/bin/bash

##
## pre-conf ##
##

sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock;
sudo dpkg --add-architecture i386

##
## Atualizar repositório ##
##

sudo apt update && upgrade

##
## Downloads programas externos
##

URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_SIMPLE_NOTE="https://github.com/Automattic/simplenote-electron/releases/download/v1.8.0/Simplenote-linux-1.8.0-amd64.deb"
URL_4K_VIDEO_DOWNLOADER="https://dl.4kdownload.com/app/4kvideodownloader_4.9.2-1_amd64.deb"

DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"

mkdir "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GOOGLE_CHROME"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_SIMPLE_NOTE"         -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_4K_VIDEO_DOWNLOADER" -P "$DIRETORIO_DOWNLOADS"

sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

## 
## Instalar programas no apt
##

PROGRAMAS_PARA_INSTALAR=(
  snapd
  wps-office
  
)

for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done
