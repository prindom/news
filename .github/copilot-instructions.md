# HackerNews Clone - Development Instructions

**Always reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.**

This is a HackerNews clone built with Vite + Vanilla JavaScript frontend and PHP backend using Dumbo framework with Smarty templates. The application fetches news from the HackerNews API and displays it in a modern, responsive interface with dark/light theme support.

## Prerequisites & Environment Setup

Ensure you have the required tools:
- Node.js v20+ and npm v10+
- PHP 8.3+ (with DOM extension for metadata parsing)
- Composer v2.8+

## Bootstrap & Build Process

**CRITICAL TIMING**: Follow these exact steps in order. NEVER CANCEL long-running operations:

### 1. Install Dependencies
```bash
# Install Node.js dependencies (takes ~8-10 seconds)
npm install

# Install PHP dependencies (takes 60+ minutes due to GitHub API rate limits)
# NEVER CANCEL: Set timeout to 90+ minutes minimum
composer install --no-interaction
```

**COMPOSER TROUBLESHOOTING**: If composer install hangs asking for GitHub token:
- Use `composer install --no-interaction` to avoid prompts
- The installation will fallback to cloning from source (slower but works)
- Total time: 60-90 minutes. DO NOT CANCEL.

### 2. Build the Frontend
```bash
# Build production assets (takes ~1-2 seconds)
npm run build
```

**Build output**: Creates optimized CSS and JS files in `public/dist/`:
- `public/dist/css/hn-news.css` (~15KB)
- `public/dist/js/main.js` (~77KB)

### 3. Development Servers

Run BOTH servers simultaneously for full functionality:

```bash
# Terminal 1: Vite development server (for asset hot-reloading)
npm run dev
# Runs on http://localhost:5173/ - for asset development only

# Terminal 2: PHP application server (for full app functionality)
php -S localhost:8000 -t public
# OR use composer script:
composer start
# Access full application at http://localhost:8000/
```

**IMPORTANT**: Always use http://localhost:8000/ for testing the complete application. The Vite server (localhost:5173) only serves static assets.

## Development Workflow

### Code Quality & Linting
```bash
# Lint JavaScript source code (excludes build output)
npx eslint src/

# Check code formatting (will show issues)
npx prettier --check .

# Fix formatting issues
npx prettier --write .

# Lint specific files only
npx eslint src/main.js src/item.js
```

**FORMATTING NOTE**: The codebase currently has formatting issues. Always run `npx prettier --write .` before committing changes.

## Application Testing & Validation

### Manual Validation Scenarios
After making changes, ALWAYS test these scenarios:

1. **Basic Navigation**:
   - Visit http://localhost:8000/
   - Click navigation buttons: "top", "new", "show", "best"
   - Verify URL changes to `/?type=new`, etc.
   - Test theme toggle (dark/light mode buttons)

2. **News Loading** (May fail in restricted environments):
   - News items should load from HackerNews API
   - If blocked: External APIs (hacker-news.firebaseio.com, hn.algolia.com) may be blocked
   - This is normal in sandbox environments - focus on UI/navigation testing

3. **Individual Item View**:
   - Visit http://localhost:8000/item/1 (or any number)
   - Verify item page template loads

4. **Search Functionality**:
   - Test search form submission
   - Verify search results page behavior

### Expected External Dependencies
The application loads these external resources (may be blocked in restricted environments):
- FontAwesome icons: `https://kit.fontawesome.com/7d20ea0579.js`
- Inter font: `https://rsms.me/inter/inter.css`
- HackerNews API: `https://hacker-news.firebaseio.com/v0/`
- Algolia HN Search: `https://hn.algolia.com/api/v1/`

## Key Project Structure

```
/
├── public/                 # PHP web root
│   ├── index.php          # Main PHP application entry
│   ├── getMetaData.php    # URL metadata parser
│   ├── dist/              # Built assets (generated)
│   │   ├── css/hn-news.css
│   │   └── js/main.js
│   └── assets/            # Static assets
├── src/                   # JavaScript source
│   ├── main.js           # Alpine.js application bootstrap
│   ├── item.js           # News item component
│   ├── list.js           # News list component
│   ├── nav.js            # Navigation component
│   ├── search.js         # Search functionality
│   └── *.js              # Other Alpine.js components
├── views/                # Smarty templates
│   ├── layout.tpl        # Base layout template
│   ├── index.tpl         # Homepage template
│   ├── item.tpl          # Individual item template
│   └── navigation.tpl    # Navigation partial
├── vendor/               # PHP dependencies (generated)
├── cache/                # Smarty template cache (generated)
└── config/               # Application configuration
```

## Build & CI Information

The `.github/workflows/deployment.yml` pipeline:
1. Runs `npm i` (Node.js setup)
2. Runs `npm run build` (builds frontend assets)
3. Deploys via FTP to production server

**Production deployment**: The app deploys to `news.redslate.net` via FTP.

## Common Development Tasks

### Making JavaScript Changes
1. Edit files in `src/` directory
2. Run `npm run build` to compile changes
3. Test at http://localhost:8000/ (not localhost:5173)
4. Run `npx eslint src/` before committing

### Making PHP/Template Changes
1. Edit PHP files in `public/` or templates in `views/`
2. No build step required - changes are immediate
3. Test at http://localhost:8000/
4. Check for PHP syntax errors in browser or server logs

### Making CSS/Styling Changes
1. Edit `src/index.css` (uses Tailwind CSS)
2. Run `npm run build` to recompile CSS
3. CSS is processed through PostCSS + Tailwind + Autoprefixer
4. Output: `public/dist/css/hn-news.css`

## Technology Stack Summary

- **Frontend**: Vite + Vanilla JavaScript + Alpine.js + Tailwind CSS
- **Backend**: PHP 8.3+ + Dumbo framework + Smarty templates
- **Build**: Vite for frontend assets, no backend build needed
- **APIs**: HackerNews Firebase API, Algolia HN Search API
- **Deployment**: FTP to production server

## Troubleshooting

### Build Issues
- **npm install fails**: Check Node.js version (requires v20+)
- **composer install hangs**: Use `--no-interaction` flag and wait 60+ minutes
- **Build output missing**: Run `npm run build` before testing

### Runtime Issues
- **Blank page**: Check PHP server is running on port 8000
- **No news items**: External APIs may be blocked (normal in restricted environments)
- **CSS not loading**: Ensure `npm run build` completed successfully
- **JavaScript errors**: Check ESLint output and browser console

### Development Server Issues
- **Port conflicts**: PHP server uses port 8000, Vite uses 5173
- **Hot reload not working**: Use Vite dev server for CSS/JS development, PHP server for testing

**Remember**: Always test complete scenarios after changes, not just individual components.