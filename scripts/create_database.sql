DROP DATABASE polring;
DROP TABLESPACE polring;
DROP ROLE polring;

CREATE USER polring PASSWORD 'secret' CREATEDB;

CREATE TABLESPACE polring OWNER polring LOCATION '/mnt/wd6/pgsql/polring';

CREATE DATABASE polring OWNER polring ENCODING 'utf-8' TABLESPACE polring;

\c polring
CREATE EXTENSION postgis;
ALTER SCHEMA public OWNER TO polring;
ALTER TABLE public.geography_columns OWNER TO polring;
ALTER TABLE public.geometry_columns OWNER TO polring;
ALTER TABLE public.spatial_ref_sys OWNER TO polring;

\c postgres
