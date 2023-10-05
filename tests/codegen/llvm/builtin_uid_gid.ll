; ModuleID = 'bpftrace'
source_filename = "bpftrace"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf-pc-linux"

%"struct map_t" = type { i8*, i8*, i8*, i8* }
%"struct map_t.0" = type { i8*, i8*, i8*, i8* }

@AT_x = dso_local global %"struct map_t" zeroinitializer, section ".maps", !dbg !0
@AT_y = dso_local global %"struct map_t.0" zeroinitializer, section ".maps", !dbg !20

; Function Attrs: nounwind
declare i64 @llvm.bpf.pseudo(i64 %0, i64 %1) #0

define i64 @"kprobe:f"(i8* %0) section "s_kprobe:f_1" !dbg !26 {
entry:
  %"@y_val" = alloca i64, align 8
  %"@y_key" = alloca i64, align 8
  %"@x_val" = alloca i64, align 8
  %"@x_key" = alloca i64, align 8
  %get_uid_gid = call i64 inttoptr (i64 15 to i64 ()*)()
  %1 = and i64 %get_uid_gid, 4294967295
  %2 = bitcast i64* %"@x_key" to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %2)
  store i64 0, i64* %"@x_key", align 8
  %3 = bitcast i64* %"@x_val" to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %3)
  store i64 %1, i64* %"@x_val", align 8
  %pseudo = call i64 @llvm.bpf.pseudo(i64 1, i64 0)
  %update_elem = call i64 inttoptr (i64 2 to i64 (i64, i64*, i64*, i64)*)(i64 %pseudo, i64* %"@x_key", i64* %"@x_val", i64 0)
  %4 = bitcast i64* %"@x_val" to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %4)
  %5 = bitcast i64* %"@x_key" to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %5)
  %get_uid_gid1 = call i64 inttoptr (i64 15 to i64 ()*)()
  %6 = lshr i64 %get_uid_gid1, 32
  %7 = bitcast i64* %"@y_key" to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %7)
  store i64 0, i64* %"@y_key", align 8
  %8 = bitcast i64* %"@y_val" to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %8)
  store i64 %6, i64* %"@y_val", align 8
  %pseudo2 = call i64 @llvm.bpf.pseudo(i64 1, i64 1)
  %update_elem3 = call i64 inttoptr (i64 2 to i64 (i64, i64*, i64*, i64)*)(i64 %pseudo2, i64* %"@y_key", i64* %"@y_val", i64 0)
  %9 = bitcast i64* %"@y_val" to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %9)
  %10 = bitcast i64* %"@y_key" to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %10)
  ret i64 0
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg %0, i8* nocapture %1) #1

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg %0, i8* nocapture %1) #1

attributes #0 = { nounwind }
attributes #1 = { argmemonly nofree nosync nounwind willreturn }

!llvm.dbg.cu = !{!22}
!llvm.module.flags = !{!25}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "AT_x", linkageName: "global", scope: !2, file: !2, type: !3, isLocal: false, isDefinition: true)
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
!19 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !2, file: !2, baseType: !17, size: 64, offset: 192)
!20 = !DIGlobalVariableExpression(var: !21, expr: !DIExpression())
!21 = distinct !DIGlobalVariable(name: "AT_y", linkageName: "global", scope: !2, file: !2, type: !3, isLocal: false, isDefinition: true)
!22 = distinct !DICompileUnit(language: DW_LANG_C, file: !2, producer: "bpftrace", isOptimized: false, runtimeVersion: 0, emissionKind: LineTablesOnly, enums: !23, globals: !24)
!23 = !{}
!24 = !{!0, !20}
!25 = !{i32 2, !"Debug Info Version", i32 3}
!26 = distinct !DISubprogram(name: "kprobe_f", linkageName: "kprobe_f", scope: !2, file: !2, type: !27, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !22, retainedNodes: !31)
!27 = !DISubroutineType(types: !28)
!28 = !{!18, !29}
!29 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !30, size: 64)
!30 = !DIBasicType(name: "int8", size: 8, encoding: DW_ATE_signed)
!31 = !{!32, !33}
!32 = !DILocalVariable(name: "var0", scope: !26, file: !2, type: !18)
!33 = !DILocalVariable(name: "var1", arg: 1, scope: !26, file: !2, type: !29)
