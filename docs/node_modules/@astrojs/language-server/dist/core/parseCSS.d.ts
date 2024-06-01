import type { ParseResult } from '@astrojs/compiler/types';
import { type VirtualCode } from '@volar/language-core';
import type ts from 'typescript';
import type { HTMLDocument } from 'vscode-html-languageservice';
export declare function extractStylesheets(snapshot: ts.IScriptSnapshot, htmlDocument: HTMLDocument, ast: ParseResult['ast']): VirtualCode[];
export declare function collectClassesAndIdsFromDocument(ast: ParseResult['ast']): string[];
