# NAP Event Tracker

Source repository for the Kingshot Server 1044 NAP Event Tracker.

## Environments

- Production branch: `main`
- Development/test branch: `develop`
- Production Vercel project: `nap-event-tracker`
- Test Vercel project: `nap-event-tracker-test`
- Shared backend: Supabase project `bdzlgirowutasrsycjfj` (Kingshot 1044 NAP)

## Source-of-truth rule

GitHub is the source of truth for application code.

- `main` = exact approved production code.
- `develop` = current test/development code.
- feature branches merge into `develop` first.
- approved `develop` changes are promoted to `main`.

Do not use ChatGPT conversation history as the only record of application state. Read `PROJECT.md` and `WORK-HANDOFF.md` before making changes.

## Migration

This repository was split from `Boltotelli/welcome-nrw` on 2026-10-02. The old source remains untouched until Vercel migration and verification are complete.
