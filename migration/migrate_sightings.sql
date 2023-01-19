-- Migracja obserwacji i ściśle powiązanych tabel

BEGIN;

TRUNCATE public.sightings
    , public.interesting_sightings
    , public.measurements
    , public.notification_sightings
    , public.ring_sighting
    , public.sighting_amendments
    , public.sighting_amendment_files
    , public.sighting_amendment_conversations
    , public.sighting_files
    , public.sighting_rejection_reasons
    , public.sighting_sighting_import
    , public.sighting_user
    , public.sighting_verifications
    , public.bird_family_sightings_rings
;


-- ptaki_stwierdzenia → sightings
INSERT INTO public.sightings (id, "date", "hour", minutes, comments, comments_hidden, date_accuracy_id, species_id,
                       species_by_scheme_id, age_id, age_by_scheme_id, sex_id, sex_by_scheme_id, plumage_id,
                       condition_id, circumstances_id, circumstances_validation_id, decoy_id, capture_method_id,
                       sighting_status_id, bird_status_id, bird_displacement_id, bird_manipulation_id,
                       bird_birth_accuracy_id, ring_verification_id, created_at, updated_at, location_id, created_by,
                       updated_by, primary_sighting_id, is_shown_on_public_map, is_virtual, species_description,
                       is_info_from_third_party, is_in_progress, other_finders, parent_ring_number, pullus_number,
                       pullus_age, pullus_age_accuracy_id, unread_ring, family_ring_number)
SELECT id_stw -- id,
       ,data -- "date",
       ,godzina -- "hour",
       ,minuty --minutes,
       ,uwagi --comments,
       ,NULL --comments_hidden,
       ,id_dd --date_accuracy_id,
       ,id_gat1 -- species_id,
       ,id_gat2 -- species_by_scheme_id, ?
       ,id_wiek1 -- age_id,
       ,id_wiek2 -- age_by_scheme_id, ?
       ,id_plec1 --sex_id,
       ,id_plec2 --sex_by_scheme_id, ?
       ,id_szata --plumage_id,
       ,id_kond --condition_id,
       ,id_okol --circumstances_id,
       ,id_okolvalid --circumstances_validation_id,
       ,id_wabik --decoy_id,
       ,id_chwyt --capture_method_id,
       ,NULL --sighting_status_id,
       ,id_status --bird_status_id,
       ,id_przem --bird_displacement_id,
       ,id_manip --bird_manipulation_id,
       ,NULL --bird_birth_accuracy_id,
       ,id_wer --ring_verification_id,
       ,datawpr --created_at,
       ,dataed --updated_at,
       --TODO mapowanie locations
       ,NULL -- id_lokalizacja, --location_id,
       --TODO mapowanie users
       ,NULL -- id_uzytkownika_wpr, --created_by,
       ,NULL -- id_uzytkownika_ed, --updated_by,
       ,id_stwpierwotne --primary_sighting_id,
       ,NULL --is_shown_on_public_map,
       ,false --is_virtual, !
       ,gatunek --species_description, ?? infododnazwa?
       ,false --is_info_from_third_party, !
       ,NULL --is_in_progress,
       ,inniznalazcy --other_finders,
       ,NULL --parent_ring_number,
       ,lp --pullus_number, ???
       ,wiekpis --pullus_age,
       ,id_doklpis--pullus_age_accuracy_id
       ,NULL --unread_ring
       ,NULL --family_ring_number
FROM dbo.ptaki_stwierdzenia
--LIMIT 1000
;


INSERT INTO public.measurements (
    measurement_type_id
    ,sighting_id
    ,numeric_value
    ,text_value
    ,created_at
    ,updated_at
    ,is_direct
)
SELECT measurement_type_id
    ,sighting_id
    ,numeric_value
    ,text_value
    ,created_at
    ,updated_at
    ,FALSE --is_direct ???
FROM (SELECT
     id_pomiar AS measurement_type_id
    ,id_stw AS sighting_id
    ,pomwartl AS numeric_value
    ,pomwart AS text_value
    ,datawpr AS created_at --?
    ,dataed AS updated_at --?
    ,0 AS measurement_no
 FROM dbo.ptaki_stwierdzenia
 WHERE id_pomiar IS NOT NULL
UNION ALL
 SELECT id_pomiar1 ,id_stw ,pomwartl1 ,pomwart1 ,datawpr ,dataed ,1
 FROM dbo.ptaki_stwierdzenia
 WHERE id_pomiar1 IS NOT NULL
UNION ALL
 SELECT id_pomiar2 ,id_stw ,pomwartl2 ,pomwart2 ,datawpr ,dataed ,2
 FROM dbo.ptaki_stwierdzenia
 WHERE id_pomiar2 IS NOT NULL
UNION ALL
 SELECT id_pomiar3 ,id_stw ,pomwartl3 ,pomwart3 ,datawpr ,dataed ,3
 FROM dbo.ptaki_stwierdzenia
 WHERE id_pomiar3 IS NOT NULL
UNION ALL
 SELECT id_pomiar4 ,id_stw ,pomwartl4 ,pomwart4 ,datawpr ,dataed ,4
 FROM dbo.ptaki_stwierdzenia
 WHERE id_pomiar4 IS NOT NULL
UNION ALL
 SELECT id_pomiar5 ,id_stw ,pomwartl5 ,pomwart5 ,datawpr ,dataed ,5
 FROM dbo.ptaki_stwierdzenia
 WHERE id_pomiar5 IS NOT NULL
UNION ALL
 SELECT id_pomiar6 ,id_stw ,pomwartl6 ,pomwart6 ,datawpr ,dataed ,6
 FROM dbo.ptaki_stwierdzenia
 WHERE id_pomiar6 IS NOT NULL
UNION ALL
 SELECT id_pomiar7 ,id_stw ,pomwartl7 ,pomwart7 ,datawpr ,dataed ,7
 FROM dbo.ptaki_stwierdzenia
 WHERE id_pomiar7 IS NOT NULL
UNION ALL
 SELECT id_pomiar8 ,id_stw ,pomwartl8 ,pomwart8 ,datawpr ,dataed ,8
 FROM dbo.ptaki_stwierdzenia
 WHERE id_pomiar8 IS NOT NULL
UNION ALL
 SELECT id_pomiar9 ,id_stw ,pomwartl9 ,pomwart9 ,datawpr ,dataed ,9
 FROM dbo.ptaki_stwierdzenia
 WHERE id_pomiar9 IS NOT NULL) src
ORDER BY sighting_id, measurement_no
;

COMMIT;

