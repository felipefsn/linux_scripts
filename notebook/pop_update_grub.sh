#!/bin/bash 
sudo apt update -y && sudo apt upgrade -y
sudo apt install grub-efi grub2-common grub-customizer
sudo grub-install
sudo cp /boot/grub/x86_64-efi/grub.efi /boot/efi/EFI/pop/grubx64.efi

#/boot/efi/EFI/pop/grub.cfg  output on grup customizer
