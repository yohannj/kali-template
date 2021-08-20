#!/bin/zsh

if [ ! -d "/usr/share/wordlists/SecLists" ] 
then
    echo "Installing SecLists"
    sudo git clone -q https://github.com/danielmiessler/SecLists /usr/share/wordlists/SecLists
fi
