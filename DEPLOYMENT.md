# Deployment (Local + Production Guide)

## Local (Docker Compose)
```bash
docker compose up --build
```

Services:
- API: http://localhost:3000
- Admin: http://localhost:5174
- Postgres: localhost:5432

## Production (Outline)
1) Provision Postgres (managed DB recommended).
2) Set env vars:
   - `DATABASE_URL`
   - `JWT_SECRET`
   - `FAST2SMS_API_KEY` (optional)
3) Deploy API container.
4) Deploy Admin static site (or container).
5) Point `VITE_API_URL` to API public URL.

## Mobile apps
- Android: build APK/AAB and publish to Play Store.
- iOS: build with Xcode on macOS, publish via App Store Connect.

## Notes
- For mobile API base URL, use your public API domain.
- For Android emulator local API: `http://10.0.2.2:3000`.
