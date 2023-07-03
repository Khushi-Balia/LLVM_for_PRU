; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt < %s -passes="print<cost-model>" 2>&1 -disable-output -S -mtriple=riscv64 -mattr=+v -riscv-v-vector-bits-min=-1 | FileCheck %s
; Check that we don't crash querying costs when vectors are not enabled.
; RUN: opt -passes="print<cost-model>" 2>&1 -disable-output -mtriple=riscv64

declare <2 x i64>  @llvm.abs.v2i64(<2 x i64>, i1)
declare <4 x i64>  @llvm.abs.v4i64(<4 x i64>, i1)
declare <8 x i64>  @llvm.abs.v8i64(<8 x i64>, i1)
declare <vscale x 2 x i64> @llvm.abs.nxv2i64(<vscale x 2 x i64>, i1)
declare <vscale x 4 x i64> @llvm.abs.nxv4i64(<vscale x 4 x i64>, i1)
declare <vscale x 8 x i64> @llvm.abs.nxv8i64(<vscale x 8 x i64>, i1)

declare <2 x i32>  @llvm.abs.v2i32(<2 x i32>, i1)
declare <4 x i32>  @llvm.abs.v4i32(<4 x i32>, i1)
declare <8 x i32>  @llvm.abs.v8i32(<8 x i32>, i1)
declare <16 x i32> @llvm.abs.v16i32(<16 x i32>, i1)
declare <vscale x 2 x i32>  @llvm.abs.nxv2i32(<vscale x 2 x i32>, i1)
declare <vscale x 4 x i32>  @llvm.abs.nxv4i32(<vscale x 4 x i32>, i1)
declare <vscale x 8 x i32>  @llvm.abs.nxv8i32(<vscale x 8 x i32>, i1)
declare <vscale x 16 x i32> @llvm.abs.nxv16i32(<vscale x 16 x i32>, i1)

declare <2 x i16>  @llvm.abs.v2i16(<2 x i16>, i1)
declare <4 x i16>  @llvm.abs.v4i16(<4 x i16>, i1)
declare <8 x i16>  @llvm.abs.v8i16(<8 x i16>, i1)
declare <16 x i16> @llvm.abs.v16i16(<16 x i16>, i1)
declare <32 x i16> @llvm.abs.v32i16(<32 x i16>, i1)
declare <vscale x 2 x i16>  @llvm.abs.nxv2i16(<vscale x 2 x i16>, i1)
declare <vscale x 4 x i16>  @llvm.abs.nxv4i16(<vscale x 4 x i16>, i1)
declare <vscale x 8 x i16>  @llvm.abs.nxv8i16(<vscale x 8 x i16>, i1)
declare <vscale x 16 x i16> @llvm.abs.nxv16i16(<vscale x 16 x i16>, i1)
declare <vscale x 32 x i16> @llvm.abs.nxv32i16(<vscale x 32 x i16>, i1)

declare <2 x i8>   @llvm.abs.v2i8(<2 x i8>, i1)
declare <4 x i8>   @llvm.abs.v4i8(<4 x i8>, i1)
declare <8 x i8>   @llvm.abs.v8i8(<8 x i8>, i1)
declare <16 x i8>  @llvm.abs.v16i8(<16 x i8>, i1)
declare <32 x i8>  @llvm.abs.v32i8(<32 x i8>, i1)
declare <64 x i8>  @llvm.abs.v64i8(<64 x i8>, i1)
declare <vscale x 8 x i8>  @llvm.abs.nxv8i8(<vscale x 8 x i8>, i1)
declare <vscale x 16 x i8> @llvm.abs.nxv16i8(<vscale x 16 x i8>, i1)
declare <vscale x 32 x i8> @llvm.abs.nxv32i8(<vscale x 32 x i8>, i1)
declare <vscale x 64 x i8> @llvm.abs.nxv64i8(<vscale x 64 x i8>, i1)

define i32 @abs(i32 %arg) {
; CHECK-LABEL: 'abs'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %1 = call <2 x i64> @llvm.abs.v2i64(<2 x i64> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %2 = call <4 x i64> @llvm.abs.v4i64(<4 x i64> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %3 = call <8 x i64> @llvm.abs.v8i64(<8 x i64> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %4 = call <vscale x 2 x i64> @llvm.abs.nxv2i64(<vscale x 2 x i64> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %5 = call <vscale x 4 x i64> @llvm.abs.nxv4i64(<vscale x 4 x i64> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %6 = call <vscale x 8 x i64> @llvm.abs.nxv8i64(<vscale x 8 x i64> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %7 = call <2 x i32> @llvm.abs.v2i32(<2 x i32> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %8 = call <4 x i32> @llvm.abs.v4i32(<4 x i32> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %9 = call <8 x i32> @llvm.abs.v8i32(<8 x i32> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %10 = call <16 x i32> @llvm.abs.v16i32(<16 x i32> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %11 = call <vscale x 2 x i32> @llvm.abs.nxv2i32(<vscale x 2 x i32> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %12 = call <vscale x 4 x i32> @llvm.abs.nxv4i32(<vscale x 4 x i32> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %13 = call <vscale x 8 x i32> @llvm.abs.nxv8i32(<vscale x 8 x i32> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %14 = call <vscale x 16 x i32> @llvm.abs.nxv16i32(<vscale x 16 x i32> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %15 = call <2 x i16> @llvm.abs.v2i16(<2 x i16> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %16 = call <4 x i16> @llvm.abs.v4i16(<4 x i16> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %17 = call <8 x i16> @llvm.abs.v8i16(<8 x i16> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %18 = call <16 x i16> @llvm.abs.v16i16(<16 x i16> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %19 = call <32 x i16> @llvm.abs.v32i16(<32 x i16> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %20 = call <vscale x 2 x i16> @llvm.abs.nxv2i16(<vscale x 2 x i16> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %21 = call <vscale x 4 x i16> @llvm.abs.nxv4i16(<vscale x 4 x i16> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %22 = call <vscale x 8 x i16> @llvm.abs.nxv8i16(<vscale x 8 x i16> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %23 = call <vscale x 16 x i16> @llvm.abs.nxv16i16(<vscale x 16 x i16> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %24 = call <vscale x 32 x i16> @llvm.abs.nxv32i16(<vscale x 32 x i16> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %25 = call <8 x i8> @llvm.abs.v8i8(<8 x i8> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %26 = call <16 x i8> @llvm.abs.v16i8(<16 x i8> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %27 = call <32 x i8> @llvm.abs.v32i8(<32 x i8> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %28 = call <64 x i8> @llvm.abs.v64i8(<64 x i8> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %29 = call <vscale x 8 x i8> @llvm.abs.nxv8i8(<vscale x 8 x i8> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %30 = call <vscale x 16 x i8> @llvm.abs.nxv16i8(<vscale x 16 x i8> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %31 = call <vscale x 32 x i8> @llvm.abs.nxv32i8(<vscale x 32 x i8> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %32 = call <vscale x 64 x i8> @llvm.abs.nxv64i8(<vscale x 64 x i8> undef, i1 false)
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret i32 undef
;
  call <2 x i64> @llvm.abs.v2i64(<2 x i64> undef, i1 false)
  call <4 x i64> @llvm.abs.v4i64(<4 x i64> undef, i1 false)
  call <8 x i64> @llvm.abs.v8i64(<8 x i64> undef, i1 false)
  call <vscale x 2 x i64> @llvm.abs.nxv2i64(<vscale x 2 x i64> undef, i1 false)
  call <vscale x 4 x i64> @llvm.abs.nxv4i64(<vscale x 4 x i64> undef, i1 false)
  call <vscale x 8 x i64> @llvm.abs.nxv8i64(<vscale x 8 x i64> undef, i1 false)

  call <2 x i32>  @llvm.abs.v2i32(<2 x i32> undef, i1 false)
  call <4 x i32>  @llvm.abs.v4i32(<4 x i32> undef, i1 false)
  call <8 x i32>  @llvm.abs.v8i32(<8 x i32> undef, i1 false)
  call <16 x i32> @llvm.abs.v16i32(<16 x i32> undef, i1 false)
  call <vscale x 2 x i32>  @llvm.abs.nxv2i32(<vscale x 2 x i32> undef, i1 false)
  call <vscale x 4 x i32>  @llvm.abs.nxv4i32(<vscale x 4 x i32> undef, i1 false)
  call <vscale x 8 x i32>  @llvm.abs.nxv8i32(<vscale x 8 x i32> undef, i1 false)
  call <vscale x 16 x i32> @llvm.abs.nxv16i32(<vscale x 16 x i32> undef, i1 false)

  call <2 x i16>  @llvm.abs.v2i16(<2 x i16> undef, i1 false)
  call <4 x i16>  @llvm.abs.v4i16(<4 x i16> undef, i1 false)
  call <8 x i16>  @llvm.abs.v8i16(<8 x i16> undef, i1 false)
  call <16 x i16> @llvm.abs.v16i16(<16 x i16> undef, i1 false)
  call <32 x i16> @llvm.abs.v32i16(<32 x i16> undef, i1 false)
  call <vscale x 2 x i16>  @llvm.abs.nxv2i16(<vscale x 2 x i16> undef, i1 false)
  call <vscale x 4 x i16>  @llvm.abs.nxv4i16(<vscale x 4 x i16> undef, i1 false)
  call <vscale x 8 x i16>  @llvm.abs.nxv8i16(<vscale x 8 x i16> undef, i1 false)
  call <vscale x 16 x i16> @llvm.abs.nxv16i16(<vscale x 16 x i16> undef, i1 false)
  call <vscale x 32 x i16> @llvm.abs.nxv32i16(<vscale x 32 x i16> undef, i1 false)

  call <8 x i8>  @llvm.abs.v8i8(<8 x i8> undef, i1 false)
  call <16 x i8> @llvm.abs.v16i8(<16 x i8> undef, i1 false)
  call <32 x i8> @llvm.abs.v32i8(<32 x i8> undef, i1 false)
  call <64 x i8> @llvm.abs.v64i8(<64 x i8> undef, i1 false)
  call <vscale x 8 x i8>  @llvm.abs.nxv8i8(<vscale x 8 x i8> undef, i1 false)
  call <vscale x 16 x i8> @llvm.abs.nxv16i8(<vscale x 16 x i8> undef, i1 false)
  call <vscale x 32 x i8> @llvm.abs.nxv32i8(<vscale x 32 x i8> undef, i1 false)
  call <vscale x 64 x i8> @llvm.abs.nxv64i8(<vscale x 64 x i8> undef, i1 false)

  ret i32 undef
}