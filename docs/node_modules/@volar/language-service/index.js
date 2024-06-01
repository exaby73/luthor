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
var __exportStar = (this && this.__exportStar) || function(m, exports) {
    for (var p in m) if (p !== "default" && !Object.prototype.hasOwnProperty.call(exports, p)) __createBinding(exports, m, p);
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.standardSemanticTokensLegend = exports.mergeWorkspaceEdits = void 0;
__exportStar(require("@volar/language-core"), exports);
__exportStar(require("./lib/languageService"), exports);
__exportStar(require("./lib/documents"), exports);
var provideRenameEdits_1 = require("./lib/features/provideRenameEdits");
Object.defineProperty(exports, "mergeWorkspaceEdits", { enumerable: true, get: function () { return provideRenameEdits_1.mergeWorkspaceEdits; } });
__exportStar(require("./lib/types"), exports);
__exportStar(require("./lib/utils/transform"), exports);
// https://code.visualstudio.com/api/language-extensions/semantic-highlight-guide#standard-token-types-and-modifiers
exports.standardSemanticTokensLegend = {
    tokenTypes: [
        'namespace',
        'class',
        'enum',
        'interface',
        'struct',
        'typeParameter',
        'type',
        'parameter',
        'variable',
        'property',
        'enumMember',
        'decorator',
        'event',
        'function',
        'method',
        'macro',
        'label',
        'comment',
        'string',
        'keyword',
        'number',
        'regexp',
        'operator',
    ],
    tokenModifiers: [
        'declaration',
        'definition',
        'readonly',
        'static',
        'deprecated',
        'abstract',
        'async',
        'modification',
        'documentation',
        'defaultLibrary',
    ],
};
//# sourceMappingURL=index.js.map