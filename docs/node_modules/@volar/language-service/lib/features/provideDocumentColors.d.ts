import type * as vscode from 'vscode-languageserver-protocol';
import type { ServiceContext } from '../types';
export declare function register(context: ServiceContext): (uri: string, token?: vscode.CancellationToken) => Promise<vscode.ColorInformation[] | undefined>;
