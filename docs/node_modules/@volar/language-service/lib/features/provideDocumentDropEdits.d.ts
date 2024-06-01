import type * as vscode from 'vscode-languageserver-protocol';
import type { ServiceContext, DataTransferItem } from '../types';
export declare function register(context: ServiceContext): (uri: string, position: vscode.Position, dataTransfer: Map<string, DataTransferItem>, token?: vscode.CancellationToken) => Promise<import("../types").DocumentDropEdit | undefined>;
