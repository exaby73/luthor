"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.createLanguageService = void 0;
const language_core_1 = require("@volar/language-core");
const documents_1 = require("./documents");
const autoInsert = require("./features/provideAutoInsertionEdit");
const callHierarchy = require("./features/provideCallHierarchyItems");
const codeActions = require("./features/provideCodeActions");
const codeLens = require("./features/provideCodeLenses");
const colorPresentations = require("./features/provideColorPresentations");
const completions = require("./features/provideCompletionItems");
const definition = require("./features/provideDefinition");
const diagnostics = require("./features/provideDiagnostics");
const documentColors = require("./features/provideDocumentColors");
const documentDrop = require("./features/provideDocumentDropEdits");
const format = require("./features/provideDocumentFormattingEdits");
const documentHighlight = require("./features/provideDocumentHighlights");
const documentLink = require("./features/provideDocumentLinks");
const semanticTokens = require("./features/provideDocumentSemanticTokens");
const documentSymbols = require("./features/provideDocumentSymbols");
const fileReferences = require("./features/provideFileReferences");
const fileRename = require("./features/provideFileRenameEdits");
const foldingRanges = require("./features/provideFoldingRanges");
const hover = require("./features/provideHover");
const inlayHints = require("./features/provideInlayHints");
const linkedEditing = require("./features/provideLinkedEditingRanges");
const references = require("./features/provideReferences");
const rename = require("./features/provideRenameEdits");
const renamePrepare = require("./features/provideRenameRange");
const selectionRanges = require("./features/provideSelectionRanges");
const signatureHelp = require("./features/provideSignatureHelp");
const workspaceSymbol = require("./features/provideWorkspaceSymbols");
const codeActionResolve = require("./features/resolveCodeAction");
const codeLensResolve = require("./features/resolveCodeLens");
const completionResolve = require("./features/resolveCompletionItem");
const documentLinkResolve = require("./features/resolveDocumentLink");
const inlayHintResolve = require("./features/resolveInlayHint");
const vscode_languageserver_textdocument_1 = require("vscode-languageserver-textdocument");
function createLanguageService(language, servicePlugins, env) {
    const documentVersions = new Map();
    const map2DocMap = new WeakMap();
    const mirrorMap2DocMirrorMap = new WeakMap();
    const snapshot2Doc = new WeakMap();
    const embeddedContentScheme = 'volar-embedded-content';
    const context = {
        language,
        documents: {
            get(uri, languageId, snapshot) {
                if (!snapshot2Doc.has(snapshot)) {
                    snapshot2Doc.set(snapshot, new Map());
                }
                const map = snapshot2Doc.get(snapshot);
                if (!map.has(uri)) {
                    const version = documentVersions.get(uri) ?? 0;
                    documentVersions.set(uri, version + 1);
                    map.set(uri, vscode_languageserver_textdocument_1.TextDocument.create(uri, languageId, version, snapshot.getText(0, snapshot.getLength())));
                }
                return map.get(uri);
            },
            *getMaps(virtualCode) {
                for (const [uri, [snapshot, map]] of context.language.maps.forEach(virtualCode)) {
                    if (!map2DocMap.has(map)) {
                        const embeddedUri = context.encodeEmbeddedDocumentUri(uri, virtualCode.id);
                        map2DocMap.set(map, new documents_1.SourceMapWithDocuments(this.get(uri, context.language.scripts.get(uri).languageId, snapshot), this.get(embeddedUri, virtualCode.languageId, virtualCode.snapshot), map));
                    }
                    yield map2DocMap.get(map);
                }
            },
            getLinkedCodeMap(virtualCode, sourceScriptId) {
                const map = context.language.linkedCodeMaps.get(virtualCode);
                if (map) {
                    if (!mirrorMap2DocMirrorMap.has(map)) {
                        const embeddedUri = context.encodeEmbeddedDocumentUri(sourceScriptId, virtualCode.id);
                        mirrorMap2DocMirrorMap.set(map, new documents_1.LinkedCodeMapWithDocument(this.get(embeddedUri, virtualCode.languageId, virtualCode.snapshot), map));
                    }
                    return mirrorMap2DocMirrorMap.get(map);
                }
            },
        },
        env,
        inject: (key, ...args) => {
            for (const service of context.services) {
                if (context.disabledServicePlugins.has(service[1])) {
                    continue;
                }
                const provide = service[1].provide?.[key];
                if (provide) {
                    return provide(...args);
                }
            }
        },
        services: [],
        commands: {
            rename: {
                create(uri, position) {
                    return {
                        title: '',
                        command: 'editor.action.rename',
                        arguments: [
                            uri,
                            position,
                        ],
                    };
                },
                is(command) {
                    return command.command === 'editor.action.rename';
                },
            },
            showReferences: {
                create(uri, position, locations) {
                    return {
                        title: locations.length === 1 ? '1 reference' : `${locations.length} references`,
                        command: 'editor.action.showReferences',
                        arguments: [
                            uri,
                            position,
                            locations,
                        ],
                    };
                },
                is(command) {
                    return command.command === 'editor.action.showReferences';
                },
            },
            setSelection: {
                create(position) {
                    return {
                        title: '',
                        command: 'setSelection',
                        arguments: [{
                                selection: {
                                    selectionStartLineNumber: position.line + 1,
                                    positionLineNumber: position.line + 1,
                                    selectionStartColumn: position.character + 1,
                                    positionColumn: position.character + 1,
                                },
                            }],
                    };
                },
                is(command) {
                    return command.command === 'setSelection';
                },
            },
        },
        disabledEmbeddedDocumentUris: new Set(),
        disabledServicePlugins: new WeakSet(),
        decodeEmbeddedDocumentUri(maybeEmbeddedContentUri) {
            if (maybeEmbeddedContentUri.startsWith(`${embeddedContentScheme}://`)) {
                const trimed = maybeEmbeddedContentUri.substring(`${embeddedContentScheme}://`.length);
                const embeddedCodeId = trimed.substring(0, trimed.indexOf('/'));
                const documentUri = trimed.substring(embeddedCodeId.length + 1);
                return [
                    decodeURIComponent(documentUri),
                    decodeURIComponent(embeddedCodeId),
                ];
            }
        },
        encodeEmbeddedDocumentUri(documentUri, embeddedContentId) {
            return `${embeddedContentScheme}://${encodeURIComponent(embeddedContentId)}/${encodeURIComponent(documentUri)}`;
        },
    };
    const api = {
        getTriggerCharacters: () => servicePlugins.map(service => service.triggerCharacters ?? []).flat(),
        getAutoFormatTriggerCharacters: () => servicePlugins.map(service => service.autoFormatTriggerCharacters ?? []).flat(),
        getSignatureHelpTriggerCharacters: () => servicePlugins.map(service => service.signatureHelpTriggerCharacters ?? []).flat(),
        getSignatureHelpRetriggerCharacters: () => servicePlugins.map(service => service.signatureHelpRetriggerCharacters ?? []).flat(),
        format: format.register(context),
        getFoldingRanges: foldingRanges.register(context),
        getSelectionRanges: selectionRanges.register(context),
        findLinkedEditingRanges: linkedEditing.register(context),
        findDocumentSymbols: documentSymbols.register(context),
        findDocumentColors: documentColors.register(context),
        getColorPresentations: colorPresentations.register(context),
        doValidation: diagnostics.register(context),
        findReferences: references.register(context),
        findFileReferences: fileReferences.register(context),
        findDefinition: definition.register(context, 'provideDefinition', language_core_1.isDefinitionEnabled),
        findTypeDefinition: definition.register(context, 'provideTypeDefinition', language_core_1.isTypeDefinitionEnabled),
        findImplementations: definition.register(context, 'provideImplementation', language_core_1.isImplementationEnabled),
        prepareRename: renamePrepare.register(context),
        doRename: rename.register(context),
        getEditsForFileRename: fileRename.register(context),
        getSemanticTokens: semanticTokens.register(context),
        doHover: hover.register(context),
        doComplete: completions.register(context),
        doCodeActions: codeActions.register(context),
        doCodeActionResolve: codeActionResolve.register(context),
        doCompletionResolve: completionResolve.register(context),
        getSignatureHelp: signatureHelp.register(context),
        doCodeLens: codeLens.register(context),
        doCodeLensResolve: codeLensResolve.register(context),
        findDocumentHighlights: documentHighlight.register(context),
        findDocumentLinks: documentLink.register(context),
        doDocumentLinkResolve: documentLinkResolve.register(context),
        findWorkspaceSymbols: workspaceSymbol.register(context),
        doAutoInsert: autoInsert.register(context),
        doDocumentDrop: documentDrop.register(context),
        getInlayHints: inlayHints.register(context),
        doInlayHintResolve: inlayHintResolve.register(context),
        callHierarchy: callHierarchy.register(context),
        dispose: () => context.services.forEach(service => service[1].dispose?.()),
        context,
    };
    for (const servicePlugin of servicePlugins) {
        context.services.push([servicePlugin, servicePlugin.create(context, api)]);
    }
    return api;
}
exports.createLanguageService = createLanguageService;
//# sourceMappingURL=languageService.js.map