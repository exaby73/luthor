import type * as svelte from '@astrojs/svelte/dist/editor.cjs';
import type * as vue from '@astrojs/vue/dist/editor.cjs';
import type * as prettier from 'prettier';
export declare function setIsTrusted(_isTrusted: boolean): void;
/**
 * Get the path of a package's directory from the paths in `fromPath`, if `root` is set to false, it will return the path of the package's entry point
 */
export declare function getPackagePath(packageName: string, fromPath: string[], root?: boolean): string | undefined;
export declare function importSvelteIntegration(fromPath: string): typeof svelte | undefined;
export declare function importVueIntegration(fromPath: string): typeof vue | undefined;
export declare function importPrettier(fromPath: string): typeof prettier | undefined;
export declare function getPrettierPluginPath(fromPath: string): string | undefined;
export declare function getWorkspacePnpPath(workspacePath: string): string | null;
