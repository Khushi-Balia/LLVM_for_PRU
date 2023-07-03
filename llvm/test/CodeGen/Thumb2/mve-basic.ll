; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main -mattr=+mve.fp -o - %s | FileCheck %s
; RUN: llc -mtriple=thumbv8.1m.main -mattr=+mve -o - %s | FileCheck %s

define arm_aapcs_vfpcc <4 x i32> @vector_add_by_value(<4 x i32> %lhs, <4 x i32>%rhs) {
; CHECK-LABEL: vector_add_by_value:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    @APP
; CHECK-NEXT:    vadd.i32 q0, q0, q1
; CHECK-NEXT:    @NO_APP
; CHECK-NEXT:    bx lr
  %result = tail call <4 x i32> asm "vadd.i32 $0,$1,$2", "=t,t,t"(<4 x i32> %lhs, <4 x i32> %rhs)
  ret <4 x i32> %result
}

define void @vector_add_by_reference(ptr %resultp, ptr %lhsp, ptr %rhsp) {
; CHECK-LABEL: vector_add_by_reference:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldrw.u32 q0, [r1]
; CHECK-NEXT:    vldrw.u32 q1, [r2]
; CHECK-NEXT:    @APP
; CHECK-NEXT:    vadd.i32 q0, q0, q1
; CHECK-NEXT:    @NO_APP
; CHECK-NEXT:    vstrw.32 q0, [r0]
; CHECK-NEXT:    bx lr
  %lhs = load <4 x i32>, ptr %lhsp, align 16
  %rhs = load <4 x i32>, ptr %rhsp, align 16
  %result = tail call <4 x i32> asm "vadd.i32 $0,$1,$2", "=t,t,t"(<4 x i32> %lhs, <4 x i32> %rhs)
  store <4 x i32> %result, ptr %resultp, align 16
  ret void
}

define void @vector_f64_copy(ptr %from, ptr %to) {
; CHECK-LABEL: vector_f64_copy:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldrw.u32 q0, [r0]
; CHECK-NEXT:    vstrw.32 q0, [r1]
; CHECK-NEXT:    bx lr
  %v = load <2 x double>, ptr %from, align 16
  store <2 x double> %v, ptr %to, align 16
  ret void
}

define arm_aapcs_vfpcc <16 x i8> @stack_slot_handling(<16 x i8> %a) #0 {
; CHECK-LABEL: stack_slot_handling:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    sub sp, #16
; CHECK-NEXT:    mov r0, sp
; CHECK-NEXT:    vstrw.32 q0, [r0]
; CHECK-NEXT:    vldrw.u32 q0, [r0]
; CHECK-NEXT:    add sp, #16
; CHECK-NEXT:    bx lr
entry:
  %a.addr = alloca <16 x i8>, align 8
  store <16 x i8> %a, ptr %a.addr, align 8
  %0 = load <16 x i8>, ptr %a.addr, align 8
  ret <16 x i8> %0
}

attributes #0 = { noinline optnone }
