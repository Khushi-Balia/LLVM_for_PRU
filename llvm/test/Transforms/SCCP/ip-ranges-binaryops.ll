; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=ipsccp -S | FileCheck %s

; x = [10, 21), y = [100, 201)
; x + y = [110, 221)
define internal i1 @f.add(i32 %x, i32 %y) {
; CHECK-LABEL: @f.add(
; CHECK-NEXT:    [[A_1:%.*]] = add i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[C_2:%.*]] = icmp sgt i32 [[A_1]], 219
; CHECK-NEXT:    [[C_4:%.*]] = icmp slt i32 [[A_1]], 111
; CHECK-NEXT:    [[C_5:%.*]] = icmp eq i32 [[A_1]], 150
; CHECK-NEXT:    [[C_6:%.*]] = icmp slt i32 [[A_1]], 150
; CHECK-NEXT:    [[RES_1:%.*]] = add i1 false, [[C_2]]
; CHECK-NEXT:    [[RES_2:%.*]] = add i1 [[RES_1]], false
; CHECK-NEXT:    [[RES_3:%.*]] = add i1 [[RES_2]], [[C_4]]
; CHECK-NEXT:    [[RES_4:%.*]] = add i1 [[RES_3]], [[C_5]]
; CHECK-NEXT:    [[RES_5:%.*]] = add i1 [[RES_4]], [[C_6]]
; CHECK-NEXT:    ret i1 [[RES_5]]
;
  %a.1 = add i32 %x, %y
  %c.1 = icmp sgt i32 %a.1, 220
  %c.2 = icmp sgt i32 %a.1, 219
  %c.3 = icmp slt i32 %a.1, 110
  %c.4 = icmp slt i32 %a.1, 111
  %c.5 = icmp eq i32 %a.1, 150
  %c.6 = icmp slt i32 %a.1, 150
  %res.1 = add i1 %c.1, %c.2
  %res.2 = add i1 %res.1, %c.3
  %res.3 = add i1 %res.2, %c.4
  %res.4 = add i1 %res.3, %c.5
  %res.5 = add i1 %res.4, %c.6
  ret i1 %res.5
}

define i1 @caller.add() {
; CHECK-LABEL: @caller.add(
; CHECK-NEXT:    [[CALL_1:%.*]] = tail call i1 @f.add(i32 10, i32 100)
; CHECK-NEXT:    [[CALL_2:%.*]] = tail call i1 @f.add(i32 20, i32 200)
; CHECK-NEXT:    [[RES:%.*]] = and i1 [[CALL_1]], [[CALL_2]]
; CHECK-NEXT:    ret i1 [[RES]]
;
  %call.1 = tail call i1 @f.add(i32 10, i32 100)
  %call.2 = tail call i1 @f.add(i32 20, i32 200)
  %res = and i1 %call.1, %call.2
  ret i1 %res
}


; x = [10, 21), y = [100, 201)
; x - y = [-190, -79)
define internal i1 @f.sub(i32 %x, i32 %y) {
; CHECK-LABEL: @f.sub(
; CHECK-NEXT:    [[A_1:%.*]] = sub i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[C_2:%.*]] = icmp sgt i32 [[A_1]], -81
; CHECK-NEXT:    [[C_4:%.*]] = icmp slt i32 [[A_1]], -189
; CHECK-NEXT:    [[C_5:%.*]] = icmp eq i32 [[A_1]], -150
; CHECK-NEXT:    [[C_6:%.*]] = icmp slt i32 [[A_1]], -150
; CHECK-NEXT:    [[RES_1:%.*]] = add i1 false, [[C_2]]
; CHECK-NEXT:    [[RES_2:%.*]] = add i1 [[RES_1]], false
; CHECK-NEXT:    [[RES_3:%.*]] = add i1 [[RES_2]], [[C_4]]
; CHECK-NEXT:    [[RES_4:%.*]] = add i1 [[RES_3]], [[C_5]]
; CHECK-NEXT:    [[RES_5:%.*]] = add i1 [[RES_4]], [[C_6]]
; CHECK-NEXT:    ret i1 [[RES_5]]
;
  %a.1 = sub i32 %x, %y
  %c.1 = icmp sgt i32 %a.1, -80
  %c.2 = icmp sgt i32 %a.1, -81
  %c.3 = icmp slt i32 %a.1, -190
  %c.4 = icmp slt i32 %a.1, -189
  %c.5 = icmp eq i32 %a.1, -150
  %c.6 = icmp slt i32 %a.1, -150
  %res.1 = add i1 %c.1, %c.2
  %res.2 = add i1 %res.1, %c.3
  %res.3 = add i1 %res.2, %c.4
  %res.4 = add i1 %res.3, %c.5
  %res.5 = add i1 %res.4, %c.6
  ret i1 %res.5
}

define i1 @caller.sub() {
; CHECK-LABEL: @caller.sub(
; CHECK-NEXT:    [[CALL_1:%.*]] = tail call i1 @f.sub(i32 10, i32 100)
; CHECK-NEXT:    [[CALL_2:%.*]] = tail call i1 @f.sub(i32 20, i32 200)
; CHECK-NEXT:    [[RES:%.*]] = and i1 [[CALL_1]], [[CALL_2]]
; CHECK-NEXT:    ret i1 [[RES]]
;
  %call.1 = tail call i1 @f.sub(i32 10, i32 100)
  %call.2 = tail call i1 @f.sub(i32 20, i32 200)
  %res = and i1 %call.1, %call.2
  ret i1 %res
}

; x = [10, 21), y = [100, 201)
; x * y = [1000, 4001)
define internal i1 @f.mul(i32 %x, i32 %y) {
; CHECK-LABEL: @f.mul(
; CHECK-NEXT:    [[A_1:%.*]] = mul i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[C_2:%.*]] = icmp sgt i32 [[A_1]], 3999
; CHECK-NEXT:    [[C_4:%.*]] = icmp slt i32 [[A_1]], 1001
; CHECK-NEXT:    [[C_5:%.*]] = icmp eq i32 [[A_1]], 1500
; CHECK-NEXT:    [[C_6:%.*]] = icmp slt i32 [[A_1]], 1500
; CHECK-NEXT:    [[RES_1:%.*]] = add i1 false, [[C_2]]
; CHECK-NEXT:    [[RES_2:%.*]] = add i1 [[RES_1]], false
; CHECK-NEXT:    [[RES_3:%.*]] = add i1 [[RES_2]], [[C_4]]
; CHECK-NEXT:    [[RES_4:%.*]] = add i1 [[RES_3]], [[C_5]]
; CHECK-NEXT:    [[RES_5:%.*]] = add i1 [[RES_4]], [[C_6]]
; CHECK-NEXT:    ret i1 [[RES_5]]
;
  %a.1 = mul i32 %x, %y
  %c.1 = icmp sgt i32 %a.1, 4000
  %c.2 = icmp sgt i32 %a.1, 3999
  %c.3 = icmp slt i32 %a.1, 1000
  %c.4 = icmp slt i32 %a.1, 1001
  %c.5 = icmp eq i32 %a.1, 1500
  %c.6 = icmp slt i32 %a.1, 1500
  %res.1 = add i1 %c.1, %c.2
  %res.2 = add i1 %res.1, %c.3
  %res.3 = add i1 %res.2, %c.4
  %res.4 = add i1 %res.3, %c.5
  %res.5 = add i1 %res.4, %c.6
  ret i1 %res.5
}

define i1 @caller.mul() {
; CHECK-LABEL: @caller.mul(
; CHECK-NEXT:    [[CALL_1:%.*]] = tail call i1 @f.mul(i32 10, i32 100)
; CHECK-NEXT:    [[CALL_2:%.*]] = tail call i1 @f.mul(i32 20, i32 200)
; CHECK-NEXT:    [[RES:%.*]] = and i1 [[CALL_1]], [[CALL_2]]
; CHECK-NEXT:    ret i1 [[RES]]
;
  %call.1 = tail call i1 @f.mul(i32 10, i32 100)
  %call.2 = tail call i1 @f.mul(i32 20, i32 200)
  %res = and i1 %call.1, %call.2
  ret i1 %res
}
