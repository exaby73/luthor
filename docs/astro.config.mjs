import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

import tailwind from '@astrojs/tailwind';

// https://astro.build/config
export default defineConfig({
  site: 'https://luthor.ex3.dev',
  base: '/',
  integrations: [
    starlight({
      title: 'Luthor',
      head: [
        {
          tag: 'script',
          attrs: {
            defer: true,
            src: 'https://cdn.jsdelivr.net/npm/alpinejs@3.14.0/dist/cdn.min.js',
          },
        },
        {
          tag: 'script',
          attrs: {
            src: '/code-gen-switcher.js',
          },
        },
      ],
      social: {
        github: 'https://github.com/exaby73/luthor',
      },
      sidebar: [
        {
          label: 'Basics',
          items: [
            {
              label: 'Installation',
              link: '/installation',
            },
            {
              label: 'Concepts',
              link: '/concepts',
            },
            {
              label: 'Validation Result',
              link: '/result',
            },
            {
              label: 'Comprehensive Example',
              link: '/comprehensive-example',
            },
          ],
        },
        {
          label: 'Single Values',
          items: [
            {
              label: 'Int',
              link: '/single-values/int',
            },
            {
              label: 'Double',
              link: '/single-values/double',
            },
            {
              label: 'Num',
              link: '/single-values/num',
            },
            {
              label: 'Bool',
              link: '/single-values/bool',
            },
            {
              label: 'String',
              link: '/single-values/string',
            },
            {
              label: 'Null',
              link: '/single-values/null',
            },
            {
              label: 'Dynamic',
              link: '/single-values/dynamic',
            },
            {
              label: 'List',
              link: '/single-values/list',
            },
            {
              label: 'Map',
              link: '/single-values/map',
            },
          ],
        },
        {
          label: 'Modifiers',
          items: [
            {
              label: 'Required',
              link: '/modifiers/required',
            },
            {
              label: 'Custom',
              link: '/modifiers/custom',
            },
            {
              label: 'Number Modifiers',
              items: [
                {
                  label: 'Min',
                  link: '/modifiers/number-modifiers/min',
                },
                {
                  label: 'Max',
                  link: '/modifiers/number-modifiers/max',
                },
              ],
            },
            {
              label: 'String Modifiers',
              items: [
                {
                  label: 'Min',
                  link: '/modifiers/string-modifiers/min',
                },
                {
                  label: 'Max',
                  link: '/modifiers/string-modifiers/max',
                },
                {
                  label: 'Length',
                  link: '/modifiers/string-modifiers/length',
                },
                {
                  label: 'Contains',
                  link: '/modifiers/string-modifiers/contains',
                },
                {
                  label: 'Starts With',
                  link: '/modifiers/string-modifiers/starts-with',
                },
                {
                  label: 'Ends With',
                  link: '/modifiers/string-modifiers/ends-with',
                },
                {
                  label: 'DateTime',
                  link: '/modifiers/string-modifiers/date-time',
                },
                {
                  label: 'Email',
                  link: '/modifiers/string-modifiers/email',
                },
                {
                  label: 'Emoji',
                  link: '/modifiers/string-modifiers/emoji',
                },
                {
                  label: 'Regex',
                  link: '/modifiers/string-modifiers/regex',
                },
                {
                  label: 'Uri',
                  link: '/modifiers/string-modifiers/uri',
                },
                {
                  label: 'URL',
                  link: '/modifiers/string-modifiers/url',
                },
                {
                  label: 'UUID',
                  link: '/modifiers/string-modifiers/uuid',
                },
                {
                  label: 'CUID',
                  link: '/modifiers/string-modifiers/cuid',
                },
                {
                  label: 'CUID 2',
                  link: '/modifiers/string-modifiers/cuid-2',
                },
              ],
            },
          ],
        },
        {
          label: 'Schemas',
          items: [
            {
              label: 'Defining schemas',
              link: '/schemas/defining-schemas',
            },
            {
              label: 'Code Generation',
              link: '/schemas/code-generation',
            },
          ],
        },
      ],
      editLink: {
        // Logic to handle the edit link in src/components/EditLink.astro
        baseUrl: 'https://example.com',
      },
      components: {
        ThemeProvider: './src/components/ThemeProvider.astro',
        ThemeSelect: './src/components/ThemeSelect.astro',
        SiteTitle: './src/components/SiteTitle.astro',
        Sidebar: './src/components/Sidebar.astro',
        Pagination: './src/components/Pagination.astro',
        Hero: './src/components/Hero.astro',
        EditLink: './src/components/EditLink.astro',
      },
      customCss: [
        '@fontsource-variable/space-grotesk/index.css',
        '@fontsource/space-mono/400.css',
        '@fontsource/space-mono/700.css',
        './src/styles/theme.css',
      ],
      expressiveCode: {
        themes: ['github-dark'],
      },
      pagination: false,
      lastUpdated: true,
    }),
    tailwind(),
  ],
  output: 'static',
});
