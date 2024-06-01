import type * as vscode from 'vscode-languageserver-protocol';
import type { ServiceContext } from '../types';
export declare function register(context: ServiceContext): (uri: string, position: vscode.Position, newName: string, token?: vscode.CancellationToken) => Promise<vscode.WorkspaceEdit | undefined>;
export declare function mergeWorkspaceEdits(original: vscode.WorkspaceEdit, ...others: vscode.WorkspaceEdit[]): void;
