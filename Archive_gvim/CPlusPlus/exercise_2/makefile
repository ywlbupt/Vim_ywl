objects = main.o
main : $(objects)
	cc -o main $(objects)
main.o : main.c
	cc -c main.c
.PHONY : clean
clean : 
	-del main.exe $(objects)
