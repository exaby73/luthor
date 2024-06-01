"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.register = void 0;
const transform_1 = require("../utils/transform");
const dedupe = require("../utils/dedupe");
const cancellation_1 = require("../utils/cancellation");
function register(context) {
    return async (oldUri, newUri, token = cancellation_1.NoneCancellationToken) => {
        for (const service of context.services) {
            if (context.disabledServicePlugins.has(service[1])) {
                continue;
            }
            if (token.isCancellationRequested) {
                break;
            }
            if (!service[1].provideFileRenameEdits) {
                continue;
            }
            const workspaceEdit = await service[1].provideFileRenameEdits(oldUri, newUri, token);
            if (workspaceEdit) {
                const result = (0, transform_1.transformWorkspaceEdit)(workspaceEdit, context, 'fileName');
                if (result?.documentChanges) {
                    result.documentChanges = dedupe.withDocumentChanges(result.documentChanges);
                }
                return result;
            }
        }
    };
}
exports.register = register;
//# sourceMappingURL=provideFileRenameEdits.js.map