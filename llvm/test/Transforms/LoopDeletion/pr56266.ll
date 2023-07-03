; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=loop-deletion < %s | FileCheck %s

define void @test() {
; CHECK-LABEL: @test(
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
  switch i16 0, label %loop [
  ]

loop:
  br i1 true, label %exit, label %loop

exit:
  ret void
}
