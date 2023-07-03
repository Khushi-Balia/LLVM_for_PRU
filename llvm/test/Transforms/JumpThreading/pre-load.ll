; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=jump-threading -S < %s | FileCheck %s

@x = global i32 0
@y = global i32 0

declare void @f()
declare void @g()

define i32 @pre(i1 %cond, i32 %n) {
; CHECK-LABEL: @pre(
; CHECK-NEXT:    br i1 [[COND:%.*]], label [[C_THREAD:%.*]], label [[C:%.*]]
; CHECK:       C.thread:
; CHECK-NEXT:    store i32 0, ptr @x, align 4
; CHECK-NEXT:    br label [[YES:%.*]]
; CHECK:       C:
; CHECK-NEXT:    [[A_PR:%.*]] = load i32, ptr @y, align 4
; CHECK-NEXT:    [[COND2:%.*]] = icmp eq i32 [[A_PR]], 0
; CHECK-NEXT:    br i1 [[COND2]], label [[YES]], label [[NO:%.*]]
; CHECK:       YES:
; CHECK-NEXT:    [[A4:%.*]] = phi i32 [ 0, [[C_THREAD]] ], [ [[A_PR]], [[C]] ]
; CHECK-NEXT:    call void @f()
; CHECK-NEXT:    ret i32 [[A4]]
; CHECK:       NO:
; CHECK-NEXT:    call void @g()
; CHECK-NEXT:    ret i32 1
;
  br i1 %cond, label %A, label %B
A:
  store i32 0, ptr @x
  br label %C
B:
  br label %C
C:
  %ptr = phi ptr [@x, %A], [@y, %B]
  %a = load i32, ptr %ptr
  %cond2 = icmp eq i32 %a, 0
  br i1 %cond2, label %YES, label %NO
YES:
  call void @f()
  ret i32 %a
NO:
  call void @g()
  ret i32 1
}

define i32 @pre_freeze(i1 %cond, i32 %n) {
; CHECK-LABEL: @pre_freeze(
; CHECK-NEXT:    br i1 [[COND:%.*]], label [[C_THREAD:%.*]], label [[C:%.*]]
; CHECK:       C.thread:
; CHECK-NEXT:    store i32 0, ptr @x, align 4
; CHECK-NEXT:    br label [[YES:%.*]]
; CHECK:       C:
; CHECK-NEXT:    [[A_PR:%.*]] = load i32, ptr @y, align 4
; CHECK-NEXT:    [[COND2:%.*]] = icmp eq i32 [[A_PR]], 0
; CHECK-NEXT:    [[COND2_FR:%.*]] = freeze i1 [[COND2]]
; CHECK-NEXT:    br i1 [[COND2_FR]], label [[YES]], label [[NO:%.*]]
; CHECK:       YES:
; CHECK-NEXT:    [[A5:%.*]] = phi i32 [ 0, [[C_THREAD]] ], [ [[A_PR]], [[C]] ]
; CHECK-NEXT:    call void @f()
; CHECK-NEXT:    ret i32 [[A5]]
; CHECK:       NO:
; CHECK-NEXT:    call void @g()
; CHECK-NEXT:    ret i32 1
;
  br i1 %cond, label %A, label %B
A:
  store i32 0, ptr @x
  br label %C
B:
  br label %C
C:
  %ptr = phi ptr [@x, %A], [@y, %B]
  %a = load i32, ptr %ptr
  %cond2 = icmp eq i32 %a, 0
  %cond2.fr = freeze i1 %cond2
  br i1 %cond2.fr, label %YES, label %NO
YES:
  call void @f()
  ret i32 %a
NO:
  call void @g()
  ret i32 1
}
