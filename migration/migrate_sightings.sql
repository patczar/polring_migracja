-- Migracja obserwacji i ściśle powiązanych tabel

TRUNCATE public.sightings;

-- ptaki_stwierdzenia → sightings
INSERT INTO public.sightings (id, "date", "hour", minutes, comments, comments_hidden, date_accuracy_id, species_id,
                       species_by_scheme_id, age_id, age_by_scheme_id, sex_id, sex_by_scheme_id, plumage_id,
                       condition_id, circumstances_id, circumstances_validation_id, decoy_id, capture_method_id,
                       sighting_status_id, bird_status_id, bird_displacement_id, bird_manipulation_id,
                       bird_birth_accuracy_id, ring_verification_id, created_at, updated_at, location_id, created_by,
                       updated_by, primary_sighting_id, is_shown_on_public_map, is_virtual, species_description,
                       is_info_from_third_party, is_in_progress, other_finders, parent_ring_number, pullus_number,
                       pullus_age_id, pullus_age_accuracy_id)
SELECT id_stw, -- id,
        data, -- "date",
       godzina, -- "hour",
       minuty, --minutes,
       uwagi, --comments,
       NULL, --comments_hidden,
       id_dd, --date_accuracy_id,
       id_gat1, -- species_id,
       id_gat2, -- species_by_scheme_id, ?
       id_wiek1, -- age_id,
       id_wiek2, -- age_by_scheme_id, ?
       id_plec1, --sex_id,
       id_plec2, --sex_by_scheme_id, ?
       id_szata, --plumage_id,
       id_kond, --condition_id,
       id_okol, --circumstances_id,
       id_okolvalid, --circumstances_validation_id,
       id_wabik, --decoy_id,
       id_chwyt, --capture_method_id,
       NULL, --sighting_status_id,
       id_status, --bird_status_id,
       id_przem, --bird_displacement_id,
       id_manip, --bird_manipulation_id,
       NULL, --bird_birth_accuracy_id,
       id_wer, --ring_verification_id,
       datawpr, --created_at,
       dataed, --updated_at,
       NULL, -- id_lokalizacja, --location_id,
       id_uzytkownika_wpr, --created_by,
       id_uzytkownika_ed, --updated_by,
       id_stwpierwotne, --primary_sighting_id,
       NULL, --is_shown_on_public_map,
       false, --is_virtual, !
       gatunek, --species_description, ?? infododnazwa?
       false, --is_info_from_third_party, !
       NULL, --is_in_progress,
       inniznalazcy, --other_finders,
       NULL, --parent_ring_number,
       NULL, --pullus_number,
       wiekpis, --pullus_age_id, ?
       id_doklpis --pullus_age_accuracy_id
FROM dbo.ptaki_stwierdzenia
LIMIT 1;

SELECT id_stw, --z
       pierwotne, --n
       data,--z
       godzina,--z
       minuty,--z
       id_poprawny,
       id_wer, --z
       id_gat1, --z
       id_gat2, --x
       gatunek, --n
       id_manip, --z
       id_przem, --z
       id_chwyt, --z
       id_wabik, --z
       id_plec1, --z
       id_plec2, --x
       id_wiek1, --z
       id_wiek2, --x
       --szata, --n ?
       id_status, --z
       lp, --n ?
       wiekpis, --x
       id_doklpis, --z
       id_dd, --z
       id_kond, --z
       id_okol, --z
       id_okolvalid, --z
       uwagi, --x
       id_korespond,
       wykaznr,
       wykazrok,
       r1ctr,
       r1nrob,
       r2ctr,
       r2nrob,
       rnrob,
       id_obr1,
       id_obr2,
       imie,
       nazwisko,
       email,
       zrdinfo,
       odleglosc,
       czasodpierw,
       kat,
       id_lokalizacja, --z
       infododnazwa,
       infodod,
       katportodromy,
       inniznalazcy, --z
       id_stwgosc,
       id_stwpierwotne, --z
       datawpr, --z
       dataed, --z
       id_uzytkownika_wpr, --z
       id_uzytkownika_ed, --z
       adres,
       datawer,
       wys_potw,
       zn_monitrodz,
       zn_monit1data,
       zn_monit1ilosc,
       zn_monit2data,
       zn_monit2ilosc,
       zn_wyjas,
       id_szata, --z
       jezyk,
       udost,
       -- p:
       id_pomiar,
       pomr,
       pomwartl,
       pomwart,
       id_pomiar1,
       pomr1,
       pomwartl1,
       pomwart1,
       id_pomiar2,
       pomr2,
       pomwartl2,
       pomwart2,
       id_pomiar3,
       pomr3,
       pomwartl3,
       pomwart3,
       id_pomiar4,
       pomr4,
       pomwartl4,
       pomwart4,
       id_pomiar5,
       pomr5,
       pomwartl5,
       pomwart5,
       id_pomiar6,
       pomr6,
       pomwartl6,
       pomwart6,
       id_pomiar7,
       pomr7,
       pomwartl7,
       pomwart7,
       id_pomiar8,
       pomr8,
       pomwartl8,
       pomwart8,
       id_pomiar9,
       pomr9,
       pomwartl9,
       pomwart9,
       hash
FROM dbo.ptaki_stwierdzenia
LIMIT 1;
