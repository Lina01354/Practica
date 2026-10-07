--
-- PostgreSQL database dump
--

\restrict bTV0PRJ5tK5Vy6sf1fUts7HdOpfC6terBT6ngCQarOLORwhNTwc5Sm4XjwliTpH

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-10-07 12:50:49

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
-- TOC entry 226 (class 1259 OID 20260)
-- Name: categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoria (
    id_categoria integer NOT NULL,
    name_categoria character varying(10) NOT NULL
);


ALTER TABLE public.categoria OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 20259)
-- Name: categoria_id_categoria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categoria_id_categoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categoria_id_categoria_seq OWNER TO postgres;

--
-- TOC entry 5091 (class 0 OID 0)
-- Dependencies: 225
-- Name: categoria_id_categoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categoria_id_categoria_seq OWNED BY public.categoria.id_categoria;


--
-- TOC entry 230 (class 1259 OID 20291)
-- Name: model_razmer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.model_razmer (
    id_model_razmer integer NOT NULL,
    id_models integer NOT NULL,
    id_razmer integer NOT NULL,
    count_m integer
);


ALTER TABLE public.model_razmer OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 20290)
-- Name: model_razmer_id_model_razmer_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.model_razmer_id_model_razmer_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.model_razmer_id_model_razmer_seq OWNER TO postgres;

--
-- TOC entry 5092 (class 0 OID 0)
-- Dependencies: 229
-- Name: model_razmer_id_model_razmer_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.model_razmer_id_model_razmer_seq OWNED BY public.model_razmer.id_model_razmer;


--
-- TOC entry 228 (class 1259 OID 20269)
-- Name: models; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.models (
    id_models integer NOT NULL,
    name_models character varying(500) NOT NULL,
    id_categoria integer NOT NULL,
    img character varying(100) NOT NULL,
    prooizvodstvo character varying(300) NOT NULL,
    opisanie character varying(1000) NOT NULL,
    coctav character varying(300) NOT NULL,
    zena integer NOT NULL
);


ALTER TABLE public.models OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 20268)
-- Name: models_id_models_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.models_id_models_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.models_id_models_seq OWNER TO postgres;

--
-- TOC entry 5093 (class 0 OID 0)
-- Dependencies: 227
-- Name: models_id_models_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.models_id_models_seq OWNED BY public.models.id_models;


--
-- TOC entry 234 (class 1259 OID 20432)
-- Name: poz_zakazi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.poz_zakazi (
    id_poz_zakazi integer NOT NULL,
    id_zakazi integer NOT NULL,
    id_models integer NOT NULL,
    id_razmer integer NOT NULL,
    count_p integer NOT NULL,
    zena numeric
);


ALTER TABLE public.poz_zakazi OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 20431)
-- Name: poz_zakazi_id_poz_zakazi_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.poz_zakazi_id_poz_zakazi_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.poz_zakazi_id_poz_zakazi_seq OWNER TO postgres;

--
-- TOC entry 5094 (class 0 OID 0)
-- Dependencies: 233
-- Name: poz_zakazi_id_poz_zakazi_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.poz_zakazi_id_poz_zakazi_seq OWNED BY public.poz_zakazi.id_poz_zakazi;


--
-- TOC entry 224 (class 1259 OID 20251)
-- Name: razmer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.razmer (
    id_razmer integer NOT NULL,
    name_razmer character varying(10) NOT NULL
);


ALTER TABLE public.razmer OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 20250)
-- Name: razmer_id_razmer_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.razmer_id_razmer_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.razmer_id_razmer_seq OWNER TO postgres;

--
-- TOC entry 5095 (class 0 OID 0)
-- Dependencies: 223
-- Name: razmer_id_razmer_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.razmer_id_razmer_seq OWNED BY public.razmer.id_razmer;


--
-- TOC entry 220 (class 1259 OID 20222)
-- Name: rols; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rols (
    id_rols integer NOT NULL,
    name_rols character varying(50) NOT NULL
);


ALTER TABLE public.rols OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 20221)
-- Name: rols_id_rols_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rols_id_rols_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rols_id_rols_seq OWNER TO postgres;

--
-- TOC entry 5096 (class 0 OID 0)
-- Dependencies: 219
-- Name: rols_id_rols_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rols_id_rols_seq OWNED BY public.rols.id_rols;


--
-- TOC entry 222 (class 1259 OID 20231)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id_users integer NOT NULL,
    name_users character varying(150) NOT NULL,
    fam_users character varying(150) NOT NULL,
    otch_users character varying(150) NOT NULL,
    login_users character varying(50) NOT NULL,
    id_rols integer NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 20230)
-- Name: users_id_users_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_users_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_users_seq OWNER TO postgres;

--
-- TOC entry 5097 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_id_users_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_users_seq OWNED BY public.users.id_users;


--
-- TOC entry 232 (class 1259 OID 20418)
-- Name: zakazi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.zakazi (
    id_zakazi integer NOT NULL,
    id_users integer NOT NULL,
    data_z character varying(20)
);


ALTER TABLE public.zakazi OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 20417)
-- Name: zakazi_id_zakazi_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.zakazi_id_zakazi_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.zakazi_id_zakazi_seq OWNER TO postgres;

--
-- TOC entry 5098 (class 0 OID 0)
-- Dependencies: 231
-- Name: zakazi_id_zakazi_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.zakazi_id_zakazi_seq OWNED BY public.zakazi.id_zakazi;


--
-- TOC entry 4894 (class 2604 OID 20263)
-- Name: categoria id_categoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria ALTER COLUMN id_categoria SET DEFAULT nextval('public.categoria_id_categoria_seq'::regclass);


--
-- TOC entry 4896 (class 2604 OID 20294)
-- Name: model_razmer id_model_razmer; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_razmer ALTER COLUMN id_model_razmer SET DEFAULT nextval('public.model_razmer_id_model_razmer_seq'::regclass);


--
-- TOC entry 4895 (class 2604 OID 20272)
-- Name: models id_models; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.models ALTER COLUMN id_models SET DEFAULT nextval('public.models_id_models_seq'::regclass);


--
-- TOC entry 4898 (class 2604 OID 20435)
-- Name: poz_zakazi id_poz_zakazi; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poz_zakazi ALTER COLUMN id_poz_zakazi SET DEFAULT nextval('public.poz_zakazi_id_poz_zakazi_seq'::regclass);


--
-- TOC entry 4893 (class 2604 OID 20254)
-- Name: razmer id_razmer; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.razmer ALTER COLUMN id_razmer SET DEFAULT nextval('public.razmer_id_razmer_seq'::regclass);


--
-- TOC entry 4891 (class 2604 OID 20225)
-- Name: rols id_rols; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rols ALTER COLUMN id_rols SET DEFAULT nextval('public.rols_id_rols_seq'::regclass);


--
-- TOC entry 4892 (class 2604 OID 20234)
-- Name: users id_users; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id_users SET DEFAULT nextval('public.users_id_users_seq'::regclass);


--
-- TOC entry 4897 (class 2604 OID 20421)
-- Name: zakazi id_zakazi; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zakazi ALTER COLUMN id_zakazi SET DEFAULT nextval('public.zakazi_id_zakazi_seq'::regclass);


--
-- TOC entry 5077 (class 0 OID 20260)
-- Dependencies: 226
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.categoria VALUES (1, 'Детская');
INSERT INTO public.categoria VALUES (2, 'Женская');
INSERT INTO public.categoria VALUES (3, 'Мужская');


--
-- TOC entry 5081 (class 0 OID 20291)
-- Dependencies: 230
-- Data for Name: model_razmer; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.model_razmer VALUES (1, 1, 4, 20);
INSERT INTO public.model_razmer VALUES (2, 1, 5, 20);
INSERT INTO public.model_razmer VALUES (3, 1, 6, 20);
INSERT INTO public.model_razmer VALUES (4, 1, 7, 20);
INSERT INTO public.model_razmer VALUES (5, 1, 8, 20);
INSERT INTO public.model_razmer VALUES (6, 1, 9, 20);
INSERT INTO public.model_razmer VALUES (7, 2, 17, 2);
INSERT INTO public.model_razmer VALUES (8, 2, 18, 2);
INSERT INTO public.model_razmer VALUES (9, 3, 2, 30);
INSERT INTO public.model_razmer VALUES (10, 3, 20, 30);
INSERT INTO public.model_razmer VALUES (11, 4, 2, 15);
INSERT INTO public.model_razmer VALUES (12, 4, 20, 15);
INSERT INTO public.model_razmer VALUES (13, 5, 21, 5);
INSERT INTO public.model_razmer VALUES (14, 5, 6, 5);
INSERT INTO public.model_razmer VALUES (15, 5, 7, 5);
INSERT INTO public.model_razmer VALUES (16, 6, 1, 4);
INSERT INTO public.model_razmer VALUES (17, 6, 2, 4);
INSERT INTO public.model_razmer VALUES (18, 6, 20, 4);
INSERT INTO public.model_razmer VALUES (19, 7, 21, 4);
INSERT INTO public.model_razmer VALUES (20, 7, 6, 4);
INSERT INTO public.model_razmer VALUES (21, 7, 7, 4);
INSERT INTO public.model_razmer VALUES (22, 7, 8, 4);
INSERT INTO public.model_razmer VALUES (23, 8, 11, 7);
INSERT INTO public.model_razmer VALUES (24, 8, 12, 7);
INSERT INTO public.model_razmer VALUES (25, 8, 13, 7);
INSERT INTO public.model_razmer VALUES (26, 8, 14, 7);
INSERT INTO public.model_razmer VALUES (27, 9, 1, 7);
INSERT INTO public.model_razmer VALUES (28, 9, 2, 7);
INSERT INTO public.model_razmer VALUES (29, 9, 20, 7);
INSERT INTO public.model_razmer VALUES (30, 10, 20, 12);
INSERT INTO public.model_razmer VALUES (31, 10, 22, 12);
INSERT INTO public.model_razmer VALUES (32, 11, 26, 2);
INSERT INTO public.model_razmer VALUES (33, 11, 28, 2);
INSERT INTO public.model_razmer VALUES (34, 12, 22, 5);
INSERT INTO public.model_razmer VALUES (35, 12, 26, 5);
INSERT INTO public.model_razmer VALUES (36, 12, 28, 5);
INSERT INTO public.model_razmer VALUES (37, 13, 20, 10);
INSERT INTO public.model_razmer VALUES (38, 13, 22, 10);
INSERT INTO public.model_razmer VALUES (39, 13, 24, 10);
INSERT INTO public.model_razmer VALUES (40, 13, 26, 10);
INSERT INTO public.model_razmer VALUES (41, 13, 28, 10);
INSERT INTO public.model_razmer VALUES (42, 14, 19, 3);
INSERT INTO public.model_razmer VALUES (43, 15, 22, 23);
INSERT INTO public.model_razmer VALUES (44, 15, 26, 23);
INSERT INTO public.model_razmer VALUES (45, 15, 28, 23);
INSERT INTO public.model_razmer VALUES (46, 16, 20, 25);
INSERT INTO public.model_razmer VALUES (47, 16, 22, 25);
INSERT INTO public.model_razmer VALUES (48, 16, 24, 25);
INSERT INTO public.model_razmer VALUES (49, 17, 20, 4);
INSERT INTO public.model_razmer VALUES (50, 17, 24, 4);
INSERT INTO public.model_razmer VALUES (51, 17, 26, 4);
INSERT INTO public.model_razmer VALUES (52, 17, 28, 4);
INSERT INTO public.model_razmer VALUES (53, 17, 19, 9);
INSERT INTO public.model_razmer VALUES (54, 17, 24, 9);
INSERT INTO public.model_razmer VALUES (55, 18, 19, 2);
INSERT INTO public.model_razmer VALUES (56, 18, 20, 2);
INSERT INTO public.model_razmer VALUES (57, 19, 22, 5);
INSERT INTO public.model_razmer VALUES (58, 19, 23, 5);
INSERT INTO public.model_razmer VALUES (59, 19, 24, 5);
INSERT INTO public.model_razmer VALUES (60, 19, 21, 5);
INSERT INTO public.model_razmer VALUES (61, 20, 19, 16);
INSERT INTO public.model_razmer VALUES (62, 20, 20, 16);
INSERT INTO public.model_razmer VALUES (63, 20, 24, 16);
INSERT INTO public.model_razmer VALUES (64, 20, 26, 16);
INSERT INTO public.model_razmer VALUES (65, 21, 19, 3);
INSERT INTO public.model_razmer VALUES (66, 21, 24, 3);
INSERT INTO public.model_razmer VALUES (67, 22, 21, 18);
INSERT INTO public.model_razmer VALUES (68, 22, 32, 18);
INSERT INTO public.model_razmer VALUES (69, 22, 27, 18);
INSERT INTO public.model_razmer VALUES (70, 22, 34, 18);
INSERT INTO public.model_razmer VALUES (71, 23, 24, 50);
INSERT INTO public.model_razmer VALUES (72, 23, 29, 50);
INSERT INTO public.model_razmer VALUES (73, 23, 26, 50);
INSERT INTO public.model_razmer VALUES (74, 23, 31, 50);
INSERT INTO public.model_razmer VALUES (75, 23, 28, 50);
INSERT INTO public.model_razmer VALUES (76, 23, 30, 50);
INSERT INTO public.model_razmer VALUES (77, 24, 30, 3);
INSERT INTO public.model_razmer VALUES (78, 24, 32, 3);
INSERT INTO public.model_razmer VALUES (79, 24, 35, 3);
INSERT INTO public.model_razmer VALUES (80, 25, 28, 23);
INSERT INTO public.model_razmer VALUES (81, 25, 30, 23);
INSERT INTO public.model_razmer VALUES (82, 25, 34, 23);
INSERT INTO public.model_razmer VALUES (83, 26, 32, 15);
INSERT INTO public.model_razmer VALUES (84, 26, 34, 15);
INSERT INTO public.model_razmer VALUES (85, 26, 35, 15);
INSERT INTO public.model_razmer VALUES (86, 27, 35, 3);
INSERT INTO public.model_razmer VALUES (87, 28, 30, 1);
INSERT INTO public.model_razmer VALUES (88, 28, 32, 1);
INSERT INTO public.model_razmer VALUES (89, 29, 32, 20);
INSERT INTO public.model_razmer VALUES (90, 29, 34, 20);
INSERT INTO public.model_razmer VALUES (91, 30, 30, 30);
INSERT INTO public.model_razmer VALUES (92, 30, 32, 30);


--
-- TOC entry 5079 (class 0 OID 20269)
-- Dependencies: 228
-- Data for Name: models; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.models VALUES (1, 'Кроссовки детские «Звёздочка» экокожа', 1, 'IMG_KS_195217.png', 'Малыш-Спорт', 'Кроссовки детские «Звёздочка» экокожа. Производитель: ООО «Малыш-Спорт»  г. Смоленск', 'Верх — экокожа (полиуретан на хлопковой основе)  подкладка — хлопок 100%  подошва — ПВХ', 2190);
INSERT INTO public.models VALUES (2, 'Кроссовки детские «Гонщик» экокожа', 1, 'IMG_KS_195213.png', 'Топ-Топ', 'Кроссовки детские «Гонщик» экокожа. Производитель: Фабрика «Топ-Топ»  г. Киров', 'Верх — экокожа (микрофибра)  подкладка — текстиль сетчатый (полиэстер)  подошва — термопластичная резина (ТЭП)', 2490);
INSERT INTO public.models VALUES (3, 'Кроссовки детские «Радуга» экокожа перфорированная', 1, 'IMG_KS_195222.png', 'Лапушка', 'Кроссовки детские «Радуга» экокожа перфорированная. Производитель: ИП Смирнова Л.В. (бренд «Лапушка»)  г. Вологда', 'Верх — экокожа перфорированная  вставки — нейлон  стелька — ортопедическая с латексной подушкой  подошва — ЭВА', 1990);
INSERT INTO public.models VALUES (4, 'Сапожки детские «Снежинка» зимние на меху', 1, 'IMG_KB_185501.png', 'Тёплые ножки', 'Сапожки детские «Снежинка» зимние на меху. Производитель: ООО «Тёплые ножки»  г. Новосибирск', 'Верх — экокожа морозостойкая  утеплитель — искусственный мех (акрил 70%  полиэстер 30%)  подкладка — флис  подошва — термоэластопласт (ТЭП)', 3490);
INSERT INTO public.models VALUES (5, 'Сапожки детские «Медвежонок» демисезонные непромокаемые', 1, 'IMG_KB_164816.png', 'Северята', 'Сапожки детские «Медвежонок» демисезонные непромокаемые. Производитель: Компания «Северята»  г. Архангельск', 'Верх — плащёвая ткань с водоотталкивающей пропиткой (полиэстер 100%)  отделка — экокожа  подкладка — микрофибра  мембрана — AirTex  подошва — резина', 3190);
INSERT INTO public.models VALUES (6, 'Сапожки детские «Принцесса» кожаные', 1, 'IMG_KB_164811.png', 'Весна', 'Сапожки детские «Принцесса» кожаные. Производитель: Мастерская «Весна»  г. Тула', 'Верх — натуральная кожа (КРС)  подкладка — шерсть натуральная (70%)  байка (30%)  стелька — войлочная  подошва — полиуретан', 4290);
INSERT INTO public.models VALUES (7, 'Сандалии детские «Пчёлка» ортопедические летние', 1, 'IMG_KSd_195207.png', 'Здоровый шаг', 'Сандалии детские «Пчёлка» ортопедические летние. Производитель: ООО «Здоровый шаг»  г. Воронеж', 'Верх — нубук натуральный  подкладка — кожа растительного дубления  стелька — анатомическая с супинатором (латекс + пробка)  подошва — каучук', 2790);
INSERT INTO public.models VALUES (8, 'Сандалии детские «Морячок» текстильные с фиксатором', 1, 'IMG_KSd_185508.png', 'Карапуз', 'Сандалии детские «Морячок» текстильные с фиксатором. Производитель: ИП Кузнецов А.Д. (бренд «Карапуз»)  г. Краснодар', 'Верх — джинсовая ткань (хлопок 100%)  окантовка — искусственная кожа  подкладка — хлопок  подошва — ЭВА лёгкая', 1690);
INSERT INTO public.models VALUES (9, 'Туфли детские «Бантик» лаковые праздничные', 1, 'IMG_KSho_185512.png', 'Маленький франт', 'Туфли детские «Бантик» лаковые праздничные. Производитель: Дом обуви «Маленький франт»  г. Москва', 'Верх — искусственная лаковая кожа (ПВХ)  носок усиленный — термопластичный полиуретан  подкладка — кожа искусственная дышащая  стелька — анатомическая с амортизацией  подошва — полиуретан', 2390);
INSERT INTO public.models VALUES (10, 'Сапоги зимние натуральная кожа', 2, 'IMG_WB_170905.png', 'Барбари', 'Сапоги женские зимние  нескользящая  устойчивая подошва  натуральный мех. Производитель: Дом обуви «Барбари»  г. Новороссийск ', 'Верх — натуральная кожа  подкладка — евромех  натуральный мех  текстильный утеплитель  подошва — резина', 25000);
INSERT INTO public.models VALUES (11, 'Сапоги осенние натуральная кожа', 2, 'IMG_WB_170859.png', 'Барбари', 'Сапоги женские демисезонные из высококачественной натуральной кожи. Производитель: Дом обуви «Барбари»  г. Новороссийск ', 'Верх — натуральная кожа  подкладка — текстильный утеплитель  стелька — текстиль  подошва — ТПР', 15000);
INSERT INTO public.models VALUES (12, 'Сапоги трубы демисезонные замшевые', 2, 'IMG_WB_170906.png', 'Твой комфорт', 'Сапоги женские демисезонные замшевые. Производитель: ОАО «Твой комфорт»  г. Ярославль', 'Верх — натуральная замша  утепленные  тракторная подошва  стелька — байка  подошва — резина', 17000);
INSERT INTO public.models VALUES (13, 'Босоножки «Песчаный берег» коричневые', 2, 'IMG_WSd_174332.png', 'Стиль и комфорт', 'Коричневая кожаная модель с открытым носком  боковой пряжкой и закрытым каблуком. Производитель: ИП «Стиль и комфорт»  г. Санкт-Петербург', 'Верх — 100% козья кожа  подкладка — 100% кожа  подошва: 100% кожа', 7500);
INSERT INTO public.models VALUES (14, 'Женские босоножки «Черный кофе» со скульптурным каблуком', 2, 'IMG_WSd_185156.png', 'Кожевенные традиции', 'Открытый носок и ремешок со сборной пряжкой  низкий каблук и резиновая подошва гарантируют комфорт. Производитель: ЗАО «Кожевенные традиции»  г. Вятка', 'Верх — кожа собственного производств  подкладка — кожа  подошва: резина', 5600);
INSERT INTO public.models VALUES (15, 'Босоножки женские «Летний бриз»', 2, 'IMG_WSd_185551.png', 'Модный силуэт', 'Босоножки женские кожаные белые  регулируемый ремешок  закрытый каблук и кожаная подошва. Производитель: ООО «Модный силуэт»  г. Кострома', 'Верх — натуральная кожа  подкладка — натуральная кожа  подошва — кожа', 7130);
INSERT INTO public.models VALUES (16, 'Демисезонные туфли натуральная кожа', 2, 'IMG_WSho_174409.png', 'Модный силуэт', 'Комфортные лаконичные лодочки  классический дизайна с современными акцентами. Производитель: ООО «Модный силуэт»  г. Кострома', 'Верх — натуральная овечья кожа  подкладка и стелька — натуральная овечья кожа  подошва — резина', 12340);
INSERT INTO public.models VALUES (17, 'Туфли женские натуральная кожа с металлическими вставками', 2, 'IMG_WSho_185202.png', 'Кожевенные традиции', 'Стильные туфли для весеннего и летнего сезона. Производитель: ЗАО «Кожевенные традиции»  г. Вятка', 'Верх — натуральная телячьей кожа  металлическая пряжка  подкладка и стелька— натуральная овечья кожа  подошва — резина', 7757);
INSERT INTO public.models VALUES (18, 'Туфли классические лодочки натуральная кожа', 2, 'IMG_WSho_185545.png', 'Стиль и комфорт', 'Модель из натуральной кожи  классический острый носок и изящная шпилька. Производитель: ИП «Стиль и комфорт»  г. Санкт-Петербург', 'Верх — натуральная кожа  подкладка и стелька — натуральная кожа  подошва — тунит', 7550);
INSERT INTO public.models VALUES (19, 'Кроссовки белые с оранжевым и красным', 2, 'IMG_WS_174110.png', 'Топ-Топ', 'Многослойный верх из кожи и текстиля. Производитель: Фабрика «Топ-Топ»  г. Киров', 'Верх — 70% кожа  30% текстиль  подкладка — текстиль  подошва — резина', 9450);
INSERT INTO public.models VALUES (20, 'Кроссовки летние кожаные', 2, 'IMG_WS_185528.png', 'Топ-Топ', 'Уверенность на каждом шагу. Материал обеспечивает долговечность и комфорт при носке. Производитель: Фабрика «Топ-Топ»  г. Киров', 'Верх — 87% кожа  11% текстиль  2% синтетика  подкладка: 100% текстиль  подошва: резина  пластик', 8565);
INSERT INTO public.models VALUES (21, 'Кроссовки кожаные', 2, 'IMG_WS_185535.png', 'Стиль и комфорт', 'Кроссовки женские из натуральной кожи. Производитель: ИП «Стиль и комфорт»  г. Санкт-Петербург', 'Верх — натуральная кожа  подкладка — кожа  подошва — полиуретан', 8765);
INSERT INTO public.models VALUES (22, 'Кроссовки «Стиль и комфорт»', 2, 'IMG_WS_185538.png', 'Стиль и комфорт', 'Кроссовки женские из натуральной кожи и синтетических материалов  сетчатые вставки. Производитель: ИП «Стиль и комфорт»  г. Санкт-Петербург', 'Верх — 70% кожа  20% полиамид  10% полиуретан  подкладка — текстиль  подошва — ТПУ', 7795);
INSERT INTO public.models VALUES (23, 'Кроссовки для бега «Драйв»', 3, 'IMG_MS_185531.png', 'Азимут', 'Сочетание стиля  комфорта и современных технологий. Производитель: Фабрика «Азимут»  г. Санкт-Петербург', 'Верх —  сетка  подкладка — текстиль  подошва —  резина', 6550);
INSERT INTO public.models VALUES (24, 'Кроссовки «Азимут Бег» ', 3, 'IMG_MS_185532.png', 'Азимут', 'Универсальный выбор для повседневного использования. Производитель: Фабрика «Азимут»  г. Санкт-Петербург', 'Верх — 6% кожа  29% текстиль  15% полимерные материалы  подкладка — 100% текстиль  подошва — полимерные материалы  резина', 7890);
INSERT INTO public.models VALUES (25, 'Кроссовки', 3, 'IMG_MS_185533.png', 'Топ-Топ', 'Кроссовки для мужчин  идеальное сочетание стиля и комфорта. Производитель: Фабрика «Топ-Топ»  г. Киров', 'Верх — 56% кожа  29% текстиль  15% полимерные материалы  подкладка — 100% текстиль  подошва — полимерные материалы  резина', 9567);
INSERT INTO public.models VALUES (26, 'Черные туфли в классическом стиле — база для деловых образов', 3, 'IMG_MSho_190514.png', 'Барбари', 'Модель выполнена из натуральной кожи  на резиновой подошве. Производитель: Дом обуви «Барбари»  г. Новороссийск ', 'Верх — натуральная кожа  подкладка — текстиль  стелька — натуральная кожа  подошва — резина', 24569);
INSERT INTO public.models VALUES (27, 'Туфли мужские светлые классика демисезонные', 3, 'IMG_MSho_190518.png', 'Берестов', 'Туфли на низком каблуке кожаные', 'Верх — натуральная кожа  подкладка — текстиль  стелька — натуральная кожа  подошва — ТЭП', 10155);
INSERT INTO public.models VALUES (28, 'Туфли из натуральной кожи', 3, 'IMG_MSho_191612.png', 'Берестов', 'Модель выполнена из натуральной кожи  на резиновой подошве  поддеживает классический и деловой стиль образов. Производитель: Дом обуви «Берестов»  г. Москва', 'Верх — натуральная кожа  подкладка — натуральная кожа  стелька — натуральная кожа  подошва — резина', 25625);
INSERT INTO public.models VALUES (29, 'Ботинки мужские демисезонные', 3, 'IMG_MB_174349.png', 'Барбари', 'Ботинки из натуральной кожи темно-коричневого и черного цвета на шнурках. Производитель: Дом обуви «Берестов»  г. Москва', 'Верх — натуральная кожа  подкладка — текстиль  подошва — искусственный материал', 21500);
INSERT INTO public.models VALUES (30, 'Ботинки черные из натуральной кожи', 3, 'IMG_MB_191200.png', 'Кожевенные традиции', 'Ботинки представляют баланс традиций и современности. Выполнены из натуральной кожи насыщенного черного цвета. Производитель: ЗАО «Кожевенные традиции»  г. Вятка', 'Верх — натуральная кожа  подкладка — ворсин  стелька — ворсин  подошва — тунит', 14567);
INSERT INTO public.models VALUES (31, 'Ботинки зимние классические', 3, 'IMG_MB_191205.png', 'Барбари', 'Выбор на каждый день — натуральная кожа  натуральный мех. Производитель: Дом обуви «Барбари»  г. Новороссийск ', 'Верх — натуральная кожа  подкладка — натуральный мех  стелька — натуральный мех  подошва — ТЭП', 15670);


--
-- TOC entry 5085 (class 0 OID 20432)
-- Dependencies: 234
-- Data for Name: poz_zakazi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.poz_zakazi VALUES (1, 11, 1, 2, 1, 2190);
INSERT INTO public.poz_zakazi VALUES (2, 11, 7, 3, 1, 2790);
INSERT INTO public.poz_zakazi VALUES (3, 12, 11, 13, 1, 25000);
INSERT INTO public.poz_zakazi VALUES (4, 12, 18, 14, 1, 7500);
INSERT INTO public.poz_zakazi VALUES (5, 12, 14, 15, 1, 17000);
INSERT INTO public.poz_zakazi VALUES (6, 12, 6, 15, 1, 8565);
INSERT INTO public.poz_zakazi VALUES (7, 12, 5, 23, 1, 7795);
INSERT INTO public.poz_zakazi VALUES (8, 14, 9, 25, 1, 7757);
INSERT INTO public.poz_zakazi VALUES (9, 14, 7, 25, 1, 12340);
INSERT INTO public.poz_zakazi VALUES (10, 14, 23, 26, 1, 7130);
INSERT INTO public.poz_zakazi VALUES (11, 14, 5, 14, 1, 8765);
INSERT INTO public.poz_zakazi VALUES (12, 14, 30, 25, 1, 15000);
INSERT INTO public.poz_zakazi VALUES (13, 15, 12, 32, 1, 9567);
INSERT INTO public.poz_zakazi VALUES (14, 15, 25, 31, 1, 21500);
INSERT INTO public.poz_zakazi VALUES (15, 15, 24, 26, 1, 7890);
INSERT INTO public.poz_zakazi VALUES (16, 16, 28, 32, 1, 24569);
INSERT INTO public.poz_zakazi VALUES (17, 16, 17, 34, 1, 14567);
INSERT INTO public.poz_zakazi VALUES (18, 16, 8, 31, 1, 15670);
INSERT INTO public.poz_zakazi VALUES (19, 17, 22, 1, 1, 4290);
INSERT INTO public.poz_zakazi VALUES (20, 17, 21, 3, 2, 2190);
INSERT INTO public.poz_zakazi VALUES (21, 17, 6, 4, 1, 1690);
INSERT INTO public.poz_zakazi VALUES (22, 18, 9, 31, 1, 25625);
INSERT INTO public.poz_zakazi VALUES (23, 18, 19, 29, 3, 7890);
INSERT INTO public.poz_zakazi VALUES (24, 18, 29, 28, 2, 6550);
INSERT INTO public.poz_zakazi VALUES (25, 19, 5, 16, 1, 2490);
INSERT INTO public.poz_zakazi VALUES (26, 19, 4, 3, 2, 3190);
INSERT INTO public.poz_zakazi VALUES (27, 20, 11, 17, 1, 7550);
INSERT INTO public.poz_zakazi VALUES (28, 20, 31, 19, 1, 7130);
INSERT INTO public.poz_zakazi VALUES (29, 20, 26, 24, 1, 12340);
INSERT INTO public.poz_zakazi VALUES (30, 20, 22, 22, 2, 8765);


--
-- TOC entry 5075 (class 0 OID 20251)
-- Dependencies: 224
-- Data for Name: razmer; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.razmer VALUES (1, '18');
INSERT INTO public.razmer VALUES (2, '19');
INSERT INTO public.razmer VALUES (3, '20');
INSERT INTO public.razmer VALUES (4, '21');
INSERT INTO public.razmer VALUES (5, '22');
INSERT INTO public.razmer VALUES (6, '23');
INSERT INTO public.razmer VALUES (7, '24');
INSERT INTO public.razmer VALUES (8, '25');
INSERT INTO public.razmer VALUES (9, '26');
INSERT INTO public.razmer VALUES (10, '27');
INSERT INTO public.razmer VALUES (11, '28');
INSERT INTO public.razmer VALUES (12, '29');
INSERT INTO public.razmer VALUES (13, '30');
INSERT INTO public.razmer VALUES (14, '31');
INSERT INTO public.razmer VALUES (15, '32');
INSERT INTO public.razmer VALUES (16, '33');
INSERT INTO public.razmer VALUES (17, '34');
INSERT INTO public.razmer VALUES (18, '35');
INSERT INTO public.razmer VALUES (19, '36');
INSERT INTO public.razmer VALUES (20, '36.5');
INSERT INTO public.razmer VALUES (21, '37');
INSERT INTO public.razmer VALUES (22, '37.5');
INSERT INTO public.razmer VALUES (23, '38');
INSERT INTO public.razmer VALUES (24, '38.5');
INSERT INTO public.razmer VALUES (25, '39');
INSERT INTO public.razmer VALUES (26, '39.5');
INSERT INTO public.razmer VALUES (27, '40');
INSERT INTO public.razmer VALUES (28, '40.5');
INSERT INTO public.razmer VALUES (29, '41');
INSERT INTO public.razmer VALUES (30, '41.5');
INSERT INTO public.razmer VALUES (31, '42');
INSERT INTO public.razmer VALUES (32, '42.5');
INSERT INTO public.razmer VALUES (33, '43');
INSERT INTO public.razmer VALUES (34, '44');
INSERT INTO public.razmer VALUES (35, '45');


--
-- TOC entry 5071 (class 0 OID 20222)
-- Dependencies: 220
-- Data for Name: rols; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.rols VALUES (1, 'администратор,');
INSERT INTO public.rols VALUES (2, 'менеджер,');
INSERT INTO public.rols VALUES (3, 'авторизованный пользователь');


--
-- TOC entry 5073 (class 0 OID 20231)
-- Dependencies: 222
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (1, 'Иван', 'Иванов', 'Сергеевич', 'isivanov', 1);
INSERT INTO public.users VALUES (2, 'Пётр', 'Петров', 'Алексеевич', 'papetrov', 2);
INSERT INTO public.users VALUES (3, 'Анна', 'Сидорова', 'Дмитриевна', 'asidorova', 3);
INSERT INTO public.users VALUES (4, 'Екатерина', 'Кузнецова', 'Андреевна', 'ekuznetsova', 2);
INSERT INTO public.users VALUES (5, 'Дмитрий', 'Смирнов', 'Владимирович', 'dsmirnov', 3);
INSERT INTO public.users VALUES (6, 'Алексей', 'Попов', 'Николаевич', 'apopov', 1);
INSERT INTO public.users VALUES (7, 'Ольга', 'Васильева', 'Игоревна', 'ovasileva', 3);
INSERT INTO public.users VALUES (8, 'Павел', 'Соколов', 'Викторович', 'psokolov', 2);
INSERT INTO public.users VALUES (9, 'Татьяна', 'Михайлова', 'Юрьевна', 'tmikhailova', 3);
INSERT INTO public.users VALUES (10, 'Наталья', 'Новикова', 'Сергеевна', 'nnovikova', 2);
INSERT INTO public.users VALUES (11, 'Андрей', 'Фёдоров', 'Максимович', 'afedorov', 1);
INSERT INTO public.users VALUES (12, 'Сергей', 'Морозов', 'Павлович', 'smorozov', 3);
INSERT INTO public.users VALUES (13, 'Юлия', 'Волкова', 'Александровна', 'jvolkova', 2);
INSERT INTO public.users VALUES (14, 'Артём', 'Алексеев', 'Евгеньевич', 'aalekseev', 3);
INSERT INTO public.users VALUES (15, 'Ирина', 'Лебедева', 'Владимировна', 'ilebedeva', 3);
INSERT INTO public.users VALUES (16, 'Никита', 'Егоров', 'Денисович', 'negorov', 2);
INSERT INTO public.users VALUES (17, 'Елена', 'Павлова', 'Петровна', 'epavlova', 3);
INSERT INTO public.users VALUES (18, 'Роман', 'Козлов', 'Олегович', 'rkozlov', 1);
INSERT INTO public.users VALUES (19, 'Виктория', 'Степанова', 'Романовна', 'vstepanova', 2);
INSERT INTO public.users VALUES (20, 'Владимир', 'Николаев', 'Иванович', 'vnikolaev', 3);


--
-- TOC entry 5083 (class 0 OID 20418)
-- Dependencies: 232
-- Data for Name: zakazi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.zakazi VALUES (11, 3, '02.04.2026');
INSERT INTO public.zakazi VALUES (12, 17, '05.04.2026');
INSERT INTO public.zakazi VALUES (13, 7, '08.04.2026');
INSERT INTO public.zakazi VALUES (14, 15, '12.04.2026');
INSERT INTO public.zakazi VALUES (15, 12, '18.04.2026');
INSERT INTO public.zakazi VALUES (16, 9, '22.04.2026');
INSERT INTO public.zakazi VALUES (17, 14, '25.04.2026');
INSERT INTO public.zakazi VALUES (18, 20, '28.04.2026');
INSERT INTO public.zakazi VALUES (19, 5, '05.05.2026');
INSERT INTO public.zakazi VALUES (20, 17, '08.05.2026');


--
-- TOC entry 5099 (class 0 OID 0)
-- Dependencies: 225
-- Name: categoria_id_categoria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categoria_id_categoria_seq', 3, true);


--
-- TOC entry 5100 (class 0 OID 0)
-- Dependencies: 229
-- Name: model_razmer_id_model_razmer_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.model_razmer_id_model_razmer_seq', 92, true);


--
-- TOC entry 5101 (class 0 OID 0)
-- Dependencies: 227
-- Name: models_id_models_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.models_id_models_seq', 31, true);


--
-- TOC entry 5102 (class 0 OID 0)
-- Dependencies: 233
-- Name: poz_zakazi_id_poz_zakazi_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.poz_zakazi_id_poz_zakazi_seq', 30, true);


--
-- TOC entry 5103 (class 0 OID 0)
-- Dependencies: 223
-- Name: razmer_id_razmer_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.razmer_id_razmer_seq', 35, true);


--
-- TOC entry 5104 (class 0 OID 0)
-- Dependencies: 219
-- Name: rols_id_rols_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rols_id_rols_seq', 3, true);


--
-- TOC entry 5105 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_id_users_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_users_seq', 20, true);


--
-- TOC entry 5106 (class 0 OID 0)
-- Dependencies: 231
-- Name: zakazi_id_zakazi_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.zakazi_id_zakazi_seq', 20, true);


--
-- TOC entry 4906 (class 2606 OID 20267)
-- Name: categoria categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (id_categoria);


--
-- TOC entry 4910 (class 2606 OID 20299)
-- Name: model_razmer model_razmer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_razmer
    ADD CONSTRAINT model_razmer_pkey PRIMARY KEY (id_model_razmer);


--
-- TOC entry 4908 (class 2606 OID 20284)
-- Name: models models_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.models
    ADD CONSTRAINT models_pkey PRIMARY KEY (id_models);


--
-- TOC entry 4914 (class 2606 OID 20444)
-- Name: poz_zakazi poz_zakazi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poz_zakazi
    ADD CONSTRAINT poz_zakazi_pkey PRIMARY KEY (id_poz_zakazi);


--
-- TOC entry 4904 (class 2606 OID 20258)
-- Name: razmer razmer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.razmer
    ADD CONSTRAINT razmer_pkey PRIMARY KEY (id_razmer);


--
-- TOC entry 4900 (class 2606 OID 20229)
-- Name: rols rols_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rols
    ADD CONSTRAINT rols_pkey PRIMARY KEY (id_rols);


--
-- TOC entry 4902 (class 2606 OID 20244)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id_users);


--
-- TOC entry 4912 (class 2606 OID 20425)
-- Name: zakazi zakazi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zakazi
    ADD CONSTRAINT zakazi_pkey PRIMARY KEY (id_zakazi);


--
-- TOC entry 4917 (class 2606 OID 20300)
-- Name: model_razmer model_razmer_id_models_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_razmer
    ADD CONSTRAINT model_razmer_id_models_fkey FOREIGN KEY (id_models) REFERENCES public.models(id_models);


--
-- TOC entry 4918 (class 2606 OID 20305)
-- Name: model_razmer model_razmer_id_razmer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_razmer
    ADD CONSTRAINT model_razmer_id_razmer_fkey FOREIGN KEY (id_razmer) REFERENCES public.razmer(id_razmer);


--
-- TOC entry 4916 (class 2606 OID 20285)
-- Name: models models_id_categoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.models
    ADD CONSTRAINT models_id_categoria_fkey FOREIGN KEY (id_categoria) REFERENCES public.categoria(id_categoria);


--
-- TOC entry 4920 (class 2606 OID 20450)
-- Name: poz_zakazi poz_zakazi_id_models_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poz_zakazi
    ADD CONSTRAINT poz_zakazi_id_models_fkey FOREIGN KEY (id_models) REFERENCES public.models(id_models);


--
-- TOC entry 4921 (class 2606 OID 20455)
-- Name: poz_zakazi poz_zakazi_id_razmer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poz_zakazi
    ADD CONSTRAINT poz_zakazi_id_razmer_fkey FOREIGN KEY (id_razmer) REFERENCES public.razmer(id_razmer);


--
-- TOC entry 4922 (class 2606 OID 20445)
-- Name: poz_zakazi poz_zakazi_id_zakazi_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poz_zakazi
    ADD CONSTRAINT poz_zakazi_id_zakazi_fkey FOREIGN KEY (id_zakazi) REFERENCES public.zakazi(id_zakazi);


--
-- TOC entry 4915 (class 2606 OID 20245)
-- Name: users users_id_rols_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_id_rols_fkey FOREIGN KEY (id_rols) REFERENCES public.rols(id_rols);


--
-- TOC entry 4919 (class 2606 OID 20426)
-- Name: zakazi zakazi_id_users_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zakazi
    ADD CONSTRAINT zakazi_id_users_fkey FOREIGN KEY (id_users) REFERENCES public.users(id_users);


-- Completed on 2026-10-07 12:50:49

--
-- PostgreSQL database dump complete
--

\unrestrict bTV0PRJ5tK5Vy6sf1fUts7HdOpfC6terBT6ngCQarOLORwhNTwc5Sm4XjwliTpH

