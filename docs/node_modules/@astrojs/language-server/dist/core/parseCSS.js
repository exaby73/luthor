"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.collectClassesAndIdsFromDocument = exports.extractStylesheets = void 0;
const utils_1 = require("@astrojs/compiler/utils");
const language_core_1 = require("@volar/language-core");
function extractStylesheets(snapshot, htmlDocument, ast) {
    const embeddedCSSCodes = findEmbeddedStyles(snapshot, htmlDocument.roots);
    const inlineStyles = findInlineStyles(ast);
    if (inlineStyles.length > 0) {
        const codes = [];
        for (const inlineStyle of inlineStyles) {
            codes.push('x { ');
            codes.push([
                inlineStyle.value,
                undefined,
                inlineStyle.position.start.offset + 'style="'.length,
                {
                    completion: true,
                    verification: false,
                    semantic: true,
                    navigation: true,
                    structure: true,
                    format: false,
                },
            ]);
            codes.push(' }\n');
        }
        const mappings = (0, language_core_1.buildMappings)(codes);
        const text = (0, language_core_1.toString)(codes);
        embeddedCSSCodes.push({
            id: 'inline.css',
            languageId: 'css',
            snapshot: {
                getText: (start, end) => text.substring(start, end),
                getLength: () => text.length,
                getChangeRange: () => undefined,
            },
            embeddedCodes: [],
            mappings,
        });
    }
    return embeddedCSSCodes;
}
exports.extractStylesheets = extractStylesheets;
/**
 * Find all embedded styles in a document.
 * Embedded styles are styles that are defined in `<style>` tags.
 */
function findEmbeddedStyles(snapshot, roots) {
    const embeddedCSSCodes = [];
    let cssIndex = 0;
    getEmbeddedCSSInNodes(roots);
    function getEmbeddedCSSInNodes(nodes) {
        for (const [_, node] of nodes.entries()) {
            if (node.tag === 'style' &&
                node.startTagEnd !== undefined &&
                node.endTagStart !== undefined) {
                const styleText = snapshot.getText(node.startTagEnd, node.endTagStart);
                embeddedCSSCodes.push({
                    id: `${cssIndex}.css`,
                    languageId: 'css',
                    snapshot: {
                        getText: (start, end) => styleText.substring(start, end),
                        getLength: () => styleText.length,
                        getChangeRange: () => undefined,
                    },
                    mappings: [
                        {
                            sourceOffsets: [node.startTagEnd],
                            generatedOffsets: [0],
                            lengths: [styleText.length],
                            data: {
                                verification: false,
                                completion: true,
                                semantic: true,
                                navigation: true,
                                structure: true,
                                format: false,
                            },
                        },
                    ],
                    embeddedCodes: [],
                });
                cssIndex++;
            }
            if (node.children)
                getEmbeddedCSSInNodes(node.children);
        }
    }
    return embeddedCSSCodes;
}
/**
 * Find all inline styles using the Astro AST
 * Inline styles are styles that are defined in the `style` attribute of an element.
 * TODO: Merge this with `findEmbeddedCSS`? Unlike scripts, there's no scoping being done here, so merging all of it in
 * the same virtual file is possible, though it might make mapping more tricky.
 */
function findInlineStyles(ast) {
    const styleAttrs = [];
    // `@astrojs/compiler`'s `walk` method is async, so we can't use it here. Arf
    function walkDown(parent) {
        if (!parent.children)
            return;
        parent.children.forEach((child) => {
            if (utils_1.is.element(child)) {
                const styleAttribute = child.attributes.find((attr) => attr.name === 'style' && attr.kind === 'quoted');
                if (styleAttribute && styleAttribute.position) {
                    styleAttrs.push(styleAttribute);
                }
            }
            if (utils_1.is.parent(child)) {
                walkDown(child);
            }
        });
    }
    walkDown(ast);
    return styleAttrs;
}
// TODO: Provide completion for classes and IDs
function collectClassesAndIdsFromDocument(ast) {
    const classesAndIds = [];
    function walkDown(parent) {
        if (!parent.children)
            return;
        parent.children.forEach((child) => {
            if (utils_1.is.element(child)) {
                const classOrIDAttributes = child.attributes
                    .filter((attr) => attr.kind === 'quoted' && (attr.name === 'class' || attr.name === 'id'))
                    .flatMap((attr) => attr.value.split(' '));
                classesAndIds.push(...classOrIDAttributes);
            }
            if (utils_1.is.parent(child)) {
                walkDown(child);
            }
        });
    }
    walkDown(ast);
    return classesAndIds;
}
exports.collectClassesAndIdsFromDocument = collectClassesAndIdsFromDocument;
//# sourceMappingURL=parseCSS.js.map