#!/bin/bash
echo "Installing acpid with pacman"
sudo pacman -S acpid

# some people had troubles when user was not in "users" group
echo "Adding user to users group"
username=$(whoami)
sudo usermod -aG users $username

# if you don't enable acpid as root, you must manually restart the service after rebooting, hence usage of "su"
echo "To enable acpi service you must be logged in as root"
su -c 'systemctl enable acpid' -m root

acpidir="/etc/acpi/events"
echo "Creating files for handling acpi events"

# echo itself into the file didn't work so tee is a workaround
echo -e "event=button/volumedown VOLDN 00000080 00000000 K\naction=/usr/bin/amixer sset 'Master',0 2-" | sudo tee -a "$acpidir/thinkpad-volume-down"

sudo echo -e "event=button/volumeup VOLUP 00000080 00000000 K\naction=/usr/bin/amixer sset 'Master',0 2+" | sudo tee -a "$acpidir/thinkpad-volume-up"

sudo echo -e "event=button/mute MUTE 00000080 00000000 K\naction=/usr/bin/amixer sset 'Master',0 toggle" | sudo tee -a "$acpidir/thinkpad-volume-toggle"

sudo echo -e "event=button/f20 F20 00000080 00000000 K\naction=/usr/bin/amixer sset 'Capture',0 toggle" | sudo tee -a "$acpidir/thinkpad-mic-mute"

# restarting the service can be done with sudo, applying the new functionality 
sudo systemctl restart acpid

echo -e "\n-------------------------------\nReboot your pc just to be sure, if buttons don't work, log in as root and enable + restart acpid.service.\n\nI also recommend installing thinkpad dock scripts with \"yay -S thinkpad-scripts\" \n"
exit 0
