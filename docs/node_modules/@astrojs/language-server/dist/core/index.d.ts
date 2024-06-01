import type { DiagnosticMessage } from '@astrojs/compiler/types';
import { type CodeMapping, type LanguagePlugin, type VirtualCode } from '@volar/language-core';
import type ts from 'typescript';
import type { HTMLDocument } from 'vscode-html-languageservice';
import { type AstroInstall } from '../utils.js';
import { AstroMetadata } from './parseAstro';
export declare function getLanguageModule(astroInstall: AstroInstall | undefined, ts: typeof import('typescript')): LanguagePlugin<AstroVirtualCode>;
export declare class AstroVirtualCode implements VirtualCode {
    fileName: string;
    snapshot: ts.IScriptSnapshot;
    id: string;
    languageId: string;
    mappings: CodeMapping[];
    embeddedCodes: VirtualCode[];
    astroMeta: AstroMetadata;
    compilerDiagnostics: DiagnosticMessage[];
    htmlDocument: HTMLDocument;
    scriptCodeIds: string[];
    codegenStacks: never[];
    constructor(fileName: string, snapshot: ts.IScriptSnapshot);
    get hasCompilationErrors(): boolean;
    update(newSnapshot: ts.IScriptSnapshot): void;
    onSnapshotUpdated(): void;
}
