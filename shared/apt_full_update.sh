#!/bin/zsh

echo "Making sure apt is fully up to date"
echo "apt update"
sudo apt-get update -qq
echo "apt dist-upgrade, you might be prompt for a grub bootloader, choose /dev/sda"
sudo apt-get dist-upgrade -qq -y
echo "apt autoremove"
sudo apt-get autoremove -qq  -y
