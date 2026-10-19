-- NAP Tracker / Kingshot 1044
-- Mirror of Supabase production migration 20261019182900, applied 2026-10-19.
-- Only modifies SG exclusion recognition in OCR preview + import RPCs.
-- No tables, permissions, frontend settings, or non-SG rules are changed.
--
-- The importer supplies p_recording_captured_at=NULL when video capture time
-- is unknown. Previously the RPC used 12:00 UTC as a placeholder for the
-- exclusion check. Nominations entered after noon were ignored and uploaded
-- as false violations. Compare active exclusion windows with the entire
-- recorded UTC SG day when the capture time is unknown. For trustworthy
-- capture timestamps retain the precise time check.
--
-- Idempotent: a function already carrying the fix is left unchanged.

DO $sg_ocr_exclusion_fix$
DECLARE
  fn record;
  definition text;
  old_check text := 'public.is_player_spending_exempt(v_player.id,v_effective_at)';
  new_check text := '(case when v_exact_capture then public.is_player_spending_exempt(v_player.id,v_effective_at) else exists (select 1 from public.nap_spending_exemptions sgx where sgx.player_id=v_player.id and sgx.ended_at is null and sgx.starts_at<v_day_end and sgx.ends_at>v_day_start) end)';
BEGIN
  FOR fn IN
    SELECT p.oid,p.proname
    FROM pg_proc p
    JOIN pg_namespace ns ON ns.oid=p.pronamespace
    WHERE ns.nspname='public'
      AND p.proname IN (
        'preview_screen_recording_nap_occurrence_v2',
        'import_screen_recording_nap_occurrence_v2'
      )
  LOOP
    definition := pg_get_functiondef(fn.oid);
    IF position(new_check IN definition)>0 THEN
      CONTINUE;
    END IF;
    IF length(definition)-length(replace(definition,old_check,''))<>length(old_check) THEN
      RAISE EXCEPTION 'Unexpected exemption-check source in %, not patching',fn.proname;
    END IF;
    EXECUTE replace(definition,old_check,new_check);
  END LOOP;
END;
$sg_ocr_exclusion_fix$;

-- Follow-up verification:
-- SELECT proname,
--        position('sgx.starts_at<v_day_end' IN pg_get_functiondef(oid))>0 AS patched
-- FROM pg_proc
-- WHERE proname IN ('preview_screen_recording_nap_occurrence_v2',
--                   'import_screen_recording_nap_occurrence_v2');
