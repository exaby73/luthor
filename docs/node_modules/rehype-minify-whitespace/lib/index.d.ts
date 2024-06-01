/**
 * Minify whitespace.
 *
 * @param {Options | null | undefined} [options]
 *   Configuration (optional).
 * @returns
 *   Transform.
 */
export default function rehypeMinifyWhitespace(options?: Options | null | undefined): (tree: Root) => undefined;
export type Nodes = import('hast').Nodes;
export type Parents = import('hast').Parents;
export type Root = import('hast').Root;
export type Text = import('hast').Text;
/**
 * Collapse a string.
 */
export type Collapse = (value: string) => string;
/**
 * Configuration.
 */
export type Options = {
    /**
     * Collapse whitespace containing newlines to `'\n'` instead of `' '`
     * (default: `false`); the default is to collapse to a single space.
     */
    newlines?: boolean | null | undefined;
};
/**
 * Result.
 */
export type Result = {
    /**
     *   Whether to remove.
     */
    remove: boolean;
    /**
     *   Whether to ignore.
     */
    ignore: boolean;
    /**
     *   Whether to strip at the start.
     */
    stripAtStart: boolean;
};
/**
 * Info passed around.
 */
export type State = {
    /**
     *   Collapse.
     */
    collapse: Collapse;
    /**
     *   Current whitespace.
     */
    whitespace: Whitespace;
    /**
     * Whether there is a break before (default: `false`).
     */
    before?: boolean | undefined;
    /**
     * Whether there is a break after (default: `false`).
     */
    after?: boolean | undefined;
};
/**
 * Whitespace setting.
 */
export type Whitespace = 'normal' | 'nowrap' | 'pre' | 'pre-wrap';
