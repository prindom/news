# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

HackerNews clone: Vite + Alpine.js + Tailwind CSS frontend with a PHP (Dumbo + Smarty) backend. Data comes from HackerNews Firebase API and Algolia HN Search API.

## Commands

- `npm run dev` — Vite dev server with Tailwind watch (localhost:5173, assets only)
- `npm run build` — Production build to `public/dist/`
- `composer start` — PHP server at localhost:8000 (full app)
- `npx eslint src/` — Lint JavaScript
- `npx prettier --check .` — Check formatting
- `npx prettier --write .` — Fix formatting

Run both `npm run dev` and `composer start` simultaneously for development. Always test at localhost:8000, not localhost:5173.

## Architecture

**Frontend** (`src/`): Alpine.js components registered via `Alpine.data()`. Global state uses `Alpine.store('current')` for feed type and `Alpine.store('itemID')`. Each JS file exports one Alpine data factory function. Entry point is `src/main.js`.

**Backend** (`public/index.php`): Dumbo micro-framework routes. `GET /` renders `index.tpl`, `GET /item/:id` renders `item.tpl`. Templates in `views/` use Smarty engine.

**Data flow**: Smarty renders HTML server-side → Alpine.js hydrates on client → components fetch from HN Firebase API (`/v0/{type}stories.json`, `/v0/item/{id}.json`) and Algolia (`/api/v1/search`, `/api/v1/items/{id}`).

**Build output**: Vite builds `src/main.js` → `public/dist/js/main.js` + `public/dist/css/hn-news.css`. PHP changes need no build step.

## Code Style

- ESM modules (`"type": "module"`), one UI concern per file
- Prettier: 4-space indent, single quotes, no semicolons, trailing commas (es5)
- ESLint: recommended rules, `no-unused-vars` and `no-undef` as warnings
- JS: lowerCamelCase. PHP classes: PascalCase
- Always run `npx prettier --write .` before committing

## Prerequisites

- Node.js v20+, npm v10+
- PHP 8.3+ (with DOM extension)
- Composer v2.8+

Note: `composer install` can take 60+ minutes due to GitHub API rate limits. Always use `--no-interaction` flag.

## Testing

No automated tests. Validate manually: navigation between feeds (top/new/best/show), item detail pages, search (Cmd/Ctrl+K), dark/light theme toggle.
