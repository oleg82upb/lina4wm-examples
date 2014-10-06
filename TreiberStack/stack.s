; ModuleID = 'stack.cpp'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32"
target triple = "i386-linux-gnu"

%struct.Node = type { i32, %struct.Node* }
%struct.Stack = type { %struct.Node* }

define void @_ZN5StackC2Ev(%struct.Stack* %this) nounwind align 2 {
entry:
  %this_addr = alloca %struct.Stack*              ; <%struct.Stack**> [#uses=2]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store %struct.Stack* %this, %struct.Stack** %this_addr
  %0 = load %struct.Stack** %this_addr, align 4   ; <%struct.Stack*> [#uses=1]
  %1 = getelementptr inbounds %struct.Stack* %0, i32 0, i32 0 ; <%struct.Node**> [#uses=1]
  volatile store %struct.Node* null, %struct.Node** %1, align 4
  br label %return

return:                                           ; preds = %entry
  ret void
}

define linkonce_odr void @_ZN4NodeC1Ev(%struct.Node* %this) nounwind align 2 {
entry:
  %this_addr = alloca %struct.Node*               ; <%struct.Node**> [#uses=2]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store %struct.Node* %this, %struct.Node** %this_addr
  %0 = load %struct.Node** %this_addr, align 4    ; <%struct.Node*> [#uses=1]
  %1 = getelementptr inbounds %struct.Node* %0, i32 0, i32 0 ; <i32*> [#uses=1]
  store i32 0, i32* %1, align 4
  br label %return

return:                                           ; preds = %entry
  ret void
}

define void @_ZN5StackC1Ev(%struct.Stack* %this) nounwind align 2 {
entry:
  %this_addr = alloca %struct.Stack*              ; <%struct.Stack**> [#uses=2]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store %struct.Stack* %this, %struct.Stack** %this_addr
  %0 = load %struct.Stack** %this_addr, align 4   ; <%struct.Stack*> [#uses=1]
  %1 = getelementptr inbounds %struct.Stack* %0, i32 0, i32 0 ; <%struct.Node**> [#uses=1]
  volatile store %struct.Node* null, %struct.Node** %1, align 4
  br label %return

return:                                           ; preds = %entry
  ret void
}

define i32 @main() nounwind {
entry:
  %retval = alloca i32                            ; <i32*> [#uses=2]
  %0 = alloca i32                                 ; <i32*> [#uses=2]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store i32 0, i32* %0, align 4
  %1 = load i32* %0, align 4                      ; <i32> [#uses=1]
  store i32 %1, i32* %retval, align 4
  br label %return

return:                                           ; preds = %entry
  %retval1 = load i32* %retval                    ; <i32> [#uses=1]
  ret i32 %retval1
}

define %struct.Node* @_ZN5Stack3popEv(%struct.Stack* %this) nounwind align 2 {
entry:
  %this_addr = alloca %struct.Stack*              ; <%struct.Stack**> [#uses=3]
  %retval = alloca %struct.Node*                  ; <%struct.Node**> [#uses=2]
  %0 = alloca %struct.Node*                       ; <%struct.Node**> [#uses=3]
  %retval.5 = alloca i8                           ; <i8*> [#uses=2]
  %ss = alloca %struct.Node*                      ; <%struct.Node**> [#uses=5]
  %ssn = alloca %struct.Node*                     ; <%struct.Node**> [#uses=2]
  %lv = alloca %struct.Node*                      ; <%struct.Node**> [#uses=0]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store %struct.Stack* %this, %struct.Stack** %this_addr
  br label %bb

bb:                                               ; preds = %bb2, %entry
  %1 = load %struct.Stack** %this_addr, align 4   ; <%struct.Stack*> [#uses=1]
  %2 = getelementptr inbounds %struct.Stack* %1, i32 0, i32 0 ; <%struct.Node**> [#uses=1]
  %3 = volatile load %struct.Node** %2, align 4   ; <%struct.Node*> [#uses=1]
  store %struct.Node* %3, %struct.Node** %ss, align 4
  %4 = load %struct.Node** %ss, align 4           ; <%struct.Node*> [#uses=1]
  %5 = icmp eq %struct.Node* %4, null             ; <i1> [#uses=1]
  br i1 %5, label %bb1, label %bb2

bb1:                                              ; preds = %bb
  store %struct.Node* null, %struct.Node** %0, align 4
  br label %bb6

bb2:                                              ; preds = %bb
  %6 = load %struct.Node** %ss, align 4           ; <%struct.Node*> [#uses=1]
  %7 = getelementptr inbounds %struct.Node* %6, i32 0, i32 1 ; <%struct.Node**> [#uses=1]
  %8 = load %struct.Node** %7, align 4            ; <%struct.Node*> [#uses=1]
  store %struct.Node* %8, %struct.Node** %ssn, align 4
  %9 = load %struct.Node** %ssn, align 4          ; <%struct.Node*> [#uses=1]
  %10 = ptrtoint %struct.Node* %9 to i32          ; <i32> [#uses=1]
  %11 = load %struct.Node** %ss, align 4          ; <%struct.Node*> [#uses=1]
  %12 = ptrtoint %struct.Node* %11 to i32         ; <i32> [#uses=2]
  %13 = load %struct.Stack** %this_addr, align 4  ; <%struct.Stack*> [#uses=1]
  %14 = getelementptr inbounds %struct.Stack* %13, i32 0, i32 0 ; <%struct.Node**> [#uses=1]
  %15 = bitcast %struct.Node** %14 to i32*        ; <i32*> [#uses=1]
  %16 = cmpxchg i32* %15, i32 %12, i32 %10 seq_cst
  %17 = icmp eq i32 %16, %12                      ; <i1> [#uses=1]
  %18 = zext i1 %17 to i8                         ; <i8> [#uses=1]
  %toBool = icmp ne i8 %18, 0                     ; <i1> [#uses=1]
  %toBoolnot = xor i1 %toBool, true               ; <i1> [#uses=1]
  %toBoolnot3 = zext i1 %toBoolnot to i8          ; <i8> [#uses=1]
  store i8 %toBoolnot3, i8* %retval.5, align 1
  %19 = load i8* %retval.5, align 1               ; <i8> [#uses=1]
  %toBool4 = icmp ne i8 %19, 0                    ; <i1> [#uses=1]
  br i1 %toBool4, label %bb, label %bb5

bb5:                                              ; preds = %bb2
  %20 = load %struct.Node** %ss, align 4          ; <%struct.Node*> [#uses=1]
  store %struct.Node* %20, %struct.Node** %0, align 4
  br label %bb6

bb6:                                              ; preds = %bb5, %bb1
  %21 = load %struct.Node** %0, align 4           ; <%struct.Node*> [#uses=1]
  store %struct.Node* %21, %struct.Node** %retval, align 4
  br label %return

return:                                           ; preds = %bb6
  %retval7 = load %struct.Node** %retval          ; <%struct.Node*> [#uses=1]
  ret %struct.Node* %retval7
}


define void @_ZN5Stack4pushEi(%struct.Stack* %this, i32 %v) align 2 {
entry:
  %this_addr = alloca %struct.Stack*              ; <%struct.Stack**> [#uses=3]
  %v_addr = alloca i32                            ; <i32*> [#uses=2]
  %retval.0 = alloca i8                           ; <i8*> [#uses=2]
  %0 = alloca %struct.Node*                       ; <%struct.Node**> [#uses=3]
  %n = alloca %struct.Node*                       ; <%struct.Node**> [#uses=4]
  %ss = alloca %struct.Node*                      ; <%struct.Node**> [#uses=3]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store %struct.Stack* %this, %struct.Stack** %this_addr
  store i32 %v, i32* %v_addr
  %1 = call i8* @_Znwj(i32 8)                     ; <i8*> [#uses=1]
  %2 = bitcast i8* %1 to %struct.Node*            ; <%struct.Node*> [#uses=1]
  store %struct.Node* %2, %struct.Node** %0, align 4
  %3 = load %struct.Node** %0, align 4            ; <%struct.Node*> [#uses=1]
  call void @_ZN4NodeC1Ev(%struct.Node* %3) nounwind
  %4 = load %struct.Node** %0, align 4            ; <%struct.Node*> [#uses=1]
  store %struct.Node* %4, %struct.Node** %n, align 4
  %5 = load %struct.Node** %n, align 4            ; <%struct.Node*> [#uses=1]
  %6 = getelementptr inbounds %struct.Node* %5, i32 0, i32 0 ; <i32*> [#uses=1]
  %7 = load i32* %v_addr, align 4                 ; <i32> [#uses=1]
  store i32 %7, i32* %6, align 4
  br label %bb

bb:                                               ; preds = %bb, %entry
  %8 = load %struct.Stack** %this_addr, align 4   ; <%struct.Stack*> [#uses=1]
  %9 = getelementptr inbounds %struct.Stack* %8, i32 0, i32 0 ; <%struct.Node**> [#uses=1]
  %10 = volatile load %struct.Node** %9, align 4  ; <%struct.Node*> [#uses=1]
  store %struct.Node* %10, %struct.Node** %ss, align 4
  %11 = load %struct.Node** %n, align 4           ; <%struct.Node*> [#uses=1]
  %12 = getelementptr inbounds %struct.Node* %11, i32 0, i32 1 ; <%struct.Node**> [#uses=1]
  %13 = load %struct.Node** %ss, align 4          ; <%struct.Node*> [#uses=1]
  store %struct.Node* %13, %struct.Node** %12, align 4
  %14 = load %struct.Node** %n, align 4           ; <%struct.Node*> [#uses=1]
  %15 = ptrtoint %struct.Node* %14 to i32         ; <i32> [#uses=1]
  %16 = load %struct.Node** %ss, align 4          ; <%struct.Node*> [#uses=1]
  %17 = ptrtoint %struct.Node* %16 to i32         ; <i32> [#uses=2]
  %18 = load %struct.Stack** %this_addr, align 4  ; <%struct.Stack*> [#uses=1]
  %19 = getelementptr inbounds %struct.Stack* %18, i32 0, i32 0 ; <%struct.Node**> [#uses=1]
  %20 = bitcast %struct.Node** %19 to i32*        ; <i32*> [#uses=1]
  %21 = cmpxchg i32* %20, i32 %17, i32 %15 seq_cst
  %22 = icmp eq i32 %21, %17                      ; <i1> [#uses=1]
  %23 = zext i1 %22 to i8                         ; <i8> [#uses=1]
  %toBool = icmp ne i8 %23, 0                     ; <i1> [#uses=1]
  %toBoolnot = xor i1 %toBool, true               ; <i1> [#uses=1]
  %toBoolnot1 = zext i1 %toBoolnot to i8          ; <i8> [#uses=1]
  store i8 %toBoolnot1, i8* %retval.0, align 1
  %24 = load i8* %retval.0, align 1               ; <i8> [#uses=1]
  %toBool2 = icmp ne i8 %24, 0                    ; <i1> [#uses=1]
  br i1 %toBool2, label %bb, label %bb3

bb3:                                              ; preds = %bb
  br label %return

return:                                           ; preds = %bb3
  ret void
}

declare i8* @_Znwj(i32)
