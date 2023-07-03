; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-none-linux-gnu -mattr=+neon < %s -o -| FileCheck %s

define <8 x i16> @smull_v8i8_v8i16(ptr %A, ptr %B) nounwind {
; CHECK-LABEL: smull_v8i8_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    smull v0.8h, v0.8b, v1.8b
; CHECK-NEXT:    ret
  %tmp1 = load <8 x i8>, ptr %A
  %tmp2 = load <8 x i8>, ptr %B
  %tmp3 = sext <8 x i8> %tmp1 to <8 x i16>
  %tmp4 = sext <8 x i8> %tmp2 to <8 x i16>
  %tmp5 = mul <8 x i16> %tmp3, %tmp4
  ret <8 x i16> %tmp5
}

define <4 x i32> @smull_v4i16_v4i32(ptr %A, ptr %B) nounwind {
; CHECK-LABEL: smull_v4i16_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    smull v0.4s, v0.4h, v1.4h
; CHECK-NEXT:    ret
  %tmp1 = load <4 x i16>, ptr %A
  %tmp2 = load <4 x i16>, ptr %B
  %tmp3 = sext <4 x i16> %tmp1 to <4 x i32>
  %tmp4 = sext <4 x i16> %tmp2 to <4 x i32>
  %tmp5 = mul <4 x i32> %tmp3, %tmp4
  ret <4 x i32> %tmp5
}

define <2 x i64> @smull_v2i32_v2i64(ptr %A, ptr %B) nounwind {
; CHECK-LABEL: smull_v2i32_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    smull v0.2d, v0.2s, v1.2s
; CHECK-NEXT:    ret
  %tmp1 = load <2 x i32>, ptr %A
  %tmp2 = load <2 x i32>, ptr %B
  %tmp3 = sext <2 x i32> %tmp1 to <2 x i64>
  %tmp4 = sext <2 x i32> %tmp2 to <2 x i64>
  %tmp5 = mul <2 x i64> %tmp3, %tmp4
  ret <2 x i64> %tmp5
}

define <8 x i32> @smull_zext_v8i8_v8i32(ptr %A, ptr %B) nounwind {
; CHECK-LABEL: smull_zext_v8i8_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ldr q2, [x1]
; CHECK-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-NEXT:    smull2 v1.4s, v0.8h, v2.8h
; CHECK-NEXT:    smull v0.4s, v0.4h, v2.4h
; CHECK-NEXT:    ret
  %load.A = load <8 x i8>, ptr %A
  %load.B = load <8 x i16>, ptr %B
  %zext.A = zext <8 x i8> %load.A to <8 x i32>
  %sext.B = sext <8 x i16> %load.B to <8 x i32>
  %res = mul <8 x i32> %zext.A, %sext.B
  ret <8 x i32> %res
}

define <8 x i32> @smull_zext_v8i8_v8i32_sext_first_operand(ptr %A, ptr %B) nounwind {
; CHECK-LABEL: smull_zext_v8i8_v8i32_sext_first_operand:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x1]
; CHECK-NEXT:    ldr q2, [x0]
; CHECK-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-NEXT:    smull2 v1.4s, v2.8h, v0.8h
; CHECK-NEXT:    smull v0.4s, v2.4h, v0.4h
; CHECK-NEXT:    ret
  %load.A = load <8 x i16>, ptr %A
  %load.B = load <8 x i8>, ptr %B
  %sext.A = sext <8 x i16> %load.A to <8 x i32>
  %zext.B = zext <8 x i8> %load.B to <8 x i32>
  %res = mul <8 x i32> %sext.A, %zext.B
  ret <8 x i32> %res
}

define <8 x i32> @smull_zext_v8i8_v8i32_top_bit_is_1(ptr %A, ptr %B) nounwind {
; CHECK-LABEL: smull_zext_v8i8_v8i32_top_bit_is_1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr q1, [x1]
; CHECK-NEXT:    orr v0.8h, #128, lsl #8
; CHECK-NEXT:    sshll v2.4s, v1.4h, #0
; CHECK-NEXT:    sshll2 v1.4s, v1.8h, #0
; CHECK-NEXT:    ushll2 v3.4s, v0.8h, #0
; CHECK-NEXT:    ushll v0.4s, v0.4h, #0
; CHECK-NEXT:    mul v1.4s, v3.4s, v1.4s
; CHECK-NEXT:    mul v0.4s, v0.4s, v2.4s
; CHECK-NEXT:    ret
  %load.A = load <8 x i16>, ptr %A
  %or.A = or <8 x i16> %load.A, <i16 u0x8000, i16 u0x8000, i16 u0x8000, i16 u0x8000, i16 u0x8000, i16 u0x8000, i16 u0x8000, i16 u0x8000>
  %load.B = load <8 x i16>, ptr %B
  %zext.A = zext <8 x i16> %or.A  to <8 x i32>
  %sext.B = sext <8 x i16> %load.B to <8 x i32>
  %res = mul <8 x i32> %zext.A, %sext.B
  ret <8 x i32> %res
}

define <4 x i32> @smull_zext_v4i16_v4i32(ptr %A, ptr %B) nounwind {
; CHECK-LABEL: smull_zext_v4i16_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr s0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-NEXT:    smull v0.4s, v0.4h, v1.4h
; CHECK-NEXT:    ret
  %load.A = load <4 x i8>, ptr %A
  %load.B = load <4 x i16>, ptr %B
  %zext.A = zext <4 x i8> %load.A to <4 x i32>
  %sext.B = sext <4 x i16> %load.B to <4 x i32>
  %res = mul <4 x i32> %zext.A, %sext.B
  ret <4 x i32> %res
}

define <2 x i64> @smull_zext_v2i32_v2i64(ptr %A, ptr %B) nounwind {
; CHECK-LABEL: smull_zext_v2i32_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x1]
; CHECK-NEXT:    ldrh w8, [x0]
; CHECK-NEXT:    ldrh w11, [x0, #2]
; CHECK-NEXT:    sshll v0.2d, v0.2s, #0
; CHECK-NEXT:    fmov x9, d0
; CHECK-NEXT:    mov x10, v0.d[1]
; CHECK-NEXT:    smull x8, w8, w9
; CHECK-NEXT:    smull x9, w11, w10
; CHECK-NEXT:    fmov d0, x8
; CHECK-NEXT:    mov v0.d[1], x9
; CHECK-NEXT:    ret
  %load.A = load <2 x i16>, ptr %A
  %load.B = load <2 x i32>, ptr %B
  %zext.A = zext <2 x i16> %load.A to <2 x i64>
  %sext.B = sext <2 x i32> %load.B to <2 x i64>
  %res = mul <2 x i64> %zext.A, %sext.B
  ret <2 x i64> %res
}

define <2 x i64> @smull_zext_and_v2i32_v2i64(ptr %A, ptr %B) nounwind {
; CHECK-LABEL: smull_zext_and_v2i32_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    bic v0.2s, #128, lsl #24
; CHECK-NEXT:    smull v0.2d, v0.2s, v1.2s
; CHECK-NEXT:    ret
  %load.A = load <2 x i32>, ptr %A
  %and.A = and <2 x i32> %load.A, <i32 u0x7FFFFFFF, i32 u0x7FFFFFFF>
  %load.B = load <2 x i32>, ptr %B
  %zext.A = zext <2 x i32> %and.A to <2 x i64>
  %sext.B = sext <2 x i32> %load.B to <2 x i64>
  %res = mul <2 x i64> %zext.A, %sext.B
  ret <2 x i64> %res
}

define <8 x i16> @umull_v8i8_v8i16(ptr %A, ptr %B) nounwind {
; CHECK-LABEL: umull_v8i8_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    umull v0.8h, v0.8b, v1.8b
; CHECK-NEXT:    ret
  %tmp1 = load <8 x i8>, ptr %A
  %tmp2 = load <8 x i8>, ptr %B
  %tmp3 = zext <8 x i8> %tmp1 to <8 x i16>
  %tmp4 = zext <8 x i8> %tmp2 to <8 x i16>
  %tmp5 = mul <8 x i16> %tmp3, %tmp4
  ret <8 x i16> %tmp5
}

define <4 x i32> @umull_v4i16_v4i32(ptr %A, ptr %B) nounwind {
; CHECK-LABEL: umull_v4i16_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    umull v0.4s, v0.4h, v1.4h
; CHECK-NEXT:    ret
  %tmp1 = load <4 x i16>, ptr %A
  %tmp2 = load <4 x i16>, ptr %B
  %tmp3 = zext <4 x i16> %tmp1 to <4 x i32>
  %tmp4 = zext <4 x i16> %tmp2 to <4 x i32>
  %tmp5 = mul <4 x i32> %tmp3, %tmp4
  ret <4 x i32> %tmp5
}

define <2 x i64> @umull_v2i32_v2i64(ptr %A, ptr %B) nounwind {
; CHECK-LABEL: umull_v2i32_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    umull v0.2d, v0.2s, v1.2s
; CHECK-NEXT:    ret
  %tmp1 = load <2 x i32>, ptr %A
  %tmp2 = load <2 x i32>, ptr %B
  %tmp3 = zext <2 x i32> %tmp1 to <2 x i64>
  %tmp4 = zext <2 x i32> %tmp2 to <2 x i64>
  %tmp5 = mul <2 x i64> %tmp3, %tmp4
  ret <2 x i64> %tmp5
}

define <8 x i16> @amull_v8i8_v8i16(ptr %A, ptr %B) nounwind {
; CHECK-LABEL: amull_v8i8_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    smull v0.8h, v0.8b, v1.8b
; CHECK-NEXT:    bic v0.8h, #255, lsl #8
; CHECK-NEXT:    ret
  %tmp1 = load <8 x i8>, ptr %A
  %tmp2 = load <8 x i8>, ptr %B
  %tmp3 = zext <8 x i8> %tmp1 to <8 x i16>
  %tmp4 = zext <8 x i8> %tmp2 to <8 x i16>
  %tmp5 = mul <8 x i16> %tmp3, %tmp4
  %and = and <8 x i16> %tmp5, <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  ret <8 x i16> %and
}

define <4 x i32> @amull_v4i16_v4i32(ptr %A, ptr %B) nounwind {
; CHECK-LABEL: amull_v4i16_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d1, [x0]
; CHECK-NEXT:    ldr d2, [x1]
; CHECK-NEXT:    movi v0.2d, #0x00ffff0000ffff
; CHECK-NEXT:    smull v1.4s, v1.4h, v2.4h
; CHECK-NEXT:    and v0.16b, v1.16b, v0.16b
; CHECK-NEXT:    ret
  %tmp1 = load <4 x i16>, ptr %A
  %tmp2 = load <4 x i16>, ptr %B
  %tmp3 = zext <4 x i16> %tmp1 to <4 x i32>
  %tmp4 = zext <4 x i16> %tmp2 to <4 x i32>
  %tmp5 = mul <4 x i32> %tmp3, %tmp4
  %and = and <4 x i32> %tmp5, <i32 65535, i32 65535, i32 65535, i32 65535>
  ret <4 x i32> %and
}

define <2 x i64> @amull_v2i32_v2i64(ptr %A, ptr %B) nounwind {
; CHECK-LABEL: amull_v2i32_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d1, [x0]
; CHECK-NEXT:    ldr d2, [x1]
; CHECK-NEXT:    movi v0.2d, #0x000000ffffffff
; CHECK-NEXT:    smull v1.2d, v1.2s, v2.2s
; CHECK-NEXT:    and v0.16b, v1.16b, v0.16b
; CHECK-NEXT:    ret
  %tmp1 = load <2 x i32>, ptr %A
  %tmp2 = load <2 x i32>, ptr %B
  %tmp3 = zext <2 x i32> %tmp1 to <2 x i64>
  %tmp4 = zext <2 x i32> %tmp2 to <2 x i64>
  %tmp5 = mul <2 x i64> %tmp3, %tmp4
  %and = and <2 x i64> %tmp5, <i64 4294967295, i64 4294967295>
  ret <2 x i64> %and
}

define <8 x i16> @smlal_v8i8_v8i16(ptr %A, ptr %B, ptr %C) nounwind {
; CHECK-LABEL: smlal_v8i8_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr d2, [x2]
; CHECK-NEXT:    smlal v0.8h, v1.8b, v2.8b
; CHECK-NEXT:    ret
  %tmp1 = load <8 x i16>, ptr %A
  %tmp2 = load <8 x i8>, ptr %B
  %tmp3 = load <8 x i8>, ptr %C
  %tmp4 = sext <8 x i8> %tmp2 to <8 x i16>
  %tmp5 = sext <8 x i8> %tmp3 to <8 x i16>
  %tmp6 = mul <8 x i16> %tmp4, %tmp5
  %tmp7 = add <8 x i16> %tmp1, %tmp6
  ret <8 x i16> %tmp7
}

define <4 x i32> @smlal_v4i16_v4i32(ptr %A, ptr %B, ptr %C) nounwind {
; CHECK-LABEL: smlal_v4i16_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr d2, [x2]
; CHECK-NEXT:    smlal v0.4s, v1.4h, v2.4h
; CHECK-NEXT:    ret
  %tmp1 = load <4 x i32>, ptr %A
  %tmp2 = load <4 x i16>, ptr %B
  %tmp3 = load <4 x i16>, ptr %C
  %tmp4 = sext <4 x i16> %tmp2 to <4 x i32>
  %tmp5 = sext <4 x i16> %tmp3 to <4 x i32>
  %tmp6 = mul <4 x i32> %tmp4, %tmp5
  %tmp7 = add <4 x i32> %tmp1, %tmp6
  ret <4 x i32> %tmp7
}

define <2 x i64> @smlal_v2i32_v2i64(ptr %A, ptr %B, ptr %C) nounwind {
; CHECK-LABEL: smlal_v2i32_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr d2, [x2]
; CHECK-NEXT:    smlal v0.2d, v1.2s, v2.2s
; CHECK-NEXT:    ret
  %tmp1 = load <2 x i64>, ptr %A
  %tmp2 = load <2 x i32>, ptr %B
  %tmp3 = load <2 x i32>, ptr %C
  %tmp4 = sext <2 x i32> %tmp2 to <2 x i64>
  %tmp5 = sext <2 x i32> %tmp3 to <2 x i64>
  %tmp6 = mul <2 x i64> %tmp4, %tmp5
  %tmp7 = add <2 x i64> %tmp1, %tmp6
  ret <2 x i64> %tmp7
}

define <8 x i16> @umlal_v8i8_v8i16(ptr %A, ptr %B, ptr %C) nounwind {
; CHECK-LABEL: umlal_v8i8_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr d2, [x2]
; CHECK-NEXT:    umlal v0.8h, v1.8b, v2.8b
; CHECK-NEXT:    ret
  %tmp1 = load <8 x i16>, ptr %A
  %tmp2 = load <8 x i8>, ptr %B
  %tmp3 = load <8 x i8>, ptr %C
  %tmp4 = zext <8 x i8> %tmp2 to <8 x i16>
  %tmp5 = zext <8 x i8> %tmp3 to <8 x i16>
  %tmp6 = mul <8 x i16> %tmp4, %tmp5
  %tmp7 = add <8 x i16> %tmp1, %tmp6
  ret <8 x i16> %tmp7
}

define <4 x i32> @umlal_v4i16_v4i32(ptr %A, ptr %B, ptr %C) nounwind {
; CHECK-LABEL: umlal_v4i16_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr d2, [x2]
; CHECK-NEXT:    umlal v0.4s, v1.4h, v2.4h
; CHECK-NEXT:    ret
  %tmp1 = load <4 x i32>, ptr %A
  %tmp2 = load <4 x i16>, ptr %B
  %tmp3 = load <4 x i16>, ptr %C
  %tmp4 = zext <4 x i16> %tmp2 to <4 x i32>
  %tmp5 = zext <4 x i16> %tmp3 to <4 x i32>
  %tmp6 = mul <4 x i32> %tmp4, %tmp5
  %tmp7 = add <4 x i32> %tmp1, %tmp6
  ret <4 x i32> %tmp7
}

define <2 x i64> @umlal_v2i32_v2i64(ptr %A, ptr %B, ptr %C) nounwind {
; CHECK-LABEL: umlal_v2i32_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr d2, [x2]
; CHECK-NEXT:    umlal v0.2d, v1.2s, v2.2s
; CHECK-NEXT:    ret
  %tmp1 = load <2 x i64>, ptr %A
  %tmp2 = load <2 x i32>, ptr %B
  %tmp3 = load <2 x i32>, ptr %C
  %tmp4 = zext <2 x i32> %tmp2 to <2 x i64>
  %tmp5 = zext <2 x i32> %tmp3 to <2 x i64>
  %tmp6 = mul <2 x i64> %tmp4, %tmp5
  %tmp7 = add <2 x i64> %tmp1, %tmp6
  ret <2 x i64> %tmp7
}

define <8 x i16> @amlal_v8i8_v8i16(ptr %A, ptr %B, ptr %C) nounwind {
; CHECK-LABEL: amlal_v8i8_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr d2, [x2]
; CHECK-NEXT:    smlal v0.8h, v1.8b, v2.8b
; CHECK-NEXT:    bic v0.8h, #255, lsl #8
; CHECK-NEXT:    ret
  %tmp1 = load <8 x i16>, ptr %A
  %tmp2 = load <8 x i8>, ptr %B
  %tmp3 = load <8 x i8>, ptr %C
  %tmp4 = zext <8 x i8> %tmp2 to <8 x i16>
  %tmp5 = zext <8 x i8> %tmp3 to <8 x i16>
  %tmp6 = mul <8 x i16> %tmp4, %tmp5
  %tmp7 = add <8 x i16> %tmp1, %tmp6
  %and = and <8 x i16> %tmp7, <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  ret <8 x i16> %and
}

define <4 x i32> @amlal_v4i16_v4i32(ptr %A, ptr %B, ptr %C) nounwind {
; CHECK-LABEL: amlal_v4i16_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr q2, [x0]
; CHECK-NEXT:    ldr d3, [x2]
; CHECK-NEXT:    movi v0.2d, #0x00ffff0000ffff
; CHECK-NEXT:    smlal v2.4s, v1.4h, v3.4h
; CHECK-NEXT:    and v0.16b, v2.16b, v0.16b
; CHECK-NEXT:    ret
  %tmp1 = load <4 x i32>, ptr %A
  %tmp2 = load <4 x i16>, ptr %B
  %tmp3 = load <4 x i16>, ptr %C
  %tmp4 = zext <4 x i16> %tmp2 to <4 x i32>
  %tmp5 = zext <4 x i16> %tmp3 to <4 x i32>
  %tmp6 = mul <4 x i32> %tmp4, %tmp5
  %tmp7 = add <4 x i32> %tmp1, %tmp6
  %and = and <4 x i32> %tmp7, <i32 65535, i32 65535, i32 65535, i32 65535>
  ret <4 x i32> %and
}

define <2 x i64> @amlal_v2i32_v2i64(ptr %A, ptr %B, ptr %C) nounwind {
; CHECK-LABEL: amlal_v2i32_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr q2, [x0]
; CHECK-NEXT:    ldr d3, [x2]
; CHECK-NEXT:    movi v0.2d, #0x000000ffffffff
; CHECK-NEXT:    smlal v2.2d, v1.2s, v3.2s
; CHECK-NEXT:    and v0.16b, v2.16b, v0.16b
; CHECK-NEXT:    ret
  %tmp1 = load <2 x i64>, ptr %A
  %tmp2 = load <2 x i32>, ptr %B
  %tmp3 = load <2 x i32>, ptr %C
  %tmp4 = zext <2 x i32> %tmp2 to <2 x i64>
  %tmp5 = zext <2 x i32> %tmp3 to <2 x i64>
  %tmp6 = mul <2 x i64> %tmp4, %tmp5
  %tmp7 = add <2 x i64> %tmp1, %tmp6
  %and = and <2 x i64> %tmp7, <i64 4294967295, i64 4294967295>
  ret <2 x i64> %and
}

define <8 x i16> @smlsl_v8i8_v8i16(ptr %A, ptr %B, ptr %C) nounwind {
; CHECK-LABEL: smlsl_v8i8_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr d2, [x2]
; CHECK-NEXT:    smlsl v0.8h, v1.8b, v2.8b
; CHECK-NEXT:    ret
  %tmp1 = load <8 x i16>, ptr %A
  %tmp2 = load <8 x i8>, ptr %B
  %tmp3 = load <8 x i8>, ptr %C
  %tmp4 = sext <8 x i8> %tmp2 to <8 x i16>
  %tmp5 = sext <8 x i8> %tmp3 to <8 x i16>
  %tmp6 = mul <8 x i16> %tmp4, %tmp5
  %tmp7 = sub <8 x i16> %tmp1, %tmp6
  ret <8 x i16> %tmp7
}

define <4 x i32> @smlsl_v4i16_v4i32(ptr %A, ptr %B, ptr %C) nounwind {
; CHECK-LABEL: smlsl_v4i16_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr d2, [x2]
; CHECK-NEXT:    smlsl v0.4s, v1.4h, v2.4h
; CHECK-NEXT:    ret
  %tmp1 = load <4 x i32>, ptr %A
  %tmp2 = load <4 x i16>, ptr %B
  %tmp3 = load <4 x i16>, ptr %C
  %tmp4 = sext <4 x i16> %tmp2 to <4 x i32>
  %tmp5 = sext <4 x i16> %tmp3 to <4 x i32>
  %tmp6 = mul <4 x i32> %tmp4, %tmp5
  %tmp7 = sub <4 x i32> %tmp1, %tmp6
  ret <4 x i32> %tmp7
}

define <2 x i64> @smlsl_v2i32_v2i64(ptr %A, ptr %B, ptr %C) nounwind {
; CHECK-LABEL: smlsl_v2i32_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr d2, [x2]
; CHECK-NEXT:    smlsl v0.2d, v1.2s, v2.2s
; CHECK-NEXT:    ret
  %tmp1 = load <2 x i64>, ptr %A
  %tmp2 = load <2 x i32>, ptr %B
  %tmp3 = load <2 x i32>, ptr %C
  %tmp4 = sext <2 x i32> %tmp2 to <2 x i64>
  %tmp5 = sext <2 x i32> %tmp3 to <2 x i64>
  %tmp6 = mul <2 x i64> %tmp4, %tmp5
  %tmp7 = sub <2 x i64> %tmp1, %tmp6
  ret <2 x i64> %tmp7
}

define <8 x i16> @umlsl_v8i8_v8i16(ptr %A, ptr %B, ptr %C) nounwind {
; CHECK-LABEL: umlsl_v8i8_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr d2, [x2]
; CHECK-NEXT:    umlsl v0.8h, v1.8b, v2.8b
; CHECK-NEXT:    ret
  %tmp1 = load <8 x i16>, ptr %A
  %tmp2 = load <8 x i8>, ptr %B
  %tmp3 = load <8 x i8>, ptr %C
  %tmp4 = zext <8 x i8> %tmp2 to <8 x i16>
  %tmp5 = zext <8 x i8> %tmp3 to <8 x i16>
  %tmp6 = mul <8 x i16> %tmp4, %tmp5
  %tmp7 = sub <8 x i16> %tmp1, %tmp6
  ret <8 x i16> %tmp7
}

define <4 x i32> @umlsl_v4i16_v4i32(ptr %A, ptr %B, ptr %C) nounwind {
; CHECK-LABEL: umlsl_v4i16_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr d2, [x2]
; CHECK-NEXT:    umlsl v0.4s, v1.4h, v2.4h
; CHECK-NEXT:    ret
  %tmp1 = load <4 x i32>, ptr %A
  %tmp2 = load <4 x i16>, ptr %B
  %tmp3 = load <4 x i16>, ptr %C
  %tmp4 = zext <4 x i16> %tmp2 to <4 x i32>
  %tmp5 = zext <4 x i16> %tmp3 to <4 x i32>
  %tmp6 = mul <4 x i32> %tmp4, %tmp5
  %tmp7 = sub <4 x i32> %tmp1, %tmp6
  ret <4 x i32> %tmp7
}

define <2 x i64> @umlsl_v2i32_v2i64(ptr %A, ptr %B, ptr %C) nounwind {
; CHECK-LABEL: umlsl_v2i32_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr d2, [x2]
; CHECK-NEXT:    umlsl v0.2d, v1.2s, v2.2s
; CHECK-NEXT:    ret
  %tmp1 = load <2 x i64>, ptr %A
  %tmp2 = load <2 x i32>, ptr %B
  %tmp3 = load <2 x i32>, ptr %C
  %tmp4 = zext <2 x i32> %tmp2 to <2 x i64>
  %tmp5 = zext <2 x i32> %tmp3 to <2 x i64>
  %tmp6 = mul <2 x i64> %tmp4, %tmp5
  %tmp7 = sub <2 x i64> %tmp1, %tmp6
  ret <2 x i64> %tmp7
}

define <8 x i16> @amlsl_v8i8_v8i16(ptr %A, ptr %B, ptr %C) nounwind {
; CHECK-LABEL: amlsl_v8i8_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr d2, [x2]
; CHECK-NEXT:    smlsl v0.8h, v1.8b, v2.8b
; CHECK-NEXT:    bic v0.8h, #255, lsl #8
; CHECK-NEXT:    ret
  %tmp1 = load <8 x i16>, ptr %A
  %tmp2 = load <8 x i8>, ptr %B
  %tmp3 = load <8 x i8>, ptr %C
  %tmp4 = zext <8 x i8> %tmp2 to <8 x i16>
  %tmp5 = zext <8 x i8> %tmp3 to <8 x i16>
  %tmp6 = mul <8 x i16> %tmp4, %tmp5
  %tmp7 = sub <8 x i16> %tmp1, %tmp6
  %and = and <8 x i16> %tmp7, <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  ret <8 x i16> %and
}

define <4 x i32> @amlsl_v4i16_v4i32(ptr %A, ptr %B, ptr %C) nounwind {
; CHECK-LABEL: amlsl_v4i16_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr q2, [x0]
; CHECK-NEXT:    ldr d3, [x2]
; CHECK-NEXT:    movi v0.2d, #0x00ffff0000ffff
; CHECK-NEXT:    smlsl v2.4s, v1.4h, v3.4h
; CHECK-NEXT:    and v0.16b, v2.16b, v0.16b
; CHECK-NEXT:    ret
  %tmp1 = load <4 x i32>, ptr %A
  %tmp2 = load <4 x i16>, ptr %B
  %tmp3 = load <4 x i16>, ptr %C
  %tmp4 = zext <4 x i16> %tmp2 to <4 x i32>
  %tmp5 = zext <4 x i16> %tmp3 to <4 x i32>
  %tmp6 = mul <4 x i32> %tmp4, %tmp5
  %tmp7 = sub <4 x i32> %tmp1, %tmp6
  %and = and <4 x i32> %tmp7, <i32 65535, i32 65535, i32 65535, i32 65535>
  ret <4 x i32> %and
}

define <2 x i64> @amlsl_v2i32_v2i64(ptr %A, ptr %B, ptr %C) nounwind {
; CHECK-LABEL: amlsl_v2i32_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr q2, [x0]
; CHECK-NEXT:    ldr d3, [x2]
; CHECK-NEXT:    movi v0.2d, #0x000000ffffffff
; CHECK-NEXT:    smlsl v2.2d, v1.2s, v3.2s
; CHECK-NEXT:    and v0.16b, v2.16b, v0.16b
; CHECK-NEXT:    ret
  %tmp1 = load <2 x i64>, ptr %A
  %tmp2 = load <2 x i32>, ptr %B
  %tmp3 = load <2 x i32>, ptr %C
  %tmp4 = zext <2 x i32> %tmp2 to <2 x i64>
  %tmp5 = zext <2 x i32> %tmp3 to <2 x i64>
  %tmp6 = mul <2 x i64> %tmp4, %tmp5
  %tmp7 = sub <2 x i64> %tmp1, %tmp6
  %and = and <2 x i64> %tmp7, <i64 4294967295, i64 4294967295>
  ret <2 x i64> %and
}

; SMULL recognizing BUILD_VECTORs with sign/zero-extended elements.
define <8 x i16> @smull_extvec_v8i8_v8i16(<8 x i8> %arg) nounwind {
; CHECK-LABEL: smull_extvec_v8i8_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.8b, #244
; CHECK-NEXT:    smull v0.8h, v0.8b, v1.8b
; CHECK-NEXT:    ret
  %tmp3 = sext <8 x i8> %arg to <8 x i16>
  %tmp4 = mul <8 x i16> %tmp3, <i16 -12, i16 -12, i16 -12, i16 -12, i16 -12, i16 -12, i16 -12, i16 -12>
  ret <8 x i16> %tmp4
}

define <8 x i16> @smull_noextvec_v8i8_v8i16(<8 x i8> %arg) nounwind {
; Do not use SMULL if the BUILD_VECTOR element values are too big.
; CHECK-LABEL: smull_noextvec_v8i8_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #64537
; CHECK-NEXT:    sshll v0.8h, v0.8b, #0
; CHECK-NEXT:    dup v1.8h, w8
; CHECK-NEXT:    mul v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %tmp3 = sext <8 x i8> %arg to <8 x i16>
  %tmp4 = mul <8 x i16> %tmp3, <i16 -999, i16 -999, i16 -999, i16 -999, i16 -999, i16 -999, i16 -999, i16 -999>
  ret <8 x i16> %tmp4
}

define <4 x i32> @smull_extvec_v4i16_v4i32(<4 x i16> %arg) nounwind {
; CHECK-LABEL: smull_extvec_v4i16_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvni v1.4h, #11
; CHECK-NEXT:    smull v0.4s, v0.4h, v1.4h
; CHECK-NEXT:    ret
  %tmp3 = sext <4 x i16> %arg to <4 x i32>
  %tmp4 = mul <4 x i32> %tmp3, <i32 -12, i32 -12, i32 -12, i32 -12>
  ret <4 x i32> %tmp4
}

define <2 x i64> @smull_extvec_v2i32_v2i64(<2 x i32> %arg) nounwind {
; CHECK-LABEL: smull_extvec_v2i32_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #-1234
; CHECK-NEXT:    dup v1.2s, w8
; CHECK-NEXT:    smull v0.2d, v0.2s, v1.2s
; CHECK-NEXT:    ret
  %tmp3 = sext <2 x i32> %arg to <2 x i64>
  %tmp4 = mul <2 x i64> %tmp3, <i64 -1234, i64 -1234>
  ret <2 x i64> %tmp4
}

define <8 x i16> @umull_extvec_v8i8_v8i16(<8 x i8> %arg) nounwind {
; CHECK-LABEL: umull_extvec_v8i8_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.8b, #12
; CHECK-NEXT:    umull v0.8h, v0.8b, v1.8b
; CHECK-NEXT:    ret
  %tmp3 = zext <8 x i8> %arg to <8 x i16>
  %tmp4 = mul <8 x i16> %tmp3, <i16 12, i16 12, i16 12, i16 12, i16 12, i16 12, i16 12, i16 12>
  ret <8 x i16> %tmp4
}

define <8 x i16> @umull_noextvec_v8i8_v8i16(<8 x i8> %arg) nounwind {
; Do not use SMULL if the BUILD_VECTOR element values are too big.
; CHECK-LABEL: umull_noextvec_v8i8_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #999
; CHECK-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-NEXT:    dup v1.8h, w8
; CHECK-NEXT:    mul v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %tmp3 = zext <8 x i8> %arg to <8 x i16>
  %tmp4 = mul <8 x i16> %tmp3, <i16 999, i16 999, i16 999, i16 999, i16 999, i16 999, i16 999, i16 999>
  ret <8 x i16> %tmp4
}

define <4 x i32> @umull_extvec_v4i16_v4i32(<4 x i16> %arg) nounwind {
; CHECK-LABEL: umull_extvec_v4i16_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #1234
; CHECK-NEXT:    dup v1.4h, w8
; CHECK-NEXT:    umull v0.4s, v0.4h, v1.4h
; CHECK-NEXT:    ret
  %tmp3 = zext <4 x i16> %arg to <4 x i32>
  %tmp4 = mul <4 x i32> %tmp3, <i32 1234, i32 1234, i32 1234, i32 1234>
  ret <4 x i32> %tmp4
}

define <2 x i64> @umull_extvec_v2i32_v2i64(<2 x i32> %arg) nounwind {
; CHECK-LABEL: umull_extvec_v2i32_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #1234
; CHECK-NEXT:    dup v1.2s, w8
; CHECK-NEXT:    umull v0.2d, v0.2s, v1.2s
; CHECK-NEXT:    ret
  %tmp3 = zext <2 x i32> %arg to <2 x i64>
  %tmp4 = mul <2 x i64> %tmp3, <i64 1234, i64 1234>
  ret <2 x i64> %tmp4
}

define <8 x i16> @amull_extvec_v8i8_v8i16(<8 x i8> %arg) nounwind {
; CHECK-LABEL: amull_extvec_v8i8_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.8b, #12
; CHECK-NEXT:    smull v0.8h, v0.8b, v1.8b
; CHECK-NEXT:    bic v0.8h, #255, lsl #8
; CHECK-NEXT:    ret
  %tmp3 = zext <8 x i8> %arg to <8 x i16>
  %tmp4 = mul <8 x i16> %tmp3, <i16 12, i16 12, i16 12, i16 12, i16 12, i16 12, i16 12, i16 12>
  %and = and <8 x i16> %tmp4, <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  ret <8 x i16> %and
}

define <4 x i32> @amull_extvec_v4i16_v4i32(<4 x i16> %arg) nounwind {
; CHECK-LABEL: amull_extvec_v4i16_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #1234
; CHECK-NEXT:    movi v1.2d, #0x00ffff0000ffff
; CHECK-NEXT:    dup v2.4h, w8
; CHECK-NEXT:    smull v0.4s, v0.4h, v2.4h
; CHECK-NEXT:    and v0.16b, v0.16b, v1.16b
; CHECK-NEXT:    ret
  %tmp3 = zext <4 x i16> %arg to <4 x i32>
  %tmp4 = mul <4 x i32> %tmp3, <i32 1234, i32 1234, i32 1234, i32 1234>
  %and = and <4 x i32> %tmp4, <i32 65535, i32 65535, i32 65535, i32 65535>
  ret <4 x i32> %and
}

define <2 x i64> @amull_extvec_v2i32_v2i64(<2 x i32> %arg) nounwind {
; CHECK-LABEL: amull_extvec_v2i32_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #1234
; CHECK-NEXT:    movi v1.2d, #0x000000ffffffff
; CHECK-NEXT:    dup v2.2s, w8
; CHECK-NEXT:    smull v0.2d, v0.2s, v2.2s
; CHECK-NEXT:    and v0.16b, v0.16b, v1.16b
; CHECK-NEXT:    ret
  %tmp3 = zext <2 x i32> %arg to <2 x i64>
  %tmp4 = mul <2 x i64> %tmp3, <i64 1234, i64 1234>
  %and = and <2 x i64> %tmp4, <i64 4294967295, i64 4294967295>
  ret <2 x i64> %and
}

define i16 @smullWithInconsistentExtensions(<8 x i8> %x, <8 x i8> %y) {
; If one operand has a zero-extend and the other a sign-extend, smull
; cannot be used.
; CHECK-LABEL: smullWithInconsistentExtensions:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sshll v0.8h, v0.8b, #0
; CHECK-NEXT:    ushll v1.8h, v1.8b, #0
; CHECK-NEXT:    mul v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    umov w0, v0.h[0]
; CHECK-NEXT:    ret
  %s = sext <8 x i8> %x to <8 x i16>
  %z = zext <8 x i8> %y to <8 x i16>
  %m = mul <8 x i16> %s, %z
  %r = extractelement <8 x i16> %m, i32 0
  ret i16 %r
}

define <8 x i16> @smull_extended_vector_operand(<8 x i16> %v) {
; CHECK-LABEL: smull_extended_vector_operand:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    movi v1.4s, #139, lsl #8
; CHECK-NEXT:    sshll v2.4s, v0.4h, #0
; CHECK-NEXT:    sshll2 v0.4s, v0.8h, #0
; CHECK-NEXT:    mul v2.4s, v2.4s, v1.4s
; CHECK-NEXT:    mul v1.4s, v0.4s, v1.4s
; CHECK-NEXT:    shrn v0.4h, v2.4s, #1
; CHECK-NEXT:    shrn2 v0.8h, v1.4s, #1
; CHECK-NEXT:    ret
entry:
%0 = sext <8 x i16> %v to <8 x i32>
%1 = mul <8 x i32> %0, <i32 35584, i32 35584, i32 35584, i32 35584, i32 35584, i32 35584, i32 35584, i32 35584>
%2 = lshr <8 x i32> %1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
%3 = trunc <8 x i32> %2 to <8 x i16>
ret <8 x i16> %3

}

define void @distribute(ptr %dst, ptr %src, i32 %mul) nounwind {
; CHECK-LABEL: distribute:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr q0, [x1]
; CHECK-NEXT:    dup v1.8b, w2
; CHECK-NEXT:    mov d2, v0.d[1]
; CHECK-NEXT:    umull v2.8h, v2.8b, v1.8b
; CHECK-NEXT:    umlal v2.8h, v0.8b, v1.8b
; CHECK-NEXT:    str q2, [x0]
; CHECK-NEXT:    ret
entry:
  %0 = trunc i32 %mul to i8
  %1 = insertelement <8 x i8> undef, i8 %0, i32 0
  %2 = shufflevector <8 x i8> %1, <8 x i8> undef, <8 x i32> zeroinitializer
  %3 = load <16 x i8>, ptr %src, align 1
  %4 = bitcast <16 x i8> %3 to <2 x double>
  %5 = extractelement <2 x double> %4, i32 1
  %6 = bitcast double %5 to <8 x i8>
  %7 = zext <8 x i8> %6 to <8 x i16>
  %8 = zext <8 x i8> %2 to <8 x i16>
  %9 = extractelement <2 x double> %4, i32 0
  %10 = bitcast double %9 to <8 x i8>
  %11 = zext <8 x i8> %10 to <8 x i16>
  %12 = add <8 x i16> %7, %11
  %13 = mul <8 x i16> %12, %8
  store <8 x i16> %13, ptr %dst, align 2
  ret void
}

define <16 x i16> @umull2_i8(<16 x i8> %arg1, <16 x i8> %arg2) {
; CHECK-LABEL: umull2_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    umull2 v2.8h, v0.16b, v1.16b
; CHECK-NEXT:    umull v0.8h, v0.8b, v1.8b
; CHECK-NEXT:    mov v1.16b, v2.16b
; CHECK-NEXT:    ret
  %arg1_ext = zext <16 x i8> %arg1 to <16 x i16>
  %arg2_ext = zext <16 x i8> %arg2 to <16 x i16>
  %mul = mul <16 x i16> %arg1_ext, %arg2_ext
  ret <16 x i16> %mul
}

define <16 x i16> @smull2_i8(<16 x i8> %arg1, <16 x i8> %arg2) {
; CHECK-LABEL: smull2_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    smull2 v2.8h, v0.16b, v1.16b
; CHECK-NEXT:    smull v0.8h, v0.8b, v1.8b
; CHECK-NEXT:    mov v1.16b, v2.16b
; CHECK-NEXT:    ret
  %arg1_ext = sext <16 x i8> %arg1 to <16 x i16>
  %arg2_ext = sext <16 x i8> %arg2 to <16 x i16>
  %mul = mul <16 x i16> %arg1_ext, %arg2_ext
  ret <16 x i16> %mul
}

define <8 x i32> @umull2_i16(<8 x i16> %arg1, <8 x i16> %arg2) {
; CHECK-LABEL: umull2_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    umull2 v2.4s, v0.8h, v1.8h
; CHECK-NEXT:    umull v0.4s, v0.4h, v1.4h
; CHECK-NEXT:    mov v1.16b, v2.16b
; CHECK-NEXT:    ret
  %arg1_ext = zext <8 x i16> %arg1 to <8 x i32>
  %arg2_ext = zext <8 x i16> %arg2 to <8 x i32>
  %mul = mul <8 x i32> %arg1_ext, %arg2_ext
  ret <8 x i32> %mul
}

define <8 x i32> @smull2_i16(<8 x i16> %arg1, <8 x i16> %arg2) {
; CHECK-LABEL: smull2_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    smull2 v2.4s, v0.8h, v1.8h
; CHECK-NEXT:    smull v0.4s, v0.4h, v1.4h
; CHECK-NEXT:    mov v1.16b, v2.16b
; CHECK-NEXT:    ret
  %arg1_ext = sext <8 x i16> %arg1 to <8 x i32>
  %arg2_ext = sext <8 x i16> %arg2 to <8 x i32>
  %mul = mul <8 x i32> %arg1_ext, %arg2_ext
  ret <8 x i32> %mul
}

define <4 x i64> @umull2_i32(<4 x i32> %arg1, <4 x i32> %arg2) {
; CHECK-LABEL: umull2_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    umull2 v2.2d, v0.4s, v1.4s
; CHECK-NEXT:    umull v0.2d, v0.2s, v1.2s
; CHECK-NEXT:    mov v1.16b, v2.16b
; CHECK-NEXT:    ret
  %arg1_ext = zext <4 x i32> %arg1 to <4 x i64>
  %arg2_ext = zext <4 x i32> %arg2 to <4 x i64>
  %mul = mul <4 x i64> %arg1_ext, %arg2_ext
  ret <4 x i64> %mul
}

define <4 x i64> @smull2_i32(<4 x i32> %arg1, <4 x i32> %arg2) {
; CHECK-LABEL: smull2_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    smull2 v2.2d, v0.4s, v1.4s
; CHECK-NEXT:    smull v0.2d, v0.2s, v1.2s
; CHECK-NEXT:    mov v1.16b, v2.16b
; CHECK-NEXT:    ret
  %arg1_ext = sext <4 x i32> %arg1 to <4 x i64>
  %arg2_ext = sext <4 x i32> %arg2 to <4 x i64>
  %mul = mul <4 x i64> %arg1_ext, %arg2_ext
  ret <4 x i64> %mul
}

define <16 x i16> @amull2_i8(<16 x i8> %arg1, <16 x i8> %arg2) {
; CHECK-LABEL: amull2_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    smull2 v2.8h, v0.16b, v1.16b
; CHECK-NEXT:    smull v0.8h, v0.8b, v1.8b
; CHECK-NEXT:    bic v2.8h, #255, lsl #8
; CHECK-NEXT:    bic v0.8h, #255, lsl #8
; CHECK-NEXT:    mov v1.16b, v2.16b
; CHECK-NEXT:    ret
  %arg1_ext = zext <16 x i8> %arg1 to <16 x i16>
  %arg2_ext = zext <16 x i8> %arg2 to <16 x i16>
  %mul = mul <16 x i16> %arg1_ext, %arg2_ext
  %and = and <16 x i16> %mul, <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  ret <16 x i16> %and
}

define <8 x i32> @amull2_i16(<8 x i16> %arg1, <8 x i16> %arg2) {
; CHECK-LABEL: amull2_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v2.2d, #0x00ffff0000ffff
; CHECK-NEXT:    smull2 v3.4s, v0.8h, v1.8h
; CHECK-NEXT:    smull v0.4s, v0.4h, v1.4h
; CHECK-NEXT:    and v1.16b, v3.16b, v2.16b
; CHECK-NEXT:    and v0.16b, v0.16b, v2.16b
; CHECK-NEXT:    ret
  %arg1_ext = zext <8 x i16> %arg1 to <8 x i32>
  %arg2_ext = zext <8 x i16> %arg2 to <8 x i32>
  %mul = mul <8 x i32> %arg1_ext, %arg2_ext
  %and = and <8 x i32> %mul, <i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535>
  ret <8 x i32> %and
}

define <4 x i64> @amull2_i32(<4 x i32> %arg1, <4 x i32> %arg2) {
; CHECK-LABEL: amull2_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v2.2d, #0x000000ffffffff
; CHECK-NEXT:    smull2 v3.2d, v0.4s, v1.4s
; CHECK-NEXT:    smull v0.2d, v0.2s, v1.2s
; CHECK-NEXT:    and v1.16b, v3.16b, v2.16b
; CHECK-NEXT:    and v0.16b, v0.16b, v2.16b
; CHECK-NEXT:    ret
  %arg1_ext = zext <4 x i32> %arg1 to <4 x i64>
  %arg2_ext = zext <4 x i32> %arg2 to <4 x i64>
  %mul = mul <4 x i64> %arg1_ext, %arg2_ext
  %and = and <4 x i64> %mul, <i64 4294967295, i64 4294967295, i64 4294967295, i64 4294967295>
  ret <4 x i64> %and
}


define <8 x i16> @umull_and_v8i16(<8 x i8> %src1, <8 x i16> %src2) {
; CHECK-LABEL: umull_and_v8i16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    bic v1.8h, #255, lsl #8
; CHECK-NEXT:    xtn v1.8b, v1.8h
; CHECK-NEXT:    umull v0.8h, v0.8b, v1.8b
; CHECK-NEXT:    ret
entry:
  %in1 = zext <8 x i8> %src1 to <8 x i16>
  %in2 = and <8 x i16> %src2, <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  %out = mul nsw <8 x i16> %in1, %in2
  ret <8 x i16> %out
}

define <8 x i16> @umull_and_v8i16_c(<8 x i8> %src1, <8 x i16> %src2) {
; CHECK-LABEL: umull_and_v8i16_c:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    bic v1.8h, #255, lsl #8
; CHECK-NEXT:    xtn v1.8b, v1.8h
; CHECK-NEXT:    umull v0.8h, v1.8b, v0.8b
; CHECK-NEXT:    ret
entry:
  %in1 = zext <8 x i8> %src1 to <8 x i16>
  %in2 = and <8 x i16> %src2, <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  %out = mul nsw <8 x i16> %in2, %in1
  ret <8 x i16> %out
}

define <8 x i16> @umull_and256_v8i16(<8 x i8> %src1, <8 x i16> %src2) {
; CHECK-LABEL: umull_and256_v8i16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    movi v2.8h, #1, lsl #8
; CHECK-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-NEXT:    and v1.16b, v1.16b, v2.16b
; CHECK-NEXT:    mul v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
entry:
  %in1 = zext <8 x i8> %src1 to <8 x i16>
  %in2 = and <8 x i16> %src2, <i16 256, i16 256, i16 256, i16 256, i16 256, i16 256, i16 256, i16 256>
  %out = mul nsw <8 x i16> %in1, %in2
  ret <8 x i16> %out
}

define <8 x i16> @umull_andconst_v8i16(<8 x i8> %src1, <8 x i16> %src2) {
; CHECK-LABEL: umull_andconst_v8i16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    movi v1.2d, #0xffffffffffffffff
; CHECK-NEXT:    umull v0.8h, v0.8b, v1.8b
; CHECK-NEXT:    ret
entry:
  %in1 = zext <8 x i8> %src1 to <8 x i16>
  %out = mul nsw <8 x i16> %in1, <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  ret <8 x i16> %out
}

define <8 x i16> @umull_smaller_v8i16(<8 x i4> %src1, <8 x i16> %src2) {
; CHECK-LABEL: umull_smaller_v8i16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    movi v2.8b, #15
; CHECK-NEXT:    bic v1.8h, #255, lsl #8
; CHECK-NEXT:    xtn v1.8b, v1.8h
; CHECK-NEXT:    and v0.8b, v0.8b, v2.8b
; CHECK-NEXT:    umull v0.8h, v0.8b, v1.8b
; CHECK-NEXT:    ret
entry:
  %in1 = zext <8 x i4> %src1 to <8 x i16>
  %in2 = and <8 x i16> %src2, <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  %out = mul nsw <8 x i16> %in1, %in2
  ret <8 x i16> %out
}

define <4 x i32> @umull_and_v4i32(<4 x i16> %src1, <4 x i32> %src2) {
; CHECK-LABEL: umull_and_v4i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    movi v2.2d, #0x0000ff000000ff
; CHECK-NEXT:    and v1.16b, v1.16b, v2.16b
; CHECK-NEXT:    xtn v1.4h, v1.4s
; CHECK-NEXT:    umull v0.4s, v0.4h, v1.4h
; CHECK-NEXT:    ret
entry:
  %in1 = zext <4 x i16> %src1 to <4 x i32>
  %in2 = and <4 x i32> %src2, <i32 255, i32 255, i32 255, i32 255>
  %out = mul nsw <4 x i32> %in1, %in2
  ret <4 x i32> %out
}

define <8 x i32> @umull_and_v8i32(<8 x i16> %src1, <8 x i32> %src2) {
; CHECK-LABEL: umull_and_v8i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    movi v3.2d, #0x0000ff000000ff
; CHECK-NEXT:    ext v4.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    and v2.16b, v2.16b, v3.16b
; CHECK-NEXT:    and v1.16b, v1.16b, v3.16b
; CHECK-NEXT:    xtn v1.4h, v1.4s
; CHECK-NEXT:    xtn v2.4h, v2.4s
; CHECK-NEXT:    umull v0.4s, v0.4h, v1.4h
; CHECK-NEXT:    umull v1.4s, v4.4h, v2.4h
; CHECK-NEXT:    ret
entry:
  %in1 = zext <8 x i16> %src1 to <8 x i32>
  %in2 = and <8 x i32> %src2, <i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255, i32 255>
  %out = mul nsw <8 x i32> %in1, %in2
  ret <8 x i32> %out
}

define <8 x i32> @umull_and_v8i32_dup(<8 x i16> %src1, i32 %src2) {
; CHECK-LABEL: umull_and_v8i32_dup:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    and w8, w0, #0xff
; CHECK-NEXT:    dup v2.8h, w8
; CHECK-NEXT:    umull2 v1.4s, v0.8h, v2.8h
; CHECK-NEXT:    umull v0.4s, v0.4h, v2.4h
; CHECK-NEXT:    ret
entry:
  %in1 = zext <8 x i16> %src1 to <8 x i32>
  %in2 = and i32 %src2, 255
  %broadcast.splatinsert = insertelement <8 x i32> undef, i32 %in2, i64 0
  %broadcast.splat = shufflevector <8 x i32> %broadcast.splatinsert, <8 x i32> undef, <8 x i32> zeroinitializer
  %out = mul nsw <8 x i32> %in1, %broadcast.splat
  ret <8 x i32> %out
}

define <2 x i64> @umull_and_v2i64(<2 x i32> %src1, <2 x i64> %src2) {
; CHECK-LABEL: umull_and_v2i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    movi v2.2d, #0x000000000000ff
; CHECK-NEXT:    and v1.16b, v1.16b, v2.16b
; CHECK-NEXT:    xtn v1.2s, v1.2d
; CHECK-NEXT:    umull v0.2d, v0.2s, v1.2s
; CHECK-NEXT:    ret
entry:
  %in1 = zext <2 x i32> %src1 to <2 x i64>
  %in2 = and <2 x i64> %src2, <i64 255, i64 255>
  %out = mul nsw <2 x i64> %in1, %in2
  ret <2 x i64> %out
}

define <4 x i64> @umull_and_v4i64(<4 x i32> %src1, <4 x i64> %src2) {
; CHECK-LABEL: umull_and_v4i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    movi v3.2d, #0x000000000000ff
; CHECK-NEXT:    ext v4.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    and v2.16b, v2.16b, v3.16b
; CHECK-NEXT:    and v1.16b, v1.16b, v3.16b
; CHECK-NEXT:    xtn v1.2s, v1.2d
; CHECK-NEXT:    xtn v2.2s, v2.2d
; CHECK-NEXT:    umull v0.2d, v0.2s, v1.2s
; CHECK-NEXT:    umull v1.2d, v4.2s, v2.2s
; CHECK-NEXT:    ret
entry:
  %in1 = zext <4 x i32> %src1 to <4 x i64>
  %in2 = and <4 x i64> %src2, <i64 255, i64 255, i64 255, i64 255>
  %out = mul nsw <4 x i64> %in1, %in2
  ret <4 x i64> %out
}

define <4 x i64> @umull_and_v4i64_dup(<4 x i32> %src1, i64 %src2) {
; CHECK-LABEL: umull_and_v4i64_dup:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    and w8, w0, #0xff
; CHECK-NEXT:    dup v2.4s, w8
; CHECK-NEXT:    umull2 v1.2d, v0.4s, v2.4s
; CHECK-NEXT:    umull v0.2d, v0.2s, v2.2s
; CHECK-NEXT:    ret
entry:
  %in1 = zext <4 x i32> %src1 to <4 x i64>
  %in2 = and i64 %src2, 255
  %broadcast.splatinsert = insertelement <4 x i64> undef, i64 %in2, i64 0
  %broadcast.splat = shufflevector <4 x i64> %broadcast.splatinsert, <4 x i64> undef, <4 x i32> zeroinitializer
  %out = mul nsw <4 x i64> %in1, %broadcast.splat
  ret <4 x i64> %out
}
