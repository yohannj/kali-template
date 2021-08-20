#!/bin/zsh

sudo apt-get install -qq -y lib32gcc-s1

echo "Ensuring directories under /home/vagrant/Software exist"
mkdir -p /home/vagrant/Software

if [ ! -f "/home/vagrant/Software/idafree76_linux.run" ] 
then
    echo "Downloading ida"
    wget -q https://out7.hex-rays.com/files/idafree76_linux.run -O /home/vagrant/Software/idafree76_linux.run
    chmod +x /home/vagrant/Software/idafree76_linux.run
    echo "You can now install ida by executing /home/vagrant/Software/idafree76_linux.run"
fi

if [ ! -f "/home/vagrant/Software/ngrok" ] 
then
    echo "Installing ngrok"
    wget -q https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip -O /home/vagrant/Software/ngrok.zip
    unzip -q -d /home/vagrant/Software /home/vagrant/Software/ngrok.zip
    rm /home/vagrant/Software/ngrok.zip
fi

if [ -z "${NGROK_AUTH_TOKEN}" ]
then
    echo "Missing NGROK_AUTH_TOKEN environment variable, auth will not be applied. You must run '/home/vagrant/Software/ngrok authtoken NGROK_AUTH_TOKEN'"
else
    /home/vagrant/Software/ngrok authtoken $NGROK_AUTH_TOKEN
fi

if [ ! -d "/home/vagrant/Software/volatility_2.6_lin64_standalone" ] 
then
    echo "Installing volatility"
    wget -q http://downloads.volatilityfoundation.org/releases/2.6/volatility_2.6_lin64_standalone.zip -O /home/vagrant/Software/volatility.zip
    unzip -q -d /home/vagrant/Software /home/vagrant/Software/volatility.zip
    rm /home/vagrant/Software/volatility.zip
fi

if [ ! -f "/home/vagrant/Software/Logic-2.3.33-master.AppImage" ] 
then
    echo "Installing Logic-2"
    wget -q https://downloads.saleae.com/logic2/Logic-2.3.33-master.AppImage -O /home/vagrant/Software/Logic-2.3.33-master.AppImage
    chmod +x /home/vagrant/Software/Logic-2.3.33-master.AppImage
fi
