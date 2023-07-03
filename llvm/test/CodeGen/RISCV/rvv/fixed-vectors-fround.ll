; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+experimental-zvfh,+v -target-abi=ilp32d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+experimental-zvfh,+v -target-abi=lp64d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s

; This file tests the code generation for `llvm.round.*` on fixed vector type.

define <1 x half> @round_v1f16(<1 x half> %x) {
; CHECK-LABEL: round_v1f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI0_0)
; CHECK-NEXT:    flh ft0, %lo(.LCPI0_0)(a0)
; CHECK-NEXT:    vsetivli zero, 1, e16, mf4, ta, ma
; CHECK-NEXT:    vfabs.v v9, v8
; CHECK-NEXT:    vmflt.vf v0, v9, ft0
; CHECK-NEXT:    fsrmi a0, 4
; CHECK-NEXT:    vfcvt.x.f.v v9, v8, v0.t
; CHECK-NEXT:    fsrm a0
; CHECK-NEXT:    vfcvt.f.x.v v9, v9, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e16, mf4, ta, mu
; CHECK-NEXT:    vfsgnj.vv v8, v9, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <1 x half> @llvm.round.v1f16(<1 x half> %x)
  ret <1 x half> %a
}
declare <1 x half> @llvm.round.v1f16(<1 x half>)

define <2 x half> @round_v2f16(<2 x half> %x) {
; CHECK-LABEL: round_v2f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI1_0)
; CHECK-NEXT:    flh ft0, %lo(.LCPI1_0)(a0)
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vfabs.v v9, v8
; CHECK-NEXT:    vmflt.vf v0, v9, ft0
; CHECK-NEXT:    fsrmi a0, 4
; CHECK-NEXT:    vfcvt.x.f.v v9, v8, v0.t
; CHECK-NEXT:    fsrm a0
; CHECK-NEXT:    vfcvt.f.x.v v9, v9, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e16, mf4, ta, mu
; CHECK-NEXT:    vfsgnj.vv v8, v9, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <2 x half> @llvm.round.v2f16(<2 x half> %x)
  ret <2 x half> %a
}
declare <2 x half> @llvm.round.v2f16(<2 x half>)

define <4 x half> @round_v4f16(<4 x half> %x) {
; CHECK-LABEL: round_v4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI2_0)
; CHECK-NEXT:    flh ft0, %lo(.LCPI2_0)(a0)
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vfabs.v v9, v8
; CHECK-NEXT:    vmflt.vf v0, v9, ft0
; CHECK-NEXT:    fsrmi a0, 4
; CHECK-NEXT:    vfcvt.x.f.v v9, v8, v0.t
; CHECK-NEXT:    fsrm a0
; CHECK-NEXT:    vfcvt.f.x.v v9, v9, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e16, mf2, ta, mu
; CHECK-NEXT:    vfsgnj.vv v8, v9, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <4 x half> @llvm.round.v4f16(<4 x half> %x)
  ret <4 x half> %a
}
declare <4 x half> @llvm.round.v4f16(<4 x half>)

define <8 x half> @round_v8f16(<8 x half> %x) {
; CHECK-LABEL: round_v8f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI3_0)
; CHECK-NEXT:    flh ft0, %lo(.LCPI3_0)(a0)
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vfabs.v v9, v8
; CHECK-NEXT:    vmflt.vf v0, v9, ft0
; CHECK-NEXT:    fsrmi a0, 4
; CHECK-NEXT:    vfcvt.x.f.v v9, v8, v0.t
; CHECK-NEXT:    fsrm a0
; CHECK-NEXT:    vfcvt.f.x.v v9, v9, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e16, m1, ta, mu
; CHECK-NEXT:    vfsgnj.vv v8, v9, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <8 x half> @llvm.round.v8f16(<8 x half> %x)
  ret <8 x half> %a
}
declare <8 x half> @llvm.round.v8f16(<8 x half>)

define <16 x half> @round_v16f16(<16 x half> %x) {
; CHECK-LABEL: round_v16f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI4_0)
; CHECK-NEXT:    flh ft0, %lo(.LCPI4_0)(a0)
; CHECK-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; CHECK-NEXT:    vfabs.v v10, v8
; CHECK-NEXT:    vmflt.vf v0, v10, ft0
; CHECK-NEXT:    fsrmi a0, 4
; CHECK-NEXT:    vfcvt.x.f.v v10, v8, v0.t
; CHECK-NEXT:    fsrm a0
; CHECK-NEXT:    vfcvt.f.x.v v10, v10, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e16, m2, ta, mu
; CHECK-NEXT:    vfsgnj.vv v8, v10, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <16 x half> @llvm.round.v16f16(<16 x half> %x)
  ret <16 x half> %a
}
declare <16 x half> @llvm.round.v16f16(<16 x half>)

define <32 x half> @round_v32f16(<32 x half> %x) {
; CHECK-LABEL: round_v32f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI5_0)
; CHECK-NEXT:    flh ft0, %lo(.LCPI5_0)(a0)
; CHECK-NEXT:    li a0, 32
; CHECK-NEXT:    vsetvli zero, a0, e16, m4, ta, ma
; CHECK-NEXT:    vfabs.v v12, v8
; CHECK-NEXT:    vmflt.vf v0, v12, ft0
; CHECK-NEXT:    fsrmi a0, 4
; CHECK-NEXT:    vfcvt.x.f.v v12, v8, v0.t
; CHECK-NEXT:    fsrm a0
; CHECK-NEXT:    vfcvt.f.x.v v12, v12, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e16, m4, ta, mu
; CHECK-NEXT:    vfsgnj.vv v8, v12, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <32 x half> @llvm.round.v32f16(<32 x half> %x)
  ret <32 x half> %a
}
declare <32 x half> @llvm.round.v32f16(<32 x half>)

define <1 x float> @round_v1f32(<1 x float> %x) {
; CHECK-LABEL: round_v1f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI6_0)
; CHECK-NEXT:    flw ft0, %lo(.LCPI6_0)(a0)
; CHECK-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; CHECK-NEXT:    vfabs.v v9, v8
; CHECK-NEXT:    vmflt.vf v0, v9, ft0
; CHECK-NEXT:    fsrmi a0, 4
; CHECK-NEXT:    vfcvt.x.f.v v9, v8, v0.t
; CHECK-NEXT:    fsrm a0
; CHECK-NEXT:    vfcvt.f.x.v v9, v9, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e32, mf2, ta, mu
; CHECK-NEXT:    vfsgnj.vv v8, v9, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <1 x float> @llvm.round.v1f32(<1 x float> %x)
  ret <1 x float> %a
}
declare <1 x float> @llvm.round.v1f32(<1 x float>)

define <2 x float> @round_v2f32(<2 x float> %x) {
; CHECK-LABEL: round_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI7_0)
; CHECK-NEXT:    flw ft0, %lo(.LCPI7_0)(a0)
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vfabs.v v9, v8
; CHECK-NEXT:    vmflt.vf v0, v9, ft0
; CHECK-NEXT:    fsrmi a0, 4
; CHECK-NEXT:    vfcvt.x.f.v v9, v8, v0.t
; CHECK-NEXT:    fsrm a0
; CHECK-NEXT:    vfcvt.f.x.v v9, v9, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e32, mf2, ta, mu
; CHECK-NEXT:    vfsgnj.vv v8, v9, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <2 x float> @llvm.round.v2f32(<2 x float> %x)
  ret <2 x float> %a
}
declare <2 x float> @llvm.round.v2f32(<2 x float>)

define <4 x float> @round_v4f32(<4 x float> %x) {
; CHECK-LABEL: round_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI8_0)
; CHECK-NEXT:    flw ft0, %lo(.LCPI8_0)(a0)
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vfabs.v v9, v8
; CHECK-NEXT:    vmflt.vf v0, v9, ft0
; CHECK-NEXT:    fsrmi a0, 4
; CHECK-NEXT:    vfcvt.x.f.v v9, v8, v0.t
; CHECK-NEXT:    fsrm a0
; CHECK-NEXT:    vfcvt.f.x.v v9, v9, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e32, m1, ta, mu
; CHECK-NEXT:    vfsgnj.vv v8, v9, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <4 x float> @llvm.round.v4f32(<4 x float> %x)
  ret <4 x float> %a
}
declare <4 x float> @llvm.round.v4f32(<4 x float>)

define <8 x float> @round_v8f32(<8 x float> %x) {
; CHECK-LABEL: round_v8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI9_0)
; CHECK-NEXT:    flw ft0, %lo(.LCPI9_0)(a0)
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vfabs.v v10, v8
; CHECK-NEXT:    vmflt.vf v0, v10, ft0
; CHECK-NEXT:    fsrmi a0, 4
; CHECK-NEXT:    vfcvt.x.f.v v10, v8, v0.t
; CHECK-NEXT:    fsrm a0
; CHECK-NEXT:    vfcvt.f.x.v v10, v10, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e32, m2, ta, mu
; CHECK-NEXT:    vfsgnj.vv v8, v10, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <8 x float> @llvm.round.v8f32(<8 x float> %x)
  ret <8 x float> %a
}
declare <8 x float> @llvm.round.v8f32(<8 x float>)

define <16 x float> @round_v16f32(<16 x float> %x) {
; CHECK-LABEL: round_v16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI10_0)
; CHECK-NEXT:    flw ft0, %lo(.LCPI10_0)(a0)
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vfabs.v v12, v8
; CHECK-NEXT:    vmflt.vf v0, v12, ft0
; CHECK-NEXT:    fsrmi a0, 4
; CHECK-NEXT:    vfcvt.x.f.v v12, v8, v0.t
; CHECK-NEXT:    fsrm a0
; CHECK-NEXT:    vfcvt.f.x.v v12, v12, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e32, m4, ta, mu
; CHECK-NEXT:    vfsgnj.vv v8, v12, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <16 x float> @llvm.round.v16f32(<16 x float> %x)
  ret <16 x float> %a
}
declare <16 x float> @llvm.round.v16f32(<16 x float>)

define <1 x double> @round_v1f64(<1 x double> %x) {
; CHECK-LABEL: round_v1f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI11_0)
; CHECK-NEXT:    fld ft0, %lo(.LCPI11_0)(a0)
; CHECK-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; CHECK-NEXT:    vfabs.v v9, v8
; CHECK-NEXT:    vmflt.vf v0, v9, ft0
; CHECK-NEXT:    fsrmi a0, 4
; CHECK-NEXT:    vfcvt.x.f.v v9, v8, v0.t
; CHECK-NEXT:    fsrm a0
; CHECK-NEXT:    vfcvt.f.x.v v9, v9, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e64, m1, ta, mu
; CHECK-NEXT:    vfsgnj.vv v8, v9, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <1 x double> @llvm.round.v1f64(<1 x double> %x)
  ret <1 x double> %a
}
declare <1 x double> @llvm.round.v1f64(<1 x double>)

define <2 x double> @round_v2f64(<2 x double> %x) {
; CHECK-LABEL: round_v2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI12_0)
; CHECK-NEXT:    fld ft0, %lo(.LCPI12_0)(a0)
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vfabs.v v9, v8
; CHECK-NEXT:    vmflt.vf v0, v9, ft0
; CHECK-NEXT:    fsrmi a0, 4
; CHECK-NEXT:    vfcvt.x.f.v v9, v8, v0.t
; CHECK-NEXT:    fsrm a0
; CHECK-NEXT:    vfcvt.f.x.v v9, v9, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e64, m1, ta, mu
; CHECK-NEXT:    vfsgnj.vv v8, v9, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <2 x double> @llvm.round.v2f64(<2 x double> %x)
  ret <2 x double> %a
}
declare <2 x double> @llvm.round.v2f64(<2 x double>)

define <4 x double> @round_v4f64(<4 x double> %x) {
; CHECK-LABEL: round_v4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI13_0)
; CHECK-NEXT:    fld ft0, %lo(.LCPI13_0)(a0)
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vfabs.v v10, v8
; CHECK-NEXT:    vmflt.vf v0, v10, ft0
; CHECK-NEXT:    fsrmi a0, 4
; CHECK-NEXT:    vfcvt.x.f.v v10, v8, v0.t
; CHECK-NEXT:    fsrm a0
; CHECK-NEXT:    vfcvt.f.x.v v10, v10, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e64, m2, ta, mu
; CHECK-NEXT:    vfsgnj.vv v8, v10, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <4 x double> @llvm.round.v4f64(<4 x double> %x)
  ret <4 x double> %a
}
declare <4 x double> @llvm.round.v4f64(<4 x double>)

define <8 x double> @round_v8f64(<8 x double> %x) {
; CHECK-LABEL: round_v8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI14_0)
; CHECK-NEXT:    fld ft0, %lo(.LCPI14_0)(a0)
; CHECK-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; CHECK-NEXT:    vfabs.v v12, v8
; CHECK-NEXT:    vmflt.vf v0, v12, ft0
; CHECK-NEXT:    fsrmi a0, 4
; CHECK-NEXT:    vfcvt.x.f.v v12, v8, v0.t
; CHECK-NEXT:    fsrm a0
; CHECK-NEXT:    vfcvt.f.x.v v12, v12, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e64, m4, ta, mu
; CHECK-NEXT:    vfsgnj.vv v8, v12, v8, v0.t
; CHECK-NEXT:    ret
  %a = call <8 x double> @llvm.round.v8f64(<8 x double> %x)
  ret <8 x double> %a
}
declare <8 x double> @llvm.round.v8f64(<8 x double>)
