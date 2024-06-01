import type { ParseResult } from '@astrojs/compiler/types';
import { type VirtualCode } from '@volar/language-core';
import type ts from 'typescript';
import type { HTMLDocument } from 'vscode-html-languageservice';
export declare function extractScriptTags(snapshot: ts.IScriptSnapshot, htmlDocument: HTMLDocument, ast: ParseResult['ast']): VirtualCode[];
