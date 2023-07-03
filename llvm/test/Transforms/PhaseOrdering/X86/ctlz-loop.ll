; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -O1 -S -mattr=+lzcnt | FileCheck %s

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; This test ensures we are able to optimize the following loop to an llvm.abs
; followed by an llvm.ctlz.
; FIXME: LoopIdiom recongize is not forming llvm.ctlz.

; int ctlz_zero_check(int n)
; {
;   n = n >= 0 ? n : -n;
;   int i = 0;
;   while(n) {
;     n >>= 1;
;     i++;
;   }
;   return i;
; }

define i32 @ctlz_loop_with_abs(i32 %n) {
; CHECK-LABEL: @ctlz_loop_with_abs(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TOBOOL_NOT1:%.*]] = icmp eq i32 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[TOBOOL_NOT1]], label [[WHILE_END:%.*]], label [[WHILE_BODY_PREHEADER:%.*]]
; CHECK:       while.body.preheader:
; CHECK-NEXT:    [[TMP0:%.*]] = tail call i32 @llvm.abs.i32(i32 [[N]], i1 true)
; CHECK-NEXT:    br label [[WHILE_BODY:%.*]]
; CHECK:       while.body:
; CHECK-NEXT:    [[N_ADDR_03:%.*]] = phi i32 [ [[TMP1:%.*]], [[WHILE_BODY]] ], [ [[TMP0]], [[WHILE_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[I_02:%.*]] = phi i32 [ [[INC:%.*]], [[WHILE_BODY]] ], [ 0, [[WHILE_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[TMP1]] = lshr i32 [[N_ADDR_03]], 1
; CHECK-NEXT:    [[INC]] = add nuw nsw i32 [[I_02]], 1
; CHECK-NEXT:    [[TOBOOL_NOT:%.*]] = icmp ult i32 [[N_ADDR_03]], 2
; CHECK-NEXT:    br i1 [[TOBOOL_NOT]], label [[WHILE_END]], label [[WHILE_BODY]]
; CHECK:       while.end:
; CHECK-NEXT:    [[I_0_LCSSA:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[INC]], [[WHILE_BODY]] ]
; CHECK-NEXT:    ret i32 [[I_0_LCSSA]]
;
entry:
  %cmp = icmp sge i32 %n, 0
  br i1 %cmp, label %cond.true, label %cond.false

cond.true:                                        ; preds = %entry
  br label %cond.end

cond.false:                                       ; preds = %entry
  %sub = sub nsw i32 0, %n
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %n, %cond.true ], [ %sub, %cond.false ]
  br label %while.cond

while.cond:                                       ; preds = %while.body, %cond.end
  %i.0 = phi i32 [ 0, %cond.end ], [ %inc, %while.body ]
  %n.addr.0 = phi i32 [ %cond, %cond.end ], [ %shr, %while.body ]
  %tobool = icmp ne i32 %n.addr.0, 0
  br i1 %tobool, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %shr = ashr i32 %n.addr.0, 1
  %inc = add nsw i32 %i.0, 1
  br label %while.cond

while.end:                                        ; preds = %while.cond
  ret i32 %i.0
}
