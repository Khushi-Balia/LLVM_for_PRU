; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -o - -S -passes=load-store-vectorizer,dce %s | FileCheck %s

; Make sure LoadStoreVectorizer vectorizes the loads below.
; In order to prove that the vectorization is safe, it tries to
; match nested adds and find an expression that adds a constant
; value to an existing index and the result doesn't overflow.

target triple = "x86_64--"

define void @ld_v4i8_add_nsw(i32 %v0, i32 %v1, ptr %src, ptr %dst) {
; CHECK-LABEL: @ld_v4i8_add_nsw(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[TMP:%.*]] = add nsw i32 [[V0:%.*]], -1
; CHECK-NEXT:    [[TMP1:%.*]] = add nsw i32 [[V1:%.*]], [[TMP]]
; CHECK-NEXT:    [[TMP2:%.*]] = sext i32 [[TMP1]] to i64
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i8, ptr [[SRC:%.*]], i64 [[TMP2]]
; CHECK-NEXT:    [[TMP1:%.*]] = load <4 x i8>, ptr [[TMP3]], align 1
; CHECK-NEXT:    [[TMP41:%.*]] = extractelement <4 x i8> [[TMP1]], i32 0
; CHECK-NEXT:    [[TMP82:%.*]] = extractelement <4 x i8> [[TMP1]], i32 1
; CHECK-NEXT:    [[TMP133:%.*]] = extractelement <4 x i8> [[TMP1]], i32 2
; CHECK-NEXT:    [[TMP184:%.*]] = extractelement <4 x i8> [[TMP1]], i32 3
; CHECK-NEXT:    [[TMP19:%.*]] = insertelement <4 x i8> poison, i8 [[TMP41]], i32 0
; CHECK-NEXT:    [[TMP20:%.*]] = insertelement <4 x i8> [[TMP19]], i8 [[TMP82]], i32 1
; CHECK-NEXT:    [[TMP21:%.*]] = insertelement <4 x i8> [[TMP20]], i8 [[TMP133]], i32 2
; CHECK-NEXT:    [[TMP22:%.*]] = insertelement <4 x i8> [[TMP21]], i8 [[TMP184]], i32 3
; CHECK-NEXT:    store <4 x i8> [[TMP22]], ptr [[DST:%.*]], align 4
; CHECK-NEXT:    ret void
;
bb:
  %tmp = add nsw i32 %v0, -1
  %tmp1 = add nsw i32 %v1, %tmp
  %tmp2 = sext i32 %tmp1 to i64
  %tmp3 = getelementptr inbounds i8, ptr %src, i64 %tmp2
  %tmp4 = load i8, ptr %tmp3, align 1
  %tmp5 = add nsw i32 %v1, %v0
  %tmp6 = sext i32 %tmp5 to i64
  %tmp7 = getelementptr inbounds i8, ptr %src, i64 %tmp6
  %tmp8 = load i8, ptr %tmp7, align 1
  %tmp9 = add nsw i32 %v0, 1
  %tmp10 = add nsw i32 %v1, %tmp9
  %tmp11 = sext i32 %tmp10 to i64
  %tmp12 = getelementptr inbounds i8, ptr %src, i64 %tmp11
  %tmp13 = load i8, ptr %tmp12, align 1
  %tmp14 = add nsw i32 %v0, 2
  %tmp15 = add nsw i32 %v1, %tmp14
  %tmp16 = sext i32 %tmp15 to i64
  %tmp17 = getelementptr inbounds i8, ptr %src, i64 %tmp16
  %tmp18 = load i8, ptr %tmp17, align 1
  %tmp19 = insertelement <4 x i8> poison, i8 %tmp4, i32 0
  %tmp20 = insertelement <4 x i8> %tmp19, i8 %tmp8, i32 1
  %tmp21 = insertelement <4 x i8> %tmp20, i8 %tmp13, i32 2
  %tmp22 = insertelement <4 x i8> %tmp21, i8 %tmp18, i32 3
  store <4 x i8> %tmp22, ptr %dst
  ret void
}

define void @ld_v4i8_add_nuw(i32 %v0, i32 %v1, ptr %src, ptr %dst) {
; CHECK-LABEL: @ld_v4i8_add_nuw(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[TMP:%.*]] = add nuw i32 [[V0:%.*]], -1
; CHECK-NEXT:    [[TMP1:%.*]] = add nuw i32 [[V1:%.*]], [[TMP]]
; CHECK-NEXT:    [[TMP2:%.*]] = zext i32 [[TMP1]] to i64
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i8, ptr [[SRC:%.*]], i64 [[TMP2]]
; CHECK-NEXT:    [[TMP1:%.*]] = load <4 x i8>, ptr [[TMP3]], align 1
; CHECK-NEXT:    [[TMP41:%.*]] = extractelement <4 x i8> [[TMP1]], i32 0
; CHECK-NEXT:    [[TMP82:%.*]] = extractelement <4 x i8> [[TMP1]], i32 1
; CHECK-NEXT:    [[TMP133:%.*]] = extractelement <4 x i8> [[TMP1]], i32 2
; CHECK-NEXT:    [[TMP184:%.*]] = extractelement <4 x i8> [[TMP1]], i32 3
; CHECK-NEXT:    [[TMP19:%.*]] = insertelement <4 x i8> poison, i8 [[TMP41]], i32 0
; CHECK-NEXT:    [[TMP20:%.*]] = insertelement <4 x i8> [[TMP19]], i8 [[TMP82]], i32 1
; CHECK-NEXT:    [[TMP21:%.*]] = insertelement <4 x i8> [[TMP20]], i8 [[TMP133]], i32 2
; CHECK-NEXT:    [[TMP22:%.*]] = insertelement <4 x i8> [[TMP21]], i8 [[TMP184]], i32 3
; CHECK-NEXT:    store <4 x i8> [[TMP22]], ptr [[DST:%.*]], align 4
; CHECK-NEXT:    ret void
;
bb:
  %tmp = add nuw i32 %v0, -1
  %tmp1 = add nuw i32 %v1, %tmp
  %tmp2 = zext i32 %tmp1 to i64
  %tmp3 = getelementptr inbounds i8, ptr %src, i64 %tmp2
  %tmp4 = load i8, ptr %tmp3, align 1
  %tmp5 = add nuw i32 %v1, %v0
  %tmp6 = zext i32 %tmp5 to i64
  %tmp7 = getelementptr inbounds i8, ptr %src, i64 %tmp6
  %tmp8 = load i8, ptr %tmp7, align 1
  %tmp9 = add nuw i32 %v0, 1
  %tmp10 = add nuw i32 %v1, %tmp9
  %tmp11 = zext i32 %tmp10 to i64
  %tmp12 = getelementptr inbounds i8, ptr %src, i64 %tmp11
  %tmp13 = load i8, ptr %tmp12, align 1
  %tmp14 = add nuw i32 %v0, 2
  %tmp15 = add nuw i32 %v1, %tmp14
  %tmp16 = zext i32 %tmp15 to i64
  %tmp17 = getelementptr inbounds i8, ptr %src, i64 %tmp16
  %tmp18 = load i8, ptr %tmp17, align 1
  %tmp19 = insertelement <4 x i8> poison, i8 %tmp4, i32 0
  %tmp20 = insertelement <4 x i8> %tmp19, i8 %tmp8, i32 1
  %tmp21 = insertelement <4 x i8> %tmp20, i8 %tmp13, i32 2
  %tmp22 = insertelement <4 x i8> %tmp21, i8 %tmp18, i32 3
  store <4 x i8> %tmp22, ptr %dst
  ret void
}

; Make sure we don't vectorize the loads below because the source of
; sext instructions doesn't have the nsw flag.

define void @ld_v4i8_add_not_safe(i32 %v0, i32 %v1, ptr %src, ptr %dst) {
; CHECK-LABEL: @ld_v4i8_add_not_safe(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[TMP:%.*]] = add nsw i32 [[V0:%.*]], -1
; CHECK-NEXT:    [[TMP1:%.*]] = add i32 [[V1:%.*]], [[TMP]]
; CHECK-NEXT:    [[TMP2:%.*]] = sext i32 [[TMP1]] to i64
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i8, ptr [[SRC:%.*]], i64 [[TMP2]]
; CHECK-NEXT:    [[TMP4:%.*]] = load i8, ptr [[TMP3]], align 1
; CHECK-NEXT:    [[TMP5:%.*]] = add i32 [[V1]], [[V0]]
; CHECK-NEXT:    [[TMP6:%.*]] = sext i32 [[TMP5]] to i64
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds i8, ptr [[SRC]], i64 [[TMP6]]
; CHECK-NEXT:    [[TMP8:%.*]] = load i8, ptr [[TMP7]], align 1
; CHECK-NEXT:    [[TMP9:%.*]] = add nsw i32 [[V0]], 1
; CHECK-NEXT:    [[TMP10:%.*]] = add i32 [[V1]], [[TMP9]]
; CHECK-NEXT:    [[TMP11:%.*]] = sext i32 [[TMP10]] to i64
; CHECK-NEXT:    [[TMP12:%.*]] = getelementptr inbounds i8, ptr [[SRC]], i64 [[TMP11]]
; CHECK-NEXT:    [[TMP13:%.*]] = load i8, ptr [[TMP12]], align 1
; CHECK-NEXT:    [[TMP14:%.*]] = add nsw i32 [[V0]], 2
; CHECK-NEXT:    [[TMP15:%.*]] = add i32 [[V1]], [[TMP14]]
; CHECK-NEXT:    [[TMP16:%.*]] = sext i32 [[TMP15]] to i64
; CHECK-NEXT:    [[TMP17:%.*]] = getelementptr inbounds i8, ptr [[SRC]], i64 [[TMP16]]
; CHECK-NEXT:    [[TMP18:%.*]] = load i8, ptr [[TMP17]], align 1
; CHECK-NEXT:    [[TMP19:%.*]] = insertelement <4 x i8> poison, i8 [[TMP4]], i32 0
; CHECK-NEXT:    [[TMP20:%.*]] = insertelement <4 x i8> [[TMP19]], i8 [[TMP8]], i32 1
; CHECK-NEXT:    [[TMP21:%.*]] = insertelement <4 x i8> [[TMP20]], i8 [[TMP13]], i32 2
; CHECK-NEXT:    [[TMP22:%.*]] = insertelement <4 x i8> [[TMP21]], i8 [[TMP18]], i32 3
; CHECK-NEXT:    store <4 x i8> [[TMP22]], ptr [[DST:%.*]], align 4
; CHECK-NEXT:    ret void
;
bb:
  %tmp = add nsw i32 %v0, -1
  %tmp1 = add i32 %v1, %tmp
  %tmp2 = sext i32 %tmp1 to i64
  %tmp3 = getelementptr inbounds i8, ptr %src, i64 %tmp2
  %tmp4 = load i8, ptr %tmp3, align 1
  %tmp5 = add i32 %v1, %v0
  %tmp6 = sext i32 %tmp5 to i64
  %tmp7 = getelementptr inbounds i8, ptr %src, i64 %tmp6
  %tmp8 = load i8, ptr %tmp7, align 1
  %tmp9 = add nsw i32 %v0, 1
  %tmp10 = add i32 %v1, %tmp9
  %tmp11 = sext i32 %tmp10 to i64
  %tmp12 = getelementptr inbounds i8, ptr %src, i64 %tmp11
  %tmp13 = load i8, ptr %tmp12, align 1
  %tmp14 = add nsw i32 %v0, 2
  %tmp15 = add i32 %v1, %tmp14
  %tmp16 = sext i32 %tmp15 to i64
  %tmp17 = getelementptr inbounds i8, ptr %src, i64 %tmp16
  %tmp18 = load i8, ptr %tmp17, align 1
  %tmp19 = insertelement <4 x i8> poison, i8 %tmp4, i32 0
  %tmp20 = insertelement <4 x i8> %tmp19, i8 %tmp8, i32 1
  %tmp21 = insertelement <4 x i8> %tmp20, i8 %tmp13, i32 2
  %tmp22 = insertelement <4 x i8> %tmp21, i8 %tmp18, i32 3
  store <4 x i8> %tmp22, ptr %dst
  ret void
}
