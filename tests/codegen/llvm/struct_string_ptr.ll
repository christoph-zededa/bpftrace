; ModuleID = 'bpftrace'
source_filename = "bpftrace"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf-pc-linux"

%"struct map_t" = type { i8*, i8*, i8*, i8* }

@AT_mystr = dso_local global %"struct map_t" zeroinitializer, section ".maps", !dbg !0

; Function Attrs: nounwind
declare i64 @llvm.bpf.pseudo(i64 %0, i64 %1) #0

define i64 @"kprobe:f"(i8* %0) section "s_kprobe:f_1" !dbg !29 {
entry:
  %"@mystr_key" = alloca i64, align 8
  %"struct Foo.str" = alloca i64, align 8
  %str = alloca [64 x i8], align 1
  %strlen = alloca i64, align 8
  %"$foo" = alloca i64, align 8
  %1 = bitcast i64* %"$foo" to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %1)
  store i64 0, i64* %"$foo", align 8
  %2 = bitcast i8* %0 to i64*
  %3 = getelementptr i64, i64* %2, i64 14
  %arg0 = load volatile i64, i64* %3, align 8
  store i64 %arg0, i64* %"$foo", align 8
  %4 = bitcast i64* %strlen to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %4)
  %5 = bitcast i64* %strlen to i8*
  call void @llvm.memset.p0i8.i64(i8* align 1 %5, i8 0, i64 8, i1 false)
  store i64 64, i64* %strlen, align 8
  %6 = bitcast [64 x i8]* %str to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %6)
  %7 = bitcast [64 x i8]* %str to i8*
  call void @llvm.memset.p0i8.i64(i8* align 1 %7, i8 0, i64 64, i1 false)
  %8 = load i64, i64* %"$foo", align 8
  %9 = add i64 %8, 0
  %10 = bitcast i64* %"struct Foo.str" to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %10)
  %probe_read_kernel = call i64 inttoptr (i64 113 to i64 (i64*, i32, i64)*)(i64* %"struct Foo.str", i32 8, i64 %9)
  %11 = load i64, i64* %"struct Foo.str", align 8
  %12 = bitcast i64* %"struct Foo.str" to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %12)
  %13 = load i64, i64* %strlen, align 8
  %14 = trunc i64 %13 to i32
  %probe_read_kernel_str = call i64 inttoptr (i64 115 to i64 ([64 x i8]*, i32, i64)*)([64 x i8]* %str, i32 %14, i64 %11)
  %15 = bitcast i64* %strlen to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %15)
  %16 = bitcast i64* %"@mystr_key" to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %16)
  store i64 0, i64* %"@mystr_key", align 8
  %pseudo = call i64 @llvm.bpf.pseudo(i64 1, i64 0)
  %update_elem = call i64 inttoptr (i64 2 to i64 (i64, i64*, [64 x i8]*, i64)*)(i64 %pseudo, i64* %"@mystr_key", [64 x i8]* %str, i64 0)
  %17 = bitcast i64* %"@mystr_key" to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %17)
  %18 = bitcast [64 x i8]* %str to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %18)
  ret i64 0
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg %0, i8* nocapture %1) #1

; Function Attrs: argmemonly nofree nosync nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly %0, i8 %1, i64 %2, i1 immarg %3) #2

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg %0, i8* nocapture %1) #1

attributes #0 = { nounwind }
attributes #1 = { argmemonly nofree nosync nounwind willreturn }
attributes #2 = { argmemonly nofree nosync nounwind willreturn writeonly }

!llvm.dbg.cu = !{!25}
!llvm.module.flags = !{!28}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "AT_mystr", linkageName: "global", scope: !2, file: !2, type: !3, isLocal: false, isDefinition: true)
!2 = !DIFile(filename: "bpftrace.bpf.o", directory: ".")
!3 = !DICompositeType(tag: DW_TAG_structure_type, scope: !2, file: !2, size: 256, elements: !4)
!4 = !{!5, !11, !16, !19}
!5 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !2, file: !2, baseType: !6, size: 64)
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = !DICompositeType(tag: DW_TAG_array_type, baseType: !8, size: 32, elements: !9)
!8 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!9 = !{!10}
!10 = !DISubrange(count: 1, lowerBound: 0)
!11 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !2, file: !2, baseType: !12, size: 64, offset: 64)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DICompositeType(tag: DW_TAG_array_type, baseType: !8, size: 131072, elements: !14)
!14 = !{!15}
!15 = !DISubrange(count: 4096, lowerBound: 0)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !2, file: !2, baseType: !17, size: 64, offset: 128)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 64)
!18 = !DIBasicType(name: "int64", size: 64, encoding: DW_ATE_signed)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !2, file: !2, baseType: !20, size: 64, offset: 192)
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !21, size: 64)
!21 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, size: 512, elements: !23)
!22 = !DIBasicType(name: "int8", size: 8, encoding: DW_ATE_signed)
!23 = !{!24}
!24 = !DISubrange(count: 64, lowerBound: 0)
!25 = distinct !DICompileUnit(language: DW_LANG_C, file: !2, producer: "bpftrace", isOptimized: false, runtimeVersion: 0, emissionKind: LineTablesOnly, enums: !26, globals: !27)
!26 = !{}
!27 = !{!0}
!28 = !{i32 2, !"Debug Info Version", i32 3}
!29 = distinct !DISubprogram(name: "kprobe_f", linkageName: "kprobe_f", scope: !2, file: !2, type: !30, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !25, retainedNodes: !33)
!30 = !DISubroutineType(types: !31)
!31 = !{!18, !32}
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!33 = !{!34, !35}
!34 = !DILocalVariable(name: "var0", scope: !29, file: !2, type: !18)
!35 = !DILocalVariable(name: "var1", arg: 1, scope: !29, file: !2, type: !32)
