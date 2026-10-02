# PROJECT — NAP Event Tracker

## Purpose
Operational NAP management application for Kingshot Server 1044.

## Source of truth
Repository: `Boltotelli/nap-event-tracker`

Branches:
- `main`: approved production source
- `develop`: current test/development source
- `feature/*`: temporary development branches

## Hosting
Production Vercel project: `nap-event-tracker`
Production URL: https://nap-event-tracker.vercel.app

Test environment: GitHub Pages from `develop`
Test URL: https://boltotelli.github.io/nap-event-tracker/

The old Vercel test project `nap-event-tracker-test` was retired on 2026-10-02. GitHub Pages from `develop` is the supported test environment.

Production Vercel was cut over to this dedicated repository and verified on 2026-10-02.

## Backend
Shared Supabase project:
- Name: Kingshot 1044 NAP
- Ref: `bdzlgirowutasrsycjfj`
- Region: eu-central-1

The repository split must not move production data, create a second database, or change schemas merely for organizational purposes.

## Deployment policy
Normal flow after migration:

`feature/* -> develop -> test -> main -> production`

Do not make production fixes only inside ChatGPT or Supabase-hosted assets without also committing the source to GitHub.

## Safety
- Preserve existing production URLs.
- Do not expose secret/service-role keys.
- Test changes before promotion to main.
- Database migrations are separate from frontend/repository migrations.
- Legacy NAP source in `welcome-nrw` was removed on 2026-10-02 after the dedicated production/test paths were verified.
