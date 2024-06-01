import type { Diagnostic } from '@volar/language-server';
export declare enum DiagnosticCodes {
    IS_NOT_A_MODULE = 2306,
    CANNOT_FIND_MODULE = 2307,
    DUPLICATED_JSX_ATTRIBUTES = 17001,
    CANT_RETURN_OUTSIDE_FUNC = 1108,
    ISOLATED_MODULE_COMPILE_ERR = 1208,
    TYPE_NOT_ASSIGNABLE = 2322,
    JSX_NO_CLOSING_TAG = 17008,
    JSX_ELEMENT_NO_CALL = 2604
}
export declare function enhancedProvideSemanticDiagnostics(originalDiagnostics: Diagnostic[], tsxLineCount?: number | undefined): Diagnostic[];
