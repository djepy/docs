# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

The source for [docs.github.com](https://docs.github.com). It is a Node.js + Express server (originally Jekyll, then Nanoc) that dynamically renders Markdown content with Liquid templating to support multiple products, versions (GitHub.com, Enterprise Server, AE), and languages.

Requires Node.js 12–14 (`.node-version` is `14.13.0`; `package.json` engines is `12 - 14`).

## Common commands

```sh
npm install              # install dependencies
npm run build            # one-time webpack build of static assets (required before `start` works fully)
npm start                # dev server on :4000, NODE_ENV=development, English + Japanese only
npm run start-all-languages  # dev server with every language enabled (slow)
npm run debug            # same as start, but with --inspect for VS Code

npm test                 # jest + eslint + prettier check + check-deps (the full CI suite)
npm run lint             # eslint --fix + prettier -w on YAML
npm run test-watch       # jest in watch mode with coverage

jest path/to/file.js     # run a single test file (substring match works: `jest page` matches page.js + pages.js)
npx jest links-and-images  # run the broken-link/image test suite (takes ~60s)

npm run browser-test     # puppeteer-based end-to-end (requires `npm run build` first; runs against :4001)
npm run pa11y-test       # accessibility checks via pa11y-ci
```

The dev server is `nodemon server.js` — it reloads on content changes. Visit http://localhost:4000/dev-toc to see the internal table of contents (not exposed in production).

## Architecture

### Request pipeline

`server.js` boots Express, then `middleware/index.js` mounts every middleware in a deliberate order (the comments in that file declare the dependencies — e.g. `detect-language` must come before `context`, `context` must come before redirects/contextualizers, `find-page` must come before everything that reads `req.context.page`). When adding middleware, respect those ordering comments; many later steps assume `req.context` is fully populated.

Key middleware to know:
- `middleware/context.js` — builds `req.context` from `warmServer()` (site data, page map, redirects, site tree). All downstream rendering reads from this.
- `middleware/find-page.js` → `middleware/render-page.js` — locate the `Page` and render it through Liquid + Markdown.
- `middleware/redirects/handle-redirects.js` + `lib/redirects/` — old URLs (legacy help paths, `redirect_from` frontmatter) get rewritten here.
- `middleware/contextualizers/` — augment `req.context` with rendered GraphQL, REST, webhooks, and release-notes data before the page renders.

### Content model

- `content/**/*.md` — English source. Every page is Markdown with YAML frontmatter. The `versions` field is **required** and gates which product versions render the page; the schema is in `lib/frontmatter.js`. Liquid (`{% if currentVersion == ... %}`) conditionally renders inside pages.
- `data/` — `reusables/` (long shared strings, accessed via `{% data reusables.foo.bar %}`), `variables/` (short strings), `ui.yml` (layout strings), `graphql/`, `release-notes/`, `products.yml`.
- `includes/` + `layouts/` — Liquid partials and HTML layouts (default is `layouts/default.html`; pages can opt into another via `layout:` frontmatter).
- `lib/liquid-tags/` — custom Liquid tags (`{% data %}`, `{% octicon %}`, `{% link %}`, etc.); each tag is its own file.
- `translations/` — auto-synced via Crowdin. **Do not edit by hand**; a pre-commit hook (`script/prevent-translation-commits.js`) blocks commits that touch this directory.

Local links in content must start with a product ID (`/actions`, `/admin`, …) and images with `/assets`. The server rewrites them per-language and per-version (see `lib/rewrite-local-links` and `lib/rewrite-asset-paths-to-s3`).

### Versioning

Two layers, both important:
1. Page-level: the `versions:` frontmatter object (keys map to entries in `lib/all-versions.js`).
2. Inline: Liquid conditionals against `currentVersion` / `enterpriseServerVersions`.

When deprecating an Enterprise Server version or adding a new one, the relevant scripts live in `script/enterprise-server-deprecations/` and `script/enterprise-server-releases/`.

### Tests

Jest, with tests under `tests/` (note: `jest.config.js` matches `**/tests/**/*.js`, not the conventional `__tests__/`). Categories: `tests/content`, `tests/rendering`, `tests/routing`, `tests/links-and-images`, `tests/meta`, `tests/graphql`, `tests/browser`. Coverage thresholds are 95% for branches/functions/lines. Browser tests use `jest-puppeteer` and are gated by `BROWSER=1`; they require a built server on :4001.

## Repo-specific gotchas

- `npm test` includes `eslint` and `prettier -c "**/*.{yml,yaml}"` and `check-deps`. A formatting or unused-dependency issue will fail CI even if Jest is green. Run `npm run lint` first.
- Husky installs git hooks on `npm install`: pre-commit blocks `translations/` changes, pre-push blocks pushes to `main` (`script/prevent-pushes-to-main.js`).
- Windows portability is a stated requirement (see the bottom of `CONTRIBUTING.md`): use `\r?\n` in regexes, prefer `path.posix` / the `slash` module when building URLs, and write helper scripts in JavaScript (under `script/`) rather than Bash so they run cross-platform.
- The site uses `make-promises-safe` and `handle-exceptions` — unhandled rejections crash the process by design; don't swallow them.
- `script/update-readme.js` regenerates `script/README.md` from JSDoc-style comments in each script. If you add a script, add the descriptive comment block and re-run it.

## Plugin workflow (Claude Code on the web)

This repo has a SessionStart hook (`.claude/hooks/session-start.sh`) that installs `@intentsolutionsio/ccpi` and restores the marketplaces and plugins listed in `.claude/marketplaces.txt` and `.claude/plugins.txt` at the start of every web session. `.claude/plugins.txt` is a **trust boundary** — every entry runs code on session start.

When working on a task, follow this protocol — the user has explicitly opted into it:

1. **Plan first** for non-trivial work. Either a 2–5 line inline plan, or delegate to the `Plan` agent for large changes.
2. **Surface plugin needs** only when one would meaningfully help. Format: *"Plugin `<name>` would do `<X>`. Install + reload your session? (yes / no / skip)"*. Default is to use built-in tools; don't reach for a plugin unless it clearly replaces work you'd otherwise duplicate.
3. **On "yes"**: add the entry to `.claude/plugins.txt`, commit, open a PR via `mcp__github__create_pull_request`, merge via `mcp__github__merge_pull_request` (the local proxy blocks direct pushes to `main`). Then tell the user: *"Plugin is on `main`. Close this Claude tab, reopen, and say 'continue' — the new session will load it."* You **cannot** reload your own running session; do not attempt `exec claude --continue` from inside.
4. **On "no" / "skip"**: do the task with built-in tools, no friction.
5. **Plugin audit**: when the user asks (or proactively after roughly every 5–10 tasks), list the entries in `.claude/plugins.txt`, judge each against recent activity, and propose removals **one at a time** with a one-line rationale. The user approves each removal individually.

When bumping `CCPI_VERSION` in `.claude/hooks/session-start.sh`, read the upstream changelog of `@intentsolutionsio/ccpi` first — the pin exists to block silent supply-chain rolls.
