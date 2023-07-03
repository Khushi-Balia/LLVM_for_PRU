; RUN: llc -verify-machine-dom-info < %s | not grep test_

; XFAIL: target={{.*}}-aix{{.*}}
; AIX system assembler default print error for undefined reference .
; so AIX chose to emit the available externally symbols into .s,
; so that users won't run into errors in situations like:
; clang -target powerpc-ibm-aix -xc -<<<$'extern inline __attribute__((__gnu_inline__)) void foo() {}\nvoid bar() { foo(); }' -O -Xclang -disable-llvm-passes

; XFAIL: target=nvptx{{.*}}
; unexpected emitting of the global var, while the function is not emitted as expected

; test_function should not be emitted to the .s file.
define available_externally i32 @test_function() {
  ret i32 4
}

; test_global should not be emitted to the .s file.
@test_global = available_externally global i32 4

