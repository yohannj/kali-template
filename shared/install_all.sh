#!/bin/zsh

scriptDir=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")
"$scriptDir"/apt_full_update.sh
"$scriptDir"/install_common.sh
"$scriptDir"/install_scripts_folder.sh
"$scriptDir"/install_software_folder.sh
"$scriptDir"/install_steg_folder.sh
"$scriptDir"/install_wordlists.sh
