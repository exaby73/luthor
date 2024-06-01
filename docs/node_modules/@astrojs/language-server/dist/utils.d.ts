export interface AstroInstall {
    path: string;
    version: {
        full: string;
        major: number;
        minor: number;
        patch: number;
    };
}
export declare function getLanguageServerTypesDir(ts: typeof import('typescript')): string;
export declare function getAstroInstall(basePaths: string[], checkForAstro?: {
    nearestPackageJson: string | undefined;
    readDirectory: typeof import('typescript').sys.readDirectory;
}): AstroInstall | 'not-an-astro-project' | 'not-found';
