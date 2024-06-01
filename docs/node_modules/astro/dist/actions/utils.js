import { AstroError } from "../core/errors/errors.js";
function hasActionsInternal(locals) {
  return "_actionsInternal" in locals;
}
function createGetActionResult(locals) {
  return (actionFn) => {
    if (!hasActionsInternal(locals))
      throw new AstroError({
        name: "AstroActionError",
        message: "Experimental actions are not enabled in your project.",
        hint: "See https://docs.astro.build/en/reference/configuration-reference/#experimental-flags"
      });
    return locals._actionsInternal.getActionResult(actionFn);
  };
}
export {
  createGetActionResult,
  hasActionsInternal
};
