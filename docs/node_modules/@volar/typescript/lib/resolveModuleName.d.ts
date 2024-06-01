import type { LanguagePlugin, SourceScript } from '@volar/language-core';
import type * as ts from 'typescript';
export declare function createResolveModuleName(ts: typeof import('typescript'), host: ts.ModuleResolutionHost, languagePlugins: LanguagePlugin<any>[], getSourceScript: (fileName: string) => SourceScript | undefined): (moduleName: string, containingFile: string, compilerOptions: ts.CompilerOptions, cache?: ts.ModuleResolutionCache, redirectedReference?: ts.ResolvedProjectReference, resolutionMode?: ts.ResolutionMode) => ts.ResolvedModuleWithFailedLookupLocations;
