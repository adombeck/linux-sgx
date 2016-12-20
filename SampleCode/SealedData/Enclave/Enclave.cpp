/*
 * Copyright (C) 2011-2016 Intel Corporation. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 *   * Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *   * Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in
 *     the documentation and/or other materials provided with the
 *     distribution.
 *   * Neither the name of Intel Corporation nor the names of its
 *     contributors may be used to endorse or promote products derived
 *     from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */



#include "string.h"
#include "stdlib.h"
#include "stdio.h"
#include "sgx_trts.h"
#include "sgx_thread.h"
#include "sgx_tseal.h"

#include "Enclave_t.h"

void printf(const char *fmt, ...)
{
    char buf[BUFSIZ] = {'\0'};
    va_list ap;
    va_start(ap, fmt);
    vsnprintf(buf, BUFSIZ, fmt, ap);
    va_end(ap);
    print(buf);
}

static inline void free_allocated_memory(void *pointer)
{
    if(pointer != NULL)
    {
        free(pointer);
        pointer = NULL;
    }
}


int initialize_enclave()
{
    return 0;
}

int seal(sgx_sealed_data_t** p_sealed_buf, uint32_t* p_secret)
{
    uint32_t sealed_len = sizeof(sgx_sealed_data_t) + sizeof(*p_secret);
    // Check the sealed_buf length and check the outside pointers deeply
    if(*p_sealed_buf == NULL)
    {
        print("Incorrect input parameter: *p_sealed_buf is NULL.\n");
        return -1;
    }
    if(!sgx_is_outside_enclave(*p_sealed_buf, sealed_len))
    {
        print("Incorrect input parameter: *p_sealed_buf is outside enclave.\n");
        return -1;
    }

    char string_buf[BUFSIZ] = {'\0'};
    uint32_t temp_secret = 0;
    uint8_t *plain_text = NULL;
    uint32_t plain_text_length = 0;
    uint8_t *temp_sealed_buf = (uint8_t *)malloc(sealed_len);
    if(temp_sealed_buf == NULL)
    {
        print("Out of memory.\n");
        return -1;
    }
    memset(temp_sealed_buf, 0, sealed_len);


    // Seal the secret data
    sgx_status_t ret = sgx_seal_data(plain_text_length, plain_text, sizeof(*p_secret), (uint8_t*) p_secret, sealed_len, (sgx_sealed_data_t *)temp_sealed_buf);
    if(ret != SGX_SUCCESS)
    {
        print("Failed to seal data\n");
        free_allocated_memory(temp_sealed_buf);
        return -1;
    }
    // Backup the sealed data to outside buffer
    memcpy(*p_sealed_buf, temp_sealed_buf, sealed_len);
//    sealed_buf->index++;

    free_allocated_memory(temp_sealed_buf);

    // Ocall to print the unsealed secret data outside.
    // In theory, the secret data(s) SHOULD NOT be transferred outside the enclave as clear text(s).
    // So please DO NOT print any secret outside. Here printing the secret data to outside is only for demo.
    printf("secret: %u\n", *p_secret);
    return 0;
}

int unseal(sgx_sealed_data_t** p_sealed_buf, uint32_t* p_secret)
{
    // It is not the first time to initialize the enclave
    // Reinitialize the enclave to recover the secret data from the input backup sealed data.

    uint32_t len = sizeof(sgx_sealed_data_t) + sizeof(uint32_t);

    //Check the sealed_buf length and check the outside pointers deeply
    if(*p_sealed_buf == NULL)
    {
        print("Incorrect input parameter: *p_sealed_buf is NULL.\n");
        return -1;
    }
    if(!sgx_is_outside_enclave(*p_sealed_buf, len))
    {
        print("Incorrect input parameter: *p_sealed_buf is outside enclave.\n");
        return -1;
    }

    // Retrieve the secret from current backup sealed data
    uint32_t unsealed_data = 0;
    uint32_t unsealed_data_length = sizeof(*p_secret);
    uint8_t *plain_text = NULL;
    uint32_t plain_text_length = 0;
    uint8_t *temp_sealed_buf = (uint8_t *)malloc(len);
    if(temp_sealed_buf == NULL)
    {
        print("Out of memory.\n");
        return -1;
    }

    memcpy(temp_sealed_buf, *p_sealed_buf, len);

    print("Unsealing data\n");

    // Unseal current sealed buf
    sgx_status_t ret = sgx_unseal_data((sgx_sealed_data_t *)temp_sealed_buf, plain_text, &plain_text_length, (uint8_t *)&unsealed_data, &unsealed_data_length);
    if(ret != SGX_SUCCESS)
    {
        print("Failed to reinitialize the enclave.\n");
        free_allocated_memory(temp_sealed_buf);
        return -1;
    }

    *p_secret = unsealed_data;
    printf("Unsealed secret: %i\n", unsealed_data);
    free_allocated_memory(temp_sealed_buf);
    return 0;
}
