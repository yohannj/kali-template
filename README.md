# Yet another repo?
Yes. I use a Kali virtual machine for learning cybersecurity and participating in Capture The Flag competitions.  
In such environment, it is important to have the ability to trash completely the VM and recreate it easily.

This repository provide scripts to setup a VM from scratch.

# Installation
## TL;DR
Get VirtualBox and Vagrant, update Vagrantfile to your taste then launch `vagrant up`.  
Create a file in `/shared/zsh/.zshrc_personal_commands` of this repo containing what you want to add at the end of `/shared/zsh/.zshrc`.

Run `. /vagrant/override_zsh.sh`, `/vagrant/override_firefox.sh` and then `/vagrant/install_all.sh`

If disk size is over 40GB, increase the partition for /dev/sda1 to 100GB (GParted live CD can help for that).

## Create the VM
### VirtualBox
We are going to work with VirtualBox. Download and install it: https://www.virtualbox.org/wiki/Downloads

### Vagrant
Download and install Vagrant: https://www.vagrantup.com/

By default the VM size is 40GB. After the whole setup around 18GB will be used.  
In case one need to go above 40GB, use the command line on the host to install a plugin that will handle that.
```powershell
vagrant plugin install vagrant-disksize
```

### Vagrantfile
The Vagrantfile is very simple and 3 variables are specified:
1. `vb.cpus = 3` - number of cpu cores that will be available in the VM  
2. `vb.memory = 8192` - number of RAM that will be available in the VM  
3. `config.disksize.size = '100GB'` - size of the VM disk. The disk is dynamically allocated so it will not reserve 100GB on the host but will grow over time with what is stored on the VM.

Note: the filesystem of the VM will still be 40GB when launched, and 60GB will be unallocated.

### Create the VM
In command line, execute the following command. Vagrant will setup the VM for you using VirtualBox.
```powershell
vagrant up
```

## Setup tools
### firefox
Run `/vagrant/override_firefox.sh`.
This will setup a predefined firefox profile with some bookmarks and plugins.

### zsh
Run `. /vagrant/override_zsh.sh`.  
Personal commands (not provided in this repo) written in `/vagrant/zsh/.zshrc_personal_commands` will be added at the end of `.zshrc` when calling the `override_zsh.sh` script.

### everything else
Run `/vagrant/install_all.sh`.  
The first time it is launched, while doing a `apt-get dist-upgrade`, a prompt for GRUB bootloader will appear. Select /dev/sda.  
This is the only thing that requires an input.

#### I want to add my own tools to this automation
`/vagrant/install_all.sh` can be launched any number of time without risks. Tools already installed will be skipped.

It is recommanded to use the same mecanism. For example create dedicated scripts and add them in `install_all.sh`.

I am still learning a lot about cybersecurity so this repository is focused on tools I use.  
I'm always happy to discover new tools though, if you are willing to contribute explain me how to use the tool you want and how it can help in cybersecurity and CTF compared to what is already in this repository.

## Increase partition size
There are many tutos for that.  
- Step 3 of http://derekmolloy.ie/resize-a-virtualbox-disk/  
- Starting at "You can use a GParted live CD" in the middle of https://www.howtogeek.com/124622/how-to-enlarge-a-virtual-machines-disk-in-virtualbox-or-vmware/  
- https://lmgtfy.app/?q=gparted+increase+partition+size+virtualbox

# Tools included
## Common
| Name         | Description                                                               |
| ------------ | ------------------------------------------------------------------------- |
| Sublime Text | Text editor. Use `subl <path>` to open a file or folder with Sublime Text |

## /home/vagrant/Scripts
| Name                              | Description                                                                                                   |
| --------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| smali                             | Assemble/Disassemble dex format, used by droidlysis for APK analysis                                          |
| apktool                           | Reverse engineer APK, used by droidlysis for APK analysis                                                     |
| dex2jar-2.0                       | Multiple tools for APK analysis, used by droidlysis                                                           |
| droidlysis                        | Property extractor for APK, helps in APK malware analysis                                                     |
| quark-engine                      | Another tool for APK malware analysis. Already in Kali, I don't know why I also downloaded it but here it is. |
| dirsearch                         | Scan the availability of specific folders and files on web servers                                            |
| evil-winrm                        | WinRM with additional capabilities for cybersecurity                                                          |
| extract_private_keys_from_dump.py | A personal scripts trying to extract private/public keys from a dump                                          |
| GitTools                          | Extract and reconstruct (partially) exposed git repository on web servers                                     |
| gzrt                              | GZip Recovery Tool                                                                                            |
| HiddenEye                         | Social engineering tool helping in phishing                                                                   |
| mitra                             | Fun tool to create a polyglot file (by Ange Albertini)                                                        |
| nikto                             | Web server scanner. Slower but more advanced results than nmap.                                               |
| My-NSE-Scripts                    | Few scripts for nmap                                                                                          |
| PowerSploit                       | PowerShell modules for pentest                                                                                |
| PEASS-ng                          | PrivEsc scanner                                                                                               |
| Responder                         | Not sure what it is. Used it to get hashed credentials in a CTF.                                              |
| RsaCtfTool                        | Try to break RSA keys                                                                                         |
| rsatool                           | Try to break RSA keys                                                                                         |
| ViperMonkey                       | Analyse malware in a Docker and scrap VBA code                                                                |

## /home/vagrant/Software
| Name       | Description                                                    |
| ---------- | -------------------------------------------------------------- |
| ida free   | Disassembler                                                   |
| ngrok      | Provide an online url/port tunneling to localhost              |
| volatility | Forensic on RAM dump                                           |
| Logic-2    | Logic analyzer of hardware signals going through Saleae device |

## /home/vagrant/steg
| Name            | Description                                      |
| --------------- | ------------------------------------------------ |
| lsb_image_stego | Password based LSB on PNG                        |
| Steganography   | Few tools for steganography, including wav files |
| Stegsolve       | Help steganographic investigation on images      |
