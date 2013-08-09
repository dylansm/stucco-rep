--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: adobe_products; Type: TABLE; Schema: public; Owner: dylan; Tablespace: 
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


ALTER TABLE public.adobe_products OWNER TO dylan;

--
-- Name: adobe_products_id_seq; Type: SEQUENCE; Schema: public; Owner: dylan
--

CREATE SEQUENCE adobe_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.adobe_products_id_seq OWNER TO dylan;

--
-- Name: adobe_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dylan
--

ALTER SEQUENCE adobe_products_id_seq OWNED BY adobe_products.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: dylan; Tablespace: 
--

CREATE TABLE comments (
    id integer NOT NULL,
    post_id integer,
    user_id integer,
    text text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.comments OWNER TO dylan;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: dylan
--

CREATE SEQUENCE comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_id_seq OWNER TO dylan;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dylan
--

ALTER SEQUENCE comments_id_seq OWNED BY comments.id;


--
-- Name: event_types; Type: TABLE; Schema: public; Owner: dylan; Tablespace: 
--

CREATE TABLE event_types (
    id integer NOT NULL,
    name character varying(255),
    event_id integer,
    points integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.event_types OWNER TO dylan;

--
-- Name: event_types_id_seq; Type: SEQUENCE; Schema: public; Owner: dylan
--

CREATE SEQUENCE event_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event_types_id_seq OWNER TO dylan;

--
-- Name: event_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dylan
--

ALTER SEQUENCE event_types_id_seq OWNED BY event_types.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: dylan; Tablespace: 
--

CREATE TABLE events (
    id integer NOT NULL,
    user_id integer,
    name character varying(255),
    start_time timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.events OWNER TO dylan;

--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: dylan
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.events_id_seq OWNER TO dylan;

--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dylan
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: likes; Type: TABLE; Schema: public; Owner: dylan; Tablespace: 
--

CREATE TABLE likes (
    id integer NOT NULL,
    post_id integer,
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.likes OWNER TO dylan;

--
-- Name: likes_id_seq; Type: SEQUENCE; Schema: public; Owner: dylan
--

CREATE SEQUENCE likes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.likes_id_seq OWNER TO dylan;

--
-- Name: likes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dylan
--

ALTER SEQUENCE likes_id_seq OWNED BY likes.id;


--
-- Name: links; Type: TABLE; Schema: public; Owner: dylan; Tablespace: 
--

CREATE TABLE links (
    id integer NOT NULL,
    name character varying(255),
    url character varying(255),
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.links OWNER TO dylan;

--
-- Name: links_id_seq; Type: SEQUENCE; Schema: public; Owner: dylan
--

CREATE SEQUENCE links_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.links_id_seq OWNER TO dylan;

--
-- Name: links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dylan
--

ALTER SEQUENCE links_id_seq OWNED BY links.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: dylan; Tablespace: 
--

CREATE TABLE notifications (
    id integer NOT NULL,
    title character varying(255),
    text text,
    archived boolean,
    notifier_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.notifications OWNER TO dylan;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: dylan
--

CREATE SEQUENCE notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_id_seq OWNER TO dylan;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dylan
--

ALTER SEQUENCE notifications_id_seq OWNED BY notifications.id;


--
-- Name: notifications_users; Type: TABLE; Schema: public; Owner: dylan; Tablespace: 
--

CREATE TABLE notifications_users (
    id integer NOT NULL,
    notification_id integer,
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.notifications_users OWNER TO dylan;

--
-- Name: notifications_users_id_seq; Type: SEQUENCE; Schema: public; Owner: dylan
--

CREATE SEQUENCE notifications_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_users_id_seq OWNER TO dylan;

--
-- Name: notifications_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dylan
--

ALTER SEQUENCE notifications_users_id_seq OWNED BY notifications_users.id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: dylan; Tablespace: 
--

CREATE TABLE posts (
    id integer NOT NULL,
    user_id integer,
    text text,
    video_url character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    post_image_file_name character varying(255),
    post_image_content_type character varying(255),
    post_image_file_size integer,
    post_image_updated_at timestamp without time zone
);


ALTER TABLE public.posts OWNER TO dylan;

--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: dylan
--

CREATE SEQUENCE posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.posts_id_seq OWNER TO dylan;

--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dylan
--

ALTER SEQUENCE posts_id_seq OWNED BY posts.id;


--
-- Name: program_marquees; Type: TABLE; Schema: public; Owner: dylan; Tablespace: 
--

CREATE TABLE program_marquees (
    id integer NOT NULL,
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    marquee_file_name character varying(255),
    marquee_content_type character varying(255),
    marquee_file_size integer,
    marquee_updated_at timestamp without time zone
);


ALTER TABLE public.program_marquees OWNER TO dylan;

--
-- Name: program_marquees_id_seq; Type: SEQUENCE; Schema: public; Owner: dylan
--

CREATE SEQUENCE program_marquees_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.program_marquees_id_seq OWNER TO dylan;

--
-- Name: program_marquees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dylan
--

ALTER SEQUENCE program_marquees_id_seq OWNED BY program_marquees.id;


--
-- Name: programs; Type: TABLE; Schema: public; Owner: dylan; Tablespace: 
--

CREATE TABLE programs (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.programs OWNER TO dylan;

--
-- Name: programs_id_seq; Type: SEQUENCE; Schema: public; Owner: dylan
--

CREATE SEQUENCE programs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.programs_id_seq OWNER TO dylan;

--
-- Name: programs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dylan
--

ALTER SEQUENCE programs_id_seq OWNED BY programs.id;


--
-- Name: programs_schools; Type: TABLE; Schema: public; Owner: dylan; Tablespace: 
--

CREATE TABLE programs_schools (
    id integer NOT NULL,
    program_id integer,
    school_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.programs_schools OWNER TO dylan;

--
-- Name: programs_schools_id_seq; Type: SEQUENCE; Schema: public; Owner: dylan
--

CREATE SEQUENCE programs_schools_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.programs_schools_id_seq OWNER TO dylan;

--
-- Name: programs_schools_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dylan
--

ALTER SEQUENCE programs_schools_id_seq OWNED BY programs_schools.id;


--
-- Name: programs_users; Type: TABLE; Schema: public; Owner: dylan; Tablespace: 
--

CREATE TABLE programs_users (
    id integer NOT NULL,
    program_id integer,
    user_id integer
);


ALTER TABLE public.programs_users OWNER TO dylan;

--
-- Name: programs_users_id_seq; Type: SEQUENCE; Schema: public; Owner: dylan
--

CREATE SEQUENCE programs_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.programs_users_id_seq OWNER TO dylan;

--
-- Name: programs_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dylan
--

ALTER SEQUENCE programs_users_id_seq OWNED BY programs_users.id;


--
-- Name: ratings; Type: TABLE; Schema: public; Owner: dylan; Tablespace: 
--

CREATE TABLE ratings (
    id integer NOT NULL,
    rating integer,
    post_id integer,
    event_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.ratings OWNER TO dylan;

--
-- Name: ratings_id_seq; Type: SEQUENCE; Schema: public; Owner: dylan
--

CREATE SEQUENCE ratings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ratings_id_seq OWNER TO dylan;

--
-- Name: ratings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dylan
--

ALTER SEQUENCE ratings_id_seq OWNED BY ratings.id;


--
-- Name: regions; Type: TABLE; Schema: public; Owner: dylan; Tablespace: 
--

CREATE TABLE regions (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.regions OWNER TO dylan;

--
-- Name: regions_id_seq; Type: SEQUENCE; Schema: public; Owner: dylan
--

CREATE SEQUENCE regions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.regions_id_seq OWNER TO dylan;

--
-- Name: regions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dylan
--

ALTER SEQUENCE regions_id_seq OWNED BY regions.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: dylan; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO dylan;

--
-- Name: schools; Type: TABLE; Schema: public; Owner: dylan; Tablespace: 
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


ALTER TABLE public.schools OWNER TO dylan;

--
-- Name: schools_id_seq; Type: SEQUENCE; Schema: public; Owner: dylan
--

CREATE SEQUENCE schools_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.schools_id_seq OWNER TO dylan;

--
-- Name: schools_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dylan
--

ALTER SEQUENCE schools_id_seq OWNED BY schools.id;


--
-- Name: tools; Type: TABLE; Schema: public; Owner: dylan; Tablespace: 
--

CREATE TABLE tools (
    id integer NOT NULL,
    user_id integer,
    adobe_product_id integer,
    name character varying(255),
    skill_level integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.tools OWNER TO dylan;

--
-- Name: tools_id_seq; Type: SEQUENCE; Schema: public; Owner: dylan
--

CREATE SEQUENCE tools_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tools_id_seq OWNER TO dylan;

--
-- Name: tools_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dylan
--

ALTER SEQUENCE tools_id_seq OWNED BY tools.id;


--
-- Name: user_applications; Type: TABLE; Schema: public; Owner: dylan; Tablespace: 
--

CREATE TABLE user_applications (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    gender character varying(1),
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
    instagram_username character varying(255),
    num_instagram_followers integer,
    twitter_username character varying(255),
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


ALTER TABLE public.user_applications OWNER TO dylan;

--
-- Name: user_applications_id_seq; Type: SEQUENCE; Schema: public; Owner: dylan
--

CREATE SEQUENCE user_applications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_applications_id_seq OWNER TO dylan;

--
-- Name: user_applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dylan
--

ALTER SEQUENCE user_applications_id_seq OWNED BY user_applications.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: dylan; Tablespace: 
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
    mobile_phone character varying(255),
    points integer,
    current_program_id integer,
    avatar_file_name character varying(255),
    avatar_content_type character varying(255),
    avatar_file_size integer,
    avatar_updated_at timestamp without time zone,
    bio text
);


ALTER TABLE public.users OWNER TO dylan;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: dylan
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO dylan;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dylan
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY adobe_products ALTER COLUMN id SET DEFAULT nextval('adobe_products_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY event_types ALTER COLUMN id SET DEFAULT nextval('event_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY likes ALTER COLUMN id SET DEFAULT nextval('likes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY links ALTER COLUMN id SET DEFAULT nextval('links_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY notifications ALTER COLUMN id SET DEFAULT nextval('notifications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY notifications_users ALTER COLUMN id SET DEFAULT nextval('notifications_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY posts ALTER COLUMN id SET DEFAULT nextval('posts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY program_marquees ALTER COLUMN id SET DEFAULT nextval('program_marquees_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY programs ALTER COLUMN id SET DEFAULT nextval('programs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY programs_schools ALTER COLUMN id SET DEFAULT nextval('programs_schools_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY programs_users ALTER COLUMN id SET DEFAULT nextval('programs_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY ratings ALTER COLUMN id SET DEFAULT nextval('ratings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY regions ALTER COLUMN id SET DEFAULT nextval('regions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY schools ALTER COLUMN id SET DEFAULT nextval('schools_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY tools ALTER COLUMN id SET DEFAULT nextval('tools_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY user_applications ALTER COLUMN id SET DEFAULT nextval('user_applications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: adobe_products; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY adobe_products (id, created_at, updated_at, name, mnemonic_file_name, mnemonic_content_type, mnemonic_file_size, mnemonic_updated_at) FROM stdin;
1	2013-08-08 19:28:49.136831	2013-08-08 19:28:49.136831	Adobe AfterEffects	aftereffects.png	image/png	1693	\N
2	2013-08-08 19:28:49.143741	2013-08-08 19:28:49.143741	Adobe Dreamweaver	dreamweaver.png	image/png	3406	\N
3	2013-08-08 19:28:49.1463	2013-08-08 19:28:49.1463	Adobe Illustrator	illustrator.png	image/png	1677	\N
4	2013-08-08 19:28:49.148434	2013-08-08 19:28:49.148434	Adobe InDesign	indesign.png	image/png	1583	\N
5	2013-08-08 19:28:49.150611	2013-08-08 19:28:49.150611	Adobe Muse	muse.png	image/png	1593	\N
6	2013-08-08 19:28:49.152683	2013-08-08 19:28:49.152683	Adobe Photoshop	photoshop.png	image/png	1626	\N
7	2013-08-08 19:28:49.154668	2013-08-08 19:28:49.154668	Adobe Premiere	premiere.png	image/png	1631	\N
\.


--
-- Name: adobe_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dylan
--

SELECT pg_catalog.setval('adobe_products_id_seq', 7, true);


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY comments (id, post_id, user_id, text, created_at, updated_at) FROM stdin;
\.


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dylan
--

SELECT pg_catalog.setval('comments_id_seq', 1, false);


--
-- Data for Name: event_types; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY event_types (id, name, event_id, points, created_at, updated_at) FROM stdin;
\.


--
-- Name: event_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dylan
--

SELECT pg_catalog.setval('event_types_id_seq', 1, false);


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY events (id, user_id, name, start_time, created_at, updated_at) FROM stdin;
\.


--
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dylan
--

SELECT pg_catalog.setval('events_id_seq', 1, false);


--
-- Data for Name: likes; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY likes (id, post_id, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: likes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dylan
--

SELECT pg_catalog.setval('likes_id_seq', 1, false);


--
-- Data for Name: links; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY links (id, name, url, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dylan
--

SELECT pg_catalog.setval('links_id_seq', 1, false);


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY notifications (id, title, text, archived, notifier_id, created_at, updated_at) FROM stdin;
1	First Notification	First test	\N	1	2013-08-09 04:44:46.846981	2013-08-09 04:44:46.846981
2	Second Post	This is another notification	\N	1	2013-08-09 05:13:08.043325	2013-08-09 05:13:08.043325
3	A third test of notifications	This is my third test.\r\n\r\nIt has a line break and a link to www.adobe.com	\N	1	2013-08-09 17:41:00.320137	2013-08-09 17:41:00.320137
\.


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dylan
--

SELECT pg_catalog.setval('notifications_id_seq', 3, true);


--
-- Data for Name: notifications_users; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY notifications_users (id, notification_id, user_id, created_at, updated_at) FROM stdin;
1	1	5	\N	\N
2	2	6	\N	\N
3	2	5	\N	\N
4	3	4	\N	\N
5	3	6	\N	\N
\.


--
-- Name: notifications_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dylan
--

SELECT pg_catalog.setval('notifications_users_id_seq', 5, true);


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY posts (id, user_id, text, video_url, created_at, updated_at, post_image_file_name, post_image_content_type, post_image_file_size, post_image_updated_at) FROM stdin;
1	4	This is a first post.	\N	2013-08-08 19:28:49.678574	2013-08-08 19:28:49.750084	\N	\N	\N	\N
2	5	This is a second post.	\N	2013-08-08 19:28:49.682008	2013-08-08 19:28:49.755169	\N	\N	\N	\N
3	6	This is a third post.	\N	2013-08-08 19:28:49.684106	2013-08-08 19:28:49.759048	\N	\N	\N	\N
4	7	This is a fourth post.	\N	2013-08-08 19:28:49.686285	2013-08-08 19:28:49.76278	\N	\N	\N	\N
5	4	This is a fifth post.	\N	2013-08-08 19:28:49.688853	2013-08-08 19:28:49.766408	\N	\N	\N	\N
6	5	This is a sixth post.	\N	2013-08-08 19:28:49.691529	2013-08-08 19:28:49.770066	\N	\N	\N	\N
7	6	This is a seventh post.	\N	2013-08-08 19:28:49.694458	2013-08-08 19:28:49.773689	\N	\N	\N	\N
8	7	This is a eighth post.	\N	2013-08-08 19:28:49.697101	2013-08-08 19:28:49.830159	\N	\N	\N	\N
9	4	This is a ninth post.	\N	2013-08-08 19:28:49.699134	2013-08-08 19:28:49.834108	\N	\N	\N	\N
10	5	This is a tenth post.	\N	2013-08-08 19:28:49.701445	2013-08-08 19:28:49.837595	\N	\N	\N	\N
11	6	This is a eleventh post.	\N	2013-08-08 19:28:49.703724	2013-08-08 19:28:49.841104	\N	\N	\N	\N
12	7	This is a twelfth post.	\N	2013-08-08 19:28:49.706092	2013-08-08 19:28:49.844761	\N	\N	\N	\N
13	4	This is a thirteenth post.	\N	2013-08-08 19:28:49.708168	2013-08-08 19:28:49.848313	\N	\N	\N	\N
14	5	This is a fourteenth post.	\N	2013-08-08 19:28:49.7102	2013-08-08 19:28:49.85187	\N	\N	\N	\N
15	6	This is a fifteenth post.	\N	2013-08-08 19:28:49.712104	2013-08-08 19:28:49.855334	\N	\N	\N	\N
16	7	This is a sixteenth post.	\N	2013-08-08 19:28:49.714162	2013-08-08 19:28:49.858829	\N	\N	\N	\N
17	4	This is a seventeenth post.	\N	2013-08-08 19:28:49.716412	2013-08-08 19:28:49.862403	\N	\N	\N	\N
18	5	This is a eighteenth post.	\N	2013-08-08 19:28:49.718477	2013-08-08 19:28:49.865947	\N	\N	\N	\N
19	6	This is a nineteenth post.	\N	2013-08-08 19:28:49.720443	2013-08-08 19:28:49.869475	\N	\N	\N	\N
20	7	This is a twentieth post.	\N	2013-08-08 19:28:49.722359	2013-08-08 19:28:49.872847	\N	\N	\N	\N
21	4	This is twenty-first post.	\N	2013-08-08 19:28:49.724378	2013-08-08 19:28:49.876826	\N	\N	\N	\N
22	5	This is twenty-second post.	\N	2013-08-08 19:28:49.726431	2013-08-08 19:28:49.882312	\N	\N	\N	\N
23	6	This is twenty-third post.	\N	2013-08-08 19:28:49.728407	2013-08-08 19:28:49.886446	\N	\N	\N	\N
24	7	This is twenty-fourth post.	\N	2013-08-08 19:28:49.730437	2013-08-08 19:28:49.890151	\N	\N	\N	\N
25	4	This is twenty-fifth post.	\N	2013-08-08 19:28:49.732389	2013-08-08 19:28:49.893695	\N	\N	\N	\N
26	5	This is twenty-sixth post.	\N	2013-08-08 19:28:49.734386	2013-08-08 19:28:49.897297	\N	\N	\N	\N
27	6	This is twenty-seventh post.	\N	2013-08-08 19:28:49.736299	2013-08-08 19:28:49.90105	\N	\N	\N	\N
28	7	This is twenty-eighth post.	\N	2013-08-08 19:28:49.738139	2013-08-08 19:28:49.904762	\N	\N	\N	\N
29	4	This is twenty-ninth post.	\N	2013-08-08 19:28:49.74013	2013-08-08 19:28:49.908399	\N	\N	\N	\N
30	5	This is thirtieth post.	\N	2013-08-08 19:28:49.742129	2013-08-08 19:28:49.912198	\N	\N	\N	\N
\.


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dylan
--

SELECT pg_catalog.setval('posts_id_seq', 30, true);


--
-- Data for Name: program_marquees; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY program_marquees (id, user_id, created_at, updated_at, marquee_file_name, marquee_content_type, marquee_file_size, marquee_updated_at) FROM stdin;
\.


--
-- Name: program_marquees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dylan
--

SELECT pg_catalog.setval('program_marquees_id_seq', 1, false);


--
-- Data for Name: programs; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY programs (id, name, created_at, updated_at) FROM stdin;
1	Student Rep Portal	2013-08-08 19:28:49.454576	2013-08-08 19:28:49.454576
\.


--
-- Name: programs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dylan
--

SELECT pg_catalog.setval('programs_id_seq', 1, true);


--
-- Data for Name: programs_schools; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY programs_schools (id, program_id, school_id, created_at, updated_at) FROM stdin;
1	1	1	\N	\N
2	1	2	\N	\N
3	1	3	\N	\N
4	1	4	\N	\N
5	1	5	\N	\N
6	1	6	\N	\N
7	1	7	\N	\N
8	1	8	\N	\N
9	1	9	\N	\N
10	1	10	\N	\N
11	1	11	\N	\N
12	1	12	\N	\N
13	1	13	\N	\N
14	1	14	\N	\N
15	1	15	\N	\N
16	1	16	\N	\N
17	1	17	\N	\N
18	1	18	\N	\N
19	1	19	\N	\N
20	1	20	\N	\N
21	1	21	\N	\N
22	1	22	\N	\N
23	1	23	\N	\N
\.


--
-- Name: programs_schools_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dylan
--

SELECT pg_catalog.setval('programs_schools_id_seq', 23, true);


--
-- Data for Name: programs_users; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY programs_users (id, program_id, user_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	1	4
5	1	5
6	1	6
7	1	7
\.


--
-- Name: programs_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dylan
--

SELECT pg_catalog.setval('programs_users_id_seq', 7, true);


--
-- Data for Name: ratings; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY ratings (id, rating, post_id, event_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: ratings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dylan
--

SELECT pg_catalog.setval('ratings_id_seq', 1, false);


--
-- Data for Name: regions; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY regions (id, name, created_at, updated_at) FROM stdin;
1	North	2013-08-08 19:28:49.543383	2013-08-08 19:28:49.543383
2	East	2013-08-08 19:28:49.546115	2013-08-08 19:28:49.546115
3	South	2013-08-08 19:28:49.547442	2013-08-08 19:28:49.547442
4	West	2013-08-08 19:28:49.548591	2013-08-08 19:28:49.548591
\.


--
-- Name: regions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dylan
--

SELECT pg_catalog.setval('regions_id_seq', 4, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY schema_migrations (version) FROM stdin;
20130515063233
20130515063505
20130519060535
20130519154612
20130529043843
20130529200200
20130529200215
20130604202935
20130607060328
20130607135330
20130607135408
20130607141035
20130607141654
20130607173221
20130612231524
20130612231553
20130614000725
20130625190609
20130625190705
20130625190831
20130625201327
20130625201403
20130625234142
20130625234226
20130625234305
20130710044515
20130803050947
20130803230446
20130803230845
20130803231958
20130804042844
20130804043428
20130808183828
\.


--
-- Data for Name: schools; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY schools (id, created_at, updated_at, school_logo_file_name, school_logo_content_type, school_logo_file_size, school_logo_updated_at, name) FROM stdin;
1	2013-06-13 21:53:34	2013-06-13 22:34:48	boston_university.png	image/png	18799	2013-06-13 22:34:48	Boston University
2	2013-06-13 21:53:34	2013-06-13 22:35:20	colorado_state.png	image/png	47266	2013-06-13 22:35:19	Colorado State University
3	2013-06-13 21:53:34	2013-06-13 22:35:39	cornell.png	image/png	62615	2013-06-13 22:35:39	Cornell University
4	2013-06-13 21:53:34	2013-06-13 22:36:04	nyu.png	image/png	37987	2013-06-13 22:36:04	NYU
5	2013-06-13 21:53:34	2013-06-13 22:36:19	northwestern.png	image/png	122743	2013-06-13 22:36:18	Northwestern University
6	2013-06-13 21:53:34	2013-06-13 22:36:32	ohio_state.png	image/png	26728	2013-06-13 22:36:31	Ohio State University
7	2013-06-13 21:53:34	2013-06-13 22:36:46	penn_state.png	image/png	10689	2013-06-13 22:36:45	Pennsylvania State University
8	2013-06-13 21:53:34	2013-06-13 22:37:10	stanford.png	image/png	36702	2013-06-13 22:37:09	Stanford University
9	2013-06-13 21:53:34	2013-06-13 22:37:33	texas_tech.png	image/png	10297	2013-06-13 22:37:33	Texas Tech University
10	2013-06-13 21:53:34	2013-06-13 22:37:55	ucla.png	image/png	31962	2013-06-13 22:37:54	UCLA
11	2013-06-13 21:53:34	2013-06-13 21:53:46	arizona.png	image/png	15802	2013-06-13 21:53:46	University of Arizona
12	2013-06-13 21:53:34	2013-06-13 22:38:16	berkeley.png	image/png	40855	2013-06-13 22:38:15	University of California, Berkeley
13	2013-06-13 21:53:34	2013-06-13 22:38:31	florida.png	image/png	45579	2013-06-13 22:38:31	University of Central Florida
14	2013-06-13 21:53:34	2013-06-13 22:38:45	u_conn.png	image/png	25757	2013-06-13 22:38:44	University of Connecticut
15	2013-06-13 21:53:34	2013-06-13 22:40:52	u_maryland.png	image/png	21496	2013-06-13 22:40:51	University of Maryland
16	2013-06-13 21:53:34	2013-06-13 22:41:30	u_mass_lowell.png	image/png	30963	2013-06-13 22:41:30	University of Massachusetts
17	2013-06-13 21:53:34	2013-06-13 22:41:48	u_michigan.png	image/png	20542	2013-06-13 22:41:47	University of Michigan
18	2013-06-13 21:53:34	2013-06-13 22:42:02	u_minnesota.png	image/png	19753	2013-06-13 22:42:01	University of Minnesota
19	2013-06-13 21:53:34	2013-06-13 22:40:38	u_oregon.png	image/png	19010	2013-06-13 22:40:37	University of Oregon
20	2013-06-13 21:53:34	2013-06-13 22:40:23	u_tenn.png	image/png	7488	2013-06-13 22:40:22	University of Tennessee, Knoxville
21	2013-06-13 21:53:34	2013-06-13 22:40:07	u_texas_austin.png	image/png	35005	2013-06-13 22:40:07	University of Texas, Austin
22	2013-06-13 21:53:34	2013-06-13 22:39:48	u_utah.png	image/png	13434	2013-06-13 22:39:47	University of Utah
23	2013-06-13 21:53:34	2013-06-13 22:39:03	u_wash.png	image/png	4706	2013-06-13 22:39:03	University of Washington
\.


--
-- Name: schools_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dylan
--

SELECT pg_catalog.setval('schools_id_seq', 1, false);


--
-- Data for Name: tools; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY tools (id, user_id, adobe_product_id, name, skill_level, created_at, updated_at) FROM stdin;
\.


--
-- Name: tools_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dylan
--

SELECT pg_catalog.setval('tools_id_seq', 1, false);


--
-- Data for Name: user_applications; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY user_applications (id, created_at, updated_at, user_id, gender, street_address, street_address2, city, state, postal_code, country, planned_grad_year, planned_grad_term, major, minor, gpa, num_facebook_friends, instagram_username, num_instagram_followers, twitter_username, num_twitter_followers, other_social_sites, member_design_community, portfolio_url, behance_profile_url, extracurriculars, extracurricular_leadership, leadership_description, reference_name, reference_relationship, reference_email, reference_phone, how_adobe_helps, student_orgs_and_leverage, teaching_experience, what_sets_you_apart, do_you_have_time, available_to_work, video_submission_url, resume_file_name, resume_content_type, resume_file_size, resume_updated_at) FROM stdin;
1	2013-08-08 19:28:49.401738	2013-08-08 19:28:49.401738	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2	2013-08-08 19:28:49.409589	2013-08-08 19:28:49.409589	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3	2013-08-08 19:28:49.415899	2013-08-08 19:28:49.415899	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4	2013-08-08 19:28:49.422103	2013-08-08 19:28:49.422103	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5	2013-08-08 19:28:49.428113	2013-08-08 19:28:49.428113	5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6	2013-08-08 19:28:49.433871	2013-08-08 19:28:49.433871	6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7	2013-08-08 19:28:49.439551	2013-08-08 19:28:49.439551	7	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Name: user_applications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dylan
--

SELECT pg_catalog.setval('user_applications_id_seq', 7, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at, first_name, last_name, admin, authentication_token, provider, uid, active_for_authentication, school_id, mobile_phone, points, current_program_id, avatar_file_name, avatar_content_type, avatar_file_size, avatar_updated_at, bio) FROM stdin;
2	vince@whoisowenjones.com	$2a$10$btEN1wy3rfw7IjslcyiBzuLaKqCXCJ4uIM/5eswe48U33KKuiJciG	\N	\N	\N	0	\N	\N	\N	\N	2013-08-08 19:28:49.408222	2013-08-08 19:28:49.408222	Vince	Ready	t	\N	\N	\N	t	\N	\N	\N	1	Passport-photo.jpg	image/jpeg	24460	2013-07-01 16:19:41	\N
3	paul@kingbirdcreative.com	$2a$10$v8c8mHrmx/YvkPIDzeFesOBGBSLTi96mSX43hULiaYZiodoMZhVMa	\N	\N	\N	0	\N	\N	\N	\N	2013-08-08 19:28:49.414264	2013-08-08 19:28:49.414264	Paul	Terhaar	t	\N	\N	\N	t	\N	\N	\N	1	\N	\N	\N	\N	\N
4	idahotallpaul@gmail.com	$2a$10$v8c8mHrmx/YvkPIDzeFesOBGBSLTi96mSX43hULiaYZiodoMZhVMa	\N	\N	\N	0	\N	\N	\N	\N	2013-08-08 19:28:49.420642	2013-08-08 19:28:49.420642	Paul	Terhaar	f	\N	\N	\N	t	\N	\N	\N	1	\N	\N	\N	\N	\N
7	vready@gmail.com	$2a$10$3NJlsyoiGbjoqLe2HE8MzOz/q6gknBsNbClndSTPyufBH2h5smFIO	\N	\N	\N	0	\N	\N	\N	\N	2013-08-08 19:28:49.438265	2013-08-08 19:28:49.438265	Vince	Ready	f	\N	\N	\N	t	\N	\N	\N	1	Passport-photo.jpg	image/jpeg	24460	2013-07-01 16:18:35	\N
6	hello@nightlang.org	$2a$10$v8c8mHrmx/YvkPIDzeFesOBGBSLTi96mSX43hULiaYZiodoMZhVMa	\N	\N	\N	1	2013-08-09 05:07:21.476195	2013-08-09 05:07:21.476195	127.0.0.1	127.0.0.1	2013-08-08 19:28:49.432549	2013-08-09 05:07:21.478115	John	Tongue	f	\N	\N	\N	t	\N	\N	\N	1	IMG_0244.JPG	image/jpeg	2270075	2013-07-01 16:19:09	\N
5	foliomedia2@yahoo.com	$2a$10$TwVWBd5ilT7kmwhXI3gMmuB1CfLOku/hGgQIne1avyKpA0Byzj496	\N	\N	\N	2	2013-08-09 05:13:52.95814	2013-08-09 05:10:59.104851	127.0.0.1	127.0.0.1	2013-08-08 19:28:49.426625	2013-08-09 05:13:52.959281	Michael	Hfuhruhurr	f	\N	\N	\N	t	\N	\N	\N	1	IMG_0183.JPG	image/jpeg	526949	2013-07-01 16:18:12	\N
1	dylan@whoisowenjones.com	$2a$10$P7RHrSrfkKo/LXXSLFOa3e55McrcHH9Ket1/P3bCzv4sJtP9G2g7y	\N	\N	\N	2	2013-08-09 05:17:33.962914	2013-08-09 05:11:24.905907	127.0.0.1	127.0.0.1	2013-08-08 19:28:49.398924	2013-08-09 05:17:33.964264	Dylan	Smith	t	\N	\N	\N	t	\N	\N	\N	1	IMG_0293.JPG	image/jpeg	2131577	2013-07-01 16:20:09	\N
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dylan
--

SELECT pg_catalog.setval('users_id_seq', 7, true);


--
-- Name: adobe_products_pkey; Type: CONSTRAINT; Schema: public; Owner: dylan; Tablespace: 
--

ALTER TABLE ONLY adobe_products
    ADD CONSTRAINT adobe_products_pkey PRIMARY KEY (id);


--
-- Name: comments_pkey; Type: CONSTRAINT; Schema: public; Owner: dylan; Tablespace: 
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: event_types_pkey; Type: CONSTRAINT; Schema: public; Owner: dylan; Tablespace: 
--

ALTER TABLE ONLY event_types
    ADD CONSTRAINT event_types_pkey PRIMARY KEY (id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: public; Owner: dylan; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: likes_pkey; Type: CONSTRAINT; Schema: public; Owner: dylan; Tablespace: 
--

ALTER TABLE ONLY likes
    ADD CONSTRAINT likes_pkey PRIMARY KEY (id);


--
-- Name: links_pkey; Type: CONSTRAINT; Schema: public; Owner: dylan; Tablespace: 
--

ALTER TABLE ONLY links
    ADD CONSTRAINT links_pkey PRIMARY KEY (id);


--
-- Name: notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: dylan; Tablespace: 
--

ALTER TABLE ONLY notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: notifications_users_pkey; Type: CONSTRAINT; Schema: public; Owner: dylan; Tablespace: 
--

ALTER TABLE ONLY notifications_users
    ADD CONSTRAINT notifications_users_pkey PRIMARY KEY (id);


--
-- Name: posts_pkey; Type: CONSTRAINT; Schema: public; Owner: dylan; Tablespace: 
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: program_marquees_pkey; Type: CONSTRAINT; Schema: public; Owner: dylan; Tablespace: 
--

ALTER TABLE ONLY program_marquees
    ADD CONSTRAINT program_marquees_pkey PRIMARY KEY (id);


--
-- Name: programs_pkey; Type: CONSTRAINT; Schema: public; Owner: dylan; Tablespace: 
--

ALTER TABLE ONLY programs
    ADD CONSTRAINT programs_pkey PRIMARY KEY (id);


--
-- Name: programs_schools_pkey; Type: CONSTRAINT; Schema: public; Owner: dylan; Tablespace: 
--

ALTER TABLE ONLY programs_schools
    ADD CONSTRAINT programs_schools_pkey PRIMARY KEY (id);


--
-- Name: programs_users_pkey; Type: CONSTRAINT; Schema: public; Owner: dylan; Tablespace: 
--

ALTER TABLE ONLY programs_users
    ADD CONSTRAINT programs_users_pkey PRIMARY KEY (id);


--
-- Name: ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: dylan; Tablespace: 
--

ALTER TABLE ONLY ratings
    ADD CONSTRAINT ratings_pkey PRIMARY KEY (id);


--
-- Name: regions_pkey; Type: CONSTRAINT; Schema: public; Owner: dylan; Tablespace: 
--

ALTER TABLE ONLY regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (id);


--
-- Name: schools_pkey; Type: CONSTRAINT; Schema: public; Owner: dylan; Tablespace: 
--

ALTER TABLE ONLY schools
    ADD CONSTRAINT schools_pkey PRIMARY KEY (id);


--
-- Name: tools_pkey; Type: CONSTRAINT; Schema: public; Owner: dylan; Tablespace: 
--

ALTER TABLE ONLY tools
    ADD CONSTRAINT tools_pkey PRIMARY KEY (id);


--
-- Name: user_applications_pkey; Type: CONSTRAINT; Schema: public; Owner: dylan; Tablespace: 
--

ALTER TABLE ONLY user_applications
    ADD CONSTRAINT user_applications_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: dylan; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_comments_on_post_id; Type: INDEX; Schema: public; Owner: dylan; Tablespace: 
--

CREATE INDEX index_comments_on_post_id ON comments USING btree (post_id);


--
-- Name: index_comments_on_user_id; Type: INDEX; Schema: public; Owner: dylan; Tablespace: 
--

CREATE INDEX index_comments_on_user_id ON comments USING btree (user_id);


--
-- Name: index_posts_on_user_id; Type: INDEX; Schema: public; Owner: dylan; Tablespace: 
--

CREATE INDEX index_posts_on_user_id ON posts USING btree (user_id);


--
-- Name: index_program_marquees_on_user_id; Type: INDEX; Schema: public; Owner: dylan; Tablespace: 
--

CREATE INDEX index_program_marquees_on_user_id ON program_marquees USING btree (user_id);


--
-- Name: index_user_applications_on_user_id; Type: INDEX; Schema: public; Owner: dylan; Tablespace: 
--

CREATE INDEX index_user_applications_on_user_id ON user_applications USING btree (user_id);


--
-- Name: index_users_on_current_program_id; Type: INDEX; Schema: public; Owner: dylan; Tablespace: 
--

CREATE INDEX index_users_on_current_program_id ON users USING btree (current_program_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: dylan; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: dylan; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_users_on_school_id; Type: INDEX; Schema: public; Owner: dylan; Tablespace: 
--

CREATE INDEX index_users_on_school_id ON users USING btree (school_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: dylan; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

