; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s

define i32 @assume_add(i32 %a, i32 %b) {
; CHECK-LABEL: @assume_add(
; CHECK-NEXT:    [[T1:%.*]] = add i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[LAST_TWO_DIGITS:%.*]] = and i32 [[T1]], 3
; CHECK-NEXT:    [[T2:%.*]] = icmp eq i32 [[LAST_TWO_DIGITS]], 0
; CHECK-NEXT:    call void @llvm.assume(i1 [[T2]])
; CHECK-NEXT:    [[T3:%.*]] = or i32 [[T1]], 3
; CHECK-NEXT:    ret i32 [[T3]]
;
  %t1 = add i32 %a, %b
  %last_two_digits = and i32 %t1, 3
  %t2 = icmp eq i32 %last_two_digits, 0
  call void @llvm.assume(i1 %t2)
  %t3 = add i32 %t1, 3
  ret i32 %t3
}

declare void @llvm.assume(i1)
