; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu \
; RUN:   -mcpu=pwr10 -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr < %s | \
; RUN:   FileCheck %s
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu \
; RUN:   -mcpu=pwr10 -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr < %s | \
; RUN:   FileCheck %s
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-ibm-aix-xcoff \
; RUN:   -mcpu=pwr10 -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr < %s | \
; RUN:   FileCheck %s

; This test case aims to test the vector multiply instructions on Power10.
; This includes the low order and high order versions of vector multiply.
; The low order version operates on doublewords, whereas the high order version
; operates on signed and unsigned words and doublewords.
; This file also includes 128 bit vector multiply instructions.

define <2 x i64> @test_vmulld(<2 x i64> %a, <2 x i64> %b) {
; CHECK-LABEL: test_vmulld:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulld v2, v3, v2
; CHECK-NEXT:    blr
entry:
  %mul = mul <2 x i64> %b, %a
  ret <2 x i64> %mul
}

define <2 x i64> @test_vmulhsd(<2 x i64> %a, <2 x i64> %b) {
; CHECK-LABEL: test_vmulhsd:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulhsd v2, v3, v2
; CHECK-NEXT:    blr
entry:
  %0 = sext <2 x i64> %a to <2 x i128>
  %1 = sext <2 x i64> %b to <2 x i128>
  %mul = mul <2 x i128> %1, %0
  %shr = lshr <2 x i128> %mul, <i128 64, i128 64>
  %tr = trunc <2 x i128> %shr to <2 x i64>
  ret <2 x i64> %tr
}

define <2 x i64> @test_vmulhud(<2 x i64> %a, <2 x i64> %b) {
; CHECK-LABEL: test_vmulhud:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulhud v2, v3, v2
; CHECK-NEXT:    blr
entry:
  %0 = zext <2 x i64> %a to <2 x i128>
  %1 = zext <2 x i64> %b to <2 x i128>
  %mul = mul <2 x i128> %1, %0
  %shr = lshr <2 x i128> %mul, <i128 64, i128 64>
  %tr = trunc <2 x i128> %shr to <2 x i64>
  ret <2 x i64> %tr
}

define <4 x i32> @test_vmulhsw(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: test_vmulhsw:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulhsw v2, v3, v2
; CHECK-NEXT:    blr
entry:
  %0 = sext <4 x i32> %a to <4 x i64>
  %1 = sext <4 x i32> %b to <4 x i64>
  %mul = mul <4 x i64> %1, %0
  %shr = lshr <4 x i64> %mul, <i64 32, i64 32, i64 32, i64 32>
  %tr = trunc <4 x i64> %shr to <4 x i32>
  ret <4 x i32> %tr
}

define <4 x i32> @test_vmulhuw(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: test_vmulhuw:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulhuw v2, v3, v2
; CHECK-NEXT:    blr
entry:
  %0 = zext <4 x i32> %a to <4 x i64>
  %1 = zext <4 x i32> %b to <4 x i64>
  %mul = mul <4 x i64> %1, %0
  %shr = lshr <4 x i64> %mul, <i64 32, i64 32, i64 32, i64 32>
  %tr = trunc <4 x i64> %shr to <4 x i32>
  ret <4 x i32> %tr
}

; Test the vector multiply high intrinsics.
declare <4 x i32> @llvm.ppc.altivec.vmulhsw(<4 x i32>, <4 x i32>)
declare <4 x i32> @llvm.ppc.altivec.vmulhuw(<4 x i32>, <4 x i32>)
declare <2 x i64> @llvm.ppc.altivec.vmulhsd(<2 x i64>, <2 x i64>)
declare <2 x i64> @llvm.ppc.altivec.vmulhud(<2 x i64>, <2 x i64>)

define <4 x i32> @test_vmulhsw_intrinsic(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: test_vmulhsw_intrinsic:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulhsw v2, v2, v3
; CHECK-NEXT:    blr
entry:
  %mulh = tail call <4 x i32> @llvm.ppc.altivec.vmulhsw(<4 x i32> %a, <4 x i32> %b)
  ret <4 x i32> %mulh
}

define <4 x i32> @test_vmulhuw_intrinsic(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: test_vmulhuw_intrinsic:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulhuw v2, v2, v3
; CHECK-NEXT:    blr
entry:
  %mulh = tail call <4 x i32> @llvm.ppc.altivec.vmulhuw(<4 x i32> %a, <4 x i32> %b)
  ret <4 x i32> %mulh
}

define <2 x i64> @test_vmulhsd_intrinsic(<2 x i64> %a, <2 x i64> %b) {
; CHECK-LABEL: test_vmulhsd_intrinsic:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulhsd v2, v2, v3
; CHECK-NEXT:    blr
entry:
  %mulh = tail call <2 x i64> @llvm.ppc.altivec.vmulhsd(<2 x i64> %a, <2 x i64> %b)
  ret <2 x i64> %mulh
}

define <2 x i64> @test_vmulhud_intrinsic(<2 x i64> %a, <2 x i64> %b) {
; CHECK-LABEL: test_vmulhud_intrinsic:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmulhud v2, v2, v3
; CHECK-NEXT:    blr
entry:
  %mulh = tail call <2 x i64> @llvm.ppc.altivec.vmulhud(<2 x i64> %a, <2 x i64> %b)
  ret <2 x i64> %mulh
}

declare <1 x i128> @llvm.ppc.altivec.vmuleud(<2 x i64>, <2 x i64>) nounwind readnone
declare <1 x i128> @llvm.ppc.altivec.vmuloud(<2 x i64>, <2 x i64>) nounwind readnone
declare <1 x i128> @llvm.ppc.altivec.vmulesd(<2 x i64>, <2 x i64>) nounwind readnone
declare <1 x i128> @llvm.ppc.altivec.vmulosd(<2 x i64>, <2 x i64>) nounwind readnone
declare <1 x i128> @llvm.ppc.altivec.vmsumcud(<2 x i64>, <2 x i64>, <1 x i128>) nounwind readnone

define <1 x i128> @test_vmuleud(<2 x i64> %x, <2 x i64> %y) nounwind readnone {
; CHECK-LABEL: test_vmuleud:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmuleud v2, v2, v3
; CHECK-NEXT:    blr
  %tmp = tail call <1 x i128> @llvm.ppc.altivec.vmuleud(<2 x i64> %x, <2 x i64> %y)
  ret <1 x i128> %tmp
}

define <1 x i128> @test_vmuloud(<2 x i64> %x, <2 x i64> %y) nounwind readnone {
; CHECK-LABEL: test_vmuloud:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmuloud v2, v2, v3
; CHECK-NEXT:    blr
  %tmp = tail call <1 x i128> @llvm.ppc.altivec.vmuloud(<2 x i64> %x, <2 x i64> %y)
  ret <1 x i128> %tmp
}

define <1 x i128> @test_vmulesd(<2 x i64> %x, <2 x i64> %y) nounwind readnone {
; CHECK-LABEL: test_vmulesd:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmulesd v2, v2, v3
; CHECK-NEXT:    blr
  %tmp = tail call <1 x i128> @llvm.ppc.altivec.vmulesd(<2 x i64> %x, <2 x i64> %y)
  ret <1 x i128> %tmp
}

define <1 x i128> @test_vmulosd(<2 x i64> %x, <2 x i64> %y) nounwind readnone {
; CHECK-LABEL: test_vmulosd:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmulosd v2, v2, v3
; CHECK-NEXT:    blr
  %tmp = tail call <1 x i128> @llvm.ppc.altivec.vmulosd(<2 x i64> %x, <2 x i64> %y)
  ret <1 x i128> %tmp
}

define <1 x i128> @test_vmsumcud(<2 x i64> %x, <2 x i64> %y, <1 x i128> %z) nounwind readnone {
; CHECK-LABEL: test_vmsumcud:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmsumcud v2, v2, v3, v4
; CHECK-NEXT:    blr
  %tmp = tail call <1 x i128> @llvm.ppc.altivec.vmsumcud(<2 x i64> %x, <2 x i64> %y, <1 x i128> %z)
  ret <1 x i128> %tmp
}
