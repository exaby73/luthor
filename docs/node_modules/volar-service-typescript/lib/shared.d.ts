import type { TextDocument } from 'vscode-languageserver-textdocument';
export declare function getConfigTitle(document: TextDocument): string;
export declare function isTsDocument(document: TextDocument): boolean;
export declare function isJsonDocument(document: TextDocument): boolean;
export declare function safeCall<T>(cb: () => T): T | undefined;
export declare function notEmpty(value: any): value is NonNullable<typeof value>;
//# sourceMappingURL=shared.d.ts.map