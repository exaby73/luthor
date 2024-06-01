import type { CodeInformation } from '@volar/language-core';
import type * as vscode from 'vscode-languageserver-protocol';
import type { ServiceContext } from '../types';
export declare function register(context: ServiceContext, apiName: 'provideDefinition' | 'provideTypeDefinition' | 'provideImplementation', isValidPosition: (data: CodeInformation) => boolean): (uri: string, position: vscode.Position, token?: vscode.CancellationToken) => Promise<vscode.LocationLink[] | undefined>;
