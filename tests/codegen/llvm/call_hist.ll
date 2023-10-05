; ModuleID = 'bpftrace'
source_filename = "bpftrace"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf-pc-linux"

%"struct map_t" = type { i8*, i8*, i8*, i8* }

@AT_x = dso_local global %"struct map_t" zeroinitializer, section ".maps", !dbg !0

; Function Attrs: nounwind
declare i64 @llvm.bpf.pseudo(i64 %0, i64 %1) #0

define i64 @"kprobe:f"(i8* %0) section "s_kprobe:f_1" !dbg !24 {
entry:
  %initial_value = alloca i64, align 8
  %lookup_elem_val = alloca i64, align 8
  %"@x_key" = alloca i64, align 8
  %get_pid_tgid = call i64 inttoptr (i64 14 to i64 ()*)()
  %1 = lshr i64 %get_pid_tgid, 32
  %log2 = call i64 @log2(i64 %1, i64 0)
  %2 = bitcast i64* %"@x_key" to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %2)
  store i64 %log2, i64* %"@x_key", align 8
  %pseudo = call i64 @llvm.bpf.pseudo(i64 1, i64 0)
  %lookup_elem = call i8* inttoptr (i64 1 to i8* (i64, i64*)*)(i64 %pseudo, i64* %"@x_key")
  %3 = bitcast i64* %lookup_elem_val to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %3)
  %map_lookup_cond = icmp ne i8* %lookup_elem, null
  br i1 %map_lookup_cond, label %lookup_success, label %lookup_failure

lookup_success:                                   ; preds = %entry
  %cast = bitcast i8* %lookup_elem to i64*
  %4 = load i64, i64* %cast, align 8
  %5 = add i64 %4, 1
  store i64 %5, i64* %cast, align 8
  br label %lookup_merge

lookup_failure:                                   ; preds = %entry
  %6 = bitcast i64* %initial_value to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %6)
  store i64 1, i64* %initial_value, align 8
  %pseudo1 = call i64 @llvm.bpf.pseudo(i64 1, i64 0)
  %update_elem = call i64 inttoptr (i64 2 to i64 (i64, i64*, i64*, i64)*)(i64 %pseudo1, i64* %"@x_key", i64* %initial_value, i64 1)
  %7 = bitcast i64* %initial_value to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %7)
  br label %lookup_merge

lookup_merge:                                     ; preds = %lookup_failure, %lookup_success
  %8 = bitcast i64* %lookup_elem_val to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %8)
  %9 = bitcast i64* %"@x_key" to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %9)
  ret i64 0
}

; Function Attrs: alwaysinline
define internal i64 @log2(i64 %0, i64 %1) #1 section "helpers" {
entry:
  %2 = alloca i64, align 8
  %3 = alloca i64, align 8
  %4 = bitcast i64* %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %4)
  store i64 %0, i64* %3, align 8
  %5 = bitcast i64* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %5)
  store i64 %1, i64* %2, align 8
  %6 = load i64, i64* %3, align 8
  %7 = icmp slt i64 %6, 0
  br i1 %7, label %hist.is_less_than_zero, label %hist.is_not_less_than_zero

hist.is_less_than_zero:                           ; preds = %entry
  ret i64 0

hist.is_not_less_than_zero:                       ; preds = %entry
  %8 = load i64, i64* %2, align 8
  %9 = shl i64 1, %8
  %10 = sub i64 %9, 1
  %11 = icmp ule i64 %6, %10
  br i1 %11, label %hist.is_zero, label %hist.is_not_zero

hist.is_zero:                                     ; preds = %hist.is_not_less_than_zero
  %12 = add i64 %6, 1
  ret i64 %12

hist.is_not_zero:                                 ; preds = %hist.is_not_less_than_zero
  %13 = icmp sge i64 %6, 4294967296
  %14 = zext i1 %13 to i64
  %15 = shl i64 %14, 5
  %16 = lshr i64 %6, %15
  %17 = add i64 0, %15
  %18 = icmp sge i64 %16, 65536
  %19 = zext i1 %18 to i64
  %20 = shl i64 %19, 4
  %21 = lshr i64 %16, %20
  %22 = add i64 %17, %20
  %23 = icmp sge i64 %21, 256
  %24 = zext i1 %23 to i64
  %25 = shl i64 %24, 3
  %26 = lshr i64 %21, %25
  %27 = add i64 %22, %25
  %28 = icmp sge i64 %26, 16
  %29 = zext i1 %28 to i64
  %30 = shl i64 %29, 2
  %31 = lshr i64 %26, %30
  %32 = add i64 %27, %30
  %33 = icmp sge i64 %31, 4
  %34 = zext i1 %33 to i64
  %35 = shl i64 %34, 1
  %36 = lshr i64 %31, %35
  %37 = add i64 %32, %35
  %38 = icmp sge i64 %36, 2
  %39 = zext i1 %38 to i64
  %40 = shl i64 %39, 0
  %41 = lshr i64 %36, %40
  %42 = add i64 %37, %40
  %43 = sub i64 %42, %8
  %44 = load i64, i64* %3, align 8
  %45 = lshr i64 %44, %43
  %46 = and i64 %45, %10
  %47 = add i64 %43, 1
  %48 = shl i64 %47, %8
  %49 = add i64 %48, %46
  %50 = add i64 %49, 1
  ret i64 %50
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg %0, i8* nocapture %1) #2

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg %0, i8* nocapture %1) #2

attributes #0 = { nounwind }
attributes #1 = { alwaysinline }
attributes #2 = { argmemonly nofree nosync nounwind willreturn }

!llvm.dbg.cu = !{!20}
!llvm.module.flags = !{!23}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "AT_x", linkageName: "global", scope: !2, file: !2, type: !3, isLocal: false, isDefinition: true)
!2 = !DIFile(filename: "bpftrace.bpf.o", directory: ".")
!3 = !DICompositeType(tag: DW_TAG_structure_type, scope: !2, file: !2, size: 256, elements: !4)
!4 = !{!5, !11, !16, !19}
!5 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !2, file: !2, baseType: !6, size: 64)
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = !DICompositeType(tag: DW_TAG_array_type, baseType: !8, size: 160, elements: !9)
!8 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!9 = !{!10}
!10 = !DISubrange(count: 5, lowerBound: 0)
!11 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !2, file: !2, baseType: !12, size: 64, offset: 64)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DICompositeType(tag: DW_TAG_array_type, baseType: !8, size: 131072, elements: !14)
!14 = !{!15}
!15 = !DISubrange(count: 4096, lowerBound: 0)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !2, file: !2, baseType: !17, size: 64, offset: 128)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 64)
!18 = !DIBasicType(name: "int64", size: 64, encoding: DW_ATE_signed)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !2, file: !2, baseType: !17, size: 64, offset: 192)
!20 = distinct !DICompileUnit(language: DW_LANG_C, file: !2, producer: "bpftrace", isOptimized: false, runtimeVersion: 0, emissionKind: LineTablesOnly, enums: !21, globals: !22)
!21 = !{}
!22 = !{!0}
!23 = !{i32 2, !"Debug Info Version", i32 3}
!24 = distinct !DISubprogram(name: "kprobe_f", linkageName: "kprobe_f", scope: !2, file: !2, type: !25, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !20, retainedNodes: !29)
!25 = !DISubroutineType(types: !26)
!26 = !{!18, !27}
!27 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 64)
!28 = !DIBasicType(name: "int8", size: 8, encoding: DW_ATE_signed)
!29 = !{!30, !31}
!30 = !DILocalVariable(name: "var0", scope: !24, file: !2, type: !18)
!31 = !DILocalVariable(name: "var1", arg: 1, scope: !24, file: !2, type: !27)
