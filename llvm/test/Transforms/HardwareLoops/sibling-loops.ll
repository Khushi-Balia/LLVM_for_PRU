; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -hardware-loops -force-hardware-loops=true -hardware-loop-decrement=1 -hardware-loop-counter-bitwidth=32 -S | FileCheck %s

define arm_aapcs_vfpcc void @test(ptr noalias nocapture readonly %off, ptr noalias nocapture %data, ptr noalias nocapture %dst, i32 %n) {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP252:%.*]] = icmp sgt i32 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP252]], label [[FOR_COND1_PREHEADER_US:%.*]], label [[FOR_COND_CLEANUP:%.*]]
; CHECK:       for.cond1.preheader.us:
; CHECK-NEXT:    [[I_057_US:%.*]] = phi i32 [ [[INC29_US:%.*]], [[FOR_COND_CLEANUP14_US:%.*]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[MUL_US:%.*]] = mul i32 [[I_057_US]], [[N]]
; CHECK-NEXT:    call void @llvm.set.loop.iterations.i32(i32 [[N]])
; CHECK-NEXT:    br label [[FOR_BODY4_US:%.*]]
; CHECK:       for.body4.us:
; CHECK-NEXT:    [[J_053_US:%.*]] = phi i32 [ 0, [[FOR_COND1_PREHEADER_US]] ], [ [[INC_US:%.*]], [[FOR_BODY4_US]] ]
; CHECK-NEXT:    [[ARRAYIDX_US:%.*]] = getelementptr inbounds i16, ptr [[OFF:%.*]], i32 [[J_053_US]]
; CHECK-NEXT:    [[L2:%.*]] = load i16, ptr [[ARRAYIDX_US]], align 2
; CHECK-NEXT:    [[ARRAYIDX5_US:%.*]] = getelementptr inbounds i16, ptr [[DATA:%.*]], i32 [[J_053_US]]
; CHECK-NEXT:    [[L3:%.*]] = load i16, ptr [[ARRAYIDX5_US]], align 2
; CHECK-NEXT:    [[ADD_US:%.*]] = add i16 [[L3]], [[L2]]
; CHECK-NEXT:    [[ADD8_US:%.*]] = add i32 [[J_053_US]], [[MUL_US]]
; CHECK-NEXT:    [[ARRAYIDX9_US:%.*]] = getelementptr inbounds i16, ptr [[DATA]], i32 [[ADD8_US]]
; CHECK-NEXT:    store i16 [[ADD_US]], ptr [[ARRAYIDX9_US]], align 2
; CHECK-NEXT:    [[INC_US]] = add nuw nsw i32 [[J_053_US]], 1
; CHECK-NEXT:    [[TMP0:%.*]] = call i1 @llvm.loop.decrement.i32(i32 1)
; CHECK-NEXT:    br i1 [[TMP0]], label [[FOR_BODY4_US]], label [[FOR_BODY15_US_PREHEADER:%.*]]
; CHECK:       for.body15.us.preheader:
; CHECK-NEXT:    call void @llvm.set.loop.iterations.i32(i32 [[N]])
; CHECK-NEXT:    br label [[FOR_BODY15_US:%.*]]
; CHECK:       for.body15.us:
; CHECK-NEXT:    [[J10_055_US:%.*]] = phi i32 [ [[INC26_US:%.*]], [[FOR_BODY15_US]] ], [ 0, [[FOR_BODY15_US_PREHEADER]] ]
; CHECK-NEXT:    [[ARRAYIDX16_US:%.*]] = getelementptr inbounds i16, ptr [[OFF]], i32 [[J10_055_US]]
; CHECK-NEXT:    [[L0:%.*]] = load i16, ptr [[ARRAYIDX16_US]], align 2
; CHECK-NEXT:    [[ARRAYIDX18_US:%.*]] = getelementptr inbounds i16, ptr [[DATA]], i32 [[J10_055_US]]
; CHECK-NEXT:    [[L1:%.*]] = load i16, ptr [[ARRAYIDX18_US]], align 2
; CHECK-NEXT:    [[ADD20_US:%.*]] = add i16 [[L1]], [[L0]]
; CHECK-NEXT:    [[ADD23_US:%.*]] = add i32 [[J10_055_US]], [[MUL_US]]
; CHECK-NEXT:    [[ARRAYIDX24_US:%.*]] = getelementptr inbounds i16, ptr [[DST:%.*]], i32 [[ADD23_US]]
; CHECK-NEXT:    store i16 [[ADD20_US]], ptr [[ARRAYIDX24_US]], align 2
; CHECK-NEXT:    [[INC26_US]] = add nuw nsw i32 [[J10_055_US]], 1
; CHECK-NEXT:    [[TMP1:%.*]] = call i1 @llvm.loop.decrement.i32(i32 1)
; CHECK-NEXT:    br i1 [[TMP1]], label [[FOR_BODY15_US]], label [[FOR_COND_CLEANUP14_US]]
; CHECK:       for.cond.cleanup14.us:
; CHECK-NEXT:    [[INC29_US]] = add nuw i32 [[I_057_US]], 1
; CHECK-NEXT:    [[EXITCOND94:%.*]] = icmp eq i32 [[INC29_US]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND94]], label [[FOR_COND_CLEANUP]], label [[FOR_COND1_PREHEADER_US]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    ret void
;
entry:
  %cmp252 = icmp sgt i32 %n, 0
  br i1 %cmp252, label %for.cond1.preheader.us, label %for.cond.cleanup

for.cond1.preheader.us: ; preds = %entry, %for.cond.cleanup14.us
  %i.057.us = phi i32 [ %inc29.us, %for.cond.cleanup14.us ], [ 0, %entry ]
  %mul.us = mul i32 %i.057.us, %n
  br label %for.body4.us

for.body4.us: ; preds = %for.body4.us, %for.cond1.preheader.us
  %j.053.us = phi i32 [ 0, %for.cond1.preheader.us ], [ %inc.us, %for.body4.us ]
  %arrayidx.us = getelementptr inbounds i16, ptr %off, i32 %j.053.us
  %l2 = load i16, ptr %arrayidx.us, align 2
  %arrayidx5.us = getelementptr inbounds i16, ptr %data, i32 %j.053.us
  %l3 = load i16, ptr %arrayidx5.us, align 2
  %add.us = add i16 %l3, %l2
  %add8.us = add i32 %j.053.us, %mul.us
  %arrayidx9.us = getelementptr inbounds i16, ptr %data, i32 %add8.us
  store i16 %add.us, ptr %arrayidx9.us, align 2
  %inc.us = add nuw nsw i32 %j.053.us, 1
  %exitcond = icmp eq i32 %inc.us, %n
  br i1 %exitcond, label %for.body15.us, label %for.body4.us

for.body15.us: ; preds = %for.body4.us, %for.body15.us
  %j10.055.us = phi i32 [ %inc26.us, %for.body15.us ], [ 0, %for.body4.us ]
  %arrayidx16.us = getelementptr inbounds i16, ptr %off, i32 %j10.055.us
  %l0 = load i16, ptr %arrayidx16.us, align 2
  %arrayidx18.us = getelementptr inbounds i16, ptr %data, i32 %j10.055.us
  %l1 = load i16, ptr %arrayidx18.us, align 2
  %add20.us = add i16 %l1, %l0
  %add23.us = add i32 %j10.055.us, %mul.us
  %arrayidx24.us = getelementptr inbounds i16, ptr %dst, i32 %add23.us
  store i16 %add20.us, ptr %arrayidx24.us, align 2
  %inc26.us = add nuw nsw i32 %j10.055.us, 1
  %exitcond93 = icmp eq i32 %inc26.us, %n
  br i1 %exitcond93, label %for.cond.cleanup14.us, label %for.body15.us

for.cond.cleanup14.us: ; preds = %for.body15.us
  %inc29.us = add nuw i32 %i.057.us, 1
  %exitcond94 = icmp eq i32 %inc29.us, %n
  br i1 %exitcond94, label %for.cond.cleanup, label %for.cond1.preheader.us

for.cond.cleanup: ; preds = %for.cond.cleanup14.us, %entry
  ret void
}
