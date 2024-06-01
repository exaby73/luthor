"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.register = void 0;
const featureWorkers_1 = require("../utils/featureWorkers");
const cancellation_1 = require("../utils/cancellation");
const transform_1 = require("../utils/transform");
const language_core_1 = require("@volar/language-core");
function register(context) {
    return (uri, token = cancellation_1.NoneCancellationToken) => {
        return (0, featureWorkers_1.documentFeatureWorker)(context, uri, map => map.map.mappings.some(mapping => (0, language_core_1.isFoldingRangesEnabled)(mapping.data)), (service, document) => {
            if (token.isCancellationRequested) {
                return;
            }
            return service[1].provideFoldingRanges?.(document, token);
        }, (data, map) => {
            if (!map) {
                return data;
            }
            return (0, transform_1.transformFoldingRanges)(data, range => map.getSourceRange(range, language_core_1.isFoldingRangesEnabled));
        }, arr => arr.flat());
    };
}
exports.register = register;
//# sourceMappingURL=provideFoldingRanges.js.map