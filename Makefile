CC=gnatmake
OPTS= -gnat95
SRC=ticketprogram.adb ticketprogrampackage.adb ticketprogrampackage.ads

build:
	${CC} ${OPTS} ./src/*

clean:
	rm -rf *.ali *.o 
