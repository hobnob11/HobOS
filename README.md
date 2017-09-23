# HobOS
hob os is littlery just a boot loader lol pls dont be impressed its like 90% mikeos with 10% hob-co spice.

# Prerequisites
Requires `nasm`, `qemu`, `kate` and `ncat` (just dnf install those lol)

# how to setup dev env:

 - you will want to use kate, `sudo dnf install kate`
 - after installing kate, clone this repo somewhere `git clone git@github.com:hobnob11/HobOS.git`
 - next, open kate, go into settings > configure kate...
 - editor components > Open/Save > Models & Filetypes > Filetype: Assembler/Intel x86 (NASM) > change Priority to 1.
 - Application > Plugins > enable the build plugin, project plugin, the terminal plugin, and the file system browser
 - apply and close settings window, click the build tab at the bottom, set the defualt Build target to execute `./buildandtest.sh`
 - open up Settings > Configure Shortcuts > search for `build`, bind `Build Default Target` to something (i bound it to f4)
 
thats it! now when you press f4, it should open up a qemu window and boot into the boot loader :D
you can even press f4 with qemu allready open, and it will reset the vm with the new binary without you having to do anything :D
 
