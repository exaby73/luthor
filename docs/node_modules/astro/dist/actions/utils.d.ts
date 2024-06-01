import type { APIContext } from '../@types/astro.js';
import type { Locals } from './runtime/middleware.js';
export declare function hasActionsInternal(locals: APIContext['locals']): locals is Locals;
export declare function createGetActionResult(locals: APIContext['locals']): APIContext['getActionResult'];
