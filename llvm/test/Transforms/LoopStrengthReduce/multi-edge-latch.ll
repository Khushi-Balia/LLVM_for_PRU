; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -loop-reduce < %s | FileCheck %s

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"

define void @test(ptr %p.base, i8 %x) {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    switch i8 [[X:%.*]], label [[WHILE_END:%.*]] [
; CHECK-NEXT:    i8 10, label [[WHILE_BODY_PREHEADER:%.*]]
; CHECK-NEXT:    i8 20, label [[WHILE_BODY_PREHEADER]]
; CHECK-NEXT:    ]
; CHECK:       while.body.preheader:
; CHECK-NEXT:    [[SCEVGEP:%.*]] = getelementptr i8, ptr [[P_BASE:%.*]], i64 1
; CHECK-NEXT:    br label [[WHILE_BODY:%.*]]
; CHECK:       while.body:
; CHECK-NEXT:    [[LSR_IV:%.*]] = phi ptr [ [[SCEVGEP1:%.*]], [[WHILE_BODY_BACKEDGE:%.*]] ], [ [[SCEVGEP]], [[WHILE_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[Y:%.*]] = load i8, ptr [[LSR_IV]], align 1
; CHECK-NEXT:    switch i8 [[Y]], label [[WHILE_END_LOOPEXIT:%.*]] [
; CHECK-NEXT:    i8 10, label [[WHILE_BODY_BACKEDGE]]
; CHECK-NEXT:    i8 20, label [[WHILE_BODY_BACKEDGE]]
; CHECK-NEXT:    ]
; CHECK:       while.body.backedge:
; CHECK-NEXT:    [[SCEVGEP1]] = getelementptr i8, ptr [[LSR_IV]], i64 1
; CHECK-NEXT:    br label [[WHILE_BODY]]
; CHECK:       while.end.loopexit:
; CHECK-NEXT:    br label [[WHILE_END]]
; CHECK:       while.end:
; CHECK-NEXT:    ret void
;
entry:
  switch i8 %x, label %while.end [
  i8 10, label %while.body
  i8 20, label %while.body
  ]

while.body:
  %p = phi ptr [ %p.inc, %while.body ], [ %p.inc, %while.body ], [ %p.base, %entry ], [ %p.base, %entry ]
  %p.inc = getelementptr inbounds i8, ptr %p, i64 1
  %y = load i8, ptr %p.inc, align 1
  switch i8 %y, label %while.end [
  i8 10, label %while.body
  i8 20, label %while.body
  ]

while.end:
  ret void
}
