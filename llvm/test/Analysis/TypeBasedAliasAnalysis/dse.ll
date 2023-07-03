; RUN: opt < %s -aa-pipeline=tbaa,basic-aa -passes=dse -S | FileCheck %s
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

; DSE should make use of TBAA.

; CHECK: @test0_yes
; CHECK-NEXT: load i8, ptr %b
; CHECK-NEXT: store i8 1, ptr %a
; CHECK-NEXT: ret i8 %y
define i8 @test0_yes(ptr %a, ptr %b) nounwind {
  store i8 0, ptr %a, !tbaa !1
  %y = load i8, ptr %b, !tbaa !2
  store i8 1, ptr %a, !tbaa !1
  ret i8 %y
}

; CHECK: @test0_no
; CHECK-NEXT: store i8 0, ptr %a
; CHECK-NEXT: load i8, ptr %b
; CHECK-NEXT: store i8 1, ptr %a
; CHECK-NEXT: ret i8 %y
define i8 @test0_no(ptr %a, ptr %b) nounwind {
  store i8 0, ptr %a, !tbaa !3
  %y = load i8, ptr %b, !tbaa !4
  store i8 1, ptr %a, !tbaa !3
  ret i8 %y
}

; CHECK: @test1_yes
; CHECK-NEXT: load i8, ptr %b
; CHECK-NEXT: store i8 1, ptr %a
; CHECK-NEXT: ret i8 %y
define i8 @test1_yes(ptr %a, ptr %b) nounwind {
  store i8 0, ptr %a
  %y = load i8, ptr %b, !tbaa !5
  store i8 1, ptr %a
  ret i8 %y
}

; CHECK: @test1_no
; CHECK-NEXT: store i8 0, ptr %a
; CHECK-NEXT: load i8, ptr %b
; CHECK-NEXT: store i8 1, ptr %a
; CHECK-NEXT: ret i8 %y
define i8 @test1_no(ptr %a, ptr %b) nounwind {
  store i8 0, ptr %a
  %y = load i8, ptr %b, !tbaa !6
  store i8 1, ptr %a
  ret i8 %y
}

; Root note.
!0 = !{ }
; Some type.
!1 = !{!7, !7, i64 0}
; Some other non-aliasing type.
!2 = !{!8, !8, i64 0}

; Some type.
!3 = !{!9, !9, i64 0}
; Some type in a different type system.
!4 = !{!10, !10, i64 0}

; Invariant memory.
!5 = !{!11, !11, i64 0, i1 1}
; Not invariant memory.
!6 = !{!11, !11, i64 0, i1 0}
!7 = !{ !"foo", !0 }
!8 = !{ !"bar", !0 }
!9 = !{ !"foo", !0 }
!10 = !{ !"bar", !12}
!11 = !{ !"qux", !0}
!12 = !{!"different"}
