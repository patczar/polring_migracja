-- Migracja obrączek. Powinna odbyć się przed migracją obserwacji.

BEGIN;

TRUNCATE public.rings
    ,public.bird_family_sightings_rings
    ,public.notifications
    ,public.ring_sighting
    ,public.rings_in_stocks
    ,public.notification_sightings
    ,public.sent_notifications
    ,public.stock_document_position_rings_in_stocks
    ,public.sent_attachments
;

INSERT INTO public.rings(
     id
    ,ring_type_id
    ,scheme_id
    ,color_id
    ,number
    ,created_at
    ,updated_at
    ,species_id
    ,ringer_id
)
SELECT id_obraczki -- > id
    ,id_typ -- > ring_type_id
    ,id_ctr -- > scheme_id
    ,id_kolor -- > color_id
    ,concat(seria, numer) -- > number
    ,NULL -- > created_at
    ,NULL -- > updated_at
    ,id_gat
    ,NULL -- > ringer_id
    -- ,kodzdubl >
    -- ,numerobpel >
    -- ,id_monit >
FROM dbo.ptaki_obraczki;

COMMIT;
