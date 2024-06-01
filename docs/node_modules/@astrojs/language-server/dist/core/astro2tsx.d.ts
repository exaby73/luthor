import type { ConvertToTSXOptions, TSXResult } from '@astrojs/compiler/types';
import type { VirtualCode } from '@volar/language-core';
import { Range } from '@volar/language-server';
import { HTMLDocument } from 'vscode-html-languageservice';
export interface LSPTSXRanges {
    frontmatter: Range;
    body: Range;
}
export declare function safeConvertToTSX(content: string, options: ConvertToTSXOptions): TSXResult | {
    code: string;
    map: {
        file: string;
        sources: never[];
        sourcesContent: never[];
        names: never[];
        mappings: string;
        version: number;
    };
    diagnostics: {
        code: 1000;
        location: {
            file: string;
            line: number;
            column: number;
            length: number;
        };
        severity: 1;
        text: string;
    }[];
    metaRanges: {
        frontmatter: {
            start: number;
            end: number;
        };
        body: {
            start: number;
            end: number;
        };
    };
};
export declare function getTSXRangesAsLSPRanges(tsx: TSXResult): LSPTSXRanges;
export declare function astro2tsx(input: string, fileName: string, htmlDocument: HTMLDocument): {
    virtualCode: VirtualCode;
    diagnostics: import("@astrojs/compiler").DiagnosticMessage[] | {
        code: 1000;
        location: {
            file: string;
            line: number;
            column: number;
            length: number;
        };
        severity: 1;
        text: string;
    }[];
    ranges: LSPTSXRanges;
};
