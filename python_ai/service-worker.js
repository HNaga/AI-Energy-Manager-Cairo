const CACHE_NAME = 'energy-ai-v1';
const urlsToCache = [
  '/',
  '/manifest.json',
  'https://img.icons8.com/fluency/512/000000/artificial-intelligence.png'
];

self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => cache.addAll(urlsToCache))
  );
});

self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request)
      .then(response => response || fetch(event.request))
  );
});
