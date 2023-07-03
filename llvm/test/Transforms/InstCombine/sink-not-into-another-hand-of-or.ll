; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

; Transform
;   z = (~x) | y
; into:
;   z = ~(x & (~y))
; iff y is free to invert and all uses of z can be freely updated.

declare void @use1(i1)
declare void @use8(i8)

; Most basic positive test
define i8 @t0(i1 %i0, i8 %v0, i8 %v1, i8 %v2, i8 %v3) {
; CHECK-LABEL: @t0(
; CHECK-NEXT:    [[I1:%.*]] = icmp ne i8 [[V0:%.*]], [[V1:%.*]]
; CHECK-NEXT:    [[I3_NOT:%.*]] = and i1 [[I1]], [[I0:%.*]]
; CHECK-NEXT:    [[I4:%.*]] = select i1 [[I3_NOT]], i8 [[V3:%.*]], i8 [[V2:%.*]]
; CHECK-NEXT:    ret i8 [[I4]]
;
  %i1 = icmp eq i8 %v0, %v1
  %i2 = xor i1 %i0, -1
  %i3 = or i1 %i2, %i1
  %i4 = select i1 %i3, i8 %v2, i8 %v3
  ret i8 %i4
}
define i8 @t1(i8 %v0, i8 %v1, i8 %v2, i8 %v3, i8 %v4, i8 %v5) {
; CHECK-LABEL: @t1(
; CHECK-NEXT:    [[I0:%.*]] = icmp eq i8 [[V0:%.*]], [[V1:%.*]]
; CHECK-NEXT:    [[I1:%.*]] = icmp ne i8 [[V2:%.*]], [[V3:%.*]]
; CHECK-NEXT:    call void @use1(i1 [[I0]])
; CHECK-NEXT:    [[I3_NOT:%.*]] = and i1 [[I1]], [[I0]]
; CHECK-NEXT:    [[I4:%.*]] = select i1 [[I3_NOT]], i8 [[V5:%.*]], i8 [[V4:%.*]]
; CHECK-NEXT:    ret i8 [[I4]]
;
  %i0 = icmp eq i8 %v0, %v1
  %i1 = icmp eq i8 %v2, %v3
  call void @use1(i1 %i0)
  %i2 = xor i1 %i0, -1
  %i3 = or i1 %i2, %i1
  %i4 = select i1 %i3, i8 %v4, i8 %v5
  ret i8 %i4
}

; All users of %i3 must be invertible
define i1 @n2(i1 %i0, i8 %v0, i8 %v1, i8 %v2, i8 %v3) {
; CHECK-LABEL: @n2(
; CHECK-NEXT:    [[I1:%.*]] = icmp eq i8 [[V0:%.*]], [[V1:%.*]]
; CHECK-NEXT:    [[I2:%.*]] = xor i1 [[I0:%.*]], true
; CHECK-NEXT:    [[I3:%.*]] = or i1 [[I1]], [[I2]]
; CHECK-NEXT:    ret i1 [[I3]]
;
  %i1 = icmp eq i8 %v0, %v1
  %i2 = xor i1 %i0, -1
  %i3 = or i1 %i2, %i1
  ret i1 %i3 ; can not be inverted
}

; %i1 must be invertible
define i8 @n3(i1 %i0, i8 %v0, i8 %v1, i8 %v2, i8 %v3) {
; CHECK-LABEL: @n3(
; CHECK-NEXT:    [[I1:%.*]] = icmp eq i8 [[V0:%.*]], [[V1:%.*]]
; CHECK-NEXT:    call void @use1(i1 [[I1]])
; CHECK-NEXT:    [[I2:%.*]] = xor i1 [[I0:%.*]], true
; CHECK-NEXT:    [[I3:%.*]] = or i1 [[I1]], [[I2]]
; CHECK-NEXT:    [[I4:%.*]] = select i1 [[I3]], i8 [[V2:%.*]], i8 [[V3:%.*]]
; CHECK-NEXT:    ret i8 [[I4]]
;
  %i1 = icmp eq i8 %v0, %v1 ; has extra uninvertible use
  call void @use1(i1 %i1) ; bad extra use
  %i2 = xor i1 %i0, -1
  %i3 = or i1 %i2, %i1
  %i4 = select i1 %i3, i8 %v2, i8 %v3
  ret i8 %i4
}

; Extra uses are invertible
define i8 @t4(i1 %i0, i8 %v0, i8 %v1, i8 %v2, i8 %v3, i8 %v4, i8 %v5) {
; CHECK-LABEL: @t4(
; CHECK-NEXT:    [[I1:%.*]] = icmp ne i8 [[V0:%.*]], [[V1:%.*]]
; CHECK-NEXT:    [[I2:%.*]] = select i1 [[I1]], i8 [[V3:%.*]], i8 [[V2:%.*]]
; CHECK-NEXT:    call void @use8(i8 [[I2]])
; CHECK-NEXT:    [[I4_NOT:%.*]] = and i1 [[I1]], [[I0:%.*]]
; CHECK-NEXT:    [[I5:%.*]] = select i1 [[I4_NOT]], i8 [[V5:%.*]], i8 [[V4:%.*]]
; CHECK-NEXT:    ret i8 [[I5]]
;
  %i1 = icmp eq i8 %v0, %v1 ; has extra invertible use
  %i2 = select i1 %i1, i8 %v2, i8 %v3 ; invertible use
  call void @use8(i8 %i2)
  %i3 = xor i1 %i0, -1
  %i4 = or i1 %i3, %i1
  %i5 = select i1 %i4, i8 %v4, i8 %v5
  ret i8 %i5
}
define i8 @t4_commutative(i1 %i0, i8 %v0, i8 %v1, i8 %v2, i8 %v3, i8 %v4, i8 %v5) {
; CHECK-LABEL: @t4_commutative(
; CHECK-NEXT:    [[I1:%.*]] = icmp ne i8 [[V0:%.*]], [[V1:%.*]]
; CHECK-NEXT:    [[I2:%.*]] = select i1 [[I1]], i8 [[V3:%.*]], i8 [[V2:%.*]]
; CHECK-NEXT:    call void @use8(i8 [[I2]])
; CHECK-NEXT:    [[I4_NOT:%.*]] = and i1 [[I1]], [[I0:%.*]]
; CHECK-NEXT:    [[I5:%.*]] = select i1 [[I4_NOT]], i8 [[V5:%.*]], i8 [[V4:%.*]]
; CHECK-NEXT:    ret i8 [[I5]]
;
  %i1 = icmp eq i8 %v0, %v1 ; has extra invertible use
  %i2 = select i1 %i1, i8 %v2, i8 %v3 ; invertible use
  call void @use8(i8 %i2)
  %i3 = xor i1 %i0, -1
  %i4 = or i1 %i1, %i3
  %i5 = select i1 %i4, i8 %v4, i8 %v5
  ret i8 %i5
}
