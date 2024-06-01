"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getWorkspacePnpPath = exports.getPrettierPluginPath = exports.importPrettier = exports.importVueIntegration = exports.importSvelteIntegration = exports.getPackagePath = exports.setIsTrusted = void 0;
const node_path_1 = require("node:path");
let isTrusted = true;
function setIsTrusted(_isTrusted) {
    isTrusted = _isTrusted;
}
exports.setIsTrusted = setIsTrusted;
/**
 * Get the path of a package's directory from the paths in `fromPath`, if `root` is set to false, it will return the path of the package's entry point
 */
function getPackagePath(packageName, fromPath, root = true) {
    const paths = [];
    if (isTrusted) {
        paths.unshift(...fromPath);
    }
    try {
        return root
            ? (0, node_path_1.dirname)(require.resolve(packageName + '/package.json', { paths }))
            : require.resolve(packageName, { paths });
    }
    catch (e) {
        return undefined;
    }
}
exports.getPackagePath = getPackagePath;
function importEditorIntegration(packageName, fromPath) {
    const pkgPath = getPackagePath(packageName, [fromPath]);
    if (pkgPath) {
        try {
            const main = (0, node_path_1.resolve)(pkgPath, 'dist', 'editor.cjs');
            return require(main);
        }
        catch (e) {
            console.error(`Couldn't load editor module from ${pkgPath}. Make sure you're using at least version v0.2.1 of the corresponding integration. Reason: ${e}`);
            return undefined;
        }
    }
    else {
        console.info(`Couldn't find package ${packageName} (searching from ${fromPath}). Make sure it's installed. If you believe this to be an error, please open an issue.`);
    }
    return undefined;
}
function importSvelteIntegration(fromPath) {
    return importEditorIntegration('@astrojs/svelte', fromPath);
}
exports.importSvelteIntegration = importSvelteIntegration;
function importVueIntegration(fromPath) {
    return importEditorIntegration('@astrojs/vue', fromPath);
}
exports.importVueIntegration = importVueIntegration;
function importPrettier(fromPath) {
    const prettierPkg = getPackagePath('prettier', [fromPath, __dirname]);
    if (!prettierPkg) {
        return undefined;
    }
    return require(prettierPkg);
}
exports.importPrettier = importPrettier;
function getPrettierPluginPath(fromPath) {
    const prettierPluginPath = getPackagePath('prettier-plugin-astro', [fromPath, __dirname], false);
    if (!prettierPluginPath) {
        return undefined;
    }
    return prettierPluginPath;
}
exports.getPrettierPluginPath = getPrettierPluginPath;
function getWorkspacePnpPath(workspacePath) {
    try {
        const possiblePath = (0, node_path_1.resolve)(workspacePath, '.pnp.cjs');
        require.resolve(possiblePath);
        return possiblePath;
    }
    catch {
        return null;
    }
}
exports.getWorkspacePnpPath = getWorkspacePnpPath;
//# sourceMappingURL=importPackage.js.map