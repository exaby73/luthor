"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.register = void 0;
const featureWorkers_1 = require("../utils/featureWorkers");
const cancellation_1 = require("../utils/cancellation");
const transform_1 = require("../utils/transform");
function register(context) {
    return (uri, position, dataTransfer, token = cancellation_1.NoneCancellationToken) => {
        return (0, featureWorkers_1.languageFeatureWorker)(context, uri, () => position, function* (map) {
            for (const mappedPosition of map.getGeneratedPositions(position)) {
                yield mappedPosition;
            }
        }, (service, document, arg) => {
            if (token.isCancellationRequested) {
                return;
            }
            return service[1].provideDocumentDropEdits?.(document, arg, dataTransfer, token);
        }, edit => {
            if (edit.additionalEdit) {
                edit.additionalEdit = (0, transform_1.transformWorkspaceEdit)(edit.additionalEdit, context, undefined);
            }
            return edit;
        });
    };
}
exports.register = register;
//# sourceMappingURL=provideDocumentDropEdits.js.map