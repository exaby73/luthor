const formContentTypes = ["application/x-www-form-urlencoded", "multipart/form-data"];
function hasContentType(contentType, expected) {
  const type = contentType.split(";")[0].toLowerCase();
  return expected.some((t) => type === t);
}
async function getAction(path) {
  const pathKeys = path.replace("/_actions/", "").split(".");
  let { server: actionLookup } = await import(import.meta.env.ACTIONS_PATH);
  for (const key of pathKeys) {
    if (!(key in actionLookup)) {
      return void 0;
    }
    actionLookup = actionLookup[key];
  }
  if (typeof actionLookup !== "function") {
    return void 0;
  }
  return actionLookup;
}
export {
  formContentTypes,
  getAction,
  hasContentType
};
