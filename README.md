# skyEM
_skyEM_ is a game emulator, that runs in 16 bit real mode.
It can be run off of a floppy disk (not tested), usb drive (not tested), and an emulator (tested).
The emulator used for testing is Qemu --> qemu-system-i386 -fda bin/skyEM.img
Please note that skyEM does not ship with any games - You will have to add games to the games/ folder manually. (More info can be found in the setup.asm file, a little bit of assembly knowledge is required)

### FAQ
What does "skyEM" mean?
  - skyEM stands for Skyline Emulator

I would like to contribute, what can I do?
  - If you want to help me out, do some bug testing and enjoy skyEM's games!

### Tools used
  - nasm 2.15.04
  - GNU Make 4.3 

### Disclaimer
- USE THIS CODE AT YOUR OWN RISK, the author assumes no liability.
- I am still learning assembly, and this project is intended to help me expand my knowledge. (If you find malformed code, feel free to open an issue or contribute to the project)
- skyEM does not emulate any device in particular, it just try's to be a "gameboy" for bootsectors as best it can.

### Honourable mentions 
- Michael Petch who's answer on [this](https://stackoverflow.com/questions/53858770/how-to-fix-os-asm113-error-times-value-138-is-negative-in-assembly-languag) stackoverflow thread helped me address more than 512 bytes after I tried alot of stuff
