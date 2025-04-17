--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22
-- Dumped by pg_dump version 12.22

-- Started on 2025-04-17 12:43:56

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

SET default_table_access_method = heap;

--
-- TOC entry 205 (class 1259 OID 16412)
-- Name: abonnements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.abonnements (
    id integer NOT NULL,
    utilisateur_id integer,
    type character varying(50) NOT NULL,
    date_debut date NOT NULL,
    date_fin date NOT NULL,
    status character varying(20) DEFAULT 'actif'::character varying,
    CONSTRAINT abonnements_status_check CHECK (((status)::text = ANY ((ARRAY['actif'::character varying, 'expir‚'::character varying, 'suspendu'::character varying])::text[]))),
    CONSTRAINT abonnements_type_check CHECK (((type)::text = ANY ((ARRAY['mensuel'::character varying, 'annuel'::character varying, 'hebdomadaire'::character varying])::text[])))
);


ALTER TABLE public.abonnements OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16410)
-- Name: abonnements_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.abonnements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.abonnements_id_seq OWNER TO postgres;

--
-- TOC entry 2936 (class 0 OID 0)
-- Dependencies: 204
-- Name: abonnements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.abonnements_id_seq OWNED BY public.abonnements.id;


--
-- TOC entry 213 (class 1259 OID 16481)
-- Name: acces; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.acces (
    id integer NOT NULL,
    utilisateur_id integer,
    abonnement_id integer,
    type_acces character varying(50) NOT NULL,
    code_acces text NOT NULL,
    CONSTRAINT acces_type_acces_check CHECK (((type_acces)::text = ANY ((ARRAY['QR Code'::character varying, 'mot de passe'::character varying, 'badge'::character varying])::text[])))
);


ALTER TABLE public.acces OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16479)
-- Name: acces_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.acces_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.acces_id_seq OWNER TO postgres;

--
-- TOC entry 2937 (class 0 OID 0)
-- Dependencies: 212
-- Name: acces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.acces_id_seq OWNED BY public.acces.id;


--
-- TOC entry 211 (class 1259 OID 16461)
-- Name: paiements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paiements (
    id integer NOT NULL,
    utilisateur_id integer,
    abonnement_id integer,
    montant numeric(10,2) NOT NULL,
    mode_paiement character varying(50) NOT NULL,
    date_paiement timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT paiements_mode_paiement_check CHECK (((mode_paiement)::text = ANY ((ARRAY['carte'::character varying, 'paypal'::character varying, 'virement'::character varying])::text[])))
);


ALTER TABLE public.paiements OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16459)
-- Name: paiements_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.paiements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.paiements_id_seq OWNER TO postgres;

--
-- TOC entry 2938 (class 0 OID 0)
-- Dependencies: 210
-- Name: paiements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paiements_id_seq OWNED BY public.paiements.id;


--
-- TOC entry 209 (class 1259 OID 16441)
-- Name: reservations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reservations (
    id integer NOT NULL,
    utilisateur_id integer,
    service_id integer,
    date_reservation timestamp without time zone NOT NULL,
    status character varying(20) DEFAULT 'en attente'::character varying,
    CONSTRAINT reservations_status_check CHECK (((status)::text = ANY ((ARRAY['confirm‚e'::character varying, 'annul‚e'::character varying, 'en attente'::character varying])::text[])))
);


ALTER TABLE public.reservations OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16439)
-- Name: reservations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reservations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reservations_id_seq OWNER TO postgres;

--
-- TOC entry 2939 (class 0 OID 0)
-- Dependencies: 208
-- Name: reservations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reservations_id_seq OWNED BY public.reservations.id;


--
-- TOC entry 207 (class 1259 OID 16428)
-- Name: services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.services (
    id integer NOT NULL,
    nom character varying(100) NOT NULL,
    description text,
    prix numeric(10,2) NOT NULL
);


ALTER TABLE public.services OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 16426)
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.services_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.services_id_seq OWNER TO postgres;

--
-- TOC entry 2940 (class 0 OID 0)
-- Dependencies: 206
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.services_id_seq OWNED BY public.services.id;


--
-- TOC entry 215 (class 1259 OID 16505)
-- Name: statistiques; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.statistiques (
    id integer NOT NULL,
    nombre_abonnements integer DEFAULT 0,
    nombre_reservations integer DEFAULT 0,
    revenus_totaux numeric(10,2) DEFAULT 0.00,
    date_statistique timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.statistiques OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16503)
-- Name: statistiques_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.statistiques_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.statistiques_id_seq OWNER TO postgres;

--
-- TOC entry 2941 (class 0 OID 0)
-- Dependencies: 214
-- Name: statistiques_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.statistiques_id_seq OWNED BY public.statistiques.id;


--
-- TOC entry 217 (class 1259 OID 16517)
-- Name: utilisateur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utilisateur (
    id integer NOT NULL,
    nom character varying NOT NULL,
    email character varying NOT NULL,
    mot_de_passe character varying NOT NULL,
    role character varying NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.utilisateur OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16515)
-- Name: utilisateur_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.utilisateur_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.utilisateur_id_seq OWNER TO postgres;

--
-- TOC entry 2942 (class 0 OID 0)
-- Dependencies: 216
-- Name: utilisateur_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.utilisateur_id_seq OWNED BY public.utilisateur.id;


--
-- TOC entry 203 (class 1259 OID 16396)
-- Name: utilisateurs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utilisateurs (
    id integer NOT NULL,
    nom character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    mot_de_passe text NOT NULL,
    role character varying(50) DEFAULT 'client'::character varying,
    date_inscription timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT utilisateurs_role_check CHECK (((role)::text = ANY ((ARRAY['admin'::character varying, 'client'::character varying])::text[])))
);


ALTER TABLE public.utilisateurs OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16394)
-- Name: utilisateurs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.utilisateurs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.utilisateurs_id_seq OWNER TO postgres;

--
-- TOC entry 2943 (class 0 OID 0)
-- Dependencies: 202
-- Name: utilisateurs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.utilisateurs_id_seq OWNED BY public.utilisateurs.id;


--
-- TOC entry 2737 (class 2604 OID 16415)
-- Name: abonnements id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.abonnements ALTER COLUMN id SET DEFAULT nextval('public.abonnements_id_seq'::regclass);


--
-- TOC entry 2748 (class 2604 OID 16484)
-- Name: acces id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acces ALTER COLUMN id SET DEFAULT nextval('public.acces_id_seq'::regclass);


--
-- TOC entry 2745 (class 2604 OID 16464)
-- Name: paiements id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paiements ALTER COLUMN id SET DEFAULT nextval('public.paiements_id_seq'::regclass);


--
-- TOC entry 2742 (class 2604 OID 16444)
-- Name: reservations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations ALTER COLUMN id SET DEFAULT nextval('public.reservations_id_seq'::regclass);


--
-- TOC entry 2741 (class 2604 OID 16431)
-- Name: services id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services ALTER COLUMN id SET DEFAULT nextval('public.services_id_seq'::regclass);


--
-- TOC entry 2750 (class 2604 OID 16508)
-- Name: statistiques id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statistiques ALTER COLUMN id SET DEFAULT nextval('public.statistiques_id_seq'::regclass);


--
-- TOC entry 2755 (class 2604 OID 16520)
-- Name: utilisateur id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur ALTER COLUMN id SET DEFAULT nextval('public.utilisateur_id_seq'::regclass);


--
-- TOC entry 2733 (class 2604 OID 16399)
-- Name: utilisateurs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateurs ALTER COLUMN id SET DEFAULT nextval('public.utilisateurs_id_seq'::regclass);


--
-- TOC entry 2918 (class 0 OID 16412)
-- Dependencies: 205
-- Data for Name: abonnements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.abonnements (id, utilisateur_id, type, date_debut, date_fin, status) FROM stdin;
\.


--
-- TOC entry 2926 (class 0 OID 16481)
-- Dependencies: 213
-- Data for Name: acces; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.acces (id, utilisateur_id, abonnement_id, type_acces, code_acces) FROM stdin;
\.


--
-- TOC entry 2924 (class 0 OID 16461)
-- Dependencies: 211
-- Data for Name: paiements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.paiements (id, utilisateur_id, abonnement_id, montant, mode_paiement, date_paiement) FROM stdin;
\.


--
-- TOC entry 2922 (class 0 OID 16441)
-- Dependencies: 209
-- Data for Name: reservations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reservations (id, utilisateur_id, service_id, date_reservation, status) FROM stdin;
\.


--
-- TOC entry 2920 (class 0 OID 16428)
-- Dependencies: 207
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.services (id, nom, description, prix) FROM stdin;
\.


--
-- TOC entry 2928 (class 0 OID 16505)
-- Dependencies: 215
-- Data for Name: statistiques; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.statistiques (id, nombre_abonnements, nombre_reservations, revenus_totaux, date_statistique) FROM stdin;
\.


--
-- TOC entry 2930 (class 0 OID 16517)
-- Dependencies: 217
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateur (id, nom, email, mot_de_passe, role, "createdAt", "updatedAt") FROM stdin;
1	yousef	yousef@example.com	yousef123	client	2025-04-14 22:08:17.497741	2025-04-14 22:08:17.497741
\.


--
-- TOC entry 2916 (class 0 OID 16396)
-- Dependencies: 203
-- Data for Name: utilisateurs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateurs (id, nom, email, mot_de_passe, role, date_inscription) FROM stdin;
1	bouzid eya	ayabouzid@gmail.com	eya123	client	2025-04-14 18:49:49.124497
2	nour	nournour@gmail.com	nour123	client	2025-04-14 18:50:46.319323
\.


--
-- TOC entry 2944 (class 0 OID 0)
-- Dependencies: 204
-- Name: abonnements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.abonnements_id_seq', 1, false);


--
-- TOC entry 2945 (class 0 OID 0)
-- Dependencies: 212
-- Name: acces_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.acces_id_seq', 1, false);


--
-- TOC entry 2946 (class 0 OID 0)
-- Dependencies: 210
-- Name: paiements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paiements_id_seq', 1, false);


--
-- TOC entry 2947 (class 0 OID 0)
-- Dependencies: 208
-- Name: reservations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reservations_id_seq', 1, false);


--
-- TOC entry 2948 (class 0 OID 0)
-- Dependencies: 206
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.services_id_seq', 1, false);


--
-- TOC entry 2949 (class 0 OID 0)
-- Dependencies: 214
-- Name: statistiques_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.statistiques_id_seq', 1, false);


--
-- TOC entry 2950 (class 0 OID 0)
-- Dependencies: 216
-- Name: utilisateur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.utilisateur_id_seq', 5, true);


--
-- TOC entry 2951 (class 0 OID 0)
-- Dependencies: 202
-- Name: utilisateurs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.utilisateurs_id_seq', 5, true);


--
-- TOC entry 2779 (class 2606 OID 16527)
-- Name: utilisateur PK_838f0f99fe900e49ef050030443; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT "PK_838f0f99fe900e49ef050030443" PRIMARY KEY (id);


--
-- TOC entry 2781 (class 2606 OID 16529)
-- Name: utilisateur UQ_e1136325a6b28e2a02b81b2f5e1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT "UQ_e1136325a6b28e2a02b81b2f5e1" UNIQUE (email);


--
-- TOC entry 2763 (class 2606 OID 16420)
-- Name: abonnements abonnements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.abonnements
    ADD CONSTRAINT abonnements_pkey PRIMARY KEY (id);


--
-- TOC entry 2773 (class 2606 OID 16492)
-- Name: acces acces_code_acces_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acces
    ADD CONSTRAINT acces_code_acces_key UNIQUE (code_acces);


--
-- TOC entry 2775 (class 2606 OID 16490)
-- Name: acces acces_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acces
    ADD CONSTRAINT acces_pkey PRIMARY KEY (id);


--
-- TOC entry 2771 (class 2606 OID 16468)
-- Name: paiements paiements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paiements
    ADD CONSTRAINT paiements_pkey PRIMARY KEY (id);


--
-- TOC entry 2769 (class 2606 OID 16448)
-- Name: reservations reservations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_pkey PRIMARY KEY (id);


--
-- TOC entry 2765 (class 2606 OID 16438)
-- Name: services services_nom_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_nom_key UNIQUE (nom);


--
-- TOC entry 2767 (class 2606 OID 16436)
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- TOC entry 2777 (class 2606 OID 16514)
-- Name: statistiques statistiques_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statistiques
    ADD CONSTRAINT statistiques_pkey PRIMARY KEY (id);


--
-- TOC entry 2759 (class 2606 OID 16409)
-- Name: utilisateurs utilisateurs_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT utilisateurs_email_key UNIQUE (email);


--
-- TOC entry 2761 (class 2606 OID 16407)
-- Name: utilisateurs utilisateurs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT utilisateurs_pkey PRIMARY KEY (id);


--
-- TOC entry 2782 (class 2606 OID 16421)
-- Name: abonnements abonnements_utilisateur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.abonnements
    ADD CONSTRAINT abonnements_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateurs(id) ON DELETE CASCADE;


--
-- TOC entry 2788 (class 2606 OID 16498)
-- Name: acces acces_abonnement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acces
    ADD CONSTRAINT acces_abonnement_id_fkey FOREIGN KEY (abonnement_id) REFERENCES public.abonnements(id) ON DELETE CASCADE;


--
-- TOC entry 2787 (class 2606 OID 16493)
-- Name: acces acces_utilisateur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acces
    ADD CONSTRAINT acces_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateurs(id) ON DELETE CASCADE;


--
-- TOC entry 2786 (class 2606 OID 16474)
-- Name: paiements paiements_abonnement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paiements
    ADD CONSTRAINT paiements_abonnement_id_fkey FOREIGN KEY (abonnement_id) REFERENCES public.abonnements(id) ON DELETE SET NULL;


--
-- TOC entry 2785 (class 2606 OID 16469)
-- Name: paiements paiements_utilisateur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paiements
    ADD CONSTRAINT paiements_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateurs(id) ON DELETE CASCADE;


--
-- TOC entry 2784 (class 2606 OID 16454)
-- Name: reservations reservations_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(id) ON DELETE CASCADE;


--
-- TOC entry 2783 (class 2606 OID 16449)
-- Name: reservations reservations_utilisateur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateurs(id) ON DELETE CASCADE;


-- Completed on 2025-04-17 12:43:59

--
-- PostgreSQL database dump complete
--

