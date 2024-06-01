import { Language, CodeInformation, SourceMap, SourceScript } from '@volar/language-core';
import type * as ts from 'typescript';
export declare function transformCallHierarchyItem(language: Language, item: ts.CallHierarchyItem, filter: (data: CodeInformation) => boolean): ts.CallHierarchyItem;
export declare function transformDiagnostic<T extends ts.Diagnostic>(language: Language, diagnostic: T, isTsc: boolean): T | undefined;
export declare function fillSourceFileText(language: Language, sourceFile: ts.SourceFile): void;
export declare function transformFileTextChanges(language: Language, changes: ts.FileTextChanges, filter: (data: CodeInformation) => boolean): ts.FileTextChanges | undefined;
export declare function transformDocumentSpan<T extends ts.DocumentSpan>(language: Language, documentSpan: T, filter: (data: CodeInformation) => boolean, shouldFallback?: boolean): T | undefined;
export declare function transformSpan(language: Language, fileName: string | undefined, textSpan: ts.TextSpan | undefined, filter: (data: CodeInformation) => boolean): {
    fileName: string;
    textSpan: ts.TextSpan;
} | undefined;
export declare function transformTextChange(sourceScript: SourceScript, map: SourceMap<CodeInformation>, textChange: ts.TextChange, filter: (data: CodeInformation) => boolean): ts.TextChange | undefined;
export declare function transformTextSpan(sourceScript: SourceScript, map: SourceMap<CodeInformation>, textSpan: ts.TextSpan, filter: (data: CodeInformation) => boolean): ts.TextSpan | undefined;
export declare function toSourceOffset(sourceScript: SourceScript, map: SourceMap, position: number, filter: (data: CodeInformation) => boolean): number | undefined;
export declare function toGeneratedOffset(sourceScript: SourceScript, map: SourceMap, position: number, filter: (data: CodeInformation) => boolean): number | undefined;
export declare function toGeneratedOffsets(sourceScript: SourceScript, map: SourceMap<CodeInformation>, position: number): Generator<readonly [number, import("@volar/language-core").Mapping<CodeInformation>], void, unknown>;
