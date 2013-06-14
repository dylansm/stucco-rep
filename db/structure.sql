--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: adobe_products; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE adobe_products (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(255),
    mnemonic_file_name character varying(255),
    mnemonic_content_type character varying(255),
    mnemonic_file_size integer,
    mnemonic_updated_at timestamp without time zone
);


--
-- Name: adobe_products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE adobe_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: adobe_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE adobe_products_id_seq OWNED BY adobe_products.id;


--
-- Name: program_managers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE program_managers (
    id integer NOT NULL,
    user_id integer,
    program_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: program_managers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE program_managers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: program_managers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE program_managers_id_seq OWNED BY program_managers.id;


--
-- Name: programs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE programs (
    id integer NOT NULL,
    name character varying(255),
    program_icon_file_name character varying(255),
    program_icon_content_type character varying(255),
    program_icon_file_size integer,
    program_icon_updated_at timestamp without time zone,
    theme_name character varying(255),
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: programs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE programs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: programs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE programs_id_seq OWNED BY programs.id;


--
-- Name: regions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE regions (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: regions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE regions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: regions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE regions_id_seq OWNED BY regions.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: schools; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schools (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    school_logo_file_name character varying(255),
    school_logo_content_type character varying(255),
    school_logo_file_size integer,
    school_logo_updated_at timestamp without time zone,
    name character varying(255)
);


--
-- Name: schools_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE schools_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: schools_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE schools_id_seq OWNED BY schools.id;


--
-- Name: tools; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tools (
    id integer NOT NULL,
    user_id integer,
    adobe_product_id integer,
    skill_level integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: tools_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tools_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tools_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tools_id_seq OWNED BY tools.id;


--
-- Name: user_applications; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_applications (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    mobile_phone character varying(255),
    gender character varying(1),
    bio text,
    street_address character varying(255),
    street_address2 character varying(255),
    city character varying(255),
    state character varying(255),
    postal_code character varying(255),
    country character varying(255),
    planned_grad_year character varying(255),
    planned_grad_term character varying(255),
    major character varying(255),
    minor character varying(255),
    gpa double precision,
    num_facebook_friends integer,
    num_instagram_followers integer,
    num_twitter_followers integer,
    other_social_sites character varying(255),
    member_design_community character varying(255),
    portfolio_url character varying(255),
    behance_profile_url character varying(255),
    extracurriculars text,
    extracurricular_leadership boolean,
    leadership_description text,
    reference_name character varying(255),
    reference_relationship character varying(255),
    reference_email character varying(255),
    reference_phone character varying(255),
    how_adobe_helps text,
    student_orgs_and_leverage text,
    teaching_experience text,
    what_sets_you_apart text,
    do_you_have_time character varying(1),
    available_to_work character varying(1),
    video_submission_url character varying(255),
    resume_file_name character varying(255),
    resume_content_type character varying(255),
    resume_file_size integer,
    resume_updated_at timestamp without time zone
);


--
-- Name: user_applications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_applications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_applications_id_seq OWNED BY user_applications.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    first_name character varying(255),
    last_name character varying(255),
    admin boolean DEFAULT false,
    authentication_token character varying(255),
    provider character varying(255),
    uid character varying(255),
    active_for_authentication boolean DEFAULT true,
    school_id integer,
    program_id integer,
    points integer,
    avatar_file_name character varying(255),
    avatar_content_type character varying(255),
    avatar_file_size integer,
    avatar_updated_at timestamp without time zone
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY adobe_products ALTER COLUMN id SET DEFAULT nextval('adobe_products_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY program_managers ALTER COLUMN id SET DEFAULT nextval('program_managers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY programs ALTER COLUMN id SET DEFAULT nextval('programs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY regions ALTER COLUMN id SET DEFAULT nextval('regions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY schools ALTER COLUMN id SET DEFAULT nextval('schools_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tools ALTER COLUMN id SET DEFAULT nextval('tools_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_applications ALTER COLUMN id SET DEFAULT nextval('user_applications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: adobe_products_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY adobe_products
    ADD CONSTRAINT adobe_products_pkey PRIMARY KEY (id);


--
-- Name: program_managers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY program_managers
    ADD CONSTRAINT program_managers_pkey PRIMARY KEY (id);


--
-- Name: programs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY programs
    ADD CONSTRAINT programs_pkey PRIMARY KEY (id);


--
-- Name: regions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (id);


--
-- Name: schools_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY schools
    ADD CONSTRAINT schools_pkey PRIMARY KEY (id);


--
-- Name: tools_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tools
    ADD CONSTRAINT tools_pkey PRIMARY KEY (id);


--
-- Name: user_applications_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_applications
    ADD CONSTRAINT user_applications_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_user_applications_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_user_applications_on_user_id ON user_applications USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_program_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_program_id ON users USING btree (program_id);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_users_on_school_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_school_id ON users USING btree (school_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20130515063233');

INSERT INTO schema_migrations (version) VALUES ('20130515063505');

INSERT INTO schema_migrations (version) VALUES ('20130516210715');

INSERT INTO schema_migrations (version) VALUES ('20130519060535');

INSERT INTO schema_migrations (version) VALUES ('20130519154612');

INSERT INTO schema_migrations (version) VALUES ('20130529043843');

INSERT INTO schema_migrations (version) VALUES ('20130529200200');

INSERT INTO schema_migrations (version) VALUES ('20130530050725');

INSERT INTO schema_migrations (version) VALUES ('20130604202935');

INSERT INTO schema_migrations (version) VALUES ('20130607060328');

INSERT INTO schema_migrations (version) VALUES ('20130607135330');

INSERT INTO schema_migrations (version) VALUES ('20130607135408');

INSERT INTO schema_migrations (version) VALUES ('20130607141035');

INSERT INTO schema_migrations (version) VALUES ('20130607141654');

INSERT INTO schema_migrations (version) VALUES ('20130607173221');

INSERT INTO schema_migrations (version) VALUES ('20130612160947');

INSERT INTO schema_migrations (version) VALUES ('20130612161250');

INSERT INTO schema_migrations (version) VALUES ('20130612231524');

INSERT INTO schema_migrations (version) VALUES ('20130612231553');
