; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; Verify that calls to known string library functions declared with
; incompatible signatures are handled gracefully and without aborting.
;
; RUN: opt < %s -passes=instcombine -opaque-pointers -S | FileCheck %s

@a = constant [2 x i8] c"1\00"

declare ptr @atoi(ptr)
declare ptr @atol(ptr)
declare ptr @atoll(ptr)

define void @call_bad_ato(ptr %ps) {
; CHECK-LABEL: @call_bad_ato(
; CHECK-NEXT:    [[IR:%.*]] = call ptr @atoi(ptr nonnull @a)
; CHECK-NEXT:    store ptr [[IR]], ptr [[PS:%.*]], align 8
; CHECK-NEXT:    [[LR:%.*]] = call ptr @atol(ptr nonnull @a)
; CHECK-NEXT:    [[PS1:%.*]] = getelementptr ptr, ptr [[PS]], i64 1
; CHECK-NEXT:    store ptr [[LR]], ptr [[PS1]], align 8
; CHECK-NEXT:    [[LLR:%.*]] = call ptr @atol(ptr nonnull @a)
; CHECK-NEXT:    [[PS2:%.*]] = getelementptr ptr, ptr [[PS]], i64 2
; CHECK-NEXT:    store ptr [[LLR]], ptr [[PS2]], align 8
; CHECK-NEXT:    ret void
;

  %ir = call ptr @atoi(ptr @a)
  store ptr %ir, ptr %ps

  %lr = call ptr @atol(ptr @a)
  %ps1 = getelementptr ptr, ptr %ps, i32 1
  store ptr %lr, ptr %ps1

  %llr = call ptr @atol(ptr @a)
  %ps2 = getelementptr ptr, ptr %ps, i32 2
  store ptr %llr, ptr %ps2

  ret void
}


declare ptr @strncasecmp(ptr, ptr)

define ptr @call_bad_strncasecmp() {
; CHECK-LABEL: @call_bad_strncasecmp(
; CHECK-NEXT:    [[CMP:%.*]] = call ptr @strncasecmp(ptr nonnull @a, ptr nonnull getelementptr inbounds ([2 x i8], ptr @a, i64 0, i64 1))
; CHECK-NEXT:    ret ptr [[CMP]]
;
  %p1 = getelementptr [2 x i8], ptr @a, i32 0, i32 1
  %cmp = call ptr @strncasecmp(ptr @a, ptr %p1)
  ret ptr %cmp
}


declare i1 @strcoll(ptr, ptr, ptr)

define i1 @call_bad_strcoll() {
; CHECK-LABEL: @call_bad_strcoll(
; CHECK-NEXT:    [[I:%.*]] = call i1 @strcoll(ptr nonnull @a, ptr nonnull getelementptr inbounds ([2 x i8], ptr @a, i64 0, i64 1), ptr nonnull @a)
; CHECK-NEXT:    ret i1 [[I]]
;
  %p1 = getelementptr [2 x i8], ptr @a, i32 0, i32 1
  %i = call i1 @strcoll(ptr @a, ptr %p1, ptr @a)
  ret i1 %i
}


declare ptr @strndup(ptr)

define ptr @call_bad_strndup() {
; CHECK-LABEL: @call_bad_strndup(
; CHECK-NEXT:    [[D:%.*]] = call ptr @strndup(ptr nonnull @a)
; CHECK-NEXT:    ret ptr [[D]]
;
  %d = call ptr @strndup(ptr @a)
  ret ptr %d
}


declare i1 @strtok(ptr, ptr, i1)

define i1 @call_bad_strtok() {
; CHECK-LABEL: @call_bad_strtok(
; CHECK-NEXT:    [[RET:%.*]] = call i1 @strtok(ptr nonnull @a, ptr nonnull getelementptr inbounds ([2 x i8], ptr @a, i64 0, i64 1), i1 false)
; CHECK-NEXT:    ret i1 [[RET]]
;
  %p1 = getelementptr [2 x i8], ptr @a, i32 0, i32 1
  %ret = call i1 @strtok(ptr @a, ptr %p1, i1 0)
  ret i1 %ret
}



declare i1 @strtok_r(ptr, ptr)

define i1 @call_bad_strtok_r() {
; CHECK-LABEL: @call_bad_strtok_r(
; CHECK-NEXT:    [[RET:%.*]] = call i1 @strtok_r(ptr nonnull @a, ptr nonnull getelementptr inbounds ([2 x i8], ptr @a, i64 0, i64 1))
; CHECK-NEXT:    ret i1 [[RET]]
;
  %p1 = getelementptr [2 x i8], ptr @a, i32 0, i32 1
  %ret = call i1 @strtok_r(ptr @a, ptr %p1)
  ret i1 %ret
}


declare i32 @strtol(ptr, ptr)
declare i32 @strtoul(ptr, ptr)

declare i64 @strtoll(ptr, ptr)
declare i64 @strtoull(ptr, ptr)

define void @call_bad_strto(ptr %psi32, ptr %psi64) {
; CHECK-LABEL: @call_bad_strto(
; CHECK-NEXT:    [[LR:%.*]] = call i32 @strtol(ptr nonnull @a, ptr null)
; CHECK-NEXT:    store i32 [[LR]], ptr [[PSI32:%.*]], align 4
; CHECK-NEXT:    [[ULR:%.*]] = call i32 @strtoul(ptr nonnull @a, ptr null)
; CHECK-NEXT:    [[PS1:%.*]] = getelementptr i32, ptr [[PSI32]], i64 1
; CHECK-NEXT:    store i32 [[ULR]], ptr [[PS1]], align 4
; CHECK-NEXT:    [[LLR:%.*]] = call i64 @strtoll(ptr nonnull @a, ptr null)
; CHECK-NEXT:    store i64 [[LLR]], ptr [[PSI64:%.*]], align 4
; CHECK-NEXT:    [[ULLR:%.*]] = call i64 @strtoull(ptr nonnull @a, ptr null)
; CHECK-NEXT:    [[PS3:%.*]] = getelementptr i64, ptr [[PSI64]], i64 3
; CHECK-NEXT:    store i64 [[ULLR]], ptr [[PS3]], align 4
; CHECK-NEXT:    ret void
;

  %lr = call i32 @strtol(ptr @a, ptr null)
  store i32 %lr, ptr %psi32

  %ulr = call i32 @strtoul(ptr @a, ptr null)
  %ps1 = getelementptr i32, ptr %psi32, i32 1
  store i32 %ulr, ptr %ps1

  %llr = call i64 @strtoll(ptr @a, ptr null)
  store i64 %llr, ptr %psi64

  %ullr = call i64 @strtoull(ptr @a, ptr null)
  %ps3 = getelementptr i64, ptr %psi64, i32 3
  store i64 %ullr, ptr %ps3

  ret void
}


declare ptr @strxfrm(ptr, ptr)

define ptr @call_bad_strxfrm() {
; CHECK-LABEL: @call_bad_strxfrm(
; CHECK-NEXT:    [[RET:%.*]] = call ptr @strxfrm(ptr nonnull @a, ptr nonnull getelementptr inbounds ([2 x i8], ptr @a, i64 0, i64 1))
; CHECK-NEXT:    ret ptr [[RET]]
;
  %p1 = getelementptr [2 x i8], ptr @a, i32 0, i32 1
  %ret = call ptr @strxfrm(ptr @a, ptr %p1)
  ret ptr %ret
}
