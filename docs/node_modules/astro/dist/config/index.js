import { Logger } from "../core/logger/core.js";
function defineConfig(config) {
  return config;
}
function getViteConfig(inlineConfig, inlineAstroConfig = {}) {
  return async ({ mode, command }) => {
    const cmd = command === "serve" ? "dev" : command;
    const [
      fs,
      { mergeConfig },
      { nodeLogDestination },
      { resolveConfig, createSettings },
      { createVite },
      { runHookConfigSetup, runHookConfigDone },
      { astroContentListenPlugin }
    ] = await Promise.all([
      import("node:fs"),
      import("vite"),
      import("../core/logger/node.js"),
      import("../core/config/index.js"),
      import("../core/create-vite.js"),
      import("../integrations/hooks.js"),
      import("./vite-plugin-content-listen.js")
    ]);
    const logger = new Logger({
      dest: nodeLogDestination,
      level: "info"
    });
    const { astroConfig: config } = await resolveConfig(inlineAstroConfig, cmd);
    let settings = await createSettings(config, inlineConfig.root);
    settings = await runHookConfigSetup({ settings, command: cmd, logger });
    const viteConfig = await createVite(
      {
        mode,
        plugins: [
          // Initialize the content listener
          astroContentListenPlugin({ settings, logger, fs })
        ]
      },
      { settings, logger, mode }
    );
    await runHookConfigDone({ settings, logger });
    return mergeConfig(viteConfig, inlineConfig);
  };
}
export {
  defineConfig,
  getViteConfig
};
