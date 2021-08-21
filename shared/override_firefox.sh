#!/bin/zsh

mkdir -p /home/vagrant/.mozilla/firefox/
scriptDir=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")
cp "$scriptDir"/firefox/installs.ini /home/vagrant/.mozilla/firefox/installs.ini
cp "$scriptDir"/firefox/profiles.ini /home/vagrant/.mozilla/firefox/profiles.ini
rm -rf /home/vagrant/.mozilla/firefox/lbdkp51y.default-esr
tar -xvzf "$scriptDir"/firefox/lbdkp51y.default-esr.tar.gz -C /home/vagrant/.mozilla/firefox
echo "To enable FoxyProxy's Burp profile, follow https://portswigger.net/burp/documentation/desktop/getting-started/proxy-setup/certificate/firefox"
