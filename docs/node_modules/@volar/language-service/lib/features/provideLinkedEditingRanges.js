"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.register = void 0;
const featureWorkers_1 = require("../utils/featureWorkers");
const common_1 = require("../utils/common");
const cancellation_1 = require("../utils/cancellation");
const language_core_1 = require("@volar/language-core");
function register(context) {
    return (uri, position, token = cancellation_1.NoneCancellationToken) => {
        return (0, featureWorkers_1.languageFeatureWorker)(context, uri, () => position, function* (map) {
            for (const pos of map.getGeneratedPositions(position, language_core_1.isLinkedEditingEnabled)) {
                yield pos;
            }
        }, (service, document, position) => {
            if (token.isCancellationRequested) {
                return;
            }
            return service[1].provideLinkedEditingRanges?.(document, position, token);
        }, (ranges, map) => {
            if (!map) {
                return ranges;
            }
            return {
                wordPattern: ranges.wordPattern,
                ranges: ranges.ranges
                    .map(range => map.getSourceRange(range, language_core_1.isLinkedEditingEnabled))
                    .filter(common_1.notEmpty),
            };
        });
    };
}
exports.register = register;
//# sourceMappingURL=provideLinkedEditingRanges.js.map