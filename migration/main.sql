-- Główny plik do uruchomienia migracji

SET client_encoding = 'UTF8';

\i migrate_dict.sql
\i migrate_sightings.sql

/*
polring=> \i main.sql
SET
INSERT 0 0
BEGIN
TRUNCATE TABLE
rings start
INSERT 0 5819490
rings done
locations start
ALTER TABLE
INSERT 0 285274
ALTER TABLE
locations done
sightings start
INSERT 0 6848487
sightings done
measurements start
INSERT 0 1371296
measurements done
ring_sighting start
INSERT 0 7138010
ring_sighting done
COMMIT
commited
*/
