/*
* Math library
*
* Copyright (C) 2016 Intel Corporation. All rights reserved.
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
*
* Author Name <jingwei.zhang@intel.com>
*   History:
*   03-14-2016 Initial version. numerics svn rev. 12864
*/
	.file "casinh.c"
	.text
..TXTST0:
# -- Begin  casinhf
	.text
       .align    16,0x90
	.globl casinhf
casinhf:
# parameter 1: %xmm0
..B1.1:
	.cfi_startproc
..___tag_value_casinhf.1:
..L2:

        subq      $24, %rsp
	.cfi_def_cfa_offset 32
        cvtps2pd  %xmm0, %xmm1
        movaps    %xmm1, %xmm0
        unpckhpd  %xmm1, %xmm1
..___tag_value_casinhf.4:
        call      casinh@PLT
..___tag_value_casinhf.5:
..B1.10:
        unpcklpd  %xmm1, %xmm0
..B1.2:
        cvtpd2ps  %xmm0, %xmm0
        movsd     %xmm0, 4(%rsp)
        movzwl    6(%rsp), %eax
        testl     $32640, %eax
        jne       ..B1.4
..B1.3:
        testl     $8388607, 4(%rsp)
        jne       ..B1.6
..B1.4:
        movzwl    10(%rsp), %eax
        testl     $32640, %eax
        jne       ..B1.7
..B1.5:
        testl     $8388607, 8(%rsp)
        je        ..B1.7
..B1.6:
        movss     .L_2il0floatpacket.12(%rip), %xmm0
        mulss     %xmm0, %xmm0
        movss     %xmm0, (%rsp)
        movsd     4(%rsp), %xmm0
..B1.7:
        addq      $24, %rsp
	.cfi_def_cfa_offset 8
        ret       
        .align    16,0x90
	.cfi_endproc
	.type	casinhf,@function
	.size	casinhf,.-casinhf
	.data
# -- End  casinhf
	.text
# -- Begin  casinh
	.text
       .align    16,0x90
	.globl casinh
casinh:
# parameter 1: %xmm0
..B2.1:
	.cfi_startproc
..___tag_value_casinh.8:
..L9:

        pushq     %r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
        xorb      %r14b, %r14b
        subq      $176, %rsp
	.cfi_def_cfa_offset 192
        movsd     %xmm0, 16(%rsp)
        movsd     %xmm1, 24(%rsp)
..B2.2:
        fnstcw    162(%rsp)
..B2.3:
        movzwl    22(%rsp), %edx
        andl      $32752, %edx
        shrl      $4, %edx
        cmpl      $2047, %edx
        jge       ..B2.38
..B2.4:
        testl     %edx, %edx
        jle       ..B2.61
..B2.5:
        movzwl    30(%rsp), %eax
        andl      $32752, %eax
        shrl      $4, %eax
        cmpl      $2047, %eax
        jge       ..B2.39
..B2.6:
        testl     %eax, %eax
        jle       ..B2.59
..B2.7:
        movzwl    162(%rsp), %edx
        movl      %edx, %eax
        andl      $768, %eax
        cmpl      $768, %eax
        je        ..B2.11
..B2.8:
        orl       $-64768, %edx
        movw      %dx, 160(%rsp)
..B2.9:
        fldcw     160(%rsp)
..B2.10:
        movb      $1, %r14b
..B2.11:
        fldt      .L_2il0floatpacket.13(%rip)
        lea       BcrossA(%rip), %rax
        movsd     24(%rsp), %xmm0
        fld       %st(0)
        fldt      .L_2il0floatpacket.14(%rip)
        movsd     %xmm0, 136(%rsp)
        fldt      (%rax)
        andps     .L_2il0floatpacket.15(%rip), %xmm0
        movsd     %xmm0, (%rsp)
        fldl      (%rsp)
        movsd     16(%rsp), %xmm1
        fadd      %st, %st(4)
        movsd     %xmm1, 128(%rsp)
        xorps     .L_2il0floatpacket.16(%rip), %xmm1
        andps     .L_2il0floatpacket.15(%rip), %xmm1
        movsd     %xmm1, (%rsp)
        fxch      %st(4)
        fstpt     72(%rsp)
        fldt      72(%rsp)
        fxch      %st(3)
        fsubr     %st(4), %st
        fstpt     104(%rsp)
        fldt      104(%rsp)
        fxch      %st(3)
        fmul      %st(0), %st
        fxch      %st(3)
        fmul      %st(0), %st
        fldl      (%rsp)
        fld       %st(0)
        fmul      %st(1), %st
        fadd      %st, %st(5)
        fxch      %st(5)
        fsqrt     
        fld       %st(0)
        fxch      %st(3)
        fadd      %st(6), %st
        fsqrt     
        fstpt     88(%rsp)
        fldt      88(%rsp)
        faddp     %st, %st(3)
        fxch      %st(4)
        fmulp     %st, %st(2)
        fld       %st(5)
        fdiv      %st(2), %st
        fxch      %st(3)
        fcomip    %st(3), %st
        jb        ..B2.13
..B2.12:
        fstp      %st(0)
        addq      $-16, %rsp
	.cfi_def_cfa_offset 208
        fxch      %st(1)
        fstpt     (%rsp)
        fxch      %st(3)
        fstpl     136(%rsp)
        fstpt     16(%rsp)
        fstpt     32(%rsp)
        fstpt     48(%rsp)
        call      asinl@PLT
        jmp       ..B2.85
	.cfi_def_cfa_offset 192
..B2.13:
        fstp      %st(2)
        fldt      .L_2il0floatpacket.13(%rip)
        fcomip    %st(5), %st
        jb        ..B2.15
..B2.14:
        fstp      %st(1)
        addq      $-16, %rsp
	.cfi_def_cfa_offset 208
        fld       %st(0)
        lea       halfs(%rip), %rax
        fadd      %st(4), %st
        fmull     (%rax)
        fldt      88(%rsp)
        fldt      104(%rsp)
        fxch      %st(1)
        fadd      %st(4), %st
        fdivr     %st(5), %st
        fldt      120(%rsp)
        fsubrp    %st, %st(2)
        faddp     %st, %st(1)
        fmulp     %st, %st(1)
        fsqrt     
        fld1      
        fdivp     %st, %st(1)
        fmul      %st(4), %st
        fstpt     (%rsp)
        fxch      %st(3)
        fstpl     136(%rsp)
        fstpt     16(%rsp)
        fstpt     32(%rsp)
        fstpt     48(%rsp)
        call      atanl@PLT
        jmp       ..B2.85
	.cfi_def_cfa_offset 192
..B2.15:
        fxch      %st(2)
        fstpt     (%rsp)
        fldt      (%rsp)
        addq      $-16, %rsp
	.cfi_def_cfa_offset 208
        fld       %st(2)
        fadd      %st(5), %st
        fldt      88(%rsp)
        faddp     %st, %st(2)
        fdiv      %st, %st(1)
        fldt      120(%rsp)
        fldt      104(%rsp)
        faddp     %st, %st(1)
        fdivrp    %st, %st(1)
        faddp     %st, %st(1)
        fldt      .L_2il0floatpacket.14(%rip)
        fmulp     %st, %st(1)
        fsqrt     
        fmulp     %st, %st(1)
        fdivr     %st(3), %st
        fstpt     (%rsp)
        fxch      %st(2)
        fstpl     136(%rsp)
        fstpt     32(%rsp)
        fstpt     48(%rsp)
        fldt      16(%rsp)
        fstpt     16(%rsp)
        call      atanl@PLT
..B2.85:
        fldt      48(%rsp)
        fxch      %st(1)
        fchs      
        fldt      32(%rsp)
        fldt      16(%rsp)
        fldl      136(%rsp)
        addq      $16, %rsp
	.cfi_def_cfa_offset 192
        fxch      %st(3)
        fstpl     64(%rsp)
..B2.16:
        lea       AcrossA(%rip), %rax
        fldt      (%rax)
        fcomip    %st(4), %st
        jb        ..B2.21
..B2.17:
        fldt      72(%rsp)
        faddp     %st, %st(1)
        fldt      .L_2il0floatpacket.13(%rip)
        fcomip    %st(3), %st
        fxch      %st(2)
        fstp      %st(0)
        jbe       ..B2.19
..B2.18:
        fldt      88(%rsp)
        fxch      %st(1)
        fdiv      %st, %st(2)
        fldt      104(%rsp)
        fsubrp    %st, %st(2)
        fdivp     %st, %st(1)
        faddp     %st, %st(1)
        fldt      .L_2il0floatpacket.14(%rip)
        fmulp     %st, %st(1)
        jmp       ..B2.20
..B2.19:
        fldt      88(%rsp)
        fxch      %st(2)
        fdivrp    %st, %st(1)
        fldt      104(%rsp)
        faddp     %st, %st(2)
        faddp     %st, %st(1)
        fldt      .L_2il0floatpacket.14(%rip)
        fmulp     %st, %st(1)
..B2.20:
        fldt      .L_2il0floatpacket.13(%rip)
        addq      $-16, %rsp
	.cfi_def_cfa_offset 208
        faddp     %st, %st(2)
        fmul      %st, %st(1)
        fxch      %st(1)
        fsqrt     
        faddp     %st, %st(1)
        fstpt     (%rsp)
        call      log1pl@PLT
        jmp       ..B2.87
	.cfi_def_cfa_offset 192
..B2.21:
        fstp      %st(0)
        fstp      %st(0)
        fstp      %st(0)
        fldt      .L_2il0floatpacket.13(%rip)
        fld       %st(1)
        fmul      %st(2), %st
        addq      $-16, %rsp
	.cfi_def_cfa_offset 208
        fsubp     %st, %st(1)
        fsqrt     
        faddp     %st, %st(1)
        fstpt     (%rsp)
        call      logl@PLT
..B2.87:
        addq      $16, %rsp
	.cfi_def_cfa_offset 192
        fstpl     (%rsp)
        movsd     (%rsp), %xmm2
..B2.22:
        lea       ZEROA(%rip), %rax
        movsd     136(%rsp), %xmm0
        movsd     (%rax), %xmm1
        comisd    %xmm1, %xmm0
        jbe       ..B2.24
..B2.23:
        movsd     64(%rsp), %xmm0
        xorps     .L_2il0floatpacket.16(%rip), %xmm0
        movsd     %xmm0, 152(%rsp)
        jmp       ..B2.25
..B2.24:
        movsd     64(%rsp), %xmm0
        movsd     %xmm0, 152(%rsp)
..B2.25:
        comisd    128(%rsp), %xmm1
        jbe       ..B2.27
..B2.26:
        xorps     .L_2il0floatpacket.16(%rip), %xmm2
        movsd     %xmm2, 144(%rsp)
        jmp       ..B2.28
..B2.27:
        movsd     %xmm2, 144(%rsp)
..B2.28:
        movzwl    150(%rsp), %eax
        testl     $32752, %eax
        jne       ..B2.31
..B2.29:
        testl     $1048575, 148(%rsp)
        jne       ..B2.34
..B2.30:
        cmpl      $0, 144(%rsp)
        jne       ..B2.34
..B2.31:
        movzwl    158(%rsp), %eax
        testl     $32752, %eax
        jne       ..B2.35
..B2.32:
        testl     $1048575, 156(%rsp)
        jne       ..B2.34
..B2.33:
        cmpl      $0, 152(%rsp)
        je        ..B2.35
..B2.34:
        lea       _LDB_MIN_NORMAL(%rip), %rax
        fldt      (%rax)
        fmul      %st(0), %st
        fstpt     48(%rsp)
..B2.35:
        testb     %r14b, %r14b
        je        ..B2.37
..B2.36:
        fldcw     162(%rsp)
..B2.37:
        movsd     144(%rsp), %xmm0
        movsd     152(%rsp), %xmm1
        addq      $176, %rsp
	.cfi_def_cfa_offset 16
	.cfi_restore 14
        popq      %r14
	.cfi_def_cfa_offset 8
        ret       
	.cfi_def_cfa_offset 192
	.cfi_offset 14, -16
..B2.38:
        movzwl    30(%rsp), %eax
        andl      $32752, %eax
        shrl      $4, %eax
..B2.39:
        testl     %eax, %eax
        jne       ..B2.43
..B2.40:
        testl     $1048575, 28(%rsp)
        jne       ..B2.43
..B2.41:
        cmpl      $0, 24(%rsp)
        jne       ..B2.43
..B2.42:
        movsd     16(%rsp), %xmm0
        call      asinh@PLT
..B2.88:
        movhpd    24(%rsp), %xmm0
        movsd     %xmm0, 144(%rsp)
        movhpd    %xmm0, 152(%rsp)
        jmp       ..B2.58
..B2.43:
        testl     %edx, %edx
        jne       ..B2.53
..B2.44:
        testl     $1048575, 20(%rsp)
        jne       ..B2.54
..B2.45:
        cmpl      $0, 16(%rsp)
        jne       ..B2.54
..B2.46:
        cmpl      $2047, %eax
        jl        ..B2.49
..B2.47:
        testl     $1048575, 28(%rsp)
        jne       ..B2.54
..B2.48:
        cmpl      $0, 24(%rsp)
        jne       ..B2.54
..B2.49:
        movsd     24(%rsp), %xmm0
        cmpl      $1023, %eax
        jl        ..B2.51
..B2.50:
        movb      31(%rsp), %r14b
        andb      $-128, %r14b
        shrb      $7, %r14b
        movzbl    %r14b, %eax
        lea       ones(%rip), %r14
        movsd     (%r14,%rax,8), %xmm1
        mulsd     %xmm1, %xmm0
        movsd     %xmm1, (%rsp)
        call      acosh@PLT
..B2.90:
        movsd     %xmm0, 8(%rsp)
        movsd     (%rsp), %xmm0
        call      asin@PLT
        jmp       ..B2.52
..B2.51:
        pxor      %xmm1, %xmm1
        movsd     %xmm1, 8(%rsp)
        call      asin@PLT
..B2.91:
        lea       ones(%rip), %r14
..B2.52:
        movb      23(%rsp), %al
        andb      $-128, %al
        shrb      $7, %al
        movsd     %xmm0, 152(%rsp)
        movsd     8(%rsp), %xmm0
        movzbl    %al, %edx
        mulsd     (%r14,%rdx,8), %xmm0
        movsd     %xmm0, 144(%rsp)
        movhpd    152(%rsp), %xmm0
        jmp       ..B2.58
..B2.53:
        cmpl      $2047, %edx
        je        ..B2.71
..B2.54:
        cmpl      $2047, %eax
        je        ..B2.67
..B2.94:
        cmpl      $2047, %edx
..B2.55:
        je        ..B2.64
..B2.56:
        movsd     24(%rsp), %xmm0
        movaps    %xmm0, %xmm3
        movsd     16(%rsp), %xmm2
        mulsd     %xmm0, %xmm3
..B2.57:
        movb      23(%rsp), %al
        lea       ones(%rip), %rdx
        andb      $-128, %al
        shrb      $7, %al
        movzbl    %al, %ecx
        movsd     (%rdx,%rcx,8), %xmm1
        mulsd     %xmm1, %xmm3
        mulsd     %xmm2, %xmm1
        movsd     %xmm3, 144(%rsp)
        call      atan2@PLT
..B2.92:
        movsd     %xmm0, 152(%rsp)
        movsd     144(%rsp), %xmm0
        movhpd    152(%rsp), %xmm0
..B2.58:
        movaps    %xmm0, %xmm1
        unpckhpd  %xmm0, %xmm1
        addq      $176, %rsp
	.cfi_def_cfa_offset 16
	.cfi_restore 14
        popq      %r14
	.cfi_def_cfa_offset 8
        ret       
	.cfi_def_cfa_offset 192
	.cfi_offset 14, -16
..B2.59:
        testl     $1048575, 28(%rsp)
        jne       ..B2.7
..B2.60:
        cmpl      $0, 24(%rsp)
        jne       ..B2.7
        jmp       ..B2.39
..B2.61:
        testl     $1048575, 20(%rsp)
        jne       ..B2.5
..B2.62:
        cmpl      $0, 16(%rsp)
        jne       ..B2.5
        jmp       ..B2.38
..B2.64:
        testl     $1048575, 20(%rsp)
        jne       ..B2.56
..B2.65:
        cmpl      $0, 16(%rsp)
        jne       ..B2.56
..B2.66:
        movsd     16(%rsp), %xmm2
        movaps    %xmm2, %xmm3
        movsd     24(%rsp), %xmm0
        mulsd     %xmm2, %xmm3
        jmp       ..B2.57
..B2.67:
        testl     $1048575, 28(%rsp)
        jne       ..B2.69
..B2.68:
        cmpl      $0, 24(%rsp)
        je        ..B2.93
..B2.69:
        cmpl      $2047, %edx
        jge       ..B2.55
..B2.70:
        movsd     24(%rsp), %xmm0
        mulsd     %xmm0, %xmm0
        unpcklpd  %xmm0, %xmm0
        movsd     %xmm0, 144(%rsp)
        movhpd    %xmm0, 152(%rsp)
        jmp       ..B2.58
..B2.71:
        testl     $1048575, 20(%rsp)
        jne       ..B2.73
..B2.72:
        cmpl      $0, 16(%rsp)
        je        ..B2.74
..B2.73:
        cmpl      $2047, %eax
        je        ..B2.78
..B2.74:
        testl     $1048575, 20(%rsp)
        jne       ..B2.76
..B2.75:
        cmpl      $0, 16(%rsp)
        je        ..B2.54
..B2.76:
        cmpl      $2047, %eax
        jge       ..B2.54
..B2.77:
        movsd     16(%rsp), %xmm0
        mulsd     %xmm0, %xmm0
        unpcklpd  %xmm0, %xmm0
        movsd     %xmm0, 144(%rsp)
        movhpd    %xmm0, 152(%rsp)
        jmp       ..B2.58
..B2.78:
        testl     $1048575, 28(%rsp)
        jne       ..B2.80
..B2.79:
        cmpl      $0, 24(%rsp)
        je        ..B2.74
..B2.80:
        movsd     24(%rsp), %xmm1
        movsd     16(%rsp), %xmm0
        mulsd     %xmm0, %xmm0
        mulsd     %xmm1, %xmm1
        unpcklpd  %xmm1, %xmm0
        movsd     %xmm0, 144(%rsp)
        movhpd    %xmm0, 152(%rsp)
        jmp       ..B2.58
..B2.93:
        cmpl      $2047, %edx
        je        ..B2.64
        jmp       ..B2.56
        .align    16,0x90
	.cfi_endproc
	.type	casinh,@function
	.size	casinh,.-casinh
	.data
# -- End  casinh
	.section .rodata, "a"
	.align 16
	.align 16
.L_2il0floatpacket.13:
	.byte	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x80,0xff,0x3f,0x00,0x00,0x00,0x00,0x00,0x00
	.type	.L_2il0floatpacket.13,@object
	.size	.L_2il0floatpacket.13,16
	.align 16
.L_2il0floatpacket.14:
	.byte	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x80,0xfe,0x3f,0x00,0x00,0x00,0x00,0x00,0x00
	.type	.L_2il0floatpacket.14,@object
	.size	.L_2il0floatpacket.14,16
	.align 16
.L_2il0floatpacket.15:
	.long	0xffffffff,0x7fffffff,0x00000000,0x00000000
	.type	.L_2il0floatpacket.15,@object
	.size	.L_2il0floatpacket.15,16
	.align 16
.L_2il0floatpacket.16:
	.long	0x00000000,0x80000000,0x00000000,0x00000000
	.type	.L_2il0floatpacket.16,@object
	.size	.L_2il0floatpacket.16,16
	.align 16
BcrossA:
	.long	1717986918
	.long	3865470566
	.long	16382
	.long	0
	.type	BcrossA,@object
	.size	BcrossA,16
	.align 16
AcrossA:
	.long	0
	.long	3221225472
	.long	16383
	.long	0
	.type	AcrossA,@object
	.size	AcrossA,16
	.align 16
ZEROA:
	.long	0
	.long	0
	.type	ZEROA,@object
	.size	ZEROA,8
	.space 8, 0x00 	# pad
	.align 16
_LDB_MIN_NORMAL:
	.word	0
	.word	0
	.word	0
	.word	32768
	.word	1
	.word	0
	.word	0
	.word	0
	.type	_LDB_MIN_NORMAL,@object
	.size	_LDB_MIN_NORMAL,16
	.align 8
halfs:
	.long	0x00000000,0x3fe00000
	.long	0x00000000,0xbfe00000
	.type	halfs,@object
	.size	halfs,16
	.align 8
ones:
	.long	0x00000000,0x3ff00000
	.long	0x00000000,0xbff00000
	.type	ones,@object
	.size	ones,16
	.align 4
.L_2il0floatpacket.12:
	.long	0x00800000
	.type	.L_2il0floatpacket.12,@object
	.size	.L_2il0floatpacket.12,4
	.data
	.section .note.GNU-stack, ""
// -- Begin DWARF2 SEGMENT .eh_frame
	.section .eh_frame,"a",@progbits
.eh_frame_seg:
	.align 1
# End
