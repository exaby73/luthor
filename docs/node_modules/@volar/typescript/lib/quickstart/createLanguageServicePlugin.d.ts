import type * as ts from 'typescript';
import { LanguagePlugin } from '@volar/language-core';
export declare function createLanguageServicePlugin(loadLanguagePlugins: (ts: typeof import('typescript'), info: ts.server.PluginCreateInfo) => LanguagePlugin[]): ts.server.PluginModuleFactory;
export declare function arrayItemsEqual(a: string[], b: string[]): boolean;
