# ThinkPad X230 ACPI script

### Overview

Some ACPI functions (volume buttons, mic and volume mute) sometimes don't work by default on ThinkPad X230, especially if you aren't using a desktop environment. So I made this fairly simple script that hopefully saves you a few hours of browsing. 

It downloads acpid and (re)installs it, enables the acpid systemd service, adds user to 'users' group and creates the necessary files to enable volume and microphone control.

**Caution**

These scripts work with alsamixer (*alsa-utils* package) and not with pulseaudio directly (though its adaptation/addition should be simple).

### Running the script

> ./x230acpi.sh

### How did I get the button codes?

I installed acpid, a program that logs and handles laptop-specific functions (like closing the lid, pushing some buttons, etc.) and started it in listening mode and pressed the buttons.

> sudo pacman -S acpid

> sudo systemctl start acpid

> acpi\_listen

...and the code pops right up. 
