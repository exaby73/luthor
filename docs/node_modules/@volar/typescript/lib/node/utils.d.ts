import type { Language } from '@volar/language-core';
export declare function notEmpty<T>(value: T | null | undefined): value is T;
export declare function getServiceScript(language: Language, fileName: string): readonly [import("@volar/language-core").ServiceScript, import("@volar/language-core").SourceScript, import("@volar/language-core").SourceMap<import("@volar/language-core").CodeInformation>] | readonly [undefined, undefined, undefined];
