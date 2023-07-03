; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=+vpu | FileCheck %s

declare <256 x i64> @llvm.vp.gather.v256i64.v256p0(<256 x ptr>, <256 x i1>, i32)

; Function Attrs: nounwind
define fastcc <256 x i64> @vp_gather_v256i64(<256 x ptr> %P, <256 x i1> %M, i32 %avl) {
; CHECK-LABEL: vp_gather_v256i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vgt %v0, %v0, 0, 0, %vm1
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call <256 x i64> @llvm.vp.gather.v256i64.v256p0(<256 x ptr> %P, <256 x i1> %M, i32 %avl)
  ret <256 x i64> %r
}

declare <256 x double> @llvm.vp.gather.v256f64.v256p0(<256 x ptr>, <256 x i1>, i32)

; Function Attrs: nounwind
define fastcc <256 x double> @vp_gather_v256f64(<256 x ptr> %P, <256 x i1> %M, i32 %avl) {
; CHECK-LABEL: vp_gather_v256f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vgt %v0, %v0, 0, 0, %vm1
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call <256 x double> @llvm.vp.gather.v256f64.v256p0(<256 x ptr> %P, <256 x i1> %M, i32 %avl)
  ret <256 x double> %r
}

declare <256 x float> @llvm.vp.gather.v256f32.v256p0(<256 x ptr>, <256 x i1>, i32)

; Function Attrs: nounwind
define fastcc <256 x float> @vp_gather_v256f32(<256 x ptr> %P, <256 x i1> %M, i32 %avl) {
; CHECK-LABEL: vp_gather_v256f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vgtu %v0, %v0, 0, 0, %vm1
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call <256 x float> @llvm.vp.gather.v256f32.v256p0(<256 x ptr> %P, <256 x i1> %M, i32 %avl)
  ret <256 x float> %r
}

declare <256 x i32> @llvm.vp.gather.v256i32.v256p0(<256 x ptr>, <256 x i1>, i32)

; Function Attrs: nounwind
define fastcc <256 x i32> @vp_gather_v256i32(<256 x ptr> %P, <256 x i1> %M, i32 %avl) {
; CHECK-LABEL: vp_gather_v256i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vgtl.zx %v0, %v0, 0, 0, %vm1
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call <256 x i32> @llvm.vp.gather.v256i32.v256p0(<256 x ptr> %P, <256 x i1> %M, i32 %avl)
  ret <256 x i32> %r
}
