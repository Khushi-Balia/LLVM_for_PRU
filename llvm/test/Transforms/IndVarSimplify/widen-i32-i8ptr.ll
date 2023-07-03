; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=indvars -S | FileCheck %s

target datalayout = "e-m:e-i64:64-n32:64"

define dso_local void @Widen_i32_i8ptr() local_unnamed_addr {
; CHECK-LABEL: @Widen_i32_i8ptr(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[PTRIDS:%.*]] = alloca [15 x ptr], align 8
; CHECK-NEXT:    store ptr [[PTRIDS]], ptr inttoptr (i64 8 to ptr), align 8
; CHECK-NEXT:    br label [[FOR_COND2106:%.*]]
; CHECK:       for.cond2106:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[FOR_COND2106]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[GID_0:%.*]] = phi ptr [ null, [[ENTRY]] ], [ [[INCDEC_PTR:%.*]], [[FOR_COND2106]] ]
; CHECK-NEXT:    [[INCDEC_PTR]] = getelementptr inbounds i8, ptr [[GID_0]], i64 1
; CHECK-NEXT:    [[ARRAYIDX2115:%.*]] = getelementptr inbounds [15 x ptr], ptr [[PTRIDS]], i64 0, i64 [[INDVARS_IV]]
; CHECK-NEXT:    store ptr [[GID_0]], ptr [[ARRAYIDX2115]], align 8
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    br label [[FOR_COND2106]]
;
entry:
  %ptrids = alloca [15 x ptr], align 8
  store ptr %ptrids, ptr inttoptr (i64 8 to ptr), align 8
  br label %for.cond2106

for.cond2106:                                     ; preds = %for.cond2106, %entry
  %gid.0 = phi ptr [ null, %entry ], [ %incdec.ptr, %for.cond2106 ]
  %i.0 = phi i32 [ 0, %entry ], [ %inc2117, %for.cond2106 ]
  %incdec.ptr = getelementptr inbounds i8, ptr %gid.0, i64 1
  %idxprom2114 = zext i32 %i.0 to i64
  %arrayidx2115 = getelementptr inbounds [15 x ptr], ptr %ptrids, i64 0, i64 %idxprom2114
  store ptr %gid.0, ptr %arrayidx2115, align 8
  %inc2117 = add nuw nsw i32 %i.0, 1
  br label %for.cond2106
}
