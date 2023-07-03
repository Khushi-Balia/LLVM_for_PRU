; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instsimplify -S | FileCheck %s

; This is not the mathlib call you were looking for.

declare double @sin(x86_fp80)

define double @PR50960(x86_fp80 %0) {
; CHECK-LABEL: @PR50960(
; CHECK-NEXT:    [[CALL:%.*]] = call double @sin(x86_fp80 0xK3FFF8000000000000000)
; CHECK-NEXT:    ret double [[CALL]]
;
  %call = call double @sin(x86_fp80 0xK3FFF8000000000000000)
  ret double %call
}
