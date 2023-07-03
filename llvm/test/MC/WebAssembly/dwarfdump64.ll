; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -filetype=obj %s -o - | llvm-dwarfdump --show-form - | FileCheck %s

; CHECK: .debug_info contents:
; CHECK-NEXT: 0x00000000: Compile Unit: length = 0x0000007e, format = DWARF32, version = 0x0004, abbr_offset = 0x0000, addr_size = 0x08 (next unit at 0x00000082)

; CHECK: 0x0000000b: DW_TAG_compile_unit
; CHECK-NEXT:              DW_AT_producer [DW_FORM_strp]     ("clang version 6.0.0 (trunk 315924) (llvm/trunk 315960)")
; CHECK-NEXT:              DW_AT_language [DW_FORM_data2]    (DW_LANG_C99)
; CHECK-NEXT:              DW_AT_name [DW_FORM_strp] ("test.c")
; CHECK-NEXT:              DW_AT_stmt_list [DW_FORM_sec_offset]      (0x00000000)
; CHECK-NEXT:              DW_AT_comp_dir [DW_FORM_strp]     ("/usr/local/google/home/sbc/dev/wasm/simple")
; CHECK-NEXT:              DW_AT_GNU_pubnames [DW_FORM_flag_present] (true)
; CHECK-NEXT:              DW_AT_low_pc [DW_FORM_addr]       (0x0000000000000002)
; CHECK-NEXT:              DW_AT_high_pc [DW_FORM_data4]     (0x00000002)

; CHECK: 0x0000002a:   DW_TAG_variable
; CHECK-NEXT:                DW_AT_name [DW_FORM_strp]       ("foo")
; CHECK-NEXT:                DW_AT_type [DW_FORM_ref4]       (0x0000003f "int *")
; CHECK-NEXT:                DW_AT_external [DW_FORM_flag_present]   (true)
; CHECK-NEXT:                DW_AT_decl_file [DW_FORM_data1] ("/usr/local/google/home/sbc/dev/wasm/simple{{[/\\]}}test.c")
; CHECK-NEXT:                DW_AT_decl_line [DW_FORM_data1] (4)
; CHECK-NEXT:                DW_AT_location [DW_FORM_exprloc]        (DW_OP_addr 0x0)

; CHECK: 0x0000003f:   DW_TAG_pointer_type
; CHECK-NEXT:                DW_AT_type [DW_FORM_ref4]       (0x00000044 "int")

; CHECK: 0x00000044:   DW_TAG_base_type
; CHECK-NEXT:                DW_AT_name [DW_FORM_strp]       ("int")
; CHECK-NEXT:                DW_AT_encoding [DW_FORM_data1]  (DW_ATE_signed)
; CHECK-NEXT:                DW_AT_byte_size [DW_FORM_data1] (0x04)

; CHECK: 0x0000004b:   DW_TAG_variable
; CHECK-NEXT:                DW_AT_name [DW_FORM_strp]       ("ptr2")
; CHECK-NEXT:                DW_AT_type [DW_FORM_ref4]       (0x00000060 "void (*)()")
; CHECK-NEXT:                DW_AT_external [DW_FORM_flag_present]   (true)
; CHECK-NEXT:                DW_AT_decl_file [DW_FORM_data1] ("/usr/local/google/home/sbc/dev/wasm/simple{{[/\\]}}test.c")
; CHECK-NEXT:                DW_AT_decl_line [DW_FORM_data1] (5)
; CHECK-NEXT:                DW_AT_location [DW_FORM_exprloc]        (DW_OP_addr 0x8)

; CHECK: 0x00000060:   DW_TAG_pointer_type
; CHECK-NEXT:                DW_AT_type [DW_FORM_ref4]       (0x00000065 "void ()")

; CHECK: 0x00000065:   DW_TAG_subroutine_type
; CHECK-NEXT:                DW_AT_prototyped [DW_FORM_flag_present] (true)

; CHECK: 0x00000066:   DW_TAG_subprogram
; CHECK-NEXT:                DW_AT_low_pc [DW_FORM_addr]     (0x0000000000000002)
; CHECK-NEXT:                DW_AT_high_pc [DW_FORM_data4]   (0x00000002)
; CHECK-NEXT:                DW_AT_frame_base [DW_FORM_exprloc]      (DW_OP_WASM_location 0x3 0x0, DW_OP_stack_value)
; CHECK-NEXT:                DW_AT_name [DW_FORM_strp]       ("f2")
; CHECK-NEXT:                DW_AT_decl_file [DW_FORM_data1] ("/usr/local/google/home/sbc/dev/wasm/simple{{[/\\]}}test.c")
; CHECK-NEXT:                DW_AT_decl_line [DW_FORM_data1] (2)
; CHECK-NEXT:                DW_AT_prototyped [DW_FORM_flag_present] (true)
; CHECK-NEXT:                DW_AT_external [DW_FORM_flag_present]   (true)

; CHECK: 0x00000081:   NULL

target triple = "wasm64-unknown-unknown"

source_filename = "test.c"

@myextern = external global i32, align 4
@foo = hidden global ptr @myextern, align 4, !dbg !0
@ptr2 = hidden global ptr @f2, align 4, !dbg !6

; Function Attrs: noinline nounwind optnone
define hidden void @f2() #0 !dbg !17 {
entry:
  ret void, !dbg !18
}

attributes #0 = { noinline nounwind optnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "frame-pointer"="none" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!13, !14, !15}
!llvm.ident = !{!16}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "foo", scope: !2, file: !3, line: 4, type: !11, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 6.0.0 (trunk 315924) (llvm/trunk 315960)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "test.c", directory: "/usr/local/google/home/sbc/dev/wasm/simple")
!4 = !{}
!5 = !{!0, !6}
!6 = !DIGlobalVariableExpression(var: !7, expr: !DIExpression())
!7 = distinct !DIGlobalVariable(name: "ptr2", scope: !2, file: !3, line: 5, type: !8, isLocal: false, isDefinition: true)
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!9 = !DISubroutineType(types: !10)
!10 = !{null}
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !{i32 2, !"Dwarf Version", i32 4}
!14 = !{i32 2, !"Debug Info Version", i32 3}
!15 = !{i32 1, !"wchar_size", i32 4}
!16 = !{!"clang version 6.0.0 (trunk 315924) (llvm/trunk 315960)"}
!17 = distinct !DISubprogram(name: "f2", scope: !3, file: !3, line: 2, type: !9, isLocal: false, isDefinition: true, scopeLine: 2, flags: DIFlagPrototyped, isOptimized: false, unit: !2, retainedNodes: !4)
!18 = !DILocation(line: 2, column: 16, scope: !17)
