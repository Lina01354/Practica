--
-- PostgreSQL database dump
--

\restrict 3nBAvtB6z4KzZAGS0XDdiLZmvLguHQ0o4mOFyuAh7SkZ8mZZSciaPgZ6nZzDdYt

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-10-01 15:25:55

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
-- TOC entry 224 (class 1259 OID 17940)
-- Name: kategoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kategoria (
    kategoria_id integer NOT NULL,
    kategoria_name character varying(100) NOT NULL
);


ALTER TABLE public.kategoria OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17939)
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
-- TOC entry 5112 (class 0 OID 0)
-- Dependencies: 223
-- Name: kategoria_kategoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kategoria_kategoria_id_seq OWNED BY public.kategoria.kategoria_id;


--
-- TOC entry 234 (class 1259 OID 17987)
-- Name: models; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.models (
    model_id integer NOT NULL,
    model_name character varying(100) NOT NULL,
    kategoria_id integer NOT NULL,
    proisvoditel_id integer NOT NULL,
    prozeser_id integer NOT NULL,
    op_pamit_id integer NOT NULL,
    nacopitel_id integer NOT NULL,
    izobrazenie character varying(100) NOT NULL,
    zena integer NOT NULL,
    kolvo_na_sklade integer
);


ALTER TABLE public.models OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 17986)
-- Name: models_model_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.models_model_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.models_model_id_seq OWNER TO postgres;

--
-- TOC entry 5113 (class 0 OID 0)
-- Dependencies: 233
-- Name: models_model_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.models_model_id_seq OWNED BY public.models.model_id;


--
-- TOC entry 232 (class 1259 OID 17977)
-- Name: nacopitel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nacopitel (
    nacopitel_id integer NOT NULL,
    obem character varying(30) NOT NULL,
    zena integer NOT NULL
);


ALTER TABLE public.nacopitel OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17976)
-- Name: nacopitel_nacopitel_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nacopitel_nacopitel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.nacopitel_nacopitel_id_seq OWNER TO postgres;

--
-- TOC entry 5114 (class 0 OID 0)
-- Dependencies: 231
-- Name: nacopitel_nacopitel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nacopitel_nacopitel_id_seq OWNED BY public.nacopitel.nacopitel_id;


--
-- TOC entry 230 (class 1259 OID 17967)
-- Name: op_pamit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.op_pamit (
    op_pamit_id integer NOT NULL,
    obem character varying(30) NOT NULL,
    zena integer NOT NULL
);


ALTER TABLE public.op_pamit OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17966)
-- Name: op_pamit_op_pamit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.op_pamit_op_pamit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.op_pamit_op_pamit_id_seq OWNER TO postgres;

--
-- TOC entry 5115 (class 0 OID 0)
-- Dependencies: 229
-- Name: op_pamit_op_pamit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.op_pamit_op_pamit_id_seq OWNED BY public.op_pamit.op_pamit_id;


--
-- TOC entry 238 (class 1259 OID 18044)
-- Name: pozitia_zakaza; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pozitia_zakaza (
    pozitia_zakaza_id integer NOT NULL,
    model_id integer NOT NULL,
    zakaz_id integer NOT NULL,
    kolvo_v_pozitii integer
);


ALTER TABLE public.pozitia_zakaza OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 18043)
-- Name: pozitia_zakaza_pozitia_zakaza_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pozitia_zakaza_pozitia_zakaza_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pozitia_zakaza_pozitia_zakaza_id_seq OWNER TO postgres;

--
-- TOC entry 5116 (class 0 OID 0)
-- Dependencies: 237
-- Name: pozitia_zakaza_pozitia_zakaza_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pozitia_zakaza_pozitia_zakaza_id_seq OWNED BY public.pozitia_zakaza.pozitia_zakaza_id;


--
-- TOC entry 226 (class 1259 OID 17949)
-- Name: proisvoditel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.proisvoditel (
    proisvoditel_id integer NOT NULL,
    proisvoditel_name character varying(100) NOT NULL
);


ALTER TABLE public.proisvoditel OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17948)
-- Name: proisvoditel_proisvoditel_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.proisvoditel_proisvoditel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.proisvoditel_proisvoditel_id_seq OWNER TO postgres;

--
-- TOC entry 5117 (class 0 OID 0)
-- Dependencies: 225
-- Name: proisvoditel_proisvoditel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.proisvoditel_proisvoditel_id_seq OWNED BY public.proisvoditel.proisvoditel_id;


--
-- TOC entry 228 (class 1259 OID 17958)
-- Name: prozeser; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prozeser (
    prozeser_id integer NOT NULL,
    prozeser_name character varying(100) NOT NULL,
    zena integer
);


ALTER TABLE public.prozeser OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17957)
-- Name: prozeser_prozeser_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prozeser_prozeser_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prozeser_prozeser_id_seq OWNER TO postgres;

--
-- TOC entry 5118 (class 0 OID 0)
-- Dependencies: 227
-- Name: prozeser_prozeser_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prozeser_prozeser_id_seq OWNED BY public.prozeser.prozeser_id;


--
-- TOC entry 220 (class 1259 OID 17915)
-- Name: rols; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rols (
    rol_id integer NOT NULL,
    name character varying(10) NOT NULL
);


ALTER TABLE public.rols OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17914)
-- Name: rols_rol_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rols_rol_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rols_rol_id_seq OWNER TO postgres;

--
-- TOC entry 5119 (class 0 OID 0)
-- Dependencies: 219
-- Name: rols_rol_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rols_rol_id_seq OWNED BY public.rols.rol_id;


--
-- TOC entry 222 (class 1259 OID 17924)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    name character varying(100) NOT NULL,
    familia character varying(100) NOT NULL,
    otchestvo character varying(100),
    pfone character varying(30) NOT NULL,
    rol_id integer
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17923)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- TOC entry 5120 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 236 (class 1259 OID 18028)
-- Name: zakazi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.zakazi (
    zakaz_id integer NOT NULL,
    user_id integer NOT NULL,
    zena integer NOT NULL,
    data_zakaza date NOT NULL,
    kolvo_v_zakaze integer
);


ALTER TABLE public.zakazi OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 18027)
-- Name: zakazi_zakaz_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.zakazi_zakaz_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.zakazi_zakaz_id_seq OWNER TO postgres;

--
-- TOC entry 5121 (class 0 OID 0)
-- Dependencies: 235
-- Name: zakazi_zakaz_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.zakazi_zakaz_id_seq OWNED BY public.zakazi.zakaz_id;


--
-- TOC entry 4903 (class 2604 OID 17943)
-- Name: kategoria kategoria_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategoria ALTER COLUMN kategoria_id SET DEFAULT nextval('public.kategoria_kategoria_id_seq'::regclass);


--
-- TOC entry 4908 (class 2604 OID 17990)
-- Name: models model_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.models ALTER COLUMN model_id SET DEFAULT nextval('public.models_model_id_seq'::regclass);


--
-- TOC entry 4907 (class 2604 OID 17980)
-- Name: nacopitel nacopitel_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacopitel ALTER COLUMN nacopitel_id SET DEFAULT nextval('public.nacopitel_nacopitel_id_seq'::regclass);


--
-- TOC entry 4906 (class 2604 OID 17970)
-- Name: op_pamit op_pamit_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.op_pamit ALTER COLUMN op_pamit_id SET DEFAULT nextval('public.op_pamit_op_pamit_id_seq'::regclass);


--
-- TOC entry 4910 (class 2604 OID 18047)
-- Name: pozitia_zakaza pozitia_zakaza_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pozitia_zakaza ALTER COLUMN pozitia_zakaza_id SET DEFAULT nextval('public.pozitia_zakaza_pozitia_zakaza_id_seq'::regclass);


--
-- TOC entry 4904 (class 2604 OID 17952)
-- Name: proisvoditel proisvoditel_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proisvoditel ALTER COLUMN proisvoditel_id SET DEFAULT nextval('public.proisvoditel_proisvoditel_id_seq'::regclass);


--
-- TOC entry 4905 (class 2604 OID 17961)
-- Name: prozeser prozeser_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prozeser ALTER COLUMN prozeser_id SET DEFAULT nextval('public.prozeser_prozeser_id_seq'::regclass);


--
-- TOC entry 4901 (class 2604 OID 17918)
-- Name: rols rol_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rols ALTER COLUMN rol_id SET DEFAULT nextval('public.rols_rol_id_seq'::regclass);


--
-- TOC entry 4902 (class 2604 OID 17927)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 4909 (class 2604 OID 18031)
-- Name: zakazi zakaz_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zakazi ALTER COLUMN zakaz_id SET DEFAULT nextval('public.zakazi_zakaz_id_seq'::regclass);


--
-- TOC entry 5092 (class 0 OID 17940)
-- Dependencies: 224
-- Data for Name: kategoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kategoria VALUES (1, 'Игровой');
INSERT INTO public.kategoria VALUES (2, 'Рабочий');


--
-- TOC entry 5102 (class 0 OID 17987)
-- Dependencies: 234
-- Data for Name: models; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.models VALUES (1, 'Модель1', 1, 1, 1, 1, 1, 'имп/файл1.пнг', 10000, 52);
INSERT INTO public.models VALUES (2, 'Модель1', 1, 1, 1, 2, 2, 'имп/файл2.пнг', 11000, 45);
INSERT INTO public.models VALUES (3, 'Модель2', 2, 1, 2, 1, 3, 'имп/файл1.пнг', 10500, 22);
INSERT INTO public.models VALUES (4, 'Модель3', 2, 2, 1, 3, 2, 'имп/файл1.пнг', 15000, 56);


--
-- TOC entry 5100 (class 0 OID 17977)
-- Dependencies: 232
-- Data for Name: nacopitel; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.nacopitel VALUES (1, 'НАКОПИТЕЛЬ1', 201);
INSERT INTO public.nacopitel VALUES (2, 'НАКОПИТЕЛЬ2', 301);
INSERT INTO public.nacopitel VALUES (3, 'НАКОПИТЕЛЬ3', 351);


--
-- TOC entry 5098 (class 0 OID 17967)
-- Dependencies: 230
-- Data for Name: op_pamit; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.op_pamit VALUES (1, 'Оп_память1', 200);
INSERT INTO public.op_pamit VALUES (2, 'Оп_память2', 300);
INSERT INTO public.op_pamit VALUES (3, 'Оп_память3', 350);


--
-- TOC entry 5106 (class 0 OID 18044)
-- Dependencies: 238
-- Data for Name: pozitia_zakaza; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pozitia_zakaza VALUES (1, 4, 1, 1);
INSERT INTO public.pozitia_zakaza VALUES (2, 4, 2, 1);
INSERT INTO public.pozitia_zakaza VALUES (3, 1, 2, 1);
INSERT INTO public.pozitia_zakaza VALUES (4, 2, 2, 1);


--
-- TOC entry 5094 (class 0 OID 17949)
-- Dependencies: 226
-- Data for Name: proisvoditel; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.proisvoditel VALUES (1, 'Дяда Вася');
INSERT INTO public.proisvoditel VALUES (2, 'Дядя Петя');


--
-- TOC entry 5096 (class 0 OID 17958)
-- Dependencies: 228
-- Data for Name: prozeser; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.prozeser VALUES (1, 'Процессор1', NULL);
INSERT INTO public.prozeser VALUES (2, 'Процессор2', NULL);


--
-- TOC entry 5088 (class 0 OID 17915)
-- Dependencies: 220
-- Data for Name: rols; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.rols VALUES (1, 'админ');
INSERT INTO public.rols VALUES (2, 'модератор');
INSERT INTO public.rols VALUES (3, 'клиет');


--
-- TOC entry 5090 (class 0 OID 17924)
-- Dependencies: 222
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (1, 'Имя1', 'Фамилия1', 'Отчество1', '+71234567890', 3);
INSERT INTO public.users VALUES (2, 'Имя2', 'Фамилия2', 'Отчество2', '+71234567891', 3);
INSERT INTO public.users VALUES (3, 'Имя3', 'Фамилия3', 'Отчество3', '+71234567892', 2);
INSERT INTO public.users VALUES (4, 'Имя4', 'Фамилия4', 'Отчество4', '+71234567893', 1);


--
-- TOC entry 5104 (class 0 OID 18028)
-- Dependencies: 236
-- Data for Name: zakazi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.zakazi VALUES (1, 1, 15000, '2025-10-15', 1);
INSERT INTO public.zakazi VALUES (2, 1, 36000, '2025-10-15', 3);


--
-- TOC entry 5122 (class 0 OID 0)
-- Dependencies: 223
-- Name: kategoria_kategoria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kategoria_kategoria_id_seq', 2, true);


--
-- TOC entry 5123 (class 0 OID 0)
-- Dependencies: 233
-- Name: models_model_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.models_model_id_seq', 4, true);


--
-- TOC entry 5124 (class 0 OID 0)
-- Dependencies: 231
-- Name: nacopitel_nacopitel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nacopitel_nacopitel_id_seq', 3, true);


--
-- TOC entry 5125 (class 0 OID 0)
-- Dependencies: 229
-- Name: op_pamit_op_pamit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.op_pamit_op_pamit_id_seq', 3, true);


--
-- TOC entry 5126 (class 0 OID 0)
-- Dependencies: 237
-- Name: pozitia_zakaza_pozitia_zakaza_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pozitia_zakaza_pozitia_zakaza_id_seq', 4, true);


--
-- TOC entry 5127 (class 0 OID 0)
-- Dependencies: 225
-- Name: proisvoditel_proisvoditel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.proisvoditel_proisvoditel_id_seq', 2, true);


--
-- TOC entry 5128 (class 0 OID 0)
-- Dependencies: 227
-- Name: prozeser_prozeser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.prozeser_prozeser_id_seq', 2, true);


--
-- TOC entry 5129 (class 0 OID 0)
-- Dependencies: 219
-- Name: rols_rol_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rols_rol_id_seq', 3, true);


--
-- TOC entry 5130 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 4, true);


--
-- TOC entry 5131 (class 0 OID 0)
-- Dependencies: 235
-- Name: zakazi_zakaz_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.zakazi_zakaz_id_seq', 2, true);


--
-- TOC entry 4916 (class 2606 OID 17947)
-- Name: kategoria kategoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategoria
    ADD CONSTRAINT kategoria_pkey PRIMARY KEY (kategoria_id);


--
-- TOC entry 4926 (class 2606 OID 18001)
-- Name: models models_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.models
    ADD CONSTRAINT models_pkey PRIMARY KEY (model_id);


--
-- TOC entry 4924 (class 2606 OID 17985)
-- Name: nacopitel nacopitel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nacopitel
    ADD CONSTRAINT nacopitel_pkey PRIMARY KEY (nacopitel_id);


--
-- TOC entry 4922 (class 2606 OID 17975)
-- Name: op_pamit op_pamit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.op_pamit
    ADD CONSTRAINT op_pamit_pkey PRIMARY KEY (op_pamit_id);


--
-- TOC entry 4930 (class 2606 OID 18052)
-- Name: pozitia_zakaza pozitia_zakaza_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pozitia_zakaza
    ADD CONSTRAINT pozitia_zakaza_pkey PRIMARY KEY (pozitia_zakaza_id);


--
-- TOC entry 4918 (class 2606 OID 17956)
-- Name: proisvoditel proisvoditel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proisvoditel
    ADD CONSTRAINT proisvoditel_pkey PRIMARY KEY (proisvoditel_id);


--
-- TOC entry 4920 (class 2606 OID 17965)
-- Name: prozeser prozeser_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prozeser
    ADD CONSTRAINT prozeser_pkey PRIMARY KEY (prozeser_id);


--
-- TOC entry 4912 (class 2606 OID 17922)
-- Name: rols rols_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rols
    ADD CONSTRAINT rols_pkey PRIMARY KEY (rol_id);


--
-- TOC entry 4914 (class 2606 OID 17933)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 4928 (class 2606 OID 18037)
-- Name: zakazi zakazi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zakazi
    ADD CONSTRAINT zakazi_pkey PRIMARY KEY (zakaz_id);


--
-- TOC entry 4932 (class 2606 OID 18002)
-- Name: models models_kategoria_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.models
    ADD CONSTRAINT models_kategoria_id_fkey FOREIGN KEY (kategoria_id) REFERENCES public.kategoria(kategoria_id);


--
-- TOC entry 4933 (class 2606 OID 18022)
-- Name: models models_nacopitel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.models
    ADD CONSTRAINT models_nacopitel_id_fkey FOREIGN KEY (nacopitel_id) REFERENCES public.nacopitel(nacopitel_id);


--
-- TOC entry 4934 (class 2606 OID 18017)
-- Name: models models_op_pamit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.models
    ADD CONSTRAINT models_op_pamit_id_fkey FOREIGN KEY (op_pamit_id) REFERENCES public.op_pamit(op_pamit_id);


--
-- TOC entry 4935 (class 2606 OID 18007)
-- Name: models models_proisvoditel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.models
    ADD CONSTRAINT models_proisvoditel_id_fkey FOREIGN KEY (proisvoditel_id) REFERENCES public.proisvoditel(proisvoditel_id);


--
-- TOC entry 4936 (class 2606 OID 18012)
-- Name: models models_prozeser_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.models
    ADD CONSTRAINT models_prozeser_id_fkey FOREIGN KEY (prozeser_id) REFERENCES public.prozeser(prozeser_id);


--
-- TOC entry 4938 (class 2606 OID 18053)
-- Name: pozitia_zakaza pozitia_zakaza_model_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pozitia_zakaza
    ADD CONSTRAINT pozitia_zakaza_model_id_fkey FOREIGN KEY (model_id) REFERENCES public.models(model_id);


--
-- TOC entry 4939 (class 2606 OID 18058)
-- Name: pozitia_zakaza pozitia_zakaza_zakaz_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pozitia_zakaza
    ADD CONSTRAINT pozitia_zakaza_zakaz_id_fkey FOREIGN KEY (zakaz_id) REFERENCES public.zakazi(zakaz_id);


--
-- TOC entry 4931 (class 2606 OID 17934)
-- Name: users users_rol_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_rol_id_fkey FOREIGN KEY (rol_id) REFERENCES public.rols(rol_id);


--
-- TOC entry 4937 (class 2606 OID 18038)
-- Name: zakazi zakazi_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zakazi
    ADD CONSTRAINT zakazi_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


-- Completed on 2026-10-01 15:25:56

--
-- PostgreSQL database dump complete
--

\unrestrict 3nBAvtB6z4KzZAGS0XDdiLZmvLguHQ0o4mOFyuAh7SkZ8mZZSciaPgZ6nZzDdYt

