"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.getAstroInstall = exports.getLanguageServerTypesDir = void 0;
const path = __importStar(require("node:path"));
const importPackage_js_1 = require("./importPackage.js");
function getLanguageServerTypesDir(ts) {
    return ts.sys.resolvePath(path.resolve(__dirname, '../types'));
}
exports.getLanguageServerTypesDir = getLanguageServerTypesDir;
function getAstroInstall(basePaths, checkForAstro) {
    let astroPath;
    let version;
    if (checkForAstro && checkForAstro.nearestPackageJson) {
        basePaths.push(path.dirname(checkForAstro.nearestPackageJson));
        let deps = new Set();
        try {
            const packageJSON = require(checkForAstro.nearestPackageJson);
            [
                ...Object.keys(packageJSON.dependencies ?? {}),
                ...Object.keys(packageJSON.devDependencies ?? {}),
                ...Object.keys(packageJSON.peerDependencies ?? {}),
            ].forEach((dep) => deps.add(dep));
        }
        catch { }
        if (!deps.has('astro')) {
            const directoryContent = checkForAstro.readDirectory(path.dirname(checkForAstro.nearestPackageJson), ['.js', '.mjs', '.cjs', '.ts', '.mts', '.cts'], undefined, undefined, 1);
            if (!directoryContent.some((file) => path.basename(file).startsWith('astro.config'))) {
                return 'not-an-astro-project';
            }
        }
    }
    try {
        astroPath = (0, importPackage_js_1.getPackagePath)('astro', basePaths);
        if (!astroPath) {
            throw Error;
        }
        version = require(path.resolve(astroPath, 'package.json')).version;
    }
    catch {
        // If we couldn't find it inside the workspace's node_modules, it might means we're in the monorepo
        try {
            astroPath = (0, importPackage_js_1.getPackagePath)('./packages/astro', basePaths);
            if (!astroPath) {
                throw Error;
            }
            version = require(path.resolve(astroPath, 'package.json')).version;
        }
        catch (e) {
            // If we still couldn't find it, it probably just doesn't exist
            console.error(`${basePaths[0]} seems to be an Astro project, but we couldn't find Astro or Astro is not installed`);
            return 'not-found';
        }
    }
    if (!version) {
        return 'not-found';
    }
    let [major, minor, patch] = version.split('.');
    if (patch.includes('-')) {
        const patchParts = patch.split('-');
        patch = patchParts[0];
    }
    return {
        path: astroPath,
        version: {
            full: version,
            major: Number(major),
            minor: Number(minor),
            patch: Number(patch),
        },
    };
}
exports.getAstroInstall = getAstroInstall;
//# sourceMappingURL=utils.js.map