import { Pipeline } from "../base-pipeline.js";
import { DEFAULT_404_COMPONENT } from "../constants.js";
import { RedirectSinglePageBuiltModule } from "../redirects/component.js";
import { createModuleScriptElement, createStylesheetElementSet } from "../render/ssr-element.js";
class AppPipeline extends Pipeline {
  #manifestData;
  static create(manifestData, {
    logger,
    manifest,
    mode,
    renderers,
    resolve,
    serverLike,
    streaming
  }) {
    const pipeline = new AppPipeline(
      logger,
      manifest,
      mode,
      renderers,
      resolve,
      serverLike,
      streaming
    );
    pipeline.#manifestData = manifestData;
    return pipeline;
  }
  headElements(routeData) {
    const routeInfo = this.manifest.routes.find((route) => route.routeData === routeData);
    const links = /* @__PURE__ */ new Set();
    const scripts = /* @__PURE__ */ new Set();
    const styles = createStylesheetElementSet(routeInfo?.styles ?? []);
    for (const script of routeInfo?.scripts ?? []) {
      if ("stage" in script) {
        if (script.stage === "head-inline") {
          scripts.add({
            props: {},
            children: script.children
          });
        }
      } else {
        scripts.add(createModuleScriptElement(script));
      }
    }
    return { links, styles, scripts };
  }
  componentMetadata() {
  }
  async getComponentByRoute(routeData) {
    const module = await this.getModuleForRoute(routeData);
    return module.page();
  }
  async tryRewrite(payload, request) {
    let foundRoute;
    for (const route of this.#manifestData.routes) {
      if (payload instanceof URL) {
        if (route.pattern.test(payload.pathname)) {
          foundRoute = route;
          break;
        }
      } else if (payload instanceof Request) {
        const url = new URL(payload.url);
        if (route.pattern.test(url.pathname)) {
          foundRoute = route;
          break;
        }
      } else {
        const newUrl = new URL(payload, new URL(request.url).origin);
        if (route.pattern.test(decodeURI(newUrl.pathname))) {
          foundRoute = route;
          break;
        }
      }
    }
    if (foundRoute) {
      const componentInstance = await this.getComponentByRoute(foundRoute);
      return [foundRoute, componentInstance];
    }
    throw new Error("Route not found");
  }
  async getModuleForRoute(route) {
    if (route.component === DEFAULT_404_COMPONENT) {
      return {
        page: async () => ({ default: () => new Response(null, { status: 404 }) }),
        renderers: []
      };
    }
    if (route.type === "redirect") {
      return RedirectSinglePageBuiltModule;
    } else {
      if (this.manifest.pageMap) {
        const importComponentInstance = this.manifest.pageMap.get(route.component);
        if (!importComponentInstance) {
          throw new Error(
            `Unexpectedly unable to find a component instance for route ${route.route}`
          );
        }
        return await importComponentInstance();
      } else if (this.manifest.pageModule) {
        return this.manifest.pageModule;
      }
      throw new Error(
        "Astro couldn't find the correct page to render, probably because it wasn't correctly mapped for SSR usage. This is an internal error, please file an issue."
      );
    }
  }
}
export {
  AppPipeline
};
