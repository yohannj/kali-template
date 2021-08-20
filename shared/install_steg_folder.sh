#!/bin/zsh

echo "Ensuring directories under /home/vagrant/steg exist"
mkdir -p /home/vagrant/steg
mkdir -p /home/vagrant/png

if [ ! -d "/home/vagrant/steg/png/lsb_image_stego" ] 
then
    echo "Installing lsb_image_stego"
    git clone -q https://github.com/ra1nb0rn/lsb_image_stego /home/vagrant/steg/png/lsb_image_stego
fi

if [ ! -d "/home/vagrant/steg/Steganography" ] 
then
    echo "Installing Steganography"
    git clone -q https://github.com/ragibson/Steganography /home/vagrant/steg/Steganography
fi

if [ ! -f "/home/vagrant/steg/Stegsolve.jar" ] 
then
    echo "Installing Stegsolve"
    wget -q http://www.caesum.com/handbook/Stegsolve.jar -O /home/vagrant/steg/Stegsolve.jar
    chmod +x /home/vagrant/steg/Stegsolve.jar
fi
