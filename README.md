# NAP Event Tracker

Source repository for the Kingshot Server 1044 NAP Event Tracker.

## Environments

- Production branch: `main`
- Development/test branch: `develop`
- Production Vercel project: `nap-event-tracker`
- Test environment: GitHub Pages from `develop` — `https://boltotelli.github.io/nap-event-tracker/`
- Shared backend: Supabase project `bdzlgirowutasrsycjfj` (Kingshot 1044 NAP)

## Source-of-truth rule

GitHub is the source of truth for application code.

- `main` = exact approved production code.
- `develop` = current test/development code.
- feature branches merge into `develop` first.
- approved `develop` changes are promoted to `main`.

Do not use ChatGPT conversation history as the only record of application state. Read `PROJECT.md` and `WORK-HANDOFF.md` before making changes.

## Migration status

The repository split from `Boltotelli/welcome-nrw` was completed on 2026-10-02:
- production Vercel now deploys from this repository's `main`;
- GitHub Pages on `develop` is the supported test environment;
- the old Vercel test project was retired;
- legacy NAP code was removed from `welcome-nrw` after verification.

The unfinished OCR/performance work remains intentionally preserved on `feature/ocr-performance-v16`.
