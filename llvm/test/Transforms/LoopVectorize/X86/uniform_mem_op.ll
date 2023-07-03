; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -force-vector-width=4 -passes=loop-vectorize -mcpu=haswell < %s | FileCheck %s

;; Basic functional tests for uniform loads and stores.  These are cases kept
;; deliberately simple (and unoptimized by other passes) to feed the vectorizer
;; with particular input IR.

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @uniform_load(ptr align(4) %addr) {
; CHECK-LABEL: @uniform_load(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr [[ADDR:%.*]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 16
; CHECK-NEXT:    [[TMP1:%.*]] = icmp eq i64 [[INDEX_NEXT]], 4096
; CHECK-NEXT:    br i1 [[TMP1]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 4097, 4096
; CHECK-NEXT:    br i1 [[CMP_N]], label [[LOOPEXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ 4096, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[IV_NEXT:%.*]], [[FOR_BODY]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[LOAD:%.*]] = load i32, ptr [[ADDR]], align 4
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i64 [[IV]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[IV]], 4096
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[LOOPEXIT]], label [[FOR_BODY]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       loopexit:
; CHECK-NEXT:    [[LOAD_LCSSA:%.*]] = phi i32 [ [[LOAD]], [[FOR_BODY]] ], [ [[TMP0]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret i32 [[LOAD_LCSSA]]
;
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ %iv.next, %for.body ], [ 0, %entry ]
  %load = load i32, ptr %addr
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv, 4096
  br i1 %exitcond, label %loopexit, label %for.body

loopexit:
  ret i32 %load
}

define i32 @uniform_load2(ptr align(4) %addr) {
; CHECK-LABEL: @uniform_load2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <4 x i32> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP1:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI1:%.*]] = phi <4 x i32> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP2:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI2:%.*]] = phi <4 x i32> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP3:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI3:%.*]] = phi <4 x i32> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP4:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr [[ADDR:%.*]], align 4
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT8:%.*]] = insertelement <4 x i32> poison, i32 [[TMP0]], i64 0
; CHECK-NEXT:    [[BROADCAST_SPLAT9:%.*]] = shufflevector <4 x i32> [[BROADCAST_SPLATINSERT8]], <4 x i32> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP1]] = add <4 x i32> [[VEC_PHI]], [[BROADCAST_SPLAT9]]
; CHECK-NEXT:    [[TMP2]] = add <4 x i32> [[VEC_PHI1]], [[BROADCAST_SPLAT9]]
; CHECK-NEXT:    [[TMP3]] = add <4 x i32> [[VEC_PHI2]], [[BROADCAST_SPLAT9]]
; CHECK-NEXT:    [[TMP4]] = add <4 x i32> [[VEC_PHI3]], [[BROADCAST_SPLAT9]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 16
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i64 [[INDEX_NEXT]], 4096
; CHECK-NEXT:    br i1 [[TMP5]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[BIN_RDX:%.*]] = add <4 x i32> [[TMP2]], [[TMP1]]
; CHECK-NEXT:    [[BIN_RDX10:%.*]] = add <4 x i32> [[TMP3]], [[BIN_RDX]]
; CHECK-NEXT:    [[BIN_RDX11:%.*]] = add <4 x i32> [[TMP4]], [[BIN_RDX10]]
; CHECK-NEXT:    [[TMP6:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[BIN_RDX11]])
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 4097, 4096
; CHECK-NEXT:    br i1 [[CMP_N]], label [[LOOPEXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ 4096, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[BC_MERGE_RDX:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[TMP6]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[IV_NEXT:%.*]], [[FOR_BODY]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[ACCUM:%.*]] = phi i32 [ [[ACCUM_NEXT:%.*]], [[FOR_BODY]] ], [ [[BC_MERGE_RDX]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[LOAD:%.*]] = load i32, ptr [[ADDR]], align 4
; CHECK-NEXT:    [[ACCUM_NEXT]] = add i32 [[ACCUM]], [[LOAD]]
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i64 [[IV]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[IV]], 4096
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[LOOPEXIT]], label [[FOR_BODY]], !llvm.loop [[LOOP5:![0-9]+]]
; CHECK:       loopexit:
; CHECK-NEXT:    [[ACCUM_NEXT_LCSSA:%.*]] = phi i32 [ [[ACCUM_NEXT]], [[FOR_BODY]] ], [ [[TMP6]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret i32 [[ACCUM_NEXT_LCSSA]]
;
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ %iv.next, %for.body ], [ 0, %entry ]
  %accum = phi i32 [%accum.next, %for.body], [0, %entry]
  %load = load i32, ptr %addr
  %accum.next = add i32 %accum, %load
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv, 4096
  br i1 %exitcond, label %loopexit, label %for.body

loopexit:
  ret i32 %accum.next
}

define i32 @uniform_address(ptr align(4) %addr, i32 %byte_offset) {
; CHECK-LABEL: @uniform_address(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = udiv i32 [[BYTE_OFFSET:%.*]], 4
; CHECK-NEXT:    [[TMP1:%.*]] = udiv i32 [[BYTE_OFFSET]], 4
; CHECK-NEXT:    [[TMP2:%.*]] = udiv i32 [[BYTE_OFFSET]], 4
; CHECK-NEXT:    [[TMP3:%.*]] = udiv i32 [[BYTE_OFFSET]], 4
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr i32, ptr [[ADDR:%.*]], i32 [[TMP0]]
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr i32, ptr [[ADDR]], i32 [[TMP1]]
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr i32, ptr [[ADDR]], i32 [[TMP2]]
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr i32, ptr [[ADDR]], i32 [[TMP3]]
; CHECK-NEXT:    [[TMP8:%.*]] = load i32, ptr [[TMP4]], align 4
; CHECK-NEXT:    [[TMP9:%.*]] = load i32, ptr [[TMP5]], align 4
; CHECK-NEXT:    [[TMP10:%.*]] = load i32, ptr [[TMP6]], align 4
; CHECK-NEXT:    [[TMP11:%.*]] = load i32, ptr [[TMP7]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 16
; CHECK-NEXT:    [[TMP12:%.*]] = icmp eq i64 [[INDEX_NEXT]], 4096
; CHECK-NEXT:    br i1 [[TMP12]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP6:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 4097, 4096
; CHECK-NEXT:    br i1 [[CMP_N]], label [[LOOPEXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ 4096, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[IV_NEXT:%.*]], [[FOR_BODY]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[OFFSET:%.*]] = udiv i32 [[BYTE_OFFSET]], 4
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr i32, ptr [[ADDR]], i32 [[OFFSET]]
; CHECK-NEXT:    [[LOAD:%.*]] = load i32, ptr [[GEP]], align 4
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i64 [[IV]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[IV]], 4096
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[LOOPEXIT]], label [[FOR_BODY]], !llvm.loop [[LOOP7:![0-9]+]]
; CHECK:       loopexit:
; CHECK-NEXT:    [[LOAD_LCSSA:%.*]] = phi i32 [ [[LOAD]], [[FOR_BODY]] ], [ [[TMP11]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret i32 [[LOAD_LCSSA]]
;
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ %iv.next, %for.body ], [ 0, %entry ]
  %offset = udiv i32 %byte_offset, 4
  %gep = getelementptr i32, ptr %addr, i32 %offset
  %load = load i32, ptr %gep
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv, 4096
  br i1 %exitcond, label %loopexit, label %for.body

loopexit:
  ret i32 %load
}



define void @uniform_store_uniform_value(ptr align(4) %addr) {
; CHECK-LABEL: @uniform_store_uniform_value(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    store i32 0, ptr [[ADDR:%.*]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 16
; CHECK-NEXT:    [[TMP0:%.*]] = icmp eq i64 [[INDEX_NEXT]], 4096
; CHECK-NEXT:    br i1 [[TMP0]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP8:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 4097, 4096
; CHECK-NEXT:    br i1 [[CMP_N]], label [[LOOPEXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ 4096, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[IV_NEXT:%.*]], [[FOR_BODY]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    store i32 0, ptr [[ADDR]], align 4
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i64 [[IV]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[IV]], 4096
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[LOOPEXIT]], label [[FOR_BODY]], !llvm.loop [[LOOP9:![0-9]+]]
; CHECK:       loopexit:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ %iv.next, %for.body ], [ 0, %entry ]
  store i32 0, ptr %addr
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv, 4096
  br i1 %exitcond, label %loopexit, label %for.body

loopexit:
  ret void
}

define void @uniform_store_varying_value(ptr align(4) %addr) {
; CHECK-LABEL: @uniform_store_varying_value(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[OFFSET_IDX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = trunc i64 [[OFFSET_IDX]] to i32
; CHECK-NEXT:    [[TMP1:%.*]] = add i32 [[TMP0]], 0
; CHECK-NEXT:    [[TMP2:%.*]] = add i32 [[TMP0]], 1
; CHECK-NEXT:    [[TMP3:%.*]] = add i32 [[TMP0]], 2
; CHECK-NEXT:    [[TMP4:%.*]] = add i32 [[TMP0]], 3
; CHECK-NEXT:    [[TMP5:%.*]] = add i32 [[TMP0]], 4
; CHECK-NEXT:    [[TMP6:%.*]] = add i32 [[TMP0]], 5
; CHECK-NEXT:    [[TMP7:%.*]] = add i32 [[TMP0]], 6
; CHECK-NEXT:    [[TMP8:%.*]] = add i32 [[TMP0]], 7
; CHECK-NEXT:    [[TMP9:%.*]] = add i32 [[TMP0]], 8
; CHECK-NEXT:    [[TMP10:%.*]] = add i32 [[TMP0]], 9
; CHECK-NEXT:    [[TMP11:%.*]] = add i32 [[TMP0]], 10
; CHECK-NEXT:    [[TMP12:%.*]] = add i32 [[TMP0]], 11
; CHECK-NEXT:    [[TMP13:%.*]] = add i32 [[TMP0]], 12
; CHECK-NEXT:    [[TMP14:%.*]] = add i32 [[TMP0]], 13
; CHECK-NEXT:    [[TMP15:%.*]] = add i32 [[TMP0]], 14
; CHECK-NEXT:    [[TMP16:%.*]] = add i32 [[TMP0]], 15
; CHECK-NEXT:    store i32 [[TMP16]], ptr [[ADDR:%.*]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[OFFSET_IDX]], 16
; CHECK-NEXT:    [[TMP17:%.*]] = icmp eq i64 [[INDEX_NEXT]], 4096
; CHECK-NEXT:    br i1 [[TMP17]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP10:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 4097, 4096
; CHECK-NEXT:    br i1 [[CMP_N]], label [[LOOPEXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ 4096, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[IV_NEXT:%.*]], [[FOR_BODY]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[IV_I32:%.*]] = trunc i64 [[IV]] to i32
; CHECK-NEXT:    store i32 [[IV_I32]], ptr [[ADDR]], align 4
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i64 [[IV]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[IV]], 4096
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[LOOPEXIT]], label [[FOR_BODY]], !llvm.loop [[LOOP11:![0-9]+]]
; CHECK:       loopexit:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ %iv.next, %for.body ], [ 0, %entry ]
  %iv.i32 = trunc i64 %iv to i32
  store i32 %iv.i32, ptr %addr
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv, 4096
  br i1 %exitcond, label %loopexit, label %for.body

loopexit:
  ret void
}

define void @uniform_rw(ptr align(4) %addr) {
; CHECK-LABEL: @uniform_rw(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[IV_NEXT:%.*]], [[FOR_BODY]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[LOAD:%.*]] = load i32, ptr [[ADDR:%.*]], align 4
; CHECK-NEXT:    [[INC:%.*]] = add i32 [[LOAD]], 1
; CHECK-NEXT:    store i32 [[INC]], ptr [[ADDR]], align 4
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i64 [[IV]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[IV]], 4096
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[LOOPEXIT:%.*]], label [[FOR_BODY]]
; CHECK:       loopexit:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ %iv.next, %for.body ], [ 0, %entry ]
  %load = load i32, ptr %addr
  %inc = add i32 %load, 1
  store i32 %inc, ptr %addr
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv, 4096
  br i1 %exitcond, label %loopexit, label %for.body

loopexit:
  ret void
}

define void @uniform_copy(ptr %A, ptr %B) {
; CHECK-LABEL: @uniform_copy(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_MEMCHECK:%.*]]
; CHECK:       vector.memcheck:
; CHECK-NEXT:    [[UGLYGEP:%.*]] = getelementptr i8, ptr [[B:%.*]], i64 4
; CHECK-NEXT:    [[UGLYGEP1:%.*]] = getelementptr i8, ptr [[A:%.*]], i64 4
; CHECK-NEXT:    [[BOUND0:%.*]] = icmp ult ptr [[B]], [[UGLYGEP1]]
; CHECK-NEXT:    [[BOUND1:%.*]] = icmp ult ptr [[A]], [[UGLYGEP]]
; CHECK-NEXT:    [[FOUND_CONFLICT:%.*]] = and i1 [[BOUND0]], [[BOUND1]]
; CHECK-NEXT:    br i1 [[FOUND_CONFLICT]], label [[SCALAR_PH]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr [[A]], align 4, !alias.scope !12
; CHECK-NEXT:    store i32 [[TMP0]], ptr [[B]], align 4, !alias.scope !15, !noalias !12
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 16
; CHECK-NEXT:    [[TMP1:%.*]] = icmp eq i64 [[INDEX_NEXT]], 4096
; CHECK-NEXT:    br i1 [[TMP1]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP17:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 4097, 4096
; CHECK-NEXT:    br i1 [[CMP_N]], label [[LOOPEXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ 4096, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ], [ 0, [[VECTOR_MEMCHECK]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[IV_NEXT:%.*]], [[FOR_BODY]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[LOAD:%.*]] = load i32, ptr [[A]], align 4
; CHECK-NEXT:    store i32 [[LOAD]], ptr [[B]], align 4
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i64 [[IV]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[IV]], 4096
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[LOOPEXIT]], label [[FOR_BODY]], !llvm.loop [[LOOP18:![0-9]+]]
; CHECK:       loopexit:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ %iv.next, %for.body ], [ 0, %entry ]
  %load = load i32, ptr %A
  store i32 %load, ptr %B
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv, 4096
  br i1 %exitcond, label %loopexit, label %for.body

loopexit:
  ret void
}


declare void @init(ptr)

;; Count the number of bits set in a bit vector -- key point of relevance is
;; that the byte load is uniform across 8 iterations at a time.
define i32 @test_count_bits(ptr %test_base) {
; CHECK-LABEL: @test_count_bits(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ALLOCA:%.*]] = alloca [4096 x i32], align 4
; CHECK-NEXT:    call void @init(ptr [[ALLOCA]])
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_IND:%.*]] = phi <4 x i64> [ <i64 0, i64 1, i64 2, i64 3>, [[VECTOR_PH]] ], [ [[VEC_IND_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <4 x i32> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP50:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI2:%.*]] = phi <4 x i32> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP51:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[STEP_ADD:%.*]] = add <4 x i64> [[VEC_IND]], <i64 4, i64 4, i64 4, i64 4>
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = add i64 [[INDEX]], 1
; CHECK-NEXT:    [[TMP2:%.*]] = add i64 [[INDEX]], 2
; CHECK-NEXT:    [[TMP3:%.*]] = add i64 [[INDEX]], 3
; CHECK-NEXT:    [[TMP4:%.*]] = add i64 [[INDEX]], 4
; CHECK-NEXT:    [[TMP5:%.*]] = add i64 [[INDEX]], 5
; CHECK-NEXT:    [[TMP6:%.*]] = add i64 [[INDEX]], 6
; CHECK-NEXT:    [[TMP7:%.*]] = add i64 [[INDEX]], 7
; CHECK-NEXT:    [[TMP8:%.*]] = udiv i64 [[TMP0]], 8
; CHECK-NEXT:    [[TMP9:%.*]] = udiv i64 [[TMP1]], 8
; CHECK-NEXT:    [[TMP10:%.*]] = udiv i64 [[TMP2]], 8
; CHECK-NEXT:    [[TMP11:%.*]] = udiv i64 [[TMP3]], 8
; CHECK-NEXT:    [[TMP12:%.*]] = udiv i64 [[TMP4]], 8
; CHECK-NEXT:    [[TMP13:%.*]] = udiv i64 [[TMP5]], 8
; CHECK-NEXT:    [[TMP14:%.*]] = udiv i64 [[TMP6]], 8
; CHECK-NEXT:    [[TMP15:%.*]] = udiv i64 [[TMP7]], 8
; CHECK-NEXT:    [[TMP16:%.*]] = getelementptr inbounds i8, ptr [[TEST_BASE:%.*]], i64 [[TMP8]]
; CHECK-NEXT:    [[TMP17:%.*]] = getelementptr inbounds i8, ptr [[TEST_BASE]], i64 [[TMP9]]
; CHECK-NEXT:    [[TMP18:%.*]] = getelementptr inbounds i8, ptr [[TEST_BASE]], i64 [[TMP10]]
; CHECK-NEXT:    [[TMP19:%.*]] = getelementptr inbounds i8, ptr [[TEST_BASE]], i64 [[TMP11]]
; CHECK-NEXT:    [[TMP20:%.*]] = getelementptr inbounds i8, ptr [[TEST_BASE]], i64 [[TMP12]]
; CHECK-NEXT:    [[TMP21:%.*]] = getelementptr inbounds i8, ptr [[TEST_BASE]], i64 [[TMP13]]
; CHECK-NEXT:    [[TMP22:%.*]] = getelementptr inbounds i8, ptr [[TEST_BASE]], i64 [[TMP14]]
; CHECK-NEXT:    [[TMP23:%.*]] = getelementptr inbounds i8, ptr [[TEST_BASE]], i64 [[TMP15]]
; CHECK-NEXT:    [[TMP24:%.*]] = load i8, ptr [[TMP16]], align 1
; CHECK-NEXT:    [[TMP25:%.*]] = load i8, ptr [[TMP17]], align 1
; CHECK-NEXT:    [[TMP26:%.*]] = load i8, ptr [[TMP18]], align 1
; CHECK-NEXT:    [[TMP27:%.*]] = load i8, ptr [[TMP19]], align 1
; CHECK-NEXT:    [[TMP28:%.*]] = insertelement <4 x i8> poison, i8 [[TMP24]], i32 0
; CHECK-NEXT:    [[TMP29:%.*]] = insertelement <4 x i8> [[TMP28]], i8 [[TMP25]], i32 1
; CHECK-NEXT:    [[TMP30:%.*]] = insertelement <4 x i8> [[TMP29]], i8 [[TMP26]], i32 2
; CHECK-NEXT:    [[TMP31:%.*]] = insertelement <4 x i8> [[TMP30]], i8 [[TMP27]], i32 3
; CHECK-NEXT:    [[TMP32:%.*]] = load i8, ptr [[TMP20]], align 1
; CHECK-NEXT:    [[TMP33:%.*]] = load i8, ptr [[TMP21]], align 1
; CHECK-NEXT:    [[TMP34:%.*]] = load i8, ptr [[TMP22]], align 1
; CHECK-NEXT:    [[TMP35:%.*]] = load i8, ptr [[TMP23]], align 1
; CHECK-NEXT:    [[TMP36:%.*]] = insertelement <4 x i8> poison, i8 [[TMP32]], i32 0
; CHECK-NEXT:    [[TMP37:%.*]] = insertelement <4 x i8> [[TMP36]], i8 [[TMP33]], i32 1
; CHECK-NEXT:    [[TMP38:%.*]] = insertelement <4 x i8> [[TMP37]], i8 [[TMP34]], i32 2
; CHECK-NEXT:    [[TMP39:%.*]] = insertelement <4 x i8> [[TMP38]], i8 [[TMP35]], i32 3
; CHECK-NEXT:    [[TMP40:%.*]] = urem <4 x i64> [[VEC_IND]], <i64 8, i64 8, i64 8, i64 8>
; CHECK-NEXT:    [[TMP41:%.*]] = urem <4 x i64> [[STEP_ADD]], <i64 8, i64 8, i64 8, i64 8>
; CHECK-NEXT:    [[TMP42:%.*]] = trunc <4 x i64> [[TMP40]] to <4 x i8>
; CHECK-NEXT:    [[TMP43:%.*]] = trunc <4 x i64> [[TMP41]] to <4 x i8>
; CHECK-NEXT:    [[TMP44:%.*]] = lshr <4 x i8> [[TMP31]], [[TMP42]]
; CHECK-NEXT:    [[TMP45:%.*]] = lshr <4 x i8> [[TMP39]], [[TMP43]]
; CHECK-NEXT:    [[TMP46:%.*]] = and <4 x i8> [[TMP44]], <i8 1, i8 1, i8 1, i8 1>
; CHECK-NEXT:    [[TMP47:%.*]] = and <4 x i8> [[TMP45]], <i8 1, i8 1, i8 1, i8 1>
; CHECK-NEXT:    [[TMP48:%.*]] = zext <4 x i8> [[TMP46]] to <4 x i32>
; CHECK-NEXT:    [[TMP49:%.*]] = zext <4 x i8> [[TMP47]] to <4 x i32>
; CHECK-NEXT:    [[TMP50]] = add <4 x i32> [[VEC_PHI]], [[TMP48]]
; CHECK-NEXT:    [[TMP51]] = add <4 x i32> [[VEC_PHI2]], [[TMP49]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 8
; CHECK-NEXT:    [[VEC_IND_NEXT]] = add <4 x i64> [[STEP_ADD]], <i64 4, i64 4, i64 4, i64 4>
; CHECK-NEXT:    [[TMP52:%.*]] = icmp eq i64 [[INDEX_NEXT]], 4096
; CHECK-NEXT:    br i1 [[TMP52]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP19:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[BIN_RDX:%.*]] = add <4 x i32> [[TMP51]], [[TMP50]]
; CHECK-NEXT:    [[TMP53:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[BIN_RDX]])
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 4096, 4096
; CHECK-NEXT:    br i1 [[CMP_N]], label [[LOOP_EXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ 4096, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[BC_MERGE_RDX:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[TMP53]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[ACCUM:%.*]] = phi i32 [ [[BC_MERGE_RDX]], [[SCALAR_PH]] ], [ [[ACCUM_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[IV_NEXT]] = add i64 [[IV]], 1
; CHECK-NEXT:    [[BYTE:%.*]] = udiv i64 [[IV]], 8
; CHECK-NEXT:    [[TEST_ADDR:%.*]] = getelementptr inbounds i8, ptr [[TEST_BASE]], i64 [[BYTE]]
; CHECK-NEXT:    [[EARLYCND:%.*]] = load i8, ptr [[TEST_ADDR]], align 1
; CHECK-NEXT:    [[BIT:%.*]] = urem i64 [[IV]], 8
; CHECK-NEXT:    [[BIT_TRUNC:%.*]] = trunc i64 [[BIT]] to i8
; CHECK-NEXT:    [[MASK:%.*]] = lshr i8 [[EARLYCND]], [[BIT_TRUNC]]
; CHECK-NEXT:    [[TEST:%.*]] = and i8 [[MASK]], 1
; CHECK-NEXT:    [[VAL:%.*]] = zext i8 [[TEST]] to i32
; CHECK-NEXT:    [[ACCUM_NEXT]] = add i32 [[ACCUM]], [[VAL]]
; CHECK-NEXT:    [[EXIT:%.*]] = icmp ugt i64 [[IV]], 4094
; CHECK-NEXT:    br i1 [[EXIT]], label [[LOOP_EXIT]], label [[LOOP]], !llvm.loop [[LOOP20:![0-9]+]]
; CHECK:       loop_exit:
; CHECK-NEXT:    [[ACCUM_NEXT_LCSSA:%.*]] = phi i32 [ [[ACCUM_NEXT]], [[LOOP]] ], [ [[TMP53]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret i32 [[ACCUM_NEXT_LCSSA]]
;
entry:
  %alloca = alloca [4096 x i32]
  call void @init(ptr %alloca)
  br label %loop
loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %accum = phi i32 [ 0, %entry ], [ %accum.next, %loop ]
  %iv.next = add i64 %iv, 1
  %byte = udiv i64 %iv, 8
  %test_addr = getelementptr inbounds i8, ptr %test_base, i64 %byte
  %earlycnd = load i8, ptr %test_addr
  %bit = urem i64 %iv, 8
  %bit.trunc = trunc i64 %bit to i8
  %mask = lshr i8 %earlycnd, %bit.trunc
  %test = and i8 %mask, 1
  %val = zext i8 %test to i32
  %accum.next = add i32 %accum, %val
  %exit = icmp ugt i64 %iv, 4094
  br i1 %exit, label %loop_exit, label %loop

loop_exit:
  ret i32 %accum.next
}

;; Same as uniform_load, but show that the uniformity analysis can handle
;; pointer operands which are not local to the function.
@GAddr = external global i32 align 4
define i32 @uniform_load_global() {
; CHECK-LABEL: @uniform_load_global(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <4 x i32> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP1:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI1:%.*]] = phi <4 x i32> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP2:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI2:%.*]] = phi <4 x i32> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP3:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI3:%.*]] = phi <4 x i32> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP4:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr @GAddr, align 4
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT8:%.*]] = insertelement <4 x i32> poison, i32 [[TMP0]], i64 0
; CHECK-NEXT:    [[BROADCAST_SPLAT9:%.*]] = shufflevector <4 x i32> [[BROADCAST_SPLATINSERT8]], <4 x i32> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP1]] = add <4 x i32> [[VEC_PHI]], [[BROADCAST_SPLAT9]]
; CHECK-NEXT:    [[TMP2]] = add <4 x i32> [[VEC_PHI1]], [[BROADCAST_SPLAT9]]
; CHECK-NEXT:    [[TMP3]] = add <4 x i32> [[VEC_PHI2]], [[BROADCAST_SPLAT9]]
; CHECK-NEXT:    [[TMP4]] = add <4 x i32> [[VEC_PHI3]], [[BROADCAST_SPLAT9]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 16
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i64 [[INDEX_NEXT]], 4096
; CHECK-NEXT:    br i1 [[TMP5]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP21:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[BIN_RDX:%.*]] = add <4 x i32> [[TMP2]], [[TMP1]]
; CHECK-NEXT:    [[BIN_RDX10:%.*]] = add <4 x i32> [[TMP3]], [[BIN_RDX]]
; CHECK-NEXT:    [[BIN_RDX11:%.*]] = add <4 x i32> [[TMP4]], [[BIN_RDX10]]
; CHECK-NEXT:    [[TMP6:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[BIN_RDX11]])
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 4097, 4096
; CHECK-NEXT:    br i1 [[CMP_N]], label [[LOOPEXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ 4096, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[BC_MERGE_RDX:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[TMP6]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[IV_NEXT:%.*]], [[FOR_BODY]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[ACCUM:%.*]] = phi i32 [ [[ACCUM_NEXT:%.*]], [[FOR_BODY]] ], [ [[BC_MERGE_RDX]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[LOAD:%.*]] = load i32, ptr @GAddr, align 4
; CHECK-NEXT:    [[ACCUM_NEXT]] = add i32 [[ACCUM]], [[LOAD]]
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i64 [[IV]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[IV]], 4096
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[LOOPEXIT]], label [[FOR_BODY]], !llvm.loop [[LOOP22:![0-9]+]]
; CHECK:       loopexit:
; CHECK-NEXT:    [[ACCUM_NEXT_LCSSA:%.*]] = phi i32 [ [[ACCUM_NEXT]], [[FOR_BODY]] ], [ [[TMP6]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret i32 [[ACCUM_NEXT_LCSSA]]
;
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ %iv.next, %for.body ], [ 0, %entry ]
  %accum = phi i32 [%accum.next, %for.body], [0, %entry]
  %load = load i32, ptr @GAddr
  %accum.next = add i32 %accum, %load
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv, 4096
  br i1 %exitcond, label %loopexit, label %for.body

loopexit:
  ret i32 %accum.next
}

;; Same as the global case, but using a constexpr
define i32 @uniform_load_constexpr() {
; CHECK-LABEL: @uniform_load_constexpr(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <4 x i32> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP1:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI1:%.*]] = phi <4 x i32> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP2:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI2:%.*]] = phi <4 x i32> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP3:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI3:%.*]] = phi <4 x i32> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP4:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr getelementptr (i32, ptr @GAddr, i64 5), align 4
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT8:%.*]] = insertelement <4 x i32> poison, i32 [[TMP0]], i64 0
; CHECK-NEXT:    [[BROADCAST_SPLAT9:%.*]] = shufflevector <4 x i32> [[BROADCAST_SPLATINSERT8]], <4 x i32> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP1]] = add <4 x i32> [[VEC_PHI]], [[BROADCAST_SPLAT9]]
; CHECK-NEXT:    [[TMP2]] = add <4 x i32> [[VEC_PHI1]], [[BROADCAST_SPLAT9]]
; CHECK-NEXT:    [[TMP3]] = add <4 x i32> [[VEC_PHI2]], [[BROADCAST_SPLAT9]]
; CHECK-NEXT:    [[TMP4]] = add <4 x i32> [[VEC_PHI3]], [[BROADCAST_SPLAT9]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 16
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i64 [[INDEX_NEXT]], 4096
; CHECK-NEXT:    br i1 [[TMP5]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP23:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[BIN_RDX:%.*]] = add <4 x i32> [[TMP2]], [[TMP1]]
; CHECK-NEXT:    [[BIN_RDX10:%.*]] = add <4 x i32> [[TMP3]], [[BIN_RDX]]
; CHECK-NEXT:    [[BIN_RDX11:%.*]] = add <4 x i32> [[TMP4]], [[BIN_RDX10]]
; CHECK-NEXT:    [[TMP6:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[BIN_RDX11]])
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 4097, 4096
; CHECK-NEXT:    br i1 [[CMP_N]], label [[LOOPEXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ 4096, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[BC_MERGE_RDX:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[TMP6]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[IV_NEXT:%.*]], [[FOR_BODY]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[ACCUM:%.*]] = phi i32 [ [[ACCUM_NEXT:%.*]], [[FOR_BODY]] ], [ [[BC_MERGE_RDX]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[LOAD:%.*]] = load i32, ptr getelementptr (i32, ptr @GAddr, i64 5), align 4
; CHECK-NEXT:    [[ACCUM_NEXT]] = add i32 [[ACCUM]], [[LOAD]]
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i64 [[IV]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[IV]], 4096
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[LOOPEXIT]], label [[FOR_BODY]], !llvm.loop [[LOOP24:![0-9]+]]
; CHECK:       loopexit:
; CHECK-NEXT:    [[ACCUM_NEXT_LCSSA:%.*]] = phi i32 [ [[ACCUM_NEXT]], [[FOR_BODY]] ], [ [[TMP6]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret i32 [[ACCUM_NEXT_LCSSA]]
;
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %iv = phi i64 [ %iv.next, %for.body ], [ 0, %entry ]
  %accum = phi i32 [ %accum.next, %for.body ], [ 0, %entry ]
  %load = load i32, ptr getelementptr (i32, ptr @GAddr, i64 5), align 4
  %accum.next = add i32 %accum, %load
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv, 4096
  br i1 %exitcond, label %loopexit, label %for.body

loopexit:                                         ; preds = %for.body
  ret i32 %accum.next
}
