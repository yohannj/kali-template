#!/bin/zsh

java17_installed=$(dpkg-query -W --showformat='${Status}\n' "openjdk-17-jdk" | grep "install ok installed")
if [ "" = "$java17_installed" ]; then
    echo "Installing java 17"
    sudo apt-get install -qq -y openjdk-17-jdk
fi

sublime_text_installed=$(dpkg-query -W --showformat='${Status}\n' "sublime-text" | grep "install ok installed")
if [ "" = "$sublime_text_installed" ]; then
    echo "Installing Sublime Text"
    wget -q -O - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
    sudo apt-get install -qq -y apt-transport-https
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
    sudo apt-get update -qq
    sudo apt-get install -qq sublime-text
fi

if [ ! -d "/opt/gradle" ] 
then
    echo "Installing gradle"
    sudo mkdir /opt/gradle \
        && sudo wget -q -O /opt/gradle/gradle.zip https://downloads.gradle-dn.com/distributions/gradle-7.2-bin.zip \
        && sudo unzip -q -d /opt/gradle /opt/gradle/gradle.zip \
        && sudo rm /opt/gradle/gradle.zip \
        && sudo ln -sfn /opt/gradle/gradle-7.2 /opt/gradle/gradle
fi
