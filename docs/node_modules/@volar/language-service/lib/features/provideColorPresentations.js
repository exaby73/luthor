"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.register = void 0;
const featureWorkers_1 = require("../utils/featureWorkers");
const common_1 = require("../utils/common");
const cancellation_1 = require("../utils/cancellation");
const language_core_1 = require("@volar/language-core");
function register(context) {
    return (uri, color, range, token = cancellation_1.NoneCancellationToken) => {
        return (0, featureWorkers_1.languageFeatureWorker)(context, uri, () => range, function* (map) {
            for (const mappedRange of map.getGeneratedRanges(range, language_core_1.isColorEnabled)) {
                yield mappedRange;
            }
        }, (service, document, range) => {
            if (token.isCancellationRequested) {
                return;
            }
            return service[1].provideColorPresentations?.(document, color, range, token);
        }, (data, map) => {
            if (!map) {
                return data;
            }
            return data
                .map(colorPresentation => {
                if (colorPresentation.textEdit) {
                    const range = map.getSourceRange(colorPresentation.textEdit.range);
                    if (!range) {
                        return undefined;
                    }
                    colorPresentation.textEdit.range = range;
                }
                if (colorPresentation.additionalTextEdits) {
                    for (const textEdit of colorPresentation.additionalTextEdits) {
                        const range = map.getSourceRange(textEdit.range);
                        if (!range) {
                            return undefined;
                        }
                        textEdit.range = range;
                    }
                }
                return colorPresentation;
            })
                .filter(common_1.notEmpty);
        });
    };
}
exports.register = register;
//# sourceMappingURL=provideColorPresentations.js.map