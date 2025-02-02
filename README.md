# Relectric-AA-Subsystem 
### Android Auto for Queen's Relectric ORION Headunit

The Relectric Android Auto subsytem relies on OpenAuto and the AASDK developped by f1xpl (https://github.com/f1xpl)

This repository contains an installation script abridged from repositories belonging to https://github.com/openDsh
The script was modified to only install aasdk, openauto, and required dependencies. 

### THIS IS EXPERIMENTAL SOFTWARE AND NOT GUARANTEED TO WORK AT ALL
This script is only intended for use on Queen's Relectric ORION Pi-based headunit. Use at your own risk. 

### Installation Instructions: 
#### In the terminal, enter the following commands:
```
cd ~

git clone https://github.com/QURelectric/AndroidAuto

cd AndroidAuto

sudo chmod +x install.sh

./install.sh

```

The installation script may take some time to fetch the required packages and build the c++ source code into an executable binary. 
When the installer is done (It will print ``` Install Finished ```), and the android auto executable can be started using the following commands:
```
cd ~/AndroidAuto/openauto/bin

autoapp
```
This will start the OpenAuto/Android Auto window, and wait for a phone to be connected over USB.




### Used software
 - [aasdk](https://github.com/f1xpl/aasdk)
 - [Boost libraries](http://www.boost.org/)
 - [libusb](http://libusb.info/)
 - [CMake](https://cmake.org/)
 - [Protocol buffers](https://developers.google.com/protocol-buffers/)
 - [OpenSSL](https://www.openssl.org/)
 - [Qt libraries](https://www.qt.io/)
 - [RtAudio](https://www.music.mcgill.ca/~gary/rtaudio/playback.html)
 - Broadcom ilclient from RaspberryPI 3 firmware
 - OpenMAX IL API

### Full list of dependecies TBA
