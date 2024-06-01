import { AsyncLocalStorage } from "node:async_hooks";
import { AstroError } from "../../core/errors/errors.js";
const ApiContextStorage = new AsyncLocalStorage();
function getApiContext() {
  const context = ApiContextStorage.getStore();
  if (!context) {
    throw new AstroError({
      name: "AstroActionError",
      message: "Unable to get API context.",
      hint: "If you attempted to call this action from server code, trying using `Astro.getActionResult()` instead."
    });
  }
  return context;
}
export {
  ApiContextStorage,
  getApiContext
};
