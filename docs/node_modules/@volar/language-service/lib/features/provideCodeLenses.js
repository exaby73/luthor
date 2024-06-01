"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.register = void 0;
const cancellation_1 = require("../utils/cancellation");
const common_1 = require("../utils/common");
const featureWorkers_1 = require("../utils/featureWorkers");
const language_core_1 = require("@volar/language-core");
function register(context) {
    return async (uri, token = cancellation_1.NoneCancellationToken) => {
        return await (0, featureWorkers_1.documentFeatureWorker)(context, uri, map => map.map.mappings.some(mapping => (0, language_core_1.isCodeLensEnabled)(mapping.data)), async (service, document) => {
            if (token.isCancellationRequested) {
                return;
            }
            let codeLens = await service[1].provideCodeLenses?.(document, token);
            const serviceIndex = context.services.indexOf(service);
            codeLens?.forEach(codeLens => {
                codeLens.data = {
                    kind: 'normal',
                    uri,
                    original: {
                        data: codeLens.data,
                    },
                    serviceIndex,
                };
            });
            const ranges = await service[1].provideReferencesCodeLensRanges?.(document, token);
            const referencesCodeLens = ranges?.map(range => ({
                range,
                data: {
                    kind: 'references',
                    sourceFileUri: uri,
                    workerFileUri: document.uri,
                    workerFileRange: range,
                    serviceIndex,
                },
            }));
            codeLens = [
                ...codeLens ?? [],
                ...referencesCodeLens ?? [],
            ];
            return codeLens;
        }, (data, map) => {
            if (!map) {
                return data;
            }
            return data
                .map(codeLens => {
                const range = map.getSourceRange(codeLens.range, language_core_1.isCodeLensEnabled);
                if (range) {
                    return {
                        ...codeLens,
                        range,
                    };
                }
            })
                .filter(common_1.notEmpty);
        }, arr => arr.flat()) ?? [];
    };
}
exports.register = register;
//# sourceMappingURL=provideCodeLenses.js.map