"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.register = void 0;
const featureWorkers_1 = require("../utils/featureWorkers");
const common_1 = require("../utils/common");
const cancellation_1 = require("../utils/cancellation");
const transform_1 = require("../utils/transform");
const language_core_1 = require("@volar/language-core");
function register(context) {
    return (uri, token = cancellation_1.NoneCancellationToken) => {
        return (0, featureWorkers_1.documentFeatureWorker)(context, uri, map => map.map.mappings.some(mapping => (0, language_core_1.isSymbolsEnabled)(mapping.data)), async (service, document) => {
            if (token.isCancellationRequested) {
                return;
            }
            return service[1].provideDocumentSymbols?.(document, token);
        }, (data, map) => {
            if (!map) {
                return data;
            }
            return data
                .map(symbol => (0, transform_1.transformDocumentSymbol)(symbol, range => map.getSourceRange(range, language_core_1.isSymbolsEnabled)))
                .filter(common_1.notEmpty);
        }, results => {
            for (let i = 0; i < results.length; i++) {
                for (let j = 0; j < results.length; j++) {
                    if (i === j) {
                        continue;
                    }
                    results[i] = results[i].filter(child => {
                        for (const parent of results[j]) {
                            if ((0, common_1.isInsideRange)(parent.range, child.range)) {
                                parent.children ??= [];
                                parent.children.push(child);
                                return false;
                            }
                        }
                        return true;
                    });
                }
            }
            return results.flat();
        });
    };
}
exports.register = register;
//# sourceMappingURL=provideDocumentSymbols.js.map