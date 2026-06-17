import type { AstroBuiltinAttributes } from 'astro';
import type { HTMLAttributes } from 'astro/types';

export type LinkHTMLAttributes = Omit<
  HTMLAttributes<'a'>,
  keyof AstroBuiltinAttributes | 'children'
>;
