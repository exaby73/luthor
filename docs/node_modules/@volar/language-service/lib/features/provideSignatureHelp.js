"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.register = void 0;
const featureWorkers_1 = require("../utils/featureWorkers");
const cancellation_1 = require("../utils/cancellation");
const language_core_1 = require("@volar/language-core");
function register(context) {
    return (uri, position, signatureHelpContext = {
        triggerKind: 1,
        isRetrigger: false,
    }, token = cancellation_1.NoneCancellationToken) => {
        return (0, featureWorkers_1.languageFeatureWorker)(context, uri, () => position, map => map.getGeneratedPositions(position, language_core_1.isSignatureHelpEnabled), (service, document, position) => {
            if (token.isCancellationRequested) {
                return;
            }
            if (signatureHelpContext?.triggerKind === 2
                && signatureHelpContext.triggerCharacter
                && !(signatureHelpContext.isRetrigger
                    ? service[0].signatureHelpRetriggerCharacters
                    : service[0].signatureHelpTriggerCharacters)?.includes(signatureHelpContext.triggerCharacter)) {
                return;
            }
            return service[1].provideSignatureHelp?.(document, position, signatureHelpContext, token);
        }, data => data);
    };
}
exports.register = register;
//# sourceMappingURL=provideSignatureHelp.js.map