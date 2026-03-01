# README

This application is a **Progressive Web App (PWA)** with offline support and installability on mobile and desktop devices.

## Prerequisites

- Ruby 3.2.1
- Node.js and Yarn
- SQLite3

## Initial Setup

### 1. Install Ruby Dependencies
```bash
bundle install
```

### 2. Install Node.js Dependencies
```bash
yarn install
```

### 3. Setup Database
```bash
rails db:create
rails db:migrate
rails db:seed
```

### 4. Build Assets (Required before first run)
This application uses `cssbundling-rails` and `jsbundling-rails` for asset management. You must compile assets before running the app:

```bash
# Build CSS from SCSS files
yarn build:css

# Build JavaScript files
yarn build
```

## Running the Application

Execute the app running the command:
```bash
./bin/dev
```

This will start three processes:
- **Web server**: Rails application on default port (usually 3000)
- **CSS watcher**: Automatically rebuilds CSS when SCSS files change
- **JS watcher**: Automatically rebuilds JavaScript when JS files change

## Troubleshooting

### Asset Pipeline Error: "The asset 'application.css' is not present"

If you encounter this error, it means the CSS assets haven't been compiled. Run:
```bash
yarn install
yarn build:css
yarn build
```

### Missing node_modules

If `node_modules/` directory doesn't exist, run:
```bash
yarn install
```

### Manual Asset Building

If you need to rebuild assets manually:
```bash
# Rebuild CSS only
yarn build:css

# Rebuild JavaScript only
yarn build

# Rebuild both
yarn build:css && yarn build
```

## Development Notes

- CSS source files are in `app/assets/stylesheets/`
- JavaScript source files are in `app/javascript/`
- Compiled assets are output to `app/assets/builds/`
- Never edit files in `app/assets/builds/` directly - they will be overwritten

## Progressive Web App (PWA) Features

This application is configured as a Progressive Web App with the following features:

### ✨ What's Included
- 📱 **Installable**: Can be installed on mobile and desktop devices
- 🔄 **Offline Support**: Service worker caches assets for offline use
- ⚡ **Fast Performance**: Cached resources load instantly
- 🎨 **App-like Experience**: Runs in standalone mode without browser chrome

### 📦 PWA Files
- `/public/manifest.json` - App manifest with metadata
- `/public/service-worker.js` - Service worker for offline functionality
- `/app/javascript/pwa.js` - PWA registration logic
- `/public/icons/` - App icons in multiple sizes

### 🎨 Generating App Icons
The app needs icons in various sizes (72x72 to 512x512). To generate them:

1. **Option 1**: Use the provided script (requires ImageMagick)
   ```bash
   cd public/icons
   ./generate-icons.sh
   ```

2. **Option 2**: Use online tools
   - [PWABuilder Image Generator](https://www.pwabuilder.com/imageGenerator)
   - [RealFaviconGenerator](https://realfavicongenerator.net/)

3. **Option 3**: Replace `public/icons/icon-template.svg` with your logo and run the script

See `/public/icons/README.md` for detailed instructions.

### 🧪 Testing PWA Features
1. Serve the app (must be HTTPS or localhost)
2. Open Chrome DevTools → Application tab
3. Check "Manifest" and "Service Workers" sections
4. Run Lighthouse audit for PWA compliance

### 📝 More Information
For detailed PWA documentation, see [PWA_README.md](PWA_README.md).

