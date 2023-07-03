; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=indvars -indvars-predicate-loops=0 < %s | FileCheck %s

; Tests in this file are specifically about correctly handling possibly poison
; producing flags when converting from one IV to another.  In particular, there
; is a risk that the IV we chose to switch to is dynamically dead (i.e. there
; is no side effect which dependents on the computation thereof).  Such an IV
; can produce poison on one or more iterations without triggering UB.  When we
; add an additional use to such an IV, we need to ensure that our new use does
; not trigger UB where none existed in the original program.

; Provide legal integer types.
target datalayout = "n8:16:32:64"

@data = common global [240 x i8] zeroinitializer, align 16

;; In this example, the pointer IV is dynamicaly dead.  As such, the fact that
;; inbounds produces poison *does not* trigger UB in the original loop.  As
;; such, the pointer IV can be poison and adding a new use of the pointer
;; IV which dependends on that poison computation in a manner which might
;; trigger UB would be incorrect.
;; FIXME: This currently shows a miscompile!
define void @neg_dynamically_dead_inbounds(i1 %always_false) #0 {
; CHECK-LABEL: @neg_dynamically_dead_inbounds(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[I_0:%.*]] = phi i8 [ 0, [[ENTRY:%.*]] ], [ [[TMP4:%.*]], [[CONT:%.*]] ]
; CHECK-NEXT:    [[P_0:%.*]] = phi ptr [ @data, [[ENTRY]] ], [ [[TMP3:%.*]], [[CONT]] ]
; CHECK-NEXT:    [[TMP3]] = getelementptr inbounds i8, ptr [[P_0]], i64 1
; CHECK-NEXT:    br i1 [[ALWAYS_FALSE:%.*]], label [[NEVER_EXECUTED:%.*]], label [[CONT]]
; CHECK:       never_executed:
; CHECK-NEXT:    store volatile i8 0, ptr [[TMP3]], align 1
; CHECK-NEXT:    br label [[CONT]]
; CHECK:       cont:
; CHECK-NEXT:    [[TMP4]] = add nuw i8 [[I_0]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp ne i8 [[TMP4]], -10
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[LOOP]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %i.0 = phi i8 [ 0, %entry ], [ %tmp4, %cont ]
  %p.0 = phi ptr [ @data, %entry ], [ %tmp3, %cont ]
  %tmp3 = getelementptr inbounds i8, ptr %p.0, i64 1
  br i1 %always_false, label %never_executed, label %cont

never_executed:
  store volatile i8 0, ptr %tmp3
  br label %cont

cont:
  %tmp4 = add i8 %i.0, 1
  %tmp5 = icmp ult i8 %tmp4, -10
  br i1 %tmp5, label %loop, label %exit

exit:
  ret void
}

; Similiar to above, but shows how we currently guard non-constant
; memory operands in a manner which hides the latent miscompile.
define void @neg_dynamically_dead_inbounds2(ptr %a, i1 %always_false) #0 {
; CHECK-LABEL: @neg_dynamically_dead_inbounds2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[I_0:%.*]] = phi i8 [ 0, [[ENTRY:%.*]] ], [ [[TMP4:%.*]], [[CONT:%.*]] ]
; CHECK-NEXT:    [[P_0:%.*]] = phi ptr [ [[A:%.*]], [[ENTRY]] ], [ [[TMP3:%.*]], [[CONT]] ]
; CHECK-NEXT:    [[TMP3]] = getelementptr inbounds i8, ptr [[P_0]], i64 1
; CHECK-NEXT:    br i1 [[ALWAYS_FALSE:%.*]], label [[NEVER_EXECUTED:%.*]], label [[CONT]]
; CHECK:       never_executed:
; CHECK-NEXT:    store volatile i8 0, ptr [[TMP3]], align 1
; CHECK-NEXT:    br label [[CONT]]
; CHECK:       cont:
; CHECK-NEXT:    [[TMP4]] = add nuw i8 [[I_0]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp ne i8 [[TMP4]], -10
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[LOOP]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %i.0 = phi i8 [ 0, %entry ], [ %tmp4, %cont ]
  %p.0 = phi ptr [ %a, %entry ], [ %tmp3, %cont ]
  %tmp3 = getelementptr inbounds i8, ptr %p.0, i64 1
  br i1 %always_false, label %never_executed, label %cont

never_executed:
  store volatile i8 0, ptr %tmp3
  br label %cont

cont:
  %tmp4 = add i8 %i.0, 1
  %tmp5 = icmp ult i8 %tmp4, -10
  br i1 %tmp5, label %loop, label %exit

exit:
  ret void
}

define void @dom_store_preinc() #0 {
; CHECK-LABEL: @dom_store_preinc(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[P_0:%.*]] = phi ptr [ @data, [[ENTRY:%.*]] ], [ [[TMP3:%.*]], [[LOOP]] ]
; CHECK-NEXT:    store volatile i8 0, ptr [[P_0]], align 1
; CHECK-NEXT:    [[TMP3]] = getelementptr inbounds i8, ptr [[P_0]], i64 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp ne ptr [[P_0]], getelementptr ([240 x i8], ptr @data, i64 1, i64 5)
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[LOOP]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %i.0 = phi i8 [ 0, %entry ], [ %tmp4, %loop ]
  %p.0 = phi ptr [ @data, %entry ], [ %tmp3, %loop ]
  store volatile i8 0, ptr %p.0
  %tmp3 = getelementptr inbounds i8, ptr %p.0, i64 1
  %tmp4 = add i8 %i.0, 1
  %tmp5 = icmp ult i8 %tmp4, -10
  br i1 %tmp5, label %loop, label %exit

exit:
  ret void
}

define void @dom_store_postinc() #0 {
; CHECK-LABEL: @dom_store_postinc(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[P_0:%.*]] = phi ptr [ @data, [[ENTRY:%.*]] ], [ [[TMP3:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[TMP3]] = getelementptr inbounds i8, ptr [[P_0]], i64 1
; CHECK-NEXT:    store volatile i8 0, ptr [[TMP3]], align 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp ne ptr [[TMP3]], getelementptr ([240 x i8], ptr @data, i64 1, i64 6)
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[LOOP]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %i.0 = phi i8 [ 0, %entry ], [ %tmp4, %loop ]
  %p.0 = phi ptr [ @data, %entry ], [ %tmp3, %loop ]
  %tmp3 = getelementptr inbounds i8, ptr %p.0, i64 1
  store volatile i8 0, ptr %tmp3
  %tmp4 = add i8 %i.0, 1
  %tmp5 = icmp ult i8 %tmp4, -10
  br i1 %tmp5, label %loop, label %exit

exit:
  ret void
}

define i8 @dom_load() #0 {
; CHECK-LABEL: @dom_load(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[P_0:%.*]] = phi ptr [ @data, [[ENTRY:%.*]] ], [ [[TMP3:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[TMP3]] = getelementptr inbounds i8, ptr [[P_0]], i64 1
; CHECK-NEXT:    [[V:%.*]] = load i8, ptr [[TMP3]], align 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp ne ptr [[TMP3]], getelementptr ([240 x i8], ptr @data, i64 1, i64 6)
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[LOOP]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    [[V_LCSSA:%.*]] = phi i8 [ [[V]], [[LOOP]] ]
; CHECK-NEXT:    ret i8 [[V_LCSSA]]
;
entry:
  br label %loop

loop:
  %i.0 = phi i8 [ 0, %entry ], [ %tmp4, %loop ]
  %p.0 = phi ptr [ @data, %entry ], [ %tmp3, %loop ]
  %tmp3 = getelementptr inbounds i8, ptr %p.0, i64 1
  %v = load i8, ptr %tmp3
  %tmp4 = add i8 %i.0, 1
  %tmp5 = icmp ult i8 %tmp4, -10
  br i1 %tmp5, label %loop, label %exit

exit:
  ret i8 %v
}

define i64 @dom_div(i64 %input) #0 {
; CHECK-LABEL: @dom_div(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[I_0:%.*]] = phi i8 [ 0, [[ENTRY:%.*]] ], [ [[TMP4:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[I_1:%.*]] = phi i64 [ [[INPUT:%.*]], [[ENTRY]] ], [ [[TMP3:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[TMP3]] = add nuw nsw i64 [[I_1]], 1
; CHECK-NEXT:    [[V:%.*]] = udiv i64 5, [[TMP3]]
; CHECK-NEXT:    [[TMP4]] = add nuw i8 [[I_0]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp ne i8 [[TMP4]], -10
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[LOOP]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    [[V_LCSSA:%.*]] = phi i64 [ [[V]], [[LOOP]] ]
; CHECK-NEXT:    ret i64 [[V_LCSSA]]
;
entry:
  br label %loop

loop:
  %i.0 = phi i8 [ 0, %entry ], [ %tmp4, %loop ]
  %i.1 = phi i64 [ %input, %entry ], [ %tmp3, %loop ]
  %tmp3 = add nsw nuw i64 %i.1, 1
  %v = udiv i64 5, %tmp3
  %tmp4 = add i8 %i.0, 1
  %tmp5 = icmp ult i8 %tmp4, -10
  br i1 %tmp5, label %loop, label %exit

exit:
  ret i64 %v
}

; For integer IVs, we handle this trigger case by stripping the problematic
; flags which removes the potential introduction of UB.
define void @neg_dead_int_iv() #0 {
; CHECK-LABEL: @neg_dead_int_iv(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[I_1:%.*]] = phi i64 [ -2, [[ENTRY:%.*]] ], [ [[TMP3:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[TMP3]] = add nsw i64 [[I_1]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp ne i64 [[TMP3]], 244
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[LOOP]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %i.0 = phi i8 [ 0, %entry ], [ %tmp4, %loop ]
  %i.1 = phi i64 [ -2, %entry ], [ %tmp3, %loop ]
  %tmp3 = add nsw nuw i64 %i.1, 1
  %tmp4 = add i8 %i.0, 1
  %tmp5 = icmp ult i8 %tmp4, -10
  br i1 %tmp5, label %loop, label %exit

exit:
  ret void
}

