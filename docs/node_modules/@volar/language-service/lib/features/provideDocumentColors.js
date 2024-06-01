"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.register = void 0;
const language_core_1 = require("@volar/language-core");
const cancellation_1 = require("../utils/cancellation");
const common_1 = require("../utils/common");
const featureWorkers_1 = require("../utils/featureWorkers");
function register(context) {
    return (uri, token = cancellation_1.NoneCancellationToken) => {
        return (0, featureWorkers_1.documentFeatureWorker)(context, uri, map => map.map.mappings.some(mapping => (0, language_core_1.isColorEnabled)(mapping.data)), (service, document) => {
            if (token.isCancellationRequested) {
                return;
            }
            return service[1].provideDocumentColors?.(document, token);
        }, (data, map) => {
            if (!map) {
                return data;
            }
            return data
                .map(color => {
                const range = map.getSourceRange(color.range, language_core_1.isColorEnabled);
                if (range) {
                    return {
                        range,
                        color: color.color,
                    };
                }
            })
                .filter(common_1.notEmpty);
        }, arr => arr.flat());
    };
}
exports.register = register;
//# sourceMappingURL=provideDocumentColors.js.map