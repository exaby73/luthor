import type { CodeAction, ServiceContext } from '@volar/language-service';
export declare function enhancedProvideCodeActions(codeActions: CodeAction[], context: ServiceContext): CodeAction[];
export declare function enhancedResolveCodeAction(codeAction: CodeAction, context: ServiceContext): CodeAction;
