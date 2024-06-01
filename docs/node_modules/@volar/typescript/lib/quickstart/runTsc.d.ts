import type * as ts from 'typescript';
import type { LanguagePlugin } from '@volar/language-core';
export declare let getLanguagePlugins: (ts: typeof import('typescript'), options: ts.CreateProgramOptions) => LanguagePlugin[];
export declare function runTsc(tscPath: string, extensions: string[], _getLanguagePlugins: typeof getLanguagePlugins): void;
