#!/bin/zsh

scriptDir=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")

echo "Installing apt dependencies for scripts"
sudo apt-get install -qq -y default-jre \
                        docker-compose \
                        git \
                        libdb4o-cil-dev \
                        libgdm-dev \
                        libmagic-dev \
                        libncurses5-dev \
                        libpcap-dev
                        libreadline-dev \
                        libsqlite3-dev \
                        libssl-dev \
                        libtk8.6 \
                        libxml2-dev \
                        libxslt-dev \
                        python3 \
                        python3-pip \
                        python3-venv \
                        unzip \
                        wget

sudo usermod -aG docker vagrant

echo "Installing python3 dependencies for scripts"
python3 -m pip install --quiet mysql \
                            mysql-connector \
                            requests_ntlm \
                            pwntools

echo "Installing gem dependencies for scripts"
sudo gem install -qq --silent winrm \
    winrm-fs \
    stringio

echo "Ensuring directories under /home/vagrant/Scripts exist"
mkdir -p /home/vagrant/Scripts
mkdir -p /home/vagrant/Scripts/nmap_scripts

if [ ! -d "/home/vagrant/Scripts/dirsearch" ] 
then
    echo "Installing dirsearch"
    git clone -q https://github.com/maurosoria/dirsearch /home/vagrant/Scripts/dirsearch
fi

if [ ! -d "/home/vagrant/Scripts/evil-winrm" ] 
then
    echo "Installing evil-winrm"
    git clone -q https://github.com/Hackplayers/evil-winrm /home/vagrant/Scripts/evil-winrm
fi

if [ ! -f "/home/vagrant/Scripts/extract_private_keys_from_dump.py" ] 
then
    echo "Copying extract_private_keys_from_dump.py"
    cp "$scriptDir"/homemade_scripts/extract_private_keys_from_dump.py /home/vagrant/Scripts/extract_private_keys_from_dump.py
fi

if [ ! -f "/home/vagrant/.local/bin/flask-unsign" ]
then
    echo "Installing flask-unsign"
    python3 -m pip install --quiet --no-warn-script-location flask-unsign
    echo 'export PATH=/home/vagrant/.local/bin:$PATH' >> /home/vagrant/.zshenv
fi

if [ ! -d "/home/vagrant/Scripts/GitTools" ] 
then
    echo "Installing GitTools"
    git clone -q https://github.com/internetwache/GitTools /home/vagrant/Scripts/GitTools
fi

if [ ! -d "/home/vagrant/Scripts/gzrt" ] 
then
    echo "Installing gzrt"
    git clone -q https://github.com/arenn/gzrt /home/vagrant/Scripts/gzrt
fi

if [ ! -d "/home/vagrant/Scripts/HiddenEyeReborn" ]
then
    echo "Installing HiddenEye"
    git clone -q https://github.com/Open-Security-Group-OSG/HiddenEyeReborn /home/vagrant/Scripts/HiddenEyeReborn
fi

if [ ! -d "/home/vagrant/Scripts/jwt_tool" ]
then
    echo "Installing jwt_tool"
    git clone -q https://github.com/ticarpi/jwt_tool /home/vagrant/Scripts/jwt_tool
fi

https://github.com/ticarpi/jwt_tool

if [ ! -d "/home/vagrant/Scripts/mitra" ] 
then
    echo "Installing mitra"
    git clone -q https://github.com/corkami/mitra /home/vagrant/Scripts/mitra
fi

if [ ! -d "/home/vagrant/Scripts/nikto" ] 
then
    echo "Installing nikto"
    git clone -q https://github.com/sullo/nikto /home/vagrant/Scripts/nikto
fi

if [ ! -d "/home/vagrant/Scripts/nmap_scripts/My-NSE-Scripts" ] 
then
    echo "Installing My-NSE-Scripts"
    git clone -q https://github.com/RicterZ/My-NSE-Scripts /home/vagrant/Scripts/nmap_scripts/My-NSE-Scripts
fi

if [ ! -d "/home/vagrant/Scripts/PowerSploit" ] 
then
    echo "Installing PowerSploit"
    git clone -q https://github.com/PowerShellMafia/PowerSploit /home/vagrant/Scripts/PowerSploit
fi

if [ ! -d "/home/vagrant/Scripts/PEASS-ng" ] 
then
    echo "Installing PEASS-ng"
    git clone -q https://github.com/carlospolop/PEASS-ng /home/vagrant/Scripts/PEASS-ng
fi

if [ ! -d "/home/vagrant/Scripts/Responder" ] 
then
    echo "Installing Responder"
    git clone -q https://github.com/lgandx/Responder /home/vagrant/Scripts/Responder
fi

if [ ! -d "/home/vagrant/Scripts/RsaCtfTool" ] 
then
    echo "Installing RsaCtfTool"
    git clone -q https://github.com/Ganapati/RsaCtfTool /home/vagrant/Scripts/RsaCtfTool
fi

if [ ! -d "/home/vagrant/Scripts/rsatool" ] 
then
    echo "Installing rsatool"
    git clone -q https://github.com/ius/rsatool /home/vagrant/Scripts/rsatool
fi

if [ ! -d "/home/vagrant/Scripts/ViperMonkey" ] 
then
    echo "Installing ViperMonkey"
    git clone -q https://github.com/decalage2/ViperMonkey /home/vagrant/Scripts/ViperMonkey
fi
