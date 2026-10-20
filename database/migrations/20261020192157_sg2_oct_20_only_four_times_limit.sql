-- Kingshot 1044 NAP — production migration 20261020192157.
-- One-day exception: October 20, 2026 (UTC), SG Day 2 only.
-- All other non-historical SG days use the usual 3x threshold.
-- Preserve historical SG 4x exceptions on September 22 and 23, 2026.
-- The exception was already applied to production Supabase.

CREATE OR REPLACE FUNCTION public.law14_threshold_multiplier(
  p_event_name text,
  p_phase_name text,
  p_occurred_at timestamp with time zone
)
RETURNS numeric
LANGUAGE sql
IMMUTABLE
SET search_path TO ''
AS $function$
  SELECT CASE
    WHEN p_event_name = 'Strongest Governor'
      AND (
        (p_phase_name = 'sg2' AND (p_occurred_at AT TIME ZONE 'UTC')::date = date '2026-09-22')
        OR (p_phase_name = 'sg3' AND (p_occurred_at AT TIME ZONE 'UTC')::date = date '2026-09-23')
        OR (p_phase_name = 'sg2' AND (p_occurred_at AT TIME ZONE 'UTC')::date = date '2026-10-20')
      )
    THEN 4::numeric
    ELSE 3::numeric
  END
$function$;

-- One-time data correction performed separately and logged in audit_log:
-- 17 invalid SG2 violations with score <= 1,248,000 were removed together
-- with 16 related sanctions. Eight SG2 violations above 4x remained.
-- The audit_log reason and correction key sg2_2026_10_20_4x document each.
