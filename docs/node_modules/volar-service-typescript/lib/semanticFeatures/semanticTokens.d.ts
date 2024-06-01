import type * as vscode from '@volar/language-service';
import type { TextDocument } from 'vscode-languageserver-textdocument';
import type { SharedContext } from './types';
export declare function register(ts: typeof import('typescript'), ctx: SharedContext): (document: TextDocument, range: vscode.Range, legend: vscode.SemanticTokensLegend) => [number, number, number, number, number][] | undefined;
//# sourceMappingURL=semanticTokens.d.ts.map