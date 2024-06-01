import { CompletionItem, CompletionList, ServiceContext } from '@volar/language-server';
export declare function enhancedProvideCompletionItems(completions: CompletionList): CompletionList;
export declare function enhancedResolveCompletionItem(resolvedCompletion: CompletionItem, context: ServiceContext): CompletionItem;
