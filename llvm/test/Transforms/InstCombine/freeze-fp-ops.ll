; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=instcombine < %s | FileCheck %s

; Test that floating point operations are not treated as sources of
; poison.

define float @freeze_fneg(float %arg) {
; CHECK-LABEL: @freeze_fneg(
; CHECK-NEXT:    [[ARG_FR:%.*]] = freeze float [[ARG:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = fneg float [[ARG_FR]]
; CHECK-NEXT:    ret float [[OP]]
;
  %op = fneg float %arg
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_fadd(float %arg0, float noundef %arg1) {
; CHECK-LABEL: @freeze_fadd(
; CHECK-NEXT:    [[ARG0_FR:%.*]] = freeze float [[ARG0:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = fadd float [[ARG0_FR]], [[ARG1:%.*]]
; CHECK-NEXT:    ret float [[OP]]
;
  %op = fadd float %arg0, %arg1
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_fsub(float %arg0, float noundef %arg1) {
; CHECK-LABEL: @freeze_fsub(
; CHECK-NEXT:    [[ARG0_FR:%.*]] = freeze float [[ARG0:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = fsub float [[ARG0_FR]], [[ARG1:%.*]]
; CHECK-NEXT:    ret float [[OP]]
;
  %op = fsub float %arg0, %arg1
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_fmul(float %arg0, float noundef %arg1) {
; CHECK-LABEL: @freeze_fmul(
; CHECK-NEXT:    [[ARG0_FR:%.*]] = freeze float [[ARG0:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = fmul float [[ARG0_FR]], [[ARG1:%.*]]
; CHECK-NEXT:    ret float [[OP]]
;
  %op = fmul float %arg0, %arg1
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_fdiv(float %arg0, float noundef %arg1) {
; CHECK-LABEL: @freeze_fdiv(
; CHECK-NEXT:    [[ARG0_FR:%.*]] = freeze float [[ARG0:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = fdiv float [[ARG0_FR]], [[ARG1:%.*]]
; CHECK-NEXT:    ret float [[OP]]
;
  %op = fdiv float %arg0, %arg1
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_frem(float %arg0, float noundef %arg1) {
; CHECK-LABEL: @freeze_frem(
; CHECK-NEXT:    [[ARG0_FR:%.*]] = freeze float [[ARG0:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = fdiv float [[ARG0_FR]], [[ARG1:%.*]]
; CHECK-NEXT:    ret float [[OP]]
;
  %op = fdiv float %arg0, %arg1
  %freeze = freeze float %op
  ret float %freeze
}

define double @fpext(float %arg) {
; CHECK-LABEL: @fpext(
; CHECK-NEXT:    [[ARG_FR:%.*]] = freeze float [[ARG:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = fpext float [[ARG_FR]] to double
; CHECK-NEXT:    ret double [[OP]]
;
  %op = fpext float %arg to double
  %freeze = freeze double %op
  ret double %freeze
}

define float @fptrunc(double %arg) {
; CHECK-LABEL: @fptrunc(
; CHECK-NEXT:    [[ARG_FR:%.*]] = freeze double [[ARG:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = fptrunc double [[ARG_FR]] to float
; CHECK-NEXT:    ret float [[OP]]
;
  %op = fptrunc double %arg to float
  %freeze = freeze float %op
  ret float %freeze
}

define float @sitofp(i32 %arg) {
; CHECK-LABEL: @sitofp(
; CHECK-NEXT:    [[ARG_FR:%.*]] = freeze i32 [[ARG:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = sitofp i32 [[ARG_FR]] to float
; CHECK-NEXT:    ret float [[OP]]
;
  %op = sitofp i32 %arg to float
  %freeze = freeze float %op
  ret float %freeze
}

define float @uitofp(i32 %arg) {
; CHECK-LABEL: @uitofp(
; CHECK-NEXT:    [[ARG_FR:%.*]] = freeze i32 [[ARG:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = uitofp i32 [[ARG_FR]] to float
; CHECK-NEXT:    ret float [[OP]]
;
  %op = uitofp i32 %arg to float
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_fma(float %arg0, float noundef %arg1, float noundef %arg2) {
; CHECK-LABEL: @freeze_fma(
; CHECK-NEXT:    [[ARG0_FR:%.*]] = freeze float [[ARG0:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call float @llvm.fma.f32(float [[ARG0_FR]], float noundef [[ARG1:%.*]], float noundef [[ARG2:%.*]])
; CHECK-NEXT:    ret float [[OP]]
;
  %op = call float @llvm.fma.f32(float %arg0, float noundef %arg1, float noundef %arg2)
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_fmuladd(float %arg0, float noundef %arg1, float noundef %arg2) {
; CHECK-LABEL: @freeze_fmuladd(
; CHECK-NEXT:    [[ARG0_FR:%.*]] = freeze float [[ARG0:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call float @llvm.fmuladd.f32(float [[ARG0_FR]], float noundef [[ARG1:%.*]], float noundef [[ARG2:%.*]])
; CHECK-NEXT:    ret float [[OP]]
;
  %op = call float @llvm.fmuladd.f32(float %arg0, float noundef %arg1, float noundef %arg2)
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_sqrt(float %arg) {
; CHECK-LABEL: @freeze_sqrt(
; CHECK-NEXT:    [[ARG_FR:%.*]] = freeze float [[ARG:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call float @llvm.sqrt.f32(float [[ARG_FR]])
; CHECK-NEXT:    ret float [[OP]]
;
  %op = call float @llvm.sqrt.f32(float %arg)
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_powi(float %arg0, i32 %arg1) {
; CHECK-LABEL: @freeze_powi(
; CHECK-NEXT:    [[OP:%.*]] = call float @llvm.powi.f32.i32(float [[ARG0:%.*]], i32 [[ARG1:%.*]])
; CHECK-NEXT:    [[FREEZE:%.*]] = freeze float [[OP]]
; CHECK-NEXT:    ret float [[FREEZE]]
;
  %op = call float @llvm.powi.f32.i32(float %arg0, i32 %arg1)
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_sin(float %arg) {
; CHECK-LABEL: @freeze_sin(
; CHECK-NEXT:    [[ARG_FR:%.*]] = freeze float [[ARG:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call float @llvm.sin.f32(float [[ARG_FR]])
; CHECK-NEXT:    ret float [[OP]]
;
  %op = call float @llvm.sin.f32(float %arg)
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_cos(float %arg) {
; CHECK-LABEL: @freeze_cos(
; CHECK-NEXT:    [[ARG_FR:%.*]] = freeze float [[ARG:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call float @llvm.cos.f32(float [[ARG_FR]])
; CHECK-NEXT:    ret float [[OP]]
;
  %op = call float @llvm.cos.f32(float %arg)
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_pow(float %arg0, float noundef %arg1) {
; CHECK-LABEL: @freeze_pow(
; CHECK-NEXT:    [[ARG0_FR:%.*]] = freeze float [[ARG0:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call float @llvm.pow.f32(float [[ARG0_FR]], float noundef [[ARG1:%.*]])
; CHECK-NEXT:    ret float [[OP]]
;
  %op = call float @llvm.pow.f32(float %arg0, float noundef %arg1)
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_log(float %arg) {
; CHECK-LABEL: @freeze_log(
; CHECK-NEXT:    [[ARG_FR:%.*]] = freeze float [[ARG:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call float @llvm.log.f32(float [[ARG_FR]])
; CHECK-NEXT:    ret float [[OP]]
;
  %op = call float @llvm.log.f32(float %arg)
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_log10(float %arg) {
; CHECK-LABEL: @freeze_log10(
; CHECK-NEXT:    [[ARG_FR:%.*]] = freeze float [[ARG:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call float @llvm.log10.f32(float [[ARG_FR]])
; CHECK-NEXT:    ret float [[OP]]
;
  %op = call float @llvm.log10.f32(float %arg)
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_log2(float %arg) {
; CHECK-LABEL: @freeze_log2(
; CHECK-NEXT:    [[ARG_FR:%.*]] = freeze float [[ARG:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call float @llvm.log2.f32(float [[ARG_FR]])
; CHECK-NEXT:    ret float [[OP]]
;
  %op = call float @llvm.log2.f32(float %arg)
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_exp(float %arg) {
; CHECK-LABEL: @freeze_exp(
; CHECK-NEXT:    [[ARG_FR:%.*]] = freeze float [[ARG:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call float @llvm.exp.f32(float [[ARG_FR]])
; CHECK-NEXT:    ret float [[OP]]
;
  %op = call float @llvm.exp.f32(float %arg)
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_exp2(float %arg) {
; CHECK-LABEL: @freeze_exp2(
; CHECK-NEXT:    [[ARG_FR:%.*]] = freeze float [[ARG:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call float @llvm.exp2.f32(float [[ARG_FR]])
; CHECK-NEXT:    ret float [[OP]]
;
  %op = call float @llvm.exp2.f32(float %arg)
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_fabs(float %arg) {
; CHECK-LABEL: @freeze_fabs(
; CHECK-NEXT:    [[ARG_FR:%.*]] = freeze float [[ARG:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call float @llvm.fabs.f32(float [[ARG_FR]])
; CHECK-NEXT:    ret float [[OP]]
;
  %op = call float @llvm.fabs.f32(float %arg)
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_copysign(float %arg0, float noundef %arg1) {
; CHECK-LABEL: @freeze_copysign(
; CHECK-NEXT:    [[ARG0_FR:%.*]] = freeze float [[ARG0:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call float @llvm.copysign.f32(float [[ARG0_FR]], float noundef [[ARG1:%.*]])
; CHECK-NEXT:    ret float [[OP]]
;
  %op = call float @llvm.copysign.f32(float %arg0, float noundef %arg1)
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_floor(float %arg) {
; CHECK-LABEL: @freeze_floor(
; CHECK-NEXT:    [[ARG_FR:%.*]] = freeze float [[ARG:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call float @llvm.floor.f32(float [[ARG_FR]])
; CHECK-NEXT:    ret float [[OP]]
;
  %op = call float @llvm.floor.f32(float %arg)
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_ceil(float %arg) {
; CHECK-LABEL: @freeze_ceil(
; CHECK-NEXT:    [[ARG_FR:%.*]] = freeze float [[ARG:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call float @llvm.ceil.f32(float [[ARG_FR]])
; CHECK-NEXT:    ret float [[OP]]
;
  %op = call float @llvm.ceil.f32(float %arg)
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_trunc(float %arg) {
; CHECK-LABEL: @freeze_trunc(
; CHECK-NEXT:    [[ARG_FR:%.*]] = freeze float [[ARG:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call float @llvm.trunc.f32(float [[ARG_FR]])
; CHECK-NEXT:    ret float [[OP]]
;
  %op = call float @llvm.trunc.f32(float %arg)
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_rint(float %arg) {
; CHECK-LABEL: @freeze_rint(
; CHECK-NEXT:    [[ARG_FR:%.*]] = freeze float [[ARG:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call float @llvm.rint.f32(float [[ARG_FR]])
; CHECK-NEXT:    ret float [[OP]]
;
  %op = call float @llvm.rint.f32(float %arg)
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_nearbyint(float %arg) {
; CHECK-LABEL: @freeze_nearbyint(
; CHECK-NEXT:    [[ARG_FR:%.*]] = freeze float [[ARG:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call float @llvm.nearbyint.f32(float [[ARG_FR]])
; CHECK-NEXT:    ret float [[OP]]
;
  %op = call float @llvm.nearbyint.f32(float %arg)
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_round(float %arg) {
; CHECK-LABEL: @freeze_round(
; CHECK-NEXT:    [[ARG_FR:%.*]] = freeze float [[ARG:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call float @llvm.round.f32(float [[ARG_FR]])
; CHECK-NEXT:    ret float [[OP]]
;
  %op = call float @llvm.round.f32(float %arg)
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_roundeven(float %arg) {
; CHECK-LABEL: @freeze_roundeven(
; CHECK-NEXT:    [[ARG_FR:%.*]] = freeze float [[ARG:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call float @llvm.roundeven.f32(float [[ARG_FR]])
; CHECK-NEXT:    ret float [[OP]]
;
  %op = call float @llvm.roundeven.f32(float %arg)
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_canonicalize(float %arg) {
; CHECK-LABEL: @freeze_canonicalize(
; CHECK-NEXT:    [[ARG_FR:%.*]] = freeze float [[ARG:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call float @llvm.canonicalize.f32(float [[ARG_FR]])
; CHECK-NEXT:    ret float [[OP]]
;
  %op = call float @llvm.canonicalize.f32(float %arg)
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_arithmetic_fence(float %arg) {
; CHECK-LABEL: @freeze_arithmetic_fence(
; CHECK-NEXT:    [[ARG_FR:%.*]] = freeze float [[ARG:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call float @llvm.arithmetic.fence.f32(float [[ARG_FR]])
; CHECK-NEXT:    ret float [[OP]]
;
  %op = call float @llvm.arithmetic.fence.f32(float %arg)
  %freeze = freeze float %op
  ret float %freeze
}

define i32 @freeze_lround(float %arg) {
; CHECK-LABEL: @freeze_lround(
; CHECK-NEXT:    [[ARG_FR:%.*]] = freeze float [[ARG:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call i32 @llvm.lround.i32.f32(float [[ARG_FR]])
; CHECK-NEXT:    ret i32 [[OP]]
;
  %op = call i32 @llvm.lround.i32.f32(float %arg)
  %freeze = freeze i32 %op
  ret i32 %freeze
}

define i32 @freeze_llround(float %arg) {
; CHECK-LABEL: @freeze_llround(
; CHECK-NEXT:    [[ARG_FR:%.*]] = freeze float [[ARG:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call i32 @llvm.llround.i32.f32(float [[ARG_FR]])
; CHECK-NEXT:    ret i32 [[OP]]
;
  %op = call i32 @llvm.llround.i32.f32(float %arg)
  %freeze = freeze i32 %op
  ret i32 %freeze
}

define i32 @freeze_lrint(float %arg) {
; CHECK-LABEL: @freeze_lrint(
; CHECK-NEXT:    [[ARG_FR:%.*]] = freeze float [[ARG:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call i32 @llvm.lrint.i32.f32(float [[ARG_FR]])
; CHECK-NEXT:    ret i32 [[OP]]
;
  %op = call i32 @llvm.lrint.i32.f32(float %arg)
  %freeze = freeze i32 %op
  ret i32 %freeze
}

define i32 @freeze_llrint(float %arg) {
; CHECK-LABEL: @freeze_llrint(
; CHECK-NEXT:    [[ARG_FR:%.*]] = freeze float [[ARG:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call i32 @llvm.llrint.i32.f32(float [[ARG_FR]])
; CHECK-NEXT:    ret i32 [[OP]]
;
  %op = call i32 @llvm.llrint.i32.f32(float %arg)
  %freeze = freeze i32 %op
  ret i32 %freeze
}

define i32 @freeze_noundef_lround(float %arg) {
; CHECK-LABEL: @freeze_noundef_lround(
; CHECK-NEXT:    [[OP:%.*]] = call noundef i32 @llvm.lround.i32.f32(float [[ARG:%.*]])
; CHECK-NEXT:    ret i32 [[OP]]
;
  %op = call noundef i32 @llvm.lround.i32.f32(float %arg)
  %freeze = freeze i32 %op
  ret i32 %freeze
}

define i32 @freeze_noundef_llround(float %arg) {
; CHECK-LABEL: @freeze_noundef_llround(
; CHECK-NEXT:    [[OP:%.*]] = call noundef i32 @llvm.llround.i32.f32(float [[ARG:%.*]])
; CHECK-NEXT:    ret i32 [[OP]]
;
  %op = call noundef i32 @llvm.llround.i32.f32(float %arg)
  %freeze = freeze i32 %op
  ret i32 %freeze
}

define i32 @freeze_noundef_lrint(float %arg) {
; CHECK-LABEL: @freeze_noundef_lrint(
; CHECK-NEXT:    [[OP:%.*]] = call noundef i32 @llvm.lrint.i32.f32(float [[ARG:%.*]])
; CHECK-NEXT:    ret i32 [[OP]]
;
  %op = call noundef i32 @llvm.lrint.i32.f32(float %arg)
  %freeze = freeze i32 %op
  ret i32 %freeze
}

define i32 @freeze_noundef_llrint(float %arg) {
; CHECK-LABEL: @freeze_noundef_llrint(
; CHECK-NEXT:    [[OP:%.*]] = call noundef i32 @llvm.llrint.i32.f32(float [[ARG:%.*]])
; CHECK-NEXT:    ret i32 [[OP]]
;
  %op = call noundef i32 @llvm.llrint.i32.f32(float %arg)
  %freeze = freeze i32 %op
  ret i32 %freeze
}

define float @freeze_minnum(float %arg0, float noundef %arg1) {
; CHECK-LABEL: @freeze_minnum(
; CHECK-NEXT:    [[ARG0_FR:%.*]] = freeze float [[ARG0:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call float @llvm.minnum.f32(float [[ARG0_FR]], float noundef [[ARG1:%.*]])
; CHECK-NEXT:    ret float [[OP]]
;
  %op = call float @llvm.minnum.f32(float %arg0, float noundef %arg1)
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_maxnum(float %arg0, float noundef %arg1) {
; CHECK-LABEL: @freeze_maxnum(
; CHECK-NEXT:    [[ARG0_FR:%.*]] = freeze float [[ARG0:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call float @llvm.maxnum.f32(float [[ARG0_FR]], float noundef [[ARG1:%.*]])
; CHECK-NEXT:    ret float [[OP]]
;
  %op = call float @llvm.maxnum.f32(float %arg0, float noundef %arg1)
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_minimum(float %arg0, float noundef %arg1) {
; CHECK-LABEL: @freeze_minimum(
; CHECK-NEXT:    [[ARG0_FR:%.*]] = freeze float [[ARG0:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call float @llvm.minimum.f32(float [[ARG0_FR]], float noundef [[ARG1:%.*]])
; CHECK-NEXT:    ret float [[OP]]
;
  %op = call float @llvm.minimum.f32(float %arg0, float noundef %arg1)
  %freeze = freeze float %op
  ret float %freeze
}

define float @freeze_maximum(float %arg0, float noundef %arg1) {
; CHECK-LABEL: @freeze_maximum(
; CHECK-NEXT:    [[ARG0_FR:%.*]] = freeze float [[ARG0:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call float @llvm.maximum.f32(float [[ARG0_FR]], float noundef [[ARG1:%.*]])
; CHECK-NEXT:    ret float [[OP]]
;
  %op = call float @llvm.maximum.f32(float %arg0, float noundef %arg1)
  %freeze = freeze float %op
  ret float %freeze
}

define i1 @freeze_isfpclass(float %arg0) {
; CHECK-LABEL: @freeze_isfpclass(
; CHECK-NEXT:    [[ARG0_FR:%.*]] = freeze float [[ARG0:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call i1 @llvm.is.fpclass.f32(float [[ARG0_FR]], i32 27)
; CHECK-NEXT:    ret i1 [[OP]]
;
  %op = call i1 @llvm.is.fpclass.f32(float %arg0, i32 27)
  %freeze = freeze i1 %op
  ret i1 %freeze
}

define float @freeze_fptrunc_round(double %arg0) {
; CHECK-LABEL: @freeze_fptrunc_round(
; CHECK-NEXT:    [[ARG0_FR:%.*]] = freeze double [[ARG0:%.*]]
; CHECK-NEXT:    [[OP:%.*]] = call float @llvm.fptrunc.round.f32.f64(double [[ARG0_FR]], metadata !"round.downward")
; CHECK-NEXT:    ret float [[OP]]
;
  %op = call float @llvm.fptrunc.round.f32.f64(double %arg0, metadata !"round.downward")
  %freeze = freeze float %op
  ret float %freeze
}

declare float @llvm.fma.f32(float, float, float)
declare float @llvm.fmuladd.f32(float, float, float)
declare float @llvm.sqrt.f32(float)
declare float @llvm.powi.f32.i32(float, i32)
declare float @llvm.sin.f32(float)
declare float @llvm.cos.f32(float)
declare float @llvm.pow.f32(float, float)
declare float @llvm.log.f32(float)
declare float @llvm.log10.f32(float)
declare float @llvm.log2.f32(float)
declare float @llvm.exp.f32(float)
declare float @llvm.exp2.f32(float)
declare float @llvm.fabs.f32(float)
declare float @llvm.copysign.f32(float, float)
declare float @llvm.floor.f32(float)
declare float @llvm.ceil.f32(float)
declare float @llvm.trunc.f32(float)
declare float @llvm.rint.f32(float)
declare float @llvm.nearbyint.f32(float)
declare float @llvm.round.f32(float)
declare float @llvm.roundeven.f32(float)
declare float @llvm.canonicalize.f32(float)
declare float @llvm.arithmetic.fence.f32(float)
declare i32 @llvm.lround.i32.f32(float)
declare i32 @llvm.llround.i32.f32(float)
declare i32 @llvm.lrint.i32.f32(float)
declare i32 @llvm.llrint.i32.f32(float)
declare float @llvm.minnum.f32(float, float)
declare float @llvm.maxnum.f32(float, float)
declare float @llvm.minimum.f32(float, float)
declare float @llvm.maximum.f32(float, float)
declare i1 @llvm.is.fpclass.f32(float, i32 immarg)
declare float @llvm.fptrunc.round.f32.f64(double, metadata)
