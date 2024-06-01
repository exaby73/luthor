/**
 * Enter a node.
 *
 * The caller is responsible for calling the return value `exit`.
 *
 * @param {State} state
 *   Current state.
 *
 *   Will be mutated: `exit` undos the changes.
 * @param {Nodes} node
 *   Node to enter.
 * @returns {() => undefined}
 *   Call to exit.
 */
export function enterState(state: State, node: Nodes): () => undefined;
export type ElementContent = import('hast').ElementContent;
export type Nodes = import('hast').Nodes;
export type Visitor = import('unist-util-visit').Visitor<ElementContent>;
export type Direction = import('./index.js').Direction;
export type State = import('./index.js').State;
