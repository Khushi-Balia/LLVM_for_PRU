; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=slp-vectorizer -S  -slp-schedule-budget=16 -mtriple=x86_64-apple-macosx10.8.0 -mcpu=corei7-avx | FileCheck %s

target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.9.0"

; Test if the budget for the scheduling region size works.
; We test with a reduced budget of 16 which should prevent vectorizing the loads.

declare void @unknown()

define void @test(ptr %a, ptr %b, ptr %c, ptr %d) {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP1:%.*]] = load <4 x float>, ptr [[A:%.*]], align 4
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    store <4 x float> [[TMP1]], ptr [[B:%.*]], align 4
; CHECK-NEXT:    [[TMP4:%.*]] = load <4 x float>, ptr [[C:%.*]], align 4
; CHECK-NEXT:    store <4 x float> [[TMP4]], ptr [[D:%.*]], align 4
; CHECK-NEXT:    ret void
;
entry:
  ; Don't vectorize these loads.
  %l0 = load float, ptr %a
  %a1 = getelementptr inbounds float, ptr %a, i64 1
  %l1 = load float, ptr %a1
  %a2 = getelementptr inbounds float, ptr %a, i64 2
  %l2 = load float, ptr %a2
  %a3 = getelementptr inbounds float, ptr %a, i64 3
  %l3 = load float, ptr %a3

  ; some unrelated instructions inbetween to enlarge the scheduling region
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()

  ; Don't vectorize these stores because their operands are too far away.
  store float %l0, ptr %b
  %b1 = getelementptr inbounds float, ptr %b, i64 1
  store float %l1, ptr %b1
  %b2 = getelementptr inbounds float, ptr %b, i64 2
  store float %l2, ptr %b2
  %b3 = getelementptr inbounds float, ptr %b, i64 3
  store float %l3, ptr %b3

  ; But still vectorize the following instructions, because even if the budget
  ; is exceeded there is a minimum region size.
  %l4 = load float, ptr %c
  %c1 = getelementptr inbounds float, ptr %c, i64 1
  %l5 = load float, ptr %c1
  %c2 = getelementptr inbounds float, ptr %c, i64 2
  %l6 = load float, ptr %c2
  %c3 = getelementptr inbounds float, ptr %c, i64 3
  %l7 = load float, ptr %c3

  store float %l4, ptr %d
  %d1 = getelementptr inbounds float, ptr %d, i64 1
  store float %l5, ptr %d1
  %d2 = getelementptr inbounds float, ptr %d, i64 2
  store float %l6, ptr %d2
  %d3 = getelementptr inbounds float, ptr %d, i64 3
  store float %l7, ptr %d3

  ret void
}

