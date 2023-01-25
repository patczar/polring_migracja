--
-- PostgreSQL database dump
--

-- Dumped from database version 13.5 (Debian 13.5-1.pgdg110+1)
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
-- Name: public; Type: SCHEMA; Schema: -; Owner: laravel
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO laravel;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: laravel
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: update_province_and_country(); Type: FUNCTION; Schema: public; Owner: laravel
--

CREATE FUNCTION public.update_province_and_country() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
                begin
                    if NEW.has_manually_edited_province_or_country then
                        return NEW;
                    else
                        NEW.province_id := (select province_id from vf_province_and_country(NEW.coordinates::geometry));
                        NEW.country_id := (select country_id from vf_province_and_country(NEW.coordinates::geometry));
                        return NEW;
                    end if;
                end;
            $$;


ALTER FUNCTION public.update_province_and_country() OWNER TO laravel;

--
-- Name: vf_other_sightings_connected_with_rings(bigint); Type: FUNCTION; Schema: public; Owner: laravel
--

CREATE FUNCTION public.vf_other_sightings_connected_with_rings(arg_sighting_id bigint) RETURNS TABLE(sighting_id bigint)
    LANGUAGE sql
    AS $$
                with sighting_species (species_id) as (
                    select max(species_id) from sightings where id = arg_sighting_id
                ), similar_species (species_id) as (
                    select species_id from (select vf_similar_species(species_id) as species_id from sighting_species) subquery_1
                ), ring_sightings_group as (
                    select s.id as sighting_id, s.primary_sighting_id = s.id as is_primary
                    from vf_rings_sightings_group(null, arg_sighting_id) vrsg
                    inner join sightings s on vrsg.sighting_id = s.id
                    where s.species_id in (select species_id from similar_species)
                )
                select sighting_id
                from ring_sightings_group
                where sighting_id <> arg_sighting_id
                    and is_primary
            $$;


ALTER FUNCTION public.vf_other_sightings_connected_with_rings(arg_sighting_id bigint) OWNER TO laravel;

--
-- Name: vf_province_and_country(public.geometry); Type: FUNCTION; Schema: public; Owner: laravel
--

CREATE FUNCTION public.vf_province_and_country(coordinates public.geometry) RETURNS TABLE(gis_id bigint, province_id bigint, country_id bigint)
    LANGUAGE sql
    AS $$
                select dg.id, dp.id, dc.id
                from dict_gis dg
                    inner join dict_provinces dp on dg.province_id = dp.id
                    inner join dict_countries dc on dp.country_id = dc.id
                where st_within(coordinates, dg.geo_data::geometry)
                order by dg.layer
                limit 1
            $$;


ALTER FUNCTION public.vf_province_and_country(coordinates public.geometry) OWNER TO laravel;

--
-- Name: vf_rings_sightings_group(bigint, bigint); Type: FUNCTION; Schema: public; Owner: laravel
--

CREATE FUNCTION public.vf_rings_sightings_group(arg_ring_id bigint, arg_sighting_id bigint) RETURNS TABLE(ring_id bigint, sighting_id bigint, ring_status_id bigint)
    LANGUAGE sql
    AS $$
            with recursive rings_sightings as (
                select ring_id, sighting_id, ring_status_id
                from ring_sighting
                where (arg_sighting_id is null and ring_id = arg_ring_id) or (arg_ring_id is null and sighting_id = arg_sighting_id)
                union
                select rs.ring_id, rs.sighting_id, rs.ring_status_id
                from ring_sighting rs
                         inner join rings_sightings rs2 on (rs.sighting_id = rs2.sighting_id or rs.ring_id = rs2.ring_id)
            )
            select * from rings_sightings;
            $$;


ALTER FUNCTION public.vf_rings_sightings_group(arg_ring_id bigint, arg_sighting_id bigint) OWNER TO laravel;

--
-- Name: vf_similar_species(bigint); Type: FUNCTION; Schema: public; Owner: laravel
--

CREATE FUNCTION public.vf_similar_species(arg_species_id bigint) RETURNS TABLE(species_id bigint)
    LANGUAGE sql
    AS $$
                select arg_species_id
                union
                select species2_id from dict_species_pairs where species1_id = arg_species_id
                union
                select species1_id from dict_species_pairs where species2_id = arg_species_id
                union
                select g2.species_id
                from dict_species_dict_species_groups g1
                    join dict_species_dict_species_groups g2 using (species_group_id)
                where g1.species_id = arg_species_id;
            $$;


ALTER FUNCTION public.vf_similar_species(arg_species_id bigint) OWNER TO laravel;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: addresses; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.addresses (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    street character varying(255),
    post_code character varying(255),
    city character varying(255),
    country character varying(255),
    type character varying(255) DEFAULT 'NORMAL'::character varying NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    company character varying(255),
    CONSTRAINT addresses_type_check CHECK (((type)::text = ANY ((ARRAY['NORMAL'::character varying, 'CORRESPONDENCE'::character varying])::text[])))
);


ALTER TABLE public.addresses OWNER TO laravel;

--
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.addresses_id_seq OWNER TO laravel;

--
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.addresses_id_seq OWNED BY public.addresses.id;


--
-- Name: data_sharing_requesters; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.data_sharing_requesters (
    id bigint NOT NULL,
    first_name text,
    last_name text,
    data_sharing_request_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.data_sharing_requesters OWNER TO laravel;

--
-- Name: applicants_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.applicants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.applicants_id_seq OWNER TO laravel;

--
-- Name: applicants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.applicants_id_seq OWNED BY public.data_sharing_requesters.id;


--
-- Name: application_configurations; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.application_configurations (
    id bigint NOT NULL,
    max_file_weight integer NOT NULL,
    max_record_warning integer NOT NULL,
    adress_print boolean NOT NULL,
    euring_separator character varying(255) NOT NULL,
    xls_invoice_cfg_pattern character varying(255) NOT NULL,
    xls_invoice_cfg_contractor_cell character varying(255) NOT NULL,
    xls_invoice_cfg_unit_price_cell character varying(255) NOT NULL,
    metal_ring character varying(255) NOT NULL,
    col_ring_leg character varying(255) NOT NULL,
    col_ring_neck character varying(255) NOT NULL,
    col_ring_beak character varying(255) NOT NULL,
    col_ring_wing character varying(255) NOT NULL,
    col_ring_col character varying(255) NOT NULL,
    col_ring_flag character varying(255) NOT NULL,
    ring_on character varying(255) NOT NULL,
    ring_control character varying(255) NOT NULL,
    ring_off character varying(255) NOT NULL,
    plg_scheme character varying(255) NOT NULL,
    not_applicable_status character varying(255) NOT NULL,
    ring_unverified character varying(255) NOT NULL,
    lost_statement character varying(255) NOT NULL,
    account_settings_email character varying(255) NOT NULL,
    account_settings_name character varying(255) NOT NULL,
    account_settings_smtp_server character varying(255) NOT NULL,
    account_settings_port integer NOT NULL,
    hidden_for_message character varying(255) NOT NULL,
    replacement_adress character varying(255) NOT NULL,
    redoing integer NOT NULL,
    max_statement_value integer NOT NULL,
    max_pdf_value integer NOT NULL,
    gps_time_period integer NOT NULL,
    gps_distance_interval integer NOT NULL,
    gps_ring character varying(255) NOT NULL,
    date_accuracy character varying(255) NOT NULL,
    ring_veryfied character varying(255) NOT NULL,
    circumstance character varying(255) NOT NULL,
    condition character varying(255) NOT NULL,
    website_unavailable boolean NOT NULL,
    max_photo_weight integer NOT NULL,
    photos_limit integer NOT NULL,
    max_xls_file_weight integer NOT NULL,
    my_birds_time_range integer NOT NULL,
    my_statement_time_range integer NOT NULL,
    pending_statement_time_range integer NOT NULL,
    registration_blocked boolean NOT NULL,
    registration_time integer NOT NULL,
    export_value integer NOT NULL,
    correct_verify boolean NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.application_configurations OWNER TO laravel;

--
-- Name: application_configurations_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.application_configurations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.application_configurations_id_seq OWNER TO laravel;

--
-- Name: application_configurations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.application_configurations_id_seq OWNED BY public.application_configurations.id;


--
-- Name: data_sharing_requests; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.data_sharing_requests (
    id bigint NOT NULL,
    address_id bigint,
    institution_email text,
    institution_phone_number text,
    contact_first_name text,
    contact_last_name text,
    contact_email text,
    contact_phone_number text,
    purpose_of_requested text,
    project_title text,
    scope_of_requested text,
    project_details text,
    scope_of_own_data text,
    info_about_planned_publication text,
    latest_date_of_data_use text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    approved boolean
);


ALTER TABLE public.data_sharing_requests OWNER TO laravel;

--
-- Name: applications_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.applications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.applications_id_seq OWNER TO laravel;

--
-- Name: applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.applications_id_seq OWNED BY public.data_sharing_requests.id;


--
-- Name: bird_family_sightings_rings; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.bird_family_sightings_rings (
    id bigint NOT NULL,
    sighting_id bigint NOT NULL,
    family_member_ring_id bigint NOT NULL,
    family_member_role character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT bird_family_sightings_rings_family_member_role_check CHECK (((family_member_role)::text = ANY ((ARRAY['PARENT'::character varying, 'PARTNER'::character varying, 'CHILD'::character varying])::text[])))
);


ALTER TABLE public.bird_family_sightings_rings OWNER TO laravel;

--
-- Name: bird_family_sightings_rings_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.bird_family_sightings_rings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bird_family_sightings_rings_id_seq OWNER TO laravel;

--
-- Name: bird_family_sightings_rings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.bird_family_sightings_rings_id_seq OWNED BY public.bird_family_sightings_rings.id;


--
-- Name: dict_ages; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_ages (
    id bigint NOT NULL,
    eu_code character varying(2),
    abbr character varying(10),
    text_pl character varying(100),
    text_en character varying(100),
    is_pullus boolean NOT NULL,
    is_active boolean NOT NULL,
    is_default boolean NOT NULL,
    sort_order integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.dict_ages OWNER TO laravel;

--
-- Name: dict_ages_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_ages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_ages_id_seq OWNER TO laravel;

--
-- Name: dict_ages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_ages_id_seq OWNED BY public.dict_ages.id;


--
-- Name: dict_areas; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_areas (
    id bigint NOT NULL,
    abbr character varying(20),
    name character varying(100),
    coordinates text,
    description character varying(1000),
    is_active boolean NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.dict_areas OWNER TO laravel;

--
-- Name: dict_areas_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_areas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_areas_id_seq OWNER TO laravel;

--
-- Name: dict_areas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_areas_id_seq OWNED BY public.dict_areas.id;


--
-- Name: dict_bird_birth_accuracies; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_bird_birth_accuracies (
    id bigint NOT NULL,
    eu_code character varying(2),
    abbr character varying(10),
    text_pl character varying(100),
    text_en character varying(100),
    is_active boolean NOT NULL,
    is_default boolean NOT NULL,
    sort_order integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.dict_bird_birth_accuracies OWNER TO laravel;

--
-- Name: dict_bird_birth_accuracies_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_bird_birth_accuracies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_bird_birth_accuracies_id_seq OWNER TO laravel;

--
-- Name: dict_bird_birth_accuracies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_bird_birth_accuracies_id_seq OWNED BY public.dict_bird_birth_accuracies.id;


--
-- Name: dict_bird_displacements; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_bird_displacements (
    id bigint NOT NULL,
    eu_code character varying(2),
    abbr character varying(10),
    text_pl character varying(100),
    text_en character varying(100),
    is_active boolean NOT NULL,
    is_default boolean NOT NULL,
    sort_order integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.dict_bird_displacements OWNER TO laravel;

--
-- Name: dict_bird_displacements_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_bird_displacements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_bird_displacements_id_seq OWNER TO laravel;

--
-- Name: dict_bird_displacements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_bird_displacements_id_seq OWNED BY public.dict_bird_displacements.id;


--
-- Name: dict_bird_manipulations; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_bird_manipulations (
    id bigint NOT NULL,
    eu_code character varying(2),
    abbr character varying(10),
    text_pl character varying(100),
    text_en character varying(100),
    is_active boolean NOT NULL,
    is_default boolean NOT NULL,
    sort_order integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.dict_bird_manipulations OWNER TO laravel;

--
-- Name: dict_bird_manipulations_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_bird_manipulations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_bird_manipulations_id_seq OWNER TO laravel;

--
-- Name: dict_bird_manipulations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_bird_manipulations_id_seq OWNED BY public.dict_bird_manipulations.id;


--
-- Name: dict_bird_statuses; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_bird_statuses (
    id bigint NOT NULL,
    eu_code character varying(2),
    abbr character varying(10),
    text_pl character varying(100),
    text_en character varying(100),
    is_active boolean NOT NULL,
    is_default boolean NOT NULL,
    sort_order integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.dict_bird_statuses OWNER TO laravel;

--
-- Name: dict_bird_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_bird_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_bird_statuses_id_seq OWNER TO laravel;

--
-- Name: dict_bird_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_bird_statuses_id_seq OWNED BY public.dict_bird_statuses.id;


--
-- Name: dict_capture_methods; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_capture_methods (
    id bigint NOT NULL,
    eu_code character varying(2),
    abbr character varying(10),
    text_pl character varying(100),
    text_en character varying(100),
    is_active boolean NOT NULL,
    is_default boolean NOT NULL,
    sort_order integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.dict_capture_methods OWNER TO laravel;

--
-- Name: dict_capture_methods_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_capture_methods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_capture_methods_id_seq OWNER TO laravel;

--
-- Name: dict_capture_methods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_capture_methods_id_seq OWNED BY public.dict_capture_methods.id;


--
-- Name: dict_circumstances; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_circumstances (
    id bigint NOT NULL,
    parent_id bigint,
    eu_code character varying(2),
    abbr character varying(10),
    text_pl character varying(100),
    text_en character varying(100),
    is_active boolean NOT NULL,
    is_default boolean NOT NULL,
    sort_order integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.dict_circumstances OWNER TO laravel;

--
-- Name: dict_circumstances_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_circumstances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_circumstances_id_seq OWNER TO laravel;

--
-- Name: dict_circumstances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_circumstances_id_seq OWNED BY public.dict_circumstances.id;


--
-- Name: dict_circumstances_validations; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_circumstances_validations (
    id bigint NOT NULL,
    abbr text,
    eu_code text,
    text_pl text,
    text_en text,
    is_active boolean NOT NULL,
    is_default boolean NOT NULL,
    sort_order integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.dict_circumstances_validations OWNER TO laravel;

--
-- Name: dict_circumstances_validations_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_circumstances_validations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_circumstances_validations_id_seq OWNER TO laravel;

--
-- Name: dict_circumstances_validations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_circumstances_validations_id_seq OWNED BY public.dict_circumstances_validations.id;


--
-- Name: dict_colors; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_colors (
    id bigint NOT NULL,
    abbr character varying(10),
    text_pl character varying(100),
    text_en character varying(100),
    is_active boolean NOT NULL,
    is_default boolean NOT NULL,
    sort_order integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    color_1 character varying(50),
    color_2 character varying(50)
);


ALTER TABLE public.dict_colors OWNER TO laravel;

--
-- Name: dict_colors_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_colors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_colors_id_seq OWNER TO laravel;

--
-- Name: dict_colors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_colors_id_seq OWNED BY public.dict_colors.id;


--
-- Name: dict_conditions; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_conditions (
    id bigint NOT NULL,
    eu_code character varying(2),
    abbr character varying(10),
    text_pl character varying(100),
    text_en character varying(100),
    is_dead boolean NOT NULL,
    is_active boolean NOT NULL,
    is_default boolean NOT NULL,
    sort_order integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.dict_conditions OWNER TO laravel;

--
-- Name: dict_conditions_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_conditions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_conditions_id_seq OWNER TO laravel;

--
-- Name: dict_conditions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_conditions_id_seq OWNED BY public.dict_conditions.id;


--
-- Name: dict_coordinate_accuracies; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_coordinate_accuracies (
    id bigint NOT NULL,
    eu_code character varying(2),
    abbr character varying(10),
    text_pl character varying(100),
    text_en character varying(100),
    is_active boolean NOT NULL,
    is_default boolean NOT NULL,
    sort_order integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.dict_coordinate_accuracies OWNER TO laravel;

--
-- Name: dict_coordinate_accuracies_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_coordinate_accuracies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_coordinate_accuracies_id_seq OWNER TO laravel;

--
-- Name: dict_coordinate_accuracies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_coordinate_accuracies_id_seq OWNED BY public.dict_coordinate_accuracies.id;


--
-- Name: dict_countries; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_countries (
    id bigint NOT NULL,
    eu_code character varying(2),
    text_pl character varying(100),
    text_en character varying(100),
    is_active boolean NOT NULL,
    is_default boolean NOT NULL,
    sort_order integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.dict_countries OWNER TO laravel;

--
-- Name: dict_countries_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_countries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_countries_id_seq OWNER TO laravel;

--
-- Name: dict_countries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_countries_id_seq OWNED BY public.dict_countries.id;


--
-- Name: dict_date_accuracies; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_date_accuracies (
    id bigint NOT NULL,
    eu_code character varying(2),
    abbr character varying(10),
    text_pl character varying(100),
    text_en character varying(100),
    is_active boolean NOT NULL,
    is_default boolean NOT NULL,
    sort_order integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.dict_date_accuracies OWNER TO laravel;

--
-- Name: dict_date_accuracies_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_date_accuracies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_date_accuracies_id_seq OWNER TO laravel;

--
-- Name: dict_date_accuracies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_date_accuracies_id_seq OWNED BY public.dict_date_accuracies.id;


--
-- Name: dict_decoys; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_decoys (
    id bigint NOT NULL,
    eu_code character varying(2),
    abbr character varying(10),
    text_pl character varying(100),
    text_en character varying(100),
    is_active boolean NOT NULL,
    is_default boolean NOT NULL,
    sort_order integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.dict_decoys OWNER TO laravel;

--
-- Name: dict_decoys_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_decoys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_decoys_id_seq OWNER TO laravel;

--
-- Name: dict_decoys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_decoys_id_seq OWNED BY public.dict_decoys.id;


--
-- Name: dict_gis; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_gis (
    id bigint NOT NULL,
    province_id bigint NOT NULL,
    layer smallint NOT NULL,
    filename character varying(100) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    geo_data public.geography
);


ALTER TABLE public.dict_gis OWNER TO laravel;

--
-- Name: dict_gis_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_gis_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_gis_id_seq OWNER TO laravel;

--
-- Name: dict_gis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_gis_id_seq OWNED BY public.dict_gis.id;


--
-- Name: dict_measurement_types; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_measurement_types (
    id bigint NOT NULL,
    eu_code character varying(2),
    abbr character varying(10),
    text_pl character varying(100),
    text_en character varying(100),
    is_active boolean NOT NULL,
    is_default boolean NOT NULL,
    sort_order integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.dict_measurement_types OWNER TO laravel;

--
-- Name: dict_measurement_types_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_measurement_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_measurement_types_id_seq OWNER TO laravel;

--
-- Name: dict_measurement_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_measurement_types_id_seq OWNED BY public.dict_measurement_types.id;


--
-- Name: dict_personal_titles; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_personal_titles (
    id bigint NOT NULL,
    name character varying(50) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    sort_order integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.dict_personal_titles OWNER TO laravel;

--
-- Name: dict_personal_titles_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_personal_titles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_personal_titles_id_seq OWNER TO laravel;

--
-- Name: dict_personal_titles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_personal_titles_id_seq OWNED BY public.dict_personal_titles.id;


--
-- Name: phone_numbers; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.phone_numbers (
    id bigint NOT NULL,
    ringer_id integer NOT NULL,
    number text NOT NULL,
    comments text NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.phone_numbers OWNER TO laravel;

--
-- Name: dict_phone_numbers_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_phone_numbers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_phone_numbers_id_seq OWNER TO laravel;

--
-- Name: dict_phone_numbers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_phone_numbers_id_seq OWNED BY public.phone_numbers.id;


--
-- Name: dict_plumages; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_plumages (
    id bigint NOT NULL,
    eu_code character varying(2),
    abbr character varying(10),
    text_pl character varying(100),
    text_en character varying(100),
    is_active boolean NOT NULL,
    is_default boolean NOT NULL,
    sort_order integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.dict_plumages OWNER TO laravel;

--
-- Name: dict_plumages_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_plumages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_plumages_id_seq OWNER TO laravel;

--
-- Name: dict_plumages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_plumages_id_seq OWNED BY public.dict_plumages.id;


--
-- Name: dict_provinces; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_provinces (
    id bigint NOT NULL,
    eu_code character varying(2),
    country_id bigint NOT NULL,
    description character varying(100),
    date_1 date,
    date_2 date,
    is_active boolean NOT NULL,
    is_default boolean NOT NULL,
    sort_order integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.dict_provinces OWNER TO laravel;

--
-- Name: dict_provinces_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_provinces_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_provinces_id_seq OWNER TO laravel;

--
-- Name: dict_provinces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_provinces_id_seq OWNED BY public.dict_provinces.id;


--
-- Name: dict_ring_placements; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_ring_placements (
    id bigint NOT NULL,
    eu_code character varying(2),
    abbr character varying(10),
    text_pl character varying(100),
    text_en character varying(100),
    is_active boolean NOT NULL,
    sort_order integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.dict_ring_placements OWNER TO laravel;

--
-- Name: dict_ring_placements_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_ring_placements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_ring_placements_id_seq OWNER TO laravel;

--
-- Name: dict_ring_placements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_ring_placements_id_seq OWNED BY public.dict_ring_placements.id;


--
-- Name: dict_ring_statuses; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_ring_statuses (
    id bigint NOT NULL,
    eu_code character varying(2),
    abbr character varying(10),
    text_pl character varying(100),
    text_en character varying(100),
    is_active boolean NOT NULL,
    is_default boolean NOT NULL,
    sort_order integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.dict_ring_statuses OWNER TO laravel;

--
-- Name: dict_ring_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_ring_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_ring_statuses_id_seq OWNER TO laravel;

--
-- Name: dict_ring_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_ring_statuses_id_seq OWNED BY public.dict_ring_statuses.id;


--
-- Name: dict_ring_stocks; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_ring_stocks (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    sort_order integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.dict_ring_stocks OWNER TO laravel;

--
-- Name: dict_ring_types; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_ring_types (
    id bigint NOT NULL,
    eu_code character varying(2),
    abbr character varying(10),
    text_pl character varying(100),
    text_en character varying(100),
    is_active boolean NOT NULL,
    is_default boolean NOT NULL,
    sort_order integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    is_stocked boolean DEFAULT true NOT NULL
);


ALTER TABLE public.dict_ring_types OWNER TO laravel;

--
-- Name: dict_ring_types_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_ring_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_ring_types_id_seq OWNER TO laravel;

--
-- Name: dict_ring_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_ring_types_id_seq OWNED BY public.dict_ring_types.id;


--
-- Name: dict_ring_verifications; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_ring_verifications (
    id bigint NOT NULL,
    eu_code character varying(2),
    abbr character varying(10),
    text_pl character varying(100),
    text_en character varying(100),
    is_active boolean NOT NULL,
    is_default boolean NOT NULL,
    sort_order integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.dict_ring_verifications OWNER TO laravel;

--
-- Name: dict_ring_verifications_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_ring_verifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_ring_verifications_id_seq OWNER TO laravel;

--
-- Name: dict_ring_verifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_ring_verifications_id_seq OWNED BY public.dict_ring_verifications.id;


--
-- Name: dict_scheme_countries; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_scheme_countries (
    id bigint NOT NULL,
    country_id integer NOT NULL,
    scheme_id integer NOT NULL,
    is_active boolean NOT NULL,
    is_default boolean NOT NULL,
    sort_order integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.dict_scheme_countries OWNER TO laravel;

--
-- Name: dict_scheme_countries_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_scheme_countries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_scheme_countries_id_seq OWNER TO laravel;

--
-- Name: dict_scheme_countries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_scheme_countries_id_seq OWNED BY public.dict_scheme_countries.id;


--
-- Name: dict_schemes; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_schemes (
    id bigint NOT NULL,
    scheme_code character varying(3),
    abbr character varying(100),
    text_pl character varying(100),
    text_en character varying(100),
    description character varying(100),
    email character varying(100),
    is_active boolean NOT NULL,
    is_default boolean NOT NULL,
    sort_order integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.dict_schemes OWNER TO laravel;

--
-- Name: dict_schemes_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_schemes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_schemes_id_seq OWNER TO laravel;

--
-- Name: dict_schemes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_schemes_id_seq OWNED BY public.dict_schemes.id;


--
-- Name: dict_sexes; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_sexes (
    id bigint NOT NULL,
    eu_code character varying(2),
    abbr character varying(10),
    text_pl character varying(100),
    text_en character varying(100),
    is_active boolean NOT NULL,
    is_default boolean NOT NULL,
    sort_order integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.dict_sexes OWNER TO laravel;

--
-- Name: dict_sexes_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_sexes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_sexes_id_seq OWNER TO laravel;

--
-- Name: dict_sexes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_sexes_id_seq OWNED BY public.dict_sexes.id;


--
-- Name: dict_sighting_amendment_statuses; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_sighting_amendment_statuses (
    id bigint NOT NULL,
    description character varying(500) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.dict_sighting_amendment_statuses OWNER TO laravel;

--
-- Name: dict_sighting_amendment_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_sighting_amendment_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_sighting_amendment_statuses_id_seq OWNER TO laravel;

--
-- Name: dict_sighting_amendment_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_sighting_amendment_statuses_id_seq OWNED BY public.dict_sighting_amendment_statuses.id;


--
-- Name: dict_sighting_statuses; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_sighting_statuses (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.dict_sighting_statuses OWNER TO laravel;

--
-- Name: dict_sighting_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_sighting_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_sighting_statuses_id_seq OWNER TO laravel;

--
-- Name: dict_sighting_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_sighting_statuses_id_seq OWNED BY public.dict_sighting_statuses.id;


--
-- Name: dict_sighting_verification_types; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_sighting_verification_types (
    id bigint NOT NULL,
    key character varying(20) NOT NULL,
    text_pl character varying(500) NOT NULL,
    text_en character varying(500),
    final_status_id bigint,
    error_type character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT dict_sighting_verification_types_error_type_check CHECK (((error_type)::text = ANY ((ARRAY['ACCEPTABLE'::character varying, 'IMPORTANT_BUT_ACCEPTABLE'::character varying, 'UNACCEPTABLE'::character varying])::text[])))
);


ALTER TABLE public.dict_sighting_verification_types OWNER TO laravel;

--
-- Name: dict_sighting_verification_types_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_sighting_verification_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_sighting_verification_types_id_seq OWNER TO laravel;

--
-- Name: dict_sighting_verification_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_sighting_verification_types_id_seq OWNED BY public.dict_sighting_verification_types.id;


--
-- Name: dict_species; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_species (
    id bigint NOT NULL,
    eu_code character varying(10),
    abbr character varying(10),
    text_pl character varying(100),
    text_en character varying(100),
    text_la character varying(100),
    is_active boolean NOT NULL,
    is_default boolean NOT NULL,
    sort_order integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.dict_species OWNER TO laravel;

--
-- Name: dict_species_ages; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_species_ages (
    id bigint NOT NULL,
    species_id integer NOT NULL,
    age_id integer NOT NULL,
    month integer NOT NULL,
    is_active boolean NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.dict_species_ages OWNER TO laravel;

--
-- Name: dict_species_ages_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_species_ages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_species_ages_id_seq OWNER TO laravel;

--
-- Name: dict_species_ages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_species_ages_id_seq OWNED BY public.dict_species_ages.id;


--
-- Name: dict_species_dict_species_groups; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_species_dict_species_groups (
    species_group_id bigint,
    species_id bigint
);


ALTER TABLE public.dict_species_dict_species_groups OWNER TO laravel;

--
-- Name: dict_species_groups; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_species_groups (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.dict_species_groups OWNER TO laravel;

--
-- Name: dict_species_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_species_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_species_groups_id_seq OWNER TO laravel;

--
-- Name: dict_species_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_species_groups_id_seq OWNED BY public.dict_species_groups.id;


--
-- Name: dict_species_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_species_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_species_id_seq OWNER TO laravel;

--
-- Name: dict_species_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_species_id_seq OWNED BY public.dict_species.id;


--
-- Name: dict_species_pairs; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_species_pairs (
    species1_id integer NOT NULL,
    species2_id integer NOT NULL
);


ALTER TABLE public.dict_species_pairs OWNER TO laravel;

--
-- Name: dict_stock_operations; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_stock_operations (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    origin_stock_id bigint,
    target_stock_id bigint,
    is_active boolean DEFAULT true NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    is_correction boolean DEFAULT false
);


ALTER TABLE public.dict_stock_operations OWNER TO laravel;

--
-- Name: dict_stock_operations_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_stock_operations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_stock_operations_id_seq OWNER TO laravel;

--
-- Name: dict_stock_operations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_stock_operations_id_seq OWNED BY public.dict_stock_operations.id;


--
-- Name: dict_user_sighting_roles; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.dict_user_sighting_roles (
    id bigint NOT NULL,
    name character varying(50) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.dict_user_sighting_roles OWNER TO laravel;

--
-- Name: dict_user_sighting_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.dict_user_sighting_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dict_user_sighting_roles_id_seq OWNER TO laravel;

--
-- Name: dict_user_sighting_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.dict_user_sighting_roles_id_seq OWNED BY public.dict_user_sighting_roles.id;


--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO laravel;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.failed_jobs_id_seq OWNER TO laravel;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: files; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.files (
    id bigint NOT NULL,
    original_name character varying(100) NOT NULL,
    hash character varying(100) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    mime text,
    size bigint
);


ALTER TABLE public.files OWNER TO laravel;

--
-- Name: files_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.files_id_seq OWNER TO laravel;

--
-- Name: files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.files_id_seq OWNED BY public.files.id;


--
-- Name: image_thumbnails; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.image_thumbnails (
    id bigint NOT NULL,
    file_id bigint NOT NULL,
    original_file_id bigint NOT NULL,
    thumbnail_type character varying(50) NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.image_thumbnails OWNER TO laravel;

--
-- Name: image_thumbnails_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.image_thumbnails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.image_thumbnails_id_seq OWNER TO laravel;

--
-- Name: image_thumbnails_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.image_thumbnails_id_seq OWNED BY public.image_thumbnails.id;


--
-- Name: interesting_sightings; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.interesting_sightings (
    id bigint NOT NULL,
    sighting_id bigint NOT NULL,
    description text NOT NULL,
    created_by bigint,
    updated_by bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.interesting_sightings OWNER TO laravel;

--
-- Name: interesting_sightings_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.interesting_sightings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.interesting_sightings_id_seq OWNER TO laravel;

--
-- Name: interesting_sightings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.interesting_sightings_id_seq OWNED BY public.interesting_sightings.id;


--
-- Name: jobs; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL,
    unique_id character varying(255)
);


ALTER TABLE public.jobs OWNER TO laravel;

--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jobs_id_seq OWNER TO laravel;

--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.locations (
    id bigint NOT NULL,
    name character varying(100),
    abbr character varying(20),
    coordinates public.geography(Point,4326) NOT NULL,
    coordinate_accuracy_id bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    province_id bigint,
    country_id bigint,
    user_id bigint,
    is_in_user_registry boolean DEFAULT false NOT NULL,
    is_in_employee_registry boolean DEFAULT false NOT NULL,
    has_manually_edited_province_or_country boolean DEFAULT false NOT NULL,
    source character(1),
    is_from_gps boolean DEFAULT false NOT NULL,
    CONSTRAINT locations_source_check CHECK ((source = ANY (ARRAY['I'::bpchar, 'M'::bpchar, 'C'::bpchar])))
);


ALTER TABLE public.locations OWNER TO laravel;

--
-- Name: COLUMN locations.source; Type: COMMENT; Schema: public; Owner: laravel
--

COMMENT ON COLUMN public.locations.source IS 'I: import, M: mapa, C: ręcznie podane współrzędne (coordinates)';


--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.locations_id_seq OWNER TO laravel;

--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- Name: mail_templates; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.mail_templates (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    subject_pl character varying(255) NOT NULL,
    subject_en character varying(255) NOT NULL,
    content_pl character varying(2048) NOT NULL,
    content_en character varying(2048) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.mail_templates OWNER TO laravel;

--
-- Name: mail_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.mail_templates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mail_templates_id_seq OWNER TO laravel;

--
-- Name: mail_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.mail_templates_id_seq OWNED BY public.mail_templates.id;


--
-- Name: notification_variables; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.notification_variables (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description_pl character varying(255) NOT NULL,
    value_pl character varying(255),
    value_en character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    is_constant boolean DEFAULT true NOT NULL,
    custom_property character varying(255),
    description_en character varying(255),
    format_constraint character varying(255),
    variable_context character varying(255),
    sort_order integer DEFAULT 0 NOT NULL,
    CONSTRAINT notification_variables_format_constraint_check CHECK (((format_constraint)::text = ANY ((ARRAY['PDF'::character varying, 'EMAIL'::character varying, ''::character varying])::text[]))),
    CONSTRAINT notification_variables_variable_context_check CHECK (((variable_context)::text = ANY ((ARRAY['SIGHTING'::character varying, 'STOCK'::character varying, 'USER'::character varying, ''::character varying])::text[])))
);


ALTER TABLE public.notification_variables OWNER TO laravel;

--
-- Name: mail_variables_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.mail_variables_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mail_variables_id_seq OWNER TO laravel;

--
-- Name: mail_variables_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.mail_variables_id_seq OWNED BY public.notification_variables.id;


--
-- Name: measurements; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.measurements (
    id bigint NOT NULL,
    measurement_type_id bigint NOT NULL,
    sighting_id bigint NOT NULL,
    numeric_value double precision,
    text_value character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    is_direct boolean
);


ALTER TABLE public.measurements OWNER TO laravel;

--
-- Name: measurements_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.measurements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.measurements_id_seq OWNER TO laravel;

--
-- Name: measurements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.measurements_id_seq OWNED BY public.measurements.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO laravel;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO laravel;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: multiple_views; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.multiple_views (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    top_left character varying(255) NOT NULL,
    top_right character varying(255) NOT NULL,
    bottom_left character varying(255) NOT NULL,
    bottom_right character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.multiple_views OWNER TO laravel;

--
-- Name: multiple_views_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.multiple_views_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.multiple_views_id_seq OWNER TO laravel;

--
-- Name: multiple_views_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.multiple_views_id_seq OWNED BY public.multiple_views.id;


--
-- Name: notification_sightings; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.notification_sightings (
    id bigint NOT NULL,
    notification_id bigint NOT NULL,
    sighting_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.notification_sightings OWNER TO laravel;

--
-- Name: notification_sightings_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.notification_sightings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notification_sightings_id_seq OWNER TO laravel;

--
-- Name: notification_sightings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.notification_sightings_id_seq OWNED BY public.notification_sightings.id;


--
-- Name: notification_types; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.notification_types (
    id character varying(255) NOT NULL,
    mail_template_id bigint,
    mail_attachment_template_id bigint,
    pdf_template_id bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.notification_types OWNER TO laravel;

--
-- Name: notifications; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.notifications (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    notification_type_id character varying(255) NOT NULL,
    ring_id bigint,
    is_actual boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.notifications OWNER TO laravel;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_id_seq OWNER TO laravel;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: order_positions; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.order_positions (
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    ring_type_id bigint,
    stock_ring_type bigint,
    stock_ring_subtype bigint,
    amount integer NOT NULL,
    amount_processed integer NOT NULL,
    sort_order integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.order_positions OWNER TO laravel;

--
-- Name: order_positions_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.order_positions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_positions_id_seq OWNER TO laravel;

--
-- Name: order_positions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.order_positions_id_seq OWNED BY public.order_positions.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.orders (
    id bigint NOT NULL,
    ringer_id bigint NOT NULL,
    is_completed boolean NOT NULL,
    document_id bigint NOT NULL,
    employee_comments text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.orders OWNER TO laravel;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO laravel;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: password_resets; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.password_resets (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_resets OWNER TO laravel;

--
-- Name: pdf_templates; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.pdf_templates (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    filename_pl character varying(255) NOT NULL,
    filename_en character varying(255) NOT NULL,
    content_pl text NOT NULL,
    content_en text NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.pdf_templates OWNER TO laravel;

--
-- Name: pdf_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.pdf_templates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pdf_templates_id_seq OWNER TO laravel;

--
-- Name: pdf_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.pdf_templates_id_seq OWNED BY public.pdf_templates.id;


--
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.personal_access_tokens OWNER TO laravel;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personal_access_tokens_id_seq OWNER TO laravel;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- Name: producers; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.producers (
    id bigint NOT NULL,
    abbr character varying(20) NOT NULL,
    name character varying(100) NOT NULL,
    country character varying(100) NOT NULL,
    city character varying(100) NOT NULL,
    zip_code character varying(10) NOT NULL,
    address character varying(100) NOT NULL,
    tax_number character varying(20) NOT NULL,
    email character varying(50) NOT NULL,
    comments character varying(500) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    sort_order integer DEFAULT 0,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.producers OWNER TO laravel;

--
-- Name: record_changes; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.record_changes (
    id bigint NOT NULL,
    reference_table character varying(255) NOT NULL,
    reference_id bigint NOT NULL,
    user_id bigint,
    original_record jsonb,
    changed_fields jsonb,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.record_changes OWNER TO laravel;

--
-- Name: record_changes_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.record_changes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.record_changes_id_seq OWNER TO laravel;

--
-- Name: record_changes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.record_changes_id_seq OWNED BY public.record_changes.id;


--
-- Name: ring_sighting; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.ring_sighting (
    id bigint NOT NULL,
    ring_id bigint,
    sighting_id bigint,
    ring_status_id bigint,
    sort_order integer,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.ring_sighting OWNER TO laravel;

--
-- Name: ring_sighting_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.ring_sighting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ring_sighting_id_seq OWNER TO laravel;

--
-- Name: ring_sighting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.ring_sighting_id_seq OWNED BY public.ring_sighting.id;


--
-- Name: ring_stocks_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.ring_stocks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ring_stocks_id_seq OWNER TO laravel;

--
-- Name: ring_stocks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.ring_stocks_id_seq OWNED BY public.dict_ring_stocks.id;


--
-- Name: ringer_data; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.ringer_data (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    is_central boolean DEFAULT false NOT NULL,
    is_ringer_group boolean DEFAULT false NOT NULL,
    is_color_ringing_coordinator boolean DEFAULT false NOT NULL,
    identity_type character varying(255) NOT NULL,
    identity_number character varying(10) NOT NULL,
    pesel character varying(11) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT ringer_data_identity_type_check CHECK (((identity_type)::text = ANY ((ARRAY['ID_CARD'::character varying, 'PASSPORT'::character varying])::text[])))
);


ALTER TABLE public.ringer_data OWNER TO laravel;

--
-- Name: ringer_data_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.ringer_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ringer_data_id_seq OWNER TO laravel;

--
-- Name: ringer_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.ringer_data_id_seq OWNED BY public.ringer_data.id;


--
-- Name: rings; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.rings (
    id bigint NOT NULL,
    ring_type_id bigint,
    scheme_id bigint,
    number character varying(60),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    species_id bigint,
    color_id bigint,
    ringer_id bigint
);


ALTER TABLE public.rings OWNER TO laravel;

--
-- Name: rings_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.rings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rings_id_seq OWNER TO laravel;

--
-- Name: rings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.rings_id_seq OWNED BY public.rings.id;


--
-- Name: rings_in_stocks; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.rings_in_stocks (
    id bigint NOT NULL,
    ring_id bigint,
    stock_id bigint,
    supplier_id bigint,
    subtype_id bigint,
    purchase_price double precision,
    selling_price double precision,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.rings_in_stocks OWNER TO laravel;

--
-- Name: rings_in_stocks_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.rings_in_stocks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rings_in_stocks_id_seq OWNER TO laravel;

--
-- Name: rings_in_stocks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.rings_in_stocks_id_seq OWNED BY public.rings_in_stocks.id;


--
-- Name: sent_attachments; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.sent_attachments (
    id bigint NOT NULL,
    sent_notification_id bigint NOT NULL,
    content jsonb NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.sent_attachments OWNER TO laravel;

--
-- Name: sent_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.sent_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sent_attachments_id_seq OWNER TO laravel;

--
-- Name: sent_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.sent_attachments_id_seq OWNED BY public.sent_attachments.id;


--
-- Name: sent_notifications; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.sent_notifications (
    id bigint NOT NULL,
    notification_id bigint NOT NULL,
    session_id character varying(255) NOT NULL,
    content jsonb NOT NULL,
    sent_at timestamp(0) without time zone NOT NULL,
    message_type character varying(255) NOT NULL,
    is_successfully_sent boolean NOT NULL,
    error text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT sent_notifications_message_type_check CHECK (((message_type)::text = ANY ((ARRAY['MAIL'::character varying, 'PDF'::character varying])::text[])))
);


ALTER TABLE public.sent_notifications OWNER TO laravel;

--
-- Name: sent_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.sent_notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sent_notifications_id_seq OWNER TO laravel;

--
-- Name: sent_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.sent_notifications_id_seq OWNED BY public.sent_notifications.id;


--
-- Name: sighting_amendment_conversations; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.sighting_amendment_conversations (
    id bigint NOT NULL,
    text character varying(2000) NOT NULL,
    writer_id bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    sighting_amendment_id bigint NOT NULL
);


ALTER TABLE public.sighting_amendment_conversations OWNER TO laravel;

--
-- Name: sighting_amendment_conversations_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.sighting_amendment_conversations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sighting_amendment_conversations_id_seq OWNER TO laravel;

--
-- Name: sighting_amendment_conversations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.sighting_amendment_conversations_id_seq OWNED BY public.sighting_amendment_conversations.id;


--
-- Name: sighting_amendment_files; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.sighting_amendment_files (
    id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    sighting_amendment_id bigint NOT NULL,
    file_id bigint NOT NULL
);


ALTER TABLE public.sighting_amendment_files OWNER TO laravel;

--
-- Name: sighting_amendment_files_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.sighting_amendment_files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sighting_amendment_files_id_seq OWNER TO laravel;

--
-- Name: sighting_amendment_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.sighting_amendment_files_id_seq OWNED BY public.sighting_amendment_files.id;


--
-- Name: sighting_amendments; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.sighting_amendments (
    id bigint NOT NULL,
    number integer NOT NULL,
    sighting_id bigint,
    user_id bigint,
    station_id bigint,
    primary_sighting_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    status_id bigint NOT NULL
);


ALTER TABLE public.sighting_amendments OWNER TO laravel;

--
-- Name: sighting_amendments_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.sighting_amendments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sighting_amendments_id_seq OWNER TO laravel;

--
-- Name: sighting_amendments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.sighting_amendments_id_seq OWNED BY public.sighting_amendments.id;


--
-- Name: sighting_files; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.sighting_files (
    id bigint NOT NULL,
    sighting_id bigint NOT NULL,
    file_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.sighting_files OWNER TO laravel;

--
-- Name: sighting_files_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.sighting_files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sighting_files_id_seq OWNER TO laravel;

--
-- Name: sighting_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.sighting_files_id_seq OWNED BY public.sighting_files.id;


--
-- Name: sighting_import_errors; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.sighting_import_errors (
    id bigint NOT NULL,
    "row" integer,
    "column" character varying(100),
    error_message character varying(1000),
    sighting_import_id bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.sighting_import_errors OWNER TO laravel;

--
-- Name: sighting_import_errors_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.sighting_import_errors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sighting_import_errors_id_seq OWNER TO laravel;

--
-- Name: sighting_import_errors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.sighting_import_errors_id_seq OWNED BY public.sighting_import_errors.id;


--
-- Name: sighting_imports; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.sighting_imports (
    id bigint NOT NULL,
    number integer NOT NULL,
    date date NOT NULL,
    user_id bigint,
    sighting_count integer,
    error_type_1_count integer,
    error_type_2_count integer,
    stage smallint NOT NULL,
    type integer NOT NULL,
    gps_id character varying(50),
    species_id bigint,
    is_gps_shared boolean,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    file_id bigint
);


ALTER TABLE public.sighting_imports OWNER TO laravel;

--
-- Name: sighting_imports_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.sighting_imports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sighting_imports_id_seq OWNER TO laravel;

--
-- Name: sighting_imports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.sighting_imports_id_seq OWNED BY public.sighting_imports.id;


--
-- Name: sighting_rejection_reasons; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.sighting_rejection_reasons (
    id bigint NOT NULL,
    sighting_id bigint NOT NULL,
    rejection_reason character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.sighting_rejection_reasons OWNER TO laravel;

--
-- Name: sighting_rejection_reasons_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.sighting_rejection_reasons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sighting_rejection_reasons_id_seq OWNER TO laravel;

--
-- Name: sighting_rejection_reasons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.sighting_rejection_reasons_id_seq OWNED BY public.sighting_rejection_reasons.id;


--
-- Name: sighting_sighting_import; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.sighting_sighting_import (
    sighting_id bigint,
    sighting_import_id bigint
);


ALTER TABLE public.sighting_sighting_import OWNER TO laravel;

--
-- Name: sighting_user; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.sighting_user (
    id bigint NOT NULL,
    user_id bigint,
    sighting_id bigint,
    user_role_id bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.sighting_user OWNER TO laravel;

--
-- Name: sighting_user_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.sighting_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sighting_user_id_seq OWNER TO laravel;

--
-- Name: sighting_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.sighting_user_id_seq OWNED BY public.sighting_user.id;


--
-- Name: sighting_verifications; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.sighting_verifications (
    sighting_id bigint NOT NULL,
    critical boolean NOT NULL,
    name character varying(1000),
    ring_number1 character varying(100),
    ring_number2 character varying(100),
    accepted boolean,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    sighting_verification_type character varying(20),
    id bigint NOT NULL
);


ALTER TABLE public.sighting_verifications OWNER TO laravel;

--
-- Name: sighting_verifications_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.sighting_verifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sighting_verifications_id_seq OWNER TO laravel;

--
-- Name: sighting_verifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.sighting_verifications_id_seq OWNED BY public.sighting_verifications.id;


--
-- Name: sightings; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.sightings (
    id bigint NOT NULL,
    date date,
    hour smallint,
    minutes smallint,
    comments text,
    comments_hidden text,
    date_accuracy_id bigint,
    species_id bigint,
    species_by_scheme_id bigint,
    age_id bigint,
    age_by_scheme_id bigint,
    sex_id bigint,
    sex_by_scheme_id bigint,
    plumage_id bigint,
    condition_id bigint,
    circumstances_id bigint,
    circumstances_validation_id bigint,
    decoy_id bigint,
    capture_method_id bigint,
    sighting_status_id bigint,
    bird_status_id bigint,
    bird_displacement_id bigint,
    bird_manipulation_id bigint,
    bird_birth_accuracy_id bigint,
    ring_verification_id bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    location_id bigint,
    created_by bigint,
    updated_by bigint,
    primary_sighting_id bigint,
    is_shown_on_public_map boolean DEFAULT true,
    is_virtual boolean DEFAULT false NOT NULL,
    species_description text,
    is_info_from_third_party boolean DEFAULT false NOT NULL,
    is_in_progress boolean DEFAULT false,
    other_finders text,
    parent_ring_number character varying(255),
    pullus_number integer,
    pullus_age_accuracy_id bigint,
    pullus_age smallint,
    unread_ring boolean,
    family_ring_number character varying(255)
);


ALTER TABLE public.sightings OWNER TO laravel;

--
-- Name: sightings_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.sightings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sightings_id_seq OWNER TO laravel;

--
-- Name: sightings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.sightings_id_seq OWNED BY public.sightings.id;


--
-- Name: static_notification_variables; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.static_notification_variables (
    id character varying(255) NOT NULL,
    namespace character varying(255),
    notification_format character varying(255),
    variable_context character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT static_notification_variables_namespace_check CHECK (((namespace)::text = ANY ((ARRAY['SELECTED'::character varying, 'PRIMARY'::character varying, 'RINGS'::character varying, 'OTHER_SIGHTINGS'::character varying, ''::character varying])::text[]))),
    CONSTRAINT static_notification_variables_notification_format_check CHECK (((notification_format)::text = ANY ((ARRAY['PDF'::character varying, 'EMAIL'::character varying, ''::character varying])::text[]))),
    CONSTRAINT static_notification_variables_variable_context_check CHECK (((variable_context)::text = ANY ((ARRAY['SIGHTING'::character varying, 'STOCK'::character varying, 'USER'::character varying, ''::character varying])::text[])))
);


ALTER TABLE public.static_notification_variables OWNER TO laravel;

--
-- Name: stock_document_position_rings_in_stocks; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.stock_document_position_rings_in_stocks (
    id bigint NOT NULL,
    rings_in_stock_id bigint NOT NULL,
    stock_document_position_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.stock_document_position_rings_in_stocks OWNER TO laravel;

--
-- Name: stock_document_position_rings_in_stocks_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.stock_document_position_rings_in_stocks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stock_document_position_rings_in_stocks_id_seq OWNER TO laravel;

--
-- Name: stock_document_position_rings_in_stocks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.stock_document_position_rings_in_stocks_id_seq OWNED BY public.stock_document_position_rings_in_stocks.id;


--
-- Name: stock_document_positions; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.stock_document_positions (
    id bigint NOT NULL,
    stock_document_id bigint NOT NULL,
    sort_order integer NOT NULL,
    series character varying(10),
    ring_numbers_from integer,
    ring_numbers_to integer,
    ring_type_id bigint,
    ring_subtype_id bigint,
    comments character varying(500),
    purchase_price double precision,
    selling_price double precision,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    ring_amount integer,
    dict_ring_type_id bigint,
    species_id bigint
);


ALTER TABLE public.stock_document_positions OWNER TO laravel;

--
-- Name: stock_document_positions_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.stock_document_positions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stock_document_positions_id_seq OWNER TO laravel;

--
-- Name: stock_document_positions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.stock_document_positions_id_seq OWNED BY public.stock_document_positions.id;


--
-- Name: stock_documents; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.stock_documents (
    id bigint NOT NULL,
    date date NOT NULL,
    index integer NOT NULL,
    deadline date,
    deleted_at timestamp(0) without time zone,
    comments character varying(500),
    stock_operation_id bigint NOT NULL,
    supplier_id bigint,
    bound_ringer_id bigint,
    transfer_ringer_id bigint,
    created_by bigint NOT NULL,
    updated_by bigint,
    deleted_by bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    was_corrected boolean DEFAULT false NOT NULL
);


ALTER TABLE public.stock_documents OWNER TO laravel;

--
-- Name: stock_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.stock_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stock_documents_id_seq OWNER TO laravel;

--
-- Name: stock_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.stock_documents_id_seq OWNED BY public.stock_documents.id;


--
-- Name: stock_ring_subtypes; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.stock_ring_subtypes (
    id bigint NOT NULL,
    type_id bigint,
    name character varying(5) NOT NULL,
    thickness double precision NOT NULL,
    height double precision NOT NULL,
    width double precision NOT NULL,
    material character varying(10) NOT NULL,
    description character varying(100) NOT NULL,
    purchase_price double precision NOT NULL,
    selling_price double precision NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    sort_order integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.stock_ring_subtypes OWNER TO laravel;

--
-- Name: stock_ring_subtypes_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.stock_ring_subtypes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stock_ring_subtypes_id_seq OWNER TO laravel;

--
-- Name: stock_ring_subtypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.stock_ring_subtypes_id_seq OWNED BY public.stock_ring_subtypes.id;


--
-- Name: stock_ring_types; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.stock_ring_types (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    sort_order integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.stock_ring_types OWNER TO laravel;

--
-- Name: stock_ring_types_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.stock_ring_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stock_ring_types_id_seq OWNER TO laravel;

--
-- Name: stock_ring_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.stock_ring_types_id_seq OWNED BY public.stock_ring_types.id;


--
-- Name: suppliers_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.suppliers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.suppliers_id_seq OWNER TO laravel;

--
-- Name: suppliers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.suppliers_id_seq OWNED BY public.producers.id;


--
-- Name: support_texts; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.support_texts (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    content_pl character varying(32768) NOT NULL,
    is_visible_to_guest boolean NOT NULL,
    is_visible_to_user boolean NOT NULL,
    is_visible_to_ringer boolean NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    video_url character varying(255),
    sort_order integer DEFAULT 0 NOT NULL,
    content_en character varying(32768)
);


ALTER TABLE public.support_texts OWNER TO laravel;

--
-- Name: support_texts_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.support_texts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.support_texts_id_seq OWNER TO laravel;

--
-- Name: support_texts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.support_texts_id_seq OWNED BY public.support_texts.id;


--
-- Name: system_messages; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.system_messages (
    id bigint NOT NULL,
    type character varying(255) NOT NULL,
    date_from date NOT NULL,
    date_to date NOT NULL,
    retry_interval_in_minutes integer NOT NULL,
    content_pl character varying(2048) NOT NULL,
    content_en character varying(2048) NOT NULL,
    is_visible_to_guest boolean NOT NULL,
    is_visible_to_user boolean NOT NULL,
    is_visible_to_ringer boolean NOT NULL,
    is_active boolean NOT NULL,
    created_by bigint,
    updated_by bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT system_messages_type_check CHECK (((type)::text = ANY ((ARRAY['INFO'::character varying, 'SUCCESS'::character varying, 'WARNING'::character varying, 'DANGER'::character varying])::text[])))
);


ALTER TABLE public.system_messages OWNER TO laravel;

--
-- Name: system_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.system_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.system_messages_id_seq OWNER TO laravel;

--
-- Name: system_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.system_messages_id_seq OWNED BY public.system_messages.id;


--
-- Name: user_verification_tokens; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.user_verification_tokens (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    token character varying(255) NOT NULL
);


ALTER TABLE public.user_verification_tokens OWNER TO laravel;

--
-- Name: user_verification_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.user_verification_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_verification_tokens_id_seq OWNER TO laravel;

--
-- Name: user_verification_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.user_verification_tokens_id_seq OWNED BY public.user_verification_tokens.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: laravel
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255),
    email character varying(255),
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    first_name character varying(255),
    last_name character varying(255),
    language character varying(2),
    subscription_active boolean DEFAULT false NOT NULL,
    hide_personal_data boolean DEFAULT false NOT NULL,
    role character varying(255) DEFAULT 'REGISTERED_USER'::character varying NOT NULL,
    home_page character varying(255) DEFAULT 'MAIN'::character varying NOT NULL,
    personal_title_id bigint,
    blocked boolean DEFAULT false NOT NULL,
    active boolean DEFAULT true NOT NULL,
    additional_information character varying(200),
    deleted_at timestamp(0) without time zone,
    CONSTRAINT users_home_page_check CHECK (((home_page)::text = ANY ((ARRAY['MAIN'::character varying, 'MY_SIGHTINGS'::character varying, 'NEW_SIGHTING'::character varying, 'MY_BIRDS'::character varying])::text[]))),
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['ADMIN'::character varying, 'EMPLOYEE'::character varying, 'REGISTERED_USER'::character varying, 'RINGER'::character varying, 'GUEST'::character varying, 'UNREGISTERED_USER'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO laravel;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: laravel
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO laravel;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: laravel
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: v_users_sightings; Type: VIEW; Schema: public; Owner: laravel
--

CREATE VIEW public.v_users_sightings AS
 SELECT sighting_user.user_id,
    sighting_user.sighting_id,
    s.primary_sighting_id,
    'direct'::text AS connection_type,
    dusr.name AS description
   FROM ((public.sighting_user
     JOIN public.dict_user_sighting_roles dusr ON ((dusr.id = sighting_user.user_role_id)))
     JOIN public.sightings s ON ((sighting_user.sighting_id = s.id)))
UNION ALL
 SELECT sightings.created_by AS user_id,
    sightings.id AS sighting_id,
    sightings.primary_sighting_id,
    'indirect'::text AS connection_type,
    'Author'::character varying AS description
   FROM public.sightings
UNION ALL
 SELECT sightings.updated_by AS user_id,
    sightings.id AS sighting_id,
    sightings.primary_sighting_id,
    'indirect'::text AS connection_type,
    'Editor'::character varying AS description
   FROM public.sightings;


ALTER TABLE public.v_users_sightings OWNER TO laravel;

--
-- Name: addresses id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.addresses ALTER COLUMN id SET DEFAULT nextval('public.addresses_id_seq'::regclass);


--
-- Name: application_configurations id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.application_configurations ALTER COLUMN id SET DEFAULT nextval('public.application_configurations_id_seq'::regclass);


--
-- Name: bird_family_sightings_rings id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.bird_family_sightings_rings ALTER COLUMN id SET DEFAULT nextval('public.bird_family_sightings_rings_id_seq'::regclass);


--
-- Name: data_sharing_requesters id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.data_sharing_requesters ALTER COLUMN id SET DEFAULT nextval('public.applicants_id_seq'::regclass);


--
-- Name: data_sharing_requests id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.data_sharing_requests ALTER COLUMN id SET DEFAULT nextval('public.applications_id_seq'::regclass);


--
-- Name: dict_ages id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_ages ALTER COLUMN id SET DEFAULT nextval('public.dict_ages_id_seq'::regclass);


--
-- Name: dict_areas id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_areas ALTER COLUMN id SET DEFAULT nextval('public.dict_areas_id_seq'::regclass);


--
-- Name: dict_bird_birth_accuracies id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_bird_birth_accuracies ALTER COLUMN id SET DEFAULT nextval('public.dict_bird_birth_accuracies_id_seq'::regclass);


--
-- Name: dict_bird_displacements id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_bird_displacements ALTER COLUMN id SET DEFAULT nextval('public.dict_bird_displacements_id_seq'::regclass);


--
-- Name: dict_bird_manipulations id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_bird_manipulations ALTER COLUMN id SET DEFAULT nextval('public.dict_bird_manipulations_id_seq'::regclass);


--
-- Name: dict_bird_statuses id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_bird_statuses ALTER COLUMN id SET DEFAULT nextval('public.dict_bird_statuses_id_seq'::regclass);


--
-- Name: dict_capture_methods id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_capture_methods ALTER COLUMN id SET DEFAULT nextval('public.dict_capture_methods_id_seq'::regclass);


--
-- Name: dict_circumstances id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_circumstances ALTER COLUMN id SET DEFAULT nextval('public.dict_circumstances_id_seq'::regclass);


--
-- Name: dict_circumstances_validations id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_circumstances_validations ALTER COLUMN id SET DEFAULT nextval('public.dict_circumstances_validations_id_seq'::regclass);


--
-- Name: dict_colors id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_colors ALTER COLUMN id SET DEFAULT nextval('public.dict_colors_id_seq'::regclass);


--
-- Name: dict_conditions id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_conditions ALTER COLUMN id SET DEFAULT nextval('public.dict_conditions_id_seq'::regclass);


--
-- Name: dict_coordinate_accuracies id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_coordinate_accuracies ALTER COLUMN id SET DEFAULT nextval('public.dict_coordinate_accuracies_id_seq'::regclass);


--
-- Name: dict_countries id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_countries ALTER COLUMN id SET DEFAULT nextval('public.dict_countries_id_seq'::regclass);


--
-- Name: dict_date_accuracies id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_date_accuracies ALTER COLUMN id SET DEFAULT nextval('public.dict_date_accuracies_id_seq'::regclass);


--
-- Name: dict_decoys id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_decoys ALTER COLUMN id SET DEFAULT nextval('public.dict_decoys_id_seq'::regclass);


--
-- Name: dict_gis id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_gis ALTER COLUMN id SET DEFAULT nextval('public.dict_gis_id_seq'::regclass);


--
-- Name: dict_measurement_types id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_measurement_types ALTER COLUMN id SET DEFAULT nextval('public.dict_measurement_types_id_seq'::regclass);


--
-- Name: dict_personal_titles id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_personal_titles ALTER COLUMN id SET DEFAULT nextval('public.dict_personal_titles_id_seq'::regclass);


--
-- Name: dict_plumages id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_plumages ALTER COLUMN id SET DEFAULT nextval('public.dict_plumages_id_seq'::regclass);


--
-- Name: dict_provinces id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_provinces ALTER COLUMN id SET DEFAULT nextval('public.dict_provinces_id_seq'::regclass);


--
-- Name: dict_ring_placements id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_ring_placements ALTER COLUMN id SET DEFAULT nextval('public.dict_ring_placements_id_seq'::regclass);


--
-- Name: dict_ring_statuses id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_ring_statuses ALTER COLUMN id SET DEFAULT nextval('public.dict_ring_statuses_id_seq'::regclass);


--
-- Name: dict_ring_stocks id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_ring_stocks ALTER COLUMN id SET DEFAULT nextval('public.ring_stocks_id_seq'::regclass);


--
-- Name: dict_ring_types id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_ring_types ALTER COLUMN id SET DEFAULT nextval('public.dict_ring_types_id_seq'::regclass);


--
-- Name: dict_ring_verifications id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_ring_verifications ALTER COLUMN id SET DEFAULT nextval('public.dict_ring_verifications_id_seq'::regclass);


--
-- Name: dict_scheme_countries id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_scheme_countries ALTER COLUMN id SET DEFAULT nextval('public.dict_scheme_countries_id_seq'::regclass);


--
-- Name: dict_schemes id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_schemes ALTER COLUMN id SET DEFAULT nextval('public.dict_schemes_id_seq'::regclass);


--
-- Name: dict_sexes id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_sexes ALTER COLUMN id SET DEFAULT nextval('public.dict_sexes_id_seq'::regclass);


--
-- Name: dict_sighting_amendment_statuses id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_sighting_amendment_statuses ALTER COLUMN id SET DEFAULT nextval('public.dict_sighting_amendment_statuses_id_seq'::regclass);


--
-- Name: dict_sighting_statuses id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_sighting_statuses ALTER COLUMN id SET DEFAULT nextval('public.dict_sighting_statuses_id_seq'::regclass);


--
-- Name: dict_sighting_verification_types id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_sighting_verification_types ALTER COLUMN id SET DEFAULT nextval('public.dict_sighting_verification_types_id_seq'::regclass);


--
-- Name: dict_species id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_species ALTER COLUMN id SET DEFAULT nextval('public.dict_species_id_seq'::regclass);


--
-- Name: dict_species_ages id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_species_ages ALTER COLUMN id SET DEFAULT nextval('public.dict_species_ages_id_seq'::regclass);


--
-- Name: dict_species_groups id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_species_groups ALTER COLUMN id SET DEFAULT nextval('public.dict_species_groups_id_seq'::regclass);


--
-- Name: dict_stock_operations id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_stock_operations ALTER COLUMN id SET DEFAULT nextval('public.dict_stock_operations_id_seq'::regclass);


--
-- Name: dict_user_sighting_roles id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_user_sighting_roles ALTER COLUMN id SET DEFAULT nextval('public.dict_user_sighting_roles_id_seq'::regclass);


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: files id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.files ALTER COLUMN id SET DEFAULT nextval('public.files_id_seq'::regclass);


--
-- Name: image_thumbnails id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.image_thumbnails ALTER COLUMN id SET DEFAULT nextval('public.image_thumbnails_id_seq'::regclass);


--
-- Name: interesting_sightings id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.interesting_sightings ALTER COLUMN id SET DEFAULT nextval('public.interesting_sightings_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- Name: mail_templates id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.mail_templates ALTER COLUMN id SET DEFAULT nextval('public.mail_templates_id_seq'::regclass);


--
-- Name: measurements id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.measurements ALTER COLUMN id SET DEFAULT nextval('public.measurements_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: multiple_views id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.multiple_views ALTER COLUMN id SET DEFAULT nextval('public.multiple_views_id_seq'::regclass);


--
-- Name: notification_sightings id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.notification_sightings ALTER COLUMN id SET DEFAULT nextval('public.notification_sightings_id_seq'::regclass);


--
-- Name: notification_variables id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.notification_variables ALTER COLUMN id SET DEFAULT nextval('public.mail_variables_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: order_positions id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.order_positions ALTER COLUMN id SET DEFAULT nextval('public.order_positions_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: pdf_templates id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.pdf_templates ALTER COLUMN id SET DEFAULT nextval('public.pdf_templates_id_seq'::regclass);


--
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- Name: phone_numbers id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.phone_numbers ALTER COLUMN id SET DEFAULT nextval('public.dict_phone_numbers_id_seq'::regclass);


--
-- Name: producers id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.producers ALTER COLUMN id SET DEFAULT nextval('public.suppliers_id_seq'::regclass);


--
-- Name: record_changes id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.record_changes ALTER COLUMN id SET DEFAULT nextval('public.record_changes_id_seq'::regclass);


--
-- Name: ring_sighting id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.ring_sighting ALTER COLUMN id SET DEFAULT nextval('public.ring_sighting_id_seq'::regclass);


--
-- Name: ringer_data id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.ringer_data ALTER COLUMN id SET DEFAULT nextval('public.ringer_data_id_seq'::regclass);


--
-- Name: rings id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.rings ALTER COLUMN id SET DEFAULT nextval('public.rings_id_seq'::regclass);


--
-- Name: rings_in_stocks id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.rings_in_stocks ALTER COLUMN id SET DEFAULT nextval('public.rings_in_stocks_id_seq'::regclass);


--
-- Name: sent_attachments id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sent_attachments ALTER COLUMN id SET DEFAULT nextval('public.sent_attachments_id_seq'::regclass);


--
-- Name: sent_notifications id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sent_notifications ALTER COLUMN id SET DEFAULT nextval('public.sent_notifications_id_seq'::regclass);


--
-- Name: sighting_amendment_conversations id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_amendment_conversations ALTER COLUMN id SET DEFAULT nextval('public.sighting_amendment_conversations_id_seq'::regclass);


--
-- Name: sighting_amendment_files id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_amendment_files ALTER COLUMN id SET DEFAULT nextval('public.sighting_amendment_files_id_seq'::regclass);


--
-- Name: sighting_amendments id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_amendments ALTER COLUMN id SET DEFAULT nextval('public.sighting_amendments_id_seq'::regclass);


--
-- Name: sighting_files id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_files ALTER COLUMN id SET DEFAULT nextval('public.sighting_files_id_seq'::regclass);


--
-- Name: sighting_import_errors id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_import_errors ALTER COLUMN id SET DEFAULT nextval('public.sighting_import_errors_id_seq'::regclass);


--
-- Name: sighting_imports id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_imports ALTER COLUMN id SET DEFAULT nextval('public.sighting_imports_id_seq'::regclass);


--
-- Name: sighting_rejection_reasons id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_rejection_reasons ALTER COLUMN id SET DEFAULT nextval('public.sighting_rejection_reasons_id_seq'::regclass);


--
-- Name: sighting_user id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_user ALTER COLUMN id SET DEFAULT nextval('public.sighting_user_id_seq'::regclass);


--
-- Name: sighting_verifications id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_verifications ALTER COLUMN id SET DEFAULT nextval('public.sighting_verifications_id_seq'::regclass);


--
-- Name: sightings id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sightings ALTER COLUMN id SET DEFAULT nextval('public.sightings_id_seq'::regclass);


--
-- Name: stock_document_position_rings_in_stocks id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.stock_document_position_rings_in_stocks ALTER COLUMN id SET DEFAULT nextval('public.stock_document_position_rings_in_stocks_id_seq'::regclass);


--
-- Name: stock_document_positions id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.stock_document_positions ALTER COLUMN id SET DEFAULT nextval('public.stock_document_positions_id_seq'::regclass);


--
-- Name: stock_documents id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.stock_documents ALTER COLUMN id SET DEFAULT nextval('public.stock_documents_id_seq'::regclass);


--
-- Name: stock_ring_subtypes id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.stock_ring_subtypes ALTER COLUMN id SET DEFAULT nextval('public.stock_ring_subtypes_id_seq'::regclass);


--
-- Name: stock_ring_types id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.stock_ring_types ALTER COLUMN id SET DEFAULT nextval('public.stock_ring_types_id_seq'::regclass);


--
-- Name: support_texts id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.support_texts ALTER COLUMN id SET DEFAULT nextval('public.support_texts_id_seq'::regclass);


--
-- Name: system_messages id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.system_messages ALTER COLUMN id SET DEFAULT nextval('public.system_messages_id_seq'::regclass);


--
-- Name: user_verification_tokens id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.user_verification_tokens ALTER COLUMN id SET DEFAULT nextval('public.user_verification_tokens_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: data_sharing_requesters applicants_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.data_sharing_requesters
    ADD CONSTRAINT applicants_pkey PRIMARY KEY (id);


--
-- Name: application_configurations application_configurations_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.application_configurations
    ADD CONSTRAINT application_configurations_pkey PRIMARY KEY (id);


--
-- Name: data_sharing_requests applications_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.data_sharing_requests
    ADD CONSTRAINT applications_pkey PRIMARY KEY (id);


--
-- Name: bird_family_sightings_rings bird_family_sightings_rings_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.bird_family_sightings_rings
    ADD CONSTRAINT bird_family_sightings_rings_pkey PRIMARY KEY (id);


--
-- Name: dict_ages dict_ages_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_ages
    ADD CONSTRAINT dict_ages_pkey PRIMARY KEY (id);


--
-- Name: dict_areas dict_areas_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_areas
    ADD CONSTRAINT dict_areas_pkey PRIMARY KEY (id);


--
-- Name: dict_bird_birth_accuracies dict_bird_birth_accuracies_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_bird_birth_accuracies
    ADD CONSTRAINT dict_bird_birth_accuracies_pkey PRIMARY KEY (id);


--
-- Name: dict_bird_displacements dict_bird_displacements_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_bird_displacements
    ADD CONSTRAINT dict_bird_displacements_pkey PRIMARY KEY (id);


--
-- Name: dict_bird_manipulations dict_bird_manipulations_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_bird_manipulations
    ADD CONSTRAINT dict_bird_manipulations_pkey PRIMARY KEY (id);


--
-- Name: dict_bird_statuses dict_bird_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_bird_statuses
    ADD CONSTRAINT dict_bird_statuses_pkey PRIMARY KEY (id);


--
-- Name: dict_capture_methods dict_capture_methods_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_capture_methods
    ADD CONSTRAINT dict_capture_methods_pkey PRIMARY KEY (id);


--
-- Name: dict_circumstances dict_circumstances_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_circumstances
    ADD CONSTRAINT dict_circumstances_pkey PRIMARY KEY (id);


--
-- Name: dict_circumstances_validations dict_circumstances_validations_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_circumstances_validations
    ADD CONSTRAINT dict_circumstances_validations_pkey PRIMARY KEY (id);


--
-- Name: dict_colors dict_colors_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_colors
    ADD CONSTRAINT dict_colors_pkey PRIMARY KEY (id);


--
-- Name: dict_conditions dict_conditions_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_conditions
    ADD CONSTRAINT dict_conditions_pkey PRIMARY KEY (id);


--
-- Name: dict_coordinate_accuracies dict_coordinate_accuracies_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_coordinate_accuracies
    ADD CONSTRAINT dict_coordinate_accuracies_pkey PRIMARY KEY (id);


--
-- Name: dict_countries dict_countries_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_countries
    ADD CONSTRAINT dict_countries_pkey PRIMARY KEY (id);


--
-- Name: dict_date_accuracies dict_date_accuracies_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_date_accuracies
    ADD CONSTRAINT dict_date_accuracies_pkey PRIMARY KEY (id);


--
-- Name: dict_decoys dict_decoys_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_decoys
    ADD CONSTRAINT dict_decoys_pkey PRIMARY KEY (id);


--
-- Name: dict_gis dict_gis_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_gis
    ADD CONSTRAINT dict_gis_pkey PRIMARY KEY (id);


--
-- Name: dict_measurement_types dict_measurement_types_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_measurement_types
    ADD CONSTRAINT dict_measurement_types_pkey PRIMARY KEY (id);


--
-- Name: dict_personal_titles dict_personal_titles_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_personal_titles
    ADD CONSTRAINT dict_personal_titles_pkey PRIMARY KEY (id);


--
-- Name: phone_numbers dict_phone_numbers_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.phone_numbers
    ADD CONSTRAINT dict_phone_numbers_pkey PRIMARY KEY (id);


--
-- Name: dict_plumages dict_plumages_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_plumages
    ADD CONSTRAINT dict_plumages_pkey PRIMARY KEY (id);


--
-- Name: dict_provinces dict_provinces_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_provinces
    ADD CONSTRAINT dict_provinces_pkey PRIMARY KEY (id);


--
-- Name: dict_ring_placements dict_ring_placements_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_ring_placements
    ADD CONSTRAINT dict_ring_placements_pkey PRIMARY KEY (id);


--
-- Name: dict_ring_statuses dict_ring_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_ring_statuses
    ADD CONSTRAINT dict_ring_statuses_pkey PRIMARY KEY (id);


--
-- Name: dict_ring_types dict_ring_types_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_ring_types
    ADD CONSTRAINT dict_ring_types_pkey PRIMARY KEY (id);


--
-- Name: dict_ring_verifications dict_ring_verifications_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_ring_verifications
    ADD CONSTRAINT dict_ring_verifications_pkey PRIMARY KEY (id);


--
-- Name: dict_scheme_countries dict_scheme_countries_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_scheme_countries
    ADD CONSTRAINT dict_scheme_countries_pkey PRIMARY KEY (id);


--
-- Name: dict_schemes dict_schemes_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_schemes
    ADD CONSTRAINT dict_schemes_pkey PRIMARY KEY (id);


--
-- Name: dict_sexes dict_sexes_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_sexes
    ADD CONSTRAINT dict_sexes_pkey PRIMARY KEY (id);


--
-- Name: dict_sighting_amendment_statuses dict_sighting_amendment_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_sighting_amendment_statuses
    ADD CONSTRAINT dict_sighting_amendment_statuses_pkey PRIMARY KEY (id);


--
-- Name: dict_sighting_statuses dict_sighting_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_sighting_statuses
    ADD CONSTRAINT dict_sighting_statuses_pkey PRIMARY KEY (id);


--
-- Name: dict_sighting_verification_types dict_sighting_verification_types_key_unique; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_sighting_verification_types
    ADD CONSTRAINT dict_sighting_verification_types_key_unique UNIQUE (key);


--
-- Name: dict_sighting_verification_types dict_sighting_verification_types_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_sighting_verification_types
    ADD CONSTRAINT dict_sighting_verification_types_pkey PRIMARY KEY (id);


--
-- Name: dict_species_ages dict_species_ages_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_species_ages
    ADD CONSTRAINT dict_species_ages_pkey PRIMARY KEY (id);


--
-- Name: dict_species_groups dict_species_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_species_groups
    ADD CONSTRAINT dict_species_groups_pkey PRIMARY KEY (id);


--
-- Name: dict_species dict_species_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_species
    ADD CONSTRAINT dict_species_pkey PRIMARY KEY (id);


--
-- Name: dict_stock_operations dict_stock_operations_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_stock_operations
    ADD CONSTRAINT dict_stock_operations_pkey PRIMARY KEY (id);


--
-- Name: dict_user_sighting_roles dict_user_sighting_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_user_sighting_roles
    ADD CONSTRAINT dict_user_sighting_roles_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: files files_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);


--
-- Name: image_thumbnails image_thumbnails_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.image_thumbnails
    ADD CONSTRAINT image_thumbnails_pkey PRIMARY KEY (id);


--
-- Name: interesting_sightings interesting_sightings_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.interesting_sightings
    ADD CONSTRAINT interesting_sightings_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_queue_unique_id_unique; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_queue_unique_id_unique UNIQUE (queue, unique_id);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: mail_templates mail_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.mail_templates
    ADD CONSTRAINT mail_templates_pkey PRIMARY KEY (id);


--
-- Name: notification_variables mail_variables_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.notification_variables
    ADD CONSTRAINT mail_variables_pkey PRIMARY KEY (id);


--
-- Name: measurements measurements_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.measurements
    ADD CONSTRAINT measurements_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: multiple_views multiple_views_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.multiple_views
    ADD CONSTRAINT multiple_views_pkey PRIMARY KEY (id);


--
-- Name: notification_sightings notification_sightings_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.notification_sightings
    ADD CONSTRAINT notification_sightings_pkey PRIMARY KEY (id);


--
-- Name: notification_types notification_types_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.notification_types
    ADD CONSTRAINT notification_types_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: order_positions order_positions_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.order_positions
    ADD CONSTRAINT order_positions_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: pdf_templates pdf_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.pdf_templates
    ADD CONSTRAINT pdf_templates_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- Name: record_changes record_changes_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.record_changes
    ADD CONSTRAINT record_changes_pkey PRIMARY KEY (id);


--
-- Name: ring_sighting ring_sighting_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.ring_sighting
    ADD CONSTRAINT ring_sighting_pkey PRIMARY KEY (id);


--
-- Name: ring_sighting ring_sighting_ring_id_sighting_id_ring_status_id_unique; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.ring_sighting
    ADD CONSTRAINT ring_sighting_ring_id_sighting_id_ring_status_id_unique UNIQUE (ring_id, sighting_id, ring_status_id);


--
-- Name: dict_ring_stocks ring_stocks_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_ring_stocks
    ADD CONSTRAINT ring_stocks_pkey PRIMARY KEY (id);


--
-- Name: ringer_data ringer_data_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.ringer_data
    ADD CONSTRAINT ringer_data_pkey PRIMARY KEY (id);


--
-- Name: rings_in_stocks rings_in_stocks_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.rings_in_stocks
    ADD CONSTRAINT rings_in_stocks_pkey PRIMARY KEY (id);


--
-- Name: rings rings_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.rings
    ADD CONSTRAINT rings_pkey PRIMARY KEY (id);


--
-- Name: sent_attachments sent_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sent_attachments
    ADD CONSTRAINT sent_attachments_pkey PRIMARY KEY (id);


--
-- Name: sent_notifications sent_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sent_notifications
    ADD CONSTRAINT sent_notifications_pkey PRIMARY KEY (id);


--
-- Name: sighting_amendment_conversations sighting_amendment_conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_amendment_conversations
    ADD CONSTRAINT sighting_amendment_conversations_pkey PRIMARY KEY (id);


--
-- Name: sighting_amendment_files sighting_amendment_files_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_amendment_files
    ADD CONSTRAINT sighting_amendment_files_pkey PRIMARY KEY (id);


--
-- Name: sighting_amendments sighting_amendments_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_amendments
    ADD CONSTRAINT sighting_amendments_pkey PRIMARY KEY (id);


--
-- Name: sighting_files sighting_files_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_files
    ADD CONSTRAINT sighting_files_pkey PRIMARY KEY (id);


--
-- Name: sighting_import_errors sighting_import_errors_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_import_errors
    ADD CONSTRAINT sighting_import_errors_pkey PRIMARY KEY (id);


--
-- Name: sighting_imports sighting_imports_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_imports
    ADD CONSTRAINT sighting_imports_pkey PRIMARY KEY (id);


--
-- Name: sighting_rejection_reasons sighting_rejection_reasons_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_rejection_reasons
    ADD CONSTRAINT sighting_rejection_reasons_pkey PRIMARY KEY (id);


--
-- Name: sighting_user sighting_user_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_user
    ADD CONSTRAINT sighting_user_pkey PRIMARY KEY (id);


--
-- Name: sighting_user sighting_user_user_id_sighting_id_user_role_id_unique; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_user
    ADD CONSTRAINT sighting_user_user_id_sighting_id_user_role_id_unique UNIQUE (user_id, sighting_id, user_role_id);


--
-- Name: sighting_verifications sighting_verifications_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_verifications
    ADD CONSTRAINT sighting_verifications_pkey PRIMARY KEY (id);


--
-- Name: sightings sightings_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sightings
    ADD CONSTRAINT sightings_pkey PRIMARY KEY (id);


--
-- Name: static_notification_variables static_notification_variables_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.static_notification_variables
    ADD CONSTRAINT static_notification_variables_pkey PRIMARY KEY (id);


--
-- Name: stock_document_position_rings_in_stocks stock_document_position_rings_in_stocks_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.stock_document_position_rings_in_stocks
    ADD CONSTRAINT stock_document_position_rings_in_stocks_pkey PRIMARY KEY (id);


--
-- Name: stock_document_positions stock_document_positions_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.stock_document_positions
    ADD CONSTRAINT stock_document_positions_pkey PRIMARY KEY (id);


--
-- Name: stock_documents stock_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.stock_documents
    ADD CONSTRAINT stock_documents_pkey PRIMARY KEY (id);


--
-- Name: stock_ring_subtypes stock_ring_subtypes_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.stock_ring_subtypes
    ADD CONSTRAINT stock_ring_subtypes_pkey PRIMARY KEY (id);


--
-- Name: stock_ring_types stock_ring_types_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.stock_ring_types
    ADD CONSTRAINT stock_ring_types_pkey PRIMARY KEY (id);


--
-- Name: producers suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.producers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (id);


--
-- Name: support_texts support_texts_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.support_texts
    ADD CONSTRAINT support_texts_pkey PRIMARY KEY (id);


--
-- Name: system_messages system_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.system_messages
    ADD CONSTRAINT system_messages_pkey PRIMARY KEY (id);


--
-- Name: user_verification_tokens user_verification_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.user_verification_tokens
    ADD CONSTRAINT user_verification_tokens_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_name_unique; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_name_unique UNIQUE (name);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: dict_gis_geo_data_index; Type: INDEX; Schema: public; Owner: laravel
--

CREATE INDEX dict_gis_geo_data_index ON public.dict_gis USING gist (geo_data);


--
-- Name: image_thumbnails_thumbnail_type_index; Type: INDEX; Schema: public; Owner: laravel
--

CREATE INDEX image_thumbnails_thumbnail_type_index ON public.image_thumbnails USING btree (thumbnail_type);


--
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: laravel
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- Name: locations_abbr_index; Type: INDEX; Schema: public; Owner: laravel
--

CREATE INDEX locations_abbr_index ON public.locations USING btree (abbr);


--
-- Name: locations_coordinates_index; Type: INDEX; Schema: public; Owner: laravel
--

CREATE INDEX locations_coordinates_index ON public.locations USING gist (coordinates);


--
-- Name: locations_is_from_gps_index; Type: INDEX; Schema: public; Owner: laravel
--

CREATE INDEX locations_is_from_gps_index ON public.locations USING btree (is_from_gps);


--
-- Name: locations_is_in_employee_registry_index; Type: INDEX; Schema: public; Owner: laravel
--

CREATE INDEX locations_is_in_employee_registry_index ON public.locations USING btree (is_in_employee_registry);


--
-- Name: locations_is_in_user_registry_index; Type: INDEX; Schema: public; Owner: laravel
--

CREATE INDEX locations_is_in_user_registry_index ON public.locations USING btree (is_in_user_registry);


--
-- Name: locations_name_index; Type: INDEX; Schema: public; Owner: laravel
--

CREATE INDEX locations_name_index ON public.locations USING btree (name);


--
-- Name: locations_source_index; Type: INDEX; Schema: public; Owner: laravel
--

CREATE INDEX locations_source_index ON public.locations USING btree (source);


--
-- Name: password_resets_email_index; Type: INDEX; Schema: public; Owner: laravel
--

CREATE INDEX password_resets_email_index ON public.password_resets USING btree (email);


--
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: laravel
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- Name: record_changes_created_at_updated_at_index; Type: INDEX; Schema: public; Owner: laravel
--

CREATE INDEX record_changes_created_at_updated_at_index ON public.record_changes USING btree (created_at, updated_at);


--
-- Name: record_changes_reference_id_index; Type: INDEX; Schema: public; Owner: laravel
--

CREATE INDEX record_changes_reference_id_index ON public.record_changes USING btree (reference_id);


--
-- Name: record_changes_reference_table_index; Type: INDEX; Schema: public; Owner: laravel
--

CREATE INDEX record_changes_reference_table_index ON public.record_changes USING btree (reference_table);


--
-- Name: record_changes_user_id_index; Type: INDEX; Schema: public; Owner: laravel
--

CREATE INDEX record_changes_user_id_index ON public.record_changes USING btree (user_id);


--
-- Name: rings_number_index; Type: INDEX; Schema: public; Owner: laravel
--

CREATE INDEX rings_number_index ON public.rings USING btree (number);


--
-- Name: sightings_created_at_index; Type: INDEX; Schema: public; Owner: laravel
--

CREATE INDEX sightings_created_at_index ON public.sightings USING btree (created_at);


--
-- Name: sightings_date_hour_minutes_index; Type: INDEX; Schema: public; Owner: laravel
--

CREATE INDEX sightings_date_hour_minutes_index ON public.sightings USING btree (date, hour, minutes);


--
-- Name: sightings_family_ring_number_index; Type: INDEX; Schema: public; Owner: laravel
--

CREATE INDEX sightings_family_ring_number_index ON public.sightings USING btree (family_ring_number);


--
-- Name: sightings_updated_at_index; Type: INDEX; Schema: public; Owner: laravel
--

CREATE INDEX sightings_updated_at_index ON public.sightings USING btree (updated_at);


--
-- Name: users_first_name_last_name_index; Type: INDEX; Schema: public; Owner: laravel
--

CREATE INDEX users_first_name_last_name_index ON public.users USING btree (first_name, last_name);


--
-- Name: locations update_province_and_country; Type: TRIGGER; Schema: public; Owner: laravel
--

CREATE TRIGGER update_province_and_country BEFORE INSERT OR UPDATE ON public.locations FOR EACH ROW EXECUTE FUNCTION public.update_province_and_country();


--
-- Name: addresses addresses_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: data_sharing_requesters applicants_application_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.data_sharing_requesters
    ADD CONSTRAINT applicants_application_id_foreign FOREIGN KEY (data_sharing_request_id) REFERENCES public.data_sharing_requests(id);


--
-- Name: data_sharing_requests applications_address_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.data_sharing_requests
    ADD CONSTRAINT applications_address_id_foreign FOREIGN KEY (address_id) REFERENCES public.addresses(id);


--
-- Name: bird_family_sightings_rings bird_family_sightings_rings_family_member_ring_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.bird_family_sightings_rings
    ADD CONSTRAINT bird_family_sightings_rings_family_member_ring_id_foreign FOREIGN KEY (family_member_ring_id) REFERENCES public.rings(id);


--
-- Name: bird_family_sightings_rings bird_family_sightings_rings_sighting_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.bird_family_sightings_rings
    ADD CONSTRAINT bird_family_sightings_rings_sighting_id_foreign FOREIGN KEY (sighting_id) REFERENCES public.sightings(id);


--
-- Name: dict_circumstances dict_circumstances_parent_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_circumstances
    ADD CONSTRAINT dict_circumstances_parent_id_foreign FOREIGN KEY (parent_id) REFERENCES public.dict_circumstances(id);


--
-- Name: dict_gis dict_gis_province_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_gis
    ADD CONSTRAINT dict_gis_province_id_foreign FOREIGN KEY (province_id) REFERENCES public.dict_provinces(id);


--
-- Name: dict_provinces dict_provinces_country_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_provinces
    ADD CONSTRAINT dict_provinces_country_id_foreign FOREIGN KEY (country_id) REFERENCES public.dict_countries(id);


--
-- Name: dict_sighting_verification_types dict_sighting_verification_types_final_status_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_sighting_verification_types
    ADD CONSTRAINT dict_sighting_verification_types_final_status_id_foreign FOREIGN KEY (final_status_id) REFERENCES public.dict_sighting_statuses(id);


--
-- Name: dict_species_dict_species_groups dict_species_dict_species_groups_species_group_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_species_dict_species_groups
    ADD CONSTRAINT dict_species_dict_species_groups_species_group_id_foreign FOREIGN KEY (species_group_id) REFERENCES public.dict_species_groups(id);


--
-- Name: dict_species_dict_species_groups dict_species_dict_species_groups_species_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_species_dict_species_groups
    ADD CONSTRAINT dict_species_dict_species_groups_species_id_foreign FOREIGN KEY (species_id) REFERENCES public.dict_species(id);


--
-- Name: dict_species_pairs dict_species_pairs_species1_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_species_pairs
    ADD CONSTRAINT dict_species_pairs_species1_id_foreign FOREIGN KEY (species1_id) REFERENCES public.dict_species(id);


--
-- Name: dict_species_pairs dict_species_pairs_species2_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_species_pairs
    ADD CONSTRAINT dict_species_pairs_species2_id_foreign FOREIGN KEY (species2_id) REFERENCES public.dict_species(id);


--
-- Name: dict_stock_operations dict_stock_operations_origin_stock_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_stock_operations
    ADD CONSTRAINT dict_stock_operations_origin_stock_id_foreign FOREIGN KEY (origin_stock_id) REFERENCES public.dict_ring_stocks(id);


--
-- Name: dict_stock_operations dict_stock_operations_target_stock_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.dict_stock_operations
    ADD CONSTRAINT dict_stock_operations_target_stock_id_foreign FOREIGN KEY (target_stock_id) REFERENCES public.dict_ring_stocks(id);


--
-- Name: image_thumbnails image_thumbnails_file_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.image_thumbnails
    ADD CONSTRAINT image_thumbnails_file_id_foreign FOREIGN KEY (file_id) REFERENCES public.files(id);


--
-- Name: image_thumbnails image_thumbnails_original_file_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.image_thumbnails
    ADD CONSTRAINT image_thumbnails_original_file_id_foreign FOREIGN KEY (original_file_id) REFERENCES public.files(id);


--
-- Name: interesting_sightings interesting_sightings_created_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.interesting_sightings
    ADD CONSTRAINT interesting_sightings_created_by_foreign FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: interesting_sightings interesting_sightings_sighting_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.interesting_sightings
    ADD CONSTRAINT interesting_sightings_sighting_id_foreign FOREIGN KEY (sighting_id) REFERENCES public.sightings(id);


--
-- Name: interesting_sightings interesting_sightings_updated_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.interesting_sightings
    ADD CONSTRAINT interesting_sightings_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES public.users(id);


--
-- Name: locations locations_coordinate_accuracy_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_coordinate_accuracy_id_foreign FOREIGN KEY (coordinate_accuracy_id) REFERENCES public.dict_coordinate_accuracies(id);


--
-- Name: locations locations_country_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_country_id_foreign FOREIGN KEY (country_id) REFERENCES public.dict_countries(id);


--
-- Name: locations locations_province_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_province_id_foreign FOREIGN KEY (province_id) REFERENCES public.dict_provinces(id);


--
-- Name: locations locations_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: measurements measurements_measurement_type_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.measurements
    ADD CONSTRAINT measurements_measurement_type_id_foreign FOREIGN KEY (measurement_type_id) REFERENCES public.dict_measurement_types(id);


--
-- Name: measurements measurements_sighting_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.measurements
    ADD CONSTRAINT measurements_sighting_id_foreign FOREIGN KEY (sighting_id) REFERENCES public.sightings(id);


--
-- Name: multiple_views multiple_views_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.multiple_views
    ADD CONSTRAINT multiple_views_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: notification_sightings notification_sightings_notification_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.notification_sightings
    ADD CONSTRAINT notification_sightings_notification_id_foreign FOREIGN KEY (notification_id) REFERENCES public.notifications(id);


--
-- Name: notification_sightings notification_sightings_sighting_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.notification_sightings
    ADD CONSTRAINT notification_sightings_sighting_id_foreign FOREIGN KEY (sighting_id) REFERENCES public.sightings(id);


--
-- Name: notification_types notification_types_mail_attachment_template_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.notification_types
    ADD CONSTRAINT notification_types_mail_attachment_template_id_foreign FOREIGN KEY (mail_attachment_template_id) REFERENCES public.pdf_templates(id);


--
-- Name: notification_types notification_types_mail_template_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.notification_types
    ADD CONSTRAINT notification_types_mail_template_id_foreign FOREIGN KEY (mail_template_id) REFERENCES public.mail_templates(id);


--
-- Name: notification_types notification_types_pdf_template_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.notification_types
    ADD CONSTRAINT notification_types_pdf_template_id_foreign FOREIGN KEY (pdf_template_id) REFERENCES public.pdf_templates(id);


--
-- Name: notifications notifications_ring_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_ring_id_foreign FOREIGN KEY (ring_id) REFERENCES public.rings(id);


--
-- Name: notifications notifications_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: order_positions order_positions_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.order_positions
    ADD CONSTRAINT order_positions_order_id_foreign FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: order_positions order_positions_ring_type_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.order_positions
    ADD CONSTRAINT order_positions_ring_type_id_foreign FOREIGN KEY (ring_type_id) REFERENCES public.dict_ring_types(id);


--
-- Name: order_positions order_positions_stock_ring_subtype_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.order_positions
    ADD CONSTRAINT order_positions_stock_ring_subtype_foreign FOREIGN KEY (stock_ring_subtype) REFERENCES public.stock_ring_subtypes(id);


--
-- Name: order_positions order_positions_stock_ring_type_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.order_positions
    ADD CONSTRAINT order_positions_stock_ring_type_foreign FOREIGN KEY (stock_ring_type) REFERENCES public.stock_ring_types(id);


--
-- Name: orders orders_document_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_document_id_foreign FOREIGN KEY (document_id) REFERENCES public.stock_documents(id);


--
-- Name: orders orders_ringer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_ringer_id_foreign FOREIGN KEY (ringer_id) REFERENCES public.users(id);


--
-- Name: phone_numbers phone_numbers_ringer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.phone_numbers
    ADD CONSTRAINT phone_numbers_ringer_id_foreign FOREIGN KEY (ringer_id) REFERENCES public.users(id);


--
-- Name: ring_sighting ring_sighting_ring_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.ring_sighting
    ADD CONSTRAINT ring_sighting_ring_id_foreign FOREIGN KEY (ring_id) REFERENCES public.rings(id);


--
-- Name: ring_sighting ring_sighting_ring_status_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.ring_sighting
    ADD CONSTRAINT ring_sighting_ring_status_id_foreign FOREIGN KEY (ring_status_id) REFERENCES public.dict_ring_statuses(id);


--
-- Name: ring_sighting ring_sighting_sighting_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.ring_sighting
    ADD CONSTRAINT ring_sighting_sighting_id_foreign FOREIGN KEY (sighting_id) REFERENCES public.sightings(id);


--
-- Name: ringer_data ringer_data_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.ringer_data
    ADD CONSTRAINT ringer_data_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: rings rings_color_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.rings
    ADD CONSTRAINT rings_color_id_foreign FOREIGN KEY (color_id) REFERENCES public.dict_colors(id);


--
-- Name: rings_in_stocks rings_in_stocks_ring_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.rings_in_stocks
    ADD CONSTRAINT rings_in_stocks_ring_id_foreign FOREIGN KEY (ring_id) REFERENCES public.rings(id);


--
-- Name: rings_in_stocks rings_in_stocks_stock_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.rings_in_stocks
    ADD CONSTRAINT rings_in_stocks_stock_id_foreign FOREIGN KEY (stock_id) REFERENCES public.dict_ring_stocks(id);


--
-- Name: rings_in_stocks rings_in_stocks_subtype_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.rings_in_stocks
    ADD CONSTRAINT rings_in_stocks_subtype_id_foreign FOREIGN KEY (subtype_id) REFERENCES public.stock_ring_subtypes(id);


--
-- Name: rings_in_stocks rings_in_stocks_supplier_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.rings_in_stocks
    ADD CONSTRAINT rings_in_stocks_supplier_id_foreign FOREIGN KEY (supplier_id) REFERENCES public.producers(id);


--
-- Name: rings rings_ring_type_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.rings
    ADD CONSTRAINT rings_ring_type_id_foreign FOREIGN KEY (ring_type_id) REFERENCES public.dict_ring_types(id);


--
-- Name: rings rings_ringer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.rings
    ADD CONSTRAINT rings_ringer_id_foreign FOREIGN KEY (ringer_id) REFERENCES public.users(id);


--
-- Name: rings rings_scheme_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.rings
    ADD CONSTRAINT rings_scheme_id_foreign FOREIGN KEY (scheme_id) REFERENCES public.dict_schemes(id);


--
-- Name: rings rings_species_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.rings
    ADD CONSTRAINT rings_species_id_foreign FOREIGN KEY (species_id) REFERENCES public.dict_species(id);


--
-- Name: sent_attachments sent_attachments_sent_notification_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sent_attachments
    ADD CONSTRAINT sent_attachments_sent_notification_id_foreign FOREIGN KEY (sent_notification_id) REFERENCES public.sent_notifications(id);


--
-- Name: sent_notifications sent_notifications_notification_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sent_notifications
    ADD CONSTRAINT sent_notifications_notification_id_foreign FOREIGN KEY (notification_id) REFERENCES public.notifications(id);


--
-- Name: sighting_amendment_conversations sighting_amendment_conversations_sighting_amendment_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_amendment_conversations
    ADD CONSTRAINT sighting_amendment_conversations_sighting_amendment_id_foreign FOREIGN KEY (sighting_amendment_id) REFERENCES public.sighting_amendments(id);


--
-- Name: sighting_amendment_conversations sighting_amendment_conversations_writer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_amendment_conversations
    ADD CONSTRAINT sighting_amendment_conversations_writer_id_foreign FOREIGN KEY (writer_id) REFERENCES public.users(id);


--
-- Name: sighting_amendment_files sighting_amendment_files_file_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_amendment_files
    ADD CONSTRAINT sighting_amendment_files_file_id_foreign FOREIGN KEY (file_id) REFERENCES public.files(id);


--
-- Name: sighting_amendment_files sighting_amendment_files_sighting_amendment_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_amendment_files
    ADD CONSTRAINT sighting_amendment_files_sighting_amendment_id_foreign FOREIGN KEY (sighting_amendment_id) REFERENCES public.sighting_amendments(id);


--
-- Name: sighting_amendments sighting_amendments_primary_sighting_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_amendments
    ADD CONSTRAINT sighting_amendments_primary_sighting_id_foreign FOREIGN KEY (primary_sighting_id) REFERENCES public.sightings(id);


--
-- Name: sighting_amendments sighting_amendments_sighting_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_amendments
    ADD CONSTRAINT sighting_amendments_sighting_id_foreign FOREIGN KEY (sighting_id) REFERENCES public.sightings(id);


--
-- Name: sighting_amendments sighting_amendments_station_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_amendments
    ADD CONSTRAINT sighting_amendments_station_id_foreign FOREIGN KEY (station_id) REFERENCES public.users(id);


--
-- Name: sighting_amendments sighting_amendments_status_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_amendments
    ADD CONSTRAINT sighting_amendments_status_id_foreign FOREIGN KEY (status_id) REFERENCES public.dict_sighting_amendment_statuses(id);


--
-- Name: sighting_amendments sighting_amendments_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_amendments
    ADD CONSTRAINT sighting_amendments_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: sighting_files sighting_files_file_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_files
    ADD CONSTRAINT sighting_files_file_id_foreign FOREIGN KEY (file_id) REFERENCES public.files(id);


--
-- Name: sighting_files sighting_files_sighting_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_files
    ADD CONSTRAINT sighting_files_sighting_id_foreign FOREIGN KEY (sighting_id) REFERENCES public.sightings(id);


--
-- Name: sighting_import_errors sighting_import_errors_sighting_import_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_import_errors
    ADD CONSTRAINT sighting_import_errors_sighting_import_id_foreign FOREIGN KEY (sighting_import_id) REFERENCES public.sighting_imports(id);


--
-- Name: sighting_imports sighting_imports_file_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_imports
    ADD CONSTRAINT sighting_imports_file_id_foreign FOREIGN KEY (file_id) REFERENCES public.files(id);


--
-- Name: sighting_imports sighting_imports_species_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_imports
    ADD CONSTRAINT sighting_imports_species_id_foreign FOREIGN KEY (species_id) REFERENCES public.dict_species(id);


--
-- Name: sighting_imports sighting_imports_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_imports
    ADD CONSTRAINT sighting_imports_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: sighting_rejection_reasons sighting_rejection_reasons_sighting_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_rejection_reasons
    ADD CONSTRAINT sighting_rejection_reasons_sighting_id_foreign FOREIGN KEY (sighting_id) REFERENCES public.sightings(id);


--
-- Name: sighting_sighting_import sighting_sighting_import_sighting_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_sighting_import
    ADD CONSTRAINT sighting_sighting_import_sighting_id_foreign FOREIGN KEY (sighting_id) REFERENCES public.sightings(id);


--
-- Name: sighting_sighting_import sighting_sighting_import_sighting_import_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_sighting_import
    ADD CONSTRAINT sighting_sighting_import_sighting_import_id_foreign FOREIGN KEY (sighting_import_id) REFERENCES public.sighting_imports(id);


--
-- Name: sighting_user sighting_user_sighting_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_user
    ADD CONSTRAINT sighting_user_sighting_id_foreign FOREIGN KEY (sighting_id) REFERENCES public.sightings(id);


--
-- Name: sighting_user sighting_user_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_user
    ADD CONSTRAINT sighting_user_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: sighting_user sighting_user_user_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_user
    ADD CONSTRAINT sighting_user_user_role_id_foreign FOREIGN KEY (user_role_id) REFERENCES public.dict_user_sighting_roles(id);


--
-- Name: sighting_verifications sighting_verifications_sighting_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_verifications
    ADD CONSTRAINT sighting_verifications_sighting_id_foreign FOREIGN KEY (sighting_id) REFERENCES public.sightings(id);


--
-- Name: sighting_verifications sighting_verifications_sighting_verification_type_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sighting_verifications
    ADD CONSTRAINT sighting_verifications_sighting_verification_type_foreign FOREIGN KEY (sighting_verification_type) REFERENCES public.dict_sighting_verification_types(key);


--
-- Name: sightings sightings_age_by_scheme_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sightings
    ADD CONSTRAINT sightings_age_by_scheme_id_foreign FOREIGN KEY (age_by_scheme_id) REFERENCES public.dict_ages(id);


--
-- Name: sightings sightings_age_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sightings
    ADD CONSTRAINT sightings_age_id_foreign FOREIGN KEY (age_id) REFERENCES public.dict_ages(id);


--
-- Name: sightings sightings_bird_birth_accuracy_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sightings
    ADD CONSTRAINT sightings_bird_birth_accuracy_id_foreign FOREIGN KEY (bird_birth_accuracy_id) REFERENCES public.dict_bird_birth_accuracies(id);


--
-- Name: sightings sightings_bird_displacement_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sightings
    ADD CONSTRAINT sightings_bird_displacement_id_foreign FOREIGN KEY (bird_displacement_id) REFERENCES public.dict_bird_displacements(id);


--
-- Name: sightings sightings_bird_manipulation_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sightings
    ADD CONSTRAINT sightings_bird_manipulation_id_foreign FOREIGN KEY (bird_manipulation_id) REFERENCES public.dict_bird_manipulations(id);


--
-- Name: sightings sightings_bird_status_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sightings
    ADD CONSTRAINT sightings_bird_status_id_foreign FOREIGN KEY (bird_status_id) REFERENCES public.dict_bird_statuses(id);


--
-- Name: sightings sightings_capture_method_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sightings
    ADD CONSTRAINT sightings_capture_method_id_foreign FOREIGN KEY (capture_method_id) REFERENCES public.dict_capture_methods(id);


--
-- Name: sightings sightings_circumstances_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sightings
    ADD CONSTRAINT sightings_circumstances_id_foreign FOREIGN KEY (circumstances_id) REFERENCES public.dict_circumstances(id);


--
-- Name: sightings sightings_circumstances_validations_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sightings
    ADD CONSTRAINT sightings_circumstances_validations_id_foreign FOREIGN KEY (circumstances_validation_id) REFERENCES public.dict_circumstances_validations(id);


--
-- Name: sightings sightings_condition_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sightings
    ADD CONSTRAINT sightings_condition_id_foreign FOREIGN KEY (condition_id) REFERENCES public.dict_conditions(id);


--
-- Name: sightings sightings_created_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sightings
    ADD CONSTRAINT sightings_created_by_foreign FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: sightings sightings_date_accuracy_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sightings
    ADD CONSTRAINT sightings_date_accuracy_id_foreign FOREIGN KEY (date_accuracy_id) REFERENCES public.dict_date_accuracies(id);


--
-- Name: sightings sightings_decoy_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sightings
    ADD CONSTRAINT sightings_decoy_id_foreign FOREIGN KEY (decoy_id) REFERENCES public.dict_decoys(id);


--
-- Name: sightings sightings_location_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sightings
    ADD CONSTRAINT sightings_location_id_foreign FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- Name: sightings sightings_plumage_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sightings
    ADD CONSTRAINT sightings_plumage_id_foreign FOREIGN KEY (plumage_id) REFERENCES public.dict_plumages(id);


--
-- Name: sightings sightings_primary_sighting_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sightings
    ADD CONSTRAINT sightings_primary_sighting_id_foreign FOREIGN KEY (primary_sighting_id) REFERENCES public.sightings(id);


--
-- Name: sightings sightings_pullus_age_accuracy_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sightings
    ADD CONSTRAINT sightings_pullus_age_accuracy_id_foreign FOREIGN KEY (pullus_age_accuracy_id) REFERENCES public.dict_bird_birth_accuracies(id);


--
-- Name: sightings sightings_ring_verification_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sightings
    ADD CONSTRAINT sightings_ring_verification_id_foreign FOREIGN KEY (ring_verification_id) REFERENCES public.dict_ring_verifications(id);


--
-- Name: sightings sightings_sex_by_scheme_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sightings
    ADD CONSTRAINT sightings_sex_by_scheme_id_foreign FOREIGN KEY (sex_by_scheme_id) REFERENCES public.dict_sexes(id);


--
-- Name: sightings sightings_sex_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sightings
    ADD CONSTRAINT sightings_sex_id_foreign FOREIGN KEY (sex_id) REFERENCES public.dict_sexes(id);


--
-- Name: sightings sightings_sighting_status_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sightings
    ADD CONSTRAINT sightings_sighting_status_id_foreign FOREIGN KEY (sighting_status_id) REFERENCES public.dict_sighting_statuses(id);


--
-- Name: sightings sightings_species_by_scheme_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sightings
    ADD CONSTRAINT sightings_species_by_scheme_id_foreign FOREIGN KEY (species_by_scheme_id) REFERENCES public.dict_species(id);


--
-- Name: sightings sightings_species_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sightings
    ADD CONSTRAINT sightings_species_id_foreign FOREIGN KEY (species_id) REFERENCES public.dict_species(id);


--
-- Name: sightings sightings_updated_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.sightings
    ADD CONSTRAINT sightings_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES public.users(id);


--
-- Name: stock_document_position_rings_in_stocks stock_document_position_rings_in_stocks_ring_in_stock_id_foreig; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.stock_document_position_rings_in_stocks
    ADD CONSTRAINT stock_document_position_rings_in_stocks_ring_in_stock_id_foreig FOREIGN KEY (rings_in_stock_id) REFERENCES public.rings_in_stocks(id);


--
-- Name: stock_document_position_rings_in_stocks stock_document_position_rings_in_stocks_stock_document_position; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.stock_document_position_rings_in_stocks
    ADD CONSTRAINT stock_document_position_rings_in_stocks_stock_document_position FOREIGN KEY (stock_document_position_id) REFERENCES public.stock_document_positions(id);


--
-- Name: stock_document_positions stock_document_positions_dict_ring_type_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.stock_document_positions
    ADD CONSTRAINT stock_document_positions_dict_ring_type_id_foreign FOREIGN KEY (dict_ring_type_id) REFERENCES public.dict_ring_types(id);


--
-- Name: stock_document_positions stock_document_positions_ring_subtype_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.stock_document_positions
    ADD CONSTRAINT stock_document_positions_ring_subtype_id_foreign FOREIGN KEY (ring_subtype_id) REFERENCES public.stock_ring_subtypes(id);


--
-- Name: stock_document_positions stock_document_positions_ring_type_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.stock_document_positions
    ADD CONSTRAINT stock_document_positions_ring_type_id_foreign FOREIGN KEY (ring_type_id) REFERENCES public.stock_ring_types(id);


--
-- Name: stock_document_positions stock_document_positions_species_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.stock_document_positions
    ADD CONSTRAINT stock_document_positions_species_id_foreign FOREIGN KEY (species_id) REFERENCES public.dict_species(id);


--
-- Name: stock_document_positions stock_document_positions_stock_document_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.stock_document_positions
    ADD CONSTRAINT stock_document_positions_stock_document_id_foreign FOREIGN KEY (stock_document_id) REFERENCES public.stock_documents(id);


--
-- Name: stock_documents stock_documents_created_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.stock_documents
    ADD CONSTRAINT stock_documents_created_by_foreign FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: stock_documents stock_documents_deleted_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.stock_documents
    ADD CONSTRAINT stock_documents_deleted_by_foreign FOREIGN KEY (deleted_by) REFERENCES public.users(id);


--
-- Name: stock_documents stock_documents_ringer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.stock_documents
    ADD CONSTRAINT stock_documents_ringer_id_foreign FOREIGN KEY (bound_ringer_id) REFERENCES public.users(id);


--
-- Name: stock_documents stock_documents_stock_operation_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.stock_documents
    ADD CONSTRAINT stock_documents_stock_operation_id_foreign FOREIGN KEY (stock_operation_id) REFERENCES public.dict_stock_operations(id);


--
-- Name: stock_documents stock_documents_supplier_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.stock_documents
    ADD CONSTRAINT stock_documents_supplier_id_foreign FOREIGN KEY (supplier_id) REFERENCES public.producers(id);


--
-- Name: stock_documents stock_documents_target_ringer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.stock_documents
    ADD CONSTRAINT stock_documents_target_ringer_id_foreign FOREIGN KEY (transfer_ringer_id) REFERENCES public.users(id);


--
-- Name: stock_documents stock_documents_updated_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.stock_documents
    ADD CONSTRAINT stock_documents_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES public.users(id);


--
-- Name: stock_ring_subtypes stock_ring_subtypes_type_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.stock_ring_subtypes
    ADD CONSTRAINT stock_ring_subtypes_type_id_foreign FOREIGN KEY (type_id) REFERENCES public.stock_ring_types(id);


--
-- Name: system_messages system_messages_created_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.system_messages
    ADD CONSTRAINT system_messages_created_by_foreign FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: system_messages system_messages_updated_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.system_messages
    ADD CONSTRAINT system_messages_updated_by_foreign FOREIGN KEY (updated_by) REFERENCES public.users(id);


--
-- Name: user_verification_tokens user_verification_tokens_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.user_verification_tokens
    ADD CONSTRAINT user_verification_tokens_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: users users_personal_title_foreign; Type: FK CONSTRAINT; Schema: public; Owner: laravel
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_personal_title_foreign FOREIGN KEY (personal_title_id) REFERENCES public.dict_personal_titles(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: laravel
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

