"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.register = void 0;
const cancellation_1 = require("../utils/cancellation");
const transform_1 = require("../utils/transform");
function register(context) {
    return async (item, token = cancellation_1.NoneCancellationToken) => {
        const data = item.data;
        if (data) {
            const service = context.services[data.serviceIndex];
            if (!service[1].resolveDocumentLink) {
                return item;
            }
            Object.assign(item, data.original);
            item = await service[1].resolveDocumentLink(item, token);
            if (item.target) {
                item.target = (0, transform_1.transformDocumentLinkTarget)(item.target, context);
            }
        }
        return item;
    };
}
exports.register = register;
//# sourceMappingURL=resolveDocumentLink.js.map