; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -O0 -mtriple=mipsel-linux-gnu -global-isel -mcpu=mips32r5 -mattr=+msa,+fp64,+nan2008 -verify-machineinstrs %s -o -| FileCheck %s -check-prefixes=P5600

declare <4 x float> @llvm.mips.fmax.a.w(<4 x float>, <4 x float>)
define void @fabs_v4f32_builtin(ptr %a, ptr %c) {
; P5600-LABEL: fabs_v4f32_builtin:
; P5600:       # %bb.0: # %entry
; P5600-NEXT:    ld.w $w0, 0($4)
; P5600-NEXT:    fmax_a.w $w0, $w0, $w0
; P5600-NEXT:    st.w $w0, 0($5)
; P5600-NEXT:    jr $ra
; P5600-NEXT:    nop
entry:
  %0 = load <4 x float>, ptr %a, align 16
  %1 = tail call <4 x float> @llvm.mips.fmax.a.w(<4 x float> %0, <4 x float> %0)
  store <4 x float> %1, ptr %c, align 16
  ret void
}


declare <2 x double> @llvm.mips.fmax.a.d(<2 x double>, <2 x double>)
define void @fabs_v2f64_builtin(ptr %a, ptr %c) {
; P5600-LABEL: fabs_v2f64_builtin:
; P5600:       # %bb.0: # %entry
; P5600-NEXT:    ld.d $w0, 0($4)
; P5600-NEXT:    fmax_a.d $w0, $w0, $w0
; P5600-NEXT:    st.d $w0, 0($5)
; P5600-NEXT:    jr $ra
; P5600-NEXT:    nop
entry:
  %0 = load <2 x double>, ptr %a, align 16
  %1 = tail call <2 x double> @llvm.mips.fmax.a.d(<2 x double> %0, <2 x double> %0)
  store <2 x double> %1, ptr %c, align 16
  ret void
}
