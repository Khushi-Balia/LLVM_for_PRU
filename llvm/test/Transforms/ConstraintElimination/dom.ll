; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=constraint-elimination -S %s | FileCheck %s

; Test cases where both the true and false successors reach the same block,
; dominated by one of them.

declare void @use(i1)

define i1 @test1(i8 %x) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[C_1:%.*]] = icmp ule i8 [[X:%.*]], 10
; CHECK-NEXT:    br i1 [[C_1]], label [[BB1:%.*]], label [[BB2:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    [[C_2:%.*]] = icmp ule i8 [[X]], 10
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    br label [[BB2]]
; CHECK:       bb2:
; CHECK-NEXT:    [[C_3:%.*]] = icmp ugt i8 [[X]], 10
; CHECK-NEXT:    ret i1 [[C_3]]
;
entry:
  %c.1 = icmp ule i8 %x, 10
  br i1 %c.1, label %bb1, label %bb2

bb1:
  %c.2 = icmp ule i8 %x, 10
  call void @use(i1 %c.2)
  br label %bb2

bb2:
  %c.3 = icmp ugt i8 %x, 10
  ret i1 %c.3
}

define i1 @test_chain_1(i8 %x) {
; CHECK-LABEL: @test_chain_1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[C_1:%.*]] = icmp ule i8 [[X:%.*]], 10
; CHECK-NEXT:    br i1 [[C_1]], label [[THEN:%.*]], label [[ELSE:%.*]]
; CHECK:       then:
; CHECK-NEXT:    [[C_2:%.*]] = icmp ule i8 [[X]], 10
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       else:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[C_3:%.*]] = icmp ugt i8 [[X]], 10
; CHECK-NEXT:    ret i1 [[C_3]]
;
entry:
  %c.1 = icmp ule i8 %x, 10
  br i1 %c.1, label %then, label %else

then:
  %c.2 = icmp ule i8 %x, 10
  call void @use(i1 %c.2)
  br label %exit

else:
  br label %exit

exit:
  %c.3 = icmp ugt i8 %x, 10
  ret i1 %c.3
}

define i1 @test_chain_2(i8 %x) {
; CHECK-LABEL: @test_chain_2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[C_1:%.*]] = icmp ule i8 [[X:%.*]], 10
; CHECK-NEXT:    br i1 [[C_1]], label [[THEN:%.*]], label [[ELSE:%.*]]
; CHECK:       then:
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       else:
; CHECK-NEXT:    [[C_2:%.*]] = icmp ule i8 [[X]], 10
; CHECK-NEXT:    call void @use(i1 false)
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[C_3:%.*]] = icmp ugt i8 [[X]], 10
; CHECK-NEXT:    ret i1 [[C_3]]
;
entry:
  %c.1 = icmp ule i8 %x, 10
  br i1 %c.1, label %then, label %else

then:
  br label %exit

else:
  %c.2 = icmp ule i8 %x, 10
  call void @use(i1 %c.2)
  br label %exit

exit:
  %c.3 = icmp ugt i8 %x, 10
  ret i1 %c.3
}

define i1 @test2(i8 %x) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[C_1:%.*]] = icmp ule i8 [[X:%.*]], 10
; CHECK-NEXT:    br i1 [[C_1]], label [[BB2:%.*]], label [[BB1:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    [[C_2:%.*]] = icmp ugt i8 [[X]], 10
; CHECK-NEXT:    ret i1 [[C_2]]
; CHECK:       bb2:
; CHECK-NEXT:    [[C_3:%.*]] = icmp ule i8 [[X]], 10
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    br label [[BB1]]
;
entry:
  %c.1 = icmp ule i8 %x, 10
  br i1 %c.1, label %bb2, label %bb1

bb1:
  %c.2 = icmp ugt i8 %x, 10
  ret i1 %c.2

bb2:
  %c.3 = icmp ule i8 %x, 10
  call void @use(i1 %c.3)
  br label %bb1
}

; Test cases where the true/false successors are not domianted by the conditional branching block.
define i1 @test3(i8 %x, i1 %c) {
; CHECK-LABEL: @test3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[BB_COND:%.*]], label [[BB1:%.*]]
; CHECK:       bb.cond:
; CHECK-NEXT:    [[C_1:%.*]] = icmp ule i8 [[X:%.*]], 10
; CHECK-NEXT:    br i1 [[C_1]], label [[BB1]], label [[BB2:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    [[C_2:%.*]] = icmp ule i8 [[X]], 10
; CHECK-NEXT:    ret i1 [[C_2]]
; CHECK:       bb2:
; CHECK-NEXT:    [[C_3:%.*]] = icmp ugt i8 [[X]], 10
; CHECK-NEXT:    ret i1 true
;
entry:
  br i1 %c, label %bb.cond, label %bb1

bb.cond:
  %c.1 = icmp ule i8 %x, 10
  br i1 %c.1, label %bb1, label %bb2

bb1:
  %c.2 = icmp ule i8 %x, 10
  ret i1 %c.2

bb2:
  %c.3 = icmp ugt i8 %x, 10
  ret i1 %c.3
}

define i1 @test4(i8 %x, i1 %c) {
; CHECK-LABEL: @test4(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[BB_COND:%.*]], label [[BB2:%.*]]
; CHECK:       bb.cond:
; CHECK-NEXT:    [[C_1:%.*]] = icmp ule i8 [[X:%.*]], 10
; CHECK-NEXT:    br i1 [[C_1]], label [[BB1:%.*]], label [[BB2]]
; CHECK:       bb1:
; CHECK-NEXT:    [[C_2:%.*]] = icmp ule i8 [[X]], 10
; CHECK-NEXT:    ret i1 true
; CHECK:       bb2:
; CHECK-NEXT:    [[C_3:%.*]] = icmp ugt i8 [[X]], 10
; CHECK-NEXT:    ret i1 [[C_3]]
;
entry:
  br i1 %c, label %bb.cond, label %bb2

bb.cond:
  %c.1 = icmp ule i8 %x, 10
  br i1 %c.1, label %bb1, label %bb2

bb1:
  %c.2 = icmp ule i8 %x, 10
  ret i1 %c.2

bb2:
  %c.3 = icmp ugt i8 %x, 10
  ret i1 %c.3
}


define i1 @test_cond_from_preheader(i8 %x, i1 %c) {
; CHECK-LABEL: @test_cond_from_preheader(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[PRE:%.*]], label [[BB2:%.*]]
; CHECK:       pre:
; CHECK-NEXT:    [[C_1:%.*]] = icmp ule i8 [[X:%.*]], 10
; CHECK-NEXT:    br i1 [[C_1]], label [[LOOP:%.*]], label [[BB2]]
; CHECK:       loop:
; CHECK-NEXT:    [[T_1:%.*]] = icmp ule i8 [[X]], 10
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    [[F_1:%.*]] = icmp ugt i8 [[X]], 10
; CHECK-NEXT:    call void @use(i1 false)
; CHECK-NEXT:    [[C_2:%.*]] = icmp ule i8 [[X]], 9
; CHECK-NEXT:    call void @use(i1 [[C_2]])
; CHECK-NEXT:    [[C_3:%.*]] = icmp ugt i8 [[X]], 9
; CHECK-NEXT:    call void @use(i1 [[C_3]])
; CHECK-NEXT:    br i1 true, label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    [[C_4:%.*]] = icmp ule i8 [[X]], 10
; CHECK-NEXT:    ret i1 true
; CHECK:       bb2:
; CHECK-NEXT:    [[C_5:%.*]] = icmp ugt i8 [[X]], 10
; CHECK-NEXT:    ret i1 [[C_5]]
;
entry:
  br i1 %c, label %pre, label %bb2

pre:
  %c.1 = icmp ule i8 %x, 10
  br i1 %c.1, label %loop, label %bb2

loop:
  %t.1 = icmp ule i8 %x, 10
  call void @use(i1 %t.1)
  %f.1 = icmp ugt i8 %x, 10
  call void @use(i1 %f.1)

  %c.2 = icmp ule i8 %x, 9
  call void @use(i1 %c.2)
  %c.3 = icmp ugt i8 %x, 9
  call void @use(i1 %c.3)

  br i1 true, label %exit, label %loop

exit:
  %c.4 = icmp ule i8 %x, 10
  ret i1 %c.4

bb2:
  %c.5 = icmp ugt i8 %x, 10
  ret i1 %c.5
}

define i1 @test_cond_from_preheader_successors_flipped(i8 %x, i1 %c) {
; CHECK-LABEL: @test_cond_from_preheader_successors_flipped(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[PRE:%.*]], label [[BB2:%.*]]
; CHECK:       pre:
; CHECK-NEXT:    [[C_1:%.*]] = icmp ule i8 [[X:%.*]], 10
; CHECK-NEXT:    br i1 [[C_1]], label [[BB2]], label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[F_1:%.*]] = icmp ule i8 [[X]], 10
; CHECK-NEXT:    call void @use(i1 false)
; CHECK-NEXT:    [[T_1:%.*]] = icmp ugt i8 [[X]], 10
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    [[C_2:%.*]] = icmp ule i8 [[X]], 11
; CHECK-NEXT:    call void @use(i1 [[C_2]])
; CHECK-NEXT:    [[C_3:%.*]] = icmp ugt i8 [[X]], 11
; CHECK-NEXT:    call void @use(i1 [[C_3]])
; CHECK-NEXT:    br i1 true, label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    [[F_2:%.*]] = icmp ule i8 [[X]], 10
; CHECK-NEXT:    ret i1 false
; CHECK:       bb2:
; CHECK-NEXT:    [[C_5:%.*]] = icmp ugt i8 [[X]], 10
; CHECK-NEXT:    ret i1 [[C_5]]
;
entry:
  br i1 %c, label %pre, label %bb2

pre:
  %c.1 = icmp ule i8 %x, 10
  br i1 %c.1, label %bb2, label %loop

loop:
  %f.1 = icmp ule i8 %x, 10
  call void @use(i1 %f.1)
  %t.1 = icmp ugt i8 %x, 10
  call void @use(i1 %t.1)

  %c.2 = icmp ule i8 %x, 11
  call void @use(i1 %c.2)
  %c.3 = icmp ugt i8 %x, 11
  call void @use(i1 %c.3)

  br i1 true, label %exit, label %loop

exit:
  %f.2 = icmp ule i8 %x, 10
  ret i1 %f.2

bb2:
  %c.5 = icmp ugt i8 %x, 10
  ret i1 %c.5
}

define i1 @test_cond_from_preheader_and(i8 %x, i8 %y, i1 %c) {
; CHECK-LABEL: @test_cond_from_preheader_and(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[PRE:%.*]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    [[C_5:%.*]] = icmp ugt i8 [[Y:%.*]], 10
; CHECK-NEXT:    ret i1 [[C_5]]
; CHECK:       pre:
; CHECK-NEXT:    [[X_1:%.*]] = icmp ule i8 [[X:%.*]], 10
; CHECK-NEXT:    [[Y_1:%.*]] = icmp ugt i8 [[Y]], 99
; CHECK-NEXT:    [[AND:%.*]] = and i1 [[X_1]], [[Y_1]]
; CHECK-NEXT:    br i1 [[AND]], label [[LOOP:%.*]], label [[EXIT_1:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[T_1:%.*]] = icmp ule i8 [[X]], 10
; CHECK-NEXT:    [[F_1:%.*]] = icmp ugt i8 [[X]], 10
; CHECK-NEXT:    [[R_1:%.*]] = xor i1 true, false
; CHECK-NEXT:    [[C_1:%.*]] = icmp ule i8 [[X]], 9
; CHECK-NEXT:    [[R_2:%.*]] = xor i1 [[R_1]], [[C_1]]
; CHECK-NEXT:    [[C_2:%.*]] = icmp ugt i8 [[X]], 9
; CHECK-NEXT:    [[R_3:%.*]] = xor i1 [[R_2]], [[C_2]]
; CHECK-NEXT:    [[T_2:%.*]] = icmp ugt i8 [[Y]], 99
; CHECK-NEXT:    [[R_4:%.*]] = xor i1 [[R_3]], true
; CHECK-NEXT:    [[F_2:%.*]] = icmp ule i8 [[Y]], 99
; CHECK-NEXT:    [[R_5:%.*]] = xor i1 [[R_4]], false
; CHECK-NEXT:    [[C_3:%.*]] = icmp ugt i8 [[Y]], 100
; CHECK-NEXT:    [[R_6:%.*]] = xor i1 [[R_5]], [[C_3]]
; CHECK-NEXT:    [[C_4:%.*]] = icmp ugt i8 [[Y]], 100
; CHECK-NEXT:    [[R_7:%.*]] = xor i1 [[R_6]], [[C_4]]
; CHECK-NEXT:    call void @use(i1 [[R_7]])
; CHECK-NEXT:    br i1 true, label [[EXIT]], label [[LOOP]]
; CHECK:       exit.1:
; CHECK-NEXT:    [[C_6:%.*]] = icmp ugt i8 [[Y]], 10
; CHECK-NEXT:    ret i1 [[C_6]]
;
entry:
  br i1 %c, label %pre, label %exit

exit:
  %c.5 = icmp ugt i8 %y, 10
  ret i1 %c.5

pre:
  %x.1 = icmp ule i8 %x, 10
  %y.1 = icmp ugt i8 %y, 99
  %and = and i1 %x.1, %y.1
  br i1 %and, label %loop, label %exit.1

loop:
  %t.1 = icmp ule i8 %x, 10
  %f.1 = icmp ugt i8 %x, 10
  %r.1 = xor i1 %t.1, %f.1

  %c.1 = icmp ule i8 %x, 9
  %r.2 = xor i1 %r.1, %c.1

  %c.2 = icmp ugt i8 %x, 9
  %r.3 = xor i1 %r.2, %c.2

  %t.2 = icmp ugt i8 %y, 99
  %r.4 = xor i1 %r.3, %t.2

  %f.2 = icmp ule i8 %y, 99
  %r.5 = xor i1 %r.4, %f.2

  %c.3 = icmp ugt i8 %y, 100
  %r.6 = xor i1 %r.5, %c.3

  %c.4 = icmp ugt i8 %y, 100
  %r.7 = xor i1 %r.6, %c.4
  call void @use(i1 %r.7)

  br i1 true, label %exit, label %loop

exit.1:
  %c.6 = icmp ugt i8 %y, 10
  ret i1 %c.6
}


define i1 @test_cond_from_preheader_and_successors_flipped(i8 %x, i8 %y, i1 %c) {
; CHECK-LABEL: @test_cond_from_preheader_and_successors_flipped(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[PRE:%.*]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    [[C_9:%.*]] = icmp ugt i8 [[Y:%.*]], 10
; CHECK-NEXT:    ret i1 [[C_9]]
; CHECK:       pre:
; CHECK-NEXT:    [[X_1:%.*]] = icmp ule i8 [[X:%.*]], 10
; CHECK-NEXT:    [[Y_1:%.*]] = icmp ugt i8 [[Y]], 99
; CHECK-NEXT:    [[AND:%.*]] = and i1 [[X_1]], [[Y_1]]
; CHECK-NEXT:    br i1 [[AND]], label [[EXIT_1:%.*]], label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[C_1:%.*]] = icmp ule i8 [[X]], 10
; CHECK-NEXT:    [[C_2:%.*]] = icmp ugt i8 [[X]], 10
; CHECK-NEXT:    [[R_1:%.*]] = xor i1 [[C_1]], [[C_2]]
; CHECK-NEXT:    [[C_3:%.*]] = icmp ule i8 [[X]], 9
; CHECK-NEXT:    [[R_2:%.*]] = xor i1 [[R_1]], [[C_3]]
; CHECK-NEXT:    [[C_4:%.*]] = icmp ugt i8 [[X]], 9
; CHECK-NEXT:    [[R_3:%.*]] = xor i1 [[R_2]], [[C_4]]
; CHECK-NEXT:    [[C_5:%.*]] = icmp ugt i8 [[Y]], 99
; CHECK-NEXT:    [[R_4:%.*]] = xor i1 [[R_3]], [[C_5]]
; CHECK-NEXT:    [[C_6:%.*]] = icmp ule i8 [[Y]], 99
; CHECK-NEXT:    [[R_5:%.*]] = xor i1 [[R_4]], [[C_6]]
; CHECK-NEXT:    [[C_7:%.*]] = icmp ugt i8 [[Y]], 100
; CHECK-NEXT:    [[R_6:%.*]] = xor i1 [[R_5]], [[C_7]]
; CHECK-NEXT:    [[C_8:%.*]] = icmp ugt i8 [[Y]], 100
; CHECK-NEXT:    [[R_7:%.*]] = xor i1 [[R_6]], [[C_8]]
; CHECK-NEXT:    call void @use(i1 [[R_7]])
; CHECK-NEXT:    br i1 true, label [[EXIT]], label [[LOOP]]
; CHECK:       exit.1:
; CHECK-NEXT:    [[T_1:%.*]] = icmp ugt i8 [[Y]], 10
; CHECK-NEXT:    ret i1 true
;
entry:
  br i1 %c, label %pre, label %exit

exit:
  %c.9 = icmp ugt i8 %y, 10
  ret i1 %c.9

pre:
  %x.1 = icmp ule i8 %x, 10
  %y.1 = icmp ugt i8 %y, 99
  %and = and i1 %x.1, %y.1
  br i1 %and, label %exit.1, label %loop

loop:
  %c.1 = icmp ule i8 %x, 10
  %c.2 = icmp ugt i8 %x, 10
  %r.1 = xor i1 %c.1, %c.2
  %c.3 = icmp ule i8 %x, 9
  %r.2 = xor i1 %r.1, %c.3
  %c.4 = icmp ugt i8 %x, 9
  %r.3 = xor i1 %r.2, %c.4

  %c.5 = icmp ugt i8 %y, 99
  %r.4 = xor i1 %r.3, %c.5
  %c.6 = icmp ule i8 %y, 99
  %r.5 = xor i1 %r.4, %c.6

  %c.7 = icmp ugt i8 %y, 100
  %r.6 = xor i1 %r.5, %c.7
  %c.8 = icmp ugt i8 %y, 100
  %r.7 = xor i1 %r.6, %c.8
  call void @use(i1 %r.7)

  br i1 true, label %exit, label %loop

exit.1:
  %t.1 = icmp ugt i8 %y, 10
  ret i1 %t.1
}

define i1 @test_cond_from_preheader_or(i8 %x, i8 %y, i1 %c) {
; CHECK-LABEL: @test_cond_from_preheader_or(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[PRE:%.*]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    [[C_5:%.*]] = icmp ugt i8 [[Y:%.*]], 10
; CHECK-NEXT:    ret i1 [[C_5]]
; CHECK:       pre:
; CHECK-NEXT:    [[X_1:%.*]] = icmp ule i8 [[X:%.*]], 10
; CHECK-NEXT:    [[Y_1:%.*]] = icmp ugt i8 [[Y]], 99
; CHECK-NEXT:    [[OR:%.*]] = or i1 [[X_1]], [[Y_1]]
; CHECK-NEXT:    br i1 [[OR]], label [[EXIT_1:%.*]], label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[T_1:%.*]] = icmp ugt i8 [[X]], 10
; CHECK-NEXT:    [[F_1:%.*]] = icmp ule i8 [[X]], 10
; CHECK-NEXT:    [[R_1:%.*]] = xor i1 true, false
; CHECK-NEXT:    [[C_1:%.*]] = icmp ugt i8 [[X]], 11
; CHECK-NEXT:    [[R_2:%.*]] = xor i1 [[R_1]], [[C_1]]
; CHECK-NEXT:    [[C_2:%.*]] = icmp ule i8 [[X]], 11
; CHECK-NEXT:    [[R_3:%.*]] = xor i1 [[R_2]], [[C_2]]
; CHECK-NEXT:    [[T_2:%.*]] = icmp ule i8 [[Y]], 99
; CHECK-NEXT:    [[R_4:%.*]] = xor i1 [[R_3]], true
; CHECK-NEXT:    [[F_2:%.*]] = icmp ugt i8 [[Y]], 99
; CHECK-NEXT:    [[R_5:%.*]] = xor i1 [[R_4]], false
; CHECK-NEXT:    [[C_3:%.*]] = icmp ule i8 [[Y]], 98
; CHECK-NEXT:    [[R_6:%.*]] = xor i1 [[R_5]], [[C_3]]
; CHECK-NEXT:    [[C_4:%.*]] = icmp ule i8 [[Y]], 98
; CHECK-NEXT:    [[R_7:%.*]] = xor i1 [[R_6]], [[C_4]]
; CHECK-NEXT:    call void @use(i1 [[R_7]])
; CHECK-NEXT:    br i1 true, label [[EXIT]], label [[LOOP]]
; CHECK:       exit.1:
; CHECK-NEXT:    [[C_6:%.*]] = icmp ule i8 [[Y]], 100
; CHECK-NEXT:    ret i1 [[C_6]]
;
entry:
  br i1 %c, label %pre, label %exit

exit:
  %c.5 = icmp ugt i8 %y, 10
  ret i1 %c.5

pre:
  %x.1 = icmp ule i8 %x, 10
  %y.1 = icmp ugt i8 %y, 99
  %or = or i1 %x.1, %y.1
  br i1 %or, label %exit.1, label %loop

loop:
  %t.1 = icmp ugt i8 %x, 10
  %f.1 = icmp ule i8 %x, 10
  %r.1 = xor i1 %t.1, %f.1
  %c.1 = icmp ugt i8 %x, 11
  %r.2 = xor i1 %r.1, %c.1
  %c.2 = icmp ule i8 %x, 11
  %r.3 = xor i1 %r.2, %c.2

  %t.2 = icmp ule i8 %y, 99
  %r.4 = xor i1 %r.3, %t.2
  %f.2 = icmp ugt i8 %y, 99
  %r.5 = xor i1 %r.4, %f.2

  %c.3 = icmp ule i8 %y, 98
  %r.6 = xor i1 %r.5, %c.3
  %c.4 = icmp ule i8 %y, 98
  %r.7 = xor i1 %r.6, %c.4
  call void @use(i1 %r.7)

  br i1 true, label %exit, label %loop

exit.1:
  %c.6 = icmp ule i8 %y, 100
  ret i1 %c.6
}

define i1 @test_cond_from_preheader_or_successor_flipped(i8 %x, i8 %y, i1 %c) {
; CHECK-LABEL: @test_cond_from_preheader_or_successor_flipped(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[PRE:%.*]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    [[C_9:%.*]] = icmp ugt i8 [[Y:%.*]], 10
; CHECK-NEXT:    ret i1 [[C_9]]
; CHECK:       pre:
; CHECK-NEXT:    [[X_1:%.*]] = icmp ule i8 [[X:%.*]], 10
; CHECK-NEXT:    [[Y_1:%.*]] = icmp ugt i8 [[Y]], 99
; CHECK-NEXT:    [[OR:%.*]] = or i1 [[X_1]], [[Y_1]]
; CHECK-NEXT:    br i1 [[OR]], label [[LOOP:%.*]], label [[EXIT_1:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[C_1:%.*]] = icmp ule i8 [[X]], 10
; CHECK-NEXT:    [[C_2:%.*]] = icmp ugt i8 [[X]], 10
; CHECK-NEXT:    [[R_1:%.*]] = xor i1 [[C_1]], [[C_2]]
; CHECK-NEXT:    [[C_3:%.*]] = icmp ule i8 [[X]], 9
; CHECK-NEXT:    [[R_2:%.*]] = xor i1 [[R_1]], [[C_3]]
; CHECK-NEXT:    [[C_4:%.*]] = icmp ugt i8 [[X]], 9
; CHECK-NEXT:    [[R_3:%.*]] = xor i1 [[R_2]], [[C_4]]
; CHECK-NEXT:    [[C_5:%.*]] = icmp ugt i8 [[Y]], 99
; CHECK-NEXT:    [[R_4:%.*]] = xor i1 [[R_3]], [[C_5]]
; CHECK-NEXT:    [[C_6:%.*]] = icmp ule i8 [[Y]], 99
; CHECK-NEXT:    [[R_5:%.*]] = xor i1 [[R_4]], [[C_6]]
; CHECK-NEXT:    [[C_7:%.*]] = icmp ugt i8 [[Y]], 100
; CHECK-NEXT:    [[R_6:%.*]] = xor i1 [[R_5]], [[C_7]]
; CHECK-NEXT:    [[C_8:%.*]] = icmp ugt i8 [[Y]], 100
; CHECK-NEXT:    [[R_7:%.*]] = xor i1 [[R_6]], [[C_8]]
; CHECK-NEXT:    call void @use(i1 [[R_7]])
; CHECK-NEXT:    br i1 true, label [[EXIT]], label [[LOOP]]
; CHECK:       exit.1:
; CHECK-NEXT:    [[T_1:%.*]] = icmp ule i8 [[Y]], 100
; CHECK-NEXT:    ret i1 true
;
entry:
  br i1 %c, label %pre, label %exit

exit:
  %c.9 = icmp ugt i8 %y, 10
  ret i1 %c.9

pre:
  %x.1 = icmp ule i8 %x, 10
  %y.1 = icmp ugt i8 %y, 99
  %or = or i1 %x.1, %y.1
  br i1 %or, label %loop, label %exit.1

loop:
  %c.1 = icmp ule i8 %x, 10
  %c.2 = icmp ugt i8 %x, 10
  %r.1 = xor i1 %c.1, %c.2
  %c.3 = icmp ule i8 %x, 9
  %r.2 = xor i1 %r.1, %c.3
  %c.4 = icmp ugt i8 %x, 9
  %r.3 = xor i1 %r.2, %c.4

  %c.5 = icmp ugt i8 %y, 99
  %r.4 = xor i1 %r.3, %c.5
  %c.6 = icmp ule i8 %y, 99
  %r.5 = xor i1 %r.4, %c.6

  %c.7 = icmp ugt i8 %y, 100
  %r.6 = xor i1 %r.5, %c.7
  %c.8 = icmp ugt i8 %y, 100
  %r.7 = xor i1 %r.6, %c.8
  call void @use(i1 %r.7)

  br i1 true, label %exit, label %loop

exit.1:
  %t.1 = icmp ule i8 %y, 100
  ret i1 %t.1
}

; Test case from PR49819.
define i1 @both_branch_to_same_block(i4 %x) {
; CHECK-LABEL: @both_branch_to_same_block(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[C_1:%.*]] = icmp ne i4 [[X:%.*]], 0
; CHECK-NEXT:    br i1 [[C_1]], label [[EXIT:%.*]], label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[C_2:%.*]] = icmp ne i4 [[X]], 0
; CHECK-NEXT:    [[C_3:%.*]] = icmp eq i4 [[X]], 0
; CHECK-NEXT:    [[RES:%.*]] = xor i1 [[C_2]], [[C_3]]
; CHECK-NEXT:    ret i1 [[RES]]
;
entry:
  %c.1 = icmp ne i4 %x, 0
  br i1 %c.1, label %exit, label %exit

exit:
  %c.2 = icmp ne i4 %x, 0
  %c.3 = icmp eq i4 %x, 0
  %res = xor i1 %c.2, %c.3
  ret i1 %res
}

define i1 @both_branch_to_same_block_and(i4 %x, i4 %y) {
; CHECK-LABEL: @both_branch_to_same_block_and(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[C_1:%.*]] = icmp ne i4 [[X:%.*]], 0
; CHECK-NEXT:    [[C_2:%.*]] = icmp ne i4 [[Y:%.*]], -6
; CHECK-NEXT:    [[AND:%.*]] = and i1 [[C_1]], [[C_2]]
; CHECK-NEXT:    br i1 [[AND]], label [[EXIT:%.*]], label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[C_3:%.*]] = icmp ne i4 [[X]], 0
; CHECK-NEXT:    [[C_4:%.*]] = icmp eq i4 [[X]], 0
; CHECK-NEXT:    [[RES:%.*]] = xor i1 [[C_3]], [[C_4]]
; CHECK-NEXT:    ret i1 [[RES]]
;
entry:
  %c.1 = icmp ne i4 %x, 0
  %c.2 = icmp ne i4 %y, 10
  %and = and i1 %c.1, %c.2
  br i1 %and, label %exit, label %exit

exit:
  %c.3 = icmp ne i4 %x, 0
  %c.4 = icmp eq i4 %x, 0
  %res = xor i1 %c.3, %c.4
  ret i1 %res
}


define i1 @both_branch_to_same_block_or(i4 %x, i4 %y) {
; CHECK-LABEL: @both_branch_to_same_block_or(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[C_1:%.*]] = icmp ne i4 [[X:%.*]], 0
; CHECK-NEXT:    [[C_2:%.*]] = icmp ne i4 [[Y:%.*]], -6
; CHECK-NEXT:    [[OR:%.*]] = or i1 [[C_1]], [[C_2]]
; CHECK-NEXT:    br i1 [[OR]], label [[EXIT:%.*]], label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[C_3:%.*]] = icmp ne i4 [[X]], 0
; CHECK-NEXT:    [[C_4:%.*]] = icmp eq i4 [[X]], 0
; CHECK-NEXT:    [[RES:%.*]] = xor i1 [[C_3]], [[C_4]]
; CHECK-NEXT:    ret i1 [[RES]]
;
entry:
  %c.1 = icmp ne i4 %x, 0
  %c.2 = icmp ne i4 %y, 10
  %or = or i1 %c.1, %c.2
  br i1 %or, label %exit, label %exit

exit:
  %c.3 = icmp ne i4 %x, 0
  %c.4 = icmp eq i4 %x, 0
  %res = xor i1 %c.3, %c.4
  ret i1 %res
}
