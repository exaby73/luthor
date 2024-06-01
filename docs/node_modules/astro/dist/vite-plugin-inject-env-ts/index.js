import path from "node:path";
import { fileURLToPath } from "node:url";
import { bold } from "kleur/colors";
import { normalizePath } from "vite";
import { ACTIONS_TYPES_FILE } from "../actions/consts.js";
import { CONTENT_TYPES_FILE } from "../content/consts.js";
import { getContentPaths } from "../content/index.js";
import {} from "../core/logger/core.js";
function getEnvTsPath({ srcDir }) {
  return new URL("env.d.ts", srcDir);
}
function astroInjectEnvTsPlugin({
  settings,
  logger,
  fs
}) {
  return {
    name: "astro-inject-env-ts",
    // Use `post` to ensure project setup is complete
    // Ex. `.astro` types have been written
    enforce: "post",
    async config() {
      await setUpEnvTs({ settings, logger, fs });
    }
  };
}
async function setUpEnvTs({
  settings,
  logger,
  fs
}) {
  const envTsPath = getEnvTsPath(settings.config);
  const dotAstroDir = getContentPaths(settings.config).cacheDir;
  const dotAstroTypeReferences = getDotAstroTypeReferences({
    root: settings.config.root,
    srcDir: settings.config.srcDir,
    fs
  });
  const envTsPathRelativeToRoot = normalizePath(
    path.relative(fileURLToPath(settings.config.root), fileURLToPath(envTsPath))
  );
  if (fs.existsSync(envTsPath)) {
    let typesEnvContents = await fs.promises.readFile(envTsPath, "utf-8");
    let addedTypes = false;
    for (const typeReference of dotAstroTypeReferences) {
      if (typesEnvContents.includes(typeReference)) continue;
      typesEnvContents = `${typeReference}
${typesEnvContents}`;
      await fs.promises.writeFile(envTsPath, typesEnvContents, "utf-8");
      addedTypes = true;
    }
    if (addedTypes) {
      logger.info("types", `Added ${bold(envTsPathRelativeToRoot)} type declarations`);
    }
  } else {
    let referenceDefs = [];
    referenceDefs.push('/// <reference types="astro/client" />');
    if (fs.existsSync(dotAstroDir)) {
      referenceDefs.push(...dotAstroTypeReferences);
    }
    await fs.promises.mkdir(settings.config.srcDir, { recursive: true });
    await fs.promises.writeFile(envTsPath, referenceDefs.join("\n"), "utf-8");
    logger.info("types", `Added ${bold(envTsPathRelativeToRoot)} type declarations`);
  }
}
function getDotAstroTypeReferences({
  fs,
  root,
  srcDir
}) {
  const { cacheDir } = getContentPaths({ root, srcDir });
  let referenceDefs = [];
  const typesFiles = [CONTENT_TYPES_FILE, ACTIONS_TYPES_FILE];
  for (const typesFile of typesFiles) {
    const url = new URL(typesFile, cacheDir);
    if (!fs.existsSync(url)) continue;
    const typesRelativeToSrcDir = normalizePath(
      path.relative(fileURLToPath(srcDir), fileURLToPath(url))
    );
    referenceDefs.push(`/// <reference path=${JSON.stringify(typesRelativeToSrcDir)} />`);
  }
  return referenceDefs;
}
export {
  astroInjectEnvTsPlugin,
  getEnvTsPath,
  setUpEnvTs
};
