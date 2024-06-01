"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.register = void 0;
const references = require("./provideReferences");
const cancellation_1 = require("../utils/cancellation");
function register(context) {
    const findReferences = references.register(context);
    return async (item, token = cancellation_1.NoneCancellationToken) => {
        const data = item.data;
        if (data?.kind === 'normal') {
            const service = context.services[data.serviceIndex];
            if (!service[1].resolveCodeLens) {
                return item;
            }
            Object.assign(item, data.original);
            item = await service[1].resolveCodeLens(item, token);
            // item.range already transformed in codeLens request
        }
        if (data?.kind === 'references') {
            const references = await findReferences(data.sourceFileUri, item.range.start, { includeDeclaration: false }, token) ?? [];
            item.command = context.commands.showReferences.create(data.sourceFileUri, item.range.start, references);
        }
        return item;
    };
}
exports.register = register;
//# sourceMappingURL=resolveCodeLens.js.map