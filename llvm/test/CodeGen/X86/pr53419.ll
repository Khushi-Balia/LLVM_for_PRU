; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+sse2   | FileCheck %s --check-prefixes=CHECK,SSE,SSE2
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+sse4.2 | FileCheck %s --check-prefixes=CHECK,SSE,SSE42
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+avx    | FileCheck %s --check-prefixes=CHECK,AVX
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+avx2   | FileCheck %s --check-prefixes=CHECK,AVX
; RUN: llc < %s -mtriple=i686-unknown   -mattr=+avx2   | FileCheck %s --check-prefixes=X86

declare i1 @llvm.vector.reduce.and.v4i1(<4 x i1>)
declare i1 @llvm.vector.reduce.and.v8i1(<8 x i1>)

; FIXME: All four versions are semantically equivalent and should produce same asm as scalar version.

define i1 @intrinsic_v4i8(ptr align 1 %arg, ptr align 1 %arg1) {
; SSE2-LABEL: intrinsic_v4i8:
; SSE2:       # %bb.0: # %bb
; SSE2-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE2-NEXT:    movd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; SSE2-NEXT:    pcmpeqb %xmm0, %xmm1
; SSE2-NEXT:    punpcklbw {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3],xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
; SSE2-NEXT:    punpcklwd {{.*#+}} xmm0 = xmm0[0,0,1,1,2,2,3,3]
; SSE2-NEXT:    movmskps %xmm0, %eax
; SSE2-NEXT:    cmpb $15, %al
; SSE2-NEXT:    sete %al
; SSE2-NEXT:    retq
;
; SSE42-LABEL: intrinsic_v4i8:
; SSE42:       # %bb.0: # %bb
; SSE42-NEXT:    pmovzxbd {{.*#+}} xmm0 = mem[0],zero,zero,zero,mem[1],zero,zero,zero,mem[2],zero,zero,zero,mem[3],zero,zero,zero
; SSE42-NEXT:    pmovzxbd {{.*#+}} xmm1 = mem[0],zero,zero,zero,mem[1],zero,zero,zero,mem[2],zero,zero,zero,mem[3],zero,zero,zero
; SSE42-NEXT:    psubd %xmm1, %xmm0
; SSE42-NEXT:    ptest %xmm0, %xmm0
; SSE42-NEXT:    sete %al
; SSE42-NEXT:    retq
;
; AVX-LABEL: intrinsic_v4i8:
; AVX:       # %bb.0: # %bb
; AVX-NEXT:    vpmovzxbd {{.*#+}} xmm0 = mem[0],zero,zero,zero,mem[1],zero,zero,zero,mem[2],zero,zero,zero,mem[3],zero,zero,zero
; AVX-NEXT:    vpmovzxbd {{.*#+}} xmm1 = mem[0],zero,zero,zero,mem[1],zero,zero,zero,mem[2],zero,zero,zero,mem[3],zero,zero,zero
; AVX-NEXT:    vpsubd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vptest %xmm0, %xmm0
; AVX-NEXT:    sete %al
; AVX-NEXT:    retq
;
; X86-LABEL: intrinsic_v4i8:
; X86:       # %bb.0: # %bb
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    vpmovzxbd {{.*#+}} xmm0 = mem[0],zero,zero,zero,mem[1],zero,zero,zero,mem[2],zero,zero,zero,mem[3],zero,zero,zero
; X86-NEXT:    vpmovzxbd {{.*#+}} xmm1 = mem[0],zero,zero,zero,mem[1],zero,zero,zero,mem[2],zero,zero,zero,mem[3],zero,zero,zero
; X86-NEXT:    vpsubd %xmm1, %xmm0, %xmm0
; X86-NEXT:    vptest %xmm0, %xmm0
; X86-NEXT:    sete %al
; X86-NEXT:    retl
bb:
  %lhs = load <4 x i8>, ptr %arg1, align 1
  %rhs = load <4 x i8>, ptr %arg, align 1
  %cmp = icmp eq <4 x i8> %lhs, %rhs
  %all_eq = call i1 @llvm.vector.reduce.and.v4i1(<4 x i1> %cmp)
  ret i1 %all_eq
}

define i1 @intrinsic_v8i8(ptr align 1 %arg, ptr align 1 %arg1) {
; SSE-LABEL: intrinsic_v8i8:
; SSE:       # %bb.0: # %bb
; SSE-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; SSE-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; SSE-NEXT:    pcmpeqb %xmm0, %xmm1
; SSE-NEXT:    pmovmskb %xmm1, %eax
; SSE-NEXT:    cmpb $-1, %al
; SSE-NEXT:    sete %al
; SSE-NEXT:    retq
;
; AVX-LABEL: intrinsic_v8i8:
; AVX:       # %bb.0: # %bb
; AVX-NEXT:    vmovq {{.*#+}} xmm0 = mem[0],zero
; AVX-NEXT:    vmovq {{.*#+}} xmm1 = mem[0],zero
; AVX-NEXT:    vpcmpeqb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpmovmskb %xmm0, %eax
; AVX-NEXT:    cmpb $-1, %al
; AVX-NEXT:    sete %al
; AVX-NEXT:    retq
;
; X86-LABEL: intrinsic_v8i8:
; X86:       # %bb.0: # %bb
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    vmovq {{.*#+}} xmm0 = mem[0],zero
; X86-NEXT:    vmovq {{.*#+}} xmm1 = mem[0],zero
; X86-NEXT:    vpcmpeqb %xmm1, %xmm0, %xmm0
; X86-NEXT:    vpmovmskb %xmm0, %eax
; X86-NEXT:    cmpb $-1, %al
; X86-NEXT:    sete %al
; X86-NEXT:    retl
bb:
  %lhs = load <8 x i8>, ptr %arg1, align 1
  %rhs = load <8 x i8>, ptr %arg, align 1
  %cmp = icmp eq <8 x i8> %lhs, %rhs
  %all_eq = call i1 @llvm.vector.reduce.and.v8i1(<8 x i1> %cmp)
  ret i1 %all_eq
}

define i1 @vector_version(ptr align 1 %arg, ptr align 1 %arg1) {
; SSE2-LABEL: vector_version:
; SSE2:       # %bb.0: # %bb
; SSE2-NEXT:    movd {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE2-NEXT:    movd {{.*#+}} xmm1 = mem[0],zero,zero,zero
; SSE2-NEXT:    pcmpeqb %xmm0, %xmm1
; SSE2-NEXT:    pcmpeqd %xmm0, %xmm0
; SSE2-NEXT:    pxor %xmm1, %xmm0
; SSE2-NEXT:    punpcklbw {{.*#+}} xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
; SSE2-NEXT:    punpcklwd {{.*#+}} xmm0 = xmm0[0,0,1,1,2,2,3,3]
; SSE2-NEXT:    movmskps %xmm0, %eax
; SSE2-NEXT:    testl %eax, %eax
; SSE2-NEXT:    sete %al
; SSE2-NEXT:    retq
;
; SSE42-LABEL: vector_version:
; SSE42:       # %bb.0: # %bb
; SSE42-NEXT:    pmovzxbd {{.*#+}} xmm0 = mem[0],zero,zero,zero,mem[1],zero,zero,zero,mem[2],zero,zero,zero,mem[3],zero,zero,zero
; SSE42-NEXT:    pmovzxbd {{.*#+}} xmm1 = mem[0],zero,zero,zero,mem[1],zero,zero,zero,mem[2],zero,zero,zero,mem[3],zero,zero,zero
; SSE42-NEXT:    psubd %xmm1, %xmm0
; SSE42-NEXT:    ptest %xmm0, %xmm0
; SSE42-NEXT:    sete %al
; SSE42-NEXT:    retq
;
; AVX-LABEL: vector_version:
; AVX:       # %bb.0: # %bb
; AVX-NEXT:    vpmovzxbd {{.*#+}} xmm0 = mem[0],zero,zero,zero,mem[1],zero,zero,zero,mem[2],zero,zero,zero,mem[3],zero,zero,zero
; AVX-NEXT:    vpmovzxbd {{.*#+}} xmm1 = mem[0],zero,zero,zero,mem[1],zero,zero,zero,mem[2],zero,zero,zero,mem[3],zero,zero,zero
; AVX-NEXT:    vpsubd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vptest %xmm0, %xmm0
; AVX-NEXT:    sete %al
; AVX-NEXT:    retq
;
; X86-LABEL: vector_version:
; X86:       # %bb.0: # %bb
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    vpmovzxbd {{.*#+}} xmm0 = mem[0],zero,zero,zero,mem[1],zero,zero,zero,mem[2],zero,zero,zero,mem[3],zero,zero,zero
; X86-NEXT:    vpmovzxbd {{.*#+}} xmm1 = mem[0],zero,zero,zero,mem[1],zero,zero,zero,mem[2],zero,zero,zero,mem[3],zero,zero,zero
; X86-NEXT:    vpsubd %xmm1, %xmm0, %xmm0
; X86-NEXT:    vptest %xmm0, %xmm0
; X86-NEXT:    sete %al
; X86-NEXT:    retl
bb:
  %lhs = load <4 x i8>, ptr %arg1, align 1
  %rhs = load <4 x i8>, ptr %arg, align 1
  %any_ne = icmp ne <4 x i8> %lhs, %rhs
  %any_ne_scalar = bitcast <4 x i1> %any_ne to i4
  %all_eq = icmp eq i4 %any_ne_scalar, 0
  ret i1 %all_eq
}

define i1 @mixed_version_v4i8(ptr align 1 %arg, ptr align 1 %arg1) {
; CHECK-LABEL: mixed_version_v4i8:
; CHECK:       # %bb.0: # %bb
; CHECK-NEXT:    movl (%rsi), %eax
; CHECK-NEXT:    cmpl (%rdi), %eax
; CHECK-NEXT:    sete %al
; CHECK-NEXT:    retq
;
; X86-LABEL: mixed_version_v4i8:
; X86:       # %bb.0: # %bb
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl (%ecx), %ecx
; X86-NEXT:    cmpl (%eax), %ecx
; X86-NEXT:    sete %al
; X86-NEXT:    retl
bb:
  %lhs = load <4 x i8>, ptr %arg1, align 1
  %rhs = load <4 x i8>, ptr %arg, align 1
  %lhs_s = bitcast <4 x i8> %lhs to i32
  %rhs_s = bitcast <4 x i8> %rhs to i32
  %all_eq = icmp eq i32 %lhs_s, %rhs_s
  ret i1 %all_eq
}

define i1 @mixed_version_v8i8(ptr align 1 %arg, ptr align 1 %arg1) {
; CHECK-LABEL: mixed_version_v8i8:
; CHECK:       # %bb.0: # %bb
; CHECK-NEXT:    movq (%rsi), %rax
; CHECK-NEXT:    cmpq (%rdi), %rax
; CHECK-NEXT:    sete %al
; CHECK-NEXT:    retq
;
; X86-LABEL: mixed_version_v8i8:
; X86:       # %bb.0: # %bb
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl (%ecx), %edx
; X86-NEXT:    movl 4(%ecx), %ecx
; X86-NEXT:    xorl 4(%eax), %ecx
; X86-NEXT:    xorl (%eax), %edx
; X86-NEXT:    orl %ecx, %edx
; X86-NEXT:    sete %al
; X86-NEXT:    retl
bb:
  %lhs = load <8 x i8>, ptr %arg1, align 1
  %rhs = load <8 x i8>, ptr %arg, align 1
  %lhs_s = bitcast <8 x i8> %lhs to i64
  %rhs_s = bitcast <8 x i8> %rhs to i64
  %all_eq = icmp eq i64 %lhs_s, %rhs_s
  ret i1 %all_eq
}

define i1 @scalar_version(ptr align 1 %arg, ptr align 1 %arg1) {
; CHECK-LABEL: scalar_version:
; CHECK:       # %bb.0: # %bb
; CHECK-NEXT:    movl (%rsi), %eax
; CHECK-NEXT:    cmpl (%rdi), %eax
; CHECK-NEXT:    sete %al
; CHECK-NEXT:    retq
;
; X86-LABEL: scalar_version:
; X86:       # %bb.0: # %bb
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl (%ecx), %ecx
; X86-NEXT:    cmpl (%eax), %ecx
; X86-NEXT:    sete %al
; X86-NEXT:    retl
bb:
  %lhs = load i32, ptr %arg1, align 1
  %rhs = load i32, ptr %arg, align 1
  %all_eq = icmp eq i32 %lhs, %rhs
  ret i1 %all_eq
}
