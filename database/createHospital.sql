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

--
-- Name: ospedale; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA ospedale;


ALTER SCHEMA ospedale OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: impiegato; Type: TABLE; Schema: ospedale; Owner: postgres
--

CREATE TABLE ospedale.impiegato (
    nome character varying(15) NOT NULL,
    cognome character varying(15) NOT NULL,
    id_imp character(5) NOT NULL,
    data_n date,
    indirizzo character varying(30) DEFAULT NULL::character varying,
    sesso character(1) DEFAULT NULL::bpchar,
    stipendio numeric(9,0) DEFAULT NULL::numeric,
    ruolo character varying(15) NOT NULL,
    n_rep smallint NOT NULL
);


ALTER TABLE ospedale.impiegato OWNER TO postgres;

--
-- Name: infermiere; Type: TABLE; Schema: ospedale; Owner: postgres
--

CREATE TABLE ospedale.infermiere (
    id_inf character(5) NOT NULL,
    anni_exp smallint
);


ALTER TABLE ospedale.infermiere OWNER TO postgres;

--
-- Name: medico; Type: TABLE; Schema: ospedale; Owner: postgres
--

CREATE TABLE ospedale.medico (
    id_medico character(5) NOT NULL,
    specializzaz character varying(20) DEFAULT NULL::character varying
);


ALTER TABLE ospedale.medico OWNER TO postgres;

--
-- Name: paziente; Type: TABLE; Schema: ospedale; Owner: postgres
--

CREATE TABLE ospedale.paziente (
    nome character varying(15) NOT NULL,
    cognome character varying(15) NOT NULL,
    cf character(9) NOT NULL,
    data_n date,
    indirizzo character varying(30) DEFAULT NULL::character varying,
    sesso character(1) DEFAULT NULL::bpchar,
    gruppo_sang character varying(2) DEFAULT NULL::bpchar,
    num_rep smallint NOT NULL
);


ALTER TABLE ospedale.paziente OWNER TO postgres;

--
-- Name: prescrizione; Type: TABLE; Schema: ospedale; Owner: postgres
--

CREATE TABLE ospedale.prescrizione (
    id_prescr character(5) NOT NULL,
    id_med character(5) NOT NULL,
    cf_paz character(9) NOT NULL,
    farmaco character varying(15) NOT NULL,
    dose_mg numeric(7,2) DEFAULT NULL::numeric,
    n_dosi_gg smallint,
    data_inizio date,
    data_fine date,
    prezzo numeric(8,2) DEFAULT NULL::numeric
);


ALTER TABLE ospedale.prescrizione OWNER TO postgres;

--
-- Name: reparto; Type: TABLE; Schema: ospedale; Owner: postgres
--

CREATE TABLE ospedale.reparto (
    nome_r character varying(15) NOT NULL,
    numero_r smallint NOT NULL,
    id_primario character(5) NOT NULL,
    num_camere smallint
);


ALTER TABLE ospedale.reparto OWNER TO postgres;

--
-- Data for Name: impiegato; Type: TABLE DATA; Schema: ospedale; Owner: postgres
--

COPY ospedale.impiegato (nome, cognome, id_imp, data_n, indirizzo, sesso, stipendio, ruolo, n_rep) FROM stdin;
Carmela	Arpa	59764	1991-05-23	\N	F	\N	Medico	2
Franco	Maruzzi	33344	1955-12-08	via Sentenza 45, Ferrara	M	64000	Medico         	5
Ginevra	Calabria\n	45345	1972-07-31	via Calma 12, Ferrara	F	35000	Infermiere     	5
Ramiro\n\n	Nicosia	66688	1962-09-15	via Animaliamo 78, Ferrara	M	\N	OSS            	5
Giovanni	Bice	88866	1937-11-10	via Alligatore 7, Ferrara	M	48000	Medico	1
Elisa\n	Sintolo	98765	1941-06-20	via delle Volte 51, Ferrara	F	75000	Medico	4
Alice	Mirto	99988	1968-07-19	via Alambicco 96, Ferrara	F	\N	Medico         	4
Orietta	Berti\n	48848	1907-10-02	via Alchimisti 8, Ferrara	F	8500000	Infermiere	2
Armando	Altieri	61254	1956-02-20	\N	\N	\N	Infermiere\n	2
Simone	Uzzi	12345	1965-01-09	via Carmine 1, Ferrara	M	55000	Medico         	3
Omar\n	Salobi	98798	1969-03-29	via Senzienti 5, Ferrara	M	\N	Tecnico        	3
\.


--
-- Data for Name: infermiere; Type: TABLE DATA; Schema: ospedale; Owner: postgres
--

COPY ospedale.infermiere (id_inf, anni_exp) FROM stdin;
45345	5
48848	42
61254	\N
\.


--
-- Data for Name: medico; Type: TABLE DATA; Schema: ospedale; Owner: postgres
--

COPY ospedale.medico (id_medico, specializzaz) FROM stdin;
12345	Psichiatria
33344	NULL
88866	Ortopedia
98765	Cardiologia
59764	Ginecologia
99988	\N
\.


--
-- Data for Name: paziente; Type: TABLE DATA; Schema: ospedale; Owner: postgres
--

COPY ospedale.paziente (nome, cognome, cf, data_n, indirizzo, sesso, gruppo_sang, num_rep) FROM stdin;
Alessandro	Franco	lssfrn981	1998-02-25	via Giovecca 211, Ferrara	M	A	5
Simona	Bus	smnbsu851	1985-06-25	via SanG 52, Ferrara	F	B	5
Alessio	Asti	xlstsi451	1945-05-03	via Aramri 11, Ferrara	M	AB	4
Rodrigo	Carimo	rdrcrm671	1967-11-12	via Beta 8, Ferrara	M	B	4
Giovanni	Smitteri	cfPazient	1965-01-09	via Sempronio 3, Ferrara	M	AB	5
Simona	Altieri	smnltr894	1965-05-10	\N	F	\N	2
Alessandra	Sempronio	lsnsmp894	1999-05-20	via Allocco 5, Ferrara	F	A	2
Anita	Manica	ntamnc465	1895-12-27	via Milani 8, Ferrara	F	B	2
Martino 	Campanaro	mrtcmp753	1984-11-14	via Gramsci 77, Ferrara	M	\N	5
\.


--
-- Data for Name: prescrizione; Type: TABLE DATA; Schema: ospedale; Owner: postgres
--

COPY ospedale.prescrizione (id_prescr, id_med, cf_paz, farmaco, dose_mg, n_dosi_gg, data_inizio, data_fine, prezzo) FROM stdin;
15894	88866	lssfrn981	cardioaspirina	60.00	1	2021-03-12	2021-03-14	520.00
10021	12345	cfPazient	pantoprazolo	50.10	2	2020-08-14	2020-08-19	5056.20
87945	59764	lsnsmp894	tachipirina	23.50	3	2021-04-17	2021-04-25	50.00
56214	59764	ntamnc465	collirio	12.00	1	2021-08-12	2021-08-15	15.00
75395	88866	rdrcrm671	cardioaspirina	5.50	3	2021-05-01	2021-05-17	21.00
85612	98765	smnbsu851	tachipirina	16.00	6	2021-07-01	2021-07-08	10.00
18642	98765	smnltr894	cardioaspirina	38.00	2	2020-12-17	2020-12-24	853.68
51643	12345	xlstsi451	limonata	45.50	9	2020-11-03	2020-11-25	954.80
14789	12345	mrtcmp753	morfina	10.00	8	2021-05-06	2021-05-14	85.50
\.


--
-- Data for Name: reparto; Type: TABLE DATA; Schema: ospedale; Owner: postgres
--

COPY ospedale.reparto (nome_r, numero_r, id_primario, num_camere) FROM stdin;
Ortopedia	1	88866	112
Cardiologia	4	98765	100
Oncologia	5	33344	54
Ostetricia	2	59764	45
Psichiatria	3	12345	25
\.


--
-- Name: impiegato impiegato_pkey; Type: CONSTRAINT; Schema: ospedale; Owner: postgres
--

ALTER TABLE ONLY ospedale.impiegato
    ADD CONSTRAINT impiegato_pkey PRIMARY KEY (id_imp);


--
-- Name: infermiere infermiere_pkey; Type: CONSTRAINT; Schema: ospedale; Owner: postgres
--

ALTER TABLE ONLY ospedale.infermiere
    ADD CONSTRAINT infermiere_pkey PRIMARY KEY (id_inf);


--
-- Name: medico medico_pkey; Type: CONSTRAINT; Schema: ospedale; Owner: postgres
--

ALTER TABLE ONLY ospedale.medico
    ADD CONSTRAINT medico_pkey PRIMARY KEY (id_medico);


--
-- Name: paziente paziente_pkey; Type: CONSTRAINT; Schema: ospedale; Owner: postgres
--

ALTER TABLE ONLY ospedale.paziente
    ADD CONSTRAINT paziente_pkey PRIMARY KEY (cf);


--
-- Name: prescrizione prescrizione_pkey; Type: CONSTRAINT; Schema: ospedale; Owner: postgres
--

ALTER TABLE ONLY ospedale.prescrizione
    ADD CONSTRAINT prescrizione_pkey PRIMARY KEY (id_prescr);


--
-- Name: reparto reparto_pkey; Type: CONSTRAINT; Schema: ospedale; Owner: postgres
--

ALTER TABLE ONLY ospedale.reparto
    ADD CONSTRAINT reparto_pkey PRIMARY KEY (numero_r);


--
-- Name: impiegato impiegato_ibfk_1; Type: FK CONSTRAINT; Schema: ospedale; Owner: postgres
--

ALTER TABLE ONLY ospedale.impiegato
    ADD CONSTRAINT impiegato_ibfk_1 FOREIGN KEY (n_rep) REFERENCES ospedale.reparto(numero_r) ON UPDATE CASCADE;


--
-- Name: infermiere infermiere_ibfk_1; Type: FK CONSTRAINT; Schema: ospedale; Owner: postgres
--

ALTER TABLE ONLY ospedale.infermiere
    ADD CONSTRAINT infermiere_ibfk_1 FOREIGN KEY (id_inf) REFERENCES ospedale.impiegato(id_imp) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: medico medico_ibfk_1; Type: FK CONSTRAINT; Schema: ospedale; Owner: postgres
--

ALTER TABLE ONLY ospedale.medico
    ADD CONSTRAINT medico_ibfk_1 FOREIGN KEY (id_medico) REFERENCES ospedale.impiegato(id_imp) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: paziente paziente_ibfk_1; Type: FK CONSTRAINT; Schema: ospedale; Owner: postgres
--

ALTER TABLE ONLY ospedale.paziente
    ADD CONSTRAINT paziente_ibfk_1 FOREIGN KEY (num_rep) REFERENCES ospedale.reparto(numero_r) ON UPDATE CASCADE;


--
-- Name: prescrizione prescrizione_ibfk_1; Type: FK CONSTRAINT; Schema: ospedale; Owner: postgres
--

ALTER TABLE ONLY ospedale.prescrizione
    ADD CONSTRAINT prescrizione_ibfk_1 FOREIGN KEY (id_med) REFERENCES ospedale.medico(id_medico);


--
-- Name: prescrizione prescrizione_ibfk_2; Type: FK CONSTRAINT; Schema: ospedale; Owner: postgres
--

ALTER TABLE ONLY ospedale.prescrizione
    ADD CONSTRAINT prescrizione_ibfk_2 FOREIGN KEY (cf_paz) REFERENCES ospedale.paziente(cf);


--
-- Name: reparto reparto_ibfk_1; Type: FK CONSTRAINT; Schema: ospedale; Owner: postgres
--

ALTER TABLE ONLY ospedale.reparto
    ADD CONSTRAINT reparto_ibfk_1 FOREIGN KEY (id_primario) REFERENCES ospedale.medico(id_medico) ON UPDATE CASCADE;


--
-- PostgreSQL database dump complete
--
