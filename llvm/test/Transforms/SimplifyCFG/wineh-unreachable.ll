; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --check-globals
; RUN: opt -S -passes=simplifycfg -simplifycfg-require-and-preserve-domtree=1 < %s | FileCheck %s

declare void @Personality()
declare void @f()

define void @test1() personality ptr @Personality {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @f() #[[ATTR0:[0-9]+]]
; CHECK-NEXT:    ret void
;
entry:
  invoke void @f()
  to label %exit unwind label %unreachable.unwind
exit:
  ret void
unreachable.unwind:
  cleanuppad within none []
  unreachable
}

define void @test2() personality ptr @Personality {
; CHECK-LABEL: @test2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    invoke void @f()
; CHECK-NEXT:    to label [[EXIT:%.*]] unwind label [[CATCH_PAD:%.*]]
; CHECK:       catch.pad:
; CHECK-NEXT:    [[CS1:%.*]] = catchswitch within none [label %catch.body] unwind to caller
; CHECK:       catch.body:
; CHECK-NEXT:    [[CATCH:%.*]] = catchpad within [[CS1]] []
; CHECK-NEXT:    call void @f()
; CHECK-NEXT:    catchret from [[CATCH]] to label [[UNREACHABLE:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
; CHECK:       unreachable:
; CHECK-NEXT:    unreachable
;
entry:
  invoke void @f()
  to label %exit unwind label %catch.pad
catch.pad:
  %cs1 = catchswitch within none [label %catch.body] unwind label %unreachable.unwind
catch.body:
  %catch = catchpad within %cs1 []
  call void @f()
  catchret from %catch to label %unreachable
exit:
  ret void
unreachable.unwind:
  cleanuppad within none []
  unreachable
unreachable:
  unreachable
}

define void @test3() personality ptr @Personality {
; CHECK-LABEL: @test3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    invoke void @f()
; CHECK-NEXT:    to label [[EXIT:%.*]] unwind label [[CLEANUP_PAD:%.*]]
; CHECK:       cleanup.pad:
; CHECK-NEXT:    [[CLEANUP:%.*]] = cleanuppad within none []
; CHECK-NEXT:    call void @f() #[[ATTR0]]
; CHECK-NEXT:    unreachable
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  invoke void @f()
  to label %exit unwind label %cleanup.pad
cleanup.pad:
  %cleanup = cleanuppad within none []
  invoke void @f()
  to label %cleanup.ret unwind label %unreachable.unwind
cleanup.ret:
  ; This cleanupret should be rewritten to unreachable,
  ; and merged into the pred block.
  cleanupret from %cleanup unwind label %unreachable.unwind
exit:
  ret void
unreachable.unwind:
  cleanuppad within none []
  unreachable
}

define void @test5() personality ptr @Personality {
; CHECK-LABEL: @test5(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    invoke void @f()
; CHECK-NEXT:    to label [[EXIT:%.*]] unwind label [[CATCH_PAD:%.*]]
; CHECK:       catch.pad:
; CHECK-NEXT:    [[CS1:%.*]] = catchswitch within none [label %catch.body] unwind to caller
; CHECK:       catch.body:
; CHECK-NEXT:    [[CATCH:%.*]] = catchpad within [[CS1]] []
; CHECK-NEXT:    catchret from [[CATCH]] to label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    unreachable
;
entry:
  invoke void @f()
  to label %exit unwind label %catch.pad

catch.pad:
  %cs1 = catchswitch within none [label %catch.body] unwind to caller

catch.body:
  %catch = catchpad within %cs1 []
  catchret from %catch to label %exit

exit:
  unreachable
}

define void @test6() personality ptr @Personality {
; CHECK-LABEL: @test6(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    invoke void @f()
; CHECK-NEXT:    to label [[EXIT:%.*]] unwind label [[CATCH_PAD:%.*]]
; CHECK:       catch.pad:
; CHECK-NEXT:    [[CS1:%.*]] = catchswitch within none [label %catch.body] unwind to caller
; CHECK:       catch.body:
; CHECK-NEXT:    [[CATCH:%.*]] = catchpad within [[CS1]] [ptr null, i32 0, ptr null]
; CHECK-NEXT:    catchret from [[CATCH]] to label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  invoke void @f()
  to label %exit unwind label %catch.pad

catch.pad:
  %cs1 = catchswitch within none [label %catch.body, label %catch.body] unwind to caller

catch.body:
  %catch = catchpad within %cs1 [ptr null, i32 0, ptr null]
  catchret from %catch to label %exit

exit:
  ret void
}

define void @test7() personality ptr @Personality {
; CHECK-LABEL: @test7(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    invoke void @f()
; CHECK-NEXT:    to label [[EXIT:%.*]] unwind label [[CATCH_PAD:%.*]]
; CHECK:       catch.pad:
; CHECK-NEXT:    [[CS1:%.*]] = catchswitch within none [label %catch.body] unwind to caller
; CHECK:       catch.body:
; CHECK-NEXT:    [[CATCH:%.*]] = catchpad within [[CS1]] [ptr null, i32 0, ptr null]
; CHECK-NEXT:    catchret from [[CATCH]] to label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  invoke void @f()
  to label %exit unwind label %catch.pad

catch.pad:
  %cs1 = catchswitch within none [label %catch.body, label %catch.body2] unwind to caller

catch.body:
  %catch = catchpad within %cs1 [ptr null, i32 0, ptr null]
  catchret from %catch to label %exit

catch.body2:
  %catch2 = catchpad within %cs1 [ptr null, i32 0, ptr null]
  catchret from %catch2 to label %exit

exit:
  ret void
}

define void @test8() personality ptr @Personality {
; CHECK-LABEL: @test8(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    invoke void @f()
; CHECK-NEXT:    to label [[EXIT:%.*]] unwind label [[CATCH_PAD:%.*]]
; CHECK:       catch.pad:
; CHECK-NEXT:    [[CS1:%.*]] = catchswitch within none [label %catch.body] unwind to caller
; CHECK:       catch.body:
; CHECK-NEXT:    [[CATCH:%.*]] = catchpad within [[CS1]] [ptr null, i32 0, ptr null]
; CHECK-NEXT:    catchret from [[CATCH]] to label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  invoke void @f()
  to label %exit unwind label %catch.pad

catch.pad:
  %cs1 = catchswitch within none [label %catch.body, label %catch.body2] unwind to caller

catch.body2:
  %catch2 = catchpad within %cs1 [ptr null, i32 0, ptr null]
  catchret from %catch2 to label %exit

catch.body:
  %catch = catchpad within %cs1 [ptr null, i32 0, ptr null]
  catchret from %catch to label %exit

exit:
  ret void
}

define void @test9() personality ptr @Personality {
; CHECK-LABEL: @test9(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    invoke void @f()
; CHECK-NEXT:    to label [[EXIT:%.*]] unwind label [[CATCH_PAD:%.*]]
; CHECK:       catch.pad:
; CHECK-NEXT:    [[CS1:%.*]] = catchswitch within none [label [[CATCH_BODY:%.*]], label %catch.body2] unwind to caller
; CHECK:       catch.body:
; CHECK-NEXT:    [[CATCH:%.*]] = catchpad within [[CS1]] [ptr null, i32 0, ptr null]
; CHECK-NEXT:    catchret from [[CATCH]] to label [[EXIT]]
; CHECK:       catch.body2:
; CHECK-NEXT:    [[CATCH2:%.*]] = catchpad within [[CS1]] [ptr null, i32 64, ptr null]
; CHECK-NEXT:    catchret from [[CATCH2]] to label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  invoke void @f()
  to label %exit unwind label %catch.pad

catch.pad:
  %cs1 = catchswitch within none [label %catch.body, label %catch.body2] unwind to caller

catch.body:
  %catch = catchpad within %cs1 [ptr null, i32 0, ptr null]
  catchret from %catch to label %exit

catch.body2:
  %catch2 = catchpad within %cs1 [ptr null, i32 64, ptr null]
  catchret from %catch2 to label %exit

exit:
  ret void
}
;.
; CHECK: attributes #[[ATTR0]] = { nounwind }
;.
