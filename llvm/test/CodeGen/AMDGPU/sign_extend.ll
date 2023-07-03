; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn-- -amdgpu-scalarize-global-loads=false -mcpu=tahiti -verify-machineinstrs < %s | FileCheck %s -allow-deprecated-dag-overlap -enable-var-scope --check-prefix=SI
; RUN: llc -mtriple=amdgcn-- -amdgpu-scalarize-global-loads=false -mcpu=tonga -mattr=-flat-for-global -verify-machineinstrs < %s | FileCheck %s -allow-deprecated-dag-overlap -enable-var-scope --check-prefix=VI

define amdgpu_kernel void @s_sext_i1_to_i32(ptr addrspace(1) %out, i32 %a, i32 %b) nounwind {
; SI-LABEL: s_sext_i1_to_i32:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s7, 0xf000
; SI-NEXT:    s_mov_b32 s6, -1
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_cmp_eq_u32 s2, s3
; SI-NEXT:    s_mov_b32 s4, s0
; SI-NEXT:    s_mov_b32 s5, s1
; SI-NEXT:    s_cselect_b64 s[0:1], -1, 0
; SI-NEXT:    v_cndmask_b32_e64 v0, 0, -1, s[0:1]
; SI-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: s_sext_i1_to_i32:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; VI-NEXT:    s_mov_b32 s7, 0xf000
; VI-NEXT:    s_mov_b32 s6, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_cmp_eq_u32 s2, s3
; VI-NEXT:    s_mov_b32 s4, s0
; VI-NEXT:    s_mov_b32 s5, s1
; VI-NEXT:    s_cselect_b64 s[0:1], -1, 0
; VI-NEXT:    v_cndmask_b32_e64 v0, 0, -1, s[0:1]
; VI-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; VI-NEXT:    s_endpgm
  %cmp = icmp eq i32 %a, %b
  %sext = sext i1 %cmp to i32
  store i32 %sext, ptr addrspace(1) %out, align 4
  ret void
}

define amdgpu_kernel void @test_s_sext_i32_to_i64(ptr addrspace(1) %out, i32 %a, i32 %b, i32 %c) nounwind {
; SI-LABEL: test_s_sext_i32_to_i64:
; SI:       ; %bb.0: ; %entry
; SI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x9
; SI-NEXT:    s_load_dword s8, s[0:1], 0xd
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b32 s0, s4
; SI-NEXT:    s_mul_i32 s4, s6, s7
; SI-NEXT:    s_add_i32 s4, s4, s8
; SI-NEXT:    s_mov_b32 s1, s5
; SI-NEXT:    s_ashr_i32 s5, s4, 31
; SI-NEXT:    v_mov_b32_e32 v0, s4
; SI-NEXT:    v_mov_b32_e32 v1, s5
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: test_s_sext_i32_to_i64:
; VI:       ; %bb.0: ; %entry
; VI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; VI-NEXT:    s_load_dword s8, s[0:1], 0x34
; VI-NEXT:    s_mov_b32 s3, 0xf000
; VI-NEXT:    s_mov_b32 s2, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_mov_b32 s0, s4
; VI-NEXT:    s_mul_i32 s4, s6, s7
; VI-NEXT:    s_add_i32 s4, s4, s8
; VI-NEXT:    s_mov_b32 s1, s5
; VI-NEXT:    s_ashr_i32 s5, s4, 31
; VI-NEXT:    v_mov_b32_e32 v0, s4
; VI-NEXT:    v_mov_b32_e32 v1, s5
; VI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0
; VI-NEXT:    s_endpgm
entry:
  %mul = mul i32 %a, %b
  %add = add i32 %mul, %c
  %sext = sext i32 %add to i64
  store i64 %sext, ptr addrspace(1) %out, align 8
  ret void
}

define amdgpu_kernel void @s_sext_i1_to_i64(ptr addrspace(1) %out, i32 %a, i32 %b) nounwind {
; SI-LABEL: s_sext_i1_to_i64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s7, 0xf000
; SI-NEXT:    s_mov_b32 s6, -1
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_cmp_eq_u32 s2, s3
; SI-NEXT:    s_mov_b32 s4, s0
; SI-NEXT:    s_mov_b32 s5, s1
; SI-NEXT:    s_cselect_b64 s[0:1], -1, 0
; SI-NEXT:    v_cndmask_b32_e64 v0, 0, -1, s[0:1]
; SI-NEXT:    v_mov_b32_e32 v1, v0
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[4:7], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: s_sext_i1_to_i64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; VI-NEXT:    s_mov_b32 s7, 0xf000
; VI-NEXT:    s_mov_b32 s6, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_cmp_eq_u32 s2, s3
; VI-NEXT:    s_mov_b32 s4, s0
; VI-NEXT:    s_mov_b32 s5, s1
; VI-NEXT:    s_cselect_b64 s[0:1], -1, 0
; VI-NEXT:    v_cndmask_b32_e64 v0, 0, -1, s[0:1]
; VI-NEXT:    v_mov_b32_e32 v1, v0
; VI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[4:7], 0
; VI-NEXT:    s_endpgm
  %cmp = icmp eq i32 %a, %b
  %sext = sext i1 %cmp to i64
  store i64 %sext, ptr addrspace(1) %out, align 8
  ret void
}

define amdgpu_kernel void @s_sext_i32_to_i64(ptr addrspace(1) %out, i32 %a) nounwind {
; SI-LABEL: s_sext_i32_to_i64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dword s4, s[0:1], 0xb
; SI-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_ashr_i32 s5, s4, 31
; SI-NEXT:    v_mov_b32_e32 v0, s4
; SI-NEXT:    v_mov_b32_e32 v1, s5
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: s_sext_i32_to_i64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dword s4, s[0:1], 0x2c
; VI-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x24
; VI-NEXT:    s_mov_b32 s3, 0xf000
; VI-NEXT:    s_mov_b32 s2, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_ashr_i32 s5, s4, 31
; VI-NEXT:    v_mov_b32_e32 v0, s4
; VI-NEXT:    v_mov_b32_e32 v1, s5
; VI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0
; VI-NEXT:    s_endpgm
  %sext = sext i32 %a to i64
  store i64 %sext, ptr addrspace(1) %out, align 8
  ret void
}

define amdgpu_kernel void @v_sext_i32_to_i64(ptr addrspace(1) %out, ptr addrspace(1) %in) nounwind {
; SI-LABEL: v_sext_i32_to_i64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s7, 0xf000
; SI-NEXT:    s_mov_b32 s6, -1
; SI-NEXT:    s_mov_b32 s10, s6
; SI-NEXT:    s_mov_b32 s11, s7
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b32 s8, s2
; SI-NEXT:    s_mov_b32 s9, s3
; SI-NEXT:    buffer_load_dword v0, off, s[8:11], 0
; SI-NEXT:    s_mov_b32 s4, s0
; SI-NEXT:    s_mov_b32 s5, s1
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_ashrrev_i32_e32 v1, 31, v0
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[4:7], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: v_sext_i32_to_i64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; VI-NEXT:    s_mov_b32 s7, 0xf000
; VI-NEXT:    s_mov_b32 s6, -1
; VI-NEXT:    s_mov_b32 s10, s6
; VI-NEXT:    s_mov_b32 s11, s7
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_mov_b32 s8, s2
; VI-NEXT:    s_mov_b32 s9, s3
; VI-NEXT:    buffer_load_dword v0, off, s[8:11], 0
; VI-NEXT:    s_mov_b32 s4, s0
; VI-NEXT:    s_mov_b32 s5, s1
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_ashrrev_i32_e32 v1, 31, v0
; VI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[4:7], 0
; VI-NEXT:    s_endpgm
  %val = load i32, ptr addrspace(1) %in, align 4
  %sext = sext i32 %val to i64
  store i64 %sext, ptr addrspace(1) %out, align 8
  ret void
}

define amdgpu_kernel void @s_sext_i16_to_i64(ptr addrspace(1) %out, i16 %a) nounwind {
; SI-LABEL: s_sext_i16_to_i64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dword s4, s[0:1], 0xb
; SI-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_bfe_i64 s[4:5], s[4:5], 0x100000
; SI-NEXT:    v_mov_b32_e32 v0, s4
; SI-NEXT:    v_mov_b32_e32 v1, s5
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: s_sext_i16_to_i64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dword s4, s[0:1], 0x2c
; VI-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x24
; VI-NEXT:    s_mov_b32 s3, 0xf000
; VI-NEXT:    s_mov_b32 s2, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_bfe_i64 s[4:5], s[4:5], 0x100000
; VI-NEXT:    v_mov_b32_e32 v0, s4
; VI-NEXT:    v_mov_b32_e32 v1, s5
; VI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0
; VI-NEXT:    s_endpgm
  %sext = sext i16 %a to i64
  store i64 %sext, ptr addrspace(1) %out, align 8
  ret void
}

define amdgpu_kernel void @s_sext_i1_to_i16(ptr addrspace(1) %out, i32 %a, i32 %b) nounwind {
; SI-LABEL: s_sext_i1_to_i16:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s7, 0xf000
; SI-NEXT:    s_mov_b32 s6, -1
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_cmp_eq_u32 s2, s3
; SI-NEXT:    s_mov_b32 s4, s0
; SI-NEXT:    s_mov_b32 s5, s1
; SI-NEXT:    s_cselect_b64 s[0:1], -1, 0
; SI-NEXT:    v_cndmask_b32_e64 v0, 0, -1, s[0:1]
; SI-NEXT:    buffer_store_short v0, off, s[4:7], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: s_sext_i1_to_i16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; VI-NEXT:    s_mov_b32 s7, 0xf000
; VI-NEXT:    s_mov_b32 s6, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_cmp_eq_u32 s2, s3
; VI-NEXT:    s_mov_b32 s4, s0
; VI-NEXT:    s_mov_b32 s5, s1
; VI-NEXT:    s_cselect_b64 s[0:1], -1, 0
; VI-NEXT:    v_cndmask_b32_e64 v0, 0, -1, s[0:1]
; VI-NEXT:    buffer_store_short v0, off, s[4:7], 0
; VI-NEXT:    s_endpgm
  %cmp = icmp eq i32 %a, %b
  %sext = sext i1 %cmp to i16
  store i16 %sext, ptr addrspace(1) %out
  ret void
}

; This purpose of this test is to make sure the i16 = sign_extend i1 node
; makes it all the way throught the legalizer/optimizer to make sure
; we select this correctly.  In the s_sext_i1_to_i16, the sign_extend node
; is optimized to a select very early.
define amdgpu_kernel void @s_sext_i1_to_i16_with_and(ptr addrspace(1) %out, i32 %a, i32 %b, i32 %c, i32 %d) nounwind {
; SI-LABEL: s_sext_i1_to_i16_with_and:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0xb
; SI-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_cmp_eq_u32 s4, s5
; SI-NEXT:    s_cselect_b64 s[4:5], -1, 0
; SI-NEXT:    s_cmp_eq_u32 s6, s7
; SI-NEXT:    s_cselect_b64 s[6:7], -1, 0
; SI-NEXT:    s_and_b64 s[4:5], s[4:5], s[6:7]
; SI-NEXT:    v_cndmask_b32_e64 v0, 0, -1, s[4:5]
; SI-NEXT:    buffer_store_short v0, off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: s_sext_i1_to_i16_with_and:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x2c
; VI-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x24
; VI-NEXT:    s_mov_b32 s3, 0xf000
; VI-NEXT:    s_mov_b32 s2, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_cmp_eq_u32 s4, s5
; VI-NEXT:    s_cselect_b64 s[4:5], -1, 0
; VI-NEXT:    s_cmp_eq_u32 s6, s7
; VI-NEXT:    s_cselect_b64 s[6:7], -1, 0
; VI-NEXT:    s_and_b64 s[4:5], s[4:5], s[6:7]
; VI-NEXT:    v_cndmask_b32_e64 v0, 0, -1, s[4:5]
; VI-NEXT:    buffer_store_short v0, off, s[0:3], 0
; VI-NEXT:    s_endpgm
  %cmp0 = icmp eq i32 %a, %b
  %cmp1 = icmp eq i32 %c, %d
  %cmp = and i1 %cmp0, %cmp1
  %sext = sext i1 %cmp to i16
  store i16 %sext, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @v_sext_i1_to_i16_with_and(ptr addrspace(1) %out, i32 %a, i32 %b, i32 %c) nounwind {
; SI-LABEL: v_sext_i1_to_i16_with_and:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x9
; SI-NEXT:    s_load_dword s8, s[0:1], 0xd
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b32 s0, s4
; SI-NEXT:    s_cmp_eq_u32 s7, s8
; SI-NEXT:    s_mov_b32 s1, s5
; SI-NEXT:    v_cmp_eq_u32_e32 vcc, s6, v0
; SI-NEXT:    s_cselect_b64 s[4:5], -1, 0
; SI-NEXT:    s_and_b64 s[4:5], vcc, s[4:5]
; SI-NEXT:    v_cndmask_b32_e64 v0, 0, -1, s[4:5]
; SI-NEXT:    buffer_store_short v0, off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: v_sext_i1_to_i16_with_and:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; VI-NEXT:    s_load_dword s8, s[0:1], 0x34
; VI-NEXT:    s_mov_b32 s3, 0xf000
; VI-NEXT:    s_mov_b32 s2, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_mov_b32 s0, s4
; VI-NEXT:    s_cmp_eq_u32 s7, s8
; VI-NEXT:    s_mov_b32 s1, s5
; VI-NEXT:    v_cmp_eq_u32_e32 vcc, s6, v0
; VI-NEXT:    s_cselect_b64 s[4:5], -1, 0
; VI-NEXT:    s_and_b64 s[4:5], vcc, s[4:5]
; VI-NEXT:    v_cndmask_b32_e64 v0, 0, -1, s[4:5]
; VI-NEXT:    buffer_store_short v0, off, s[0:3], 0
; VI-NEXT:    s_endpgm
  %tid = tail call i32 @llvm.amdgcn.workitem.id.x() #1
  %cmp0 = icmp eq i32 %a, %tid
  %cmp1 = icmp eq i32 %b, %c
  %cmp = and i1 %cmp0, %cmp1
  %sext = sext i1 %cmp to i16
  store i16 %sext, ptr addrspace(1) %out
  ret void
}

; FIXME: We end up with a v_bfe instruction, because the i16 srl
; gets selected to a v_lshrrev_b16 instructions, so the input to
; the bfe is a vector registers.  To fix this we need to be able to
; optimize:
; t29: i16 = truncate t10
; t55: i16 = srl t29, Constant:i32<8>
; t63: i32 = any_extend t55
; t64: i32 = sign_extend_inreg t63, ValueType:ch:i8
define amdgpu_kernel void @s_sext_v4i8_to_v4i32(ptr addrspace(1) %out, i32 %a) nounwind {
; SI-LABEL: s_sext_v4i8_to_v4i32:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dword s4, s[0:1], 0xb
; SI-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_ashr_i32 s5, s4, 24
; SI-NEXT:    s_bfe_i32 s6, s4, 0x80010
; SI-NEXT:    s_bfe_i32 s7, s4, 0x80008
; SI-NEXT:    s_sext_i32_i8 s4, s4
; SI-NEXT:    v_mov_b32_e32 v0, s4
; SI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; SI-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; SI-NEXT:    v_mov_b32_e32 v0, s7
; SI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; SI-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; SI-NEXT:    v_mov_b32_e32 v0, s6
; SI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; SI-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; SI-NEXT:    v_mov_b32_e32 v0, s5
; SI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    s_endpgm
;
; VI-LABEL: s_sext_v4i8_to_v4i32:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dword s4, s[0:1], 0x2c
; VI-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x24
; VI-NEXT:    s_mov_b32 s3, 0xf000
; VI-NEXT:    s_mov_b32 s2, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_lshrrev_b16_e64 v0, 8, s4
; VI-NEXT:    s_ashr_i32 s5, s4, 24
; VI-NEXT:    s_bfe_i32 s6, s4, 0x80010
; VI-NEXT:    s_sext_i32_i8 s4, s4
; VI-NEXT:    v_bfe_i32 v0, v0, 0, 8
; VI-NEXT:    v_mov_b32_e32 v1, s4
; VI-NEXT:    buffer_store_dword v1, off, s[0:3], 0
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v0, s6
; VI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v0, s5
; VI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    s_endpgm
  %cast = bitcast i32 %a to <4 x i8>
  %ext = sext <4 x i8> %cast to <4 x i32>
  %elt0 = extractelement <4 x i32> %ext, i32 0
  %elt1 = extractelement <4 x i32> %ext, i32 1
  %elt2 = extractelement <4 x i32> %ext, i32 2
  %elt3 = extractelement <4 x i32> %ext, i32 3
  store volatile i32 %elt0, ptr addrspace(1) %out
  store volatile i32 %elt1, ptr addrspace(1) %out
  store volatile i32 %elt2, ptr addrspace(1) %out
  store volatile i32 %elt3, ptr addrspace(1) %out
  ret void
}

; FIXME: need to optimize same sequence as above test to avoid
; this shift.
define amdgpu_kernel void @v_sext_v4i8_to_v4i32(ptr addrspace(1) %out, ptr addrspace(1) %in) nounwind {
; SI-LABEL: v_sext_v4i8_to_v4i32:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s7, 0xf000
; SI-NEXT:    s_mov_b32 s6, -1
; SI-NEXT:    s_mov_b32 s10, s6
; SI-NEXT:    s_mov_b32 s11, s7
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b32 s8, s2
; SI-NEXT:    s_mov_b32 s9, s3
; SI-NEXT:    buffer_load_dword v0, off, s[8:11], 0
; SI-NEXT:    s_mov_b32 s4, s0
; SI-NEXT:    s_mov_b32 s5, s1
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_ashrrev_i32_e32 v1, 24, v0
; SI-NEXT:    v_bfe_i32 v2, v0, 16, 8
; SI-NEXT:    v_bfe_i32 v3, v0, 8, 8
; SI-NEXT:    v_bfe_i32 v0, v0, 0, 8
; SI-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    buffer_store_dword v3, off, s[4:7], 0
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    buffer_store_dword v2, off, s[4:7], 0
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    buffer_store_dword v1, off, s[4:7], 0
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    s_endpgm
;
; VI-LABEL: v_sext_v4i8_to_v4i32:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; VI-NEXT:    s_mov_b32 s7, 0xf000
; VI-NEXT:    s_mov_b32 s6, -1
; VI-NEXT:    s_mov_b32 s10, s6
; VI-NEXT:    s_mov_b32 s11, s7
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_mov_b32 s8, s2
; VI-NEXT:    s_mov_b32 s9, s3
; VI-NEXT:    buffer_load_dword v0, off, s[8:11], 0
; VI-NEXT:    s_mov_b32 s4, s0
; VI-NEXT:    s_mov_b32 s5, s1
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_lshrrev_b16_e32 v1, 8, v0
; VI-NEXT:    v_ashrrev_i32_e32 v2, 24, v0
; VI-NEXT:    v_bfe_i32 v3, v0, 16, 8
; VI-NEXT:    v_bfe_i32 v0, v0, 0, 8
; VI-NEXT:    v_bfe_i32 v1, v1, 0, 8
; VI-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    buffer_store_dword v1, off, s[4:7], 0
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    buffer_store_dword v3, off, s[4:7], 0
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    buffer_store_dword v2, off, s[4:7], 0
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    s_endpgm
  %a = load i32, ptr addrspace(1) %in
  %cast = bitcast i32 %a to <4 x i8>
  %ext = sext <4 x i8> %cast to <4 x i32>
  %elt0 = extractelement <4 x i32> %ext, i32 0
  %elt1 = extractelement <4 x i32> %ext, i32 1
  %elt2 = extractelement <4 x i32> %ext, i32 2
  %elt3 = extractelement <4 x i32> %ext, i32 3
  store volatile i32 %elt0, ptr addrspace(1) %out
  store volatile i32 %elt1, ptr addrspace(1) %out
  store volatile i32 %elt2, ptr addrspace(1) %out
  store volatile i32 %elt3, ptr addrspace(1) %out
  ret void
}

; FIXME: s_bfe_i64, same on SI and VI
define amdgpu_kernel void @s_sext_v4i16_to_v4i32(ptr addrspace(1) %out, i64 %a) nounwind {
; SI-LABEL: s_sext_v4i16_to_v4i32:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s7, 0xf000
; SI-NEXT:    s_mov_b32 s6, -1
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b32 s4, s0
; SI-NEXT:    s_mov_b32 s5, s1
; SI-NEXT:    s_ashr_i64 s[0:1], s[2:3], 48
; SI-NEXT:    s_ashr_i32 s1, s2, 16
; SI-NEXT:    s_sext_i32_i16 s2, s2
; SI-NEXT:    v_mov_b32_e32 v0, s2
; SI-NEXT:    s_sext_i32_i16 s3, s3
; SI-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; SI-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; SI-NEXT:    v_mov_b32_e32 v0, s1
; SI-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; SI-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; SI-NEXT:    v_mov_b32_e32 v0, s3
; SI-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; SI-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; SI-NEXT:    v_mov_b32_e32 v0, s0
; SI-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    s_endpgm
;
; VI-LABEL: s_sext_v4i16_to_v4i32:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; VI-NEXT:    s_mov_b32 s7, 0xf000
; VI-NEXT:    s_mov_b32 s6, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_mov_b32 s5, s1
; VI-NEXT:    s_ashr_i32 s1, s2, 16
; VI-NEXT:    s_sext_i32_i16 s2, s2
; VI-NEXT:    s_mov_b32 s4, s0
; VI-NEXT:    v_mov_b32_e32 v0, s2
; VI-NEXT:    s_ashr_i32 s0, s3, 16
; VI-NEXT:    s_sext_i32_i16 s3, s3
; VI-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v0, s1
; VI-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v0, s3
; VI-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    s_endpgm
  %cast = bitcast i64 %a to <4 x i16>
  %ext = sext <4 x i16> %cast to <4 x i32>
  %elt0 = extractelement <4 x i32> %ext, i32 0
  %elt1 = extractelement <4 x i32> %ext, i32 1
  %elt2 = extractelement <4 x i32> %ext, i32 2
  %elt3 = extractelement <4 x i32> %ext, i32 3
  store volatile i32 %elt0, ptr addrspace(1) %out
  store volatile i32 %elt1, ptr addrspace(1) %out
  store volatile i32 %elt2, ptr addrspace(1) %out
  store volatile i32 %elt3, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @v_sext_v4i16_to_v4i32(ptr addrspace(1) %out, ptr addrspace(1) %in) nounwind {
; SI-LABEL: v_sext_v4i16_to_v4i32:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s7, 0xf000
; SI-NEXT:    s_mov_b32 s6, -1
; SI-NEXT:    s_mov_b32 s10, s6
; SI-NEXT:    s_mov_b32 s11, s7
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b32 s8, s2
; SI-NEXT:    s_mov_b32 s9, s3
; SI-NEXT:    buffer_load_dwordx2 v[0:1], off, s[8:11], 0
; SI-NEXT:    s_mov_b32 s4, s0
; SI-NEXT:    s_mov_b32 s5, s1
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_ashr_i64 v[2:3], v[0:1], 48
; SI-NEXT:    v_ashrrev_i32_e32 v3, 16, v0
; SI-NEXT:    v_bfe_i32 v0, v0, 0, 16
; SI-NEXT:    v_bfe_i32 v1, v1, 0, 16
; SI-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    buffer_store_dword v3, off, s[4:7], 0
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    buffer_store_dword v1, off, s[4:7], 0
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    buffer_store_dword v2, off, s[4:7], 0
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    s_endpgm
;
; VI-LABEL: v_sext_v4i16_to_v4i32:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; VI-NEXT:    s_mov_b32 s7, 0xf000
; VI-NEXT:    s_mov_b32 s6, -1
; VI-NEXT:    s_mov_b32 s10, s6
; VI-NEXT:    s_mov_b32 s11, s7
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_mov_b32 s8, s2
; VI-NEXT:    s_mov_b32 s9, s3
; VI-NEXT:    buffer_load_dwordx2 v[0:1], off, s[8:11], 0
; VI-NEXT:    s_mov_b32 s4, s0
; VI-NEXT:    s_mov_b32 s5, s1
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_ashrrev_i32_e32 v3, 16, v0
; VI-NEXT:    v_bfe_i32 v0, v0, 0, 16
; VI-NEXT:    v_ashrrev_i32_e32 v2, 16, v1
; VI-NEXT:    v_bfe_i32 v1, v1, 0, 16
; VI-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    buffer_store_dword v3, off, s[4:7], 0
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    buffer_store_dword v1, off, s[4:7], 0
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    buffer_store_dword v2, off, s[4:7], 0
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    s_endpgm
  %a = load i64, ptr addrspace(1) %in
  %cast = bitcast i64 %a to <4 x i16>
  %ext = sext <4 x i16> %cast to <4 x i32>
  %elt0 = extractelement <4 x i32> %ext, i32 0
  %elt1 = extractelement <4 x i32> %ext, i32 1
  %elt2 = extractelement <4 x i32> %ext, i32 2
  %elt3 = extractelement <4 x i32> %ext, i32 3
  store volatile i32 %elt0, ptr addrspace(1) %out
  store volatile i32 %elt1, ptr addrspace(1) %out
  store volatile i32 %elt2, ptr addrspace(1) %out
  store volatile i32 %elt3, ptr addrspace(1) %out
  ret void
}

declare i32 @llvm.amdgcn.workitem.id.x() #1

attributes #1 = { nounwind readnone }
