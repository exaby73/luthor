---
name: Luthor docs
description: Validation docs set as a test report. Report paper, 1px hairlines, colour rationed by role.
colors:
  paper-dark: "#13161c"
  paper-light: "#f7f8fa"
  ink-dark: "#eef0f3"
  ink-light: "#15181e"
  text-dark: "#b9bfca"
  text-light: "#3b414d"
  text-strong-dark: "#dde0e6"
  text-strong-light: "#262a33"
  muted-dark: "#8a92a1"
  muted-light: "#5f6673"
  faint-dark: "#5d6574"
  faint-light: "#8a919e"
  rule-dark: "#2b303a"
  rule-light: "#cfd3db"
  hairline-dark: "#262b34"
  hairline-light: "#dcdfe6"
  hairline-soft-dark: "#2b303a"
  hairline-soft-light: "#d6dae2"
  code-bg-dark: "#0e1015"
  code-bg-light: "#ffffff"
  code-chrome-dark: "#171a21"
  code-chrome-light: "#f0f2f5"
  inline-code-bg-dark: "#1e232b"
  inline-code-bg-light: "#e6e9ee"
  pass-green-dark: "#5ccf97"
  pass-green-light: "#0d7a47"
  pass-green-high-dark: "#8fe0b8"
  pass-green-high-light: "#0a5e37"
  pass-green-low-dark: "#173426"
  pass-green-low-light: "#d8f0e2"
  fail-red-dark: "#f08279"
  fail-red-light: "#b3261e"
  caution-amber-dark: "#e2b04f"
  caution-amber-light: "#8a5600"
  note-blue-dark: "#86a9f5"
  note-blue-light: "#2457c5"
  syntax-purple-dark: "#c2a7f5"
  syntax-purple-light: "#6b43c4"
  on-accent-dark: "#0f1b15"
  on-accent-light: "#ffffff"
  selection-dark: "rgba(92, 207, 151, 0.28)"
  selection-light: "rgba(13, 122, 71, 0.2)"
  backdrop-dark: "rgba(10, 12, 16, 0.7)"
  backdrop-light: "rgba(40, 46, 58, 0.5)"
typography:
  display:
    fontFamily: "Atkinson Hyperlegible Next Variable, system-ui, sans-serif"
    fontSize: "clamp(2.125rem, 1.4rem + 2.6vw, 3.25rem)"
    fontWeight: 700
    lineHeight: 1.05
    letterSpacing: "-0.025em"
  headline:
    fontFamily: "Atkinson Hyperlegible Next Variable, system-ui, sans-serif"
    fontSize: "clamp(2rem, 1.45rem + 1.8vw, 2.625rem)"
    fontWeight: 700
    lineHeight: 1.1
    letterSpacing: "-0.02em"
  title:
    fontFamily: "Atkinson Hyperlegible Next Variable, system-ui, sans-serif"
    fontSize: "1.5rem"
    fontWeight: 650
    lineHeight: 1.15
    letterSpacing: "-0.015em"
  subtitle:
    fontFamily: "Atkinson Hyperlegible Next Variable, system-ui, sans-serif"
    fontSize: "1.1875rem"
    fontWeight: 650
    lineHeight: 1.15
    letterSpacing: "-0.01em"
  lead:
    fontFamily: "Atkinson Hyperlegible Next Variable, system-ui, sans-serif"
    fontSize: "1.125rem"
    fontWeight: 400
    lineHeight: 1.55
  body:
    fontFamily: "Atkinson Hyperlegible Next Variable, system-ui, sans-serif"
    fontSize: "1rem"
    fontWeight: 400
    lineHeight: 1.65
  small:
    fontFamily: "Atkinson Hyperlegible Next Variable, system-ui, sans-serif"
    fontSize: "0.875rem"
    fontWeight: 400
    lineHeight: 1.5
  label:
    fontFamily: "Atkinson Hyperlegible Next Variable, system-ui, sans-serif"
    fontSize: "0.8125rem"
    fontWeight: 650
    lineHeight: 1.4
    letterSpacing: "0.01em"
  code:
    fontFamily: "Atkinson Hyperlegible Mono Variable, ui-monospace, monospace"
    fontSize: "0.875rem"
    fontWeight: 400
    lineHeight: 1.6
  code-small:
    fontFamily: "Atkinson Hyperlegible Mono Variable, ui-monospace, monospace"
    fontSize: "0.8125rem"
    fontWeight: 400
    lineHeight: 1.4
rounded:
  none: "0"
  sm: "0.125rem"
spacing:
  "1": "0.25rem"
  "2": "0.5rem"
  "3": "0.75rem"
  "4": "1rem"
  "5": "1.25rem"
  "6": "1.5rem"
  "8": "2rem"
  "10": "2.5rem"
  "12": "3rem"
  "14": "3.5rem"
components:
  link-inline:
    textColor: "{colors.pass-green-dark}"
    typography: "{typography.body}"
  link-inline-hover:
    textColor: "{colors.pass-green-high-dark}"
  link-hero-primary:
    textColor: "{colors.ink-dark}"
    typography: "{typography.body}"
    height: "2.75rem"
  link-hero-primary-hover:
    textColor: "{colors.pass-green-dark}"
  inline-code:
    backgroundColor: "{colors.inline-code-bg-dark}"
    textColor: "{colors.ink-dark}"
    rounded: "{rounded.sm}"
    padding: "0.1em 0.35em"
  search-trigger:
    backgroundColor: "{colors.code-bg-dark}"
    textColor: "{colors.muted-dark}"
    rounded: "{rounded.sm}"
    height: "2.25rem"
    padding: "0 0.5rem 0 0.625rem"
    typography: "{typography.small}"
  search-trigger-hover:
    textColor: "{colors.ink-dark}"
  menu-button:
    backgroundColor: "{colors.code-bg-dark}"
    textColor: "{colors.ink-dark}"
    rounded: "{rounded.sm}"
    width: "2.25rem"
    height: "2.25rem"
    padding: "0.375rem"
  sidebar-link:
    textColor: "{colors.text-dark}"
    rounded: "{rounded.none}"
    padding: "0.3rem 0.5rem 0.3rem 0.875rem"
    typography: "{typography.small}"
  sidebar-link-current:
    textColor: "{colors.ink-dark}"
    rounded: "{rounded.none}"
  tab:
    textColor: "{colors.muted-dark}"
    padding: "0.45rem 0.75rem"
    typography: "{typography.small}"
  tab-selected:
    textColor: "{colors.ink-dark}"
  aside:
    textColor: "{colors.text-strong-dark}"
    rounded: "{rounded.sm}"
    padding: "0.875rem 1rem"
    typography: "{typography.small}"
  report-figure:
    backgroundColor: "{colors.code-bg-dark}"
    textColor: "{colors.text-strong-dark}"
    rounded: "{rounded.sm}"
    typography: "{typography.code}"
  report-figure-head:
    backgroundColor: "{colors.code-chrome-dark}"
    textColor: "{colors.muted-dark}"
    padding: "0.5rem 1rem"
    typography: "{typography.code-small}"
  pagination-link:
    textColor: "{colors.muted-dark}"
    rounded: "{rounded.sm}"
    padding: "0.875rem 1rem"
    typography: "{typography.code-small}"
  index-row:
    textColor: "{colors.text-dark}"
    padding: "0.5rem 0.25rem"
    height: "2.5rem"
    typography: "{typography.small}"
  index-row-hover:
    textColor: "{colors.ink-dark}"
---

# Design System: Luthor docs

## Overview

**Creative North Star: "The test report"**

The site is set like the output of `dart test`. Every example states an input and prints the verdict beside it, with a `+passed -failed` counter in the corner and a `Which:` line under each failure. The page is the paper that report prints on. Light mode is a cool near-white sheet with iron ink. Dark mode is a graphite panel with a blue cast and bone ink. Both modes use the same 1px hairlines and the same five colour roles.

Density is high and even. Prose sits in a 46rem measure. Headings, code blocks, verdict figures, and tables all start on the same left edge. Rules separate sections; fills do not. State is shown with a mark (a 2px rule, a bracket, an underline), never with a tinted background on the whole element. The two exceptions are the hover tint on index rows and the 8 percent tint behind asides, both drawn at a strength that reads as paper, not as a card.

The build refused the stock docs hero with two pill buttons, cards, gradients, glow, and drop shadows on content. One motion exists: the landing report reveals its rows in sequence while the counter ticks. Nothing else moves beyond 120ms colour transitions.

**Key Characteristics:**
- Two full palettes (dark `:root`, light `[data-theme='light']`) with identical role assignments.
- Pass green is the only accent. It marks links, the current page, passed rows, focus, and the mark.
- Every rule, border, and divider is 1px. Current-item markers and the primary underline are 2px.
- One radius, 0.125rem. Several elements are square.
- One sans (Atkinson Hyperlegible Next) for prose and UI, its mono sibling for code, counters, and the figure.
- No shadows on content. The search dialog is the only shadowed surface.

## Colors

Two neutral ramps carry the page, and five chromatic roles are each permitted in named places only.

### Primary
- **Pass green** (`pass-green-dark` / `pass-green-light`): links in prose, the current sidebar item's 2px rule, the current table-of-contents rule, the selected tab's 2px underline, the active editor tab indicator, the passed glyph and `+n` counter in the report figure, the focus bracket, the step counters, the site mark, tip asides, the copy-success tooltip, text selection, the caret, and `accent-color` on form controls. Hover on a prose link moves to the high step (`pass-green-high-*`). The low step (`pass-green-low-*`) is defined but used only through Starlight internals.

### Secondary
- **Fail red** (`fail-red-dark` / `fail-red-light`): the failed glyph, the `-n` counter, and the `Which:` message in the report figure; deleted lines in diff code blocks; danger asides. Red never marks an interactive element.
- **Caution amber** (`caution-amber-dark` / `caution-amber-light`): caution asides only.

### Tertiary
- **Note blue** (`note-blue-dark` / `note-blue-light`): note asides and syntax highlighting.
- **Syntax purple** (`syntax-purple-dark` / `syntax-purple-light`): syntax highlighting only. Never appears in UI chrome.

### Neutral
- **Paper** (`paper-dark` #13161c / `paper-light` #f7f8fa): page, header, and sidebar background. The three share one value; there is no panel tint.
- **Ink** (`ink-dark` / `ink-light`): headings, strong text, the current nav item, hovered links in chrome, and the identifier column in the report figure and index.
- **Text strong** (`text-strong-*`): aside body text and the report figure's default text.
- **Text** (`text-dark` / `text-light`): body prose, sidebar links at rest, footer links.
- **Muted** (`muted-dark` / `muted-light`): table headers, table-of-contents links, group labels, the report head, captions, meta lines, pagination labels, blockquotes.
- **Faint** (`faint-dark` / `faint-light`): carets, terminal dots, the blockquote rule, the secondary hero underline, footer separators.
- **Hairline** (`hairline-dark` / `hairline-light`): every 1px border and rule. `hairline-soft-*` is the sidebar and table-of-contents rail, and the step connector. `rule-*` is the heavier table header underline and the scrollbar thumb.
- **Code background** (`code-bg-*`): code blocks, the report figure, the search trigger, the menu button, and the mobile table-of-contents toggle. In light mode this is pure white sitting on the off-white sheet.
- **Code chrome** (`code-chrome-*`): editor tab bars, terminal title bars, and the report figure head.
- **Inline code background** (`inline-code-bg-*`): inline `code` in prose.

### Named rules
**The rationed colour rule.** Green is for links, current position, passed verdicts, and focus. Red is for failed verdicts, error text, deletions, and danger asides. Amber is for caution asides. Blue and purple are for syntax and note asides. Anything not on that list is a neutral. A new element that wants colour has to name which role it is.

**The same-paper rule.** Header, sidebar, and content share one background value in each theme. Depth comes from the hairline between them, not from a tonal step.

**The two-theme rule.** Every colour token has a dark and a light value with the same role. Code blocks use github-dark-default and github-light-default with their backgrounds replaced by the code background token, so code sits on the same paper as the figure next to it.

## Typography

**Display and body font:** Atkinson Hyperlegible Next Variable (self-hosted through fontsource), falling back to system-ui.
**Code and counter font:** Atkinson Hyperlegible Mono Variable (self-hosted through fontsource), falling back to ui-monospace.

**Character:** One family in two cuts. The sans has unambiguous glyphs for I, l, 1, O, and 0, which matters in docs that print identifiers in prose. The mono matches its x-height, so an inline `code` span at 0.875em sits on the same baseline as the words around it. Numerals are tabular everywhere (`font-variant-numeric: tabular-nums` on `body`) so counters and version numbers do not shift. Ligatures are off in code.

### Hierarchy
- **Display** (700, clamp 2.125rem to 3.25rem, 1.05, -0.025em): the landing headline only.
- **Headline** (700, clamp 2rem to 2.625rem, 1.1, -0.02em): the page title `h1` on every docs page, balanced wrapping.
- **Title** (650, 1.5rem, 1.15, -0.015em): `h2`. Each one opens a ruled section with a 1px top hairline, 3rem above (3.5rem on the landing page) and 1.25rem of padding under the rule.
- **Subtitle** (650, 1.1875rem, 1.15, -0.01em): `h3`, 2rem above. `h4` is 650 at 1rem, 1.5rem above.
- **Lead** (400, 1.125rem, 1.55): the one-sentence landing lead under the display line.
- **Body** (400, 1rem, 1.65): prose in a 46rem column. Links underline at 1px in green at 45 percent, offset 0.2em, and go solid on hover.
- **Small** (400, 0.875rem, 1.5): tables, aside bodies, sidebar links, tabs, hero facts, footer meta.
- **Label** (650, 0.8125rem, 1.4, 0.01em): sidebar group labels, table-of-contents heading, table headers, aside titles, API index group labels, pagination labels. Mixed case. Nested sidebar group labels drop to 0.75rem in muted.
- **Code** (400, 0.875rem, 1.6): code blocks and the report figure. Inline code is 0.875em of its context. `code-small` (0.8125rem) is the identifier column in the API index and the editor tab labels.

### Named rules
**The weight ladder rule.** Four weights, and each has one job. 400 is reading text. 500 is the secondary hero link and the search input. 600 is the current nav item, the selected tab, the hero links, and fact values. 650 is every heading from `h2` down, strong text, and labels. 700 is `h1`, the wordmark, and the pass or fail glyph.

**The tight-heading rule.** Letter spacing tightens as size grows: -0.025em on display, -0.02em on headline, -0.015em on title, -0.01em on subtitle, 0 on body, +0.01em on labels. No heading is uppercase.

## Layout

Starlight's three-pane frame with a 17rem left sidebar, a 46rem content column, and a right table-of-contents rail. The panes share one background and are separated by 1px hairlines on the sidebar's right edge, the rail's left edge, and under the header. Both rails draw a 1px vertical hairline down the left of their link lists; the current item lays a 2px green rule over that hairline, inset -1px so the two coincide.

The landing page widens the container to 72rem and keeps prose children capped at 46rem. Its first viewport is a two-column grid at 64rem and up, `minmax(0, 5fr) minmax(0, 6fr)` with a 4rem column gap and 3rem of top padding; below 64rem it stacks with a 2.5rem row gap and 1.5rem top padding. The copy column caps at 34rem. The API index runs in CSS columns: one below 40rem, two to 64rem, three above, with a 3rem column gap and groups that do not break across columns.

Spacing steps are quarter-rem multiples. Inside components: 0.25rem, 0.5rem, 0.75rem, 1rem. Between blocks: 1.25rem above a code block and 1.5rem below, 1.5rem above a report figure, 2rem above an `h3`, 2.5rem around an `hr`, 3rem above an `h2` and above the footer. The sidebar separates top-level groups by 1.5rem and starts 1.5rem down. Cell padding in tables is 0.55rem by 0.75rem with the first and last cells flush to the column edges, so table text aligns with the prose edge.

Interactive targets at phone width are at least 2.75rem tall (sidebar links, mobile table-of-contents items, hero links). The search trigger collapses to a 2.25rem square icon button below 50rem and grows to a 22rem field above it. Tables below 40rem scroll sideways with identifiers kept whole; the last column holds a 16rem minimum.

## Elevation & Depth

Flat. Content surfaces have no shadows: Starlight's small shadow token is set to `none`, Expressive Code frames have their shadow removed, and the pagination links, menu button, and step counters all carry `box-shadow: none` explicitly. Depth is drawn with hairlines and with the two code surfaces: code background sits slightly darker than the paper in dark mode and pure white against the off-white sheet in light mode, and code chrome (tab bars, the report head) is one step toward the paper from that.

### Shadow vocabulary
- **Dialog** (`box-shadow: 0 16px 40px rgba(0, 0, 0, 0.45)` dark, `0 16px 40px rgba(20, 24, 32, 0.16)` light): the search dialog only, over a flat backdrop overlay with no blur.
- **Overlay** (`0 8px 24px rgba(0, 0, 0, 0.35)` dark, `0 8px 24px rgba(20, 24, 32, 0.12)` light): the medium step Starlight reserves for popovers. Not used by any authored component.

### Named rules
**The hairline rule.** Every border, divider, and rail is 1px of the hairline token. The only lines heavier than that are state marks: the 2px current rule, the 2px tab and editor-tab indicator, the 2px underline on hero links and the hovered wordmark, and the 2px code line-marker accent.

**The mark-not-fill rule.** Current, selected, and focused states are drawn as lines beside or under the element. Backgrounds change only on hover of an index row (green at 8 percent) and the open menu button (one neutral step).

## Shapes

Corners are 0.125rem (`--lu-radius`) on everything that has a corner: code frames, the report figure, asides, the search trigger and dialog, the menu button, inline code, pagination links, `kbd`, the copy button, and the theme select. Sidebar links, editor tabs, the step counter, and table cells are square. Nothing is pill-shaped or circular; Starlight's round menu button and round step badges were squared.

Borders are 1px solid hairline. The report figure separates its rows with a 1px dashed hairline at 65 percent, the one dashed line in the system. Asides keep a uniform 1px border on all four sides in the role colour, not a thick left bar. Blockquotes and definition descriptions carry a 1px left rule. The site mark and favicon are a single stroked path at 2.5 stroke width with square caps and mitre joins.

## Components

### Links
- **Prose:** green text, 1px underline in green at 45 percent opacity, offset 0.2em. Hover moves text to the high green and the underline to solid. 120ms colour transition. Inline code inside a link inherits the link colour.
- **Hero links:** ink text at 600 with a 2px green underline offset 0.3em, 2.75rem minimum height. The secondary hero link is 500 with a faint-grey underline. Both turn green on hover and focus. There are no buttons on the site.
- **Footer colophon:** text grey, no underline at rest, separated by `/` in faint grey. Hover goes to ink with a green underline.

### Focus
Two vertical bars either side of the element, drawn with `box-shadow: -5px 0 0 -1px green, 5px 0 0 -1px green` and a transparent 2px outline so the bracket is the only visible ring. Inputs use the same bracket at 4px without spread. Sidebar links use an inset 2px left rule instead so the bracket does not collide with the rail. Index rows pull the focus outline 2px inward.

### Search trigger and menu button
- **Shape:** 2.25rem tall, 0.125rem radius, 1px hairline border, code background.
- **Search:** muted text, 0.875rem, with a `kbd` hint in mono at 0.75rem inside its own hairline box. Hover and focus lift the border to faint grey and the text to ink.
- **Menu button:** 2.25rem square, ink icon. While the menu is open the background steps to the panel grey and the border to faint grey.
- **Dialog:** paper background, 1px hairline, 0.125rem radius, the one shadow, flat backdrop overlay. Result highlights are green text on an 8 to 10 percent green tint with a 1px green bottom border.

### Navigation
- **Sidebar:** group labels at label size in ink, nested group labels at 0.75rem muted. Links are small text in text grey with 0.3rem by 0.5rem padding, no radius, no background in any state. Hover goes to ink. The current page is ink at 600 with a 2px green rule over the group's 1px rail. Carets are faint grey and go to ink on hover.
- **Table of contents:** muted 0.8125rem links on a 1px rail; the current entry is ink at 600 with the same 2px green rule.
- **Mobile:** sidebar links and table-of-contents items grow to 2.75rem rows at body size. The mobile table-of-contents toggle is the same square-cornered hairline box as the search trigger and its border turns green while open.
- **Site title:** the L mark in green at 26px beside the wordmark at 1.25rem, 700, -0.02em. Hover underlines the wordmark 2px in green.

### Tabs
Hairline under the whole tab list; tabs are small text in muted with 0.45rem by 0.75rem padding and a 2px transparent bottom border overlapping the hairline by 1px. Hover goes to ink with a faint-grey border; the selected tab is ink at 600 with a green border. Every hand-written versus generated comparison uses `<Tabs syncKey="codegen">` so the reader's choice persists across all 34 pages that carry it.

### Code blocks
Expressive Code with a 1px hairline frame at 0.125rem, code background, 0.875rem mono at 1.6, 0.875rem by 1.125rem padding. Editor tab bars and terminal title bars use the code chrome colour with a hairline underneath; the active tab is code background with a 2px green indicator on top and square corners. Line markers are a 2px accent: green for `mark` and `ins`, red for `del`, each over an 8 to 12 percent tint. The copy button is a hairline box on code background and its success tooltip is green with on-accent text.

### Asides
1px border on all sides in the role colour, 0.125rem radius, a tint of that colour at 8 percent, 0.875rem by 1rem padding. Title at label size, body at small size in strong text. Note is blue, tip is green, caution is amber, danger is red. Links inside an aside take the aside's colour.

### Tables
Full width, collapsed, small text at 1.5. No vertical rules, no stripes. Every cell has a 1px hairline underneath; headers are label size in muted with the heavier rule-grey underline. First and last cells are flush to the column edges. Code in cells does not wrap.

### Steps
Counters are green mono at 700 on the paper with no badge, no radius, no shadow. A 1px soft hairline connects the steps. The first line of each step is ink.

### Pagination
Hairline boxes at 0.125rem with 0.875rem by 1rem padding, no shadow. Labels at 0.8125rem muted, titles at 1.0625rem ink at 600, arrows in green. The border turns green on hover.

### API index
Groups with label-size muted headings over a list that opens with a 1px top hairline and rules each row underneath. Each row is a link laid out as a two-column grid, `minmax(9.5rem, auto) 1fr`, identifier in code-small ink on the left and a small-text summary on the right, 2.5rem minimum height. Hover tints the row green at 8 percent and turns the identifier green. Below 26rem the row stacks to one column.

### Report figure (signature)
`Verdict.astro`. A `figure` on code background with a 1px hairline and 0.125rem corners, set entirely in mono at 0.875rem. The head is code chrome with a hairline underneath, the validator expression in text grey on the left and the `+n -n` counter on the right, green then red, tabular, 0.02em tracking. Rows are a `1.25rem 1fr` grid: a bold `+` or `-` glyph in the verdict colour, the input as Dart source in ink, and for failures one `Which:` line per message in red with the `Which:` prefix in muted. Rows are separated by the dashed hairline. A visually hidden "valid:" or "invalid:" prefix carries the verdict for screen readers, and the counter carries an `aria-label`.

On the landing page only, `animate` reveals rows one at a time: each row fades in from 4px left over 420ms on `cubic-bezier(0.16, 1, 0.3, 1)`, starting at 200ms and stepping 180ms per row, while a script increments the counter 120ms after each row lands. Under `prefers-reduced-motion: reduce` the animation is off and the final count is already in the markup. The figure appears 45 times across the content and is the way every example states its result.

## Do's and Don'ts

### Do:
- **Do** print the verdict. An example that validates something ends in a report figure or a `switch` over the result, never in "this passes".
- **Do** draw every border, rail, and divider at 1px with the hairline token, and reserve 2px for current, selected, and focus marks.
- **Do** keep green for links, current position, passed verdicts, and focus; red for failed verdicts, error text, deletions, and danger asides; amber for caution asides.
- **Do** use 0.125rem on anything with a corner and square corners on sidebar links, tabs, and step counters.
- **Do** keep hand-written and generated code in `<Tabs syncKey="codegen">` so the switch persists across pages.
- **Do** set counters, versions, and the pass or fail numbers in the mono with tabular numerals.
- **Do** keep new motion behind `prefers-reduced-motion` and limit it to one authored moment per page; colour transitions stay at 120ms.
- **Do** give every colour a dark and a light value with the same role before using it.

### Don't:
- **Don't** add buttons, pills, filled call-to-action blocks, or cards. Interactive text is a link with an underline.
- **Don't** add shadows, gradients, glow, or backdrop blur to content. The search dialog is the only shadowed surface.
- **Don't** tint the header or sidebar a different value from the content paper.
- **Don't** mark current or selected state with a filled background. Use the 2px rule or underline.
- **Don't** use purple or blue in UI chrome; they belong to syntax highlighting and note asides.
- **Don't** use uppercase or letter-spaced labels above headings. Labels are mixed case at 650 and name a group of items.
- **Don't** stripe tables or add vertical rules to them.
- **Don't** colour a link red or amber; those roles are verdicts and warnings, not affordances.
