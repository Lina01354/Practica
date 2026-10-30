--
-- PostgreSQL database dump
--

\restrict u52gWmeFre6bVFMYiD6saOXxjzwWfCkDwMQ03LdHPdbmdq9wtL5sKdgUtYgQYuC

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-10-30 13:31:06

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
-- TOC entry 224 (class 1259 OID 20785)
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category (
    category_id integer NOT NULL,
    category_name character varying(50)
);


ALTER TABLE public.category OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 20784)
-- Name: category_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.category_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.category_category_id_seq OWNER TO postgres;

--
-- TOC entry 5090 (class 0 OID 0)
-- Dependencies: 223
-- Name: category_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.category_category_id_seq OWNED BY public.category.category_id;


--
-- TOC entry 232 (class 1259 OID 20851)
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    order_item_id integer NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    size_id integer NOT NULL,
    quantity integer NOT NULL,
    price numeric
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 20850)
-- Name: order_items_order_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_order_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_order_item_id_seq OWNER TO postgres;

--
-- TOC entry 5091 (class 0 OID 0)
-- Dependencies: 231
-- Name: order_items_order_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_order_item_id_seq OWNED BY public.order_items.order_item_id;


--
-- TOC entry 234 (class 1259 OID 20894)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    order_id integer NOT NULL,
    order_date character varying(50),
    user_id integer NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 20893)
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_order_id_seq OWNER TO postgres;

--
-- TOC entry 5092 (class 0 OID 0)
-- Dependencies: 233
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;


--
-- TOC entry 226 (class 1259 OID 20793)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    product_id integer NOT NULL,
    category_id integer NOT NULL,
    subcategory character varying(50),
    image_path character varying(50),
    product_name character varying(150),
    manufacturer character varying(50),
    description character varying(500),
    composition character varying(500),
    price numeric
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 20792)
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_product_id_seq OWNER TO postgres;

--
-- TOC entry 5093 (class 0 OID 0)
-- Dependencies: 225
-- Name: products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;


--
-- TOC entry 220 (class 1259 OID 20763)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    role_id integer NOT NULL,
    role_name character varying(50)
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 20762)
-- Name: roles_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_role_id_seq OWNER TO postgres;

--
-- TOC entry 5094 (class 0 OID 0)
-- Dependencies: 219
-- Name: roles_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_role_id_seq OWNED BY public.roles.role_id;


--
-- TOC entry 228 (class 1259 OID 20809)
-- Name: sizes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sizes (
    size_id integer NOT NULL,
    size_value character varying(10)
);


ALTER TABLE public.sizes OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 20808)
-- Name: sizes_size_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sizes_size_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sizes_size_id_seq OWNER TO postgres;

--
-- TOC entry 5095 (class 0 OID 0)
-- Dependencies: 227
-- Name: sizes_size_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sizes_size_id_seq OWNED BY public.sizes.size_id;


--
-- TOC entry 230 (class 1259 OID 20817)
-- Name: stock_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stock_items (
    stock_item_id integer NOT NULL,
    product_id integer NOT NULL,
    size_id integer NOT NULL,
    quantity_available integer
);


ALTER TABLE public.stock_items OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 20816)
-- Name: stock_items_stock_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stock_items_stock_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stock_items_stock_item_id_seq OWNER TO postgres;

--
-- TOC entry 5096 (class 0 OID 0)
-- Dependencies: 229
-- Name: stock_items_stock_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stock_items_stock_item_id_seq OWNED BY public.stock_items.stock_item_id;


--
-- TOC entry 222 (class 1259 OID 20771)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    last_name character varying(50),
    first_name character varying(50),
    middle_name character varying(50),
    login character varying(50),
    role_id integer NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 20770)
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
-- TOC entry 5097 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 4893 (class 2604 OID 20788)
-- Name: category category_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category ALTER COLUMN category_id SET DEFAULT nextval('public.category_category_id_seq'::regclass);


--
-- TOC entry 4897 (class 2604 OID 20854)
-- Name: order_items order_item_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN order_item_id SET DEFAULT nextval('public.order_items_order_item_id_seq'::regclass);


--
-- TOC entry 4898 (class 2604 OID 20897)
-- Name: orders order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);


--
-- TOC entry 4894 (class 2604 OID 20796)
-- Name: products product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);


--
-- TOC entry 4891 (class 2604 OID 20766)
-- Name: roles role_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN role_id SET DEFAULT nextval('public.roles_role_id_seq'::regclass);


--
-- TOC entry 4895 (class 2604 OID 20812)
-- Name: sizes size_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sizes ALTER COLUMN size_id SET DEFAULT nextval('public.sizes_size_id_seq'::regclass);


--
-- TOC entry 4896 (class 2604 OID 20820)
-- Name: stock_items stock_item_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_items ALTER COLUMN stock_item_id SET DEFAULT nextval('public.stock_items_stock_item_id_seq'::regclass);


--
-- TOC entry 4892 (class 2604 OID 20774)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 5074 (class 0 OID 20785)
-- Dependencies: 224
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.category VALUES (1, 'Детская обувь');
INSERT INTO public.category VALUES (2, 'Женская обувь');
INSERT INTO public.category VALUES (3, 'Мужская обувь');


--
-- TOC entry 5082 (class 0 OID 20851)
-- Dependencies: 232
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.order_items VALUES (1, 1, 1, 3, 1, 2190);
INSERT INTO public.order_items VALUES (2, 1, 7, 5, 1, 2790);
INSERT INTO public.order_items VALUES (3, 2, 10, 19, 1, 25000);
INSERT INTO public.order_items VALUES (4, 2, 13, 23, 1, 7500);
INSERT INTO public.order_items VALUES (5, 3, 12, 21, 1, 17000);
INSERT INTO public.order_items VALUES (6, 3, 20, 21, 1, 8565);
INSERT INTO public.order_items VALUES (7, 3, 22, 18, 1, 7795);
INSERT INTO public.order_items VALUES (8, 4, 16, 23, 1, 7757);
INSERT INTO public.order_items VALUES (9, 4, 16, 23, 1, 12340);
INSERT INTO public.order_items VALUES (10, 4, 15, 25, 1, 7130);
INSERT INTO public.order_items VALUES (11, 4, 21, 19, 1, 8765);
INSERT INTO public.order_items VALUES (12, 4, 11, 25, 1, 15000);
INSERT INTO public.order_items VALUES (13, 5, 25, 29, 1, 9567);
INSERT INTO public.order_items VALUES (14, 5, 29, 29, 1, 21500);
INSERT INTO public.order_items VALUES (15, 5, 24, 25, 1, 7890);
INSERT INTO public.order_items VALUES (16, 6, 26, 27, 1, 24569);
INSERT INTO public.order_items VALUES (17, 6, 30, 31, 1, 14567);
INSERT INTO public.order_items VALUES (18, 6, 31, 29, 1, 15670);
INSERT INTO public.order_items VALUES (19, 7, 6, 1, 1, 4290);
INSERT INTO public.order_items VALUES (20, 7, 1, 4, 2, 2190);
INSERT INTO public.order_items VALUES (21, 7, 8, 11, 1, 1690);
INSERT INTO public.order_items VALUES (22, 8, 28, 34, 1, 25625);
INSERT INTO public.order_items VALUES (23, 8, 24, 27, 3, 7890);
INSERT INTO public.order_items VALUES (24, 8, 23, 33, 2, 6550);
INSERT INTO public.order_items VALUES (25, 9, 2, 16, 1, 2490);
INSERT INTO public.order_items VALUES (26, 9, 5, 5, 2, 3190);
INSERT INTO public.order_items VALUES (27, 10, 18, 18, 1, 7550);
INSERT INTO public.order_items VALUES (28, 10, 15, 21, 1, 7130);
INSERT INTO public.order_items VALUES (29, 10, 16, 19, 1, 12340);
INSERT INTO public.order_items VALUES (30, 10, 21, 18, 2, 8765);


--
-- TOC entry 5084 (class 0 OID 20894)
-- Dependencies: 234
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.orders VALUES (1, '02.04.2026', 3);
INSERT INTO public.orders VALUES (2, '05.04.2026', 17);
INSERT INTO public.orders VALUES (3, '08.04.2026', 7);
INSERT INTO public.orders VALUES (4, '12.04.2026', 15);
INSERT INTO public.orders VALUES (5, '18.04.2026', 12);
INSERT INTO public.orders VALUES (6, '22.04.2026', 9);
INSERT INTO public.orders VALUES (7, '25.04.2026', 14);
INSERT INTO public.orders VALUES (8, '28.04.2026', 20);
INSERT INTO public.orders VALUES (9, '05.05.2026', 5);
INSERT INTO public.orders VALUES (10, '08.05.2026', 17);


--
-- TOC entry 5076 (class 0 OID 20793)
-- Dependencies: 226
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.products VALUES (1, 1, 'Кроссовки', 'IMG_KS_195217.png', 'Кроссовки детские «Звёздочка» экокожа', 'Малыш-Спорт', 'Кроссовки детские «Звёздочка» экокожа. Производитель: ООО «Малыш-Спорт» г. Смоленск', 'Верх — экокожа (полиуретан на хлопковой основе) подкладка — хлопок 100% подошва — ПВХ', 2190);
INSERT INTO public.products VALUES (2, 1, 'Кроссовки', 'IMG_KS_195213.png', 'Кроссовки детские «Гонщик» экокожа', 'Топ-Топ', 'Кроссовки детские «Гонщик» экокожа. Производитель: Фабрика «Топ-Топ» г. Киров', 'Верх — экокожа (микрофибра) подкладка — текстиль сетчатый (полиэстер) подошва — термопластичная резина (ТЭП)', 2490);
INSERT INTO public.products VALUES (3, 1, 'Кроссовки', 'IMG_KS_195222.png', 'Кроссовки детские «Радуга» экокожа перфорированная', 'Лапушка', 'Кроссовки детские «Радуга» экокожа перфорированная. Производитель: ИП Смирнова Л.В. (бренд «Лапушка») г. Вологда', 'Верх — экокожа перфорированная вставки — нейлон стелька — ортопедическая с латексной подушкой подошва — ЭВА', 1990);
INSERT INTO public.products VALUES (4, 1, 'Сапоги', 'IMG_KB_185501.png', 'Сапожки детские «Снежинка» зимние на меху', 'Тёплые ножки', 'Сапожки детские «Снежинка» зимние на меху. Производитель: ООО «Тёплые ножки» г. Новосибирск', 'Верх — экокожа морозостойкая утеплитель — искусственный мех (акрил 70% полиэстер 30%) подкладка — флис подошва — термоэластопласт (ТЭП)', 3490);
INSERT INTO public.products VALUES (5, 1, 'Сапоги', 'IMG_KB_164816.png', 'Сапожки детские «Медвежонок» демисезонные непромокаемые', 'Северята', 'Сапожки детские «Медвежонок» демисезонные непромокаемые. Производитель: Компания «Северята» г. Архангельск', 'Верх — плащёвая ткань с водоотталкивающей пропиткой (полиэстер 100%) отделка — экокожа подкладка — микрофибра мембрана — AirTex подошва — резина', 3190);
INSERT INTO public.products VALUES (6, 1, 'Сапоги', 'IMG_KB_164811.png', 'Сапожки детские «Принцесса» кожаные', 'Весна', 'Сапожки детские «Принцесса» кожаные. Производитель: Мастерская «Весна» г. Тула', 'Верх — натуральная кожа (КРС) подкладка — шерсть натуральная (70%) байка (30%) стелька — войлочная подошва — полиуретан', 4290);
INSERT INTO public.products VALUES (7, 1, 'Босоножки', 'IMG_KSd_195207.png', 'Сандалии детские «Пчёлка» ортопедические летние', 'Здоровый шаг', 'Сандалии детские «Пчёлка» ортопедические летние. Производитель: ООО «Здоровый шаг» г. Воронеж', 'Верх — нубук натуральный подкладка — кожа растительного дубления стелька — анатомическая с супинатором (латекс + пробка) подошва — каучук', 2790);
INSERT INTO public.products VALUES (8, 1, 'Босоножки', 'IMG_KSd_185508.png', 'Сандалии детские «Морячок» текстильные с фиксатором', 'Карапуз', 'Сандалии детские «Морячок» текстильные с фиксатором. Производитель: ИП Кузнецов А.Д. (бренд «Карапуз») г. Краснодар', 'Верх — джинсовая ткань (хлопок 100%) окантовка — искусственная кожа подкладка — хлопок подошва — ЭВА лёгкая', 1690);
INSERT INTO public.products VALUES (9, 1, 'Туфли', 'IMG_KSho_185512.png', 'Туфли детские «Бантик» лаковые праздничные', 'Маленький франт', 'Туфли детские «Бантик» лаковые праздничные. Производитель: Дом обуви «Маленький франт» г. Москва', 'Верх — искусственная лаковая кожа (ПВХ) носок усиленный — термопластичный полиуретан подкладка — кожа искусственная дышащая стелька — анатомическая с амортизацией подошва — полиуретан', 2390);
INSERT INTO public.products VALUES (10, 2, 'Сапоги', 'IMG_WB_170905.png', 'Сапоги зимние натуральная кожа', 'Барбари', 'Сапоги женские зимние нескользящая устойчивая подошва натуральный мех. Производитель: Дом обуви «Барбари» г. Новороссийск ', 'Верх — натуральная кожа подкладка — евромех натуральный мех текстильный утеплитель подошва — резина', 25000);
INSERT INTO public.products VALUES (11, 2, 'Сапоги', 'IMG_WB_170859.png', 'Сапоги осенние натуральная кожа', 'Барбари', 'Сапоги женские демисезонные из высококачественной натуральной кожи. Производитель: Дом обуви «Барбари» г. Новороссийск ', 'Верх — натуральная кожа подкладка — текстильный утеплитель стелька — текстиль подошва — ТПР', 15000);
INSERT INTO public.products VALUES (12, 2, 'Сапоги', 'IMG_WB_170906.png', 'Сапоги трубы демисезонные замшевые', 'Твой комфорт', 'Сапоги женские демисезонные замшевые. Производитель: ОАО «Твой комфорт» г. Ярославль', 'Верх — натуральная замша утепленные тракторная подошва стелька — байка подошва — резина', 17000);
INSERT INTO public.products VALUES (13, 2, 'Босоножки', 'IMG_WSd_174332.png', 'Босоножки «Песчаный берег» коричневые', 'Стиль и комфорт', 'Коричневая кожаная модель с открытым носком боковой пряжкой и закрытым каблуком. Производитель: ИП «Стиль и комфорт» г. Санкт-Петербург', 'Верх — 100% козья кожа подкладка — 100% кожа подошва: 100% кожа', 7500);
INSERT INTO public.products VALUES (14, 2, 'Босоножки', 'IMG_WSd_185156.png', 'Женские босоножки «Черный кофе» со скульптурным каблуком', 'Кожевенные традиции', 'Открытый носок и ремешок со сборной пряжкой низкий каблук и резиновая подошва гарантируют комфорт. Производитель: ЗАО «Кожевенные традиции» г. Вятка', 'Верх — кожа собственного производств подкладка — кожа подошва: резина', 5600);
INSERT INTO public.products VALUES (15, 2, 'Босоножки', 'IMG_WSd_185551.png', 'Босоножки женские «Летний бриз»', 'Модный силуэт', 'Босоножки женские кожаные белые регулируемый ремешок закрытый каблук и кожаная подошва. Производитель: ООО «Модный силуэт» г. Кострома', 'Верх — натуральная кожа подкладка — натуральная кожа подошва — кожа', 7130);
INSERT INTO public.products VALUES (16, 2, 'Туфли', 'IMG_WSho_174409.png', 'Демисезонные туфли натуральная кожа', 'Модный силуэт', 'Комфортные лаконичные лодочки классический дизайна с современными акцентами. Производитель: ООО «Модный силуэт» г. Кострома', 'Верх — натуральная овечья кожа подкладка и стелька — натуральная овечья кожа подошва — резина', 12340);
INSERT INTO public.products VALUES (17, 2, 'Туфли', 'IMG_WSho_185202.png', 'Туфли женские натуральная кожа с металлическими вставками', 'Кожевенные традиции', 'Стильные туфли для весеннего и летнего сезона. Производитель: ЗАО «Кожевенные традиции» г. Вятка', 'Верх — натуральная телячьей кожа металлическая пряжка подкладка и стелька— натуральная овечья кожа подошва — резина', 7757);
INSERT INTO public.products VALUES (18, 2, 'Туфли', 'IMG_WSho_185545.png', 'Туфли классические лодочки натуральная кожа', 'Стиль и комфорт', 'Модель из натуральной кожи классический острый носок и изящная шпилька. Производитель: ИП «Стиль и комфорт» г. Санкт-Петербург', 'Верх — натуральная кожа подкладка и стелька — натуральная кожа подошва — тунит', 7550);
INSERT INTO public.products VALUES (19, 2, 'Кроссовки', 'IMG_WS_174110.png', 'Кроссовки белые с оранжевым и красным', 'Топ-Топ', 'Многослойный верх из кожи и текстиля. Производитель: Фабрика «Топ-Топ» г. Киров', 'Верх — 70% кожа 30% текстиль подкладка — текстиль подошва — резина', 9450);
INSERT INTO public.products VALUES (20, 2, 'Кроссовки', 'IMG_WS_185528.png', 'Кроссовки летние кожаные', 'Топ-Топ', 'Уверенность на каждом шагу. Материал обеспечивает долговечность и комфорт при носке. Производитель: Фабрика «Топ-Топ» г. Киров', 'Верх — 87% кожа 11% текстиль 2% синтетика подкладка: 100% текстиль подошва: резина пластик', 8565);
INSERT INTO public.products VALUES (21, 2, 'Кроссовки', 'IMG_WS_185535.png', 'Кроссовки кожаные', 'Стиль и комфорт', 'Кроссовки женские из натуральной кожи. Производитель: ИП «Стиль и комфорт» г. Санкт-Петербург', 'Верх — натуральная кожа подкладка — кожа подошва — полиуретан', 8765);
INSERT INTO public.products VALUES (22, 2, 'Кроссовки', 'IMG_WS_185538.png', 'Кроссовки «Стиль и комфорт»', 'Стиль и комфорт', 'Кроссовки женские из натуральной кожи и синтетических материалов сетчатые вставки. Производитель: ИП «Стиль и комфорт» г. Санкт-Петербург', 'Верх — 70% кожа 20% полиамид 10% полиуретан подкладка — текстиль подошва — ТПУ', 7795);
INSERT INTO public.products VALUES (23, 3, 'Кроссовки', 'IMG_MS_185531.png', 'Кроссовки для бега «Драйв»', 'Азимут', 'Сочетание стиля комфорта и современных технологий. Производитель: Фабрика «Азимут» г. Санкт-Петербург', 'Верх —  сетка подкладка — текстиль подошва —  резина', 6550);
INSERT INTO public.products VALUES (24, 3, 'Кроссовки', 'IMG_MS_185532.png', 'Кроссовки «Азимут Бег» ', 'Азимут', 'Универсальный выбор для повседневного использования. Производитель: Фабрика «Азимут» г. Санкт-Петербург', 'Верх — 6% кожа 29% текстиль 15% полимерные материалы подкладка — 100% текстиль подошва — полимерные материалы резина', 7890);
INSERT INTO public.products VALUES (25, 3, 'Кроссовки', 'IMG_MS_185533.png', 'Кроссовки', 'Топ-Топ', 'Кроссовки для мужчин идеальное сочетание стиля и комфорта. Производитель: Фабрика «Топ-Топ» г. Киров', 'Верх — 56% кожа 29% текстиль 15% полимерные материалы подкладка — 100% текстиль подошва — полимерные материалы резина', 9567);
INSERT INTO public.products VALUES (26, 3, 'Туфли', 'IMG_MSho_190514.png', 'Черные туфли в классическом стиле — база для деловых образов', 'Барбари', 'Модель выполнена из натуральной кожи на резиновой подошве. Производитель: Дом обуви «Барбари» г. Новороссийск ', 'Верх — натуральная кожа подкладка — текстиль стелька — натуральная кожа подошва — резина', 24569);
INSERT INTO public.products VALUES (27, 3, 'Туфли', 'IMG_MSho_190518.png', 'Туфли мужские светлые классика демисезонные', 'Берестов', 'Туфли на низком каблуке кожаные', 'Верх — натуральная кожа подкладка — текстиль стелька — натуральная кожа подошва — ТЭП', 10155);
INSERT INTO public.products VALUES (28, 3, 'Туфли', 'IMG_MSho_191612.png', 'Туфли из натуральной кожи', 'Берестов', 'Модель выполнена из натуральной кожи на резиновой подошве поддеживает классический и деловой стиль образов. Производитель: Дом обуви «Берестов» г. Москва', 'Верх — натуральная кожа подкладка — натуральная кожа стелька — натуральная кожа подошва — резина', 25625);
INSERT INTO public.products VALUES (29, 3, 'Ботинки', 'IMG_MB_174349.png', 'Ботинки мужские демисезонные', 'Барбари', 'Ботинки из натуральной кожи темно-коричневого и черного цвета на шнурках. Производитель: Дом обуви «Берестов» г. Москва', 'Верх — натуральная кожа подкладка — текстиль подошва — искусственный материал', 21500);
INSERT INTO public.products VALUES (30, 3, 'Ботинки', 'IMG_MB_191200.png', 'Ботинки черные из натуральной кожи', 'Кожевенные традиции', 'Ботинки представляют баланс традиций и современности. Выполнены из натуральной кожи насыщенного черного цвета. Производитель: ЗАО «Кожевенные традиции» г. Вятка', 'Верх — натуральная кожа подкладка — ворсин стелька — ворсин подошва — тунит', 14567);
INSERT INTO public.products VALUES (31, 3, 'Ботинки', 'IMG_MB_191205.png', 'Ботинки зимние классические', 'Барбари', 'Выбор на каждый день — натуральная кожа натуральный мех. Производитель: Дом обуви «Барбари» г. Новороссийск ', 'Верх — натуральная кожа подкладка — натуральный мех стелька — натуральный мех подошва — ТЭП', 15670);


--
-- TOC entry 5070 (class 0 OID 20763)
-- Dependencies: 220
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.roles VALUES (1, 'Администратор');
INSERT INTO public.roles VALUES (2, 'Менеджер');
INSERT INTO public.roles VALUES (3, 'Авторизованный пользователь');


--
-- TOC entry 5078 (class 0 OID 20809)
-- Dependencies: 228
-- Data for Name: sizes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sizes VALUES (1, '18');
INSERT INTO public.sizes VALUES (2, '19');
INSERT INTO public.sizes VALUES (3, '20');
INSERT INTO public.sizes VALUES (4, '21');
INSERT INTO public.sizes VALUES (5, '22');
INSERT INTO public.sizes VALUES (6, '23');
INSERT INTO public.sizes VALUES (7, '24');
INSERT INTO public.sizes VALUES (8, '25');
INSERT INTO public.sizes VALUES (9, '26');
INSERT INTO public.sizes VALUES (10, '27');
INSERT INTO public.sizes VALUES (11, '28');
INSERT INTO public.sizes VALUES (12, '29');
INSERT INTO public.sizes VALUES (13, '30');
INSERT INTO public.sizes VALUES (14, '31');
INSERT INTO public.sizes VALUES (15, '32');
INSERT INTO public.sizes VALUES (16, '33');
INSERT INTO public.sizes VALUES (17, '34');
INSERT INTO public.sizes VALUES (18, '35');
INSERT INTO public.sizes VALUES (19, '36');
INSERT INTO public.sizes VALUES (20, '36.5');
INSERT INTO public.sizes VALUES (21, '37');
INSERT INTO public.sizes VALUES (22, '37.5');
INSERT INTO public.sizes VALUES (23, '38');
INSERT INTO public.sizes VALUES (24, '38.5');
INSERT INTO public.sizes VALUES (25, '39');
INSERT INTO public.sizes VALUES (26, '39.5');
INSERT INTO public.sizes VALUES (27, '40');
INSERT INTO public.sizes VALUES (28, '40.5');
INSERT INTO public.sizes VALUES (29, '41');
INSERT INTO public.sizes VALUES (30, '41.5');
INSERT INTO public.sizes VALUES (31, '42');
INSERT INTO public.sizes VALUES (32, '42.5');
INSERT INTO public.sizes VALUES (33, '43');
INSERT INTO public.sizes VALUES (34, '44');
INSERT INTO public.sizes VALUES (35, '45');


--
-- TOC entry 5080 (class 0 OID 20817)
-- Dependencies: 230
-- Data for Name: stock_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.stock_items VALUES (1, 1, 3, 20);
INSERT INTO public.stock_items VALUES (2, 1, 4, 20);
INSERT INTO public.stock_items VALUES (3, 1, 5, 20);
INSERT INTO public.stock_items VALUES (4, 1, 6, 20);
INSERT INTO public.stock_items VALUES (5, 1, 7, 20);
INSERT INTO public.stock_items VALUES (6, 1, 8, 20);
INSERT INTO public.stock_items VALUES (7, 2, 16, 2);
INSERT INTO public.stock_items VALUES (8, 2, 17, 2);
INSERT INTO public.stock_items VALUES (9, 3, 2, 30);
INSERT INTO public.stock_items VALUES (10, 3, 3, 30);
INSERT INTO public.stock_items VALUES (11, 4, 2, 15);
INSERT INTO public.stock_items VALUES (12, 4, 3, 15);
INSERT INTO public.stock_items VALUES (13, 5, 4, 5);
INSERT INTO public.stock_items VALUES (14, 5, 5, 5);
INSERT INTO public.stock_items VALUES (15, 5, 6, 5);
INSERT INTO public.stock_items VALUES (16, 6, 1, 4);
INSERT INTO public.stock_items VALUES (17, 6, 2, 4);
INSERT INTO public.stock_items VALUES (18, 6, 3, 4);
INSERT INTO public.stock_items VALUES (19, 7, 4, 4);
INSERT INTO public.stock_items VALUES (20, 7, 5, 4);
INSERT INTO public.stock_items VALUES (21, 7, 6, 4);
INSERT INTO public.stock_items VALUES (22, 7, 7, 4);
INSERT INTO public.stock_items VALUES (23, 8, 10, 7);
INSERT INTO public.stock_items VALUES (24, 8, 11, 7);
INSERT INTO public.stock_items VALUES (25, 8, 12, 7);
INSERT INTO public.stock_items VALUES (26, 8, 13, 7);
INSERT INTO public.stock_items VALUES (27, 9, 1, 7);
INSERT INTO public.stock_items VALUES (28, 9, 2, 7);
INSERT INTO public.stock_items VALUES (29, 9, 3, 7);
INSERT INTO public.stock_items VALUES (30, 10, 19, 12);
INSERT INTO public.stock_items VALUES (31, 10, 21, 12);
INSERT INTO public.stock_items VALUES (32, 11, 25, 2);
INSERT INTO public.stock_items VALUES (33, 11, 27, 2);
INSERT INTO public.stock_items VALUES (34, 12, 21, 5);
INSERT INTO public.stock_items VALUES (35, 12, 25, 5);
INSERT INTO public.stock_items VALUES (36, 12, 27, 5);
INSERT INTO public.stock_items VALUES (37, 13, 19, 10);
INSERT INTO public.stock_items VALUES (38, 13, 21, 10);
INSERT INTO public.stock_items VALUES (39, 13, 23, 10);
INSERT INTO public.stock_items VALUES (40, 13, 25, 10);
INSERT INTO public.stock_items VALUES (41, 13, 27, 10);
INSERT INTO public.stock_items VALUES (42, 14, 18, 3);
INSERT INTO public.stock_items VALUES (43, 15, 21, 23);
INSERT INTO public.stock_items VALUES (44, 15, 25, 23);
INSERT INTO public.stock_items VALUES (45, 15, 27, 23);
INSERT INTO public.stock_items VALUES (46, 16, 19, 25);
INSERT INTO public.stock_items VALUES (47, 16, 21, 25);
INSERT INTO public.stock_items VALUES (48, 16, 23, 25);
INSERT INTO public.stock_items VALUES (49, 17, 19, 4);
INSERT INTO public.stock_items VALUES (50, 17, 23, 4);
INSERT INTO public.stock_items VALUES (51, 17, 25, 4);
INSERT INTO public.stock_items VALUES (52, 17, 27, 4);
INSERT INTO public.stock_items VALUES (53, 18, 18, 9);
INSERT INTO public.stock_items VALUES (54, 18, 23, 9);
INSERT INTO public.stock_items VALUES (55, 19, 18, 2);
INSERT INTO public.stock_items VALUES (56, 19, 19, 2);
INSERT INTO public.stock_items VALUES (57, 20, 21, 5);
INSERT INTO public.stock_items VALUES (58, 20, 22, 5);
INSERT INTO public.stock_items VALUES (59, 20, 23, 5);
INSERT INTO public.stock_items VALUES (60, 20, 24, 5);
INSERT INTO public.stock_items VALUES (61, 21, 18, 16);
INSERT INTO public.stock_items VALUES (62, 21, 19, 16);
INSERT INTO public.stock_items VALUES (63, 21, 23, 16);
INSERT INTO public.stock_items VALUES (64, 21, 25, 16);
INSERT INTO public.stock_items VALUES (65, 22, 18, 3);
INSERT INTO public.stock_items VALUES (66, 22, 23, 3);
INSERT INTO public.stock_items VALUES (67, 23, 30, 18);
INSERT INTO public.stock_items VALUES (68, 23, 31, 18);
INSERT INTO public.stock_items VALUES (69, 23, 32, 18);
INSERT INTO public.stock_items VALUES (70, 23, 33, 18);
INSERT INTO public.stock_items VALUES (71, 24, 23, 50);
INSERT INTO public.stock_items VALUES (72, 24, 24, 50);
INSERT INTO public.stock_items VALUES (73, 24, 25, 50);
INSERT INTO public.stock_items VALUES (74, 24, 26, 50);
INSERT INTO public.stock_items VALUES (75, 24, 27, 50);
INSERT INTO public.stock_items VALUES (76, 24, 29, 50);
INSERT INTO public.stock_items VALUES (77, 25, 29, 3);
INSERT INTO public.stock_items VALUES (78, 25, 31, 3);
INSERT INTO public.stock_items VALUES (79, 25, 34, 3);
INSERT INTO public.stock_items VALUES (80, 26, 27, 23);
INSERT INTO public.stock_items VALUES (81, 26, 29, 23);
INSERT INTO public.stock_items VALUES (82, 26, 33, 23);
INSERT INTO public.stock_items VALUES (83, 27, 31, 15);
INSERT INTO public.stock_items VALUES (84, 27, 33, 15);
INSERT INTO public.stock_items VALUES (85, 27, 34, 15);
INSERT INTO public.stock_items VALUES (86, 28, 34, 3);
INSERT INTO public.stock_items VALUES (87, 29, 29, 1);
INSERT INTO public.stock_items VALUES (88, 29, 31, 1);
INSERT INTO public.stock_items VALUES (89, 30, 31, 20);
INSERT INTO public.stock_items VALUES (90, 30, 33, 20);
INSERT INTO public.stock_items VALUES (91, 31, 29, 30);
INSERT INTO public.stock_items VALUES (92, 31, 31, 30);


--
-- TOC entry 5072 (class 0 OID 20771)
-- Dependencies: 222
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (1, 'Иванов', 'Иван', 'Сергеевич', 'isivanov', 1);
INSERT INTO public.users VALUES (2, 'Петров', 'Пётр', 'Алексеевич', 'papetrov', 2);
INSERT INTO public.users VALUES (3, 'Сидорова', 'Анна', 'Дмитриевна', 'asidorova', 3);
INSERT INTO public.users VALUES (4, 'Кузнецова', 'Екатерина', 'Андреевна', 'ekuznetsova', 2);
INSERT INTO public.users VALUES (5, 'Смирнов', 'Дмитрий', 'Владимирович', 'dsmirnov', 3);
INSERT INTO public.users VALUES (6, 'Попов', 'Алексей', 'Николаевич', 'apopov', 1);
INSERT INTO public.users VALUES (7, 'Васильева', 'Ольга', 'Игоревна', 'ovasileva', 3);
INSERT INTO public.users VALUES (8, 'Соколов', 'Павел', 'Викторович', 'psokolov', 2);
INSERT INTO public.users VALUES (9, 'Михайлова', 'Татьяна', 'Юрьевна', 'tmikhailova', 3);
INSERT INTO public.users VALUES (10, 'Новикова', 'Наталья', 'Сергеевна', 'nnovikova', 2);
INSERT INTO public.users VALUES (11, 'Фёдоров', 'Андрей', 'Максимович', 'afedorov', 1);
INSERT INTO public.users VALUES (12, 'Морозов', 'Сергей', 'Павлович', 'smorozov', 3);
INSERT INTO public.users VALUES (13, 'Волкова', 'Юлия', 'Александровна', 'jvolkova', 2);
INSERT INTO public.users VALUES (14, 'Алексеев', 'Артём', 'Евгеньевич', 'aalekseev', 3);
INSERT INTO public.users VALUES (15, 'Лебедева', 'Ирина', 'Владимировна', 'ilebedeva', 3);
INSERT INTO public.users VALUES (16, 'Егоров', 'Никита', 'Денисович', 'negorov', 2);
INSERT INTO public.users VALUES (17, 'Павлова', 'Елена', 'Петровна', 'epavlova', 3);
INSERT INTO public.users VALUES (18, 'Козлов', 'Роман', 'Олегович', 'rkozlov', 1);
INSERT INTO public.users VALUES (19, 'Степанова', 'Виктория', 'Романовна', 'vstepanova', 2);
INSERT INTO public.users VALUES (20, 'Николаев', 'Владимир', 'Иванович', 'vnikolaev', 3);


--
-- TOC entry 5098 (class 0 OID 0)
-- Dependencies: 223
-- Name: category_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.category_category_id_seq', 3, true);


--
-- TOC entry 5099 (class 0 OID 0)
-- Dependencies: 231
-- Name: order_items_order_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_order_item_id_seq', 30, true);


--
-- TOC entry 5100 (class 0 OID 0)
-- Dependencies: 233
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 10, true);


--
-- TOC entry 5101 (class 0 OID 0)
-- Dependencies: 225
-- Name: products_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_product_id_seq', 31, true);


--
-- TOC entry 5102 (class 0 OID 0)
-- Dependencies: 219
-- Name: roles_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_role_id_seq', 3, true);


--
-- TOC entry 5103 (class 0 OID 0)
-- Dependencies: 227
-- Name: sizes_size_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sizes_size_id_seq', 35, true);


--
-- TOC entry 5104 (class 0 OID 0)
-- Dependencies: 229
-- Name: stock_items_stock_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stock_items_stock_item_id_seq', 92, true);


--
-- TOC entry 5105 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 20, true);


--
-- TOC entry 4904 (class 2606 OID 20791)
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);


--
-- TOC entry 4912 (class 2606 OID 20863)
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (order_item_id);


--
-- TOC entry 4914 (class 2606 OID 20901)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- TOC entry 4906 (class 2606 OID 20802)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- TOC entry 4900 (class 2606 OID 20769)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (role_id);


--
-- TOC entry 4908 (class 2606 OID 20815)
-- Name: sizes sizes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sizes
    ADD CONSTRAINT sizes_pkey PRIMARY KEY (size_id);


--
-- TOC entry 4910 (class 2606 OID 20825)
-- Name: stock_items stock_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_items
    ADD CONSTRAINT stock_items_pkey PRIMARY KEY (stock_item_id);


--
-- TOC entry 4902 (class 2606 OID 20778)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 4919 (class 2606 OID 20869)
-- Name: order_items order_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id);


--
-- TOC entry 4920 (class 2606 OID 20874)
-- Name: order_items order_items_size_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_size_id_fkey FOREIGN KEY (size_id) REFERENCES public.sizes(size_id);


--
-- TOC entry 4921 (class 2606 OID 20902)
-- Name: orders orders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- TOC entry 4916 (class 2606 OID 20803)
-- Name: products products_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(category_id);


--
-- TOC entry 4917 (class 2606 OID 20826)
-- Name: stock_items stock_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_items
    ADD CONSTRAINT stock_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id);


--
-- TOC entry 4918 (class 2606 OID 20831)
-- Name: stock_items stock_items_size_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_items
    ADD CONSTRAINT stock_items_size_id_fkey FOREIGN KEY (size_id) REFERENCES public.sizes(size_id);


--
-- TOC entry 4915 (class 2606 OID 20779)
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(role_id);


-- Completed on 2026-10-30 13:31:06

--
-- PostgreSQL database dump complete
--

\unrestrict u52gWmeFre6bVFMYiD6saOXxjzwWfCkDwMQ03LdHPdbmdq9wtL5sKdgUtYgQYuC

