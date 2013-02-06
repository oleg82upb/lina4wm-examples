; ModuleID = 'rdcss.cpp'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

%struct.stDescriptor = type { i32*, i32*, i32, i32, i32 }
%"class.std::type_info" = type { i32 (...)**, i8* }

@_ZTIj = external constant i8*
@_ZTVN10__cxxabiv117__class_type_infoE = external global i8*
@_ZTS12stDescriptor = linkonce_odr constant [15 x i8] c"12stDescriptor\00"
@_ZTI12stDescriptor = linkonce_odr unnamed_addr constant { i8*, i8* } { i8* bitcast (i8** getelementptr inbounds (i8** @_ZTVN10__cxxabiv117__class_type_infoE, i32 2) to i8*), i8* getelementptr inbounds ([15 x i8]* @_ZTS12stDescriptor, i32 0, i32 0) }

define i32 @_Z5RDCSSP12stDescriptor(%struct.stDescriptor* %d) {
entry:
  %d.addr = alloca %struct.stDescriptor*, align 4
  %r = alloca i32, align 4
  store %struct.stDescriptor* %d, %struct.stDescriptor** %d.addr, align 4
  br label %do.body

do.body:                                          ; preds = %do.cond, %entry
  %0 = load %struct.stDescriptor** %d.addr, align 4
  %a2 = getelementptr inbounds %struct.stDescriptor* %0, i32 0, i32 1
  %1 = load i32** %a2, align 4
  %2 = load %struct.stDescriptor** %d.addr, align 4
  %o2 = getelementptr inbounds %struct.stDescriptor* %2, i32 0, i32 3
  %3 = load i32* %o2, align 4
  %4 = load %struct.stDescriptor** %d.addr, align 4
  %5 = ptrtoint %struct.stDescriptor* %4 to i32
  %call = call i32 @_Z4CAS1Pjjj(i32* %1, i32 %3, i32 %5)
  store i32 %call, i32* %r, align 4
  %call1 = call zeroext i1 @_ZNKSt9type_infoeqERKS_(%"class.std::type_info"* bitcast (i8** @_ZTIj to %"class.std::type_info"*), %"class.std::type_info"* bitcast ({ i8*, i8* }* @_ZTI12stDescriptor to %"class.std::type_info"*))
  br i1 %call1, label %if.then, label %if.end

if.then:                                          ; preds = %do.body
  %6 = load i32* %r, align 4
  %7 = inttoptr i32 %6 to %struct.stDescriptor*
  call void @_Z8CompleteP12stDescriptor(%struct.stDescriptor* %7)
  br label %if.end

if.end:                                           ; preds = %if.then, %do.body
  br label %do.cond

do.cond:                                          ; preds = %if.end
  %call2 = call zeroext i1 @_ZNKSt9type_infoeqERKS_(%"class.std::type_info"* bitcast (i8** @_ZTIj to %"class.std::type_info"*), %"class.std::type_info"* bitcast ({ i8*, i8* }* @_ZTI12stDescriptor to %"class.std::type_info"*))
  br i1 %call2, label %do.body, label %do.end

do.end:                                           ; preds = %do.cond
  %8 = load i32* %r, align 4
  %9 = load %struct.stDescriptor** %d.addr, align 4
  %o23 = getelementptr inbounds %struct.stDescriptor* %9, i32 0, i32 3
  %10 = load i32* %o23, align 4
  %cmp = icmp eq i32 %8, %10
  br i1 %cmp, label %if.then4, label %if.end5

if.then4:                                         ; preds = %do.end
  %11 = load %struct.stDescriptor** %d.addr, align 4
  call void @_Z8CompleteP12stDescriptor(%struct.stDescriptor* %11)
  br label %if.end5

if.end5:                                          ; preds = %if.then4, %do.end
  %12 = load i32* %r, align 4
  ret i32 %12
}

define i32 @_Z4CAS1Pjjj(i32* %a, i32 %o, i32 %n) nounwind {
entry:
  %a.addr = alloca i32*, align 4
  %o.addr = alloca i32, align 4
  %n.addr = alloca i32, align 4
  store i32* %a, i32** %a.addr, align 4
  store i32 %o, i32* %o.addr, align 4
  store i32 %n, i32* %n.addr, align 4
  %0 = load i32** %a.addr, align 4
  %1 = load i32* %o.addr, align 4
  %2 = load i32* %n.addr, align 4
  %3 = cmpxchg i32* %0, i32 %1, i32 %2 seq_cst
  ret i32 %3
}

define linkonce_odr zeroext i1 @_ZNKSt9type_infoeqERKS_(%"class.std::type_info"* %this, %"class.std::type_info"* %__arg) nounwind align 2 {
entry:
  %this.addr = alloca %"class.std::type_info"*, align 4
  %__arg.addr = alloca %"class.std::type_info"*, align 4
  store %"class.std::type_info"* %this, %"class.std::type_info"** %this.addr, align 4
  store %"class.std::type_info"* %__arg, %"class.std::type_info"** %__arg.addr, align 4
  %this1 = load %"class.std::type_info"** %this.addr
  %__name = getelementptr inbounds %"class.std::type_info"* %this1, i32 0, i32 1
  %0 = load i8** %__name, align 4
  %1 = load %"class.std::type_info"** %__arg.addr, align 4
  %__name2 = getelementptr inbounds %"class.std::type_info"* %1, i32 0, i32 1
  %2 = load i8** %__name2, align 4
  %cmp = icmp eq i8* %0, %2
  br i1 %cmp, label %lor.end, label %lor.rhs

lor.rhs:                                          ; preds = %entry
  %__name3 = getelementptr inbounds %"class.std::type_info"* %this1, i32 0, i32 1
  %3 = load i8** %__name3, align 4
  %arrayidx = getelementptr inbounds i8* %3, i32 0
  %4 = load i8* %arrayidx, align 1
  %conv = sext i8 %4 to i32
  %cmp4 = icmp ne i32 %conv, 42
  br i1 %cmp4, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %lor.rhs
  %__name5 = getelementptr inbounds %"class.std::type_info"* %this1, i32 0, i32 1
  %5 = load i8** %__name5, align 4
  %6 = load %"class.std::type_info"** %__arg.addr, align 4
  %__name6 = getelementptr inbounds %"class.std::type_info"* %6, i32 0, i32 1
  %7 = load i8** %__name6, align 4
  %call = call i32 @strcmp(i8* %5, i8* %7) nounwind
  %cmp7 = icmp eq i32 %call, 0
  br label %land.end

land.end:                                         ; preds = %land.rhs, %lor.rhs
  %8 = phi i1 [ false, %lor.rhs ], [ %cmp7, %land.rhs ]
  br label %lor.end

lor.end:                                          ; preds = %land.end, %entry
  %9 = phi i1 [ true, %entry ], [ %8, %land.end ]
  ret i1 %9
}

define void @_Z8CompleteP12stDescriptor(%struct.stDescriptor* %d) {
entry:
  %d.addr = alloca %struct.stDescriptor*, align 4
  %v = alloca i32, align 4
  store %struct.stDescriptor* %d, %struct.stDescriptor** %d.addr, align 4
  %0 = load %struct.stDescriptor** %d.addr, align 4
  %a1 = getelementptr inbounds %struct.stDescriptor* %0, i32 0, i32 0
  %1 = load i32** %a1, align 4
  %2 = load i32* %1, align 4
  store i32 %2, i32* %v, align 4
  %3 = load i32* %v, align 4
  %4 = load %struct.stDescriptor** %d.addr, align 4
  %o1 = getelementptr inbounds %struct.stDescriptor* %4, i32 0, i32 2
  %5 = load i32* %o1, align 4
  %cmp = icmp eq i32 %3, %5
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %6 = load %struct.stDescriptor** %d.addr, align 4
  %a2 = getelementptr inbounds %struct.stDescriptor* %6, i32 0, i32 1
  %7 = load i32** %a2, align 4
  %8 = load %struct.stDescriptor** %d.addr, align 4
  %9 = ptrtoint %struct.stDescriptor* %8 to i32
  %10 = load %struct.stDescriptor** %d.addr, align 4
  %n2 = getelementptr inbounds %struct.stDescriptor* %10, i32 0, i32 4
  %11 = load i32* %n2, align 4
  %call = call i32 @_Z4CAS1Pjjj(i32* %7, i32 %9, i32 %11)
  br label %if.end

if.else:                                          ; preds = %entry
  %12 = load %struct.stDescriptor** %d.addr, align 4
  %a21 = getelementptr inbounds %struct.stDescriptor* %12, i32 0, i32 1
  %13 = load i32** %a21, align 4
  %14 = load %struct.stDescriptor** %d.addr, align 4
  %15 = ptrtoint %struct.stDescriptor* %14 to i32
  %16 = load %struct.stDescriptor** %d.addr, align 4
  %o2 = getelementptr inbounds %struct.stDescriptor* %16, i32 0, i32 3
  %17 = load i32* %o2, align 4
  %call2 = call i32 @_Z4CAS1Pjjj(i32* %13, i32 %15, i32 %17)
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  ret void
}

define i32 @_Z4ReadPj(i32* %addr) {
entry:
  %addr.addr = alloca i32*, align 4
  %r = alloca i32, align 4
  store i32* %addr, i32** %addr.addr, align 4
  br label %do.body

do.body:                                          ; preds = %do.cond, %entry
  %0 = load i32** %addr.addr, align 4
  %1 = load i32* %0, align 4
  store i32 %1, i32* %r, align 4
  %call = call zeroext i1 @_ZNKSt9type_infoeqERKS_(%"class.std::type_info"* bitcast (i8** @_ZTIj to %"class.std::type_info"*), %"class.std::type_info"* bitcast ({ i8*, i8* }* @_ZTI12stDescriptor to %"class.std::type_info"*))
  br i1 %call, label %if.then, label %if.end

if.then:                                          ; preds = %do.body
  %2 = load i32* %r, align 4
  %3 = inttoptr i32 %2 to %struct.stDescriptor*
  call void @_Z8CompleteP12stDescriptor(%struct.stDescriptor* %3)
  br label %if.end

if.end:                                           ; preds = %if.then, %do.body
  br label %do.cond

do.cond:                                          ; preds = %if.end
  %call1 = call zeroext i1 @_ZNKSt9type_infoeqERKS_(%"class.std::type_info"* bitcast (i8** @_ZTIj to %"class.std::type_info"*), %"class.std::type_info"* bitcast ({ i8*, i8* }* @_ZTI12stDescriptor to %"class.std::type_info"*))
  br i1 %call1, label %do.body, label %do.end

do.end:                                           ; preds = %do.cond
  %4 = load i32* %r, align 4
  ret i32 %4
}

declare i32 @strcmp(i8*, i8*) nounwind
