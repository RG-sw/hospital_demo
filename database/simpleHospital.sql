CREATE TABLE patient (
    name character varying(15) NOT NULL,
    surname character varying(15) NOT NULL,
    ssn character(9) NOT NULL,
    birth_date date,
    address character varying(30) DEFAULT NULL::character varying,
    sex character(1) DEFAULT NULL::bpchar,
    blood_type character varying(2) DEFAULT NULL::bpchar,
    building smallint NOT NULL
);

COPY patient (name, surname, ssn, birth_date, address, sex, blood_type, building) FROM stdin;
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
