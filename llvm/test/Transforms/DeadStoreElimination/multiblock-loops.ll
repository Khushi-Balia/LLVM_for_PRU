; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=dse -S | FileCheck %s

target datalayout = "e-m:e-p:32:32-i64:64-v128:64:128-a:0:32-n32-S64"
declare void @llvm.memset.p0.i64(ptr nocapture, i8, i64, i32, i1) nounwind

define void @test13(ptr noalias %P) {
; CHECK-LABEL: @test13(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR:%.*]]
; CHECK:       for:
; CHECK-NEXT:    store i32 0, ptr [[P:%.*]], align 4
; CHECK-NEXT:    br i1 false, label [[FOR]], label [[END:%.*]]
; CHECK:       end:
; CHECK-NEXT:    ret void
;
entry:
  br label %for
for:
  store i32 0, ptr %P
  br i1 false, label %for, label %end
end:
  ret void
}


define void @test14(ptr noalias %P) {
; CHECK-LABEL: @test14(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR:%.*]]
; CHECK:       for:
; CHECK-NEXT:    store i32 0, ptr [[P:%.*]], align 4
; CHECK-NEXT:    br i1 false, label [[FOR]], label [[END:%.*]]
; CHECK:       end:
; CHECK-NEXT:    ret void
;
entry:
  store i32 1, ptr %P
  br label %for
for:
  store i32 0, ptr %P
  br i1 false, label %for, label %end
end:
  ret void
}

define void @test18(ptr noalias %P) {
; CHECK-LABEL: @test18(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store i32 0, ptr [[P:%.*]], align 4
; CHECK-NEXT:    br label [[FOR:%.*]]
; CHECK:       for:
; CHECK-NEXT:    store i8 1, ptr [[P]], align 1
; CHECK-NEXT:    [[X:%.*]] = load i32, ptr [[P]], align 4
; CHECK-NEXT:    store i8 2, ptr [[P]], align 1
; CHECK-NEXT:    br i1 false, label [[FOR]], label [[END:%.*]]
; CHECK:       end:
; CHECK-NEXT:    ret void
;
entry:
  store i32 0, ptr %P
  br label %for
for:
  store i8 1, ptr %P
  %x = load i32, ptr %P
  store i8 2, ptr %P
  br i1 false, label %for, label %end
end:
  ret void
}

define void @test21(ptr noalias %P) {
; CHECK-LABEL: @test21(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ARRAYIDX0:%.*]] = getelementptr inbounds i32, ptr [[P:%.*]], i64 1
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds i8, ptr [[ARRAYIDX0]], i64 4
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 4 [[TMP0]], i8 0, i64 24, i1 false)
; CHECK-NEXT:    br label [[FOR:%.*]]
; CHECK:       for:
; CHECK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds i32, ptr [[P]], i64 1
; CHECK-NEXT:    store i32 1, ptr [[ARRAYIDX1]], align 4
; CHECK-NEXT:    br i1 false, label [[FOR]], label [[END:%.*]]
; CHECK:       end:
; CHECK-NEXT:    ret void
;
entry:
  %arrayidx0 = getelementptr inbounds i32, ptr %P, i64 1
  call void @llvm.memset.p0.i64(ptr %arrayidx0, i8 0, i64 28, i32 4, i1 false)
  br label %for
for:
  %arrayidx1 = getelementptr inbounds i32, ptr %P, i64 1
  store i32 1, ptr %arrayidx1, align 4
  br i1 false, label %for, label %end
end:
  ret void
}

define void @test_loop(i32 %N, ptr noalias nocapture readonly %A, ptr noalias nocapture readonly %x, ptr noalias nocapture %b) local_unnamed_addr {
; CHECK-LABEL: @test_loop(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP27:%.*]] = icmp sgt i32 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP27]], label [[FOR_BODY4_LR_PH_PREHEADER:%.*]], label [[FOR_COND_CLEANUP:%.*]]
; CHECK:       for.body4.lr.ph.preheader:
; CHECK-NEXT:    br label [[FOR_BODY4_LR_PH:%.*]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    ret void
; CHECK:       for.body4.lr.ph:
; CHECK-NEXT:    [[I_028:%.*]] = phi i32 [ [[INC11:%.*]], [[FOR_COND_CLEANUP3:%.*]] ], [ 0, [[FOR_BODY4_LR_PH_PREHEADER]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, ptr [[B:%.*]], i32 [[I_028]]
; CHECK-NEXT:    [[MUL:%.*]] = mul nsw i32 [[I_028]], [[N]]
; CHECK-NEXT:    br label [[FOR_BODY4:%.*]]
; CHECK:       for.body4:
; CHECK-NEXT:    [[TMP0:%.*]] = phi i32 [ 0, [[FOR_BODY4_LR_PH]] ], [ [[ADD9:%.*]], [[FOR_BODY4]] ]
; CHECK-NEXT:    [[J_026:%.*]] = phi i32 [ 0, [[FOR_BODY4_LR_PH]] ], [ [[INC:%.*]], [[FOR_BODY4]] ]
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[J_026]], [[MUL]]
; CHECK-NEXT:    [[ARRAYIDX5:%.*]] = getelementptr inbounds i32, ptr [[A:%.*]], i32 [[ADD]]
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr [[ARRAYIDX5]], align 4
; CHECK-NEXT:    [[ARRAYIDX6:%.*]] = getelementptr inbounds i32, ptr [[X:%.*]], i32 [[J_026]]
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr [[ARRAYIDX6]], align 4
; CHECK-NEXT:    [[MUL7:%.*]] = mul nsw i32 [[TMP2]], [[TMP1]]
; CHECK-NEXT:    [[ADD9]] = add nsw i32 [[MUL7]], [[TMP0]]
; CHECK-NEXT:    [[INC]] = add nuw nsw i32 [[J_026]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[INC]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP3]], label [[FOR_BODY4]]
; CHECK:       for.cond.cleanup3:
; CHECK-NEXT:    store i32 [[ADD9]], ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[INC11]] = add nuw nsw i32 [[I_028]], 1
; CHECK-NEXT:    [[EXITCOND29:%.*]] = icmp eq i32 [[INC11]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND29]], label [[FOR_COND_CLEANUP]], label [[FOR_BODY4_LR_PH]]
;
entry:
  %cmp27 = icmp sgt i32 %N, 0
  br i1 %cmp27, label %for.body4.lr.ph.preheader, label %for.cond.cleanup

for.body4.lr.ph.preheader:                        ; preds = %entry
  br label %for.body4.lr.ph

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3, %entry
  ret void

for.body4.lr.ph:                                  ; preds = %for.body4.lr.ph.preheader, %for.cond.cleanup3
  %i.028 = phi i32 [ %inc11, %for.cond.cleanup3 ], [ 0, %for.body4.lr.ph.preheader ]
  %arrayidx = getelementptr inbounds i32, ptr %b, i32 %i.028
  store i32 0, ptr %arrayidx, align 4
  %mul = mul nsw i32 %i.028, %N
  br label %for.body4

for.body4:                                        ; preds = %for.body4, %for.body4.lr.ph
  %0 = phi i32 [ 0, %for.body4.lr.ph ], [ %add9, %for.body4 ]
  %j.026 = phi i32 [ 0, %for.body4.lr.ph ], [ %inc, %for.body4 ]
  %add = add nsw i32 %j.026, %mul
  %arrayidx5 = getelementptr inbounds i32, ptr %A, i32 %add
  %1 = load i32, ptr %arrayidx5, align 4
  %arrayidx6 = getelementptr inbounds i32, ptr %x, i32 %j.026
  %2 = load i32, ptr %arrayidx6, align 4
  %mul7 = mul nsw i32 %2, %1
  %add9 = add nsw i32 %mul7, %0
  %inc = add nuw nsw i32 %j.026, 1
  %exitcond = icmp eq i32 %inc, %N
  br i1 %exitcond, label %for.cond.cleanup3, label %for.body4

for.cond.cleanup3:                                ; preds = %for.body4
  store i32 %add9, ptr %arrayidx, align 4
  %inc11 = add nuw nsw i32 %i.028, 1
  %exitcond29 = icmp eq i32 %inc11, %N
  br i1 %exitcond29, label %for.cond.cleanup, label %for.body4.lr.ph
}

define i32 @test_if(i1 %c, ptr %p, i32 %i) {
; CHECK-LABEL: @test_if(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[BB1:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    [[PH:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[INC:%.*]], [[BB3:%.*]] ]
; CHECK-NEXT:    [[INC]] = add i32 [[PH]], 1
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds i32, ptr [[P:%.*]], i32 [[PH]]
; CHECK-NEXT:    br i1 [[C:%.*]], label [[BB2:%.*]], label [[BB3]]
; CHECK:       bb2:
; CHECK-NEXT:    br label [[BB3]]
; CHECK:       bb3:
; CHECK-NEXT:    store i32 2, ptr [[GEP]], align 4
; CHECK-NEXT:    [[C1:%.*]] = icmp slt i32 [[PH]], 10
; CHECK-NEXT:    br i1 [[C1]], label [[BB1]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 0
;
entry:
  br label %bb1
bb1:
  %ph = phi i32 [ 0, %entry ], [ %inc, %bb3 ]
  %inc = add i32 %ph, 1
  %gep = getelementptr inbounds i32, ptr %p, i32 %ph
  store i32 %i, ptr %gep, align 4
  br i1 %c, label %bb2, label %bb3
bb2:
  br label %bb3
bb3:
  store i32 2, ptr %gep, align 4
  %c1 = icmp slt i32 %ph, 10
  br i1 %c1, label %bb1, label %exit
exit:
  ret i32 0
}

define i32 @test_if2(i1 %c, ptr %p, i32 %i) {
; CHECK-LABEL: @test_if2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[BB1:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    [[PH:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[INC:%.*]], [[BB2:%.*]] ], [ [[INC]], [[BB3:%.*]] ]
; CHECK-NEXT:    [[INC]] = add i32 [[PH]], 1
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds i32, ptr [[P:%.*]], i32 [[PH]]
; CHECK-NEXT:    br i1 [[C:%.*]], label [[BB2]], label [[BB3]]
; CHECK:       bb2:
; CHECK-NEXT:    store i32 2, ptr [[GEP]], align 4
; CHECK-NEXT:    [[C1:%.*]] = icmp slt i32 [[PH]], 10
; CHECK-NEXT:    br i1 [[C1]], label [[BB1]], label [[EXIT:%.*]]
; CHECK:       bb3:
; CHECK-NEXT:    store i32 3, ptr [[GEP]], align 4
; CHECK-NEXT:    [[C2:%.*]] = icmp slt i32 [[PH]], 5
; CHECK-NEXT:    br i1 [[C2]], label [[BB1]], label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 0
;
entry:
  br label %bb1
bb1:
  %ph = phi i32 [ 0, %entry ], [ %inc, %bb2 ], [ %inc, %bb3 ]
  %inc = add i32 %ph, 1
  %gep = getelementptr inbounds i32, ptr %p, i32 %ph
  store i32 %i, ptr %gep, align 4
  br i1 %c, label %bb2, label %bb3
bb2:
  store i32 2, ptr %gep, align 4
  %c1 = icmp slt i32 %ph, 10
  br i1 %c1, label %bb1, label %exit
bb3:
  store i32 3, ptr %gep, align 4
  %c2 = icmp slt i32 %ph, 5
  br i1 %c2, label %bb1, label %exit
exit:
  ret i32 0
}

define i32 @test_if3(i1 %c, ptr %p, i32 %i) {
; CHECK-LABEL: @test_if3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[BB1:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    [[PH:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[INC:%.*]], [[BB3:%.*]] ]
; CHECK-NEXT:    [[INC]] = add i32 [[PH]], 1
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds i32, ptr [[P:%.*]], i32 [[PH]]
; CHECK-NEXT:    store i32 [[I:%.*]], ptr [[GEP]], align 4
; CHECK-NEXT:    br i1 [[C:%.*]], label [[BB2:%.*]], label [[BB3]]
; CHECK:       bb2:
; CHECK-NEXT:    store i32 2, ptr [[GEP]], align 4
; CHECK-NEXT:    br label [[BB3]]
; CHECK:       bb3:
; CHECK-NEXT:    [[C1:%.*]] = icmp slt i32 [[PH]], 10
; CHECK-NEXT:    br i1 [[C1]], label [[BB1]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 0
;
entry:
  br label %bb1
bb1:
  %ph = phi i32 [ 0, %entry ], [ %inc, %bb3 ]
  %inc = add i32 %ph, 1
  %gep = getelementptr inbounds i32, ptr %p, i32 %ph
  store i32 %i, ptr %gep, align 4
  br i1 %c, label %bb2, label %bb3
bb2:
  store i32 2, ptr %gep, align 4
  br label %bb3
bb3:
  %c1 = icmp slt i32 %ph, 10
  br i1 %c1, label %bb1, label %exit
exit:
  ret i32 0
}

define i32 @test_if4(i1 %c, ptr %p, i32 %i) {
; CHECK-LABEL: @test_if4(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[BB1:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    [[PH:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[INC:%.*]], [[BB1]] ], [ [[INC]], [[BB2:%.*]] ]
; CHECK-NEXT:    [[INC]] = add i32 [[PH]], 1
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds i32, ptr [[P:%.*]], i32 [[PH]]
; CHECK-NEXT:    store i32 [[I:%.*]], ptr [[GEP]], align 4
; CHECK-NEXT:    br i1 [[C:%.*]], label [[BB2]], label [[BB1]]
; CHECK:       bb2:
; CHECK-NEXT:    store i32 2, ptr [[GEP]], align 4
; CHECK-NEXT:    [[C1:%.*]] = icmp slt i32 [[PH]], 10
; CHECK-NEXT:    br i1 [[C1]], label [[BB1]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 0
;
entry:
  br label %bb1
bb1:
  %ph = phi i32 [ 0, %entry ], [ %inc, %bb1 ], [ %inc, %bb2 ]
  %inc = add i32 %ph, 1
  %gep = getelementptr inbounds i32, ptr %p, i32 %ph
  store i32 %i, ptr %gep, align 4
  br i1 %c, label %bb2, label %bb1
bb2:
  store i32 2, ptr %gep, align 4
  %c1 = icmp slt i32 %ph, 10
  br i1 %c1, label %bb1, label %exit
exit:
  ret i32 0
}

declare void @clobber()
define i32 @test_self(i1 %c, ptr %p, i32 %i) {
; CHECK-LABEL: @test_self(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[BB1:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    [[PH:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[INC:%.*]], [[BB1]] ], [ [[INC]], [[BB2:%.*]] ]
; CHECK-NEXT:    [[INC]] = add i32 [[PH]], 1
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds i32, ptr [[P:%.*]], i32 [[PH]]
; CHECK-NEXT:    store i32 1, ptr [[GEP]], align 4
; CHECK-NEXT:    call void @clobber()
; CHECK-NEXT:    store i32 2, ptr [[GEP]], align 4
; CHECK-NEXT:    br i1 [[C:%.*]], label [[BB2]], label [[BB1]]
; CHECK:       bb2:
; CHECK-NEXT:    store i32 3, ptr [[GEP]], align 4
; CHECK-NEXT:    [[C1:%.*]] = icmp slt i32 [[PH]], 10
; CHECK-NEXT:    br i1 [[C1]], label [[BB1]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 0
;
entry:
  br label %bb1
bb1:
  %ph = phi i32 [ 0, %entry ], [ %inc, %bb1 ], [ %inc, %bb2 ]
  %inc = add i32 %ph, 1
  %gep = getelementptr inbounds i32, ptr %p, i32 %ph
  store i32 1, ptr %gep, align 4
  call void @clobber()
  store i32 2, ptr %gep, align 4
  br i1 %c, label %bb2, label %bb1
bb2:
  store i32 3, ptr %gep, align 4
  %c1 = icmp slt i32 %ph, 10
  br i1 %c1, label %bb1, label %exit
exit:
  ret i32 0
}

define i32 @test_selfalloca(i1 %c, i32 %i) {
; CHECK-LABEL: @test_selfalloca(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[P:%.*]] = alloca i32, align 4
; CHECK-NEXT:    br label [[BB1:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    [[PH:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[INC:%.*]], [[BB1]] ], [ [[INC]], [[BB2:%.*]] ]
; CHECK-NEXT:    [[INC]] = add i32 [[PH]], 1
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds i32, ptr [[P]], i32 [[PH]]
; CHECK-NEXT:    call void @clobber()
; CHECK-NEXT:    store i32 2, ptr [[GEP]], align 4
; CHECK-NEXT:    br i1 [[C:%.*]], label [[BB2]], label [[BB1]]
; CHECK:       bb2:
; CHECK-NEXT:    store i32 3, ptr [[GEP]], align 4
; CHECK-NEXT:    [[C1:%.*]] = icmp slt i32 [[PH]], 10
; CHECK-NEXT:    br i1 [[C1]], label [[BB1]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    [[PG:%.*]] = getelementptr inbounds i32, ptr [[P]], i32 [[I:%.*]]
; CHECK-NEXT:    [[L:%.*]] = load i32, ptr [[PG]], align 4
; CHECK-NEXT:    ret i32 [[L]]
;
entry:
  %p = alloca i32, align 4
  br label %bb1
bb1:
  %ph = phi i32 [ 0, %entry ], [ %inc, %bb1 ], [ %inc, %bb2 ]
  %inc = add i32 %ph, 1
  %gep = getelementptr inbounds i32, ptr %p, i32 %ph
  store i32 1, ptr %gep, align 4
  call void @clobber()
  store i32 2, ptr %gep, align 4
  br i1 %c, label %bb2, label %bb1
bb2:
  store i32 3, ptr %gep, align 4
  %c1 = icmp slt i32 %ph, 10
  br i1 %c1, label %bb1, label %exit
exit:
  %pg = getelementptr inbounds i32, ptr %p, i32 %i
  %l = load i32, ptr %pg
  ret i32 %l
}

declare i1 @cond() readnone nounwind

define void @loop_multiple_def_uses(ptr noalias %P) {
; CHECK-LABEL: @loop_multiple_def_uses(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_HEADER:%.*]]
; CHECK:       for.header:
; CHECK-NEXT:    [[C1:%.*]] = call i1 @cond()
; CHECK-NEXT:    br i1 [[C1]], label [[FOR_BODY:%.*]], label [[END:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    store i32 2, ptr [[P:%.*]], align 4
; CHECK-NEXT:    [[LV:%.*]] = load i32, ptr [[P]], align 4
; CHECK-NEXT:    br label [[FOR_HEADER]]
; CHECK:       end:
; CHECK-NEXT:    store i32 3, ptr [[P]], align 4
; CHECK-NEXT:    ret void
;
entry:
  br label %for.header

for.header:
  store i32 1, ptr %P, align 4
  %c1 = call i1 @cond()
  br i1 %c1, label %for.body, label %end

for.body:
  store i32 2, ptr %P, align 4
  %lv = load i32, ptr %P
  br label %for.header

end:
  store i32 3, ptr %P, align 4
  ret void
}

; We cannot eliminate the store in for.header, as it is only partially
; overwritten in for.body and read afterwards.
define void @loop_multiple_def_uses_partial_write(ptr noalias %p) {
; CHECK-LABEL: @loop_multiple_def_uses_partial_write(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_HEADER:%.*]]
; CHECK:       for.header:
; CHECK-NEXT:    store i32 1239297, ptr [[P:%.*]], align 4
; CHECK-NEXT:    [[C1:%.*]] = call i1 @cond()
; CHECK-NEXT:    br i1 [[C1]], label [[FOR_BODY:%.*]], label [[END:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[LV:%.*]] = load i32, ptr [[P]], align 4
; CHECK-NEXT:    br label [[FOR_HEADER]]
; CHECK:       end:
; CHECK-NEXT:    store i32 3, ptr [[P]], align 4
; CHECK-NEXT:    ret void
;
entry:
  br label %for.header

for.header:
  store i32 1239491, ptr %p, align 4
  %c1 = call i1 @cond()
  br i1 %c1, label %for.body, label %end

for.body:
  store i8 1, ptr %p, align 4
  %lv = load i32, ptr %p
  br label %for.header

end:
  store i32 3, ptr %p, align 4
  ret void
}

; We cannot eliminate the store in for.header, as the location is not overwritten
; in for.body and read afterwards.
define void @loop_multiple_def_uses_mayalias_write(ptr %p, ptr %q) {
; CHECK-LABEL: @loop_multiple_def_uses_mayalias_write(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_HEADER:%.*]]
; CHECK:       for.header:
; CHECK-NEXT:    store i32 1239491, ptr [[P:%.*]], align 4
; CHECK-NEXT:    [[C1:%.*]] = call i1 @cond()
; CHECK-NEXT:    br i1 [[C1]], label [[FOR_BODY:%.*]], label [[END:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    store i32 1, ptr [[Q:%.*]], align 4
; CHECK-NEXT:    [[LV:%.*]] = load i32, ptr [[P]], align 4
; CHECK-NEXT:    br label [[FOR_HEADER]]
; CHECK:       end:
; CHECK-NEXT:    store i32 3, ptr [[P]], align 4
; CHECK-NEXT:    ret void
;
entry:
  br label %for.header

for.header:
  store i32 1239491, ptr %p, align 4
  %c1 = call i1 @cond()
  br i1 %c1, label %for.body, label %end

for.body:
  store i32 1, ptr %q, align 4
  %lv = load i32, ptr %p
  br label %for.header

end:
  store i32 3, ptr %p, align 4
  ret void
}

%struct.hoge = type { i32, i32 }

@global = external local_unnamed_addr global ptr, align 8

define void @widget(ptr %tmp) {
; CHECK-LABEL: @widget(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr align 1 [[TMP:%.*]], ptr nonnull align 16 undef, i64 64, i1 false)
; CHECK-NEXT:    br label [[BB1:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    [[TMP2:%.*]] = load ptr, ptr @global, align 8
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds [[STRUCT_HOGE:%.*]], ptr [[TMP2]], i64 undef, i32 1
; CHECK-NEXT:    store i32 0, ptr [[TMP3]], align 4
; CHECK-NEXT:    [[TMP4:%.*]] = load ptr, ptr @global, align 8
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds [[STRUCT_HOGE]], ptr [[TMP4]], i64 undef, i32 1
; CHECK-NEXT:    store i32 10, ptr [[TMP5]], align 4
; CHECK-NEXT:    br label [[BB1]]
;
bb:
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %tmp, ptr nonnull align 16 undef, i64 64, i1 false)
  br label %bb1

bb1:                                              ; preds = %bb1, %bb
  %tmp2 = load ptr, ptr @global, align 8
  %tmp3 = getelementptr inbounds %struct.hoge, ptr %tmp2, i64 undef, i32 1
  store i32 0, ptr %tmp3, align 4
  %tmp4 = load ptr, ptr @global, align 8
  %tmp5 = getelementptr inbounds %struct.hoge, ptr %tmp4, i64 undef, i32 1
  store i32 10, ptr %tmp5, align 4
  br label %bb1
}

declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg)

@x = global [10 x i16] zeroinitializer, align 1

; Make sure we do not eliminate the store in %do.body, because it writes to
; multiple locations in the loop and the store in %if.end10 only stores to
; the last one.
define i16 @test_loop_carried_dep() {
; CHECK-LABEL: @test_loop_carried_dep(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[DO_BODY:%.*]]
; CHECK:       do.body:
; CHECK-NEXT:    [[I_0:%.*]] = phi i16 [ 0, [[ENTRY:%.*]] ], [ [[INC:%.*]], [[IF_END:%.*]] ]
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds [10 x i16], ptr @x, i16 0, i16 [[I_0]]
; CHECK-NEXT:    store i16 2, ptr [[ARRAYIDX2]], align 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i16 [[I_0]], 4
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[IF_END10:%.*]], label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    [[INC]] = add nuw nsw i16 [[I_0]], 1
; CHECK-NEXT:    br label [[DO_BODY]]
; CHECK:       if.end10:
; CHECK-NEXT:    store i16 1, ptr [[ARRAYIDX2]], align 1
; CHECK-NEXT:    ret i16 0
;
entry:
  br label %do.body

do.body:                                          ; preds = %if.end, %entry
  %i.0 = phi i16 [ 0, %entry ], [ %inc, %if.end ]
  %arrayidx2 = getelementptr inbounds [10 x i16], ptr @x, i16 0, i16 %i.0
  store i16 2, ptr %arrayidx2, align 1
  %exitcond = icmp eq i16 %i.0, 4
  br i1 %exitcond, label %if.end10, label %if.end

if.end:                                           ; preds = %do.body
  %inc = add nuw nsw i16 %i.0, 1
  br label %do.body

if.end10:                                         ; preds = %do.body
  store i16 1, ptr %arrayidx2, align 1
  ret i16 0
}

; Similar to above, but with an irreducible loop. The stores should not be removed.
define i16 @irreducible(i1 %c) {
; CHECK-LABEL: @irreducible(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[A:%.*]], label [[B:%.*]]
; CHECK:       A:
; CHECK-NEXT:    [[I_0:%.*]] = phi i16 [ 0, [[ENTRY:%.*]] ], [ [[INC:%.*]], [[B]] ]
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds [10 x i16], ptr @x, i16 0, i16 [[I_0]]
; CHECK-NEXT:    br label [[B]]
; CHECK:       B:
; CHECK-NEXT:    [[J_0:%.*]] = phi i16 [ 0, [[ENTRY]] ], [ [[I_0]], [[A]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [10 x i16], ptr @x, i16 0, i16 [[J_0]]
; CHECK-NEXT:    store i16 2, ptr [[ARRAYIDX]], align 1
; CHECK-NEXT:    [[INC]] = add nuw nsw i16 [[J_0]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i16 [[J_0]], 4
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[EXIT:%.*]], label [[A]]
; CHECK:       exit:
; CHECK-NEXT:    store i16 1, ptr [[ARRAYIDX]], align 1
; CHECK-NEXT:    ret i16 0
;
entry:
  br i1 %c, label %A, label %B

A:
  %i.0 = phi i16 [ 0, %entry ], [ %inc, %B ]
  %arrayidx2 = getelementptr inbounds [10 x i16], ptr @x, i16 0, i16 %i.0
  br label %B

B:
  %j.0 = phi i16 [ 0, %entry ], [ %i.0, %A ]
  %arrayidx = getelementptr inbounds [10 x i16], ptr @x, i16 0, i16 %j.0
  store i16 2, ptr %arrayidx, align 1
  %inc = add nuw nsw i16 %j.0, 1
  %exitcond = icmp eq i16 %j.0, 4
  br i1 %exitcond, label %exit, label %A

exit:
  store i16 1, ptr %arrayidx, align 1
  ret i16 0
}

define i16 @irreducible_entryblock_def(i1 %c) {
; CHECK-LABEL: @irreducible_entryblock_def(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[A:%.*]], label [[B:%.*]]
; CHECK:       A:
; CHECK-NEXT:    br label [[B]]
; CHECK:       B:
; CHECK-NEXT:    br i1 [[C]], label [[EXIT:%.*]], label [[A]]
; CHECK:       exit:
; CHECK-NEXT:    ret i16 0
;
entry:
  %obj = alloca i32, align 4
  br i1 %c, label %A, label %B

A:
  store i32 1, ptr %obj, align 4
  br label %B

B:
  br i1 %c, label %exit, label %A

exit:
  ret i16 0
}

; An irreducible loop inside another loop.
define i16 @irreducible_nested() {
; CHECK-LABEL: @irreducible_nested(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[OUTER:%.*]]
; CHECK:       outer:
; CHECK-NEXT:    [[X:%.*]] = phi i16 [ 0, [[ENTRY:%.*]] ], [ [[INCX:%.*]], [[OUTERL:%.*]] ]
; CHECK-NEXT:    [[C:%.*]] = icmp sgt i16 [[X]], 2
; CHECK-NEXT:    br i1 [[C]], label [[A:%.*]], label [[B:%.*]]
; CHECK:       A:
; CHECK-NEXT:    [[I_0:%.*]] = phi i16 [ 0, [[OUTER]] ], [ [[INC:%.*]], [[B]] ]
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds [10 x i16], ptr @x, i16 0, i16 [[I_0]]
; CHECK-NEXT:    br label [[B]]
; CHECK:       B:
; CHECK-NEXT:    [[J_0:%.*]] = phi i16 [ 0, [[OUTER]] ], [ [[I_0]], [[A]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [10 x i16], ptr @x, i16 0, i16 [[J_0]]
; CHECK-NEXT:    store i16 2, ptr [[ARRAYIDX]], align 1
; CHECK-NEXT:    [[INC]] = add nuw nsw i16 [[J_0]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i16 [[J_0]], 4
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[OUTERL]], label [[A]]
; CHECK:       outerl:
; CHECK-NEXT:    store i16 1, ptr [[ARRAYIDX]], align 1
; CHECK-NEXT:    [[INCX]] = add nuw nsw i16 [[X]], 1
; CHECK-NEXT:    [[EXITCONDX:%.*]] = icmp eq i16 [[X]], 4
; CHECK-NEXT:    br i1 [[EXITCONDX]], label [[END:%.*]], label [[OUTER]]
; CHECK:       end:
; CHECK-NEXT:    ret i16 0
;
entry:
  br label %outer

outer:
  %x = phi i16 [ 0, %entry ], [ %incx, %outerl ]
  %c = icmp sgt i16 %x, 2
  br i1 %c, label %A, label %B

A:
  %i.0 = phi i16 [ 0, %outer ], [ %inc, %B ]
  %arrayidx2 = getelementptr inbounds [10 x i16], ptr @x, i16 0, i16 %i.0
  br label %B

B:
  %j.0 = phi i16 [ 0, %outer ], [ %i.0, %A ]
  %arrayidx = getelementptr inbounds [10 x i16], ptr @x, i16 0, i16 %j.0
  store i16 2, ptr %arrayidx, align 1
  %inc = add nuw nsw i16 %j.0, 1
  %exitcond = icmp eq i16 %j.0, 4
  br i1 %exitcond, label %outerl, label %A

outerl:
  store i16 1, ptr %arrayidx, align 1
  %incx = add nuw nsw i16 %x, 1
  %exitcondx = icmp eq i16 %x, 4
  br i1 %exitcondx, label %end, label %outer

end:
  ret i16 0
}

define i16 @multi_overwrite(i1 %cond) {
; CHECK-LABEL: @multi_overwrite(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[DO_BODY:%.*]]
; CHECK:       do.body:
; CHECK-NEXT:    [[I_0:%.*]] = phi i16 [ 0, [[ENTRY:%.*]] ], [ [[INC:%.*]], [[IF_END2:%.*]] ]
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds [10 x i16], ptr @x, i16 0, i16 [[I_0]]
; CHECK-NEXT:    store i16 2, ptr [[ARRAYIDX2]], align 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i16 [[I_0]], 4
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[EXIT:%.*]], label [[IF_END:%.*]]
; CHECK:       if.end:
; CHECK-NEXT:    br i1 [[COND:%.*]], label [[DO_STORE:%.*]], label [[IF_END2]]
; CHECK:       do.store:
; CHECK-NEXT:    store i16 3, ptr [[ARRAYIDX2]], align 1
; CHECK-NEXT:    br label [[IF_END2]]
; CHECK:       if.end2:
; CHECK-NEXT:    [[INC]] = add nuw nsw i16 [[I_0]], 1
; CHECK-NEXT:    br label [[DO_BODY]]
; CHECK:       exit:
; CHECK-NEXT:    store i16 1, ptr [[ARRAYIDX2]], align 1
; CHECK-NEXT:    ret i16 0
;
entry:
  br label %do.body

do.body:
  %i.0 = phi i16 [ 0, %entry ], [ %inc, %if.end2 ]
  %arrayidx2 = getelementptr inbounds [10 x i16], ptr @x, i16 0, i16 %i.0
  store i16 2, ptr %arrayidx2, align 1
  %exitcond = icmp eq i16 %i.0, 4
  br i1 %exitcond, label %exit, label %if.end

if.end:
  br i1 %cond, label %do.store, label %if.end2

do.store:
  store i16 3, ptr %arrayidx2, align 1
  br label %if.end2

if.end2:
  %inc = add nuw nsw i16 %i.0, 1
  br label %do.body

exit:
  store i16 1, ptr %arrayidx2, align 1
  ret i16 0
}

define void @test(ptr noalias %data1, ptr %data2, ptr %data3, i32 %i1)
; CHECK-LABEL: @test(
; CHECK-NEXT:    [[C:%.*]] = icmp eq i32 [[I1:%.*]], 0
; CHECK-NEXT:    br label [[PH0:%.*]]
; CHECK:       ph0:
; CHECK-NEXT:    br label [[HEADER0:%.*]]
; CHECK:       header0:
; CHECK-NEXT:    [[P1:%.*]] = phi i32 [ 0, [[PH0]] ], [ [[PN1:%.*]], [[END1:%.*]] ]
; CHECK-NEXT:    [[PN1]] = add i32 [[P1]], 1
; CHECK-NEXT:    [[PC1:%.*]] = icmp slt i32 [[PN1]], 5
; CHECK-NEXT:    [[V2:%.*]] = getelementptr [10 x i16], ptr @x, i32 0, i32 [[P1]]
; CHECK-NEXT:    store i16 1, ptr [[V2]], align 2
; CHECK-NEXT:    br i1 [[C]], label [[THEN1:%.*]], label [[ELSE1:%.*]]
; CHECK:       then1:
; CHECK-NEXT:    store i16 2, ptr [[V2]], align 2
; CHECK-NEXT:    br label [[END1]]
; CHECK:       else1:
; CHECK-NEXT:    br label [[END1]]
; CHECK:       end1:
; CHECK-NEXT:    br i1 [[PC1]], label [[HEADER0]], label [[END0:%.*]]
; CHECK:       end0:
; CHECK-NEXT:    br label [[HEADER2:%.*]]
; CHECK:       header2:
; CHECK-NEXT:    [[P3:%.*]] = phi i32 [ 0, [[END0]] ], [ [[PN3:%.*]], [[HEADER2]] ]
; CHECK-NEXT:    [[PN3]] = add i32 [[P3]], 1
; CHECK-NEXT:    [[PC3:%.*]] = icmp slt i32 [[PN3]], 5
; CHECK-NEXT:    store i16 4, ptr [[V2]], align 2
; CHECK-NEXT:    br i1 [[PC3]], label [[HEADER2]], label [[END2:%.*]]
; CHECK:       end2:
; CHECK-NEXT:    ret void
;
{
  %c = icmp eq i32 %i1, 0
  br label %ph0
ph0:
  br label %header0
header0:
  %p1 = phi i32 [0, %ph0], [%pn1, %end1]
  %pn1 = add i32 %p1, 1
  %pc1 = icmp slt i32 %pn1, 5
  %v2 = getelementptr [10 x i16], ptr @x, i32 0, i32 %p1
  store i16 1, ptr %v2
  br i1 %c, label %then1, label %else1
then1:
  store i16 2, ptr %v2
  br label %end1
else1:
  br label %end1
end1:
  br i1 %pc1, label %header0, label %end0
end0:
  br label %header2
header2:
  %p3 = phi i32 [0, %end0], [%pn3, %header2]
  %pn3 = add i32 %p3, 1
  %pc3 = icmp slt i32 %pn3, 5
  store i16 4, ptr %v2
  br i1 %pc3, label %header2, label %end2
end2:
  ret void
}

; Similar to above, but with multiple partial overlaps
define i16 @partial_override_fromloop(i1 %c, i32 %i) {
; CHECK-LABEL: @partial_override_fromloop(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[DO_BODY:%.*]]
; CHECK:       do.body:
; CHECK-NEXT:    [[I_0:%.*]] = phi i16 [ 0, [[ENTRY:%.*]] ], [ [[INC:%.*]], [[IF_END2:%.*]] ]
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds [10 x i16], ptr @x, i16 0, i16 [[I_0]]
; CHECK-NEXT:    store i16 2, ptr [[ARRAYIDX2]], align 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i16 [[I_0]], 4
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[EXIT:%.*]], label [[IF_END:%.*]]
; CHECK:       if.end:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[DO_STORE:%.*]], label [[IF_END2]]
; CHECK:       do.store:
; CHECK-NEXT:    store i16 3, ptr [[ARRAYIDX2]], align 1
; CHECK-NEXT:    br label [[IF_END2]]
; CHECK:       if.end2:
; CHECK-NEXT:    [[INC]] = add nuw nsw i16 [[I_0]], 1
; CHECK-NEXT:    br label [[DO_BODY]]
; CHECK:       exit:
; CHECK-NEXT:    [[BC2:%.*]] = getelementptr inbounds i8, ptr [[ARRAYIDX2]], i32 1
; CHECK-NEXT:    store i8 10, ptr [[ARRAYIDX2]], align 1
; CHECK-NEXT:    store i8 11, ptr [[BC2]], align 1
; CHECK-NEXT:    ret i16 0
;
entry:
  br label %do.body

do.body:
  %i.0 = phi i16 [ 0, %entry ], [ %inc, %if.end2 ]
  %arrayidx2 = getelementptr inbounds [10 x i16], ptr @x, i16 0, i16 %i.0
  store i16 2, ptr %arrayidx2, align 1
  %exitcond = icmp eq i16 %i.0, 4
  br i1 %exitcond, label %exit, label %if.end

if.end:
  br i1 %c, label %do.store, label %if.end2

do.store:
  store i16 3, ptr %arrayidx2, align 1
  br label %if.end2

if.end2:
  %inc = add nuw nsw i16 %i.0, 1
  br label %do.body

exit:
  %bc2 = getelementptr inbounds i8, ptr %arrayidx2, i32 1
  store i8 10, ptr %arrayidx2, align 1
  store i8 11, ptr %bc2, align 1
  ret i16 0
}


define i16 @partial_override_overloop(i1 %c, i32 %i) {
; CHECK-LABEL: @partial_override_overloop(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FIRST:%.*]]
; CHECK:       first:
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [10 x i16], ptr @x, i16 0, i32 [[I:%.*]]
; CHECK-NEXT:    br label [[DO_BODY:%.*]]
; CHECK:       do.body:
; CHECK-NEXT:    [[I_0:%.*]] = phi i16 [ 0, [[FIRST]] ], [ [[INC:%.*]], [[DO_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds [10 x i16], ptr @x, i16 0, i16 [[I_0]]
; CHECK-NEXT:    store i16 2, ptr [[ARRAYIDX2]], align 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i16 [[I_0]], 4
; CHECK-NEXT:    [[INC]] = add nuw nsw i16 [[I_0]], 1
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[EXIT:%.*]], label [[DO_BODY]]
; CHECK:       exit:
; CHECK-NEXT:    [[BC2:%.*]] = getelementptr inbounds i8, ptr [[ARRAYIDX]], i32 1
; CHECK-NEXT:    store i8 10, ptr [[ARRAYIDX]], align 1
; CHECK-NEXT:    store i8 11, ptr [[BC2]], align 1
; CHECK-NEXT:    ret i16 0
;
entry:
  ; Branch to first so MemoryLoc is not in the entry block.
  br label %first

first:
  %arrayidx = getelementptr inbounds [10 x i16], ptr @x, i16 0, i32 %i
  store i16 1, ptr %arrayidx, align 1
  br label %do.body

do.body:
  %i.0 = phi i16 [ 0, %first ], [ %inc, %do.body ]
  %arrayidx2 = getelementptr inbounds [10 x i16], ptr @x, i16 0, i16 %i.0
  store i16 2, ptr %arrayidx2, align 1
  %exitcond = icmp eq i16 %i.0, 4
  %inc = add nuw nsw i16 %i.0, 1
  br i1 %exitcond, label %exit, label %do.body

exit:
  %bc2 = getelementptr inbounds i8, ptr %arrayidx, i32 1
  store i8 10, ptr %arrayidx, align 1
  store i8 11, ptr %bc2, align 1
  ret i16 0
}

define i16 @partial_override_multi(i1 %c, i32 %i) {
; CHECK-LABEL: @partial_override_multi(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[DO_BODY:%.*]]
; CHECK:       do.body:
; CHECK-NEXT:    [[I_0:%.*]] = phi i16 [ 0, [[ENTRY:%.*]] ], [ [[INC:%.*]], [[DO_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds [10 x i16], ptr @x, i16 0, i16 [[I_0]]
; CHECK-NEXT:    store i16 10, ptr [[ARRAYIDX2]], align 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i16 [[I_0]], 4
; CHECK-NEXT:    [[INC]] = add nuw nsw i16 [[I_0]], 1
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[EXIT:%.*]], label [[DO_BODY]]
; CHECK:       exit:
; CHECK-NEXT:    [[BC2:%.*]] = getelementptr inbounds i8, ptr [[ARRAYIDX2]], i32 1
; CHECK-NEXT:    store i8 11, ptr [[BC2]], align 1
; CHECK-NEXT:    ret i16 0
;
entry:
  br label %do.body

do.body:
  %i.0 = phi i16 [ 0, %entry ], [ %inc, %do.body ]
  %arrayidx2 = getelementptr inbounds [10 x i16], ptr @x, i16 0, i16 %i.0
  store i16 2, ptr %arrayidx2, align 1
  store i8 10, ptr %arrayidx2, align 1
  %exitcond = icmp eq i16 %i.0, 4
  %inc = add nuw nsw i16 %i.0, 1
  br i1 %exitcond, label %exit, label %do.body

exit:
  %bc2 = getelementptr inbounds i8, ptr %arrayidx2, i32 1
  store i8 11, ptr %bc2, align 1
  ret i16 0
}

define void @InitializeMasks(ptr %p) {
; CHECK-LABEL: @InitializeMasks(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_BODY98:%.*]]
; CHECK:       for.body98:
; CHECK-NEXT:    [[INDVARS_IV377:%.*]] = phi i64 [ 8, [[ENTRY:%.*]] ], [ [[INC2:%.*]], [[FOR_INC140:%.*]] ], [ [[INC1:%.*]], [[FOR_INC140_THREAD:%.*]] ]
; CHECK-NEXT:    [[ARRAYIDX106:%.*]] = getelementptr inbounds i64, ptr [[P:%.*]], i64 [[INDVARS_IV377]]
; CHECK-NEXT:    store i64 1, ptr [[ARRAYIDX106]], align 8
; CHECK-NEXT:    [[CMP107:%.*]] = icmp ugt i64 [[INDVARS_IV377]], 15
; CHECK-NEXT:    br i1 [[CMP107]], label [[IF_END:%.*]], label [[IF_END_THREAD:%.*]]
; CHECK:       if.end.thread:
; CHECK-NEXT:    br label [[FOR_INC140_THREAD]]
; CHECK:       if.end:
; CHECK-NEXT:    store i64 2, ptr [[ARRAYIDX106]], align 8
; CHECK-NEXT:    [[CMP127:%.*]] = icmp ult i64 [[INDVARS_IV377]], 48
; CHECK-NEXT:    br i1 [[CMP127]], label [[FOR_INC140_THREAD]], label [[FOR_INC140]]
; CHECK:       for.inc140.thread:
; CHECK-NEXT:    [[INC1]] = add i64 [[INDVARS_IV377]], 1
; CHECK-NEXT:    br label [[FOR_BODY98]]
; CHECK:       for.inc140:
; CHECK-NEXT:    [[INC2]] = add i64 [[INDVARS_IV377]], 1
; CHECK-NEXT:    [[EXITCOND384_NOT:%.*]] = icmp eq i64 [[INDVARS_IV377]], 56
; CHECK-NEXT:    br i1 [[EXITCOND384_NOT]], label [[FOR_INC177:%.*]], label [[FOR_BODY98]]
; CHECK:       for.inc177:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body98

for.body98:                                       ; preds = %for.inc140, %for.inc140.thread, %entry
  %indvars.iv377 = phi i64 [ 8, %entry ], [ %inc2, %for.inc140 ], [ %inc1, %for.inc140.thread ]
  %arrayidx106 = getelementptr inbounds i64, ptr %p, i64 %indvars.iv377
  store i64 1, ptr %arrayidx106, align 8
  %cmp107 = icmp ugt i64 %indvars.iv377, 15
  br i1 %cmp107, label %if.end, label %if.end.thread

if.end.thread:                                    ; preds = %for.body98
  br label %for.inc140.thread

if.end:                                           ; preds = %for.body98
  store i64 2, ptr %arrayidx106, align 8
  %cmp127 = icmp ult i64 %indvars.iv377, 48
  br i1 %cmp127, label %for.inc140.thread, label %for.inc140

for.inc140.thread:                                ; preds = %if.end, %if.end.thread
  %inc1 = add i64 %indvars.iv377, 1
  br label %for.body98

for.inc140:                                       ; preds = %if.end
  %inc2 = add i64 %indvars.iv377, 1
  %exitcond384.not = icmp eq i64 %indvars.iv377, 56
  br i1 %exitcond384.not, label %for.inc177, label %for.body98

for.inc177:                                       ; preds = %for.inc140
  ret void
}
