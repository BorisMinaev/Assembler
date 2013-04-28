dct-test: dct-test.cpp dct
	g++ -std=c++11 dct-test.cpp -c -o build/dct-test.o -m32
	gcc build/dct-test.o build/dct.o -lstdc++ -o build/dct-test -m32

dct: dct.asm
	yasm dct.asm -o build/dct.o -f elf32
