import type * as vscode from 'vscode-languageserver-protocol';
import type { ServiceContext } from '../types';
export declare function register(context: ServiceContext): (uri: string, position: vscode.Position, referenceContext: vscode.ReferenceContext, token?: vscode.CancellationToken) => Promise<vscode.Location[] | undefined>;
