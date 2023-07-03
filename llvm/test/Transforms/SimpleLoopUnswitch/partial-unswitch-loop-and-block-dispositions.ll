; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes='loop(loop-interchange),loop-mssa(simple-loop-unswitch<nontrivial>)' -S -verify-scev %s | FileCheck %s

declare void @clobber()

; Make sure SCEV loop and block dispositions are properly invalidated after
; unswitching.
define void @test_pr58564(i16 %a, i1 %c.1, ptr %dst) {
; CHECK-LABEL: @test_pr58564(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = icmp ult i16 [[A:%.*]], -6
; CHECK-NEXT:    br i1 [[TMP0]], label [[ENTRY_SPLIT_US:%.*]], label [[ENTRY_SPLIT:%.*]]
; CHECK:       entry.split.us:
; CHECK-NEXT:    br i1 [[C_1:%.*]], label [[ENTRY_SPLIT_US_SPLIT_US:%.*]], label [[ENTRY_SPLIT_US_SPLIT:%.*]]
; CHECK:       entry.split.us.split.us:
; CHECK-NEXT:    br label [[LOOP_1_HEADER_US_US:%.*]]
; CHECK:       loop.1.header.us.us:
; CHECK-NEXT:    br label [[LOOP_1_HEADER_SPLIT_US_US_US:%.*]]
; CHECK:       loop.1.header.split.us.us.us:
; CHECK-NEXT:    br label [[LOOP_1_HEADER_SPLIT_US_SPLIT_US_SPLIT_US_SPLIT_US:%.*]]
; CHECK:       loop.1.header.split.us.split.us.split.us.split.us:
; CHECK-NEXT:    br label [[LOOP_1_HEADER_SPLIT_US_SPLIT_US_SPLIT_US:%.*]]
; CHECK:       entry.split.us.split:
; CHECK-NEXT:    br label [[LOOP_1_HEADER_US:%.*]]
; CHECK:       loop.1.header.us:
; CHECK-NEXT:    br label [[LOOP_1_HEADER_SPLIT_US_US:%.*]]
; CHECK:       loop.4.header.us5:
; CHECK-NEXT:    br label [[LOOP_5_US6:%.*]]
; CHECK:       loop.5.us6:
; CHECK-NEXT:    [[IV_US7:%.*]] = phi i16 [ 0, [[LOOP_4_HEADER_US5:%.*]] ], [ [[IV_NEXT_US9:%.*]], [[LOOP_5_US6]] ]
; CHECK-NEXT:    [[GEP_US8:%.*]] = getelementptr inbounds ptr, ptr [[DST:%.*]], i16 [[IV_US7]]
; CHECK-NEXT:    store ptr null, ptr [[GEP_US8]], align 8
; CHECK-NEXT:    [[IV_NEXT_US9]] = add nuw nsw i16 [[IV_US7]], 1
; CHECK-NEXT:    [[EC_US10:%.*]] = icmp ne i16 [[IV_US7]], 10000
; CHECK-NEXT:    br i1 [[EC_US10]], label [[LOOP_5_US6]], label [[LOOP_4_LATCH_US11:%.*]]
; CHECK:       loop.4.latch.us11:
; CHECK-NEXT:    br label [[LOOP_1_LATCH_US:%.*]]
; CHECK:       loop.1.latch.us:
; CHECK-NEXT:    br label [[LOOP_1_HEADER_US]]
; CHECK:       loop.4.header.preheader.us:
; CHECK-NEXT:    br i1 false, label [[LOOP_4_HEADER_PREHEADER_SPLIT4_US_SPLIT_US:%.*]], label [[LOOP_4_HEADER_PREHEADER_SPLIT4_US15:%.*]]
; CHECK:       loop.1.header.split.us.us:
; CHECK-NEXT:    br label [[LOOP_1_HEADER_SPLIT_US_SPLIT_US14:%.*]]
; CHECK:       loop.2.header.us.us12:
; CHECK-NEXT:    br label [[LOOP_2_HEADER_SPLIT_US_US_US13:%.*]]
; CHECK:       loop.2.latch.us.us:
; CHECK-NEXT:    br i1 false, label [[LOOP_2_HEADER_US_US12:%.*]], label [[LOOP_4_HEADER_PREHEADER_SPLIT_US_US:%.*]]
; CHECK:       loop.2.header.split.us.us.us13:
; CHECK-NEXT:    br label [[LOOP_2_HEADER_SPLIT_US_SPLIT_US3_US:%.*]]
; CHECK:       loop.3.header.us.us1.us:
; CHECK-NEXT:    br label [[LOOP_3_LATCH_US_US2_US:%.*]]
; CHECK:       loop.3.latch.us.us2.us:
; CHECK-NEXT:    br label [[LOOP_2_LATCH_SPLIT_US_US_US:%.*]]
; CHECK:       loop.2.latch.split.us.us.us:
; CHECK-NEXT:    br label [[LOOP_2_LATCH_US_US:%.*]]
; CHECK:       loop.2.header.split.us.split.us3.us:
; CHECK-NEXT:    br label [[LOOP_3_HEADER_US_US1_US:%.*]]
; CHECK:       loop.4.header.preheader.split.us.us:
; CHECK-NEXT:    br label [[LOOP_4_HEADER_PREHEADER_US:%.*]]
; CHECK:       loop.1.header.split.us.split.us14:
; CHECK-NEXT:    br label [[LOOP_2_HEADER_US_US12]]
; CHECK:       loop.4.header.preheader.split4.us15:
; CHECK-NEXT:    br label [[LOOP_4_HEADER_US5]]
; CHECK:       loop.4.header.preheader.split4.us.split.us:
; CHECK-NEXT:    br label [[LOOP_4_HEADER_PREHEADER_SPLIT4_US:%.*]]
; CHECK:       loop.1.header.split.us.split.us.split.us:
; CHECK-NEXT:    br label [[LOOP_1_HEADER_SPLIT_US_SPLIT_US:%.*]]
; CHECK:       entry.split:
; CHECK-NEXT:    br label [[LOOP_1_HEADER:%.*]]
; CHECK:       loop.1.header:
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ult i16 [[A]], -6
; CHECK-NEXT:    br i1 [[TMP1]], label [[LOOP_1_HEADER_SPLIT_US:%.*]], label [[LOOP_1_HEADER_SPLIT:%.*]]
; CHECK:       loop.1.header.split.us:
; CHECK-NEXT:    br i1 [[C_1]], label [[LOOP_1_HEADER_SPLIT_US_SPLIT_US_SPLIT:%.*]], label [[LOOP_1_HEADER_SPLIT_US_SPLIT:%.*]]
; CHECK:       loop.1.header.split.us.split.us.split:
; CHECK-NEXT:    br label [[LOOP_1_HEADER_SPLIT_US_SPLIT_US]]
; CHECK:       loop.1.header.split.us.split.us:
; CHECK-NEXT:    br label [[LOOP_2_HEADER_US_US:%.*]]
; CHECK:       loop.2.header.us.us:
; CHECK-NEXT:    br label [[LOOP_2_HEADER_SPLIT_US_US_US:%.*]]
; CHECK:       loop.2.header.split.us.us.us:
; CHECK-NEXT:    br label [[LOOP_2_HEADER_SPLIT_US_SPLIT_US_SPLIT_US_SPLIT_US:%.*]]
; CHECK:       loop.2.header.split.us.split.us.split.us.split.us:
; CHECK-NEXT:    br label [[LOOP_2_HEADER_SPLIT_US_SPLIT_US_SPLIT_US:%.*]]
; CHECK:       loop.1.header.split.us.split:
; CHECK-NEXT:    br label [[LOOP_2_HEADER_US:%.*]]
; CHECK:       loop.2.header.us:
; CHECK-NEXT:    br label [[LOOP_2_HEADER_SPLIT_US_US:%.*]]
; CHECK:       loop.2.latch.us:
; CHECK-NEXT:    br i1 false, label [[LOOP_2_HEADER_US]], label [[LOOP_4_HEADER_PREHEADER_SPLIT_US:%.*]]
; CHECK:       loop.2.header.split.us.us:
; CHECK-NEXT:    br label [[LOOP_2_HEADER_SPLIT_US_SPLIT_US3:%.*]]
; CHECK:       loop.3.header.us.us1:
; CHECK-NEXT:    br label [[LOOP_3_LATCH_US_US2:%.*]]
; CHECK:       loop.3.latch.us.us2:
; CHECK-NEXT:    br label [[LOOP_2_LATCH_SPLIT_US_US:%.*]]
; CHECK:       loop.2.latch.split.us.us:
; CHECK-NEXT:    br label [[LOOP_2_LATCH_US:%.*]]
; CHECK:       loop.2.header.split.us.split.us3:
; CHECK-NEXT:    br label [[LOOP_3_HEADER_US_US1:%.*]]
; CHECK:       loop.4.header.preheader.split.us:
; CHECK-NEXT:    br label [[LOOP_4_HEADER_PREHEADER:%.*]]
; CHECK:       loop.2.header.split.us.split.us.split.us:
; CHECK-NEXT:    br label [[LOOP_2_HEADER_SPLIT_US_SPLIT_US:%.*]]
; CHECK:       loop.1.header.split:
; CHECK-NEXT:    br label [[LOOP_2_HEADER:%.*]]
; CHECK:       loop.2.header:
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ult i16 [[A]], -6
; CHECK-NEXT:    br i1 [[TMP2]], label [[LOOP_2_HEADER_SPLIT_US:%.*]], label [[LOOP_2_HEADER_SPLIT:%.*]]
; CHECK:       loop.2.header.split.us:
; CHECK-NEXT:    br i1 [[C_1]], label [[LOOP_2_HEADER_SPLIT_US_SPLIT_US_SPLIT:%.*]], label [[LOOP_2_HEADER_SPLIT_US_SPLIT:%.*]]
; CHECK:       loop.2.header.split.us.split.us.split:
; CHECK-NEXT:    br label [[LOOP_2_HEADER_SPLIT_US_SPLIT_US]]
; CHECK:       loop.2.header.split.us.split.us:
; CHECK-NEXT:    br label [[LOOP_3_HEADER_US_US:%.*]]
; CHECK:       loop.3.header.us.us:
; CHECK-NEXT:    br label [[LOOP_3_LATCH_US_US:%.*]]
; CHECK:       loop.3.latch.us.us:
; CHECK-NEXT:    br label [[LOOP_3_HEADER_US_US]]
; CHECK:       loop.2.header.split.us.split:
; CHECK-NEXT:    br label [[LOOP_3_HEADER_US:%.*]]
; CHECK:       loop.3.header.us:
; CHECK-NEXT:    br label [[LOOP_3_LATCH_US:%.*]]
; CHECK:       loop.3.latch.us:
; CHECK-NEXT:    br label [[LOOP_2_LATCH_SPLIT_US:%.*]]
; CHECK:       loop.2.latch.split.us:
; CHECK-NEXT:    br label [[LOOP_2_LATCH:%.*]]
; CHECK:       loop.2.header.split:
; CHECK-NEXT:    br label [[LOOP_3_HEADER:%.*]]
; CHECK:       loop.3.header:
; CHECK-NEXT:    [[TMP3:%.*]] = icmp ult i16 [[A]], -6
; CHECK-NEXT:    br i1 [[TMP3]], label [[LOOP_3_LATCH:%.*]], label [[LOOP_3_THEN:%.*]]
; CHECK:       loop.3.then:
; CHECK-NEXT:    call void @clobber()
; CHECK-NEXT:    br label [[LOOP_3_LATCH]]
; CHECK:       loop.3.latch:
; CHECK-NEXT:    br i1 [[C_1]], label [[LOOP_3_HEADER]], label [[LOOP_2_LATCH_SPLIT:%.*]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       loop.2.latch.split:
; CHECK-NEXT:    br label [[LOOP_2_LATCH]]
; CHECK:       loop.2.latch:
; CHECK-NEXT:    br i1 [[C_1]], label [[LOOP_2_HEADER]], label [[LOOP_4_HEADER_PREHEADER_SPLIT:%.*]], !llvm.loop [[LOOP2:![0-9]+]]
; CHECK:       loop.4.header.preheader.split:
; CHECK-NEXT:    br label [[LOOP_4_HEADER_PREHEADER]]
; CHECK:       loop.4.header.preheader:
; CHECK-NEXT:    br i1 [[C_1]], label [[LOOP_4_HEADER_PREHEADER_SPLIT4_US_SPLIT:%.*]], label [[LOOP_4_HEADER_PREHEADER_SPLIT4:%.*]]
; CHECK:       loop.4.header.preheader.split4.us.split:
; CHECK-NEXT:    br label [[LOOP_4_HEADER_PREHEADER_SPLIT4_US]]
; CHECK:       loop.4.header.preheader.split4.us:
; CHECK-NEXT:    br label [[LOOP_4_HEADER_US:%.*]]
; CHECK:       loop.4.header.us:
; CHECK-NEXT:    br label [[LOOP_5_US:%.*]]
; CHECK:       loop.5.us:
; CHECK-NEXT:    [[IV_US:%.*]] = phi i16 [ 0, [[LOOP_4_HEADER_US]] ], [ [[IV_NEXT_US:%.*]], [[LOOP_5_US]] ]
; CHECK-NEXT:    [[GEP_US:%.*]] = getelementptr inbounds ptr, ptr [[DST]], i16 [[IV_US]]
; CHECK-NEXT:    store ptr null, ptr [[GEP_US]], align 8
; CHECK-NEXT:    [[IV_NEXT_US]] = add nuw nsw i16 [[IV_US]], 1
; CHECK-NEXT:    [[EC_US:%.*]] = icmp ne i16 [[IV_US]], 10000
; CHECK-NEXT:    br i1 [[EC_US]], label [[LOOP_5_US]], label [[LOOP_4_LATCH_US:%.*]]
; CHECK:       loop.4.latch.us:
; CHECK-NEXT:    br label [[LOOP_4_HEADER_US]]
; CHECK:       loop.4.header.preheader.split4:
; CHECK-NEXT:    br label [[LOOP_4_HEADER:%.*]]
; CHECK:       loop.4.header:
; CHECK-NEXT:    br label [[LOOP_5:%.*]]
; CHECK:       loop.5:
; CHECK-NEXT:    [[IV:%.*]] = phi i16 [ 0, [[LOOP_4_HEADER]] ], [ [[IV_NEXT:%.*]], [[LOOP_5]] ]
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds ptr, ptr [[DST]], i16 [[IV]]
; CHECK-NEXT:    store ptr null, ptr [[GEP]], align 8
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i16 [[IV]], 1
; CHECK-NEXT:    [[EC:%.*]] = icmp ne i16 [[IV]], 10000
; CHECK-NEXT:    br i1 [[EC]], label [[LOOP_5]], label [[LOOP_4_LATCH:%.*]]
; CHECK:       loop.4.latch:
; CHECK-NEXT:    br label [[LOOP_1_LATCH:%.*]]
; CHECK:       loop.1.latch:
; CHECK-NEXT:    br label [[LOOP_1_HEADER]], !llvm.loop [[LOOP3:![0-9]+]]
;
entry:
  br label %loop.1.header

loop.1.header:
  br label %loop.2.header

loop.2.header:
  br label %loop.3.header

loop.3.header:
  %0 = icmp ult i16 %a, -6
  br i1 %0, label %loop.3.latch, label %loop.3.then

loop.3.then:
  call void @clobber()
  br label %loop.3.latch

loop.3.latch:
  br i1 %c.1, label %loop.3.header, label %loop.2.latch

loop.2.latch:
  br i1 %c.1, label %loop.2.header, label %loop.4.header

loop.4.header:
  br label %loop.5

loop.5:
  %iv = phi i16 [ 0, %loop.4.header ], [ %iv.next, %loop.5 ]
  %gep = getelementptr inbounds ptr, ptr %dst, i16 %iv
  store ptr null, ptr %gep, align 8
  %iv.next = add nuw nsw i16 %iv, 1
  %ec = icmp ne i16 %iv, 10000
  br i1 %ec, label %loop.5, label %loop.4.latch

loop.4.latch:
  br i1 %c.1, label %loop.4.header, label %loop.1.latch

loop.1.latch:
  br label %loop.1.header
}
