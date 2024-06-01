import type * as vscode from 'vscode-languageserver-protocol';
import type { ServiceContext } from '../types';
export interface ServiceCodeActionData {
    uri: string;
    version: number;
    original: Pick<vscode.CodeAction, 'data' | 'edit'>;
    serviceIndex: number;
}
export declare function register(context: ServiceContext): (uri: string, range: vscode.Range, codeActionContext: vscode.CodeActionContext, token?: vscode.CancellationToken) => Promise<vscode.CodeAction[] | undefined>;
