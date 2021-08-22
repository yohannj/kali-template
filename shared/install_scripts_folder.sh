#!/bin/zsh

scriptDir=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")

echo "Installing apt dependencies for scripts"
sudo apt-get install -qq -y default-jre \
                        git \
                        libmagic-dev \
                        libxml2-dev \
                        libxslt-dev \
                        python3 \
                        python3-pip \
                        python3-venv \
                        unzip \
                        wget

echo "Installing gem dependencies for scripts"
sudo gem install -qq --silent winrm \
    winrm-fs \
    stringio

echo "Ensuring directories under /home/vagrant/Scripts exist"
mkdir -p /home/vagrant/Scripts
mkdir -p /home/vagrant/Scripts/apk_libs
mkdir -p /home/vagrant/Scripts/nmap_scripts

if [ ! -d "/home/vagrant/Scripts/apk_libs/smali" ] 
then
    echo "Install smali for assembling/disassembling of dex format (apk analysis)"

    git clone -q https://github.com/JesusFreke/smali /home/vagrant/Scripts/apk_libs/smali
    /opt/gradle/gradle/bin/gradle build -q -p /home/vagrant/Scripts/apk_libs/smali

    version=$(perl -nle 'print $1 if(/^version = '\''([\d.]+)'\''$/)' /home/vagrant/Scripts/apk_libs/smali/build.gradle)
    ln -sfn /home/vagrant/Scripts/apk_libs/smali/baksmali/build/libs/baksmali-$version-cbd41d36-dirty.jar /home/vagrant/Scripts/apk_libs/baksmali.jar
fi

if [ ! -d "/home/vagrant/Scripts/apk_libs/apktool" ] 
then
    echo "Install apktool for reverse engineering apk"

    git clone -q https://github.com/iBotPeaches/Apktool /home/vagrant/Scripts/apk_libs/apktool
    /opt/gradle/gradle/bin/gradle build shadowJar -q -p /home/vagrant/Scripts/apk_libs/apktool

    version=$(perl -nle 'print $1 if(/^version = '\''([\d.]+)'\''$/)' /home/vagrant/Scripts/apk_libs/apktool/build.gradle)
    ln -sfn /home/vagrant/Scripts/apk_libs/apktool/build/libs/apktool-$version.jar /home/vagrant/Scripts/apk_libs/apktool.jar
fi

if [ ! -d "/home/vagrant/Scripts/apk_libs/dex2jar-2.0" ] 
then
    echo "Installing dex2jar 2.0"
    wget -q https://github.com/pxb1988/dex2jar/releases/download/2.0/dex-tools-2.0.zip -O /home/vagrant/Scripts/apk_libs/dex2jar-2.0.zip
    unzip -q -d /home/vagrant/Scripts/apk_libs /home/vagrant/Scripts/apk_libs/dex2jar-2.0.zip
    chmod 755 /home/vagrant/Scripts/apk_libs/dex2jar-2.0.zip
    rm /home/vagrant/Scripts/apk_libs/dex2jar-2.0.zip
fi

if [ ! -d "/home/vagrant/Scripts/apk_libs/droidlysis" ] 
then
    echo "Installing droidlysis"

    git clone -q https://github.com/cryptax/droidlysis /home/vagrant/Scripts/apk_libs/droidlysis
    python3 -m venv /home/vagrant/Scripts/apk_libs/droidlysis/.venv
    /home/vagrant/Scripts/apk_libs/droidlysis/.venv/bin/pip3 -q install -r /home/vagrant/Scripts/apk_libs/droidlysis/requirements.txt

    perl -i -pe 's/^APKTOOL_JAR = .*?$/APKTOOL_JAR = os.path.join( os.path.expanduser("\/home\/vagrant\/Scripts\/apk_libs"), "apktool.jar")/' /home/vagrant/Scripts/apk_libs/droidlysis/droidconfig.py
    perl -i -pe 's/^BAKSMALI_JAR = .*?$/BAKSMALI_JAR = os.path.join( os.path.expanduser("\/home\/vagrant\/Scripts\/apk_libs"), "baksmali.jar")/' /home/vagrant/Scripts/apk_libs/droidlysis/droidconfig.py
    perl -i -pe 's/^DEX2JAR_CMD = .*?$/DEX2JAR_CMD = os.path.join( os.path.expanduser("\/home\/vagrant\/Scripts\/apk_libs\/dex2jar-2.0"), "d2j-dex2jar.sh")/' /home/vagrant/Scripts/apk_libs/droidlysis/droidconfig.py
    perl -i -pe 's/^INSTALL_DIR = .*?$/INSTALL_DIR = os.path.expanduser("\/home\/vagrant\/Scripts\/apk_libs\/droidlysis")/' /home/vagrant/Scripts/apk_libs/droidlysis/droidconfig.py
fi

if [ ! -d "/home/vagrant/Scripts/apk_libs/quark-engine" ] 
then
    echo "Install quark-engine"
    git clone -q https://github.com/quark-engine/quark-engine /home/vagrant/Scripts/apk_libs/quark-engine
fi

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

if [ ! -d "/home/vagrant/Scripts/HiddenEye" ] 
then
    echo "Installing HiddenEye"
    git clone -q https://github.com/DarkSecDevelopers/HiddenEye-Legacy /home/vagrant/Scripts/HiddenEye
fi

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

if [ ! -d "/home/vagrant/Scripts/linux-exploit-suggester-2" ] 
then
    echo "Installing linux-exploit-suggester-2"
    git clone -q https://github.com/jondonas/linux-exploit-suggester-2 /home/vagrant/Scripts/linux-exploit-suggester-2
fi
