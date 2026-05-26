CC=gnatmake
OPTS= -gnat2022
SRC=ticketprogram.adb ticketprogrampackage.adb ticketprogrampackage.ads

build:
	${CC} ${OPTS} ./src/*

clean:
	rm -rf *.ali *.o 
