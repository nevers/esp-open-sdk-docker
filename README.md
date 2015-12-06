# esp-open-sdk-docker
This project builds a docker container for the ESP8266 SoC SDK. It builds the whole toolchain by shamelessly cloning & executing the integration scripts as provided here: https://github.com/pfalcon/esp-open-sdk/ The goal is to use this container as a base for any ESP8266 project.

Usage:
- Install docker: http://docker.io/
- ./docker-build
- You can now use the docker image to build your project. For more info, refer to  [esp-blinky-docker](https://github.com/nevers/esp-blinky-docker/) or [esp-httpd-docker](https://github.com/nevers/esp-httpd-docker/)

Reference schematic for flashing your code to the chip:
![Schematic](schematics/esp8266.png)
