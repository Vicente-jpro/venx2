# README

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

