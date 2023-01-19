-- Migracja tabel słownikowych
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