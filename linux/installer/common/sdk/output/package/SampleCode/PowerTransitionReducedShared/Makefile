all:
	@echo Compiling Enclave_c.t
	cc -g -fpie -I/opt/intel/sgxsdk/include -c Enclave/Enclave_t.c -o Enclave/Enclave_t.o

	@echo Compiling...
	g++ -g -fpie -I/opt/intel/sgxsdk/include -I./Common -c Enclave/Enclave.cpp -o Enclave/Enclave.o
	
	@echo Linking...
	g++ -g Enclave/Enclave_t.o Enclave/Enclave.o -o libenclave.so -nodefaultlibs -nostartfiles -L/opt/intel/sgxsdk/lib64 -Wl,--whole-archive -lsgx_trts -Wl,--no-whole-archive -Wl,--start-group -lsgx_tstdc -lsgx_tstdcxx -lsgx_tcrypto -lsgx_tservice -Wl,--end-group -Wl,-pie,-eenclave_entry -Wl,--defsym,__ImageBase=0

clean: 
	rm -rf *.o *.so Enclave/Enclave.o

