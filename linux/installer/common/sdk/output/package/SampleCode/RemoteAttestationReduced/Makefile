all:
	@echo Compiling Enclave_c.t
	gcc -g -fpie -I/opt/pysgx/sgxsdk/include -iquote/opt/pysgx/sgxsdk/include/tlibc -c isv_enclave/isv_enclave_t.c -o isv_enclave/isv_enclave_t.o

	@echo Compiling...
	gcc -g -fpie -I/opt/pysgx/sgxsdk/include -iquote/opt/pysgx/sgxsdk/include/tlibc -c isv_enclave/isv_enclave.cpp -o isv_enclave/isv_enclave.o

	@echo Linking...
	gcc -g isv_enclave/isv_enclave_t.o isv_enclave/isv_enclave.o -o isv_enclave.so -static-libgcc -L/opt/pysgx/sgxsdk/lib64 -Wl,--whole-archive -lsgx_trts -Wl,--no-whole-archive -Wl,--start-group -lsgx_tstdc -lsgx_tstdcxx -lsgx_tkey_exchange -lsgx_tcrypto -lsgx_tservice -Wl,--end-group -Wl,-Bstatic -Wl,-Bsymbolic -Wl,--no-undefined -Wl,--defsym,__ImageBase=0 -Wl,--allow-multiple-definition 
	
clean: 
	rm -rf *.o *.so Enclave/Enclave.o

