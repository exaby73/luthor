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
            if (!service[1].resolveCodeAction) {
                return item;
            }
            Object.assign(item, data.original);
            item = await service[1].resolveCodeAction(item, token);
            item = service[1].transformCodeAction?.(item)
                ?? (item.edit
                    ? {
                        ...item,
                        edit: (0, transform_1.transformWorkspaceEdit)(item.edit, context, 'codeAction', { [data.uri]: data.version }),
                    }
                    : item);
        }
        return item;
    };
}
exports.register = register;
//# sourceMappingURL=resolveCodeAction.js.map