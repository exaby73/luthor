import type * as ts from 'typescript';
import { LanguagePlugin } from '@volar/language-core';
export declare function createAsyncLanguageServicePlugin(extensions: string[], scriptKind: ts.ScriptKind, loadLanguagePlugins: (ts: typeof import('typescript'), info: ts.server.PluginCreateInfo) => Promise<LanguagePlugin[]>): ts.server.PluginModuleFactory;
