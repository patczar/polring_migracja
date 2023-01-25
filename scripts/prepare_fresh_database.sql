\set username laravel
\set dbname laravel

DROP DATABASE :dbname;
DROP ROLE :username;

CREATE USER :username PASSWORD 'secret' CREATEDB;

CREATE DATABASE :dbname OWNER :username ENCODING 'utf-8';

\c :dbname
CREATE EXTENSION postgis;
ALTER SCHEMA public OWNER TO :username;
ALTER TABLE public.geography_columns OWNER TO :username;
ALTER TABLE public.geometry_columns OWNER TO :username;
ALTER TABLE public.spatial_ref_sys OWNER TO :username;

