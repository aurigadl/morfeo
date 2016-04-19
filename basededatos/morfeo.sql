--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.1
-- Dumped by pg_dump version 9.5.2

-- Started on 2016-04-18 20:08:19 COT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE morfeo;
--
-- TOC entry 3040 (class 1262 OID 19072)
-- Name: morfeo; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE morfeo WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'es_CO.UTF-8' LC_CTYPE = 'es_CO.UTF-8';


ALTER DATABASE morfeo OWNER TO postgres;

\connect morfeo

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 17463)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3041 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 180 (class 1259 OID 17470)
-- Name: anexos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE anexos (
    id integer NOT NULL,
    anex_radi_nume numeric(15,0) NOT NULL,
    anex_codigo character varying(20) NOT NULL,
    anex_tipo numeric(4,0) NOT NULL,
    anex_tamano numeric,
    anex_solo_lect character varying(1) NOT NULL,
    anex_creador character varying(35) NOT NULL,
    anex_desc character varying(512),
    anex_numero numeric(5,0) NOT NULL,
    anex_nomb_archivo character varying(50) NOT NULL,
    anex_borrado character varying(1) NOT NULL,
    anex_origen numeric(1,0) DEFAULT 0,
    anex_ubic character varying(15),
    anex_salida numeric(1,0) DEFAULT 0,
    radi_nume_salida numeric(15,0),
    anex_radi_fech timestamp without time zone,
    anex_estado numeric(1,0) DEFAULT 0,
    usua_doc character varying(14),
    sgd_rem_destino numeric(1,0) DEFAULT 0,
    anex_fech_envio timestamp without time zone,
    sgd_dir_tipo numeric(4,0),
    anex_fech_impres date,
    anex_depe_creador numeric(7,0),
    sgd_doc_secuencia numeric(15,0),
    sgd_doc_padre character varying(20),
    sgd_arg_codigo numeric(2,0),
    sgd_tpr_codigo numeric(4,0) DEFAULT 0 NOT NULL,
    sgd_deve_codigo numeric(2,0),
    sgd_deve_fech timestamp without time zone,
    sgd_fech_impres timestamp without time zone,
    anex_fech_anex timestamp without time zone,
    anex_depe_codi character varying(7),
    sgd_pnufe_codi numeric(4,0),
    sgd_dnufe_codi numeric(4,0),
    anex_usudoc_creador character varying(15),
    sgd_fech_doc timestamp without time zone,
    sgd_apli_codi numeric(4,0),
    sgd_trad_codigo numeric(2,0),
    sgd_dir_direccion character varying(150),
    muni_codi numeric(4,0),
    dpto_codi numeric(2,0),
    sgd_exp_numero character varying(18),
    anex_tipo_envio numeric(2,0),
    anex_sha1 character varying(100)
);


ALTER TABLE anexos OWNER TO postgres;

--
-- TOC entry 3043 (class 0 OID 0)
-- Dependencies: 180
-- Name: COLUMN anexos.anex_sha1; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN anexos.anex_sha1 IS 'Cadena de verificacion de anexos';


--
-- TOC entry 181 (class 1259 OID 17485)
-- Name: anexos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE anexos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE anexos_id_seq OWNER TO postgres;

--
-- TOC entry 3045 (class 0 OID 0)
-- Dependencies: 181
-- Name: anexos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE anexos_id_seq OWNED BY anexos.id;


--
-- TOC entry 182 (class 1259 OID 17487)
-- Name: anexos_tipo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE anexos_tipo (
    anex_tipo_codi numeric(4,0) NOT NULL,
    anex_tipo_ext character varying(10) NOT NULL,
    anex_tipo_desc character varying(50)
);


ALTER TABLE anexos_tipo OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 17490)
-- Name: autg_grupos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE autg_grupos (
    id integer NOT NULL,
    nombre character varying,
    descripcion character varying
);


ALTER TABLE autg_grupos OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 17496)
-- Name: autm_membresias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE autm_membresias (
    id integer NOT NULL,
    autg_id integer,
    autu_id integer
);


ALTER TABLE autm_membresias OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 17499)
-- Name: autp_permisos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE autp_permisos (
    id integer NOT NULL,
    nombre character varying(250),
    descripcion character varying(500),
    crud integer
);


ALTER TABLE autp_permisos OWNER TO postgres;

--
-- TOC entry 3046 (class 0 OID 0)
-- Dependencies: 185
-- Name: COLUMN autp_permisos.descripcion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN autp_permisos.descripcion IS 'Descripción del permiso';


--
-- TOC entry 3047 (class 0 OID 0)
-- Dependencies: 185
-- Name: COLUMN autp_permisos.crud; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN autp_permisos.crud IS 'Realizar crud sobre el elemento.
Leer 1
Editar 2
Crear y Borrar 3';


--
-- TOC entry 186 (class 1259 OID 17505)
-- Name: autr_restric_grupo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE autr_restric_grupo (
    id integer NOT NULL,
    autg_id integer,
    autp_id integer
);


ALTER TABLE autr_restric_grupo OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 17514)
-- Name: bodega_empresas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE bodega_empresas (
    nombre_de_la_empresa character varying(160),
    nuir character varying(13),
    nit_de_la_empresa character varying(80),
    sigla_de_la_empresa character varying(80),
    direccion character varying(4000),
    codigo_del_departamento character varying(4000),
    codigo_del_municipio character varying(4000),
    telefono_1 character varying(4000),
    telefono_2 character varying(4000),
    email character varying(4000),
    nombre_rep_legal character varying(4000),
    cargo_rep_legal character varying(4000),
    identificador_empresa numeric(5,0) NOT NULL,
    are_esp_secue numeric(8,0) NOT NULL,
    id_cont numeric(2,0) DEFAULT 1,
    id_pais numeric(4,0) DEFAULT 170,
    activa numeric(1,0) DEFAULT 1,
    flag_rups character(1)
);


ALTER TABLE bodega_empresas OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 17547)
-- Name: carpeta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE carpeta (
    carp_codi numeric(2,0) NOT NULL,
    carp_desc character varying(80) NOT NULL
);


ALTER TABLE carpeta OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 17550)
-- Name: carpeta_per; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE carpeta_per (
    usua_codi numeric(10,0) NOT NULL,
    depe_codi numeric(10,0) NOT NULL,
    nomb_carp character varying(10),
    desc_carp character varying(30),
    codi_carp numeric(3,0)
);


ALTER TABLE carpeta_per OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 17701)
-- Name: departamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE departamento (
    dpto_codi numeric(2,0) NOT NULL,
    dpto_nomb character varying(70) NOT NULL,
    id_cont numeric(2,0) DEFAULT 1,
    id_pais numeric(4,0) DEFAULT 170
);


ALTER TABLE departamento OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 17709)
-- Name: dependencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE dependencia (
    id integer NOT NULL,
    depe_codi numeric(7,0) NOT NULL,
    depe_nomb character varying(70) NOT NULL,
    dpto_codi numeric(2,0),
    depe_codi_padre numeric(7,0),
    muni_codi numeric(4,0),
    depe_codi_territorial numeric(7,0),
    dep_sigla character varying(30),
    dep_central numeric(1,0),
    dep_direccion character varying(100),
    depe_num_interna numeric(4,0),
    depe_num_resolucion numeric(4,0),
    depe_rad_tp1 numeric(3,0),
    acto_admon character varying(100),
    id_cont numeric(2,0) DEFAULT 1,
    id_pais numeric(4,0) DEFAULT 170,
    depe_estado numeric(1,0) DEFAULT 1
);


ALTER TABLE dependencia OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 17715)
-- Name: dependencia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE dependencia_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dependencia_id_seq OWNER TO postgres;

--
-- TOC entry 3048 (class 0 OID 0)
-- Dependencies: 192
-- Name: dependencia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE dependencia_id_seq OWNED BY dependencia.id;


--
-- TOC entry 193 (class 1259 OID 17717)
-- Name: dependencia_visibilidad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE dependencia_visibilidad (
    codigo_visibilidad numeric(18,0) NOT NULL,
    dependencia_visible numeric(5,0) NOT NULL,
    dependencia_observa numeric(5,0) NOT NULL
);


ALTER TABLE dependencia_visibilidad OWNER TO postgres;

--
-- TOC entry 194 (class 1259 OID 17720)
-- Name: estado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE estado (
    esta_codi numeric(2,0) NOT NULL,
    esta_desc character varying(100) NOT NULL
);


ALTER TABLE estado OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 17744)
-- Name: hist_eventos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE hist_eventos (
    id bigint NOT NULL,
    depe_codi numeric(7,0) NOT NULL,
    hist_fech timestamp without time zone NOT NULL,
    usua_codi numeric(10,0) NOT NULL,
    radi_nume_radi numeric(15,0) NOT NULL,
    hist_obse character varying(600) NOT NULL,
    usua_codi_dest numeric(10,0),
    usua_doc character varying(14),
    sgd_ttr_codigo numeric(3,0),
    hist_usua_autor character varying(14),
    hist_doc_dest character varying(14),
    depe_codi_dest numeric(7,0)
);


ALTER TABLE hist_eventos OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 17750)
-- Name: hist_eventos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hist_eventos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hist_eventos_id_seq OWNER TO postgres;

--
-- TOC entry 3049 (class 0 OID 0)
-- Dependencies: 196
-- Name: hist_eventos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hist_eventos_id_seq OWNED BY hist_eventos.id;


--
-- TOC entry 197 (class 1259 OID 17752)
-- Name: informados; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE informados (
    radi_nume_radi numeric(15,0) NOT NULL,
    usua_codi numeric(10,0) NOT NULL,
    depe_codi numeric(7,0) NOT NULL,
    info_desc character varying(600),
    info_fech timestamp without time zone NOT NULL,
    info_leido numeric(1,0) DEFAULT 0,
    info_codi numeric(20,0),
    usua_doc character varying(14),
    info_conjunto integer DEFAULT 0,
    usua_doc_origen character varying(20)
);


ALTER TABLE informados OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 17760)
-- Name: medio_recepcion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE medio_recepcion (
    mrec_codi numeric(2,0) NOT NULL,
    mrec_desc character varying(100) NOT NULL
);


ALTER TABLE medio_recepcion OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 17763)
-- Name: municipio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE municipio (
    muni_codi numeric(4,0) NOT NULL,
    dpto_codi numeric(2,0) NOT NULL,
    muni_nomb character varying(100) NOT NULL,
    id_cont numeric(2,0) DEFAULT 1,
    id_pais numeric(4,0) DEFAULT 170,
    homologa_muni character varying(10),
    homologa_idmuni numeric(4,0),
    activa numeric(1,0) DEFAULT 1
);


ALTER TABLE municipio OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 17789)
-- Name: par_serv_servicios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE par_serv_servicios (
    par_serv_secue numeric(8,0) NOT NULL,
    par_serv_codigo character varying(5),
    par_serv_nombre character varying(100),
    par_serv_estado character varying(1)
);


ALTER TABLE par_serv_servicios OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 17792)
-- Name: prestamo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE prestamo (
    pres_id numeric(10,0) NOT NULL,
    radi_nume_radi numeric(15,0) NOT NULL,
    usua_login_actu character varying(20) NOT NULL,
    depe_codi numeric(10,0) NOT NULL,
    usua_login_pres character varying(20),
    pres_desc character varying(200),
    pres_fech_pres timestamp without time zone,
    pres_fech_devo timestamp without time zone,
    pres_fech_pedi timestamp without time zone NOT NULL,
    pres_estado numeric(2,0),
    pres_requerimiento numeric(2,0),
    pres_depe_arch numeric(5,0),
    pres_fech_venc timestamp without time zone,
    dev_desc character varying(500),
    pres_fech_canc timestamp without time zone,
    usua_login_canc character varying(20),
    usua_login_rx character varying(20),
    sgd_exp_numero character varying(40)
);


ALTER TABLE prestamo OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 17798)
-- Name: radicado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE radicado (
    id bigint NOT NULL,
    radi_nume_radi numeric(15,0) NOT NULL,
    radi_fech_radi timestamp without time zone NOT NULL,
    tdoc_codi numeric(4,0) DEFAULT 0 NOT NULL,
    trte_codi numeric(2,0) DEFAULT 0,
    mrec_codi numeric(2,0),
    eesp_codi numeric(10,0),
    radi_fech_ofic timestamp without time zone,
    tdid_codi numeric(2,0) DEFAULT 0,
    radi_pais character varying(70),
    muni_codi numeric(5,0),
    cpob_codi numeric(4,0),
    carp_codi numeric(3,0),
    esta_codi numeric(2,0),
    dpto_codi numeric(2,0),
    radi_nume_hoja numeric(4,0),
    radi_desc_anex character varying(600),
    radi_nume_deri numeric(15,0),
    radi_path character varying(300),
    radi_usua_actu numeric(10,0),
    radi_depe_actu numeric(5,0),
    ra_asun character varying(500),
    radi_usu_ante character varying(45),
    radi_depe_radi numeric(3,0),
    radi_usua_radi numeric(10,0),
    codi_nivel numeric(2,0) DEFAULT 1,
    flag_nivel numeric,
    carp_per numeric(1,0) DEFAULT 0,
    radi_leido numeric(1,0) DEFAULT 0,
    radi_cuentai character varying(100),
    radi_tipo_deri numeric(2,0) DEFAULT 0,
    listo character varying(2),
    sgd_tma_codigo numeric(4,0),
    sgd_mtd_codigo numeric(4,0),
    par_serv_secue numeric(8,0),
    sgd_fld_codigo numeric(3,0) DEFAULT 0,
    radi_agend numeric(1,0),
    radi_fech_agend timestamp without time zone,
    sgd_doc_secuencia numeric(15,0),
    sgd_pnufe_codi numeric(4,0),
    sgd_eanu_codigo numeric(1,0),
    sgd_not_codi numeric(3,0),
    radi_fech_notif timestamp without time zone,
    sgd_tdec_codigo numeric(4,0),
    sgd_apli_codi numeric(4,0),
    sgd_ttr_codigo numeric,
    sgd_trad_codigo numeric(2,0),
    fech_vcmto timestamp without time zone,
    sgd_termino_real numeric(4,0),
    id_cont numeric(2,0) DEFAULT 1,
    sgd_spub_codigo numeric(2,0) DEFAULT 0,
    id_pais numeric(3,0),
    radi_nrr numeric(2,0) DEFAULT 0,
    depe_codi numeric(7,0),
    radi_nume_folio numeric(5,0),
    radi_nume_anexo character varying(14),
    radi_nume_guia character varying(60),
    radi_nume_iden character varying(15),
    sgd_rad_codigoverificacion character varying(35),
    origen character varying,
    referenciados character varying,
    numero_radicado character varying(50),
    esta_fisico numeric(2,0) DEFAULT 0
);


ALTER TABLE radicado OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 17816)
-- Name: radicado_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE radicado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE radicado_id_seq OWNER TO postgres;

--
-- TOC entry 3050 (class 0 OID 0)
-- Dependencies: 203
-- Name: radicado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE radicado_id_seq OWNED BY radicado.id;


--
-- TOC entry 204 (class 1259 OID 17876)
-- Name: series; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE series (
    depe_codi numeric(7,0) NOT NULL,
    seri_nume numeric(7,0) NOT NULL,
    seri_tipo numeric(2,0) NOT NULL,
    seri_ano numeric(4,0) NOT NULL,
    dpto_codi numeric(2,0) NOT NULL,
    bloq character varying(20)
);


ALTER TABLE series OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 17882)
-- Name: sgd_agen_agendados; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_agen_agendados (
    id integer NOT NULL,
    sgd_agen_fech date,
    sgd_agen_observacion character varying(1500),
    radi_nume_radi numeric(15,0) NOT NULL,
    usua_doc character varying(18) NOT NULL,
    depe_codi character varying(20),
    sgd_agen_fechplazo date,
    sgd_agen_activo numeric
);


ALTER TABLE sgd_agen_agendados OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 17888)
-- Name: sgd_agen_agendados_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sgd_agen_agendados_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sgd_agen_agendados_id_seq OWNER TO postgres;

--
-- TOC entry 3051 (class 0 OID 0)
-- Dependencies: 206
-- Name: sgd_agen_agendados_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sgd_agen_agendados_id_seq OWNED BY sgd_agen_agendados.id;


--
-- TOC entry 207 (class 1259 OID 17890)
-- Name: sgd_anar_anexarg; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_anar_anexarg (
    sgd_anar_codi numeric(4,0) NOT NULL,
    anex_codigo character varying(20),
    sgd_argd_codi numeric(4,0),
    sgd_anar_argcod numeric(4,0)
);


ALTER TABLE sgd_anar_anexarg OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 17893)
-- Name: sgd_anu_anulados; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_anu_anulados (
    sgd_anu_id numeric(4,0) NOT NULL,
    sgd_anu_desc character varying(250),
    radi_nume_radi numeric,
    sgd_eanu_codi numeric(4,0),
    sgd_anu_sol_fech timestamp without time zone,
    depe_codi numeric(7,0),
    usua_doc character varying(14),
    usua_codi numeric(4,0),
    depe_codi_anu numeric(7,0),
    usua_doc_anu character varying(14),
    usua_codi_anu numeric(4,0),
    usua_anu_acta numeric(8,0),
    sgd_anu_path_acta character varying(200),
    sgd_trad_codigo numeric(2,0)
);


ALTER TABLE sgd_anu_anulados OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 17922)
-- Name: sgd_argd_argdoc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_argd_argdoc (
    sgd_argd_codi numeric(4,0) NOT NULL,
    sgd_pnufe_codi numeric(4,0),
    sgd_argd_tabla character varying(100),
    sgd_argd_tcodi character varying(100),
    sgd_argd_tdes character varying(100),
    sgd_argd_llist character varying(150),
    sgd_argd_campo character varying(100)
);


ALTER TABLE sgd_argd_argdoc OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 17931)
-- Name: sgd_auditoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_auditoria (
    usua_doc character varying(50),
    tipo character varying(20),
    tabla character varying(50),
    isql text,
    fecha numeric(20,0),
    ip character varying(40)
);


ALTER TABLE sgd_auditoria OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 17937)
-- Name: sgd_camexp_campoexpediente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_camexp_campoexpediente (
    sgd_camexp_codigo numeric(4,0) NOT NULL,
    sgd_camexp_campo character varying(30) NOT NULL,
    sgd_parexp_codigo numeric(4,0) NOT NULL,
    sgd_camexp_fk numeric DEFAULT 0,
    sgd_camexp_tablafk character varying(30),
    sgd_camexp_campofk character varying(30),
    sgd_camexp_campovalor character varying(30),
    sgd_campexp_orden numeric(1,0)
);


ALTER TABLE sgd_camexp_campoexpediente OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 17944)
-- Name: sgd_carp_descripcion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_carp_descripcion (
    sgd_carp_depecodi numeric(7,0) NOT NULL,
    sgd_carp_tiporad numeric(2,0) NOT NULL,
    sgd_carp_descr character varying(40)
);


ALTER TABLE sgd_carp_descripcion OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 17947)
-- Name: sgd_cau_causal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_cau_causal (
    sgd_cau_codigo numeric(4,0) NOT NULL,
    sgd_cau_descrip character varying(150)
);


ALTER TABLE sgd_cau_causal OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 17950)
-- Name: sgd_caux_causales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_caux_causales (
    sgd_caux_codigo numeric(10,0) NOT NULL,
    radi_nume_radi numeric(15,0),
    sgd_dcau_codigo numeric(4,0),
    sgd_ddca_codigo numeric(4,0),
    sgd_caux_fecha timestamp without time zone,
    usua_doc character varying(14),
    sgd_cau_codigo numeric(4,0) DEFAULT 0
);


ALTER TABLE sgd_caux_causales OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 17954)
-- Name: sgd_ciu_ciudadano; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_ciu_ciudadano (
    tdid_codi numeric(2,0),
    sgd_ciu_codigo numeric(10,0) NOT NULL,
    sgd_ciu_nombre character varying(150),
    sgd_ciu_direccion character varying(150),
    sgd_ciu_apell1 character varying(50),
    sgd_ciu_apell2 character varying(50),
    sgd_ciu_telefono character varying(50),
    sgd_ciu_email character varying(50),
    muni_codi numeric(4,0),
    dpto_codi numeric(4,0),
    sgd_ciu_cedula character varying(13),
    id_cont numeric(2,0) DEFAULT 1,
    id_pais numeric(4,0) DEFAULT 170,
    t_muni_codi numeric(4,0),
    t_dpto_codi numeric(4,0),
    t_pais_codi numeric(4,0),
    pais_acapella numeric
);


ALTER TABLE sgd_ciu_ciudadano OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 17962)
-- Name: sgd_clta_clstarif; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_clta_clstarif (
    sgd_fenv_codigo numeric(5,0),
    sgd_clta_codser numeric(5,0),
    sgd_tar_codigo numeric(5,0),
    sgd_clta_descrip character varying(100),
    sgd_clta_pesdes numeric(15,0),
    sgd_clta_peshast numeric(15,0)
);


ALTER TABLE sgd_clta_clstarif OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17965)
-- Name: sgd_cob_campobliga; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_cob_campobliga (
    sgd_cob_codi numeric(4,0) NOT NULL,
    sgd_cob_desc character varying(150),
    sgd_cob_label character varying(50),
    sgd_tidm_codi numeric(4,0)
);


ALTER TABLE sgd_cob_campobliga OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 17974)
-- Name: sgd_dcau_causal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_dcau_causal (
    sgd_dcau_codigo numeric(4,0) NOT NULL,
    sgd_cau_codigo numeric(4,0),
    sgd_dcau_descrip character varying(150)
);


ALTER TABLE sgd_dcau_causal OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17977)
-- Name: sgd_ddca_ddsgrgdo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_ddca_ddsgrgdo (
    sgd_ddca_codigo numeric(4,0) NOT NULL,
    sgd_dcau_codigo numeric(4,0),
    par_serv_secue numeric(8,0),
    sgd_ddca_descrip character varying(150)
);


ALTER TABLE sgd_ddca_ddsgrgdo OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17980)
-- Name: sgd_def_contactos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_def_contactos (
    ctt_id numeric(15,0) NOT NULL,
    ctt_nombre character varying(60) NOT NULL,
    ctt_cargo character varying(60) NOT NULL,
    ctt_telefono character varying(25),
    ctt_id_tipo numeric(4,0) NOT NULL,
    ctt_id_empresa numeric(15,0) NOT NULL
);


ALTER TABLE sgd_def_contactos OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17983)
-- Name: sgd_def_continentes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_def_continentes (
    id_cont numeric(2,0) NOT NULL,
    nombre_cont character varying(20) NOT NULL
);


ALTER TABLE sgd_def_continentes OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17986)
-- Name: sgd_def_paises; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_def_paises (
    id_pais numeric(4,0) NOT NULL,
    id_cont numeric(2,0) DEFAULT 1 NOT NULL,
    nombre_pais character varying(30) NOT NULL
);


ALTER TABLE sgd_def_paises OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17990)
-- Name: sgd_deve_dev_envio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_deve_dev_envio (
    sgd_deve_codigo numeric(2,0) NOT NULL,
    sgd_deve_desc character varying(150) NOT NULL
);


ALTER TABLE sgd_deve_dev_envio OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17995)
-- Name: sgd_dir_drecciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_dir_drecciones (
    id bigint NOT NULL,
    sgd_dir_codigo numeric(10,0) NOT NULL,
    sgd_dir_tipo numeric(4,0) NOT NULL,
    sgd_oem_codigo numeric(15,0),
    sgd_ciu_codigo numeric(15,0),
    radi_nume_radi numeric(15,0),
    sgd_esp_codi numeric(5,0),
    muni_codi numeric(4,0),
    dpto_codi numeric(2,0),
    sgd_dir_direccion character varying(150),
    sgd_dir_telefono character varying(50),
    sgd_dir_mail character varying(50),
    sgd_sec_codigo numeric(13,0),
    sgd_temporal_nombre character varying(150),
    anex_codigo numeric(20,0),
    sgd_anex_codigo character varying(20),
    sgd_dir_nombre character varying(150),
    sgd_doc_fun character varying(14),
    sgd_dir_nomremdes character varying(1000),
    sgd_trd_codigo numeric(1,0),
    sgd_dir_tdoc numeric(1,0),
    sgd_dir_doc character varying(14),
    id_pais numeric(4,0) DEFAULT 170,
    id_cont numeric(2,0) DEFAULT 1,
    departamento_id integer,
    ciudad_id integer,
    sgd_dir_apellido character varying(50)
);


ALTER TABLE sgd_dir_drecciones OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 18003)
-- Name: sgd_dir_drecciones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sgd_dir_drecciones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sgd_dir_drecciones_id_seq OWNER TO postgres;

--
-- TOC entry 3052 (class 0 OID 0)
-- Dependencies: 225
-- Name: sgd_dir_drecciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sgd_dir_drecciones_id_seq OWNED BY sgd_dir_drecciones.id;


--
-- TOC entry 226 (class 1259 OID 18005)
-- Name: sgd_dnufe_docnufe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_dnufe_docnufe (
    sgd_dnufe_codi numeric(4,0) NOT NULL,
    sgd_pnufe_codi numeric(4,0),
    sgd_tpr_codigo numeric(4,0),
    sgd_dnufe_label character varying(150),
    trte_codi numeric(2,0),
    sgd_dnufe_main character varying(1),
    sgd_dnufe_path character varying(150),
    sgd_dnufe_gerarq character varying(10),
    anex_tipo_codi numeric(4,0)
);


ALTER TABLE sgd_dnufe_docnufe OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 18014)
-- Name: sgd_einv_inventario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_einv_inventario (
    sgd_einv_codigo numeric NOT NULL,
    sgd_depe_nomb character varying(150),
    sgd_depe_codi numeric(7,0),
    sgd_einv_expnum character varying(18),
    sgd_einv_titulo character varying(400),
    sgd_einv_unidad numeric,
    sgd_einv_fech date,
    sgd_einv_fechfin date,
    sgd_einv_radicados character varying(40),
    sgd_einv_folios numeric,
    sgd_einv_nundocu numeric,
    sgd_einv_nundocubodega numeric,
    sgd_einv_caja numeric,
    sgd_einv_cajabodega numeric,
    sgd_einv_srd numeric,
    sgd_einv_nomsrd character varying(400),
    sgd_einv_sbrd numeric,
    sgd_einv_nomsbrd character varying(400),
    sgd_einv_retencion character varying(400),
    sgd_einv_disfinal character varying(400),
    sgd_einv_ubicacion character varying(400),
    sgd_einv_observacion character varying(400)
);


ALTER TABLE sgd_einv_inventario OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 18020)
-- Name: sgd_eit_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_eit_items (
    sgd_eit_codigo numeric NOT NULL,
    sgd_eit_cod_padre character varying(4) DEFAULT '0'::character varying,
    sgd_eit_nombre character varying(40),
    sgd_eit_sigla character varying(20),
    codi_dpto numeric(4,0),
    codi_muni numeric(5,0)
);


ALTER TABLE sgd_eit_items OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 18027)
-- Name: sgd_empus_empusuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_empus_empusuario (
    sgd_empus_codigo numeric(5,0) NOT NULL,
    sgd_empus_estado character(1),
    usua_login character varying(40) NOT NULL,
    identificador_empresa numeric(5,0) NOT NULL
);


ALTER TABLE sgd_empus_empusuario OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 18033)
-- Name: sgd_enve_envioespecial; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_enve_envioespecial (
    sgd_fenv_codigo numeric(4,0),
    sgd_enve_valorl character varying(30),
    sgd_enve_valorn character varying(30),
    sgd_enve_desc character varying(30)
);


ALTER TABLE sgd_enve_envioespecial OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 18045)
-- Name: sgd_exp_expediente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_exp_expediente (
    id bigint NOT NULL,
    sgd_exp_numero character varying(18) NOT NULL,
    radi_nume_radi numeric(18,0) NOT NULL,
    sgd_exp_fech timestamp without time zone,
    sgd_exp_fech_mod timestamp without time zone,
    depe_codi numeric(7,0),
    usua_codi numeric(10,0),
    usua_doc character varying(15),
    sgd_exp_estado numeric(1,0) DEFAULT 0,
    sgd_exp_titulo character varying(50),
    sgd_exp_asunto character varying(150),
    sgd_exp_carpeta character varying(30),
    sgd_exp_ufisica character varying(20),
    sgd_exp_isla character varying(10),
    sgd_exp_estante character varying(10),
    sgd_exp_caja character varying(10),
    sgd_exp_fech_arch date,
    sgd_srd_codigo numeric(3,0),
    sgd_sbrd_codigo numeric(3,0),
    sgd_fexp_codigo numeric(3,0) DEFAULT 0,
    sgd_exp_subexpediente numeric,
    sgd_exp_archivo numeric(1,0),
    sgd_exp_unicon numeric(1,0),
    sgd_exp_fechfin timestamp without time zone,
    sgd_exp_folios character varying(4),
    sgd_exp_rete numeric(2,0),
    sgd_exp_entrepa numeric(2,0),
    radi_usua_arch character varying(40),
    sgd_exp_edificio character varying(400),
    sgd_exp_caja_bodega character varying(40),
    sgd_exp_carro character varying(40),
    sgd_exp_carpeta_bodega character varying(40),
    sgd_exp_privado numeric(1,0),
    sgd_exp_cd character varying(10),
    sgd_exp_nref character varying(7),
    sgd_exp_fechafin timestamp without time zone,
    sgd_prd_codigo numeric(4,0)
);


ALTER TABLE sgd_exp_expediente OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 18053)
-- Name: sgd_exp_expediente_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sgd_exp_expediente_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sgd_exp_expediente_id_seq OWNER TO postgres;

--
-- TOC entry 3053 (class 0 OID 0)
-- Dependencies: 232
-- Name: sgd_exp_expediente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sgd_exp_expediente_id_seq OWNED BY sgd_exp_expediente.id;


--
-- TOC entry 233 (class 1259 OID 18055)
-- Name: sgd_fenv_frmenvio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_fenv_frmenvio (
    sgd_fenv_codigo numeric(5,0) NOT NULL,
    sgd_fenv_descrip character varying(40),
    sgd_fenv_estado numeric(1,0) DEFAULT 1 NOT NULL,
    sgd_fenv_planilla numeric(1,0) DEFAULT 0 NOT NULL
);


ALTER TABLE sgd_fenv_frmenvio OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 18060)
-- Name: sgd_fexp_flujoexpedientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_fexp_flujoexpedientes (
    sgd_fexp_codigo numeric(6,0) NOT NULL,
    sgd_pexp_codigo numeric(6,0),
    sgd_fexp_orden numeric(4,0),
    sgd_fexp_terminos numeric(4,0),
    sgd_fexp_imagen character varying(50),
    sgd_fexp_descrip character varying(255),
    sgd_fld_posleft character varying(10),
    sgd_fld_postop character varying(10)
);


ALTER TABLE sgd_fexp_flujoexpedientes OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 18063)
-- Name: sgd_firrad_firmarads; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_firrad_firmarads (
    sgd_firrad_id numeric(15,0) NOT NULL,
    radi_nume_radi numeric(15,0) NOT NULL,
    usua_doc character varying(14) NOT NULL,
    sgd_firrad_firma character varying(1),
    sgd_firrad_fecha timestamp without time zone,
    sgd_firrad_docsolic character varying(14) NOT NULL,
    sgd_firrad_fechsolic timestamp without time zone NOT NULL,
    sgd_firrad_pk character varying(1000)
);


ALTER TABLE sgd_firrad_firmarads OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 18069)
-- Name: sgd_fld_flujodoc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_fld_flujodoc (
    sgd_fld_codigo numeric(3,0),
    sgd_fld_desc character varying(100),
    sgd_tpr_codigo numeric(3,0),
    sgd_fld_imagen character varying(50),
    sgd_fld_grupoweb numeric
);


ALTER TABLE sgd_fld_flujodoc OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 18075)
-- Name: sgd_fun_funciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_fun_funciones (
    sgd_fun_codigo numeric(4,0) NOT NULL,
    sgd_fun_descrip character varying(530),
    sgd_fun_fech_ini timestamp without time zone,
    sgd_fun_fech_fin timestamp without time zone
);


ALTER TABLE sgd_fun_funciones OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 18081)
-- Name: sgd_hfld_histflujodoc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_hfld_histflujodoc (
    id integer NOT NULL,
    sgd_hfld_codigo numeric(6,0),
    sgd_fexp_codigo numeric(3,0),
    sgd_exp_fechflujoant timestamp without time zone,
    sgd_hfld_fech timestamp without time zone,
    sgd_exp_numero character varying(18),
    radi_nume_radi numeric(15,0),
    usua_doc character varying(20),
    usua_codi numeric(10,0),
    depe_codi numeric(10,0),
    sgd_ttr_codigo numeric(2,0),
    sgd_fexp_observa character varying(500),
    sgd_hfld_observa character varying(500),
    sgd_fars_codigo numeric(10,0),
    sgd_hfld_automatico numeric(10,0)
);


ALTER TABLE sgd_hfld_histflujodoc OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 18087)
-- Name: sgd_hfld_histflujodoc_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sgd_hfld_histflujodoc_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sgd_hfld_histflujodoc_id_seq OWNER TO postgres;

--
-- TOC entry 3054 (class 0 OID 0)
-- Dependencies: 239
-- Name: sgd_hfld_histflujodoc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sgd_hfld_histflujodoc_id_seq OWNED BY sgd_hfld_histflujodoc.id;


--
-- TOC entry 240 (class 1259 OID 18089)
-- Name: sgd_hmtd_hismatdoc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_hmtd_hismatdoc (
    sgd_hmtd_codigo numeric(6,0) NOT NULL,
    sgd_hmtd_fecha timestamp without time zone NOT NULL,
    radi_nume_radi numeric(15,0) NOT NULL,
    usua_codi numeric(10,0) NOT NULL,
    sgd_hmtd_obse character varying(600) NOT NULL,
    usua_doc numeric(13,0),
    depe_codi numeric(10,0),
    sgd_mtd_codigo numeric(4,0)
);


ALTER TABLE sgd_hmtd_hismatdoc OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 18104)
-- Name: sgd_masiva_excel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_masiva_excel (
    sgd_masiva_dependencia numeric(3,0),
    sgd_masiva_usuario numeric(10,0),
    sgd_masiva_tiporadicacion numeric(1,0),
    sgd_masiva_codigo numeric(15,1) NOT NULL,
    sgd_masiva_radicada numeric(1,0),
    sgd_masiva_intervalo numeric(3,0),
    sgd_masiva_rangoini character varying(15),
    sgd_masiva_rangofin character varying(15)
);


ALTER TABLE sgd_masiva_excel OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 18107)
-- Name: sgd_mat_matriz; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_mat_matriz (
    sgd_mat_codigo numeric(4,0) NOT NULL,
    depe_codi numeric(10,0),
    sgd_fun_codigo numeric(4,0),
    sgd_prc_codigo numeric(4,0),
    sgd_prd_codigo numeric(4,0)
);


ALTER TABLE sgd_mat_matriz OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 18113)
-- Name: sgd_mrd_matrird; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_mrd_matrird (
    sgd_mrd_codigo numeric(4,0) NOT NULL,
    depe_codi numeric(10,0) NOT NULL,
    depe_codi_aplica character varying(100),
    sgd_srd_codigo numeric(4,0) NOT NULL,
    sgd_sbrd_codigo numeric(4,0) NOT NULL,
    sgd_tpr_codigo numeric(4,0) NOT NULL,
    soporte character varying(10),
    sgd_mrd_fechini timestamp without time zone,
    sgd_mrd_esta character varying(10)
);


ALTER TABLE sgd_mrd_matrird OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 18118)
-- Name: sgd_msdep_msgdep; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_msdep_msgdep (
    depe_codi numeric(10,0) NOT NULL,
    sgd_msg_codi numeric(15,0) NOT NULL
);


ALTER TABLE sgd_msdep_msgdep OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 18121)
-- Name: sgd_msg_mensaje; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_msg_mensaje (
    sgd_msg_codi numeric(15,0) NOT NULL,
    sgd_tme_codi numeric(3,0),
    sgd_msg_desc character varying(150),
    sgd_msg_fechdesp timestamp without time zone NOT NULL,
    sgd_msg_url character varying(150),
    sgd_msg_veces numeric(3,0),
    sgd_msg_ancho numeric(6,0),
    sgd_msg_largo numeric(6,0),
    sgd_msg_etiqueta character varying(20)
);


ALTER TABLE sgd_msg_mensaje OWNER TO postgres;

--
-- TOC entry 3055 (class 0 OID 0)
-- Dependencies: 245
-- Name: COLUMN sgd_msg_mensaje.sgd_msg_etiqueta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_msg_mensaje.sgd_msg_etiqueta IS 'Nombre corto para mostrar del mensaje';


--
-- TOC entry 246 (class 1259 OID 18124)
-- Name: sgd_mtd_matriz_doc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_mtd_matriz_doc (
    sgd_mtd_codigo numeric(4,0) NOT NULL,
    sgd_mat_codigo numeric(4,0),
    sgd_tpr_codigo numeric(4,0)
);


ALTER TABLE sgd_mtd_matriz_doc OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 18133)
-- Name: sgd_noh_nohabiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_noh_nohabiles (
    noh_fecha timestamp without time zone NOT NULL
);


ALTER TABLE sgd_noh_nohabiles OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 18136)
-- Name: sgd_not_notificacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_not_notificacion (
    sgd_not_codi numeric(3,0) NOT NULL,
    sgd_not_descrip character varying(100) NOT NULL
);


ALTER TABLE sgd_not_notificacion OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 18139)
-- Name: sgd_novedad_usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_novedad_usuario (
    usua_doc character varying(20) NOT NULL,
    nov_infor character varying(255),
    nov_reasig character varying(255),
    nov_vobo character varying(255),
    nov_dev character varying(255),
    nov_entr character varying(255)
);


ALTER TABLE sgd_novedad_usuario OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 18145)
-- Name: sgd_ntrd_notifrad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_ntrd_notifrad (
    radi_nume_radi numeric(15,0) NOT NULL,
    sgd_not_codi numeric(3,0) NOT NULL,
    sgd_ntrd_notificador character varying(150),
    sgd_ntrd_notificado character varying(150),
    sgd_ntrd_fecha_not timestamp without time zone,
    sgd_ntrd_num_edicto numeric(6,0),
    sgd_ntrd_fecha_fija timestamp without time zone,
    sgd_ntrd_fecha_desfija timestamp without time zone,
    sgd_ntrd_observaciones character varying(150)
);


ALTER TABLE sgd_ntrd_notifrad OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 18148)
-- Name: sgd_oem_oempresas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_oem_oempresas (
    sgd_oem_codigo numeric(15,0) NOT NULL,
    tdid_codi numeric(2,0),
    sgd_oem_oempresa character varying(150),
    sgd_oem_rep_legal character varying(150),
    sgd_oem_nit character varying(14),
    sgd_oem_sigla character varying(50),
    muni_codi numeric(4,0),
    dpto_codi numeric(2,0),
    sgd_oem_direccion character varying(150),
    sgd_oem_telefono character varying(50),
    id_cont numeric(2,0) DEFAULT 1,
    id_pais numeric(4,0) DEFAULT 170
);


ALTER TABLE sgd_oem_oempresas OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 18159)
-- Name: sgd_param_admin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_param_admin (
    param_codigo character varying(20) NOT NULL,
    param_nombre character varying(255),
    param_desc character varying(255),
    param_valor character varying(255)
);


ALTER TABLE sgd_param_admin OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 18165)
-- Name: sgd_parametro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_parametro (
    param_nomb character varying(25) NOT NULL,
    param_codi numeric(5,0) NOT NULL,
    param_valor character varying(25) NOT NULL
);


ALTER TABLE sgd_parametro OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 18168)
-- Name: sgd_parexp_paramexpediente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_parexp_paramexpediente (
    sgd_parexp_codigo numeric(4,0) NOT NULL,
    depe_codi numeric(10,0) NOT NULL,
    sgd_parexp_tabla character varying(30) NOT NULL,
    sgd_parexp_etiqueta character varying(15) NOT NULL,
    sgd_parexp_orden numeric(2,0),
    sgd_parexp_editable smallint DEFAULT 0,
    id integer NOT NULL
);


ALTER TABLE sgd_parexp_paramexpediente OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 18172)
-- Name: sgd_parexp_paramexpediente_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sgd_parexp_paramexpediente_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sgd_parexp_paramexpediente_id_seq OWNER TO postgres;

--
-- TOC entry 3056 (class 0 OID 0)
-- Dependencies: 255
-- Name: sgd_parexp_paramexpediente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sgd_parexp_paramexpediente_id_seq OWNED BY sgd_parexp_paramexpediente.id;


--
-- TOC entry 256 (class 1259 OID 18174)
-- Name: sgd_pexp_procexpedientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_pexp_procexpedientes (
    sgd_pexp_codigo numeric NOT NULL,
    sgd_pexp_descrip character varying(100),
    sgd_pexp_terminos numeric DEFAULT 0,
    sgd_srd_codigo numeric(3,0),
    sgd_sbrd_codigo numeric(3,0),
    sgd_pexp_automatico numeric(1,0) DEFAULT 1,
    sgd_pexp_tieneflujo numeric
);


ALTER TABLE sgd_pexp_procexpedientes OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 18182)
-- Name: sgd_plan_plantillas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_plan_plantillas (
    id bigint NOT NULL,
    plan_nombre character varying(50),
    plan_fecha timestamp without time zone,
    depe_codi numeric(10,0),
    usua_codi numeric(10,0),
    plan_tipo numeric(4,0),
    plan_plantilla text
);


ALTER TABLE sgd_plan_plantillas OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 18188)
-- Name: sgd_plan_plantillas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sgd_plan_plantillas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sgd_plan_plantillas_id_seq OWNER TO postgres;

--
-- TOC entry 3057 (class 0 OID 0)
-- Dependencies: 258
-- Name: sgd_plan_plantillas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sgd_plan_plantillas_id_seq OWNED BY sgd_plan_plantillas.id;


--
-- TOC entry 259 (class 1259 OID 18190)
-- Name: sgd_pnufe_procnumfe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_pnufe_procnumfe (
    sgd_pnufe_codi numeric(4,0) NOT NULL,
    sgd_tpr_codigo numeric(4,0),
    sgd_pnufe_descrip character varying(150),
    sgd_pnufe_serie character varying(50)
);


ALTER TABLE sgd_pnufe_procnumfe OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 18193)
-- Name: sgd_pnun_procenum; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_pnun_procenum (
    sgd_pnufe_codi numeric(4,0),
    depe_codi numeric(10,0),
    sgd_pnun_prepone character varying(50)
);


ALTER TABLE sgd_pnun_procenum OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 18196)
-- Name: sgd_prc_proceso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_prc_proceso (
    sgd_prc_codigo numeric(4,0) NOT NULL,
    sgd_prc_descrip character varying(150)
);


ALTER TABLE sgd_prc_proceso OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 18199)
-- Name: sgd_prd_prcdmentos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_prd_prcdmentos (
    sgd_prd_codigo numeric(4,0) NOT NULL,
    sgd_prc_codigo numeric(4,0),
    sgd_prd_descrip character varying(200)
);


ALTER TABLE sgd_prd_prcdmentos OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 18202)
-- Name: sgd_rda_retdoca; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_rda_retdoca (
    anex_radi_nume numeric(15,0) NOT NULL,
    anex_codigo character varying(20) NOT NULL,
    radi_nume_salida numeric(15,0),
    anex_borrado character varying(1),
    sgd_mrd_codigo numeric(4,0) NOT NULL,
    depe_codi numeric(10,0) NOT NULL,
    usua_codi numeric(10,0) NOT NULL,
    usua_doc character varying(14) NOT NULL,
    sgd_rda_fech timestamp without time zone,
    sgd_deve_codigo numeric(2,0),
    anex_solo_lect character varying(1),
    anex_radi_fech timestamp without time zone,
    anex_estado numeric(1,0),
    anex_nomb_archivo character varying(50),
    anex_tipo numeric(4,0),
    sgd_dir_tipo numeric(4,0)
);


ALTER TABLE sgd_rda_retdoca OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 18205)
-- Name: sgd_rdf_retdocf; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_rdf_retdocf (
    id bigint NOT NULL,
    sgd_mrd_codigo numeric(4,0) NOT NULL,
    radi_nume_radi numeric(15,0) NOT NULL,
    depe_codi numeric(10,0) NOT NULL,
    usua_codi numeric(10,0) NOT NULL,
    usua_doc character varying(14) NOT NULL,
    sgd_rdf_fech timestamp without time zone NOT NULL
);


ALTER TABLE sgd_rdf_retdocf OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 18208)
-- Name: sgd_rdf_retdocf_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sgd_rdf_retdocf_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sgd_rdf_retdocf_id_seq OWNER TO postgres;

--
-- TOC entry 3058 (class 0 OID 0)
-- Dependencies: 265
-- Name: sgd_rdf_retdocf_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sgd_rdf_retdocf_id_seq OWNED BY sgd_rdf_retdocf.id;


--
-- TOC entry 266 (class 1259 OID 18210)
-- Name: sgd_renv_regenvio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_renv_regenvio (
    id bigint NOT NULL,
    sgd_renv_codigo numeric(6,0) NOT NULL,
    sgd_fenv_codigo numeric(5,0),
    sgd_renv_fech timestamp without time zone,
    radi_nume_sal numeric(14,0),
    sgd_renv_destino character varying(150),
    sgd_renv_telefono character varying(50),
    sgd_renv_mail character varying(150),
    sgd_renv_peso character varying(10),
    sgd_renv_valor character varying(10),
    sgd_renv_certificado numeric(1,0),
    sgd_renv_estado numeric(1,0),
    usua_doc numeric(15,0),
    sgd_renv_nombre character varying(100),
    sgd_rem_destino numeric(1,0) DEFAULT 0,
    sgd_dir_codigo numeric(10,0),
    sgd_renv_planilla character varying(8),
    sgd_renv_fech_sal timestamp without time zone,
    depe_codi numeric(10,0),
    sgd_dir_tipo numeric(4,0) DEFAULT 0,
    radi_nume_grupo numeric(22,0),
    sgd_renv_dir character varying(100),
    sgd_renv_depto character varying(30),
    sgd_renv_mpio character varying(30),
    sgd_renv_tel character varying(20),
    sgd_renv_cantidad numeric(4,0) DEFAULT 0,
    sgd_renv_tipo numeric(1,0) DEFAULT 0,
    sgd_renv_observa character varying(200),
    sgd_renv_grupo numeric(14,0),
    sgd_deve_codigo numeric(2,0),
    sgd_deve_fech timestamp without time zone,
    sgd_renv_valortotal character varying(14) DEFAULT '0'::character varying,
    sgd_renv_valistamiento character varying(10) DEFAULT '0'::character varying,
    sgd_renv_vdescuento character varying(10) DEFAULT '0'::character varying,
    sgd_renv_vadicional character varying(14) DEFAULT '0'::character varying,
    sgd_depe_genera numeric(5,0),
    sgd_renv_pais character varying(30) DEFAULT 'colombia'::character varying
);


ALTER TABLE sgd_renv_regenvio OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 18225)
-- Name: sgd_renv_regenvio_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sgd_renv_regenvio_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sgd_renv_regenvio_id_seq OWNER TO postgres;

--
-- TOC entry 3059 (class 0 OID 0)
-- Dependencies: 267
-- Name: sgd_renv_regenvio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sgd_renv_regenvio_id_seq OWNED BY sgd_renv_regenvio.id;


--
-- TOC entry 268 (class 1259 OID 18233)
-- Name: sgd_rmr_radmasivre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_rmr_radmasivre (
    sgd_rmr_grupo numeric(15,0) NOT NULL,
    sgd_rmr_radi numeric(15,0) NOT NULL
);


ALTER TABLE sgd_rmr_radmasivre OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 18236)
-- Name: sgd_san_sancionados; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_san_sancionados (
    sgd_san_ref character varying(20) NOT NULL,
    sgd_san_decision character varying(60),
    sgd_san_cargo character varying(50),
    sgd_san_expediente character varying(20),
    sgd_san_tipo_sancion character varying(50),
    sgd_san_plazo character varying(100),
    sgd_san_valor numeric(14,2),
    sgd_san_radicacion character varying(15),
    sgd_san_fecha_radicado timestamp without time zone,
    sgd_san_valorletras character varying(1000),
    sgd_san_nombreempresa character varying(160),
    sgd_san_motivos character varying(160),
    sgd_san_sectores character varying(160),
    sgd_san_padre character varying(15),
    sgd_san_fecha_padre timestamp without time zone,
    sgd_san_notificado character varying(100)
);


ALTER TABLE sgd_san_sancionados OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 18242)
-- Name: sgd_sbrd_subserierd; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_sbrd_subserierd (
    sgd_srd_codigo numeric(4,0) NOT NULL,
    sgd_sbrd_codigo numeric(4,0) NOT NULL,
    sgd_sbrd_descrip character varying(200) NOT NULL,
    sgd_sbrd_fechini timestamp without time zone NOT NULL,
    sgd_sbrd_fechfin timestamp without time zone NOT NULL,
    sgd_sbrd_tiemag numeric(4,0),
    sgd_sbrd_tiemac numeric(4,0),
    sgd_sbrd_dispfin character varying(50),
    sgd_sbrd_soporte character varying(50),
    sgd_sbrd_procedi character varying(200)
);


ALTER TABLE sgd_sbrd_subserierd OWNER TO postgres;

--
-- TOC entry 3060 (class 0 OID 0)
-- Dependencies: 270
-- Name: TABLE sgd_sbrd_subserierd; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sgd_sbrd_subserierd IS 'Tabla que contiene  las Subseries documentales en OrfeoGPL. Modificado por Jloasada 20121';


--
-- TOC entry 3061 (class 0 OID 0)
-- Dependencies: 270
-- Name: COLUMN sgd_sbrd_subserierd.sgd_srd_codigo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_sbrd_subserierd.sgd_srd_codigo IS 'Codigo de Serie Documental, desde la ver 3.8 se elimina el pk en este campo y se crea el Id.  Esto permite la modificacion de este codigo segun conveniencia de las Entidades/Empresas.';


--
-- TOC entry 3062 (class 0 OID 0)
-- Dependencies: 270
-- Name: COLUMN sgd_sbrd_subserierd.sgd_sbrd_fechini; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_sbrd_subserierd.sgd_sbrd_fechini IS 'Fecha en la cual inicia la ejecucion de esta subserie Documental.';


--
-- TOC entry 3063 (class 0 OID 0)
-- Dependencies: 270
-- Name: COLUMN sgd_sbrd_subserierd.sgd_sbrd_fechfin; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_sbrd_subserierd.sgd_sbrd_fechfin IS 'Fecha en la cual finaliza la ejecucion de esta subserie Documental. ';


--
-- TOC entry 271 (class 1259 OID 18251)
-- Name: sgd_senuf_secnumfe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_senuf_secnumfe (
    sgd_pnufe_codi numeric(4,0),
    depe_codi numeric(10,0),
    sgd_senuf_sec character varying(50)
);


ALTER TABLE sgd_senuf_secnumfe OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 18254)
-- Name: sgd_sexp_secexpedientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_sexp_secexpedientes (
    sgd_exp_numero character varying(18) NOT NULL,
    sgd_srd_codigo numeric,
    sgd_sbrd_codigo numeric,
    sgd_sexp_secuencia numeric,
    depe_codi numeric(10,0),
    usua_doc character varying(15),
    sgd_sexp_fech timestamp without time zone,
    sgd_fexp_codigo numeric DEFAULT 0,
    sgd_sexp_ano numeric,
    usua_doc_responsable character varying(18),
    sgd_sexp_parexp1 character varying(300),
    sgd_sexp_parexp2 character varying(300),
    sgd_sexp_parexp3 character varying(300),
    sgd_sexp_parexp4 character varying(1200),
    sgd_sexp_parexp5 character varying(512),
    sgd_pexp_codigo numeric(3,0) DEFAULT 0 NOT NULL,
    sgd_exp_fech_arch timestamp without time zone,
    sgd_fld_codigo numeric(3,0),
    sgd_exp_fechflujoant timestamp without time zone,
    sgd_mrd_codigo numeric(4,0),
    sgd_exp_subexpediente numeric(18,0),
    sgd_exp_privado numeric(1,0),
    sgd_exp_caja character varying(10),
    id integer NOT NULL,
    sgd_sexp_parexp6 character varying(250),
    sgd_sexp_parexp7 character varying(250),
    sgd_sexp_parexp8 character varying(250),
    sgd_sexp_parexp9 character varying(250),
    sgd_sexp_parexp10 character varying(250),
    sgd_sexp_prestamo integer DEFAULT 0 NOT NULL
);


ALTER TABLE sgd_sexp_secexpedientes OWNER TO postgres;

--
-- TOC entry 3064 (class 0 OID 0)
-- Dependencies: 272
-- Name: COLUMN sgd_sexp_secexpedientes.sgd_sexp_prestamo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_sexp_secexpedientes.sgd_sexp_prestamo IS 'Boolenao para prestamo de expedientes';


--
-- TOC entry 273 (class 1259 OID 18263)
-- Name: sgd_sexp_secexpedientes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sgd_sexp_secexpedientes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sgd_sexp_secexpedientes_id_seq OWNER TO postgres;

--
-- TOC entry 3065 (class 0 OID 0)
-- Dependencies: 273
-- Name: sgd_sexp_secexpedientes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sgd_sexp_secexpedientes_id_seq OWNED BY sgd_sexp_secexpedientes.id;


--
-- TOC entry 274 (class 1259 OID 18272)
-- Name: sgd_srd_seriesrd; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_srd_seriesrd (
    sgd_srd_codigo numeric(4,0) NOT NULL,
    sgd_srd_descrip character varying(70) NOT NULL,
    sgd_srd_fechini timestamp without time zone NOT NULL,
    sgd_srd_fechfin timestamp without time zone NOT NULL
);


ALTER TABLE sgd_srd_seriesrd OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 18275)
-- Name: sgd_tar_tarifas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_tar_tarifas (
    sgd_fenv_codigo numeric(5,0),
    sgd_tar_codigo numeric(5,0),
    sgd_tar_valenv1 numeric(15,0),
    sgd_tar_valenv2 numeric(15,0),
    sgd_tar_valenv1g1 numeric(15,0),
    sgd_clta_codser numeric(5,0),
    sgd_tar_valenv2g2 numeric(15,0),
    sgd_clta_descrip character varying(100)
);


ALTER TABLE sgd_tar_tarifas OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 18278)
-- Name: sgd_tdec_tipodecision; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_tdec_tipodecision (
    sgd_apli_codi numeric(4,0) NOT NULL,
    sgd_tdec_codigo numeric(4,0) NOT NULL,
    sgd_tdec_descrip character varying(150),
    sgd_tdec_sancionar numeric(1,0),
    sgd_tdec_firmeza numeric(1,0),
    sgd_tdec_versancion numeric(1,0),
    sgd_tdec_showmenu numeric(1,0),
    sgd_tdec_updnotif numeric(1,0)
);


ALTER TABLE sgd_tdec_tipodecision OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 18293)
-- Name: sgd_tip3_tipotercero; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_tip3_tipotercero (
    sgd_tip3_codigo numeric(2,0) NOT NULL,
    sgd_dir_tipo numeric(4,0),
    sgd_tip3_nombre character varying(15),
    sgd_tip3_desc character varying(30),
    sgd_tip3_imgpestana character varying(20),
    sgd_tpr_tp1 numeric(1,0) DEFAULT 0,
    sgd_tpr_tp2 numeric(1,0) DEFAULT 0,
    sgd_tpr_tp3 numeric(1,0) DEFAULT 0,
    sgd_tpr_tp4 smallint DEFAULT 1,
    sgd_tpr_tp5 smallint DEFAULT 1,
    sgd_tpr_tp9 smallint DEFAULT 1
);


ALTER TABLE sgd_tip3_tipotercero OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 18302)
-- Name: sgd_tma_temas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_tma_temas (
    sgd_tma_codigo numeric(4,0) NOT NULL,
    depe_codi numeric(10,0),
    sgd_prc_codigo numeric(4,0),
    sgd_tma_descrip character varying(150)
);


ALTER TABLE sgd_tma_temas OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 18305)
-- Name: sgd_tme_tipmen; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_tme_tipmen (
    sgd_tme_codi numeric(3,0) NOT NULL
);


ALTER TABLE sgd_tme_tipmen OWNER TO postgres;

--
-- TOC entry 280 (class 1259 OID 18308)
-- Name: sgd_tpr_tpdcumento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_tpr_tpdcumento (
    sgd_tpr_codigo numeric(4,0) NOT NULL,
    sgd_tpr_descrip character varying(150),
    sgd_tpr_termino numeric(4,0),
    sgd_tpr_tpuso numeric(1,0),
    sgd_tpr_radica character(1),
    sgd_tpr_tp3 numeric(1,0) DEFAULT 0,
    sgd_tpr_tp1 numeric(1,0) DEFAULT 0,
    sgd_tpr_tp2 numeric(1,0) DEFAULT 0,
    sgd_tpr_estado numeric(1,0) DEFAULT 1,
    sgd_termino_real numeric(4,0),
    sgd_tpr_tp6 numeric(1,0) DEFAULT 0,
    sgd_tpr_web numeric(1,0) DEFAULT 0,
    sgd_tpr_tp4 smallint,
    sgd_tpr_tp5 smallint,
    sgd_tpr_tp9 smallint
);


ALTER TABLE sgd_tpr_tpdcumento OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 18317)
-- Name: sgd_trad_tiporad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_trad_tiporad (
    sgd_trad_codigo numeric(2,0) NOT NULL,
    sgd_trad_descr character varying(30),
    sgd_trad_icono character varying(30),
    sgd_trad_genradsal numeric(1,0)
);


ALTER TABLE sgd_trad_tiporad OWNER TO postgres;

--
-- TOC entry 282 (class 1259 OID 18325)
-- Name: sgd_ttr_transaccion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_ttr_transaccion (
    sgd_ttr_codigo numeric(3,0) NOT NULL,
    sgd_ttr_descrip character varying(100) NOT NULL
);


ALTER TABLE sgd_ttr_transaccion OWNER TO postgres;

--
-- TOC entry 283 (class 1259 OID 18334)
-- Name: tipo_doc_identificacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tipo_doc_identificacion (
    tdid_codi numeric(2,0) NOT NULL,
    tdid_desc character varying(100) NOT NULL
);


ALTER TABLE tipo_doc_identificacion OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 18337)
-- Name: tipo_remitente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tipo_remitente (
    trte_codi numeric(2,0) NOT NULL,
    trte_desc character varying(100) NOT NULL
);


ALTER TABLE tipo_remitente OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 18340)
-- Name: ubicacion_fisica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ubicacion_fisica (
    ubic_depe_radi numeric(5,0) NOT NULL,
    ubic_depe_arch numeric(5,0)
);


ALTER TABLE ubicacion_fisica OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 18343)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE usuario (
    id integer NOT NULL,
    usua_codi numeric(10,0) NOT NULL,
    depe_codi numeric(10,0) NOT NULL,
    usua_login character varying(40) NOT NULL,
    usua_fech_crea timestamp without time zone NOT NULL,
    usua_pasw character varying(30) NOT NULL,
    usua_esta character varying(10) NOT NULL,
    usua_nomb character varying(45),
    usua_admin character(1) DEFAULT '0'::bpchar,
    usua_nuevo character(1) DEFAULT '0'::bpchar,
    usua_doc character varying(14) DEFAULT '0'::character varying,
    codi_nivel numeric(2,0) DEFAULT 1,
    usua_sesion character varying(100),
    usua_fech_sesion timestamp without time zone,
    usua_ext numeric(4,0),
    usua_nacim date,
    usua_email character varying(50),
    usua_at character varying(15),
    usua_piso numeric(2,0),
    usu_telefono1 character varying(14),
    id_pais numeric(4,0) DEFAULT 170,
    id_cont numeric(2,0) DEFAULT 1,
    sgd_rol_codigo numeric(1,0) DEFAULT 0,
    usua_email_1 character varying(50),
    usua_email_2 character varying(50)
);


ALTER TABLE usuario OWNER TO postgres;

--
-- TOC entry 287 (class 1259 OID 18373)
-- Name: usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE usuario_id_seq OWNER TO postgres;

--
-- TOC entry 3066 (class 0 OID 0)
-- Dependencies: 287
-- Name: usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE usuario_id_seq OWNED BY usuario.id;


--
-- TOC entry 2493 (class 2604 OID 18435)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY anexos ALTER COLUMN id SET DEFAULT nextval('anexos_id_seq'::regclass);


--
-- TOC entry 2502 (class 2604 OID 18442)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dependencia ALTER COLUMN id SET DEFAULT nextval('dependencia_id_seq'::regclass);


--
-- TOC entry 2503 (class 2604 OID 18446)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hist_eventos ALTER COLUMN id SET DEFAULT nextval('hist_eventos_id_seq'::regclass);


--
-- TOC entry 2515 (class 2604 OID 18447)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY radicado ALTER COLUMN id SET DEFAULT nextval('radicado_id_seq'::regclass);


--
-- TOC entry 2522 (class 2604 OID 18448)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_agen_agendados ALTER COLUMN id SET DEFAULT nextval('sgd_agen_agendados_id_seq'::regclass);


--
-- TOC entry 2530 (class 2604 OID 18449)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_dir_drecciones ALTER COLUMN id SET DEFAULT nextval('sgd_dir_drecciones_id_seq'::regclass);


--
-- TOC entry 2534 (class 2604 OID 18450)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_exp_expediente ALTER COLUMN id SET DEFAULT nextval('sgd_exp_expediente_id_seq'::regclass);


--
-- TOC entry 2537 (class 2604 OID 18451)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_hfld_histflujodoc ALTER COLUMN id SET DEFAULT nextval('sgd_hfld_histflujodoc_id_seq'::regclass);


--
-- TOC entry 2541 (class 2604 OID 18452)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_parexp_paramexpediente ALTER COLUMN id SET DEFAULT nextval('sgd_parexp_paramexpediente_id_seq'::regclass);


--
-- TOC entry 2544 (class 2604 OID 18453)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_plan_plantillas ALTER COLUMN id SET DEFAULT nextval('sgd_plan_plantillas_id_seq'::regclass);


--
-- TOC entry 2545 (class 2604 OID 18454)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_rdf_retdocf ALTER COLUMN id SET DEFAULT nextval('sgd_rdf_retdocf_id_seq'::regclass);


--
-- TOC entry 2555 (class 2604 OID 18455)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_renv_regenvio ALTER COLUMN id SET DEFAULT nextval('sgd_renv_regenvio_id_seq'::regclass);


--
-- TOC entry 2559 (class 2604 OID 18456)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_sexp_secexpedientes ALTER COLUMN id SET DEFAULT nextval('sgd_sexp_secexpedientes_id_seq'::regclass);


--
-- TOC entry 2579 (class 2604 OID 18457)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario ALTER COLUMN id SET DEFAULT nextval('usuario_id_seq'::regclass);


--
-- TOC entry 2928 (class 0 OID 17470)
-- Dependencies: 180
-- Data for Name: anexos; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3067 (class 0 OID 0)
-- Dependencies: 181
-- Name: anexos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('anexos_id_seq', 1, true);


--
-- TOC entry 2930 (class 0 OID 17487)
-- Dependencies: 182
-- Data for Name: anexos_tipo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO anexos_tipo (anex_tipo_codi, anex_tipo_ext, anex_tipo_desc) VALUES (13, 'csv', 'csv (separado por comas)');
INSERT INTO anexos_tipo (anex_tipo_codi, anex_tipo_ext, anex_tipo_desc) VALUES (1, 'doc', '.doc (Procesador de texto - Word)');
INSERT INTO anexos_tipo (anex_tipo_codi, anex_tipo_ext, anex_tipo_desc) VALUES (2, 'xls', '.xls (Hoja de calculo)');
INSERT INTO anexos_tipo (anex_tipo_codi, anex_tipo_ext, anex_tipo_desc) VALUES (3, 'ppt', '.ppt (Presentacion)');
INSERT INTO anexos_tipo (anex_tipo_codi, anex_tipo_ext, anex_tipo_desc) VALUES (4, 'tif', '.tif (Imagen)');
INSERT INTO anexos_tipo (anex_tipo_codi, anex_tipo_ext, anex_tipo_desc) VALUES (5, 'jpg', '.jpg (Imagen)');
INSERT INTO anexos_tipo (anex_tipo_codi, anex_tipo_ext, anex_tipo_desc) VALUES (6, 'gif', '.gif (Imagen)');
INSERT INTO anexos_tipo (anex_tipo_codi, anex_tipo_ext, anex_tipo_desc) VALUES (7, 'pdf', '.pdf (Acrobat Reader)');
INSERT INTO anexos_tipo (anex_tipo_codi, anex_tipo_ext, anex_tipo_desc) VALUES (8, 'txt', '.txt (Documento texto)');
INSERT INTO anexos_tipo (anex_tipo_codi, anex_tipo_ext, anex_tipo_desc) VALUES (20, 'avi', '.avi (Video)');
INSERT INTO anexos_tipo (anex_tipo_codi, anex_tipo_ext, anex_tipo_desc) VALUES (21, 'mpg', '.mpg (video)');
INSERT INTO anexos_tipo (anex_tipo_codi, anex_tipo_ext, anex_tipo_desc) VALUES (16, 'xml', '.xml (XML de Microsoft Word 2003)');
INSERT INTO anexos_tipo (anex_tipo_codi, anex_tipo_ext, anex_tipo_desc) VALUES (23, 'tar', '.tar (Comprimido)');
INSERT INTO anexos_tipo (anex_tipo_codi, anex_tipo_ext, anex_tipo_desc) VALUES (9, 'zip', '.zip (Comprimido)');
INSERT INTO anexos_tipo (anex_tipo_codi, anex_tipo_ext, anex_tipo_desc) VALUES (10, 'rtf', '.rtf (Rich Text Format)');
INSERT INTO anexos_tipo (anex_tipo_codi, anex_tipo_ext, anex_tipo_desc) VALUES (11, 'dia', '.dia (Diagrama)');
INSERT INTO anexos_tipo (anex_tipo_codi, anex_tipo_ext, anex_tipo_desc) VALUES (12, 'zargo', 'Argo(Diagrama)');
INSERT INTO anexos_tipo (anex_tipo_codi, anex_tipo_ext, anex_tipo_desc) VALUES (18, 'docx', '.docx (Word > 2007)');
INSERT INTO anexos_tipo (anex_tipo_codi, anex_tipo_ext, anex_tipo_desc) VALUES (17, 'png', '.png (Imagen)');
INSERT INTO anexos_tipo (anex_tipo_codi, anex_tipo_ext, anex_tipo_desc) VALUES (14, 'odt', '.odt (Procesador de Texto - odf)');
INSERT INTO anexos_tipo (anex_tipo_codi, anex_tipo_ext, anex_tipo_desc) VALUES (15, 'ods', '.ods (Hoja de Calculo - Odf)');
INSERT INTO anexos_tipo (anex_tipo_codi, anex_tipo_ext, anex_tipo_desc) VALUES (24, 'xlsx', 'Archivos de Excel 2014');


--
-- TOC entry 2931 (class 0 OID 17490)
-- Dependencies: 183
-- Data for Name: autg_grupos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO autg_grupos (id, nombre, descripcion) VALUES (1, 'Administrador', 'Administrador del sistema');
INSERT INTO autg_grupos (id, nombre, descripcion) VALUES (2, 'Digitalizador', 'Digitaliza oficios entrada, salida y fondos. ');
INSERT INTO autg_grupos (id, nombre, descripcion) VALUES (3, 'Secretaria', 'Secretaria por dependencia');
INSERT INTO autg_grupos (id, nombre, descripcion) VALUES (4, 'Radicación Entrada', 'Radicación del Sistema');
INSERT INTO autg_grupos (id, nombre, descripcion) VALUES (5, 'Envíos', 'Usuario para envíos de Correspondencia');
INSERT INTO autg_grupos (id, nombre, descripcion) VALUES (6, 'Archivo Fisico', 'Archivo Fisico del proceso de gestion documental');
INSERT INTO autg_grupos (id, nombre, descripcion) VALUES (7, 'Jefe', 'Jefes de dependencia.');
INSERT INTO autg_grupos (id, nombre, descripcion) VALUES (8, 'Asistente', 'Asiste al jefe en diversas tareas');
INSERT INTO autg_grupos (id, nombre, descripcion) VALUES (9, 'funcionario', 'usuario que radica internos y salidas');


--
-- TOC entry 2932 (class 0 OID 17496)
-- Dependencies: 184
-- Data for Name: autm_membresias; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO autm_membresias (id, autg_id, autu_id) VALUES (1, 1, 1);


--
-- TOC entry 2933 (class 0 OID 17499)
-- Dependencies: 185
-- Data for Name: autp_permisos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (44, 'USUARIO_PRUEBA', 'Prueba', 3);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (45, 'USUARIO_PUBLICO', 'Habilita La Visibilidad De Un Usuario', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (46, 'USUARIO_REASIGNA', 'Usuario Reasigna', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (36, 'USUA_AUTH_LDAP', 'Autentica Por Ldap', 0);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (18, 'USUARIO_REASIGNAR', 'Reasignar', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (15, 'SGD_PANU_CODI', 'Anulacion', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (37, 'USUA_NUEVO', 'El Usuario Que Tenga Este Permiso, Se Le Resetea La Contraseña', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (47, 'USUA_SCAN', 'Permiso Digitalizacion ', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (48, 'USUA_SCAN', 'Permiso Digitalizacion ', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (33, 'USUA_PERM_OWNCLOUD', 'Digitalizador_Owncloud', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (32, 'CODI_NIVEL', 'Codigo Del Nivel', 5);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (12, 'DEPE_CODI_PADRE', 'Codigo Padre', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (27, 'PERM_ARCHI', 'Permiso Archivo', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (10, 'PERM_BORRAR_ANEXO', 'Borrar Anexo', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (9, 'PERM_TIPIF_ANEXO', 'Anexo', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (28, 'PERM_VOBO', 'Permiso Visto Bueno', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (7, 'PERM_RADI', 'Radicacion', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (34, 'SGD_PERM_ESTADISTICA', 'Estadistica Nivel 2', 2);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (35, 'SGD_PERM_ESTADISTICA', 'Estadistica Nivel Maximo', 5);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (1, 'USUA_ADM_PLANTILLA', 'Uso De Plantillas', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (2, 'USUA_ADMIN_ARCHIVO', 'Administrador Archivo', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (5, 'USUA_ADMIN_ARCHIVO', 'Archivo Editar', 2);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (6, 'USUA_ADMIN_SISTEMA', 'Administrador Del Sistema', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (11, 'USUA_MASIVA', 'Radicacion Masiva', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (30, 'USUA_PERM_ADMINFLUJOS', 'Flujos', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (14, 'USUA_PERM_DEV', 'Descripcion', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (21, 'USUA_PERM_FIRMA', 'Firma', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (8, 'USUA_PERM_IMPRESION', 'Permiso Para Marcar Como Impreso', 2);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (20, 'USUA_PERM_INTERGAPPS', 'Descripcion', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (17, 'USUA_PERM_MODIFICA', 'Modificacion', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (23, 'USUA_PERM_NOTIFICA', 'Descripcion', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (22, 'USUA_PERM_PRESTAMO', 'Descripcion', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (25, 'USUA_PERM_RADEMAIL', 'Descripcion', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (26, 'USUA_PERM_RADFAX', 'Descripcion', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (13, 'USUA_PERM_NUMERA_RES', 'Numeracion', 0);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (29, 'USUA_PERM_RESPUESTA', 'Descripcion', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (19, 'USUA_PERM_SANCIONADOS', 'Descripcion', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (3, 'USUA_PERM_TRD', 'Administrador Trd', 3);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (38, 'USUA_PERM_TRD', 'Trd', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (40, 'USUA_PRAD_REPRAD', 'Permiso Reporte De Radicación De Entrada', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (42, 'USUA_PRAD_TP2', 'Permiso Radicación De Entrada', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (49, 'USUA_PERM_STICKER', 'Permiso De Sticker', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (16, 'USUA_PERM_ENVIOS', 'Envios', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (41, 'USUA_PRAD_TP1', 'Radica Salida', 3);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (43, 'USUA_PRAD_TP3', 'Radicar Interno', 1);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (24, 'USUA_PERM_EXPEDIENTE', 'Expediente', 3);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (31, 'USUA_ADMIN_ARCHIVO', 'Archivo', 0);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (4, 'SGD_PERM_ESTADISTICA', 'Permisos Estadistica', 2);
INSERT INTO autp_permisos (id, nombre, descripcion, crud) VALUES (39, 'USUA_PERM_TRD', 'Trd', 5);


--
-- TOC entry 2934 (class 0 OID 17505)
-- Dependencies: 186
-- Data for Name: autr_restric_grupo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (1, 1, 1);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (2, 1, 2);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (3, 1, 3);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (4, 1, 4);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (5, 1, 5);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (6, 1, 6);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (7, 1, 7);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (8, 1, 8);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (9, 1, 9);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (10, 1, 10);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (11, 1, 11);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (12, 1, 12);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (13, 1, 13);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (14, 1, 14);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (15, 1, 15);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (16, 1, 16);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (17, 1, 17);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (18, 1, 18);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (19, 1, 19);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (20, 1, 20);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (21, 1, 21);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (22, 1, 22);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (23, 1, 23);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (24, 1, 24);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (25, 1, 25);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (26, 1, 26);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (27, 1, 27);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (28, 1, 28);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (29, 1, 29);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (30, 1, 30);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (31, 1, 31);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (32, 1, 32);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (33, 1, 33);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (34, 1, 34);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (35, 1, 35);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (36, 1, 36);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (37, 1, 37);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (38, 1, 38);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (39, 1, 39);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (40, 1, 40);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (41, 1, 41);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (42, 1, 42);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (43, 1, 43);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (44, 1, 44);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (45, 1, 45);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (46, 1, 46);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (47, 1, 47);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (48, 1, 48);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (49, 1, 49);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (50, 1, 50);
INSERT INTO autr_restric_grupo (id, autg_id, autp_id) VALUES (51, 1, 51);


--
-- TOC entry 2935 (class 0 OID 17514)
-- Dependencies: 187
-- Data for Name: bodega_empresas; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2936 (class 0 OID 17547)
-- Dependencies: 188
-- Data for Name: carpeta; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO carpeta (carp_codi, carp_desc) VALUES (0, 'Entrada');
INSERT INTO carpeta (carp_codi, carp_desc) VALUES (12, 'Devueltos');
INSERT INTO carpeta (carp_codi, carp_desc) VALUES (11, 'Vo.Bo.');
INSERT INTO carpeta (carp_codi, carp_desc) VALUES (1, 'Salida');
INSERT INTO carpeta (carp_codi, carp_desc) VALUES (3, 'Memos');
INSERT INTO carpeta (carp_codi, carp_desc) VALUES (4, 'Transferencias');
INSERT INTO carpeta (carp_codi, carp_desc) VALUES (13, 'Radicados Antiguos');
INSERT INTO carpeta (carp_codi, carp_desc) VALUES (5, 'Resoluciones');


--
-- TOC entry 2937 (class 0 OID 17550)
-- Dependencies: 189
-- Data for Name: carpeta_per; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2938 (class 0 OID 17701)
-- Dependencies: 190
-- Data for Name: departamento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (8, 'ATLANTICO', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (11, 'D.C.', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (13, 'BOLIVAR', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (15, 'BOYACA', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (17, 'CALDAS', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (5, 'ANTIOQUIA', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (18, 'CAQUETA', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (19, 'CAUCA', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (20, 'CESAR', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (23, 'CORDOBA', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (25, 'CUNDINAMARCA', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (27, 'CHOCO', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (41, 'HUILA', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (44, 'LA GUAJIRA', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (47, 'MAGDALENA', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (50, 'META', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (52, 'NARINO', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (54, 'NORTE DE SANTANDER', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (63, 'QUINDIO', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (66, 'RISARALDA', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (68, 'SANTANDER', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (70, 'SUCRE', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (73, 'TOLIMA', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (76, 'VALLE DEL CAUCA', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (81, 'ARAUCA', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (85, 'CASANARE', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (86, 'PUTUMAYO', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (88, 'SAN ANDRES', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (91, 'AMAZONAS', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (94, 'GUAINIA', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (95, 'GUAVIARE', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (97, 'VAUPES', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (99, 'VICHADA', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (9, 'CALIFORNIA', 1, 200);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (0, 'NO EXISTE', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (1, 'TODOS', 1, 170);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (2, 'SAO PAULO', 1, 29);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (3, 'LIMA', 1, 166);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (4, 'KENTUCKY', 1, 223);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (6, 'TEXAS', 1, 223);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (7, 'DISTRITO FEDERAL', 1, 137);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (98, 'RIO DE JANEIRO', 1, 29);
INSERT INTO departamento (dpto_codi, dpto_nomb, id_cont, id_pais) VALUES (80, 'LA PAZ', 1, 25);


--
-- TOC entry 2939 (class 0 OID 17709)
-- Dependencies: 191
-- Data for Name: dependencia; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO dependencia (id, depe_codi, depe_nomb, dpto_codi, depe_codi_padre, muni_codi, depe_codi_territorial, dep_sigla, dep_central, dep_direccion, depe_num_interna, depe_num_resolucion, depe_rad_tp1, acto_admon, id_cont, id_pais, depe_estado) VALUES (2, 900, 'PRUEBAS', 11, 900, 1, 900, 'pb', NULL, '', 900, NULL, 900, '', 1, 170, 1);
INSERT INTO dependencia (id, depe_codi, depe_nomb, dpto_codi, depe_codi_padre, muni_codi, depe_codi_territorial, dep_sigla, dep_central, dep_direccion, depe_num_interna, depe_num_resolucion, depe_rad_tp1, acto_admon, id_cont, id_pais, depe_estado) VALUES (1, 100, 'GERENCIA', 11, NULL, 1, 0, 'GG', NULL, '', NULL, NULL, 100, '', 1, 170, 1);
INSERT INTO dependencia (id, depe_codi, depe_nomb, dpto_codi, depe_codi_padre, muni_codi, depe_codi_territorial, dep_sigla, dep_central, dep_direccion, depe_num_interna, depe_num_resolucion, depe_rad_tp1, acto_admon, id_cont, id_pais, depe_estado) VALUES (3, 999, 'ARCHIVO VIRTUAL', 11, 100, 1, 100, 'ARCHIVO', NULL, 'Calle 52 No. 13 - 64 Pisos 7 - 8 y 9', NULL, NULL, 100, '', 1, 170, 1);


--
-- TOC entry 3068 (class 0 OID 0)
-- Dependencies: 192
-- Name: dependencia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('dependencia_id_seq', 4, true);


--
-- TOC entry 2941 (class 0 OID 17717)
-- Dependencies: 193
-- Data for Name: dependencia_visibilidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (637, 905, 905);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (147, 110, 100);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (148, 110, 110);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (149, 110, 120);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (150, 110, 130);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (151, 110, 200);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (152, 110, 300);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (153, 110, 400);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (154, 110, 410);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (155, 110, 420);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (156, 110, 430);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (157, 110, 440);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (158, 110, 450);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (159, 110, 460);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (160, 110, 500);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (161, 110, 600);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (162, 110, 605);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (163, 110, 900);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (164, 110, 905);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (165, 110, 999);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (166, 120, 100);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (167, 120, 110);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (168, 120, 120);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (169, 120, 130);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (170, 120, 200);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (171, 120, 300);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (172, 120, 400);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (173, 120, 410);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (174, 120, 420);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (175, 120, 430);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (176, 120, 440);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (177, 120, 450);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (178, 120, 460);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (179, 120, 500);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (180, 120, 600);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (181, 120, 605);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (182, 120, 900);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (183, 120, 905);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (184, 120, 999);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (185, 130, 100);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (186, 130, 110);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (187, 130, 120);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (188, 130, 130);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (189, 130, 200);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (190, 130, 300);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (191, 130, 400);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (192, 130, 410);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (193, 130, 420);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (194, 130, 430);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (195, 130, 440);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (196, 130, 450);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (197, 130, 460);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (198, 130, 500);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (199, 130, 600);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (200, 130, 605);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (201, 130, 900);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (202, 130, 905);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (203, 130, 999);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (242, 400, 100);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (243, 400, 110);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (244, 400, 120);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (245, 400, 130);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (246, 400, 200);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (247, 400, 300);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (248, 400, 400);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (249, 400, 410);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (250, 400, 420);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (251, 400, 430);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (252, 400, 440);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (253, 400, 450);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (254, 400, 460);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (255, 400, 500);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (256, 400, 600);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (257, 400, 605);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (258, 400, 900);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (259, 400, 905);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (260, 400, 999);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (566, 460, 100);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (567, 460, 110);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (568, 460, 120);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (569, 460, 130);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (570, 460, 200);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (571, 460, 300);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (572, 460, 400);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (573, 460, 410);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (574, 460, 420);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (575, 460, 430);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (576, 460, 440);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (577, 460, 450);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (578, 460, 460);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (579, 460, 500);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (580, 460, 600);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (581, 460, 605);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (582, 460, 900);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (583, 460, 905);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (584, 460, 999);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (617, 300, 100);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (618, 300, 110);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (619, 300, 120);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (620, 300, 130);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (621, 300, 200);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (622, 300, 300);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (623, 300, 301);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (624, 300, 400);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (625, 300, 410);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (626, 300, 420);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (627, 300, 430);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (628, 300, 440);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (629, 300, 450);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (630, 300, 460);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (631, 300, 500);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (632, 300, 600);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (633, 300, 605);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (634, 300, 900);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (635, 300, 905);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (636, 300, 999);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (337, 450, 100);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (338, 450, 110);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (339, 450, 120);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (340, 450, 130);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (341, 450, 200);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (342, 450, 300);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (343, 450, 400);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (344, 450, 410);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (345, 450, 420);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (346, 450, 430);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (347, 450, 440);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (348, 450, 450);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (349, 450, 460);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (350, 450, 500);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (351, 450, 600);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (352, 450, 605);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (353, 450, 900);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (354, 450, 905);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (355, 450, 999);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (375, 500, 100);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (376, 500, 110);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (377, 500, 120);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (378, 500, 130);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (379, 500, 200);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (380, 500, 300);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (381, 500, 400);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (382, 500, 410);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (383, 500, 420);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (384, 500, 430);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (385, 500, 440);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (386, 500, 450);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (387, 500, 460);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (388, 500, 500);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (389, 500, 600);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (390, 500, 605);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (391, 500, 900);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (392, 500, 905);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (393, 500, 999);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (394, 600, 100);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (395, 600, 110);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (396, 600, 120);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (397, 600, 130);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (398, 600, 200);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (399, 600, 300);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (400, 600, 400);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (401, 600, 410);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (402, 600, 420);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (403, 600, 430);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (404, 600, 440);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (405, 600, 450);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (406, 600, 460);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (407, 600, 500);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (408, 600, 600);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (409, 600, 605);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (410, 600, 900);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (411, 600, 905);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (412, 600, 999);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (431, 200, 100);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (432, 200, 110);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (433, 200, 120);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (434, 200, 130);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (435, 200, 200);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (436, 200, 300);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (437, 200, 400);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (438, 200, 410);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (439, 200, 420);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (440, 200, 430);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (441, 200, 440);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (442, 200, 450);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (443, 200, 460);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (444, 200, 500);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (445, 200, 600);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (446, 200, 605);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (447, 200, 900);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (448, 200, 905);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (449, 200, 999);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (450, 605, 100);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (451, 605, 110);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (452, 605, 120);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (453, 605, 130);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (454, 605, 200);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (455, 605, 300);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (456, 605, 400);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (457, 605, 410);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (458, 605, 420);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (459, 605, 430);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (460, 605, 440);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (461, 605, 450);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (462, 605, 460);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (463, 605, 500);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (464, 605, 600);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (465, 605, 605);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (466, 605, 900);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (467, 605, 905);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (468, 605, 999);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (591, 900, 900);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (592, 420, 100);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (593, 420, 400);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (594, 420, 420);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (595, 420, 700);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (596, 420, 999);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (597, 100, 100);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (598, 100, 110);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (599, 100, 120);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (600, 100, 130);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (601, 100, 200);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (602, 100, 300);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (603, 100, 301);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (604, 100, 400);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (605, 100, 410);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (606, 100, 420);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (607, 100, 430);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (608, 100, 440);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (609, 100, 450);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (610, 100, 460);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (611, 100, 500);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (612, 100, 600);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (613, 100, 605);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (614, 100, 900);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (615, 100, 905);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (616, 100, 999);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (469, 301, 100);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (470, 301, 110);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (471, 301, 120);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (472, 301, 130);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (473, 301, 200);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (474, 301, 300);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (475, 301, 301);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (476, 301, 400);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (477, 301, 410);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (478, 301, 420);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (479, 301, 430);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (480, 301, 440);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (481, 301, 450);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (482, 301, 460);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (483, 301, 500);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (484, 301, 600);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (485, 301, 605);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (486, 301, 700);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (487, 301, 900);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (488, 301, 905);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (489, 301, 999);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (528, 430, 100);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (529, 430, 110);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (530, 430, 120);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (531, 430, 130);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (532, 430, 200);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (533, 430, 300);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (534, 430, 400);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (535, 430, 410);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (536, 430, 420);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (537, 430, 430);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (538, 430, 440);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (539, 430, 450);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (540, 430, 460);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (541, 430, 500);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (542, 430, 600);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (543, 430, 605);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (544, 430, 900);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (545, 430, 905);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (546, 430, 999);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (547, 440, 100);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (548, 440, 110);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (549, 440, 120);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (550, 440, 130);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (551, 440, 200);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (552, 440, 300);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (553, 440, 400);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (554, 440, 410);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (555, 440, 420);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (556, 440, 430);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (557, 440, 440);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (558, 440, 450);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (559, 440, 460);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (560, 440, 500);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (561, 440, 600);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (562, 440, 605);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (563, 440, 900);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (564, 440, 905);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (565, 440, 999);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (638, 110, 100);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (639, 110, 900);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (640, 110, 905);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (641, 110, 999);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (642, 120, 905);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (643, 130, 100);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (644, 130, 110);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (645, 130, 120);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (646, 130, 900);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (647, 130, 905);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (648, 130, 999);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (649, 200, 100);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (650, 200, 110);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (651, 200, 120);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (652, 200, 130);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (653, 200, 900);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (654, 200, 905);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (655, 200, 999);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (656, 300, 100);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (657, 300, 110);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (658, 300, 120);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (659, 300, 130);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (660, 300, 200);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (661, 300, 900);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (662, 300, 905);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (663, 300, 999);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (664, 400, 100);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (665, 400, 110);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (666, 400, 120);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (667, 400, 130);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (668, 400, 200);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (669, 400, 300);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (670, 400, 900);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (671, 400, 905);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (672, 400, 999);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (694, 410, 100);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (695, 410, 110);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (696, 410, 120);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (697, 410, 130);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (698, 410, 200);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (699, 410, 300);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (700, 410, 400);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (701, 410, 410);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (702, 410, 900);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (703, 410, 905);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (704, 410, 999);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (716, 420, 411);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (717, 430, 300);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (718, 440, 100);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (719, 440, 110);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (720, 440, 120);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (721, 440, 130);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (722, 440, 200);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (723, 440, 300);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (724, 440, 400);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (725, 440, 410);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (726, 440, 900);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (727, 440, 905);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (728, 440, 999);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (729, 450, 440);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (730, 460, 100);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (731, 460, 110);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (732, 460, 120);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (733, 460, 130);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (734, 460, 200);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (735, 460, 300);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (736, 460, 400);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (737, 460, 410);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (738, 460, 420);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (739, 460, 430);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (740, 460, 440);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (741, 460, 450);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (742, 460, 900);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (743, 460, 905);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (744, 460, 999);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (745, 470, 100);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (746, 470, 110);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (747, 470, 120);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (748, 470, 130);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (749, 470, 200);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (750, 470, 300);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (751, 470, 400);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (752, 470, 410);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (753, 470, 420);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (754, 470, 430);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (755, 470, 440);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (756, 470, 450);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (757, 470, 460);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (758, 470, 900);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (759, 470, 905);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (760, 470, 999);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (761, 500, 100);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (762, 500, 110);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (763, 500, 120);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (764, 500, 130);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (765, 500, 200);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (766, 500, 300);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (767, 500, 400);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (768, 500, 410);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (769, 500, 420);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (770, 500, 430);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (771, 500, 440);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (772, 500, 450);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (773, 500, 460);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (774, 500, 900);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (775, 500, 905);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (776, 500, 999);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (777, 510, 100);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (778, 510, 110);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (779, 510, 120);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (780, 510, 130);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (781, 510, 200);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (782, 510, 300);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (783, 510, 400);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (784, 510, 410);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (785, 510, 420);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (786, 510, 430);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (787, 510, 440);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (788, 510, 450);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (789, 510, 460);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (790, 510, 500);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (791, 510, 900);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (792, 510, 905);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (793, 510, 999);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (794, 600, 100);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (795, 600, 110);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (796, 600, 120);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (797, 600, 130);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (798, 600, 200);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (799, 600, 300);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (800, 600, 400);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (801, 600, 410);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (802, 600, 420);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (803, 600, 430);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (804, 600, 440);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (805, 600, 450);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (806, 600, 460);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (807, 600, 500);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (808, 600, 900);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (809, 600, 905);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (810, 600, 999);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (812, 412, 100);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (813, 412, 110);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (814, 412, 120);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (815, 412, 130);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (816, 412, 200);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (817, 412, 300);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (818, 412, 400);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (819, 412, 410);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (820, 412, 900);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (821, 412, 905);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (822, 412, 999);
INSERT INTO dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) VALUES (823, 411, 900);


--
-- TOC entry 2942 (class 0 OID 17720)
-- Dependencies: 194
-- Data for Name: estado; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO estado (esta_codi, esta_desc) VALUES (9, 'Documento de Orfeo');


--
-- TOC entry 2943 (class 0 OID 17744)
-- Dependencies: 195
-- Data for Name: hist_eventos; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3069 (class 0 OID 0)
-- Dependencies: 196
-- Name: hist_eventos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hist_eventos_id_seq', 1, true);


--
-- TOC entry 2945 (class 0 OID 17752)
-- Dependencies: 197
-- Data for Name: informados; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2946 (class 0 OID 17760)
-- Dependencies: 198
-- Data for Name: medio_recepcion; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO medio_recepcion (mrec_codi, mrec_desc) VALUES (2, 'Fax');
INSERT INTO medio_recepcion (mrec_codi, mrec_desc) VALUES (9, 'Chat');
INSERT INTO medio_recepcion (mrec_codi, mrec_desc) VALUES (8, 'Call Center');
INSERT INTO medio_recepcion (mrec_codi, mrec_desc) VALUES (1, 'Personal');
INSERT INTO medio_recepcion (mrec_codi, mrec_desc) VALUES (3, 'Sitio Web');
INSERT INTO medio_recepcion (mrec_codi, mrec_desc) VALUES (5, 'Mensajería');
INSERT INTO medio_recepcion (mrec_codi, mrec_desc) VALUES (7, 'Atención Personalizada');
INSERT INTO medio_recepcion (mrec_codi, mrec_desc) VALUES (4, 'Correo electrónico');
INSERT INTO medio_recepcion (mrec_codi, mrec_desc) VALUES (6, 'Telefónico');
INSERT INTO medio_recepcion (mrec_codi, mrec_desc) VALUES (0, 'No especificado');


--
-- TOC entry 2947 (class 0 OID 17763)
-- Dependencies: 199
-- Data for Name: municipio; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (537, 15, 'PAZ DE RIO', 1, 170, NULL, 268, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (599, 54, 'RAGONVALIA', 1, 170, NULL, 807, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (720, 68, 'SANTA HELENA DEL OPON', 1, 170, NULL, 920, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (675, 23, 'SAN BERNARDO DEL VIENTO', 1, 170, NULL, 453, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (224, 52, 'CUASPUD', 1, 170, NULL, 727, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (745, 47, 'SITIONUEVO', 1, 170, NULL, 682, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (221, 70, 'COVENAS', 1, 170, NULL, 937, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 99, 'PUERTO CARRENO', 1, 170, NULL, 1101, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (307, 68, 'GIRON (SAN JUAN DE)', 1, 170, NULL, 880, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (569, 86, 'PUERTO CAICEDO', 1, 170, NULL, 1080, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (427, 52, 'MAGUI', 1, 170, NULL, 751, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (645, 25, 'S.ANTONIO TEQUENDAMA', 1, 170, NULL, 534, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (138, 5, 'CANASGORDAS', 1, 170, NULL, 30, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (570, 47, 'PUEBLOVIEJO', 1, 170, NULL, 674, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (753, 18, 'SAN VICENTE DEL CAGUAN', 1, 170, NULL, 360, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (99, 27, 'BOJAYA', 1, 170, NULL, 581, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (576, 5, 'PUEBLORRICO', 1, 170, NULL, 80, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (541, 5, 'PENOL', 1, 170, NULL, 78, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (250, 27, 'EL LITORAL DEL SAN JUAN', 1, 170, NULL, 587, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (25, 27, 'ALTO BAUDO', 1, 170, NULL, 576, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (75, 27, 'BAHIA SOLANO', 1, 170, NULL, 579, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (662, 25, 'SAN JUAN DE RIO SECO', 1, 170, NULL, 538, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (692, 47, 'SAN SEBASTIAN BUENAVISTA', 1, 170, NULL, 678, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (94, 18, 'BELEN DE LOS ANDAQUIES', 1, 170, NULL, 350, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (381, 52, 'LA FLORIDA', 1, 170, NULL, 744, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (258, 52, 'EL TABLON', 1, 170, NULL, 734, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (893, 5, 'YONDO', 1, 170, NULL, 126, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (0, 0, 'No Existe', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 8, 'BARRANQUILLA', 1, 170, NULL, 128, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (873, 5, 'VIGIA DEL FUERTE', 1, 170, NULL, 122, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (809, 5, 'TITIRIBI', 1, 170, NULL, 113, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (667, 5, 'SAN RAFAEL', 1, 170, NULL, 100, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (647, 5, 'SAN ANDRES', 1, 170, NULL, 91, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (656, 5, 'SAN JERONIMO', 1, 170, NULL, 94, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (440, 5, 'MARINILLA', 1, 170, NULL, 70, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (475, 5, 'MURINDO', 1, 170, NULL, 72, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (483, 5, 'NARINO', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (817, 25, 'TOCANCIPA', 1, 170, NULL, 558, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (862, 25, 'VERGARA', 1, 170, NULL, 565, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (873, 25, 'VILLAPINZON', 1, 170, NULL, 568, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (455, 15, 'MIRAFLORES', 1, 170, NULL, 251, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (469, 15, 'MONIQUIRA', 1, 170, NULL, 254, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (511, 15, 'PACHAVITA', 1, 170, NULL, 261, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (238, 15, 'DUITAMA', 1, 170, NULL, 229, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (248, 15, 'EL ESPINO', 1, 170, NULL, 231, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (276, 15, 'FLORESTA', 1, 170, NULL, 233, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (332, 15, 'GUICAN', 1, 170, NULL, 240, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (367, 15, 'JENESANO', 1, 170, NULL, 242, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (172, 15, 'CHINAVITA', 1, 170, NULL, 213, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (180, 15, 'CHISCAS', 1, 170, NULL, 215, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (189, 15, 'CIENEGA', 1, 170, NULL, 219, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (327, 68, 'GUEPSA', 1, 170, NULL, 885, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (271, 68, 'FLORIAN', 1, 170, NULL, 876, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (209, 68, 'CONFINES', 1, 170, NULL, 866, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (81, 68, 'BARRANCABERMEJA', 1, 170, NULL, 851, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (170, 66, 'DOSQUEBRADAS', 1, 170, NULL, 835, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (190, 63, 'CIRCASIA', 1, 170, NULL, 822, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (175, 25, 'CHIA', 1, 170, NULL, 473, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (224, 25, 'CUCUNUBA', 1, 170, NULL, 479, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (40, 25, 'ANOLAIMA', 1, 170, NULL, 461, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (148, 25, 'CAPARRAPI', 1, 170, NULL, 469, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (83, 52, 'BELEN', 1, 170, NULL, 202, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (370, 50, 'LA URIBE', 1, 170, NULL, 702, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (711, 50, 'VISTA HERMOSA', 1, 170, NULL, 714, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (300, 80, 'LA PAZ', 1, 173, NULL, 891, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (245, 50, 'EL CALVARIO', 1, 170, NULL, 693, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (287, 50, 'FUENTE DE ORO', 1, 170, NULL, 696, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (318, 47, 'GUAMAL', 1, 170, NULL, 668, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (551, 47, 'PIVIJAY', 1, 170, NULL, 672, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (53, 47, 'ARACATACA', 1, 170, NULL, 658, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (874, 44, 'VILLANUEVA', 1, 170, NULL, 196, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (585, 19, 'PURACE', 1, 170, NULL, 391, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (693, 19, 'SAN SEBASTIAN', 1, 170, NULL, 393, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (513, 19, 'PADILLA', 1, 170, NULL, 385, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (318, 19, 'GUAPI', 1, 170, NULL, 376, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (110, 19, 'BUENOS AIRES', 1, 170, NULL, 369, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (50, 19, 'ARGELIA', 1, 170, NULL, 16, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 19, 'POPAYAN', 1, 170, NULL, 364, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 18, 'FLORENCIA', 1, 170, NULL, 348, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (256, 18, 'EL PAUJIL', 1, 170, NULL, 354, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (460, 18, 'MILAN', 1, 170, NULL, 356, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (442, 17, 'MARMATO', 1, 170, NULL, 331, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (444, 17, 'MARQUETALIA', 1, 170, NULL, 332, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (524, 17, 'PALESTINA', 1, 170, NULL, 337, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (372, 8, 'JUAN DE ACOSTA', 1, 170, NULL, 133, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (520, 8, 'PALMAR DE VARELA', 1, 170, NULL, 137, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (560, 8, 'PONEDERA', 1, 170, NULL, 140, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (244, 13, 'EL CARMEN DE BOLIVAR', 1, 170, NULL, 165, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (109, 76, 'BUENAVENTURA', 1, 170, NULL, 1013, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (54, 76, 'ARGELIA', 1, 170, NULL, 16, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (31, 5, 'AMALFI', 1, 170, NULL, 7, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (38, 5, 'ANGOSTURA', 1, 170, NULL, 10, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (59, 5, 'ARMENIA', 1, 170, NULL, 17, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (497, 76, 'OBANDO', 1, 170, NULL, 1032, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (147, 76, 'CARTAGO', 1, 170, NULL, 1019, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (204, 70, 'COLOSO', 1, 170, NULL, 935, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (283, 73, 'FRESNO', 1, 170, NULL, 977, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (551, 41, 'PITALITO', 1, 170, NULL, 628, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (797, 41, 'TESALIA', 1, 170, NULL, 635, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (418, 54, 'LOURDES', 1, 170, NULL, 801, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (660, 54, 'SALAZAR', 1, 170, NULL, 808, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (347, 54, 'HERRAN', 1, 170, NULL, 796, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (99, 54, 'BOCHALEMA', 1, 170, NULL, 782, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (854, 5, 'VALDIVIA', 1, 170, NULL, 118, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (665, 5, 'SAN PEDRO DE URABA', 1, 170, NULL, 99, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (652, 5, 'SAN FRANCISCO', 1, 170, NULL, 93, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (769, 25, 'SUBACHOQUE', 1, 170, NULL, 546, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (513, 25, 'PACHO', 1, 170, NULL, 522, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (761, 15, 'SOMONDOCO', 1, 170, NULL, 296, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (646, 15, 'SAMACA', 1, 170, NULL, 278, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (667, 15, 'SAN LUIS DE GACENO', 1, 170, NULL, 281, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (114, 15, 'BUSBANZA', 1, 170, NULL, 209, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (667, 13, 'SAN MARTIN DE LOBA', 1, 170, NULL, 185, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (745, 68, 'SIMACOTA', 1, 170, NULL, 921, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (468, 68, 'MOLAGAVITA', 1, 170, NULL, 898, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 68, 'BUCARAMANGA', 1, 170, NULL, 845, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (88, 66, 'BELEN DE UMBRIA', 1, 170, NULL, 834, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (290, 25, 'FUSAGASUGA', 1, 170, NULL, 488, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (74, 13, 'BARRANCO DE LOBA', 1, 170, NULL, 159, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (672, 23, 'SAN ANTERO', 1, 170, NULL, 452, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (233, 52, 'CUMBITARA', 1, 170, NULL, 729, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (313, 50, 'GRANADA', 1, 170, NULL, 54, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (350, 50, 'LA MACARENA', 1, 170, NULL, 701, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (660, 47, 'SABANAS DE SAN ANGEL', 1, 170, NULL, 676, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (450, 27, 'MEDIO SAN JUAN', 1, 170, NULL, 593, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (580, 27, 'RIO ORO', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (495, 17, 'NORCASIA', 1, 170, NULL, 335, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (568, 86, 'PUERTO ASIS', 1, 170, NULL, 1079, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (219, 86, 'COLON', 1, 170, NULL, 1076, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (571, 86, 'PUERTO GUZMAN', 1, 170, NULL, 1081, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (749, 86, 'SIBUNDOY', 1, 170, NULL, 1083, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (755, 86, 'SAN FRANCISCO', 1, 170, NULL, 93, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (885, 86, 'VILLAGARZON', 1, 170, NULL, 1088, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 88, 'SAN ANDRES', 1, 170, NULL, 91, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (263, 85, 'PORE', 1, 170, NULL, 1066, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (279, 85, 'RECETOR', 1, 170, NULL, 1067, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (300, 85, 'SABANALARGA', 1, 170, NULL, 144, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (400, 85, 'TAMARA', 1, 170, NULL, 1071, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (410, 85, 'TAURAMENA', 1, 170, NULL, 1072, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (440, 85, 'VILLANUEVA', 1, 170, NULL, 196, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 86, 'MOCOA', 1, 170, NULL, 1075, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (225, 85, 'NUNCHIA', 1, 170, NULL, 1063, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (250, 85, 'PAZ DE ARIPORO', 1, 170, NULL, 1065, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (15, 85, 'CHAMEZA', 1, 170, NULL, 1058, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (136, 85, 'LA SALINA', 1, 170, NULL, 1060, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (139, 85, 'MANI', 1, 170, NULL, 1061, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (220, 81, 'CRAVO NORTE', 1, 170, NULL, 1051, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (591, 81, 'PUERTO RONDON', 1, 170, NULL, 1053, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (736, 81, 'SARAVENA', 1, 170, NULL, 1054, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (869, 76, 'VIJES', 1, 170, NULL, 1045, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (890, 76, 'YOTOCO', 1, 170, NULL, 1046, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (895, 76, 'ZARZAL', 1, 170, NULL, 1048, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (834, 76, 'TULUA', 1, 170, NULL, 1042, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (845, 76, 'ULLOA', 1, 170, NULL, 1043, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (670, 76, 'SAN PEDRO', 1, 170, NULL, 98, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (563, 76, 'PRADERA', 1, 170, NULL, 1034, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (606, 76, 'RESTREPO', 1, 170, NULL, 709, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (520, 76, 'PALMIRA', 1, 170, NULL, 1033, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (318, 76, 'GUACARI', 1, 170, NULL, 1027, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (364, 76, 'JAMUNDI', 1, 170, NULL, 1028, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (246, 76, 'EL CAIRO', 1, 170, NULL, 1022, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (275, 76, 'FLORIDA', 1, 170, NULL, 1025, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (233, 76, 'DAGUA', 1, 170, NULL, 1020, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (243, 76, 'EL AGUILA', 1, 170, NULL, 1021, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (111, 76, 'BUGA', 1, 170, NULL, 1014, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (110, 70, 'BUENAVISTA', 1, 170, NULL, 208, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (124, 70, 'CAIMITO', 1, 170, NULL, 934, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (215, 70, 'COROZAL', 1, 170, NULL, 936, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (230, 70, 'CHALAN', 1, 170, NULL, 938, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (780, 68, 'SURATA', 1, 170, NULL, 925, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (820, 68, 'TONA', 1, 170, NULL, 926, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (861, 68, 'VELEZ', 1, 170, NULL, 928, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (872, 68, 'VILLANUEVA', 1, 170, NULL, 196, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (895, 68, 'ZAPATOCA', 1, 170, NULL, 931, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 70, 'SINCELEJO', 1, 170, NULL, 932, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (675, 73, 'SAN ANTONIO', 1, 170, NULL, 998, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (678, 73, 'SAN LUIS', 1, 170, NULL, 97, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (770, 73, 'SUAREZ', 1, 170, NULL, 398, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (873, 73, 'VILLARRICA', 1, 170, NULL, 1005, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 76, 'CALI', 1, 170, NULL, 1006, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (616, 73, 'RIOBLANCO', 1, 170, NULL, 994, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (411, 73, 'LIBANO', 1, 170, NULL, 983, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (461, 73, 'MURILLO', 1, 170, NULL, 986, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (504, 73, 'ORTEGA', 1, 170, NULL, 988, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (319, 73, 'GUAMO', 1, 170, NULL, 978, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (168, 73, 'CHAPARRAL', 1, 170, NULL, 969, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (217, 73, 'COYAIMA', 1, 170, NULL, 971, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (270, 73, 'FALAN', 1, 170, NULL, 975, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (43, 73, 'ANZOATEGUI', 1, 170, NULL, 963, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (279, 44, 'FONSECA', 1, 170, NULL, 647, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (430, 44, 'MAICAO', 1, 170, NULL, 650, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 44, 'RIOHACHA', 1, 170, NULL, 641, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (78, 44, 'BARRANCAS', 1, 170, NULL, 643, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (676, 41, 'SANTA MARIA', 1, 170, NULL, 286, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (871, 54, 'VILLA CARO', 1, 170, NULL, 817, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (865, 86, 'VALLE GUAMUEZ', 1, 170, NULL, 1087, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (671, 73, 'SALDANA', 1, 170, NULL, 997, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (298, 41, 'GARZON', 1, 170, NULL, 614, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (349, 41, 'HOBO', 1, 170, NULL, 617, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (483, 41, 'NATAGA', 1, 170, NULL, 622, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (548, 41, 'PITAL', 1, 170, NULL, 627, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (6, 41, 'ACEVEDO', 1, 170, NULL, 605, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (16, 41, 'AIPE', 1, 170, NULL, 607, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (244, 41, 'ELIAS', 1, 170, NULL, 613, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (745, 27, 'SIPI', 1, 170, NULL, 600, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (800, 27, 'UNGUIA', 1, 170, NULL, 602, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (820, 70, 'TOLU', 1, 170, NULL, 956, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (742, 70, 'SINCE', 1, 170, NULL, 954, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (523, 70, 'PALMITO', 1, 170, NULL, 947, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (400, 70, 'LA UNION', 1, 170, NULL, 67, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (429, 70, 'MAJAGUAL', 1, 170, NULL, 944, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (508, 70, 'OVEJAS', 1, 170, NULL, 946, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (413, 27, 'LLORO', 1, 170, NULL, 590, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (495, 27, 'NUQUI', 1, 170, NULL, 595, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (800, 54, 'TEORAMA', 1, 170, NULL, 814, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (810, 54, 'TIBU', 1, 170, NULL, 815, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (261, 54, 'EL ZULIA', 1, 170, NULL, 793, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (377, 54, 'LABATECA', 1, 170, NULL, 797, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (109, 54, 'BUCARASICA', 1, 170, NULL, 783, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (172, 54, 'CHINACOTA', 1, 170, NULL, 786, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (838, 52, 'TUQUERRES', 1, 170, NULL, 777, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (788, 52, 'TANGUA', 1, 170, NULL, 775, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (835, 52, 'TUMACO', 1, 170, NULL, 776, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (687, 52, 'SAN LORENZO', 1, 170, NULL, 768, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (693, 52, 'SAN PABLO', 1, 170, NULL, 186, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (612, 52, 'RICAURTE', 1, 170, NULL, 533, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (473, 52, 'MOSQUERA', 1, 170, NULL, 515, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (560, 52, 'POTOSI', 1, 170, NULL, 759, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (399, 52, 'LA UNION', 1, 170, NULL, 67, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (405, 52, 'LEIVA', 1, 170, NULL, 748, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (354, 52, 'IMUES', 1, 170, NULL, 741, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (378, 52, 'LA CRUZ', 1, 170, NULL, 743, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (320, 52, 'GUAITARILLA', 1, 170, NULL, 738, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (890, 5, 'YOLOMBO', 1, 170, NULL, 125, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (847, 5, 'URRAO', 1, 170, NULL, 117, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (856, 5, 'VALPARAISO', 1, 170, NULL, 119, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (837, 5, 'TURBO', 1, 170, NULL, 115, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (842, 5, 'URAMITA', 1, 170, NULL, 116, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (679, 5, 'SANTA BARBARA', 1, 170, NULL, 103, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (649, 5, 'SAN CARLOS', 1, 170, NULL, 92, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (664, 5, 'SAN PEDRO', 1, 170, NULL, 98, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (591, 5, 'PUERTO TRIUNFO', 1, 170, NULL, 83, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (607, 5, 'RETIRO', 1, 170, NULL, 85, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (631, 5, 'SABANETA', 1, 170, NULL, 89, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (411, 5, 'LIBORINA', 1, 170, NULL, 68, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (480, 5, 'MUTATA', 1, 170, NULL, 73, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (543, 5, 'PEQUE', 1, 170, NULL, 79, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (898, 25, 'ZIPACON', 1, 170, NULL, 572, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (815, 25, 'TOCAIMA', 1, 170, NULL, 557, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (823, 25, 'TOPAIPI', 1, 170, NULL, 559, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (878, 25, 'VIOTA', 1, 170, NULL, 570, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (885, 25, 'YACOPI', 1, 170, NULL, 571, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (718, 25, 'SASAIMA', 1, 170, NULL, 539, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (92, 27, 'CARMEN DEL DARIEN', 1, 170, NULL, 583, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (42, 27, 'MEDIO BAUDO', 1, 170, NULL, 592, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (777, 25, 'SUPATA', 1, 170, NULL, 548, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (785, 25, 'TABIO', 1, 170, NULL, 551, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (109, 27, 'RIO IRO', 1, 170, NULL, 596, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (491, 25, 'NOCAIMA', 1, 170, NULL, 520, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (506, 25, 'VENECIA', 1, 170, NULL, 121, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (530, 25, 'PARATEBUENO', 1, 170, NULL, 525, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (592, 25, 'QUEBRADANEGRA', 1, 170, NULL, 529, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (594, 25, 'QUETAME', 1, 170, NULL, 530, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (599, 25, 'APULO', 1, 170, NULL, 532, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (649, 25, 'SAN BERNARDO', 1, 170, NULL, 535, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (653, 25, 'SAN CAYETANO', 1, 170, NULL, 536, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (335, 25, 'GUAYABETAL', 1, 170, NULL, 501, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (339, 25, 'GUTIERREZ', 1, 170, NULL, 502, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (368, 25, 'JERUSALEN', 1, 170, NULL, 503, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (372, 25, 'JUNIN', 1, 170, NULL, 504, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (386, 25, 'LA MESA', 1, 170, NULL, 506, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (402, 25, 'LA VEGA', 1, 170, NULL, 380, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (430, 25, 'MADRID', 1, 170, NULL, 512, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (436, 25, 'MANTA', 1, 170, NULL, 513, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (438, 25, 'MEDINA', 1, 170, NULL, 514, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (483, 25, 'NARINO', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (488, 25, 'NILO', 1, 170, NULL, 518, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (814, 15, 'TOCA', 1, 170, NULL, 309, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (816, 15, 'TOGUI', 1, 170, NULL, 310, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (832, 15, 'TUNUNGUA', 1, 170, NULL, 313, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (835, 15, 'TURMEQUE', 1, 170, NULL, 314, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (837, 15, 'TUTA', 1, 170, NULL, 315, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (861, 15, 'VENTAQUEMADA', 1, 170, NULL, 318, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (897, 15, 'ZETAQUIRA', 1, 170, NULL, 320, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 17, 'MANIZALES', 1, 170, NULL, 321, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (42, 17, 'ANSERMA', 1, 170, NULL, 323, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (690, 15, 'SANTA MARIA', 1, 170, NULL, 286, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (693, 15, 'SANTA ROSA DE VITERBO', 1, 170, NULL, 287, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (723, 15, 'SATIVASUR', 1, 170, NULL, 290, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (740, 15, 'SIACHOQUE', 1, 170, NULL, 291, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (753, 15, 'SOATA', 1, 170, NULL, 292, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (755, 15, 'SOCOTA', 1, 170, NULL, 293, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (762, 15, 'SORA', 1, 170, NULL, 297, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (774, 15, 'SUSACON', 1, 170, NULL, 300, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (776, 15, 'SUTAMARCHAN', 1, 170, NULL, 301, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (790, 15, 'TASCO', 1, 170, NULL, 303, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (808, 15, 'TINJACA', 1, 170, NULL, 307, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (810, 15, 'TIPACOQUE', 1, 170, NULL, 308, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (522, 15, 'PANQUEBA', 1, 170, NULL, 265, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (599, 15, 'RAMIRIQUI', 1, 170, NULL, 273, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (632, 15, 'SABOYA', 1, 170, NULL, 276, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (638, 15, 'SACHICA', 1, 170, NULL, 277, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (664, 15, 'SAN JOSE DE PARE', 1, 170, NULL, 280, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (676, 15, 'SAN MIGUEL DE SEMA', 1, 170, NULL, 283, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (681, 15, 'SAN PABLO DE BORBUR', 1, 170, NULL, 284, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (403, 15, 'LA UVITA', 1, 170, NULL, 247, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (407, 15, 'VILLA DE LEYVA', 1, 170, NULL, 248, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (442, 15, 'MARIPI', 1, 170, NULL, 250, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (466, 15, 'MONGUI', 1, 170, NULL, 253, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (476, 15, 'MOTAVITA', 1, 170, NULL, 255, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (135, 27, 'CANTON DEL SAN PABLO', 1, 170, NULL, 582, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (398, 25, 'LA PENA', 1, 170, NULL, 508, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (550, 15, 'PISVA', 1, 170, NULL, 270, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (507, 15, 'OTANCHE', 1, 170, NULL, 260, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (514, 15, 'PAEZ', 1, 170, NULL, 262, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (516, 15, 'PAIPA', 1, 170, NULL, 263, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (244, 15, 'EL COCUY', 1, 170, NULL, 230, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (272, 15, 'FIRAVITOBA', 1, 170, NULL, 232, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (299, 15, 'GARAGOA', 1, 170, NULL, 236, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (325, 15, 'GUAYATA', 1, 170, NULL, 239, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (368, 15, 'JERICO', 1, 170, NULL, 243, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (380, 15, 'LA CAPILLA', 1, 170, NULL, 245, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (183, 15, 'CHITA', 1, 170, NULL, 216, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (187, 15, 'CHIVATA', 1, 170, NULL, 218, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (204, 15, 'COMBITA', 1, 170, NULL, 220, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (218, 15, 'COVARACHIA', 1, 170, NULL, 223, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (894, 13, 'ZAMBRANO', 1, 170, NULL, 197, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (92, 15, 'BETEITIVA', 1, 170, NULL, 204, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (131, 15, 'CALDAS', 1, 170, NULL, 210, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (670, 13, 'SAN PABLO', 1, 170, NULL, 186, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (600, 13, 'RIO VIEJO', 1, 170, NULL, 178, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (647, 13, 'SAN ESTANISLAO', 1, 170, NULL, 180, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (654, 13, 'SAN JACINTO', 1, 170, NULL, 182, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (88, 5, 'BELLO', 1, 170, NULL, 20, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (113, 5, 'BURITICA', 1, 170, NULL, 25, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (125, 5, 'CAICEDO', 1, 170, NULL, 27, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (321, 5, 'GUATAPE', 1, 170, NULL, 57, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (368, 5, 'JERICO', 1, 170, NULL, 243, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (380, 5, 'LA ESTRELLA', 1, 170, NULL, 65, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (264, 5, 'ENTRERRIOS', 1, 170, NULL, 47, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (306, 5, 'GIRALDO', 1, 170, NULL, 51, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (315, 5, 'GUADALUPE', 1, 170, NULL, 55, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (209, 5, 'CONCORDIA', 1, 170, NULL, 41, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (234, 5, 'DABEIBA', 1, 170, NULL, 43, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (240, 5, 'EBEJICO', 1, 170, NULL, 45, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (145, 5, 'CARAMANTA', 1, 170, NULL, 32, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (150, 5, 'CAROLINA', 1, 170, NULL, 35, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (705, 68, 'SANTA BARBARA', 1, 170, NULL, 103, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (673, 68, 'SAN BENITO', 1, 170, NULL, 913, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (524, 99, 'LA PRIMAVERA', 1, 170, NULL, 1102, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (573, 68, 'PUERTO PARRA', 1, 170, NULL, 908, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (464, 68, 'MOGOTES', 1, 170, NULL, 897, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (502, 68, 'ONZAGA', 1, 170, NULL, 901, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (533, 68, 'PARAMO', 1, 170, NULL, 904, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (385, 68, 'LANDAZURI', 1, 170, NULL, 890, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (406, 68, 'LEBRIJA', 1, 170, NULL, 892, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (425, 68, 'MACARAVITA', 1, 170, NULL, 894, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (320, 68, 'GUADALUPE', 1, 170, NULL, 55, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (324, 68, 'GUAVATA', 1, 170, NULL, 884, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (344, 68, 'HATO', 1, 170, NULL, 886, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (255, 68, 'EL PLAYON', 1, 170, NULL, 873, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (266, 68, 'ENCISO', 1, 170, NULL, 875, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (276, 68, 'FLORIDABLANCA', 1, 170, NULL, 877, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (207, 68, 'CONCEPCION', 1, 170, NULL, 40, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (211, 68, 'CONTRATACION', 1, 170, NULL, 867, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (229, 68, 'CURITI', 1, 170, NULL, 869, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (101, 68, 'BOLIVAR', 1, 170, NULL, 368, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (121, 68, 'CABRERA', 1, 170, NULL, 466, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (687, 66, 'SANTUARIO', 1, 170, NULL, 106, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (20, 68, 'ALBANIA', 1, 170, NULL, 349, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (456, 66, 'MISTRATO', 1, 170, NULL, 840, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (45, 66, 'APIA', 1, 170, NULL, 832, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (318, 66, 'GUATICA', 1, 170, NULL, 836, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (401, 63, 'LA TEBAIDA', 1, 170, NULL, 826, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (594, 63, 'QUIMBAYA', 1, 170, NULL, 829, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (111, 63, 'BUENAVISTA', 1, 170, NULL, 208, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (293, 25, 'GACHALA', 1, 170, NULL, 489, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (299, 25, 'GAMA', 1, 170, NULL, 492, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (320, 25, 'GUADUAS', 1, 170, NULL, 496, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (168, 25, 'CHAGUANI', 1, 170, NULL, 472, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (181, 25, 'CHOACHI', 1, 170, NULL, 475, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (214, 25, 'COTA', 1, 170, NULL, 478, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (269, 25, 'FACATATIVA', 1, 170, NULL, 483, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (281, 25, 'FOSCA', 1, 170, NULL, 485, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (288, 25, 'FUQUENE', 1, 170, NULL, 487, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (53, 25, 'ARBELAEZ', 1, 170, NULL, 462, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (95, 25, 'BITUIMA', 1, 170, NULL, 464, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (126, 25, 'CAJICA', 1, 170, NULL, 468, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (807, 23, 'TIERRALTA', 1, 170, NULL, 456, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (686, 23, 'SAN PELAYO', 1, 170, NULL, 455, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (174, 17, 'CHINCHINA', 1, 170, NULL, 326, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (433, 17, 'MANZANARES', 1, 170, NULL, 330, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 95, 'SAN JOSE DEL GUAVIARE', 1, 170, NULL, 1094, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (15, 95, 'CALAMAR', 1, 170, NULL, 160, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (140, 13, 'CALAMAR', 1, 170, NULL, 160, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (212, 13, 'CORDOBA', 1, 170, NULL, 163, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (638, 8, 'SABANALARGA', 1, 170, NULL, 144, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (675, 8, 'SANTA LUCIA', 1, 170, NULL, 145, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (685, 8, 'SANTO TOMAS', 1, 170, NULL, 146, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (849, 8, 'USIACURI', 1, 170, NULL, 150, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 13, 'CARTAGENA', 1, 170, NULL, 153, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (6, 13, 'ACHI', 1, 170, NULL, 154, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (580, 23, 'PUERTO LIBERTADOR', 1, 170, NULL, 448, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (660, 23, 'SAHAGUN', 1, 170, NULL, 450, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (555, 23, 'PLANETA RICA', 1, 170, NULL, 445, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (570, 23, 'PUEBLO NUEVO', 1, 170, NULL, 446, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (466, 23, 'MONTELIBANO', 1, 170, NULL, 443, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (168, 23, 'CHIMA', 1, 170, NULL, 435, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (189, 23, 'CIENAGA DE ORO', 1, 170, NULL, 437, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (417, 23, 'LORICA', 1, 170, NULL, 440, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (750, 20, 'SAN DIEGO', 1, 170, NULL, 427, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (770, 20, 'SAN MARTIN', 1, 170, NULL, 428, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 23, 'MONTERIA', 1, 170, NULL, 430, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (79, 23, 'BUENAVISTA', 1, 170, NULL, 208, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (310, 20, 'GONZALEZ', 1, 170, NULL, 417, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (550, 20, 'PELAYA', 1, 170, NULL, 422, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (621, 20, 'LA PAZ', 1, 170, NULL, 891, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (710, 20, 'SAN ALBERTO', 1, 170, NULL, 426, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (175, 20, 'CHIMICHAGUA', 1, 170, NULL, 411, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (178, 20, 'CHIRIGUANA', 1, 170, NULL, 412, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (228, 20, 'CURUMANI', 1, 170, NULL, 413, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 20, 'VALLEDUPAR', 1, 170, NULL, 405, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (13, 20, 'AGUSTIN CODAZZI', 1, 170, NULL, 407, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 94, 'INIRIDA', 1, 170, NULL, 1093, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (500, 23, 'MONITOS', 1, 170, NULL, 444, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (443, 20, 'MANAURE BALCON DL CESAR', 1, 170, NULL, 420, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (807, 19, 'TIMBIO', 1, 170, NULL, 400, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (824, 19, 'TOTORO', 1, 170, NULL, 403, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (743, 19, 'SILVIA', 1, 170, NULL, 396, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (215, 52, 'CORDOBA', 1, 170, NULL, 163, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (250, 52, 'EL CHARCO', 1, 170, NULL, 731, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (51, 52, 'ARBOLEDA', 1, 170, NULL, 719, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (203, 52, 'COLON', 1, 170, NULL, 1076, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (400, 50, 'LEJANIAS', 1, 170, NULL, 703, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (590, 50, 'PUERTO RICO', 1, 170, NULL, 358, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (686, 50, 'SAN JUANITO', 1, 170, NULL, 712, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (150, 50, 'CASTILLA LA NUEVA', 1, 170, NULL, 690, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (226, 50, 'CUMARAL', 1, 170, NULL, 692, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (251, 50, 'EL CASTILLO', 1, 170, NULL, 694, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (707, 47, 'SANTA ANA', 1, 170, NULL, 680, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (288, 47, 'FUNDACION', 1, 170, NULL, 667, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (555, 47, 'PLATO', 1, 170, NULL, 673, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (855, 44, 'URUMITA', 1, 170, NULL, 654, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (134, 27, 'BELEN DE BAJIRA', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (573, 19, 'PUERTO TEJADA', 1, 170, NULL, 390, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (473, 19, 'MORALES', 1, 170, NULL, 175, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (517, 19, 'PAEZ', 1, 170, NULL, 262, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (290, 19, 'FLORENCIA', 1, 170, NULL, 348, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (130, 19, 'CAJIBIO', 1, 170, NULL, 370, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (142, 19, 'CALOTO', 1, 170, NULL, 372, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (100, 19, 'BOLIVAR', 1, 170, NULL, 368, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (860, 18, 'VALPARAISO', 1, 170, NULL, 119, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (877, 17, 'VITERBO', 1, 170, NULL, 347, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (247, 18, 'EL DONCELLO', 1, 170, NULL, 353, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (616, 17, 'RISARALDA', 1, 170, NULL, 340, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (662, 17, 'SAMANA', 1, 170, NULL, 342, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (777, 17, 'SUPIA', 1, 170, NULL, 344, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (513, 17, 'PACORA', 1, 170, NULL, 336, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (614, 17, 'RIOSUCIO', 1, 170, NULL, 339, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (141, 8, 'CANDELARIA', 1, 170, NULL, 131, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (436, 8, 'MANATI', 1, 170, NULL, 136, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (549, 8, 'PIOJO', 1, 170, NULL, 138, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (433, 13, 'MAHATES', 1, 170, NULL, 170, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (473, 13, 'MORALES', 1, 170, NULL, 175, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (430, 13, 'MAGANGUE', 1, 170, NULL, 169, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (100, 76, 'BOLIVAR', 1, 170, NULL, 368, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (20, 76, 'ALCALA', 1, 170, NULL, 1008, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (21, 5, 'ALEJANDRIA', 1, 170, NULL, 5, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (34, 5, 'ANDES', 1, 170, NULL, 8, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (40, 5, 'ANORI', 1, 170, NULL, 11, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (55, 5, 'ARGELIA', 1, 170, NULL, 16, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (306, 76, 'GINEBRA', 1, 170, NULL, 1026, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (248, 76, 'EL CERRITO', 1, 170, NULL, 1023, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (113, 76, 'BUGALAGRANDE', 1, 170, NULL, 1015, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (560, 44, 'MANAURE', 1, 170, NULL, 420, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (801, 41, 'TERUEL', 1, 170, NULL, 637, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (668, 41, 'SAN AGUSTIN', 1, 170, NULL, 631, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (396, 41, 'LA PLATA', 1, 170, NULL, 621, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (250, 54, 'EL TARRA', 1, 170, NULL, 792, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (405, 54, 'LOS PATIOS', 1, 170, NULL, 800, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (786, 52, 'TAMINANGO', 1, 170, NULL, 774, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (887, 5, 'YARUMAL', 1, 170, NULL, 124, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (819, 5, 'TOLEDO', 1, 170, NULL, 114, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (686, 5, 'SANTA ROSA DE OSOS', 1, 170, NULL, 104, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (875, 25, 'VILLETA', 1, 170, NULL, 569, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (740, 25, 'SIBATE', 1, 170, NULL, 541, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (781, 25, 'SUTATAUSA', 1, 170, NULL, 550, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (524, 25, 'PANDI', 1, 170, NULL, 524, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (764, 15, 'SORACA', 1, 170, NULL, 299, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (531, 15, 'PAUNA', 1, 170, NULL, 266, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (621, 15, 'RONDON', 1, 170, NULL, 275, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (185, 15, 'CHITARAQUE', 1, 170, NULL, 217, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (212, 15, 'COPER', 1, 170, NULL, 221, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (47, 15, 'AQUITANIA', 1, 170, NULL, 200, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (744, 13, 'SIMITI', 1, 170, NULL, 190, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (549, 13, 'PINILLOS', 1, 170, NULL, 176, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (684, 68, 'SAN JOSE DE MIRANDA', 1, 170, NULL, 916, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (615, 68, 'RIONEGRO', 1, 170, NULL, 86, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (522, 68, 'PALMAR', 1, 170, NULL, 902, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (594, 66, 'QUINCHIA', 1, 170, NULL, 842, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (302, 63, 'GENOVA', 1, 170, NULL, 825, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (548, 63, 'PIJAO', 1, 170, NULL, 828, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (88, 17, 'BELALCAZAR', 1, 170, NULL, 325, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (758, 8, 'SOLEDAD', 1, 170, NULL, 147, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (586, 23, 'PURISIMA', 1, 170, NULL, 449, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (210, 52, 'CONTADERO', 1, 170, NULL, 725, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (110, 52, 'BUESACO', 1, 170, NULL, 722, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (568, 50, 'PUERTO GAITAN', 1, 170, NULL, 705, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (680, 50, 'SAN CARLOS DE GUAROA', 1, 170, NULL, 710, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (355, 19, 'INZA', 1, 170, NULL, 377, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (256, 19, 'EL TAMBO', 1, 170, NULL, 374, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (137, 19, 'CALDONO', 1, 170, NULL, 371, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (75, 19, 'BALBOA', 1, 170, NULL, 367, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (29, 18, 'ALBANIA', 1, 170, NULL, 349, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (205, 18, 'CURILLO', 1, 170, NULL, 352, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (2, 5, 'ABEJORRAL', 1, 170, NULL, 2, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (30, 5, 'AMAGA', 1, 170, NULL, 6, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (42, 5, 'SANTAFE DE ANTIOQUIA', 1, 170, NULL, 12, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (79, 5, 'BARBOSA', 1, 170, NULL, 18, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (889, 97, 'YAVARATE', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (572, 99, 'SANTA RITA', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (263, 91, 'EL ENCANTO', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (405, 91, 'LA CHORRERA', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (407, 91, 'LA PEDRERA', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (798, 91, 'TARAPACA', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (343, 94, 'GUAVIARE', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (883, 94, 'SAN FELIPE', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (884, 94, 'PUERTO COLOMBIA', 1, 170, NULL, 141, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (885, 94, 'LA GUADALUPE', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (161, 97, 'CARURU', 1, 170, NULL, 1099, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (511, 97, 'PACOA', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (777, 97, 'PAPUNAUA', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (312, 25, 'GRANADA', 1, 170, NULL, 54, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (30, 13, 'ALTOS DEL ROSARIO', 1, 170, NULL, 155, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (580, 13, 'REGIDOR', 1, 170, NULL, 177, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (222, 13, 'CLEMENCIA', 1, 170, NULL, 164, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (258, 47, 'EL PINON', 1, 170, NULL, 665, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 47, 'SANTAMARTA', 1, 170, NULL, 656, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (540, 91, 'PUERTO NARINO', 1, 170, NULL, 1092, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (410, 18, 'LA MONTANITA', 1, 170, NULL, 355, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (810, 13, 'IQUISIO', 1, 170, NULL, 193, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (620, 13, 'SAN CRISTOBAL', 1, 170, NULL, 179, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (42, 13, 'ARENAL', 1, 170, NULL, 156, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (188, 13, 'CICUCO', 1, 170, NULL, 162, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (62, 13, 'ARROYOHONDO', 1, 170, NULL, 158, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (50, 27, 'ATRATO', 1, 170, NULL, 577, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (260, 25, 'EL ROSAL', 1, 170, NULL, 482, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (90, 44, 'DIBULLA', 1, 170, NULL, 644, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (98, 44, 'DISTRACCION', 1, 170, NULL, 645, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (420, 44, 'LA JAGUA DEL PILAR', 1, 170, NULL, 649, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (757, 86, 'SAN MIGUEL', 1, 170, NULL, 917, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (533, 19, 'PIAMONTE', 1, 170, NULL, 388, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (845, 19, 'VILLA RICA', 1, 170, NULL, 404, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (785, 18, 'SOLITA', 1, 170, NULL, 362, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (300, 23, 'COTORRA', 1, 170, NULL, 438, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (430, 91, 'LA VICTORIA', 1, 170, NULL, 246, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (530, 91, 'PUERTO ALEGRIA', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (570, 20, 'PUEBLO BELLO', 1, 170, NULL, 423, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (90, 5, 'LA PINTADA', 1, 170, NULL, 66, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (390, 5, 'LA PINTADA', 1, 170, NULL, 66, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (756, 18, 'SOLANO', 1, 170, NULL, 361, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (890, 97, 'VILLA FATIMA', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (891, 97, 'ACARICUARA', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (35, 44, 'ALBANIA', 1, 170, NULL, 349, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (785, 19, 'SUCRE', 1, 170, NULL, 399, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (999, 1, 'TODOS', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (160, 27, 'CERTEGUI', 1, 170, NULL, 584, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (720, 47, 'SANTA BARBARA DE PINTO', 1, 170, NULL, 681, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (30, 47, 'ALGARROBO', 1, 170, NULL, 657, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (585, 73, 'PURIFICACION', 1, 170, NULL, 993, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (443, 73, 'MARIQUITA', 1, 170, NULL, 984, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (483, 73, 'NATAGAIMA', 1, 170, NULL, 987, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (352, 73, 'ICONONZO', 1, 170, NULL, 981, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (200, 73, 'COELLO', 1, 170, NULL, 970, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (268, 73, 'ESPINAL', 1, 170, NULL, 974, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (26, 73, 'ALVARADO', 1, 170, NULL, 961, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (124, 73, 'CAJAMARCA', 1, 170, NULL, 966, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (110, 44, 'EL MOLINO', 1, 170, NULL, 646, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (615, 41, 'RIVERA', 1, 170, NULL, 629, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (660, 41, 'SALADOBLANCO', 1, 170, NULL, 630, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (791, 41, 'TARQUI', 1, 170, NULL, 634, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (378, 41, 'LA ARGENTINA', 1, 170, NULL, 620, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (518, 41, 'PAICOL', 1, 170, NULL, 624, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 41, 'NEIVA', 1, 170, NULL, 604, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (20, 41, 'ALGECIRAS', 1, 170, NULL, 608, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (78, 41, 'BARAYA', 1, 170, NULL, 610, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (660, 27, 'SAN JOSE DEL PALMAR', 1, 170, NULL, 599, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (713, 70, 'SAN ONOFRE', 1, 170, NULL, 952, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (771, 70, 'SUCRE', 1, 170, NULL, 399, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (678, 70, 'SAN BENITO ABAD', 1, 170, NULL, 949, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (708, 70, 'SAN MARCOS', 1, 170, NULL, 951, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (491, 27, 'NOVITA', 1, 170, NULL, 594, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (615, 27, 'RIOSUCIO', 1, 170, NULL, 339, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (480, 54, 'MUTISCUA', 1, 170, NULL, 802, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (520, 54, 'PAMPLONITA', 1, 170, NULL, 805, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (673, 54, 'SAN CAYETANO', 1, 170, NULL, 536, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (398, 54, 'LA PLAYA', 1, 170, NULL, 799, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (125, 54, 'CACOTA', 1, 170, NULL, 784, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (174, 54, 'CHITAGA', 1, 170, NULL, 787, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (3, 54, 'ABREGO', 1, 170, NULL, 780, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (885, 52, 'YACUANQUER', 1, 170, NULL, 778, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (683, 52, 'SANDONA', 1, 170, NULL, 766, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (685, 52, 'SAN BERNARDO', 1, 170, NULL, 535, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (621, 52, 'ROBERTO PAYAN', 1, 170, NULL, 764, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (565, 52, 'PROVIDENCIA', 1, 170, NULL, 760, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (411, 52, 'LINARES', 1, 170, NULL, 749, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (418, 52, 'LOS ANDES', 1, 170, NULL, 750, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (356, 52, 'IPIALES', 1, 170, NULL, 742, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (287, 52, 'FUNES', 1, 170, NULL, 736, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (317, 52, 'GUACHUCAL', 1, 170, NULL, 737, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (137, 8, 'CAMPO DE LA CRUZ', 1, 170, NULL, 130, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (858, 5, 'VEGACHI', 1, 170, NULL, 120, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (674, 5, 'SAN VICENTE', 1, 170, NULL, 102, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (690, 5, 'SANTO DOMINGO', 1, 170, NULL, 105, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (736, 5, 'SEGOVIA', 1, 170, NULL, 107, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (659, 5, 'SAN JUAN DE URABA', 1, 170, NULL, 96, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (615, 5, 'RIONEGRO', 1, 170, NULL, 86, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (628, 5, 'SABANALARGA', 1, 170, NULL, 144, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (495, 5, 'NECHI', 1, 170, NULL, 76, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (245, 27, 'EL CARMEN', 1, 170, NULL, 586, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (205, 27, 'CONDOTO', 1, 170, NULL, 585, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (899, 25, 'ZIPAQUIRA', 1, 170, NULL, 573, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (807, 25, 'TIBIRITA', 1, 170, NULL, 556, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (839, 25, 'UBALA', 1, 170, NULL, 560, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (843, 25, 'UBATE', 1, 170, NULL, 562, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (743, 25, 'SILVANIA', 1, 170, NULL, 542, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (772, 25, 'SUESCA', 1, 170, NULL, 547, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (779, 25, 'SUSA', 1, 170, NULL, 549, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (480, 15, 'MUZO', 1, 170, NULL, 256, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (494, 15, 'NUEVO COLON', 1, 170, NULL, 258, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (518, 15, 'PAJARITO', 1, 170, NULL, 264, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (232, 15, 'CHIQUIZA', 1, 170, NULL, 227, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (296, 15, 'GAMEZA', 1, 170, NULL, 235, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (317, 15, 'GUACAMAYAS', 1, 170, NULL, 237, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (377, 15, 'LABRANZAGRANDE', 1, 170, NULL, 244, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (162, 15, 'CERINZA', 1, 170, NULL, 212, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (215, 15, 'CORRALES', 1, 170, NULL, 222, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (224, 15, 'CUCAITA', 1, 170, NULL, 225, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (873, 13, 'VILLANUEVA', 1, 170, NULL, 196, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (22, 15, 'ALMEIDA', 1, 170, NULL, 199, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (87, 15, 'BELEN', 1, 170, NULL, 202, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (97, 15, 'BOAVITA', 1, 170, NULL, 205, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (109, 15, 'BUENAVISTA', 1, 170, NULL, 208, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (657, 13, 'SAN JUAN NEPOMUCENO', 1, 170, NULL, 184, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (760, 13, 'SOPLAVIENTO', 1, 170, NULL, 191, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (780, 13, 'TALAIGUA NUEVO', 1, 170, NULL, 192, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (650, 13, 'SAN FERNANDO', 1, 170, NULL, 181, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (86, 5, 'BELMIRA', 1, 170, NULL, 19, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (93, 5, 'BETULIA', 1, 170, NULL, 22, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (854, 73, 'VALLE DE SAN JUAN', 1, 170, NULL, 1002, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (520, 52, 'FRANCIS PIZARRO', 1, 170, NULL, 757, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (585, 5, 'PTO NARE(LAMAGDALENA)', 1, 170, NULL, 82, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (683, 13, 'SANTA ROSA NORTE', 1, 170, NULL, 188, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (107, 5, 'BRICENO', 1, 170, NULL, 24, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (120, 5, 'CACERES', 1, 170, NULL, 26, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (129, 5, 'CALDAS', 1, 170, NULL, 210, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (347, 5, 'HELICONIA', 1, 170, NULL, 58, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (360, 5, 'ITAGUI', 1, 170, NULL, 60, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (364, 5, 'JARDIN', 1, 170, NULL, 62, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (376, 5, 'LA CEJA', 1, 170, NULL, 64, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (400, 5, 'LA UNION', 1, 170, NULL, 67, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (266, 5, 'ENVIGADO', 1, 170, NULL, 48, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (284, 5, 'FRONTINO', 1, 170, NULL, 50, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (308, 5, 'GIRARDOTA', 1, 170, NULL, 52, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (313, 5, 'GRANADA', 1, 170, NULL, 54, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (318, 5, 'GUARNE', 1, 170, NULL, 56, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (206, 5, 'CONCEPCION', 1, 170, NULL, 40, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (212, 5, 'COPACABANA', 1, 170, NULL, 42, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (237, 5, 'DON MATIAS', 1, 170, NULL, 44, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (134, 5, 'CAMPAMENTO', 1, 170, NULL, 29, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (142, 5, 'CARACOLI', 1, 170, NULL, 31, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (148, 5, 'CARMEN DE VIBORAL', 1, 170, NULL, 34, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (190, 5, 'CISNEROS', 1, 170, NULL, 38, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (689, 68, 'SAN VICENTE DE CHUCURI', 1, 170, NULL, 918, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (755, 68, 'SOCORRO', 1, 170, NULL, 922, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (669, 68, 'SAN ANDRES', 1, 170, NULL, 91, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (679, 68, 'SAN GIL', 1, 170, NULL, 914, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (572, 68, 'PUENTE NACIONAL', 1, 170, NULL, 907, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (575, 68, 'PUERTO WILCHES', 1, 170, NULL, 909, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (498, 68, 'OCAMONTE', 1, 170, NULL, 899, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (549, 68, 'PINCHOTE', 1, 170, NULL, 906, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (377, 68, 'LA BELLEZA', 1, 170, NULL, 889, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (397, 68, 'LA PAZ', 1, 170, NULL, 891, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (418, 68, 'LOS SANTOS', 1, 170, NULL, 893, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (296, 68, 'GALAN', 1, 170, NULL, 878, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (298, 68, 'GAMBITA', 1, 170, NULL, 879, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (368, 68, 'JESUS MARIA', 1, 170, NULL, 887, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (245, 68, 'EL GUACAMAYO', 1, 170, NULL, 871, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (264, 68, 'ENCINO', 1, 170, NULL, 874, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (167, 68, 'CHARALA', 1, 170, NULL, 860, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (176, 68, 'CHIMA', 1, 170, NULL, 435, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (190, 68, 'CIMITARRA', 1, 170, NULL, 864, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (217, 68, 'COROMORO', 1, 170, NULL, 868, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (160, 68, 'CEPITA', 1, 170, NULL, 858, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (79, 68, 'BARICHARA', 1, 170, NULL, 850, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (132, 68, 'CALIFORNIA', 1, 170, NULL, 855, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (682, 66, 'SANTA ROSA DE CABAL', 1, 170, NULL, 843, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (51, 68, 'ARATOCA', 1, 170, NULL, 848, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (400, 66, 'LA VIRGINIA', 1, 170, NULL, 838, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (572, 66, 'PUEBLO RICO', 1, 170, NULL, 80, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (272, 63, 'FILANDIA', 1, 170, NULL, 824, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (470, 63, 'MONTENEGRO', 1, 170, NULL, 827, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 66, 'PEREIRA', 1, 170, NULL, 831, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (874, 54, 'VILLA DEL ROSARIO', 1, 170, NULL, 818, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (295, 25, 'GACHANCIPA', 1, 170, NULL, 490, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (307, 25, 'GIRARDOT', 1, 170, NULL, 493, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (322, 25, 'GUASCA', 1, 170, NULL, 497, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (326, 25, 'GUATAVITA', 1, 170, NULL, 499, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (178, 25, 'CHIPAQUE', 1, 170, NULL, 474, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (200, 25, 'COGUA', 1, 170, NULL, 477, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (279, 25, 'FOMEQUE', 1, 170, NULL, 484, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (286, 25, 'FUNZA', 1, 170, NULL, 486, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 25, 'AGUA DE DIOS', 1, 170, NULL, 458, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (86, 25, 'BELTRAN', 1, 170, NULL, 463, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (99, 25, 'BOJACA', 1, 170, NULL, 465, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (120, 25, 'CABRERA', 1, 170, NULL, 466, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (154, 25, 'CARMEN DE CARUPA', 1, 170, NULL, 471, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (678, 23, 'SAN CARLOS', 1, 170, NULL, 92, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (50, 17, 'ARANZAZU', 1, 170, NULL, 324, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (207, 52, 'CONSACA', 1, 170, NULL, 724, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (36, 52, 'ANCUYA', 1, 170, NULL, 718, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (325, 50, 'MAPIRIPAN', 1, 170, NULL, 699, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (450, 50, 'PUERTO CONCORDIA', 1, 170, NULL, 704, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (577, 50, 'PUERTO LLERAS', 1, 170, NULL, 707, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (683, 50, 'SAN JUAN DE ARAMA', 1, 170, NULL, 711, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (798, 47, 'TENERIFE', 1, 170, NULL, 683, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (6, 50, 'ACACIAS', 1, 170, NULL, 687, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (110, 50, 'BARRANCA DE UPIA', 1, 170, NULL, 688, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (223, 50, 'CUBARRAL', 1, 170, NULL, 691, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (425, 27, 'MEDIO ATRATO', 1, 170, NULL, 591, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1711, 3, 'LIMA', 1, 171, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (570, 86, 'LA HORMIGA', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 4, 'LEXINGTON', 1, 200, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 9, 'STANFORD', 1, 200, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1722, 2, 'SAO PAULO', 1, 172, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (810, 27, 'UNION PANAMERICANA', 1, 170, NULL, 603, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (605, 47, 'REMOLINO', 1, 170, NULL, 675, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (245, 47, 'EL BANCO', 1, 170, NULL, 664, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (161, 47, 'CERRO SAN ANTONIO', 1, 170, NULL, 660, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (548, 19, 'PIENDAMO', 1, 170, NULL, 389, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (450, 19, 'MERCADERES', 1, 170, NULL, 382, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (397, 19, 'LA VEGA', 1, 170, NULL, 380, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (610, 18, 'SAN JOSE DE FRAGUA', 1, 170, NULL, 359, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (867, 17, 'VICTORIA', 1, 170, NULL, 345, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (592, 18, 'PUERTO RICO', 1, 170, NULL, 358, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (653, 17, 'SALAMINA', 1, 170, NULL, 341, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (541, 17, 'PENSILVANIA', 1, 170, NULL, 338, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (296, 8, 'GALAPA', 1, 170, NULL, 132, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (440, 13, 'MARGARITA', 1, 170, NULL, 171, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (468, 13, 'MOMPOS', 1, 170, NULL, 174, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (36, 76, 'ANDALUCIA', 1, 170, NULL, 1009, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (4, 5, 'ABRIAQUI', 1, 170, NULL, 3, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (45, 5, 'APARTADO', 1, 170, NULL, 14, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (828, 76, 'TRUJILLO', 1, 170, NULL, 1041, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (377, 76, 'LA CUMBRE', 1, 170, NULL, 1029, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (30, 73, 'AMBALEMA', 1, 170, NULL, 962, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (148, 73, 'CARMEN DE APICALA', 1, 170, NULL, 967, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (357, 41, 'IQUIRA', 1, 170, NULL, 618, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (128, 54, 'CACHIRA', 1, 170, NULL, 785, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 54, 'CUCUTA', 1, 170, NULL, 779, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (790, 5, 'TARAZA', 1, 170, NULL, 111, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (642, 5, 'SALGAR', 1, 170, NULL, 90, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (658, 25, 'SAN FRANCISCO', 1, 170, NULL, 93, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (572, 25, 'PUERTO SALGAR', 1, 170, NULL, 527, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (524, 68, 'PALMAS SOCORRO', 1, 170, NULL, 903, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (258, 25, 'EL PENON', 1, 170, NULL, 481, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (150, 27, 'carmen del darien', 1, 170, '0', 583, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (806, 15, 'TIBASOSA', 1, 170, NULL, 306, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (838, 13, 'TURBANA', 1, 170, NULL, 195, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (90, 15, 'BERBEO', 1, 170, NULL, 203, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (154, 5, 'CAUCASIA', 1, 170, NULL, 36, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (655, 68, 'SABANA DE TORRES', 1, 170, NULL, 911, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (440, 66, 'MARSELLA', 1, 170, NULL, 839, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (380, 17, 'LA DORADA', 1, 170, NULL, 328, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (25, 95, 'EL RETORNO', 1, 170, NULL, 1096, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (701, 19, 'SANTA ROSA', 1, 170, NULL, 188, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 52, 'PASTO', 1, 170, NULL, 715, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (205, 47, 'CONCORDIA', 1, 170, NULL, 41, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (960, 47, 'ZAPAYAN', 1, 170, NULL, 684, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (600, 27, 'RIO QUITO', 1, 170, NULL, 597, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (320, 86, 'ORITO', 1, 170, NULL, 1077, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (573, 86, 'PUERTO LEGUIZAMO', 1, 170, NULL, 1082, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (760, 86, 'SANTIAGO', 1, 170, NULL, 811, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (564, 88, 'PROVIDENCIA', 1, 170, NULL, 760, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 91, 'LETICIA', 1, 170, NULL, 1091, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (315, 85, 'SACAMA', 1, 170, NULL, 1069, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (325, 85, 'SAN LUIS DE PALENQUE', 1, 170, NULL, 1070, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (430, 85, 'TRINIDAD', 1, 170, NULL, 1073, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (230, 85, 'OROCUE', 1, 170, NULL, 1064, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (10, 85, 'AGUAZUL', 1, 170, NULL, 1057, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (125, 85, 'HATO COROZAL', 1, 170, NULL, 1059, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (162, 85, 'MONTERREY', 1, 170, NULL, 1062, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (300, 81, 'FORTUL', 1, 170, NULL, 1052, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (794, 81, 'TAME', 1, 170, NULL, 1055, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 85, 'YOPAL', 1, 170, NULL, 1056, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (892, 76, 'YUMBO', 1, 170, NULL, 1047, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 81, 'ARAUCA', 1, 170, NULL, 1049, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (65, 81, 'ARAUQUITA', 1, 170, NULL, 1050, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (736, 76, 'SEVILLA', 1, 170, NULL, 1039, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (823, 76, 'TORO', 1, 170, NULL, 1040, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (622, 76, 'ROLDANILLO', 1, 170, NULL, 1037, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (403, 76, 'LA VICTORIA', 1, 170, NULL, 246, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (400, 76, 'LA UNION', 1, 170, NULL, 67, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (250, 76, 'EL DOVIO', 1, 170, NULL, 1024, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (130, 76, 'CANDELARIA', 1, 170, NULL, 131, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (122, 76, 'CAICEDONIA', 1, 170, NULL, 1016, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (265, 70, 'GUARANDA', 1, 170, NULL, 941, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (773, 68, 'SUCRE', 1, 170, NULL, 399, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (867, 68, 'VETAS', 1, 170, NULL, 929, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (622, 73, 'RONCESVALLES', 1, 170, NULL, 995, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (624, 73, 'ROVIRA', 1, 170, NULL, 996, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (686, 73, 'SANTA ISABEL', 1, 170, NULL, 1000, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (861, 73, 'VENADILLO', 1, 170, NULL, 1003, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (555, 73, 'PLANADAS', 1, 170, NULL, 991, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (233, 70, 'EL ROBLE', 1, 170, NULL, 939, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (449, 73, 'MELGAR', 1, 170, NULL, 985, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (347, 73, 'HERVEO', 1, 170, NULL, 979, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (408, 73, 'LERIDA', 1, 170, NULL, 982, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (236, 73, 'DOLORES', 1, 170, NULL, 973, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (24, 73, 'ALPUJARRA', 1, 170, NULL, 960, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (152, 73, 'CASABIANCA', 1, 170, NULL, 968, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (847, 44, 'URIBIA', 1, 170, NULL, 653, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (807, 41, 'TIMANA', 1, 170, NULL, 638, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (770, 41, 'SUAZA', 1, 170, NULL, 633, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (799, 41, 'TELLO', 1, 170, NULL, 636, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (359, 41, 'ISNOS', 1, 170, NULL, 619, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (503, 41, 'OPORAPA', 1, 170, NULL, 623, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (524, 41, 'PALERMO', 1, 170, NULL, 625, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (26, 41, 'ALTAMIRA', 1, 170, NULL, 609, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (132, 41, 'CAMPOALEGRE', 1, 170, NULL, 611, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (787, 27, 'TADO', 1, 170, NULL, 601, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 73, 'IBAGUE', 1, 170, NULL, 958, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (717, 70, 'SAN PEDRO', 1, 170, NULL, 98, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (702, 70, 'SAN JUAN DE BETULIA', 1, 170, NULL, 950, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (473, 70, 'MORROA', 1, 170, NULL, 945, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (680, 54, 'SANTIAGO', 1, 170, NULL, 811, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (743, 54, 'SILOS', 1, 170, NULL, 813, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (670, 54, 'SAN CALIXTO', 1, 170, NULL, 809, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (313, 54, 'GRAMALOTE', 1, 170, NULL, 794, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (223, 54, 'CUCUTILLA', 1, 170, NULL, 789, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (245, 54, 'EL CARMEN', 1, 170, NULL, 586, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (699, 52, 'SANTACRUZ', 1, 170, NULL, 772, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (720, 52, 'SAPUYES', 1, 170, NULL, 773, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (585, 52, 'PUPIALES', 1, 170, NULL, 762, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (678, 52, 'SAMANIEGO', 1, 170, NULL, 765, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (506, 52, 'OSPINA', 1, 170, NULL, 756, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (540, 52, 'POLICARPA', 1, 170, NULL, 758, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (573, 52, 'PUERRES', 1, 170, NULL, 761, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (435, 52, 'MALLAMA', 1, 170, NULL, 752, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (352, 52, 'ILES', 1, 170, NULL, 740, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (385, 52, 'LA LLANADA', 1, 170, NULL, 745, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (390, 52, 'LA TOLA', 1, 170, NULL, 746, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (260, 52, 'EL TAMBO', 1, 170, NULL, 374, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (895, 5, 'ZARAGOZA', 1, 170, NULL, 127, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (78, 8, 'BARANOA', 1, 170, NULL, 129, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (885, 5, 'YALI', 1, 170, NULL, 123, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (761, 5, 'SOPETRAN', 1, 170, NULL, 109, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (789, 5, 'TAMESIS', 1, 170, NULL, 110, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (792, 5, 'TARSO', 1, 170, NULL, 112, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (670, 5, 'SAN ROQUE', 1, 170, NULL, 101, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (697, 5, 'SANTUARIO', 1, 170, NULL, 106, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (756, 5, 'SONSON', 1, 170, NULL, 108, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (579, 5, 'PUERTO BERRIO', 1, 170, NULL, 81, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (604, 5, 'REMEDIOS', 1, 170, NULL, 84, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (425, 5, 'MACEO', 1, 170, NULL, 69, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (467, 5, 'MONTEBELLO', 1, 170, NULL, 71, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (490, 5, 'NECOCLI', 1, 170, NULL, 75, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (501, 5, 'OLAYA', 1, 170, NULL, 77, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (361, 27, 'ISTMINA', 1, 170, NULL, 588, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (6, 27, 'ACANDI', 1, 170, NULL, 575, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (73, 27, 'BAGADO', 1, 170, NULL, 578, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 27, 'QUIBDO', 1, 170, NULL, 574, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (805, 25, 'TIBACUY', 1, 170, NULL, 555, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (841, 25, 'UBAQUE', 1, 170, NULL, 561, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (845, 25, 'UNE', 1, 170, NULL, 563, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (851, 25, 'UTICA', 1, 170, NULL, 564, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (871, 25, 'VILLAGOMEZ', 1, 170, NULL, 567, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (126, 76, 'CALIMA (DARIEN)', 1, 170, NULL, 1017, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (855, 68, 'VALLE DE SAN JOSE', 1, 170, NULL, 927, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (498, 54, 'OCANA', 1, 170, NULL, 803, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (658, 5, 'SAN JOSE DE LA MONTANA', 1, 170, NULL, 95, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (77, 27, 'BAJO BAUDO', 1, 170, NULL, 580, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (736, 25, 'SESQUILE', 1, 170, NULL, 540, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (745, 25, 'SIMIJACA', 1, 170, NULL, 543, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (758, 25, 'SOPO', 1, 170, NULL, 545, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (793, 25, 'TAUSA', 1, 170, NULL, 552, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (797, 25, 'TENA', 1, 170, NULL, 553, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (518, 25, 'PAIME', 1, 170, NULL, 523, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (535, 25, 'PASCA', 1, 170, NULL, 526, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (580, 25, 'PULI', 1, 170, NULL, 528, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (612, 25, 'RICAURTE', 1, 170, NULL, 533, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (328, 25, 'GUAYABAL DE SIQUIMA', 1, 170, NULL, 500, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (377, 25, 'LA CALERA', 1, 170, NULL, 505, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (394, 25, 'LA PALMA', 1, 170, NULL, 507, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (407, 25, 'LENGUAZAQUE', 1, 170, NULL, 510, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (426, 25, 'MACHETA', 1, 170, NULL, 511, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (473, 25, 'MOSQUERA', 1, 170, NULL, 515, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (486, 25, 'NEMOCON', 1, 170, NULL, 517, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (489, 25, 'NIMAIMA', 1, 170, NULL, 519, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (820, 15, 'TOPAGA', 1, 170, NULL, 311, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (822, 15, 'TOTA', 1, 170, NULL, 312, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (839, 15, 'TUTASA', 1, 170, NULL, 316, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (842, 15, 'UMBITA', 1, 170, NULL, 317, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (879, 15, 'VIRACACHA', 1, 170, NULL, 319, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (13, 17, 'AGUADAS', 1, 170, NULL, 322, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (686, 15, 'SANTANA', 1, 170, NULL, 285, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (696, 15, 'SANTA SOFIA', 1, 170, NULL, 288, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (720, 15, 'SATIVANORTE', 1, 170, NULL, 289, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (757, 15, 'SOCHA', 1, 170, NULL, 294, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (759, 15, 'SOGAMOSO', 1, 170, NULL, 295, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (763, 15, 'SOTAQUIRA', 1, 170, NULL, 298, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (798, 15, 'TENZA', 1, 170, NULL, 304, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (804, 15, 'TIBANA', 1, 170, NULL, 305, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (533, 15, 'PAYA', 1, 170, NULL, 267, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (542, 15, 'PESCA', 1, 170, NULL, 269, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (572, 15, 'PUERTO BOYACA', 1, 170, NULL, 271, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (600, 15, 'RAQUIRA', 1, 170, NULL, 274, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (660, 15, 'SAN EDUARDO', 1, 170, NULL, 279, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (673, 15, 'SAN MATEO', 1, 170, NULL, 282, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (401, 15, 'LA VICTORIA', 1, 170, NULL, 246, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (425, 15, 'MACANAL', 1, 170, NULL, 249, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (464, 15, 'MONGUA', 1, 170, NULL, 252, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (491, 15, 'NOBSA', 1, 170, NULL, 257, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (500, 15, 'OICATA', 1, 170, NULL, 259, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (226, 15, 'CUITIVA', 1, 170, NULL, 226, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (236, 15, 'CHIVOR', 1, 170, NULL, 228, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (293, 15, 'GACHANTIVA', 1, 170, NULL, 234, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (322, 15, 'GUATEQUE', 1, 170, NULL, 238, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (362, 15, 'IZA', 1, 170, NULL, 241, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (135, 15, 'CAMPOHERMOSO', 1, 170, NULL, 211, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (176, 15, 'CHIQUINQUIRA', 1, 170, NULL, 214, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (836, 13, 'TURBACO', 1, 170, NULL, 194, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (51, 15, 'ARCABUCO', 1, 170, NULL, 201, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (673, 13, 'SANTA CATALINA', 1, 170, NULL, 187, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (688, 13, 'SANTA ROSA DEL SUR', 1, 170, NULL, 189, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (91, 5, 'BETANIA', 1, 170, NULL, 21, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (101, 5, 'BOLIVAR', 1, 170, NULL, 368, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (353, 5, 'HISPANIA', 1, 170, NULL, 59, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (361, 5, 'ITUANGO', 1, 170, NULL, 61, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (282, 5, 'FREDONIA', 1, 170, NULL, 49, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (310, 5, 'GOMEZ PLATA', 1, 170, NULL, 53, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (197, 5, 'COCORNA', 1, 170, NULL, 39, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (250, 5, 'EL BAGRE', 1, 170, NULL, 46, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (172, 5, 'CHIGORODO', 1, 170, NULL, 37, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (770, 68, 'SUAITA', 1, 170, NULL, 923, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (682, 68, 'SAN JOAQUIN', 1, 170, NULL, 915, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (444, 68, 'MATANZA', 1, 170, NULL, 896, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (500, 68, 'OIBA', 1, 170, NULL, 900, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (547, 68, 'PIEDECUESTA', 1, 170, NULL, 905, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (720, 54, 'SARDINATA', 1, 170, NULL, 812, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (553, 54, 'PUERTO SANTANDER', 1, 170, NULL, 806, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (344, 54, 'HACARI', 1, 170, NULL, 795, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (239, 54, 'DURANIA', 1, 170, NULL, 790, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (51, 54, 'ARBOLEDAS', 1, 170, NULL, 781, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (694, 52, 'SAN PEDRO DE CARTAGO', 1, 170, NULL, 770, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (490, 52, 'OLAYA HERRERA', 1, 170, NULL, 755, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (323, 52, 'GUALMATAN', 1, 170, NULL, 739, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 6, 'AUSTIN', 1, 200, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 7, 'SAN MIGUEL', 1, 300, NULL, 917, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (370, 68, 'JORDAN', 1, 170, NULL, 888, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (432, 68, 'MALAGA', 1, 170, NULL, 895, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (318, 68, 'GUACA', 1, 170, NULL, 881, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (322, 68, 'GUAPOTA', 1, 170, NULL, 883, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (235, 68, 'EL CARMEN', 1, 170, NULL, 586, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (169, 68, 'CHARTA', 1, 170, NULL, 861, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (179, 68, 'CHIPATA', 1, 170, NULL, 863, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (162, 68, 'CERRITO', 1, 170, NULL, 859, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (92, 68, 'BETULIA', 1, 170, NULL, 22, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (147, 68, 'CAPITANEJO', 1, 170, NULL, 856, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (13, 68, 'AGUADA', 1, 170, NULL, 846, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (383, 66, 'LA CELIA', 1, 170, NULL, 837, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (75, 66, 'BALBOA', 1, 170, NULL, 367, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (212, 63, 'CORDOBA', 1, 170, NULL, 163, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (820, 54, 'TOLEDO', 1, 170, NULL, 114, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 63, 'ARMENIA', 1, 170, NULL, 17, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (297, 25, 'GACHETA', 1, 170, NULL, 491, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (317, 25, 'GUACHETA', 1, 170, NULL, 495, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (324, 25, 'GUATAQUI', 1, 170, NULL, 498, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (183, 25, 'CHOCONTA', 1, 170, NULL, 476, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (245, 25, 'EL COLEGIO', 1, 170, NULL, 480, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (19, 25, 'ALBAN', 1, 170, NULL, 459, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (35, 25, 'ANAPOIMA', 1, 170, NULL, 460, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (123, 25, 'CACHIPAY', 1, 170, NULL, 467, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (151, 25, 'CAQUEZA', 1, 170, NULL, 470, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (855, 23, 'VALENCIA', 1, 170, NULL, 457, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (272, 17, 'FILADELFIA', 1, 170, NULL, 327, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (388, 17, 'LA MERCED', 1, 170, NULL, 329, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (200, 95, 'MIRAFLORES', 1, 170, NULL, 251, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 97, 'MITU', 1, 170, NULL, 1098, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (573, 8, 'PUERTO COLOMBIA', 1, 170, NULL, 141, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (606, 8, 'REPELON', 1, 170, NULL, 142, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (770, 8, 'SUAN', 1, 170, NULL, 148, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (106, 15, 'BRICENO', 1, 170, NULL, 207, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (696, 52, 'SANTABARBARA', 1, 170, NULL, 771, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (254, 52, 'EL PENOL', 1, 170, NULL, 732, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (480, 52, 'NARINO', 1, 170, NULL, 754, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (250, 68, 'EL PENON', 1, 170, NULL, 872, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (832, 8, 'TUBARA', 1, 170, NULL, 149, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (52, 13, 'ARJONA', 1, 170, NULL, 157, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (670, 23, 'SAN ANDRES SOTAVENTO', 1, 170, NULL, 451, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (574, 23, 'PUERTO ESCONDIDO', 1, 170, NULL, 447, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (419, 23, 'LOS CORDOBAS', 1, 170, NULL, 441, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (464, 23, 'MOMIL', 1, 170, NULL, 442, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (182, 23, 'CHINU', 1, 170, NULL, 436, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (90, 23, 'CANALETE', 1, 170, NULL, 433, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (162, 23, 'CERETE', 1, 170, NULL, 434, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (787, 20, 'TAMALAMEQUE', 1, 170, NULL, 429, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (68, 23, 'AYAPEL', 1, 170, NULL, 431, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (383, 20, 'LA GLORIA', 1, 170, NULL, 418, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (400, 20, 'LA JAGUA DE IBIRICO', 1, 170, NULL, 419, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (517, 20, 'PAILITAS', 1, 170, NULL, 421, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (614, 20, 'RIO DE ORO', 1, 170, NULL, 424, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (32, 20, 'ASTREA', 1, 170, NULL, 408, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (45, 20, 'BECERRIL', 1, 170, NULL, 409, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (60, 20, 'BOSCONIA', 1, 170, NULL, 410, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (238, 20, 'EL COPEY', 1, 170, NULL, 414, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (250, 20, 'EL PASO', 1, 170, NULL, 415, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (295, 20, 'GAMARRA', 1, 170, NULL, 416, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (11, 20, 'AGUACHICA', 1, 170, NULL, 406, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (780, 19, 'SUAREZ', 1, 170, NULL, 398, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (809, 19, 'TIMBIQUI', 1, 170, NULL, 401, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (821, 19, 'TORIBIO', 1, 170, NULL, 402, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (698, 19, 'SANTANDER DE QUILICHAO', 1, 170, NULL, 394, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (760, 19, 'SOTARA', 1, 170, NULL, 397, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (227, 52, 'CUMBAL', 1, 170, NULL, 728, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (240, 52, 'CHACHAGUI', 1, 170, NULL, 730, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (79, 52, 'BARBACOAS', 1, 170, NULL, 720, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (19, 52, 'ALBAN', 1, 170, NULL, 459, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (318, 50, 'GUAMAL', 1, 170, NULL, 668, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (330, 50, 'MESETAS', 1, 170, NULL, 700, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (573, 50, 'PUERTO LOPEZ', 1, 170, NULL, 706, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (606, 50, 'RESTREPO', 1, 170, NULL, 709, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (689, 50, 'SAN MARTIN', 1, 170, NULL, 428, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 50, 'VILLAVICENCIO', 1, 170, NULL, 686, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (124, 50, 'CABUYARO', 1, 170, NULL, 689, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (675, 47, 'SALAMINA', 1, 170, NULL, 341, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (703, 47, 'SAN ZENON', 1, 170, NULL, 679, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (541, 47, 'PEDRAZA', 1, 170, NULL, 670, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (58, 47, 'ARIGUANI', 1, 170, NULL, 659, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (170, 47, 'CHIVOLO', 1, 170, NULL, 661, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (189, 47, 'CIENAGA', 1, 170, NULL, 662, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (622, 19, 'ROSAS', 1, 170, NULL, 392, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (455, 19, 'MIRANDA', 1, 170, NULL, 383, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (418, 19, 'LOPEZ', 1, 170, NULL, 381, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (364, 19, 'JAMBALO', 1, 170, NULL, 378, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (212, 19, 'CORINTO', 1, 170, NULL, 373, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (765, 18, 'SOLANO', 1, 170, NULL, 361, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (22, 19, 'ALMAGUER', 1, 170, NULL, 365, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (150, 18, 'CARTAGENA DEL CHAIRA', 1, 170, NULL, 351, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (479, 18, 'MORELIA', 1, 170, NULL, 357, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (446, 17, 'MARULANDA', 1, 170, NULL, 333, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (486, 17, 'NEIRA', 1, 170, NULL, 334, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (421, 8, 'LURUACO', 1, 170, NULL, 134, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (433, 8, 'MALAMBO', 1, 170, NULL, 135, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (558, 8, 'POLONUEVO', 1, 170, NULL, 139, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (442, 13, 'MARIA LA BAJA', 1, 170, NULL, 172, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (248, 13, 'EL GUAMO', 1, 170, NULL, 166, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (41, 76, 'ANSERMANUEVO', 1, 170, NULL, 1010, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 5, 'MEDELLIN', 1, 170, NULL, 1, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (44, 5, 'ANZA', 1, 170, NULL, 13, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (863, 76, 'VERSALLES', 1, 170, NULL, 1044, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (616, 76, 'RIOFRIO', 1, 170, NULL, 1036, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (235, 70, 'GALERAS', 1, 170, NULL, 940, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (67, 73, 'ATACO', 1, 170, NULL, 965, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (885, 41, 'YAGUARA', 1, 170, NULL, 640, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (306, 41, 'GIGANTE', 1, 170, NULL, 615, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (518, 54, 'PAMPLONA', 1, 170, NULL, 804, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (206, 54, 'CONVENCION', 1, 170, NULL, 788, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (861, 5, 'VENECIA', 1, 170, NULL, 121, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (660, 5, 'SAN LUIS', 1, 170, NULL, 97, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (867, 25, 'VIANI', 1, 170, NULL, 566, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (754, 25, 'SOACHA', 1, 170, NULL, 544, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (799, 25, 'TENJO', 1, 170, NULL, 554, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (596, 25, 'QUIPILE', 1, 170, NULL, 531, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (778, 15, 'SUTATENZA', 1, 170, NULL, 302, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (580, 15, 'QUIPAMA', 1, 170, NULL, 272, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (223, 15, 'CUBARA', 1, 170, NULL, 224, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 15, 'TUNJA', 1, 170, NULL, 198, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (104, 15, 'BOYACA', 1, 170, NULL, 206, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (147, 5, 'CAREPA', 1, 170, NULL, 33, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (686, 68, 'SAN MIGUEL', 1, 170, NULL, 917, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (152, 68, 'CARCASI', 1, 170, NULL, 857, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (77, 68, 'BARBOSA', 1, 170, NULL, 18, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (690, 63, 'SALENTO', 1, 170, NULL, 830, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (130, 63, 'CALARCA', 1, 170, NULL, 821, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (634, 8, 'SABANAGRANDE', 1, 170, NULL, 143, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1, 11, 'BOGOTA', 1, 170, NULL, 152, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (256, 52, 'EL ROSARIO', 1, 170, NULL, 733, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (22, 52, 'ALDANA', 1, 170, NULL, 717, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (532, 19, 'PATIA (EL BORDO)', 1, 170, NULL, 387, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (392, 19, 'LA SIERRA', 1, 170, NULL, 379, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (873, 17, 'VILLAMARIA', 1, 170, NULL, 346, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (36, 5, 'ANGELOPOLIS', 1, 170, NULL, 9, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (51, 5, 'ARBOLETES', 1, 170, NULL, 15, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (760, 99, 'SAN JOSE DE OCUNE', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (773, 99, 'CUMARIBO', 1, 170, NULL, 1104, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (460, 91, 'MIRITI-PARANA', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (669, 91, 'PTO SANTANDER', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (886, 94, 'CACAHUAL', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (887, 94, 'PANA PANA', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (666, 97, 'TARAIRA', 1, 170, NULL, 1100, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (385, 54, 'LA ESPERANZA', 1, 170, NULL, 798, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (458, 13, 'MONTECRISTO', 1, 170, NULL, 173, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (160, 13, 'CANTAGALLO', 1, 170, NULL, 161, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (300, 13, 'HATILLO DE LOBA', 1, 170, NULL, 168, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (655, 13, 'SAN JACINTO DEL CAUCA', 1, 170, NULL, 183, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (378, 44, 'HATONUEVO', 1, 170, NULL, 648, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (268, 47, 'EL RETEN', 1, 170, NULL, 666, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (520, 73, 'PALOCABILDO', 1, 170, NULL, 989, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (268, 13, 'EL PENON', 1, 170, NULL, 167, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (545, 47, 'PIJINO DEL CARMEN', 1, 170, NULL, 671, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (350, 23, 'LA APARTADA', 1, 170, NULL, 439, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (536, 91, 'PUERTO ARICA', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (665, 17, 'SAN JOSE', 1, 170, NULL, 343, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (270, 50, 'EL DORADO', 1, 170, NULL, 695, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (888, 94, 'CD. MORICHAL NUEVO', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (624, 99, 'SANTA ROSALIA', 1, 170, NULL, 1103, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (999, 47, 'NUEVA GRANADA', 1, 170, NULL, 669, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (98, 47, 'ZONA BANANERA', 1, 170, NULL, 685, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (870, 73, 'VILLAHERMOSA', 1, 170, NULL, 1004, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (563, 73, 'PRADO', 1, 170, NULL, 992, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (547, 73, 'PIEDRAS', 1, 170, NULL, 990, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (349, 73, 'HONDA', 1, 170, NULL, 980, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (226, 73, 'CUNDAY', 1, 170, NULL, 972, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (275, 73, 'FLANDES', 1, 170, NULL, 976, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (650, 44, 'SAN JUAN DEL CESAR', 1, 170, NULL, 652, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (872, 41, 'VILLAVIEJA', 1, 170, NULL, 639, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (319, 41, 'GUADALUPE', 1, 170, NULL, 55, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (530, 41, 'PALESTINA', 1, 170, NULL, 337, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (13, 41, 'AGRADO', 1, 170, NULL, 606, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (206, 41, 'COLOMBIA', 1, 170, NULL, 612, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (823, 70, 'TOLUVIEJO', 1, 170, NULL, 957, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (670, 70, 'SAMPUES', 1, 170, NULL, 948, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (418, 70, 'LOS PALMITOS', 1, 170, NULL, 943, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (372, 27, 'JURADO', 1, 170, NULL, 589, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (1723, 2, 'RIO DE JANEIRO', 1, 172, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (9563, 98, 'RIO DE JANEIRO', 1, 172, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (236, 23, 'TUCHIN', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (490, 13, 'NOROSI', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (300, 19, 'GUACHENE', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (682, 23, 'SAN JOSE DE URE', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (125, 68, 'BERLIN', 1, 170, NULL, NULL, 1);
INSERT INTO municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) VALUES (55, 73, 'ARMERO', 1, 170, NULL, 964, 1);


--
-- TOC entry 2948 (class 0 OID 17789)
-- Dependencies: 200
-- Data for Name: par_serv_servicios; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO par_serv_servicios (par_serv_secue, par_serv_codigo, par_serv_nombre, par_serv_estado) VALUES (1, '1', 'ACUEDUCTO', 'A');
INSERT INTO par_serv_servicios (par_serv_secue, par_serv_codigo, par_serv_nombre, par_serv_estado) VALUES (2, '2', 'ALCANTARILLADO', 'A');
INSERT INTO par_serv_servicios (par_serv_secue, par_serv_codigo, par_serv_nombre, par_serv_estado) VALUES (3, '3', 'ASEO', 'A');
INSERT INTO par_serv_servicios (par_serv_secue, par_serv_codigo, par_serv_nombre, par_serv_estado) VALUES (4, '4', 'ENERGIA ELECTRICA', 'A');
INSERT INTO par_serv_servicios (par_serv_secue, par_serv_codigo, par_serv_nombre, par_serv_estado) VALUES (5, '5', 'GAS NATURAL', 'A');
INSERT INTO par_serv_servicios (par_serv_secue, par_serv_codigo, par_serv_nombre, par_serv_estado) VALUES (6, '6', 'TELEFONIA', 'A');
INSERT INTO par_serv_servicios (par_serv_secue, par_serv_codigo, par_serv_nombre, par_serv_estado) VALUES (7, '7', 'GAS LICUADO DEL PETROLEO', 'A');
INSERT INTO par_serv_servicios (par_serv_secue, par_serv_codigo, par_serv_nombre, par_serv_estado) VALUES (8, '8', 'SERVICIOS NO COMPETENTES ', 'A');
INSERT INTO par_serv_servicios (par_serv_secue, par_serv_codigo, par_serv_nombre, par_serv_estado) VALUES (9, '9', 'CONSOLIDADO', NULL);


--
-- TOC entry 2949 (class 0 OID 17792)
-- Dependencies: 201
-- Data for Name: prestamo; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2950 (class 0 OID 17798)
-- Dependencies: 202
-- Data for Name: radicado; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3070 (class 0 OID 0)
-- Dependencies: 203
-- Name: radicado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('radicado_id_seq', 1, true);


--
-- TOC entry 2952 (class 0 OID 17876)
-- Dependencies: 204
-- Data for Name: series; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2953 (class 0 OID 17882)
-- Dependencies: 205
-- Data for Name: sgd_agen_agendados; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3071 (class 0 OID 0)
-- Dependencies: 206
-- Name: sgd_agen_agendados_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sgd_agen_agendados_id_seq', 1, true);


--
-- TOC entry 2955 (class 0 OID 17890)
-- Dependencies: 207
-- Data for Name: sgd_anar_anexarg; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2956 (class 0 OID 17893)
-- Dependencies: 208
-- Data for Name: sgd_anu_anulados; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2957 (class 0 OID 17922)
-- Dependencies: 209
-- Data for Name: sgd_argd_argdoc; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2958 (class 0 OID 17931)
-- Dependencies: 210
-- Data for Name: sgd_auditoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 13:06:44> UPDATE USUARIO SET USUA_SESION=^160411010644O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460398004, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 13:06:44> UPDATE USUARIO SET USUA_SESION=^160411010644O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460398004, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', '', '2016-04-11 13:07:01> UPDATE
                                USUARIO
                                SET
                                USUA_NUEVO     = ^1^,
                                USUA_PASW      =^27CCB0EEA8A706C4C34A16891F^,
                                USUA_SESION    = ^CAMCLAV20160411^
                            WHERE
                                DEPE_CODI = 900 AND
                                USUA_CODI = 1', 1460398021, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', '', '2016-04-11 13:07:01> UPDATE
                                USUARIO
                                SET
                                USUA_NUEVO     = ^1^,
                                USUA_PASW      =^27CCB0EEA8A706C4C34A16891F^,
                                USUA_SESION    = ^CAMCLAV20160411^
                            WHERE
                                DEPE_CODI = 900 AND
                                USUA_CODI = 1', 1460398021, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', '', '2016-04-11 13:07:01> UPDATE
                    USUARIO
               SET
                    USUA_SESION =^FIN  2016:04:11 13:0407:01^
               WHERE
                    USUA_SESION LIKE ^%160411010644O127001ADMON%^', 1460398021, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', '', '2016-04-11 13:07:01> UPDATE
                    USUARIO
               SET
                    USUA_SESION =^FIN  2016:04:11 13:0407:01^
               WHERE
                    USUA_SESION LIKE ^%160411010644O127001ADMON%^', 1460398021, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 13:07:10> UPDATE USUARIO SET USUA_SESION=^160411010710O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460398030, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 13:07:10> UPDATE USUARIO SET USUA_SESION=^160411010710O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460398030, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 13:09:40> UPDATE USUARIO SET USUA_SESION=^160411010940O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460398180, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 13:09:40> UPDATE USUARIO SET USUA_SESION=^160411010940O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460398180, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 13:09:52> UPDATE USUARIO SET USUA_SESION=^160411010952O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460398192, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 13:09:52> UPDATE USUARIO SET USUA_SESION=^160411010952O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460398192, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 19:42:05> UPDATE USUARIO SET USUA_SESION=^160411074205O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460421725, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 19:42:05> UPDATE USUARIO SET USUA_SESION=^160411074205O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460421725, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 20:07:54> UPDATE USUARIO SET USUA_SESION=^160411080754O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460423274, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 20:07:54> UPDATE USUARIO SET USUA_SESION=^160411080754O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460423274, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 20:09:12> UPDATE USUARIO SET USUA_SESION=^160411080912O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460423352, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 20:09:12> UPDATE USUARIO SET USUA_SESION=^160411080912O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460423352, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 20:10:38> UPDATE USUARIO SET USUA_SESION=^160411081038O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460423438, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 20:10:38> UPDATE USUARIO SET USUA_SESION=^160411081038O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460423438, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 20:20:35> UPDATE USUARIO SET USUA_SESION=^160411082035O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460424035, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 20:20:35> UPDATE USUARIO SET USUA_SESION=^160411082035O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460424035, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 20:20:43> UPDATE USUARIO SET USUA_SESION=^160411082043O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460424043, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 20:20:43> UPDATE USUARIO SET USUA_SESION=^160411082043O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460424043, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 21:55:14> UPDATE USUARIO SET USUA_SESION=^160411095406O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460429714, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 21:55:14> UPDATE USUARIO SET USUA_SESION=^160411095406O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460429714, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 21:57:12> UPDATE USUARIO SET USUA_SESION=^160411095634O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460429832, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 21:57:12> UPDATE USUARIO SET USUA_SESION=^160411095634O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460429832, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 22:05:55> UPDATE USUARIO SET USUA_SESION=^160411100555O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460430355, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 22:05:55> UPDATE USUARIO SET USUA_SESION=^160411100555O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460430355, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 22:06:59> UPDATE USUARIO SET USUA_SESION=^160411100659O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460430419, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 22:06:59> UPDATE USUARIO SET USUA_SESION=^160411100659O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460430419, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 22:10:12> UPDATE USUARIO SET USUA_SESION=^160411101012O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460430612, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 22:10:12> UPDATE USUARIO SET USUA_SESION=^160411101012O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460430612, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 22:11:32> UPDATE USUARIO SET USUA_SESION=^160411101132O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460430692, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 22:11:32> UPDATE USUARIO SET USUA_SESION=^160411101132O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460430692, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 22:14:51> UPDATE USUARIO SET USUA_SESION=^160411101451O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460430891, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 22:14:51> UPDATE USUARIO SET USUA_SESION=^160411101451O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460430891, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 22:15:46> UPDATE USUARIO SET USUA_SESION=^160411101546O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460430946, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 22:15:46> UPDATE USUARIO SET USUA_SESION=^160411101546O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460430946, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 22:24:38> UPDATE USUARIO SET USUA_SESION=^160411102438O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460431478, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 22:24:38> UPDATE USUARIO SET USUA_SESION=^160411102438O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460431478, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 22:31:14> UPDATE USUARIO SET USUA_SESION=^160411103114O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460431874, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 22:31:14> UPDATE USUARIO SET USUA_SESION=^160411103114O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460431874, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 22:31:35> UPDATE USUARIO SET USUA_SESION=^160411103135O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460431895, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 22:31:35> UPDATE USUARIO SET USUA_SESION=^160411103135O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460431895, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 22:31:40> UPDATE USUARIO SET USUA_SESION=^160411103140O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460431900, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 22:31:40> UPDATE USUARIO SET USUA_SESION=^160411103140O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460431900, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 22:31:49> UPDATE USUARIO SET USUA_SESION=^160411103149O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460431909, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 22:31:49> UPDATE USUARIO SET USUA_SESION=^160411103149O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460431909, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 22:31:58> UPDATE USUARIO SET USUA_SESION=^160411103158O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460431918, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 22:31:58> UPDATE USUARIO SET USUA_SESION=^160411103158O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460431918, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 22:32:29> UPDATE USUARIO SET USUA_SESION=^160411103229O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460431949, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 22:32:29> UPDATE USUARIO SET USUA_SESION=^160411103229O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460431949, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 22:34:52> UPDATE USUARIO SET USUA_SESION=^160411103452O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460432092, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 22:34:53> UPDATE USUARIO SET USUA_SESION=^160411103452O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460432093, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 22:35:04> UPDATE USUARIO SET USUA_SESION=^160411103504O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460432104, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-11 22:35:04> UPDATE USUARIO SET USUA_SESION=^160411103504O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460432104, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 08:18:41> UPDATE USUARIO SET USUA_SESION=^160412081841O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460467121, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 08:18:41> UPDATE USUARIO SET USUA_SESION=^160412081841O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460467121, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 08:18:47> UPDATE USUARIO SET USUA_SESION=^160412081847O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460467127, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 08:18:47> UPDATE USUARIO SET USUA_SESION=^160412081847O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460467127, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 08:18:58> UPDATE USUARIO SET USUA_SESION=^160412081858O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460467138, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 08:18:58> UPDATE USUARIO SET USUA_SESION=^160412081858O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460467138, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 08:19:04> UPDATE USUARIO SET USUA_SESION=^160412081904O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460467144, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 08:19:04> UPDATE USUARIO SET USUA_SESION=^160412081904O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460467144, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 08:31:16> UPDATE USUARIO SET USUA_SESION=^160412083116O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460467876, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 08:31:16> UPDATE USUARIO SET USUA_SESION=^160412083116O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460467876, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 08:31:22> UPDATE USUARIO SET USUA_SESION=^160412083122O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460467882, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 08:31:22> UPDATE USUARIO SET USUA_SESION=^160412083122O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460467882, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 08:32:15> UPDATE USUARIO SET USUA_SESION=^160412083215O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460467935, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 08:32:15> UPDATE USUARIO SET USUA_SESION=^160412083215O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460467935, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 08:35:21> UPDATE USUARIO SET USUA_SESION=^160412083521O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460468121, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 08:35:21> UPDATE USUARIO SET USUA_SESION=^160412083521O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460468121, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 08:35:26> UPDATE USUARIO SET USUA_SESION=^160412083526O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460468126, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 08:35:26> UPDATE USUARIO SET USUA_SESION=^160412083526O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460468126, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 08:35:35> UPDATE USUARIO SET USUA_SESION=^160412083535O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460468135, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 08:35:35> UPDATE USUARIO SET USUA_SESION=^160412083535O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460468135, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 08:35:57> UPDATE USUARIO SET USUA_SESION=^160412083557O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460468157, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 08:35:57> UPDATE USUARIO SET USUA_SESION=^160412083557O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460468157, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 08:38:42> UPDATE USUARIO SET USUA_SESION=^160412083842O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460468322, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 08:38:43> UPDATE USUARIO SET USUA_SESION=^160412083842O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460468323, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 09:05:36> UPDATE USUARIO SET USUA_SESION=^160412090313O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460469936, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 09:05:36> UPDATE USUARIO SET USUA_SESION=^160412090313O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460469936, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 09:28:42> UPDATE USUARIO SET USUA_SESION=^160412092842O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460471322, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 09:28:42> UPDATE USUARIO SET USUA_SESION=^160412092842O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460471322, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 09:33:45> UPDATE USUARIO SET USUA_SESION=^160412093345O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460471625, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 09:33:45> UPDATE USUARIO SET USUA_SESION=^160412093345O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460471625, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 10:14:24> UPDATE USUARIO SET USUA_SESION=^160412101424O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460474064, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 10:14:24> UPDATE USUARIO SET USUA_SESION=^160412101424O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460474064, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 10:48:03> UPDATE USUARIO SET USUA_SESION=^160412104803O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460476083, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 10:48:03> UPDATE USUARIO SET USUA_SESION=^160412104803O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460476083, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 10:48:22> UPDATE USUARIO SET USUA_SESION=^160412104822O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460476102, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-12 10:48:22> UPDATE USUARIO SET USUA_SESION=^160412104822O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460476102, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-13 10:51:33> UPDATE USUARIO SET USUA_SESION=^160413105133O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460562693, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-13 10:51:33> UPDATE USUARIO SET USUA_SESION=^160413105133O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460562693, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', '', '2016-04-13 10:51:37> UPDATE
                    USUARIO
               SET
                    USUA_SESION =^FIN  2016:04:13 10:0451:37^
               WHERE
                    USUA_SESION LIKE ^%160413105133O127001ADMON%^', 1460562697, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', '', '2016-04-13 10:51:38> UPDATE
                    USUARIO
               SET
                    USUA_SESION =^FIN  2016:04:13 10:0451:37^
               WHERE
                    USUA_SESION LIKE ^%160413105133O127001ADMON%^', 1460562698, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-13 12:06:44> UPDATE USUARIO SET USUA_SESION=^160413120644O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460567204, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-13 12:06:45> UPDATE USUARIO SET USUA_SESION=^160413120644O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460567205, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-13 12:16:57> UPDATE USUARIO SET USUA_SESION=^160413121657O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460567817, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-13 12:16:57> UPDATE USUARIO SET USUA_SESION=^160413121657O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460567817, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', '', '2016-04-13 12:17:02> UPDATE
                    USUARIO
               SET
                    USUA_SESION =^FIN  2016:04:13 12:0417:02^
               WHERE
                    USUA_SESION LIKE ^%160413121657O127001ADMON%^', 1460567822, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', '', '2016-04-13 12:17:02> UPDATE
                    USUARIO
               SET
                    USUA_SESION =^FIN  2016:04:13 12:0417:02^
               WHERE
                    USUA_SESION LIKE ^%160413121657O127001ADMON%^', 1460567822, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-13 12:22:31> UPDATE USUARIO SET USUA_SESION=^160413122231O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460568151, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-13 12:22:31> UPDATE USUARIO SET USUA_SESION=^160413122231O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460568151, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', '', '2016-04-13 12:22:35> UPDATE
                    USUARIO
               SET
                    USUA_SESION =^FIN  2016:04:13 12:0422:35^
               WHERE
                    USUA_SESION LIKE ^%160413122231O127001ADMON%^', 1460568155, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', '', '2016-04-13 12:22:35> UPDATE
                    USUARIO
               SET
                    USUA_SESION =^FIN  2016:04:13 12:0422:35^
               WHERE
                    USUA_SESION LIKE ^%160413122231O127001ADMON%^', 1460568155, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 09:43:37> UPDATE USUARIO SET USUA_SESION=^160414094337O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460645017, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 09:43:37> UPDATE USUARIO SET USUA_SESION=^160414094337O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460645017, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 09:47:24> UPDATE USUARIO SET USUA_SESION=^160414094724O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460645244, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 09:47:25> UPDATE USUARIO SET USUA_SESION=^160414094724O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460645245, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 09:55:40> UPDATE USUARIO SET USUA_SESION=^160414095540O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460645740, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 09:55:40> UPDATE USUARIO SET USUA_SESION=^160414095540O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460645740, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 10:29:23> UPDATE USUARIO SET USUA_SESION=^160414102923O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460647763, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 10:29:23> UPDATE USUARIO SET USUA_SESION=^160414102923O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460647763, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 10:30:27> UPDATE USUARIO SET USUA_SESION=^160414103027O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460647827, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 10:30:27> UPDATE USUARIO SET USUA_SESION=^160414103027O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460647827, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 10:32:59> UPDATE USUARIO SET USUA_SESION=^160414103259O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460647979, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 10:32:59> UPDATE USUARIO SET USUA_SESION=^160414103259O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460647979, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 10:33:26> UPDATE USUARIO SET USUA_SESION=^160414103326O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460648006, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 10:33:26> UPDATE USUARIO SET USUA_SESION=^160414103326O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460648006, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 10:38:28> UPDATE USUARIO SET USUA_SESION=^160414103828O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460648308, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 10:38:28> UPDATE USUARIO SET USUA_SESION=^160414103828O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460648308, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 10:38:37> UPDATE USUARIO SET USUA_SESION=^160414103837O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460648317, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 10:38:37> UPDATE USUARIO SET USUA_SESION=^160414103837O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460648317, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 10:39:10> UPDATE USUARIO SET USUA_SESION=^160414103910O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460648350, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 10:39:10> UPDATE USUARIO SET USUA_SESION=^160414103910O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460648350, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 10:39:23> UPDATE USUARIO SET USUA_SESION=^160414103923O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460648363, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 10:39:23> UPDATE USUARIO SET USUA_SESION=^160414103923O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460648363, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 10:43:33> UPDATE USUARIO SET USUA_SESION=^160414104333O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460648613, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 10:43:34> UPDATE USUARIO SET USUA_SESION=^160414104333O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460648614, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 11:12:21> UPDATE USUARIO SET USUA_SESION=^160414111221O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460650341, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 11:12:21> UPDATE USUARIO SET USUA_SESION=^160414111221O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460650341, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 11:12:28> UPDATE USUARIO SET USUA_SESION=^160414111228O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460650348, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 11:12:28> UPDATE USUARIO SET USUA_SESION=^160414111228O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460650348, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 11:35:36> UPDATE USUARIO SET USUA_SESION=^160414113536O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460651736, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 11:35:36> UPDATE USUARIO SET USUA_SESION=^160414113536O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460651736, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 12:57:15> UPDATE USUARIO SET USUA_SESION=^160414125715O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460656635, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-14 12:57:15> UPDATE USUARIO SET USUA_SESION=^160414125715O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460656635, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 11:40:06> UPDATE USUARIO SET USUA_SESION=^160415114006O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460738406, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 11:40:06> UPDATE USUARIO SET USUA_SESION=^160415114006O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460738406, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 11:46:06> UPDATE USUARIO SET USUA_SESION=^160415114606O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460738766, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 11:46:07> UPDATE USUARIO SET USUA_SESION=^160415114606O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460738767, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 11:46:42> UPDATE USUARIO SET USUA_SESION=^160415114642O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460738802, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 11:46:42> UPDATE USUARIO SET USUA_SESION=^160415114642O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460738802, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 11:47:27> UPDATE USUARIO SET USUA_SESION=^160415114727O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460738847, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 11:47:27> UPDATE USUARIO SET USUA_SESION=^160415114727O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460738847, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 11:47:36> UPDATE USUARIO SET USUA_SESION=^160415114736O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460738856, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 11:47:36> UPDATE USUARIO SET USUA_SESION=^160415114736O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460738856, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 11:47:51> UPDATE USUARIO SET USUA_SESION=^160415114751O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460738871, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 11:47:51> UPDATE USUARIO SET USUA_SESION=^160415114751O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460738871, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', '', '2016-04-15 11:47:56> UPDATE
                    USUARIO
               SET
                    USUA_SESION =^FIN  2016:04:15 11:0447:56^
               WHERE
                    USUA_SESION LIKE ^%160415114751O127001ADMON%^', 1460738876, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', '', '2016-04-15 11:47:56> UPDATE
                    USUARIO
               SET
                    USUA_SESION =^FIN  2016:04:15 11:0447:56^
               WHERE
                    USUA_SESION LIKE ^%160415114751O127001ADMON%^', 1460738876, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 11:59:33> UPDATE USUARIO SET USUA_SESION=^160415115933O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460739573, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 11:59:33> UPDATE USUARIO SET USUA_SESION=^160415115933O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460739573, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 12:12:30> UPDATE USUARIO SET USUA_SESION=^160415121230O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460740350, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 12:12:30> UPDATE USUARIO SET USUA_SESION=^160415121230O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460740350, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 19:36:56> UPDATE USUARIO SET USUA_SESION=^160415073656O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460767016, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 19:36:56> UPDATE USUARIO SET USUA_SESION=^160415073656O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460767016, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 19:55:17> UPDATE USUARIO SET USUA_SESION=^160415075517O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460768117, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 19:55:17> UPDATE USUARIO SET USUA_SESION=^160415075517O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460768117, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 20:31:23> UPDATE USUARIO SET USUA_SESION=^160415083123O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460770283, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 20:31:23> UPDATE USUARIO SET USUA_SESION=^160415083123O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460770283, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 20:34:22> UPDATE USUARIO SET USUA_SESION=^160415083422O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460770462, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 20:34:22> UPDATE USUARIO SET USUA_SESION=^160415083422O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460770462, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 20:35:43> UPDATE USUARIO SET USUA_SESION=^160415083543O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460770543, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 20:35:43> UPDATE USUARIO SET USUA_SESION=^160415083543O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460770543, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 20:37:33> UPDATE USUARIO SET USUA_SESION=^160415083733O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460770653, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 20:37:33> UPDATE USUARIO SET USUA_SESION=^160415083733O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460770653, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 20:41:09> UPDATE USUARIO SET USUA_SESION=^160415084109O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460770869, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 20:41:09> UPDATE USUARIO SET USUA_SESION=^160415084109O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460770869, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 20:41:22> UPDATE USUARIO SET USUA_SESION=^160415084122O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460770882, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 20:41:22> UPDATE USUARIO SET USUA_SESION=^160415084122O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460770882, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 20:41:35> UPDATE USUARIO SET USUA_SESION=^160415084135O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460770895, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-15 20:41:35> UPDATE USUARIO SET USUA_SESION=^160415084135O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460770895, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 12:58:05> UPDATE USUARIO SET USUA_SESION=^160416125805O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460829485, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 12:58:05> UPDATE USUARIO SET USUA_SESION=^160416125805O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460829485, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 13:00:29> UPDATE USUARIO SET USUA_SESION=^160416010029O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460829629, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 13:00:29> UPDATE USUARIO SET USUA_SESION=^160416010029O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460829629, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 13:01:09> UPDATE USUARIO SET USUA_SESION=^160416010109O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460829669, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 13:01:09> UPDATE USUARIO SET USUA_SESION=^160416010109O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460829669, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 13:02:01> UPDATE USUARIO SET USUA_SESION=^160416010201O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460829721, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 13:02:01> UPDATE USUARIO SET USUA_SESION=^160416010201O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460829721, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 13:02:14> UPDATE USUARIO SET USUA_SESION=^160416010214O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460829734, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 13:02:15> UPDATE USUARIO SET USUA_SESION=^160416010214O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460829735, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', '', '2016-04-16 13:20:40> UPDATE
                    USUARIO
               SET
                    USUA_SESION =^FIN  2016:04:16 13:0420:40^
               WHERE
                    USUA_SESION LIKE ^%160416010214O127001ADMON%^', 1460830840, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', '', '2016-04-16 13:20:40> UPDATE
                    USUARIO
               SET
                    USUA_SESION =^FIN  2016:04:16 13:0420:40^
               WHERE
                    USUA_SESION LIKE ^%160416010214O127001ADMON%^', 1460830840, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 13:20:45> UPDATE USUARIO SET USUA_SESION=^160416012045O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460830845, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 13:20:45> UPDATE USUARIO SET USUA_SESION=^160416012045O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460830845, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:07:50> UPDATE USUARIO SET USUA_SESION=^160416020750O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460833670, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:07:50> UPDATE USUARIO SET USUA_SESION=^160416020750O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460833670, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:08:47> UPDATE USUARIO SET USUA_SESION=^160416020847O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460833727, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:08:47> UPDATE USUARIO SET USUA_SESION=^160416020847O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460833727, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:11:33> UPDATE USUARIO SET USUA_SESION=^160416021133O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460833893, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:11:33> UPDATE USUARIO SET USUA_SESION=^160416021133O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460833893, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:11:57> UPDATE USUARIO SET USUA_SESION=^160416021157O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460833917, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:11:57> UPDATE USUARIO SET USUA_SESION=^160416021157O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460833917, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:14:18> UPDATE USUARIO SET USUA_SESION=^160416021418O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460834058, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:14:18> UPDATE USUARIO SET USUA_SESION=^160416021418O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460834058, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:25:45> UPDATE USUARIO SET USUA_SESION=^160416022545O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460834745, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:25:45> UPDATE USUARIO SET USUA_SESION=^160416022545O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460834745, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:30:07> UPDATE USUARIO SET USUA_SESION=^160416023007O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460835007, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:30:07> UPDATE USUARIO SET USUA_SESION=^160416023007O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460835007, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:30:18> UPDATE USUARIO SET USUA_SESION=^160416023018O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460835018, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:30:18> UPDATE USUARIO SET USUA_SESION=^160416023018O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460835018, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:32:12> UPDATE USUARIO SET USUA_SESION=^160416023212O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460835132, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:32:12> UPDATE USUARIO SET USUA_SESION=^160416023212O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460835132, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:32:19> UPDATE USUARIO SET USUA_SESION=^160416023219O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460835139, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:32:19> UPDATE USUARIO SET USUA_SESION=^160416023219O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460835139, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:32:36> UPDATE USUARIO SET USUA_SESION=^160416023236O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460835156, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:32:36> UPDATE USUARIO SET USUA_SESION=^160416023236O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460835156, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:33:11> UPDATE USUARIO SET USUA_SESION=^160416023311O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460835191, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:33:11> UPDATE USUARIO SET USUA_SESION=^160416023311O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460835191, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:34:18> UPDATE USUARIO SET USUA_SESION=^160416023418O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460835258, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:34:18> UPDATE USUARIO SET USUA_SESION=^160416023418O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460835258, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:37:48> UPDATE USUARIO SET USUA_SESION=^160416023748O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460835468, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:37:48> UPDATE USUARIO SET USUA_SESION=^160416023748O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460835468, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:44:09> UPDATE USUARIO SET USUA_SESION=^160416024409O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460835849, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:44:09> UPDATE USUARIO SET USUA_SESION=^160416024409O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460835849, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:45:10> UPDATE USUARIO SET USUA_SESION=^160416024510O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460835910, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 14:45:10> UPDATE USUARIO SET USUA_SESION=^160416024510O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460835910, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 15:05:02> UPDATE USUARIO SET USUA_SESION=^160416030502O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460837102, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-16 15:05:02> UPDATE USUARIO SET USUA_SESION=^160416030502O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460837102, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-18 10:36:59> UPDATE USUARIO SET USUA_SESION=^160418103659O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460993819, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-18 10:36:59> UPDATE USUARIO SET USUA_SESION=^160418103659O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1460993819, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('', 'u', '', '2016-04-18 12:36:09> UPDATE
                    USUARIO
               SET
                    USUA_SESION =^FIN  2016:04:18 12:0436:09^
               WHERE
                    USUA_SESION LIKE ^%160418103659O127001ADMON%^', 1461000969, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('', 'u', '', '2016-04-18 12:36:09> UPDATE
                    USUARIO
               SET
                    USUA_SESION =^FIN  2016:04:18 12:0436:09^
               WHERE
                    USUA_SESION LIKE ^%160418103659O127001ADMON%^', 1461000969, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-18 12:36:12> UPDATE USUARIO SET USUA_SESION=^160418123612O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1461000972, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-18 12:36:12> UPDATE USUARIO SET USUA_SESION=^160418123612O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1461000972, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-18 19:35:21> UPDATE USUARIO SET USUA_SESION=^160418073521O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1461026121, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', 'USUARIO', '2016-04-18 19:35:21> UPDATE USUARIO SET USUA_SESION=^160418073521O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ ', 1461026121, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', '', '2016-04-18 19:35:40> UPDATE
                    USUARIO
               SET
                    USUA_SESION =^FIN  2016:04:18 19:0435:40^
               WHERE
                    USUA_SESION LIKE ^%160418073521O127001ADMON%^', 1461026140, '127.0.0.1 - ');
INSERT INTO sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) VALUES ('1999999', 'u', '', '2016-04-18 19:35:40> UPDATE
                    USUARIO
               SET
                    USUA_SESION =^FIN  2016:04:18 19:0435:40^
               WHERE
                    USUA_SESION LIKE ^%160418073521O127001ADMON%^', 1461026140, '127.0.0.1 - ');


--
-- TOC entry 2959 (class 0 OID 17937)
-- Dependencies: 211
-- Data for Name: sgd_camexp_campoexpediente; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2960 (class 0 OID 17944)
-- Dependencies: 212
-- Data for Name: sgd_carp_descripcion; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2961 (class 0 OID 17947)
-- Dependencies: 213
-- Data for Name: sgd_cau_causal; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO sgd_cau_causal (sgd_cau_codigo, sgd_cau_descrip) VALUES (1, 'Facturacion');
INSERT INTO sgd_cau_causal (sgd_cau_codigo, sgd_cau_descrip) VALUES (2, 'Instalacion');
INSERT INTO sgd_cau_causal (sgd_cau_codigo, sgd_cau_descrip) VALUES (3, 'Prestacion');
INSERT INTO sgd_cau_causal (sgd_cau_codigo, sgd_cau_descrip) VALUES (0, '---');


--
-- TOC entry 2962 (class 0 OID 17950)
-- Dependencies: 214
-- Data for Name: sgd_caux_causales; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2963 (class 0 OID 17954)
-- Dependencies: 215
-- Data for Name: sgd_ciu_ciudadano; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2964 (class 0 OID 17962)
-- Dependencies: 216
-- Data for Name: sgd_clta_clstarif; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO sgd_clta_clstarif (sgd_fenv_codigo, sgd_clta_codser, sgd_tar_codigo, sgd_clta_descrip, sgd_clta_pesdes, sgd_clta_peshast) VALUES (101, 1, 1, 'Envio normal de 1 a 500 Gr', 1, 500);
INSERT INTO sgd_clta_clstarif (sgd_fenv_codigo, sgd_clta_codser, sgd_tar_codigo, sgd_clta_descrip, sgd_clta_pesdes, sgd_clta_peshast) VALUES (115, 1, 1, 'Llevar via mensajero.', 0, 1000);
INSERT INTO sgd_clta_clstarif (sgd_fenv_codigo, sgd_clta_codser, sgd_tar_codigo, sgd_clta_descrip, sgd_clta_pesdes, sgd_clta_peshast) VALUES (101, 2, 8, 'Pruebas ', 10, 1000);
INSERT INTO sgd_clta_clstarif (sgd_fenv_codigo, sgd_clta_codser, sgd_tar_codigo, sgd_clta_descrip, sgd_clta_pesdes, sgd_clta_peshast) VALUES (101, 1, 100, 'Envio normal de 1 a 500 Gr', 1, 500);


--
-- TOC entry 2965 (class 0 OID 17965)
-- Dependencies: 217
-- Data for Name: sgd_cob_campobliga; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO sgd_cob_campobliga (sgd_cob_codi, sgd_cob_desc, sgd_cob_label, sgd_tidm_codi) VALUES (1, 'NOMBRE', 'NOMBRE', 2);
INSERT INTO sgd_cob_campobliga (sgd_cob_codi, sgd_cob_desc, sgd_cob_label, sgd_tidm_codi) VALUES (2, 'DIRECCION', 'DIR', 2);
INSERT INTO sgd_cob_campobliga (sgd_cob_codi, sgd_cob_desc, sgd_cob_label, sgd_tidm_codi) VALUES (3, 'MUNICIPIO', 'MUNI_NOMBRE', 2);
INSERT INTO sgd_cob_campobliga (sgd_cob_codi, sgd_cob_desc, sgd_cob_label, sgd_tidm_codi) VALUES (4, 'DEPARTAMENTO', 'DEPTO_NOMBRE', 2);
INSERT INTO sgd_cob_campobliga (sgd_cob_codi, sgd_cob_desc, sgd_cob_label, sgd_tidm_codi) VALUES (5, 'TIPO', 'TIPO', 2);
INSERT INTO sgd_cob_campobliga (sgd_cob_codi, sgd_cob_desc, sgd_cob_label, sgd_tidm_codi) VALUES (6, 'PAIS', 'PAIS_NOMBRE', 2);


--
-- TOC entry 2966 (class 0 OID 17974)
-- Dependencies: 218
-- Data for Name: sgd_dcau_causal; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2967 (class 0 OID 17977)
-- Dependencies: 219
-- Data for Name: sgd_ddca_ddsgrgdo; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2968 (class 0 OID 17980)
-- Dependencies: 220
-- Data for Name: sgd_def_contactos; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2969 (class 0 OID 17983)
-- Dependencies: 221
-- Data for Name: sgd_def_continentes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO sgd_def_continentes (id_cont, nombre_cont) VALUES (1, 'America');


--
-- TOC entry 2970 (class 0 OID 17986)
-- Dependencies: 222
-- Data for Name: sgd_def_paises; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO sgd_def_paises (id_pais, id_cont, nombre_pais) VALUES (166, 1, 'PERU');
INSERT INTO sgd_def_paises (id_pais, id_cont, nombre_pais) VALUES (29, 1, 'BRASIL');
INSERT INTO sgd_def_paises (id_pais, id_cont, nombre_pais) VALUES (25, 1, 'BOLIVIA');
INSERT INTO sgd_def_paises (id_pais, id_cont, nombre_pais) VALUES (223, 1, 'USA');
INSERT INTO sgd_def_paises (id_pais, id_cont, nombre_pais) VALUES (137, 1, 'MEXICO');
INSERT INTO sgd_def_paises (id_pais, id_cont, nombre_pais) VALUES (170, 1, 'COLOMBIA');


--
-- TOC entry 2971 (class 0 OID 17990)
-- Dependencies: 223
-- Data for Name: sgd_deve_dev_envio; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO sgd_deve_dev_envio (sgd_deve_codigo, sgd_deve_desc) VALUES (1, 'CASA DESOCUPADA');
INSERT INTO sgd_deve_dev_envio (sgd_deve_codigo, sgd_deve_desc) VALUES (2, 'CAMBIO DE DOMICILIO');
INSERT INTO sgd_deve_dev_envio (sgd_deve_codigo, sgd_deve_desc) VALUES (99, 'SOBREPASO TIEMPO DE ESPERA');
INSERT INTO sgd_deve_dev_envio (sgd_deve_codigo, sgd_deve_desc) VALUES (3, 'CERRADO');
INSERT INTO sgd_deve_dev_envio (sgd_deve_codigo, sgd_deve_desc) VALUES (4, 'DESCONOCIDO');
INSERT INTO sgd_deve_dev_envio (sgd_deve_codigo, sgd_deve_desc) VALUES (5, 'DEVUELTO DE PORTERIA');
INSERT INTO sgd_deve_dev_envio (sgd_deve_codigo, sgd_deve_desc) VALUES (6, 'DIRECCION DEFICIENTE');
INSERT INTO sgd_deve_dev_envio (sgd_deve_codigo, sgd_deve_desc) VALUES (7, 'FALLECIDO');
INSERT INTO sgd_deve_dev_envio (sgd_deve_codigo, sgd_deve_desc) VALUES (8, 'NO EXISTE NUMERO');
INSERT INTO sgd_deve_dev_envio (sgd_deve_codigo, sgd_deve_desc) VALUES (9, 'NO RESIDE');
INSERT INTO sgd_deve_dev_envio (sgd_deve_codigo, sgd_deve_desc) VALUES (10, 'NO RECLAMADO');
INSERT INTO sgd_deve_dev_envio (sgd_deve_codigo, sgd_deve_desc) VALUES (11, 'REHUSADO');
INSERT INTO sgd_deve_dev_envio (sgd_deve_codigo, sgd_deve_desc) VALUES (12, 'SE TRASLADO');
INSERT INTO sgd_deve_dev_envio (sgd_deve_codigo, sgd_deve_desc) VALUES (13, 'NO EXISTE EMPRESA');
INSERT INTO sgd_deve_dev_envio (sgd_deve_codigo, sgd_deve_desc) VALUES (14, 'ZONA DE ALTO RIESGO');
INSERT INTO sgd_deve_dev_envio (sgd_deve_codigo, sgd_deve_desc) VALUES (15, 'SOBRE DESOCUPADO');
INSERT INTO sgd_deve_dev_envio (sgd_deve_codigo, sgd_deve_desc) VALUES (16, 'FUERA PERIMETRO URBANO');
INSERT INTO sgd_deve_dev_envio (sgd_deve_codigo, sgd_deve_desc) VALUES (17, 'ENVIADO A ADPOSTAL, CONTROL DE CALIDAD');
INSERT INTO sgd_deve_dev_envio (sgd_deve_codigo, sgd_deve_desc) VALUES (18, 'SIN SELLO');
INSERT INTO sgd_deve_dev_envio (sgd_deve_codigo, sgd_deve_desc) VALUES (90, 'DOCUMENTO MAL RADICADO');


--
-- TOC entry 2972 (class 0 OID 17995)
-- Dependencies: 224
-- Data for Name: sgd_dir_drecciones; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3072 (class 0 OID 0)
-- Dependencies: 225
-- Name: sgd_dir_drecciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sgd_dir_drecciones_id_seq', 1, true);


--
-- TOC entry 2974 (class 0 OID 18005)
-- Dependencies: 226
-- Data for Name: sgd_dnufe_docnufe; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2975 (class 0 OID 18014)
-- Dependencies: 227
-- Data for Name: sgd_einv_inventario; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2976 (class 0 OID 18020)
-- Dependencies: 228
-- Data for Name: sgd_eit_items; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2977 (class 0 OID 18027)
-- Dependencies: 229
-- Data for Name: sgd_empus_empusuario; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2978 (class 0 OID 18033)
-- Dependencies: 230
-- Data for Name: sgd_enve_envioespecial; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2979 (class 0 OID 18045)
-- Dependencies: 231
-- Data for Name: sgd_exp_expediente; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3073 (class 0 OID 0)
-- Dependencies: 232
-- Name: sgd_exp_expediente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sgd_exp_expediente_id_seq', 1, true);


--
-- TOC entry 2981 (class 0 OID 18055)
-- Dependencies: 233
-- Data for Name: sgd_fenv_frmenvio; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO sgd_fenv_frmenvio (sgd_fenv_codigo, sgd_fenv_descrip, sgd_fenv_estado, sgd_fenv_planilla) VALUES (102, 'SERVIENTREGA', 1, 0);
INSERT INTO sgd_fenv_frmenvio (sgd_fenv_codigo, sgd_fenv_descrip, sgd_fenv_estado, sgd_fenv_planilla) VALUES (103, 'ENTREGA PERSONAL', 1, 0);
INSERT INTO sgd_fenv_frmenvio (sgd_fenv_codigo, sgd_fenv_descrip, sgd_fenv_estado, sgd_fenv_planilla) VALUES (104, 'FAX', 1, 0);
INSERT INTO sgd_fenv_frmenvio (sgd_fenv_codigo, sgd_fenv_descrip, sgd_fenv_estado, sgd_fenv_planilla) VALUES (105, 'POSTEXPRESS', 1, 0);
INSERT INTO sgd_fenv_frmenvio (sgd_fenv_codigo, sgd_fenv_descrip, sgd_fenv_estado, sgd_fenv_planilla) VALUES (106, 'CORREO ELECTRONICO', 1, 0);
INSERT INTO sgd_fenv_frmenvio (sgd_fenv_codigo, sgd_fenv_descrip, sgd_fenv_estado, sgd_fenv_planilla) VALUES (107, 'CORRA', 1, 0);
INSERT INTO sgd_fenv_frmenvio (sgd_fenv_codigo, sgd_fenv_descrip, sgd_fenv_estado, sgd_fenv_planilla) VALUES (108, 'NORMAL', 1, 0);
INSERT INTO sgd_fenv_frmenvio (sgd_fenv_codigo, sgd_fenv_descrip, sgd_fenv_estado, sgd_fenv_planilla) VALUES (109, 'CERTIFICADO CON ACUSE ', 1, 0);
INSERT INTO sgd_fenv_frmenvio (sgd_fenv_codigo, sgd_fenv_descrip, sgd_fenv_estado, sgd_fenv_planilla) VALUES (901, 'NO ENVIADO', 1, 0);
INSERT INTO sgd_fenv_frmenvio (sgd_fenv_codigo, sgd_fenv_descrip, sgd_fenv_estado, sgd_fenv_planilla) VALUES (902, 'SOPORTE DIGITALIZADO', 1, 0);
INSERT INTO sgd_fenv_frmenvio (sgd_fenv_codigo, sgd_fenv_descrip, sgd_fenv_estado, sgd_fenv_planilla) VALUES (110, 'INTER RAPIDISIMO', 1, 0);
INSERT INTO sgd_fenv_frmenvio (sgd_fenv_codigo, sgd_fenv_descrip, sgd_fenv_estado, sgd_fenv_planilla) VALUES (115, 'Mensajero1', 1, 1);
INSERT INTO sgd_fenv_frmenvio (sgd_fenv_codigo, sgd_fenv_descrip, sgd_fenv_estado, sgd_fenv_planilla) VALUES (101, 'CERTIFICADO', 1, 0);


--
-- TOC entry 2982 (class 0 OID 18060)
-- Dependencies: 234
-- Data for Name: sgd_fexp_flujoexpedientes; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2983 (class 0 OID 18063)
-- Dependencies: 235
-- Data for Name: sgd_firrad_firmarads; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2984 (class 0 OID 18069)
-- Dependencies: 236
-- Data for Name: sgd_fld_flujodoc; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2985 (class 0 OID 18075)
-- Dependencies: 237
-- Data for Name: sgd_fun_funciones; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2986 (class 0 OID 18081)
-- Dependencies: 238
-- Data for Name: sgd_hfld_histflujodoc; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3074 (class 0 OID 0)
-- Dependencies: 239
-- Name: sgd_hfld_histflujodoc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sgd_hfld_histflujodoc_id_seq', 1, true);


--
-- TOC entry 2988 (class 0 OID 18089)
-- Dependencies: 240
-- Data for Name: sgd_hmtd_hismatdoc; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2989 (class 0 OID 18104)
-- Dependencies: 241
-- Data for Name: sgd_masiva_excel; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2990 (class 0 OID 18107)
-- Dependencies: 242
-- Data for Name: sgd_mat_matriz; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2991 (class 0 OID 18113)
-- Dependencies: 243
-- Data for Name: sgd_mrd_matrird; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2992 (class 0 OID 18118)
-- Dependencies: 244
-- Data for Name: sgd_msdep_msgdep; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2993 (class 0 OID 18121)
-- Dependencies: 245
-- Data for Name: sgd_msg_mensaje; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO sgd_msg_mensaje (sgd_msg_codi, sgd_tme_codi, sgd_msg_desc, sgd_msg_fechdesp, sgd_msg_url, sgd_msg_veces, sgd_msg_ancho, sgd_msg_largo, sgd_msg_etiqueta) VALUES (100, 100, 'Para su información', '2014-07-31 00:00:00', 'http://locahost', 0, 0, 0, 'Información');
INSERT INTO sgd_msg_mensaje (sgd_msg_codi, sgd_tme_codi, sgd_msg_desc, sgd_msg_fechdesp, sgd_msg_url, sgd_msg_veces, sgd_msg_ancho, sgd_msg_largo, sgd_msg_etiqueta) VALUES (104, 104, 'Para comentarios', '2014-08-26 00:00:00', 'http://localhost', 0, 0, 0, 'Comentarios');
INSERT INTO sgd_msg_mensaje (sgd_msg_codi, sgd_tme_codi, sgd_msg_desc, sgd_msg_fechdesp, sgd_msg_url, sgd_msg_veces, sgd_msg_ancho, sgd_msg_largo, sgd_msg_etiqueta) VALUES (105, 105, 'Para hablar conmigo del asunto', '2014-08-26 00:00:00', 'http://localhost', 0, 0, 0, 'Hablar  Asunto');
INSERT INTO sgd_msg_mensaje (sgd_msg_codi, sgd_tme_codi, sgd_msg_desc, sgd_msg_fechdesp, sgd_msg_url, sgd_msg_veces, sgd_msg_ancho, sgd_msg_largo, sgd_msg_etiqueta) VALUES (106, 106, 'Para atender con prioridad', '2014-08-26 00:00:00', 'http://localhost', 0, 0, 0, 'Prioridad Alta');
INSERT INTO sgd_msg_mensaje (sgd_msg_codi, sgd_tme_codi, sgd_msg_desc, sgd_msg_fechdesp, sgd_msg_url, sgd_msg_veces, sgd_msg_ancho, sgd_msg_largo, sgd_msg_etiqueta) VALUES (101, 101, 'Para encargarse del asunto', '2014-07-31 00:00:00', 'http://localhost', 0, 0, 0, 'Asunto');
INSERT INTO sgd_msg_mensaje (sgd_msg_codi, sgd_tme_codi, sgd_msg_desc, sgd_msg_fechdesp, sgd_msg_url, sgd_msg_veces, sgd_msg_ancho, sgd_msg_largo, sgd_msg_etiqueta) VALUES (103, 103, 'Para su consideración y firma', '2014-08-26 00:00:00', 'htpp://localhost', 0, 0, 0, 'Firma');
INSERT INTO sgd_msg_mensaje (sgd_msg_codi, sgd_tme_codi, sgd_msg_desc, sgd_msg_fechdesp, sgd_msg_url, sgd_msg_veces, sgd_msg_ancho, sgd_msg_largo, sgd_msg_etiqueta) VALUES (102, 102, 'Preparar respuesta para firma', '2014-07-31 00:00:00', 'http://localhost', 0, 0, 0, 'Respuesta firma');


--
-- TOC entry 2994 (class 0 OID 18124)
-- Dependencies: 246
-- Data for Name: sgd_mtd_matriz_doc; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2995 (class 0 OID 18133)
-- Dependencies: 247
-- Data for Name: sgd_noh_nohabiles; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2996 (class 0 OID 18136)
-- Dependencies: 248
-- Data for Name: sgd_not_notificacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO sgd_not_notificacion (sgd_not_codi, sgd_not_descrip) VALUES (4, 'CONDUCTA CONCLUYENTE');
INSERT INTO sgd_not_notificacion (sgd_not_codi, sgd_not_descrip) VALUES (1, 'PERSONAL');
INSERT INTO sgd_not_notificacion (sgd_not_codi, sgd_not_descrip) VALUES (3, 'EDICTO');


--
-- TOC entry 2997 (class 0 OID 18139)
-- Dependencies: 249
-- Data for Name: sgd_novedad_usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2998 (class 0 OID 18145)
-- Dependencies: 250
-- Data for Name: sgd_ntrd_notifrad; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2999 (class 0 OID 18148)
-- Dependencies: 251
-- Data for Name: sgd_oem_oempresas; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3000 (class 0 OID 18159)
-- Dependencies: 252
-- Data for Name: sgd_param_admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO sgd_param_admin (param_codigo, param_nombre, param_desc, param_valor) VALUES ('1', 'ALERT_FUNCTION', '1', '1');


--
-- TOC entry 3001 (class 0 OID 18165)
-- Dependencies: 253
-- Data for Name: sgd_parametro; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO sgd_parametro (param_nomb, param_codi, param_valor) VALUES ('PRESTAMO_ESTADO', 5, 'Prestamo Indefinido');
INSERT INTO sgd_parametro (param_nomb, param_codi, param_valor) VALUES ('PRESTAMO_REQUERIMIENTO', 1, 'Documento');
INSERT INTO sgd_parametro (param_nomb, param_codi, param_valor) VALUES ('PRESTAMO_REQUERIMIENTO', 2, 'Anexo');
INSERT INTO sgd_parametro (param_nomb, param_codi, param_valor) VALUES ('PRESTAMO_REQUERIMIENTO', 3, 'Documento y Anexo');
INSERT INTO sgd_parametro (param_nomb, param_codi, param_valor) VALUES ('PRESTAMO_DIAS_PREST', 1, '8');
INSERT INTO sgd_parametro (param_nomb, param_codi, param_valor) VALUES ('PRESTAMO_DIAS_CANC', 1, '2');
INSERT INTO sgd_parametro (param_nomb, param_codi, param_valor) VALUES ('PRESTAMO_ESTADO', 4, 'Cancelado');
INSERT INTO sgd_parametro (param_nomb, param_codi, param_valor) VALUES ('PRESTAMO_ESTADO', 3, 'Devuelto');
INSERT INTO sgd_parametro (param_nomb, param_codi, param_valor) VALUES ('PRESTAMO_ESTADO', 2, 'Prestado');
INSERT INTO sgd_parametro (param_nomb, param_codi, param_valor) VALUES ('PRESTAMO_ESTADO', 1, 'Solicitado');
INSERT INTO sgd_parametro (param_nomb, param_codi, param_valor) VALUES ('PRESTAMO_REQUERIMIENTO', 4, 'Expediente');
INSERT INTO sgd_parametro (param_nomb, param_codi, param_valor) VALUES ('PRESTAMO_ESTADO', 6, 'Devolver al Proveedor');
INSERT INTO sgd_parametro (param_nomb, param_codi, param_valor) VALUES ('PRESTAMO_PASW', 1, '123');


--
-- TOC entry 3002 (class 0 OID 18168)
-- Dependencies: 254
-- Data for Name: sgd_parexp_paramexpediente; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3075 (class 0 OID 0)
-- Dependencies: 255
-- Name: sgd_parexp_paramexpediente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sgd_parexp_paramexpediente_id_seq', 1, true);


--
-- TOC entry 3004 (class 0 OID 18174)
-- Dependencies: 256
-- Data for Name: sgd_pexp_procexpedientes; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3005 (class 0 OID 18182)
-- Dependencies: 257
-- Data for Name: sgd_plan_plantillas; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3076 (class 0 OID 0)
-- Dependencies: 258
-- Name: sgd_plan_plantillas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sgd_plan_plantillas_id_seq', 1, true);


--
-- TOC entry 3007 (class 0 OID 18190)
-- Dependencies: 259
-- Data for Name: sgd_pnufe_procnumfe; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3008 (class 0 OID 18193)
-- Dependencies: 260
-- Data for Name: sgd_pnun_procenum; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3009 (class 0 OID 18196)
-- Dependencies: 261
-- Data for Name: sgd_prc_proceso; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3010 (class 0 OID 18199)
-- Dependencies: 262
-- Data for Name: sgd_prd_prcdmentos; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3011 (class 0 OID 18202)
-- Dependencies: 263
-- Data for Name: sgd_rda_retdoca; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3012 (class 0 OID 18205)
-- Dependencies: 264
-- Data for Name: sgd_rdf_retdocf; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3077 (class 0 OID 0)
-- Dependencies: 265
-- Name: sgd_rdf_retdocf_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sgd_rdf_retdocf_id_seq', 1, true);


--
-- TOC entry 3014 (class 0 OID 18210)
-- Dependencies: 266
-- Data for Name: sgd_renv_regenvio; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3078 (class 0 OID 0)
-- Dependencies: 267
-- Name: sgd_renv_regenvio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sgd_renv_regenvio_id_seq', 1, true);


--
-- TOC entry 3016 (class 0 OID 18233)
-- Dependencies: 268
-- Data for Name: sgd_rmr_radmasivre; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3017 (class 0 OID 18236)
-- Dependencies: 269
-- Data for Name: sgd_san_sancionados; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3018 (class 0 OID 18242)
-- Dependencies: 270
-- Data for Name: sgd_sbrd_subserierd; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3019 (class 0 OID 18251)
-- Dependencies: 271
-- Data for Name: sgd_senuf_secnumfe; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3020 (class 0 OID 18254)
-- Dependencies: 272
-- Data for Name: sgd_sexp_secexpedientes; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3079 (class 0 OID 0)
-- Dependencies: 273
-- Name: sgd_sexp_secexpedientes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sgd_sexp_secexpedientes_id_seq', 1, true);


--
-- TOC entry 3022 (class 0 OID 18272)
-- Dependencies: 274
-- Data for Name: sgd_srd_seriesrd; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3023 (class 0 OID 18275)
-- Dependencies: 275
-- Data for Name: sgd_tar_tarifas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO sgd_tar_tarifas (sgd_fenv_codigo, sgd_tar_codigo, sgd_tar_valenv1, sgd_tar_valenv2, sgd_tar_valenv1g1, sgd_clta_codser, sgd_tar_valenv2g2, sgd_clta_descrip) VALUES (101, 1, 5700, 6700, 0, 1, 0, NULL);
INSERT INTO sgd_tar_tarifas (sgd_fenv_codigo, sgd_tar_codigo, sgd_tar_valenv1, sgd_tar_valenv2, sgd_tar_valenv1g1, sgd_clta_codser, sgd_tar_valenv2g2, sgd_clta_descrip) VALUES (115, 1, 1, 1, 0, 1, 0, NULL);
INSERT INTO sgd_tar_tarifas (sgd_fenv_codigo, sgd_tar_codigo, sgd_tar_valenv1, sgd_tar_valenv2, sgd_tar_valenv1g1, sgd_clta_codser, sgd_tar_valenv2g2, sgd_clta_descrip) VALUES (101, 8, 0, 0, 10, 2, 1000, NULL);
INSERT INTO sgd_tar_tarifas (sgd_fenv_codigo, sgd_tar_codigo, sgd_tar_valenv1, sgd_tar_valenv2, sgd_tar_valenv1g1, sgd_clta_codser, sgd_tar_valenv2g2, sgd_clta_descrip) VALUES (101, 100, 5700, 6700, 0, 1, 0, NULL);


--
-- TOC entry 3024 (class 0 OID 18278)
-- Dependencies: 276
-- Data for Name: sgd_tdec_tipodecision; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3025 (class 0 OID 18293)
-- Dependencies: 277
-- Data for Name: sgd_tip3_tipotercero; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO sgd_tip3_tipotercero (sgd_tip3_codigo, sgd_dir_tipo, sgd_tip3_nombre, sgd_tip3_desc, sgd_tip3_imgpestana, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_tp3, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (2, 1, 'DESTINATARIO', 'DESTINATARIO', 'tip3destina.jpg', 1, 0, 1, 1, 1, 1);
INSERT INTO sgd_tip3_tipotercero (sgd_tip3_codigo, sgd_dir_tipo, sgd_tip3_nombre, sgd_tip3_desc, sgd_tip3_imgpestana, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_tp3, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (3, 2, 'PREDIO', 'PREDIO', 'tip3predio.jpg', 1, 1, 1, 1, 1, 1);
INSERT INTO sgd_tip3_tipotercero (sgd_tip3_codigo, sgd_dir_tipo, sgd_tip3_nombre, sgd_tip3_desc, sgd_tip3_imgpestana, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_tp3, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (4, 3, 'ENTIDAD', 'ENTIDAD', 'tip3esp.jpg', 1, 1, 1, 1, 1, 1);
INSERT INTO sgd_tip3_tipotercero (sgd_tip3_codigo, sgd_dir_tipo, sgd_tip3_nombre, sgd_tip3_desc, sgd_tip3_imgpestana, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_tp3, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (1, 1, 'REMITENTE', 'REMITENTE', 'tip3remitente.jpg', 0, 1, 0, 0, 0, 1);


--
-- TOC entry 3026 (class 0 OID 18302)
-- Dependencies: 278
-- Data for Name: sgd_tma_temas; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3027 (class 0 OID 18305)
-- Dependencies: 279
-- Data for Name: sgd_tme_tipmen; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO sgd_tme_tipmen (sgd_tme_codi) VALUES (1);


--
-- TOC entry 3028 (class 0 OID 18308)
-- Dependencies: 280
-- Data for Name: sgd_tpr_tpdcumento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (2, 'Acta', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (3, 'Acta aprobación de garantía única', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (4, 'Acta de anulación de certificado de disponibilidad presupuestal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (5, 'Acta de anulación de saldos no comprometidos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (6, 'Acta de Apertura', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (7, 'Acta de aprobación del plan financiero', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (8, 'Acta de audiencia Asignación de riesgos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (9, 'Acta de Audiencia de Adjudicación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (10, 'Acta de Audiencia de precalificación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (11, 'Acta de cierre de la mesa', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (12, 'Acta de cierre y apertura de propuestas ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (13, 'Acta de comité', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (14, 'Acta de comité de conciliación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (15, 'Acta de concertación del PIGA', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (16, 'Acta de conciliación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (17, 'Acta de conformación del COPASO', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (18, 'Acta de designación comité evaluador', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (19, 'Acta de entrega de los bienes por contrato de comodato', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (20, 'Acta de entrega del bien por donación  traslado o traspaso', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (21, 'Acta de entrega del predio', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (22, 'Acta de entrega y recibo de bienes', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (24, 'Acta de escrutinio con número de votos depositados por mesa', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (25, 'Acta de escrutinio con número total de sufragantes', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (26, 'Acta de escrutinio general', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (27, 'Acta de finalización o recibo de satisfacción ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (28, 'Acta de informe de gestión', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (29, 'Acta de inicio', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (30, 'Acta de instalación de la mesa', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (31, 'Acta de la subasta presencial o electrónica', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (32, 'Acta de liquidación ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (33, 'Acta de liquidación contrato', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (34, 'Acta de liquidación de compromiso presupuestal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (35, 'Acta de liquidación de contrato con anexos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (36, 'Acta de posesión', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (37, 'Acta de recibo de propuestas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (38, 'Acta de recibo final para la terminación de contrato', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (39, 'Acta de Reparto  ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (40, 'Acta de Reparto Notarial ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (41, 'Acta de reunión de COPASO', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (42, 'Acta de reunión de presentación y aprobación del plan', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (43, 'Acta de reunión del CONFIS', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (45, 'Acta de revisión por la dirección', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (46, 'Acta de supervisión', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (47, 'Acta de Verificación de oferta económica y Acuerdo con el oferente calificado en primer lugar.', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (48, 'Acta del comité de inventario', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (49, 'Acta del comité interno de conciliación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (51, 'Acta Visita administrativa', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (52, 'Actas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (53, 'Actas de Comité de Contratación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (54, 'Actas de reunión', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (55, 'Actas de reuniones clientes potenciales', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (56, 'Actas de supervisión', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (57, 'Acto administrativo autorizando la licencia por paternidad o adopción', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (58, 'Acto administrativo de aprobación del traslado presupuestal (Acta  resolución o acuerdo de la junta directiva)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (59, 'Acto administrativo de baja o alta de bienes motivado en la toma', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (60, 'Acto administrativo de conformación del COPASO', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (61, 'Acto administrativo de convocatoria para elecciones de representantes COPASO', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (62, 'Acto administrativo de liquidación unilateral', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (63, 'Acto administrativo de modificación de la planta', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (64, 'Acto administrativo de suspensión o aplazamiento presupuestal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (65, 'Acto administrativo del retiro del funcionario', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (66, 'Acto administrativo que ordenaria la ejecución de la sanción', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (67, 'Acuerdo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (68, 'Acuerdo de expedición del presupuesto', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (69, 'Acuerdo de la junta directiva dando concepto favorable al proyecto de presupuesto', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (70, 'Acuerdo de modificación presupuestal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (73, 'Adendas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (74, 'Adendas (si hay lugar)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (75, 'Administración del Edificio', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (76, 'Afiliación al fondo de pensiones y salud', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (77, 'Alegatos de conclusión', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (78, 'Análisis del entorno', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (79, 'Anexo Memorando Interno solicitud para facturar', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (80, 'Anexos (Copia Consignación  transferencia electrónica).', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (81, 'Antecedentes', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (82, 'Antecedentes judiciales', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (83, 'Antecedentes propios de tipo contractual', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (84, 'Anteproyecto de presupuesto', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (85, 'Audiencia pacto de cumplimiento', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (86, 'Audiencia y fallo proceso verbal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (87, 'Auto admisorio de la acción', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (88, 'Auto admisorio y/o inadmisorio', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (89, 'Auto apertura investigación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (90, 'Auto citación audiencia', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (91, 'Auto concediendo recurso de apelación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (92, 'Auto concediendo recurso de queja', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (93, 'Auto corriendo traslado para alegar de conclusión', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (94, 'Auto de acumulación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (95, 'Auto de archivo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (96, 'Auto de incorporación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (97, 'Auto de indagación preliminar averiguación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (98, 'Auto de indagación preliminar implicado', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (99, 'Auto de nulidad', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (100, 'Auto de remisión por competencia a otro operador interno', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (101, 'Auto de remisión por competencia poder preferente', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (102, 'Auto declarando desierto recurso', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (103, 'Auto declarando desierto recurso de queja', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (104, 'Auto declarando precluido el recurso de queja', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (105, 'Auto declaratoria ausencia', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (107, 'Auto decreta pruebas descargos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (108, 'Auto desatando la apelación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (109, 'Auto inhibitorio', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (110, 'Auto niega pruebas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (111, 'Auto nombramiento defensor', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (112, 'Auto nombramiento defensor de oficio', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (113, 'Auto obedezcase y cúmplase', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (114, 'Auto prorroga término investigación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (115, 'Auto que inadmite la revocatoria directa', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (116, 'Auto que rechaza la revocatoria directa', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (117, 'Auto rechazando recurso de apelación extemporaneo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (118, 'Auto rechazando recurso de apelación improcedente', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (119, 'Auto rechazando recurso de queja extemporáneo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (120, 'Auto rechazando recurso de reposición extemporaneo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (121, 'Auto rechazando recurso de reposición improcedente', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (122, 'Auto remisión por competencia', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (123, 'Auto resolviendo recurso reposición', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (125, 'Autorización de descuento ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (124, 'Auto variación pilego de cargos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (127, 'Autorización de Pago a Terceros', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (128, 'Autorización para subarrendar el predio', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (129, 'Avalúo Comercial del predio', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (130, 'Aviso de convocatoria', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (131, 'backup', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (132, 'Balance General', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (133, 'Balance General  certificado por contador', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (134, 'Base de Datos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (135, 'Boletín Catastral', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (136, 'Carta de aceptación de la oferta de Compra', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (137, 'CDP', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (138, 'Certificación bancaria', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (140, 'Certificación de información laboral para la emisión de bono pensional', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (141, 'Certificación de la cuenta bancaria', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (142, 'Certificación de pago de cesantías del fondo Nacional del Ahorro ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (322, 'Conciliación prejudicial', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (144, 'Certificación de pago del servicio prestado', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (145, 'Certificación de tradición y libertad (cesantías para liberación de gravámenes)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (146, 'Certificación del banco de apertura de cuenta', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (147, 'Certificación del Ministerio de Educación avalando la institución educativa (cesantías para educación)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (148, 'Certificación importación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (149, 'Certificación laboral de funciones y/o salarial', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (150, 'Certificación médica', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (151, 'Certificación nacionalización vehículo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (152, 'Certificaciones de experiencia', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (153, 'Certificado de  capacidad  idoneidad y experiencia', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (154, 'Certificado de antecedentes de la Contraloría General de la República', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (155, 'Certificado de antecedentes disciplinarios de la Personería de Bogotá', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (156, 'Certificado de antecedentes disciplinarios de la procuraduría', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (158, 'Certificado de antecedentes disciplinarios del Consejo Superior de la Judicatura (para abogados) (persona natural)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (160, 'Certificado de antecedentes penales de la Policía Nacional', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (159, 'Certificado de antecedentes fiscales  de la Contraloría General de la Nación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (161, 'Certificado de antecedentes profesionales', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (162, 'Certificado de aportes parafiscales para personas naturales o jurídicas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (163, 'Certificado de compromiso de reservas presupuéstales', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (164, 'Certificado de Cumplimiento ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (165, 'Certificado de defunción', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (166, 'Certificado de disminución de la base de retención en la fuente por concepto de salud prepagada', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (167, 'Certificado de Disponibilidad Presupuestal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (168, 'Certificado de disponibilidad presupuestal de los rubros a los cuales se les reduce el presupuesto', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (169, 'Certificado de Existencia y Representación Legal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (170, 'Certificado de existencia y representación Legal -  persona jurídica', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (171, 'Certificado de factores salariales', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (172, 'Certificado de garantía', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (173, 'Certificado de invalidez', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (174, 'Certificado de los antecedentes disciplinarios de la personería', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (175, 'Certificado de paz y salvo de pensión y salud para personas naturales y jurídicas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (176, 'Certificado de Registro Presupuestal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (177, 'Certificado de tradición y libertad (cesantías para compra de vivienda)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (178, 'Certificado del banco donde se tenga la obligación hipotecaria (cesantías para liberación de gravámenes)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (180, 'Certificado o afiliación a pensión', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (181, 'Certificado o afiliación a salud', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (182, 'Certificado para disminución de la base de retención en la fuente por concepto de obligación hipotecaria', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (184, 'Certificados de experiencia laboral', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (183, 'Certificados de estudios', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (185, 'Certificados de formación académica', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (186, 'Certificados de ingresos y retenciones', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (187, 'Certificados de tradición y libertad para estudio de títulos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (188, 'Circular', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (189, 'Circular de cierre presupuestal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (190, 'Circular de programación presupuestal y cronograma presupuestal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (191, 'Circular informando a las áreas el cronograma para la proyección de los ingresos y gastos para la siguiente vigencia', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (192, 'Citación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (193, 'Citación Notificación Oferta de Compra', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (194, 'Citación para ser jurados de votación en elecciones por votación popular', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (195, 'Citación quejoso ratificación y ampliación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (196, 'Citación revisión por la Dirección', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (197, 'Citación testigo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (198, 'Coadyuvancia', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (199, 'Comentarios a los pliegos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (200, 'Comprobante de ajuste', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (201, 'Comprobante de ingreso a almacén o bodega', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (202, 'Comprobante de salida de bienes', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (203, 'Comprobante de salida de bienes por contrato de comodato', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (204, 'Comprobante de salida por donación  traslado o traspaso', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (255, 'Comunicación oficial de renuncia voluntaria', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (253, 'Comunicación oficial de notificación de la resolución que resuelve el recurso de apelación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (252, 'Comunicación oficial de notificación de la resolución para licencia', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (251, 'Comunicación oficial de notificación de la resolución o decreto para la comisión de servicios', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (250, 'Comunicación oficial de notificación de la resolución o decreto para la comisión de estudios', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (249, 'Comunicación oficial de notificación de la resolución de suspensión o aplazamiento', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (248, 'Comunicación oficial de notificación de la resolución de reconocimiento o reajuste de la prima técnica', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (247, 'Comunicación oficial de notificación de la resolución de nombramiento ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (350, 'Cronograma de actividades con la ARL', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (206, 'Comprobante de traslado o salida de bienes de almacén al servicio', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (205, 'Comprobante de traslado de inventarios', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (207, 'Comprobantes de movimiento diario', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (208, 'Comprobantes de reintegro de la tesorería Distrital', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (209, 'Comunicación a organismos de control sobre fallo absolutorio', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (210, 'Comunicación al nominador para la ejecución', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (211, 'Comunicación apertura de indagación preliminar', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (212, 'Comunicación apertura de investigación implicado', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (213, 'Comunicación apertura de investigación personeria', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (214, 'Comunicación apertura de investigación procuraduria', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (216, 'Comunicación auto archivo quejoso', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (215, 'Comunicación auto archivo implicado', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (217, 'Comunicación auto concede apelación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (218, 'Comunicación auto niega recurso de apelación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (219, 'Comunicación auto segunda instancia quejoso', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (220, 'Comunicación citación audiencia implicado', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (221, 'Comunicación citación audiencia personeria', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (222, 'Comunicación citación audiencia procuraduria', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (223, 'Comunicación citación audiencia recursos humanos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (224, 'Comunicación consultorio juridico', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (225, 'Comunicación decreto oficioso de pruebas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (227, 'Comunicación defensor oficio', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (228, 'Comunicación enviando el cronograma de transferencias (CORREO ELECTRONICO)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (229, 'Comunicación fallo absolutorio quejoso', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (230, 'Comunicación fallo de segunda instacia', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (231, 'Comunicación fallo primera instancia implicado', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (232, 'Comunicación implicado no apelante', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (233, 'Comunicación implicado segunda instancia', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (234, 'Comunicación interna de Traslado al funcionario designado para resover la PQRS', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (235, 'Comunicación oficial', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (236, 'Comunicación oficial autorizando el permiso o calamidad domestica', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (237, 'Comunicación oficial citando al comité', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (238, 'Comunicación oficial comunicando la autorización de la comisión de servicios', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (239, 'Comunicación oficial convocando a los miembros del COPASO', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (241, 'Comunicación oficial de divulgación del Plan de Capacitación ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (242, 'Comunicación oficial de divulgación del Programa de Bienestar Social ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (243, 'Comunicación oficial de negación de la prima técnica', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (244, 'Comunicación oficial de notificación a los jurados', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (246, 'Comunicación oficial de notificación de la resolución de insubsistencia del nombramiento de un empleado', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (256, 'Comunicación Oficial de respuesta al peticionario.', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (257, 'Comunicación oficial de solicitud de certificación de información laboral para la emisión de bono pensional', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (258, 'Comunicación oficial de solicitud de encargo de personal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (259, 'Comunicación oficial de solicitud de inclusión de las modificaciones presupuéstales en la agenda del CONFIS', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (260, 'Comunicación oficial de solicitud de inscripción de las actividades de  bienestar ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (261, 'Comunicación oficial de solicitud de liquidación de cesantías parciales o definitivas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (262, 'Comunicación oficial de solicitud de vacaciones', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (263, 'Comunicación oficial de solicitud para comisión de estudios', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (323, 'Conformación lista de oferentes (menor cuantía)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (264, 'Comunicación oficial de solicitud para comisión interna o externa de servicios', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (265, 'Comunicación oficial del CONFIS a cada una de las entidades remitiendo las modificaciones presupuéstales aprobadas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (267, 'Comunicación oficial informando a los entes de control la efectividad de la sanción', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (268, 'Comunicación oficial informando al área las inconsistencias encontradas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (269, 'Comunicación oficial informando al funcionario cuando se hace efectiva la sanción', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (270, 'Comunicación oficial informando el periodo de vacaciones acumuladas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (271, 'Comunicación oficial informando la elección del cargo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (272, 'Comunicación oficial informando la programación de saneamiento ambiental', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (273, 'Comunicación oficial informando la realización del simulacro a las instancias participantes', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (274, 'Comunicación oficial informando que no se requiere saneamiento preventivo ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (275, 'Comunicación oficial negando las cesantías parciales', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (276, 'Comunicación oficial remisoria a la Secretaría Distrital de Planeación de la solicitud de concepto sobre modificación ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (277, 'Comunicación oficial remisoria de las TRD al concejo Distrital de archivos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (278, 'Comunicación oficial remisoria de las TVD al concejo Distrital de archivos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (280, 'Comunicación Oficial remisorio de la PQRS a la dependencia o Etidad competente', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (281, 'Comunicación oficial remisorio de los aportes a cesantías al fondo ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (282, 'Comunicación oficial remitiendo las TRD para concepto de archivo de Bogotá', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (283, 'Comunicación oficial remitiendo las TVD para concepto de archivo de Bogotá', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (284, 'Comunicación oficial renunciando al cargo por jubilación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (285, 'Comunicación oficial solicitando a la Secretaría de Hacienda concepto sobre traslado presupuestal interno ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (286, 'Comunicación oficial solicitando a las secretarías de Hacienda y Planeación la aprobación de la reducción presupuestal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (287, 'Comunicación oficial solicitando concepto sobre suspensión o aplazamiento presupuestal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (288, 'Comunicación oficial solicitando permiso', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (289, 'Comunicación otras autoridades', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (290, 'Comunicación pliego de cargos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (291, 'Comunicación prorroga apertura de investigación implicado', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (292, 'Comunicación registro sanción personeria', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (293, 'Comunicación registro sanción procuraduria', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (294, 'Comunicación remisión expediente segunda instancia', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (295, 'Comunicación remisoria del Acto administrativo de reducción presupuestal a las secretarias de hacienda y planeación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (296, 'Comunicación remisoria del formulario de planta de personal con costos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (297, 'Comunicación solicitando reconocimiento y ajuste de la primera técnica', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (298, 'Comunicación solicitud de documentos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (299, 'Comunicación tramite recurso queja', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (300, 'Comunicación traslado alegatos conclución', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (301, 'Comunicaciones', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (302, 'Comunicaciones internas y externas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (303, 'Comunicaciones Oficiales', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (304, 'Comunicaciones oficiales bancos ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (305, 'Comunicaciones Oficiales Enviadas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (307, 'Comunicaciones Oficiales Recibidas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (306, 'Comunicaciones Oficiales Internas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (308, 'Comunicado oficial remisorio a la Secretaria Distrital de Planeación de la solicitud de concepto sobre modificaciones', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (309, 'Concepto', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (311, 'Concepto de las TRD de archivo de Bogotá', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (312, 'Concepto de las TVD de archivo de Bogotá', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (314, 'Concepto sobre aplazamiento o reducción presupuestal por parte de la Secretaría de Hacienda.', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (310, 'Concepto de Factibilidad', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (313, 'Concepto de Viabilidad', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (315, 'Concepto sobre traslado presupuestal interno emitido por la secretaría de hacienda', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (317, 'Concepto técnico de los bienes susceptibles de baja', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (318, 'Concepto técnico y recomendaciones al proyecto de presupuesto', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (320, 'Conceptos ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (319, 'Concepto validación y valoración social', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (321, 'Conciliación judicial', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (328, 'Constancia de inasistencia', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (335, 'Contrato laboral a termino fijo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (340, 'Convocatoria para conformación de las brigadas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (326, 'Constancia de cumplimiento de pagos al Sistema de Seguridad Social y Parafiscales (personas jurídicas)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (327, 'Constancia de ejecutoria', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (329, 'Constancia de no conciliación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (330, 'Contestación de la acción', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (331, 'Contestación de la demanda', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (332, 'Contestación de la querella', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (333, 'Contrato', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (336, 'Convenio Interadministrativo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (338, 'Convocatoria Cerrada', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (337, 'Convocatoria Abierta pública', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (339, 'Convocatoria de concurso cerrado para trabajadores oficiales', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (341, 'Copia de la cédula de ciudadanía (Conductor)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (342, 'Copia de la licencia de conducción', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (343, 'Copia de la manzana catastral', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (344, 'Copia de la Póliza de seguro ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (346, 'Copia de recibos de servicios públicos del predio', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (353, 'Cronograma de ejecución del plan de mercadeo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (345, 'Copia de la Tarjeta de propiedad', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (347, 'Copia del contrato de arrendamiento  actual', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (348, 'Copia Folio de Matrícula Inmobiliaria ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (349, 'Cotización plan de compras. ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (351, 'Cronograma de actividades para mitigar riesgos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (352, 'Cronograma de ejecución del inventario físico de bienes ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (354, 'Cronograma de transferencias documentales primarias', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (355, 'Croquis del accidente de tránsito', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (356, 'CRP', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (357, 'Cuadro de Clasificación documental', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (359, 'Cuadro preliminar del anteproyecto de ingresos y/o gastos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (358, 'Cuadro de indicadores y cierre financiero', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (360, 'Cuadro y tabla de ventas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (361, 'Declaración ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (362, 'Declaración de ICA de los últimos dos (2) años', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (363, 'Declaración de IVA de los últimos dos (2) años', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (365, 'Declaración escrita a la Empresa de Renovación Urbana', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (366, 'Declaración escrita del propietario del predio', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (367, 'Declaración escrita firmada por arrendatario y arrendador', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (368, 'Declaración extrajuicio de convivencia (cesantías para educación)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (369, 'Declaración juramentada de bienes y rentas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (370, 'Declaración juramentada de no tener procesos de demandas por alimentos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (371, 'Decreto autorizando comisión al exterior del país', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (372, 'Decreto autorizando comisión de servicios', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (373, 'Decreto de comisión por estudios en el exterior', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (374, 'Decreto de liquidación ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (375, 'Decreto de liquidación (Alcalde Mayor)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (376, 'Decreto de reducción presupuestal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (377, 'Demanda', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (378, 'Denuncia', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (379, 'Denuncia del hurto de un bien', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (380, 'Derecho de Peticion', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (381, 'Diagnóstico de la falla del vehículo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (382, 'Directiva', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (383, 'Documentación Antecedentes IDU', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (385, 'Documento convocatoria a la elección del COPASO', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (386, 'Documento de aprobación del Programa de Seguridad y Salud en el trabajo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (387, 'Documento de baja de bien por hurto', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (388, 'Documento de compromiso u oficialización del hallazgo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (389, 'Documento de divulgación de la lista de candidatos inscritos al COPASO', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (390, 'Documento de divulgación del Plan de trabajo de Seguridad y Salud en el trabajo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (391, 'Documento de Flujo de caja a precios constantes', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (392, 'Documento de formulación del proyecto ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (393, 'Documento de inspecciones', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (396, 'Documento de recomendaciones al CONFIS', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (397, 'Documento de reinducción', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (398, 'Documento de verificación del subsane de documentos ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (399, 'Documento informando a los funcionarios la participación en la capacitaciones ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (400, 'Documento informando las fechas  de realización del inventario', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (401, 'Documento que soporta el recibo a satisfacción', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (402, 'Documento síntesis de Gestión Social ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (403, 'Documentos de prefactibilidad o de factibilidad', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (404, 'Documentos de recolección de necesidades de capacitación ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (405, 'Documentos que soportan los lances durante la subasta presencial', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (406, 'ECO Estudio de Conveniencia y Oportunidad', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (408, 'Encuesta de satisfacción', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (407, 'Edicto', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (409, 'Encuestas Unidades Documentales', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (410, 'Escrito alegatos de conclución', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (411, 'Escrito de descargos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (412, 'Escritura del predio a nombre de la Entidad', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (413, 'Escrituras de tradición del inmueble a 20 años', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (414, 'Especificaciones técnicas del producto o servicio', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (415, 'Especificaciones técnicas del producto o servicio para la subasta inversa', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (416, 'Estadísticas de salud visual  auditiva  ergonómica', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (417, 'Estado de actividades económica  social y ambiental', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (780, 'Publicación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (418, 'Estado de cambios en el Patrimonio', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (419, 'Estado de cuenta predial', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (420, 'Estado de flujos de efectivo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (421, 'Estado de pérdidas y ganancias', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (422, 'Estado de Resultados  certificado por contador', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (423, 'Estados de cuentas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (424, 'Estados de cuentas (Saldos a favor de contratistas)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (425, 'Estrategia de gestión social en la zona priorizada', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (426, 'Estudio ambiental', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (427, 'Estudio arquitectónico', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (428, 'Estudio de avalúo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (429, 'Estudio de mercado', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (430, 'Estudio de necesidades', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (432, 'Estudio de redes', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (433, 'Estudio de reparto de cargos y beneficios', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (434, 'Estudio de suelos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (435, 'Estudio de títulos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (436, 'Estudio de Títulos del predio', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (437, 'Estudio de transito', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (438, 'Estudio de valoración patrimonial ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (439, 'Estudio de viabilidad', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (440, 'Estudio jurídico', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (441, 'Estudio socio económico', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (442, 'Estudio técnico', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (443, 'Estudio topográfico', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (444, 'Estudio urbanístico', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (445, 'Estudios previos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (446, 'Evaluación a la fecha de retiro', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (447, 'Evaluación de conocimiento de la capacitación ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (448, 'Evaluación de satisfacción de la capacitación ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (450, 'Evaluación del desempeño de los funcionarios a su cargo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (451, 'Exposición de motivos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (452, 'Extracto del acta de la junta directiva aprobando la reducción presupuestal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (453, 'Extractos bancarios', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (454, 'Factura de acueducto y alcantarillado', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (455, 'Factura de luz', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (457, 'Factura de teléfono', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (456, 'Factura de telefonía móvil', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (458, 'Factura de venta', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (459, 'Factura o Cuenta Cobro', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (460, 'Fallo ejecutoriado de sanción disciplinaria', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (461, 'Fallo primera instancia', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (462, 'Fallo segunda instancia', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (463, 'Fallos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (464, 'Ficha de cómite de conciliación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (465, 'Ficha de conciliación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (466, 'Ficha Seguimiento Unidad Social ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (468, 'Fichas Censales', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (470, 'Fichas preliminares de perfiles de clientes', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (472, 'Folio de Matrícula Inmobiliaria con oferta de compra Inscrita', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (471, 'Folio de Matricula Inmobiliaria con Escritura Registrada a Nombre de la Entidad', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (473, 'Formato Acta de Acuerdo ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (474, 'Formato Acta de Recibo de Predio', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (476, 'Formato Certificado de Registro Presupuestal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (475, 'Formato Certificado de Disponibilidad Presupuestal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (477, 'Formato conciliación informes tesorería', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (478, 'Formato creación y/o eliminación de usuarios y/o correo GCO-FT-042', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (479, 'Formato de conciliación de información', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (480, 'Formato de Factura', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (481, 'Formato de Plan de mejoramiento', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (483, 'Formato de solicitud actualización Intranet y pagina Web CI-FT-054', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (484, 'Formato de solicitud de elementos de oficina', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (485, 'Formato de solicitud de modificación y actualización de indicadores', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (486, 'Formato de solicitud último pago', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (487, 'Formato de transferencia electrónica', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (488, 'Formato Disponibilidad de Fondos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (489, 'Formato Estado de Tesorería', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (490, 'Formato liquidación del componente económico del Plan de Gestión Social', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (491, 'Formato para Caracterización Social', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (492, 'Formato Recibo de Caja', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (493, 'Formato Registro de Atención a ciudadanos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (494, 'Formato solicitud Autorización de Pago Primer Contado', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (781, 'Queja', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (495, 'Formato solicitud Autorización de Pago Segundo Contado', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (497, 'Formato Solicitud de Registro presupuestal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (496, 'Formato Solicitud de Disponibilidad Presupuestal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (498, 'Formato único de hoja de vida', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (499, 'Formato Único de Hoja de Vida  persona natural  debidamente diligenciado', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (500, 'Formatos para recolección de necesidades de la comunidad (Entrevista)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (501, 'Formulario de evaluación y entrevista para ingreso de empleos cargos de libre nombramiento', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (502, 'Formulario de obligaciones contingentes por operaciones de crédito y otros contratos administrativos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (503, 'Formulario de Preguntas y Respuestas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (504, 'Formulario de proyección del servicio de la deuda', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (505, 'Formulario de superávit fiscal o excedente financiero', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (506, 'Formulario financiación de reservas presupuéstales', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (507, 'Formulario planta de personal con costos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (508, 'Formulario relación de los pasivos exigibles de funcionamiento', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (509, 'Formularios de pago de impuesto predial últimos cinco años', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (510, 'Fotocopia de acta de posesión (Entidad contratante)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (512, 'Fotocopia de Cédula del propietario - persona natural', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (513, 'Fotocopia de la  Cédula de Ciudadanía', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (514, 'Fotocopia de la cédula de ciudadanía del beneficiario', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (516, 'Fotocopia de la cédula del arquitecto o Ing. Civil (Cesantías para mejoras locativas)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (515, 'Fotocopia de la cédula de la ciudadanía del representante legal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (517, 'Fotocopia de la tarjeta profesional (de acuerdo al cargo)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (518, 'Fotocopia de la tarjeta profesional del arquitecto o Ing. Civil (cesantías para mejoras locativas)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (519, 'Fotocopia de los certificados laborales  académicos y/o experiencia', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (520, 'Fotocopia del decreto de nombramiento (Entidad contratante)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (522, 'Fotocopia Libreta militar', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (521, 'Fotocopia del documento de identidad', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (524, 'Garantía Única', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (523, 'Fuente de financiación de los pasivos exigibles', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (525, 'GF-FT-079 Orden de Operación o Instrucción de Pago', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (526, 'GF-FT-080 Seguimiento Contractual', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (527, 'GF-FT-081 Seguimiento Diario Fideicomisos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (528, 'Guía de recibido', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (529, 'Hoja de vida de la Función Pública', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (530, 'Hoja de vida del equipo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (531, 'Hoja de vida del indicador', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (535, 'Incapacidades', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (537, 'Información de la cuenta bancaria', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (533, 'Impugnación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (538, 'Información Mercado Inmobiliario', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (539, 'Informe', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (540, 'Informe Acuerdo de Gestión de los Jefes de Control Interno', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (542, 'Informe consolidado de bienes de consumo  devolutivos y saldos contables de inventarios', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (541, 'Informe análisis de seguimiento', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (543, 'Informe Controles de Advertencia ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (544, 'Informe de Actividades', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (545, 'Informe de actividades de ejecución de la ARL', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (546, 'Informe de actividades desarrolladas al vehículo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (547, 'Informe de análisis de las tendencias o comportamiento del mercado ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (548, 'Informe de auditoría de seguimiento al desarrollo del plan', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (549, 'Informe de Cierre Expediente GS-FT-071', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (550, 'Informe de comisión', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (551, 'Informe de conteo físico en almacén o bodega', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (552, 'Informe de cumplimiento a la Directiva 003 de 2013', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (553, 'Informe de disponibilidades  compromisos y autorizaciones de giro', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (554, 'Informe de ejecución del plan de compras', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (555, 'Informe de ejecución presupuestal activa y pasiva (Ingresos y gastos)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (556, 'Informe de ejecución presupuestal de ingresos y gastos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (557, 'Informe de esquemas comerciales del negocio y estrategias de comercialización', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (558, 'Informe de Evaluación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (559, 'Informe de Evaluación a la Gestión Institucional', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (561, 'Informe de evaluación de las actividades para mitigar el riesgo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (560, 'Informe de evaluación de las actividades de seguridad y salud en el trabajo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (562, 'Informe de Gestión de la ERU.', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (563, 'Informe de hechos constitutivos de faltas disciplinarias', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (565, 'Informe de justificación de las partidas presupuéstales de informes y/o gastos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (564, 'Informe de justificación de la anulación presupuestal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (566, 'Informe de justificación de los ingresos proyectados', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (567, 'Informe de justificación de los parámetros  las variables o supuestos utilizados y cambios en las tendencias de la proyección ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (568, 'Informe de justificación legal  económica y financiera del traslado presupuestal interno del traslado que afecta los agregados', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (569, 'Informe de la ejecución por proyectos del Sistema General de Participación y plusvalía', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (570, 'Informe de la Rendición de Cuenta Electrónico por SIVICOF', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (571, 'Informe de las quejas  sugerencias y reclamos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (572, 'Informe de logros', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (573, 'Informe de los simulacros de emergencia', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (574, 'Informe de pruebas de comercialización de productos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (575, 'Informe de reporte de indicadores', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (577, 'Informe de Seguimiento a los Mapas de Riesgos Institucionales', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (576, 'Informe de seguimiento a las Funciones del Comité de Conciliaciones', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (578, 'Informe de seguimiento a los proyectos de inversión', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (579, 'Informe de Seguimiento al Plan de Mejoramiento', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (580, 'Informe de tasación de indemnizaciones', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (581, 'Informe del ajuste presupuestal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (582, 'Informe del estado de la tesorería ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (584, 'Informe diagnóstico del entorno y del mercado', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (585, 'Informe Ejecutivo Anual del Sistema de Control Interno', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (586, 'Informe estadístico de consumo de servicios públicos y telefonía móvil', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (587, 'Informe Final', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (588, 'Informe final de contratista', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (589, 'Informe final de ejecución  del Programa de Bienestar Social ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (590, 'Informe final de ejecución del plan de capacitación ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (591, 'Informe Final de Gestión Social ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (592, 'Informe final de la toma física de los inventarios en bodega y bienes devolutivos en servicio ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (593, 'Informe final de sobrantes y faltantes', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (594, 'Informe Pormenorizado de Control Interno ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (595, 'Informe Preliminar', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (597, 'Informe Seguimiento al Plan Anticorrupción', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (598, 'Informe técnico de saneamiento ambiental preventivo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (599, 'Informes', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (600, 'Informes a Entes de Control', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (601, 'Informes de actividades', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (602, 'Informes de Evaluación del Sistema de Control Interno Contable', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (603, 'Informes de precalificación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (604, 'Informes de seguimiento PIGA', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (605, 'Informes estados financieros', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (607, 'Instrumento que detecte las necesidades colectivas e individuales de Bienestar Social ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (608, 'Inventario de entrega', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (609, 'Inventario individual de bienes devolutivos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (610, 'Inventario individual de bienes devolutivos en servicio', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (611, 'Inventarios de registros documentales', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (612, 'Inventarios de registros documentales de la transferencia primaria', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (613, 'Inventarios documentales a eliminar', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (614, 'Investigación de accidentes e incidentes de trabajo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (615, 'Invitación Pública', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (616, 'Justificación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (617, 'Justificación legal  económica y financiera (Empresas industriales y/o comerciales del estado)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (618, 'Justificación legal  económica y financiera de la reducción presupuestal ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (619, 'Justificación legal  económica y financiera del traslado presupuestal de inversión', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (620, 'Justificación legal  económica y financiera del traslado presupuestal interno por centro de costos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (622, 'Libro auxiliar', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (621, 'Legalización de Caja Menor', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (623, 'Libro diario', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (624, 'Libro mayor y balance', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (625, 'Lineamiento de política presupuestal emitida por la Alcaldía mayor de Bogotá', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (626, 'Lista de aspirantes inscritos para elección del COPASO', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (627, 'Lista de clientes potenciales', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (628, 'Lista de precios y tarifas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (629, 'Lista general de votantes', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (630, 'Lista general de votantes y jurados publicada', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (631, 'Listado de asistencia a la capacitación de brigadistas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (632, 'Listado de asistencia a los programas de capacitación ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (634, 'Listado de los afiliados al fondo de cesantías  del Fondo Nacional del Ahorro ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (635, 'Listado de postulados para la conformación de brigadas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (636, 'Listados de asistencia', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (637, 'Manejo de Caja Menor', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (638, 'Manifestación de interés en participar (menor cuantía)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (639, 'Manifestaciones de interés', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (640, 'Manual ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (641, 'Manual de Contratación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (642, 'Manual de imagen corporativa', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (643, 'Manual de Operaciones', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (644, 'Mapa de Tenencia', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (646, 'Marco fiscal de mediano plazo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (645, 'Mapa para Identificación de Conflictos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (647, 'Matrícula', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (648, 'Matriz', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (649, 'Matriz de Gestión Institucional', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (650, 'Matriz FODA', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (651, 'Memorando', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (652, 'Memorando Detallando las Inconsistencias', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (653, 'Memorando donde se confirma el hurto de un bien', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (654, 'Memorando enviando la proyección de los ingresos y/o gastos por centro de costos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (656, 'Memorando remisorio de PAC por áreas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (657, 'Memorando solicitando ajuste al POR', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (658, 'Memorando solicitando el traslado presupuestal que afecta los agregados (presupuesto de funcionamiento)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (659, 'Memorando solicitando el traslado presupuestal que no afecta los agregados', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (660, 'Memorando solicitando la reducción presupuestal.', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (661, 'Memorando solicitando la reprogramación de pagos de inversión y funcionamiento', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (662, 'Memorando solicitando liberación de una reserva presupuestal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (665, 'Memorandos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (666, 'Metodología Asignación de Costos y Gastos de los Proyectos de Renovación Urbana de Bogotá', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (667, 'Minuta escritura pública', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (668, 'NIT de la Unión Temporal o Consorcio ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (669, 'Nómina ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (670, 'Nomina adicional (copia) ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (671, 'Nota bancaria ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (672, 'Nota contable ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (674, 'Notificación a otros sujetos procesales', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (673, 'Notas a los Estados Contables', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (675, 'Notificación Auto inhibitorio', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (676, 'Notificación de la demanda', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (677, 'Notificación de la denuncia', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (678, 'Notificación de la querella', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (679, 'Notificación edicto', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (680, 'Notificación edicto Auto inhibitorio', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (681, 'Notificación edicto Verbal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (682, 'Notificación personal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (683, 'Novedades de encargos ( copia ) ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (684, 'Novedades de ingreso (copia)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (685, 'Novedades de licencias ( copia) ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (686, 'Novedades de prima técnica ( copia )', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (687, 'Novedades de retiros ( copia ) ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (688, 'Observaciones a la evaluación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (689, 'Observaciones al pliego definitivo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (690, 'Observaciones al proyecto de pliego de condiciones', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (691, 'Observaciones Proyecto Pliegos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (692, 'Ofertas ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (693, 'Oficio asignando la cuota global de gastos ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (695, 'Oficio enviando la información del cierre presupuestal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (694, 'Oficio CNB-1092', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (697, 'Oficio remisorio de la programación y justificación de ingresos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (698, 'Oficio remisorio de la proyección del servicio de la deuda', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (699, 'Oficio remisorio de las obligaciones contingentes por operaciones de crédito y otros contratos administrativos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (700, 'Oficio remisorio de los informes a la secretaría de hacienda', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (701, 'Oficio remisorio de los pasivos exigibles', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (702, 'Oficio remisorio de programación  mensual de pagos a tesorería Distrital', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (703, 'Oficio remisorio de reprogramación del PAC', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (782, 'Querella', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (704, 'Oficio remisorio del acto administrativo a las secretarias de Hacienda y Planeación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (705, 'Oficio remisorio del acto administrativo de traslado presupuestal a la Secretaria Distrital de Hacienda', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (706, 'Oficio remisorio del anteproyecto de presupuesto', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (707, 'Oficio remisorio del formulario de planta de personal con costos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (708, 'Oficio remisorio del plan financiero o el plan financiero plurianual', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (709, 'Oficio remisorio del proyecto de presupuesto al CONFIS y a la Secretaria Distrital de Hacienda', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (710, 'Oficio remitido por la secretaría Distrital de hacienda informando la reducción del presupuesto de la entidad', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (711, 'Oficios envío de anexos para escritura', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (713, 'Orden de pago ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (712, 'Orden de matrícula (cesantías para educación)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (714, 'Orden de trabajo para mantenimiento del vehículo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (715, 'Orden judicial para desvinculación del funcionario', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (716, 'Otro sí  adiciones  prórrogas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (717, 'Papeles de Trabajo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (718, 'Paz y Salvo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (719, 'paz y salvo de entrega del cargo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (720, 'Paz y salvo de entrega del carné', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (721, 'Paz y salvo de inventarios de bienes muebles a su cargo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (722, 'Paz y salvo de inventarios documentales', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (723, 'Paz y salvo expedido por el arrendador', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (724, 'Paz y Salvos Servicios Públicos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (726, 'Plan', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (727, 'Plan de acción Institucional ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (728, 'Plan de acción por áreas y/o procesos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (729, 'Plan de Auditoría ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (730, 'Plan de Capacitación ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (731, 'Plan de compras', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (732, 'Plan de comunicaciones', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (734, 'Plan de Gestión Social ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (735, 'Plan de mejoramiento', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (736, 'Plan de sensibilización para fomentar el autocontrol', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (737, 'Plan de ventas ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (738, 'Plan estratégico', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (739, 'Plan financiero', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (740, 'Plan financiero plurianual', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (742, 'Plan Lucha Anticorrupción y Atención al Ciudadano ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (743, 'Plan Operativo Anual de Inversiones POAI', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (744, 'Planilla', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (745, 'Planilla de comunicaciones devueltas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (746, 'Planilla de despacho de la comunicación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (747, 'Planilla de registro de backup de información', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (748, 'Pliego de Cargos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (749, 'Pliego de Condiciones definitivo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (750, 'Poder', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (751, 'Poder conferido', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (752, 'Política', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (753, 'Portafolio de proyectos y servicios', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (754, 'Preguntas y Respuestas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (755, 'Programa Anual Mensualizado de Caja PAC', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (756, 'Programa anual mensualizado de caja por áreas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (757, 'Programa de  Bienestar Social ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (758, 'Programa de factores de riesgos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (759, 'Programa de Seguridad y Salud en el trabajo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (761, 'Programación de la auditoría', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (762, 'Programación del presupuesto orientado a resultados POR', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (763, 'Programación del presupuesto orientado a resultados por centro de costo.', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (764, 'Programas de vigilancia epidemiológica', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (765, 'Promesa de Compraventa', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (766, 'Promesa de compraventa (cesantías para compra de vivienda)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (767, 'Promesa de compraventa o escritura pública no registrada', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (769, 'Propuesta de distribución de los excedentes financieros', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (768, 'Propuesta', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (770, 'Propuesta de productos inmobiliarios', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (771, 'Propuesta en caso de requerirse', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (772, 'Propuesta tabla de ventas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (773, 'Propuestas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (774, 'Providencia', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (775, 'Proyecto de Pliego de Condiciones-Prepliegos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (776, 'Proyecto de presupuesto', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (777, 'Proyecto Pliegos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (778, 'Pruebas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (779, 'Pruebas anexas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (783, 'Ratificación y ampliación de la queja', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (784, 'Recibo a satisfacción del trabajo realizado al vehículo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (785, 'Recibo de impuestos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (787, 'Recibo de pago de cesantías ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (786, 'Recibo de pago', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (788, 'Recibo de pago de impuesto del timbre ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (789, 'Recibo de pago de la publicación del contrato (Según cuantía)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (790, 'Recibo pago retefuente y derechos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (791, 'Recurso de apelación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (792, 'Recurso de apelación del quejoso', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (793, 'Recurso de reposición', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (794, 'Recurso de reposición y en subsidio apelación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (795, 'Recursos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (796, 'Registro audiovisual', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (797, 'Registro civil', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (800, 'Registro civil de nacimiento de los hijos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (799, 'Registro civil de matrimonio (cesantías para educación)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (801, 'Registro de actividades', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (803, 'Registro de afiliación a fondo de cesantías', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (802, 'Registro de afiliación a caja de compensación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (804, 'Registro de afiliación a fondo de pensiones', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (805, 'Registro de afiliación a salud', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (806, 'Registro de asistencia', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (842, 'Resolución aplazando las vacaciones', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (843, 'Resolución aprobación el  Plan de Capacitación (copia)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (844, 'Resolución aprobando el plan de compras', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (845, 'Resolución autorizando el gasto para la comisión', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (848, 'Resolución autorizando o negando la comisión de servicios', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (850, 'Resolución autorizando o negando la licencia por paternidad o adopción', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (841, 'Resolución adoptando el Programa de Seguridad y Salud en el trabajo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (846, 'Resolución autorizando las vacaciones', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (851, 'Resolución de aceptación de renuncia voluntaria', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (852, 'Resolución de Adjudicación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (853, 'Resolución de adopción', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (854, 'Resolución de Apertura del proceso', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (855, 'Resolución de aprobación del CONFIS', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (856, 'Resolución de aprobación del presupuesto', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (859, 'Resolución de desvinculación del funcionario por decisión judicial', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (860, 'Resolución de desvinculación del funcionario por derecho de jubilación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (857, 'Resolución de aprobación del presupuesto por el CONFIS', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (858, 'Resolución de aprobación del Programa de Bienestar Social (copia)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (861, 'Resolución de desvinculación del funcionario por invalidez absoluta', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (862, 'Resolución de encargo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (863, 'Resolución de encargo de un empleo o funcionario', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (866, 'Resolución de liquidación definitiva de prestaciones sociales', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (864, 'Resolución de insubsistencia abandono de cargo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (867, 'Resolución de liquidación del presupuesto', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (868, 'Resolución de nombramiento', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (870, 'Resolución de reconocimiento de las cesantías e intereses anuales', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (871, 'Resolución de reconocimiento de prestaciones de los herederos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (869, 'Resolución de reconocimiento de la pensión', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (872, 'Resolución de reducción presupuestal emitida por la entidad', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (873, 'Resolución de reducción presupuestal en la entidad', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (807, 'Registro de asistencia al Programa de Bienestar Social ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (808, 'Registro de asistencia de las actividades para mitigar el riesgo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (809, 'Registro de bienes y rentas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (810, 'Registro de consulta y préstamo de documentos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (811, 'Registro de Información Tributaria', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (812, 'Registro de matrimonio', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (814, 'Registro fotográfico', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (813, 'Registro del Comité Paritario del COPASO', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (815, 'Registro fotográfico de actividades de bienestar', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (816, 'Registro fotográfico de la diligencia', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (817, 'Registro fotográfico del predio', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (818, 'Registro interno de comunicaciones devueltas', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (819, 'Registro presupuestal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (820, 'Registro topográfico del predio', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (821, 'Registro Único de Reporte de Accidentes de Trabajo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (822, 'Registro Único Tributario', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (823, 'Registros de asistencia', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (824, 'Reglamento Fideicomiso', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (826, 'Relación de cuentas por cobrar', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (827, 'Relación de cuentas por pagar', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (828, 'Relación de descuento de salud ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (829, 'Relación de gastos esenciales', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (830, 'Relación de los funcionarios afiliados y valor acreditado ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (831, 'Relación de pago aportes parafiscales ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (832, 'Relación de reservas presupuéstales', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (833, 'Relación de saldos de los registros presupuéstales', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (834, 'Relación mensual de  descuentos ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (836, 'Reporte de inventario de los bienes devolutivos actuales ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (835, 'Relación tipificadas de bienes a dar de baja ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (837, 'Reporte de prestamos documentales vencidos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (838, 'Reporte visitas Intranet y pagina Web ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (839, 'Requerimiento', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (1, 'Acción', 0, NULL, '0', 1, 1, 1, 1, 0, 0, 0, 0, 0, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (245, 'Comunicación oficial de notificación de la resolución', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (876, 'Resolución de traslado presupuestal interno que no afecta los agregados', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (877, 'Resolución de traslado presupuestal que afecta los agregados', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (878, 'Resolución de traslado presupuestal que no afecta los agregados', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (879, 'Resolución de vacaciones', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (881, 'Resolución del CONFIS aprobando la reducción presupuestal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (882, 'Resolución del proyecto de presupuesto', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (883, 'Resolución para dar de baja los bienes', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (884, 'Resolución que resuelve el recurso de apelación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (885, 'Resolución resolviendo el recurso de reposición', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (886, 'Resolución suspendiendo las vacaciones', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (887, 'Respuesta a las observaciones al pliego', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (889, 'Respuesta a las observaciones del pliego definitivo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (50, 'Acta o Resolución de Adjudicación o Declaratoria Desierta', 0, NULL, '0', 1, 1, 1, 1, 0, 0, 0, 0, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (875, 'Resolución de suspensión o aplazamiento presupuestal  emitida por la entidad ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (890, 'Respuesta observaciones', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (893, 'Seguimiento al Plan de Acción', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (895, 'Sistema de información contractual', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (896, 'Solicitud', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (898, 'Solicitud de anulación de certificado de disponibilidad presupuestal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (899, 'Solicitud de anulación de registro presupuestal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (888, 'Respuesta a las observaciones al Prepliego', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (891, 'Resumen de Nomina ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (892, 'Resumen ejecutivo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (894, 'Sentencias', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (897, 'Solicitud autorización de pago', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (901, 'Solicitud de certificación laboral', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (900, 'Solicitud de Cancelación Oferta de Compra', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (902, 'Solicitud de certificado de compromiso presupuestal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (906, 'Solicitud de contratación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (907, 'Solicitud de documentos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (909, 'Solicitud de Inscripción de Oferta de Compra', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (903, 'Solicitud de Certificado de Disponibilidad Presupuestal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (905, 'Solicitud de consulta y préstamo de documentos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (908, 'Solicitud de ingreso de los bienes a almacén', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (910, 'Solicitud de licencia no remunerada', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (911, 'Solicitud de licencia por paternidad y adopción', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (912, 'Solicitud de permiso remunerado por haber sido jurado de votación ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (913, 'Solicitud de préstamo de bienes entre entidades (comodato)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (914, 'Solicitud de registro de disponibilidad presupuestal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (915, 'Solicitud de reparto Notarial', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (916, 'Solicitud de reprogramación del PAC', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (917, 'Solicitud de revocatoria directa', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (918, 'Solicitud de soporte y mantenimiento', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (919, 'Solicitud de suministro de gasolina', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (920, 'Solicitud de traslado o salida de bienes de almacén a servicio', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (921, 'Solicitud de traslados presupuéstales internos por centro de costos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (922, 'Solicitud del traslado de inventarios', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (924, 'Solicitud paz y salvos de servicios públicos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (923, 'Solicitud Efectivo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (925, 'Solicitud y asignación de servicios de mantenimiento correctivo de vehículos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (926, 'Solicitud y Legalización de Gastos de Caja Menor', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (927, 'Soporte de la Transacción', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (928, 'Soportes de contabilidad', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (929, 'Tabla de Egresos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (930, 'Tablas de predial e ICA', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (931, 'Tablas de retención documental', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (932, 'Tablas de valoración documental', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (934, 'Testimonio', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (935, 'Tres últimos recibos de pago de arriendo  por cada contrato', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (936, 'Verificación de requisitos habilitantes', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (937, 'Version libre', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (938, 'Votos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (23, 'Acta de escrutinio con número de votos a favor de cada candidato', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (44, 'Acta de reunión presentando los lineamientos para la programación presupuestal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (71, 'Acuerdo del concejo Distrital de archivos (aprobando las TRD) Copia', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (72, 'Acuerdo del concejo Distrital de archivos (aprobando las TVD) Copia', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (106, 'Auto decreta pruebas de indagación o investigación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (126, 'Autorización de descuento aportes voluntarios de pensiones', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (139, 'Certificación de inexistencia expedido por el Director Corporativo (contratos de prestación de servicios y de apoyo a la gestión)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (143, 'Certificación de pago de servicios públicos y/o telefonía móvil', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (157, 'Certificado de antecedentes disciplinarios de la Procuraduría General de la Nación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (179, 'Certificado del jefe de personal sobre la imposibilidad de atender el asunto objeto del contrato con personal de planta / inexistencia de personal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (226, 'Comunicación decreto pruebas sujeto procesal', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (240, 'Comunicación oficial de autorización para retiro de cesantías definitivas de los fondos privados', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (254, 'Comunicación oficial de notificación de la resolución resolviendo el recurso de reposición', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (266, 'Comunicación oficial emitida por el Confis  remitiendo la Resolución de aprobación de la reducción presupuestal.', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (279, 'Comunicación oficial remisoria del informe de Ejecución a Secretaría de Hacienda  Secretaría de Planeación y entes de control', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (316, 'Concepto sobre viabilidad para efectuar el traslado presupuestal interno por inversión', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (324, 'Consignación de Cuenta Bancaria', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (325, 'Consolidado movimientos de cuentas ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (334, 'Contrato de obra civil autenticada en notaria (cesantías para mejoras locativas)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (364, 'Declaración de Renta de los últimos dos (2) años', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (384, 'Documento convocando a las actividades del Programa de Seguridad y Salud Ocupacional', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (395, 'Documento de recolección de necesidades de Bienestar Social', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (394, 'Documento de notificación de la expedición de la certificación de salario para bono pensional', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (431, 'Estudio de permanencia de dotaciones', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (449, 'Evaluación de satisfacción del Programa de Bienestar Social ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (467, 'Ficha técnica de conciliación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (469, 'Fichas detalladas de perfiles de clientes', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (482, 'Formato de seguimiento a requerimientos de actualización Intranet y pagina Web CI-FT-055', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (511, 'Fotocopia de cédula de ciudadanía del representante legal (Entidad contratante)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (532, 'Hoja de vida del vehículo', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (534, 'Incapacidad por maternidad', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (536, 'Incapacidades Certificados para disminución de la base de retención en la fuente por concepto de salud prepagada ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (583, 'Informe Derechos de Autor  software- Dirección Nacional de Derechos de Autor', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (596, 'Informe preliminar de evaluación', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (606, 'Instrumento que detecte las deficiencias colectivas e individuales de capacitación ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (633, 'Listado de asistencia a los programas de capacitación (canales de ventas)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (655, 'Memorando informando a las áreas el cronograma para la proyección de los ingresos y gastos para la siguiente vigencia', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (663, 'Memorando solicitando relación de los bienes de consumo y devolutivos', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (664, 'Memorando solicitando suspensión o aplazamiento presupuestal que no afecta los agregados', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (696, 'Oficio notificando la aprobación a recomendaciones sobre el presupuesto', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (725, 'Piezas de comunicación promocional  y publicitaria ', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (733, 'Plan de emergencia', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (741, 'Plan institucional de gestión ambiental', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (760, 'Programación de ingresos propios (establecimientos públicos  empresas comerciales e industriales)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (798, 'Registro civil (hijos) (cesantías para educación)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (825, 'Relación de Comprobantes-Reembolso Mensual de Caja', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (840, 'Resolución', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (849, 'Resolución autorizando o negando la comisión para desempeñar un cargo de libre nombramiento y remoción', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (847, 'Resolución autorizando o negando la comisión de estudios', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (865, 'Resolución de insubsistencia del nombramiento de un empleado', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (874, 'Resolución de retiro del funcionario por no aprobación del periodo de prueba', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (880, 'Resolución de vacancia definitiva por fallecimiento del titular', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, 1, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (904, 'Solicitud de concepto sobre las modificaciones presupuéstales de inversión que afecten los agregados', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (933, 'Tasación de reconocimientos económicos adicionales (Indemnizaciones)', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, NULL, NULL, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (0, 'NO definido', 0, 0, ' ', 0, 0, 0, 1, 0, 0, 0, 0, 0, 0);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (939, 'SOPORTE', 0, NULL, '0', 1, 1, 1, 1, 0, 0, 0, 0, 0, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (940, 'PRUEBAS ARCHIVO', 0, NULL, '0', 0, 0, 0, 1, NULL, 0, 0, 0, 0, 0);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (941, 'EXPEDIENTES DOCUMENTOS', 0, NULL, '0', 0, 0, 0, 1, NULL, 0, 0, 0, 0, 0);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (942, 'EXPEDIENTE SOPORTE', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, 0, 0, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (943, 'PRUEBAS CAPACITACION ARCHIVO MODIFICADA', 0, NULL, '0', 0, 1, 0, 1, 0, 0, 0, 1, 0, 0);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (946, 'ACTAS DE PRUEBA', 0, NULL, '0', 0, 0, 0, 1, NULL, 0, 0, 0, 0, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (944, 'PRUEBAS SUEÑO', 0, NULL, '0', 0, 0, 0, 1, 0, 0, 0, 0, 0, 0);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (945, 'FUSIL', 0, NULL, '0', 0, 0, 1, 1, 0, 0, 0, 0, 0, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (947, 'DOCUMENTO TAREA', 0, NULL, '0', 0, 0, 0, 1, NULL, 0, 0, 0, 0, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (948, 'CITACIONES', 0, NULL, '0', 1, 1, 1, 1, NULL, 0, 0, 0, 0, 0);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (949, 'PRUEBA ARCHIVO', 0, NULL, '0', 0, 0, 0, 1, NULL, 0, 0, 0, 0, 0);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (952, 'ACTAS DE CONTRATOS ', 0, NULL, '0', 0, 0, 0, 1, NULL, 0, 0, 0, 0, 1);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (950, 'GESTION DOCUMENTOS4', 0, NULL, '0', 1, 0, 0, 1, 0, 0, 0, 0, 0, 0);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (951, 'CAJAS X 400', 0, NULL, '0', 0, 0, 1, 1, 0, 0, 0, 0, 0, 0);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (953, 'ACTA DE CONTRATO ALEJANDRO', 0, NULL, '0', 0, 0, 0, 1, 0, 0, 0, 0, 0, 0);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (954, 'BOMBAS CUMPLEAñOS', 0, NULL, '0', 1, 0, 0, 1, NULL, 0, 0, 0, 0, 0);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (955, 'BOMBAS CON AGUA', 0, NULL, '0', 1, 0, 1, 1, NULL, 0, 0, 0, 0, 0);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (956, 'ACATAS ALEJANDRO', 0, NULL, '0', 0, 0, 1, 1, NULL, 0, 0, 0, 0, 0);
INSERT INTO sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) VALUES (957, 'CHEQUES POR AñO', 0, NULL, '0', 0, 1, 0, 1, NULL, 0, 0, 0, 0, 0);


--
-- TOC entry 3029 (class 0 OID 18317)
-- Dependencies: 281
-- Data for Name: sgd_trad_tiporad; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO sgd_trad_tiporad (sgd_trad_codigo, sgd_trad_descr, sgd_trad_icono, sgd_trad_genradsal) VALUES (1, 'Salida', 'RadSalida.gif', 1);
INSERT INTO sgd_trad_tiporad (sgd_trad_codigo, sgd_trad_descr, sgd_trad_icono, sgd_trad_genradsal) VALUES (2, 'Entrada', 'RadEntrada.gif', 1);
INSERT INTO sgd_trad_tiporad (sgd_trad_codigo, sgd_trad_descr, sgd_trad_icono, sgd_trad_genradsal) VALUES (3, 'Memorando', 'RadInterna.gif', 1);
INSERT INTO sgd_trad_tiporad (sgd_trad_codigo, sgd_trad_descr, sgd_trad_icono, sgd_trad_genradsal) VALUES (5, 'Resoluciones', 'RadInterna.gif', 1);
INSERT INTO sgd_trad_tiporad (sgd_trad_codigo, sgd_trad_descr, sgd_trad_icono, sgd_trad_genradsal) VALUES (4, 'Transferencias', 'RadInterna.gif', 1);
INSERT INTO sgd_trad_tiporad (sgd_trad_codigo, sgd_trad_descr, sgd_trad_icono, sgd_trad_genradsal) VALUES (9, 'Documentos de trabajo', 'RadInterna.gif', 1);


--
-- TOC entry 3030 (class 0 OID 18325)
-- Dependencies: 282
-- Data for Name: sgd_ttr_transaccion; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (61, 'Cambio de Etapa del Expediente');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (40, 'Firma Digital de Documento');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (41, 'Eliminacion solicitud de Firma Digital');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (50, 'Cambio de Estado Expediente');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (51, 'Creacion Expediente');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (1, 'Recuperacion Radicado');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (8, 'Informar');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (19, 'Cambiar Tipo de Documento');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (20, 'Crear Registro');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (21, 'Editar Registro');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (10, 'Movimiento entre Carpetas');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (7, 'Borrar Informado');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (13, 'Archivar');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (14, 'Agendar');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (15, 'Sacar de la agenda');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (0, '--');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (16, 'Reasignar para Vo.Bo.');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (2, 'Radicacion');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (22, 'Digitalizacion de Radicado');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (23, 'Digitalizacion - Modificacion');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (24, 'Asociacion Imagen fax');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (30, 'Radicacion Masiva');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (17, 'Modificacion de Causal');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (18, 'Modificacion del Sector');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (25, 'Solicitud de Anulacion');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (26, 'Anulacion Rad');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (27, 'Rechazo de Anulacion');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (37, 'Cambio de Estado del Documento');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (28, 'Devolucion de correo');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (29, 'Digitalizacion de Anexo');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (31, 'Borrado de Anexo a radicado');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (32, 'Modificacion TRD');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (33, 'Eliminar TRD');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (35, 'Tipificacion de la decision');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (36, 'Cambio en la Notificacion');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (38, 'Cambio Vinculacion Documento');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (39, 'Solicitud de Firma');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (42, 'Digitalizacion Radicado(Asoc. Imagen Web)');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (60, 'Cambio seguridad Expediente');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (52, 'Excluir radicado de expediente');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (53, 'Incluir radicado en expediente');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (54, 'Cambio Seguridad del Documento');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (57, 'Ingreso al Archivo Fisico');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (65, 'Archivar NRR');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (55, 'Creación Subexpediente');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (56, 'Cambio de Responsable');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (58, 'Expediente Cerrado');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (59, 'Expediente Reabierto');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (90, 'Devolucion Correspondencia por No entrega de Fisico a tiempo');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (70, 'Edición de formulario');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (9, 'Enviado');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (12, 'Devuelto');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (11, 'Modificación Radicado');
INSERT INTO sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) VALUES (91, 'Anexo');


--
-- TOC entry 3031 (class 0 OID 18334)
-- Dependencies: 283
-- Data for Name: tipo_doc_identificacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO tipo_doc_identificacion (tdid_codi, tdid_desc) VALUES (0, 'Cedula de Ciudadania');
INSERT INTO tipo_doc_identificacion (tdid_codi, tdid_desc) VALUES (1, 'Tarjeta de Identidad');
INSERT INTO tipo_doc_identificacion (tdid_codi, tdid_desc) VALUES (2, 'Cedula de Extranjeria');
INSERT INTO tipo_doc_identificacion (tdid_codi, tdid_desc) VALUES (3, 'Pasaporte');
INSERT INTO tipo_doc_identificacion (tdid_codi, tdid_desc) VALUES (4, 'Nit');
INSERT INTO tipo_doc_identificacion (tdid_codi, tdid_desc) VALUES (5, 'Nuir');


--
-- TOC entry 3032 (class 0 OID 18337)
-- Dependencies: 284
-- Data for Name: tipo_remitente; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO tipo_remitente (trte_codi, trte_desc) VALUES (0, 'ENTIDAD');
INSERT INTO tipo_remitente (trte_codi, trte_desc) VALUES (1, 'OTRA EMPRESA');
INSERT INTO tipo_remitente (trte_codi, trte_desc) VALUES (2, 'PERSONA NATURAL');
INSERT INTO tipo_remitente (trte_codi, trte_desc) VALUES (5, 'PREDIO');
INSERT INTO tipo_remitente (trte_codi, trte_desc) VALUES (3, 'OTRO');


--
-- TOC entry 3033 (class 0 OID 18340)
-- Dependencies: 285
-- Data for Name: ubicacion_fisica; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3034 (class 0 OID 18343)
-- Dependencies: 286
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO usuario (id, usua_codi, depe_codi, usua_login, usua_fech_crea, usua_pasw, usua_esta, usua_nomb, usua_admin, usua_nuevo, usua_doc, codi_nivel, usua_sesion, usua_fech_sesion, usua_ext, usua_nacim, usua_email, usua_at, usua_piso, usu_telefono1, id_pais, id_cont, sgd_rol_codigo, usua_email_1, usua_email_2) VALUES (4, 4, 900, 'PRUEBAS200', '2014-06-04 20:21:03', '02cb962ac59075b964b07152d2', '1', 'Pruebas200', '0', '0', '4999999', 1, 'FIN  2014:06:11 20:0650:32', '2014-06-11 20:33:23.794507', NULL, '0001-02-03', 'pruebas200orfeo@midominio.com', NULL, NULL, NULL, 170, 1, 0, NULL, NULL);
INSERT INTO usuario (id, usua_codi, depe_codi, usua_login, usua_fech_crea, usua_pasw, usua_esta, usua_nomb, usua_admin, usua_nuevo, usua_doc, codi_nivel, usua_sesion, usua_fech_sesion, usua_ext, usua_nacim, usua_email, usua_at, usua_piso, usu_telefono1, id_pais, id_cont, sgd_rol_codigo, usua_email_1, usua_email_2) VALUES (1, 1, 900, 'ADMON', '2007-09-21 00:00:00', '27ccb0eea8a706c4c34a16891f', '1', 'Administrador', '1', '1', '1999999', 5, 'FIN  2016:04:18 19:0435:40', '2016-04-18 19:35:21.689051', 1111, NULL, 'admonorfeo@midominio.com', NULL, 4, NULL, 170, 1, 0, NULL, NULL);
INSERT INTO usuario (id, usua_codi, depe_codi, usua_login, usua_fech_crea, usua_pasw, usua_esta, usua_nomb, usua_admin, usua_nuevo, usua_doc, codi_nivel, usua_sesion, usua_fech_sesion, usua_ext, usua_nacim, usua_email, usua_at, usua_piso, usu_telefono1, id_pais, id_cont, sgd_rol_codigo, usua_email_1, usua_email_2) VALUES (2, 2, 900, 'PRUEBAS100', '2008-08-13 10:10:31.822753', '02cb962ac59075b964b07152d2', '1', 'Pruebas100 ', '1', '0', '2999999', 1, '40412084406o186116247141PRUEBA', '2014-04-12 20:44:06.300562', NULL, '2008-05-09', 'pruebas100orfeo@midominio.com', NULL, NULL, NULL, 170, 1, 0, NULL, NULL);
INSERT INTO usuario (id, usua_codi, depe_codi, usua_login, usua_fech_crea, usua_pasw, usua_esta, usua_nomb, usua_admin, usua_nuevo, usua_doc, codi_nivel, usua_sesion, usua_fech_sesion, usua_ext, usua_nacim, usua_email, usua_at, usua_piso, usu_telefono1, id_pais, id_cont, sgd_rol_codigo, usua_email_1, usua_email_2) VALUES (3, 3, 900, 'RADICADOR', '2014-04-03 16:33:51', '1521322cd50f15e9c3293b3b0f', '1', 'Radicador', '0', '0', '3999999', 1, '140723031526o19216810186RADICADOR', '2014-07-23 15:15:26.542792', NULL, NULL, 'radicadororfeo@midominio.com', NULL, NULL, NULL, 170, 1, 1, NULL, NULL);


--
-- TOC entry 3080 (class 0 OID 0)
-- Dependencies: 287
-- Name: usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('usuario_id_seq', 4, true);


--
-- TOC entry 2581 (class 2606 OID 18465)
-- Name: anex_pk_anex_codigo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY anexos
    ADD CONSTRAINT anex_pk_anex_codigo PRIMARY KEY (anex_codigo);


--
-- TOC entry 2584 (class 2606 OID 18467)
-- Name: anex_pk_anex_tipo_codi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY anexos_tipo
    ADD CONSTRAINT anex_pk_anex_tipo_codi PRIMARY KEY (anex_tipo_codi);


--
-- TOC entry 2598 (class 2606 OID 18485)
-- Name: carpetas_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY carpeta
    ADD CONSTRAINT carpetas_pk PRIMARY KEY (carp_codi);


--
-- TOC entry 2600 (class 2606 OID 18493)
-- Name: departamento_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY departamento
    ADD CONSTRAINT departamento_pk PRIMARY KEY (dpto_codi);


--
-- TOC entry 2605 (class 2606 OID 18495)
-- Name: dependencia_visibilidad_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dependencia_visibilidad
    ADD CONSTRAINT dependencia_visibilidad_pk PRIMARY KEY (codigo_visibilidad);


--
-- TOC entry 2607 (class 2606 OID 18497)
-- Name: estados_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estado
    ADD CONSTRAINT estados_pk PRIMARY KEY (esta_codi);


--
-- TOC entry 2712 (class 2606 OID 18505)
-- Name: pk_Parexp_Id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_parexp_paramexpediente
    ADD CONSTRAINT "pk_Parexp_Id" PRIMARY KEY (id);


--
-- TOC entry 2629 (class 2606 OID 18507)
-- Name: pk_anu_naludos; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_anu_anulados
    ADD CONSTRAINT pk_anu_naludos PRIMARY KEY (sgd_anu_id);


--
-- TOC entry 2586 (class 2606 OID 20195)
-- Name: pk_autg_grupos; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY autg_grupos
    ADD CONSTRAINT pk_autg_grupos PRIMARY KEY (id);


--
-- TOC entry 2592 (class 2606 OID 20197)
-- Name: pk_autp_permisos; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY autp_permisos
    ADD CONSTRAINT pk_autp_permisos PRIMARY KEY (id);


--
-- TOC entry 2594 (class 2606 OID 20199)
-- Name: pk_autr_restric_grupo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY autr_restric_grupo
    ADD CONSTRAINT pk_autr_restric_grupo PRIMARY KEY (id);


--
-- TOC entry 2596 (class 2606 OID 18509)
-- Name: pk_bodega_empresas_secue; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY bodega_empresas
    ADD CONSTRAINT pk_bodega_empresas_secue PRIMARY KEY (identificador_empresa);


--
-- TOC entry 2603 (class 2606 OID 18513)
-- Name: pk_depe; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dependencia
    ADD CONSTRAINT pk_depe PRIMARY KEY (depe_codi);


--
-- TOC entry 2588 (class 2606 OID 20191)
-- Name: pk_id_membresias; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY autm_membresias
    ADD CONSTRAINT pk_id_membresias PRIMARY KEY (id);


--
-- TOC entry 2611 (class 2606 OID 18517)
-- Name: pk_medio_recepcion; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY medio_recepcion
    ADD CONSTRAINT pk_medio_recepcion PRIMARY KEY (mrec_codi);


--
-- TOC entry 2614 (class 2606 OID 18519)
-- Name: pk_municipio; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY municipio
    ADD CONSTRAINT pk_municipio PRIMARY KEY (muni_codi, dpto_codi);


--
-- TOC entry 2616 (class 2606 OID 18521)
-- Name: pk_par_serv_servicios; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY par_serv_servicios
    ADD CONSTRAINT pk_par_serv_servicios PRIMARY KEY (par_serv_secue);


--
-- TOC entry 2618 (class 2606 OID 18525)
-- Name: pk_prestamo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY prestamo
    ADD CONSTRAINT pk_prestamo PRIMARY KEY (pres_id);


--
-- TOC entry 2625 (class 2606 OID 18527)
-- Name: pk_seri; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY series
    ADD CONSTRAINT pk_seri PRIMARY KEY (depe_codi, seri_tipo, seri_ano);


--
-- TOC entry 2627 (class 2606 OID 18531)
-- Name: pk_sgd_anar_anexarg; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_anar_anexarg
    ADD CONSTRAINT pk_sgd_anar_anexarg PRIMARY KEY (sgd_anar_codi);


--
-- TOC entry 2631 (class 2606 OID 18543)
-- Name: pk_sgd_argd_argdoc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_argd_argdoc
    ADD CONSTRAINT pk_sgd_argd_argdoc PRIMARY KEY (sgd_argd_codi);


--
-- TOC entry 2633 (class 2606 OID 18547)
-- Name: pk_sgd_camexp_campoexpediente; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_camexp_campoexpediente
    ADD CONSTRAINT pk_sgd_camexp_campoexpediente PRIMARY KEY (sgd_camexp_codigo);


--
-- TOC entry 2637 (class 2606 OID 18549)
-- Name: pk_sgd_cau_causal; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_cau_causal
    ADD CONSTRAINT pk_sgd_cau_causal PRIMARY KEY (sgd_cau_codigo);


--
-- TOC entry 2639 (class 2606 OID 18551)
-- Name: pk_sgd_caux_causales; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_caux_causales
    ADD CONSTRAINT pk_sgd_caux_causales PRIMARY KEY (sgd_caux_codigo);


--
-- TOC entry 2642 (class 2606 OID 18553)
-- Name: pk_sgd_ciu_ciudadano; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_ciu_ciudadano
    ADD CONSTRAINT pk_sgd_ciu_ciudadano PRIMARY KEY (sgd_ciu_codigo);


--
-- TOC entry 2644 (class 2606 OID 18555)
-- Name: pk_sgd_cob_campobliga; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_cob_campobliga
    ADD CONSTRAINT pk_sgd_cob_campobliga PRIMARY KEY (sgd_cob_codi);


--
-- TOC entry 2646 (class 2606 OID 18557)
-- Name: pk_sgd_dcau_causal; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_dcau_causal
    ADD CONSTRAINT pk_sgd_dcau_causal PRIMARY KEY (sgd_dcau_codigo);


--
-- TOC entry 2648 (class 2606 OID 18559)
-- Name: pk_sgd_ddca_ddsgrgdo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_ddca_ddsgrgdo
    ADD CONSTRAINT pk_sgd_ddca_ddsgrgdo PRIMARY KEY (sgd_ddca_codigo);


--
-- TOC entry 2650 (class 2606 OID 18561)
-- Name: pk_sgd_def_continentes; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_def_continentes
    ADD CONSTRAINT pk_sgd_def_continentes PRIMARY KEY (id_cont);


--
-- TOC entry 2652 (class 2606 OID 18563)
-- Name: pk_sgd_def_paises; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_def_paises
    ADD CONSTRAINT pk_sgd_def_paises PRIMARY KEY (id_pais);


--
-- TOC entry 2654 (class 2606 OID 18565)
-- Name: pk_sgd_deve; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_deve_dev_envio
    ADD CONSTRAINT pk_sgd_deve PRIMARY KEY (sgd_deve_codigo);


--
-- TOC entry 2658 (class 2606 OID 18567)
-- Name: pk_sgd_dir; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_dir_drecciones
    ADD CONSTRAINT pk_sgd_dir PRIMARY KEY (sgd_dir_codigo);


--
-- TOC entry 2660 (class 2606 OID 18569)
-- Name: pk_sgd_dnufe_docnufe; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_dnufe_docnufe
    ADD CONSTRAINT pk_sgd_dnufe_docnufe PRIMARY KEY (sgd_dnufe_codi);


--
-- TOC entry 2666 (class 2606 OID 18571)
-- Name: pk_sgd_empus_usuario; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_empus_empusuario
    ADD CONSTRAINT pk_sgd_empus_usuario PRIMARY KEY (sgd_empus_codigo);


--
-- TOC entry 2672 (class 2606 OID 18577)
-- Name: pk_sgd_fenv; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_fenv_frmenvio
    ADD CONSTRAINT pk_sgd_fenv PRIMARY KEY (sgd_fenv_codigo);


--
-- TOC entry 2674 (class 2606 OID 18579)
-- Name: pk_sgd_fexp_descrip; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_fexp_flujoexpedientes
    ADD CONSTRAINT pk_sgd_fexp_descrip PRIMARY KEY (sgd_fexp_codigo);


--
-- TOC entry 2676 (class 2606 OID 18581)
-- Name: pk_sgd_firrad_firmarads; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_firrad_firmarads
    ADD CONSTRAINT pk_sgd_firrad_firmarads PRIMARY KEY (sgd_firrad_id);


--
-- TOC entry 2678 (class 2606 OID 18583)
-- Name: pk_sgd_fun_funciones; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_fun_funciones
    ADD CONSTRAINT pk_sgd_fun_funciones PRIMARY KEY (sgd_fun_codigo);


--
-- TOC entry 2682 (class 2606 OID 18585)
-- Name: pk_sgd_hmtd_hismatdoc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_hmtd_hismatdoc
    ADD CONSTRAINT pk_sgd_hmtd_hismatdoc PRIMARY KEY (sgd_hmtd_codigo);


--
-- TOC entry 2687 (class 2606 OID 18589)
-- Name: pk_sgd_mat_matriz; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_mat_matriz
    ADD CONSTRAINT pk_sgd_mat_matriz PRIMARY KEY (sgd_mat_codigo);


--
-- TOC entry 2692 (class 2606 OID 18593)
-- Name: pk_sgd_mrd_matrird; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_mrd_matrird
    ADD CONSTRAINT pk_sgd_mrd_matrird PRIMARY KEY (sgd_mrd_codigo);


--
-- TOC entry 2696 (class 2606 OID 18597)
-- Name: pk_sgd_msg_mensaje; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_msg_mensaje
    ADD CONSTRAINT pk_sgd_msg_mensaje PRIMARY KEY (sgd_msg_codi);


--
-- TOC entry 2698 (class 2606 OID 18599)
-- Name: pk_sgd_mtd_matriz_doc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_mtd_matriz_doc
    ADD CONSTRAINT pk_sgd_mtd_matriz_doc PRIMARY KEY (sgd_mtd_codigo);


--
-- TOC entry 2700 (class 2606 OID 18601)
-- Name: pk_sgd_not; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_not_notificacion
    ADD CONSTRAINT pk_sgd_not PRIMARY KEY (sgd_not_codi);


--
-- TOC entry 2705 (class 2606 OID 18603)
-- Name: pk_sgd_oem_oempresas; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_oem_oempresas
    ADD CONSTRAINT pk_sgd_oem_oempresas PRIMARY KEY (sgd_oem_codigo);


--
-- TOC entry 2714 (class 2606 OID 18605)
-- Name: pk_sgd_pexp_procexpedientes; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_pexp_procexpedientes
    ADD CONSTRAINT pk_sgd_pexp_procexpedientes PRIMARY KEY (sgd_pexp_codigo);


--
-- TOC entry 2716 (class 2606 OID 18607)
-- Name: pk_sgd_pnufe_procnumfe; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_pnufe_procnumfe
    ADD CONSTRAINT pk_sgd_pnufe_procnumfe PRIMARY KEY (sgd_pnufe_codi);


--
-- TOC entry 2718 (class 2606 OID 18611)
-- Name: pk_sgd_prc_proceso; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_prc_proceso
    ADD CONSTRAINT pk_sgd_prc_proceso PRIMARY KEY (sgd_prc_codigo);


--
-- TOC entry 2720 (class 2606 OID 18613)
-- Name: pk_sgd_prd_prcdmentos; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_prd_prcdmentos
    ADD CONSTRAINT pk_sgd_prd_prcdmentos PRIMARY KEY (sgd_prd_codigo);


--
-- TOC entry 2724 (class 2606 OID 18615)
-- Name: pk_sgd_rmr_radmasivre; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_rmr_radmasivre
    ADD CONSTRAINT pk_sgd_rmr_radmasivre PRIMARY KEY (sgd_rmr_grupo, sgd_rmr_radi);


--
-- TOC entry 2726 (class 2606 OID 18617)
-- Name: pk_sgd_san_sancionados; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_san_sancionados
    ADD CONSTRAINT pk_sgd_san_sancionados PRIMARY KEY (sgd_san_ref);


--
-- TOC entry 2734 (class 2606 OID 18623)
-- Name: pk_sgd_srd_seriesrd; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_srd_seriesrd
    ADD CONSTRAINT pk_sgd_srd_seriesrd PRIMARY KEY (sgd_srd_codigo);


--
-- TOC entry 2738 (class 2606 OID 18625)
-- Name: pk_sgd_tdec_tipodecision; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_tdec_tipodecision
    ADD CONSTRAINT pk_sgd_tdec_tipodecision PRIMARY KEY (sgd_tdec_codigo);


--
-- TOC entry 2740 (class 2606 OID 18629)
-- Name: pk_sgd_tip_tipotercero; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_tip3_tipotercero
    ADD CONSTRAINT pk_sgd_tip_tipotercero PRIMARY KEY (sgd_tip3_codigo);


--
-- TOC entry 2742 (class 2606 OID 18631)
-- Name: pk_sgd_tma_temas; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_tma_temas
    ADD CONSTRAINT pk_sgd_tma_temas PRIMARY KEY (sgd_tma_codigo);


--
-- TOC entry 2744 (class 2606 OID 18633)
-- Name: pk_sgd_tme_tipmen; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_tme_tipmen
    ADD CONSTRAINT pk_sgd_tme_tipmen PRIMARY KEY (sgd_tme_codi);


--
-- TOC entry 2748 (class 2606 OID 18635)
-- Name: pk_sgd_tpr_tpdcumento; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_tpr_tpdcumento
    ADD CONSTRAINT pk_sgd_tpr_tpdcumento PRIMARY KEY (sgd_tpr_codigo);


--
-- TOC entry 2753 (class 2606 OID 18637)
-- Name: pk_sgd_ttr_transaccion; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_ttr_transaccion
    ADD CONSTRAINT pk_sgd_ttr_transaccion PRIMARY KEY (sgd_ttr_codigo);


--
-- TOC entry 2622 (class 2606 OID 18641)
-- Name: radicado_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY radicado
    ADD CONSTRAINT radicado_pk PRIMARY KEY (radi_nume_radi);


--
-- TOC entry 2635 (class 2606 OID 18643)
-- Name: sgd_carp_descripcion_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_carp_descripcion
    ADD CONSTRAINT sgd_carp_descripcion_pk PRIMARY KEY (sgd_carp_depecodi, sgd_carp_tiporad);


--
-- TOC entry 2662 (class 2606 OID 18647)
-- Name: sgd_einv_inventario_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_einv_inventario
    ADD CONSTRAINT sgd_einv_inventario_pk PRIMARY KEY (sgd_einv_codigo);


--
-- TOC entry 2664 (class 2606 OID 18649)
-- Name: sgd_eit_items_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_eit_items
    ADD CONSTRAINT sgd_eit_items_pk PRIMARY KEY (sgd_eit_codigo);


--
-- TOC entry 2670 (class 2606 OID 18651)
-- Name: sgd_exp_expediente_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_exp_expediente
    ADD CONSTRAINT sgd_exp_expediente_pk PRIMARY KEY (sgd_exp_numero, radi_nume_radi);


--
-- TOC entry 2680 (class 2606 OID 18653)
-- Name: sgd_hfld_histflujodoc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_hfld_histflujodoc
    ADD CONSTRAINT sgd_hfld_histflujodoc_pkey PRIMARY KEY (id);


--
-- TOC entry 2684 (class 2606 OID 18655)
-- Name: sgd_masiva_codigo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_masiva_excel
    ADD CONSTRAINT sgd_masiva_codigo PRIMARY KEY (sgd_masiva_codigo);


--
-- TOC entry 2703 (class 2606 OID 18659)
-- Name: sgd_novedad_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_novedad_usuario
    ADD CONSTRAINT sgd_novedad_usuario_pkey PRIMARY KEY (usua_doc);


--
-- TOC entry 2708 (class 2606 OID 18661)
-- Name: sgd_param_admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_param_admin
    ADD CONSTRAINT sgd_param_admin_pkey PRIMARY KEY (param_codigo);


--
-- TOC entry 2710 (class 2606 OID 18663)
-- Name: sgd_parametro_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_parametro
    ADD CONSTRAINT sgd_parametro_pk PRIMARY KEY (param_nomb, param_codi);


--
-- TOC entry 2731 (class 2606 OID 18665)
-- Name: sgd_sexp_secexpedientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_sexp_secexpedientes
    ADD CONSTRAINT sgd_sexp_secexpedientes_pkey PRIMARY KEY (id);


--
-- TOC entry 2750 (class 2606 OID 18671)
-- Name: sgd_trad_tiporad_codigo_inx; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_trad_tiporad
    ADD CONSTRAINT sgd_trad_tiporad_codigo_inx PRIMARY KEY (sgd_trad_codigo);


--
-- TOC entry 2755 (class 2606 OID 18675)
-- Name: tipo_doc_identificacion_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_doc_identificacion
    ADD CONSTRAINT tipo_doc_identificacion_pk PRIMARY KEY (tdid_codi);


--
-- TOC entry 2757 (class 2606 OID 18677)
-- Name: tipo_remitente_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_remitente
    ADD CONSTRAINT tipo_remitente_pk PRIMARY KEY (trte_codi);


--
-- TOC entry 2590 (class 2606 OID 20193)
-- Name: uk_autg_autu_usuarios; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY autm_membresias
    ADD CONSTRAINT uk_autg_autu_usuarios UNIQUE (autg_id, autu_id);


--
-- TOC entry 2689 (class 2606 OID 18681)
-- Name: uk_sgd_mat; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_mat_matriz
    ADD CONSTRAINT uk_sgd_mat UNIQUE (depe_codi, sgd_fun_codigo, sgd_prc_codigo, sgd_prd_codigo);


--
-- TOC entry 2694 (class 2606 OID 18683)
-- Name: uk_sgd_mrd_matrird; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_mrd_matrird
    ADD CONSTRAINT uk_sgd_mrd_matrird UNIQUE (depe_codi, sgd_srd_codigo, sgd_sbrd_codigo, sgd_tpr_codigo);


--
-- TOC entry 2722 (class 2606 OID 18685)
-- Name: uk_sgd_rdf_retdocf; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_rdf_retdocf
    ADD CONSTRAINT uk_sgd_rdf_retdocf UNIQUE (radi_nume_radi, depe_codi, sgd_mrd_codigo);


--
-- TOC entry 2736 (class 2606 OID 18687)
-- Name: uk_sgd_srd_descrip; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_srd_seriesrd
    ADD CONSTRAINT uk_sgd_srd_descrip UNIQUE (sgd_srd_descrip);


--
-- TOC entry 2761 (class 2606 OID 18689)
-- Name: unique_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT unique_id UNIQUE (id);


--
-- TOC entry 2763 (class 2606 OID 18691)
-- Name: unique_usua_login; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT unique_usua_login UNIQUE (usua_login);


--
-- TOC entry 2765 (class 2606 OID 18693)
-- Name: usuario_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_pk PRIMARY KEY (id);


--
-- TOC entry 2767 (class 2606 OID 18695)
-- Name: usuario_uk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_uk UNIQUE (usua_codi, depe_codi);


--
-- TOC entry 2582 (class 1259 OID 18707)
-- Name: idxAnexos; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idxAnexos" ON anexos USING btree (anex_radi_nume, anex_codigo, anex_fech_anex);


--
-- TOC entry 2655 (class 1259 OID 18708)
-- Name: idxDirDrecciones; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idxDirDrecciones" ON sgd_dir_drecciones USING btree (sgd_dir_codigo, sgd_trd_codigo, radi_nume_radi);


--
-- TOC entry 2619 (class 1259 OID 18709)
-- Name: idxRadicado; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idxRadicado" ON radicado USING btree (radi_nume_radi, radi_fech_radi, tdoc_codi);


--
-- TOC entry 2667 (class 1259 OID 18710)
-- Name: idxSgdExpediente; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idxSgdExpediente" ON sgd_exp_expediente USING btree (sgd_exp_numero, radi_nume_radi, sgd_exp_estado);


--
-- TOC entry 2608 (class 1259 OID 18711)
-- Name: idx_RadiUsuaDoc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_RadiUsuaDoc" ON hist_eventos USING btree (radi_nume_radi, usua_doc);


--
-- TOC entry 2758 (class 1259 OID 18712)
-- Name: idx_UsuarioUsuaDoc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_UsuarioUsuaDoc" ON usuario USING btree (usua_doc, usua_esta, depe_codi, usua_codi);


--
-- TOC entry 2640 (class 1259 OID 18713)
-- Name: idx_ciuCodigo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_ciuCodigo" ON sgd_ciu_ciudadano USING btree (sgd_ciu_codigo, sgd_ciu_cedula, sgd_ciu_nombre, sgd_ciu_apell1, sgd_ciu_apell2);


--
-- TOC entry 2601 (class 1259 OID 18714)
-- Name: idx_deptoCodi; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_deptoCodi" ON departamento USING btree (dpto_codi, id_pais, id_cont);


--
-- TOC entry 2668 (class 1259 OID 18715)
-- Name: idx_expNumeroDepeUsuaMuni; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_expNumeroDepeUsuaMuni" ON sgd_exp_expediente USING btree (sgd_exp_numero, radi_nume_radi, depe_codi, usua_codi, usua_doc, sgd_exp_estado);


--
-- TOC entry 2609 (class 1259 OID 18716)
-- Name: idx_histEventos; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_histEventos" ON hist_eventos USING btree (radi_nume_radi, hist_fech, depe_codi, usua_codi, sgd_ttr_codigo);


--
-- TOC entry 2685 (class 1259 OID 18717)
-- Name: idx_matCodigo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_matCodigo" ON sgd_mat_matriz USING btree (sgd_mat_codigo, sgd_prd_codigo);


--
-- TOC entry 2690 (class 1259 OID 18718)
-- Name: idx_mrd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_mrd ON sgd_mrd_matrird USING btree (sgd_mrd_codigo, depe_codi, depe_codi_aplica, sgd_srd_codigo, sgd_sbrd_codigo, sgd_mrd_esta);


--
-- TOC entry 2612 (class 1259 OID 18719)
-- Name: idx_municipio; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_municipio ON municipio USING btree (dpto_codi, muni_codi, id_cont, id_pais);


--
-- TOC entry 2701 (class 1259 OID 18720)
-- Name: idx_novedad_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_novedad_usuario ON sgd_novedad_usuario USING btree (usua_doc);


--
-- TOC entry 2706 (class 1259 OID 18721)
-- Name: idx_param_admin; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_param_admin ON sgd_param_admin USING btree (param_codigo);


--
-- TOC entry 2656 (class 1259 OID 18722)
-- Name: idx_radiTipoName; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_radiTipoName" ON sgd_dir_drecciones USING btree (radi_nume_radi, sgd_dir_tipo, muni_codi, dpto_codi);


--
-- TOC entry 2620 (class 1259 OID 18723)
-- Name: idx_radicadoCarpetas; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_radicadoCarpetas" ON radicado USING btree (radi_nume_radi, carp_codi, carp_per);


--
-- TOC entry 2727 (class 1259 OID 18724)
-- Name: idx_sbrd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sbrd ON sgd_sbrd_subserierd USING btree (sgd_srd_codigo, sgd_sbrd_codigo, sgd_sbrd_fechini, sgd_sbrd_fechfin, sgd_sbrd_procedi);


--
-- TOC entry 2728 (class 1259 OID 18725)
-- Name: idx_sexp; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sexp ON sgd_sexp_secexpedientes USING btree (sgd_exp_numero, sgd_srd_codigo, sgd_sbrd_codigo, sgd_pexp_codigo, sgd_sexp_fech);


--
-- TOC entry 2732 (class 1259 OID 18726)
-- Name: idx_srdCodi; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_srdCodi" ON sgd_srd_seriesrd USING btree (sgd_srd_codigo, sgd_srd_fechini, sgd_srd_fechfin);


--
-- TOC entry 2745 (class 1259 OID 18727)
-- Name: idx_tpr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_tpr ON sgd_tpr_tpdcumento USING btree (sgd_tpr_codigo, sgd_tpr_estado);


--
-- TOC entry 2746 (class 1259 OID 18728)
-- Name: idx_tprCodigoName; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_tprCodigoName" ON sgd_tpr_tpdcumento USING btree (sgd_tpr_codigo, sgd_tpr_estado);


--
-- TOC entry 2751 (class 1259 OID 18729)
-- Name: idx_ttr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ttr ON sgd_ttr_transaccion USING btree (sgd_ttr_codigo);


--
-- TOC entry 2759 (class 1259 OID 18730)
-- Name: idx_usuaCodi; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_usuaCodi" ON usuario USING btree (usua_codi, depe_codi, usua_esta);


--
-- TOC entry 2729 (class 1259 OID 18731)
-- Name: ndx_numero_fexp; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ndx_numero_fexp ON sgd_sexp_secexpedientes USING btree (sgd_fexp_codigo, sgd_exp_numero);


--
-- TOC entry 2623 (class 1259 OID 18733)
-- Name: radicado_radi_nume_radi_ra_asun_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX radicado_radi_nume_radi_ra_asun_idx ON radicado USING btree (radi_nume_radi, ra_asun);


--
-- TOC entry 2768 (class 2606 OID 18769)
-- Name: fk_depe_padre; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dependencia
    ADD CONSTRAINT fk_depe_padre FOREIGN KEY (depe_codi_padre) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2769 (class 2606 OID 18774)
-- Name: fk_hist_depe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hist_eventos
    ADD CONSTRAINT fk_hist_depe FOREIGN KEY (depe_codi) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2770 (class 2606 OID 18779)
-- Name: fk_info_depe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY informados
    ADD CONSTRAINT fk_info_depe FOREIGN KEY (depe_codi) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2771 (class 2606 OID 18784)
-- Name: fk_municipi_ref_128_departam; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY municipio
    ADD CONSTRAINT fk_municipi_ref_128_departam FOREIGN KEY (dpto_codi) REFERENCES departamento(dpto_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2786 (class 2606 OID 18789)
-- Name: fk_paises_continentes; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_def_paises
    ADD CONSTRAINT fk_paises_continentes FOREIGN KEY (id_cont) REFERENCES sgd_def_continentes(id_cont) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2772 (class 2606 OID 18794)
-- Name: fk_prestamo_depe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY prestamo
    ADD CONSTRAINT fk_prestamo_depe FOREIGN KEY (depe_codi) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2773 (class 2606 OID 18799)
-- Name: fk_prestamo_depe_arch; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY prestamo
    ADD CONSTRAINT fk_prestamo_depe_arch FOREIGN KEY (pres_depe_arch) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2774 (class 2606 OID 18809)
-- Name: fk_radi_esta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY radicado
    ADD CONSTRAINT fk_radi_esta FOREIGN KEY (esta_codi) REFERENCES estado(esta_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2775 (class 2606 OID 18814)
-- Name: fk_radi_mrec; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY radicado
    ADD CONSTRAINT fk_radi_mrec FOREIGN KEY (mrec_codi) REFERENCES medio_recepcion(mrec_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2776 (class 2606 OID 18819)
-- Name: fk_radi_muni; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY radicado
    ADD CONSTRAINT fk_radi_muni FOREIGN KEY (muni_codi, dpto_codi) REFERENCES municipio(muni_codi, dpto_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2780 (class 2606 OID 18824)
-- Name: fk_radicado_nume; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_anu_anulados
    ADD CONSTRAINT fk_radicado_nume FOREIGN KEY (radi_nume_radi) REFERENCES radicado(radi_nume_radi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2777 (class 2606 OID 18829)
-- Name: fk_radicado_par_serv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY radicado
    ADD CONSTRAINT fk_radicado_par_serv FOREIGN KEY (par_serv_secue) REFERENCES par_serv_servicios(par_serv_secue) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2810 (class 2606 OID 18834)
-- Name: fk_sexp_secexp_pexp_codigo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_sexp_secexpedientes
    ADD CONSTRAINT fk_sexp_secexp_pexp_codigo FOREIGN KEY (sgd_pexp_codigo) REFERENCES sgd_pexp_procexpedientes(sgd_pexp_codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2779 (class 2606 OID 18839)
-- Name: fk_sgd_anar_anexos; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_anar_anexarg
    ADD CONSTRAINT fk_sgd_anar_anexos FOREIGN KEY (anex_codigo) REFERENCES anexos(anex_codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2782 (class 2606 OID 18854)
-- Name: fk_sgd_caux_radicado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_caux_causales
    ADD CONSTRAINT fk_sgd_caux_radicado FOREIGN KEY (radi_nume_radi) REFERENCES radicado(radi_nume_radi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2783 (class 2606 OID 18859)
-- Name: fk_sgd_dcau_sgd_cau_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_dcau_causal
    ADD CONSTRAINT fk_sgd_dcau_sgd_cau_ FOREIGN KEY (sgd_cau_codigo) REFERENCES sgd_cau_causal(sgd_cau_codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2784 (class 2606 OID 18864)
-- Name: fk_sgd_ddca_ref_678_par_serv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_ddca_ddsgrgdo
    ADD CONSTRAINT fk_sgd_ddca_ref_678_par_serv FOREIGN KEY (par_serv_secue) REFERENCES par_serv_servicios(par_serv_secue) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2785 (class 2606 OID 18869)
-- Name: fk_sgd_ddca_sgd_dcau; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_ddca_ddsgrgdo
    ADD CONSTRAINT fk_sgd_ddca_sgd_dcau FOREIGN KEY (sgd_dcau_codigo) REFERENCES sgd_dcau_causal(sgd_dcau_codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2787 (class 2606 OID 18874)
-- Name: fk_sgd_dir_municipio; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_dir_drecciones
    ADD CONSTRAINT fk_sgd_dir_municipio FOREIGN KEY (muni_codi, dpto_codi) REFERENCES municipio(muni_codi, dpto_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2788 (class 2606 OID 18879)
-- Name: fk_sgd_dir_radicado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_dir_drecciones
    ADD CONSTRAINT fk_sgd_dir_radicado FOREIGN KEY (radi_nume_radi) REFERENCES radicado(radi_nume_radi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2789 (class 2606 OID 18884)
-- Name: fk_sgd_dir_sgd_ciu; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_dir_drecciones
    ADD CONSTRAINT fk_sgd_dir_sgd_ciu FOREIGN KEY (sgd_ciu_codigo) REFERENCES sgd_ciu_ciudadano(sgd_ciu_codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2790 (class 2606 OID 18889)
-- Name: fk_sgd_dnufe_anex_tipo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_dnufe_docnufe
    ADD CONSTRAINT fk_sgd_dnufe_anex_tipo FOREIGN KEY (anex_tipo_codi) REFERENCES anexos_tipo(anex_tipo_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2791 (class 2606 OID 18899)
-- Name: fk_sgd_exp_dependencia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_exp_expediente
    ADD CONSTRAINT fk_sgd_exp_dependencia FOREIGN KEY (depe_codi) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2792 (class 2606 OID 18904)
-- Name: fk_sgd_exp_radicado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_exp_expediente
    ADD CONSTRAINT fk_sgd_exp_radicado FOREIGN KEY (radi_nume_radi) REFERENCES radicado(radi_nume_radi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2793 (class 2606 OID 18909)
-- Name: fk_sgd_firr_ref_82_radicado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_firrad_firmarads
    ADD CONSTRAINT fk_sgd_firr_ref_82_radicado FOREIGN KEY (radi_nume_radi) REFERENCES radicado(radi_nume_radi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2794 (class 2606 OID 18914)
-- Name: fk_sgd_hmtd_depe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_hmtd_hismatdoc
    ADD CONSTRAINT fk_sgd_hmtd_depe FOREIGN KEY (depe_codi) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2795 (class 2606 OID 18919)
-- Name: fk_sgd_hmtd_radicado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_hmtd_hismatdoc
    ADD CONSTRAINT fk_sgd_hmtd_radicado FOREIGN KEY (radi_nume_radi) REFERENCES radicado(radi_nume_radi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2796 (class 2606 OID 18929)
-- Name: fk_sgd_mat_depe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_mat_matriz
    ADD CONSTRAINT fk_sgd_mat_depe FOREIGN KEY (depe_codi) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2797 (class 2606 OID 18934)
-- Name: fk_sgd_mat_sgd_fun; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_mat_matriz
    ADD CONSTRAINT fk_sgd_mat_sgd_fun FOREIGN KEY (sgd_fun_codigo) REFERENCES sgd_fun_funciones(sgd_fun_codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2798 (class 2606 OID 18939)
-- Name: fk_sgd_mrd_depe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_mrd_matrird
    ADD CONSTRAINT fk_sgd_mrd_depe FOREIGN KEY (depe_codi) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2799 (class 2606 OID 18944)
-- Name: fk_sgd_msde_ref_27_dependen; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_msdep_msgdep
    ADD CONSTRAINT fk_sgd_msde_ref_27_dependen FOREIGN KEY (depe_codi) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2800 (class 2606 OID 18949)
-- Name: fk_sgd_mtd_sgd_mtd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_mtd_matriz_doc
    ADD CONSTRAINT fk_sgd_mtd_sgd_mtd FOREIGN KEY (sgd_mat_codigo) REFERENCES sgd_mat_matriz(sgd_mat_codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2801 (class 2606 OID 18954)
-- Name: fk_sgd_ntrd_notifrad_radicado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_ntrd_notifrad
    ADD CONSTRAINT fk_sgd_ntrd_notifrad_radicado FOREIGN KEY (radi_nume_radi) REFERENCES radicado(radi_nume_radi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2802 (class 2606 OID 18959)
-- Name: fk_sgd_oem_municipio; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_oem_oempresas
    ADD CONSTRAINT fk_sgd_oem_municipio FOREIGN KEY (muni_codi, dpto_codi) REFERENCES municipio(muni_codi, dpto_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2803 (class 2606 OID 18964)
-- Name: fk_sgd_pnun_depe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_pnun_procenum
    ADD CONSTRAINT fk_sgd_pnun_depe FOREIGN KEY (depe_codi) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2804 (class 2606 OID 18969)
-- Name: fk_sgd_pnun_sgd_pnufe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_pnun_procenum
    ADD CONSTRAINT fk_sgd_pnun_sgd_pnufe FOREIGN KEY (sgd_pnufe_codi) REFERENCES sgd_pnufe_procnumfe(sgd_pnufe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2805 (class 2606 OID 18974)
-- Name: fk_sgd_rdf_depe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_rdf_retdocf
    ADD CONSTRAINT fk_sgd_rdf_depe FOREIGN KEY (depe_codi) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2806 (class 2606 OID 18979)
-- Name: fk_sgd_rdf_trd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_rdf_retdocf
    ADD CONSTRAINT fk_sgd_rdf_trd FOREIGN KEY (sgd_mrd_codigo) REFERENCES sgd_mrd_matrird(sgd_mrd_codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2807 (class 2606 OID 18984)
-- Name: fk_sgd_renv_dependecia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_renv_regenvio
    ADD CONSTRAINT fk_sgd_renv_dependecia FOREIGN KEY (depe_codi) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2808 (class 2606 OID 18989)
-- Name: fk_sgd_renv_sgd_deve; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_renv_regenvio
    ADD CONSTRAINT fk_sgd_renv_sgd_deve FOREIGN KEY (sgd_deve_codigo) REFERENCES sgd_deve_dev_envio(sgd_deve_codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2809 (class 2606 OID 18994)
-- Name: fk_sgd_renv_sgd_dir; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_renv_regenvio
    ADD CONSTRAINT fk_sgd_renv_sgd_dir FOREIGN KEY (sgd_dir_codigo) REFERENCES sgd_dir_drecciones(sgd_dir_codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2811 (class 2606 OID 19004)
-- Name: fk_sgd_tma_depe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_tma_temas
    ADD CONSTRAINT fk_sgd_tma_depe FOREIGN KEY (depe_codi) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2812 (class 2606 OID 19009)
-- Name: fk_sgd_tma_sgd_prc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_tma_temas
    ADD CONSTRAINT fk_sgd_tma_sgd_prc FOREIGN KEY (sgd_prc_codigo) REFERENCES sgd_prc_proceso(sgd_prc_codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2813 (class 2606 OID 19019)
-- Name: fk_usua_depe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT fk_usua_depe FOREIGN KEY (depe_codi) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2778 (class 2606 OID 19024)
-- Name: sgd_agen_agendados_r01; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_agen_agendados
    ADD CONSTRAINT sgd_agen_agendados_r01 FOREIGN KEY (radi_nume_radi) REFERENCES radicado(radi_nume_radi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2781 (class 2606 OID 19034)
-- Name: sgd_carp_descripcion_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_carp_descripcion
    ADD CONSTRAINT sgd_carp_descripcion_fk1 FOREIGN KEY (sgd_carp_depecodi) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3042 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- TOC entry 3044 (class 0 OID 0)
-- Dependencies: 180
-- Name: anexos; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE anexos FROM PUBLIC;
REVOKE ALL ON TABLE anexos FROM postgres;
GRANT ALL ON TABLE anexos TO postgres;


-- Completed on 2016-04-18 20:08:20 COT

--
-- PostgreSQL database dump complete
--

