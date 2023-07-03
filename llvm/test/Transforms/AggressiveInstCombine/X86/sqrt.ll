; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=aggressive-instcombine -mtriple x86_64-- -S | FileCheck %s

declare float @sqrtf(float)
declare double @sqrt(double)
declare fp128 @sqrtl(fp128)
declare float @llvm.fabs.f32(float)

; "nnan" implies no setting of errno and the target can lower this to an
; instruction, so transform to an intrinsic.

define float @sqrt_call_nnan_f32(float %x) {
; CHECK-LABEL: @sqrt_call_nnan_f32(
; CHECK-NEXT:    [[SQRT1:%.*]] = call nnan float @llvm.sqrt.f32(float [[X:%.*]])
; CHECK-NEXT:    ret float [[SQRT1]]
;
  %sqrt = call nnan float @sqrtf(float %x)
  ret float %sqrt
}

; Verify that other FMF are propagated to the intrinsic call.
; We don't care about propagating 'tail' because this is not going to be a lowered as a call.

define double @sqrt_call_nnan_f64(double %x) {
; CHECK-LABEL: @sqrt_call_nnan_f64(
; CHECK-NEXT:    [[SQRT1:%.*]] = call nnan ninf double @llvm.sqrt.f64(double [[X:%.*]])
; CHECK-NEXT:    ret double [[SQRT1]]
;
  %sqrt = tail call nnan ninf double @sqrt(double %x)
  ret double %sqrt
}

; We don't change this because it will be lowered to a call that could
; theoretically still change errno and affect other accessors of errno.

define fp128 @sqrt_call_nnan_f128(fp128 %x) {
; CHECK-LABEL: @sqrt_call_nnan_f128(
; CHECK-NEXT:    [[SQRT:%.*]] = call nnan fp128 @sqrtl(fp128 [[X:%.*]])
; CHECK-NEXT:    ret fp128 [[SQRT]]
;
  %sqrt = call nnan fp128 @sqrtl(fp128 %x)
  ret fp128 %sqrt
}

; Don't alter a no-builtin libcall.

define float @sqrt_call_nnan_f32_nobuiltin(float %x) {
; CHECK-LABEL: @sqrt_call_nnan_f32_nobuiltin(
; CHECK-NEXT:    [[SQRT:%.*]] = call nnan float @sqrtf(float [[X:%.*]]) #[[ATTR1:[0-9]+]]
; CHECK-NEXT:    ret float [[SQRT]]
;
  %sqrt = call nnan float @sqrtf(float %x) nobuiltin
  ret float %sqrt
}

define float @sqrt_call_f32_squared(float %x) {
; CHECK-LABEL: @sqrt_call_f32_squared(
; CHECK-NEXT:    [[X2:%.*]] = fmul float [[X:%.*]], [[X]]
; CHECK-NEXT:    [[SQRT1:%.*]] = call float @llvm.sqrt.f32(float [[X2]])
; CHECK-NEXT:    ret float [[SQRT1]]
;
  %x2 = fmul float %x, %x
  %sqrt = call float @sqrtf(float %x2)
  ret float %sqrt
}

define float @sqrt_call_f32_fabs(float %x) {
; CHECK-LABEL: @sqrt_call_f32_fabs(
; CHECK-NEXT:    [[A:%.*]] = call float @llvm.fabs.f32(float [[X:%.*]])
; CHECK-NEXT:    [[SQRT1:%.*]] = call float @llvm.sqrt.f32(float [[A]])
; CHECK-NEXT:    ret float [[SQRT1]]
;
  %a = call float @llvm.fabs.f32(float %x)
  %sqrt = call float @sqrtf(float %a)
  ret float %sqrt
}
