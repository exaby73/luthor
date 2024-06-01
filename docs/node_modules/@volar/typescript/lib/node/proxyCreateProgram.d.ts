import { LanguagePlugin } from '@volar/language-core';
import type * as ts from 'typescript';
export declare function proxyCreateProgram(ts: typeof import('typescript'), original: typeof ts['createProgram'], getLanguagePlugins: (ts: typeof import('typescript'), options: ts.CreateProgramOptions) => LanguagePlugin[]): typeof import("typescript").createProgram;
