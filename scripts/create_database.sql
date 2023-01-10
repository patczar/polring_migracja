DROP DATABASE polring;

DROP ROLE polring;

CREATE USER polring PASSWORD 'secret' CREATEDB;

CREATE DATABASE polring OWNER polring ENCODING 'utf-8';

\c polring
CREATE EXTENSION postgis;
ALTER SCHEMA public OWNER TO polring;
ALTER TABLE public.geography_columns OWNER TO polring;
ALTER TABLE public.geometry_columns OWNER TO polring;
ALTER TABLE public.spatial_ref_sys OWNER TO polring;

\c postgres
