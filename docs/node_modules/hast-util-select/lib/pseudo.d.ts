/** @type {(rule: AstPseudoClass, element: Element, index: number | undefined, parent: Parents | undefined, state: State) => boolean} */
export const pseudo: (rule: AstPseudoClass, element: Element, index: number | undefined, parent: Parents | undefined, state: State) => boolean;
export type AstPseudoClass = import('css-selector-parser').AstPseudoClass;
export type Element = import('hast').Element;
export type ElementContent = import('hast').ElementContent;
export type Parents = import('hast').Parents;
export type State = import('./index.js').State;
