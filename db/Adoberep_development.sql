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
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: dylan; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO dylan;

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
    uid character varying(255)
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

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY schema_migrations (version) FROM stdin;
20130515063233
20130515063505
20130516210715
20130519060535
20130519154612
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at, first_name, last_name, admin, authentication_token, provider, uid) FROM stdin;
82	hello@nightlang.org	$2a$10$v8c8mHrmx/YvkPIDzeFesOBGBSLTi96mSX43hULiaYZiodoMZhVMa	uy4CsCqSsxw5EkMBbt1L	2013-05-27 06:56:14.548125	\N	1	2013-05-27 16:18:39.4988	2013-05-27 16:18:39.4988	127.0.0.1	127.0.0.1	2013-05-27 06:56:14.546528	2013-05-27 16:18:39.500011	John	Tongue	f	\N	\N	\N
81	foliomedia2@yahoo.com	$2a$10$TwVWBd5ilT7kmwhXI3gMmuB1CfLOku/hGgQIne1avyKpA0Byzj496	zpppGcWy2xZ2szz2DfnG	2013-05-27 06:56:13.851243	\N	3	2013-05-28 15:53:06.544754	2013-05-28 05:10:34.083651	127.0.0.1	127.0.0.1	2013-05-27 06:56:13.843989	2013-05-28 15:53:06.547917	Michael	Hfuhruhurr	f	CAADmzjuhoH8BAM0ktBGS23UcSw5nu6v7YTLEbAJKazOpg1TbENPv6IAoNIb8eDobhw43nhi2eQreC2UTNKSHt9BVZCeDu9SBFPnGfyfFHwKYFjlZASpaeLlGt8yxIaoYRXlbjQZAWlLovXuak4X	facebook	100000689107298
45	dylan@whoisowenjones.com	$2a$10$P7RHrSrfkKo/LXXSLFOa3e55McrcHH9Ket1/P3bCzv4sJtP9G2g7y	yb4buEN7UVXQruyeZVQ4	2013-05-27 02:13:06.556941	\N	16	2013-05-28 15:54:05.20388	2013-05-28 05:11:21.028808	127.0.0.1	127.0.0.1	2013-05-27 02:13:06.549201	2013-05-28 15:54:05.204896	Dylan	Smith	t	CAADmzjuhoH8BAFCfTa6aiKghkRplZCA8pLVXe9m9uiC1dfDqi7CzIZCGM7IgX5QZAN8BZCZCFuuGpytUI3Djg3gjeX4T87s6F5MQRbgJz0vx6MH9uMXAsGIvK2kiyXAUCXQu0bWtYgQxZB8IflZCc7c	facebook	100005976664425
112	vready@gmail.com	$2a$10$btEN1wy3rfw7IjslcyiBzuLaKqCXCJ4uIM/5eswe48U33KKuiJciG	\N	\N	\N	1	2013-05-28 16:03:21.720971	2013-05-28 16:03:21.720971	192.168.0.114	192.168.0.114	2013-05-28 15:55:24.531348	2013-05-28 16:03:21.721826	Vince	Ready	f	\N	\N	\N
113	vince@whoisowenjones.com	$2a$10$3NJlsyoiGbjoqLe2HE8MzOz/q6gknBsNbClndSTPyufBH2h5smFIO	\N	\N	\N	1	2013-05-28 16:19:44.280982	2013-05-28 16:19:44.280982	192.168.0.114	192.168.0.114	2013-05-28 16:18:03.853527	2013-05-28 16:19:44.281884	Vince	Ready	f	\N	\N	\N
114	test@user.com	$2a$10$btEN1wy3rfw7IjslcyiBzuLaKqCXCJ4uIM/5eswe48U33KKuiJciG	sFysUM7MsmzwxteRFU9m	2013-05-28 16:49:36.620852	\N	0	\N	\N	\N	\N	2013-05-28 16:49:36.616244	2013-05-28 16:49:36.616244	Test	User	f	\N	\N	\N
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dylan
--

SELECT pg_catalog.setval('users_id_seq', 114, true);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: dylan; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: dylan; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: dylan; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: dylan; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: public; Type: ACL; Schema: -; Owner: dylan
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM dylan;
GRANT ALL ON SCHEMA public TO dylan;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

