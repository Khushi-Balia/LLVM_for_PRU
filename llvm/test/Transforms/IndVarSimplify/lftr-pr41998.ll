; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=indvars -S | FileCheck %s

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

define void @test_int(i32 %start, ptr %p) {
; CHECK-LABEL: @test_int(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = trunc i32 [[START:%.*]] to i3
; CHECK-NEXT:    [[TMP1:%.*]] = sub i3 0, [[TMP0]]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[I2:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[I2_INC:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[I2_INC]] = add nuw nsw i32 [[I2]], 1
; CHECK-NEXT:    store volatile i32 [[I2_INC]], ptr [[P:%.*]], align 4
; CHECK-NEXT:    [[LFTR_WIDEIV:%.*]] = trunc i32 [[I2_INC]] to i3
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i3 [[LFTR_WIDEIV]], [[TMP1]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[END:%.*]], label [[LOOP]]
; CHECK:       end:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %i = phi i32 [ %start, %entry ], [ %i.inc, %loop ]
  %i2 = phi i32 [ 0, %entry ], [ %i2.inc, %loop ]
  %i.inc = add nuw i32 %i, 1
  %i2.inc = add nuw i32 %i2, 1
  store volatile i32 %i2.inc, ptr %p
  %and = and i32 %i.inc, 7
  %cmp = icmp eq i32 %and, 0
  br i1 %cmp, label %end, label %loop

end:
  ret void
}

@data = global [256 x i8] zeroinitializer

define void @test_ptr(i32 %start) {
; CHECK-LABEL: @test_ptr(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = trunc i32 [[START:%.*]] to i3
; CHECK-NEXT:    [[TMP1:%.*]] = sub i3 -1, [[TMP0]]
; CHECK-NEXT:    [[TMP2:%.*]] = zext i3 [[TMP1]] to i64
; CHECK-NEXT:    [[TMP3:%.*]] = add nuw nsw i64 [[TMP2]], 1
; CHECK-NEXT:    [[UGLYGEP:%.*]] = getelementptr i8, ptr @data, i64 [[TMP3]]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[P:%.*]] = phi ptr [ @data, [[ENTRY:%.*]] ], [ [[P_INC:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[P_INC]] = getelementptr inbounds i8, ptr [[P]], i64 1
; CHECK-NEXT:    store volatile i8 0, ptr [[P_INC]], align 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq ptr [[P_INC]], [[UGLYGEP]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[END:%.*]], label [[LOOP]]
; CHECK:       end:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %i = phi i32 [ %start, %entry ], [ %i.inc, %loop ]
  %p = phi ptr [ @data, %entry ], [ %p.inc, %loop ]
  %i.inc = add nuw i32 %i, 1
  %p.inc = getelementptr inbounds i8, ptr %p, i64 1
  store volatile i8 0, ptr %p.inc
  %and = and i32 %i.inc, 7
  %cmp = icmp eq i32 %and, 0
  br i1 %cmp, label %end, label %loop

end:
  ret void
}
