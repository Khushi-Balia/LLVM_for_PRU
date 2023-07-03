; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt < %s -disable-output -scalar-evolution-use-expensive-range-sharpening -passes='print<scalar-evolution>' 2>&1 | FileCheck %s

define i32 @test_01(i32 %start, ptr %p, ptr %q) {
; CHECK-LABEL: 'test_01'
; CHECK-NEXT:  Classifying expressions for: @test_01
; CHECK-NEXT:    %0 = zext i32 %start to i64
; CHECK-NEXT:    --> (zext i32 %start to i64) U: [0,4294967296) S: [0,4294967296)
; CHECK-NEXT:    %indvars.iv = phi i64 [ %indvars.iv.next, %backedge ], [ %0, %entry ]
; CHECK-NEXT:    --> {(zext i32 %start to i64),+,-1}<nsw><%loop> U: [0,4294967296) S: [0,4294967296) Exits: <<Unknown>> LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %iv = phi i32 [ %start, %entry ], [ %iv.next, %backedge ]
; CHECK-NEXT:    --> {%start,+,-1}<%loop> U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %iv.next = add i32 %iv, -1
; CHECK-NEXT:    --> {(-1 + %start),+,-1}<%loop> U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %index = zext i32 %iv.next to i64
; CHECK-NEXT:    --> (zext i32 {(-1 + %start),+,-1}<%loop> to i64) U: [0,4294967296) S: [0,4294967296) Exits: <<Unknown>> LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %store.addr = getelementptr i32, ptr %p, i64 %index
; CHECK-NEXT:    --> ((4 * (zext i32 {(-1 + %start),+,-1}<%loop> to i64))<nuw><nsw> + %p) U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %load.addr = getelementptr i32, ptr %q, i64 %index
; CHECK-NEXT:    --> ((4 * (zext i32 {(-1 + %start),+,-1}<%loop> to i64))<nuw><nsw> + %q) U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %stop = load i32, ptr %load.addr, align 4
; CHECK-NEXT:    --> %stop U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %loop: Variant }
; CHECK-NEXT:    %indvars.iv.next = add nsw i64 %indvars.iv, -1
; CHECK-NEXT:    --> {(-1 + (zext i32 %start to i64))<nsw>,+,-1}<nsw><%loop> U: [-4294967296,4294967295) S: [-1,4294967295) Exits: <<Unknown>> LoopDispositions: { %loop: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @test_01
; CHECK-NEXT:  Loop %loop: <multiple exits> Unpredictable backedge-taken count.
; CHECK-NEXT:    exit count for loop: (zext i32 %start to i64)
; CHECK-NEXT:    exit count for backedge: ***COULDNOTCOMPUTE***
; CHECK-NEXT:  Loop %loop: constant max backedge-taken count is 4294967295
; CHECK-NEXT:  Loop %loop: symbolic max backedge-taken count is (zext i32 %start to i64)
; CHECK-NEXT:    symbolic max exit count for loop: (zext i32 %start to i64)
; CHECK-NEXT:    symbolic max exit count for backedge: ***COULDNOTCOMPUTE***
; CHECK-NEXT:  Loop %loop: Unpredictable predicated backedge-taken count.
;
entry:
  %0 = zext i32 %start to i64
  br label %loop

loop:                                             ; preds = %backedge, %entry
  %indvars.iv = phi i64 [ %indvars.iv.next, %backedge ], [ %0, %entry ]
  %iv = phi i32 [ %start, %entry ], [ %iv.next, %backedge ]
  %cond = icmp eq i64 %indvars.iv, 0
  br i1 %cond, label %exit, label %backedge

backedge:                                         ; preds = %loop
  %iv.next = add i32 %iv, -1
  %index = zext i32 %iv.next to i64
  %store.addr = getelementptr i32, ptr %p, i64 %index
  store i32 1, ptr %store.addr, align 4
  %load.addr = getelementptr i32, ptr %q, i64 %index
  %stop = load i32, ptr %load.addr, align 4
  %loop.cond = icmp eq i32 %stop, 0
  %indvars.iv.next = add nsw i64 %indvars.iv, -1
  br i1 %loop.cond, label %loop, label %failure

exit:                                             ; preds = %loop
  ret i32 0

failure:                                          ; preds = %backedge
  unreachable
}

; Check that we do not mess up with wrapping ranges.
define i32 @test_02(i32 %start, ptr %p, ptr %q) {
; CHECK-LABEL: 'test_02'
; CHECK-NEXT:  Classifying expressions for: @test_02
; CHECK-NEXT:    %zext = zext i32 %start to i64
; CHECK-NEXT:    --> (zext i32 %start to i64) U: [0,4294967296) S: [0,4294967296)
; CHECK-NEXT:    %shl = shl i64 %zext, 31
; CHECK-NEXT:    --> (2147483648 * (zext i32 %start to i64))<nuw><nsw> U: [0,9223372034707292161) S: [0,9223372034707292161)
; CHECK-NEXT:    %indvars.iv = phi i64 [ %indvars.iv.next, %loop ], [ %shl, %entry ]
; CHECK-NEXT:    --> {(2147483648 * (zext i32 %start to i64))<nuw><nsw>,+,-1}<nsw><%loop> U: [-9223372036854775808,9223372034707292161) S: [-9223372036854775808,9223372034707292161) Exits: -9223372036854775806 LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %indvars.iv.next = add nsw i64 %indvars.iv, -1
; CHECK-NEXT:    --> {(-1 + (2147483648 * (zext i32 %start to i64))<nuw><nsw>)<nsw>,+,-1}<nw><%loop> U: full-set S: full-set Exits: -9223372036854775807 LoopDispositions: { %loop: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @test_02
; CHECK-NEXT:  Loop %loop: backedge-taken count is (9223372036854775806 + (2147483648 * (zext i32 %start to i64))<nuw><nsw>)<nuw>
; CHECK-NEXT:  Loop %loop: constant max backedge-taken count is -2147483650
; CHECK-NEXT:  Loop %loop: symbolic max backedge-taken count is (9223372036854775806 + (2147483648 * (zext i32 %start to i64))<nuw><nsw>)<nuw>
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is (9223372036854775806 + (2147483648 * (zext i32 %start to i64))<nuw><nsw>)<nuw>
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  %zext = zext i32 %start to i64
  %shl = shl i64 %zext, 31
  br label %loop

loop:                                             ; preds = %backedge, %entry
  %indvars.iv = phi i64 [ %indvars.iv.next, %loop ], [ %shl, %entry ]
  %cond = icmp eq i64 %indvars.iv, -9223372036854775806
  %indvars.iv.next = add nsw i64 %indvars.iv, -1
  br i1 %cond, label %exit, label %loop

exit:                                             ; preds = %loop
  ret i32 0
}

define void @pointer_iv_nowrap(ptr %startptr, ptr %endptr) local_unnamed_addr {
; CHECK-LABEL: 'pointer_iv_nowrap'
; CHECK-NEXT:  Classifying expressions for: @pointer_iv_nowrap
; CHECK-NEXT:    %init = getelementptr inbounds i8, ptr %startptr, i64 2000
; CHECK-NEXT:    --> (2000 + %startptr) U: full-set S: full-set
; CHECK-NEXT:    %iv = phi ptr [ %init, %entry ], [ %iv.next, %loop ]
; CHECK-NEXT:    --> {(2000 + %startptr),+,1}<nuw><%loop> U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %iv.next = getelementptr inbounds i8, ptr %iv, i64 1
; CHECK-NEXT:    --> {(2001 + %startptr),+,1}<nuw><%loop> U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %loop: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @pointer_iv_nowrap
; CHECK-NEXT:  Loop %loop: Unpredictable backedge-taken count.
; CHECK-NEXT:  Loop %loop: Unpredictable constant max backedge-taken count.
; CHECK-NEXT:  Loop %loop: Unpredictable symbolic max backedge-taken count.
; CHECK-NEXT:  Loop %loop: Unpredictable predicated backedge-taken count.
;
entry:
  %init = getelementptr inbounds i8, ptr %startptr, i64 2000
  br label %loop

loop:
  %iv = phi ptr [ %init, %entry ], [ %iv.next, %loop ]
  %iv.next = getelementptr inbounds i8, ptr %iv, i64 1
  %ec = icmp ugt ptr %iv.next, %endptr
  br i1 %ec, label %end, label %loop

end:
  ret void
}

define void @pointer_iv_nowrap_guard(ptr %startptr, ptr %endptr) local_unnamed_addr {
; CHECK-LABEL: 'pointer_iv_nowrap_guard'
; CHECK-NEXT:  Classifying expressions for: @pointer_iv_nowrap_guard
; CHECK-NEXT:    %init = getelementptr inbounds i32, ptr %startptr, i64 2000
; CHECK-NEXT:    --> (8000 + %startptr)<nuw> U: [8000,0) S: [8000,0)
; CHECK-NEXT:    %iv = phi ptr [ %init, %entry ], [ %iv.next, %loop ]
; CHECK-NEXT:    --> {(8000 + %startptr)<nuw>,+,4}<nuw><%loop> U: [8000,0) S: [8000,0) Exits: (8000 + (4 * ((-8001 + (-1 * (ptrtoint ptr %startptr to i64)) + ((8004 + (ptrtoint ptr %startptr to i64)) umax (ptrtoint ptr %endptr to i64))) /u 4))<nuw> + %startptr) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %iv.next = getelementptr inbounds i32, ptr %iv, i64 1
; CHECK-NEXT:    --> {(8004 + %startptr),+,4}<nuw><%loop> U: full-set S: full-set Exits: (8004 + (4 * ((-8001 + (-1 * (ptrtoint ptr %startptr to i64)) + ((8004 + (ptrtoint ptr %startptr to i64)) umax (ptrtoint ptr %endptr to i64))) /u 4))<nuw> + %startptr) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @pointer_iv_nowrap_guard
; CHECK-NEXT:  Loop %loop: backedge-taken count is ((-8001 + (-1 * (ptrtoint ptr %startptr to i64)) + ((8004 + (ptrtoint ptr %startptr to i64)) umax (ptrtoint ptr %endptr to i64))) /u 4)
; CHECK-NEXT:  Loop %loop: constant max backedge-taken count is 4611686018427387903
; CHECK-NEXT:  Loop %loop: symbolic max backedge-taken count is ((-8001 + (-1 * (ptrtoint ptr %startptr to i64)) + ((8004 + (ptrtoint ptr %startptr to i64)) umax (ptrtoint ptr %endptr to i64))) /u 4)
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is ((-8001 + (-1 * (ptrtoint ptr %startptr to i64)) + ((8004 + (ptrtoint ptr %startptr to i64)) umax (ptrtoint ptr %endptr to i64))) /u 4)
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  %init = getelementptr inbounds i32, ptr %startptr, i64 2000
  %cmp2 = icmp ult ptr %init, %endptr
  br i1 %cmp2, label %loop, label %end

loop:
  %iv = phi ptr [ %init, %entry ], [ %iv.next, %loop ]
  %iv.next = getelementptr inbounds i32, ptr %iv, i64 1
  %ec = icmp uge ptr %iv.next, %endptr
  br i1 %ec, label %end, label %loop

end:
  ret void
}
