--
-- PostgreSQL database dump
--

-- Dumped from database version 11.4
-- Dumped by pg_dump version 11.4

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

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: projects; Type: TABLE; Schema: public; Owner: ben
--

CREATE TABLE public.projects (
    id integer NOT NULL,
    title character varying NOT NULL
);


ALTER TABLE public.projects OWNER TO ben;

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: ben
--

CREATE SEQUENCE public.projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.projects_id_seq OWNER TO ben;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ben
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: volunteers; Type: TABLE; Schema: public; Owner: ben
--

CREATE TABLE public.volunteers (
    id integer NOT NULL,
    name character varying NOT NULL,
    project_id integer NOT NULL
);


ALTER TABLE public.volunteers OWNER TO ben;

--
-- Name: volunteers_id_seq; Type: SEQUENCE; Schema: public; Owner: ben
--

CREATE SEQUENCE public.volunteers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.volunteers_id_seq OWNER TO ben;

--
-- Name: volunteers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ben
--

ALTER SEQUENCE public.volunteers_id_seq OWNED BY public.volunteers.id;


--
-- Name: volunteers_project_id_seq; Type: SEQUENCE; Schema: public; Owner: ben
--

CREATE SEQUENCE public.volunteers_project_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.volunteers_project_id_seq OWNER TO ben;

--
-- Name: volunteers_project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ben
--

ALTER SEQUENCE public.volunteers_project_id_seq OWNED BY public.volunteers.project_id;


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: ben
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: volunteers id; Type: DEFAULT; Schema: public; Owner: ben
--

ALTER TABLE ONLY public.volunteers ALTER COLUMN id SET DEFAULT nextval('public.volunteers_id_seq'::regclass);


--
-- Name: volunteers project_id; Type: DEFAULT; Schema: public; Owner: ben
--

ALTER TABLE ONLY public.volunteers ALTER COLUMN project_id SET DEFAULT nextval('public.volunteers_project_id_seq'::regclass);


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: ben
--

COPY public.projects (id, title) FROM stdin;
596	Teaching Kids to Code
597	Teaching Ruby to Kids
\.


--
-- Data for Name: volunteers; Type: TABLE DATA; Schema: public; Owner: ben
--

COPY public.volunteers (id, name, project_id) FROM stdin;
241	John	596
242	Jane	596
243	Kim	597
244	Kris	597
\.


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ben
--

SELECT pg_catalog.setval('public.projects_id_seq', 597, true);


--
-- Name: volunteers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ben
--

SELECT pg_catalog.setval('public.volunteers_id_seq', 244, true);


--
-- Name: volunteers_project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ben
--

SELECT pg_catalog.setval('public.volunteers_project_id_seq', 1, false);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: ben
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: volunteers volunteers_pkey; Type: CONSTRAINT; Schema: public; Owner: ben
--

ALTER TABLE ONLY public.volunteers
    ADD CONSTRAINT volunteers_pkey PRIMARY KEY (id);


--
-- Name: volunteers volunteers_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ben
--

ALTER TABLE ONLY public.volunteers
    ADD CONSTRAINT volunteers_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

