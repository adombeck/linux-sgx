all:
	@echo Compiling Enclave_c.t
	cc -I/opt/intel/sgxsdk/include -I/opt/intel/sgxsdk/include/tlibc -I/opt/intel/sgxsdk/include/stlport -I./Common -c Enclave/Enclave_t.c -o Enclave/Enclave_t.o

	@echo Compiling...
	g++ -I/opt/intel/sgxsdk/include -I./Common -c Enclave/Enclave.cpp -o Enclave/Enclave.o
	
	@echo Linking...
	g++ Enclave/Enclave_t.o Enclave/Enclave.o -o enclave -L/opt/intel/sgxsdk/lib64 -Wl,--whole-archive -lsgx_trts -Wl,--no-whole-archive -Wl,--start-group -lsgx_tstdc -lsgx_tstdcxx -lsgx_tcrypto -lsgx_tservice -Wl,--end-group -Wl,--defsym,__ImageBase=0

clean: 
	rm -rf *.o *.so Enclave/Enclave.o

