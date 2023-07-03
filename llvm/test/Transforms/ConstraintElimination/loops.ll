; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=constraint-elimination -S %s | FileCheck %s

declare void @use(i1)

; Make sure conditions in loops are not used to simplify themselves.

define void @loop1(ptr %T, ptr %x, i32 %points, i32 %trigint) {
; CHECK-LABEL: @loop1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[IDX_EXT:%.*]] = sext i32 [[POINTS:%.*]] to i64
; CHECK-NEXT:    [[ADD_PTR:%.*]] = getelementptr inbounds float, ptr [[X:%.*]], i64 [[IDX_EXT]]
; CHECK-NEXT:    [[ADD_PTR1:%.*]] = getelementptr inbounds float, ptr [[ADD_PTR]], i64 -8
; CHECK-NEXT:    [[SHR:%.*]] = ashr i32 [[POINTS]], 1
; CHECK-NEXT:    [[IDX_EXT2:%.*]] = sext i32 [[SHR]] to i64
; CHECK-NEXT:    [[ADD_PTR3:%.*]] = getelementptr inbounds float, ptr [[X]], i64 [[IDX_EXT2]]
; CHECK-NEXT:    [[ADD_PTR4:%.*]] = getelementptr inbounds float, ptr [[ADD_PTR3]], i64 -8
; CHECK-NEXT:    br label [[DO_BODY:%.*]]
; CHECK:       do.body:
; CHECK-NEXT:    [[X2_0:%.*]] = phi ptr [ [[ADD_PTR4]], [[ENTRY:%.*]] ], [ [[ADD_PTR106:%.*]], [[DO_BODY]] ]
; CHECK-NEXT:    [[X1_0:%.*]] = phi ptr [ [[ADD_PTR1]], [[ENTRY]] ], [ [[ADD_PTR105:%.*]], [[DO_BODY]] ]
; CHECK-NEXT:    [[ADD_PTR105]] = getelementptr inbounds float, ptr [[X1_0]], i64 -8
; CHECK-NEXT:    [[ADD_PTR106]] = getelementptr inbounds float, ptr [[X2_0]], i64 -8
; CHECK-NEXT:    [[CMP:%.*]] = icmp uge ptr [[ADD_PTR106]], [[X]]
; CHECK-NEXT:    br i1 [[CMP]], label [[DO_BODY]], label [[DO_END:%.*]]
; CHECK:       do.end:
; CHECK-NEXT:    ret void
;
entry:
  %idx.ext = sext i32 %points to i64
  %add.ptr = getelementptr inbounds float, ptr %x, i64 %idx.ext
  %add.ptr1 = getelementptr inbounds float, ptr %add.ptr, i64 -8
  %shr = ashr i32 %points, 1
  %idx.ext2 = sext i32 %shr to i64
  %add.ptr3 = getelementptr inbounds float, ptr %x, i64 %idx.ext2
  %add.ptr4 = getelementptr inbounds float, ptr %add.ptr3, i64 -8
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %x2.0 = phi ptr [ %add.ptr4, %entry ], [ %add.ptr106, %do.body ]
  %x1.0 = phi ptr [ %add.ptr1, %entry ], [ %add.ptr105, %do.body ]
  %add.ptr105 = getelementptr inbounds float, ptr %x1.0, i64 -8
  %add.ptr106 = getelementptr inbounds float, ptr %x2.0, i64 -8
  %cmp = icmp uge ptr %add.ptr106, %x
  br i1 %cmp, label %do.body, label %do.end

do.end:                                           ; preds = %do.body
  ret void
}


; Some tests with loops with conditions in the header.

define i32 @loop_header_dom(i32 %y, i1 %c) {
; CHECK-LABEL: @loop_header_dom(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[LOOP_HEADER:%.*]], label [[EXIT:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[X:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[X_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[C_1:%.*]] = icmp ule i32 [[X]], 10
; CHECK-NEXT:    br i1 [[C_1]], label [[LOOP_LATCH]], label [[EXIT]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[T_1:%.*]] = icmp ule i32 [[X]], 10
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    [[F_1:%.*]] = icmp ugt i32 [[X]], 10
; CHECK-NEXT:    call void @use(i1 false)
; CHECK-NEXT:    [[C_2:%.*]] = icmp ule i32 [[X]], 9
; CHECK-NEXT:    call void @use(i1 [[C_2]])
; CHECK-NEXT:    [[C_3:%.*]] = icmp ugt i32 [[X]], 9
; CHECK-NEXT:    call void @use(i1 [[C_3]])
; CHECK-NEXT:    [[X_NEXT]] = add i32 [[X]], 1
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    [[C_4:%.*]] = icmp ugt i32 [[Y:%.*]], 10
; CHECK-NEXT:    call void @use(i1 [[C_4]])
; CHECK-NEXT:    ret i32 20
;
entry:
  br i1 %c, label %loop.header, label %exit

loop.header:
  %x = phi i32 [ 0, %entry ], [ %x.next, %loop.latch ]
  %c.1 = icmp ule i32 %x, 10
  br i1 %c.1, label %loop.latch, label %exit

loop.latch:
  %t.1 = icmp ule i32 %x, 10
  call void @use(i1 %t.1)
  %f.1 = icmp ugt i32 %x, 10
  call void @use(i1 %f.1)

  %c.2 = icmp ule i32 %x, 9
  call void @use(i1 %c.2)
  %c.3 = icmp ugt i32 %x, 9
  call void @use(i1 %c.3)

  %x.next = add i32 %x, 1
  br label %loop.header

exit:
  %c.4 = icmp ugt i32 %y, 10
  call void @use(i1 %c.4)
  ret i32 20
}

define i32 @loop_header_dom_successors_flipped(i32 %y, i1 %c) {
; CHECK-LABEL: @loop_header_dom_successors_flipped(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[LOOP_HEADER:%.*]], label [[EXIT:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[X:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[X_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[C_1:%.*]] = icmp ule i32 [[X]], 10
; CHECK-NEXT:    br i1 [[C_1]], label [[EXIT]], label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[F_1:%.*]] = icmp ule i32 [[X]], 10
; CHECK-NEXT:    call void @use(i1 false)
; CHECK-NEXT:    [[T_1:%.*]] = icmp ugt i32 [[X]], 10
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    [[C_2:%.*]] = icmp ugt i32 [[X]], 11
; CHECK-NEXT:    call void @use(i1 [[C_2]])
; CHECK-NEXT:    [[C_3:%.*]] = icmp ule i32 [[X]], 11
; CHECK-NEXT:    call void @use(i1 [[C_3]])
; CHECK-NEXT:    [[X_NEXT]] = add i32 [[X]], 1
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    [[C_4:%.*]] = icmp ugt i32 [[Y:%.*]], 10
; CHECK-NEXT:    call void @use(i1 [[C_4]])
; CHECK-NEXT:    ret i32 20
;
entry:
  br i1 %c, label %loop.header, label %exit

loop.header:
  %x = phi i32 [ 0, %entry ], [ %x.next, %loop.latch ]
  %c.1 = icmp ule i32 %x, 10
  br i1 %c.1, label %exit, label %loop.latch

loop.latch:
  %f.1 = icmp ule i32 %x, 10
  call void @use(i1 %f.1)
  %t.1 = icmp ugt i32 %x, 10
  call void @use(i1 %t.1)

  %c.2 = icmp ugt i32 %x, 11
  call void @use(i1 %c.2)
  %c.3 = icmp ule i32 %x,11
  call void @use(i1 %c.3)

  %x.next = add i32 %x, 1
  br label %loop.header

exit:
  %c.4 = icmp ugt i32 %y, 10
  call void @use(i1 %c.4)
  ret i32 20
}

define void @loop_header_dom_or(i32 %y, i1 %c) {
; CHECK-LABEL: @loop_header_dom_or(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[LOOP_HEADER:%.*]], label [[EXIT:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[X:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[X_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[X_1:%.*]] = icmp ule i32 [[X]], 10
; CHECK-NEXT:    [[Y_1:%.*]] = icmp ugt i32 [[Y:%.*]], 99
; CHECK-NEXT:    [[OR:%.*]] = or i1 [[X_1]], [[Y_1]]
; CHECK-NEXT:    br i1 [[OR]], label [[EXIT]], label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[T_1:%.*]] = icmp ugt i32 [[X]], 10
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    [[F_1:%.*]] = icmp ule i32 [[X]], 10
; CHECK-NEXT:    call void @use(i1 false)
; CHECK-NEXT:    [[C_1:%.*]] = icmp ugt i32 [[X]], 11
; CHECK-NEXT:    call void @use(i1 [[C_1]])
; CHECK-NEXT:    [[C_2:%.*]] = icmp ule i32 [[X]], 11
; CHECK-NEXT:    call void @use(i1 [[C_2]])
; CHECK-NEXT:    [[T_2:%.*]] = icmp ule i32 [[Y]], 99
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    [[F_2:%.*]] = icmp ugt i32 [[Y]], 99
; CHECK-NEXT:    call void @use(i1 false)
; CHECK-NEXT:    [[C_3:%.*]] = icmp ule i32 [[Y]], 98
; CHECK-NEXT:    call void @use(i1 [[C_3]])
; CHECK-NEXT:    [[C_4:%.*]] = icmp ule i32 [[Y]], 98
; CHECK-NEXT:    call void @use(i1 [[C_4]])
; CHECK-NEXT:    [[X_NEXT]] = add i32 [[X]], 1
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    [[C_5:%.*]] = icmp ugt i32 [[Y]], 10
; CHECK-NEXT:    call void @use(i1 [[C_5]])
; CHECK-NEXT:    ret void
;
entry:
  br i1 %c, label %loop.header, label %exit

loop.header:
  %x = phi i32 [ 0, %entry ], [ %x.next, %loop.latch ]
  %x.1 = icmp ule i32 %x, 10
  %y.1 = icmp ugt i32 %y, 99
  %or = or i1 %x.1, %y.1
  br i1 %or, label %exit, label %loop.latch

loop.latch:
  %t.1 = icmp ugt i32 %x, 10
  call void @use(i1 %t.1)
  %f.1 = icmp ule i32 %x, 10
  call void @use(i1 %f.1)
  %c.1 = icmp ugt i32 %x, 11
  call void @use(i1 %c.1)
  %c.2 = icmp ule i32 %x, 11
  call void @use(i1 %c.2)


  %t.2 = icmp ule i32 %y, 99
  call void @use(i1 %t.2)
  %f.2 = icmp ugt i32 %y, 99
  call void @use(i1 %f.2)

  %c.3 = icmp ule i32 %y, 98
  call void @use(i1 %c.3)
  %c.4 = icmp ule i32 %y, 98
  call void @use(i1 %c.4)

  %x.next = add i32 %x, 1
  br label %loop.header

exit:
  %c.5 = icmp ugt i32 %y, 10
  call void @use(i1 %c.5)
  ret void
}

define void @loop_header_dom_or_successors_flipped(i32 %y, i1 %c) {
; CHECK-LABEL: @loop_header_dom_or_successors_flipped(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[LOOP_HEADER:%.*]], label [[EXIT:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[X:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[X_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[X_1:%.*]] = icmp ule i32 [[X]], 10
; CHECK-NEXT:    [[Y_1:%.*]] = icmp ugt i32 [[Y:%.*]], 99
; CHECK-NEXT:    [[OR:%.*]] = or i1 [[X_1]], [[Y_1]]
; CHECK-NEXT:    br i1 [[OR]], label [[LOOP_LATCH]], label [[EXIT]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[C_1:%.*]] = icmp ule i32 [[X]], 10
; CHECK-NEXT:    call void @use(i1 [[C_1]])
; CHECK-NEXT:    [[C_2:%.*]] = icmp ugt i32 [[X]], 10
; CHECK-NEXT:    call void @use(i1 [[C_2]])
; CHECK-NEXT:    [[C_3:%.*]] = icmp ule i32 [[X]], 9
; CHECK-NEXT:    call void @use(i1 [[C_3]])
; CHECK-NEXT:    [[C_4:%.*]] = icmp ugt i32 [[X]], 9
; CHECK-NEXT:    call void @use(i1 [[C_4]])
; CHECK-NEXT:    [[C_5:%.*]] = icmp ugt i32 [[Y]], 99
; CHECK-NEXT:    call void @use(i1 [[C_5]])
; CHECK-NEXT:    [[C_6:%.*]] = icmp ule i32 [[Y]], 99
; CHECK-NEXT:    call void @use(i1 [[C_6]])
; CHECK-NEXT:    [[C_7:%.*]] = icmp ugt i32 [[Y]], 100
; CHECK-NEXT:    call void @use(i1 [[C_7]])
; CHECK-NEXT:    [[C_8:%.*]] = icmp ugt i32 [[Y]], 100
; CHECK-NEXT:    call void @use(i1 [[C_8]])
; CHECK-NEXT:    [[X_NEXT]] = add i32 [[X]], 1
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    [[T_1:%.*]] = icmp ugt i32 [[Y]], 10
; CHECK-NEXT:    call void @use(i1 [[T_1]])
; CHECK-NEXT:    ret void
;
entry:
  br i1 %c, label %loop.header, label %exit

loop.header:
  %x = phi i32 [ 0, %entry ], [ %x.next, %loop.latch ]
  %x.1 = icmp ule i32 %x, 10
  %y.1 = icmp ugt i32 %y, 99
  %or = or i1 %x.1, %y.1
  br i1 %or, label %loop.latch, label %exit

loop.latch:
  %c.1 = icmp ule i32 %x, 10
  call void @use(i1 %c.1)
  %c.2 = icmp ugt i32 %x, 10
  call void @use(i1 %c.2)
  %c.3 = icmp ule i32 %x, 9
  call void @use(i1 %c.3)
  %c.4 = icmp ugt i32 %x, 9
  call void @use(i1 %c.4)


  %c.5 = icmp ugt i32 %y, 99
  call void @use(i1 %c.5)
  %c.6 = icmp ule i32 %y, 99
  call void @use(i1 %c.6)

  %c.7 = icmp ugt i32 %y, 100
  call void @use(i1 %c.7)
  %c.8 = icmp ugt i32 %y, 100
  call void @use(i1 %c.8)

  %x.next = add i32 %x, 1
  br label %loop.header

exit:
  %t.1 = icmp ugt i32 %y, 10
  call void @use(i1 %t.1)
  ret void
}


define void @loop_header_dom_and(i32 %y, i1 %c) {
; CHECK-LABEL: @loop_header_dom_and(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[LOOP_HEADER:%.*]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    [[C_5:%.*]] = icmp ugt i32 [[Y:%.*]], 10
; CHECK-NEXT:    call void @use(i1 [[C_5]])
; CHECK-NEXT:    ret void
; CHECK:       loop.header:
; CHECK-NEXT:    [[X:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[X_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[X_1:%.*]] = icmp ule i32 [[X]], 10
; CHECK-NEXT:    [[Y_1:%.*]] = icmp ugt i32 [[Y]], 99
; CHECK-NEXT:    [[AND:%.*]] = and i1 [[X_1]], [[Y_1]]
; CHECK-NEXT:    br i1 [[AND]], label [[LOOP_LATCH]], label [[EXIT_1:%.*]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[T_1:%.*]] = icmp ule i32 [[X]], 10
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    [[F_1:%.*]] = icmp ugt i32 [[X]], 10
; CHECK-NEXT:    call void @use(i1 false)
; CHECK-NEXT:    [[C_1:%.*]] = icmp ule i32 [[X]], 9
; CHECK-NEXT:    call void @use(i1 [[C_1]])
; CHECK-NEXT:    [[C_2:%.*]] = icmp ugt i32 [[X]], 9
; CHECK-NEXT:    call void @use(i1 [[C_2]])
; CHECK-NEXT:    [[T_2:%.*]] = icmp ugt i32 [[Y]], 99
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    [[F_2:%.*]] = icmp ule i32 [[Y]], 99
; CHECK-NEXT:    call void @use(i1 false)
; CHECK-NEXT:    [[C_3:%.*]] = icmp ugt i32 [[Y]], 100
; CHECK-NEXT:    call void @use(i1 [[C_3]])
; CHECK-NEXT:    [[C_4:%.*]] = icmp ugt i32 [[Y]], 100
; CHECK-NEXT:    call void @use(i1 [[C_4]])
; CHECK-NEXT:    [[X_NEXT]] = add i32 [[X]], 1
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit.1:
; CHECK-NEXT:    [[C_6:%.*]] = icmp ugt i32 [[Y]], 10
; CHECK-NEXT:    call void @use(i1 [[C_6]])
; CHECK-NEXT:    ret void
;
entry:
  br i1 %c, label %loop.header, label %exit

exit:
  %c.5 = icmp ugt i32 %y, 10
  call void @use(i1 %c.5)
  ret void

loop.header:
  %x = phi i32 [ 0, %entry ], [ %x.next, %loop.latch ]
  %x.1 = icmp ule i32 %x, 10
  %y.1 = icmp ugt i32 %y, 99
  %and = and i1 %x.1, %y.1
  br i1 %and, label %loop.latch, label %exit.1

loop.latch:
  %t.1 = icmp ule i32 %x, 10
  call void @use(i1 %t.1)
  %f.1 = icmp ugt i32 %x, 10
  call void @use(i1 %f.1)
  %c.1 = icmp ule i32 %x, 9
  call void @use(i1 %c.1)
  %c.2 = icmp ugt i32 %x, 9
  call void @use(i1 %c.2)


  %t.2 = icmp ugt i32 %y, 99
  call void @use(i1 %t.2)
  %f.2 = icmp ule i32 %y, 99
  call void @use(i1 %f.2)

  %c.3 = icmp ugt i32 %y, 100
  call void @use(i1 %c.3)
  %c.4 = icmp ugt i32 %y, 100
  call void @use(i1 %c.4)

  %x.next = add i32 %x, 1
  br label %loop.header

exit.1:
  %c.6 = icmp ugt i32 %y, 10
  call void @use(i1 %c.6)
  ret void
}

define void @loop_header_dom_and_successors_flipped(i32 %y, i1 %c) {
; CHECK-LABEL: @loop_header_dom_and_successors_flipped(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[LOOP_HEADER:%.*]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    [[C_9:%.*]] = icmp ugt i32 [[Y:%.*]], 10
; CHECK-NEXT:    call void @use(i1 [[C_9]])
; CHECK-NEXT:    ret void
; CHECK:       loop.header:
; CHECK-NEXT:    [[X:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[X_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[X_1:%.*]] = icmp ule i32 [[X]], 10
; CHECK-NEXT:    [[Y_1:%.*]] = icmp ugt i32 [[Y]], 99
; CHECK-NEXT:    [[AND:%.*]] = and i1 [[X_1]], [[Y_1]]
; CHECK-NEXT:    br i1 [[AND]], label [[EXIT_1:%.*]], label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[C_1:%.*]] = icmp ule i32 [[X]], 10
; CHECK-NEXT:    call void @use(i1 [[C_1]])
; CHECK-NEXT:    [[C_2:%.*]] = icmp ugt i32 [[X]], 10
; CHECK-NEXT:    call void @use(i1 [[C_2]])
; CHECK-NEXT:    [[C_3:%.*]] = icmp ule i32 [[X]], 9
; CHECK-NEXT:    call void @use(i1 [[C_3]])
; CHECK-NEXT:    [[C_4:%.*]] = icmp ugt i32 [[X]], 9
; CHECK-NEXT:    call void @use(i1 [[C_4]])
; CHECK-NEXT:    [[C_5:%.*]] = icmp ugt i32 [[Y]], 99
; CHECK-NEXT:    call void @use(i1 [[C_5]])
; CHECK-NEXT:    [[C_6:%.*]] = icmp ule i32 [[Y]], 99
; CHECK-NEXT:    call void @use(i1 [[C_6]])
; CHECK-NEXT:    [[C_7:%.*]] = icmp ugt i32 [[Y]], 100
; CHECK-NEXT:    call void @use(i1 [[C_7]])
; CHECK-NEXT:    [[C_8:%.*]] = icmp ugt i32 [[Y]], 100
; CHECK-NEXT:    call void @use(i1 [[C_8]])
; CHECK-NEXT:    [[X_NEXT]] = add i32 [[X]], 1
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit.1:
; CHECK-NEXT:    [[T_1:%.*]] = icmp ugt i32 [[Y]], 10
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    ret void
;
entry:
  br i1 %c, label %loop.header, label %exit

exit:
  %c.9 = icmp ugt i32 %y, 10
  call void @use(i1 %c.9)
  ret void

loop.header:
  %x = phi i32 [ 0, %entry ], [ %x.next, %loop.latch ]
  %x.1 = icmp ule i32 %x, 10
  %y.1 = icmp ugt i32 %y, 99
  %and = and i1 %x.1, %y.1
  br i1 %and, label %exit.1, label %loop.latch

loop.latch:
  %c.1 = icmp ule i32 %x, 10
  call void @use(i1 %c.1)
  %c.2 = icmp ugt i32 %x, 10
  call void @use(i1 %c.2)
  %c.3 = icmp ule i32 %x, 9
  call void @use(i1 %c.3)
  %c.4 = icmp ugt i32 %x, 9
  call void @use(i1 %c.4)


  %c.5 = icmp ugt i32 %y, 99
  call void @use(i1 %c.5)
  %c.6 = icmp ule i32 %y, 99
  call void @use(i1 %c.6)

  %c.7 = icmp ugt i32 %y, 100
  call void @use(i1 %c.7)
  %c.8 = icmp ugt i32 %y, 100
  call void @use(i1 %c.8)

  %x.next = add i32 %x, 1
  br label %loop.header

exit.1:
  %t.1 = icmp ugt i32 %y, 10
  call void @use(i1 %t.1)
  ret void
}
