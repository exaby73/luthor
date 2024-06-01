import { Pipeline } from "../core/base-pipeline.js";
import { RouteNotFound } from "../core/errors/errors-data.js";
import { AstroError } from "../core/errors/index.js";
import {
  createModuleScriptElement,
  createStylesheetElementSet
} from "../core/render/ssr-element.js";
class ContainerPipeline extends Pipeline {
  /**
   * Internal cache to store components instances by `RouteData`.
   * @private
   */
  #componentsInterner = /* @__PURE__ */ new WeakMap();
  static create({
    logger,
    manifest,
    renderers,
    resolve,
    serverLike,
    streaming
  }) {
    return new ContainerPipeline(
      logger,
      manifest,
      "development",
      renderers,
      resolve,
      serverLike,
      streaming
    );
  }
  componentMetadata(_routeData) {
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
  async tryRewrite(rewritePayload) {
    let foundRoute;
    for (const route of this.manifest.routes) {
      const routeData = route.routeData;
      if (rewritePayload instanceof URL) {
        if (routeData.pattern.test(rewritePayload.pathname)) {
          foundRoute = routeData;
          break;
        }
      } else if (rewritePayload instanceof Request) {
        const url = new URL(rewritePayload.url);
        if (routeData.pattern.test(url.pathname)) {
          foundRoute = routeData;
          break;
        }
      } else if (routeData.pattern.test(decodeURI(rewritePayload))) {
        foundRoute = routeData;
        break;
      }
    }
    if (foundRoute) {
      const componentInstance = await this.getComponentByRoute(foundRoute);
      return [foundRoute, componentInstance];
    } else {
      throw new AstroError(RouteNotFound);
    }
  }
  insertRoute(route, componentInstance) {
    this.#componentsInterner.set(route, {
      page() {
        return Promise.resolve(componentInstance);
      },
      renderers: this.manifest.renderers,
      onRequest: this.manifest.middleware
    });
  }
  // At the moment it's not used by the container via any public API
  // @ts-expect-error It needs to be implemented.
  async getComponentByRoute(_routeData) {
  }
}
export {
  ContainerPipeline
};
