; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve -asm-verbose=1 < %s | FileCheck %s

;
; LD1B
;

define <vscale x 16 x i32> @masked_ld1b_i8_sext_i32(<vscale x 16 x i8> *%base, <vscale x 16 x i1> %mask) {
; CHECK-LABEL: masked_ld1b_i8_sext_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1b { z0.b }, p0/z, [x0]
; CHECK-NEXT:    sunpklo z1.h, z0.b
; CHECK-NEXT:    sunpkhi z3.h, z0.b
; CHECK-NEXT:    sunpklo z0.s, z1.h
; CHECK-NEXT:    sunpkhi z1.s, z1.h
; CHECK-NEXT:    sunpklo z2.s, z3.h
; CHECK-NEXT:    sunpkhi z3.s, z3.h
; CHECK-NEXT:    ret
  %wide.masked.load = call <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(<vscale x 16 x i8>* %base, i32 2, <vscale x 16 x i1> %mask, <vscale x 16 x i8> undef)
  %res = sext <vscale x 16 x i8> %wide.masked.load to <vscale x 16 x i32>
  ret <vscale x 16 x i32> %res
}

define <vscale x 16 x i32> @masked_ld1b_i8_zext_i32(<vscale x 16 x i8> *%base, <vscale x 16 x i1> %mask) {
; CHECK-LABEL: masked_ld1b_i8_zext_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1b { z0.b }, p0/z, [x0]
; CHECK-NEXT:    uunpklo z1.h, z0.b
; CHECK-NEXT:    uunpkhi z3.h, z0.b
; CHECK-NEXT:    uunpklo z0.s, z1.h
; CHECK-NEXT:    uunpkhi z1.s, z1.h
; CHECK-NEXT:    uunpklo z2.s, z3.h
; CHECK-NEXT:    uunpkhi z3.s, z3.h
; CHECK-NEXT:    ret
  %wide.masked.load = call <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(<vscale x 16 x i8>* %base, i32 2, <vscale x 16 x i1> %mask, <vscale x 16 x i8> undef)
  %res = zext <vscale x 16 x i8> %wide.masked.load to <vscale x 16 x i32>
  ret <vscale x 16 x i32> %res
}

define <vscale x 16 x i64> @masked_ld1b_i8_sext(<vscale x 16 x i8> *%base, <vscale x 16 x i1> %mask) {
; CHECK-LABEL: masked_ld1b_i8_sext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1b { z0.b }, p0/z, [x0]
; CHECK-NEXT:    sunpklo z1.h, z0.b
; CHECK-NEXT:    sunpkhi z0.h, z0.b
; CHECK-NEXT:    sunpklo z2.s, z1.h
; CHECK-NEXT:    sunpkhi z3.s, z1.h
; CHECK-NEXT:    sunpklo z5.s, z0.h
; CHECK-NEXT:    sunpkhi z7.s, z0.h
; CHECK-NEXT:    sunpklo z0.d, z2.s
; CHECK-NEXT:    sunpkhi z1.d, z2.s
; CHECK-NEXT:    sunpklo z2.d, z3.s
; CHECK-NEXT:    sunpkhi z3.d, z3.s
; CHECK-NEXT:    sunpklo z4.d, z5.s
; CHECK-NEXT:    sunpkhi z5.d, z5.s
; CHECK-NEXT:    sunpklo z6.d, z7.s
; CHECK-NEXT:    sunpkhi z7.d, z7.s
; CHECK-NEXT:    ret
  %wide.masked.load = call <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(<vscale x 16 x i8>* %base, i32 2, <vscale x 16 x i1> %mask, <vscale x 16 x i8> undef)
  %res = sext <vscale x 16 x i8> %wide.masked.load to <vscale x 16 x i64>
  ret <vscale x 16 x i64> %res
}

define <vscale x 16 x i64> @masked_ld1b_i8_zext(<vscale x 16 x i8> *%base, <vscale x 16 x i1> %mask) {
; CHECK-LABEL: masked_ld1b_i8_zext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1b { z0.b }, p0/z, [x0]
; CHECK-NEXT:    uunpklo z1.h, z0.b
; CHECK-NEXT:    uunpkhi z0.h, z0.b
; CHECK-NEXT:    uunpklo z2.s, z1.h
; CHECK-NEXT:    uunpkhi z3.s, z1.h
; CHECK-NEXT:    uunpklo z5.s, z0.h
; CHECK-NEXT:    uunpkhi z7.s, z0.h
; CHECK-NEXT:    uunpklo z0.d, z2.s
; CHECK-NEXT:    uunpkhi z1.d, z2.s
; CHECK-NEXT:    uunpklo z2.d, z3.s
; CHECK-NEXT:    uunpkhi z3.d, z3.s
; CHECK-NEXT:    uunpklo z4.d, z5.s
; CHECK-NEXT:    uunpkhi z5.d, z5.s
; CHECK-NEXT:    uunpklo z6.d, z7.s
; CHECK-NEXT:    uunpkhi z7.d, z7.s
; CHECK-NEXT:    ret
  %wide.masked.load = call <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(<vscale x 16 x i8>* %base, i32 2, <vscale x 16 x i1> %mask, <vscale x 16 x i8> undef)
  %res = zext <vscale x 16 x i8> %wide.masked.load to <vscale x 16 x i64>
  ret <vscale x 16 x i64> %res
}

;
; LD1H
;

define <vscale x 8 x i64> @masked_ld1h_i16_sext(<vscale x 8 x i16> *%base, <vscale x 8 x i1> %mask) {
; CHECK-LABEL: masked_ld1h_i16_sext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1h { z0.h }, p0/z, [x0]
; CHECK-NEXT:    sunpklo z1.s, z0.h
; CHECK-NEXT:    sunpkhi z3.s, z0.h
; CHECK-NEXT:    sunpklo z0.d, z1.s
; CHECK-NEXT:    sunpkhi z1.d, z1.s
; CHECK-NEXT:    sunpklo z2.d, z3.s
; CHECK-NEXT:    sunpkhi z3.d, z3.s
; CHECK-NEXT:    ret
  %wide.masked.load = call <vscale x 8 x i16> @llvm.masked.load.nxv8i16.p0(<vscale x 8 x i16>* %base, i32 2, <vscale x 8 x i1> %mask, <vscale x 8 x i16> undef)
  %res = sext <vscale x 8 x i16> %wide.masked.load to <vscale x 8 x i64>
  ret <vscale x 8 x i64> %res
}

define <vscale x 8 x i64> @masked_ld1h_i16_zext(<vscale x 8 x i16> *%base, <vscale x 8 x i1> %mask) {
; CHECK-LABEL: masked_ld1h_i16_zext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1h { z0.h }, p0/z, [x0]
; CHECK-NEXT:    uunpklo z1.s, z0.h
; CHECK-NEXT:    uunpkhi z3.s, z0.h
; CHECK-NEXT:    uunpklo z0.d, z1.s
; CHECK-NEXT:    uunpkhi z1.d, z1.s
; CHECK-NEXT:    uunpklo z2.d, z3.s
; CHECK-NEXT:    uunpkhi z3.d, z3.s
; CHECK-NEXT:    ret
  %wide.masked.load = call <vscale x 8 x i16> @llvm.masked.load.nxv8i16.p0(<vscale x 8 x i16>* %base, i32 2, <vscale x 8 x i1> %mask, <vscale x 8 x i16> undef)
  %res = zext <vscale x 8 x i16> %wide.masked.load to <vscale x 8 x i64>
  ret <vscale x 8 x i64> %res
}

;
; LD1W
;

define <vscale x 4 x i64> @masked_ld1w_i32_sext(<vscale x 4 x i32> *%base, <vscale x 4 x i1> %mask) {
; CHECK-LABEL: masked_ld1w_i32_sext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1w { z1.s }, p0/z, [x0]
; CHECK-NEXT:    sunpklo z0.d, z1.s
; CHECK-NEXT:    sunpkhi z1.d, z1.s
; CHECK-NEXT:    ret
  %wide.masked.load = call <vscale x 4 x i32> @llvm.masked.load.nxv4i32.p0(<vscale x 4 x i32>* %base, i32 4, <vscale x 4 x i1> %mask, <vscale x 4 x i32> undef)
  %res = sext <vscale x 4 x i32> %wide.masked.load to <vscale x 4 x i64>
  ret <vscale x 4 x i64> %res
}

define <vscale x 4 x i64> @masked_ld1w_i32_zext(<vscale x 4 x i32> *%base, <vscale x 4 x i1> %mask) {
; CHECK-LABEL: masked_ld1w_i32_zext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ld1w { z1.s }, p0/z, [x0]
; CHECK-NEXT:    uunpklo z0.d, z1.s
; CHECK-NEXT:    uunpkhi z1.d, z1.s
; CHECK-NEXT:    ret
  %wide.masked.load = call <vscale x 4 x i32> @llvm.masked.load.nxv4i32.p0(<vscale x 4 x i32>* %base, i32 4, <vscale x 4 x i1> %mask, <vscale x 4 x i32> undef)
  %res = zext <vscale x 4 x i32> %wide.masked.load to <vscale x 4 x i64>
  ret <vscale x 4 x i64> %res
}

declare <vscale x 16 x i8> @llvm.masked.load.nxv16i8.p0(<vscale x 16 x i8>*, i32 immarg, <vscale x 16 x i1>, <vscale x 16 x i8>)
declare <vscale x 8 x i16> @llvm.masked.load.nxv8i16.p0(<vscale x 8 x i16>*, i32 immarg, <vscale x 8 x i1>, <vscale x 8 x i16>)
declare <vscale x 4 x i32> @llvm.masked.load.nxv4i32.p0(<vscale x 4 x i32>*, i32 immarg, <vscale x 4 x i1>, <vscale x 4 x i32>)

