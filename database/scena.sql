--
-- PostgreSQL database dump
--

\restrict Befem0H4XDfgSeTSF8A2jvSRg7PqMgzmOmtNQs60139XGOHNtQwvqkSmHGo1nEH

-- Dumped from database version 18.6 (Ubuntu 18.6-0ubuntu0.26.04.1)
-- Dumped by pg_dump version 18.6 (Ubuntu 18.6-0ubuntu0.26.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: shows; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shows (
    id integer NOT NULL,
    titulo character varying(255) NOT NULL,
    data_show date NOT NULL,
    endereco character varying(255) NOT NULL
);


ALTER TABLE public.shows OWNER TO postgres;

--
-- Name: shows_bandas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shows_bandas (
    show_id integer NOT NULL,
    nome_banda character varying(255) NOT NULL
);


ALTER TABLE public.shows_bandas OWNER TO postgres;

--
-- Name: shows_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shows_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.shows_id_seq OWNER TO postgres;

--
-- Name: shows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shows_id_seq OWNED BY public.shows.id;


--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id integer NOT NULL,
    nome character varying(50) NOT NULL,
    email character varying(255) NOT NULL,
    senha character varying(255) NOT NULL,
    is_admin boolean DEFAULT false
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_seq OWNER TO postgres;

--
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- Name: shows id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shows ALTER COLUMN id SET DEFAULT nextval('public.shows_id_seq'::regclass);


--
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- Data for Name: shows; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shows (id, titulo, data_show, endereco) FROM stdin;
12	The Town	2027-09-07	interlagos
21	lollapalooza	2027-05-22	interlagos
23	soad e faith no more	2027-01-15	Estádio Maracanã, Rio de Janeiro
24	teste de data 	2026-10-21	teste
\.


--
-- Data for Name: shows_bandas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shows_bandas (show_id, nome_banda) FROM stdin;
12	Slipknot
12	Marilyn manson
21	charli xcx
21	fontaines d.c
21	angine de poitrine
21	die spitz
21	budang
21	the killers
23	System of a Down
23	Faith no more
24	só teste mesmo
\.


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id, nome, email, senha, is_admin) FROM stdin;
1	Teste	teste@scena.com	senha_teste	f
2	chino	chino@moreno.com	$2y$12$dGj9f/ZSmdTVjHlxFfv6/eMYF8nXJOMBeznQyeLD.Cw/xMixp9bUi	f
3	richard d. james	rich@twin.com	$2y$12$BUUXz7oKczpiuRtGaWot4ewngHmNNqLhl7iln.WvMvofbsarPX8ES	f
4	admin	admin@admin.com	$2y$12$vAosakba9XTrCCGot9KqZ.PAsL3cv7iGsSsv7OR1NL2dQ8YsyBiNG	t
5	janio quadros	jango@brasil.com	$2y$12$iG2IpDwODZhci7X7zlcW4ewPvkpgFfcOhehiq40eTfrJDEOAZReGu	f
7	teste	123@123.com	$2y$12$p8L.AUEThx1I3lF3EnjbjuxU1YbYk6ue4M1hOfjw1Og.7ZwfyfbMW	f
8	Rafael	costa@gmail.com	$2y$12$KKIkSBNm1bGzq5yreen6ze/iiy6q3pBZUD6BhHFEoNvgpdjgRZRtW	f
9	comum	comum@comum	$2y$12$M/ZN3nDXvvFBlrfU5c6d.e9v/v46dUhlIRCiMt.b7Ijx5Wdx23dPG	f
10	Jorge	jorge@jorge.com.br	$2y$12$zLCippwSpFJOgYUAvWlssuTEkqyy2ZUHkzQn104cVYsbt.tSA3eX2	f
\.


--
-- Name: shows_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shows_id_seq', 24, true);


--
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 10, true);


--
-- Name: shows_bandas shows_bandas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shows_bandas
    ADD CONSTRAINT shows_bandas_pkey PRIMARY KEY (show_id, nome_banda);


--
-- Name: shows shows_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shows
    ADD CONSTRAINT shows_pkey PRIMARY KEY (id);


--
-- Name: usuarios usuarios_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key UNIQUE (email);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- Name: shows_bandas shows_bandas_show_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shows_bandas
    ADD CONSTRAINT shows_bandas_show_id_fkey FOREIGN KEY (show_id) REFERENCES public.shows(id) ON DELETE CASCADE;


--
-- Name: TABLE shows; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.shows TO scena;


--
-- Name: TABLE shows_bandas; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.shows_bandas TO scena;


--
-- Name: SEQUENCE shows_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.shows_id_seq TO scena;


--
-- Name: TABLE usuarios; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.usuarios TO scena;


--
-- Name: SEQUENCE usuarios_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.usuarios_id_seq TO scena;


--
-- PostgreSQL database dump complete
--

\unrestrict Befem0H4XDfgSeTSF8A2jvSRg7PqMgzmOmtNQs60139XGOHNtQwvqkSmHGo1nEH

