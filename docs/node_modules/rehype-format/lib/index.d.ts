/**
 * Format whitespace in HTML.
 *
 * @param {Options | null | undefined} [options]
 *   Configuration (optional).
 * @returns
 *   Transform.
 */
export default function rehypeFormat(options?: Options | null | undefined): (tree: Root) => undefined;
export type Nodes = import('hast').Nodes;
export type Root = import('hast').Root;
export type RootContent = import('hast').RootContent;
/**
 * Configuration.
 */
export type Options = {
    /**
     * List of tag names to join with a blank line (default: `[]`); these tags,
     * when next to each other, are joined by a blank line (`\n\n`); for example,
     * when `['head', 'body']` is given, a blank line is added between these two.
     */
    blanks?: Array<string> | null | undefined;
    /**
     * Indentation per level (default: `2`); when number, uses that amount of
     * spaces; when `string`, uses that per indentation level.
     */
    indent?: number | string | null | undefined;
    /**
     * Whether to indent the first level (default: `true`); this is usually the
     * `<html>`, thus not indenting `head` and `body`.
     */
    indentInitial?: boolean | null | undefined;
};
