"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.register = void 0;
const cancellation_1 = require("../utils/cancellation");
const common_1 = require("../utils/common");
const featureWorkers_1 = require("../utils/featureWorkers");
const transform_1 = require("../utils/transform");
const language_core_1 = require("@volar/language-core");
function register(context) {
    return async (uri, token = cancellation_1.NoneCancellationToken) => {
        return await (0, featureWorkers_1.documentFeatureWorker)(context, uri, map => map.map.mappings.some(mapping => (0, language_core_1.isDocumentLinkEnabled)(mapping.data)), async (service, document) => {
            if (token.isCancellationRequested) {
                return;
            }
            const links = await service[1].provideDocumentLinks?.(document, token);
            for (const link of links ?? []) {
                link.data = {
                    uri,
                    original: {
                        data: link.data,
                    },
                    serviceIndex: context.services.indexOf(service),
                };
            }
            return links;
        }, (links, map) => {
            if (!map) {
                return links;
            }
            return links
                .map(link => {
                const range = map.getSourceRange(link.range, language_core_1.isDocumentLinkEnabled);
                if (!range) {
                    return;
                }
                link = {
                    ...link,
                    range,
                };
                if (link.target) {
                    link.target = (0, transform_1.transformDocumentLinkTarget)(link.target, context);
                }
                return link;
            })
                .filter(common_1.notEmpty);
        }, arr => arr.flat()) ?? [];
    };
}
exports.register = register;
//# sourceMappingURL=provideDocumentLinks.js.map