import type { Segment, StackNode } from 'muggle-string';
export interface Stack {
    source: string;
    range: [number, number];
}
export declare function buildStacks<T>(chunks: Segment<T>[], stacks: StackNode[]): Stack[];
