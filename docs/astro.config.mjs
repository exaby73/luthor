import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";

import tailwind from "@astrojs/tailwind";

// https://astro.build/config
export default defineConfig({
  site: "https://luthor.dev",
  base: "/",
  integrations: [
    starlight({
      title: "Luthor",
      head: [
        {
          tag: "script",
          attrs: {
            defer: true,
            src: "https://cdn.jsdelivr.net/npm/alpinejs@3.14.0/dist/cdn.min.js",
          },
        },
        {
          tag: "script",
          attrs: {
            src: "/code-gen-switcher.js",
          },
        },
      ],
      social: {
        github: "https://github.com/exaby73/luthor",
      },
      sidebar: [
        {
          label: "Home",
          link: "/",
        },
        {
          label: "Get Started",
          link: "/get-started",
        },
      ],
      editLink: {
        baseUrl: "https://github.com/exaby73/luthor/docs/edit/docs/",
      },
      components: {
        ThemeProvider: "./src/components/ThemeProvider.astro",
        ThemeSelect: "./src/components/ThemeSelect.astro",
        SiteTitle: "./src/components/SiteTitle.astro",
        Sidebar: "./src/components/Sidebar.astro",
        Pagination: "./src/components/Pagination.astro",
        Hero: "./src/components/Hero.astro",
        EditLink: "./src/components/EditLink.astro",
      },
      customCss: [
        "@fontsource-variable/space-grotesk/index.css",
        "@fontsource/space-mono/400.css",
        "@fontsource/space-mono/700.css",
        "./src/styles/theme.css",
      ],
      expressiveCode: {
        themes: ["github-dark"],
      },
      pagination: false,
      lastUpdated: true,
    }),
    tailwind(),
  ],
  output: "static",
});
