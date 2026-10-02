# WORK HANDOFF — NAP Event Tracker

Last updated: 2026-10-02

## Current migration state

The NAP application is being separated from `Boltotelli/welcome-nrw` into this dedicated repository.

### Verified live production source
The production URL `https://nap-event-tracker.vercel.app` was fetched directly and compared with:
`Boltotelli/welcome-nrw/main/nap-event-tracker/`

Verified byte-equal live files:
- `live-adapter.js`
- `native-screen-import.js`
- `live-translations-v2.js`

The live HTML reports:
`window.NAP2_BUILD='20260928-settings-lock1'`

and loads:
- `live-adapter.js?v=20261001-forgehammer-310-v1`
- `native-screen-import.js?v=20260928-event-availability-fix4`
- `live-translations-v2.js?v=20260925-overdue-days-i18n`

Therefore `welcome-nrw/main/nap-event-tracker/` is the verified production source snapshot for this migration.

### Development source
The active development lineage is:
`Boltotelli/welcome-nrw` branch `fix/nap2-navigation-mobile`,
directory `nap-event-tracker-test/`.

That branch includes newer OCR/video compatibility work and must become `develop`, not production `main`, unless explicitly promoted after testing.

## Important current product rules

- NAP alliances with app access: NWO, NwO, THM, NRW, CWR, PxR.
- TWD is not a NAP login alliance.
- Violation validity is globally 28 days.
- Current rule from 2026-09-26 onward: one violation per event per day; higher scores upgrade the existing violation rather than automatically creating a new stage after contact.
- ScreenImporter evidence/update logic must reuse existing violations/cases and avoid duplicates.
- Times shown in the app should use UTC.
- Support is privacy-scoped; alliance users must not gain access to another alliance's private case details.

## Infrastructure boundary

Shared Supabase is intentional. Do not split the database as part of repository cleanup.

Discord bots and Welcome Page are separate applications even where they share Supabase data.

## Migration checklist

- [x] Create dedicated repository.
- [x] Verify actual live production source against deployed Vercel content.
- [x] Import production text/code source into `main`.
- [ ] Copy binary alliance badge assets.
- [x] Create `develop` from the verified production baseline.
- [x] Compare target branches to source snapshots.
- [ ] Reconnect test Vercel project to new repo/develop.
- [ ] Verify test.
- [ ] Reconnect production Vercel project to new repo/main.
- [ ] Verify production.
- [x] GitHub Pages test environment moved to new repo/develop.
- [ ] Only after stable operation, remove legacy NAP source from welcome-nrw.

### GitHub Pages test

Test URL: `https://boltotelli.github.io/nap-event-tracker/`

GitHub Pages deploys automatically from `develop` via `.github/workflows/pages-test.yml`.

Current flow:
`feature/* -> develop -> GitHub Pages test -> main -> Vercel production`

The unfinished OCR / Performance / AM work is preserved on `feature/ocr-performance-v16` and is not part of the current live baseline.

## Do not do

Do not delete legacy source, legacy branches, Vercel projects, Supabase tables, or Edge Functions during cutover unless separately reviewed.
