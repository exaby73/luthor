"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.PointToPosition = void 0;
const language_server_1 = require("@volar/language-server");
/**
 * Transform a Point from the Astro compiler to an LSP Position
 */
function PointToPosition(point) {
    // Columns and lines are 0-based in LSP, but the compiler's Point are 1 based.
    return language_server_1.Position.create(point.line - 1, point.column - 1);
}
exports.PointToPosition = PointToPosition;
//# sourceMappingURL=compilerUtils.js.map