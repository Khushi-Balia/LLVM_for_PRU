; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -mtriple=amdgcn-amd-amdhsa -passes=infer-address-spaces,instsimplify %s | FileCheck %s

target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5"

define i8 @ptrmask_cast_local_to_flat(ptr addrspace(3) %src.ptr, i64 %mask) {
; CHECK-LABEL: @ptrmask_cast_local_to_flat(
; CHECK-NEXT:    [[CAST:%.*]] = addrspacecast ptr addrspace(3) [[SRC_PTR:%.*]] to ptr
; CHECK-NEXT:    [[MASKED:%.*]] = call ptr @llvm.ptrmask.p0.i64(ptr [[CAST]], i64 [[MASK:%.*]])
; CHECK-NEXT:    [[LOAD:%.*]] = load i8, ptr [[MASKED]], align 1
; CHECK-NEXT:    ret i8 [[LOAD]]
;
  %cast = addrspacecast ptr addrspace(3) %src.ptr to ptr
  %masked = call ptr @llvm.ptrmask.p0.i64(ptr %cast, i64 %mask)
  %load = load i8, ptr %masked
  ret i8 %load
}

define i8 @ptrmask_cast_private_to_flat(ptr addrspace(5) %src.ptr, i64 %mask) {
; CHECK-LABEL: @ptrmask_cast_private_to_flat(
; CHECK-NEXT:    [[CAST:%.*]] = addrspacecast ptr addrspace(5) [[SRC_PTR:%.*]] to ptr
; CHECK-NEXT:    [[MASKED:%.*]] = call ptr @llvm.ptrmask.p0.i64(ptr [[CAST]], i64 [[MASK:%.*]])
; CHECK-NEXT:    [[LOAD:%.*]] = load i8, ptr [[MASKED]], align 1
; CHECK-NEXT:    ret i8 [[LOAD]]
;
  %cast = addrspacecast ptr addrspace(5) %src.ptr to ptr
  %masked = call ptr @llvm.ptrmask.p0.i64(ptr %cast, i64 %mask)
  %load = load i8, ptr %masked
  ret i8 %load
}

define i8 @ptrmask_cast_region_to_flat(ptr addrspace(2) %src.ptr, i64 %mask) {
; CHECK-LABEL: @ptrmask_cast_region_to_flat(
; CHECK-NEXT:    [[CAST:%.*]] = addrspacecast ptr addrspace(2) [[SRC_PTR:%.*]] to ptr
; CHECK-NEXT:    [[MASKED:%.*]] = call ptr @llvm.ptrmask.p0.i64(ptr [[CAST]], i64 [[MASK:%.*]])
; CHECK-NEXT:    [[LOAD:%.*]] = load i8, ptr [[MASKED]], align 1
; CHECK-NEXT:    ret i8 [[LOAD]]
;
  %cast = addrspacecast ptr addrspace(2) %src.ptr to ptr
  %masked = call ptr @llvm.ptrmask.p0.i64(ptr %cast, i64 %mask)
  %load = load i8, ptr %masked
  ret i8 %load
}

define i8 @ptrmask_cast_global_to_flat(ptr addrspace(1) %src.ptr, i64 %mask) {
; CHECK-LABEL: @ptrmask_cast_global_to_flat(
; CHECK-NEXT:    [[TMP1:%.*]] = call ptr addrspace(1) @llvm.ptrmask.p1.i64(ptr addrspace(1) [[SRC_PTR:%.*]], i64 [[MASK:%.*]])
; CHECK-NEXT:    [[LOAD:%.*]] = load i8, ptr addrspace(1) [[TMP1]], align 1
; CHECK-NEXT:    ret i8 [[LOAD]]
;
  %cast = addrspacecast ptr addrspace(1) %src.ptr to ptr
  %masked = call ptr @llvm.ptrmask.p0.i64(ptr %cast, i64 %mask)
  %load = load i8, ptr %masked
  ret i8 %load
}

define i8 @ptrmask_cast_999_to_flat(ptr addrspace(999) %src.ptr, i64 %mask) {
; CHECK-LABEL: @ptrmask_cast_999_to_flat(
; CHECK-NEXT:    [[TMP1:%.*]] = call ptr addrspace(999) @llvm.ptrmask.p999.i64(ptr addrspace(999) [[SRC_PTR:%.*]], i64 [[MASK:%.*]])
; CHECK-NEXT:    [[LOAD:%.*]] = load i8, ptr addrspace(999) [[TMP1]], align 1
; CHECK-NEXT:    ret i8 [[LOAD]]
;
  %cast = addrspacecast ptr addrspace(999) %src.ptr to ptr
  %masked = call ptr @llvm.ptrmask.p0.i64(ptr %cast, i64 %mask)
  %load = load i8, ptr %masked
  ret i8 %load
}

define i8 @ptrmask_cast_flat_to_local(ptr %ptr, i64 %mask) {
; CHECK-LABEL: @ptrmask_cast_flat_to_local(
; CHECK-NEXT:    [[MASKED:%.*]] = call ptr @llvm.ptrmask.p0.i64(ptr [[PTR:%.*]], i64 [[MASK:%.*]])
; CHECK-NEXT:    [[CAST:%.*]] = addrspacecast ptr [[MASKED]] to ptr addrspace(3)
; CHECK-NEXT:    [[LOAD:%.*]] = load i8, ptr addrspace(3) [[CAST]], align 1
; CHECK-NEXT:    ret i8 [[LOAD]]
;
  %masked = call ptr @llvm.ptrmask.p0.i64(ptr %ptr, i64 %mask)
  %cast = addrspacecast ptr %masked to ptr addrspace(3)
  %load = load i8, ptr addrspace(3) %cast
  ret i8 %load
}

define i8 @ptrmask_cast_flat_to_private(ptr %ptr, i64 %mask) {
; CHECK-LABEL: @ptrmask_cast_flat_to_private(
; CHECK-NEXT:    [[MASKED:%.*]] = call ptr @llvm.ptrmask.p0.i64(ptr [[PTR:%.*]], i64 [[MASK:%.*]])
; CHECK-NEXT:    [[CAST:%.*]] = addrspacecast ptr [[MASKED]] to ptr addrspace(5)
; CHECK-NEXT:    [[LOAD:%.*]] = load i8, ptr addrspace(5) [[CAST]], align 1
; CHECK-NEXT:    ret i8 [[LOAD]]
;
  %masked = call ptr @llvm.ptrmask.p0.i64(ptr %ptr, i64 %mask)
  %cast = addrspacecast ptr %masked to ptr addrspace(5)
  %load = load i8, ptr addrspace(5) %cast
  ret i8 %load
}

define i8 @ptrmask_cast_flat_to_global(ptr %ptr, i64 %mask) {
; CHECK-LABEL: @ptrmask_cast_flat_to_global(
; CHECK-NEXT:    [[MASKED:%.*]] = call ptr @llvm.ptrmask.p0.i64(ptr [[PTR:%.*]], i64 [[MASK:%.*]])
; CHECK-NEXT:    [[CAST:%.*]] = addrspacecast ptr [[MASKED]] to ptr addrspace(1)
; CHECK-NEXT:    [[LOAD:%.*]] = load i8, ptr addrspace(1) [[CAST]], align 1
; CHECK-NEXT:    ret i8 [[LOAD]]
;
  %masked = call ptr @llvm.ptrmask.p0.i64(ptr %ptr, i64 %mask)
  %cast = addrspacecast ptr %masked to ptr addrspace(1)
  %load = load i8, ptr addrspace(1) %cast
  ret i8 %load
}

@lds0 = internal addrspace(3) global i8 123, align 4
@gv = internal addrspace(1) global i8 123, align 4

define i8 @ptrmask_cast_local_to_flat_global(i64 %mask) {
; CHECK-LABEL: @ptrmask_cast_local_to_flat_global(
; CHECK-NEXT:    [[MASKED:%.*]] = call ptr @llvm.ptrmask.p0.i64(ptr addrspacecast (ptr addrspace(3) @lds0 to ptr), i64 [[MASK:%.*]])
; CHECK-NEXT:    [[LOAD:%.*]] = load i8, ptr [[MASKED]], align 1
; CHECK-NEXT:    ret i8 [[LOAD]]
;
  %masked = call ptr @llvm.ptrmask.p0.i64(ptr addrspacecast (ptr addrspace(3) @lds0 to ptr), i64 %mask)
  %load = load i8, ptr %masked, align 1
  ret i8 %load
}

define i8 @ptrmask_cast_global_to_flat_global(i64 %mask) {
; CHECK-LABEL: @ptrmask_cast_global_to_flat_global(
; CHECK-NEXT:    [[TMP1:%.*]] = call ptr addrspace(1) @llvm.ptrmask.p1.i64(ptr addrspace(1) @gv, i64 [[MASK:%.*]])
; CHECK-NEXT:    [[LOAD:%.*]] = load i8, ptr addrspace(1) [[TMP1]], align 1
; CHECK-NEXT:    ret i8 [[LOAD]]
;
  %masked = call ptr @llvm.ptrmask.p0.i64(ptr addrspacecast (ptr addrspace(1) @gv to ptr), i64 %mask)
  %load = load i8, ptr %masked, align 1
  ret i8 %load
}

define i8 @multi_ptrmask_cast_global_to_flat(ptr addrspace(1) %src.ptr, i64 %mask) {
; CHECK-LABEL: @multi_ptrmask_cast_global_to_flat(
; CHECK-NEXT:    [[LOAD0:%.*]] = load i8, ptr addrspace(1) [[SRC_PTR:%.*]], align 1
; CHECK-NEXT:    [[TMP1:%.*]] = call ptr addrspace(1) @llvm.ptrmask.p1.i64(ptr addrspace(1) [[SRC_PTR]], i64 [[MASK:%.*]])
; CHECK-NEXT:    [[LOAD1:%.*]] = load i8, ptr addrspace(1) [[TMP1]], align 1
; CHECK-NEXT:    [[ADD:%.*]] = add i8 [[LOAD0]], [[LOAD1]]
; CHECK-NEXT:    ret i8 [[ADD]]
;
  %cast = addrspacecast ptr addrspace(1) %src.ptr to ptr
  %load0 = load i8, ptr %cast
  %masked = call ptr @llvm.ptrmask.p0.i64(ptr %cast, i64 %mask)
  %load1 = load i8, ptr %masked
  %add = add i8 %load0, %load1
  ret i8 %add
}

; Can't rewrite the ptrmask, but can rewrite other use instructions
define i8 @multi_ptrmask_cast_local_to_flat(ptr addrspace(3) %src.ptr, i64 %mask) {
; CHECK-LABEL: @multi_ptrmask_cast_local_to_flat(
; CHECK-NEXT:    [[CAST:%.*]] = addrspacecast ptr addrspace(3) [[SRC_PTR:%.*]] to ptr
; CHECK-NEXT:    [[LOAD0:%.*]] = load i8, ptr addrspace(3) [[SRC_PTR]], align 1
; CHECK-NEXT:    [[MASKED:%.*]] = call ptr @llvm.ptrmask.p0.i64(ptr [[CAST]], i64 [[MASK:%.*]])
; CHECK-NEXT:    [[LOAD1:%.*]] = load i8, ptr [[MASKED]], align 1
; CHECK-NEXT:    [[ADD:%.*]] = add i8 [[LOAD0]], [[LOAD1]]
; CHECK-NEXT:    ret i8 [[ADD]]
;
  %cast = addrspacecast ptr addrspace(3) %src.ptr to ptr
  %load0 = load i8, ptr %cast
  %masked = call ptr @llvm.ptrmask.p0.i64(ptr %cast, i64 %mask)
  %load1 = load i8, ptr %masked
  %add = add i8 %load0, %load1
  ret i8 %add
}

define i8 @multi_ptrmask_cast_region_to_flat(ptr addrspace(2) %src.ptr, i64 %mask) {
; CHECK-LABEL: @multi_ptrmask_cast_region_to_flat(
; CHECK-NEXT:    [[CAST:%.*]] = addrspacecast ptr addrspace(2) [[SRC_PTR:%.*]] to ptr
; CHECK-NEXT:    [[LOAD0:%.*]] = load i8, ptr addrspace(2) [[SRC_PTR]], align 1
; CHECK-NEXT:    [[MASKED:%.*]] = call ptr @llvm.ptrmask.p0.i64(ptr [[CAST]], i64 [[MASK:%.*]])
; CHECK-NEXT:    [[LOAD1:%.*]] = load i8, ptr [[MASKED]], align 1
; CHECK-NEXT:    [[ADD:%.*]] = add i8 [[LOAD0]], [[LOAD1]]
; CHECK-NEXT:    ret i8 [[ADD]]
;
  %cast = addrspacecast ptr addrspace(2) %src.ptr to ptr
  %load0 = load i8, ptr %cast
  %masked = call ptr @llvm.ptrmask.p0.i64(ptr %cast, i64 %mask)
  %load1 = load i8, ptr %masked
  %add = add i8 %load0, %load1
  ret i8 %add
}

; Do not fold this since it clears a single high bit.
define i8 @ptrmask_cast_local_to_flat_const_mask_fffffffeffffffff(ptr addrspace(3) %src.ptr) {
; CHECK-LABEL: @ptrmask_cast_local_to_flat_const_mask_fffffffeffffffff(
; CHECK-NEXT:    [[CAST:%.*]] = addrspacecast ptr addrspace(3) [[SRC_PTR:%.*]] to ptr
; CHECK-NEXT:    [[MASKED:%.*]] = call ptr @llvm.ptrmask.p0.i64(ptr [[CAST]], i64 -4294967297)
; CHECK-NEXT:    [[LOAD:%.*]] = load i8, ptr [[MASKED]], align 1
; CHECK-NEXT:    ret i8 [[LOAD]]
;
  %cast = addrspacecast ptr addrspace(3) %src.ptr to ptr
  %masked = call ptr @llvm.ptrmask.p0.i64(ptr %cast, i64 -4294967297)
  %load = load i8, ptr %masked
  ret i8 %load
}

; Do not fold this since it clears a single high bit.
define i8 @ptrmask_cast_local_to_flat_const_mask_7fffffffffffffff(ptr addrspace(3) %src.ptr) {
; CHECK-LABEL: @ptrmask_cast_local_to_flat_const_mask_7fffffffffffffff(
; CHECK-NEXT:    [[CAST:%.*]] = addrspacecast ptr addrspace(3) [[SRC_PTR:%.*]] to ptr
; CHECK-NEXT:    [[MASKED:%.*]] = call ptr @llvm.ptrmask.p0.i64(ptr [[CAST]], i64 9223372036854775807)
; CHECK-NEXT:    [[LOAD:%.*]] = load i8, ptr [[MASKED]], align 1
; CHECK-NEXT:    ret i8 [[LOAD]]
;
  %cast = addrspacecast ptr addrspace(3) %src.ptr to ptr
  %masked = call ptr @llvm.ptrmask.p0.i64(ptr %cast, i64 9223372036854775807)
  %load = load i8, ptr %masked
  ret i8 %load
}

define i8 @ptrmask_cast_local_to_flat_const_mask_ffffffff00000000(ptr addrspace(3) %src.ptr) {
; CHECK-LABEL: @ptrmask_cast_local_to_flat_const_mask_ffffffff00000000(
; CHECK-NEXT:    [[TMP1:%.*]] = call ptr addrspace(3) @llvm.ptrmask.p3.i32(ptr addrspace(3) [[SRC_PTR:%.*]], i32 0)
; CHECK-NEXT:    [[LOAD:%.*]] = load i8, ptr addrspace(3) [[TMP1]], align 1
; CHECK-NEXT:    ret i8 [[LOAD]]
;
  %cast = addrspacecast ptr addrspace(3) %src.ptr to ptr
  %masked = call ptr @llvm.ptrmask.p0.i64(ptr %cast, i64 -4294967296)
  %load = load i8, ptr %masked
  ret i8 %load
}

define i8 @ptrmask_cast_local_to_flat_const_mask_ffffffff80000000(ptr addrspace(3) %src.ptr) {
; CHECK-LABEL: @ptrmask_cast_local_to_flat_const_mask_ffffffff80000000(
; CHECK-NEXT:    [[TMP1:%.*]] = call ptr addrspace(3) @llvm.ptrmask.p3.i32(ptr addrspace(3) [[SRC_PTR:%.*]], i32 -2147483648)
; CHECK-NEXT:    [[LOAD:%.*]] = load i8, ptr addrspace(3) [[TMP1]], align 1
; CHECK-NEXT:    ret i8 [[LOAD]]
;
  %cast = addrspacecast ptr addrspace(3) %src.ptr to ptr
  %masked = call ptr @llvm.ptrmask.p0.i64(ptr %cast, i64 -2147483648)
  %load = load i8, ptr %masked
  ret i8 %load
}

; Test some align-down patterns. These only touch the low bits, which are preserved through the cast.
define i8 @ptrmask_cast_local_to_flat_const_mask_ffffffffffff0000(ptr addrspace(3) %src.ptr) {
; CHECK-LABEL: @ptrmask_cast_local_to_flat_const_mask_ffffffffffff0000(
; CHECK-NEXT:    [[TMP1:%.*]] = call ptr addrspace(3) @llvm.ptrmask.p3.i32(ptr addrspace(3) [[SRC_PTR:%.*]], i32 -65536)
; CHECK-NEXT:    [[LOAD:%.*]] = load i8, ptr addrspace(3) [[TMP1]], align 1
; CHECK-NEXT:    ret i8 [[LOAD]]
;
  %cast = addrspacecast ptr addrspace(3) %src.ptr to ptr
  %masked = call ptr @llvm.ptrmask.p0.i64(ptr %cast, i64 -65536)
  %load = load i8, ptr %masked
  ret i8 %load
}

define i8 @ptrmask_cast_local_to_flat_const_mask_ffffffffffffff00(ptr addrspace(3) %src.ptr) {
; CHECK-LABEL: @ptrmask_cast_local_to_flat_const_mask_ffffffffffffff00(
; CHECK-NEXT:    [[TMP1:%.*]] = call ptr addrspace(3) @llvm.ptrmask.p3.i32(ptr addrspace(3) [[SRC_PTR:%.*]], i32 -256)
; CHECK-NEXT:    [[LOAD:%.*]] = load i8, ptr addrspace(3) [[TMP1]], align 1
; CHECK-NEXT:    ret i8 [[LOAD]]
;
  %cast = addrspacecast ptr addrspace(3) %src.ptr to ptr
  %masked = call ptr @llvm.ptrmask.p0.i64(ptr %cast, i64 -256)
  %load = load i8, ptr %masked
  ret i8 %load
}

define i8 @ptrmask_cast_local_to_flat_const_mask_ffffffffffffffe0(ptr addrspace(3) %src.ptr) {
; CHECK-LABEL: @ptrmask_cast_local_to_flat_const_mask_ffffffffffffffe0(
; CHECK-NEXT:    [[TMP1:%.*]] = call ptr addrspace(3) @llvm.ptrmask.p3.i32(ptr addrspace(3) [[SRC_PTR:%.*]], i32 -32)
; CHECK-NEXT:    [[LOAD:%.*]] = load i8, ptr addrspace(3) [[TMP1]], align 1
; CHECK-NEXT:    ret i8 [[LOAD]]
;
  %cast = addrspacecast ptr addrspace(3) %src.ptr to ptr
  %masked = call ptr @llvm.ptrmask.p0.i64(ptr %cast, i64 -32)
  %load = load i8, ptr %masked
  ret i8 %load
}

define i8 @ptrmask_cast_local_to_flat_const_mask_fffffffffffffff0(ptr addrspace(3) %src.ptr) {
; CHECK-LABEL: @ptrmask_cast_local_to_flat_const_mask_fffffffffffffff0(
; CHECK-NEXT:    [[TMP1:%.*]] = call ptr addrspace(3) @llvm.ptrmask.p3.i32(ptr addrspace(3) [[SRC_PTR:%.*]], i32 -16)
; CHECK-NEXT:    [[LOAD:%.*]] = load i8, ptr addrspace(3) [[TMP1]], align 1
; CHECK-NEXT:    ret i8 [[LOAD]]
;
  %cast = addrspacecast ptr addrspace(3) %src.ptr to ptr
  %masked = call ptr @llvm.ptrmask.p0.i64(ptr %cast, i64 -16)
  %load = load i8, ptr %masked
  ret i8 %load
}

define i8 @ptrmask_cast_local_to_flat_const_mask_fffffffffffffff8(ptr addrspace(3) %src.ptr) {
; CHECK-LABEL: @ptrmask_cast_local_to_flat_const_mask_fffffffffffffff8(
; CHECK-NEXT:    [[TMP1:%.*]] = call ptr addrspace(3) @llvm.ptrmask.p3.i32(ptr addrspace(3) [[SRC_PTR:%.*]], i32 -8)
; CHECK-NEXT:    [[LOAD:%.*]] = load i8, ptr addrspace(3) [[TMP1]], align 1
; CHECK-NEXT:    ret i8 [[LOAD]]
;
  %cast = addrspacecast ptr addrspace(3) %src.ptr to ptr
  %masked = call ptr @llvm.ptrmask.p0.i64(ptr %cast, i64 -8)
  %load = load i8, ptr %masked
  ret i8 %load
}

define i8 @ptrmask_cast_local_to_flat_const_mask_fffffffffffffffc(ptr addrspace(3) %src.ptr) {
; CHECK-LABEL: @ptrmask_cast_local_to_flat_const_mask_fffffffffffffffc(
; CHECK-NEXT:    [[TMP1:%.*]] = call ptr addrspace(3) @llvm.ptrmask.p3.i32(ptr addrspace(3) [[SRC_PTR:%.*]], i32 -4)
; CHECK-NEXT:    [[LOAD:%.*]] = load i8, ptr addrspace(3) [[TMP1]], align 1
; CHECK-NEXT:    ret i8 [[LOAD]]
;
  %cast = addrspacecast ptr addrspace(3) %src.ptr to ptr
  %masked = call ptr @llvm.ptrmask.p0.i64(ptr %cast, i64 -4)
  %load = load i8, ptr %masked
  ret i8 %load
}

define i8 @ptrmask_cast_local_to_flat_const_mask_fffffffffffffffe(ptr addrspace(3) %src.ptr) {
; CHECK-LABEL: @ptrmask_cast_local_to_flat_const_mask_fffffffffffffffe(
; CHECK-NEXT:    [[TMP1:%.*]] = call ptr addrspace(3) @llvm.ptrmask.p3.i32(ptr addrspace(3) [[SRC_PTR:%.*]], i32 -2)
; CHECK-NEXT:    [[LOAD:%.*]] = load i8, ptr addrspace(3) [[TMP1]], align 1
; CHECK-NEXT:    ret i8 [[LOAD]]
;
  %cast = addrspacecast ptr addrspace(3) %src.ptr to ptr
  %masked = call ptr @llvm.ptrmask.p0.i64(ptr %cast, i64 -2)
  %load = load i8, ptr %masked
  ret i8 %load
}

define i8 @ptrmask_cast_local_to_flat_const_mask_ffffffffffffffff(ptr addrspace(3) %src.ptr) {
; CHECK-LABEL: @ptrmask_cast_local_to_flat_const_mask_ffffffffffffffff(
; CHECK-NEXT:    [[TMP1:%.*]] = call ptr addrspace(3) @llvm.ptrmask.p3.i32(ptr addrspace(3) [[SRC_PTR:%.*]], i32 -1)
; CHECK-NEXT:    [[LOAD:%.*]] = load i8, ptr addrspace(3) [[TMP1]], align 1
; CHECK-NEXT:    ret i8 [[LOAD]]
;
  %cast = addrspacecast ptr addrspace(3) %src.ptr to ptr
  %masked = call ptr @llvm.ptrmask.p0.i64(ptr %cast, i64 -1)
  %load = load i8, ptr %masked
  ret i8 %load
}

; Make sure non-constant masks can also be handled.
define i8 @ptrmask_cast_local_to_flat_load_range_mask(ptr addrspace(3) %src.ptr, ptr addrspace(1) %mask.ptr) {
; CHECK-LABEL: @ptrmask_cast_local_to_flat_load_range_mask(
; CHECK-NEXT:    [[LOAD_MASK:%.*]] = load i64, ptr addrspace(1) [[MASK_PTR:%.*]], align 8, !range !0
; CHECK-NEXT:    [[TMP1:%.*]] = trunc i64 [[LOAD_MASK]] to i32
; CHECK-NEXT:    [[TMP2:%.*]] = call ptr addrspace(3) @llvm.ptrmask.p3.i32(ptr addrspace(3) [[SRC_PTR:%.*]], i32 [[TMP1]])
; CHECK-NEXT:    [[LOAD:%.*]] = load i8, ptr addrspace(3) [[TMP2]], align 1
; CHECK-NEXT:    ret i8 [[LOAD]]
;
  %load.mask = load i64, ptr addrspace(1) %mask.ptr, align 8, !range !0
  %cast = addrspacecast ptr addrspace(3) %src.ptr to ptr
  %masked = call ptr @llvm.ptrmask.p0.i64(ptr %cast, i64 %load.mask)
  %load = load i8, ptr %masked
  ret i8 %load
}

; This should not be folded, as the mask is implicitly zero extended,
; so it would clear the high bits.
define i8 @ptrmask_cast_local_to_flat_const_mask_32bit_neg4(ptr addrspace(3) %src.ptr) {
; CHECK-LABEL: @ptrmask_cast_local_to_flat_const_mask_32bit_neg4(
; CHECK-NEXT:    [[CAST:%.*]] = addrspacecast ptr addrspace(3) [[SRC_PTR:%.*]] to ptr
; CHECK-NEXT:    [[MASKED:%.*]] = call ptr @llvm.ptrmask.p0.i32(ptr [[CAST]], i32 -4)
; CHECK-NEXT:    [[LOAD:%.*]] = load i8, ptr [[MASKED]], align 1
; CHECK-NEXT:    ret i8 [[LOAD]]
;
  %cast = addrspacecast ptr addrspace(3) %src.ptr to ptr
  %masked = call ptr @llvm.ptrmask.p0.i32(ptr %cast, i32 -4)
  %load = load i8, ptr %masked
  ret i8 %load
}

declare ptr @llvm.ptrmask.p0.i64(ptr, i64) #0
declare ptr @llvm.ptrmask.p0.i32(ptr, i32) #0
declare ptr addrspace(5) @llvm.ptrmask.p5.i32(ptr addrspace(5), i32) #0
declare ptr addrspace(3) @llvm.ptrmask.p3.i32(ptr addrspace(3), i32) #0
declare ptr addrspace(1) @llvm.ptrmask.p1.i64(ptr addrspace(1), i64) #0

attributes #0 = { nounwind readnone speculatable willreturn }

!0 = !{i64 -64, i64 -1}
