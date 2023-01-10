--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1 (Debian 15.1-1.pgdg110+1)
-- Dumped by pg_dump version 15.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: dbo; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA dbo;


ALTER SCHEMA dbo OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: aspnet_sqlcachetablesforchangenotification; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.aspnet_sqlcachetablesforchangenotification (
    tablename text NOT NULL,
    notificationcreated timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    changeid integer DEFAULT 0 NOT NULL
);


ALTER TABLE dbo.aspnet_sqlcachetablesforchangenotification OWNER TO postgres;

--
-- Name: aspnet_sqlpagestatepersister; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.aspnet_sqlpagestatepersister (
    id_state text NOT NULL,
    created timestamp with time zone NOT NULL,
    state bytea
);


ALTER TABLE dbo.aspnet_sqlpagestatepersister OWNER TO postgres;

--
-- Name: dtproperties; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.dtproperties (
    id bigint NOT NULL,
    objectid integer,
    property text NOT NULL,
    value text,
    uvalue text,
    lvalue bytea,
    version integer DEFAULT 0 NOT NULL
);


ALTER TABLE dbo.dtproperties OWNER TO postgres;

--
-- Name: dtproperties_id_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.dtproperties_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.dtproperties_id_seq OWNER TO postgres;

--
-- Name: dtproperties_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.dtproperties_id_seq OWNED BY dbo.dtproperties.id;


--
-- Name: ptaki_adresy; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_adresy (
    id_adres bigint NOT NULL,
    id_uzytkownika integer NOT NULL,
    miasto text NOT NULL,
    kodpoczt text NOT NULL,
    adres text NOT NULL,
    id_adresyrodzaj integer NOT NULL,
    opis text DEFAULT ''::text NOT NULL,
    aktualny boolean DEFAULT true NOT NULL,
    firma1 text NOT NULL,
    firma2 text NOT NULL,
    firma3 text NOT NULL,
    kraj text NOT NULL
);


ALTER TABLE dbo.ptaki_adresy OWNER TO postgres;

--
-- Name: ptaki_adresy_id_adres_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_adresy_id_adres_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_adresy_id_adres_seq OWNER TO postgres;

--
-- Name: ptaki_adresy_id_adres_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_adresy_id_adres_seq OWNED BY dbo.ptaki_adresy.id_adres;


--
-- Name: ptaki_adresyrodzaj; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_adresyrodzaj (
    id_adresyrodzaj integer NOT NULL,
    nazwa text NOT NULL
);


ALTER TABLE dbo.ptaki_adresyrodzaj OWNER TO postgres;

--
-- Name: ptaki_bk_chwyt; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_chwyt (
    id_chwyt bigint NOT NULL,
    kodeu text,
    skrot text,
    opis_pl text,
    opis_en text,
    aktywny boolean DEFAULT true NOT NULL,
    domyslny boolean DEFAULT false NOT NULL,
    lp integer DEFAULT 0 NOT NULL
);


ALTER TABLE dbo.ptaki_bk_chwyt OWNER TO postgres;

--
-- Name: ptaki_bk_chwyt_id_chwyt_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_bk_chwyt_id_chwyt_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_bk_chwyt_id_chwyt_seq OWNER TO postgres;

--
-- Name: ptaki_bk_chwyt_id_chwyt_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_bk_chwyt_id_chwyt_seq OWNED BY dbo.ptaki_bk_chwyt.id_chwyt;


--
-- Name: ptaki_bk_ctr; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_ctr (
    id_ctr bigint NOT NULL,
    ctr text,
    skrot text,
    kraj_pl text,
    kraj_en text,
    opis text,
    email text,
    aktywny boolean DEFAULT true NOT NULL,
    domyslny boolean DEFAULT false NOT NULL,
    lp integer DEFAULT 0 NOT NULL
);


ALTER TABLE dbo.ptaki_bk_ctr OWNER TO postgres;

--
-- Name: ptaki_bk_ctr_id_ctr_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_bk_ctr_id_ctr_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_bk_ctr_id_ctr_seq OWNER TO postgres;

--
-- Name: ptaki_bk_ctr_id_ctr_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_bk_ctr_id_ctr_seq OWNED BY dbo.ptaki_bk_ctr.id_ctr;


--
-- Name: ptaki_bk_dd; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_dd (
    id_dd bigint NOT NULL,
    kodeu text,
    skrot text,
    opis_pl text,
    opis_en text,
    aktywny boolean DEFAULT true NOT NULL,
    domyslny boolean DEFAULT false NOT NULL,
    lp integer DEFAULT 0 NOT NULL
);


ALTER TABLE dbo.ptaki_bk_dd OWNER TO postgres;

--
-- Name: ptaki_bk_dd_id_dd_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_bk_dd_id_dd_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_bk_dd_id_dd_seq OWNER TO postgres;

--
-- Name: ptaki_bk_dd_id_dd_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_bk_dd_id_dd_seq OWNED BY dbo.ptaki_bk_dd.id_dd;


--
-- Name: ptaki_bk_dk; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_dk (
    id_dk bigint NOT NULL,
    kodeu text,
    skrot text,
    opis_pl text,
    opis_en text,
    aktywny boolean DEFAULT true NOT NULL,
    domyslny boolean DEFAULT false NOT NULL,
    lp integer DEFAULT 0 NOT NULL
);


ALTER TABLE dbo.ptaki_bk_dk OWNER TO postgres;

--
-- Name: ptaki_bk_dk_id_dk_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_bk_dk_id_dk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_bk_dk_id_dk_seq OWNER TO postgres;

--
-- Name: ptaki_bk_dk_id_dk_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_bk_dk_id_dk_seq OWNED BY dbo.ptaki_bk_dk.id_dk;


--
-- Name: ptaki_bk_doklpis; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_doklpis (
    id_doklpis bigint NOT NULL,
    kodeu text,
    skrot text,
    opis_pl text,
    opis_en text,
    aktywny boolean DEFAULT true NOT NULL,
    domyslny boolean DEFAULT false NOT NULL,
    lp integer DEFAULT 0 NOT NULL
);


ALTER TABLE dbo.ptaki_bk_doklpis OWNER TO postgres;

--
-- Name: ptaki_bk_doklpis_id_doklpis_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_bk_doklpis_id_doklpis_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_bk_doklpis_id_doklpis_seq OWNER TO postgres;

--
-- Name: ptaki_bk_doklpis_id_doklpis_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_bk_doklpis_id_doklpis_seq OWNED BY dbo.ptaki_bk_doklpis.id_doklpis;


--
-- Name: ptaki_bk_gatunek; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_gatunek (
    id_gat bigint NOT NULL,
    kodeu text,
    skrot text,
    lat text,
    pol text,
    eng text,
    aktywny boolean DEFAULT true NOT NULL,
    domyslny boolean DEFAULT false NOT NULL,
    lp integer DEFAULT 0 NOT NULL
);


ALTER TABLE dbo.ptaki_bk_gatunek OWNER TO postgres;

--
-- Name: ptaki_bk_gatunek_id_gat_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_bk_gatunek_id_gat_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_bk_gatunek_id_gat_seq OWNER TO postgres;

--
-- Name: ptaki_bk_gatunek_id_gat_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_bk_gatunek_id_gat_seq OWNED BY dbo.ptaki_bk_gatunek.id_gat;


--
-- Name: ptaki_bk_gatunekgrupa; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_gatunekgrupa (
    id_grupa bigint NOT NULL,
    nazwa text NOT NULL
);


ALTER TABLE dbo.ptaki_bk_gatunekgrupa OWNER TO postgres;

--
-- Name: ptaki_bk_gatunekgrupa_gatunki; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_gatunekgrupa_gatunki (
    id_grupa integer NOT NULL,
    id_gat integer NOT NULL
);


ALTER TABLE dbo.ptaki_bk_gatunekgrupa_gatunki OWNER TO postgres;

--
-- Name: ptaki_bk_gatunekgrupa_id_grupa_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_bk_gatunekgrupa_id_grupa_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_bk_gatunekgrupa_id_grupa_seq OWNER TO postgres;

--
-- Name: ptaki_bk_gatunekgrupa_id_grupa_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_bk_gatunekgrupa_id_grupa_seq OWNED BY dbo.ptaki_bk_gatunekgrupa.id_grupa;


--
-- Name: ptaki_bk_gatunekold; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_gatunekold (
    lat text NOT NULL,
    skrot text NOT NULL
);


ALTER TABLE dbo.ptaki_bk_gatunekold OWNER TO postgres;

--
-- Name: ptaki_bk_gatunekpara; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_gatunekpara (
    id_gat1 integer NOT NULL,
    id_gat2 integer
);


ALTER TABLE dbo.ptaki_bk_gatunekpara OWNER TO postgres;

--
-- Name: ptaki_bk_gatunektyp; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_gatunektyp (
    id_gattyp bigint NOT NULL,
    id_gat integer NOT NULL,
    id_wiek integer,
    id_plec integer,
    aktywny boolean DEFAULT true NOT NULL,
    id_obraczkityp integer NOT NULL
);


ALTER TABLE dbo.ptaki_bk_gatunektyp OWNER TO postgres;

--
-- Name: ptaki_bk_gatunektyp_id_gattyp_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_bk_gatunektyp_id_gattyp_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_bk_gatunektyp_id_gattyp_seq OWNER TO postgres;

--
-- Name: ptaki_bk_gatunektyp_id_gattyp_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_bk_gatunektyp_id_gattyp_seq OWNED BY dbo.ptaki_bk_gatunektyp.id_gattyp;


--
-- Name: ptaki_bk_gatunekwiek; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_gatunekwiek (
    id_gatwiek bigint NOT NULL,
    id_gat integer NOT NULL,
    id_wiek integer NOT NULL,
    mc integer NOT NULL,
    aktywny boolean DEFAULT true NOT NULL
);


ALTER TABLE dbo.ptaki_bk_gatunekwiek OWNER TO postgres;

--
-- Name: ptaki_bk_gatunekwiek_id_gatwiek_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_bk_gatunekwiek_id_gatwiek_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_bk_gatunekwiek_id_gatwiek_seq OWNER TO postgres;

--
-- Name: ptaki_bk_gatunekwiek_id_gatwiek_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_bk_gatunekwiek_id_gatwiek_seq OWNED BY dbo.ptaki_bk_gatunekwiek.id_gatwiek;


--
-- Name: ptaki_bk_kolor; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_kolor (
    id_kolor bigint NOT NULL,
    krz text,
    skrot text,
    opis_pl text,
    opis_en text,
    aktywny boolean DEFAULT true NOT NULL,
    domyslny boolean DEFAULT false NOT NULL,
    lp integer DEFAULT 0 NOT NULL
);


ALTER TABLE dbo.ptaki_bk_kolor OWNER TO postgres;

--
-- Name: ptaki_bk_kolor_id_kolor_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_bk_kolor_id_kolor_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_bk_kolor_id_kolor_seq OWNER TO postgres;

--
-- Name: ptaki_bk_kolor_id_kolor_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_bk_kolor_id_kolor_seq OWNED BY dbo.ptaki_bk_kolor.id_kolor;


--
-- Name: ptaki_bk_kondycja; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_kondycja (
    id_kond bigint NOT NULL,
    kodeu text,
    skrot text,
    opis_pl text,
    opis_en text,
    aktywny boolean DEFAULT true NOT NULL,
    martwy boolean DEFAULT false NOT NULL,
    domyslny boolean DEFAULT false NOT NULL,
    lp integer DEFAULT 0 NOT NULL
);


ALTER TABLE dbo.ptaki_bk_kondycja OWNER TO postgres;

--
-- Name: ptaki_bk_kondycja_id_kond_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_bk_kondycja_id_kond_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_bk_kondycja_id_kond_seq OWNER TO postgres;

--
-- Name: ptaki_bk_kondycja_id_kond_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_bk_kondycja_id_kond_seq OWNED BY dbo.ptaki_bk_kondycja.id_kond;


--
-- Name: ptaki_bk_kraj; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_kraj (
    id_kraj bigint NOT NULL,
    kodeu text,
    opis_pl text,
    opis_en text,
    aktywny boolean DEFAULT true NOT NULL,
    domyslny boolean DEFAULT false NOT NULL,
    lp integer DEFAULT 0 NOT NULL
);


ALTER TABLE dbo.ptaki_bk_kraj OWNER TO postgres;

--
-- Name: ptaki_bk_kraj_id_kraj_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_bk_kraj_id_kraj_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_bk_kraj_id_kraj_seq OWNER TO postgres;

--
-- Name: ptaki_bk_kraj_id_kraj_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_bk_kraj_id_kraj_seq OWNED BY dbo.ptaki_bk_kraj.id_kraj;


--
-- Name: ptaki_bk_krajctr; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_krajctr (
    id_krajctr bigint NOT NULL,
    id_kraj integer NOT NULL,
    id_ctr integer NOT NULL,
    aktywny boolean DEFAULT true NOT NULL,
    domyslny boolean DEFAULT false NOT NULL,
    lp integer DEFAULT 0 NOT NULL
);


ALTER TABLE dbo.ptaki_bk_krajctr OWNER TO postgres;

--
-- Name: ptaki_bk_krajctr_id_krajctr_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_bk_krajctr_id_krajctr_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_bk_krajctr_id_krajctr_seq OWNER TO postgres;

--
-- Name: ptaki_bk_krajctr_id_krajctr_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_bk_krajctr_id_krajctr_seq OWNED BY dbo.ptaki_bk_krajctr.id_krajctr;


--
-- Name: ptaki_bk_kto; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_kto (
    id_kto integer NOT NULL,
    nazwa text NOT NULL
);


ALTER TABLE dbo.ptaki_bk_kto OWNER TO postgres;

--
-- Name: ptaki_bk_manip; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_manip (
    id_manip bigint NOT NULL,
    kodeu text,
    skrot text,
    opis_pl text,
    opis_en text,
    aktywny boolean DEFAULT true NOT NULL,
    domyslny boolean DEFAULT false NOT NULL,
    lp integer DEFAULT 0 NOT NULL
);


ALTER TABLE dbo.ptaki_bk_manip OWNER TO postgres;

--
-- Name: ptaki_bk_manip_id_manip_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_bk_manip_id_manip_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_bk_manip_id_manip_seq OWNER TO postgres;

--
-- Name: ptaki_bk_manip_id_manip_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_bk_manip_id_manip_seq OWNED BY dbo.ptaki_bk_manip.id_manip;


--
-- Name: ptaki_bk_obszar; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_obszar (
    id_obszaru bigint NOT NULL,
    skrot text,
    nazwa text,
    koordynaty text,
    opis text,
    aktywny boolean DEFAULT true NOT NULL
);


ALTER TABLE dbo.ptaki_bk_obszar OWNER TO postgres;

--
-- Name: ptaki_bk_obszar_id_obszaru_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_bk_obszar_id_obszaru_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_bk_obszar_id_obszaru_seq OWNER TO postgres;

--
-- Name: ptaki_bk_obszar_id_obszaru_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_bk_obszar_id_obszaru_seq OWNED BY dbo.ptaki_bk_obszar.id_obszaru;


--
-- Name: ptaki_bk_okol; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_okol (
    id_okol bigint NOT NULL,
    id_parent integer,
    skrot text,
    kodeu text,
    opis_pl text,
    opis_en text,
    aktywny boolean DEFAULT true NOT NULL,
    domyslny boolean DEFAULT false NOT NULL,
    lp integer DEFAULT 0 NOT NULL
);


ALTER TABLE dbo.ptaki_bk_okol OWNER TO postgres;

--
-- Name: ptaki_bk_okol_id_okol_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_bk_okol_id_okol_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_bk_okol_id_okol_seq OWNER TO postgres;

--
-- Name: ptaki_bk_okol_id_okol_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_bk_okol_id_okol_seq OWNED BY dbo.ptaki_bk_okol.id_okol;


--
-- Name: ptaki_bk_okolvalid; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_okolvalid (
    id_okolvalid bigint NOT NULL,
    skrot text,
    kodeu text,
    opis_pl text,
    opis_en text,
    aktywny boolean DEFAULT true NOT NULL,
    domyslny boolean DEFAULT false NOT NULL,
    lp integer DEFAULT 0 NOT NULL
);


ALTER TABLE dbo.ptaki_bk_okolvalid OWNER TO postgres;

--
-- Name: ptaki_bk_okolvalid_id_okolvalid_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_bk_okolvalid_id_okolvalid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_bk_okolvalid_id_okolvalid_seq OWNER TO postgres;

--
-- Name: ptaki_bk_okolvalid_id_okolvalid_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_bk_okolvalid_id_okolvalid_seq OWNED BY dbo.ptaki_bk_okolvalid.id_okolvalid;


--
-- Name: ptaki_bk_plec; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_plec (
    id_plec bigint NOT NULL,
    kodeu text,
    skrot text,
    opis_pl text,
    opis_en text,
    aktywny boolean DEFAULT true NOT NULL,
    domyslny boolean DEFAULT false NOT NULL,
    lp integer DEFAULT 0 NOT NULL
);


ALTER TABLE dbo.ptaki_bk_plec OWNER TO postgres;

--
-- Name: ptaki_bk_plec_id_plec_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_bk_plec_id_plec_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_bk_plec_id_plec_seq OWNER TO postgres;

--
-- Name: ptaki_bk_plec_id_plec_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_bk_plec_id_plec_seq OWNED BY dbo.ptaki_bk_plec.id_plec;


--
-- Name: ptaki_bk_pomiar; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_pomiar (
    id_pomiar bigint NOT NULL,
    skrot text,
    kodeu text,
    opis_pl text,
    opis_en text,
    aktywny boolean DEFAULT true NOT NULL,
    domyslny boolean DEFAULT false NOT NULL,
    lp integer DEFAULT 0 NOT NULL
);


ALTER TABLE dbo.ptaki_bk_pomiar OWNER TO postgres;

--
-- Name: ptaki_bk_pomiar_id_pomiar_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_bk_pomiar_id_pomiar_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_bk_pomiar_id_pomiar_seq OWNER TO postgres;

--
-- Name: ptaki_bk_pomiar_id_pomiar_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_bk_pomiar_id_pomiar_seq OWNED BY dbo.ptaki_bk_pomiar.id_pomiar;


--
-- Name: ptaki_bk_poprawny; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_poprawny (
    id_poprawny integer NOT NULL,
    opis text NOT NULL
);


ALTER TABLE dbo.ptaki_bk_poprawny OWNER TO postgres;

--
-- Name: ptaki_bk_prowincja; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_prowincja (
    id_prow bigint NOT NULL,
    kodeu text,
    id_kraj integer NOT NULL,
    opis_prow text,
    szs numeric,
    szn numeric,
    dlw numeric,
    dle numeric,
    data1 timestamp with time zone,
    data2 timestamp with time zone,
    aktywny boolean DEFAULT true NOT NULL,
    domyslny boolean DEFAULT false NOT NULL,
    lp integer DEFAULT 0 NOT NULL
);


ALTER TABLE dbo.ptaki_bk_prowincja OWNER TO postgres;

--
-- Name: ptaki_bk_prowincja_id_prow_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_bk_prowincja_id_prow_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_bk_prowincja_id_prow_seq OWNER TO postgres;

--
-- Name: ptaki_bk_prowincja_id_prow_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_bk_prowincja_id_prow_seq OWNED BY dbo.ptaki_bk_prowincja.id_prow;


--
-- Name: ptaki_bk_przem; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_przem (
    id_przem bigint NOT NULL,
    kodeu text,
    skrot text,
    opis_pl text,
    opis_en text,
    aktywny boolean DEFAULT true NOT NULL,
    domyslny boolean DEFAULT false NOT NULL,
    lp integer DEFAULT 0 NOT NULL
);


ALTER TABLE dbo.ptaki_bk_przem OWNER TO postgres;

--
-- Name: ptaki_bk_przem_id_przem_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_bk_przem_id_przem_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_bk_przem_id_przem_seq OWNER TO postgres;

--
-- Name: ptaki_bk_przem_id_przem_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_bk_przem_id_przem_seq OWNED BY dbo.ptaki_bk_przem.id_przem;


--
-- Name: ptaki_bk_stanzn; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_stanzn (
    id_stan bigint NOT NULL,
    kodeu text,
    skrot text,
    opis_pl text,
    opis_en text,
    aktywny boolean DEFAULT true NOT NULL,
    domyslny boolean DEFAULT false NOT NULL,
    lp integer DEFAULT 0 NOT NULL
);


ALTER TABLE dbo.ptaki_bk_stanzn OWNER TO postgres;

--
-- Name: ptaki_bk_stanzn_id_stan_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_bk_stanzn_id_stan_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_bk_stanzn_id_stan_seq OWNER TO postgres;

--
-- Name: ptaki_bk_stanzn_id_stan_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_bk_stanzn_id_stan_seq OWNED BY dbo.ptaki_bk_stanzn.id_stan;


--
-- Name: ptaki_bk_status; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_status (
    id_status bigint NOT NULL,
    stat text,
    skrot text,
    kodeu text,
    opis_pl text,
    opis_en text,
    aktywny boolean DEFAULT true NOT NULL,
    mapiskleta boolean DEFAULT false NOT NULL,
    domyslny boolean DEFAULT false NOT NULL,
    lp integer DEFAULT 0 NOT NULL
);


ALTER TABLE dbo.ptaki_bk_status OWNER TO postgres;

--
-- Name: ptaki_bk_status_id_status_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_bk_status_id_status_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_bk_status_id_status_seq OWNER TO postgres;

--
-- Name: ptaki_bk_status_id_status_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_bk_status_id_status_seq OWNED BY dbo.ptaki_bk_status.id_status;


--
-- Name: ptaki_bk_szata; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_szata (
    id_szata bigint NOT NULL,
    kodeu text,
    skrot text,
    opis_pl text,
    opis_en text,
    aktywny boolean DEFAULT true NOT NULL,
    domyslny boolean DEFAULT false NOT NULL,
    lp integer DEFAULT 0 NOT NULL
);


ALTER TABLE dbo.ptaki_bk_szata OWNER TO postgres;

--
-- Name: ptaki_bk_szata_id_szata_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_bk_szata_id_szata_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_bk_szata_id_szata_seq OWNER TO postgres;

--
-- Name: ptaki_bk_szata_id_szata_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_bk_szata_id_szata_seq OWNED BY dbo.ptaki_bk_szata.id_szata;


--
-- Name: ptaki_bk_typobr; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_typobr (
    id_typ bigint NOT NULL,
    kodeu text,
    skrot text,
    opis_pl text,
    opis_en text,
    aktywny boolean DEFAULT true NOT NULL,
    domyslny boolean DEFAULT false NOT NULL,
    lp integer DEFAULT 0 NOT NULL
);


ALTER TABLE dbo.ptaki_bk_typobr OWNER TO postgres;

--
-- Name: ptaki_bk_typobr_id_typ_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_bk_typobr_id_typ_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_bk_typobr_id_typ_seq OWNER TO postgres;

--
-- Name: ptaki_bk_typobr_id_typ_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_bk_typobr_id_typ_seq OWNED BY dbo.ptaki_bk_typobr.id_typ;


--
-- Name: ptaki_bk_wabik; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_wabik (
    id_wabik bigint NOT NULL,
    kodeu text,
    skrot text,
    opis_pl text,
    opis_en text,
    aktywny boolean DEFAULT true NOT NULL,
    domyslny boolean DEFAULT false NOT NULL,
    lp integer DEFAULT 0 NOT NULL
);


ALTER TABLE dbo.ptaki_bk_wabik OWNER TO postgres;

--
-- Name: ptaki_bk_wabik_id_wabik_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_bk_wabik_id_wabik_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_bk_wabik_id_wabik_seq OWNER TO postgres;

--
-- Name: ptaki_bk_wabik_id_wabik_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_bk_wabik_id_wabik_seq OWNED BY dbo.ptaki_bk_wabik.id_wabik;


--
-- Name: ptaki_bk_wer; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_wer (
    id_wer bigint NOT NULL,
    kodeu text,
    skrot text,
    opis_pl text,
    opis_en text,
    aktywny boolean DEFAULT true NOT NULL,
    domyslny boolean DEFAULT false NOT NULL,
    lp integer DEFAULT 0 NOT NULL
);


ALTER TABLE dbo.ptaki_bk_wer OWNER TO postgres;

--
-- Name: ptaki_bk_wer_id_wer_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_bk_wer_id_wer_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_bk_wer_id_wer_seq OWNER TO postgres;

--
-- Name: ptaki_bk_wer_id_wer_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_bk_wer_id_wer_seq OWNED BY dbo.ptaki_bk_wer.id_wer;


--
-- Name: ptaki_bk_werst; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_werst (
    id_werst text NOT NULL,
    opis_pl text NOT NULL,
    opis_en text,
    rowv timestamp without time zone NOT NULL
);


ALTER TABLE dbo.ptaki_bk_werst OWNER TO postgres;

--
-- Name: ptaki_bk_wiek; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_wiek (
    id_wiek bigint NOT NULL,
    kodeu text,
    skrot text,
    opis_pl text,
    opis_en text,
    aktywny boolean DEFAULT true NOT NULL,
    piskle boolean DEFAULT false NOT NULL,
    domyslny boolean DEFAULT false NOT NULL,
    lp integer DEFAULT 0 NOT NULL
);


ALTER TABLE dbo.ptaki_bk_wiek OWNER TO postgres;

--
-- Name: ptaki_bk_wiek_id_wiek_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_bk_wiek_id_wiek_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_bk_wiek_id_wiek_seq OWNER TO postgres;

--
-- Name: ptaki_bk_wiek_id_wiek_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_bk_wiek_id_wiek_seq OWNED BY dbo.ptaki_bk_wiek.id_wiek;


--
-- Name: ptaki_bk_wiekpara; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_bk_wiekpara (
    id_wiek1 integer NOT NULL,
    id_wiek2 integer NOT NULL,
    aktywny boolean DEFAULT true NOT NULL
);


ALTER TABLE dbo.ptaki_bk_wiekpara OWNER TO postgres;

--
-- Name: ptaki_dfiles; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_dfiles (
    id_dfiles bigint NOT NULL,
    uploadtime timestamp with time zone NOT NULL,
    id_guid uuid NOT NULL,
    id_file text NOT NULL,
    lp integer NOT NULL,
    filename text NOT NULL,
    filedata bytea NOT NULL,
    hash character varying(64)
);


ALTER TABLE dbo.ptaki_dfiles OWNER TO postgres;

--
-- Name: ptaki_dfiles_id_dfiles_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_dfiles_id_dfiles_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_dfiles_id_dfiles_seq OWNER TO postgres;

--
-- Name: ptaki_dfiles_id_dfiles_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_dfiles_id_dfiles_seq OWNED BY dbo.ptaki_dfiles.id_dfiles;


--
-- Name: ptaki_doktozsamrodzaj; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_doktozsamrodzaj (
    id_doktozsamrodzaj bigint NOT NULL,
    nazwa text NOT NULL
);


ALTER TABLE dbo.ptaki_doktozsamrodzaj OWNER TO postgres;

--
-- Name: ptaki_doktozsamrodzaj_id_doktozsamrodzaj_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_doktozsamrodzaj_id_doktozsamrodzaj_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_doktozsamrodzaj_id_doktozsamrodzaj_seq OWNER TO postgres;

--
-- Name: ptaki_doktozsamrodzaj_id_doktozsamrodzaj_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_doktozsamrodzaj_id_doktozsamrodzaj_seq OWNED BY dbo.ptaki_doktozsamrodzaj.id_doktozsamrodzaj;


--
-- Name: ptaki_dostawcy; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_dostawcy (
    id_dostawca bigint NOT NULL,
    nazwaskr text NOT NULL,
    nazwapeln text NOT NULL,
    miasto text NOT NULL,
    kodpoczt text NOT NULL,
    adres text NOT NULL,
    nip text NOT NULL,
    mail text NOT NULL,
    uwagi text NOT NULL,
    kraj text NOT NULL
);


ALTER TABLE dbo.ptaki_dostawcy OWNER TO postgres;

--
-- Name: ptaki_dostawcy_id_dostawca_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_dostawcy_id_dostawca_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_dostawcy_id_dostawca_seq OWNER TO postgres;

--
-- Name: ptaki_dostawcy_id_dostawca_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_dostawcy_id_dostawca_seq OWNED BY dbo.ptaki_dostawcy.id_dostawca;


--
-- Name: ptaki_emailewysylka; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_emailewysylka (
    id_emailwysylka bigint NOT NULL,
    id_sesja uuid NOT NULL,
    id_uzytkownik integer,
    imie text,
    nazwisko text,
    msg_to text,
    msg_subject text NOT NULL,
    msg_body text NOT NULL,
    id_monit integer,
    datawys timestamp with time zone
);


ALTER TABLE dbo.ptaki_emailewysylka OWNER TO postgres;

--
-- Name: ptaki_emailewysylka_id_emailwysylka_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_emailewysylka_id_emailwysylka_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_emailewysylka_id_emailwysylka_seq OWNER TO postgres;

--
-- Name: ptaki_emailewysylka_id_emailwysylka_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_emailewysylka_id_emailwysylka_seq OWNED BY dbo.ptaki_emailewysylka.id_emailwysylka;


--
-- Name: ptaki_emailewysylkabld; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_emailewysylkabld (
    id_emailewysylkabld bigint NOT NULL,
    data timestamp with time zone NOT NULL,
    id_stw bigint NOT NULL,
    blad text NOT NULL,
    id_monit integer
);


ALTER TABLE dbo.ptaki_emailewysylkabld OWNER TO postgres;

--
-- Name: ptaki_emailewysylkabld_id_emailewysylkabld_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_emailewysylkabld_id_emailewysylkabld_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_emailewysylkabld_id_emailewysylkabld_seq OWNER TO postgres;

--
-- Name: ptaki_emailewysylkabld_id_emailewysylkabld_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_emailewysylkabld_id_emailewysylkabld_seq OWNED BY dbo.ptaki_emailewysylkabld.id_emailewysylkabld;


--
-- Name: ptaki_emailewysylkastw; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_emailewysylkastw (
    id_emailwysylka integer NOT NULL,
    id_stw bigint NOT NULL,
    zn_monitrodz smallint
);


ALTER TABLE dbo.ptaki_emailewysylkastw OWNER TO postgres;

--
-- Name: ptaki_emailewysylkazal; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_emailewysylkazal (
    id_emailwysylkazal bigint NOT NULL,
    id_emailwysylka integer NOT NULL,
    att_name text NOT NULL,
    att_content bytea,
    hash character varying(64)
);


ALTER TABLE dbo.ptaki_emailewysylkazal OWNER TO postgres;

--
-- Name: ptaki_emailewysylkazal_id_emailwysylkazal_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_emailewysylkazal_id_emailwysylkazal_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_emailewysylkazal_id_emailwysylkazal_seq OWNER TO postgres;

--
-- Name: ptaki_emailewysylkazal_id_emailwysylkazal_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_emailewysylkazal_id_emailwysylkazal_seq OWNED BY dbo.ptaki_emailewysylkazal.id_emailwysylkazal;


--
-- Name: ptaki_emailwzorzec; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_emailwzorzec (
    id_emailwzorzec integer NOT NULL,
    nazwa text NOT NULL
);


ALTER TABLE dbo.ptaki_emailwzorzec OWNER TO postgres;

--
-- Name: ptaki_emailwzorzecdef; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_emailwzorzecdef (
    id_emailwzorzec integer NOT NULL,
    lang text NOT NULL,
    msg_subject text NOT NULL,
    msg_body text NOT NULL
);


ALTER TABLE dbo.ptaki_emailwzorzecdef OWNER TO postgres;

--
-- Name: ptaki_emailwzorzecpar; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_emailwzorzecpar (
    id_emailwzorzecpar bigint NOT NULL,
    id_emailwzorzec integer,
    zmienna text NOT NULL,
    wartosc text,
    opis text NOT NULL,
    editable boolean NOT NULL
);


ALTER TABLE dbo.ptaki_emailwzorzecpar OWNER TO postgres;

--
-- Name: ptaki_emailwzorzecpar_id_emailwzorzecpar_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_emailwzorzecpar_id_emailwzorzecpar_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_emailwzorzecpar_id_emailwzorzecpar_seq OWNER TO postgres;

--
-- Name: ptaki_emailwzorzecpar_id_emailwzorzecpar_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_emailwzorzecpar_id_emailwzorzecpar_seq OWNED BY dbo.ptaki_emailwzorzecpar.id_emailwzorzecpar;


--
-- Name: ptaki_goscie; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_goscie (
    id_gosc bigint NOT NULL,
    id_uzytkownika integer NOT NULL,
    telefon text NOT NULL,
    mailozmianach boolean NOT NULL
);


ALTER TABLE dbo.ptaki_goscie OWNER TO postgres;

--
-- Name: ptaki_goscie_id_gosc_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_goscie_id_gosc_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_goscie_id_gosc_seq OWNER TO postgres;

--
-- Name: ptaki_goscie_id_gosc_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_goscie_id_gosc_seq OWNED BY dbo.ptaki_goscie.id_gosc;


--
-- Name: ptaki_goscieoczek; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_goscieoczek (
    id_goscieoczek bigint NOT NULL,
    login text NOT NULL,
    imie text NOT NULL,
    nazwisko text NOT NULL,
    haslo text NOT NULL,
    email text NOT NULL,
    utworzony timestamp with time zone,
    aktywacjaid text,
    jezyk text
);


ALTER TABLE dbo.ptaki_goscieoczek OWNER TO postgres;

--
-- Name: ptaki_goscieoczek_id_goscieoczek_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_goscieoczek_id_goscieoczek_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_goscieoczek_id_goscieoczek_seq OWNER TO postgres;

--
-- Name: ptaki_goscieoczek_id_goscieoczek_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_goscieoczek_id_goscieoczek_seq OWNED BY dbo.ptaki_goscieoczek.id_goscieoczek;


--
-- Name: ptaki_komunikaty; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_komunikaty (
    id_komunikaty bigint NOT NULL,
    dataod timestamp with time zone NOT NULL,
    datado timestamp with time zone NOT NULL,
    tryb text NOT NULL,
    rodzaj text NOT NULL,
    ponow_min integer,
    nieaktywny boolean NOT NULL,
    cel_gosc boolean NOT NULL,
    cel_obr boolean NOT NULL,
    cel_uzyt boolean NOT NULL,
    tresc_pl text,
    tresc_en text,
    ktoutw integer,
    datautw timestamp with time zone NOT NULL,
    ktoed integer,
    dataed timestamp with time zone
);


ALTER TABLE dbo.ptaki_komunikaty OWNER TO postgres;

--
-- Name: ptaki_komunikaty_id_komunikaty_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_komunikaty_id_komunikaty_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_komunikaty_id_komunikaty_seq OWNER TO postgres;

--
-- Name: ptaki_komunikaty_id_komunikaty_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_komunikaty_id_komunikaty_seq OWNED BY dbo.ptaki_komunikaty.id_komunikaty;


--
-- Name: ptaki_komunikatyukryj; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_komunikatyukryj (
    id_komunikaty integer NOT NULL,
    id_uzytkownika integer NOT NULL,
    datautc timestamp with time zone NOT NULL
);


ALTER TABLE dbo.ptaki_komunikatyukryj OWNER TO postgres;

--
-- Name: ptaki_licencje; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_licencje (
    id_licencja bigint NOT NULL,
    id_obraczkarz integer NOT NULL,
    numer text NOT NULL,
    numerdecyzji text NOT NULL,
    datadecyzji timestamp with time zone NOT NULL,
    wydanyprzez text,
    warunki text,
    waznaod timestamp with time zone NOT NULL,
    waznado timestamp with time zone NOT NULL
);


ALTER TABLE dbo.ptaki_licencje OWNER TO postgres;

--
-- Name: ptaki_licencje_id_licencja_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_licencje_id_licencja_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_licencje_id_licencja_seq OWNER TO postgres;

--
-- Name: ptaki_licencje_id_licencja_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_licencje_id_licencja_seq OWNED BY dbo.ptaki_licencje.id_licencja;


--
-- Name: ptaki_lokalizacja; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_lokalizacja (
    id_lokalizacja bigint NOT NULL,
    id_obr integer,
    miejsce text,
    id_kraj integer,
    id_prow integer,
    szer numeric,
    dlug numeric,
    id_dk integer,
    kliknamapie boolean,
    wpispracstacji boolean,
    zweryfikowany boolean,
    wpisobraczkarz boolean,
    skrot text,
    listaprac boolean NOT NULL,
    szerd smallint,
    szerm smallint,
    szers numeric,
    dlugd smallint,
    dlugm smallint,
    dlugs numeric,
    szerdms text,
    dlugdms text,
    szerz smallint,
    dlugz smallint,
    gps boolean DEFAULT false NOT NULL,
    geog bytea
);


ALTER TABLE dbo.ptaki_lokalizacja OWNER TO postgres;

--
-- Name: ptaki_lokalizacja_id_lokalizacja_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_lokalizacja_id_lokalizacja_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_lokalizacja_id_lokalizacja_seq OWNER TO postgres;

--
-- Name: ptaki_lokalizacja_id_lokalizacja_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_lokalizacja_id_lokalizacja_seq OWNED BY dbo.ptaki_lokalizacja.id_lokalizacja;


--
-- Name: ptaki_mag; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_mag (
    id_mag integer NOT NULL,
    nazwa text NOT NULL
);


ALTER TABLE dbo.ptaki_mag OWNER TO postgres;

--
-- Name: ptaki_magdokum; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_magdokum (
    id_dokum bigint NOT NULL,
    nrdok text NOT NULL,
    data timestamp with time zone NOT NULL,
    id_oper integer NOT NULL,
    id_dostawca integer,
    id_obraczkarz integer,
    uwagi text,
    terminrealizacji timestamp with time zone,
    id_uzytkownikazapisal integer,
    nrdok_rok integer DEFAULT 0 NOT NULL,
    nrdok_schemat text DEFAULT ''::text NOT NULL,
    nrdok_lp integer DEFAULT 0 NOT NULL,
    id_uzytkownikaskasowal integer,
    skasowany timestamp with time zone,
    id_obraczkarz2 integer
);


ALTER TABLE dbo.ptaki_magdokum OWNER TO postgres;

--
-- Name: ptaki_magdokum_id_dokum_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_magdokum_id_dokum_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_magdokum_id_dokum_seq OWNER TO postgres;

--
-- Name: ptaki_magdokum_id_dokum_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_magdokum_id_dokum_seq OWNED BY dbo.ptaki_magdokum.id_dokum;


--
-- Name: ptaki_magdokumpoz; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_magdokumpoz (
    id_dokumpoz bigint NOT NULL,
    id_dokum integer NOT NULL,
    id_obraczkityp integer NOT NULL,
    nrpoz integer NOT NULL,
    seria text NOT NULL,
    lpod integer NOT NULL,
    lpdo integer NOT NULL,
    lpdlug integer NOT NULL,
    cenazakupu numeric,
    cenasprzed numeric,
    uwagipoz text,
    id_obraczkipodtyp integer
);


ALTER TABLE dbo.ptaki_magdokumpoz OWNER TO postgres;

--
-- Name: ptaki_magdokumpoz_id_dokumpoz_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_magdokumpoz_id_dokumpoz_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_magdokumpoz_id_dokumpoz_seq OWNER TO postgres;

--
-- Name: ptaki_magdokumpoz_id_dokumpoz_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_magdokumpoz_id_dokumpoz_seq OWNED BY dbo.ptaki_magdokumpoz.id_dokumpoz;


--
-- Name: ptaki_magdokumpoz_magobraczki; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_magdokumpoz_magobraczki (
    id_obraczki integer NOT NULL,
    id_dokumpoz integer NOT NULL
);


ALTER TABLE dbo.ptaki_magdokumpoz_magobraczki OWNER TO postgres;

--
-- Name: ptaki_magkolorowe; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_magkolorowe (
    id_magkolorowe bigint NOT NULL,
    id_typ integer NOT NULL,
    id_kolor integer NOT NULL,
    id_gat integer NOT NULL,
    numer text NOT NULL,
    id_uzytkownika integer NOT NULL,
    datawpr timestamp with time zone NOT NULL
);


ALTER TABLE dbo.ptaki_magkolorowe OWNER TO postgres;

--
-- Name: ptaki_magkolorowe_id_magkolorowe_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_magkolorowe_id_magkolorowe_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_magkolorowe_id_magkolorowe_seq OWNER TO postgres;

--
-- Name: ptaki_magkolorowe_id_magkolorowe_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_magkolorowe_id_magkolorowe_seq OWNED BY dbo.ptaki_magkolorowe.id_magkolorowe;


--
-- Name: ptaki_magobraczki; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_magobraczki (
    id_obraczki bigint NOT NULL,
    seria text NOT NULL,
    lp integer NOT NULL,
    lpdlug integer NOT NULL,
    lppelny text,
    id_mag integer,
    id_dostawca integer,
    id_obraczkarz integer,
    cenazakupu numeric,
    cenasprzed numeric,
    id_obraczkipodtyp integer NOT NULL,
    numerobpel text
);


ALTER TABLE dbo.ptaki_magobraczki OWNER TO postgres;

--
-- Name: ptaki_magobraczki_id_obraczki_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_magobraczki_id_obraczki_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_magobraczki_id_obraczki_seq OWNER TO postgres;

--
-- Name: ptaki_magobraczki_id_obraczki_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_magobraczki_id_obraczki_seq OWNED BY dbo.ptaki_magobraczki.id_obraczki;


--
-- Name: ptaki_magobraczkipodtyp; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_magobraczkipodtyp (
    id_obraczkipodtyp bigint NOT NULL,
    id_obraczkityp integer NOT NULL,
    nazwa text NOT NULL,
    grubosc numeric NOT NULL,
    wysokosc numeric NOT NULL,
    szerokosc numeric NOT NULL,
    material text NOT NULL,
    opis text NOT NULL,
    cenazakupu numeric NOT NULL
);


ALTER TABLE dbo.ptaki_magobraczkipodtyp OWNER TO postgres;

--
-- Name: ptaki_magobraczkipodtyp_id_obraczkipodtyp_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_magobraczkipodtyp_id_obraczkipodtyp_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_magobraczkipodtyp_id_obraczkipodtyp_seq OWNER TO postgres;

--
-- Name: ptaki_magobraczkipodtyp_id_obraczkipodtyp_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_magobraczkipodtyp_id_obraczkipodtyp_seq OWNED BY dbo.ptaki_magobraczkipodtyp.id_obraczkipodtyp;


--
-- Name: ptaki_magobraczkityp; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_magobraczkityp (
    id_obraczkityp bigint NOT NULL,
    nazwa text NOT NULL,
    cenasprzed numeric NOT NULL
);


ALTER TABLE dbo.ptaki_magobraczkityp OWNER TO postgres;

--
-- Name: ptaki_magobraczkityp_id_obraczkityp_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_magobraczkityp_id_obraczkityp_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_magobraczkityp_id_obraczkityp_seq OWNER TO postgres;

--
-- Name: ptaki_magobraczkityp_id_obraczkityp_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_magobraczkityp_id_obraczkityp_seq OWNED BY dbo.ptaki_magobraczkityp.id_obraczkityp;


--
-- Name: ptaki_magobraczkiwykluczenia; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_magobraczkiwykluczenia (
    id_wyklucz bigint NOT NULL,
    seria text NOT NULL,
    lpod integer NOT NULL,
    lpdo integer NOT NULL,
    lpdlug integer NOT NULL
);


ALTER TABLE dbo.ptaki_magobraczkiwykluczenia OWNER TO postgres;

--
-- Name: ptaki_magobraczkiwykluczenia_id_wyklucz_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_magobraczkiwykluczenia_id_wyklucz_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_magobraczkiwykluczenia_id_wyklucz_seq OWNER TO postgres;

--
-- Name: ptaki_magobraczkiwykluczenia_id_wyklucz_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_magobraczkiwykluczenia_id_wyklucz_seq OWNED BY dbo.ptaki_magobraczkiwykluczenia.id_wyklucz;


--
-- Name: ptaki_magoper; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_magoper (
    id_oper integer NOT NULL,
    nazwa text NOT NULL,
    id_mag1 integer,
    id_mag2 integer,
    aktywna boolean NOT NULL,
    nrdok_schemat text DEFAULT ''::text NOT NULL
);


ALTER TABLE dbo.ptaki_magoper OWNER TO postgres;

--
-- Name: ptaki_monity; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_monity (
    id_monit bigint NOT NULL,
    aktywny boolean NOT NULL,
    brak_obr boolean NOT NULL,
    blad boolean NOT NULL,
    wstrzymany boolean NOT NULL,
    wymus boolean NOT NULL,
    ilewys integer,
    ostwys timestamp with time zone,
    dowyslania boolean,
    popr_wys boolean
);


ALTER TABLE dbo.ptaki_monity OWNER TO postgres;

--
-- Name: ptaki_monity_id_monit_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_monity_id_monit_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_monity_id_monit_seq OWNER TO postgres;

--
-- Name: ptaki_monity_id_monit_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_monity_id_monit_seq OWNED BY dbo.ptaki_monity.id_monit;


--
-- Name: ptaki_obraczkarze; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_obraczkarze (
    id_obraczkarz bigint NOT NULL,
    id_uzytkownika integer NOT NULL,
    id_doktozsamrodzaj integer,
    doktozsamnumer text NOT NULL,
    id_zakresobraczrodzaj integer,
    pesel text NOT NULL,
    widzidane boolean NOT NULL,
    mailozmianach boolean NOT NULL,
    id_num integer,
    licencjagatunkiall boolean DEFAULT false NOT NULL,
    grupaobraczkarska boolean NOT NULL,
    inniwidzajegodane boolean NOT NULL,
    id_ctr integer
);


ALTER TABLE dbo.ptaki_obraczkarze OWNER TO postgres;

--
-- Name: ptaki_obraczkarze_id_obraczkarz_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_obraczkarze_id_obraczkarz_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_obraczkarze_id_obraczkarz_seq OWNER TO postgres;

--
-- Name: ptaki_obraczkarze_id_obraczkarz_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_obraczkarze_id_obraczkarz_seq OWNED BY dbo.ptaki_obraczkarze.id_obraczkarz;


--
-- Name: ptaki_obraczkarzegatunki; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_obraczkarzegatunki (
    id_obraczkarz integer NOT NULL,
    id_gat integer NOT NULL
);


ALTER TABLE dbo.ptaki_obraczkarzegatunki OWNER TO postgres;

--
-- Name: ptaki_obraczki; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_obraczki (
    id_obraczki bigint NOT NULL,
    id_typ integer,
    id_ctr integer,
    id_kolor integer,
    seria text,
    numer text,
    kodzdubl text,
    id_gat integer,
    numerobpel text,
    id_monit integer
);


ALTER TABLE dbo.ptaki_obraczki OWNER TO postgres;

--
-- Name: ptaki_obraczki_id_obraczki_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_obraczki_id_obraczki_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_obraczki_id_obraczki_seq OWNER TO postgres;

--
-- Name: ptaki_obraczki_id_obraczki_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_obraczki_id_obraczki_seq OWNED BY dbo.ptaki_obraczki.id_obraczki;


--
-- Name: ptaki_obraczkistan; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_obraczkistan (
    id_obraczkistan bigint NOT NULL,
    id_obraczki bigint,
    id_stw bigint,
    id_stan integer,
    lp smallint NOT NULL
);


ALTER TABLE dbo.ptaki_obraczkistan OWNER TO postgres;

--
-- Name: ptaki_obraczkistan_id_obraczkistan_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_obraczkistan_id_obraczkistan_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_obraczkistan_id_obraczkistan_seq OWNER TO postgres;

--
-- Name: ptaki_obraczkistan_id_obraczkistan_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_obraczkistan_id_obraczkistan_seq OWNED BY dbo.ptaki_obraczkistan.id_obraczkistan;


--
-- Name: ptaki_params; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_params (
    nazwa text NOT NULL,
    wartosc_s text,
    wartosc_i integer,
    wartosc_d numeric
);


ALTER TABLE dbo.ptaki_params OWNER TO postgres;

--
-- Name: ptaki_paramspliki; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_paramspliki (
    id_pliku text NOT NULL,
    nazwa text NOT NULL,
    plik bytea NOT NULL,
    md5 text,
    hash character varying(64)
);


ALTER TABLE dbo.ptaki_paramspliki OWNER TO postgres;

--
-- Name: ptaki_paramsuser; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_paramsuser (
    userid integer NOT NULL,
    nazwa text NOT NULL,
    wartosc_s text,
    wartosc_i integer,
    wartosc_d numeric,
    wartosc_t text
);


ALTER TABLE dbo.ptaki_paramsuser OWNER TO postgres;

--
-- Name: ptaki_pdfwysylka; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_pdfwysylka (
    id_pdfwysylka bigint NOT NULL,
    id_sesja uuid NOT NULL,
    imie text,
    nazwisko text,
    adres text,
    wyslano timestamp with time zone
);


ALTER TABLE dbo.ptaki_pdfwysylka OWNER TO postgres;

--
-- Name: ptaki_pdfwysylka_id_pdfwysylka_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_pdfwysylka_id_pdfwysylka_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_pdfwysylka_id_pdfwysylka_seq OWNER TO postgres;

--
-- Name: ptaki_pdfwysylka_id_pdfwysylka_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_pdfwysylka_id_pdfwysylka_seq OWNED BY dbo.ptaki_pdfwysylka.id_pdfwysylka;


--
-- Name: ptaki_pdfwysylkazal; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_pdfwysylkazal (
    id_pdfwysylkazal bigint NOT NULL,
    id_pdfwysylka integer NOT NULL,
    name text NOT NULL,
    content bytea NOT NULL,
    hash character varying(64)
);


ALTER TABLE dbo.ptaki_pdfwysylkazal OWNER TO postgres;

--
-- Name: ptaki_pdfwysylkazal_id_pdfwysylkazal_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_pdfwysylkazal_id_pdfwysylkazal_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_pdfwysylkazal_id_pdfwysylkazal_seq OWNER TO postgres;

--
-- Name: ptaki_pdfwysylkazal_id_pdfwysylkazal_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_pdfwysylkazal_id_pdfwysylkazal_seq OWNED BY dbo.ptaki_pdfwysylkazal.id_pdfwysylkazal;


--
-- Name: ptaki_prawa; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_prawa (
    id_prawa integer NOT NULL,
    nazwa text NOT NULL,
    rodzaj integer NOT NULL,
    lp integer NOT NULL
);


ALTER TABLE dbo.ptaki_prawa OWNER TO postgres;

--
-- Name: ptaki_ptakobr; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_ptakobr (
    id_ptakiobr bigint NOT NULL,
    id_stwpierwotne bigint NOT NULL,
    id_obr1 integer,
    id_obr2 integer
);


ALTER TABLE dbo.ptaki_ptakobr OWNER TO postgres;

--
-- Name: ptaki_ptakobr_id_ptakiobr_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_ptakobr_id_ptakiobr_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_ptakobr_id_ptakiobr_seq OWNER TO postgres;

--
-- Name: ptaki_ptakobr_id_ptakiobr_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_ptakobr_id_ptakiobr_seq OWNED BY dbo.ptaki_ptakobr.id_ptakiobr;


--
-- Name: ptaki_stwierdzenia; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_stwierdzenia (
    id_stw bigint NOT NULL,
    pierwotne boolean NOT NULL,
    id_poprawny integer,
    id_wer integer,
    id_gat1 integer,
    id_gat2 integer,
    gatunek text,
    id_manip integer,
    id_przem integer,
    id_chwyt integer,
    id_wabik integer,
    id_plec1 integer,
    id_plec2 integer,
    id_wiek1 integer,
    id_wiek2 integer,
    szata text,
    id_pomiar integer,
    pomr boolean,
    pomwartl numeric,
    pomwart text,
    id_status integer,
    lp integer,
    wiekpis integer,
    id_doklpis integer,
    data timestamp with time zone,
    id_dd integer,
    id_kond integer,
    id_okol integer,
    id_okolvalid integer,
    uwagi text,
    id_korespond bigint,
    wykaznr integer,
    wykazrok integer,
    r1ctr text,
    r1nrob text,
    r2ctr text,
    r2nrob text,
    rnrob text,
    id_obr1 integer,
    id_obr2 integer,
    imie text,
    nazwisko text,
    email text,
    zrdinfo boolean,
    odleglosc integer,
    czasodpierw integer,
    kat integer,
    id_lokalizacja bigint,
    infododnazwa text,
    infodod bytea,
    katportodromy numeric,
    inniznalazcy text,
    id_stwgosc integer,
    godzina smallint,
    minuty smallint,
    id_stwpierwotne bigint,
    datawpr timestamp with time zone,
    dataed timestamp with time zone,
    id_uzytkownika_wpr integer,
    id_uzytkownika_ed integer,
    adres text,
    datawer timestamp with time zone,
    wys_potw boolean DEFAULT false NOT NULL,
    zn_monitrodz smallint,
    zn_monit1data timestamp with time zone,
    zn_monit1ilosc smallint,
    zn_monit2data timestamp with time zone,
    zn_monit2ilosc smallint,
    zn_wyjas timestamp with time zone,
    id_szata integer,
    jezyk text,
    udost smallint DEFAULT '0'::smallint NOT NULL,
    id_pomiar1 integer,
    pomr1 boolean,
    pomwartl1 numeric,
    pomwart1 text,
    id_pomiar2 integer,
    pomr2 boolean,
    pomwartl2 numeric,
    pomwart2 text,
    id_pomiar3 integer,
    pomr3 boolean,
    pomwartl3 numeric,
    pomwart3 text,
    id_pomiar4 integer,
    pomr4 boolean,
    pomwartl4 numeric,
    pomwart4 text,
    id_pomiar5 integer,
    pomr5 boolean,
    pomwartl5 numeric,
    pomwart5 text,
    id_pomiar6 integer,
    pomr6 boolean,
    pomwartl6 numeric,
    pomwart6 text,
    id_pomiar7 integer,
    pomr7 boolean,
    pomwartl7 numeric,
    pomwart7 text,
    id_pomiar8 integer,
    pomr8 boolean,
    pomwartl8 numeric,
    pomwart8 text,
    id_pomiar9 integer,
    pomr9 boolean,
    pomwartl9 numeric,
    pomwart9 text,
    hash character varying(64)
);


ALTER TABLE dbo.ptaki_stwierdzenia OWNER TO postgres;

--
-- Name: ptaki_stwierdzenia_id_stw_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_stwierdzenia_id_stw_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_stwierdzenia_id_stw_seq OWNER TO postgres;

--
-- Name: ptaki_stwierdzenia_id_stw_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_stwierdzenia_id_stw_seq OWNED BY dbo.ptaki_stwierdzenia.id_stw;


--
-- Name: ptaki_stwierdzeniagoscie; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_stwierdzeniagoscie (
    id_stwgosc bigint NOT NULL,
    id_kto integer NOT NULL,
    imie text NOT NULL,
    nazwisko text NOT NULL,
    email text NOT NULL,
    adres text NOT NULL,
    dbfid text,
    jezyk text NOT NULL
);


ALTER TABLE dbo.ptaki_stwierdzeniagoscie OWNER TO postgres;

--
-- Name: ptaki_stwierdzeniagoscie_id_stwgosc_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_stwierdzeniagoscie_id_stwgosc_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_stwierdzeniagoscie_id_stwgosc_seq OWNER TO postgres;

--
-- Name: ptaki_stwierdzeniagoscie_id_stwgosc_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_stwierdzeniagoscie_id_stwgosc_seq OWNED BY dbo.ptaki_stwierdzeniagoscie.id_stwgosc;


--
-- Name: ptaki_stwierdzeniakoresp; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_stwierdzeniakoresp (
    id_stwkoresp bigint NOT NULL,
    id_stw bigint NOT NULL,
    koresp_rok integer,
    koresp_nr integer
);


ALTER TABLE dbo.ptaki_stwierdzeniakoresp OWNER TO postgres;

--
-- Name: ptaki_stwierdzeniakoresp_id_stwkoresp_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_stwierdzeniakoresp_id_stwkoresp_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_stwierdzeniakoresp_id_stwkoresp_seq OWNER TO postgres;

--
-- Name: ptaki_stwierdzeniakoresp_id_stwkoresp_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_stwierdzeniakoresp_id_stwkoresp_seq OWNED BY dbo.ptaki_stwierdzeniakoresp.id_stwkoresp;


--
-- Name: ptaki_stwierdzeniapliki; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_stwierdzeniapliki (
    id_pliki bigint NOT NULL,
    id_stw bigint NOT NULL,
    nazwa text NOT NULL,
    plik bytea,
    hash character varying(64)
);


ALTER TABLE dbo.ptaki_stwierdzeniapliki OWNER TO postgres;

--
-- Name: ptaki_stwierdzeniapliki_id_pliki_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_stwierdzeniapliki_id_pliki_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_stwierdzeniapliki_id_pliki_seq OWNER TO postgres;

--
-- Name: ptaki_stwierdzeniapliki_id_pliki_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_stwierdzeniapliki_id_pliki_seq OWNED BY dbo.ptaki_stwierdzeniapliki.id_pliki;


--
-- Name: ptaki_stwierdzeniapol; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_stwierdzeniapol (
    id_stwierdzeniapol bigint NOT NULL,
    id_stw bigint NOT NULL,
    id_uzytkownika integer,
    id_ctr integer
);


ALTER TABLE dbo.ptaki_stwierdzeniapol OWNER TO postgres;

--
-- Name: ptaki_stwierdzeniapol_id_stwierdzeniapol_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_stwierdzeniapol_id_stwierdzeniapol_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_stwierdzeniapol_id_stwierdzeniapol_seq OWNER TO postgres;

--
-- Name: ptaki_stwierdzeniapol_id_stwierdzeniapol_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_stwierdzeniapol_id_stwierdzeniapol_seq OWNED BY dbo.ptaki_stwierdzeniapol.id_stwierdzeniapol;


--
-- Name: ptaki_stwierdzeniarodz; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_stwierdzeniarodz (
    id_stw bigint NOT NULL,
    nrrodz smallint NOT NULL,
    id_obraczki bigint NOT NULL
);


ALTER TABLE dbo.ptaki_stwierdzeniarodz OWNER TO postgres;

--
-- Name: ptaki_stwierdzeniawer; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_stwierdzeniawer (
    id_stw bigint NOT NULL,
    lp integer NOT NULL,
    krytyczny boolean NOT NULL,
    nazwa text,
    id_werst text,
    werst_par1 text,
    werst_par2 text,
    akc boolean,
    akc_par text
);


ALTER TABLE dbo.ptaki_stwierdzeniawer OWNER TO postgres;

--
-- Name: ptaki_stwimport; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_stwimport (
    id_stwimport bigint NOT NULL,
    numer integer NOT NULL,
    rok integer NOT NULL,
    data timestamp with time zone NOT NULL,
    id_uzytkownika integer,
    plik bytea,
    iloscstw integer,
    iloscstwb1 integer,
    iloscstwb2 integer,
    nazwa_pliku text NOT NULL,
    etap smallint NOT NULL,
    typ integer DEFAULT 1 NOT NULL,
    nrgps text,
    id_gat integer,
    udostgps boolean,
    hash character varying(64)
);


ALTER TABLE dbo.ptaki_stwimport OWNER TO postgres;

--
-- Name: ptaki_stwimport_bld; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_stwimport_bld (
    id_stwimport integer NOT NULL,
    wiersz integer,
    kolumna text,
    blad text NOT NULL,
    id_stwimport_bld bigint NOT NULL
);


ALTER TABLE dbo.ptaki_stwimport_bld OWNER TO postgres;

--
-- Name: ptaki_stwimport_bld_id_stwimport_bld_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_stwimport_bld_id_stwimport_bld_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_stwimport_bld_id_stwimport_bld_seq OWNER TO postgres;

--
-- Name: ptaki_stwimport_bld_id_stwimport_bld_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_stwimport_bld_id_stwimport_bld_seq OWNED BY dbo.ptaki_stwimport_bld.id_stwimport_bld;


--
-- Name: ptaki_stwimport_id_stwimport_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_stwimport_id_stwimport_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_stwimport_id_stwimport_seq OWNER TO postgres;

--
-- Name: ptaki_stwimport_id_stwimport_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_stwimport_id_stwimport_seq OWNED BY dbo.ptaki_stwimport.id_stwimport;


--
-- Name: ptaki_stwimport_stw; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_stwimport_stw (
    id_stw bigint NOT NULL,
    id_stwimport integer NOT NULL,
    stw integer NOT NULL
);


ALTER TABLE dbo.ptaki_stwimport_stw OWNER TO postgres;

--
-- Name: ptaki_stwpopr; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_stwpopr (
    id_stwpopr bigint NOT NULL,
    id_stw bigint,
    lp integer NOT NULL,
    id_uzytkownika_user integer,
    id_uzytkownika_stacja integer,
    info_user text NOT NULL,
    info_stacja text,
    data_user timestamp with time zone NOT NULL,
    data_stacja timestamp with time zone,
    status integer NOT NULL,
    id_stworyg bigint NOT NULL
);


ALTER TABLE dbo.ptaki_stwpopr OWNER TO postgres;

--
-- Name: ptaki_stwpopr_id_stwpopr_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_stwpopr_id_stwpopr_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_stwpopr_id_stwpopr_seq OWNER TO postgres;

--
-- Name: ptaki_stwpopr_id_stwpopr_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_stwpopr_id_stwpopr_seq OWNED BY dbo.ptaki_stwpopr.id_stwpopr;


--
-- Name: ptaki_szablonywydrukow; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_szablonywydrukow (
    nazwa text NOT NULL,
    szablon text
);


ALTER TABLE dbo.ptaki_szablonywydrukow OWNER TO postgres;

--
-- Name: ptaki_telefony; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_telefony (
    id_telefon bigint NOT NULL,
    id_obraczkarz integer NOT NULL,
    numer text NOT NULL,
    opis text NOT NULL
);


ALTER TABLE dbo.ptaki_telefony OWNER TO postgres;

--
-- Name: ptaki_telefony_id_telefon_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_telefony_id_telefon_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_telefony_id_telefon_seq OWNER TO postgres;

--
-- Name: ptaki_telefony_id_telefon_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_telefony_id_telefon_seq OWNED BY dbo.ptaki_telefony.id_telefon;


--
-- Name: ptaki_uzytkownicy; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_uzytkownicy (
    id_uzytkownika bigint NOT NULL,
    login text NOT NULL,
    imie text NOT NULL,
    nazwisko text NOT NULL,
    haslo text NOT NULL,
    email text NOT NULL,
    blokada boolean DEFAULT false,
    usuniety timestamp with time zone,
    id_kto integer NOT NULL,
    jezyk text NOT NULL,
    zagrkol boolean NOT NULL,
    automat boolean,
    uwagi text,
    dbfid text
);


ALTER TABLE dbo.ptaki_uzytkownicy OWNER TO postgres;

--
-- Name: ptaki_uzytkownicy_id_uzytkownika_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_uzytkownicy_id_uzytkownika_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_uzytkownicy_id_uzytkownika_seq OWNER TO postgres;

--
-- Name: ptaki_uzytkownicy_id_uzytkownika_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_uzytkownicy_id_uzytkownika_seq OWNED BY dbo.ptaki_uzytkownicy.id_uzytkownika;


--
-- Name: ptaki_uzytkownicy_prawa; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_uzytkownicy_prawa (
    id_uzytkownika integer NOT NULL,
    id_prawa integer NOT NULL,
    rodzaj integer NOT NULL,
    wartosc_int integer,
    wartosc_str text,
    wartosc_dec numeric
);


ALTER TABLE dbo.ptaki_uzytkownicy_prawa OWNER TO postgres;

--
-- Name: ptaki_wwwhelp; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_wwwhelp (
    id_wwwhelp bigint NOT NULL,
    data timestamp with time zone NOT NULL,
    temat text NOT NULL,
    tresc text NOT NULL,
    jezyk text NOT NULL,
    wid_gosc boolean NOT NULL,
    wid_uzyt boolean NOT NULL,
    wid_obr boolean NOT NULL
);


ALTER TABLE dbo.ptaki_wwwhelp OWNER TO postgres;

--
-- Name: ptaki_wwwhelp_id_wwwhelp_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_wwwhelp_id_wwwhelp_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_wwwhelp_id_wwwhelp_seq OWNER TO postgres;

--
-- Name: ptaki_wwwhelp_id_wwwhelp_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_wwwhelp_id_wwwhelp_seq OWNED BY dbo.ptaki_wwwhelp.id_wwwhelp;


--
-- Name: ptaki_zadaniakolejka; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_zadaniakolejka (
    id_zadaniakolejka bigint NOT NULL,
    sesja text NOT NULL,
    lp integer NOT NULL,
    zadanie integer NOT NULL,
    dodano timestamp with time zone NOT NULL,
    anulowane boolean NOT NULL,
    sesja_wyk text,
    rozpoczecie timestamp with time zone,
    zakonczenie timestamp with time zone,
    ilosc integer,
    komunikat text
);


ALTER TABLE dbo.ptaki_zadaniakolejka OWNER TO postgres;

--
-- Name: ptaki_zadaniakolejka_id_zadaniakolejka_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_zadaniakolejka_id_zadaniakolejka_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_zadaniakolejka_id_zadaniakolejka_seq OWNER TO postgres;

--
-- Name: ptaki_zadaniakolejka_id_zadaniakolejka_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_zadaniakolejka_id_zadaniakolejka_seq OWNED BY dbo.ptaki_zadaniakolejka.id_zadaniakolejka;


--
-- Name: ptaki_zakresobracz; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_zakresobracz (
    id_zakresobracz bigint NOT NULL,
    id_obraczkarz integer NOT NULL,
    opis text NOT NULL
);


ALTER TABLE dbo.ptaki_zakresobracz OWNER TO postgres;

--
-- Name: ptaki_zakresobracz_id_zakresobracz_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_zakresobracz_id_zakresobracz_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_zakresobracz_id_zakresobracz_seq OWNER TO postgres;

--
-- Name: ptaki_zakresobracz_id_zakresobracz_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_zakresobracz_id_zakresobracz_seq OWNED BY dbo.ptaki_zakresobracz.id_zakresobracz;


--
-- Name: ptaki_zakresobraczrodzaj; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_zakresobraczrodzaj (
    id_zakresobraczrodzaj bigint NOT NULL,
    nazwa text NOT NULL
);


ALTER TABLE dbo.ptaki_zakresobraczrodzaj OWNER TO postgres;

--
-- Name: ptaki_zakresobraczrodzaj_id_zakresobraczrodzaj_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_zakresobraczrodzaj_id_zakresobraczrodzaj_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_zakresobraczrodzaj_id_zakresobraczrodzaj_seq OWNER TO postgres;

--
-- Name: ptaki_zakresobraczrodzaj_id_zakresobraczrodzaj_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_zakresobraczrodzaj_id_zakresobraczrodzaj_seq OWNED BY dbo.ptaki_zakresobraczrodzaj.id_zakresobraczrodzaj;


--
-- Name: ptaki_zamowienia; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_zamowienia (
    id_zamow bigint NOT NULL,
    id_obraczkarz integer NOT NULL,
    data timestamp with time zone NOT NULL,
    anulowane boolean DEFAULT false NOT NULL,
    zrealizowane boolean DEFAULT false NOT NULL
);


ALTER TABLE dbo.ptaki_zamowienia OWNER TO postgres;

--
-- Name: ptaki_zamowienia_id_zamow_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_zamowienia_id_zamow_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_zamowienia_id_zamow_seq OWNER TO postgres;

--
-- Name: ptaki_zamowienia_id_zamow_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_zamowienia_id_zamow_seq OWNED BY dbo.ptaki_zamowienia.id_zamow;


--
-- Name: ptaki_zamowieniadok; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_zamowieniadok (
    id_zamowdok bigint NOT NULL,
    id_uzytkownika integer NOT NULL,
    data timestamp with time zone NOT NULL
);


ALTER TABLE dbo.ptaki_zamowieniadok OWNER TO postgres;

--
-- Name: ptaki_zamowieniadok_id_zamowdok_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_zamowieniadok_id_zamowdok_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_zamowieniadok_id_zamowdok_seq OWNER TO postgres;

--
-- Name: ptaki_zamowieniadok_id_zamowdok_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_zamowieniadok_id_zamowdok_seq OWNED BY dbo.ptaki_zamowieniadok.id_zamowdok;


--
-- Name: ptaki_zamowieniadokpoz; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_zamowieniadokpoz (
    id_zamowdokpoz bigint NOT NULL,
    id_zamowdok integer NOT NULL,
    id_dokum integer NOT NULL,
    id_zamow integer NOT NULL
);


ALTER TABLE dbo.ptaki_zamowieniadokpoz OWNER TO postgres;

--
-- Name: ptaki_zamowieniadokpoz_id_zamowdokpoz_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_zamowieniadokpoz_id_zamowdokpoz_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_zamowieniadokpoz_id_zamowdokpoz_seq OWNER TO postgres;

--
-- Name: ptaki_zamowieniadokpoz_id_zamowdokpoz_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_zamowieniadokpoz_id_zamowdokpoz_seq OWNED BY dbo.ptaki_zamowieniadokpoz.id_zamowdokpoz;


--
-- Name: ptaki_zamowieniapoz; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.ptaki_zamowieniapoz (
    id_zamowpoz bigint NOT NULL,
    id_zamow integer NOT NULL,
    id_obraczkityp integer NOT NULL,
    ilosc integer NOT NULL,
    ilosczrealizowana integer NOT NULL,
    sposobplatnosci integer NOT NULL
);


ALTER TABLE dbo.ptaki_zamowieniapoz OWNER TO postgres;

--
-- Name: ptaki_zamowieniapoz_id_zamowpoz_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.ptaki_zamowieniapoz_id_zamowpoz_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.ptaki_zamowieniapoz_id_zamowpoz_seq OWNER TO postgres;

--
-- Name: ptaki_zamowieniapoz_id_zamowpoz_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.ptaki_zamowieniapoz_id_zamowpoz_seq OWNED BY dbo.ptaki_zamowieniapoz.id_zamowpoz;


--
-- Name: sysdiagrams; Type: TABLE; Schema: dbo; Owner: postgres
--

CREATE TABLE dbo.sysdiagrams (
    name text NOT NULL,
    principal_id integer NOT NULL,
    diagram_id bigint NOT NULL,
    version integer,
    definition bytea
);


ALTER TABLE dbo.sysdiagrams OWNER TO postgres;

--
-- Name: sysdiagrams_diagram_id_seq; Type: SEQUENCE; Schema: dbo; Owner: postgres
--

CREATE SEQUENCE dbo.sysdiagrams_diagram_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbo.sysdiagrams_diagram_id_seq OWNER TO postgres;

--
-- Name: sysdiagrams_diagram_id_seq; Type: SEQUENCE OWNED BY; Schema: dbo; Owner: postgres
--

ALTER SEQUENCE dbo.sysdiagrams_diagram_id_seq OWNED BY dbo.sysdiagrams.diagram_id;


--
-- Name: dtproperties id; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.dtproperties ALTER COLUMN id SET DEFAULT nextval('dbo.dtproperties_id_seq'::regclass);


--
-- Name: ptaki_adresy id_adres; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_adresy ALTER COLUMN id_adres SET DEFAULT nextval('dbo.ptaki_adresy_id_adres_seq'::regclass);


--
-- Name: ptaki_bk_chwyt id_chwyt; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_chwyt ALTER COLUMN id_chwyt SET DEFAULT nextval('dbo.ptaki_bk_chwyt_id_chwyt_seq'::regclass);


--
-- Name: ptaki_bk_ctr id_ctr; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_ctr ALTER COLUMN id_ctr SET DEFAULT nextval('dbo.ptaki_bk_ctr_id_ctr_seq'::regclass);


--
-- Name: ptaki_bk_dd id_dd; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_dd ALTER COLUMN id_dd SET DEFAULT nextval('dbo.ptaki_bk_dd_id_dd_seq'::regclass);


--
-- Name: ptaki_bk_dk id_dk; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_dk ALTER COLUMN id_dk SET DEFAULT nextval('dbo.ptaki_bk_dk_id_dk_seq'::regclass);


--
-- Name: ptaki_bk_doklpis id_doklpis; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_doklpis ALTER COLUMN id_doklpis SET DEFAULT nextval('dbo.ptaki_bk_doklpis_id_doklpis_seq'::regclass);


--
-- Name: ptaki_bk_gatunek id_gat; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_gatunek ALTER COLUMN id_gat SET DEFAULT nextval('dbo.ptaki_bk_gatunek_id_gat_seq'::regclass);


--
-- Name: ptaki_bk_gatunekgrupa id_grupa; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_gatunekgrupa ALTER COLUMN id_grupa SET DEFAULT nextval('dbo.ptaki_bk_gatunekgrupa_id_grupa_seq'::regclass);


--
-- Name: ptaki_bk_gatunektyp id_gattyp; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_gatunektyp ALTER COLUMN id_gattyp SET DEFAULT nextval('dbo.ptaki_bk_gatunektyp_id_gattyp_seq'::regclass);


--
-- Name: ptaki_bk_gatunekwiek id_gatwiek; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_gatunekwiek ALTER COLUMN id_gatwiek SET DEFAULT nextval('dbo.ptaki_bk_gatunekwiek_id_gatwiek_seq'::regclass);


--
-- Name: ptaki_bk_kolor id_kolor; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_kolor ALTER COLUMN id_kolor SET DEFAULT nextval('dbo.ptaki_bk_kolor_id_kolor_seq'::regclass);


--
-- Name: ptaki_bk_kondycja id_kond; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_kondycja ALTER COLUMN id_kond SET DEFAULT nextval('dbo.ptaki_bk_kondycja_id_kond_seq'::regclass);


--
-- Name: ptaki_bk_kraj id_kraj; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_kraj ALTER COLUMN id_kraj SET DEFAULT nextval('dbo.ptaki_bk_kraj_id_kraj_seq'::regclass);


--
-- Name: ptaki_bk_krajctr id_krajctr; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_krajctr ALTER COLUMN id_krajctr SET DEFAULT nextval('dbo.ptaki_bk_krajctr_id_krajctr_seq'::regclass);


--
-- Name: ptaki_bk_manip id_manip; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_manip ALTER COLUMN id_manip SET DEFAULT nextval('dbo.ptaki_bk_manip_id_manip_seq'::regclass);


--
-- Name: ptaki_bk_obszar id_obszaru; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_obszar ALTER COLUMN id_obszaru SET DEFAULT nextval('dbo.ptaki_bk_obszar_id_obszaru_seq'::regclass);


--
-- Name: ptaki_bk_okol id_okol; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_okol ALTER COLUMN id_okol SET DEFAULT nextval('dbo.ptaki_bk_okol_id_okol_seq'::regclass);


--
-- Name: ptaki_bk_okolvalid id_okolvalid; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_okolvalid ALTER COLUMN id_okolvalid SET DEFAULT nextval('dbo.ptaki_bk_okolvalid_id_okolvalid_seq'::regclass);


--
-- Name: ptaki_bk_plec id_plec; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_plec ALTER COLUMN id_plec SET DEFAULT nextval('dbo.ptaki_bk_plec_id_plec_seq'::regclass);


--
-- Name: ptaki_bk_pomiar id_pomiar; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_pomiar ALTER COLUMN id_pomiar SET DEFAULT nextval('dbo.ptaki_bk_pomiar_id_pomiar_seq'::regclass);


--
-- Name: ptaki_bk_prowincja id_prow; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_prowincja ALTER COLUMN id_prow SET DEFAULT nextval('dbo.ptaki_bk_prowincja_id_prow_seq'::regclass);


--
-- Name: ptaki_bk_przem id_przem; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_przem ALTER COLUMN id_przem SET DEFAULT nextval('dbo.ptaki_bk_przem_id_przem_seq'::regclass);


--
-- Name: ptaki_bk_stanzn id_stan; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_stanzn ALTER COLUMN id_stan SET DEFAULT nextval('dbo.ptaki_bk_stanzn_id_stan_seq'::regclass);


--
-- Name: ptaki_bk_status id_status; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_status ALTER COLUMN id_status SET DEFAULT nextval('dbo.ptaki_bk_status_id_status_seq'::regclass);


--
-- Name: ptaki_bk_szata id_szata; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_szata ALTER COLUMN id_szata SET DEFAULT nextval('dbo.ptaki_bk_szata_id_szata_seq'::regclass);


--
-- Name: ptaki_bk_typobr id_typ; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_typobr ALTER COLUMN id_typ SET DEFAULT nextval('dbo.ptaki_bk_typobr_id_typ_seq'::regclass);


--
-- Name: ptaki_bk_wabik id_wabik; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_wabik ALTER COLUMN id_wabik SET DEFAULT nextval('dbo.ptaki_bk_wabik_id_wabik_seq'::regclass);


--
-- Name: ptaki_bk_wer id_wer; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_wer ALTER COLUMN id_wer SET DEFAULT nextval('dbo.ptaki_bk_wer_id_wer_seq'::regclass);


--
-- Name: ptaki_bk_wiek id_wiek; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_wiek ALTER COLUMN id_wiek SET DEFAULT nextval('dbo.ptaki_bk_wiek_id_wiek_seq'::regclass);


--
-- Name: ptaki_dfiles id_dfiles; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_dfiles ALTER COLUMN id_dfiles SET DEFAULT nextval('dbo.ptaki_dfiles_id_dfiles_seq'::regclass);


--
-- Name: ptaki_doktozsamrodzaj id_doktozsamrodzaj; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_doktozsamrodzaj ALTER COLUMN id_doktozsamrodzaj SET DEFAULT nextval('dbo.ptaki_doktozsamrodzaj_id_doktozsamrodzaj_seq'::regclass);


--
-- Name: ptaki_dostawcy id_dostawca; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_dostawcy ALTER COLUMN id_dostawca SET DEFAULT nextval('dbo.ptaki_dostawcy_id_dostawca_seq'::regclass);


--
-- Name: ptaki_emailewysylka id_emailwysylka; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_emailewysylka ALTER COLUMN id_emailwysylka SET DEFAULT nextval('dbo.ptaki_emailewysylka_id_emailwysylka_seq'::regclass);


--
-- Name: ptaki_emailewysylkabld id_emailewysylkabld; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_emailewysylkabld ALTER COLUMN id_emailewysylkabld SET DEFAULT nextval('dbo.ptaki_emailewysylkabld_id_emailewysylkabld_seq'::regclass);


--
-- Name: ptaki_emailewysylkazal id_emailwysylkazal; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_emailewysylkazal ALTER COLUMN id_emailwysylkazal SET DEFAULT nextval('dbo.ptaki_emailewysylkazal_id_emailwysylkazal_seq'::regclass);


--
-- Name: ptaki_emailwzorzecpar id_emailwzorzecpar; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_emailwzorzecpar ALTER COLUMN id_emailwzorzecpar SET DEFAULT nextval('dbo.ptaki_emailwzorzecpar_id_emailwzorzecpar_seq'::regclass);


--
-- Name: ptaki_goscie id_gosc; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_goscie ALTER COLUMN id_gosc SET DEFAULT nextval('dbo.ptaki_goscie_id_gosc_seq'::regclass);


--
-- Name: ptaki_goscieoczek id_goscieoczek; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_goscieoczek ALTER COLUMN id_goscieoczek SET DEFAULT nextval('dbo.ptaki_goscieoczek_id_goscieoczek_seq'::regclass);


--
-- Name: ptaki_komunikaty id_komunikaty; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_komunikaty ALTER COLUMN id_komunikaty SET DEFAULT nextval('dbo.ptaki_komunikaty_id_komunikaty_seq'::regclass);


--
-- Name: ptaki_licencje id_licencja; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_licencje ALTER COLUMN id_licencja SET DEFAULT nextval('dbo.ptaki_licencje_id_licencja_seq'::regclass);


--
-- Name: ptaki_lokalizacja id_lokalizacja; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_lokalizacja ALTER COLUMN id_lokalizacja SET DEFAULT nextval('dbo.ptaki_lokalizacja_id_lokalizacja_seq'::regclass);


--
-- Name: ptaki_magdokum id_dokum; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magdokum ALTER COLUMN id_dokum SET DEFAULT nextval('dbo.ptaki_magdokum_id_dokum_seq'::regclass);


--
-- Name: ptaki_magdokumpoz id_dokumpoz; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magdokumpoz ALTER COLUMN id_dokumpoz SET DEFAULT nextval('dbo.ptaki_magdokumpoz_id_dokumpoz_seq'::regclass);


--
-- Name: ptaki_magkolorowe id_magkolorowe; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magkolorowe ALTER COLUMN id_magkolorowe SET DEFAULT nextval('dbo.ptaki_magkolorowe_id_magkolorowe_seq'::regclass);


--
-- Name: ptaki_magobraczki id_obraczki; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magobraczki ALTER COLUMN id_obraczki SET DEFAULT nextval('dbo.ptaki_magobraczki_id_obraczki_seq'::regclass);


--
-- Name: ptaki_magobraczkipodtyp id_obraczkipodtyp; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magobraczkipodtyp ALTER COLUMN id_obraczkipodtyp SET DEFAULT nextval('dbo.ptaki_magobraczkipodtyp_id_obraczkipodtyp_seq'::regclass);


--
-- Name: ptaki_magobraczkityp id_obraczkityp; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magobraczkityp ALTER COLUMN id_obraczkityp SET DEFAULT nextval('dbo.ptaki_magobraczkityp_id_obraczkityp_seq'::regclass);


--
-- Name: ptaki_magobraczkiwykluczenia id_wyklucz; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magobraczkiwykluczenia ALTER COLUMN id_wyklucz SET DEFAULT nextval('dbo.ptaki_magobraczkiwykluczenia_id_wyklucz_seq'::regclass);


--
-- Name: ptaki_monity id_monit; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_monity ALTER COLUMN id_monit SET DEFAULT nextval('dbo.ptaki_monity_id_monit_seq'::regclass);


--
-- Name: ptaki_obraczkarze id_obraczkarz; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_obraczkarze ALTER COLUMN id_obraczkarz SET DEFAULT nextval('dbo.ptaki_obraczkarze_id_obraczkarz_seq'::regclass);


--
-- Name: ptaki_obraczki id_obraczki; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_obraczki ALTER COLUMN id_obraczki SET DEFAULT nextval('dbo.ptaki_obraczki_id_obraczki_seq'::regclass);


--
-- Name: ptaki_obraczkistan id_obraczkistan; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_obraczkistan ALTER COLUMN id_obraczkistan SET DEFAULT nextval('dbo.ptaki_obraczkistan_id_obraczkistan_seq'::regclass);


--
-- Name: ptaki_pdfwysylka id_pdfwysylka; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_pdfwysylka ALTER COLUMN id_pdfwysylka SET DEFAULT nextval('dbo.ptaki_pdfwysylka_id_pdfwysylka_seq'::regclass);


--
-- Name: ptaki_pdfwysylkazal id_pdfwysylkazal; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_pdfwysylkazal ALTER COLUMN id_pdfwysylkazal SET DEFAULT nextval('dbo.ptaki_pdfwysylkazal_id_pdfwysylkazal_seq'::regclass);


--
-- Name: ptaki_ptakobr id_ptakiobr; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_ptakobr ALTER COLUMN id_ptakiobr SET DEFAULT nextval('dbo.ptaki_ptakobr_id_ptakiobr_seq'::regclass);


--
-- Name: ptaki_stwierdzenia id_stw; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia ALTER COLUMN id_stw SET DEFAULT nextval('dbo.ptaki_stwierdzenia_id_stw_seq'::regclass);


--
-- Name: ptaki_stwierdzeniagoscie id_stwgosc; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzeniagoscie ALTER COLUMN id_stwgosc SET DEFAULT nextval('dbo.ptaki_stwierdzeniagoscie_id_stwgosc_seq'::regclass);


--
-- Name: ptaki_stwierdzeniakoresp id_stwkoresp; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzeniakoresp ALTER COLUMN id_stwkoresp SET DEFAULT nextval('dbo.ptaki_stwierdzeniakoresp_id_stwkoresp_seq'::regclass);


--
-- Name: ptaki_stwierdzeniapliki id_pliki; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzeniapliki ALTER COLUMN id_pliki SET DEFAULT nextval('dbo.ptaki_stwierdzeniapliki_id_pliki_seq'::regclass);


--
-- Name: ptaki_stwierdzeniapol id_stwierdzeniapol; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzeniapol ALTER COLUMN id_stwierdzeniapol SET DEFAULT nextval('dbo.ptaki_stwierdzeniapol_id_stwierdzeniapol_seq'::regclass);


--
-- Name: ptaki_stwimport id_stwimport; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwimport ALTER COLUMN id_stwimport SET DEFAULT nextval('dbo.ptaki_stwimport_id_stwimport_seq'::regclass);


--
-- Name: ptaki_stwimport_bld id_stwimport_bld; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwimport_bld ALTER COLUMN id_stwimport_bld SET DEFAULT nextval('dbo.ptaki_stwimport_bld_id_stwimport_bld_seq'::regclass);


--
-- Name: ptaki_stwpopr id_stwpopr; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwpopr ALTER COLUMN id_stwpopr SET DEFAULT nextval('dbo.ptaki_stwpopr_id_stwpopr_seq'::regclass);


--
-- Name: ptaki_telefony id_telefon; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_telefony ALTER COLUMN id_telefon SET DEFAULT nextval('dbo.ptaki_telefony_id_telefon_seq'::regclass);


--
-- Name: ptaki_uzytkownicy id_uzytkownika; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_uzytkownicy ALTER COLUMN id_uzytkownika SET DEFAULT nextval('dbo.ptaki_uzytkownicy_id_uzytkownika_seq'::regclass);


--
-- Name: ptaki_wwwhelp id_wwwhelp; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_wwwhelp ALTER COLUMN id_wwwhelp SET DEFAULT nextval('dbo.ptaki_wwwhelp_id_wwwhelp_seq'::regclass);


--
-- Name: ptaki_zadaniakolejka id_zadaniakolejka; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_zadaniakolejka ALTER COLUMN id_zadaniakolejka SET DEFAULT nextval('dbo.ptaki_zadaniakolejka_id_zadaniakolejka_seq'::regclass);


--
-- Name: ptaki_zakresobracz id_zakresobracz; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_zakresobracz ALTER COLUMN id_zakresobracz SET DEFAULT nextval('dbo.ptaki_zakresobracz_id_zakresobracz_seq'::regclass);


--
-- Name: ptaki_zakresobraczrodzaj id_zakresobraczrodzaj; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_zakresobraczrodzaj ALTER COLUMN id_zakresobraczrodzaj SET DEFAULT nextval('dbo.ptaki_zakresobraczrodzaj_id_zakresobraczrodzaj_seq'::regclass);


--
-- Name: ptaki_zamowienia id_zamow; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_zamowienia ALTER COLUMN id_zamow SET DEFAULT nextval('dbo.ptaki_zamowienia_id_zamow_seq'::regclass);


--
-- Name: ptaki_zamowieniadok id_zamowdok; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_zamowieniadok ALTER COLUMN id_zamowdok SET DEFAULT nextval('dbo.ptaki_zamowieniadok_id_zamowdok_seq'::regclass);


--
-- Name: ptaki_zamowieniadokpoz id_zamowdokpoz; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_zamowieniadokpoz ALTER COLUMN id_zamowdokpoz SET DEFAULT nextval('dbo.ptaki_zamowieniadokpoz_id_zamowdokpoz_seq'::regclass);


--
-- Name: ptaki_zamowieniapoz id_zamowpoz; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_zamowieniapoz ALTER COLUMN id_zamowpoz SET DEFAULT nextval('dbo.ptaki_zamowieniapoz_id_zamowpoz_seq'::regclass);


--
-- Name: sysdiagrams diagram_id; Type: DEFAULT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.sysdiagrams ALTER COLUMN diagram_id SET DEFAULT nextval('dbo.sysdiagrams_diagram_id_seq'::regclass);


--
-- Name: aspnet_sqlcachetablesforchangenotification idx_16514_pk__aspnet_s__93f7ac694ffcbe51; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.aspnet_sqlcachetablesforchangenotification
    ADD CONSTRAINT idx_16514_pk__aspnet_s__93f7ac694ffcbe51 PRIMARY KEY (tablename);


--
-- Name: aspnet_sqlpagestatepersister idx_16521_pk_aspnet_sqlpagestatepersister; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.aspnet_sqlpagestatepersister
    ADD CONSTRAINT idx_16521_pk_aspnet_sqlpagestatepersister PRIMARY KEY (id_state);


--
-- Name: dtproperties idx_16527_pk_dtproperties; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.dtproperties
    ADD CONSTRAINT idx_16527_pk_dtproperties PRIMARY KEY (id, property);


--
-- Name: ptaki_adresy idx_16535_pk_ptaki_adresy; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_adresy
    ADD CONSTRAINT idx_16535_pk_ptaki_adresy PRIMARY KEY (id_adres);


--
-- Name: ptaki_adresyrodzaj idx_16543_pk_ptaki_adresyrodzaj; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_adresyrodzaj
    ADD CONSTRAINT idx_16543_pk_ptaki_adresyrodzaj PRIMARY KEY (id_adresyrodzaj);


--
-- Name: ptaki_bk_chwyt idx_16549_pk_ptaki_bk_chwyt; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_chwyt
    ADD CONSTRAINT idx_16549_pk_ptaki_bk_chwyt PRIMARY KEY (id_chwyt);


--
-- Name: ptaki_bk_ctr idx_16559_pk_ptaki_bk_ctr; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_ctr
    ADD CONSTRAINT idx_16559_pk_ptaki_bk_ctr PRIMARY KEY (id_ctr);


--
-- Name: ptaki_bk_dd idx_16569_pk_ptaki_bk_dd; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_dd
    ADD CONSTRAINT idx_16569_pk_ptaki_bk_dd PRIMARY KEY (id_dd);


--
-- Name: ptaki_bk_dk idx_16579_pk_ptaki_bk_dk; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_dk
    ADD CONSTRAINT idx_16579_pk_ptaki_bk_dk PRIMARY KEY (id_dk);


--
-- Name: ptaki_bk_doklpis idx_16589_pk_ptaki_bk_doklpis; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_doklpis
    ADD CONSTRAINT idx_16589_pk_ptaki_bk_doklpis PRIMARY KEY (id_doklpis);


--
-- Name: ptaki_bk_gatunek idx_16599_pk_ptaki_bk_gatunek; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_gatunek
    ADD CONSTRAINT idx_16599_pk_ptaki_bk_gatunek PRIMARY KEY (id_gat);


--
-- Name: ptaki_bk_gatunekgrupa idx_16609_pk_ptaki_bk_gatunekgrupa; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_gatunekgrupa
    ADD CONSTRAINT idx_16609_pk_ptaki_bk_gatunekgrupa PRIMARY KEY (id_grupa);


--
-- Name: ptaki_bk_gatunekgrupa_gatunki idx_16615_pk_ptaki_bk_gatunekgrupa_gatunki; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_gatunekgrupa_gatunki
    ADD CONSTRAINT idx_16615_pk_ptaki_bk_gatunekgrupa_gatunki PRIMARY KEY (id_grupa, id_gat);


--
-- Name: ptaki_bk_gatunekold idx_16618_pk_ptaki_bk_gatunekold; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_gatunekold
    ADD CONSTRAINT idx_16618_pk_ptaki_bk_gatunekold PRIMARY KEY (lat);


--
-- Name: ptaki_bk_gatunektyp idx_16627_pkptaki_bk_gatunektyp; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_gatunektyp
    ADD CONSTRAINT idx_16627_pkptaki_bk_gatunektyp PRIMARY KEY (id_gattyp);


--
-- Name: ptaki_bk_gatunekwiek idx_16633_pk_ptaki_bk_gatunekwiek; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_gatunekwiek
    ADD CONSTRAINT idx_16633_pk_ptaki_bk_gatunekwiek PRIMARY KEY (id_gatwiek);


--
-- Name: ptaki_bk_kolor idx_16639_pk_ptaki_bk_kolor; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_kolor
    ADD CONSTRAINT idx_16639_pk_ptaki_bk_kolor PRIMARY KEY (id_kolor);


--
-- Name: ptaki_bk_kondycja idx_16649_pk_ptaki_bk_kondycja; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_kondycja
    ADD CONSTRAINT idx_16649_pk_ptaki_bk_kondycja PRIMARY KEY (id_kond);


--
-- Name: ptaki_bk_kraj idx_16660_pk_ptaki_bk_kraj; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_kraj
    ADD CONSTRAINT idx_16660_pk_ptaki_bk_kraj PRIMARY KEY (id_kraj);


--
-- Name: ptaki_bk_krajctr idx_16670_pk_ptaki_bk_ptaki_bk_krajctr; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_krajctr
    ADD CONSTRAINT idx_16670_pk_ptaki_bk_ptaki_bk_krajctr PRIMARY KEY (id_krajctr);


--
-- Name: ptaki_bk_kto idx_16677_pk_ptaki_bk_kto; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_kto
    ADD CONSTRAINT idx_16677_pk_ptaki_bk_kto PRIMARY KEY (id_kto);


--
-- Name: ptaki_bk_manip idx_16683_pk_ptaki_bk_manip; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_manip
    ADD CONSTRAINT idx_16683_pk_ptaki_bk_manip PRIMARY KEY (id_manip);


--
-- Name: ptaki_bk_obszar idx_16693_pk_ptaki_bk_obszar; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_obszar
    ADD CONSTRAINT idx_16693_pk_ptaki_bk_obszar PRIMARY KEY (id_obszaru);


--
-- Name: ptaki_bk_okol idx_16701_pk_ptaki_bk_ok; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_okol
    ADD CONSTRAINT idx_16701_pk_ptaki_bk_ok PRIMARY KEY (id_okol);


--
-- Name: ptaki_bk_okolvalid idx_16711_pk_ptaki_bk_okolvalid; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_okolvalid
    ADD CONSTRAINT idx_16711_pk_ptaki_bk_okolvalid PRIMARY KEY (id_okolvalid);


--
-- Name: ptaki_bk_plec idx_16721_pk_ptaki_bk_plec; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_plec
    ADD CONSTRAINT idx_16721_pk_ptaki_bk_plec PRIMARY KEY (id_plec);


--
-- Name: ptaki_bk_pomiar idx_16731_pk_ptaki_bk_pomiar; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_pomiar
    ADD CONSTRAINT idx_16731_pk_ptaki_bk_pomiar PRIMARY KEY (id_pomiar);


--
-- Name: ptaki_bk_poprawny idx_16740_pk_ptaki_bk_poprawny; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_poprawny
    ADD CONSTRAINT idx_16740_pk_ptaki_bk_poprawny PRIMARY KEY (id_poprawny);


--
-- Name: ptaki_bk_prowincja idx_16746_pk_ptaki_bk_prowincja; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_prowincja
    ADD CONSTRAINT idx_16746_pk_ptaki_bk_prowincja PRIMARY KEY (id_prow);


--
-- Name: ptaki_bk_przem idx_16756_pk_ptaki_bk_przem; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_przem
    ADD CONSTRAINT idx_16756_pk_ptaki_bk_przem PRIMARY KEY (id_przem);


--
-- Name: ptaki_bk_stanzn idx_16766_pk_ptaki_bk_stanzn; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_stanzn
    ADD CONSTRAINT idx_16766_pk_ptaki_bk_stanzn PRIMARY KEY (id_stan);


--
-- Name: ptaki_bk_status idx_16776_pk_ptaki_bk_status; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_status
    ADD CONSTRAINT idx_16776_pk_ptaki_bk_status PRIMARY KEY (id_status);


--
-- Name: ptaki_bk_szata idx_16787_pk_ptaki_bk_szata; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_szata
    ADD CONSTRAINT idx_16787_pk_ptaki_bk_szata PRIMARY KEY (id_szata);


--
-- Name: ptaki_bk_typobr idx_16797_pk_ptaki_bk_typobr; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_typobr
    ADD CONSTRAINT idx_16797_pk_ptaki_bk_typobr PRIMARY KEY (id_typ);


--
-- Name: ptaki_bk_wabik idx_16807_pk_ptaki_bk_wabik; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_wabik
    ADD CONSTRAINT idx_16807_pk_ptaki_bk_wabik PRIMARY KEY (id_wabik);


--
-- Name: ptaki_bk_wer idx_16817_pk_ptaki_bk_wer; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_wer
    ADD CONSTRAINT idx_16817_pk_ptaki_bk_wer PRIMARY KEY (id_wer);


--
-- Name: ptaki_bk_werst idx_16826_pk_ptaki_bk_werst; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_werst
    ADD CONSTRAINT idx_16826_pk_ptaki_bk_werst PRIMARY KEY (id_werst);


--
-- Name: ptaki_bk_wiek idx_16832_pk_ptaki_bk_wiek; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_wiek
    ADD CONSTRAINT idx_16832_pk_ptaki_bk_wiek PRIMARY KEY (id_wiek);


--
-- Name: ptaki_bk_wiekpara idx_16842_pk_ptaki_bk_wiekpara; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_wiekpara
    ADD CONSTRAINT idx_16842_pk_ptaki_bk_wiekpara PRIMARY KEY (id_wiek1, id_wiek2);


--
-- Name: ptaki_dfiles idx_16847_pk_ptaki_dfiles; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_dfiles
    ADD CONSTRAINT idx_16847_pk_ptaki_dfiles PRIMARY KEY (id_dfiles);


--
-- Name: ptaki_doktozsamrodzaj idx_16854_pk_ptaki_doktozsamrodzaj; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_doktozsamrodzaj
    ADD CONSTRAINT idx_16854_pk_ptaki_doktozsamrodzaj PRIMARY KEY (id_doktozsamrodzaj);


--
-- Name: ptaki_dostawcy idx_16861_pk_ptaki_dostawcy; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_dostawcy
    ADD CONSTRAINT idx_16861_pk_ptaki_dostawcy PRIMARY KEY (id_dostawca);


--
-- Name: ptaki_emailewysylka idx_16868_pk_ptaki_emailewysylka; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_emailewysylka
    ADD CONSTRAINT idx_16868_pk_ptaki_emailewysylka PRIMARY KEY (id_emailwysylka);


--
-- Name: ptaki_emailewysylkabld idx_16875_pk_ptaki_emailewysylkabld; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_emailewysylkabld
    ADD CONSTRAINT idx_16875_pk_ptaki_emailewysylkabld PRIMARY KEY (id_emailewysylkabld);


--
-- Name: ptaki_emailewysylkastw idx_16881_pk_ptaki_emailewysylkastw; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_emailewysylkastw
    ADD CONSTRAINT idx_16881_pk_ptaki_emailewysylkastw PRIMARY KEY (id_emailwysylka, id_stw);


--
-- Name: ptaki_emailewysylkazal idx_16885_pk_ptaki_emailewysylkazal; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_emailewysylkazal
    ADD CONSTRAINT idx_16885_pk_ptaki_emailewysylkazal PRIMARY KEY (id_emailwysylkazal);


--
-- Name: ptaki_emailwzorzec idx_16891_pk_ptaki_emailwzorzec; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_emailwzorzec
    ADD CONSTRAINT idx_16891_pk_ptaki_emailwzorzec PRIMARY KEY (id_emailwzorzec);


--
-- Name: ptaki_emailwzorzecdef idx_16896_pk_ptaki_emailwzorzecdef; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_emailwzorzecdef
    ADD CONSTRAINT idx_16896_pk_ptaki_emailwzorzecdef PRIMARY KEY (id_emailwzorzec, lang);


--
-- Name: ptaki_emailwzorzecpar idx_16902_pk_ptaki_emailwzorzecpar; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_emailwzorzecpar
    ADD CONSTRAINT idx_16902_pk_ptaki_emailwzorzecpar PRIMARY KEY (id_emailwzorzecpar);


--
-- Name: ptaki_goscie idx_16909_pk_ptaki_goscie; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_goscie
    ADD CONSTRAINT idx_16909_pk_ptaki_goscie PRIMARY KEY (id_gosc);


--
-- Name: ptaki_goscieoczek idx_16916_pk_ptaki_goscieoczek; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_goscieoczek
    ADD CONSTRAINT idx_16916_pk_ptaki_goscieoczek PRIMARY KEY (id_goscieoczek);


--
-- Name: ptaki_komunikaty idx_16923_pk_ptaki_komunikaty; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_komunikaty
    ADD CONSTRAINT idx_16923_pk_ptaki_komunikaty PRIMARY KEY (id_komunikaty);


--
-- Name: ptaki_komunikatyukryj idx_16929_pk_ptaki_komunikatyukryj; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_komunikatyukryj
    ADD CONSTRAINT idx_16929_pk_ptaki_komunikatyukryj PRIMARY KEY (id_komunikaty, id_uzytkownika);


--
-- Name: ptaki_licencje idx_16933_pk_ptaki_licencje; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_licencje
    ADD CONSTRAINT idx_16933_pk_ptaki_licencje PRIMARY KEY (id_licencja);


--
-- Name: ptaki_lokalizacja idx_16940_pk_ptaki_lokalizacja; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_lokalizacja
    ADD CONSTRAINT idx_16940_pk_ptaki_lokalizacja PRIMARY KEY (id_lokalizacja);


--
-- Name: ptaki_mag idx_16947_pk_ptaki_mag; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_mag
    ADD CONSTRAINT idx_16947_pk_ptaki_mag PRIMARY KEY (id_mag);


--
-- Name: ptaki_magdokum idx_16953_pk_ptaki_magdokum; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magdokum
    ADD CONSTRAINT idx_16953_pk_ptaki_magdokum PRIMARY KEY (id_dokum);


--
-- Name: ptaki_magdokumpoz idx_16963_pk_ptaki_magdokumpoz; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magdokumpoz
    ADD CONSTRAINT idx_16963_pk_ptaki_magdokumpoz PRIMARY KEY (id_dokumpoz);


--
-- Name: ptaki_magdokumpoz_magobraczki idx_16969_pk_ptaki_magdokumpoz_magobraczki; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magdokumpoz_magobraczki
    ADD CONSTRAINT idx_16969_pk_ptaki_magdokumpoz_magobraczki PRIMARY KEY (id_obraczki, id_dokumpoz);


--
-- Name: ptaki_magkolorowe idx_16973_pk_ptaki_magkolorowe; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magkolorowe
    ADD CONSTRAINT idx_16973_pk_ptaki_magkolorowe PRIMARY KEY (id_magkolorowe);


--
-- Name: ptaki_magobraczki idx_16980_pk_ptaki_magobraczki; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magobraczki
    ADD CONSTRAINT idx_16980_pk_ptaki_magobraczki PRIMARY KEY (id_obraczki);


--
-- Name: ptaki_magobraczkipodtyp idx_16987_pk_ptaki_magobraczkipodtyp; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magobraczkipodtyp
    ADD CONSTRAINT idx_16987_pk_ptaki_magobraczkipodtyp PRIMARY KEY (id_obraczkipodtyp);


--
-- Name: ptaki_magobraczkityp idx_16994_pk_ptaki_magobraczkityp; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magobraczkityp
    ADD CONSTRAINT idx_16994_pk_ptaki_magobraczkityp PRIMARY KEY (id_obraczkityp);


--
-- Name: ptaki_magobraczkiwykluczenia idx_17001_pk_ptaki_magobraczkiwykluczenia; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magobraczkiwykluczenia
    ADD CONSTRAINT idx_17001_pk_ptaki_magobraczkiwykluczenia PRIMARY KEY (id_wyklucz);


--
-- Name: ptaki_magoper idx_17007_pk_ptaki_magoperacje; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magoper
    ADD CONSTRAINT idx_17007_pk_ptaki_magoperacje PRIMARY KEY (id_oper);


--
-- Name: ptaki_monity idx_17014_pk_ptaki_monity; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_monity
    ADD CONSTRAINT idx_17014_pk_ptaki_monity PRIMARY KEY (id_monit);


--
-- Name: ptaki_obraczkarze idx_17019_pk_ptaki_obraczkarze; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_obraczkarze
    ADD CONSTRAINT idx_17019_pk_ptaki_obraczkarze PRIMARY KEY (id_obraczkarz);


--
-- Name: ptaki_obraczkarzegatunki idx_17026_pk_ptaki_obraczkarzegatunki; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_obraczkarzegatunki
    ADD CONSTRAINT idx_17026_pk_ptaki_obraczkarzegatunki PRIMARY KEY (id_obraczkarz, id_gat);


--
-- Name: ptaki_obraczki idx_17030_pk_ptaki_obraczki; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_obraczki
    ADD CONSTRAINT idx_17030_pk_ptaki_obraczki PRIMARY KEY (id_obraczki);


--
-- Name: ptaki_obraczkistan idx_17037_pk_ptaki_obraczkistan; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_obraczkistan
    ADD CONSTRAINT idx_17037_pk_ptaki_obraczkistan PRIMARY KEY (id_obraczkistan);


--
-- Name: ptaki_params idx_17041_pk_lab_params; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_params
    ADD CONSTRAINT idx_17041_pk_lab_params PRIMARY KEY (nazwa);


--
-- Name: ptaki_paramspliki idx_17046_pk_ptaki_paramspliki; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_paramspliki
    ADD CONSTRAINT idx_17046_pk_ptaki_paramspliki PRIMARY KEY (id_pliku);


--
-- Name: ptaki_paramsuser idx_17051_pk_ptaki_paramsuser; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_paramsuser
    ADD CONSTRAINT idx_17051_pk_ptaki_paramsuser PRIMARY KEY (userid, nazwa);


--
-- Name: ptaki_pdfwysylka idx_17057_pk_ptaki_pdfwysylka; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_pdfwysylka
    ADD CONSTRAINT idx_17057_pk_ptaki_pdfwysylka PRIMARY KEY (id_pdfwysylka);


--
-- Name: ptaki_pdfwysylkazal idx_17064_pk_ptaki_pdfwysylkazal; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_pdfwysylkazal
    ADD CONSTRAINT idx_17064_pk_ptaki_pdfwysylkazal PRIMARY KEY (id_pdfwysylkazal);


--
-- Name: ptaki_prawa idx_17070_pk_ptaki_prawa; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_prawa
    ADD CONSTRAINT idx_17070_pk_ptaki_prawa PRIMARY KEY (id_prawa);


--
-- Name: ptaki_ptakobr idx_17076_pk_ptaki_ptakobr; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_ptakobr
    ADD CONSTRAINT idx_17076_pk_ptaki_ptakobr PRIMARY KEY (id_ptakiobr);


--
-- Name: ptaki_stwierdzenia idx_17081_pk_ptaki_stwierdzenia; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT idx_17081_pk_ptaki_stwierdzenia PRIMARY KEY (id_stw);


--
-- Name: ptaki_stwierdzeniagoscie idx_17090_pk_ptaki_bk_stwierdzeniagoscie; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzeniagoscie
    ADD CONSTRAINT idx_17090_pk_ptaki_bk_stwierdzeniagoscie PRIMARY KEY (id_stwgosc);


--
-- Name: ptaki_stwierdzeniakoresp idx_17097_pk_ptaki_stwierdzeniakoresp; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzeniakoresp
    ADD CONSTRAINT idx_17097_pk_ptaki_stwierdzeniakoresp PRIMARY KEY (id_stwkoresp);


--
-- Name: ptaki_stwierdzeniapliki idx_17102_pk_ptaki_stwierdzeniapliki; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzeniapliki
    ADD CONSTRAINT idx_17102_pk_ptaki_stwierdzeniapliki PRIMARY KEY (id_pliki);


--
-- Name: ptaki_stwierdzeniapol idx_17109_pk_ptaki_stwierdzeniapol; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzeniapol
    ADD CONSTRAINT idx_17109_pk_ptaki_stwierdzeniapol PRIMARY KEY (id_stwierdzeniapol);


--
-- Name: ptaki_stwierdzeniarodz idx_17113_pk_ptaki_stwierdzeniarodz; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzeniarodz
    ADD CONSTRAINT idx_17113_pk_ptaki_stwierdzeniarodz PRIMARY KEY (id_stw, nrrodz);


--
-- Name: ptaki_stwierdzeniawer idx_17116_pk_ptaki_stwierdzeniawer; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzeniawer
    ADD CONSTRAINT idx_17116_pk_ptaki_stwierdzeniawer PRIMARY KEY (id_stw, lp);


--
-- Name: ptaki_stwimport idx_17122_pk_ptaki_stwimport; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwimport
    ADD CONSTRAINT idx_17122_pk_ptaki_stwimport PRIMARY KEY (id_stwimport);


--
-- Name: ptaki_stwimport_bld idx_17130_pk_ptaki_stwimport_bld; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwimport_bld
    ADD CONSTRAINT idx_17130_pk_ptaki_stwimport_bld PRIMARY KEY (id_stwimport_bld);


--
-- Name: ptaki_stwimport_stw idx_17136_pk_ptaki_stwimport_stw; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwimport_stw
    ADD CONSTRAINT idx_17136_pk_ptaki_stwimport_stw PRIMARY KEY (id_stw);


--
-- Name: ptaki_stwpopr idx_17140_pk_ptaki_stwpopr; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwpopr
    ADD CONSTRAINT idx_17140_pk_ptaki_stwpopr PRIMARY KEY (id_stwpopr);


--
-- Name: ptaki_szablonywydrukow idx_17146_pk_ptaki_szablonywydrukow; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_szablonywydrukow
    ADD CONSTRAINT idx_17146_pk_ptaki_szablonywydrukow PRIMARY KEY (nazwa);


--
-- Name: ptaki_telefony idx_17152_pk_ptaki_telefony; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_telefony
    ADD CONSTRAINT idx_17152_pk_ptaki_telefony PRIMARY KEY (id_telefon);


--
-- Name: ptaki_uzytkownicy idx_17159_pk_ptaki_uzytkownicy; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_uzytkownicy
    ADD CONSTRAINT idx_17159_pk_ptaki_uzytkownicy PRIMARY KEY (id_uzytkownika);


--
-- Name: ptaki_uzytkownicy_prawa idx_17166_pk_ptaki_uzytkownicy_prawa; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_uzytkownicy_prawa
    ADD CONSTRAINT idx_17166_pk_ptaki_uzytkownicy_prawa PRIMARY KEY (id_uzytkownika, id_prawa);


--
-- Name: ptaki_wwwhelp idx_17172_pk_ptaki_wwwhelp; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_wwwhelp
    ADD CONSTRAINT idx_17172_pk_ptaki_wwwhelp PRIMARY KEY (id_wwwhelp);


--
-- Name: ptaki_zadaniakolejka idx_17179_pk_ptaki_zadaniakolejka; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_zadaniakolejka
    ADD CONSTRAINT idx_17179_pk_ptaki_zadaniakolejka PRIMARY KEY (id_zadaniakolejka);


--
-- Name: ptaki_zakresobracz idx_17186_pk_ptaki_zakresobracz; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_zakresobracz
    ADD CONSTRAINT idx_17186_pk_ptaki_zakresobracz PRIMARY KEY (id_zakresobracz);


--
-- Name: ptaki_zakresobraczrodzaj idx_17193_pk_ptaki_zakresobraczrodzaj; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_zakresobraczrodzaj
    ADD CONSTRAINT idx_17193_pk_ptaki_zakresobraczrodzaj PRIMARY KEY (id_zakresobraczrodzaj);


--
-- Name: ptaki_zamowienia idx_17200_pk_ptaki_zamowienia; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_zamowienia
    ADD CONSTRAINT idx_17200_pk_ptaki_zamowienia PRIMARY KEY (id_zamow);


--
-- Name: ptaki_zamowieniadok idx_17207_pk_ptaki_zamowieniadok; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_zamowieniadok
    ADD CONSTRAINT idx_17207_pk_ptaki_zamowieniadok PRIMARY KEY (id_zamowdok);


--
-- Name: ptaki_zamowieniadokpoz idx_17212_pk_ptaki_zamowieniadokpoz; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_zamowieniadokpoz
    ADD CONSTRAINT idx_17212_pk_ptaki_zamowieniadokpoz PRIMARY KEY (id_zamowdokpoz);


--
-- Name: ptaki_zamowieniapoz idx_17217_pk_ptaki_zamowieniapoz; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_zamowieniapoz
    ADD CONSTRAINT idx_17217_pk_ptaki_zamowieniapoz PRIMARY KEY (id_zamowpoz);


--
-- Name: sysdiagrams idx_17222_pk__sysdiagr__c2b05b6176577163; Type: CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.sysdiagrams
    ADD CONSTRAINT idx_17222_pk__sysdiagr__c2b05b6176577163 PRIMARY KEY (diagram_id);


--
-- Name: idx_16521_ix_aspnet_sqlpagestatepersister_created; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_16521_ix_aspnet_sqlpagestatepersister_created ON dbo.aspnet_sqlpagestatepersister USING btree (created);


--
-- Name: idx_16599_ix_ptaki_bk_gatunek_skrot; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_16599_ix_ptaki_bk_gatunek_skrot ON dbo.ptaki_bk_gatunek USING btree (skrot, id_gat);


--
-- Name: idx_16623_uq_ptaki_bk_gatunekpara; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE UNIQUE INDEX idx_16623_uq_ptaki_bk_gatunekpara ON dbo.ptaki_bk_gatunekpara USING btree (id_gat1, id_gat2);


--
-- Name: idx_16861_uq_ptaki_dostawcy_nip; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE UNIQUE INDEX idx_16861_uq_ptaki_dostawcy_nip ON dbo.ptaki_dostawcy USING btree (nip);


--
-- Name: idx_16868_ix_ptaki_emailewysylka_datawys; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_16868_ix_ptaki_emailewysylka_datawys ON dbo.ptaki_emailewysylka USING btree (datawys);


--
-- Name: idx_16868_ix_ptaki_emailewysylka_id_monit; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_16868_ix_ptaki_emailewysylka_id_monit ON dbo.ptaki_emailewysylka USING btree (id_monit, datawys);


--
-- Name: idx_16902_uq_ptaki_emailwzorzecpar; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE UNIQUE INDEX idx_16902_uq_ptaki_emailwzorzecpar ON dbo.ptaki_emailwzorzecpar USING btree (id_emailwzorzecpar, id_emailwzorzec, zmienna);


--
-- Name: idx_16909_uq_ptaki_goscie_id_uzytkownika; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE UNIQUE INDEX idx_16909_uq_ptaki_goscie_id_uzytkownika ON dbo.ptaki_goscie USING btree (id_uzytkownika);


--
-- Name: idx_16916_ix_ptaki_goscieoczek_utworzony; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_16916_ix_ptaki_goscieoczek_utworzony ON dbo.ptaki_goscieoczek USING btree (utworzony);


--
-- Name: idx_16923_ix_ptaki_komunikaty_data; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_16923_ix_ptaki_komunikaty_data ON dbo.ptaki_komunikaty USING btree (dataod, datado, cel_gosc, cel_obr, cel_uzyt, nieaktywny);


--
-- Name: idx_16933_uq_ptaki_licencje_numer; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE UNIQUE INDEX idx_16933_uq_ptaki_licencje_numer ON dbo.ptaki_licencje USING btree (numer);


--
-- Name: idx_16940_ix_ptaki_lokalizacja_1; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_16940_ix_ptaki_lokalizacja_1 ON dbo.ptaki_lokalizacja USING btree (listaprac, gps);


--
-- Name: idx_16940_ix_ptaki_lokalizacja_2; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_16940_ix_ptaki_lokalizacja_2 ON dbo.ptaki_lokalizacja USING btree (szer, dlug, gps);


--
-- Name: idx_16953_ix_ptaki_magdokum_data; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_16953_ix_ptaki_magdokum_data ON dbo.ptaki_magdokum USING btree (data);


--
-- Name: idx_16953_ix_ptaki_magdokum_skasowany; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_16953_ix_ptaki_magdokum_skasowany ON dbo.ptaki_magdokum USING btree (skasowany, id_uzytkownikaskasowal);


--
-- Name: idx_16953_uq_ptaki_magdokum_nrdok; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE UNIQUE INDEX idx_16953_uq_ptaki_magdokum_nrdok ON dbo.ptaki_magdokum USING btree (nrdok);


--
-- Name: idx_16953_uq_ptaki_magdokum_nrdok_schemat; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE UNIQUE INDEX idx_16953_uq_ptaki_magdokum_nrdok_schemat ON dbo.ptaki_magdokum USING btree (nrdok_rok, nrdok_schemat, nrdok_lp);


--
-- Name: idx_16963_uq_ptaki_magdokumpoz_nrpoz; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE UNIQUE INDEX idx_16963_uq_ptaki_magdokumpoz_nrpoz ON dbo.ptaki_magdokumpoz USING btree (id_dokum, nrpoz);


--
-- Name: idx_16969_ix_ptaki_magdokumpoz_magobraczki_id_dokumpoz; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_16969_ix_ptaki_magdokumpoz_magobraczki_id_dokumpoz ON dbo.ptaki_magdokumpoz_magobraczki USING btree (id_dokumpoz);


--
-- Name: idx_16973_uq_ptaki_magkolorowe; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE UNIQUE INDEX idx_16973_uq_ptaki_magkolorowe ON dbo.ptaki_magkolorowe USING btree (id_typ, id_kolor, id_gat, numer, id_uzytkownika);


--
-- Name: idx_16980_ix_lpdlug; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_16980_ix_lpdlug ON dbo.ptaki_magobraczki USING btree (lpdlug);


--
-- Name: idx_16980_ix_ptaki_magobraczki_id_mag; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_16980_ix_ptaki_magobraczki_id_mag ON dbo.ptaki_magobraczki USING btree (id_mag, id_obraczkipodtyp);


--
-- Name: idx_16980_ix_ptaki_magobraczki_numerobpel; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_16980_ix_ptaki_magobraczki_numerobpel ON dbo.ptaki_magobraczki USING btree (numerobpel);


--
-- Name: idx_16980_ix_serialplpdlug; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_16980_ix_serialplpdlug ON dbo.ptaki_magobraczki USING btree (seria, lp, lpdlug);


--
-- Name: idx_16980_uq_ptaki_magobraczki_lppelny; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE UNIQUE INDEX idx_16980_uq_ptaki_magobraczki_lppelny ON dbo.ptaki_magobraczki USING btree (seria, lppelny);


--
-- Name: idx_16980_uq_ptaki_magobraczki_numer; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE UNIQUE INDEX idx_16980_uq_ptaki_magobraczki_numer ON dbo.ptaki_magobraczki USING btree (seria, lpdlug, lp);


--
-- Name: idx_17001_uq_ptaki_magobraczkiwykluczenia; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE UNIQUE INDEX idx_17001_uq_ptaki_magobraczkiwykluczenia ON dbo.ptaki_magobraczkiwykluczenia USING btree (seria, lpdlug, lpod, lpdo);


--
-- Name: idx_17014_ix_ptaki_monity_dowyslania; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_17014_ix_ptaki_monity_dowyslania ON dbo.ptaki_monity USING btree (dowyslania);


--
-- Name: idx_17019_uq_ptaki_obraczkarze_id_uzytkownika; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE UNIQUE INDEX idx_17019_uq_ptaki_obraczkarze_id_uzytkownika ON dbo.ptaki_obraczkarze USING btree (id_uzytkownika);


--
-- Name: idx_17030_ix_ptaki_obraczki_id_monit; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_17030_ix_ptaki_obraczki_id_monit ON dbo.ptaki_obraczki USING btree (id_monit);


--
-- Name: idx_17030_ix_ptaki_obraczki_numerobpel; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_17030_ix_ptaki_obraczki_numerobpel ON dbo.ptaki_obraczki USING btree (numerobpel);


--
-- Name: idx_17030_ix_ptaki_obraczki_obraczkakol; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_17030_ix_ptaki_obraczki_obraczkakol ON dbo.ptaki_obraczki USING btree (id_typ, id_kolor, id_gat, numer, kodzdubl);


--
-- Name: idx_17030_uq_ptaki_obraczki_20110704; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE UNIQUE INDEX idx_17030_uq_ptaki_obraczki_20110704 ON dbo.ptaki_obraczki USING btree (id_typ, id_ctr, seria, numer, kodzdubl, id_kolor, id_gat);


--
-- Name: idx_17037_ix_ptaki_obraczkistan_idobraczki; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_17037_ix_ptaki_obraczkistan_idobraczki ON dbo.ptaki_obraczkistan USING btree (id_obraczki, id_stw);


--
-- Name: idx_17037_ix_ptaki_obraczkistan_lp; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_17037_ix_ptaki_obraczkistan_lp ON dbo.ptaki_obraczkistan USING btree (lp);


--
-- Name: idx_17037_uq_ptaki_obraczkistan; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE UNIQUE INDEX idx_17037_uq_ptaki_obraczkistan ON dbo.ptaki_obraczkistan USING btree (id_stw, id_obraczki);


--
-- Name: idx_17057_ix_ptaki_pdfwysylka_wyslano; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_17057_ix_ptaki_pdfwysylka_wyslano ON dbo.ptaki_pdfwysylka USING btree (wyslano);


--
-- Name: idx_17076_ix_ptaki_ptakobr; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_17076_ix_ptaki_ptakobr ON dbo.ptaki_ptakobr USING btree (id_obr1, id_obr2, id_stwpierwotne);


--
-- Name: idx_17076_uq_ptaki_ptakobr; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE UNIQUE INDEX idx_17076_uq_ptaki_ptakobr ON dbo.ptaki_ptakobr USING btree (id_stwpierwotne, id_obr1, id_obr2);


--
-- Name: idx_17081_ix_ptaki_stwierdzenia_data; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_17081_ix_ptaki_stwierdzenia_data ON dbo.ptaki_stwierdzenia USING btree (data);


--
-- Name: idx_17081_ix_ptaki_stwierdzenia_dataed; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_17081_ix_ptaki_stwierdzenia_dataed ON dbo.ptaki_stwierdzenia USING btree (dataed);


--
-- Name: idx_17081_ix_ptaki_stwierdzenia_datawer; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_17081_ix_ptaki_stwierdzenia_datawer ON dbo.ptaki_stwierdzenia USING btree (datawer);


--
-- Name: idx_17081_ix_ptaki_stwierdzenia_datawpr; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_17081_ix_ptaki_stwierdzenia_datawpr ON dbo.ptaki_stwierdzenia USING btree (datawpr);


--
-- Name: idx_17081_ix_ptaki_stwierdzenia_id_lokalizacja; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_17081_ix_ptaki_stwierdzenia_id_lokalizacja ON dbo.ptaki_stwierdzenia USING btree (id_lokalizacja);


--
-- Name: idx_17081_ix_ptaki_stwierdzenia_id_stwgosc; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_17081_ix_ptaki_stwierdzenia_id_stwgosc ON dbo.ptaki_stwierdzenia USING btree (id_stwgosc);


--
-- Name: idx_17081_ix_ptaki_stwierdzenia_id_stwpierwotne; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_17081_ix_ptaki_stwierdzenia_id_stwpierwotne ON dbo.ptaki_stwierdzenia USING btree (id_stwpierwotne);


--
-- Name: idx_17081_ix_ptaki_stwierdzenia_monity; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_17081_ix_ptaki_stwierdzenia_monity ON dbo.ptaki_stwierdzenia USING btree (zn_monitrodz, zn_monit1data, zn_monit2data, zn_wyjas);


--
-- Name: idx_17081_ix_ptaki_stwierdzenia_poprawnypierwotne; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_17081_ix_ptaki_stwierdzenia_poprawnypierwotne ON dbo.ptaki_stwierdzenia USING btree (id_poprawny, id_stwpierwotne, id_obr1, id_obr2);


--
-- Name: idx_17081_ix_ptaki_stwierdzenia_ptaki1; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_17081_ix_ptaki_stwierdzenia_ptaki1 ON dbo.ptaki_stwierdzenia USING btree (id_poprawny, id_obr1, id_obr2, id_stw, id_stwpierwotne, data, datawer);


--
-- Name: idx_17081_ix_ptaki_stwierdzenia_wys_potw; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_17081_ix_ptaki_stwierdzenia_wys_potw ON dbo.ptaki_stwierdzenia USING btree (wys_potw, id_poprawny);


--
-- Name: idx_17109_uq_ptaki_stwierdzeniapol; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE UNIQUE INDEX idx_17109_uq_ptaki_stwierdzeniapol ON dbo.ptaki_stwierdzeniapol USING btree (id_stw, id_uzytkownika, id_ctr);


--
-- Name: idx_17122_uq_ptakistwimport; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE UNIQUE INDEX idx_17122_uq_ptakistwimport ON dbo.ptaki_stwimport USING btree (numer, rok);


--
-- Name: idx_17140_ix_ptaki_stwpopr_id_stw; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_17140_ix_ptaki_stwpopr_id_stw ON dbo.ptaki_stwpopr USING btree (id_stw);


--
-- Name: idx_17159_uq_ptaki_uzytkownicy_automat; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE UNIQUE INDEX idx_17159_uq_ptaki_uzytkownicy_automat ON dbo.ptaki_uzytkownicy USING btree (automat) WHERE (automat = true);


--
-- Name: idx_17159_uq_ptaki_uzytkownicy_loginusuniety; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE UNIQUE INDEX idx_17159_uq_ptaki_uzytkownicy_loginusuniety ON dbo.ptaki_uzytkownicy USING btree (login, usuniety);


--
-- Name: idx_17172_ix_ptaki_wwwhelp_gosc; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_17172_ix_ptaki_wwwhelp_gosc ON dbo.ptaki_wwwhelp USING btree (jezyk, wid_gosc);


--
-- Name: idx_17172_ix_ptaki_wwwhelp_obr; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_17172_ix_ptaki_wwwhelp_obr ON dbo.ptaki_wwwhelp USING btree (jezyk, wid_obr);


--
-- Name: idx_17172_ix_ptaki_wwwhelp_uzyt; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_17172_ix_ptaki_wwwhelp_uzyt ON dbo.ptaki_wwwhelp USING btree (jezyk, wid_uzyt);


--
-- Name: idx_17179_uq_ptaki_zadaniakolejka; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE UNIQUE INDEX idx_17179_uq_ptaki_zadaniakolejka ON dbo.ptaki_zadaniakolejka USING btree (sesja, lp);


--
-- Name: idx_17200_ix_ptaki_zamowienia_data; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_17200_ix_ptaki_zamowienia_data ON dbo.ptaki_zamowienia USING btree (data);


--
-- Name: idx_17207_ix_ptaki_zamowieniadok_data; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_17207_ix_ptaki_zamowieniadok_data ON dbo.ptaki_zamowieniadok USING btree (data);


--
-- Name: idx_17222_uk_principal_name; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE UNIQUE INDEX idx_17222_uk_principal_name ON dbo.sysdiagrams USING btree (principal_id, name);


--
-- Name: idx_lastname; Type: INDEX; Schema: dbo; Owner: postgres
--

CREATE INDEX idx_lastname ON dbo.ptaki_stwierdzeniapliki USING btree (hash);


--
-- Name: ptaki_adresy fk_ptaki_adresy_ptaki_adresyrodzaj; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_adresy
    ADD CONSTRAINT fk_ptaki_adresy_ptaki_adresyrodzaj FOREIGN KEY (id_adresyrodzaj) REFERENCES dbo.ptaki_adresyrodzaj(id_adresyrodzaj);


--
-- Name: ptaki_adresy fk_ptaki_adresy_ptaki_uzytkownicy; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_adresy
    ADD CONSTRAINT fk_ptaki_adresy_ptaki_uzytkownicy FOREIGN KEY (id_uzytkownika) REFERENCES dbo.ptaki_uzytkownicy(id_uzytkownika);


--
-- Name: ptaki_bk_gatunekgrupa_gatunki fk_ptaki_bk_gatunekgrupa_gatunki_ptaki_bk_gatunek; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_gatunekgrupa_gatunki
    ADD CONSTRAINT fk_ptaki_bk_gatunekgrupa_gatunki_ptaki_bk_gatunek FOREIGN KEY (id_gat) REFERENCES dbo.ptaki_bk_gatunek(id_gat) ON DELETE CASCADE;


--
-- Name: ptaki_bk_gatunekgrupa_gatunki fk_ptaki_bk_gatunekgrupa_gatunki_ptaki_bk_gatunekgrupa; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_gatunekgrupa_gatunki
    ADD CONSTRAINT fk_ptaki_bk_gatunekgrupa_gatunki_ptaki_bk_gatunekgrupa FOREIGN KEY (id_grupa) REFERENCES dbo.ptaki_bk_gatunekgrupa(id_grupa) ON DELETE CASCADE;


--
-- Name: ptaki_bk_gatunekpara fk_ptaki_bk_gatunekpara_ptaki_bk_gatunek1; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_gatunekpara
    ADD CONSTRAINT fk_ptaki_bk_gatunekpara_ptaki_bk_gatunek1 FOREIGN KEY (id_gat1) REFERENCES dbo.ptaki_bk_gatunek(id_gat);


--
-- Name: ptaki_bk_gatunekpara fk_ptaki_bk_gatunekpara_ptaki_bk_gatunek2; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_gatunekpara
    ADD CONSTRAINT fk_ptaki_bk_gatunekpara_ptaki_bk_gatunek2 FOREIGN KEY (id_gat2) REFERENCES dbo.ptaki_bk_gatunek(id_gat);


--
-- Name: ptaki_bk_gatunektyp fk_ptaki_bk_gatunektyp_ptaki_bk_gatunek; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_gatunektyp
    ADD CONSTRAINT fk_ptaki_bk_gatunektyp_ptaki_bk_gatunek FOREIGN KEY (id_gat) REFERENCES dbo.ptaki_bk_gatunek(id_gat);


--
-- Name: ptaki_bk_gatunektyp fk_ptaki_bk_gatunektyp_ptaki_bk_plec; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_gatunektyp
    ADD CONSTRAINT fk_ptaki_bk_gatunektyp_ptaki_bk_plec FOREIGN KEY (id_plec) REFERENCES dbo.ptaki_bk_plec(id_plec);


--
-- Name: ptaki_bk_gatunektyp fk_ptaki_bk_gatunektyp_ptaki_bk_wiek; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_gatunektyp
    ADD CONSTRAINT fk_ptaki_bk_gatunektyp_ptaki_bk_wiek FOREIGN KEY (id_wiek) REFERENCES dbo.ptaki_bk_wiek(id_wiek);


--
-- Name: ptaki_bk_gatunektyp fk_ptaki_bk_gatunektyp_ptaki_magobraczkityp; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_gatunektyp
    ADD CONSTRAINT fk_ptaki_bk_gatunektyp_ptaki_magobraczkityp FOREIGN KEY (id_obraczkityp) REFERENCES dbo.ptaki_magobraczkityp(id_obraczkityp);


--
-- Name: ptaki_bk_gatunekwiek fk_ptaki_bk_gatunekwiek_ptaki_bk_gatunek; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_gatunekwiek
    ADD CONSTRAINT fk_ptaki_bk_gatunekwiek_ptaki_bk_gatunek FOREIGN KEY (id_gat) REFERENCES dbo.ptaki_bk_gatunek(id_gat);


--
-- Name: ptaki_bk_gatunekwiek fk_ptaki_bk_gatunekwiek_ptaki_bk_wiek; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_gatunekwiek
    ADD CONSTRAINT fk_ptaki_bk_gatunekwiek_ptaki_bk_wiek FOREIGN KEY (id_wiek) REFERENCES dbo.ptaki_bk_wiek(id_wiek);


--
-- Name: ptaki_bk_krajctr fk_ptaki_bk_krajctr_ptaki_bk_ctr; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_krajctr
    ADD CONSTRAINT fk_ptaki_bk_krajctr_ptaki_bk_ctr FOREIGN KEY (id_ctr) REFERENCES dbo.ptaki_bk_ctr(id_ctr);


--
-- Name: ptaki_bk_krajctr fk_ptaki_bk_krajctr_ptaki_bk_kraj; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_krajctr
    ADD CONSTRAINT fk_ptaki_bk_krajctr_ptaki_bk_kraj FOREIGN KEY (id_kraj) REFERENCES dbo.ptaki_bk_kraj(id_kraj);


--
-- Name: ptaki_bk_okol fk_ptaki_bk_okol_ptaki_bk_okol; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_okol
    ADD CONSTRAINT fk_ptaki_bk_okol_ptaki_bk_okol FOREIGN KEY (id_parent) REFERENCES dbo.ptaki_bk_okol(id_okol);


--
-- Name: ptaki_bk_prowincja fk_ptaki_bk_prowincja_ptaki_bk_kraj; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_prowincja
    ADD CONSTRAINT fk_ptaki_bk_prowincja_ptaki_bk_kraj FOREIGN KEY (id_kraj) REFERENCES dbo.ptaki_bk_kraj(id_kraj);


--
-- Name: ptaki_bk_wiekpara fk_ptaki_bk_wiekpara_ptaki_bk_wiek1; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_wiekpara
    ADD CONSTRAINT fk_ptaki_bk_wiekpara_ptaki_bk_wiek1 FOREIGN KEY (id_wiek1) REFERENCES dbo.ptaki_bk_wiek(id_wiek);


--
-- Name: ptaki_bk_wiekpara fk_ptaki_bk_wiekpara_ptaki_bk_wiek2; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_bk_wiekpara
    ADD CONSTRAINT fk_ptaki_bk_wiekpara_ptaki_bk_wiek2 FOREIGN KEY (id_wiek2) REFERENCES dbo.ptaki_bk_wiek(id_wiek);


--
-- Name: ptaki_emailewysylkastw fk_ptaki_emailewysylka_ptaki_emailewysylkastw; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_emailewysylkastw
    ADD CONSTRAINT fk_ptaki_emailewysylka_ptaki_emailewysylkastw FOREIGN KEY (id_emailwysylka) REFERENCES dbo.ptaki_emailewysylka(id_emailwysylka) ON DELETE CASCADE;


--
-- Name: ptaki_emailewysylka fk_ptaki_emailewysylka_ptaki_monity; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_emailewysylka
    ADD CONSTRAINT fk_ptaki_emailewysylka_ptaki_monity FOREIGN KEY (id_monit) REFERENCES dbo.ptaki_monity(id_monit);


--
-- Name: ptaki_emailewysylka fk_ptaki_emailewysylka_ptaki_uzytkownicy; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_emailewysylka
    ADD CONSTRAINT fk_ptaki_emailewysylka_ptaki_uzytkownicy FOREIGN KEY (id_uzytkownik) REFERENCES dbo.ptaki_uzytkownicy(id_uzytkownika) ON DELETE CASCADE;


--
-- Name: ptaki_emailewysylkabld fk_ptaki_emailewysylkabld_ptaki_monity; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_emailewysylkabld
    ADD CONSTRAINT fk_ptaki_emailewysylkabld_ptaki_monity FOREIGN KEY (id_monit) REFERENCES dbo.ptaki_monity(id_monit);


--
-- Name: ptaki_emailewysylkazal fk_ptaki_emailewysylkazal_ptaki_emailewysylka; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_emailewysylkazal
    ADD CONSTRAINT fk_ptaki_emailewysylkazal_ptaki_emailewysylka FOREIGN KEY (id_emailwysylka) REFERENCES dbo.ptaki_emailewysylka(id_emailwysylka) ON DELETE CASCADE;


--
-- Name: ptaki_emailwzorzecdef fk_ptaki_emailwzorzecdef_ptaki_emailwzorzec; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_emailwzorzecdef
    ADD CONSTRAINT fk_ptaki_emailwzorzecdef_ptaki_emailwzorzec FOREIGN KEY (id_emailwzorzec) REFERENCES dbo.ptaki_emailwzorzec(id_emailwzorzec) ON DELETE CASCADE;


--
-- Name: ptaki_emailwzorzecpar fk_ptaki_emailwzorzecpar_ptaki_emailwzorzec; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_emailwzorzecpar
    ADD CONSTRAINT fk_ptaki_emailwzorzecpar_ptaki_emailwzorzec FOREIGN KEY (id_emailwzorzec) REFERENCES dbo.ptaki_emailwzorzec(id_emailwzorzec) ON DELETE CASCADE;


--
-- Name: ptaki_goscie fk_ptaki_goscie_ptaki_uzytkownicy; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_goscie
    ADD CONSTRAINT fk_ptaki_goscie_ptaki_uzytkownicy FOREIGN KEY (id_uzytkownika) REFERENCES dbo.ptaki_uzytkownicy(id_uzytkownika);


--
-- Name: ptaki_komunikaty fk_ptaki_komunikaty_ptaki_uzytkownicy_ed; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_komunikaty
    ADD CONSTRAINT fk_ptaki_komunikaty_ptaki_uzytkownicy_ed FOREIGN KEY (ktoed) REFERENCES dbo.ptaki_uzytkownicy(id_uzytkownika);


--
-- Name: ptaki_komunikaty fk_ptaki_komunikaty_ptaki_uzytkownicy_utw; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_komunikaty
    ADD CONSTRAINT fk_ptaki_komunikaty_ptaki_uzytkownicy_utw FOREIGN KEY (ktoutw) REFERENCES dbo.ptaki_uzytkownicy(id_uzytkownika);


--
-- Name: ptaki_komunikatyukryj fk_ptaki_komunikatyukryj_ptaki_komunikaty; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_komunikatyukryj
    ADD CONSTRAINT fk_ptaki_komunikatyukryj_ptaki_komunikaty FOREIGN KEY (id_komunikaty) REFERENCES dbo.ptaki_komunikaty(id_komunikaty) ON DELETE CASCADE;


--
-- Name: ptaki_komunikatyukryj fk_ptaki_komunikatyukryj_ptaki_uzytkownicy; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_komunikatyukryj
    ADD CONSTRAINT fk_ptaki_komunikatyukryj_ptaki_uzytkownicy FOREIGN KEY (id_uzytkownika) REFERENCES dbo.ptaki_uzytkownicy(id_uzytkownika) ON DELETE CASCADE;


--
-- Name: ptaki_licencje fk_ptaki_licencje_ptaki_obraczkarze; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_licencje
    ADD CONSTRAINT fk_ptaki_licencje_ptaki_obraczkarze FOREIGN KEY (id_obraczkarz) REFERENCES dbo.ptaki_obraczkarze(id_obraczkarz);


--
-- Name: ptaki_lokalizacja fk_ptaki_lokalizacja_ptaki_bk_dk; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_lokalizacja
    ADD CONSTRAINT fk_ptaki_lokalizacja_ptaki_bk_dk FOREIGN KEY (id_dk) REFERENCES dbo.ptaki_bk_dk(id_dk);


--
-- Name: ptaki_lokalizacja fk_ptaki_lokalizacja_ptaki_bk_kraj; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_lokalizacja
    ADD CONSTRAINT fk_ptaki_lokalizacja_ptaki_bk_kraj FOREIGN KEY (id_kraj) REFERENCES dbo.ptaki_bk_kraj(id_kraj);


--
-- Name: ptaki_lokalizacja fk_ptaki_lokalizacja_ptaki_bk_prowincja; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_lokalizacja
    ADD CONSTRAINT fk_ptaki_lokalizacja_ptaki_bk_prowincja FOREIGN KEY (id_prow) REFERENCES dbo.ptaki_bk_prowincja(id_prow);


--
-- Name: ptaki_lokalizacja fk_ptaki_lokalizacja_ptaki_uzytkownicy; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_lokalizacja
    ADD CONSTRAINT fk_ptaki_lokalizacja_ptaki_uzytkownicy FOREIGN KEY (id_obr) REFERENCES dbo.ptaki_uzytkownicy(id_uzytkownika);


--
-- Name: ptaki_magdokum fk_ptaki_magdokum_ptaki_dostawcy; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magdokum
    ADD CONSTRAINT fk_ptaki_magdokum_ptaki_dostawcy FOREIGN KEY (id_dostawca) REFERENCES dbo.ptaki_dostawcy(id_dostawca);


--
-- Name: ptaki_magdokum fk_ptaki_magdokum_ptaki_magoper; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magdokum
    ADD CONSTRAINT fk_ptaki_magdokum_ptaki_magoper FOREIGN KEY (id_oper) REFERENCES dbo.ptaki_magoper(id_oper);


--
-- Name: ptaki_magdokum fk_ptaki_magdokum_ptaki_obraczkarze; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magdokum
    ADD CONSTRAINT fk_ptaki_magdokum_ptaki_obraczkarze FOREIGN KEY (id_obraczkarz) REFERENCES dbo.ptaki_obraczkarze(id_obraczkarz);


--
-- Name: ptaki_magdokum fk_ptaki_magdokum_ptaki_obraczkarze_2; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magdokum
    ADD CONSTRAINT fk_ptaki_magdokum_ptaki_obraczkarze_2 FOREIGN KEY (id_obraczkarz2) REFERENCES dbo.ptaki_obraczkarze(id_obraczkarz);


--
-- Name: ptaki_magdokum fk_ptaki_magdokum_ptaki_uzytkownicy; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magdokum
    ADD CONSTRAINT fk_ptaki_magdokum_ptaki_uzytkownicy FOREIGN KEY (id_uzytkownikazapisal) REFERENCES dbo.ptaki_uzytkownicy(id_uzytkownika);


--
-- Name: ptaki_magdokum fk_ptaki_magdokum_ptaki_uzytkownicy_id_uzytkownikaskasowal; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magdokum
    ADD CONSTRAINT fk_ptaki_magdokum_ptaki_uzytkownicy_id_uzytkownikaskasowal FOREIGN KEY (id_uzytkownikaskasowal) REFERENCES dbo.ptaki_uzytkownicy(id_uzytkownika);


--
-- Name: ptaki_magdokumpoz_magobraczki fk_ptaki_magdokumpoz_magobraczki_ptaki_magdokumpoz; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magdokumpoz_magobraczki
    ADD CONSTRAINT fk_ptaki_magdokumpoz_magobraczki_ptaki_magdokumpoz FOREIGN KEY (id_dokumpoz) REFERENCES dbo.ptaki_magdokumpoz(id_dokumpoz);


--
-- Name: ptaki_magdokumpoz_magobraczki fk_ptaki_magdokumpoz_magobraczki_ptaki_magobraczki; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magdokumpoz_magobraczki
    ADD CONSTRAINT fk_ptaki_magdokumpoz_magobraczki_ptaki_magobraczki FOREIGN KEY (id_obraczki) REFERENCES dbo.ptaki_magobraczki(id_obraczki);


--
-- Name: ptaki_magdokumpoz fk_ptaki_magdokumpoz_ptaki_magdokum; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magdokumpoz
    ADD CONSTRAINT fk_ptaki_magdokumpoz_ptaki_magdokum FOREIGN KEY (id_dokum) REFERENCES dbo.ptaki_magdokum(id_dokum);


--
-- Name: ptaki_magdokumpoz fk_ptaki_magdokumpoz_ptaki_magobraczkipodtyp; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magdokumpoz
    ADD CONSTRAINT fk_ptaki_magdokumpoz_ptaki_magobraczkipodtyp FOREIGN KEY (id_obraczkipodtyp) REFERENCES dbo.ptaki_magobraczkipodtyp(id_obraczkipodtyp);


--
-- Name: ptaki_magdokumpoz fk_ptaki_magdokumpoz_ptaki_magobraczkityp; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magdokumpoz
    ADD CONSTRAINT fk_ptaki_magdokumpoz_ptaki_magobraczkityp FOREIGN KEY (id_obraczkityp) REFERENCES dbo.ptaki_magobraczkityp(id_obraczkityp);


--
-- Name: ptaki_magkolorowe fk_ptaki_magkolorowe_ptaki_bk_gatunek; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magkolorowe
    ADD CONSTRAINT fk_ptaki_magkolorowe_ptaki_bk_gatunek FOREIGN KEY (id_gat) REFERENCES dbo.ptaki_bk_gatunek(id_gat);


--
-- Name: ptaki_magkolorowe fk_ptaki_magkolorowe_ptaki_bk_kolor; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magkolorowe
    ADD CONSTRAINT fk_ptaki_magkolorowe_ptaki_bk_kolor FOREIGN KEY (id_kolor) REFERENCES dbo.ptaki_bk_kolor(id_kolor);


--
-- Name: ptaki_magkolorowe fk_ptaki_magkolorowe_ptaki_bk_typobr; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magkolorowe
    ADD CONSTRAINT fk_ptaki_magkolorowe_ptaki_bk_typobr FOREIGN KEY (id_typ) REFERENCES dbo.ptaki_bk_typobr(id_typ);


--
-- Name: ptaki_magkolorowe fk_ptaki_magkolorowe_ptaki_uzytkownicy; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magkolorowe
    ADD CONSTRAINT fk_ptaki_magkolorowe_ptaki_uzytkownicy FOREIGN KEY (id_uzytkownika) REFERENCES dbo.ptaki_uzytkownicy(id_uzytkownika);


--
-- Name: ptaki_magobraczki fk_ptaki_magobraczki_ptaki_dostawcy; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magobraczki
    ADD CONSTRAINT fk_ptaki_magobraczki_ptaki_dostawcy FOREIGN KEY (id_dostawca) REFERENCES dbo.ptaki_dostawcy(id_dostawca);


--
-- Name: ptaki_magobraczki fk_ptaki_magobraczki_ptaki_id_mag; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magobraczki
    ADD CONSTRAINT fk_ptaki_magobraczki_ptaki_id_mag FOREIGN KEY (id_mag) REFERENCES dbo.ptaki_mag(id_mag);


--
-- Name: ptaki_magobraczki fk_ptaki_magobraczki_ptaki_magobraczkipodtyp; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magobraczki
    ADD CONSTRAINT fk_ptaki_magobraczki_ptaki_magobraczkipodtyp FOREIGN KEY (id_obraczkipodtyp) REFERENCES dbo.ptaki_magobraczkipodtyp(id_obraczkipodtyp);


--
-- Name: ptaki_magobraczki fk_ptaki_magobraczki_ptaki_obraczkarze; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magobraczki
    ADD CONSTRAINT fk_ptaki_magobraczki_ptaki_obraczkarze FOREIGN KEY (id_obraczkarz) REFERENCES dbo.ptaki_obraczkarze(id_obraczkarz);


--
-- Name: ptaki_magoper fk_ptaki_magoperacje_ptaki_mag_1; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magoper
    ADD CONSTRAINT fk_ptaki_magoperacje_ptaki_mag_1 FOREIGN KEY (id_mag1) REFERENCES dbo.ptaki_mag(id_mag);


--
-- Name: ptaki_magoper fk_ptaki_magoperacje_ptaki_mag_2; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magoper
    ADD CONSTRAINT fk_ptaki_magoperacje_ptaki_mag_2 FOREIGN KEY (id_mag2) REFERENCES dbo.ptaki_mag(id_mag);


--
-- Name: ptaki_obraczkarze fk_ptaki_obraczkarze_ptaki_bk_ctr; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_obraczkarze
    ADD CONSTRAINT fk_ptaki_obraczkarze_ptaki_bk_ctr FOREIGN KEY (id_ctr) REFERENCES dbo.ptaki_bk_ctr(id_ctr) ON DELETE SET NULL;


--
-- Name: ptaki_obraczkarze fk_ptaki_obraczkarze_ptaki_doktozsamrodzaj; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_obraczkarze
    ADD CONSTRAINT fk_ptaki_obraczkarze_ptaki_doktozsamrodzaj FOREIGN KEY (id_doktozsamrodzaj) REFERENCES dbo.ptaki_doktozsamrodzaj(id_doktozsamrodzaj);


--
-- Name: ptaki_obraczkarze fk_ptaki_obraczkarze_ptaki_uzytkownicy; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_obraczkarze
    ADD CONSTRAINT fk_ptaki_obraczkarze_ptaki_uzytkownicy FOREIGN KEY (id_uzytkownika) REFERENCES dbo.ptaki_uzytkownicy(id_uzytkownika);


--
-- Name: ptaki_obraczkarze fk_ptaki_obraczkarze_ptaki_zakresobraczrodzaj; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_obraczkarze
    ADD CONSTRAINT fk_ptaki_obraczkarze_ptaki_zakresobraczrodzaj FOREIGN KEY (id_zakresobraczrodzaj) REFERENCES dbo.ptaki_zakresobraczrodzaj(id_zakresobraczrodzaj);


--
-- Name: ptaki_obraczkarzegatunki fk_ptaki_obraczkarzegatunki_ptaki_bk_gatunek; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_obraczkarzegatunki
    ADD CONSTRAINT fk_ptaki_obraczkarzegatunki_ptaki_bk_gatunek FOREIGN KEY (id_gat) REFERENCES dbo.ptaki_bk_gatunek(id_gat) ON DELETE CASCADE;


--
-- Name: ptaki_obraczkarzegatunki fk_ptaki_obraczkarzegatunki_ptaki_obraczkarze; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_obraczkarzegatunki
    ADD CONSTRAINT fk_ptaki_obraczkarzegatunki_ptaki_obraczkarze FOREIGN KEY (id_obraczkarz) REFERENCES dbo.ptaki_obraczkarze(id_obraczkarz) ON DELETE CASCADE;


--
-- Name: ptaki_obraczki fk_ptaki_obraczki_ptaki_bk_ctr; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_obraczki
    ADD CONSTRAINT fk_ptaki_obraczki_ptaki_bk_ctr FOREIGN KEY (id_ctr) REFERENCES dbo.ptaki_bk_ctr(id_ctr);


--
-- Name: ptaki_obraczki fk_ptaki_obraczki_ptaki_bk_gatunek; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_obraczki
    ADD CONSTRAINT fk_ptaki_obraczki_ptaki_bk_gatunek FOREIGN KEY (id_gat) REFERENCES dbo.ptaki_bk_gatunek(id_gat);


--
-- Name: ptaki_obraczki fk_ptaki_obraczki_ptaki_bk_kolor; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_obraczki
    ADD CONSTRAINT fk_ptaki_obraczki_ptaki_bk_kolor FOREIGN KEY (id_kolor) REFERENCES dbo.ptaki_bk_kolor(id_kolor);


--
-- Name: ptaki_obraczki fk_ptaki_obraczki_ptaki_bk_typobr; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_obraczki
    ADD CONSTRAINT fk_ptaki_obraczki_ptaki_bk_typobr FOREIGN KEY (id_typ) REFERENCES dbo.ptaki_bk_typobr(id_typ);


--
-- Name: ptaki_obraczki fk_ptaki_obraczki_ptaki_monity; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_obraczki
    ADD CONSTRAINT fk_ptaki_obraczki_ptaki_monity FOREIGN KEY (id_monit) REFERENCES dbo.ptaki_monity(id_monit) ON DELETE SET NULL;


--
-- Name: ptaki_obraczkistan fk_ptaki_obraczkistan_ptaki_bk_stanzn; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_obraczkistan
    ADD CONSTRAINT fk_ptaki_obraczkistan_ptaki_bk_stanzn FOREIGN KEY (id_stan) REFERENCES dbo.ptaki_bk_stanzn(id_stan);


--
-- Name: ptaki_obraczkistan fk_ptaki_obraczkistan_ptaki_obraczki; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_obraczkistan
    ADD CONSTRAINT fk_ptaki_obraczkistan_ptaki_obraczki FOREIGN KEY (id_obraczki) REFERENCES dbo.ptaki_obraczki(id_obraczki);


--
-- Name: ptaki_obraczkistan fk_ptaki_obraczkistan_ptaki_stwierdzenia; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_obraczkistan
    ADD CONSTRAINT fk_ptaki_obraczkistan_ptaki_stwierdzenia FOREIGN KEY (id_stw) REFERENCES dbo.ptaki_stwierdzenia(id_stw);


--
-- Name: ptaki_paramsuser fk_ptaki_paramuser_ptaki_uzytkownicy; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_paramsuser
    ADD CONSTRAINT fk_ptaki_paramuser_ptaki_uzytkownicy FOREIGN KEY (userid) REFERENCES dbo.ptaki_uzytkownicy(id_uzytkownika);


--
-- Name: ptaki_pdfwysylkazal fk_ptaki_pdfwysylkazal_ptaki_pdfwysylka; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_pdfwysylkazal
    ADD CONSTRAINT fk_ptaki_pdfwysylkazal_ptaki_pdfwysylka FOREIGN KEY (id_pdfwysylka) REFERENCES dbo.ptaki_pdfwysylka(id_pdfwysylka) ON DELETE CASCADE;


--
-- Name: ptaki_ptakobr fk_ptaki_ptakobr_ptaki_stwierdzenia; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_ptakobr
    ADD CONSTRAINT fk_ptaki_ptakobr_ptaki_stwierdzenia FOREIGN KEY (id_stwpierwotne) REFERENCES dbo.ptaki_stwierdzenia(id_stw) ON DELETE CASCADE;


--
-- Name: ptaki_ptakobr fk_ptaki_ptakobr_ptaki_uzytkownicy_1; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_ptakobr
    ADD CONSTRAINT fk_ptaki_ptakobr_ptaki_uzytkownicy_1 FOREIGN KEY (id_obr1) REFERENCES dbo.ptaki_uzytkownicy(id_uzytkownika);


--
-- Name: ptaki_ptakobr fk_ptaki_ptakobr_ptaki_uzytkownicy_2; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_ptakobr
    ADD CONSTRAINT fk_ptaki_ptakobr_ptaki_uzytkownicy_2 FOREIGN KEY (id_obr2) REFERENCES dbo.ptaki_uzytkownicy(id_uzytkownika);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_bk_chwyt; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_bk_chwyt FOREIGN KEY (id_chwyt) REFERENCES dbo.ptaki_bk_chwyt(id_chwyt);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_bk_dd; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_bk_dd FOREIGN KEY (id_dd) REFERENCES dbo.ptaki_bk_dd(id_dd);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_bk_doklpis; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_bk_doklpis FOREIGN KEY (id_doklpis) REFERENCES dbo.ptaki_bk_doklpis(id_doklpis);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_bk_gatunek1; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_bk_gatunek1 FOREIGN KEY (id_gat1) REFERENCES dbo.ptaki_bk_gatunek(id_gat);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_bk_gatunek2; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_bk_gatunek2 FOREIGN KEY (id_gat2) REFERENCES dbo.ptaki_bk_gatunek(id_gat);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_bk_id_plec1; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_bk_id_plec1 FOREIGN KEY (id_plec1) REFERENCES dbo.ptaki_bk_plec(id_plec);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_bk_id_plec2; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_bk_id_plec2 FOREIGN KEY (id_plec2) REFERENCES dbo.ptaki_bk_plec(id_plec);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_bk_kondycja; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_bk_kondycja FOREIGN KEY (id_kond) REFERENCES dbo.ptaki_bk_kondycja(id_kond);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_bk_manip; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_bk_manip FOREIGN KEY (id_manip) REFERENCES dbo.ptaki_bk_manip(id_manip);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_bk_okol; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_bk_okol FOREIGN KEY (id_okol) REFERENCES dbo.ptaki_bk_okol(id_okol);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_bk_okolvalid; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_bk_okolvalid FOREIGN KEY (id_okolvalid) REFERENCES dbo.ptaki_bk_okolvalid(id_okolvalid);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_bk_pomiar; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_bk_pomiar FOREIGN KEY (id_pomiar) REFERENCES dbo.ptaki_bk_pomiar(id_pomiar);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_bk_pomiar1; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_bk_pomiar1 FOREIGN KEY (id_pomiar1) REFERENCES dbo.ptaki_bk_pomiar(id_pomiar);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_bk_pomiar2; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_bk_pomiar2 FOREIGN KEY (id_pomiar2) REFERENCES dbo.ptaki_bk_pomiar(id_pomiar);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_bk_pomiar3; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_bk_pomiar3 FOREIGN KEY (id_pomiar3) REFERENCES dbo.ptaki_bk_pomiar(id_pomiar);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_bk_pomiar4; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_bk_pomiar4 FOREIGN KEY (id_pomiar4) REFERENCES dbo.ptaki_bk_pomiar(id_pomiar);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_bk_pomiar5; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_bk_pomiar5 FOREIGN KEY (id_pomiar5) REFERENCES dbo.ptaki_bk_pomiar(id_pomiar);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_bk_pomiar6; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_bk_pomiar6 FOREIGN KEY (id_pomiar6) REFERENCES dbo.ptaki_bk_pomiar(id_pomiar);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_bk_pomiar7; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_bk_pomiar7 FOREIGN KEY (id_pomiar7) REFERENCES dbo.ptaki_bk_pomiar(id_pomiar);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_bk_pomiar8; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_bk_pomiar8 FOREIGN KEY (id_pomiar8) REFERENCES dbo.ptaki_bk_pomiar(id_pomiar);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_bk_pomiar9; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_bk_pomiar9 FOREIGN KEY (id_pomiar9) REFERENCES dbo.ptaki_bk_pomiar(id_pomiar);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_bk_poprawny; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_bk_poprawny FOREIGN KEY (id_poprawny) REFERENCES dbo.ptaki_bk_poprawny(id_poprawny);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_bk_przem; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_bk_przem FOREIGN KEY (id_przem) REFERENCES dbo.ptaki_bk_przem(id_przem);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_bk_status; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_bk_status FOREIGN KEY (id_status) REFERENCES dbo.ptaki_bk_status(id_status);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_bk_szata; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_bk_szata FOREIGN KEY (id_szata) REFERENCES dbo.ptaki_bk_szata(id_szata);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_bk_wabik; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_bk_wabik FOREIGN KEY (id_wabik) REFERENCES dbo.ptaki_bk_wabik(id_wabik);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_bk_wer; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_bk_wer FOREIGN KEY (id_wer) REFERENCES dbo.ptaki_bk_wer(id_wer);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_bk_wiek1; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_bk_wiek1 FOREIGN KEY (id_wiek1) REFERENCES dbo.ptaki_bk_wiek(id_wiek);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_bk_wiek2; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_bk_wiek2 FOREIGN KEY (id_wiek2) REFERENCES dbo.ptaki_bk_wiek(id_wiek);


--
-- Name: ptaki_emailewysylkabld fk_ptaki_stwierdzenia_ptaki_emailewysylkabld; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_emailewysylkabld
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_emailewysylkabld FOREIGN KEY (id_stw) REFERENCES dbo.ptaki_stwierdzenia(id_stw) ON DELETE CASCADE;


--
-- Name: ptaki_emailewysylkastw fk_ptaki_stwierdzenia_ptaki_emailewysylkastw; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_emailewysylkastw
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_emailewysylkastw FOREIGN KEY (id_stw) REFERENCES dbo.ptaki_stwierdzenia(id_stw) ON DELETE CASCADE;


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_lokalizacja; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_lokalizacja FOREIGN KEY (id_lokalizacja) REFERENCES dbo.ptaki_lokalizacja(id_lokalizacja);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_stwierdzenia; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_stwierdzenia FOREIGN KEY (id_stwpierwotne) REFERENCES dbo.ptaki_stwierdzenia(id_stw);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_stwierdzeniagoscie; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_stwierdzeniagoscie FOREIGN KEY (id_stwgosc) REFERENCES dbo.ptaki_stwierdzeniagoscie(id_stwgosc);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_uzytkownicy1; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_uzytkownicy1 FOREIGN KEY (id_obr1) REFERENCES dbo.ptaki_uzytkownicy(id_uzytkownika);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_uzytkownicy2; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_uzytkownicy2 FOREIGN KEY (id_obr2) REFERENCES dbo.ptaki_uzytkownicy(id_uzytkownika);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_uzytkownicy_ed; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_uzytkownicy_ed FOREIGN KEY (id_uzytkownika_ed) REFERENCES dbo.ptaki_uzytkownicy(id_uzytkownika);


--
-- Name: ptaki_stwierdzenia fk_ptaki_stwierdzenia_ptaki_uzytkownicy_wpr; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzenia
    ADD CONSTRAINT fk_ptaki_stwierdzenia_ptaki_uzytkownicy_wpr FOREIGN KEY (id_uzytkownika_wpr) REFERENCES dbo.ptaki_uzytkownicy(id_uzytkownika);


--
-- Name: ptaki_stwierdzeniagoscie fk_ptaki_stwierdzeniagoscie_ptaki_bk_kto; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzeniagoscie
    ADD CONSTRAINT fk_ptaki_stwierdzeniagoscie_ptaki_bk_kto FOREIGN KEY (id_kto) REFERENCES dbo.ptaki_bk_kto(id_kto);


--
-- Name: ptaki_stwierdzeniakoresp fk_ptaki_stwierdzeniakoresp_ptaki_stwierdzenia; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzeniakoresp
    ADD CONSTRAINT fk_ptaki_stwierdzeniakoresp_ptaki_stwierdzenia FOREIGN KEY (id_stw) REFERENCES dbo.ptaki_stwierdzenia(id_stw);


--
-- Name: ptaki_stwierdzeniapliki fk_ptaki_stwierdzeniapliki_ptaki_stwierdzenia; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzeniapliki
    ADD CONSTRAINT fk_ptaki_stwierdzeniapliki_ptaki_stwierdzenia FOREIGN KEY (id_stw) REFERENCES dbo.ptaki_stwierdzenia(id_stw) ON DELETE CASCADE;


--
-- Name: ptaki_stwierdzeniapol fk_ptaki_stwierdzeniapol_ptaki_bk_ctr; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzeniapol
    ADD CONSTRAINT fk_ptaki_stwierdzeniapol_ptaki_bk_ctr FOREIGN KEY (id_ctr) REFERENCES dbo.ptaki_bk_ctr(id_ctr) ON DELETE CASCADE;


--
-- Name: ptaki_stwierdzeniapol fk_ptaki_stwierdzeniapol_ptaki_stwierdzenia; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzeniapol
    ADD CONSTRAINT fk_ptaki_stwierdzeniapol_ptaki_stwierdzenia FOREIGN KEY (id_stw) REFERENCES dbo.ptaki_stwierdzenia(id_stw) ON DELETE CASCADE;


--
-- Name: ptaki_stwierdzeniapol fk_ptaki_stwierdzeniapol_ptaki_uzytkownicy; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzeniapol
    ADD CONSTRAINT fk_ptaki_stwierdzeniapol_ptaki_uzytkownicy FOREIGN KEY (id_uzytkownika) REFERENCES dbo.ptaki_uzytkownicy(id_uzytkownika) ON DELETE CASCADE;


--
-- Name: ptaki_stwierdzeniarodz fk_ptaki_stwierdzeniarodz_ptaki_obraczki; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzeniarodz
    ADD CONSTRAINT fk_ptaki_stwierdzeniarodz_ptaki_obraczki FOREIGN KEY (id_obraczki) REFERENCES dbo.ptaki_obraczki(id_obraczki);


--
-- Name: ptaki_stwierdzeniarodz fk_ptaki_stwierdzeniarodz_ptaki_stwierdzenia; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzeniarodz
    ADD CONSTRAINT fk_ptaki_stwierdzeniarodz_ptaki_stwierdzenia FOREIGN KEY (id_stw) REFERENCES dbo.ptaki_stwierdzenia(id_stw);


--
-- Name: ptaki_stwierdzeniawer fk_ptaki_stwierdzeniawer_ptaki_stwierdzenia; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwierdzeniawer
    ADD CONSTRAINT fk_ptaki_stwierdzeniawer_ptaki_stwierdzenia FOREIGN KEY (id_stw) REFERENCES dbo.ptaki_stwierdzenia(id_stw);


--
-- Name: ptaki_stwimport_bld fk_ptaki_stwimport_bld_ptaki_stwimport; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwimport_bld
    ADD CONSTRAINT fk_ptaki_stwimport_bld_ptaki_stwimport FOREIGN KEY (id_stwimport) REFERENCES dbo.ptaki_stwimport(id_stwimport) ON DELETE CASCADE;


--
-- Name: ptaki_stwimport fk_ptaki_stwimport_ptaki_bk_gatunek; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwimport
    ADD CONSTRAINT fk_ptaki_stwimport_ptaki_bk_gatunek FOREIGN KEY (id_gat) REFERENCES dbo.ptaki_bk_gatunek(id_gat);


--
-- Name: ptaki_stwimport fk_ptaki_stwimport_ptaki_uzytkownicy; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwimport
    ADD CONSTRAINT fk_ptaki_stwimport_ptaki_uzytkownicy FOREIGN KEY (id_uzytkownika) REFERENCES dbo.ptaki_uzytkownicy(id_uzytkownika);


--
-- Name: ptaki_stwimport_stw fk_ptaki_stwimport_stw_ptaki_stwierdzenia; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwimport_stw
    ADD CONSTRAINT fk_ptaki_stwimport_stw_ptaki_stwierdzenia FOREIGN KEY (id_stw) REFERENCES dbo.ptaki_stwierdzenia(id_stw) ON DELETE CASCADE;


--
-- Name: ptaki_stwimport_stw fk_ptaki_stwimport_stw_ptaki_stwimport; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwimport_stw
    ADD CONSTRAINT fk_ptaki_stwimport_stw_ptaki_stwimport FOREIGN KEY (id_stwimport) REFERENCES dbo.ptaki_stwimport(id_stwimport);


--
-- Name: ptaki_stwpopr fk_ptaki_stwpopr_ptaki_stwierdzenia; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwpopr
    ADD CONSTRAINT fk_ptaki_stwpopr_ptaki_stwierdzenia FOREIGN KEY (id_stw) REFERENCES dbo.ptaki_stwierdzenia(id_stw) ON DELETE SET NULL;


--
-- Name: ptaki_stwpopr fk_ptaki_stwpopr_ptaki_uzytkownicy_stacja; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwpopr
    ADD CONSTRAINT fk_ptaki_stwpopr_ptaki_uzytkownicy_stacja FOREIGN KEY (id_uzytkownika_stacja) REFERENCES dbo.ptaki_uzytkownicy(id_uzytkownika);


--
-- Name: ptaki_stwpopr fk_ptaki_stwpopr_ptaki_uzytkownicy_user; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_stwpopr
    ADD CONSTRAINT fk_ptaki_stwpopr_ptaki_uzytkownicy_user FOREIGN KEY (id_uzytkownika_user) REFERENCES dbo.ptaki_uzytkownicy(id_uzytkownika) ON DELETE SET NULL;


--
-- Name: ptaki_telefony fk_ptaki_telefony_ptaki_obraczkarze; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_telefony
    ADD CONSTRAINT fk_ptaki_telefony_ptaki_obraczkarze FOREIGN KEY (id_obraczkarz) REFERENCES dbo.ptaki_obraczkarze(id_obraczkarz);


--
-- Name: ptaki_uzytkownicy_prawa fk_ptaki_uzytkownicy_prawa_ptaki_prawa; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_uzytkownicy_prawa
    ADD CONSTRAINT fk_ptaki_uzytkownicy_prawa_ptaki_prawa FOREIGN KEY (id_prawa) REFERENCES dbo.ptaki_prawa(id_prawa);


--
-- Name: ptaki_uzytkownicy_prawa fk_ptaki_uzytkownicy_prawa_ptaki_uzytkownicy; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_uzytkownicy_prawa
    ADD CONSTRAINT fk_ptaki_uzytkownicy_prawa_ptaki_uzytkownicy FOREIGN KEY (id_uzytkownika) REFERENCES dbo.ptaki_uzytkownicy(id_uzytkownika);


--
-- Name: ptaki_uzytkownicy fk_ptaki_uzytkownicy_ptaki_stwierdzeniagoscie; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_uzytkownicy
    ADD CONSTRAINT fk_ptaki_uzytkownicy_ptaki_stwierdzeniagoscie FOREIGN KEY (id_kto) REFERENCES dbo.ptaki_bk_kto(id_kto);


--
-- Name: ptaki_zakresobracz fk_ptaki_zakresobracz_ptaki_obraczkarze; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_zakresobracz
    ADD CONSTRAINT fk_ptaki_zakresobracz_ptaki_obraczkarze FOREIGN KEY (id_obraczkarz) REFERENCES dbo.ptaki_obraczkarze(id_obraczkarz);


--
-- Name: ptaki_zamowienia fk_ptaki_zamowienia_ptaki_obraczkarze; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_zamowienia
    ADD CONSTRAINT fk_ptaki_zamowienia_ptaki_obraczkarze FOREIGN KEY (id_obraczkarz) REFERENCES dbo.ptaki_obraczkarze(id_obraczkarz);


--
-- Name: ptaki_zamowieniadok fk_ptaki_zamowieniadok_ptaki_uzytkownicy; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_zamowieniadok
    ADD CONSTRAINT fk_ptaki_zamowieniadok_ptaki_uzytkownicy FOREIGN KEY (id_uzytkownika) REFERENCES dbo.ptaki_uzytkownicy(id_uzytkownika);


--
-- Name: ptaki_zamowieniadokpoz fk_ptaki_zamowieniadokpoz_ptaki_magdokum; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_zamowieniadokpoz
    ADD CONSTRAINT fk_ptaki_zamowieniadokpoz_ptaki_magdokum FOREIGN KEY (id_dokum) REFERENCES dbo.ptaki_magdokum(id_dokum);


--
-- Name: ptaki_zamowieniadokpoz fk_ptaki_zamowieniadokpoz_ptaki_zamowienia; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_zamowieniadokpoz
    ADD CONSTRAINT fk_ptaki_zamowieniadokpoz_ptaki_zamowienia FOREIGN KEY (id_zamow) REFERENCES dbo.ptaki_zamowienia(id_zamow);


--
-- Name: ptaki_zamowieniadokpoz fk_ptaki_zamowieniadokpoz_ptaki_zamowieniadok; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_zamowieniadokpoz
    ADD CONSTRAINT fk_ptaki_zamowieniadokpoz_ptaki_zamowieniadok FOREIGN KEY (id_zamowdok) REFERENCES dbo.ptaki_zamowieniadok(id_zamowdok);


--
-- Name: ptaki_zamowieniapoz fk_ptaki_zamowieniapoz_ptaki_magobraczkityp; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_zamowieniapoz
    ADD CONSTRAINT fk_ptaki_zamowieniapoz_ptaki_magobraczkityp FOREIGN KEY (id_obraczkityp) REFERENCES dbo.ptaki_magobraczkityp(id_obraczkityp);


--
-- Name: ptaki_zamowieniapoz fk_ptaki_zamowieniapoz_ptaki_zamowienia; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_zamowieniapoz
    ADD CONSTRAINT fk_ptaki_zamowieniapoz_ptaki_zamowienia FOREIGN KEY (id_zamow) REFERENCES dbo.ptaki_zamowienia(id_zamow);


--
-- Name: ptaki_magobraczkipodtyp ptaki_magobraczkipodtyp_ptaki_magobraczkityp; Type: FK CONSTRAINT; Schema: dbo; Owner: postgres
--

ALTER TABLE ONLY dbo.ptaki_magobraczkipodtyp
    ADD CONSTRAINT ptaki_magobraczkipodtyp_ptaki_magobraczkityp FOREIGN KEY (id_obraczkityp) REFERENCES dbo.ptaki_magobraczkityp(id_obraczkityp);


--
-- PostgreSQL database dump complete
--

