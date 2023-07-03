; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=simplifycfg -simplifycfg-require-and-preserve-domtree=1 -S | FileCheck %s

  %llvm.dbg.anchor.type = type { i32, i32 }
  %llvm.dbg.basictype.type = type { i32, ptr, ptr, ptr, i32, i64, i64, i64, i32, i32 }
  %llvm.dbg.compile_unit.type = type { i32, ptr, i32, ptr, ptr, ptr, i1, i1, ptr }
  %llvm.dbg.composite.type = type { i32, ptr, ptr, ptr, i32, i64, i64, i64, i32, ptr, ptr }
  %llvm.dbg.derivedtype.type = type { i32, ptr, ptr, ptr, i32, i64, i64, i64, i32, ptr }
  %llvm.dbg.global_variable.type = type { i32, ptr, ptr, ptr, ptr, ptr, ptr, i32, ptr, i1, i1, ptr }
  %llvm.dbg.subprogram.type = type { i32, ptr, ptr, ptr, ptr, ptr, ptr, i32, ptr, i1, i1 }
  %llvm.dbg.subrange.type = type { i32, i64, i64 }
  %struct.Group = type { %struct.Scene, %struct.Sphere, %"struct.std::list<Scene*,std::allocator<Scene*> >" }
  %struct.Ray = type { %struct.Vec, %struct.Vec }
  %struct.Scene = type { ptr }
  %struct.Sphere = type { %struct.Scene, %struct.Vec, double }
  %struct.Vec = type { double, double, double }
  %struct.__class_type_info_pseudo = type { %struct.__type_info_pseudo }
  %struct.__false_type = type <{ i8 }>
  %"struct.__gnu_cxx::new_allocator<Scene*>" = type <{ i8 }>
  %"struct.__gnu_cxx::new_allocator<std::_List_node<Scene*> >" = type <{ i8 }>
  %struct.__si_class_type_info_pseudo = type { %struct.__type_info_pseudo, ptr }
  %struct.__type_info_pseudo = type { ptr, ptr }
  %"struct.std::Hit" = type { double, %struct.Vec }
  %"struct.std::_List_base<Scene*,std::allocator<Scene*> >" = type { %"struct.std::_List_base<Scene*,std::allocator<Scene*> >::_List_impl" }
  %"struct.std::_List_base<Scene*,std::allocator<Scene*> >::_List_impl" = type { %"struct.std::_List_node_base" }
  %"struct.std::_List_const_iterator<Scene*>" = type { ptr }
  %"struct.std::_List_iterator<Scene*>" = type { ptr }
  %"struct.std::_List_node<Scene*>" = type { %"struct.std::_List_node_base", ptr }
  %"struct.std::_List_node_base" = type { ptr, ptr }
  %"struct.std::allocator<Scene*>" = type <{ i8 }>
  %"struct.std::allocator<std::_List_node<Scene*> >" = type <{ i8 }>
  %"struct.std::basic_ios<char,std::char_traits<char> >" = type { %"struct.std::ios_base", ptr, i8, i8, ptr, ptr, ptr, ptr }
  %"struct.std::basic_ostream<char,std::char_traits<char> >" = type { ptr, %"struct.std::basic_ios<char,std::char_traits<char> >" }
  %"struct.std::basic_streambuf<char,std::char_traits<char> >" = type { ptr, ptr, ptr, ptr, ptr, ptr, ptr, %"struct.std::locale" }
  %"struct.std::ctype<char>" = type { %"struct.std::locale::facet", ptr, i8, ptr, ptr, ptr, i8, [256 x i8], [256 x i8], i8 }
  %"struct.std::ios_base" = type { ptr, i32, i32, i32, i32, i32, ptr, %"struct.std::ios_base::_Words", [8 x %"struct.std::ios_base::_Words"], i32, ptr, %"struct.std::locale" }
  %"struct.std::ios_base::Init" = type <{ i8 }>
  %"struct.std::ios_base::_Callback_list" = type { ptr, ptr, i32, i32 }
  %"struct.std::ios_base::_Words" = type { ptr, i32 }
  %"struct.std::list<Scene*,std::allocator<Scene*> >" = type { %"struct.std::_List_base<Scene*,std::allocator<Scene*> >" }
  %"struct.std::locale" = type { ptr }
  %"struct.std::locale::_Impl" = type { i32, ptr, i32, ptr, ptr }
  %"struct.std::locale::facet" = type { ptr, i32 }
  %"struct.std::num_get<char,std::istreambuf_iterator<char, std::char_traits<char> > >" = type { %"struct.std::locale::facet" }
  %"struct.std::num_put<char,std::ostreambuf_iterator<char, std::char_traits<char> > >" = type { %"struct.std::locale::facet" }
  %"struct.std::numeric_limits<double>" = type <{ i8 }>
  %"struct.std::type_info" = type { ptr, ptr }
@llvm.dbg.subprogram947 = external constant %llvm.dbg.subprogram.type		; <ptr> [#uses=1]

declare void @llvm.dbg.func.start(ptr) nounwind

declare void @llvm.dbg.region.end(ptr) nounwind

declare void @_ZN9__gnu_cxx13new_allocatorIP5SceneED2Ev(ptr) nounwind

define void @_ZNSaIP5SceneED1Ev(ptr %this) nounwind {
; CHECK-LABEL: @_ZNSaIP5SceneED1Ev(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[THIS_ADDR:%.*]] = alloca ptr, align 8
; CHECK-NEXT:    %"alloca point" = bitcast i32 0 to i32
; CHECK-NEXT:    call void @llvm.dbg.func.start(ptr @llvm.dbg.subprogram947)
; CHECK-NEXT:    store ptr [[THIS:%.*]], ptr [[THIS_ADDR]], align 8
; CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[THIS_ADDR]], align 4
; CHECK-NEXT:    call void @_ZN9__gnu_cxx13new_allocatorIP5SceneED2Ev(ptr [[TMP0]]) #[[ATTR0:[0-9]+]]
; CHECK-NEXT:    call void @llvm.dbg.region.end(ptr @llvm.dbg.subprogram947)
; CHECK-NEXT:    ret void
;
entry:
  %this_addr = alloca ptr		; <ptr> [#uses=2]
  %"alloca point" = bitcast i32 0 to i32		; <i32> [#uses=0]
  call void @llvm.dbg.func.start(ptr @llvm.dbg.subprogram947)
  store ptr %this, ptr %this_addr
  %0 = load ptr, ptr %this_addr, align 4		; <ptr> [#uses=1]
  call void @_ZN9__gnu_cxx13new_allocatorIP5SceneED2Ev(ptr %0) nounwind
  br label %bb

bb:		; preds = %entry
  br label %return

return:		; preds = %bb
  call void @llvm.dbg.region.end(ptr @llvm.dbg.subprogram947)
  ret void
}
