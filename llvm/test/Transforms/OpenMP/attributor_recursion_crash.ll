; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --scrub-attributes
; RUN: opt -passes=openmp-opt -S < %s | FileCheck %s
; TODO: This should have a second test case with a chain load->phi->load->phi
;                                                           A              |
;                                                           \-------------/

%"struct.TS" = type { i32, ptr }

define weak amdgpu_kernel void @k() {
; CHECK-LABEL: define {{[^@]+}}@k() {
; CHECK-NEXT:  BB1:
; CHECK-NEXT:    br label [[BB2:%.*]]
; CHECK:       BB2:
; CHECK-NEXT:    [[DOTPRE158_I:%.*]] = phi ptr [ null, [[BB1:%.*]] ], [ [[PRE2:%.*]], [[BB6:%.*]] ]
; CHECK-NEXT:    br i1 false, label [[BB4:%.*]], label [[BB3:%.*]]
; CHECK:       BB3:
; CHECK-NEXT:    br label [[BB4]]
; CHECK:       BB4:
; CHECK-NEXT:    [[PRE1:%.*]] = phi ptr [ [[DOTPRE158_I]], [[BB3]] ], [ null, [[BB2]] ]
; CHECK-NEXT:    br i1 false, label [[BB6]], label [[BB5:%.*]]
; CHECK:       BB5:
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds [[STRUCT_TS:%.*]], ptr [[PRE1]], i64 0, i32 1
; CHECK-NEXT:    [[Q3:%.*]] = load ptr, ptr [[GEP]], align 8
; CHECK-NEXT:    br label [[BB6]]
; CHECK:       BB6:
; CHECK-NEXT:    [[PRE2]] = phi ptr [ null, [[BB4]] ], [ [[Q3]], [[BB5]] ]
; CHECK-NEXT:    br label [[BB2]]
;
BB1:
  br label %BB2

BB2:
  %.pre158.i = phi ptr [ null, %BB1 ], [ %pre2, %BB6 ]
  br i1 false, label %BB4, label %BB3

BB3:
  br label %BB4

BB4:
  %pre1 = phi ptr [ %.pre158.i, %BB3 ], [ null, %BB2 ]
  br i1 false, label %BB6, label %BB5

BB5:
  %gep = getelementptr inbounds %"struct.TS", ptr %pre1, i64 0, i32 1
  %q3 = load ptr, ptr %gep, align 8
  br label %BB6

BB6:
  %pre2 = phi ptr [ null, %BB4 ], [ %q3, %BB5 ]
  br label %BB2
}

!llvm.module.flags = !{!0, !1}

!0 = !{i32 7, !"openmp", i32 50}
!1 = !{i32 7, !"openmp-device", i32 50}
