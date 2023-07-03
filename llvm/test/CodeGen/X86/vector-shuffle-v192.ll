; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-pc-linux -mattr=+avx2 | FileCheck %s --check-prefix=AVX2
; RUN: llc < %s -mtriple=x86_64-pc-linux -mattr=+avx512f,+avx512vl | FileCheck %s --check-prefix=AVX512F
; RUN: llc < %s -mtriple=x86_64-pc-linux -mattr=+avx512f,+avx512vl,+avx512bw | FileCheck %s --check-prefix=AVX512BW
; RUN: llc < %s -mtriple=x86_64-pc-linux -mattr=+avx512f,+avx512vl,+avx512vbmi | FileCheck %s --check-prefix=AVX512VBMI

define <64 x i8> @f1(ptr %p0) {
; AVX2-LABEL: f1:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovdqa 128(%rdi), %ymm1
; AVX2-NEXT:    vmovdqa 32(%rdi), %ymm0
; AVX2-NEXT:    vmovdqa (%rdi), %xmm2
; AVX2-NEXT:    vmovdqa 16(%rdi), %xmm3
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm4 = <128,128,128,128,128,128,3,5,9,11,15,u,u,u,u,u>
; AVX2-NEXT:    vpshufb %xmm4, %xmm3, %xmm3
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm5 = <1,3,7,9,13,15,128,128,128,128,128,u,u,u,u,u>
; AVX2-NEXT:    vpshufb %xmm5, %xmm2, %xmm2
; AVX2-NEXT:    vpor %xmm3, %xmm2, %xmm2
; AVX2-NEXT:    vmovdqa {{.*#+}} ymm3 = <u,u,u,u,u,u,u,u,u,u,u,1,5,7,11,13,1,3,7,9,13,15,u,u,u,u,u,u,u,u,u,u>
; AVX2-NEXT:    vpshufb %ymm3, %ymm0, %ymm0
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm6 = [255,255,255,255,255,255,255,255,255,255,255,0,0,0,0,0]
; AVX2-NEXT:    vpblendvb %ymm6, %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    vmovdqa 80(%rdi), %xmm2
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm7 = <u,u,u,u,u,u,128,128,128,128,128,1,5,7,11,13>
; AVX2-NEXT:    vpshufb %xmm7, %xmm2, %xmm2
; AVX2-NEXT:    vmovdqa 64(%rdi), %xmm8
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm9 = <u,u,u,u,u,u,3,5,9,11,15,128,128,128,128,128>
; AVX2-NEXT:    vpshufb %xmm9, %xmm8, %xmm8
; AVX2-NEXT:    vpor %xmm2, %xmm8, %xmm2
; AVX2-NEXT:    vinserti128 $1, %xmm2, %ymm0, %ymm2
; AVX2-NEXT:    vpblendw {{.*#+}} ymm2 = ymm0[0,1,2],ymm2[3,4,5,6,7],ymm0[8,9,10],ymm2[11,12,13,14,15]
; AVX2-NEXT:    vpblendd {{.*#+}} ymm0 = ymm0[0,1,2,3],ymm2[4,5,6,7]
; AVX2-NEXT:    vmovdqa 112(%rdi), %xmm2
; AVX2-NEXT:    vpshufb %xmm4, %xmm2, %xmm2
; AVX2-NEXT:    vmovdqa 96(%rdi), %xmm4
; AVX2-NEXT:    vpshufb %xmm5, %xmm4, %xmm4
; AVX2-NEXT:    vpor %xmm2, %xmm4, %xmm2
; AVX2-NEXT:    vpshufb %ymm3, %ymm1, %ymm1
; AVX2-NEXT:    vpblendvb %ymm6, %ymm2, %ymm1, %ymm1
; AVX2-NEXT:    vmovdqa 176(%rdi), %xmm2
; AVX2-NEXT:    vpshufb %xmm7, %xmm2, %xmm2
; AVX2-NEXT:    vmovdqa 160(%rdi), %xmm3
; AVX2-NEXT:    vpshufb %xmm9, %xmm3, %xmm3
; AVX2-NEXT:    vpor %xmm2, %xmm3, %xmm2
; AVX2-NEXT:    vinserti128 $1, %xmm2, %ymm0, %ymm2
; AVX2-NEXT:    vpblendw {{.*#+}} ymm2 = ymm1[0,1,2],ymm2[3,4,5,6,7],ymm1[8,9,10],ymm2[11,12,13,14,15]
; AVX2-NEXT:    vpblendd {{.*#+}} ymm1 = ymm1[0,1,2,3],ymm2[4,5,6,7]
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: f1:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vmovdqa 112(%rdi), %xmm0
; AVX512F-NEXT:    vmovdqa {{.*#+}} xmm1 = <128,128,128,128,128,128,3,5,9,11,15,u,u,u,u,u>
; AVX512F-NEXT:    vpshufb %xmm1, %xmm0, %xmm0
; AVX512F-NEXT:    vmovdqa 96(%rdi), %xmm2
; AVX512F-NEXT:    vmovdqa {{.*#+}} xmm3 = <1,3,7,9,13,15,128,128,128,128,128,u,u,u,u,u>
; AVX512F-NEXT:    vpshufb %xmm3, %xmm2, %xmm2
; AVX512F-NEXT:    vpor %xmm0, %xmm2, %xmm0
; AVX512F-NEXT:    vmovdqa 176(%rdi), %xmm2
; AVX512F-NEXT:    vmovdqa {{.*#+}} xmm4 = <u,u,u,u,u,u,128,128,128,128,128,1,5,7,11,13>
; AVX512F-NEXT:    vpshufb %xmm4, %xmm2, %xmm2
; AVX512F-NEXT:    vmovdqa 160(%rdi), %xmm5
; AVX512F-NEXT:    vmovdqa {{.*#+}} xmm6 = <u,u,u,u,u,u,3,5,9,11,15,128,128,128,128,128>
; AVX512F-NEXT:    vpshufb %xmm6, %xmm5, %xmm5
; AVX512F-NEXT:    vpor %xmm2, %xmm5, %xmm2
; AVX512F-NEXT:    vinserti128 $1, %xmm2, %ymm0, %ymm2
; AVX512F-NEXT:    vmovdqa 128(%rdi), %ymm5
; AVX512F-NEXT:    vpshufb {{.*#+}} ymm5 = ymm5[u,u,u,u,u,u,u,u,u,u,u,1,5,7,11,13,17,19,23,25,29,31,u,u,u,u,u,u,u,u,u,u]
; AVX512F-NEXT:    vpblendw {{.*#+}} ymm2 = ymm5[0,1,2],ymm2[3,4,5,6,7],ymm5[8,9,10],ymm2[11,12,13,14,15]
; AVX512F-NEXT:    vpblendd {{.*#+}} ymm2 = ymm5[0,1,2,3],ymm2[4,5,6,7]
; AVX512F-NEXT:    vpternlogq $228, {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %ymm0, %ymm2
; AVX512F-NEXT:    vmovdqa 80(%rdi), %xmm0
; AVX512F-NEXT:    vpshufb %xmm4, %xmm0, %xmm0
; AVX512F-NEXT:    vmovdqa 64(%rdi), %xmm4
; AVX512F-NEXT:    vpshufb %xmm6, %xmm4, %xmm4
; AVX512F-NEXT:    vpor %xmm0, %xmm4, %xmm0
; AVX512F-NEXT:    vinserti128 $1, %xmm0, %ymm0, %ymm0
; AVX512F-NEXT:    vmovdqa (%rdi), %xmm4
; AVX512F-NEXT:    vmovdqa 16(%rdi), %xmm5
; AVX512F-NEXT:    vpshufb %xmm1, %xmm5, %xmm1
; AVX512F-NEXT:    vpshufb %xmm3, %xmm4, %xmm3
; AVX512F-NEXT:    vpor %xmm1, %xmm3, %xmm1
; AVX512F-NEXT:    vmovdqa 32(%rdi), %ymm3
; AVX512F-NEXT:    vpshufb {{.*#+}} ymm3 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,ymm3[1,5,7,11,13,17,19,23,25,29,31],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
; AVX512F-NEXT:    vpternlogq $248, {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %ymm1, %ymm3
; AVX512F-NEXT:    vpblendw {{.*#+}} ymm0 = ymm3[0,1,2],ymm0[3,4,5,6,7],ymm3[8,9,10],ymm0[11,12,13,14,15]
; AVX512F-NEXT:    vpblendd {{.*#+}} ymm0 = ymm3[0,1,2,3],ymm0[4,5,6,7]
; AVX512F-NEXT:    vinserti64x4 $1, %ymm2, %zmm0, %zmm0
; AVX512F-NEXT:    retq
;
; AVX512BW-LABEL: f1:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vmovdqa 112(%rdi), %xmm0
; AVX512BW-NEXT:    vmovdqa {{.*#+}} xmm1 = <128,128,128,128,128,128,3,5,9,11,15,u,u,u,u,u>
; AVX512BW-NEXT:    vpshufb %xmm1, %xmm0, %xmm0
; AVX512BW-NEXT:    vmovdqa 96(%rdi), %xmm2
; AVX512BW-NEXT:    vmovdqa {{.*#+}} xmm3 = <1,3,7,9,13,15,128,128,128,128,128,u,u,u,u,u>
; AVX512BW-NEXT:    vpshufb %xmm3, %xmm2, %xmm2
; AVX512BW-NEXT:    vpor %xmm0, %xmm2, %xmm0
; AVX512BW-NEXT:    vmovdqa 176(%rdi), %xmm2
; AVX512BW-NEXT:    vmovdqa {{.*#+}} xmm4 = <u,u,u,u,u,u,128,128,128,128,128,1,5,7,11,13>
; AVX512BW-NEXT:    vpshufb %xmm4, %xmm2, %xmm2
; AVX512BW-NEXT:    vmovdqa 160(%rdi), %xmm5
; AVX512BW-NEXT:    vmovdqa {{.*#+}} xmm6 = <u,u,u,u,u,u,3,5,9,11,15,128,128,128,128,128>
; AVX512BW-NEXT:    vpshufb %xmm6, %xmm5, %xmm5
; AVX512BW-NEXT:    vpor %xmm2, %xmm5, %xmm2
; AVX512BW-NEXT:    vinserti128 $1, %xmm2, %ymm0, %ymm2
; AVX512BW-NEXT:    vmovdqa 128(%rdi), %ymm5
; AVX512BW-NEXT:    vmovdqa {{.*#+}} ymm7 = <u,u,u,u,u,u,u,u,u,u,u,1,5,7,11,13,1,3,7,9,13,15,u,u,u,u,u,u,u,u,u,u>
; AVX512BW-NEXT:    vpshufb %ymm7, %ymm5, %ymm5
; AVX512BW-NEXT:    vpblendw {{.*#+}} ymm2 = ymm5[0,1,2],ymm2[3,4,5,6,7],ymm5[8,9,10],ymm2[11,12,13,14,15]
; AVX512BW-NEXT:    vpblendd {{.*#+}} ymm2 = ymm5[0,1,2,3],ymm2[4,5,6,7]
; AVX512BW-NEXT:    movl $2047, %eax # imm = 0x7FF
; AVX512BW-NEXT:    kmovd %eax, %k1
; AVX512BW-NEXT:    vmovdqu8 %ymm0, %ymm2 {%k1}
; AVX512BW-NEXT:    vmovdqa (%rdi), %xmm0
; AVX512BW-NEXT:    vmovdqa 16(%rdi), %xmm5
; AVX512BW-NEXT:    vpshufb %xmm1, %xmm5, %xmm1
; AVX512BW-NEXT:    vpshufb %xmm3, %xmm0, %xmm0
; AVX512BW-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX512BW-NEXT:    vmovdqa 32(%rdi), %ymm1
; AVX512BW-NEXT:    movl $4192256, %eax # imm = 0x3FF800
; AVX512BW-NEXT:    kmovd %eax, %k1
; AVX512BW-NEXT:    vpshufb %ymm7, %ymm1, %ymm0 {%k1}
; AVX512BW-NEXT:    vmovdqa 80(%rdi), %xmm1
; AVX512BW-NEXT:    vpshufb %xmm4, %xmm1, %xmm1
; AVX512BW-NEXT:    vmovdqa 64(%rdi), %xmm3
; AVX512BW-NEXT:    vpshufb %xmm6, %xmm3, %xmm3
; AVX512BW-NEXT:    vpor %xmm1, %xmm3, %xmm1
; AVX512BW-NEXT:    vinserti128 $1, %xmm1, %ymm0, %ymm1
; AVX512BW-NEXT:    vpblendw {{.*#+}} ymm1 = ymm0[0,1,2],ymm1[3,4,5,6,7],ymm0[8,9,10],ymm1[11,12,13,14,15]
; AVX512BW-NEXT:    vpblendd {{.*#+}} ymm0 = ymm0[0,1,2,3],ymm1[4,5,6,7]
; AVX512BW-NEXT:    vinserti64x4 $1, %ymm2, %zmm0, %zmm0
; AVX512BW-NEXT:    retq
;
; AVX512VBMI-LABEL: f1:
; AVX512VBMI:       # %bb.0:
; AVX512VBMI-NEXT:    vmovdqa64 (%rdi), %zmm0
; AVX512VBMI-NEXT:    vmovdqa64 {{.*#+}} zmm1 = <1,3,7,9,13,15,19,21,25,27,31,33,37,39,43,45,49,51,55,57,61,63,67,69,73,75,79,81,85,87,91,93,97,99,103,105,109,111,115,117,121,123,127,u,u,u,u,u,u,u,u,u,u,u,u,u,u,u,u,u,u,u,u,u>
; AVX512VBMI-NEXT:    vpermi2b 64(%rdi), %zmm0, %zmm1
; AVX512VBMI-NEXT:    vmovdqa64 {{.*#+}} zmm0 = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,65,69,71,75,77,81,83,87,89,93,95,99,101,105,107,111,113,117,119,123,125]
; AVX512VBMI-NEXT:    vpermi2b 128(%rdi), %zmm1, %zmm0
; AVX512VBMI-NEXT:    retq
  %a0 = load <192 x i8>, ptr %p0
  %r = shufflevector <192 x i8> %a0, <192 x i8> poison, <64 x i32> <i32 1, i32 3, i32 7, i32 9, i32 13, i32 15, i32 19, i32 21, i32 25, i32 27, i32 31, i32 33, i32 37, i32 39, i32 43, i32 45, i32 49, i32 51, i32 55, i32 57, i32 61, i32 63, i32 67, i32 69, i32 73, i32 75, i32 79, i32 81, i32 85, i32 87, i32 91, i32 93, i32 97, i32 99, i32 103, i32 105, i32 109, i32 111, i32 115, i32 117, i32 121, i32 123, i32 127, i32 129, i32 133, i32 135, i32 139, i32 141, i32 145, i32 147, i32 151, i32 153, i32 157, i32 159, i32 163, i32 165, i32 169, i32 171, i32 175, i32 177, i32 181, i32 183, i32 187, i32 189>
  ret <64 x i8> %r
}

define <64 x i8> @f2(ptr %p0) {
; AVX2-LABEL: f2:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovdqa 128(%rdi), %ymm1
; AVX2-NEXT:    vmovdqa 32(%rdi), %ymm0
; AVX2-NEXT:    vmovdqa (%rdi), %xmm2
; AVX2-NEXT:    vmovdqa 16(%rdi), %xmm3
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm4 = <1,5,7,11,13,128,128,128,128,128,128,u,u,u,u,u>
; AVX2-NEXT:    vpshufb %xmm4, %xmm2, %xmm2
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm5 = <128,128,128,128,128,1,3,7,9,13,15,u,u,u,u,u>
; AVX2-NEXT:    vpshufb %xmm5, %xmm3, %xmm3
; AVX2-NEXT:    vpor %xmm2, %xmm3, %xmm2
; AVX2-NEXT:    vmovdqa {{.*#+}} ymm3 = <u,u,u,u,u,u,u,u,u,u,u,3,5,9,11,15,1,5,7,11,13,u,u,u,u,u,u,u,u,u,u,u>
; AVX2-NEXT:    vpshufb %ymm3, %ymm0, %ymm0
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm6 = [255,255,255,255,255,255,255,255,255,255,255,0,0,0,0,0]
; AVX2-NEXT:    vpblendvb %ymm6, %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    vmovdqa 80(%rdi), %xmm2
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm7 = <u,u,u,u,u,128,128,128,128,128,128,3,5,9,11,15>
; AVX2-NEXT:    vpshufb %xmm7, %xmm2, %xmm2
; AVX2-NEXT:    vmovdqa 64(%rdi), %xmm8
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm9 = <u,u,u,u,u,1,3,7,9,13,15,128,128,128,128,128>
; AVX2-NEXT:    vpshufb %xmm9, %xmm8, %xmm8
; AVX2-NEXT:    vpor %xmm2, %xmm8, %xmm2
; AVX2-NEXT:    vinserti128 $1, %xmm2, %ymm0, %ymm2
; AVX2-NEXT:    vmovdqa {{.*#+}} ymm8 = [255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0,0,0,0,0,0,0,0,0]
; AVX2-NEXT:    vpblendvb %ymm8, %ymm0, %ymm2, %ymm0
; AVX2-NEXT:    vmovdqa 96(%rdi), %xmm2
; AVX2-NEXT:    vpshufb %xmm4, %xmm2, %xmm2
; AVX2-NEXT:    vmovdqa 112(%rdi), %xmm4
; AVX2-NEXT:    vpshufb %xmm5, %xmm4, %xmm4
; AVX2-NEXT:    vpor %xmm2, %xmm4, %xmm2
; AVX2-NEXT:    vpshufb %ymm3, %ymm1, %ymm1
; AVX2-NEXT:    vpblendvb %ymm6, %ymm2, %ymm1, %ymm1
; AVX2-NEXT:    vmovdqa 176(%rdi), %xmm2
; AVX2-NEXT:    vpshufb %xmm7, %xmm2, %xmm2
; AVX2-NEXT:    vmovdqa 160(%rdi), %xmm3
; AVX2-NEXT:    vpshufb %xmm9, %xmm3, %xmm3
; AVX2-NEXT:    vpor %xmm2, %xmm3, %xmm2
; AVX2-NEXT:    vinserti128 $1, %xmm2, %ymm0, %ymm2
; AVX2-NEXT:    vpblendvb %ymm8, %ymm1, %ymm2, %ymm1
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: f2:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vmovdqa 176(%rdi), %xmm0
; AVX512F-NEXT:    vmovdqa {{.*#+}} xmm1 = <u,u,u,u,u,128,128,128,128,128,128,3,5,9,11,15>
; AVX512F-NEXT:    vpshufb %xmm1, %xmm0, %xmm0
; AVX512F-NEXT:    vmovdqa 160(%rdi), %xmm2
; AVX512F-NEXT:    vmovdqa {{.*#+}} xmm3 = <u,u,u,u,u,1,3,7,9,13,15,128,128,128,128,128>
; AVX512F-NEXT:    vpshufb %xmm3, %xmm2, %xmm2
; AVX512F-NEXT:    vpor %xmm0, %xmm2, %xmm0
; AVX512F-NEXT:    vinserti128 $1, %xmm0, %ymm0, %ymm0
; AVX512F-NEXT:    vmovdqa (%rdi), %xmm2
; AVX512F-NEXT:    vmovdqa 16(%rdi), %xmm4
; AVX512F-NEXT:    vmovdqa {{.*#+}} xmm5 = <1,5,7,11,13,128,128,128,128,128,128,u,u,u,u,u>
; AVX512F-NEXT:    vpshufb %xmm5, %xmm2, %xmm2
; AVX512F-NEXT:    vmovdqa {{.*#+}} xmm6 = <128,128,128,128,128,1,3,7,9,13,15,u,u,u,u,u>
; AVX512F-NEXT:    vpshufb %xmm6, %xmm4, %xmm4
; AVX512F-NEXT:    vpor %xmm2, %xmm4, %xmm2
; AVX512F-NEXT:    vinserti64x4 $1, %ymm0, %zmm2, %zmm0
; AVX512F-NEXT:    vmovdqa 32(%rdi), %ymm2
; AVX512F-NEXT:    vpshufb {{.*#+}} ymm2 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,ymm2[3,5,9,11,15,17,21,23,27,29,u,u,u,u,u,u,u,u,u,u,u]
; AVX512F-NEXT:    vmovdqa 128(%rdi), %ymm4
; AVX512F-NEXT:    vpshufb {{.*#+}} ymm4 = ymm4[u,u,u,u,u,u,u,u,u,u,u,3,5,9,11,15,17,21,23,27,29],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
; AVX512F-NEXT:    vinserti64x4 $1, %ymm4, %zmm2, %zmm2
; AVX512F-NEXT:    vbroadcasti64x4 {{.*#+}} zmm4 = [255,255,255,255,255,255,255,255,255,255,255,0,0,0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255,255,255,255]
; AVX512F-NEXT:    # zmm4 = mem[0,1,2,3,0,1,2,3]
; AVX512F-NEXT:    vpternlogq $234, %zmm2, %zmm0, %zmm4
; AVX512F-NEXT:    vmovdqa 96(%rdi), %xmm0
; AVX512F-NEXT:    vpshufb %xmm5, %xmm0, %xmm0
; AVX512F-NEXT:    vmovdqa 112(%rdi), %xmm2
; AVX512F-NEXT:    vpshufb %xmm6, %xmm2, %xmm2
; AVX512F-NEXT:    vpor %xmm0, %xmm2, %xmm0
; AVX512F-NEXT:    vinserti32x4 $2, %xmm0, %zmm0, %zmm0
; AVX512F-NEXT:    vmovdqa 80(%rdi), %xmm2
; AVX512F-NEXT:    vpshufb %xmm1, %xmm2, %xmm1
; AVX512F-NEXT:    vmovdqa 64(%rdi), %xmm2
; AVX512F-NEXT:    vpshufb %xmm3, %xmm2, %xmm2
; AVX512F-NEXT:    vpor %xmm1, %xmm2, %xmm1
; AVX512F-NEXT:    vinserti128 $1, %xmm1, %ymm0, %ymm1
; AVX512F-NEXT:    vshufi64x2 {{.*#+}} zmm0 = zmm1[0,1,2,3],zmm0[4,5,6,7]
; AVX512F-NEXT:    vpternlogq $216, {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %zmm4, %zmm0
; AVX512F-NEXT:    retq
;
; AVX512BW-LABEL: f2:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vmovdqa 176(%rdi), %xmm0
; AVX512BW-NEXT:    vmovdqa {{.*#+}} xmm1 = <u,u,u,u,u,128,128,128,128,128,128,3,5,9,11,15>
; AVX512BW-NEXT:    vpshufb %xmm1, %xmm0, %xmm0
; AVX512BW-NEXT:    vmovdqa 160(%rdi), %xmm2
; AVX512BW-NEXT:    vmovdqa {{.*#+}} xmm3 = <u,u,u,u,u,1,3,7,9,13,15,128,128,128,128,128>
; AVX512BW-NEXT:    vpshufb %xmm3, %xmm2, %xmm2
; AVX512BW-NEXT:    vpor %xmm0, %xmm2, %xmm0
; AVX512BW-NEXT:    vinserti128 $1, %xmm0, %ymm0, %ymm0
; AVX512BW-NEXT:    vmovdqa 128(%rdi), %ymm2
; AVX512BW-NEXT:    vmovdqa {{.*#+}} ymm4 = <u,u,u,u,u,u,u,u,u,u,u,3,5,9,11,15,1,5,7,11,13,u,u,u,u,u,u,u,u,u,u,u>
; AVX512BW-NEXT:    movl $2095104, %eax # imm = 0x1FF800
; AVX512BW-NEXT:    kmovd %eax, %k1
; AVX512BW-NEXT:    vpshufb %ymm4, %ymm2, %ymm0 {%k1}
; AVX512BW-NEXT:    vmovdqa 96(%rdi), %xmm2
; AVX512BW-NEXT:    vmovdqa {{.*#+}} xmm5 = <1,5,7,11,13,128,128,128,128,128,128,u,u,u,u,u>
; AVX512BW-NEXT:    vpshufb %xmm5, %xmm2, %xmm2
; AVX512BW-NEXT:    vmovdqa 112(%rdi), %xmm6
; AVX512BW-NEXT:    vmovdqa {{.*#+}} xmm7 = <128,128,128,128,128,1,3,7,9,13,15,u,u,u,u,u>
; AVX512BW-NEXT:    vpshufb %xmm7, %xmm6, %xmm6
; AVX512BW-NEXT:    vpor %xmm2, %xmm6, %xmm2
; AVX512BW-NEXT:    movl $2047, %eax # imm = 0x7FF
; AVX512BW-NEXT:    kmovd %eax, %k2
; AVX512BW-NEXT:    vmovdqu8 %ymm2, %ymm0 {%k2}
; AVX512BW-NEXT:    vmovdqa (%rdi), %xmm2
; AVX512BW-NEXT:    vmovdqa 16(%rdi), %xmm6
; AVX512BW-NEXT:    vpshufb %xmm5, %xmm2, %xmm2
; AVX512BW-NEXT:    vpshufb %xmm7, %xmm6, %xmm5
; AVX512BW-NEXT:    vpor %xmm2, %xmm5, %xmm2
; AVX512BW-NEXT:    vmovdqa 32(%rdi), %ymm5
; AVX512BW-NEXT:    vpshufb %ymm4, %ymm5, %ymm2 {%k1}
; AVX512BW-NEXT:    vmovdqa 80(%rdi), %xmm4
; AVX512BW-NEXT:    vpshufb %xmm1, %xmm4, %xmm1
; AVX512BW-NEXT:    vmovdqa 64(%rdi), %xmm4
; AVX512BW-NEXT:    vpshufb %xmm3, %xmm4, %xmm3
; AVX512BW-NEXT:    vpor %xmm1, %xmm3, %xmm1
; AVX512BW-NEXT:    vinserti128 $1, %xmm1, %ymm0, %ymm1
; AVX512BW-NEXT:    movl $-2097152, %eax # imm = 0xFFE00000
; AVX512BW-NEXT:    kmovd %eax, %k1
; AVX512BW-NEXT:    vmovdqu8 %ymm1, %ymm2 {%k1}
; AVX512BW-NEXT:    vinserti64x4 $1, %ymm0, %zmm2, %zmm0
; AVX512BW-NEXT:    retq
;
; AVX512VBMI-LABEL: f2:
; AVX512VBMI:       # %bb.0:
; AVX512VBMI-NEXT:    vmovdqa64 64(%rdi), %zmm0
; AVX512VBMI-NEXT:    vmovdqa64 {{.*#+}} zmm1 = <65,69,71,75,77,81,83,87,89,93,95,99,101,105,107,111,113,117,119,123,125,1,3,7,9,13,15,19,21,25,27,31,33,37,39,43,45,49,51,55,57,61,63,u,u,u,u,u,u,u,u,u,u,u,u,u,u,u,u,u,u,u,u,u>
; AVX512VBMI-NEXT:    vpermi2b (%rdi), %zmm0, %zmm1
; AVX512VBMI-NEXT:    vmovdqa64 {{.*#+}} zmm0 = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,67,69,73,75,79,81,85,87,91,93,97,99,103,105,109,111,115,117,121,123,127]
; AVX512VBMI-NEXT:    vpermi2b 128(%rdi), %zmm1, %zmm0
; AVX512VBMI-NEXT:    retq
  %a0 = load <192 x i8>, ptr %p0
  %r = shufflevector <192 x i8> %a0, <192 x i8> poison, <64 x i32> <i32 1, i32 5, i32 7, i32 11, i32 13, i32 17, i32 19, i32 23, i32 25, i32 29, i32 31, i32 35, i32 37, i32 41, i32 43, i32 47, i32 49, i32 53, i32 55, i32 59, i32 61, i32 65, i32 67, i32 71, i32 73, i32 77, i32 79, i32 83, i32 85, i32 89, i32 91, i32 95, i32 97, i32 101, i32 103, i32 107, i32 109, i32 113, i32 115, i32 119, i32 121, i32 125, i32 127, i32 131, i32 133, i32 137, i32 139, i32 143, i32 145, i32 149, i32 151, i32 155, i32 157, i32 161, i32 163, i32 167, i32 169, i32 173, i32 175, i32 179, i32 181, i32 185, i32 187, i32 191>
  ret <64 x i8> %r
}

define <64 x i8> @f3(ptr %p0) {
; AVX2-LABEL: f3:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovdqa 128(%rdi), %ymm1
; AVX2-NEXT:    vmovdqa 32(%rdi), %ymm0
; AVX2-NEXT:    vmovdqa 64(%rdi), %xmm2
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm3 = <u,u,u,u,u,0,4,6,10,12,128,128,128,128,128,128>
; AVX2-NEXT:    vpshufb %xmm3, %xmm2, %xmm2
; AVX2-NEXT:    vmovdqa 80(%rdi), %xmm4
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm5 = <u,u,u,u,u,128,128,128,128,128,0,2,6,8,12,14>
; AVX2-NEXT:    vpshufb %xmm5, %xmm4, %xmm4
; AVX2-NEXT:    vpor %xmm2, %xmm4, %xmm2
; AVX2-NEXT:    vinserti128 $1, %xmm2, %ymm0, %ymm2
; AVX2-NEXT:    vmovdqa (%rdi), %xmm4
; AVX2-NEXT:    vmovdqa 16(%rdi), %xmm6
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm7 = <128,128,128,128,128,0,4,6,10,12,u,u,u,u,u,u>
; AVX2-NEXT:    vpshufb %xmm7, %xmm6, %xmm6
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm8 = <2,4,8,10,14,128,128,128,128,128,u,u,u,u,u,u>
; AVX2-NEXT:    vpshufb %xmm8, %xmm4, %xmm4
; AVX2-NEXT:    vpor %xmm6, %xmm4, %xmm4
; AVX2-NEXT:    vmovdqa {{.*#+}} ymm6 = <u,u,u,u,u,u,u,u,u,u,0,2,6,8,12,14,2,4,8,10,14,u,u,u,u,u,u,u,u,u,u,u>
; AVX2-NEXT:    vpshufb %ymm6, %ymm0, %ymm0
; AVX2-NEXT:    vpblendw {{.*#+}} xmm4 = xmm4[0,1,2,3,4],xmm0[5,6,7]
; AVX2-NEXT:    vpblendd {{.*#+}} ymm0 = ymm4[0,1,2,3],ymm0[4,5,6,7]
; AVX2-NEXT:    vmovdqa {{.*#+}} ymm4 = [255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0,0,0,0,0,0,0,0,0]
; AVX2-NEXT:    vpblendvb %ymm4, %ymm0, %ymm2, %ymm0
; AVX2-NEXT:    vmovdqa 160(%rdi), %xmm2
; AVX2-NEXT:    vpshufb %xmm3, %xmm2, %xmm2
; AVX2-NEXT:    vmovdqa 176(%rdi), %xmm3
; AVX2-NEXT:    vpshufb %xmm5, %xmm3, %xmm3
; AVX2-NEXT:    vpor %xmm2, %xmm3, %xmm2
; AVX2-NEXT:    vinserti128 $1, %xmm2, %ymm0, %ymm2
; AVX2-NEXT:    vmovdqa 112(%rdi), %xmm3
; AVX2-NEXT:    vpshufb %xmm7, %xmm3, %xmm3
; AVX2-NEXT:    vmovdqa 96(%rdi), %xmm5
; AVX2-NEXT:    vpshufb %xmm8, %xmm5, %xmm5
; AVX2-NEXT:    vpor %xmm3, %xmm5, %xmm3
; AVX2-NEXT:    vpshufb %ymm6, %ymm1, %ymm1
; AVX2-NEXT:    vpblendw {{.*#+}} xmm3 = xmm3[0,1,2,3,4],xmm1[5,6,7]
; AVX2-NEXT:    vpblendd {{.*#+}} ymm1 = ymm3[0,1,2,3],ymm1[4,5,6,7]
; AVX2-NEXT:    vpblendvb %ymm4, %ymm1, %ymm2, %ymm1
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: f3:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vmovdqa 64(%rdi), %xmm1
; AVX512F-NEXT:    vmovdqa {{.*#+}} xmm0 = <u,u,u,u,u,0,4,6,10,12,128,128,128,128,128,128>
; AVX512F-NEXT:    vpshufb %xmm0, %xmm1, %xmm2
; AVX512F-NEXT:    vmovdqa 80(%rdi), %xmm3
; AVX512F-NEXT:    vmovdqa {{.*#+}} xmm1 = <u,u,u,u,u,128,128,128,128,128,0,2,6,8,12,14>
; AVX512F-NEXT:    vpshufb %xmm1, %xmm3, %xmm3
; AVX512F-NEXT:    vpor %xmm2, %xmm3, %xmm2
; AVX512F-NEXT:    vinserti128 $1, %xmm2, %ymm0, %ymm2
; AVX512F-NEXT:    vmovdqa (%rdi), %xmm3
; AVX512F-NEXT:    vmovdqa 16(%rdi), %xmm4
; AVX512F-NEXT:    vmovdqa {{.*#+}} xmm5 = <128,128,128,128,128,0,4,6,10,12,u,u,u,u,u,u>
; AVX512F-NEXT:    vpshufb %xmm5, %xmm4, %xmm4
; AVX512F-NEXT:    vmovdqa {{.*#+}} xmm6 = <2,4,8,10,14,128,128,128,128,128,u,u,u,u,u,u>
; AVX512F-NEXT:    vpshufb %xmm6, %xmm3, %xmm3
; AVX512F-NEXT:    vpor %xmm4, %xmm3, %xmm3
; AVX512F-NEXT:    vmovdqa 32(%rdi), %ymm4
; AVX512F-NEXT:    vmovdqa {{.*#+}} ymm7 = <u,u,u,u,u,u,u,u,u,u,0,2,6,8,12,14,2,4,8,10,14,u,u,u,u,u,u,u,u,u,u,u>
; AVX512F-NEXT:    vpshufb %ymm7, %ymm4, %ymm4
; AVX512F-NEXT:    vpblendw {{.*#+}} xmm3 = xmm3[0,1,2,3,4],xmm4[5,6,7]
; AVX512F-NEXT:    vpblendd {{.*#+}} ymm3 = ymm3[0,1,2,3],ymm4[4,5,6,7]
; AVX512F-NEXT:    vmovdqa {{.*#+}} ymm4 = [255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0,0,0,0,0,0,0,0,0]
; AVX512F-NEXT:    vpternlogq $226, %ymm2, %ymm4, %ymm3
; AVX512F-NEXT:    vmovdqa 112(%rdi), %xmm2
; AVX512F-NEXT:    vpshufb %xmm5, %xmm2, %xmm2
; AVX512F-NEXT:    vmovdqa 96(%rdi), %xmm5
; AVX512F-NEXT:    vpshufb %xmm6, %xmm5, %xmm5
; AVX512F-NEXT:    vpor %xmm2, %xmm5, %xmm2
; AVX512F-NEXT:    vinserti64x4 $1, %ymm2, %zmm3, %zmm2
; AVX512F-NEXT:    vextracti32x4 $2, %zmm2, %xmm2
; AVX512F-NEXT:    vmovdqa 128(%rdi), %ymm5
; AVX512F-NEXT:    vpshufb %ymm7, %ymm5, %ymm5
; AVX512F-NEXT:    vpblendw {{.*#+}} xmm2 = xmm2[0,1,2,3,4],xmm5[5,6,7]
; AVX512F-NEXT:    vmovdqa 160(%rdi), %xmm6
; AVX512F-NEXT:    vpshufb %xmm0, %xmm6, %xmm0
; AVX512F-NEXT:    vmovdqa 176(%rdi), %xmm6
; AVX512F-NEXT:    vpshufb %xmm1, %xmm6, %xmm1
; AVX512F-NEXT:    vpor %xmm0, %xmm1, %xmm0
; AVX512F-NEXT:    vinserti128 $1, %xmm0, %ymm0, %ymm0
; AVX512F-NEXT:    vpternlogq $216, %ymm4, %ymm5, %ymm0
; AVX512F-NEXT:    vpblendd {{.*#+}} ymm0 = ymm2[0,1,2,3],ymm0[4,5,6,7]
; AVX512F-NEXT:    vinserti64x4 $1, %ymm0, %zmm3, %zmm0
; AVX512F-NEXT:    retq
;
; AVX512BW-LABEL: f3:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vmovdqa 64(%rdi), %xmm0
; AVX512BW-NEXT:    vmovdqa {{.*#+}} xmm1 = <u,u,u,u,u,0,4,6,10,12,128,128,128,128,128,128>
; AVX512BW-NEXT:    vpshufb %xmm1, %xmm0, %xmm0
; AVX512BW-NEXT:    vmovdqa 80(%rdi), %xmm2
; AVX512BW-NEXT:    vmovdqa {{.*#+}} xmm3 = <u,u,u,u,u,128,128,128,128,128,0,2,6,8,12,14>
; AVX512BW-NEXT:    vpshufb %xmm3, %xmm2, %xmm2
; AVX512BW-NEXT:    vpor %xmm0, %xmm2, %xmm0
; AVX512BW-NEXT:    vinserti128 $1, %xmm0, %ymm0, %ymm0
; AVX512BW-NEXT:    vmovdqa (%rdi), %xmm2
; AVX512BW-NEXT:    vmovdqa 16(%rdi), %xmm4
; AVX512BW-NEXT:    vmovdqa {{.*#+}} xmm5 = <128,128,128,128,128,0,4,6,10,12,u,u,u,u,u,u>
; AVX512BW-NEXT:    vpshufb %xmm5, %xmm4, %xmm4
; AVX512BW-NEXT:    vmovdqa {{.*#+}} xmm6 = <2,4,8,10,14,128,128,128,128,128,u,u,u,u,u,u>
; AVX512BW-NEXT:    vpshufb %xmm6, %xmm2, %xmm2
; AVX512BW-NEXT:    vpor %xmm4, %xmm2, %xmm2
; AVX512BW-NEXT:    vmovdqa 32(%rdi), %ymm4
; AVX512BW-NEXT:    vmovdqa {{.*#+}} ymm7 = <u,u,u,u,u,u,u,u,u,u,0,2,6,8,12,14,2,4,8,10,14,u,u,u,u,u,u,u,u,u,u,u>
; AVX512BW-NEXT:    vpshufb %ymm7, %ymm4, %ymm4
; AVX512BW-NEXT:    vpblendw {{.*#+}} xmm2 = xmm2[0,1,2,3,4],xmm4[5,6,7]
; AVX512BW-NEXT:    vpblendd {{.*#+}} ymm2 = ymm2[0,1,2,3],ymm4[4,5,6,7]
; AVX512BW-NEXT:    movl $-2097152, %eax # imm = 0xFFE00000
; AVX512BW-NEXT:    kmovd %eax, %k1
; AVX512BW-NEXT:    vmovdqu8 %ymm0, %ymm2 {%k1}
; AVX512BW-NEXT:    vmovdqa 112(%rdi), %xmm0
; AVX512BW-NEXT:    vpshufb %xmm5, %xmm0, %xmm0
; AVX512BW-NEXT:    vmovdqa 96(%rdi), %xmm4
; AVX512BW-NEXT:    vpshufb %xmm6, %xmm4, %xmm4
; AVX512BW-NEXT:    vpor %xmm0, %xmm4, %xmm0
; AVX512BW-NEXT:    vinserti64x4 $1, %ymm0, %zmm2, %zmm0
; AVX512BW-NEXT:    vextracti32x4 $2, %zmm0, %xmm0
; AVX512BW-NEXT:    vmovdqa 160(%rdi), %xmm4
; AVX512BW-NEXT:    vpshufb %xmm1, %xmm4, %xmm1
; AVX512BW-NEXT:    vmovdqa 176(%rdi), %xmm4
; AVX512BW-NEXT:    vpshufb %xmm3, %xmm4, %xmm3
; AVX512BW-NEXT:    vpor %xmm1, %xmm3, %xmm1
; AVX512BW-NEXT:    vinserti128 $1, %xmm1, %ymm0, %ymm1
; AVX512BW-NEXT:    vmovdqa 128(%rdi), %ymm3
; AVX512BW-NEXT:    vpshufb %ymm7, %ymm3, %ymm3
; AVX512BW-NEXT:    vmovdqu8 %ymm1, %ymm3 {%k1}
; AVX512BW-NEXT:    vpblendw {{.*#+}} xmm0 = xmm0[0,1,2,3,4],xmm3[5,6,7]
; AVX512BW-NEXT:    vpblendd {{.*#+}} ymm0 = ymm0[0,1,2,3],ymm3[4,5,6,7]
; AVX512BW-NEXT:    vinserti64x4 $1, %ymm0, %zmm2, %zmm0
; AVX512BW-NEXT:    retq
;
; AVX512VBMI-LABEL: f3:
; AVX512VBMI:       # %bb.0:
; AVX512VBMI-NEXT:    vmovdqa64 (%rdi), %zmm0
; AVX512VBMI-NEXT:    vmovdqa64 {{.*#+}} zmm1 = <2,4,8,10,14,16,20,22,26,28,32,34,38,40,44,46,50,52,56,58,62,64,68,70,74,76,80,82,86,88,92,94,98,100,104,106,110,112,116,118,122,124,u,u,u,u,u,u,u,u,u,u,u,u,u,u,u,u,u,u,u,u,u,u>
; AVX512VBMI-NEXT:    vpermi2b 64(%rdi), %zmm0, %zmm1
; AVX512VBMI-NEXT:    vmovdqa64 {{.*#+}} zmm0 = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,64,66,70,72,76,78,82,84,88,90,94,96,100,102,106,108,112,114,118,120,124,126]
; AVX512VBMI-NEXT:    vpermi2b 128(%rdi), %zmm1, %zmm0
; AVX512VBMI-NEXT:    retq
  %a0 = load <192 x i8>, ptr %p0
  %r = shufflevector <192 x i8> %a0, <192 x i8> poison, <64 x i32> <i32 2, i32 4, i32 8, i32 10, i32 14, i32 16, i32 20, i32 22, i32 26, i32 28, i32 32, i32 34, i32 38, i32 40, i32 44, i32 46, i32 50, i32 52, i32 56, i32 58, i32 62, i32 64, i32 68, i32 70, i32 74, i32 76, i32 80, i32 82, i32 86, i32 88, i32 92, i32 94, i32 98, i32 100, i32 104, i32 106, i32 110, i32 112, i32 116, i32 118, i32 122, i32 124, i32 128, i32 130, i32 134, i32 136, i32 140, i32 142, i32 146, i32 148, i32 152, i32 154, i32 158, i32 160, i32 164, i32 166, i32 170, i32 172, i32 176, i32 178, i32 182, i32 184, i32 188, i32 190>
  ret <64 x i8> %r
}

define <64 x i8> @f4(ptr %p0) {
; AVX2-LABEL: f4:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovdqa 128(%rdi), %ymm1
; AVX2-NEXT:    vmovdqa 32(%rdi), %ymm0
; AVX2-NEXT:    vmovdqa (%rdi), %xmm2
; AVX2-NEXT:    vmovdqa 16(%rdi), %xmm3
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm4 = <0,4,6,10,12,128,128,128,128,128,128,u,u,u,u,u>
; AVX2-NEXT:    vpshufb %xmm4, %xmm2, %xmm2
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm5 = <128,128,128,128,128,0,2,6,8,12,14,u,u,u,u,u>
; AVX2-NEXT:    vpshufb %xmm5, %xmm3, %xmm3
; AVX2-NEXT:    vpor %xmm2, %xmm3, %xmm2
; AVX2-NEXT:    vmovdqa {{.*#+}} ymm3 = <u,u,u,u,u,u,u,u,u,u,u,2,4,8,10,14,0,4,6,10,12,u,u,u,u,u,u,u,u,u,u,u>
; AVX2-NEXT:    vpshufb %ymm3, %ymm0, %ymm0
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm6 = [255,255,255,255,255,255,255,255,255,255,255,0,0,0,0,0]
; AVX2-NEXT:    vpblendvb %ymm6, %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    vmovdqa 80(%rdi), %xmm2
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm7 = <u,u,u,u,u,128,128,128,128,128,128,2,4,8,10,14>
; AVX2-NEXT:    vpshufb %xmm7, %xmm2, %xmm2
; AVX2-NEXT:    vmovdqa 64(%rdi), %xmm8
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm9 = <u,u,u,u,u,0,2,6,8,12,14,128,128,128,128,128>
; AVX2-NEXT:    vpshufb %xmm9, %xmm8, %xmm8
; AVX2-NEXT:    vpor %xmm2, %xmm8, %xmm2
; AVX2-NEXT:    vinserti128 $1, %xmm2, %ymm0, %ymm2
; AVX2-NEXT:    vmovdqa {{.*#+}} ymm8 = [255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0,0,0,0,0,0,0,0,0]
; AVX2-NEXT:    vpblendvb %ymm8, %ymm0, %ymm2, %ymm0
; AVX2-NEXT:    vmovdqa 96(%rdi), %xmm2
; AVX2-NEXT:    vpshufb %xmm4, %xmm2, %xmm2
; AVX2-NEXT:    vmovdqa 112(%rdi), %xmm4
; AVX2-NEXT:    vpshufb %xmm5, %xmm4, %xmm4
; AVX2-NEXT:    vpor %xmm2, %xmm4, %xmm2
; AVX2-NEXT:    vpshufb %ymm3, %ymm1, %ymm1
; AVX2-NEXT:    vpblendvb %ymm6, %ymm2, %ymm1, %ymm1
; AVX2-NEXT:    vmovdqa 176(%rdi), %xmm2
; AVX2-NEXT:    vpshufb %xmm7, %xmm2, %xmm2
; AVX2-NEXT:    vmovdqa 160(%rdi), %xmm3
; AVX2-NEXT:    vpshufb %xmm9, %xmm3, %xmm3
; AVX2-NEXT:    vpor %xmm2, %xmm3, %xmm2
; AVX2-NEXT:    vinserti128 $1, %xmm2, %ymm0, %ymm2
; AVX2-NEXT:    vpblendvb %ymm8, %ymm1, %ymm2, %ymm1
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: f4:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vmovdqa 176(%rdi), %xmm0
; AVX512F-NEXT:    vmovdqa {{.*#+}} xmm1 = <u,u,u,u,u,128,128,128,128,128,128,2,4,8,10,14>
; AVX512F-NEXT:    vpshufb %xmm1, %xmm0, %xmm0
; AVX512F-NEXT:    vmovdqa 160(%rdi), %xmm2
; AVX512F-NEXT:    vmovdqa {{.*#+}} xmm3 = <u,u,u,u,u,0,2,6,8,12,14,128,128,128,128,128>
; AVX512F-NEXT:    vpshufb %xmm3, %xmm2, %xmm2
; AVX512F-NEXT:    vpor %xmm0, %xmm2, %xmm0
; AVX512F-NEXT:    vinserti128 $1, %xmm0, %ymm0, %ymm0
; AVX512F-NEXT:    vmovdqa (%rdi), %xmm2
; AVX512F-NEXT:    vmovdqa 16(%rdi), %xmm4
; AVX512F-NEXT:    vmovdqa {{.*#+}} xmm5 = <0,4,6,10,12,128,128,128,128,128,128,u,u,u,u,u>
; AVX512F-NEXT:    vpshufb %xmm5, %xmm2, %xmm2
; AVX512F-NEXT:    vmovdqa {{.*#+}} xmm6 = <128,128,128,128,128,0,2,6,8,12,14,u,u,u,u,u>
; AVX512F-NEXT:    vpshufb %xmm6, %xmm4, %xmm4
; AVX512F-NEXT:    vpor %xmm2, %xmm4, %xmm2
; AVX512F-NEXT:    vinserti64x4 $1, %ymm0, %zmm2, %zmm0
; AVX512F-NEXT:    vmovdqa 32(%rdi), %ymm2
; AVX512F-NEXT:    vpshufb {{.*#+}} ymm2 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,ymm2[2,4,8,10,14,16,20,22,26,28,u,u,u,u,u,u,u,u,u,u,u]
; AVX512F-NEXT:    vmovdqa 128(%rdi), %ymm4
; AVX512F-NEXT:    vpshufb {{.*#+}} ymm4 = ymm4[u,u,u,u,u,u,u,u,u,u,u,2,4,8,10,14,16,20,22,26,28],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
; AVX512F-NEXT:    vinserti64x4 $1, %ymm4, %zmm2, %zmm2
; AVX512F-NEXT:    vbroadcasti64x4 {{.*#+}} zmm4 = [255,255,255,255,255,255,255,255,255,255,255,0,0,0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255,255,255,255]
; AVX512F-NEXT:    # zmm4 = mem[0,1,2,3,0,1,2,3]
; AVX512F-NEXT:    vpternlogq $234, %zmm2, %zmm0, %zmm4
; AVX512F-NEXT:    vmovdqa 96(%rdi), %xmm0
; AVX512F-NEXT:    vpshufb %xmm5, %xmm0, %xmm0
; AVX512F-NEXT:    vmovdqa 112(%rdi), %xmm2
; AVX512F-NEXT:    vpshufb %xmm6, %xmm2, %xmm2
; AVX512F-NEXT:    vpor %xmm0, %xmm2, %xmm0
; AVX512F-NEXT:    vinserti32x4 $2, %xmm0, %zmm0, %zmm0
; AVX512F-NEXT:    vmovdqa 80(%rdi), %xmm2
; AVX512F-NEXT:    vpshufb %xmm1, %xmm2, %xmm1
; AVX512F-NEXT:    vmovdqa 64(%rdi), %xmm2
; AVX512F-NEXT:    vpshufb %xmm3, %xmm2, %xmm2
; AVX512F-NEXT:    vpor %xmm1, %xmm2, %xmm1
; AVX512F-NEXT:    vinserti128 $1, %xmm1, %ymm0, %ymm1
; AVX512F-NEXT:    vshufi64x2 {{.*#+}} zmm0 = zmm1[0,1,2,3],zmm0[4,5,6,7]
; AVX512F-NEXT:    vpternlogq $216, {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %zmm4, %zmm0
; AVX512F-NEXT:    retq
;
; AVX512BW-LABEL: f4:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vmovdqa 176(%rdi), %xmm0
; AVX512BW-NEXT:    vmovdqa {{.*#+}} xmm1 = <u,u,u,u,u,128,128,128,128,128,128,2,4,8,10,14>
; AVX512BW-NEXT:    vpshufb %xmm1, %xmm0, %xmm0
; AVX512BW-NEXT:    vmovdqa 160(%rdi), %xmm2
; AVX512BW-NEXT:    vmovdqa {{.*#+}} xmm3 = <u,u,u,u,u,0,2,6,8,12,14,128,128,128,128,128>
; AVX512BW-NEXT:    vpshufb %xmm3, %xmm2, %xmm2
; AVX512BW-NEXT:    vpor %xmm0, %xmm2, %xmm0
; AVX512BW-NEXT:    vinserti128 $1, %xmm0, %ymm0, %ymm0
; AVX512BW-NEXT:    vmovdqa 128(%rdi), %ymm2
; AVX512BW-NEXT:    vmovdqa {{.*#+}} ymm4 = <u,u,u,u,u,u,u,u,u,u,u,2,4,8,10,14,0,4,6,10,12,u,u,u,u,u,u,u,u,u,u,u>
; AVX512BW-NEXT:    movl $2095104, %eax # imm = 0x1FF800
; AVX512BW-NEXT:    kmovd %eax, %k1
; AVX512BW-NEXT:    vpshufb %ymm4, %ymm2, %ymm0 {%k1}
; AVX512BW-NEXT:    vmovdqa 96(%rdi), %xmm2
; AVX512BW-NEXT:    vmovdqa {{.*#+}} xmm5 = <0,4,6,10,12,128,128,128,128,128,128,u,u,u,u,u>
; AVX512BW-NEXT:    vpshufb %xmm5, %xmm2, %xmm2
; AVX512BW-NEXT:    vmovdqa 112(%rdi), %xmm6
; AVX512BW-NEXT:    vmovdqa {{.*#+}} xmm7 = <128,128,128,128,128,0,2,6,8,12,14,u,u,u,u,u>
; AVX512BW-NEXT:    vpshufb %xmm7, %xmm6, %xmm6
; AVX512BW-NEXT:    vpor %xmm2, %xmm6, %xmm2
; AVX512BW-NEXT:    movl $2047, %eax # imm = 0x7FF
; AVX512BW-NEXT:    kmovd %eax, %k2
; AVX512BW-NEXT:    vmovdqu8 %ymm2, %ymm0 {%k2}
; AVX512BW-NEXT:    vmovdqa (%rdi), %xmm2
; AVX512BW-NEXT:    vmovdqa 16(%rdi), %xmm6
; AVX512BW-NEXT:    vpshufb %xmm5, %xmm2, %xmm2
; AVX512BW-NEXT:    vpshufb %xmm7, %xmm6, %xmm5
; AVX512BW-NEXT:    vpor %xmm2, %xmm5, %xmm2
; AVX512BW-NEXT:    vmovdqa 32(%rdi), %ymm5
; AVX512BW-NEXT:    vpshufb %ymm4, %ymm5, %ymm2 {%k1}
; AVX512BW-NEXT:    vmovdqa 80(%rdi), %xmm4
; AVX512BW-NEXT:    vpshufb %xmm1, %xmm4, %xmm1
; AVX512BW-NEXT:    vmovdqa 64(%rdi), %xmm4
; AVX512BW-NEXT:    vpshufb %xmm3, %xmm4, %xmm3
; AVX512BW-NEXT:    vpor %xmm1, %xmm3, %xmm1
; AVX512BW-NEXT:    vinserti128 $1, %xmm1, %ymm0, %ymm1
; AVX512BW-NEXT:    movl $-2097152, %eax # imm = 0xFFE00000
; AVX512BW-NEXT:    kmovd %eax, %k1
; AVX512BW-NEXT:    vmovdqu8 %ymm1, %ymm2 {%k1}
; AVX512BW-NEXT:    vinserti64x4 $1, %ymm0, %zmm2, %zmm0
; AVX512BW-NEXT:    retq
;
; AVX512VBMI-LABEL: f4:
; AVX512VBMI:       # %bb.0:
; AVX512VBMI-NEXT:    vmovdqa64 64(%rdi), %zmm0
; AVX512VBMI-NEXT:    vmovdqa64 {{.*#+}} zmm1 = <64,68,70,74,76,80,82,86,88,92,94,98,100,104,106,110,112,116,118,122,124,0,2,6,8,12,14,18,20,24,26,30,32,36,38,42,44,48,50,54,56,60,62,u,u,u,u,u,u,u,u,u,u,u,u,u,u,u,u,u,u,u,u,u>
; AVX512VBMI-NEXT:    vpermi2b (%rdi), %zmm0, %zmm1
; AVX512VBMI-NEXT:    vmovdqa64 {{.*#+}} zmm0 = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,66,68,72,74,78,80,84,86,90,92,96,98,102,104,108,110,114,116,120,122,126]
; AVX512VBMI-NEXT:    vpermi2b 128(%rdi), %zmm1, %zmm0
; AVX512VBMI-NEXT:    retq
  %a0 = load <192 x i8>, ptr %p0
  %r = shufflevector <192 x i8> %a0, <192 x i8> poison, <64 x i32> <i32 0, i32 4, i32 6, i32 10, i32 12, i32 16, i32 18, i32 22, i32 24, i32 28, i32 30, i32 34, i32 36, i32 40, i32 42, i32 46, i32 48, i32 52, i32 54, i32 58, i32 60, i32 64, i32 66, i32 70, i32 72, i32 76, i32 78, i32 82, i32 84, i32 88, i32 90, i32 94, i32 96, i32 100, i32 102, i32 106, i32 108, i32 112, i32 114, i32 118, i32 120, i32 124, i32 126, i32 130, i32 132, i32 136, i32 138, i32 142, i32 144, i32 148, i32 150, i32 154, i32 156, i32 160, i32 162, i32 166, i32 168, i32 172, i32 174, i32 178, i32 180, i32 184, i32 186, i32 190>
  ret <64 x i8> %r
}
