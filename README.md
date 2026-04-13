# Filmedme

Filmedme is a Flutter mobile app scaffold inspired by VSCO workflows:

- film-like presets and recipes
- private studio drafts before publish
- clear separation between frontend modules and backend domains

## Frontend

Flutter app lives in `lib/` and follows a feature-first structure:

- `app/` app shell, theme, routing
- `core/` shared widgets and models
- `features/` discover, studio, editor, presets, navigation shell

## Backend

Backend is separated into another project folder:

- `/Users/nookthawat/Project/filmedme-backend`

That repo contains the Node.js + TypeScript backend API.

## Environment

Create local env for Flutter API connection:

```bash
cp .env.example .env
```

Set your backend base URL in `.env`:

```bash
API_BASE_URL=http://localhost:4000/api
API_BASE_URL_ANDROID=http://10.0.2.2:4000/api
API_BASE_URL_IOS=http://localhost:4000/api
```

### Emulator and Simulator notes

- Android Emulator cannot use `localhost` for host machine API, use `10.0.2.2`
- iOS Simulator can use `localhost`
- Physical devices should use your machine LAN IP, for example `http://192.168.1.10:4000/api`

## Flutter quick run

```bash
flutter pub get
flutter run
```

## Run and Debug (VS Code)

Open folder `/Users/nookthawat/Project/filmedme` in VS Code, then go to `Run and Debug`.

Use one of these launch profiles:

- `Flutter (Current Device)`
- `Flutter (Android Emulator)`
- `Flutter (iOS Simulator)`
- `Full Stack (Android Emulator)` (backend + app)
- `Full Stack (iOS Simulator)` (backend + app)
