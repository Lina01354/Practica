--
-- PostgreSQL database dump
--

\restrict NlvGduJMKU27ggbHqBAY586fS5gMMD4kNvKPpijhuwe1fYxbYyBtt7YThCRB23G

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-10-01 19:26:14

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
-- TOC entry 226 (class 1259 OID 19386)
-- Name: kategoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kategoria (
    kategoria_id integer NOT NULL,
    kategoria_name character varying(30) NOT NULL
);


ALTER TABLE public.kategoria OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 19385)
-- Name: kategoria_kategoria_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kategoria_kategoria_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.kategoria_kategoria_id_seq OWNER TO postgres;

--
-- TOC entry 5048 (class 0 OID 0)
-- Dependencies: 225
-- Name: kategoria_kategoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kategoria_kategoria_id_seq OWNED BY public.kategoria.kategoria_id;


--
-- TOC entry 4891 (class 2604 OID 19389)
-- Name: kategoria kategoria_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategoria ALTER COLUMN kategoria_id SET DEFAULT nextval('public.kategoria_kategoria_id_seq'::regclass);


--
-- TOC entry 5042 (class 0 OID 19386)
-- Dependencies: 226
-- Data for Name: kategoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kategoria VALUES (1, 'Детская обувь');
INSERT INTO public.kategoria VALUES (2, 'Женская обувь');
INSERT INTO public.kategoria VALUES (3, 'Мужская обувь');


--
-- TOC entry 5049 (class 0 OID 0)
-- Dependencies: 225
-- Name: kategoria_kategoria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kategoria_kategoria_id_seq', 3, true);


--
-- TOC entry 4893 (class 2606 OID 19393)
-- Name: kategoria kategoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategoria
    ADD CONSTRAINT kategoria_pkey PRIMARY KEY (kategoria_id);


-- Completed on 2026-10-01 19:26:14

--
-- PostgreSQL database dump complete
--

\unrestrict NlvGduJMKU27ggbHqBAY586fS5gMMD4kNvKPpijhuwe1fYxbYyBtt7YThCRB23G

