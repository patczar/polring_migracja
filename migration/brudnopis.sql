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



SELECT count(*) FROM dbo.ptaki_obraczki;

SELECT count(*) FROM public.rings;
