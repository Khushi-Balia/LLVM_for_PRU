; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s --mattr=+complxnum,+neon,+fullfp16 -o - | FileCheck %s

target triple = "aarch64-arm-none-eabi"


; Expected to transform
define <2 x float> @complex_add_v2f32(<2 x float> %a, <2 x float> %b) {
; CHECK-LABEL: complex_add_v2f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcadd v0.2s, v1.2s, v0.2s, #90
; CHECK-NEXT:    ret
entry:
  %a.real = shufflevector <2 x float> %a, <2 x float> zeroinitializer, <1 x i32> <i32 0>
  %a.imag = shufflevector <2 x float> %a, <2 x float> zeroinitializer, <1 x i32> <i32 1>
  %b.real = shufflevector <2 x float> %b, <2 x float> zeroinitializer, <1 x i32> <i32 0>
  %b.imag = shufflevector <2 x float> %b, <2 x float> zeroinitializer, <1 x i32> <i32 1>
  %0 = fsub fast <1 x float> %b.real, %a.imag
  %1 = fadd fast <1 x float> %b.imag, %a.real
  %interleaved.vec = shufflevector <1 x float> %0, <1 x float> %1, <2 x i32> <i32 0, i32 1>
  ret <2 x float> %interleaved.vec
}

; Expected to transform
define <4 x float> @complex_add_v4f32(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: complex_add_v4f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcadd v0.4s, v1.4s, v0.4s, #90
; CHECK-NEXT:    ret
entry:
  %a.real = shufflevector <4 x float> %a, <4 x float> zeroinitializer, <2 x i32> <i32 0, i32 2>
  %a.imag = shufflevector <4 x float> %a, <4 x float> zeroinitializer, <2 x i32> <i32 1, i32 3>
  %b.real = shufflevector <4 x float> %b, <4 x float> zeroinitializer, <2 x i32> <i32 0, i32 2>
  %b.imag = shufflevector <4 x float> %b, <4 x float> zeroinitializer, <2 x i32> <i32 1, i32 3>
  %0 = fsub fast <2 x float> %b.real, %a.imag
  %1 = fadd fast <2 x float> %b.imag, %a.real
  %interleaved.vec = shufflevector <2 x float> %0, <2 x float> %1, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
  ret <4 x float> %interleaved.vec
}

; Expected to transform
define <8 x float> @complex_add_v8f32(<8 x float> %a, <8 x float> %b) {
; CHECK-LABEL: complex_add_v8f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcadd v0.4s, v2.4s, v0.4s, #90
; CHECK-NEXT:    fcadd v1.4s, v3.4s, v1.4s, #90
; CHECK-NEXT:    ret
entry:
  %a.real = shufflevector <8 x float> %a, <8 x float> zeroinitializer, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  %a.imag = shufflevector <8 x float> %a, <8 x float> zeroinitializer, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
  %b.real = shufflevector <8 x float> %b, <8 x float> zeroinitializer, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  %b.imag = shufflevector <8 x float> %b, <8 x float> zeroinitializer, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
  %0 = fsub fast <4 x float> %b.real, %a.imag
  %1 = fadd fast <4 x float> %b.imag, %a.real
  %interleaved.vec = shufflevector <4 x float> %0, <4 x float> %1, <8 x i32> <i32 0, i32 4, i32 1, i32 5, i32 2, i32 6, i32 3, i32 7>
  ret <8 x float> %interleaved.vec
}

; Expected to transform
define <16 x float> @complex_add_v16f32(<16 x float> %a, <16 x float> %b) {
; CHECK-LABEL: complex_add_v16f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcadd v2.4s, v6.4s, v2.4s, #90
; CHECK-NEXT:    fcadd v0.4s, v4.4s, v0.4s, #90
; CHECK-NEXT:    fcadd v1.4s, v5.4s, v1.4s, #90
; CHECK-NEXT:    fcadd v3.4s, v7.4s, v3.4s, #90
; CHECK-NEXT:    ret
entry:
  %a.real = shufflevector <16 x float> %a, <16 x float> zeroinitializer, <8 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14>
  %a.imag = shufflevector <16 x float> %a, <16 x float> zeroinitializer, <8 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15>
  %b.real = shufflevector <16 x float> %b, <16 x float> zeroinitializer, <8 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14>
  %b.imag = shufflevector <16 x float> %b, <16 x float> zeroinitializer, <8 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15>
  %0 = fsub fast <8 x float> %b.real, %a.imag
  %1 = fadd fast <8 x float> %b.imag, %a.real
  %interleaved.vec = shufflevector <8 x float> %0, <8 x float> %1, <16 x i32> <i32 0, i32 8, i32 1, i32 9, i32 2, i32 10, i32 3, i32 11, i32 4, i32 12, i32 5, i32 13, i32 6, i32 14, i32 7, i32 15>
  ret <16 x float> %interleaved.vec
}
