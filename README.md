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

That repo contains all Supabase schema, seed scripts, and edge functions.

## Flutter quick run

```bash
flutter pub get
flutter run
```
