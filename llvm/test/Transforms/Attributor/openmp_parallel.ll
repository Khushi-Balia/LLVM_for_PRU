; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=13 -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"

%struct.ident_t = type { i32, i32, i32, i32, ptr }

@0 = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00", align 1
@1 = private unnamed_addr constant %struct.ident_t { i32 0, i32 514, i32 0, i32 0, ptr @0 }, align 8
@2 = private unnamed_addr constant %struct.ident_t { i32 0, i32 2, i32 0, i32 0, ptr @0 }, align 8

; %a is write only, %b is read only, neither is captured or freed, or ...
; FIXME: %a and %b are *not* readnone!

;.
; CHECK: @[[GLOB0:[0-9]+]] = private unnamed_addr constant [23 x i8] c"
; CHECK: @[[GLOB1:[0-9]+]] = private unnamed_addr constant [[STRUCT_IDENT_T:%.*]] { i32 0, i32 514, i32 0, i32 0, ptr @[[GLOB0]] }, align 8
; CHECK: @[[GLOB2:[0-9]+]] = private unnamed_addr constant [[STRUCT_IDENT_T:%.*]] { i32 0, i32 2, i32 0, i32 0, ptr @[[GLOB0]] }, align 8
;.
define dso_local void @func(ptr nocapture %a, ptr %b, i32 %N) local_unnamed_addr #0 {
; TUNIT: Function Attrs: nounwind uwtable
; TUNIT-LABEL: define {{[^@]+}}@func
; TUNIT-SAME: (ptr nocapture nofree writeonly [[A:%.*]], ptr nocapture nofree readonly [[B:%.*]], i32 [[N:%.*]]) local_unnamed_addr #[[ATTR0:[0-9]+]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    [[A_ADDR:%.*]] = alloca ptr, align 8
; TUNIT-NEXT:    [[B_ADDR:%.*]] = alloca ptr, align 8
; TUNIT-NEXT:    [[N_ADDR:%.*]] = alloca i32, align 4
; TUNIT-NEXT:    store ptr [[A]], ptr [[A_ADDR]], align 8
; TUNIT-NEXT:    store ptr [[B]], ptr [[B_ADDR]], align 8
; TUNIT-NEXT:    call void (ptr, i32, ptr, ...) @__kmpc_fork_call(ptr noundef nonnull align 8 dereferenceable(24) @[[GLOB2]], i32 noundef 3, ptr noundef @.omp_outlined., ptr noalias nocapture nofree nonnull readnone align 4 dereferenceable(4) undef, ptr noalias nocapture nofree noundef nonnull readonly align 8 dereferenceable(8) [[A_ADDR]], ptr noalias nocapture nofree noundef nonnull readonly align 8 dereferenceable(8) [[B_ADDR]])
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: nounwind uwtable
; CGSCC-LABEL: define {{[^@]+}}@func
; CGSCC-SAME: (ptr nocapture nofree [[A:%.*]], ptr nofree [[B:%.*]], i32 [[N:%.*]]) local_unnamed_addr #[[ATTR0:[0-9]+]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[A_ADDR:%.*]] = alloca ptr, align 8
; CGSCC-NEXT:    [[B_ADDR:%.*]] = alloca ptr, align 8
; CGSCC-NEXT:    [[N_ADDR:%.*]] = alloca i32, align 4
; CGSCC-NEXT:    store ptr [[A]], ptr [[A_ADDR]], align 8
; CGSCC-NEXT:    store ptr [[B]], ptr [[B_ADDR]], align 8
; CGSCC-NEXT:    store i32 199, ptr [[N_ADDR]], align 4
; CGSCC-NEXT:    call void (ptr, i32, ptr, ...) @__kmpc_fork_call(ptr noundef nonnull align 8 dereferenceable(24) @[[GLOB2]], i32 noundef 3, ptr noundef @.omp_outlined., ptr nofree noundef nonnull readonly align 4 dereferenceable(4) [[N_ADDR]], ptr nofree noundef nonnull readonly align 8 dereferenceable(8) [[A_ADDR]], ptr nofree noundef nonnull readonly align 8 dereferenceable(8) [[B_ADDR]])
; CGSCC-NEXT:    ret void
;
entry:
  %a.addr = alloca ptr, align 8
  %b.addr = alloca ptr, align 8
  %N.addr = alloca i32, align 4
  store ptr %a, ptr %a.addr, align 8
  store ptr %b, ptr %b.addr, align 8
  store i32 199, ptr %N.addr, align 4
  call void (ptr, i32, ptr, ...) @__kmpc_fork_call(ptr nonnull @2, i32 3, ptr @.omp_outlined., ptr nonnull %N.addr, ptr nonnull %a.addr, ptr nonnull %b.addr)
  ret void
}

; FIXME: %N should not be loaded but 199 should be used.

define internal void @.omp_outlined.(ptr noalias nocapture readonly %.global_tid., ptr noalias nocapture readnone %.bound_tid., ptr nocapture nonnull readonly align 4 dereferenceable(4) %N, ptr nocapture nonnull readonly align 8 dereferenceable(8) %a, ptr nocapture nonnull readonly align 8 dereferenceable(8) %b) #1 {
; TUNIT: Function Attrs: alwaysinline nofree norecurse nounwind uwtable
; TUNIT-LABEL: define {{[^@]+}}@.omp_outlined.
; TUNIT-SAME: (ptr noalias nocapture nofree readonly [[DOTGLOBAL_TID_:%.*]], ptr noalias nocapture nofree readnone [[DOTBOUND_TID_:%.*]], ptr noalias nocapture nofree nonnull readnone align 4 dereferenceable(4) [[N:%.*]], ptr noalias nocapture nofree noundef nonnull readonly align 8 dereferenceable(8) [[A:%.*]], ptr noalias nocapture nofree noundef nonnull readonly align 8 dereferenceable(8) [[B:%.*]]) #[[ATTR1:[0-9]+]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    [[DOTOMP_LB:%.*]] = alloca i32, align 4
; TUNIT-NEXT:    [[DOTOMP_UB:%.*]] = alloca i32, align 4
; TUNIT-NEXT:    [[DOTOMP_STRIDE:%.*]] = alloca i32, align 4
; TUNIT-NEXT:    [[DOTOMP_IS_LAST:%.*]] = alloca i32, align 4
; TUNIT-NEXT:    br label [[OMP_PRECOND_THEN:%.*]]
; TUNIT:       omp.precond.then:
; TUNIT-NEXT:    call void @llvm.lifetime.start.p0(i64 noundef 4, ptr nocapture nofree noundef nonnull align 4 dereferenceable(4) [[DOTOMP_LB]]) #[[ATTR3:[0-9]+]]
; TUNIT-NEXT:    store i32 0, ptr [[DOTOMP_LB]], align 4
; TUNIT-NEXT:    call void @llvm.lifetime.start.p0(i64 noundef 4, ptr nocapture nofree noundef nonnull align 4 dereferenceable(4) [[DOTOMP_UB]])
; TUNIT-NEXT:    store i32 197, ptr [[DOTOMP_UB]], align 4
; TUNIT-NEXT:    call void @llvm.lifetime.start.p0(i64 noundef 4, ptr nocapture nofree noundef nonnull align 4 dereferenceable(4) [[DOTOMP_STRIDE]])
; TUNIT-NEXT:    store i32 1, ptr [[DOTOMP_STRIDE]], align 4
; TUNIT-NEXT:    call void @llvm.lifetime.start.p0(i64 noundef 4, ptr nocapture nofree noundef nonnull align 4 dereferenceable(4) [[DOTOMP_IS_LAST]])
; TUNIT-NEXT:    store i32 0, ptr [[DOTOMP_IS_LAST]], align 4
; TUNIT-NEXT:    [[TMP0:%.*]] = load i32, ptr [[DOTGLOBAL_TID_]], align 4
; TUNIT-NEXT:    call void @__kmpc_for_static_init_4(ptr noundef nonnull align 8 dereferenceable(24) @[[GLOB1]], i32 [[TMP0]], i32 noundef 34, ptr noundef nonnull align 4 dereferenceable(4) [[DOTOMP_IS_LAST]], ptr noundef nonnull align 4 dereferenceable(4) [[DOTOMP_LB]], ptr noundef nonnull align 4 dereferenceable(4) [[DOTOMP_UB]], ptr noundef nonnull align 4 dereferenceable(4) [[DOTOMP_STRIDE]], i32 noundef 1, i32 noundef 1)
; TUNIT-NEXT:    [[TMP1:%.*]] = load i32, ptr [[DOTOMP_UB]], align 4
; TUNIT-NEXT:    [[CMP4:%.*]] = icmp sgt i32 [[TMP1]], 197
; TUNIT-NEXT:    [[COND:%.*]] = select i1 [[CMP4]], i32 197, i32 [[TMP1]]
; TUNIT-NEXT:    store i32 [[COND]], ptr [[DOTOMP_UB]], align 4
; TUNIT-NEXT:    [[TMP2:%.*]] = load i32, ptr [[DOTOMP_LB]], align 4
; TUNIT-NEXT:    [[CMP513:%.*]] = icmp sgt i32 [[TMP2]], [[COND]]
; TUNIT-NEXT:    br i1 [[CMP513]], label [[OMP_LOOP_EXIT:%.*]], label [[OMP_INNER_FOR_BODY_LR_PH:%.*]]
; TUNIT:       omp.inner.for.body.lr.ph:
; TUNIT-NEXT:    [[TMP3:%.*]] = load ptr, ptr [[B]], align 8
; TUNIT-NEXT:    [[TMP4:%.*]] = load ptr, ptr [[A]], align 8
; TUNIT-NEXT:    [[TMP5:%.*]] = sext i32 [[TMP2]] to i64
; TUNIT-NEXT:    [[TMP6:%.*]] = sext i32 [[COND]] to i64
; TUNIT-NEXT:    br label [[OMP_INNER_FOR_BODY:%.*]]
; TUNIT:       omp.inner.for.body:
; TUNIT-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[OMP_INNER_FOR_BODY]] ], [ [[TMP5]], [[OMP_INNER_FOR_BODY_LR_PH]] ]
; TUNIT-NEXT:    [[INDVARS_IV_NEXT]] = add nsw i64 [[INDVARS_IV]], 1
; TUNIT-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds float, ptr [[TMP3]], i64 [[INDVARS_IV_NEXT]]
; TUNIT-NEXT:    [[TMP7:%.*]] = load float, ptr [[ARRAYIDX]], align 4
; TUNIT-NEXT:    [[CONV7:%.*]] = fadd float [[TMP7]], 1.000000e+00
; TUNIT-NEXT:    [[ARRAYIDX9:%.*]] = getelementptr inbounds float, ptr [[TMP4]], i64 [[INDVARS_IV_NEXT]]
; TUNIT-NEXT:    store float [[CONV7]], ptr [[ARRAYIDX9]], align 4
; TUNIT-NEXT:    [[CMP5:%.*]] = icmp slt i64 [[INDVARS_IV]], [[TMP6]]
; TUNIT-NEXT:    br i1 [[CMP5]], label [[OMP_INNER_FOR_BODY]], label [[OMP_LOOP_EXIT]]
; TUNIT:       omp.loop.exit:
; TUNIT-NEXT:    call void @__kmpc_for_static_fini(ptr noundef nonnull align 8 dereferenceable(24) @[[GLOB1]], i32 [[TMP0]])
; TUNIT-NEXT:    call void @llvm.lifetime.end.p0(i64 noundef 4, ptr nocapture nofree noundef nonnull align 4 dereferenceable(4) [[DOTOMP_IS_LAST]])
; TUNIT-NEXT:    call void @llvm.lifetime.end.p0(i64 noundef 4, ptr nocapture nofree noundef nonnull align 4 dereferenceable(4) [[DOTOMP_STRIDE]])
; TUNIT-NEXT:    call void @llvm.lifetime.end.p0(i64 noundef 4, ptr nocapture nofree noundef nonnull align 4 dereferenceable(4) [[DOTOMP_UB]])
; TUNIT-NEXT:    call void @llvm.lifetime.end.p0(i64 noundef 4, ptr nocapture nofree noundef nonnull align 4 dereferenceable(4) [[DOTOMP_LB]])
; TUNIT-NEXT:    br label [[OMP_PRECOND_END:%.*]]
; TUNIT:       omp.precond.end:
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: alwaysinline nofree norecurse nounwind uwtable
; CGSCC-LABEL: define {{[^@]+}}@.omp_outlined.
; CGSCC-SAME: (ptr noalias nocapture nofree readonly [[DOTGLOBAL_TID_:%.*]], ptr noalias nocapture nofree readnone [[DOTBOUND_TID_:%.*]], ptr noalias nocapture nofree noundef nonnull readonly align 4 dereferenceable(4) [[N:%.*]], ptr noalias nocapture nofree noundef nonnull readonly align 8 dereferenceable(8) [[A:%.*]], ptr noalias nocapture nofree noundef nonnull readonly align 8 dereferenceable(8) [[B:%.*]]) #[[ATTR1:[0-9]+]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[DOTOMP_LB:%.*]] = alloca i32, align 4
; CGSCC-NEXT:    [[DOTOMP_UB:%.*]] = alloca i32, align 4
; CGSCC-NEXT:    [[DOTOMP_STRIDE:%.*]] = alloca i32, align 4
; CGSCC-NEXT:    [[DOTOMP_IS_LAST:%.*]] = alloca i32, align 4
; CGSCC-NEXT:    [[TMP0:%.*]] = load i32, ptr [[N]], align 4
; CGSCC-NEXT:    [[SUB2:%.*]] = add nsw i32 [[TMP0]], -2
; CGSCC-NEXT:    [[CMP:%.*]] = icmp sgt i32 [[TMP0]], 1
; CGSCC-NEXT:    br i1 [[CMP]], label [[OMP_PRECOND_THEN:%.*]], label [[OMP_PRECOND_END:%.*]]
; CGSCC:       omp.precond.then:
; CGSCC-NEXT:    call void @llvm.lifetime.start.p0(i64 noundef 4, ptr nocapture nofree noundef nonnull align 4 dereferenceable(4) [[DOTOMP_LB]]) #[[ATTR3:[0-9]+]]
; CGSCC-NEXT:    store i32 0, ptr [[DOTOMP_LB]], align 4
; CGSCC-NEXT:    call void @llvm.lifetime.start.p0(i64 noundef 4, ptr nocapture nofree noundef nonnull align 4 dereferenceable(4) [[DOTOMP_UB]])
; CGSCC-NEXT:    store i32 [[SUB2]], ptr [[DOTOMP_UB]], align 4
; CGSCC-NEXT:    call void @llvm.lifetime.start.p0(i64 noundef 4, ptr nocapture nofree noundef nonnull align 4 dereferenceable(4) [[DOTOMP_STRIDE]])
; CGSCC-NEXT:    store i32 1, ptr [[DOTOMP_STRIDE]], align 4
; CGSCC-NEXT:    call void @llvm.lifetime.start.p0(i64 noundef 4, ptr nocapture nofree noundef nonnull align 4 dereferenceable(4) [[DOTOMP_IS_LAST]])
; CGSCC-NEXT:    store i32 0, ptr [[DOTOMP_IS_LAST]], align 4
; CGSCC-NEXT:    [[TMP1:%.*]] = load i32, ptr [[DOTGLOBAL_TID_]], align 4
; CGSCC-NEXT:    call void @__kmpc_for_static_init_4(ptr noundef nonnull align 8 dereferenceable(24) @[[GLOB1]], i32 [[TMP1]], i32 noundef 34, ptr noundef nonnull align 4 dereferenceable(4) [[DOTOMP_IS_LAST]], ptr noundef nonnull align 4 dereferenceable(4) [[DOTOMP_LB]], ptr noundef nonnull align 4 dereferenceable(4) [[DOTOMP_UB]], ptr noundef nonnull align 4 dereferenceable(4) [[DOTOMP_STRIDE]], i32 noundef 1, i32 noundef 1)
; CGSCC-NEXT:    [[TMP2:%.*]] = load i32, ptr [[DOTOMP_UB]], align 4
; CGSCC-NEXT:    [[CMP4:%.*]] = icmp sgt i32 [[TMP2]], [[SUB2]]
; CGSCC-NEXT:    [[COND:%.*]] = select i1 [[CMP4]], i32 [[SUB2]], i32 [[TMP2]]
; CGSCC-NEXT:    store i32 [[COND]], ptr [[DOTOMP_UB]], align 4
; CGSCC-NEXT:    [[TMP3:%.*]] = load i32, ptr [[DOTOMP_LB]], align 4
; CGSCC-NEXT:    [[CMP513:%.*]] = icmp sgt i32 [[TMP3]], [[COND]]
; CGSCC-NEXT:    br i1 [[CMP513]], label [[OMP_LOOP_EXIT:%.*]], label [[OMP_INNER_FOR_BODY_LR_PH:%.*]]
; CGSCC:       omp.inner.for.body.lr.ph:
; CGSCC-NEXT:    [[TMP4:%.*]] = load ptr, ptr [[B]], align 8
; CGSCC-NEXT:    [[TMP5:%.*]] = load ptr, ptr [[A]], align 8
; CGSCC-NEXT:    [[TMP6:%.*]] = sext i32 [[TMP3]] to i64
; CGSCC-NEXT:    [[TMP7:%.*]] = sext i32 [[COND]] to i64
; CGSCC-NEXT:    br label [[OMP_INNER_FOR_BODY:%.*]]
; CGSCC:       omp.inner.for.body:
; CGSCC-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[OMP_INNER_FOR_BODY]] ], [ [[TMP6]], [[OMP_INNER_FOR_BODY_LR_PH]] ]
; CGSCC-NEXT:    [[INDVARS_IV_NEXT]] = add nsw i64 [[INDVARS_IV]], 1
; CGSCC-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds float, ptr [[TMP4]], i64 [[INDVARS_IV_NEXT]]
; CGSCC-NEXT:    [[TMP8:%.*]] = load float, ptr [[ARRAYIDX]], align 4
; CGSCC-NEXT:    [[CONV7:%.*]] = fadd float [[TMP8]], 1.000000e+00
; CGSCC-NEXT:    [[ARRAYIDX9:%.*]] = getelementptr inbounds float, ptr [[TMP5]], i64 [[INDVARS_IV_NEXT]]
; CGSCC-NEXT:    store float [[CONV7]], ptr [[ARRAYIDX9]], align 4
; CGSCC-NEXT:    [[CMP5:%.*]] = icmp slt i64 [[INDVARS_IV]], [[TMP7]]
; CGSCC-NEXT:    br i1 [[CMP5]], label [[OMP_INNER_FOR_BODY]], label [[OMP_LOOP_EXIT]]
; CGSCC:       omp.loop.exit:
; CGSCC-NEXT:    call void @__kmpc_for_static_fini(ptr noundef nonnull align 8 dereferenceable(24) @[[GLOB1]], i32 [[TMP1]])
; CGSCC-NEXT:    call void @llvm.lifetime.end.p0(i64 noundef 4, ptr nocapture nofree noundef nonnull align 4 dereferenceable(4) [[DOTOMP_IS_LAST]])
; CGSCC-NEXT:    call void @llvm.lifetime.end.p0(i64 noundef 4, ptr nocapture nofree noundef nonnull align 4 dereferenceable(4) [[DOTOMP_STRIDE]])
; CGSCC-NEXT:    call void @llvm.lifetime.end.p0(i64 noundef 4, ptr nocapture nofree noundef nonnull align 4 dereferenceable(4) [[DOTOMP_UB]])
; CGSCC-NEXT:    call void @llvm.lifetime.end.p0(i64 noundef 4, ptr nocapture nofree noundef nonnull align 4 dereferenceable(4) [[DOTOMP_LB]])
; CGSCC-NEXT:    br label [[OMP_PRECOND_END]]
; CGSCC:       omp.precond.end:
; CGSCC-NEXT:    ret void
;
entry:
  %.omp.lb = alloca i32, align 4
  %.omp.ub = alloca i32, align 4
  %.omp.stride = alloca i32, align 4
  %.omp.is_last = alloca i32, align 4
  %0 = load i32, ptr %N, align 4
  %sub2 = add nsw i32 %0, -2
  %cmp = icmp sgt i32 %0, 1
  br i1 %cmp, label %omp.precond.then, label %omp.precond.end

omp.precond.then:                                 ; preds = %entry
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %.omp.lb) #3
  store i32 0, ptr %.omp.lb, align 4
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %.omp.ub) #3
  store i32 %sub2, ptr %.omp.ub, align 4
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %.omp.stride) #3
  store i32 1, ptr %.omp.stride, align 4
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %.omp.is_last) #3
  store i32 0, ptr %.omp.is_last, align 4
  %1 = load i32, ptr %.global_tid., align 4
  call void @__kmpc_for_static_init_4(ptr nonnull @1, i32 %1, i32 34, ptr nonnull %.omp.is_last, ptr nonnull %.omp.lb, ptr nonnull %.omp.ub, ptr nonnull %.omp.stride, i32 1, i32 1) #3
  %2 = load i32, ptr %.omp.ub, align 4
  %cmp4 = icmp sgt i32 %2, %sub2
  %cond = select i1 %cmp4, i32 %sub2, i32 %2
  store i32 %cond, ptr %.omp.ub, align 4
  %3 = load i32, ptr %.omp.lb, align 4
  %cmp513 = icmp sgt i32 %3, %cond
  br i1 %cmp513, label %omp.loop.exit, label %omp.inner.for.body.lr.ph

omp.inner.for.body.lr.ph:                         ; preds = %omp.precond.then
  %4 = load ptr, ptr %b, align 8
  %5 = load ptr, ptr %a, align 8
  %6 = sext i32 %3 to i64
  %7 = sext i32 %cond to i64
  br label %omp.inner.for.body

omp.inner.for.body:                               ; preds = %omp.inner.for.body, %omp.inner.for.body.lr.ph
  %indvars.iv = phi i64 [ %indvars.iv.next, %omp.inner.for.body ], [ %6, %omp.inner.for.body.lr.ph ]
  %indvars.iv.next = add nsw i64 %indvars.iv, 1
  %arrayidx = getelementptr inbounds float, ptr %4, i64 %indvars.iv.next
  %8 = load float, ptr %arrayidx, align 4
  %conv7 = fadd float %8, 1.000000e+00
  %arrayidx9 = getelementptr inbounds float, ptr %5, i64 %indvars.iv.next
  store float %conv7, ptr %arrayidx9, align 4
  %cmp5 = icmp slt i64 %indvars.iv, %7
  br i1 %cmp5, label %omp.inner.for.body, label %omp.loop.exit

omp.loop.exit:                                    ; preds = %omp.inner.for.body, %omp.precond.then
  call void @__kmpc_for_static_fini(ptr nonnull @1, i32 %1)
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %.omp.is_last) #3
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %.omp.stride) #3
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %.omp.ub) #3
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %.omp.lb) #3
  br label %omp.precond.end

omp.precond.end:                                  ; preds = %omp.loop.exit, %entry
  ret void
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #2

declare dso_local void @__kmpc_for_static_init_4(ptr, i32, i32, ptr, ptr, ptr, ptr, i32, i32) local_unnamed_addr

; Function Attrs: nounwind
declare void @__kmpc_for_static_fini(ptr, i32) local_unnamed_addr #3

; Function Attrs: nounwind
declare !callback !1 void @__kmpc_fork_call(ptr, i32, ptr, ...) local_unnamed_addr #3

attributes #0 = { nounwind uwtable }
attributes #1 = { alwaysinline nofree norecurse nounwind uwtable }
attributes #2 = { nounwind }

!llvm.module.flags = !{!0}

!0 = !{i32 7, !"openmp", i32 50}
!1 = !{!2}
!2 = !{i64 2, i64 -1, i64 -1, i1 true}
;.
; CHECK: attributes #[[ATTR0:[0-9]+]] = { nounwind uwtable }
; CHECK: attributes #[[ATTR1:[0-9]+]] = { alwaysinline nofree norecurse nounwind uwtable }
; CHECK: attributes #[[ATTR2:[0-9]+]] = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
; CHECK: attributes #[[ATTR3:[0-9]+]] = { memory(readwrite) }
;.
; CHECK: [[META0:![0-9]+]] = !{i32 7, !"openmp", i32 50}
; CHECK: [[META1:![0-9]+]] = !{!2}
; CHECK: [[META2:![0-9]+]] = !{i64 2, i64 -1, i64 -1, i1 true}
;.
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; CHECK: {{.*}}
