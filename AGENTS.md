# Repository Guidelines

## Project Structure & Module Organization
- `src/` contains the Vite front-end source (ES modules, Tailwind entry in `index.css`, and UI modules like `nav.js`, `list.js`).
- `views/` holds Smarty templates (`layout.tpl`, `index.tpl`, `item.tpl`) used by the PHP layer.
- `public/` is the web root. PHP entrypoints live here (`index.php`, `getMetaData.php`), and Vite build output lands in `public/dist/`.
- `models/` contains PHP model classes (e.g., `Database.php`, `User.php`).
- Tooling/config lives in `vite.config.js`, `tailwind.config.js`, `eslint.config.js`, and `prettier.config.js`.

## Build, Test, and Development Commands
- `npm run dev`: start the Vite dev server with Tailwind in watch mode.
- `npm run build`: create a production build into `public/dist/`.
- `npm run serve`: preview the production build via Vite.
- `composer start`: run the PHP dev server at `http://localhost:8000` with `public/` as the docroot.

## Coding Style & Naming Conventions
- JavaScript uses ESM (`"type": "module"`). Keep modules small and focused (one UI concern per file).
- Formatting follows Prettier: 4-space indentation, single quotes, and no semicolons.
- Linting uses ESLint recommended rules; unused vars and undefined globals warn. Run manually with `npx eslint .` when needed.
- Prefer descriptive, lowerCamelCase for JS functions and variables; PHP classes should use PascalCase.

## Testing Guidelines
- There is no automated test runner configured yet. Validate changes by running the app and clicking through key flows.
- If you add tests in the future, document the command and naming convention here.

## Commit & Pull Request Guidelines
- Git history shows short, imperative messages (e.g., “Update .gitignore”, “updates”). Follow that style.
- PRs should include a clear description of changes, linked issues when applicable, and screenshots/GIFs for UI changes.

## Configuration & Security Notes
- Do not commit secrets or API keys; keep config in environment variables where possible.
- When adjusting build output, ensure `public/dist/` stays in sync with `npm run build`.
