; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-globals
; RUN: opt -S -mtriple=amdgcn-amd-amdhsa -amdgpu-attributor %s | FileCheck -allow-unused-prefixes %s

@x = global i32 0
;.
; CHECK: @[[X:[a-zA-Z0-9_$"\\.-]+]] = global i32 0
;.
define void @func1() {
; CHECK-LABEL: define {{[^@]+}}@func1
; CHECK-SAME: () #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:    store i32 0, ptr @x, align 4
; CHECK-NEXT:    ret void
;
  store i32 0, ptr @x
  ret void
}

define void @func4() {
; CHECK-LABEL: define {{[^@]+}}@func4
; CHECK-SAME: () #[[ATTR0]] {
; CHECK-NEXT:    store i32 0, ptr @x, align 4
; CHECK-NEXT:    ret void
;
  store i32 0, ptr @x
  ret void
}

define void @func2() #0 {
; CHECK-LABEL: define {{[^@]+}}@func2
; CHECK-SAME: () #[[ATTR0]] {
; CHECK-NEXT:    call void @func4()
; CHECK-NEXT:    call void @func1()
; CHECK-NEXT:    ret void
;
  call void @func4()
  call void @func1()
  ret void
}

define void @func3() {
; CHECK-LABEL: define {{[^@]+}}@func3
; CHECK-SAME: () #[[ATTR0]] {
; CHECK-NEXT:    call void @func1()
; CHECK-NEXT:    ret void
;
  call void @func1()
  ret void
}

define amdgpu_kernel void @kernel3() #0 {
; CHECK-LABEL: define {{[^@]+}}@kernel3
; CHECK-SAME: () #[[ATTR0]] {
; CHECK-NEXT:    call void @func2()
; CHECK-NEXT:    call void @func3()
; CHECK-NEXT:    ret void
;
  call void @func2()
  call void @func3()
  ret void
}

attributes #0 = { "uniform-work-group-size"="false" }
;.
; CHECK: attributes #[[ATTR0]] = { "amdgpu-no-completion-action" "amdgpu-no-default-queue" "amdgpu-no-dispatch-id" "amdgpu-no-dispatch-ptr" "amdgpu-no-heap-ptr" "amdgpu-no-hostcall-ptr" "amdgpu-no-implicitarg-ptr" "amdgpu-no-lds-kernel-id" "amdgpu-no-multigrid-sync-arg" "amdgpu-no-queue-ptr" "amdgpu-no-workgroup-id-x" "amdgpu-no-workgroup-id-y" "amdgpu-no-workgroup-id-z" "amdgpu-no-workitem-id-x" "amdgpu-no-workitem-id-y" "amdgpu-no-workitem-id-z" "uniform-work-group-size"="false" }
;.
