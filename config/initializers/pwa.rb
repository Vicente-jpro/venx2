# Rails configuration for PWA
# This ensures PWA files are served with correct content-type and headers

Rails.application.config.middleware.use(
  Rack::Static,
  urls: ['/manifest.json', '/service-worker.js'],
  root: Rails.public_path,
  header_rules: [
    [:all, { 'Cache-Control' => 'public, max-age=0' }],
    [%w[manifest.json], { 'Content-Type' => 'application/manifest+json' }],
    [%w[service-worker.js], { 'Content-Type' => 'application/javascript' }]
  ]
)
