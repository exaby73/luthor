import { yellow } from "kleur/colors";
import { defineMiddleware } from "../../core/middleware/index.js";
import { ApiContextStorage } from "./store.js";
import { formContentTypes, getAction, hasContentType } from "./utils.js";
import { callSafely } from "./virtual/shared.js";
const onRequest = defineMiddleware(async (context, next) => {
  const locals = context.locals;
  if (locals._actionsInternal) return ApiContextStorage.run(context, () => next());
  if (context.request.method === "GET") {
    return nextWithLocalsStub(next, context);
  }
  if (context.request.method === "POST" && context.request.body === null) {
    return nextWithStaticStub(next, context);
  }
  const { request, url } = context;
  const contentType = request.headers.get("Content-Type");
  if (url.pathname.startsWith("/_actions")) return nextWithLocalsStub(next, context);
  if (!contentType || !hasContentType(contentType, formContentTypes)) {
    return nextWithLocalsStub(next, context);
  }
  const formData = await request.clone().formData();
  const actionPath = formData.get("_astroAction");
  if (typeof actionPath !== "string") return nextWithLocalsStub(next, context);
  const action = await getAction(actionPath);
  if (!action) return nextWithLocalsStub(next, context);
  const result = await ApiContextStorage.run(context, () => callSafely(() => action(formData)));
  const actionsInternal = {
    getActionResult: (actionFn) => {
      if (actionFn.toString() !== actionPath) return Promise.resolve(void 0);
      return result;
    },
    actionResult: result
  };
  Object.defineProperty(locals, "_actionsInternal", { writable: false, value: actionsInternal });
  return ApiContextStorage.run(context, async () => {
    const response = await next();
    if (result.error) {
      return new Response(response.body, {
        status: result.error.status,
        statusText: result.error.name,
        headers: response.headers
      });
    }
    return response;
  });
});
function nextWithStaticStub(next, context) {
  Object.defineProperty(context.locals, "_actionsInternal", {
    writable: false,
    value: {
      getActionResult: () => {
        console.warn(
          yellow("[astro:actions]"),
          "`getActionResult()` should not be called on prerendered pages. Astro can only handle actions for pages rendered on-demand."
        );
        return void 0;
      }
    }
  });
  return ApiContextStorage.run(context, () => next());
}
function nextWithLocalsStub(next, context) {
  Object.defineProperty(context.locals, "_actionsInternal", {
    writable: false,
    value: {
      getActionResult: () => void 0
    }
  });
  return ApiContextStorage.run(context, () => next());
}
export {
  onRequest
};
