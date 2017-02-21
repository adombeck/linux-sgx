all:
	@echo Compiling Enclave_c.t
	gcc -g -fpie -I/opt/pysgx/sgxsdk/include -iquote/opt/pysgx/sgxsdk/include/tlibc -c test_t.c -o test_t.o

	@echo Compiling...
	gcc -g -fpie -I/opt/pysgx/sgxsdk/include -iquote/opt/pysgx/sgxsdk/include/tlibc -c test.c -o test.o

	@echo Linking...
	gcc -g test_t.o test.o -o test.so -shared-libgcc -L/opt/pysgx/sgxsdk/lib64 -Wl,--whole-archive -lsgx_trts -Wl,--no-whole-archive -Wl,--start-group -lsgx_tstdc -lsgx_tstdcxx -lsgx_tkey_exchange -lsgx_tcrypto -lsgx_tservice -Wl,--end-group -Wl,-Bsymbolic -Wl,--no-undefined -Wl,--defsym,__ImageBase=0 -Wl,--allow-multiple-definition
	
clean: 
	rm -rf *.o *.so Enclave/Enclave.o

