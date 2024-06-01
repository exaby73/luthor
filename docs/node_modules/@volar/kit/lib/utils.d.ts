/// <reference types="typesafe-path" />
import type * as path from 'typesafe-path/posix';
import type * as ts from 'typescript';
export declare const defaultCompilerOptions: ts.CompilerOptions;
export declare function asPosix(path: string): path.PosixPath;
export declare const uriToFileName: (uri: string) => string;
export declare const fileNameToUri: (fileName: string) => string;
