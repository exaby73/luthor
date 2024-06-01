export * from '@volar/language-core';
export * from './lib/languageService';
export * from './lib/documents';
export { mergeWorkspaceEdits } from './lib/features/provideRenameEdits';
export * from './lib/types';
export * from './lib/utils/transform';
import type * as vscode from 'vscode-languageserver-protocol';
export declare const standardSemanticTokensLegend: vscode.SemanticTokensLegend;
