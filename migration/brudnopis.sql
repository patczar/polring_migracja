INSERT INTO public.dict_species(id, eu_code, abbr, text_pl, text_en, text_la, is_active, is_default, sort_order, created_at, updated_at)
SELECT id_gat,
       kodeu,
       skrot,
       pol,
       eng,
       lat,
       aktywny,
       domyslny,
       lp,
       current_timestamp,
       current_timestamp
FROM dbo.ptaki_bk_gatunek
WHERE id_gat >= 1511;
;

-- Wybór pól z ptaki_stwierdzenia
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

SELECT count(*) FROM dbo.ptaki_lokalizacja;

SELECT * FROM dbo.ptaki_lokalizacja
WHERE length(skrot) > 10;

SELECT max(length(skrot)) FROM dbo.ptaki_lokalizacja;
-- zmiana varchar(10) na varchar(20)


SELECT id_lokalizacja
    ,szer
    ,szerd, szerm, szers
    ,dlug
    ,dlugd, dlugm, dlugs
FROM dbo.ptaki_lokalizacja;

SELECT id_lokalizacja
    ,szer
    ,szerd + szerm / 60.0 + szers / 3600.0 AS szer_liczona
    ,dlug
    ,dlugd + dlugm / 60.0 + dlugs / 3600.0 AS dlug_liczona
FROM dbo.ptaki_lokalizacja;

SELECT max(abs(szer - szer_liczona)) AS max_szer_dif, max(abs(dlug - dlug_liczona)) AS max_dlug_dif
FROM (SELECT id_lokalizacja
    ,szer
    ,(szerd + szerm / 60.0 + szers / 3600.0) * szerz AS szer_liczona
    ,dlug
    ,(dlugd + dlugm / 60.0 + dlugs / 3600.0) * dlugz AS dlug_liczona
FROM dbo.ptaki_lokalizacja) sub;

SELECT *
FROM (SELECT id_lokalizacja
    ,szer
    ,(szerd + szerm / 60.0 + szers / 3600.0) * szerz AS szer_liczona
    ,dlug
    ,(dlugd + dlugm / 60.0 + dlugs / 3600.0) * dlugz AS dlug_liczona
FROM dbo.ptaki_lokalizacja) sub
ORDER BY abs(szer - szer_liczona) + abs(dlug - dlug_liczona) DESC;

SELECT id_lokalizacja
    ,miejsce --name
    ,skrot --abbr
    ,id_dk --coordinate_accuracy_id
    ,NULL --created_at
    ,NULL --updated_at
    ,id_prow --province_id
    ,id_kraj --country_id
    ,id_obr --user_id
    ,wpisobraczkarz --is_in_user_registry
    ,wpispracstacji --is_in_employee_registry
    ,FALSE --! has_manually_edited_province_or_country
    ,NULL --! source
    ,gps --is_from_gps
    ,kliknamapie
    ,zweryfikowany
    ,listaprac
    ,geog
    ,szer
    ,dlug
    ,szerd
    ,szerm
    ,szers
    ,dlugd
    ,dlugm
    ,dlugs
    ,szerdms
    ,dlugdms
    ,szerz
    ,dlugz
    ,concat('point(', dlug, ' ', szer, ')')
    ,st_geomfromtext(concat('point(', dlug, ' ', szer, ')'))
    ,concat('point(', dlugz * (dlugd + dlugm / 60.0 + dlugs / 3600.0), ' ', szerz * (szerd + szerm / 60.0 + szers / 3600.0), ')')
    ,st_geomfromtext(concat('point(', dlugz * (dlugd + dlugm / 60.0 + dlugs / 3600.0), ' ', szerz * (szerd + szerm / 60.0 + szers / 3600.0), ')'))
FROM dbo.ptaki_lokalizacja;


SELECT count(*) FROM dbo.ptaki_obraczki;

SELECT count(*) FROM public.rings;
