# skyEM
skyEM is a game emulator, that runs in 16 bit real mode.
It can be run off of a floppy disk (not tested), usb drive (not tested), and an emulator (tested).
The emulator used for testing is Qemu --> qemu-system-i386 -fda bin/skyEM.img

What does "skyEM" mean?
  - skyEM stands for Skyline Emulator

I would like to contribute, what can I do?
  - If you want to help me out, do some bug testing and enjoy skyEM's games!

NOTE: skyEM does not emulate any device in particular, it just try's to emulate retro games as best it can.

# Tools used
  - nasm 2.15.04
  - GNU Make 4.3 

# Disclaimer
- This project is NOT finished -> ((VERY) Early stage of development - Do not expect flawless and pretty formatted code)
- This code may break your device if you are not carefull, the author of this assumes no liability.

# Honourable mentions 
- Michael Petch who's answer on this stackoverflow thread helped me address more than 512 bytes after I tried alot of stuff (https://stackoverflow.com/questions/53858770/how-to-fix-os-asm113-error-times-value-138-is-negative-in-assembly-languag)
