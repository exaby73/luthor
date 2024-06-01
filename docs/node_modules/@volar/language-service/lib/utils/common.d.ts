import type * as ts from 'typescript';
import type * as vscode from 'vscode-languageserver-protocol';
import type { CodeInformation, SourceMap } from '@volar/language-core';
export declare function findOverlapCodeRange(start: number, end: number, map: SourceMap<CodeInformation>, filter: (data: CodeInformation) => boolean): {
    start: number;
    end: number;
} | undefined;
export declare function isInsideRange(parent: vscode.Range, child: vscode.Range): boolean;
export declare function isEqualRange(a: vscode.Range, b: vscode.Range): boolean;
export declare function stringToSnapshot(str: string): ts.IScriptSnapshot;
export declare function sleep(ms: number): Promise<unknown>;
export declare function notEmpty<T>(value: T | null | undefined): value is T;
