export declare const formContentTypes: string[];
export declare function hasContentType(contentType: string, expected: string[]): boolean;
export type MaybePromise<T> = T | Promise<T>;
/**
 * Get server-side action based on the route path.
 * Imports from `import.meta.env.ACTIONS_PATH`, which maps to
 * the user's `src/actions/index.ts` file at build-time.
 */
export declare function getAction(path: string): Promise<((param: unknown) => MaybePromise<unknown>) | undefined>;
