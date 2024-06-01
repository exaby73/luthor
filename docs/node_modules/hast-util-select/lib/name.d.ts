/**
 * Check whether an element has a tag name.
 *
 * @param {AstTagName} query
 *   AST rule (with `tag`).
 * @param {Element} element
 *   Element.
 * @returns {boolean}
 *   Whether `element` matches `query`.
 */
export function name(query: AstTagName, element: Element): boolean;
export type AstTagName = import('css-selector-parser').AstTagName;
export type Element = import('hast').Element;
