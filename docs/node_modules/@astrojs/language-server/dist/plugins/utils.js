"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.editShouldBeInFrontmatter = exports.getOpenFrontmatterEdit = exports.getNewFrontmatterEdit = exports.ensureRangeIsInFrontmatter = exports.ensureProperEditForFrontmatter = exports.isInsideFrontmatter = exports.isInsideExpression = exports.isInComponentStartTag = exports.isPossibleComponent = exports.isJSDocument = void 0;
const vscode_html_languageservice_1 = require("vscode-html-languageservice");
function isJSDocument(languageId) {
    return (languageId === 'javascript' ||
        languageId === 'typescript' ||
        languageId === 'javascriptreact' ||
        languageId === 'typescriptreact');
}
exports.isJSDocument = isJSDocument;
/**
 * Return true if a specific node could be a component.
 * This is not a 100% sure test as it'll return false for any component that does not match the standard format for a component
 */
function isPossibleComponent(node) {
    return !!node.tag?.[0].match(/[A-Z]/) || !!node.tag?.match(/.+[.][A-Z]?/);
}
exports.isPossibleComponent = isPossibleComponent;
/**
 * Return if a given offset is inside the start tag of a component
 */
function isInComponentStartTag(html, offset) {
    const node = html.findNodeAt(offset);
    return isPossibleComponent(node) && (!node.startTagEnd || offset < node.startTagEnd);
}
exports.isInComponentStartTag = isInComponentStartTag;
/**
 * Return if a given position is inside a JSX expression
 */
function isInsideExpression(html, tagStart, position) {
    const charactersInNode = html.substring(tagStart, position);
    return charactersInNode.lastIndexOf('{') > charactersInNode.lastIndexOf('}');
}
exports.isInsideExpression = isInsideExpression;
/**
 * Return if a given offset is inside the frontmatter
 */
function isInsideFrontmatter(offset, frontmatter) {
    switch (frontmatter.status) {
        case 'closed':
            return offset > frontmatter.position.start.offset && offset < frontmatter.position.end.offset;
        case 'open':
            return offset > frontmatter.position.start.offset;
        case 'doesnt-exist':
            return false;
    }
}
exports.isInsideFrontmatter = isInsideFrontmatter;
function ensureProperEditForFrontmatter(edit, metadata, newLine, position = 'top') {
    switch (metadata.frontmatter.status) {
        case 'open':
            return getOpenFrontmatterEdit(edit, metadata, newLine);
        case 'closed':
            const newRange = ensureRangeIsInFrontmatter(edit.range, metadata, position);
            return {
                newText: newRange.start.line === metadata.frontmatter.position.start.line &&
                    edit.newText.startsWith(newLine)
                    ? edit.newText.trimStart()
                    : edit.newText,
                range: newRange,
            };
        case 'doesnt-exist':
            return getNewFrontmatterEdit(edit, metadata, newLine);
    }
}
exports.ensureProperEditForFrontmatter = ensureProperEditForFrontmatter;
/**
 * Force a range to be at the start of the frontmatter if it is outside
 */
function ensureRangeIsInFrontmatter(range, metadata, position = 'top') {
    if (metadata.frontmatter.status === 'open' || metadata.frontmatter.status === 'closed') {
        const frontmatterEndPosition = metadata.frontmatter.position.end
            ? metadata.tsxRanges.frontmatter.end
            : undefined;
        // If the range start is outside the frontmatter, return a range at the start of the frontmatter
        if (range.start.line < metadata.tsxRanges.frontmatter.start.line ||
            (frontmatterEndPosition && range.start.line > frontmatterEndPosition.line)) {
            if (frontmatterEndPosition && position === 'bottom') {
                return vscode_html_languageservice_1.Range.create(frontmatterEndPosition, frontmatterEndPosition);
            }
            return vscode_html_languageservice_1.Range.create(metadata.tsxRanges.frontmatter.start, metadata.tsxRanges.frontmatter.start);
        }
        return range;
    }
    return range;
}
exports.ensureRangeIsInFrontmatter = ensureRangeIsInFrontmatter;
function getNewFrontmatterEdit(edit, astroMetadata, newLine) {
    edit.newText = `---${edit.newText.startsWith(newLine) ? '' : newLine}${edit.newText}---${newLine}${newLine}`;
    edit.range = vscode_html_languageservice_1.Range.create(astroMetadata.tsxRanges.frontmatter.start, astroMetadata.tsxRanges.frontmatter.start);
    return edit;
}
exports.getNewFrontmatterEdit = getNewFrontmatterEdit;
function getOpenFrontmatterEdit(edit, astroMetadata, newLine) {
    edit.newText = edit.newText.startsWith(newLine)
        ? `${edit.newText}---`
        : `${newLine}${edit.newText}---`;
    edit.range = vscode_html_languageservice_1.Range.create(astroMetadata.tsxRanges.frontmatter.start, astroMetadata.tsxRanges.frontmatter.start);
    return edit;
}
exports.getOpenFrontmatterEdit = getOpenFrontmatterEdit;
// Most edits that are at the beginning of the TSX, or outside the document are intended for the frontmatter
function editShouldBeInFrontmatter(range, astroMetadata) {
    const isAtTSXStart = range.start.line < astroMetadata.tsxRanges.frontmatter.start.line;
    const isPastFile = range.start.line > astroMetadata.tsxRanges.body.end.line;
    const shouldIt = isAtTSXStart || isPastFile;
    return shouldIt
        ? { itShould: true, position: isPastFile ? 'bottom' : 'top' }
        : { itShould: false, position: undefined };
}
exports.editShouldBeInFrontmatter = editShouldBeInFrontmatter;
//# sourceMappingURL=utils.js.map