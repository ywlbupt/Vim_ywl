objects = main.o colorConsole.o
GreedySnaker : $(objects)
	g++ -o GreedySnaker $(objects)
main.o : main.cpp
	g++ -c main.cpp
colorConsole.o : colorConsole.h colorConsole.cpp
	g++ -c colorConsole.cpp
.PHONY : clean 
clean : 
	-del $(objects) GreedySnaker.exe
