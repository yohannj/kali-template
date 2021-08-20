#!/bin/zsh

scriptDir=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")
cp "$scriptDir"/zsh/.zsh_aliases /home/vagrant/.zsh_aliases
cp "$scriptDir"/zsh/.zshrc /home/vagrant/.zshrc

if [ -f "$scriptDir/zsh/.zshrc_personal_commands" ] 
then
    cat "$scriptDir"/zsh/.zshrc_personal_commands >> /home/vagrant/.zshrc
fi

# Sourcing will only work if this script is called using `. ./override_zsh.sh`
# without '. ' at the beginning, zsh will create a new shell to execute the current commands
# in that case sourcing .zshrc will have consequences on that new shell, not the caller shell.
. /home/vagrant/.zshrc
