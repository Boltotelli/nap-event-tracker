# WORK HANDOFF — NAP Event Tracker

Last updated: 2026-10-02

## Current state

The NAP application repository split was completed and verified on 2026-10-02. This repository is now the application source of truth.

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
- Law 14 is now **Event Spending** with sections 14.1–14.4. 14.1 keeps the >3× non-KvK spending rule and exceptions; 14.2 keeps the progressive stage 1–4 penalties; 14.3 covers Non-NAP players (first violation: warning to player + R5; further violation: 7 days without Law #5 protection, enforced by the current king's alliance); 14.4 incorporates the Strongest Governor nomination rotation. Laws 14A and 15 are retired/inactive.
- Transfer workflow: POOL/non-NAP → NAP transfers may be accepted immediately by the destination NAP alliance because the source has no app access. The 72-hour observation window remains visible as safety context but no longer blocks manual acceptance. Reject/temporary remains available. Normal NAP → NAP transfers keep the existing source/destination authorization workflow. Transfer UI labels follow the selected DE/EN/FR/ES language.

## Infrastructure boundary

Shared Supabase is intentional. Do not split the database as part of repository cleanup.

Discord bots and Welcome Page are separate applications even where they share Supabase data.

## Migration completed

- [x] Dedicated repository created.
- [x] Production source verified against the prior live Vercel deployment.
- [x] Production source and alliance badge assets imported into `main`.
- [x] `develop` established for test/development.
- [x] GitHub Pages test environment deployed from `develop` and verified.
- [x] Vercel production reconnected to this repository / `main` and verified.
- [x] Old Vercel test project retired.
- [x] Legacy NAP source removed from `welcome-nrw` after stable cutover.

### GitHub Pages test

Test URL: `https://boltotelli.github.io/nap-event-tracker/`

GitHub Pages deploys automatically from `develop` via `.github/workflows/pages-test.yml`.

Current flow:
`feature/* -> develop -> GitHub Pages test -> main -> Vercel production`

The unfinished OCR / Performance / AM work is preserved on `feature/ocr-performance-v16` and is not part of the current live baseline.

## Current branch policy

- `main`: approved production source; Vercel production tracks this branch.
- `develop`: supported GitHub Pages test source.
- `feature/ocr-performance-v16`: unfinished OCR/performance work intentionally preserved and not part of the production baseline.

Do not remove preserved feature work or shared Supabase runtime components merely as repository cleanup. Review runtime dependencies separately.
