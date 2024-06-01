import type * as vscode from 'vscode-languageserver-protocol';
import type { ServiceContext } from '../types';
export interface ServiceCodeLensData {
    kind: 'normal';
    uri: string;
    original: Pick<vscode.CodeLens, 'data'>;
    serviceIndex: number;
}
export interface ServiceReferencesCodeLensData {
    kind: 'references';
    sourceFileUri: string;
    workerFileUri: string;
    workerFileRange: vscode.Range;
    serviceIndex: number;
}
export declare function register(context: ServiceContext): (uri: string, token?: vscode.CancellationToken) => Promise<vscode.CodeLens[]>;
