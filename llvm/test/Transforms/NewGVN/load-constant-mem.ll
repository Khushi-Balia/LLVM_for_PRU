; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=newgvn -S | FileCheck %s
; PR4189
@G = external constant [4 x i32]

define i32 @test(ptr %p, i32 %i) nounwind {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[P:%.*]] = getelementptr [4 x i32], ptr @G, i32 0, i32 [[I:%.*]]
; CHECK-NEXT:    store i8 4, ptr [[P:%.*]]
; CHECK-NEXT:    ret i32 0
;
entry:
  %P = getelementptr [4 x i32], ptr @G, i32 0, i32 %i
  %A = load i32, ptr %P
  store i8 4, ptr %p
  %B = load i32, ptr %P
  %C = sub i32 %A, %B
  ret i32 %C
}

