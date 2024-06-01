import type { ComponentInstance, ManifestData, RewritePayload, RouteData, SSRResult } from '../../@types/astro.js';
import { Pipeline } from '../base-pipeline.js';
import type { SinglePageBuiltModule } from '../build/types.js';
export declare class AppPipeline extends Pipeline {
    #private;
    static create(manifestData: ManifestData, { logger, manifest, mode, renderers, resolve, serverLike, streaming, }: Pick<AppPipeline, 'logger' | 'manifest' | 'mode' | 'renderers' | 'resolve' | 'serverLike' | 'streaming'>): AppPipeline;
    headElements(routeData: RouteData): Pick<SSRResult, 'scripts' | 'styles' | 'links'>;
    componentMetadata(): void;
    getComponentByRoute(routeData: RouteData): Promise<ComponentInstance>;
    tryRewrite(payload: RewritePayload, request: Request): Promise<[RouteData, ComponentInstance]>;
    getModuleForRoute(route: RouteData): Promise<SinglePageBuiltModule>;
}
