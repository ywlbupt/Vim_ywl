# executable files for this directory
OBJ = main_only.o ywl.o
PRG = main_only
FCP = main_only.cpp ywl.cpp
CC = g++

CCFLAGS = -Wall
LIB_FLAGS = -pthread 


edit : $(OBJ)
	$(CC) -g -o $(PRG) $(OBJ)

main_only.o : ywl.h main_only.cpp
	$(CC) -c $(CCFLAGS) main_only.cpp

ywl.o : ywl.h ywl.cpp
	$(CC) -c $(CCFLAGS) ywl.cpp	

# exec:
#	@echo helloworld
# # cd ~ ; pwd

.PHONY : clean
clean :
	-rm $(OBJ) $(PRG)
	# exec "!g++ % -g -Wall -o %<"
