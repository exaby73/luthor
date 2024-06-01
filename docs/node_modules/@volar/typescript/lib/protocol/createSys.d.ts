import type { ServiceEnvironment, Disposable } from '@volar/language-service';
import type * as ts from 'typescript';
export declare function createSys(ts: typeof import('typescript'), env: ServiceEnvironment, currentDirectory: string): ts.System & {
    version: number;
    sync(): Promise<number>;
} & Disposable;
