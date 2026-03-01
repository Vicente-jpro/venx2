# Venx2 - Progressive Web App

Rails-based Progressive Web Application for sales and inventory management.

## Features

- ✨ Progressive Web App (PWA) enabled
- 📱 Installable on mobile and desktop devices
- 🔄 Offline functionality with service worker
- 💾 Local caching for improved performance

## PWA Features

This application is configured as a Progressive Web App, which means:

1. **Installable**: Users can install the app on their devices (mobile and desktop)
2. **Offline Support**: The app can work offline once installed
3. **App-like Experience**: Runs in standalone mode without browser UI
4. **Fast Performance**: Assets are cached for quick loading

### Installing the PWA

#### On Mobile (Android/iOS):
1. Open the app in your mobile browser
2. Look for the "Add to Home Screen" or "Install App" prompt
3. Tap "Install" or "Add"
4. The app icon will appear on your home screen

#### On Desktop (Chrome/Edge):
1. Open the app in Chrome or Edge
2. Look for the install icon (⊕) in the address bar
3. Click "Install"
4. The app will open in its own window

#### On Windows:
See [WINDOWS_INSTALL.md](WINDOWS_INSTALL.md) for detailed Windows installation instructions.

**Quick steps:**
- Open in Microsoft Edge or Chrome
- Click the install prompt in the address bar
- App appears in Start Menu and can be pinned to taskbar

### PWA Configuration Files

- `/public/manifest.json` - PWA manifest file with app metadata
- `/public/service-worker.js` - Service worker for offline functionality
- `/app/javascript/pwa.js` - PWA registration and install prompt handling
- `/public/icons/` - App icons in various sizes

### Generating App Icons

The app needs icons in multiple sizes. To generate them:

1. Install ImageMagick:
   ```bash
   # Ubuntu/Debian
   sudo apt-get install imagemagick
   
   # macOS
   brew install imagemagick
   ```

2. Run the icon generation script:
   ```bash
   cd public/icons
   ./generate-icons.sh
   ```

Or use an online tool like [PWABuilder](https://www.pwabuilder.com/imageGenerator) to generate all required sizes.

### Customizing Your PWA

Edit `/public/manifest.json` to customize:
- App name and short name
- Theme colors
- Display mode
- Orientation
- Icons

Edit `/public/service-worker.js` to customize:
- Cache strategy
- Offline fallbacks
- Files to cache

## Development

```bash
# Install dependencies
bundle install
npm install

# Setup database
rails db:setup

# Run development server
bin/dev
```

## Testing PWA Features

To test PWA features in development:

1. The app must be served over HTTPS (or localhost)
2. Open Chrome DevTools → Application tab
3. Check "Manifest" to verify manifest.json
4. Check "Service Workers" to verify service worker registration
5. Use "Lighthouse" to audit PWA compliance

## Production Deployment

Ensure your production server:
- Serves the app over HTTPS
- Has proper SSL certificate
- Serves manifest.json with `application/json` content-type
- Serves service-worker.js with proper cache headers

## Advanced: Microsoft Store Publishing

To distribute your PWA through the Microsoft Store:

### Using PWABuilder (Recommended)

1. **Prepare your app:**
   - Deploy to production with HTTPS
   - Ensure all PWA requirements are met
   - Test installation on Windows

2. **Generate Windows package:**
   ```bash
   # Visit PWABuilder
   # https://www.pwabuilder.com/
   # Enter your production URL
   # Select "Windows" platform
   # Download the generated package
   ```

   Or use CLI:
   ```bash
   npm install -g @pwabuilder/cli
   pwabuilder package https://your-app-url.com --platform windows
   ```

3. **Create Microsoft Partner Center account:**
   - Go to https://partner.microsoft.com/
   - Register ($19 one-time fee)
   - Reserve your app name

4. **Submit to Store:**
   - Upload the generated package
   - Add screenshots and descriptions
   - Complete submission form
   - Wait for review (typically 24-48 hours)

### Benefits of Microsoft Store:
- ✅ Appears in Windows 11 Store
- ✅ Automatic updates
- ✅ Better discoverability
- ✅ Professional distribution
- ✅ Can reach millions of Windows users

### Requirements:
- Valid SSL certificate (HTTPS)
- Working PWA with manifest and service worker
- Privacy policy URL
- App screenshots (minimum 1280x720)
- App description and metadata

For detailed instructions, see: [PWABuilder Documentation](https://docs.pwabuilder.com/)

## Platform-Specific Installation Guides

- **Windows**: See [WINDOWS_INSTALL.md](WINDOWS_INSTALL.md)
- **Android**: Built-in browser install prompt
- **iOS/macOS**: Safari "Add to Home Screen" / "Add to Dock"

## License

[Your License Here]
