"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.fileNameToUri = exports.uriToFileName = exports.asPosix = exports.defaultCompilerOptions = void 0;
const vscode_uri_1 = require("vscode-uri");
require("fs");
exports.defaultCompilerOptions = {
    allowJs: true,
    allowSyntheticDefaultImports: true,
    allowNonTsExtensions: true,
    resolveJsonModule: true,
    jsx: 1,
};
function asPosix(path) {
    return path.replace(/\\/g, '/');
}
exports.asPosix = asPosix;
const uriToFileName = (uri) => vscode_uri_1.URI.parse(uri).fsPath.replace(/\\/g, '/');
exports.uriToFileName = uriToFileName;
const fileNameToUri = (fileName) => vscode_uri_1.URI.file(fileName).toString();
exports.fileNameToUri = fileNameToUri;
//# sourceMappingURL=utils.js.map