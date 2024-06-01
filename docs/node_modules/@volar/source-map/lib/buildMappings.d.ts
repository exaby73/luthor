import type { Segment } from 'muggle-string';
import type { Mapping } from './sourceMap';
export declare function buildMappings<T>(chunks: Segment<T>[]): Mapping<T>[];
