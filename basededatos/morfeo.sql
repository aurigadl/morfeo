--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.1
-- Dumped by pg_dump version 9.5.2

-- Started on 2016-04-13 11:36:54 COT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

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
-- TOC entry 3041 (class 0 OID 0)
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
-- TOC entry 3043 (class 0 OID 0)
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
    autg_id integer,
    nombre character varying(250),
    descripcion character varying(500),
    crud integer,
    dependencia character varying(150)
);


ALTER TABLE autp_permisos OWNER TO postgres;

--
-- TOC entry 3044 (class 0 OID 0)
-- Dependencies: 185
-- Name: COLUMN autp_permisos.descripcion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN autp_permisos.descripcion IS 'Descripción del permiso';


--
-- TOC entry 3045 (class 0 OID 0)
-- Dependencies: 185
-- Name: COLUMN autp_permisos.crud; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN autp_permisos.crud IS 'Realizar crud sobre el elemento.
Leer 1
Editar 2
Crear y Borrar 3';


--
-- TOC entry 3046 (class 0 OID 0)
-- Dependencies: 185
-- Name: COLUMN autp_permisos.dependencia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN autp_permisos.dependencia IS 'Permite seleccionar el alcanze del elemento, acceso a la pripia depedendencia, todsas las depedencias o ninguna. 
0 ninguna
1 propia
2 todas';


--
-- TOC entry 186 (class 1259 OID 17505)
-- Name: autr_restric_grupo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE autr_restric_grupo (
    id integer,
    autg_id integer,
    autp_id integer
);


ALTER TABLE autr_restric_grupo OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 17508)
-- Name: autu_usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE autu_usuarios (
    id integer NOT NULL,
    nombres character varying(250),
    apellidos character varying(250),
    correo character varying(250),
    contrasena character varying(300),
    usuario character varying(150),
    estado character varying
);


ALTER TABLE autu_usuarios OWNER TO postgres;

--
-- TOC entry 3047 (class 0 OID 0)
-- Dependencies: 187
-- Name: COLUMN autu_usuarios.usuario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN autu_usuarios.usuario IS 'Identificacion del usuario';


--
-- TOC entry 3048 (class 0 OID 0)
-- Dependencies: 187
-- Name: COLUMN autu_usuarios.estado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN autu_usuarios.estado IS 'Estado de los usuarios, nos indican si estan activos o no. ';


--
-- TOC entry 188 (class 1259 OID 17514)
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
-- TOC entry 189 (class 1259 OID 17547)
-- Name: carpeta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE carpeta (
    carp_codi numeric(2,0) NOT NULL,
    carp_desc character varying(80) NOT NULL
);


ALTER TABLE carpeta OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 17550)
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
-- TOC entry 191 (class 1259 OID 17701)
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
-- TOC entry 192 (class 1259 OID 17709)
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
-- TOC entry 193 (class 1259 OID 17715)
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
-- TOC entry 3049 (class 0 OID 0)
-- Dependencies: 193
-- Name: dependencia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE dependencia_id_seq OWNED BY dependencia.id;


--
-- TOC entry 194 (class 1259 OID 17717)
-- Name: dependencia_visibilidad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE dependencia_visibilidad (
    codigo_visibilidad numeric(18,0) NOT NULL,
    dependencia_visible numeric(5,0) NOT NULL,
    dependencia_observa numeric(5,0) NOT NULL
);


ALTER TABLE dependencia_visibilidad OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 17720)
-- Name: estado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE estado (
    esta_codi numeric(2,0) NOT NULL,
    esta_desc character varying(100) NOT NULL
);


ALTER TABLE estado OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 17744)
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
-- TOC entry 197 (class 1259 OID 17750)
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
-- TOC entry 3050 (class 0 OID 0)
-- Dependencies: 197
-- Name: hist_eventos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE hist_eventos_id_seq OWNED BY hist_eventos.id;


--
-- TOC entry 198 (class 1259 OID 17752)
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
-- TOC entry 199 (class 1259 OID 17760)
-- Name: medio_recepcion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE medio_recepcion (
    mrec_codi numeric(2,0) NOT NULL,
    mrec_desc character varying(100) NOT NULL
);


ALTER TABLE medio_recepcion OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 17763)
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
-- TOC entry 201 (class 1259 OID 17789)
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
-- TOC entry 202 (class 1259 OID 17792)
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
-- TOC entry 203 (class 1259 OID 17798)
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
-- TOC entry 204 (class 1259 OID 17816)
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
-- TOC entry 3051 (class 0 OID 0)
-- Dependencies: 204
-- Name: radicado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE radicado_id_seq OWNED BY radicado.id;


--
-- TOC entry 205 (class 1259 OID 17876)
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
-- TOC entry 206 (class 1259 OID 17882)
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
-- TOC entry 207 (class 1259 OID 17888)
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
-- TOC entry 3052 (class 0 OID 0)
-- Dependencies: 207
-- Name: sgd_agen_agendados_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sgd_agen_agendados_id_seq OWNED BY sgd_agen_agendados.id;


--
-- TOC entry 208 (class 1259 OID 17890)
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
-- TOC entry 209 (class 1259 OID 17893)
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
-- TOC entry 210 (class 1259 OID 17922)
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
-- TOC entry 211 (class 1259 OID 17931)
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
-- TOC entry 212 (class 1259 OID 17937)
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
-- TOC entry 213 (class 1259 OID 17944)
-- Name: sgd_carp_descripcion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_carp_descripcion (
    sgd_carp_depecodi numeric(7,0) NOT NULL,
    sgd_carp_tiporad numeric(2,0) NOT NULL,
    sgd_carp_descr character varying(40)
);


ALTER TABLE sgd_carp_descripcion OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 17947)
-- Name: sgd_cau_causal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_cau_causal (
    sgd_cau_codigo numeric(4,0) NOT NULL,
    sgd_cau_descrip character varying(150)
);


ALTER TABLE sgd_cau_causal OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 17950)
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
-- TOC entry 216 (class 1259 OID 17954)
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
-- TOC entry 217 (class 1259 OID 17962)
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
-- TOC entry 218 (class 1259 OID 17965)
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
-- TOC entry 219 (class 1259 OID 17974)
-- Name: sgd_dcau_causal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_dcau_causal (
    sgd_dcau_codigo numeric(4,0) NOT NULL,
    sgd_cau_codigo numeric(4,0),
    sgd_dcau_descrip character varying(150)
);


ALTER TABLE sgd_dcau_causal OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17977)
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
-- TOC entry 221 (class 1259 OID 17980)
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
-- TOC entry 222 (class 1259 OID 17983)
-- Name: sgd_def_continentes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_def_continentes (
    id_cont numeric(2,0) NOT NULL,
    nombre_cont character varying(20) NOT NULL
);


ALTER TABLE sgd_def_continentes OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17986)
-- Name: sgd_def_paises; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_def_paises (
    id_pais numeric(4,0) NOT NULL,
    id_cont numeric(2,0) DEFAULT 1 NOT NULL,
    nombre_pais character varying(30) NOT NULL
);


ALTER TABLE sgd_def_paises OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17990)
-- Name: sgd_deve_dev_envio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_deve_dev_envio (
    sgd_deve_codigo numeric(2,0) NOT NULL,
    sgd_deve_desc character varying(150) NOT NULL
);


ALTER TABLE sgd_deve_dev_envio OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17995)
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
-- TOC entry 226 (class 1259 OID 18003)
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
-- TOC entry 3053 (class 0 OID 0)
-- Dependencies: 226
-- Name: sgd_dir_drecciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sgd_dir_drecciones_id_seq OWNED BY sgd_dir_drecciones.id;


--
-- TOC entry 227 (class 1259 OID 18005)
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
-- TOC entry 228 (class 1259 OID 18014)
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
-- TOC entry 229 (class 1259 OID 18020)
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
-- TOC entry 230 (class 1259 OID 18027)
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
-- TOC entry 231 (class 1259 OID 18033)
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
-- TOC entry 232 (class 1259 OID 18045)
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
-- TOC entry 233 (class 1259 OID 18053)
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
-- TOC entry 3054 (class 0 OID 0)
-- Dependencies: 233
-- Name: sgd_exp_expediente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sgd_exp_expediente_id_seq OWNED BY sgd_exp_expediente.id;


--
-- TOC entry 234 (class 1259 OID 18055)
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
-- TOC entry 235 (class 1259 OID 18060)
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
-- TOC entry 236 (class 1259 OID 18063)
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
-- TOC entry 237 (class 1259 OID 18069)
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
-- TOC entry 238 (class 1259 OID 18075)
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
-- TOC entry 239 (class 1259 OID 18081)
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
-- TOC entry 240 (class 1259 OID 18087)
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
-- TOC entry 3055 (class 0 OID 0)
-- Dependencies: 240
-- Name: sgd_hfld_histflujodoc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sgd_hfld_histflujodoc_id_seq OWNED BY sgd_hfld_histflujodoc.id;


--
-- TOC entry 241 (class 1259 OID 18089)
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
-- TOC entry 242 (class 1259 OID 18104)
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
-- TOC entry 243 (class 1259 OID 18107)
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
-- TOC entry 244 (class 1259 OID 18113)
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
-- TOC entry 245 (class 1259 OID 18118)
-- Name: sgd_msdep_msgdep; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_msdep_msgdep (
    depe_codi numeric(10,0) NOT NULL,
    sgd_msg_codi numeric(15,0) NOT NULL
);


ALTER TABLE sgd_msdep_msgdep OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 18121)
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
-- TOC entry 3056 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN sgd_msg_mensaje.sgd_msg_etiqueta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_msg_mensaje.sgd_msg_etiqueta IS 'Nombre corto para mostrar del mensaje';


--
-- TOC entry 247 (class 1259 OID 18124)
-- Name: sgd_mtd_matriz_doc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_mtd_matriz_doc (
    sgd_mtd_codigo numeric(4,0) NOT NULL,
    sgd_mat_codigo numeric(4,0),
    sgd_tpr_codigo numeric(4,0)
);


ALTER TABLE sgd_mtd_matriz_doc OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 18133)
-- Name: sgd_noh_nohabiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_noh_nohabiles (
    noh_fecha timestamp without time zone NOT NULL
);


ALTER TABLE sgd_noh_nohabiles OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 18136)
-- Name: sgd_not_notificacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_not_notificacion (
    sgd_not_codi numeric(3,0) NOT NULL,
    sgd_not_descrip character varying(100) NOT NULL
);


ALTER TABLE sgd_not_notificacion OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 18139)
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
-- TOC entry 251 (class 1259 OID 18145)
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
-- TOC entry 252 (class 1259 OID 18148)
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
-- TOC entry 253 (class 1259 OID 18159)
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
-- TOC entry 254 (class 1259 OID 18165)
-- Name: sgd_parametro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_parametro (
    param_nomb character varying(25) NOT NULL,
    param_codi numeric(5,0) NOT NULL,
    param_valor character varying(25) NOT NULL
);


ALTER TABLE sgd_parametro OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 18168)
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
-- TOC entry 256 (class 1259 OID 18172)
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
-- TOC entry 3057 (class 0 OID 0)
-- Dependencies: 256
-- Name: sgd_parexp_paramexpediente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sgd_parexp_paramexpediente_id_seq OWNED BY sgd_parexp_paramexpediente.id;


--
-- TOC entry 257 (class 1259 OID 18174)
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
-- TOC entry 258 (class 1259 OID 18182)
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
-- TOC entry 259 (class 1259 OID 18188)
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
-- TOC entry 3058 (class 0 OID 0)
-- Dependencies: 259
-- Name: sgd_plan_plantillas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sgd_plan_plantillas_id_seq OWNED BY sgd_plan_plantillas.id;


--
-- TOC entry 260 (class 1259 OID 18190)
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
-- TOC entry 261 (class 1259 OID 18193)
-- Name: sgd_pnun_procenum; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_pnun_procenum (
    sgd_pnufe_codi numeric(4,0),
    depe_codi numeric(10,0),
    sgd_pnun_prepone character varying(50)
);


ALTER TABLE sgd_pnun_procenum OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 18196)
-- Name: sgd_prc_proceso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_prc_proceso (
    sgd_prc_codigo numeric(4,0) NOT NULL,
    sgd_prc_descrip character varying(150)
);


ALTER TABLE sgd_prc_proceso OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 18199)
-- Name: sgd_prd_prcdmentos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_prd_prcdmentos (
    sgd_prd_codigo numeric(4,0) NOT NULL,
    sgd_prc_codigo numeric(4,0),
    sgd_prd_descrip character varying(200)
);


ALTER TABLE sgd_prd_prcdmentos OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 18202)
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
-- TOC entry 265 (class 1259 OID 18205)
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
-- TOC entry 266 (class 1259 OID 18208)
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
-- TOC entry 3059 (class 0 OID 0)
-- Dependencies: 266
-- Name: sgd_rdf_retdocf_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sgd_rdf_retdocf_id_seq OWNED BY sgd_rdf_retdocf.id;


--
-- TOC entry 267 (class 1259 OID 18210)
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
-- TOC entry 268 (class 1259 OID 18225)
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
-- TOC entry 3060 (class 0 OID 0)
-- Dependencies: 268
-- Name: sgd_renv_regenvio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sgd_renv_regenvio_id_seq OWNED BY sgd_renv_regenvio.id;


--
-- TOC entry 269 (class 1259 OID 18233)
-- Name: sgd_rmr_radmasivre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_rmr_radmasivre (
    sgd_rmr_grupo numeric(15,0) NOT NULL,
    sgd_rmr_radi numeric(15,0) NOT NULL
);


ALTER TABLE sgd_rmr_radmasivre OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 18236)
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
-- TOC entry 271 (class 1259 OID 18242)
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
-- TOC entry 3061 (class 0 OID 0)
-- Dependencies: 271
-- Name: TABLE sgd_sbrd_subserierd; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sgd_sbrd_subserierd IS 'Tabla que contiene  las Subseries documentales en OrfeoGPL. Modificado por Jloasada 20121';


--
-- TOC entry 3062 (class 0 OID 0)
-- Dependencies: 271
-- Name: COLUMN sgd_sbrd_subserierd.sgd_srd_codigo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_sbrd_subserierd.sgd_srd_codigo IS 'Codigo de Serie Documental, desde la ver 3.8 se elimina el pk en este campo y se crea el Id.  Esto permite la modificacion de este codigo segun conveniencia de las Entidades/Empresas.';


--
-- TOC entry 3063 (class 0 OID 0)
-- Dependencies: 271
-- Name: COLUMN sgd_sbrd_subserierd.sgd_sbrd_fechini; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_sbrd_subserierd.sgd_sbrd_fechini IS 'Fecha en la cual inicia la ejecucion de esta subserie Documental.';


--
-- TOC entry 3064 (class 0 OID 0)
-- Dependencies: 271
-- Name: COLUMN sgd_sbrd_subserierd.sgd_sbrd_fechfin; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_sbrd_subserierd.sgd_sbrd_fechfin IS 'Fecha en la cual finaliza la ejecucion de esta subserie Documental. ';


--
-- TOC entry 272 (class 1259 OID 18251)
-- Name: sgd_senuf_secnumfe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_senuf_secnumfe (
    sgd_pnufe_codi numeric(4,0),
    depe_codi numeric(10,0),
    sgd_senuf_sec character varying(50)
);


ALTER TABLE sgd_senuf_secnumfe OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 18254)
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
-- TOC entry 3065 (class 0 OID 0)
-- Dependencies: 273
-- Name: COLUMN sgd_sexp_secexpedientes.sgd_sexp_prestamo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_sexp_secexpedientes.sgd_sexp_prestamo IS 'Boolenao para prestamo de expedientes';


--
-- TOC entry 274 (class 1259 OID 18263)
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
-- TOC entry 3066 (class 0 OID 0)
-- Dependencies: 274
-- Name: sgd_sexp_secexpedientes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sgd_sexp_secexpedientes_id_seq OWNED BY sgd_sexp_secexpedientes.id;


--
-- TOC entry 275 (class 1259 OID 18272)
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
-- TOC entry 276 (class 1259 OID 18275)
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
-- TOC entry 277 (class 1259 OID 18278)
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
-- TOC entry 278 (class 1259 OID 18293)
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
-- TOC entry 279 (class 1259 OID 18302)
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
-- TOC entry 280 (class 1259 OID 18305)
-- Name: sgd_tme_tipmen; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_tme_tipmen (
    sgd_tme_codi numeric(3,0) NOT NULL
);


ALTER TABLE sgd_tme_tipmen OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 18308)
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
-- TOC entry 282 (class 1259 OID 18317)
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
-- TOC entry 283 (class 1259 OID 18325)
-- Name: sgd_ttr_transaccion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sgd_ttr_transaccion (
    sgd_ttr_codigo numeric(3,0) NOT NULL,
    sgd_ttr_descrip character varying(100) NOT NULL
);


ALTER TABLE sgd_ttr_transaccion OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 18334)
-- Name: tipo_doc_identificacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tipo_doc_identificacion (
    tdid_codi numeric(2,0) NOT NULL,
    tdid_desc character varying(100) NOT NULL
);


ALTER TABLE tipo_doc_identificacion OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 18337)
-- Name: tipo_remitente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tipo_remitente (
    trte_codi numeric(2,0) NOT NULL,
    trte_desc character varying(100) NOT NULL
);


ALTER TABLE tipo_remitente OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 18340)
-- Name: ubicacion_fisica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ubicacion_fisica (
    ubic_depe_radi numeric(5,0) NOT NULL,
    ubic_depe_arch numeric(5,0)
);


ALTER TABLE ubicacion_fisica OWNER TO postgres;

--
-- TOC entry 287 (class 1259 OID 18343)
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
-- TOC entry 288 (class 1259 OID 18373)
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
-- TOC entry 3067 (class 0 OID 0)
-- Dependencies: 288
-- Name: usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE usuario_id_seq OWNED BY usuario.id;


--
-- TOC entry 2498 (class 2604 OID 18435)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY anexos ALTER COLUMN id SET DEFAULT nextval('anexos_id_seq'::regclass);


--
-- TOC entry 2507 (class 2604 OID 18442)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dependencia ALTER COLUMN id SET DEFAULT nextval('dependencia_id_seq'::regclass);


--
-- TOC entry 2508 (class 2604 OID 18446)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hist_eventos ALTER COLUMN id SET DEFAULT nextval('hist_eventos_id_seq'::regclass);


--
-- TOC entry 2520 (class 2604 OID 18447)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY radicado ALTER COLUMN id SET DEFAULT nextval('radicado_id_seq'::regclass);


--
-- TOC entry 2527 (class 2604 OID 18448)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_agen_agendados ALTER COLUMN id SET DEFAULT nextval('sgd_agen_agendados_id_seq'::regclass);


--
-- TOC entry 2535 (class 2604 OID 18449)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_dir_drecciones ALTER COLUMN id SET DEFAULT nextval('sgd_dir_drecciones_id_seq'::regclass);


--
-- TOC entry 2539 (class 2604 OID 18450)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_exp_expediente ALTER COLUMN id SET DEFAULT nextval('sgd_exp_expediente_id_seq'::regclass);


--
-- TOC entry 2542 (class 2604 OID 18451)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_hfld_histflujodoc ALTER COLUMN id SET DEFAULT nextval('sgd_hfld_histflujodoc_id_seq'::regclass);


--
-- TOC entry 2546 (class 2604 OID 18452)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_parexp_paramexpediente ALTER COLUMN id SET DEFAULT nextval('sgd_parexp_paramexpediente_id_seq'::regclass);


--
-- TOC entry 2549 (class 2604 OID 18453)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_plan_plantillas ALTER COLUMN id SET DEFAULT nextval('sgd_plan_plantillas_id_seq'::regclass);


--
-- TOC entry 2550 (class 2604 OID 18454)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_rdf_retdocf ALTER COLUMN id SET DEFAULT nextval('sgd_rdf_retdocf_id_seq'::regclass);


--
-- TOC entry 2560 (class 2604 OID 18455)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_renv_regenvio ALTER COLUMN id SET DEFAULT nextval('sgd_renv_regenvio_id_seq'::regclass);


--
-- TOC entry 2564 (class 2604 OID 18456)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_sexp_secexpedientes ALTER COLUMN id SET DEFAULT nextval('sgd_sexp_secexpedientes_id_seq'::regclass);


--
-- TOC entry 2584 (class 2604 OID 18457)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario ALTER COLUMN id SET DEFAULT nextval('usuario_id_seq'::regclass);


--
-- TOC entry 2925 (class 0 OID 17470)
-- Dependencies: 180
-- Data for Name: anexos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY anexos (id, anex_radi_nume, anex_codigo, anex_tipo, anex_tamano, anex_solo_lect, anex_creador, anex_desc, anex_numero, anex_nomb_archivo, anex_borrado, anex_origen, anex_ubic, anex_salida, radi_nume_salida, anex_radi_fech, anex_estado, usua_doc, sgd_rem_destino, anex_fech_envio, sgd_dir_tipo, anex_fech_impres, anex_depe_creador, sgd_doc_secuencia, sgd_doc_padre, sgd_arg_codigo, sgd_tpr_codigo, sgd_deve_codigo, sgd_deve_fech, sgd_fech_impres, anex_fech_anex, anex_depe_codi, sgd_pnufe_codi, sgd_dnufe_codi, anex_usudoc_creador, sgd_fech_doc, sgd_apli_codi, sgd_trad_codigo, sgd_dir_direccion, muni_codi, dpto_codi, sgd_exp_numero, anex_tipo_envio, anex_sha1) FROM stdin;
\.


--
-- TOC entry 3068 (class 0 OID 0)
-- Dependencies: 181
-- Name: anexos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('anexos_id_seq', 1, true);


--
-- TOC entry 2927 (class 0 OID 17487)
-- Dependencies: 182
-- Data for Name: anexos_tipo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY anexos_tipo (anex_tipo_codi, anex_tipo_ext, anex_tipo_desc) FROM stdin;
13	csv	csv (separado por comas)
1	doc	.doc (Procesador de texto - Word)
2	xls	.xls (Hoja de calculo)
3	ppt	.ppt (Presentacion)
4	tif	.tif (Imagen)
5	jpg	.jpg (Imagen)
6	gif	.gif (Imagen)
7	pdf	.pdf (Acrobat Reader)
8	txt	.txt (Documento texto)
20	avi	.avi (Video)
21	mpg	.mpg (video)
16	xml	.xml (XML de Microsoft Word 2003)
23	tar	.tar (Comprimido)
9	zip	.zip (Comprimido)
10	rtf	.rtf (Rich Text Format)
11	dia	.dia (Diagrama)
12	zargo	Argo(Diagrama)
18	docx	.docx (Word > 2007)
17	png	.png (Imagen)
14	odt	.odt (Procesador de Texto - odf)
15	ods	.ods (Hoja de Calculo - Odf)
24	xlsx	Archivos de Excel 2014
\.


--
-- TOC entry 2928 (class 0 OID 17490)
-- Dependencies: 183
-- Data for Name: autg_grupos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY autg_grupos (id, nombre, descripcion) FROM stdin;
5	Radicación Entrada	Radicación del Sistema
6	Envíos	Usuario para envíos de Correspondencia
2	Administrador	Administrador del sistema
3	Digitalizador	Digitaliza oficios entrada, salida y fondos. 
4	Secretaria	Secretaria por dependencia
7	Archivo Fisico	Archivo Fisico del proceso de gestion documental
8	Jefe	Jefes de dependencia.
9	Asistente	Asiste al jefe en diversas tareas
10	funcionario	usuario que radica internos y salidas
\.


--
-- TOC entry 2929 (class 0 OID 17496)
-- Dependencies: 184
-- Data for Name: autm_membresias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY autm_membresias (id, autg_id, autu_id) FROM stdin;
1	1	148
2	1	95
3	1	90
4	1	81
5	1	116
6	1	164
7	1	162
8	1	143
10	3	204
11	2	4
13	2	2
14	8	205
15	5	205
18	2	207
19	8	208
20	7	209
21	7	211
22	7	212
23	7	214
24	4	215
25	7	216
26	6	217
27	4	217
28	5	217
30	5	206
31	5	210
32	4	210
33	5	212
34	5	218
35	4	219
36	3	220
38	3	218
39	4	221
40	8	232
41	9	234
43	8	242
44	4	244
45	9	244
46	8	245
47	8	250
48	7	250
49	7	251
50	7	252
51	7	253
52	7	254
53	7	249
54	8	255
56	8	260
58	6	218
59	4	218
60	9	218
61	8	271
64	4	288
65	9	288
66	8	276
67	8	292
68	8	297
69	4	304
70	9	304
71	9	321
72	4	321
73	8	326
74	5	328
75	5	329
76	5	330
77	6	328
78	6	329
79	6	330
80	3	328
81	3	329
82	3	330
83	4	329
84	4	328
85	4	330
86	9	328
87	9	329
88	9	330
92	8	333
93	5	2
94	6	2
95	3	2
96	4	2
97	7	2
98	8	2
99	9	2
101	6	334
102	8	331
103	2	334
104	8	335
105	8	336
106	8	337
107	8	338
108	8	339
109	8	340
110	10	269
111	10	332
112	10	233
113	10	219
114	10	220
115	10	169
116	10	234
117	10	232
118	10	242
119	10	319
120	10	295
121	10	252
122	10	268
123	10	243
124	10	241
125	10	259
126	10	208
127	10	270
128	10	212
129	10	206
130	10	245
131	10	213
132	10	217
133	10	287
134	10	304
135	10	286
136	10	278
137	10	311
138	10	228
139	10	263
140	10	272
141	10	244
142	10	323
143	10	253
144	10	236
145	10	254
146	10	266
147	10	214
148	10	316
149	10	334
150	10	20
151	10	126
152	10	215
153	10	117
154	10	225
155	10	257
156	10	265
157	10	280
158	10	282
159	10	281
160	10	314
161	10	313
162	10	299
163	10	306
164	10	307
165	10	312
166	10	315
167	10	309
168	10	264
169	10	224
170	10	238
171	10	239
172	10	273
173	10	328
174	10	240
175	10	318
176	10	329
177	10	204
178	10	218
179	10	202
180	10	210
181	10	211
182	10	205
183	10	327
184	10	258
185	10	226
186	10	216
187	10	249
188	10	294
189	10	275
190	10	321
191	10	267
192	10	283
193	10	284
194	10	302
199	10	227
195	10	285
197	10	325
196	10	303
198	10	262
200	10	293
201	10	237
202	10	231
203	10	261
204	10	256
205	10	255
206	10	246
207	10	229
208	10	222
209	10	248
210	10	251
211	10	296
212	10	317
213	10	274
214	10	320
215	10	250
216	10	277
217	10	291
218	10	289
219	10	279
220	10	308
221	10	298
222	10	300
223	10	301
224	10	322
225	10	305
226	10	230
227	10	331
228	10	336
229	10	337
230	10	2
231	10	330
232	10	335
233	10	290
234	10	340
235	10	288
236	10	339
237	10	310
238	10	338
239	9	332
240	4	234
241	4	332
242	10	341
243	8	342
244	8	343
245	5	253
246	5	252
247	5	254
248	5	216
249	5	250
250	5	251
251	6	252
252	6	253
253	6	254
254	6	216
255	6	250
256	6	251
257	3	252
258	3	253
259	3	254
260	3	216
261	3	250
262	3	251
263	4	252
264	4	253
265	4	254
266	4	216
267	4	250
268	4	251
269	7	328
270	7	218
271	7	329
272	9	252
273	9	253
274	9	254
275	9	216
276	9	250
277	9	251
278	10	344
279	7	330
280	9	249
281	3	249
282	6	249
283	5	249
284	8	345
\.


--
-- TOC entry 2930 (class 0 OID 17499)
-- Dependencies: 185
-- Data for Name: autp_permisos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY autp_permisos (id, autg_id, nombre, descripcion, crud, dependencia) FROM stdin;
44	\N	USUARIO_PRUEBA	PRUEBA	3	\N
45	\N	USUARIO_PUBLICO	Habilita la visibilidad de un usuario	1	\N
46	\N	USUARIO_REASIGNA	Usuario reasigna	1	\N
36	\N	USUA_AUTH_LDAP	Autentica por LDAP	0	\N
18	0	USUARIO_REASIGNAR	reasignar	1	
15	0	SGD_PANU_CODI	Anulacion	1	
37	\N	USUA_NUEVO	El usuario que tenga este permiso, se le resetea la contraseña	1	\N
47	\N	USUA_SCAN	PERMISO DIGITALIZACION 	1	\N
48	\N	USUA_SCAN	PERMISO DIGITALIZACION 	1	\N
33	\N	USUA_PERM_OWNCLOUD	DIGITALIZADOR_OwnCloud	1	\N
32	\N	CODI_NIVEL	Codigo del nivel	5	\N
12	0	DEPE_CODI_PADRE	codigo padre	1	
27	0	PERM_ARCHI	permiso archivo	1	
10	0	PERM_BORRAR_ANEXO	borrar anexo	1	
9	0	PERM_TIPIF_ANEXO	anexo	1	
28	0	PERM_VOBO	permiso visto bueno	1	
7	0	PERM_RADI	radicacion	1	
34	\N	SGD_PERM_ESTADISTICA	Estadistica Nivel 2	2	\N
35	\N	SGD_PERM_ESTADISTICA	Estadistica nivel Maximo	5	\N
1	0	USUA_ADM_PLANTILLA	Uso de plantillas	1	
2	0	USUA_ADMIN_ARCHIVO	Administrador Archivo	1	
5	0	USUA_ADMIN_ARCHIVO	ARCHIVO EDITAR	2	
6	0	USUA_ADMIN_SISTEMA	Administrador del sistema	1	
11	0	USUA_MASIVA	radicacion masiva	1	
30	0	USUA_PERM_ADMINFLUJOS	FLUJOS	1	
14	0	USUA_PERM_DEV	DESCRIPCION	1	
21	0	USUA_PERM_FIRMA	FIRMA	1	
8	0	USUA_PERM_IMPRESION	Permiso para marcar como impreso	2	
20	0	USUA_PERM_INTERGAPPS	DESCRIPCION	1	
17	0	USUA_PERM_MODIFICA	modificacion	1	
23	0	USUA_PERM_NOTIFICA	DESCRIPCION	1	
22	0	USUA_PERM_PRESTAMO	DESCRIPCION	1	
25	0	USUA_PERM_RADEMAIL	DESCRIPCION	1	
26	0	USUA_PERM_RADFAX	DESCRIPCION	1	
13	0	USUA_PERM_NUMERA_RES	numeracion	0	
29	0	USUA_PERM_RESPUESTA	DESCRIPCION	1	
19	0	USUA_PERM_SANCIONADOS	DESCRIPCION	1	
3	0	USUA_PERM_TRD	Administrador TRD	3	
38	\N	USUA_PERM_TRD	TRD	1	\N
40	\N	USUA_PRAD_REPRAD	Permiso reporte de Radicación de Entrada	1	\N
42	\N	USUA_PRAD_TP2	Permiso Radicación de Entrada	1	\N
49	\N	USUA_PERM_STICKER	Permiso de STICKER	1	\N
50	\N	a	a	0	\N
51	\N	Dpruebas	Pruebas D	1	\N
16	0	USUA_PERM_ENVIOS	ENVIOS	1	
41	\N	USUA_PRAD_TP1	Radica Salida	3	\N
43	\N	USUA_PRAD_TP3	Radicar Interno	1	\N
24	0	USUA_PERM_EXPEDIENTE	EXPEDIENTE	3	
31	\N	USUA_ADMIN_ARCHIVO	ARCHIVO	0	\N
4	0	SGD_PERM_ESTADISTICA	permisos estadistica	2	
39	\N	USUA_PERM_TRD	TRD	5	\N
\.


--
-- TOC entry 2931 (class 0 OID 17505)
-- Dependencies: 186
-- Data for Name: autr_restric_grupo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY autr_restric_grupo (id, autg_id, autp_id) FROM stdin;
2	6	\N
106	5	42
107	2	42
108	5	49
109	2	49
14	2	18
20	4	32
21	4	12
22	4	27
23	2	10
24	7	10
30	7	9
31	4	28
38	2	7
39	3	7
40	4	7
41	5	7
42	6	7
43	4	34
44	4	35
45	2	1
46	4	1
47	7	2
51	2	5
52	7	5
54	2	6
55	2	36
56	2	11
57	4	11
59	4	30
60	4	14
63	4	21
64	4	8
65	4	20
66	4	17
67	4	23
69	4	22
70	4	25
71	4	26
72	2	13
73	4	13
74	4	29
75	4	19
76	7	3
77	2	38
79	4	40
86	4	44
87	4	45
88	2	46
89	4	46
93	2	15
94	8	15
95	4	37
96	7	37
103	3	47
104	3	48
105	3	33
110	5	50
117	2	51
121	6	16
122	4	16
123	2	41
124	4	41
125	8	41
126	9	41
127	10	41
128	6	43
129	2	43
130	4	43
131	10	43
132	2	24
133	8	24
134	9	24
135	2	31
136	7	31
137	5	4
138	6	4
139	2	4
140	3	4
141	4	4
142	7	4
143	8	4
144	2	39
145	7	39
\.


--
-- TOC entry 2932 (class 0 OID 17508)
-- Dependencies: 187
-- Data for Name: autu_usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY autu_usuarios (id, nombres, apellidos, correo, contrasena, usuario, estado) FROM stdin;
\.


--
-- TOC entry 2933 (class 0 OID 17514)
-- Dependencies: 188
-- Data for Name: bodega_empresas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY bodega_empresas (nombre_de_la_empresa, nuir, nit_de_la_empresa, sigla_de_la_empresa, direccion, codigo_del_departamento, codigo_del_municipio, telefono_1, telefono_2, email, nombre_rep_legal, cargo_rep_legal, identificador_empresa, are_esp_secue, id_cont, id_pais, activa, flag_rups) FROM stdin;
\.


--
-- TOC entry 2934 (class 0 OID 17547)
-- Dependencies: 189
-- Data for Name: carpeta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY carpeta (carp_codi, carp_desc) FROM stdin;
0	Entrada
12	Devueltos
11	Vo.Bo.
1	Salida
3	Memos
4	Transferencias
13	Radicados Antiguos
5	Resoluciones
\.


--
-- TOC entry 2935 (class 0 OID 17550)
-- Dependencies: 190
-- Data for Name: carpeta_per; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY carpeta_per (usua_codi, depe_codi, nomb_carp, desc_carp, codi_carp) FROM stdin;
\.


--
-- TOC entry 2936 (class 0 OID 17701)
-- Dependencies: 191
-- Data for Name: departamento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY departamento (dpto_codi, dpto_nomb, id_cont, id_pais) FROM stdin;
8	ATLANTICO	1	170
11	D.C.	1	170
13	BOLIVAR	1	170
15	BOYACA	1	170
17	CALDAS	1	170
5	ANTIOQUIA	1	170
18	CAQUETA	1	170
19	CAUCA	1	170
20	CESAR	1	170
23	CORDOBA	1	170
25	CUNDINAMARCA	1	170
27	CHOCO	1	170
41	HUILA	1	170
44	LA GUAJIRA	1	170
47	MAGDALENA	1	170
50	META	1	170
52	NARINO	1	170
54	NORTE DE SANTANDER	1	170
63	QUINDIO	1	170
66	RISARALDA	1	170
68	SANTANDER	1	170
70	SUCRE	1	170
73	TOLIMA	1	170
76	VALLE DEL CAUCA	1	170
81	ARAUCA	1	170
85	CASANARE	1	170
86	PUTUMAYO	1	170
88	SAN ANDRES	1	170
91	AMAZONAS	1	170
94	GUAINIA	1	170
95	GUAVIARE	1	170
97	VAUPES	1	170
99	VICHADA	1	170
9	CALIFORNIA	1	200
0	NO EXISTE	1	170
1	TODOS	1	170
2	SAO PAULO	1	29
3	LIMA	1	166
4	KENTUCKY	1	223
6	TEXAS	1	223
7	DISTRITO FEDERAL	1	137
98	RIO DE JANEIRO	1	29
80	LA PAZ	1	25
\.


--
-- TOC entry 2937 (class 0 OID 17709)
-- Dependencies: 192
-- Data for Name: dependencia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY dependencia (id, depe_codi, depe_nomb, dpto_codi, depe_codi_padre, muni_codi, depe_codi_territorial, dep_sigla, dep_central, dep_direccion, depe_num_interna, depe_num_resolucion, depe_rad_tp1, acto_admon, id_cont, id_pais, depe_estado) FROM stdin;
2	900	PRUEBAS	11	900	1	900	pb	\N		900	\N	900		1	170	1
1	100	GERENCIA	11	\N	1	0	GG	\N		\N	\N	100		1	170	1
3	999	ARCHIVO VIRTUAL	11	100	1	100	ARCHIVO	\N	Calle 52 No. 13 - 64 Pisos 7 - 8 y 9	\N	\N	100		1	170	1
\.


--
-- TOC entry 3069 (class 0 OID 0)
-- Dependencies: 193
-- Name: dependencia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('dependencia_id_seq', 4, true);


--
-- TOC entry 2939 (class 0 OID 17717)
-- Dependencies: 194
-- Data for Name: dependencia_visibilidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY dependencia_visibilidad (codigo_visibilidad, dependencia_visible, dependencia_observa) FROM stdin;
637	905	905
147	110	100
148	110	110
149	110	120
150	110	130
151	110	200
152	110	300
153	110	400
154	110	410
155	110	420
156	110	430
157	110	440
158	110	450
159	110	460
160	110	500
161	110	600
162	110	605
163	110	900
164	110	905
165	110	999
166	120	100
167	120	110
168	120	120
169	120	130
170	120	200
171	120	300
172	120	400
173	120	410
174	120	420
175	120	430
176	120	440
177	120	450
178	120	460
179	120	500
180	120	600
181	120	605
182	120	900
183	120	905
184	120	999
185	130	100
186	130	110
187	130	120
188	130	130
189	130	200
190	130	300
191	130	400
192	130	410
193	130	420
194	130	430
195	130	440
196	130	450
197	130	460
198	130	500
199	130	600
200	130	605
201	130	900
202	130	905
203	130	999
242	400	100
243	400	110
244	400	120
245	400	130
246	400	200
247	400	300
248	400	400
249	400	410
250	400	420
251	400	430
252	400	440
253	400	450
254	400	460
255	400	500
256	400	600
257	400	605
258	400	900
259	400	905
260	400	999
566	460	100
567	460	110
568	460	120
569	460	130
570	460	200
571	460	300
572	460	400
573	460	410
574	460	420
575	460	430
576	460	440
577	460	450
578	460	460
579	460	500
580	460	600
581	460	605
582	460	900
583	460	905
584	460	999
617	300	100
618	300	110
619	300	120
620	300	130
621	300	200
622	300	300
623	300	301
624	300	400
625	300	410
626	300	420
627	300	430
628	300	440
629	300	450
630	300	460
631	300	500
632	300	600
633	300	605
634	300	900
635	300	905
636	300	999
337	450	100
338	450	110
339	450	120
340	450	130
341	450	200
342	450	300
343	450	400
344	450	410
345	450	420
346	450	430
347	450	440
348	450	450
349	450	460
350	450	500
351	450	600
352	450	605
353	450	900
354	450	905
355	450	999
375	500	100
376	500	110
377	500	120
378	500	130
379	500	200
380	500	300
381	500	400
382	500	410
383	500	420
384	500	430
385	500	440
386	500	450
387	500	460
388	500	500
389	500	600
390	500	605
391	500	900
392	500	905
393	500	999
394	600	100
395	600	110
396	600	120
397	600	130
398	600	200
399	600	300
400	600	400
401	600	410
402	600	420
403	600	430
404	600	440
405	600	450
406	600	460
407	600	500
408	600	600
409	600	605
410	600	900
411	600	905
412	600	999
431	200	100
432	200	110
433	200	120
434	200	130
435	200	200
436	200	300
437	200	400
438	200	410
439	200	420
440	200	430
441	200	440
442	200	450
443	200	460
444	200	500
445	200	600
446	200	605
447	200	900
448	200	905
449	200	999
450	605	100
451	605	110
452	605	120
453	605	130
454	605	200
455	605	300
456	605	400
457	605	410
458	605	420
459	605	430
460	605	440
461	605	450
462	605	460
463	605	500
464	605	600
465	605	605
466	605	900
467	605	905
468	605	999
591	900	900
592	420	100
593	420	400
594	420	420
595	420	700
596	420	999
597	100	100
598	100	110
599	100	120
600	100	130
601	100	200
602	100	300
603	100	301
604	100	400
605	100	410
606	100	420
607	100	430
608	100	440
609	100	450
610	100	460
611	100	500
612	100	600
613	100	605
614	100	900
615	100	905
616	100	999
469	301	100
470	301	110
471	301	120
472	301	130
473	301	200
474	301	300
475	301	301
476	301	400
477	301	410
478	301	420
479	301	430
480	301	440
481	301	450
482	301	460
483	301	500
484	301	600
485	301	605
486	301	700
487	301	900
488	301	905
489	301	999
528	430	100
529	430	110
530	430	120
531	430	130
532	430	200
533	430	300
534	430	400
535	430	410
536	430	420
537	430	430
538	430	440
539	430	450
540	430	460
541	430	500
542	430	600
543	430	605
544	430	900
545	430	905
546	430	999
547	440	100
548	440	110
549	440	120
550	440	130
551	440	200
552	440	300
553	440	400
554	440	410
555	440	420
556	440	430
557	440	440
558	440	450
559	440	460
560	440	500
561	440	600
562	440	605
563	440	900
564	440	905
565	440	999
638	110	100
639	110	900
640	110	905
641	110	999
642	120	905
643	130	100
644	130	110
645	130	120
646	130	900
647	130	905
648	130	999
649	200	100
650	200	110
651	200	120
652	200	130
653	200	900
654	200	905
655	200	999
656	300	100
657	300	110
658	300	120
659	300	130
660	300	200
661	300	900
662	300	905
663	300	999
664	400	100
665	400	110
666	400	120
667	400	130
668	400	200
669	400	300
670	400	900
671	400	905
672	400	999
694	410	100
695	410	110
696	410	120
697	410	130
698	410	200
699	410	300
700	410	400
701	410	410
702	410	900
703	410	905
704	410	999
716	420	411
717	430	300
718	440	100
719	440	110
720	440	120
721	440	130
722	440	200
723	440	300
724	440	400
725	440	410
726	440	900
727	440	905
728	440	999
729	450	440
730	460	100
731	460	110
732	460	120
733	460	130
734	460	200
735	460	300
736	460	400
737	460	410
738	460	420
739	460	430
740	460	440
741	460	450
742	460	900
743	460	905
744	460	999
745	470	100
746	470	110
747	470	120
748	470	130
749	470	200
750	470	300
751	470	400
752	470	410
753	470	420
754	470	430
755	470	440
756	470	450
757	470	460
758	470	900
759	470	905
760	470	999
761	500	100
762	500	110
763	500	120
764	500	130
765	500	200
766	500	300
767	500	400
768	500	410
769	500	420
770	500	430
771	500	440
772	500	450
773	500	460
774	500	900
775	500	905
776	500	999
777	510	100
778	510	110
779	510	120
780	510	130
781	510	200
782	510	300
783	510	400
784	510	410
785	510	420
786	510	430
787	510	440
788	510	450
789	510	460
790	510	500
791	510	900
792	510	905
793	510	999
794	600	100
795	600	110
796	600	120
797	600	130
798	600	200
799	600	300
800	600	400
801	600	410
802	600	420
803	600	430
804	600	440
805	600	450
806	600	460
807	600	500
808	600	900
809	600	905
810	600	999
812	412	100
813	412	110
814	412	120
815	412	130
816	412	200
817	412	300
818	412	400
819	412	410
820	412	900
821	412	905
822	412	999
823	411	900
\.


--
-- TOC entry 2940 (class 0 OID 17720)
-- Dependencies: 195
-- Data for Name: estado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY estado (esta_codi, esta_desc) FROM stdin;
9	Documento de Orfeo
\.


--
-- TOC entry 2941 (class 0 OID 17744)
-- Dependencies: 196
-- Data for Name: hist_eventos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hist_eventos (id, depe_codi, hist_fech, usua_codi, radi_nume_radi, hist_obse, usua_codi_dest, usua_doc, sgd_ttr_codigo, hist_usua_autor, hist_doc_dest, depe_codi_dest) FROM stdin;
\.


--
-- TOC entry 3070 (class 0 OID 0)
-- Dependencies: 197
-- Name: hist_eventos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hist_eventos_id_seq', 1, true);


--
-- TOC entry 2943 (class 0 OID 17752)
-- Dependencies: 198
-- Data for Name: informados; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY informados (radi_nume_radi, usua_codi, depe_codi, info_desc, info_fech, info_leido, info_codi, usua_doc, info_conjunto, usua_doc_origen) FROM stdin;
\.


--
-- TOC entry 2944 (class 0 OID 17760)
-- Dependencies: 199
-- Data for Name: medio_recepcion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY medio_recepcion (mrec_codi, mrec_desc) FROM stdin;
2	Fax
9	Chat
8	Call Center
1	Personal
3	Sitio Web
5	Mensajería
7	Atención Personalizada
4	Correo electrónico
6	Telefónico
0	No especificado
\.


--
-- TOC entry 2945 (class 0 OID 17763)
-- Dependencies: 200
-- Data for Name: municipio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY municipio (muni_codi, dpto_codi, muni_nomb, id_cont, id_pais, homologa_muni, homologa_idmuni, activa) FROM stdin;
537	15	PAZ DE RIO	1	170	\N	268	1
599	54	RAGONVALIA	1	170	\N	807	1
720	68	SANTA HELENA DEL OPON	1	170	\N	920	1
675	23	SAN BERNARDO DEL VIENTO	1	170	\N	453	1
224	52	CUASPUD	1	170	\N	727	1
745	47	SITIONUEVO	1	170	\N	682	1
221	70	COVENAS	1	170	\N	937	1
1	99	PUERTO CARRENO	1	170	\N	1101	1
307	68	GIRON (SAN JUAN DE)	1	170	\N	880	1
569	86	PUERTO CAICEDO	1	170	\N	1080	1
427	52	MAGUI	1	170	\N	751	1
645	25	S.ANTONIO TEQUENDAMA	1	170	\N	534	1
138	5	CANASGORDAS	1	170	\N	30	1
570	47	PUEBLOVIEJO	1	170	\N	674	1
753	18	SAN VICENTE DEL CAGUAN	1	170	\N	360	1
99	27	BOJAYA	1	170	\N	581	1
576	5	PUEBLORRICO	1	170	\N	80	1
541	5	PENOL	1	170	\N	78	1
250	27	EL LITORAL DEL SAN JUAN	1	170	\N	587	1
25	27	ALTO BAUDO	1	170	\N	576	1
75	27	BAHIA SOLANO	1	170	\N	579	1
662	25	SAN JUAN DE RIO SECO	1	170	\N	538	1
692	47	SAN SEBASTIAN BUENAVISTA	1	170	\N	678	1
94	18	BELEN DE LOS ANDAQUIES	1	170	\N	350	1
381	52	LA FLORIDA	1	170	\N	744	1
258	52	EL TABLON	1	170	\N	734	1
893	5	YONDO	1	170	\N	126	1
0	0	No Existe	1	170	\N	\N	1
1	8	BARRANQUILLA	1	170	\N	128	1
873	5	VIGIA DEL FUERTE	1	170	\N	122	1
809	5	TITIRIBI	1	170	\N	113	1
667	5	SAN RAFAEL	1	170	\N	100	1
647	5	SAN ANDRES	1	170	\N	91	1
656	5	SAN JERONIMO	1	170	\N	94	1
440	5	MARINILLA	1	170	\N	70	1
475	5	MURINDO	1	170	\N	72	1
483	5	NARINO	1	170	\N	\N	1
817	25	TOCANCIPA	1	170	\N	558	1
862	25	VERGARA	1	170	\N	565	1
873	25	VILLAPINZON	1	170	\N	568	1
455	15	MIRAFLORES	1	170	\N	251	1
469	15	MONIQUIRA	1	170	\N	254	1
511	15	PACHAVITA	1	170	\N	261	1
238	15	DUITAMA	1	170	\N	229	1
248	15	EL ESPINO	1	170	\N	231	1
276	15	FLORESTA	1	170	\N	233	1
332	15	GUICAN	1	170	\N	240	1
367	15	JENESANO	1	170	\N	242	1
172	15	CHINAVITA	1	170	\N	213	1
180	15	CHISCAS	1	170	\N	215	1
189	15	CIENEGA	1	170	\N	219	1
327	68	GUEPSA	1	170	\N	885	1
271	68	FLORIAN	1	170	\N	876	1
209	68	CONFINES	1	170	\N	866	1
81	68	BARRANCABERMEJA	1	170	\N	851	1
170	66	DOSQUEBRADAS	1	170	\N	835	1
190	63	CIRCASIA	1	170	\N	822	1
175	25	CHIA	1	170	\N	473	1
224	25	CUCUNUBA	1	170	\N	479	1
40	25	ANOLAIMA	1	170	\N	461	1
148	25	CAPARRAPI	1	170	\N	469	1
83	52	BELEN	1	170	\N	202	1
370	50	LA URIBE	1	170	\N	702	1
711	50	VISTA HERMOSA	1	170	\N	714	1
300	80	LA PAZ	1	173	\N	891	1
245	50	EL CALVARIO	1	170	\N	693	1
287	50	FUENTE DE ORO	1	170	\N	696	1
318	47	GUAMAL	1	170	\N	668	1
551	47	PIVIJAY	1	170	\N	672	1
53	47	ARACATACA	1	170	\N	658	1
874	44	VILLANUEVA	1	170	\N	196	1
585	19	PURACE	1	170	\N	391	1
693	19	SAN SEBASTIAN	1	170	\N	393	1
513	19	PADILLA	1	170	\N	385	1
318	19	GUAPI	1	170	\N	376	1
110	19	BUENOS AIRES	1	170	\N	369	1
50	19	ARGELIA	1	170	\N	16	1
1	19	POPAYAN	1	170	\N	364	1
1	18	FLORENCIA	1	170	\N	348	1
256	18	EL PAUJIL	1	170	\N	354	1
460	18	MILAN	1	170	\N	356	1
442	17	MARMATO	1	170	\N	331	1
444	17	MARQUETALIA	1	170	\N	332	1
524	17	PALESTINA	1	170	\N	337	1
372	8	JUAN DE ACOSTA	1	170	\N	133	1
520	8	PALMAR DE VARELA	1	170	\N	137	1
560	8	PONEDERA	1	170	\N	140	1
244	13	EL CARMEN DE BOLIVAR	1	170	\N	165	1
109	76	BUENAVENTURA	1	170	\N	1013	1
54	76	ARGELIA	1	170	\N	16	1
31	5	AMALFI	1	170	\N	7	1
38	5	ANGOSTURA	1	170	\N	10	1
59	5	ARMENIA	1	170	\N	17	1
497	76	OBANDO	1	170	\N	1032	1
147	76	CARTAGO	1	170	\N	1019	1
204	70	COLOSO	1	170	\N	935	1
283	73	FRESNO	1	170	\N	977	1
551	41	PITALITO	1	170	\N	628	1
797	41	TESALIA	1	170	\N	635	1
418	54	LOURDES	1	170	\N	801	1
660	54	SALAZAR	1	170	\N	808	1
347	54	HERRAN	1	170	\N	796	1
99	54	BOCHALEMA	1	170	\N	782	1
854	5	VALDIVIA	1	170	\N	118	1
665	5	SAN PEDRO DE URABA	1	170	\N	99	1
652	5	SAN FRANCISCO	1	170	\N	93	1
769	25	SUBACHOQUE	1	170	\N	546	1
513	25	PACHO	1	170	\N	522	1
761	15	SOMONDOCO	1	170	\N	296	1
646	15	SAMACA	1	170	\N	278	1
667	15	SAN LUIS DE GACENO	1	170	\N	281	1
114	15	BUSBANZA	1	170	\N	209	1
667	13	SAN MARTIN DE LOBA	1	170	\N	185	1
745	68	SIMACOTA	1	170	\N	921	1
468	68	MOLAGAVITA	1	170	\N	898	1
1	68	BUCARAMANGA	1	170	\N	845	1
88	66	BELEN DE UMBRIA	1	170	\N	834	1
290	25	FUSAGASUGA	1	170	\N	488	1
74	13	BARRANCO DE LOBA	1	170	\N	159	1
672	23	SAN ANTERO	1	170	\N	452	1
233	52	CUMBITARA	1	170	\N	729	1
313	50	GRANADA	1	170	\N	54	1
350	50	LA MACARENA	1	170	\N	701	1
660	47	SABANAS DE SAN ANGEL	1	170	\N	676	1
450	27	MEDIO SAN JUAN	1	170	\N	593	1
580	27	RIO ORO	1	170	\N	\N	1
495	17	NORCASIA	1	170	\N	335	1
568	86	PUERTO ASIS	1	170	\N	1079	1
219	86	COLON	1	170	\N	1076	1
571	86	PUERTO GUZMAN	1	170	\N	1081	1
749	86	SIBUNDOY	1	170	\N	1083	1
755	86	SAN FRANCISCO	1	170	\N	93	1
885	86	VILLAGARZON	1	170	\N	1088	1
1	88	SAN ANDRES	1	170	\N	91	1
263	85	PORE	1	170	\N	1066	1
279	85	RECETOR	1	170	\N	1067	1
300	85	SABANALARGA	1	170	\N	144	1
400	85	TAMARA	1	170	\N	1071	1
410	85	TAURAMENA	1	170	\N	1072	1
440	85	VILLANUEVA	1	170	\N	196	1
1	86	MOCOA	1	170	\N	1075	1
225	85	NUNCHIA	1	170	\N	1063	1
250	85	PAZ DE ARIPORO	1	170	\N	1065	1
15	85	CHAMEZA	1	170	\N	1058	1
136	85	LA SALINA	1	170	\N	1060	1
139	85	MANI	1	170	\N	1061	1
220	81	CRAVO NORTE	1	170	\N	1051	1
591	81	PUERTO RONDON	1	170	\N	1053	1
736	81	SARAVENA	1	170	\N	1054	1
869	76	VIJES	1	170	\N	1045	1
890	76	YOTOCO	1	170	\N	1046	1
895	76	ZARZAL	1	170	\N	1048	1
834	76	TULUA	1	170	\N	1042	1
845	76	ULLOA	1	170	\N	1043	1
670	76	SAN PEDRO	1	170	\N	98	1
563	76	PRADERA	1	170	\N	1034	1
606	76	RESTREPO	1	170	\N	709	1
520	76	PALMIRA	1	170	\N	1033	1
318	76	GUACARI	1	170	\N	1027	1
364	76	JAMUNDI	1	170	\N	1028	1
246	76	EL CAIRO	1	170	\N	1022	1
275	76	FLORIDA	1	170	\N	1025	1
233	76	DAGUA	1	170	\N	1020	1
243	76	EL AGUILA	1	170	\N	1021	1
111	76	BUGA	1	170	\N	1014	1
110	70	BUENAVISTA	1	170	\N	208	1
124	70	CAIMITO	1	170	\N	934	1
215	70	COROZAL	1	170	\N	936	1
230	70	CHALAN	1	170	\N	938	1
780	68	SURATA	1	170	\N	925	1
820	68	TONA	1	170	\N	926	1
861	68	VELEZ	1	170	\N	928	1
872	68	VILLANUEVA	1	170	\N	196	1
895	68	ZAPATOCA	1	170	\N	931	1
1	70	SINCELEJO	1	170	\N	932	1
675	73	SAN ANTONIO	1	170	\N	998	1
678	73	SAN LUIS	1	170	\N	97	1
770	73	SUAREZ	1	170	\N	398	1
873	73	VILLARRICA	1	170	\N	1005	1
1	76	CALI	1	170	\N	1006	1
616	73	RIOBLANCO	1	170	\N	994	1
411	73	LIBANO	1	170	\N	983	1
461	73	MURILLO	1	170	\N	986	1
504	73	ORTEGA	1	170	\N	988	1
319	73	GUAMO	1	170	\N	978	1
168	73	CHAPARRAL	1	170	\N	969	1
217	73	COYAIMA	1	170	\N	971	1
270	73	FALAN	1	170	\N	975	1
43	73	ANZOATEGUI	1	170	\N	963	1
279	44	FONSECA	1	170	\N	647	1
430	44	MAICAO	1	170	\N	650	1
1	44	RIOHACHA	1	170	\N	641	1
78	44	BARRANCAS	1	170	\N	643	1
676	41	SANTA MARIA	1	170	\N	286	1
871	54	VILLA CARO	1	170	\N	817	1
865	86	VALLE GUAMUEZ	1	170	\N	1087	1
671	73	SALDANA	1	170	\N	997	1
298	41	GARZON	1	170	\N	614	1
349	41	HOBO	1	170	\N	617	1
483	41	NATAGA	1	170	\N	622	1
548	41	PITAL	1	170	\N	627	1
6	41	ACEVEDO	1	170	\N	605	1
16	41	AIPE	1	170	\N	607	1
244	41	ELIAS	1	170	\N	613	1
745	27	SIPI	1	170	\N	600	1
800	27	UNGUIA	1	170	\N	602	1
820	70	TOLU	1	170	\N	956	1
742	70	SINCE	1	170	\N	954	1
523	70	PALMITO	1	170	\N	947	1
400	70	LA UNION	1	170	\N	67	1
429	70	MAJAGUAL	1	170	\N	944	1
508	70	OVEJAS	1	170	\N	946	1
413	27	LLORO	1	170	\N	590	1
495	27	NUQUI	1	170	\N	595	1
800	54	TEORAMA	1	170	\N	814	1
810	54	TIBU	1	170	\N	815	1
261	54	EL ZULIA	1	170	\N	793	1
377	54	LABATECA	1	170	\N	797	1
109	54	BUCARASICA	1	170	\N	783	1
172	54	CHINACOTA	1	170	\N	786	1
838	52	TUQUERRES	1	170	\N	777	1
788	52	TANGUA	1	170	\N	775	1
835	52	TUMACO	1	170	\N	776	1
687	52	SAN LORENZO	1	170	\N	768	1
693	52	SAN PABLO	1	170	\N	186	1
612	52	RICAURTE	1	170	\N	533	1
473	52	MOSQUERA	1	170	\N	515	1
560	52	POTOSI	1	170	\N	759	1
399	52	LA UNION	1	170	\N	67	1
405	52	LEIVA	1	170	\N	748	1
354	52	IMUES	1	170	\N	741	1
378	52	LA CRUZ	1	170	\N	743	1
320	52	GUAITARILLA	1	170	\N	738	1
890	5	YOLOMBO	1	170	\N	125	1
847	5	URRAO	1	170	\N	117	1
856	5	VALPARAISO	1	170	\N	119	1
837	5	TURBO	1	170	\N	115	1
842	5	URAMITA	1	170	\N	116	1
679	5	SANTA BARBARA	1	170	\N	103	1
649	5	SAN CARLOS	1	170	\N	92	1
664	5	SAN PEDRO	1	170	\N	98	1
591	5	PUERTO TRIUNFO	1	170	\N	83	1
607	5	RETIRO	1	170	\N	85	1
631	5	SABANETA	1	170	\N	89	1
411	5	LIBORINA	1	170	\N	68	1
480	5	MUTATA	1	170	\N	73	1
543	5	PEQUE	1	170	\N	79	1
898	25	ZIPACON	1	170	\N	572	1
815	25	TOCAIMA	1	170	\N	557	1
823	25	TOPAIPI	1	170	\N	559	1
878	25	VIOTA	1	170	\N	570	1
885	25	YACOPI	1	170	\N	571	1
718	25	SASAIMA	1	170	\N	539	1
92	27	CARMEN DEL DARIEN	1	170	\N	583	1
42	27	MEDIO BAUDO	1	170	\N	592	1
777	25	SUPATA	1	170	\N	548	1
785	25	TABIO	1	170	\N	551	1
109	27	RIO IRO	1	170	\N	596	1
491	25	NOCAIMA	1	170	\N	520	1
506	25	VENECIA	1	170	\N	121	1
530	25	PARATEBUENO	1	170	\N	525	1
592	25	QUEBRADANEGRA	1	170	\N	529	1
594	25	QUETAME	1	170	\N	530	1
599	25	APULO	1	170	\N	532	1
649	25	SAN BERNARDO	1	170	\N	535	1
653	25	SAN CAYETANO	1	170	\N	536	1
335	25	GUAYABETAL	1	170	\N	501	1
339	25	GUTIERREZ	1	170	\N	502	1
368	25	JERUSALEN	1	170	\N	503	1
372	25	JUNIN	1	170	\N	504	1
386	25	LA MESA	1	170	\N	506	1
402	25	LA VEGA	1	170	\N	380	1
430	25	MADRID	1	170	\N	512	1
436	25	MANTA	1	170	\N	513	1
438	25	MEDINA	1	170	\N	514	1
483	25	NARINO	1	170	\N	\N	1
488	25	NILO	1	170	\N	518	1
814	15	TOCA	1	170	\N	309	1
816	15	TOGUI	1	170	\N	310	1
832	15	TUNUNGUA	1	170	\N	313	1
835	15	TURMEQUE	1	170	\N	314	1
837	15	TUTA	1	170	\N	315	1
861	15	VENTAQUEMADA	1	170	\N	318	1
897	15	ZETAQUIRA	1	170	\N	320	1
1	17	MANIZALES	1	170	\N	321	1
42	17	ANSERMA	1	170	\N	323	1
690	15	SANTA MARIA	1	170	\N	286	1
693	15	SANTA ROSA DE VITERBO	1	170	\N	287	1
723	15	SATIVASUR	1	170	\N	290	1
740	15	SIACHOQUE	1	170	\N	291	1
753	15	SOATA	1	170	\N	292	1
755	15	SOCOTA	1	170	\N	293	1
762	15	SORA	1	170	\N	297	1
774	15	SUSACON	1	170	\N	300	1
776	15	SUTAMARCHAN	1	170	\N	301	1
790	15	TASCO	1	170	\N	303	1
808	15	TINJACA	1	170	\N	307	1
810	15	TIPACOQUE	1	170	\N	308	1
522	15	PANQUEBA	1	170	\N	265	1
599	15	RAMIRIQUI	1	170	\N	273	1
632	15	SABOYA	1	170	\N	276	1
638	15	SACHICA	1	170	\N	277	1
664	15	SAN JOSE DE PARE	1	170	\N	280	1
676	15	SAN MIGUEL DE SEMA	1	170	\N	283	1
681	15	SAN PABLO DE BORBUR	1	170	\N	284	1
403	15	LA UVITA	1	170	\N	247	1
407	15	VILLA DE LEYVA	1	170	\N	248	1
442	15	MARIPI	1	170	\N	250	1
466	15	MONGUI	1	170	\N	253	1
476	15	MOTAVITA	1	170	\N	255	1
135	27	CANTON DEL SAN PABLO	1	170	\N	582	1
398	25	LA PENA	1	170	\N	508	1
550	15	PISVA	1	170	\N	270	1
507	15	OTANCHE	1	170	\N	260	1
514	15	PAEZ	1	170	\N	262	1
516	15	PAIPA	1	170	\N	263	1
244	15	EL COCUY	1	170	\N	230	1
272	15	FIRAVITOBA	1	170	\N	232	1
299	15	GARAGOA	1	170	\N	236	1
325	15	GUAYATA	1	170	\N	239	1
368	15	JERICO	1	170	\N	243	1
380	15	LA CAPILLA	1	170	\N	245	1
183	15	CHITA	1	170	\N	216	1
187	15	CHIVATA	1	170	\N	218	1
204	15	COMBITA	1	170	\N	220	1
218	15	COVARACHIA	1	170	\N	223	1
894	13	ZAMBRANO	1	170	\N	197	1
92	15	BETEITIVA	1	170	\N	204	1
131	15	CALDAS	1	170	\N	210	1
670	13	SAN PABLO	1	170	\N	186	1
600	13	RIO VIEJO	1	170	\N	178	1
647	13	SAN ESTANISLAO	1	170	\N	180	1
654	13	SAN JACINTO	1	170	\N	182	1
88	5	BELLO	1	170	\N	20	1
113	5	BURITICA	1	170	\N	25	1
125	5	CAICEDO	1	170	\N	27	1
321	5	GUATAPE	1	170	\N	57	1
368	5	JERICO	1	170	\N	243	1
380	5	LA ESTRELLA	1	170	\N	65	1
264	5	ENTRERRIOS	1	170	\N	47	1
306	5	GIRALDO	1	170	\N	51	1
315	5	GUADALUPE	1	170	\N	55	1
209	5	CONCORDIA	1	170	\N	41	1
234	5	DABEIBA	1	170	\N	43	1
240	5	EBEJICO	1	170	\N	45	1
145	5	CARAMANTA	1	170	\N	32	1
150	5	CAROLINA	1	170	\N	35	1
705	68	SANTA BARBARA	1	170	\N	103	1
673	68	SAN BENITO	1	170	\N	913	1
524	99	LA PRIMAVERA	1	170	\N	1102	1
573	68	PUERTO PARRA	1	170	\N	908	1
464	68	MOGOTES	1	170	\N	897	1
502	68	ONZAGA	1	170	\N	901	1
533	68	PARAMO	1	170	\N	904	1
385	68	LANDAZURI	1	170	\N	890	1
406	68	LEBRIJA	1	170	\N	892	1
425	68	MACARAVITA	1	170	\N	894	1
320	68	GUADALUPE	1	170	\N	55	1
324	68	GUAVATA	1	170	\N	884	1
344	68	HATO	1	170	\N	886	1
255	68	EL PLAYON	1	170	\N	873	1
266	68	ENCISO	1	170	\N	875	1
276	68	FLORIDABLANCA	1	170	\N	877	1
207	68	CONCEPCION	1	170	\N	40	1
211	68	CONTRATACION	1	170	\N	867	1
229	68	CURITI	1	170	\N	869	1
101	68	BOLIVAR	1	170	\N	368	1
121	68	CABRERA	1	170	\N	466	1
687	66	SANTUARIO	1	170	\N	106	1
20	68	ALBANIA	1	170	\N	349	1
456	66	MISTRATO	1	170	\N	840	1
45	66	APIA	1	170	\N	832	1
318	66	GUATICA	1	170	\N	836	1
401	63	LA TEBAIDA	1	170	\N	826	1
594	63	QUIMBAYA	1	170	\N	829	1
111	63	BUENAVISTA	1	170	\N	208	1
293	25	GACHALA	1	170	\N	489	1
299	25	GAMA	1	170	\N	492	1
320	25	GUADUAS	1	170	\N	496	1
168	25	CHAGUANI	1	170	\N	472	1
181	25	CHOACHI	1	170	\N	475	1
214	25	COTA	1	170	\N	478	1
269	25	FACATATIVA	1	170	\N	483	1
281	25	FOSCA	1	170	\N	485	1
288	25	FUQUENE	1	170	\N	487	1
53	25	ARBELAEZ	1	170	\N	462	1
95	25	BITUIMA	1	170	\N	464	1
126	25	CAJICA	1	170	\N	468	1
807	23	TIERRALTA	1	170	\N	456	1
686	23	SAN PELAYO	1	170	\N	455	1
174	17	CHINCHINA	1	170	\N	326	1
433	17	MANZANARES	1	170	\N	330	1
1	95	SAN JOSE DEL GUAVIARE	1	170	\N	1094	1
15	95	CALAMAR	1	170	\N	160	1
140	13	CALAMAR	1	170	\N	160	1
212	13	CORDOBA	1	170	\N	163	1
638	8	SABANALARGA	1	170	\N	144	1
675	8	SANTA LUCIA	1	170	\N	145	1
685	8	SANTO TOMAS	1	170	\N	146	1
849	8	USIACURI	1	170	\N	150	1
1	13	CARTAGENA	1	170	\N	153	1
6	13	ACHI	1	170	\N	154	1
580	23	PUERTO LIBERTADOR	1	170	\N	448	1
660	23	SAHAGUN	1	170	\N	450	1
555	23	PLANETA RICA	1	170	\N	445	1
570	23	PUEBLO NUEVO	1	170	\N	446	1
466	23	MONTELIBANO	1	170	\N	443	1
168	23	CHIMA	1	170	\N	435	1
189	23	CIENAGA DE ORO	1	170	\N	437	1
417	23	LORICA	1	170	\N	440	1
750	20	SAN DIEGO	1	170	\N	427	1
770	20	SAN MARTIN	1	170	\N	428	1
1	23	MONTERIA	1	170	\N	430	1
79	23	BUENAVISTA	1	170	\N	208	1
310	20	GONZALEZ	1	170	\N	417	1
550	20	PELAYA	1	170	\N	422	1
621	20	LA PAZ	1	170	\N	891	1
710	20	SAN ALBERTO	1	170	\N	426	1
175	20	CHIMICHAGUA	1	170	\N	411	1
178	20	CHIRIGUANA	1	170	\N	412	1
228	20	CURUMANI	1	170	\N	413	1
1	20	VALLEDUPAR	1	170	\N	405	1
13	20	AGUSTIN CODAZZI	1	170	\N	407	1
1	94	INIRIDA	1	170	\N	1093	1
500	23	MONITOS	1	170	\N	444	1
443	20	MANAURE BALCON DL CESAR	1	170	\N	420	1
807	19	TIMBIO	1	170	\N	400	1
824	19	TOTORO	1	170	\N	403	1
743	19	SILVIA	1	170	\N	396	1
215	52	CORDOBA	1	170	\N	163	1
250	52	EL CHARCO	1	170	\N	731	1
51	52	ARBOLEDA	1	170	\N	719	1
203	52	COLON	1	170	\N	1076	1
400	50	LEJANIAS	1	170	\N	703	1
590	50	PUERTO RICO	1	170	\N	358	1
686	50	SAN JUANITO	1	170	\N	712	1
150	50	CASTILLA LA NUEVA	1	170	\N	690	1
226	50	CUMARAL	1	170	\N	692	1
251	50	EL CASTILLO	1	170	\N	694	1
707	47	SANTA ANA	1	170	\N	680	1
288	47	FUNDACION	1	170	\N	667	1
555	47	PLATO	1	170	\N	673	1
855	44	URUMITA	1	170	\N	654	1
134	27	BELEN DE BAJIRA	1	170	\N	\N	1
573	19	PUERTO TEJADA	1	170	\N	390	1
473	19	MORALES	1	170	\N	175	1
517	19	PAEZ	1	170	\N	262	1
290	19	FLORENCIA	1	170	\N	348	1
130	19	CAJIBIO	1	170	\N	370	1
142	19	CALOTO	1	170	\N	372	1
100	19	BOLIVAR	1	170	\N	368	1
860	18	VALPARAISO	1	170	\N	119	1
877	17	VITERBO	1	170	\N	347	1
247	18	EL DONCELLO	1	170	\N	353	1
616	17	RISARALDA	1	170	\N	340	1
662	17	SAMANA	1	170	\N	342	1
777	17	SUPIA	1	170	\N	344	1
513	17	PACORA	1	170	\N	336	1
614	17	RIOSUCIO	1	170	\N	339	1
141	8	CANDELARIA	1	170	\N	131	1
436	8	MANATI	1	170	\N	136	1
549	8	PIOJO	1	170	\N	138	1
433	13	MAHATES	1	170	\N	170	1
473	13	MORALES	1	170	\N	175	1
430	13	MAGANGUE	1	170	\N	169	1
100	76	BOLIVAR	1	170	\N	368	1
20	76	ALCALA	1	170	\N	1008	1
21	5	ALEJANDRIA	1	170	\N	5	1
34	5	ANDES	1	170	\N	8	1
40	5	ANORI	1	170	\N	11	1
55	5	ARGELIA	1	170	\N	16	1
306	76	GINEBRA	1	170	\N	1026	1
248	76	EL CERRITO	1	170	\N	1023	1
113	76	BUGALAGRANDE	1	170	\N	1015	1
560	44	MANAURE	1	170	\N	420	1
801	41	TERUEL	1	170	\N	637	1
668	41	SAN AGUSTIN	1	170	\N	631	1
396	41	LA PLATA	1	170	\N	621	1
250	54	EL TARRA	1	170	\N	792	1
405	54	LOS PATIOS	1	170	\N	800	1
786	52	TAMINANGO	1	170	\N	774	1
887	5	YARUMAL	1	170	\N	124	1
819	5	TOLEDO	1	170	\N	114	1
686	5	SANTA ROSA DE OSOS	1	170	\N	104	1
875	25	VILLETA	1	170	\N	569	1
740	25	SIBATE	1	170	\N	541	1
781	25	SUTATAUSA	1	170	\N	550	1
524	25	PANDI	1	170	\N	524	1
764	15	SORACA	1	170	\N	299	1
531	15	PAUNA	1	170	\N	266	1
621	15	RONDON	1	170	\N	275	1
185	15	CHITARAQUE	1	170	\N	217	1
212	15	COPER	1	170	\N	221	1
47	15	AQUITANIA	1	170	\N	200	1
744	13	SIMITI	1	170	\N	190	1
549	13	PINILLOS	1	170	\N	176	1
684	68	SAN JOSE DE MIRANDA	1	170	\N	916	1
615	68	RIONEGRO	1	170	\N	86	1
522	68	PALMAR	1	170	\N	902	1
594	66	QUINCHIA	1	170	\N	842	1
302	63	GENOVA	1	170	\N	825	1
548	63	PIJAO	1	170	\N	828	1
88	17	BELALCAZAR	1	170	\N	325	1
758	8	SOLEDAD	1	170	\N	147	1
586	23	PURISIMA	1	170	\N	449	1
210	52	CONTADERO	1	170	\N	725	1
110	52	BUESACO	1	170	\N	722	1
568	50	PUERTO GAITAN	1	170	\N	705	1
680	50	SAN CARLOS DE GUAROA	1	170	\N	710	1
355	19	INZA	1	170	\N	377	1
256	19	EL TAMBO	1	170	\N	374	1
137	19	CALDONO	1	170	\N	371	1
75	19	BALBOA	1	170	\N	367	1
29	18	ALBANIA	1	170	\N	349	1
205	18	CURILLO	1	170	\N	352	1
2	5	ABEJORRAL	1	170	\N	2	1
30	5	AMAGA	1	170	\N	6	1
42	5	SANTAFE DE ANTIOQUIA	1	170	\N	12	1
79	5	BARBOSA	1	170	\N	18	1
889	97	YAVARATE	1	170	\N	\N	1
572	99	SANTA RITA	1	170	\N	\N	1
263	91	EL ENCANTO	1	170	\N	\N	1
405	91	LA CHORRERA	1	170	\N	\N	1
407	91	LA PEDRERA	1	170	\N	\N	1
798	91	TARAPACA	1	170	\N	\N	1
343	94	GUAVIARE	1	170	\N	\N	1
883	94	SAN FELIPE	1	170	\N	\N	1
884	94	PUERTO COLOMBIA	1	170	\N	141	1
885	94	LA GUADALUPE	1	170	\N	\N	1
161	97	CARURU	1	170	\N	1099	1
511	97	PACOA	1	170	\N	\N	1
777	97	PAPUNAUA	1	170	\N	\N	1
312	25	GRANADA	1	170	\N	54	1
30	13	ALTOS DEL ROSARIO	1	170	\N	155	1
580	13	REGIDOR	1	170	\N	177	1
222	13	CLEMENCIA	1	170	\N	164	1
258	47	EL PINON	1	170	\N	665	1
1	47	SANTAMARTA	1	170	\N	656	1
540	91	PUERTO NARINO	1	170	\N	1092	1
410	18	LA MONTANITA	1	170	\N	355	1
810	13	IQUISIO	1	170	\N	193	1
620	13	SAN CRISTOBAL	1	170	\N	179	1
42	13	ARENAL	1	170	\N	156	1
188	13	CICUCO	1	170	\N	162	1
62	13	ARROYOHONDO	1	170	\N	158	1
50	27	ATRATO	1	170	\N	577	1
260	25	EL ROSAL	1	170	\N	482	1
90	44	DIBULLA	1	170	\N	644	1
98	44	DISTRACCION	1	170	\N	645	1
420	44	LA JAGUA DEL PILAR	1	170	\N	649	1
757	86	SAN MIGUEL	1	170	\N	917	1
533	19	PIAMONTE	1	170	\N	388	1
845	19	VILLA RICA	1	170	\N	404	1
785	18	SOLITA	1	170	\N	362	1
300	23	COTORRA	1	170	\N	438	1
430	91	LA VICTORIA	1	170	\N	246	1
530	91	PUERTO ALEGRIA	1	170	\N	\N	1
570	20	PUEBLO BELLO	1	170	\N	423	1
90	5	LA PINTADA	1	170	\N	66	1
390	5	LA PINTADA	1	170	\N	66	1
756	18	SOLANO	1	170	\N	361	1
890	97	VILLA FATIMA	1	170	\N	\N	1
891	97	ACARICUARA	1	170	\N	\N	1
35	44	ALBANIA	1	170	\N	349	1
785	19	SUCRE	1	170	\N	399	1
999	1	TODOS	1	170	\N	\N	1
160	27	CERTEGUI	1	170	\N	584	1
720	47	SANTA BARBARA DE PINTO	1	170	\N	681	1
30	47	ALGARROBO	1	170	\N	657	1
585	73	PURIFICACION	1	170	\N	993	1
443	73	MARIQUITA	1	170	\N	984	1
483	73	NATAGAIMA	1	170	\N	987	1
352	73	ICONONZO	1	170	\N	981	1
200	73	COELLO	1	170	\N	970	1
268	73	ESPINAL	1	170	\N	974	1
26	73	ALVARADO	1	170	\N	961	1
124	73	CAJAMARCA	1	170	\N	966	1
110	44	EL MOLINO	1	170	\N	646	1
615	41	RIVERA	1	170	\N	629	1
660	41	SALADOBLANCO	1	170	\N	630	1
791	41	TARQUI	1	170	\N	634	1
378	41	LA ARGENTINA	1	170	\N	620	1
518	41	PAICOL	1	170	\N	624	1
1	41	NEIVA	1	170	\N	604	1
20	41	ALGECIRAS	1	170	\N	608	1
78	41	BARAYA	1	170	\N	610	1
660	27	SAN JOSE DEL PALMAR	1	170	\N	599	1
713	70	SAN ONOFRE	1	170	\N	952	1
771	70	SUCRE	1	170	\N	399	1
678	70	SAN BENITO ABAD	1	170	\N	949	1
708	70	SAN MARCOS	1	170	\N	951	1
491	27	NOVITA	1	170	\N	594	1
615	27	RIOSUCIO	1	170	\N	339	1
480	54	MUTISCUA	1	170	\N	802	1
520	54	PAMPLONITA	1	170	\N	805	1
673	54	SAN CAYETANO	1	170	\N	536	1
398	54	LA PLAYA	1	170	\N	799	1
125	54	CACOTA	1	170	\N	784	1
174	54	CHITAGA	1	170	\N	787	1
3	54	ABREGO	1	170	\N	780	1
885	52	YACUANQUER	1	170	\N	778	1
683	52	SANDONA	1	170	\N	766	1
685	52	SAN BERNARDO	1	170	\N	535	1
621	52	ROBERTO PAYAN	1	170	\N	764	1
565	52	PROVIDENCIA	1	170	\N	760	1
411	52	LINARES	1	170	\N	749	1
418	52	LOS ANDES	1	170	\N	750	1
356	52	IPIALES	1	170	\N	742	1
287	52	FUNES	1	170	\N	736	1
317	52	GUACHUCAL	1	170	\N	737	1
137	8	CAMPO DE LA CRUZ	1	170	\N	130	1
858	5	VEGACHI	1	170	\N	120	1
674	5	SAN VICENTE	1	170	\N	102	1
690	5	SANTO DOMINGO	1	170	\N	105	1
736	5	SEGOVIA	1	170	\N	107	1
659	5	SAN JUAN DE URABA	1	170	\N	96	1
615	5	RIONEGRO	1	170	\N	86	1
628	5	SABANALARGA	1	170	\N	144	1
495	5	NECHI	1	170	\N	76	1
245	27	EL CARMEN	1	170	\N	586	1
205	27	CONDOTO	1	170	\N	585	1
899	25	ZIPAQUIRA	1	170	\N	573	1
807	25	TIBIRITA	1	170	\N	556	1
839	25	UBALA	1	170	\N	560	1
843	25	UBATE	1	170	\N	562	1
743	25	SILVANIA	1	170	\N	542	1
772	25	SUESCA	1	170	\N	547	1
779	25	SUSA	1	170	\N	549	1
480	15	MUZO	1	170	\N	256	1
494	15	NUEVO COLON	1	170	\N	258	1
518	15	PAJARITO	1	170	\N	264	1
232	15	CHIQUIZA	1	170	\N	227	1
296	15	GAMEZA	1	170	\N	235	1
317	15	GUACAMAYAS	1	170	\N	237	1
377	15	LABRANZAGRANDE	1	170	\N	244	1
162	15	CERINZA	1	170	\N	212	1
215	15	CORRALES	1	170	\N	222	1
224	15	CUCAITA	1	170	\N	225	1
873	13	VILLANUEVA	1	170	\N	196	1
22	15	ALMEIDA	1	170	\N	199	1
87	15	BELEN	1	170	\N	202	1
97	15	BOAVITA	1	170	\N	205	1
109	15	BUENAVISTA	1	170	\N	208	1
657	13	SAN JUAN NEPOMUCENO	1	170	\N	184	1
760	13	SOPLAVIENTO	1	170	\N	191	1
780	13	TALAIGUA NUEVO	1	170	\N	192	1
650	13	SAN FERNANDO	1	170	\N	181	1
86	5	BELMIRA	1	170	\N	19	1
93	5	BETULIA	1	170	\N	22	1
854	73	VALLE DE SAN JUAN	1	170	\N	1002	1
520	52	FRANCIS PIZARRO	1	170	\N	757	1
585	5	PTO NARE(LAMAGDALENA)	1	170	\N	82	1
683	13	SANTA ROSA NORTE	1	170	\N	188	1
107	5	BRICENO	1	170	\N	24	1
120	5	CACERES	1	170	\N	26	1
129	5	CALDAS	1	170	\N	210	1
347	5	HELICONIA	1	170	\N	58	1
360	5	ITAGUI	1	170	\N	60	1
364	5	JARDIN	1	170	\N	62	1
376	5	LA CEJA	1	170	\N	64	1
400	5	LA UNION	1	170	\N	67	1
266	5	ENVIGADO	1	170	\N	48	1
284	5	FRONTINO	1	170	\N	50	1
308	5	GIRARDOTA	1	170	\N	52	1
313	5	GRANADA	1	170	\N	54	1
318	5	GUARNE	1	170	\N	56	1
206	5	CONCEPCION	1	170	\N	40	1
212	5	COPACABANA	1	170	\N	42	1
237	5	DON MATIAS	1	170	\N	44	1
134	5	CAMPAMENTO	1	170	\N	29	1
142	5	CARACOLI	1	170	\N	31	1
148	5	CARMEN DE VIBORAL	1	170	\N	34	1
190	5	CISNEROS	1	170	\N	38	1
689	68	SAN VICENTE DE CHUCURI	1	170	\N	918	1
755	68	SOCORRO	1	170	\N	922	1
669	68	SAN ANDRES	1	170	\N	91	1
679	68	SAN GIL	1	170	\N	914	1
572	68	PUENTE NACIONAL	1	170	\N	907	1
575	68	PUERTO WILCHES	1	170	\N	909	1
498	68	OCAMONTE	1	170	\N	899	1
549	68	PINCHOTE	1	170	\N	906	1
377	68	LA BELLEZA	1	170	\N	889	1
397	68	LA PAZ	1	170	\N	891	1
418	68	LOS SANTOS	1	170	\N	893	1
296	68	GALAN	1	170	\N	878	1
298	68	GAMBITA	1	170	\N	879	1
368	68	JESUS MARIA	1	170	\N	887	1
245	68	EL GUACAMAYO	1	170	\N	871	1
264	68	ENCINO	1	170	\N	874	1
167	68	CHARALA	1	170	\N	860	1
176	68	CHIMA	1	170	\N	435	1
190	68	CIMITARRA	1	170	\N	864	1
217	68	COROMORO	1	170	\N	868	1
160	68	CEPITA	1	170	\N	858	1
79	68	BARICHARA	1	170	\N	850	1
132	68	CALIFORNIA	1	170	\N	855	1
682	66	SANTA ROSA DE CABAL	1	170	\N	843	1
51	68	ARATOCA	1	170	\N	848	1
400	66	LA VIRGINIA	1	170	\N	838	1
572	66	PUEBLO RICO	1	170	\N	80	1
272	63	FILANDIA	1	170	\N	824	1
470	63	MONTENEGRO	1	170	\N	827	1
1	66	PEREIRA	1	170	\N	831	1
874	54	VILLA DEL ROSARIO	1	170	\N	818	1
295	25	GACHANCIPA	1	170	\N	490	1
307	25	GIRARDOT	1	170	\N	493	1
322	25	GUASCA	1	170	\N	497	1
326	25	GUATAVITA	1	170	\N	499	1
178	25	CHIPAQUE	1	170	\N	474	1
200	25	COGUA	1	170	\N	477	1
279	25	FOMEQUE	1	170	\N	484	1
286	25	FUNZA	1	170	\N	486	1
1	25	AGUA DE DIOS	1	170	\N	458	1
86	25	BELTRAN	1	170	\N	463	1
99	25	BOJACA	1	170	\N	465	1
120	25	CABRERA	1	170	\N	466	1
154	25	CARMEN DE CARUPA	1	170	\N	471	1
678	23	SAN CARLOS	1	170	\N	92	1
50	17	ARANZAZU	1	170	\N	324	1
207	52	CONSACA	1	170	\N	724	1
36	52	ANCUYA	1	170	\N	718	1
325	50	MAPIRIPAN	1	170	\N	699	1
450	50	PUERTO CONCORDIA	1	170	\N	704	1
577	50	PUERTO LLERAS	1	170	\N	707	1
683	50	SAN JUAN DE ARAMA	1	170	\N	711	1
798	47	TENERIFE	1	170	\N	683	1
6	50	ACACIAS	1	170	\N	687	1
110	50	BARRANCA DE UPIA	1	170	\N	688	1
223	50	CUBARRAL	1	170	\N	691	1
425	27	MEDIO ATRATO	1	170	\N	591	1
1711	3	LIMA	1	171	\N	\N	1
570	86	LA HORMIGA	1	170	\N	\N	1
1	4	LEXINGTON	1	200	\N	\N	1
1	9	STANFORD	1	200	\N	\N	1
1722	2	SAO PAULO	1	172	\N	\N	1
810	27	UNION PANAMERICANA	1	170	\N	603	1
605	47	REMOLINO	1	170	\N	675	1
245	47	EL BANCO	1	170	\N	664	1
161	47	CERRO SAN ANTONIO	1	170	\N	660	1
548	19	PIENDAMO	1	170	\N	389	1
450	19	MERCADERES	1	170	\N	382	1
397	19	LA VEGA	1	170	\N	380	1
610	18	SAN JOSE DE FRAGUA	1	170	\N	359	1
867	17	VICTORIA	1	170	\N	345	1
592	18	PUERTO RICO	1	170	\N	358	1
653	17	SALAMINA	1	170	\N	341	1
541	17	PENSILVANIA	1	170	\N	338	1
296	8	GALAPA	1	170	\N	132	1
440	13	MARGARITA	1	170	\N	171	1
468	13	MOMPOS	1	170	\N	174	1
36	76	ANDALUCIA	1	170	\N	1009	1
4	5	ABRIAQUI	1	170	\N	3	1
45	5	APARTADO	1	170	\N	14	1
828	76	TRUJILLO	1	170	\N	1041	1
377	76	LA CUMBRE	1	170	\N	1029	1
30	73	AMBALEMA	1	170	\N	962	1
148	73	CARMEN DE APICALA	1	170	\N	967	1
357	41	IQUIRA	1	170	\N	618	1
128	54	CACHIRA	1	170	\N	785	1
1	54	CUCUTA	1	170	\N	779	1
790	5	TARAZA	1	170	\N	111	1
642	5	SALGAR	1	170	\N	90	1
658	25	SAN FRANCISCO	1	170	\N	93	1
572	25	PUERTO SALGAR	1	170	\N	527	1
524	68	PALMAS SOCORRO	1	170	\N	903	1
258	25	EL PENON	1	170	\N	481	1
150	27	carmen del darien	1	170	0	583	1
806	15	TIBASOSA	1	170	\N	306	1
838	13	TURBANA	1	170	\N	195	1
90	15	BERBEO	1	170	\N	203	1
154	5	CAUCASIA	1	170	\N	36	1
655	68	SABANA DE TORRES	1	170	\N	911	1
440	66	MARSELLA	1	170	\N	839	1
380	17	LA DORADA	1	170	\N	328	1
25	95	EL RETORNO	1	170	\N	1096	1
701	19	SANTA ROSA	1	170	\N	188	1
1	52	PASTO	1	170	\N	715	1
205	47	CONCORDIA	1	170	\N	41	1
960	47	ZAPAYAN	1	170	\N	684	1
600	27	RIO QUITO	1	170	\N	597	1
320	86	ORITO	1	170	\N	1077	1
573	86	PUERTO LEGUIZAMO	1	170	\N	1082	1
760	86	SANTIAGO	1	170	\N	811	1
564	88	PROVIDENCIA	1	170	\N	760	1
1	91	LETICIA	1	170	\N	1091	1
315	85	SACAMA	1	170	\N	1069	1
325	85	SAN LUIS DE PALENQUE	1	170	\N	1070	1
430	85	TRINIDAD	1	170	\N	1073	1
230	85	OROCUE	1	170	\N	1064	1
10	85	AGUAZUL	1	170	\N	1057	1
125	85	HATO COROZAL	1	170	\N	1059	1
162	85	MONTERREY	1	170	\N	1062	1
300	81	FORTUL	1	170	\N	1052	1
794	81	TAME	1	170	\N	1055	1
1	85	YOPAL	1	170	\N	1056	1
892	76	YUMBO	1	170	\N	1047	1
1	81	ARAUCA	1	170	\N	1049	1
65	81	ARAUQUITA	1	170	\N	1050	1
736	76	SEVILLA	1	170	\N	1039	1
823	76	TORO	1	170	\N	1040	1
622	76	ROLDANILLO	1	170	\N	1037	1
403	76	LA VICTORIA	1	170	\N	246	1
400	76	LA UNION	1	170	\N	67	1
250	76	EL DOVIO	1	170	\N	1024	1
130	76	CANDELARIA	1	170	\N	131	1
122	76	CAICEDONIA	1	170	\N	1016	1
265	70	GUARANDA	1	170	\N	941	1
773	68	SUCRE	1	170	\N	399	1
867	68	VETAS	1	170	\N	929	1
622	73	RONCESVALLES	1	170	\N	995	1
624	73	ROVIRA	1	170	\N	996	1
686	73	SANTA ISABEL	1	170	\N	1000	1
861	73	VENADILLO	1	170	\N	1003	1
555	73	PLANADAS	1	170	\N	991	1
233	70	EL ROBLE	1	170	\N	939	1
449	73	MELGAR	1	170	\N	985	1
347	73	HERVEO	1	170	\N	979	1
408	73	LERIDA	1	170	\N	982	1
236	73	DOLORES	1	170	\N	973	1
24	73	ALPUJARRA	1	170	\N	960	1
152	73	CASABIANCA	1	170	\N	968	1
847	44	URIBIA	1	170	\N	653	1
807	41	TIMANA	1	170	\N	638	1
770	41	SUAZA	1	170	\N	633	1
799	41	TELLO	1	170	\N	636	1
359	41	ISNOS	1	170	\N	619	1
503	41	OPORAPA	1	170	\N	623	1
524	41	PALERMO	1	170	\N	625	1
26	41	ALTAMIRA	1	170	\N	609	1
132	41	CAMPOALEGRE	1	170	\N	611	1
787	27	TADO	1	170	\N	601	1
1	73	IBAGUE	1	170	\N	958	1
717	70	SAN PEDRO	1	170	\N	98	1
702	70	SAN JUAN DE BETULIA	1	170	\N	950	1
473	70	MORROA	1	170	\N	945	1
680	54	SANTIAGO	1	170	\N	811	1
743	54	SILOS	1	170	\N	813	1
670	54	SAN CALIXTO	1	170	\N	809	1
313	54	GRAMALOTE	1	170	\N	794	1
223	54	CUCUTILLA	1	170	\N	789	1
245	54	EL CARMEN	1	170	\N	586	1
699	52	SANTACRUZ	1	170	\N	772	1
720	52	SAPUYES	1	170	\N	773	1
585	52	PUPIALES	1	170	\N	762	1
678	52	SAMANIEGO	1	170	\N	765	1
506	52	OSPINA	1	170	\N	756	1
540	52	POLICARPA	1	170	\N	758	1
573	52	PUERRES	1	170	\N	761	1
435	52	MALLAMA	1	170	\N	752	1
352	52	ILES	1	170	\N	740	1
385	52	LA LLANADA	1	170	\N	745	1
390	52	LA TOLA	1	170	\N	746	1
260	52	EL TAMBO	1	170	\N	374	1
895	5	ZARAGOZA	1	170	\N	127	1
78	8	BARANOA	1	170	\N	129	1
885	5	YALI	1	170	\N	123	1
761	5	SOPETRAN	1	170	\N	109	1
789	5	TAMESIS	1	170	\N	110	1
792	5	TARSO	1	170	\N	112	1
670	5	SAN ROQUE	1	170	\N	101	1
697	5	SANTUARIO	1	170	\N	106	1
756	5	SONSON	1	170	\N	108	1
579	5	PUERTO BERRIO	1	170	\N	81	1
604	5	REMEDIOS	1	170	\N	84	1
425	5	MACEO	1	170	\N	69	1
467	5	MONTEBELLO	1	170	\N	71	1
490	5	NECOCLI	1	170	\N	75	1
501	5	OLAYA	1	170	\N	77	1
361	27	ISTMINA	1	170	\N	588	1
6	27	ACANDI	1	170	\N	575	1
73	27	BAGADO	1	170	\N	578	1
1	27	QUIBDO	1	170	\N	574	1
805	25	TIBACUY	1	170	\N	555	1
841	25	UBAQUE	1	170	\N	561	1
845	25	UNE	1	170	\N	563	1
851	25	UTICA	1	170	\N	564	1
871	25	VILLAGOMEZ	1	170	\N	567	1
126	76	CALIMA (DARIEN)	1	170	\N	1017	1
855	68	VALLE DE SAN JOSE	1	170	\N	927	1
498	54	OCANA	1	170	\N	803	1
658	5	SAN JOSE DE LA MONTANA	1	170	\N	95	1
77	27	BAJO BAUDO	1	170	\N	580	1
736	25	SESQUILE	1	170	\N	540	1
745	25	SIMIJACA	1	170	\N	543	1
758	25	SOPO	1	170	\N	545	1
793	25	TAUSA	1	170	\N	552	1
797	25	TENA	1	170	\N	553	1
518	25	PAIME	1	170	\N	523	1
535	25	PASCA	1	170	\N	526	1
580	25	PULI	1	170	\N	528	1
612	25	RICAURTE	1	170	\N	533	1
328	25	GUAYABAL DE SIQUIMA	1	170	\N	500	1
377	25	LA CALERA	1	170	\N	505	1
394	25	LA PALMA	1	170	\N	507	1
407	25	LENGUAZAQUE	1	170	\N	510	1
426	25	MACHETA	1	170	\N	511	1
473	25	MOSQUERA	1	170	\N	515	1
486	25	NEMOCON	1	170	\N	517	1
489	25	NIMAIMA	1	170	\N	519	1
820	15	TOPAGA	1	170	\N	311	1
822	15	TOTA	1	170	\N	312	1
839	15	TUTASA	1	170	\N	316	1
842	15	UMBITA	1	170	\N	317	1
879	15	VIRACACHA	1	170	\N	319	1
13	17	AGUADAS	1	170	\N	322	1
686	15	SANTANA	1	170	\N	285	1
696	15	SANTA SOFIA	1	170	\N	288	1
720	15	SATIVANORTE	1	170	\N	289	1
757	15	SOCHA	1	170	\N	294	1
759	15	SOGAMOSO	1	170	\N	295	1
763	15	SOTAQUIRA	1	170	\N	298	1
798	15	TENZA	1	170	\N	304	1
804	15	TIBANA	1	170	\N	305	1
533	15	PAYA	1	170	\N	267	1
542	15	PESCA	1	170	\N	269	1
572	15	PUERTO BOYACA	1	170	\N	271	1
600	15	RAQUIRA	1	170	\N	274	1
660	15	SAN EDUARDO	1	170	\N	279	1
673	15	SAN MATEO	1	170	\N	282	1
401	15	LA VICTORIA	1	170	\N	246	1
425	15	MACANAL	1	170	\N	249	1
464	15	MONGUA	1	170	\N	252	1
491	15	NOBSA	1	170	\N	257	1
500	15	OICATA	1	170	\N	259	1
226	15	CUITIVA	1	170	\N	226	1
236	15	CHIVOR	1	170	\N	228	1
293	15	GACHANTIVA	1	170	\N	234	1
322	15	GUATEQUE	1	170	\N	238	1
362	15	IZA	1	170	\N	241	1
135	15	CAMPOHERMOSO	1	170	\N	211	1
176	15	CHIQUINQUIRA	1	170	\N	214	1
836	13	TURBACO	1	170	\N	194	1
51	15	ARCABUCO	1	170	\N	201	1
673	13	SANTA CATALINA	1	170	\N	187	1
688	13	SANTA ROSA DEL SUR	1	170	\N	189	1
91	5	BETANIA	1	170	\N	21	1
101	5	BOLIVAR	1	170	\N	368	1
353	5	HISPANIA	1	170	\N	59	1
361	5	ITUANGO	1	170	\N	61	1
282	5	FREDONIA	1	170	\N	49	1
310	5	GOMEZ PLATA	1	170	\N	53	1
197	5	COCORNA	1	170	\N	39	1
250	5	EL BAGRE	1	170	\N	46	1
172	5	CHIGORODO	1	170	\N	37	1
770	68	SUAITA	1	170	\N	923	1
682	68	SAN JOAQUIN	1	170	\N	915	1
444	68	MATANZA	1	170	\N	896	1
500	68	OIBA	1	170	\N	900	1
547	68	PIEDECUESTA	1	170	\N	905	1
720	54	SARDINATA	1	170	\N	812	1
553	54	PUERTO SANTANDER	1	170	\N	806	1
344	54	HACARI	1	170	\N	795	1
239	54	DURANIA	1	170	\N	790	1
51	54	ARBOLEDAS	1	170	\N	781	1
694	52	SAN PEDRO DE CARTAGO	1	170	\N	770	1
490	52	OLAYA HERRERA	1	170	\N	755	1
323	52	GUALMATAN	1	170	\N	739	1
1	6	AUSTIN	1	200	\N	\N	1
1	7	SAN MIGUEL	1	300	\N	917	1
370	68	JORDAN	1	170	\N	888	1
432	68	MALAGA	1	170	\N	895	1
318	68	GUACA	1	170	\N	881	1
322	68	GUAPOTA	1	170	\N	883	1
235	68	EL CARMEN	1	170	\N	586	1
169	68	CHARTA	1	170	\N	861	1
179	68	CHIPATA	1	170	\N	863	1
162	68	CERRITO	1	170	\N	859	1
92	68	BETULIA	1	170	\N	22	1
147	68	CAPITANEJO	1	170	\N	856	1
13	68	AGUADA	1	170	\N	846	1
383	66	LA CELIA	1	170	\N	837	1
75	66	BALBOA	1	170	\N	367	1
212	63	CORDOBA	1	170	\N	163	1
820	54	TOLEDO	1	170	\N	114	1
1	63	ARMENIA	1	170	\N	17	1
297	25	GACHETA	1	170	\N	491	1
317	25	GUACHETA	1	170	\N	495	1
324	25	GUATAQUI	1	170	\N	498	1
183	25	CHOCONTA	1	170	\N	476	1
245	25	EL COLEGIO	1	170	\N	480	1
19	25	ALBAN	1	170	\N	459	1
35	25	ANAPOIMA	1	170	\N	460	1
123	25	CACHIPAY	1	170	\N	467	1
151	25	CAQUEZA	1	170	\N	470	1
855	23	VALENCIA	1	170	\N	457	1
272	17	FILADELFIA	1	170	\N	327	1
388	17	LA MERCED	1	170	\N	329	1
200	95	MIRAFLORES	1	170	\N	251	1
1	97	MITU	1	170	\N	1098	1
573	8	PUERTO COLOMBIA	1	170	\N	141	1
606	8	REPELON	1	170	\N	142	1
770	8	SUAN	1	170	\N	148	1
106	15	BRICENO	1	170	\N	207	1
696	52	SANTABARBARA	1	170	\N	771	1
254	52	EL PENOL	1	170	\N	732	1
480	52	NARINO	1	170	\N	754	1
250	68	EL PENON	1	170	\N	872	1
832	8	TUBARA	1	170	\N	149	1
52	13	ARJONA	1	170	\N	157	1
670	23	SAN ANDRES SOTAVENTO	1	170	\N	451	1
574	23	PUERTO ESCONDIDO	1	170	\N	447	1
419	23	LOS CORDOBAS	1	170	\N	441	1
464	23	MOMIL	1	170	\N	442	1
182	23	CHINU	1	170	\N	436	1
90	23	CANALETE	1	170	\N	433	1
162	23	CERETE	1	170	\N	434	1
787	20	TAMALAMEQUE	1	170	\N	429	1
68	23	AYAPEL	1	170	\N	431	1
383	20	LA GLORIA	1	170	\N	418	1
400	20	LA JAGUA DE IBIRICO	1	170	\N	419	1
517	20	PAILITAS	1	170	\N	421	1
614	20	RIO DE ORO	1	170	\N	424	1
32	20	ASTREA	1	170	\N	408	1
45	20	BECERRIL	1	170	\N	409	1
60	20	BOSCONIA	1	170	\N	410	1
238	20	EL COPEY	1	170	\N	414	1
250	20	EL PASO	1	170	\N	415	1
295	20	GAMARRA	1	170	\N	416	1
11	20	AGUACHICA	1	170	\N	406	1
780	19	SUAREZ	1	170	\N	398	1
809	19	TIMBIQUI	1	170	\N	401	1
821	19	TORIBIO	1	170	\N	402	1
698	19	SANTANDER DE QUILICHAO	1	170	\N	394	1
760	19	SOTARA	1	170	\N	397	1
227	52	CUMBAL	1	170	\N	728	1
240	52	CHACHAGUI	1	170	\N	730	1
79	52	BARBACOAS	1	170	\N	720	1
19	52	ALBAN	1	170	\N	459	1
318	50	GUAMAL	1	170	\N	668	1
330	50	MESETAS	1	170	\N	700	1
573	50	PUERTO LOPEZ	1	170	\N	706	1
606	50	RESTREPO	1	170	\N	709	1
689	50	SAN MARTIN	1	170	\N	428	1
1	50	VILLAVICENCIO	1	170	\N	686	1
124	50	CABUYARO	1	170	\N	689	1
675	47	SALAMINA	1	170	\N	341	1
703	47	SAN ZENON	1	170	\N	679	1
541	47	PEDRAZA	1	170	\N	670	1
58	47	ARIGUANI	1	170	\N	659	1
170	47	CHIVOLO	1	170	\N	661	1
189	47	CIENAGA	1	170	\N	662	1
622	19	ROSAS	1	170	\N	392	1
455	19	MIRANDA	1	170	\N	383	1
418	19	LOPEZ	1	170	\N	381	1
364	19	JAMBALO	1	170	\N	378	1
212	19	CORINTO	1	170	\N	373	1
765	18	SOLANO	1	170	\N	361	1
22	19	ALMAGUER	1	170	\N	365	1
150	18	CARTAGENA DEL CHAIRA	1	170	\N	351	1
479	18	MORELIA	1	170	\N	357	1
446	17	MARULANDA	1	170	\N	333	1
486	17	NEIRA	1	170	\N	334	1
421	8	LURUACO	1	170	\N	134	1
433	8	MALAMBO	1	170	\N	135	1
558	8	POLONUEVO	1	170	\N	139	1
442	13	MARIA LA BAJA	1	170	\N	172	1
248	13	EL GUAMO	1	170	\N	166	1
41	76	ANSERMANUEVO	1	170	\N	1010	1
1	5	MEDELLIN	1	170	\N	1	1
44	5	ANZA	1	170	\N	13	1
863	76	VERSALLES	1	170	\N	1044	1
616	76	RIOFRIO	1	170	\N	1036	1
235	70	GALERAS	1	170	\N	940	1
67	73	ATACO	1	170	\N	965	1
885	41	YAGUARA	1	170	\N	640	1
306	41	GIGANTE	1	170	\N	615	1
518	54	PAMPLONA	1	170	\N	804	1
206	54	CONVENCION	1	170	\N	788	1
861	5	VENECIA	1	170	\N	121	1
660	5	SAN LUIS	1	170	\N	97	1
867	25	VIANI	1	170	\N	566	1
754	25	SOACHA	1	170	\N	544	1
799	25	TENJO	1	170	\N	554	1
596	25	QUIPILE	1	170	\N	531	1
778	15	SUTATENZA	1	170	\N	302	1
580	15	QUIPAMA	1	170	\N	272	1
223	15	CUBARA	1	170	\N	224	1
1	15	TUNJA	1	170	\N	198	1
104	15	BOYACA	1	170	\N	206	1
147	5	CAREPA	1	170	\N	33	1
686	68	SAN MIGUEL	1	170	\N	917	1
152	68	CARCASI	1	170	\N	857	1
77	68	BARBOSA	1	170	\N	18	1
690	63	SALENTO	1	170	\N	830	1
130	63	CALARCA	1	170	\N	821	1
634	8	SABANAGRANDE	1	170	\N	143	1
1	11	BOGOTA	1	170	\N	152	1
256	52	EL ROSARIO	1	170	\N	733	1
22	52	ALDANA	1	170	\N	717	1
532	19	PATIA (EL BORDO)	1	170	\N	387	1
392	19	LA SIERRA	1	170	\N	379	1
873	17	VILLAMARIA	1	170	\N	346	1
36	5	ANGELOPOLIS	1	170	\N	9	1
51	5	ARBOLETES	1	170	\N	15	1
760	99	SAN JOSE DE OCUNE	1	170	\N	\N	1
773	99	CUMARIBO	1	170	\N	1104	1
460	91	MIRITI-PARANA	1	170	\N	\N	1
669	91	PTO SANTANDER	1	170	\N	\N	1
886	94	CACAHUAL	1	170	\N	\N	1
887	94	PANA PANA	1	170	\N	\N	1
666	97	TARAIRA	1	170	\N	1100	1
385	54	LA ESPERANZA	1	170	\N	798	1
458	13	MONTECRISTO	1	170	\N	173	1
160	13	CANTAGALLO	1	170	\N	161	1
300	13	HATILLO DE LOBA	1	170	\N	168	1
655	13	SAN JACINTO DEL CAUCA	1	170	\N	183	1
378	44	HATONUEVO	1	170	\N	648	1
268	47	EL RETEN	1	170	\N	666	1
520	73	PALOCABILDO	1	170	\N	989	1
268	13	EL PENON	1	170	\N	167	1
545	47	PIJINO DEL CARMEN	1	170	\N	671	1
350	23	LA APARTADA	1	170	\N	439	1
536	91	PUERTO ARICA	1	170	\N	\N	1
665	17	SAN JOSE	1	170	\N	343	1
270	50	EL DORADO	1	170	\N	695	1
888	94	CD. MORICHAL NUEVO	1	170	\N	\N	1
624	99	SANTA ROSALIA	1	170	\N	1103	1
999	47	NUEVA GRANADA	1	170	\N	669	1
98	47	ZONA BANANERA	1	170	\N	685	1
870	73	VILLAHERMOSA	1	170	\N	1004	1
563	73	PRADO	1	170	\N	992	1
547	73	PIEDRAS	1	170	\N	990	1
349	73	HONDA	1	170	\N	980	1
226	73	CUNDAY	1	170	\N	972	1
275	73	FLANDES	1	170	\N	976	1
650	44	SAN JUAN DEL CESAR	1	170	\N	652	1
872	41	VILLAVIEJA	1	170	\N	639	1
319	41	GUADALUPE	1	170	\N	55	1
530	41	PALESTINA	1	170	\N	337	1
13	41	AGRADO	1	170	\N	606	1
206	41	COLOMBIA	1	170	\N	612	1
823	70	TOLUVIEJO	1	170	\N	957	1
670	70	SAMPUES	1	170	\N	948	1
418	70	LOS PALMITOS	1	170	\N	943	1
372	27	JURADO	1	170	\N	589	1
1723	2	RIO DE JANEIRO	1	172	\N	\N	1
9563	98	RIO DE JANEIRO	1	172	\N	\N	1
236	23	TUCHIN	1	170	\N	\N	1
490	13	NOROSI	1	170	\N	\N	1
300	19	GUACHENE	1	170	\N	\N	1
682	23	SAN JOSE DE URE	1	170	\N	\N	1
125	68	BERLIN	1	170	\N	\N	1
55	73	ARMERO	1	170	\N	964	1
\.


--
-- TOC entry 2946 (class 0 OID 17789)
-- Dependencies: 201
-- Data for Name: par_serv_servicios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY par_serv_servicios (par_serv_secue, par_serv_codigo, par_serv_nombre, par_serv_estado) FROM stdin;
1	1	ACUEDUCTO	A
2	2	ALCANTARILLADO	A
3	3	ASEO	A
4	4	ENERGIA ELECTRICA	A
5	5	GAS NATURAL	A
6	6	TELEFONIA	A
7	7	GAS LICUADO DEL PETROLEO	A
8	8	SERVICIOS NO COMPETENTES 	A
9	9	CONSOLIDADO	\N
\.


--
-- TOC entry 2947 (class 0 OID 17792)
-- Dependencies: 202
-- Data for Name: prestamo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY prestamo (pres_id, radi_nume_radi, usua_login_actu, depe_codi, usua_login_pres, pres_desc, pres_fech_pres, pres_fech_devo, pres_fech_pedi, pres_estado, pres_requerimiento, pres_depe_arch, pres_fech_venc, dev_desc, pres_fech_canc, usua_login_canc, usua_login_rx, sgd_exp_numero) FROM stdin;
\.


--
-- TOC entry 2948 (class 0 OID 17798)
-- Dependencies: 203
-- Data for Name: radicado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY radicado (id, radi_nume_radi, radi_fech_radi, tdoc_codi, trte_codi, mrec_codi, eesp_codi, radi_fech_ofic, tdid_codi, radi_pais, muni_codi, cpob_codi, carp_codi, esta_codi, dpto_codi, radi_nume_hoja, radi_desc_anex, radi_nume_deri, radi_path, radi_usua_actu, radi_depe_actu, ra_asun, radi_usu_ante, radi_depe_radi, radi_usua_radi, codi_nivel, flag_nivel, carp_per, radi_leido, radi_cuentai, radi_tipo_deri, listo, sgd_tma_codigo, sgd_mtd_codigo, par_serv_secue, sgd_fld_codigo, radi_agend, radi_fech_agend, sgd_doc_secuencia, sgd_pnufe_codi, sgd_eanu_codigo, sgd_not_codi, radi_fech_notif, sgd_tdec_codigo, sgd_apli_codi, sgd_ttr_codigo, sgd_trad_codigo, fech_vcmto, sgd_termino_real, id_cont, sgd_spub_codigo, id_pais, radi_nrr, depe_codi, radi_nume_folio, radi_nume_anexo, radi_nume_guia, radi_nume_iden, sgd_rad_codigoverificacion, origen, referenciados, numero_radicado, esta_fisico) FROM stdin;
\.


--
-- TOC entry 3071 (class 0 OID 0)
-- Dependencies: 204
-- Name: radicado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('radicado_id_seq', 1, true);


--
-- TOC entry 2950 (class 0 OID 17876)
-- Dependencies: 205
-- Data for Name: series; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY series (depe_codi, seri_nume, seri_tipo, seri_ano, dpto_codi, bloq) FROM stdin;
\.


--
-- TOC entry 2951 (class 0 OID 17882)
-- Dependencies: 206
-- Data for Name: sgd_agen_agendados; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_agen_agendados (id, sgd_agen_fech, sgd_agen_observacion, radi_nume_radi, usua_doc, depe_codi, sgd_agen_fechplazo, sgd_agen_activo) FROM stdin;
\.


--
-- TOC entry 3072 (class 0 OID 0)
-- Dependencies: 207
-- Name: sgd_agen_agendados_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sgd_agen_agendados_id_seq', 1, true);


--
-- TOC entry 2953 (class 0 OID 17890)
-- Dependencies: 208
-- Data for Name: sgd_anar_anexarg; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_anar_anexarg (sgd_anar_codi, anex_codigo, sgd_argd_codi, sgd_anar_argcod) FROM stdin;
\.


--
-- TOC entry 2954 (class 0 OID 17893)
-- Dependencies: 209
-- Data for Name: sgd_anu_anulados; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_anu_anulados (sgd_anu_id, sgd_anu_desc, radi_nume_radi, sgd_eanu_codi, sgd_anu_sol_fech, depe_codi, usua_doc, usua_codi, depe_codi_anu, usua_doc_anu, usua_codi_anu, usua_anu_acta, sgd_anu_path_acta, sgd_trad_codigo) FROM stdin;
\.


--
-- TOC entry 2955 (class 0 OID 17922)
-- Dependencies: 210
-- Data for Name: sgd_argd_argdoc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_argd_argdoc (sgd_argd_codi, sgd_pnufe_codi, sgd_argd_tabla, sgd_argd_tcodi, sgd_argd_tdes, sgd_argd_llist, sgd_argd_campo) FROM stdin;
\.


--
-- TOC entry 2956 (class 0 OID 17931)
-- Dependencies: 211
-- Data for Name: sgd_auditoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_auditoria (usua_doc, tipo, tabla, isql, fecha, ip) FROM stdin;
1999999	u	USUARIO	2016-04-11 13:06:44> UPDATE USUARIO SET USUA_SESION=^160411010644O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460398004	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 13:06:44> UPDATE USUARIO SET USUA_SESION=^160411010644O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460398004	127.0.0.1 - 
1999999	u		2016-04-11 13:07:01> UPDATE\r\n                                USUARIO\r\n                                SET\r\n                                USUA_NUEVO     = ^1^,\r\n                                USUA_PASW      =^27CCB0EEA8A706C4C34A16891F^,\r\n                                USUA_SESION    = ^CAMCLAV20160411^\r\n                            WHERE\r\n                                DEPE_CODI = 900 AND\r\n                                USUA_CODI = 1	1460398021	127.0.0.1 - 
1999999	u		2016-04-11 13:07:01> UPDATE\r\n                                USUARIO\r\n                                SET\r\n                                USUA_NUEVO     = ^1^,\r\n                                USUA_PASW      =^27CCB0EEA8A706C4C34A16891F^,\r\n                                USUA_SESION    = ^CAMCLAV20160411^\r\n                            WHERE\r\n                                DEPE_CODI = 900 AND\r\n                                USUA_CODI = 1	1460398021	127.0.0.1 - 
1999999	u		2016-04-11 13:07:01> UPDATE\r\n                    USUARIO\r\n               SET\r\n                    USUA_SESION =^FIN  2016:04:11 13:0407:01^\r\n               WHERE\r\n                    USUA_SESION LIKE ^%160411010644O127001ADMON%^	1460398021	127.0.0.1 - 
1999999	u		2016-04-11 13:07:01> UPDATE\r\n                    USUARIO\r\n               SET\r\n                    USUA_SESION =^FIN  2016:04:11 13:0407:01^\r\n               WHERE\r\n                    USUA_SESION LIKE ^%160411010644O127001ADMON%^	1460398021	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 13:07:10> UPDATE USUARIO SET USUA_SESION=^160411010710O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460398030	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 13:07:10> UPDATE USUARIO SET USUA_SESION=^160411010710O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460398030	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 13:09:40> UPDATE USUARIO SET USUA_SESION=^160411010940O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460398180	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 13:09:40> UPDATE USUARIO SET USUA_SESION=^160411010940O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460398180	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 13:09:52> UPDATE USUARIO SET USUA_SESION=^160411010952O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460398192	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 13:09:52> UPDATE USUARIO SET USUA_SESION=^160411010952O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460398192	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 19:42:05> UPDATE USUARIO SET USUA_SESION=^160411074205O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460421725	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 19:42:05> UPDATE USUARIO SET USUA_SESION=^160411074205O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460421725	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 20:07:54> UPDATE USUARIO SET USUA_SESION=^160411080754O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460423274	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 20:07:54> UPDATE USUARIO SET USUA_SESION=^160411080754O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460423274	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 20:09:12> UPDATE USUARIO SET USUA_SESION=^160411080912O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460423352	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 20:09:12> UPDATE USUARIO SET USUA_SESION=^160411080912O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460423352	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 20:10:38> UPDATE USUARIO SET USUA_SESION=^160411081038O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460423438	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 20:10:38> UPDATE USUARIO SET USUA_SESION=^160411081038O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460423438	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 20:20:35> UPDATE USUARIO SET USUA_SESION=^160411082035O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460424035	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 20:20:35> UPDATE USUARIO SET USUA_SESION=^160411082035O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460424035	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 20:20:43> UPDATE USUARIO SET USUA_SESION=^160411082043O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460424043	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 20:20:43> UPDATE USUARIO SET USUA_SESION=^160411082043O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460424043	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 21:55:14> UPDATE USUARIO SET USUA_SESION=^160411095406O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460429714	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 21:55:14> UPDATE USUARIO SET USUA_SESION=^160411095406O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460429714	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 21:57:12> UPDATE USUARIO SET USUA_SESION=^160411095634O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460429832	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 21:57:12> UPDATE USUARIO SET USUA_SESION=^160411095634O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460429832	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 22:05:55> UPDATE USUARIO SET USUA_SESION=^160411100555O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460430355	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 22:05:55> UPDATE USUARIO SET USUA_SESION=^160411100555O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460430355	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 22:06:59> UPDATE USUARIO SET USUA_SESION=^160411100659O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460430419	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 22:06:59> UPDATE USUARIO SET USUA_SESION=^160411100659O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460430419	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 22:10:12> UPDATE USUARIO SET USUA_SESION=^160411101012O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460430612	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 22:10:12> UPDATE USUARIO SET USUA_SESION=^160411101012O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460430612	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 22:11:32> UPDATE USUARIO SET USUA_SESION=^160411101132O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460430692	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 22:11:32> UPDATE USUARIO SET USUA_SESION=^160411101132O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460430692	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 22:14:51> UPDATE USUARIO SET USUA_SESION=^160411101451O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460430891	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 22:14:51> UPDATE USUARIO SET USUA_SESION=^160411101451O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460430891	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 22:15:46> UPDATE USUARIO SET USUA_SESION=^160411101546O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460430946	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 22:15:46> UPDATE USUARIO SET USUA_SESION=^160411101546O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460430946	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 22:24:38> UPDATE USUARIO SET USUA_SESION=^160411102438O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460431478	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 22:24:38> UPDATE USUARIO SET USUA_SESION=^160411102438O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460431478	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 22:31:14> UPDATE USUARIO SET USUA_SESION=^160411103114O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460431874	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 22:31:14> UPDATE USUARIO SET USUA_SESION=^160411103114O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460431874	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 22:31:35> UPDATE USUARIO SET USUA_SESION=^160411103135O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460431895	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 22:31:35> UPDATE USUARIO SET USUA_SESION=^160411103135O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460431895	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 22:31:40> UPDATE USUARIO SET USUA_SESION=^160411103140O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460431900	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 22:31:40> UPDATE USUARIO SET USUA_SESION=^160411103140O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460431900	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 22:31:49> UPDATE USUARIO SET USUA_SESION=^160411103149O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460431909	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 22:31:49> UPDATE USUARIO SET USUA_SESION=^160411103149O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460431909	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 22:31:58> UPDATE USUARIO SET USUA_SESION=^160411103158O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460431918	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 22:31:58> UPDATE USUARIO SET USUA_SESION=^160411103158O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460431918	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 22:32:29> UPDATE USUARIO SET USUA_SESION=^160411103229O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460431949	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 22:32:29> UPDATE USUARIO SET USUA_SESION=^160411103229O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460431949	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 22:34:52> UPDATE USUARIO SET USUA_SESION=^160411103452O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460432092	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 22:34:53> UPDATE USUARIO SET USUA_SESION=^160411103452O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460432093	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 22:35:04> UPDATE USUARIO SET USUA_SESION=^160411103504O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460432104	127.0.0.1 - 
1999999	u	USUARIO	2016-04-11 22:35:04> UPDATE USUARIO SET USUA_SESION=^160411103504O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460432104	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 08:18:41> UPDATE USUARIO SET USUA_SESION=^160412081841O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460467121	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 08:18:41> UPDATE USUARIO SET USUA_SESION=^160412081841O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460467121	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 08:18:47> UPDATE USUARIO SET USUA_SESION=^160412081847O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460467127	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 08:18:47> UPDATE USUARIO SET USUA_SESION=^160412081847O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460467127	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 08:18:58> UPDATE USUARIO SET USUA_SESION=^160412081858O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460467138	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 08:18:58> UPDATE USUARIO SET USUA_SESION=^160412081858O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460467138	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 08:19:04> UPDATE USUARIO SET USUA_SESION=^160412081904O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460467144	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 08:19:04> UPDATE USUARIO SET USUA_SESION=^160412081904O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460467144	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 08:31:16> UPDATE USUARIO SET USUA_SESION=^160412083116O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460467876	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 08:31:16> UPDATE USUARIO SET USUA_SESION=^160412083116O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460467876	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 08:31:22> UPDATE USUARIO SET USUA_SESION=^160412083122O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460467882	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 08:31:22> UPDATE USUARIO SET USUA_SESION=^160412083122O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460467882	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 08:32:15> UPDATE USUARIO SET USUA_SESION=^160412083215O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460467935	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 08:32:15> UPDATE USUARIO SET USUA_SESION=^160412083215O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460467935	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 08:35:21> UPDATE USUARIO SET USUA_SESION=^160412083521O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460468121	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 08:35:21> UPDATE USUARIO SET USUA_SESION=^160412083521O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460468121	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 08:35:26> UPDATE USUARIO SET USUA_SESION=^160412083526O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460468126	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 08:35:26> UPDATE USUARIO SET USUA_SESION=^160412083526O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460468126	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 08:35:35> UPDATE USUARIO SET USUA_SESION=^160412083535O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460468135	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 08:35:35> UPDATE USUARIO SET USUA_SESION=^160412083535O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460468135	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 08:35:57> UPDATE USUARIO SET USUA_SESION=^160412083557O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460468157	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 08:35:57> UPDATE USUARIO SET USUA_SESION=^160412083557O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460468157	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 08:38:42> UPDATE USUARIO SET USUA_SESION=^160412083842O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460468322	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 08:38:43> UPDATE USUARIO SET USUA_SESION=^160412083842O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460468323	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 09:05:36> UPDATE USUARIO SET USUA_SESION=^160412090313O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460469936	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 09:05:36> UPDATE USUARIO SET USUA_SESION=^160412090313O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460469936	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 09:28:42> UPDATE USUARIO SET USUA_SESION=^160412092842O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460471322	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 09:28:42> UPDATE USUARIO SET USUA_SESION=^160412092842O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460471322	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 09:33:45> UPDATE USUARIO SET USUA_SESION=^160412093345O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460471625	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 09:33:45> UPDATE USUARIO SET USUA_SESION=^160412093345O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460471625	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 10:14:24> UPDATE USUARIO SET USUA_SESION=^160412101424O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460474064	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 10:14:24> UPDATE USUARIO SET USUA_SESION=^160412101424O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460474064	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 10:48:03> UPDATE USUARIO SET USUA_SESION=^160412104803O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460476083	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 10:48:03> UPDATE USUARIO SET USUA_SESION=^160412104803O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460476083	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 10:48:22> UPDATE USUARIO SET USUA_SESION=^160412104822O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460476102	127.0.0.1 - 
1999999	u	USUARIO	2016-04-12 10:48:22> UPDATE USUARIO SET USUA_SESION=^160412104822O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460476102	127.0.0.1 - 
1999999	u	USUARIO	2016-04-13 10:51:33> UPDATE USUARIO SET USUA_SESION=^160413105133O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460562693	127.0.0.1 - 
1999999	u	USUARIO	2016-04-13 10:51:33> UPDATE USUARIO SET USUA_SESION=^160413105133O127001ADMON^,USUA_FECH_SESION=(CURRENT_TIMESTAMP+INTERVAL^0 DAYS^)    WHERE  USUA_LOGIN = ^ADMON^ 	1460562693	127.0.0.1 - 
1999999	u		2016-04-13 10:51:37> UPDATE\r\n                    USUARIO\r\n               SET\r\n                    USUA_SESION =^FIN  2016:04:13 10:0451:37^\r\n               WHERE\r\n                    USUA_SESION LIKE ^%160413105133O127001ADMON%^	1460562697	127.0.0.1 - 
1999999	u		2016-04-13 10:51:38> UPDATE\r\n                    USUARIO\r\n               SET\r\n                    USUA_SESION =^FIN  2016:04:13 10:0451:37^\r\n               WHERE\r\n                    USUA_SESION LIKE ^%160413105133O127001ADMON%^	1460562698	127.0.0.1 - 
\.


--
-- TOC entry 2957 (class 0 OID 17937)
-- Dependencies: 212
-- Data for Name: sgd_camexp_campoexpediente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_camexp_campoexpediente (sgd_camexp_codigo, sgd_camexp_campo, sgd_parexp_codigo, sgd_camexp_fk, sgd_camexp_tablafk, sgd_camexp_campofk, sgd_camexp_campovalor, sgd_campexp_orden) FROM stdin;
\.


--
-- TOC entry 2958 (class 0 OID 17944)
-- Dependencies: 213
-- Data for Name: sgd_carp_descripcion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_carp_descripcion (sgd_carp_depecodi, sgd_carp_tiporad, sgd_carp_descr) FROM stdin;
\.


--
-- TOC entry 2959 (class 0 OID 17947)
-- Dependencies: 214
-- Data for Name: sgd_cau_causal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_cau_causal (sgd_cau_codigo, sgd_cau_descrip) FROM stdin;
1	Facturacion
2	Instalacion
3	Prestacion
0	---
\.


--
-- TOC entry 2960 (class 0 OID 17950)
-- Dependencies: 215
-- Data for Name: sgd_caux_causales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_caux_causales (sgd_caux_codigo, radi_nume_radi, sgd_dcau_codigo, sgd_ddca_codigo, sgd_caux_fecha, usua_doc, sgd_cau_codigo) FROM stdin;
\.


--
-- TOC entry 2961 (class 0 OID 17954)
-- Dependencies: 216
-- Data for Name: sgd_ciu_ciudadano; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_ciu_ciudadano (tdid_codi, sgd_ciu_codigo, sgd_ciu_nombre, sgd_ciu_direccion, sgd_ciu_apell1, sgd_ciu_apell2, sgd_ciu_telefono, sgd_ciu_email, muni_codi, dpto_codi, sgd_ciu_cedula, id_cont, id_pais, t_muni_codi, t_dpto_codi, t_pais_codi, pais_acapella) FROM stdin;
\.


--
-- TOC entry 2962 (class 0 OID 17962)
-- Dependencies: 217
-- Data for Name: sgd_clta_clstarif; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_clta_clstarif (sgd_fenv_codigo, sgd_clta_codser, sgd_tar_codigo, sgd_clta_descrip, sgd_clta_pesdes, sgd_clta_peshast) FROM stdin;
101	1	1	Envio normal de 1 a 500 Gr	1	500
115	1	1	Llevar via mensajero.	0	1000
101	2	8	Pruebas 	10	1000
101	1	100	Envio normal de 1 a 500 Gr	1	500
\.


--
-- TOC entry 2963 (class 0 OID 17965)
-- Dependencies: 218
-- Data for Name: sgd_cob_campobliga; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_cob_campobliga (sgd_cob_codi, sgd_cob_desc, sgd_cob_label, sgd_tidm_codi) FROM stdin;
1	NOMBRE	NOMBRE	2
2	DIRECCION	DIR	2
3	MUNICIPIO	MUNI_NOMBRE	2
4	DEPARTAMENTO	DEPTO_NOMBRE	2
5	TIPO	TIPO	2
6	PAIS	PAIS_NOMBRE	2
\.


--
-- TOC entry 2964 (class 0 OID 17974)
-- Dependencies: 219
-- Data for Name: sgd_dcau_causal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_dcau_causal (sgd_dcau_codigo, sgd_cau_codigo, sgd_dcau_descrip) FROM stdin;
\.


--
-- TOC entry 2965 (class 0 OID 17977)
-- Dependencies: 220
-- Data for Name: sgd_ddca_ddsgrgdo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_ddca_ddsgrgdo (sgd_ddca_codigo, sgd_dcau_codigo, par_serv_secue, sgd_ddca_descrip) FROM stdin;
\.


--
-- TOC entry 2966 (class 0 OID 17980)
-- Dependencies: 221
-- Data for Name: sgd_def_contactos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_def_contactos (ctt_id, ctt_nombre, ctt_cargo, ctt_telefono, ctt_id_tipo, ctt_id_empresa) FROM stdin;
\.


--
-- TOC entry 2967 (class 0 OID 17983)
-- Dependencies: 222
-- Data for Name: sgd_def_continentes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_def_continentes (id_cont, nombre_cont) FROM stdin;
1	America
\.


--
-- TOC entry 2968 (class 0 OID 17986)
-- Dependencies: 223
-- Data for Name: sgd_def_paises; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_def_paises (id_pais, id_cont, nombre_pais) FROM stdin;
166	1	PERU
29	1	BRASIL
25	1	BOLIVIA
223	1	USA
137	1	MEXICO
170	1	COLOMBIA
\.


--
-- TOC entry 2969 (class 0 OID 17990)
-- Dependencies: 224
-- Data for Name: sgd_deve_dev_envio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_deve_dev_envio (sgd_deve_codigo, sgd_deve_desc) FROM stdin;
1	CASA DESOCUPADA
2	CAMBIO DE DOMICILIO
99	SOBREPASO TIEMPO DE ESPERA
3	CERRADO
4	DESCONOCIDO
5	DEVUELTO DE PORTERIA
6	DIRECCION DEFICIENTE
7	FALLECIDO
8	NO EXISTE NUMERO
9	NO RESIDE
10	NO RECLAMADO
11	REHUSADO
12	SE TRASLADO
13	NO EXISTE EMPRESA
14	ZONA DE ALTO RIESGO
15	SOBRE DESOCUPADO
16	FUERA PERIMETRO URBANO
17	ENVIADO A ADPOSTAL, CONTROL DE CALIDAD
18	SIN SELLO
90	DOCUMENTO MAL RADICADO
\.


--
-- TOC entry 2970 (class 0 OID 17995)
-- Dependencies: 225
-- Data for Name: sgd_dir_drecciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_dir_drecciones (id, sgd_dir_codigo, sgd_dir_tipo, sgd_oem_codigo, sgd_ciu_codigo, radi_nume_radi, sgd_esp_codi, muni_codi, dpto_codi, sgd_dir_direccion, sgd_dir_telefono, sgd_dir_mail, sgd_sec_codigo, sgd_temporal_nombre, anex_codigo, sgd_anex_codigo, sgd_dir_nombre, sgd_doc_fun, sgd_dir_nomremdes, sgd_trd_codigo, sgd_dir_tdoc, sgd_dir_doc, id_pais, id_cont, departamento_id, ciudad_id, sgd_dir_apellido) FROM stdin;
\.


--
-- TOC entry 3073 (class 0 OID 0)
-- Dependencies: 226
-- Name: sgd_dir_drecciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sgd_dir_drecciones_id_seq', 1, true);


--
-- TOC entry 2972 (class 0 OID 18005)
-- Dependencies: 227
-- Data for Name: sgd_dnufe_docnufe; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_dnufe_docnufe (sgd_dnufe_codi, sgd_pnufe_codi, sgd_tpr_codigo, sgd_dnufe_label, trte_codi, sgd_dnufe_main, sgd_dnufe_path, sgd_dnufe_gerarq, anex_tipo_codi) FROM stdin;
\.


--
-- TOC entry 2973 (class 0 OID 18014)
-- Dependencies: 228
-- Data for Name: sgd_einv_inventario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_einv_inventario (sgd_einv_codigo, sgd_depe_nomb, sgd_depe_codi, sgd_einv_expnum, sgd_einv_titulo, sgd_einv_unidad, sgd_einv_fech, sgd_einv_fechfin, sgd_einv_radicados, sgd_einv_folios, sgd_einv_nundocu, sgd_einv_nundocubodega, sgd_einv_caja, sgd_einv_cajabodega, sgd_einv_srd, sgd_einv_nomsrd, sgd_einv_sbrd, sgd_einv_nomsbrd, sgd_einv_retencion, sgd_einv_disfinal, sgd_einv_ubicacion, sgd_einv_observacion) FROM stdin;
\.


--
-- TOC entry 2974 (class 0 OID 18020)
-- Dependencies: 229
-- Data for Name: sgd_eit_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_eit_items (sgd_eit_codigo, sgd_eit_cod_padre, sgd_eit_nombre, sgd_eit_sigla, codi_dpto, codi_muni) FROM stdin;
\.


--
-- TOC entry 2975 (class 0 OID 18027)
-- Dependencies: 230
-- Data for Name: sgd_empus_empusuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_empus_empusuario (sgd_empus_codigo, sgd_empus_estado, usua_login, identificador_empresa) FROM stdin;
\.


--
-- TOC entry 2976 (class 0 OID 18033)
-- Dependencies: 231
-- Data for Name: sgd_enve_envioespecial; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_enve_envioespecial (sgd_fenv_codigo, sgd_enve_valorl, sgd_enve_valorn, sgd_enve_desc) FROM stdin;
\.


--
-- TOC entry 2977 (class 0 OID 18045)
-- Dependencies: 232
-- Data for Name: sgd_exp_expediente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_exp_expediente (id, sgd_exp_numero, radi_nume_radi, sgd_exp_fech, sgd_exp_fech_mod, depe_codi, usua_codi, usua_doc, sgd_exp_estado, sgd_exp_titulo, sgd_exp_asunto, sgd_exp_carpeta, sgd_exp_ufisica, sgd_exp_isla, sgd_exp_estante, sgd_exp_caja, sgd_exp_fech_arch, sgd_srd_codigo, sgd_sbrd_codigo, sgd_fexp_codigo, sgd_exp_subexpediente, sgd_exp_archivo, sgd_exp_unicon, sgd_exp_fechfin, sgd_exp_folios, sgd_exp_rete, sgd_exp_entrepa, radi_usua_arch, sgd_exp_edificio, sgd_exp_caja_bodega, sgd_exp_carro, sgd_exp_carpeta_bodega, sgd_exp_privado, sgd_exp_cd, sgd_exp_nref, sgd_exp_fechafin, sgd_prd_codigo) FROM stdin;
\.


--
-- TOC entry 3074 (class 0 OID 0)
-- Dependencies: 233
-- Name: sgd_exp_expediente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sgd_exp_expediente_id_seq', 1, true);


--
-- TOC entry 2979 (class 0 OID 18055)
-- Dependencies: 234
-- Data for Name: sgd_fenv_frmenvio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_fenv_frmenvio (sgd_fenv_codigo, sgd_fenv_descrip, sgd_fenv_estado, sgd_fenv_planilla) FROM stdin;
102	SERVIENTREGA	1	0
103	ENTREGA PERSONAL	1	0
104	FAX	1	0
105	POSTEXPRESS	1	0
106	CORREO ELECTRONICO	1	0
107	CORRA	1	0
108	NORMAL	1	0
109	CERTIFICADO CON ACUSE 	1	0
901	NO ENVIADO	1	0
902	SOPORTE DIGITALIZADO	1	0
110	INTER RAPIDISIMO	1	0
115	Mensajero1	1	1
101	CERTIFICADO	1	0
\.


--
-- TOC entry 2980 (class 0 OID 18060)
-- Dependencies: 235
-- Data for Name: sgd_fexp_flujoexpedientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_fexp_flujoexpedientes (sgd_fexp_codigo, sgd_pexp_codigo, sgd_fexp_orden, sgd_fexp_terminos, sgd_fexp_imagen, sgd_fexp_descrip, sgd_fld_posleft, sgd_fld_postop) FROM stdin;
\.


--
-- TOC entry 2981 (class 0 OID 18063)
-- Dependencies: 236
-- Data for Name: sgd_firrad_firmarads; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_firrad_firmarads (sgd_firrad_id, radi_nume_radi, usua_doc, sgd_firrad_firma, sgd_firrad_fecha, sgd_firrad_docsolic, sgd_firrad_fechsolic, sgd_firrad_pk) FROM stdin;
\.


--
-- TOC entry 2982 (class 0 OID 18069)
-- Dependencies: 237
-- Data for Name: sgd_fld_flujodoc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_fld_flujodoc (sgd_fld_codigo, sgd_fld_desc, sgd_tpr_codigo, sgd_fld_imagen, sgd_fld_grupoweb) FROM stdin;
\.


--
-- TOC entry 2983 (class 0 OID 18075)
-- Dependencies: 238
-- Data for Name: sgd_fun_funciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_fun_funciones (sgd_fun_codigo, sgd_fun_descrip, sgd_fun_fech_ini, sgd_fun_fech_fin) FROM stdin;
\.


--
-- TOC entry 2984 (class 0 OID 18081)
-- Dependencies: 239
-- Data for Name: sgd_hfld_histflujodoc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_hfld_histflujodoc (id, sgd_hfld_codigo, sgd_fexp_codigo, sgd_exp_fechflujoant, sgd_hfld_fech, sgd_exp_numero, radi_nume_radi, usua_doc, usua_codi, depe_codi, sgd_ttr_codigo, sgd_fexp_observa, sgd_hfld_observa, sgd_fars_codigo, sgd_hfld_automatico) FROM stdin;
\.


--
-- TOC entry 3075 (class 0 OID 0)
-- Dependencies: 240
-- Name: sgd_hfld_histflujodoc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sgd_hfld_histflujodoc_id_seq', 1, true);


--
-- TOC entry 2986 (class 0 OID 18089)
-- Dependencies: 241
-- Data for Name: sgd_hmtd_hismatdoc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_hmtd_hismatdoc (sgd_hmtd_codigo, sgd_hmtd_fecha, radi_nume_radi, usua_codi, sgd_hmtd_obse, usua_doc, depe_codi, sgd_mtd_codigo) FROM stdin;
\.


--
-- TOC entry 2987 (class 0 OID 18104)
-- Dependencies: 242
-- Data for Name: sgd_masiva_excel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_masiva_excel (sgd_masiva_dependencia, sgd_masiva_usuario, sgd_masiva_tiporadicacion, sgd_masiva_codigo, sgd_masiva_radicada, sgd_masiva_intervalo, sgd_masiva_rangoini, sgd_masiva_rangofin) FROM stdin;
\.


--
-- TOC entry 2988 (class 0 OID 18107)
-- Dependencies: 243
-- Data for Name: sgd_mat_matriz; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_mat_matriz (sgd_mat_codigo, depe_codi, sgd_fun_codigo, sgd_prc_codigo, sgd_prd_codigo) FROM stdin;
\.


--
-- TOC entry 2989 (class 0 OID 18113)
-- Dependencies: 244
-- Data for Name: sgd_mrd_matrird; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_mrd_matrird (sgd_mrd_codigo, depe_codi, depe_codi_aplica, sgd_srd_codigo, sgd_sbrd_codigo, sgd_tpr_codigo, soporte, sgd_mrd_fechini, sgd_mrd_esta) FROM stdin;
\.


--
-- TOC entry 2990 (class 0 OID 18118)
-- Dependencies: 245
-- Data for Name: sgd_msdep_msgdep; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_msdep_msgdep (depe_codi, sgd_msg_codi) FROM stdin;
\.


--
-- TOC entry 2991 (class 0 OID 18121)
-- Dependencies: 246
-- Data for Name: sgd_msg_mensaje; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_msg_mensaje (sgd_msg_codi, sgd_tme_codi, sgd_msg_desc, sgd_msg_fechdesp, sgd_msg_url, sgd_msg_veces, sgd_msg_ancho, sgd_msg_largo, sgd_msg_etiqueta) FROM stdin;
100	100	Para su información	2014-07-31 00:00:00	http://locahost	0	0	0	Información
104	104	Para comentarios	2014-08-26 00:00:00	http://localhost	0	0	0	Comentarios
105	105	Para hablar conmigo del asunto	2014-08-26 00:00:00	http://localhost	0	0	0	Hablar  Asunto
106	106	Para atender con prioridad	2014-08-26 00:00:00	http://localhost	0	0	0	Prioridad Alta
101	101	Para encargarse del asunto	2014-07-31 00:00:00	http://localhost	0	0	0	Asunto
103	103	Para su consideración y firma	2014-08-26 00:00:00	htpp://localhost	0	0	0	Firma
102	102	Preparar respuesta para firma	2014-07-31 00:00:00	http://localhost	0	0	0	Respuesta firma
\.


--
-- TOC entry 2992 (class 0 OID 18124)
-- Dependencies: 247
-- Data for Name: sgd_mtd_matriz_doc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_mtd_matriz_doc (sgd_mtd_codigo, sgd_mat_codigo, sgd_tpr_codigo) FROM stdin;
\.


--
-- TOC entry 2993 (class 0 OID 18133)
-- Dependencies: 248
-- Data for Name: sgd_noh_nohabiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_noh_nohabiles (noh_fecha) FROM stdin;
\.


--
-- TOC entry 2994 (class 0 OID 18136)
-- Dependencies: 249
-- Data for Name: sgd_not_notificacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_not_notificacion (sgd_not_codi, sgd_not_descrip) FROM stdin;
4	CONDUCTA CONCLUYENTE
1	PERSONAL
3	EDICTO
\.


--
-- TOC entry 2995 (class 0 OID 18139)
-- Dependencies: 250
-- Data for Name: sgd_novedad_usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_novedad_usuario (usua_doc, nov_infor, nov_reasig, nov_vobo, nov_dev, nov_entr) FROM stdin;
\.


--
-- TOC entry 2996 (class 0 OID 18145)
-- Dependencies: 251
-- Data for Name: sgd_ntrd_notifrad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_ntrd_notifrad (radi_nume_radi, sgd_not_codi, sgd_ntrd_notificador, sgd_ntrd_notificado, sgd_ntrd_fecha_not, sgd_ntrd_num_edicto, sgd_ntrd_fecha_fija, sgd_ntrd_fecha_desfija, sgd_ntrd_observaciones) FROM stdin;
\.


--
-- TOC entry 2997 (class 0 OID 18148)
-- Dependencies: 252
-- Data for Name: sgd_oem_oempresas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_oem_oempresas (sgd_oem_codigo, tdid_codi, sgd_oem_oempresa, sgd_oem_rep_legal, sgd_oem_nit, sgd_oem_sigla, muni_codi, dpto_codi, sgd_oem_direccion, sgd_oem_telefono, id_cont, id_pais) FROM stdin;
\.


--
-- TOC entry 2998 (class 0 OID 18159)
-- Dependencies: 253
-- Data for Name: sgd_param_admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_param_admin (param_codigo, param_nombre, param_desc, param_valor) FROM stdin;
1	ALERT_FUNCTION	1	1
\.


--
-- TOC entry 2999 (class 0 OID 18165)
-- Dependencies: 254
-- Data for Name: sgd_parametro; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_parametro (param_nomb, param_codi, param_valor) FROM stdin;
PRESTAMO_ESTADO	5	Prestamo Indefinido
PRESTAMO_REQUERIMIENTO	1	Documento
PRESTAMO_REQUERIMIENTO	2	Anexo
PRESTAMO_REQUERIMIENTO	3	Documento y Anexo
PRESTAMO_DIAS_PREST	1	8
PRESTAMO_DIAS_CANC	1	2
PRESTAMO_ESTADO	4	Cancelado
PRESTAMO_ESTADO	3	Devuelto
PRESTAMO_ESTADO	2	Prestado
PRESTAMO_ESTADO	1	Solicitado
PRESTAMO_REQUERIMIENTO	4	Expediente
PRESTAMO_ESTADO	6	Devolver al Proveedor
PRESTAMO_PASW	1	123
\.


--
-- TOC entry 3000 (class 0 OID 18168)
-- Dependencies: 255
-- Data for Name: sgd_parexp_paramexpediente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_parexp_paramexpediente (sgd_parexp_codigo, depe_codi, sgd_parexp_tabla, sgd_parexp_etiqueta, sgd_parexp_orden, sgd_parexp_editable, id) FROM stdin;
\.


--
-- TOC entry 3076 (class 0 OID 0)
-- Dependencies: 256
-- Name: sgd_parexp_paramexpediente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sgd_parexp_paramexpediente_id_seq', 1, true);


--
-- TOC entry 3002 (class 0 OID 18174)
-- Dependencies: 257
-- Data for Name: sgd_pexp_procexpedientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_pexp_procexpedientes (sgd_pexp_codigo, sgd_pexp_descrip, sgd_pexp_terminos, sgd_srd_codigo, sgd_sbrd_codigo, sgd_pexp_automatico, sgd_pexp_tieneflujo) FROM stdin;
\.


--
-- TOC entry 3003 (class 0 OID 18182)
-- Dependencies: 258
-- Data for Name: sgd_plan_plantillas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_plan_plantillas (id, plan_nombre, plan_fecha, depe_codi, usua_codi, plan_tipo, plan_plantilla) FROM stdin;
\.


--
-- TOC entry 3077 (class 0 OID 0)
-- Dependencies: 259
-- Name: sgd_plan_plantillas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sgd_plan_plantillas_id_seq', 1, true);


--
-- TOC entry 3005 (class 0 OID 18190)
-- Dependencies: 260
-- Data for Name: sgd_pnufe_procnumfe; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_pnufe_procnumfe (sgd_pnufe_codi, sgd_tpr_codigo, sgd_pnufe_descrip, sgd_pnufe_serie) FROM stdin;
\.


--
-- TOC entry 3006 (class 0 OID 18193)
-- Dependencies: 261
-- Data for Name: sgd_pnun_procenum; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_pnun_procenum (sgd_pnufe_codi, depe_codi, sgd_pnun_prepone) FROM stdin;
\.


--
-- TOC entry 3007 (class 0 OID 18196)
-- Dependencies: 262
-- Data for Name: sgd_prc_proceso; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_prc_proceso (sgd_prc_codigo, sgd_prc_descrip) FROM stdin;
\.


--
-- TOC entry 3008 (class 0 OID 18199)
-- Dependencies: 263
-- Data for Name: sgd_prd_prcdmentos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_prd_prcdmentos (sgd_prd_codigo, sgd_prc_codigo, sgd_prd_descrip) FROM stdin;
\.


--
-- TOC entry 3009 (class 0 OID 18202)
-- Dependencies: 264
-- Data for Name: sgd_rda_retdoca; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_rda_retdoca (anex_radi_nume, anex_codigo, radi_nume_salida, anex_borrado, sgd_mrd_codigo, depe_codi, usua_codi, usua_doc, sgd_rda_fech, sgd_deve_codigo, anex_solo_lect, anex_radi_fech, anex_estado, anex_nomb_archivo, anex_tipo, sgd_dir_tipo) FROM stdin;
\.


--
-- TOC entry 3010 (class 0 OID 18205)
-- Dependencies: 265
-- Data for Name: sgd_rdf_retdocf; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_rdf_retdocf (id, sgd_mrd_codigo, radi_nume_radi, depe_codi, usua_codi, usua_doc, sgd_rdf_fech) FROM stdin;
\.


--
-- TOC entry 3078 (class 0 OID 0)
-- Dependencies: 266
-- Name: sgd_rdf_retdocf_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sgd_rdf_retdocf_id_seq', 1, true);


--
-- TOC entry 3012 (class 0 OID 18210)
-- Dependencies: 267
-- Data for Name: sgd_renv_regenvio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_renv_regenvio (id, sgd_renv_codigo, sgd_fenv_codigo, sgd_renv_fech, radi_nume_sal, sgd_renv_destino, sgd_renv_telefono, sgd_renv_mail, sgd_renv_peso, sgd_renv_valor, sgd_renv_certificado, sgd_renv_estado, usua_doc, sgd_renv_nombre, sgd_rem_destino, sgd_dir_codigo, sgd_renv_planilla, sgd_renv_fech_sal, depe_codi, sgd_dir_tipo, radi_nume_grupo, sgd_renv_dir, sgd_renv_depto, sgd_renv_mpio, sgd_renv_tel, sgd_renv_cantidad, sgd_renv_tipo, sgd_renv_observa, sgd_renv_grupo, sgd_deve_codigo, sgd_deve_fech, sgd_renv_valortotal, sgd_renv_valistamiento, sgd_renv_vdescuento, sgd_renv_vadicional, sgd_depe_genera, sgd_renv_pais) FROM stdin;
\.


--
-- TOC entry 3079 (class 0 OID 0)
-- Dependencies: 268
-- Name: sgd_renv_regenvio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sgd_renv_regenvio_id_seq', 1, true);


--
-- TOC entry 3014 (class 0 OID 18233)
-- Dependencies: 269
-- Data for Name: sgd_rmr_radmasivre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_rmr_radmasivre (sgd_rmr_grupo, sgd_rmr_radi) FROM stdin;
\.


--
-- TOC entry 3015 (class 0 OID 18236)
-- Dependencies: 270
-- Data for Name: sgd_san_sancionados; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_san_sancionados (sgd_san_ref, sgd_san_decision, sgd_san_cargo, sgd_san_expediente, sgd_san_tipo_sancion, sgd_san_plazo, sgd_san_valor, sgd_san_radicacion, sgd_san_fecha_radicado, sgd_san_valorletras, sgd_san_nombreempresa, sgd_san_motivos, sgd_san_sectores, sgd_san_padre, sgd_san_fecha_padre, sgd_san_notificado) FROM stdin;
\.


--
-- TOC entry 3016 (class 0 OID 18242)
-- Dependencies: 271
-- Data for Name: sgd_sbrd_subserierd; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_sbrd_subserierd (sgd_srd_codigo, sgd_sbrd_codigo, sgd_sbrd_descrip, sgd_sbrd_fechini, sgd_sbrd_fechfin, sgd_sbrd_tiemag, sgd_sbrd_tiemac, sgd_sbrd_dispfin, sgd_sbrd_soporte, sgd_sbrd_procedi) FROM stdin;
\.


--
-- TOC entry 3017 (class 0 OID 18251)
-- Dependencies: 272
-- Data for Name: sgd_senuf_secnumfe; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_senuf_secnumfe (sgd_pnufe_codi, depe_codi, sgd_senuf_sec) FROM stdin;
\.


--
-- TOC entry 3018 (class 0 OID 18254)
-- Dependencies: 273
-- Data for Name: sgd_sexp_secexpedientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_sexp_secexpedientes (sgd_exp_numero, sgd_srd_codigo, sgd_sbrd_codigo, sgd_sexp_secuencia, depe_codi, usua_doc, sgd_sexp_fech, sgd_fexp_codigo, sgd_sexp_ano, usua_doc_responsable, sgd_sexp_parexp1, sgd_sexp_parexp2, sgd_sexp_parexp3, sgd_sexp_parexp4, sgd_sexp_parexp5, sgd_pexp_codigo, sgd_exp_fech_arch, sgd_fld_codigo, sgd_exp_fechflujoant, sgd_mrd_codigo, sgd_exp_subexpediente, sgd_exp_privado, sgd_exp_caja, id, sgd_sexp_parexp6, sgd_sexp_parexp7, sgd_sexp_parexp8, sgd_sexp_parexp9, sgd_sexp_parexp10, sgd_sexp_prestamo) FROM stdin;
\.


--
-- TOC entry 3080 (class 0 OID 0)
-- Dependencies: 274
-- Name: sgd_sexp_secexpedientes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sgd_sexp_secexpedientes_id_seq', 1, true);


--
-- TOC entry 3020 (class 0 OID 18272)
-- Dependencies: 275
-- Data for Name: sgd_srd_seriesrd; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_srd_seriesrd (sgd_srd_codigo, sgd_srd_descrip, sgd_srd_fechini, sgd_srd_fechfin) FROM stdin;
\.


--
-- TOC entry 3021 (class 0 OID 18275)
-- Dependencies: 276
-- Data for Name: sgd_tar_tarifas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_tar_tarifas (sgd_fenv_codigo, sgd_tar_codigo, sgd_tar_valenv1, sgd_tar_valenv2, sgd_tar_valenv1g1, sgd_clta_codser, sgd_tar_valenv2g2, sgd_clta_descrip) FROM stdin;
101	1	5700	6700	0	1	0	\N
115	1	1	1	0	1	0	\N
101	8	0	0	10	2	1000	\N
101	100	5700	6700	0	1	0	\N
\.


--
-- TOC entry 3022 (class 0 OID 18278)
-- Dependencies: 277
-- Data for Name: sgd_tdec_tipodecision; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_tdec_tipodecision (sgd_apli_codi, sgd_tdec_codigo, sgd_tdec_descrip, sgd_tdec_sancionar, sgd_tdec_firmeza, sgd_tdec_versancion, sgd_tdec_showmenu, sgd_tdec_updnotif) FROM stdin;
\.


--
-- TOC entry 3023 (class 0 OID 18293)
-- Dependencies: 278
-- Data for Name: sgd_tip3_tipotercero; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_tip3_tipotercero (sgd_tip3_codigo, sgd_dir_tipo, sgd_tip3_nombre, sgd_tip3_desc, sgd_tip3_imgpestana, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_tp3, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) FROM stdin;
2	1	DESTINATARIO	DESTINATARIO	tip3destina.jpg	1	0	1	1	1	1
3	2	PREDIO	PREDIO	tip3predio.jpg	1	1	1	1	1	1
4	3	ENTIDAD	ENTIDAD	tip3esp.jpg	1	1	1	1	1	1
1	1	REMITENTE	REMITENTE	tip3remitente.jpg	0	1	0	0	0	1
\.


--
-- TOC entry 3024 (class 0 OID 18302)
-- Dependencies: 279
-- Data for Name: sgd_tma_temas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_tma_temas (sgd_tma_codigo, depe_codi, sgd_prc_codigo, sgd_tma_descrip) FROM stdin;
\.


--
-- TOC entry 3025 (class 0 OID 18305)
-- Dependencies: 280
-- Data for Name: sgd_tme_tipmen; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_tme_tipmen (sgd_tme_codi) FROM stdin;
1
\.


--
-- TOC entry 3026 (class 0 OID 18308)
-- Dependencies: 281
-- Data for Name: sgd_tpr_tpdcumento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_tpr_tpdcumento (sgd_tpr_codigo, sgd_tpr_descrip, sgd_tpr_termino, sgd_tpr_tpuso, sgd_tpr_radica, sgd_tpr_tp3, sgd_tpr_tp1, sgd_tpr_tp2, sgd_tpr_estado, sgd_termino_real, sgd_tpr_tp6, sgd_tpr_web, sgd_tpr_tp4, sgd_tpr_tp5, sgd_tpr_tp9) FROM stdin;
2	Acta	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
3	Acta aprobación de garantía única	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
4	Acta de anulación de certificado de disponibilidad presupuestal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
5	Acta de anulación de saldos no comprometidos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
6	Acta de Apertura	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
7	Acta de aprobación del plan financiero	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
8	Acta de audiencia Asignación de riesgos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
9	Acta de Audiencia de Adjudicación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
10	Acta de Audiencia de precalificación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
11	Acta de cierre de la mesa	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
12	Acta de cierre y apertura de propuestas 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
13	Acta de comité	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
14	Acta de comité de conciliación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
15	Acta de concertación del PIGA	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
16	Acta de conciliación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
17	Acta de conformación del COPASO	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
18	Acta de designación comité evaluador	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
19	Acta de entrega de los bienes por contrato de comodato	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
20	Acta de entrega del bien por donación  traslado o traspaso	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
21	Acta de entrega del predio	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
22	Acta de entrega y recibo de bienes	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
24	Acta de escrutinio con número de votos depositados por mesa	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
25	Acta de escrutinio con número total de sufragantes	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
26	Acta de escrutinio general	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
27	Acta de finalización o recibo de satisfacción 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
28	Acta de informe de gestión	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
29	Acta de inicio	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
30	Acta de instalación de la mesa	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
31	Acta de la subasta presencial o electrónica	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
32	Acta de liquidación 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
33	Acta de liquidación contrato	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
34	Acta de liquidación de compromiso presupuestal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
35	Acta de liquidación de contrato con anexos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
36	Acta de posesión	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
37	Acta de recibo de propuestas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
38	Acta de recibo final para la terminación de contrato	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
39	Acta de Reparto  	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
40	Acta de Reparto Notarial 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
41	Acta de reunión de COPASO	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
42	Acta de reunión de presentación y aprobación del plan	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
43	Acta de reunión del CONFIS	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
45	Acta de revisión por la dirección	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
46	Acta de supervisión	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
47	Acta de Verificación de oferta económica y Acuerdo con el oferente calificado en primer lugar.	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
48	Acta del comité de inventario	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
49	Acta del comité interno de conciliación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
51	Acta Visita administrativa	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
52	Actas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
53	Actas de Comité de Contratación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
54	Actas de reunión	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
55	Actas de reuniones clientes potenciales	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
56	Actas de supervisión	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
57	Acto administrativo autorizando la licencia por paternidad o adopción	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
58	Acto administrativo de aprobación del traslado presupuestal (Acta  resolución o acuerdo de la junta directiva)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
59	Acto administrativo de baja o alta de bienes motivado en la toma	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
60	Acto administrativo de conformación del COPASO	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
61	Acto administrativo de convocatoria para elecciones de representantes COPASO	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
62	Acto administrativo de liquidación unilateral	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
63	Acto administrativo de modificación de la planta	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
64	Acto administrativo de suspensión o aplazamiento presupuestal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
65	Acto administrativo del retiro del funcionario	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
66	Acto administrativo que ordenaria la ejecución de la sanción	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
67	Acuerdo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
68	Acuerdo de expedición del presupuesto	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
69	Acuerdo de la junta directiva dando concepto favorable al proyecto de presupuesto	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
70	Acuerdo de modificación presupuestal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
73	Adendas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
74	Adendas (si hay lugar)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
75	Administración del Edificio	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
76	Afiliación al fondo de pensiones y salud	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
77	Alegatos de conclusión	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
78	Análisis del entorno	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
79	Anexo Memorando Interno solicitud para facturar	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
80	Anexos (Copia Consignación  transferencia electrónica).	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
81	Antecedentes	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
82	Antecedentes judiciales	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
83	Antecedentes propios de tipo contractual	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
84	Anteproyecto de presupuesto	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
85	Audiencia pacto de cumplimiento	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
86	Audiencia y fallo proceso verbal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
87	Auto admisorio de la acción	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
88	Auto admisorio y/o inadmisorio	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
89	Auto apertura investigación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
90	Auto citación audiencia	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
91	Auto concediendo recurso de apelación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
92	Auto concediendo recurso de queja	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
93	Auto corriendo traslado para alegar de conclusión	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
94	Auto de acumulación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
95	Auto de archivo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
96	Auto de incorporación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
97	Auto de indagación preliminar averiguación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
98	Auto de indagación preliminar implicado	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
99	Auto de nulidad	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
100	Auto de remisión por competencia a otro operador interno	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
101	Auto de remisión por competencia poder preferente	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
102	Auto declarando desierto recurso	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
103	Auto declarando desierto recurso de queja	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
104	Auto declarando precluido el recurso de queja	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
105	Auto declaratoria ausencia	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
107	Auto decreta pruebas descargos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
108	Auto desatando la apelación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
109	Auto inhibitorio	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
110	Auto niega pruebas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
111	Auto nombramiento defensor	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
112	Auto nombramiento defensor de oficio	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
113	Auto obedezcase y cúmplase	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
114	Auto prorroga término investigación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
115	Auto que inadmite la revocatoria directa	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
116	Auto que rechaza la revocatoria directa	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
117	Auto rechazando recurso de apelación extemporaneo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
118	Auto rechazando recurso de apelación improcedente	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
119	Auto rechazando recurso de queja extemporáneo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
120	Auto rechazando recurso de reposición extemporaneo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
121	Auto rechazando recurso de reposición improcedente	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
122	Auto remisión por competencia	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
123	Auto resolviendo recurso reposición	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
125	Autorización de descuento 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
124	Auto variación pilego de cargos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
127	Autorización de Pago a Terceros	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
128	Autorización para subarrendar el predio	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
129	Avalúo Comercial del predio	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
130	Aviso de convocatoria	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
131	backup	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
132	Balance General	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
133	Balance General  certificado por contador	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
134	Base de Datos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
135	Boletín Catastral	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
136	Carta de aceptación de la oferta de Compra	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
137	CDP	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
138	Certificación bancaria	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
140	Certificación de información laboral para la emisión de bono pensional	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
141	Certificación de la cuenta bancaria	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
142	Certificación de pago de cesantías del fondo Nacional del Ahorro 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
322	Conciliación prejudicial	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
144	Certificación de pago del servicio prestado	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
145	Certificación de tradición y libertad (cesantías para liberación de gravámenes)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
146	Certificación del banco de apertura de cuenta	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
147	Certificación del Ministerio de Educación avalando la institución educativa (cesantías para educación)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
148	Certificación importación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
149	Certificación laboral de funciones y/o salarial	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
150	Certificación médica	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
151	Certificación nacionalización vehículo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
152	Certificaciones de experiencia	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
153	Certificado de  capacidad  idoneidad y experiencia	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
154	Certificado de antecedentes de la Contraloría General de la República	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
155	Certificado de antecedentes disciplinarios de la Personería de Bogotá	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
156	Certificado de antecedentes disciplinarios de la procuraduría	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
158	Certificado de antecedentes disciplinarios del Consejo Superior de la Judicatura (para abogados) (persona natural)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
160	Certificado de antecedentes penales de la Policía Nacional	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
159	Certificado de antecedentes fiscales  de la Contraloría General de la Nación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
161	Certificado de antecedentes profesionales	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
162	Certificado de aportes parafiscales para personas naturales o jurídicas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
163	Certificado de compromiso de reservas presupuéstales	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
164	Certificado de Cumplimiento 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
165	Certificado de defunción	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
166	Certificado de disminución de la base de retención en la fuente por concepto de salud prepagada	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
167	Certificado de Disponibilidad Presupuestal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
168	Certificado de disponibilidad presupuestal de los rubros a los cuales se les reduce el presupuesto	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
169	Certificado de Existencia y Representación Legal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
170	Certificado de existencia y representación Legal -  persona jurídica	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
171	Certificado de factores salariales	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
172	Certificado de garantía	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
173	Certificado de invalidez	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
174	Certificado de los antecedentes disciplinarios de la personería	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
175	Certificado de paz y salvo de pensión y salud para personas naturales y jurídicas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
176	Certificado de Registro Presupuestal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
177	Certificado de tradición y libertad (cesantías para compra de vivienda)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
178	Certificado del banco donde se tenga la obligación hipotecaria (cesantías para liberación de gravámenes)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
180	Certificado o afiliación a pensión	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
181	Certificado o afiliación a salud	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
182	Certificado para disminución de la base de retención en la fuente por concepto de obligación hipotecaria	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
184	Certificados de experiencia laboral	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
183	Certificados de estudios	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
185	Certificados de formación académica	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
186	Certificados de ingresos y retenciones	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
187	Certificados de tradición y libertad para estudio de títulos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
188	Circular	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
189	Circular de cierre presupuestal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
190	Circular de programación presupuestal y cronograma presupuestal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
191	Circular informando a las áreas el cronograma para la proyección de los ingresos y gastos para la siguiente vigencia	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
192	Citación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
193	Citación Notificación Oferta de Compra	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
194	Citación para ser jurados de votación en elecciones por votación popular	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
195	Citación quejoso ratificación y ampliación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
196	Citación revisión por la Dirección	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
197	Citación testigo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
198	Coadyuvancia	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
199	Comentarios a los pliegos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
200	Comprobante de ajuste	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
201	Comprobante de ingreso a almacén o bodega	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
202	Comprobante de salida de bienes	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
203	Comprobante de salida de bienes por contrato de comodato	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
204	Comprobante de salida por donación  traslado o traspaso	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
255	Comunicación oficial de renuncia voluntaria	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
253	Comunicación oficial de notificación de la resolución que resuelve el recurso de apelación	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
252	Comunicación oficial de notificación de la resolución para licencia	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
251	Comunicación oficial de notificación de la resolución o decreto para la comisión de servicios	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
250	Comunicación oficial de notificación de la resolución o decreto para la comisión de estudios	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
249	Comunicación oficial de notificación de la resolución de suspensión o aplazamiento	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
248	Comunicación oficial de notificación de la resolución de reconocimiento o reajuste de la prima técnica	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
247	Comunicación oficial de notificación de la resolución de nombramiento 	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
350	Cronograma de actividades con la ARL	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
206	Comprobante de traslado o salida de bienes de almacén al servicio	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
205	Comprobante de traslado de inventarios	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
207	Comprobantes de movimiento diario	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
208	Comprobantes de reintegro de la tesorería Distrital	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
209	Comunicación a organismos de control sobre fallo absolutorio	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
210	Comunicación al nominador para la ejecución	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
211	Comunicación apertura de indagación preliminar	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
212	Comunicación apertura de investigación implicado	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
213	Comunicación apertura de investigación personeria	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
214	Comunicación apertura de investigación procuraduria	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
216	Comunicación auto archivo quejoso	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
215	Comunicación auto archivo implicado	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
217	Comunicación auto concede apelación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
218	Comunicación auto niega recurso de apelación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
219	Comunicación auto segunda instancia quejoso	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
220	Comunicación citación audiencia implicado	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
221	Comunicación citación audiencia personeria	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
222	Comunicación citación audiencia procuraduria	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
223	Comunicación citación audiencia recursos humanos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
224	Comunicación consultorio juridico	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
225	Comunicación decreto oficioso de pruebas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
227	Comunicación defensor oficio	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
228	Comunicación enviando el cronograma de transferencias (CORREO ELECTRONICO)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
229	Comunicación fallo absolutorio quejoso	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
230	Comunicación fallo de segunda instacia	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
231	Comunicación fallo primera instancia implicado	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
232	Comunicación implicado no apelante	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
233	Comunicación implicado segunda instancia	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
234	Comunicación interna de Traslado al funcionario designado para resover la PQRS	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
235	Comunicación oficial	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
236	Comunicación oficial autorizando el permiso o calamidad domestica	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
237	Comunicación oficial citando al comité	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
238	Comunicación oficial comunicando la autorización de la comisión de servicios	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
239	Comunicación oficial convocando a los miembros del COPASO	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
241	Comunicación oficial de divulgación del Plan de Capacitación 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
242	Comunicación oficial de divulgación del Programa de Bienestar Social 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
243	Comunicación oficial de negación de la prima técnica	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
244	Comunicación oficial de notificación a los jurados	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
246	Comunicación oficial de notificación de la resolución de insubsistencia del nombramiento de un empleado	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
256	Comunicación Oficial de respuesta al peticionario.	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
257	Comunicación oficial de solicitud de certificación de información laboral para la emisión de bono pensional	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
258	Comunicación oficial de solicitud de encargo de personal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
259	Comunicación oficial de solicitud de inclusión de las modificaciones presupuéstales en la agenda del CONFIS	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
260	Comunicación oficial de solicitud de inscripción de las actividades de  bienestar 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
261	Comunicación oficial de solicitud de liquidación de cesantías parciales o definitivas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
262	Comunicación oficial de solicitud de vacaciones	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
263	Comunicación oficial de solicitud para comisión de estudios	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
323	Conformación lista de oferentes (menor cuantía)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
264	Comunicación oficial de solicitud para comisión interna o externa de servicios	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
265	Comunicación oficial del CONFIS a cada una de las entidades remitiendo las modificaciones presupuéstales aprobadas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
267	Comunicación oficial informando a los entes de control la efectividad de la sanción	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
268	Comunicación oficial informando al área las inconsistencias encontradas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
269	Comunicación oficial informando al funcionario cuando se hace efectiva la sanción	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
270	Comunicación oficial informando el periodo de vacaciones acumuladas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
271	Comunicación oficial informando la elección del cargo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
272	Comunicación oficial informando la programación de saneamiento ambiental	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
273	Comunicación oficial informando la realización del simulacro a las instancias participantes	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
274	Comunicación oficial informando que no se requiere saneamiento preventivo 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
275	Comunicación oficial negando las cesantías parciales	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
276	Comunicación oficial remisoria a la Secretaría Distrital de Planeación de la solicitud de concepto sobre modificación 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
277	Comunicación oficial remisoria de las TRD al concejo Distrital de archivos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
278	Comunicación oficial remisoria de las TVD al concejo Distrital de archivos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
280	Comunicación Oficial remisorio de la PQRS a la dependencia o Etidad competente	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
281	Comunicación oficial remisorio de los aportes a cesantías al fondo 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
282	Comunicación oficial remitiendo las TRD para concepto de archivo de Bogotá	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
283	Comunicación oficial remitiendo las TVD para concepto de archivo de Bogotá	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
284	Comunicación oficial renunciando al cargo por jubilación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
285	Comunicación oficial solicitando a la Secretaría de Hacienda concepto sobre traslado presupuestal interno 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
286	Comunicación oficial solicitando a las secretarías de Hacienda y Planeación la aprobación de la reducción presupuestal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
287	Comunicación oficial solicitando concepto sobre suspensión o aplazamiento presupuestal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
288	Comunicación oficial solicitando permiso	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
289	Comunicación otras autoridades	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
290	Comunicación pliego de cargos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
291	Comunicación prorroga apertura de investigación implicado	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
292	Comunicación registro sanción personeria	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
293	Comunicación registro sanción procuraduria	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
294	Comunicación remisión expediente segunda instancia	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
295	Comunicación remisoria del Acto administrativo de reducción presupuestal a las secretarias de hacienda y planeación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
296	Comunicación remisoria del formulario de planta de personal con costos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
297	Comunicación solicitando reconocimiento y ajuste de la primera técnica	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
298	Comunicación solicitud de documentos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
299	Comunicación tramite recurso queja	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
300	Comunicación traslado alegatos conclución	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
301	Comunicaciones	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
302	Comunicaciones internas y externas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
303	Comunicaciones Oficiales	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
304	Comunicaciones oficiales bancos 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
305	Comunicaciones Oficiales Enviadas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
307	Comunicaciones Oficiales Recibidas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
306	Comunicaciones Oficiales Internas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
308	Comunicado oficial remisorio a la Secretaria Distrital de Planeación de la solicitud de concepto sobre modificaciones	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
309	Concepto	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
311	Concepto de las TRD de archivo de Bogotá	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
312	Concepto de las TVD de archivo de Bogotá	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
314	Concepto sobre aplazamiento o reducción presupuestal por parte de la Secretaría de Hacienda.	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
310	Concepto de Factibilidad	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
313	Concepto de Viabilidad	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
315	Concepto sobre traslado presupuestal interno emitido por la secretaría de hacienda	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
317	Concepto técnico de los bienes susceptibles de baja	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
318	Concepto técnico y recomendaciones al proyecto de presupuesto	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
320	Conceptos 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
319	Concepto validación y valoración social	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
321	Conciliación judicial	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
328	Constancia de inasistencia	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
335	Contrato laboral a termino fijo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
340	Convocatoria para conformación de las brigadas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
326	Constancia de cumplimiento de pagos al Sistema de Seguridad Social y Parafiscales (personas jurídicas)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
327	Constancia de ejecutoria	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
329	Constancia de no conciliación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
330	Contestación de la acción	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
331	Contestación de la demanda	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
332	Contestación de la querella	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
333	Contrato	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
336	Convenio Interadministrativo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
338	Convocatoria Cerrada	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
337	Convocatoria Abierta pública	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
339	Convocatoria de concurso cerrado para trabajadores oficiales	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
341	Copia de la cédula de ciudadanía (Conductor)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
342	Copia de la licencia de conducción	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
343	Copia de la manzana catastral	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
344	Copia de la Póliza de seguro 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
346	Copia de recibos de servicios públicos del predio	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
353	Cronograma de ejecución del plan de mercadeo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
345	Copia de la Tarjeta de propiedad	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
347	Copia del contrato de arrendamiento  actual	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
348	Copia Folio de Matrícula Inmobiliaria 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
349	Cotización plan de compras. 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
351	Cronograma de actividades para mitigar riesgos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
352	Cronograma de ejecución del inventario físico de bienes 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
354	Cronograma de transferencias documentales primarias	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
355	Croquis del accidente de tránsito	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
356	CRP	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
357	Cuadro de Clasificación documental	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
359	Cuadro preliminar del anteproyecto de ingresos y/o gastos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
358	Cuadro de indicadores y cierre financiero	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
360	Cuadro y tabla de ventas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
361	Declaración 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
362	Declaración de ICA de los últimos dos (2) años	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
363	Declaración de IVA de los últimos dos (2) años	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
365	Declaración escrita a la Empresa de Renovación Urbana	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
366	Declaración escrita del propietario del predio	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
367	Declaración escrita firmada por arrendatario y arrendador	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
368	Declaración extrajuicio de convivencia (cesantías para educación)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
369	Declaración juramentada de bienes y rentas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
370	Declaración juramentada de no tener procesos de demandas por alimentos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
371	Decreto autorizando comisión al exterior del país	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
372	Decreto autorizando comisión de servicios	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
373	Decreto de comisión por estudios en el exterior	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
374	Decreto de liquidación 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
375	Decreto de liquidación (Alcalde Mayor)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
376	Decreto de reducción presupuestal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
377	Demanda	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
378	Denuncia	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
379	Denuncia del hurto de un bien	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
380	Derecho de Peticion	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
381	Diagnóstico de la falla del vehículo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
382	Directiva	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
383	Documentación Antecedentes IDU	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
385	Documento convocatoria a la elección del COPASO	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
386	Documento de aprobación del Programa de Seguridad y Salud en el trabajo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
387	Documento de baja de bien por hurto	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
388	Documento de compromiso u oficialización del hallazgo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
389	Documento de divulgación de la lista de candidatos inscritos al COPASO	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
390	Documento de divulgación del Plan de trabajo de Seguridad y Salud en el trabajo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
391	Documento de Flujo de caja a precios constantes	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
392	Documento de formulación del proyecto 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
393	Documento de inspecciones	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
396	Documento de recomendaciones al CONFIS	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
397	Documento de reinducción	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
398	Documento de verificación del subsane de documentos 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
399	Documento informando a los funcionarios la participación en la capacitaciones 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
400	Documento informando las fechas  de realización del inventario	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
401	Documento que soporta el recibo a satisfacción	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
402	Documento síntesis de Gestión Social 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
403	Documentos de prefactibilidad o de factibilidad	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
404	Documentos de recolección de necesidades de capacitación 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
405	Documentos que soportan los lances durante la subasta presencial	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
406	ECO Estudio de Conveniencia y Oportunidad	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
408	Encuesta de satisfacción	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
407	Edicto	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
409	Encuestas Unidades Documentales	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
410	Escrito alegatos de conclución	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
411	Escrito de descargos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
412	Escritura del predio a nombre de la Entidad	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
413	Escrituras de tradición del inmueble a 20 años	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
414	Especificaciones técnicas del producto o servicio	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
415	Especificaciones técnicas del producto o servicio para la subasta inversa	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
416	Estadísticas de salud visual  auditiva  ergonómica	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
417	Estado de actividades económica  social y ambiental	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
780	Publicación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
418	Estado de cambios en el Patrimonio	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
419	Estado de cuenta predial	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
420	Estado de flujos de efectivo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
421	Estado de pérdidas y ganancias	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
422	Estado de Resultados  certificado por contador	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
423	Estados de cuentas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
424	Estados de cuentas (Saldos a favor de contratistas)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
425	Estrategia de gestión social en la zona priorizada	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
426	Estudio ambiental	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
427	Estudio arquitectónico	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
428	Estudio de avalúo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
429	Estudio de mercado	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
430	Estudio de necesidades	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
432	Estudio de redes	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
433	Estudio de reparto de cargos y beneficios	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
434	Estudio de suelos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
435	Estudio de títulos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
436	Estudio de Títulos del predio	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
437	Estudio de transito	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
438	Estudio de valoración patrimonial 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
439	Estudio de viabilidad	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
440	Estudio jurídico	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
441	Estudio socio económico	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
442	Estudio técnico	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
443	Estudio topográfico	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
444	Estudio urbanístico	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
445	Estudios previos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
446	Evaluación a la fecha de retiro	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
447	Evaluación de conocimiento de la capacitación 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
448	Evaluación de satisfacción de la capacitación 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
450	Evaluación del desempeño de los funcionarios a su cargo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
451	Exposición de motivos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
452	Extracto del acta de la junta directiva aprobando la reducción presupuestal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
453	Extractos bancarios	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
454	Factura de acueducto y alcantarillado	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
455	Factura de luz	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
457	Factura de teléfono	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
456	Factura de telefonía móvil	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
458	Factura de venta	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
459	Factura o Cuenta Cobro	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
460	Fallo ejecutoriado de sanción disciplinaria	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
461	Fallo primera instancia	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
462	Fallo segunda instancia	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
463	Fallos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
464	Ficha de cómite de conciliación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
465	Ficha de conciliación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
466	Ficha Seguimiento Unidad Social 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
468	Fichas Censales	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
470	Fichas preliminares de perfiles de clientes	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
472	Folio de Matrícula Inmobiliaria con oferta de compra Inscrita	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
471	Folio de Matricula Inmobiliaria con Escritura Registrada a Nombre de la Entidad	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
473	Formato Acta de Acuerdo 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
474	Formato Acta de Recibo de Predio	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
476	Formato Certificado de Registro Presupuestal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
475	Formato Certificado de Disponibilidad Presupuestal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
477	Formato conciliación informes tesorería	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
478	Formato creación y/o eliminación de usuarios y/o correo GCO-FT-042	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
479	Formato de conciliación de información	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
480	Formato de Factura	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
481	Formato de Plan de mejoramiento	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
483	Formato de solicitud actualización Intranet y pagina Web CI-FT-054	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
484	Formato de solicitud de elementos de oficina	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
485	Formato de solicitud de modificación y actualización de indicadores	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
486	Formato de solicitud último pago	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
487	Formato de transferencia electrónica	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
488	Formato Disponibilidad de Fondos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
489	Formato Estado de Tesorería	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
490	Formato liquidación del componente económico del Plan de Gestión Social	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
491	Formato para Caracterización Social	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
492	Formato Recibo de Caja	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
493	Formato Registro de Atención a ciudadanos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
494	Formato solicitud Autorización de Pago Primer Contado	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
781	Queja	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
495	Formato solicitud Autorización de Pago Segundo Contado	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
497	Formato Solicitud de Registro presupuestal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
496	Formato Solicitud de Disponibilidad Presupuestal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
498	Formato único de hoja de vida	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
499	Formato Único de Hoja de Vida  persona natural  debidamente diligenciado	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
500	Formatos para recolección de necesidades de la comunidad (Entrevista)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
501	Formulario de evaluación y entrevista para ingreso de empleos cargos de libre nombramiento	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
502	Formulario de obligaciones contingentes por operaciones de crédito y otros contratos administrativos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
503	Formulario de Preguntas y Respuestas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
504	Formulario de proyección del servicio de la deuda	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
505	Formulario de superávit fiscal o excedente financiero	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
506	Formulario financiación de reservas presupuéstales	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
507	Formulario planta de personal con costos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
508	Formulario relación de los pasivos exigibles de funcionamiento	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
509	Formularios de pago de impuesto predial últimos cinco años	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
510	Fotocopia de acta de posesión (Entidad contratante)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
512	Fotocopia de Cédula del propietario - persona natural	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
513	Fotocopia de la  Cédula de Ciudadanía	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
514	Fotocopia de la cédula de ciudadanía del beneficiario	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
516	Fotocopia de la cédula del arquitecto o Ing. Civil (Cesantías para mejoras locativas)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
515	Fotocopia de la cédula de la ciudadanía del representante legal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
517	Fotocopia de la tarjeta profesional (de acuerdo al cargo)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
518	Fotocopia de la tarjeta profesional del arquitecto o Ing. Civil (cesantías para mejoras locativas)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
519	Fotocopia de los certificados laborales  académicos y/o experiencia	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
520	Fotocopia del decreto de nombramiento (Entidad contratante)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
522	Fotocopia Libreta militar	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
521	Fotocopia del documento de identidad	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
524	Garantía Única	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
523	Fuente de financiación de los pasivos exigibles	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
525	GF-FT-079 Orden de Operación o Instrucción de Pago	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
526	GF-FT-080 Seguimiento Contractual	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
527	GF-FT-081 Seguimiento Diario Fideicomisos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
528	Guía de recibido	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
529	Hoja de vida de la Función Pública	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
530	Hoja de vida del equipo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
531	Hoja de vida del indicador	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
535	Incapacidades	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
537	Información de la cuenta bancaria	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
533	Impugnación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
538	Información Mercado Inmobiliario	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
539	Informe	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
540	Informe Acuerdo de Gestión de los Jefes de Control Interno	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
542	Informe consolidado de bienes de consumo  devolutivos y saldos contables de inventarios	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
541	Informe análisis de seguimiento	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
543	Informe Controles de Advertencia 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
544	Informe de Actividades	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
545	Informe de actividades de ejecución de la ARL	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
546	Informe de actividades desarrolladas al vehículo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
547	Informe de análisis de las tendencias o comportamiento del mercado 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
548	Informe de auditoría de seguimiento al desarrollo del plan	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
549	Informe de Cierre Expediente GS-FT-071	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
550	Informe de comisión	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
551	Informe de conteo físico en almacén o bodega	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
552	Informe de cumplimiento a la Directiva 003 de 2013	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
553	Informe de disponibilidades  compromisos y autorizaciones de giro	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
554	Informe de ejecución del plan de compras	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
555	Informe de ejecución presupuestal activa y pasiva (Ingresos y gastos)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
556	Informe de ejecución presupuestal de ingresos y gastos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
557	Informe de esquemas comerciales del negocio y estrategias de comercialización	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
558	Informe de Evaluación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
559	Informe de Evaluación a la Gestión Institucional	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
561	Informe de evaluación de las actividades para mitigar el riesgo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
560	Informe de evaluación de las actividades de seguridad y salud en el trabajo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
562	Informe de Gestión de la ERU.	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
563	Informe de hechos constitutivos de faltas disciplinarias	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
565	Informe de justificación de las partidas presupuéstales de informes y/o gastos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
564	Informe de justificación de la anulación presupuestal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
566	Informe de justificación de los ingresos proyectados	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
567	Informe de justificación de los parámetros  las variables o supuestos utilizados y cambios en las tendencias de la proyección 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
568	Informe de justificación legal  económica y financiera del traslado presupuestal interno del traslado que afecta los agregados	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
569	Informe de la ejecución por proyectos del Sistema General de Participación y plusvalía	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
570	Informe de la Rendición de Cuenta Electrónico por SIVICOF	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
571	Informe de las quejas  sugerencias y reclamos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
572	Informe de logros	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
573	Informe de los simulacros de emergencia	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
574	Informe de pruebas de comercialización de productos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
575	Informe de reporte de indicadores	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
577	Informe de Seguimiento a los Mapas de Riesgos Institucionales	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
576	Informe de seguimiento a las Funciones del Comité de Conciliaciones	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
578	Informe de seguimiento a los proyectos de inversión	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
579	Informe de Seguimiento al Plan de Mejoramiento	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
580	Informe de tasación de indemnizaciones	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
581	Informe del ajuste presupuestal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
582	Informe del estado de la tesorería 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
584	Informe diagnóstico del entorno y del mercado	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
585	Informe Ejecutivo Anual del Sistema de Control Interno	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
586	Informe estadístico de consumo de servicios públicos y telefonía móvil	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
587	Informe Final	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
588	Informe final de contratista	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
589	Informe final de ejecución  del Programa de Bienestar Social 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
590	Informe final de ejecución del plan de capacitación 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
591	Informe Final de Gestión Social 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
592	Informe final de la toma física de los inventarios en bodega y bienes devolutivos en servicio 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
593	Informe final de sobrantes y faltantes	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
594	Informe Pormenorizado de Control Interno 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
595	Informe Preliminar	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
597	Informe Seguimiento al Plan Anticorrupción	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
598	Informe técnico de saneamiento ambiental preventivo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
599	Informes	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
600	Informes a Entes de Control	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
601	Informes de actividades	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
602	Informes de Evaluación del Sistema de Control Interno Contable	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
603	Informes de precalificación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
604	Informes de seguimiento PIGA	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
605	Informes estados financieros	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
607	Instrumento que detecte las necesidades colectivas e individuales de Bienestar Social 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
608	Inventario de entrega	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
609	Inventario individual de bienes devolutivos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
610	Inventario individual de bienes devolutivos en servicio	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
611	Inventarios de registros documentales	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
612	Inventarios de registros documentales de la transferencia primaria	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
613	Inventarios documentales a eliminar	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
614	Investigación de accidentes e incidentes de trabajo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
615	Invitación Pública	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
616	Justificación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
617	Justificación legal  económica y financiera (Empresas industriales y/o comerciales del estado)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
618	Justificación legal  económica y financiera de la reducción presupuestal 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
619	Justificación legal  económica y financiera del traslado presupuestal de inversión	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
620	Justificación legal  económica y financiera del traslado presupuestal interno por centro de costos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
622	Libro auxiliar	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
621	Legalización de Caja Menor	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
623	Libro diario	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
624	Libro mayor y balance	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
625	Lineamiento de política presupuestal emitida por la Alcaldía mayor de Bogotá	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
626	Lista de aspirantes inscritos para elección del COPASO	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
627	Lista de clientes potenciales	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
628	Lista de precios y tarifas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
629	Lista general de votantes	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
630	Lista general de votantes y jurados publicada	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
631	Listado de asistencia a la capacitación de brigadistas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
632	Listado de asistencia a los programas de capacitación 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
634	Listado de los afiliados al fondo de cesantías  del Fondo Nacional del Ahorro 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
635	Listado de postulados para la conformación de brigadas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
636	Listados de asistencia	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
637	Manejo de Caja Menor	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
638	Manifestación de interés en participar (menor cuantía)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
639	Manifestaciones de interés	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
640	Manual 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
641	Manual de Contratación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
642	Manual de imagen corporativa	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
643	Manual de Operaciones	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
644	Mapa de Tenencia	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
646	Marco fiscal de mediano plazo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
645	Mapa para Identificación de Conflictos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
647	Matrícula	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
648	Matriz	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
649	Matriz de Gestión Institucional	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
650	Matriz FODA	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
651	Memorando	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
652	Memorando Detallando las Inconsistencias	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
653	Memorando donde se confirma el hurto de un bien	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
654	Memorando enviando la proyección de los ingresos y/o gastos por centro de costos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
656	Memorando remisorio de PAC por áreas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
657	Memorando solicitando ajuste al POR	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
658	Memorando solicitando el traslado presupuestal que afecta los agregados (presupuesto de funcionamiento)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
659	Memorando solicitando el traslado presupuestal que no afecta los agregados	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
660	Memorando solicitando la reducción presupuestal.	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
661	Memorando solicitando la reprogramación de pagos de inversión y funcionamiento	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
662	Memorando solicitando liberación de una reserva presupuestal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
665	Memorandos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
666	Metodología Asignación de Costos y Gastos de los Proyectos de Renovación Urbana de Bogotá	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
667	Minuta escritura pública	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
668	NIT de la Unión Temporal o Consorcio 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
669	Nómina 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
670	Nomina adicional (copia) 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
671	Nota bancaria 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
672	Nota contable 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
674	Notificación a otros sujetos procesales	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
673	Notas a los Estados Contables	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
675	Notificación Auto inhibitorio	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
676	Notificación de la demanda	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
677	Notificación de la denuncia	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
678	Notificación de la querella	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
679	Notificación edicto	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
680	Notificación edicto Auto inhibitorio	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
681	Notificación edicto Verbal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
682	Notificación personal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
683	Novedades de encargos ( copia ) 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
684	Novedades de ingreso (copia)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
685	Novedades de licencias ( copia) 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
686	Novedades de prima técnica ( copia )	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
687	Novedades de retiros ( copia ) 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
688	Observaciones a la evaluación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
689	Observaciones al pliego definitivo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
690	Observaciones al proyecto de pliego de condiciones	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
691	Observaciones Proyecto Pliegos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
692	Ofertas 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
693	Oficio asignando la cuota global de gastos 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
695	Oficio enviando la información del cierre presupuestal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
694	Oficio CNB-1092	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
697	Oficio remisorio de la programación y justificación de ingresos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
698	Oficio remisorio de la proyección del servicio de la deuda	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
699	Oficio remisorio de las obligaciones contingentes por operaciones de crédito y otros contratos administrativos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
700	Oficio remisorio de los informes a la secretaría de hacienda	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
701	Oficio remisorio de los pasivos exigibles	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
702	Oficio remisorio de programación  mensual de pagos a tesorería Distrital	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
703	Oficio remisorio de reprogramación del PAC	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
782	Querella	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
704	Oficio remisorio del acto administrativo a las secretarias de Hacienda y Planeación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
705	Oficio remisorio del acto administrativo de traslado presupuestal a la Secretaria Distrital de Hacienda	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
706	Oficio remisorio del anteproyecto de presupuesto	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
707	Oficio remisorio del formulario de planta de personal con costos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
708	Oficio remisorio del plan financiero o el plan financiero plurianual	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
709	Oficio remisorio del proyecto de presupuesto al CONFIS y a la Secretaria Distrital de Hacienda	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
710	Oficio remitido por la secretaría Distrital de hacienda informando la reducción del presupuesto de la entidad	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
711	Oficios envío de anexos para escritura	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
713	Orden de pago 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
712	Orden de matrícula (cesantías para educación)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
714	Orden de trabajo para mantenimiento del vehículo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
715	Orden judicial para desvinculación del funcionario	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
716	Otro sí  adiciones  prórrogas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
717	Papeles de Trabajo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
718	Paz y Salvo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
719	paz y salvo de entrega del cargo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
720	Paz y salvo de entrega del carné	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
721	Paz y salvo de inventarios de bienes muebles a su cargo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
722	Paz y salvo de inventarios documentales	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
723	Paz y salvo expedido por el arrendador	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
724	Paz y Salvos Servicios Públicos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
726	Plan	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
727	Plan de acción Institucional 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
728	Plan de acción por áreas y/o procesos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
729	Plan de Auditoría 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
730	Plan de Capacitación 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
731	Plan de compras	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
732	Plan de comunicaciones	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
734	Plan de Gestión Social 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
735	Plan de mejoramiento	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
736	Plan de sensibilización para fomentar el autocontrol	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
737	Plan de ventas 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
738	Plan estratégico	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
739	Plan financiero	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
740	Plan financiero plurianual	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
742	Plan Lucha Anticorrupción y Atención al Ciudadano 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
743	Plan Operativo Anual de Inversiones POAI	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
744	Planilla	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
745	Planilla de comunicaciones devueltas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
746	Planilla de despacho de la comunicación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
747	Planilla de registro de backup de información	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
748	Pliego de Cargos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
749	Pliego de Condiciones definitivo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
750	Poder	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
751	Poder conferido	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
752	Política	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
753	Portafolio de proyectos y servicios	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
754	Preguntas y Respuestas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
755	Programa Anual Mensualizado de Caja PAC	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
756	Programa anual mensualizado de caja por áreas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
757	Programa de  Bienestar Social 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
758	Programa de factores de riesgos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
759	Programa de Seguridad y Salud en el trabajo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
761	Programación de la auditoría	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
762	Programación del presupuesto orientado a resultados POR	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
763	Programación del presupuesto orientado a resultados por centro de costo.	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
764	Programas de vigilancia epidemiológica	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
765	Promesa de Compraventa	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
766	Promesa de compraventa (cesantías para compra de vivienda)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
767	Promesa de compraventa o escritura pública no registrada	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
769	Propuesta de distribución de los excedentes financieros	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
768	Propuesta	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
770	Propuesta de productos inmobiliarios	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
771	Propuesta en caso de requerirse	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
772	Propuesta tabla de ventas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
773	Propuestas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
774	Providencia	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
775	Proyecto de Pliego de Condiciones-Prepliegos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
776	Proyecto de presupuesto	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
777	Proyecto Pliegos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
778	Pruebas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
779	Pruebas anexas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
783	Ratificación y ampliación de la queja	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
784	Recibo a satisfacción del trabajo realizado al vehículo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
785	Recibo de impuestos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
787	Recibo de pago de cesantías 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
786	Recibo de pago	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
788	Recibo de pago de impuesto del timbre 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
789	Recibo de pago de la publicación del contrato (Según cuantía)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
790	Recibo pago retefuente y derechos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
791	Recurso de apelación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
792	Recurso de apelación del quejoso	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
793	Recurso de reposición	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
794	Recurso de reposición y en subsidio apelación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
795	Recursos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
796	Registro audiovisual	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
797	Registro civil	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
800	Registro civil de nacimiento de los hijos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
799	Registro civil de matrimonio (cesantías para educación)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
801	Registro de actividades	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
803	Registro de afiliación a fondo de cesantías	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
802	Registro de afiliación a caja de compensación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
804	Registro de afiliación a fondo de pensiones	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
805	Registro de afiliación a salud	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
806	Registro de asistencia	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
842	Resolución aplazando las vacaciones	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
843	Resolución aprobación el  Plan de Capacitación (copia)	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
844	Resolución aprobando el plan de compras	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
845	Resolución autorizando el gasto para la comisión	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
848	Resolución autorizando o negando la comisión de servicios	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
850	Resolución autorizando o negando la licencia por paternidad o adopción	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
841	Resolución adoptando el Programa de Seguridad y Salud en el trabajo	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
846	Resolución autorizando las vacaciones	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
851	Resolución de aceptación de renuncia voluntaria	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
852	Resolución de Adjudicación	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
853	Resolución de adopción	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
854	Resolución de Apertura del proceso	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
855	Resolución de aprobación del CONFIS	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
856	Resolución de aprobación del presupuesto	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
859	Resolución de desvinculación del funcionario por decisión judicial	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
860	Resolución de desvinculación del funcionario por derecho de jubilación	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
857	Resolución de aprobación del presupuesto por el CONFIS	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
858	Resolución de aprobación del Programa de Bienestar Social (copia)	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
861	Resolución de desvinculación del funcionario por invalidez absoluta	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
862	Resolución de encargo	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
863	Resolución de encargo de un empleo o funcionario	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
866	Resolución de liquidación definitiva de prestaciones sociales	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
864	Resolución de insubsistencia abandono de cargo	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
867	Resolución de liquidación del presupuesto	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
868	Resolución de nombramiento	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
870	Resolución de reconocimiento de las cesantías e intereses anuales	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
871	Resolución de reconocimiento de prestaciones de los herederos	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
869	Resolución de reconocimiento de la pensión	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
872	Resolución de reducción presupuestal emitida por la entidad	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
873	Resolución de reducción presupuestal en la entidad	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
807	Registro de asistencia al Programa de Bienestar Social 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
808	Registro de asistencia de las actividades para mitigar el riesgo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
809	Registro de bienes y rentas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
810	Registro de consulta y préstamo de documentos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
811	Registro de Información Tributaria	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
812	Registro de matrimonio	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
814	Registro fotográfico	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
813	Registro del Comité Paritario del COPASO	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
815	Registro fotográfico de actividades de bienestar	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
816	Registro fotográfico de la diligencia	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
817	Registro fotográfico del predio	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
818	Registro interno de comunicaciones devueltas	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
819	Registro presupuestal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
820	Registro topográfico del predio	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
821	Registro Único de Reporte de Accidentes de Trabajo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
822	Registro Único Tributario	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
823	Registros de asistencia	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
824	Reglamento Fideicomiso	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
826	Relación de cuentas por cobrar	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
827	Relación de cuentas por pagar	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
828	Relación de descuento de salud 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
829	Relación de gastos esenciales	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
830	Relación de los funcionarios afiliados y valor acreditado 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
831	Relación de pago aportes parafiscales 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
832	Relación de reservas presupuéstales	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
833	Relación de saldos de los registros presupuéstales	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
834	Relación mensual de  descuentos 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
836	Reporte de inventario de los bienes devolutivos actuales 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
835	Relación tipificadas de bienes a dar de baja 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
837	Reporte de prestamos documentales vencidos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
838	Reporte visitas Intranet y pagina Web 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
839	Requerimiento	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
1	Acción	0	\N	0	1	1	1	1	0	0	0	0	0	1
245	Comunicación oficial de notificación de la resolución	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
876	Resolución de traslado presupuestal interno que no afecta los agregados	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
877	Resolución de traslado presupuestal que afecta los agregados	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
878	Resolución de traslado presupuestal que no afecta los agregados	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
879	Resolución de vacaciones	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
881	Resolución del CONFIS aprobando la reducción presupuestal	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
882	Resolución del proyecto de presupuesto	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
883	Resolución para dar de baja los bienes	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
884	Resolución que resuelve el recurso de apelación	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
885	Resolución resolviendo el recurso de reposición	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
886	Resolución suspendiendo las vacaciones	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
887	Respuesta a las observaciones al pliego	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
889	Respuesta a las observaciones del pliego definitivo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
50	Acta o Resolución de Adjudicación o Declaratoria Desierta	0	\N	0	1	1	1	1	0	0	0	0	1	1
875	Resolución de suspensión o aplazamiento presupuestal  emitida por la entidad 	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
890	Respuesta observaciones	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
893	Seguimiento al Plan de Acción	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
895	Sistema de información contractual	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
896	Solicitud	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
898	Solicitud de anulación de certificado de disponibilidad presupuestal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
899	Solicitud de anulación de registro presupuestal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
888	Respuesta a las observaciones al Prepliego	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
891	Resumen de Nomina 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
892	Resumen ejecutivo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
894	Sentencias	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
897	Solicitud autorización de pago	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
901	Solicitud de certificación laboral	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
900	Solicitud de Cancelación Oferta de Compra	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
902	Solicitud de certificado de compromiso presupuestal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
906	Solicitud de contratación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
907	Solicitud de documentos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
909	Solicitud de Inscripción de Oferta de Compra	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
903	Solicitud de Certificado de Disponibilidad Presupuestal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
905	Solicitud de consulta y préstamo de documentos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
908	Solicitud de ingreso de los bienes a almacén	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
910	Solicitud de licencia no remunerada	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
911	Solicitud de licencia por paternidad y adopción	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
912	Solicitud de permiso remunerado por haber sido jurado de votación 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
913	Solicitud de préstamo de bienes entre entidades (comodato)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
914	Solicitud de registro de disponibilidad presupuestal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
915	Solicitud de reparto Notarial	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
916	Solicitud de reprogramación del PAC	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
917	Solicitud de revocatoria directa	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
918	Solicitud de soporte y mantenimiento	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
919	Solicitud de suministro de gasolina	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
920	Solicitud de traslado o salida de bienes de almacén a servicio	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
921	Solicitud de traslados presupuéstales internos por centro de costos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
922	Solicitud del traslado de inventarios	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
924	Solicitud paz y salvos de servicios públicos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
923	Solicitud Efectivo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
925	Solicitud y asignación de servicios de mantenimiento correctivo de vehículos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
926	Solicitud y Legalización de Gastos de Caja Menor	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
927	Soporte de la Transacción	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
928	Soportes de contabilidad	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
929	Tabla de Egresos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
930	Tablas de predial e ICA	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
931	Tablas de retención documental	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
932	Tablas de valoración documental	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
934	Testimonio	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
935	Tres últimos recibos de pago de arriendo  por cada contrato	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
936	Verificación de requisitos habilitantes	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
937	Version libre	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
938	Votos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
23	Acta de escrutinio con número de votos a favor de cada candidato	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
44	Acta de reunión presentando los lineamientos para la programación presupuestal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
71	Acuerdo del concejo Distrital de archivos (aprobando las TRD) Copia	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
72	Acuerdo del concejo Distrital de archivos (aprobando las TVD) Copia	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
106	Auto decreta pruebas de indagación o investigación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
126	Autorización de descuento aportes voluntarios de pensiones	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
139	Certificación de inexistencia expedido por el Director Corporativo (contratos de prestación de servicios y de apoyo a la gestión)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
143	Certificación de pago de servicios públicos y/o telefonía móvil	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
157	Certificado de antecedentes disciplinarios de la Procuraduría General de la Nación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
179	Certificado del jefe de personal sobre la imposibilidad de atender el asunto objeto del contrato con personal de planta / inexistencia de personal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
226	Comunicación decreto pruebas sujeto procesal	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
240	Comunicación oficial de autorización para retiro de cesantías definitivas de los fondos privados	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
254	Comunicación oficial de notificación de la resolución resolviendo el recurso de reposición	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
266	Comunicación oficial emitida por el Confis  remitiendo la Resolución de aprobación de la reducción presupuestal.	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
279	Comunicación oficial remisoria del informe de Ejecución a Secretaría de Hacienda  Secretaría de Planeación y entes de control	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
316	Concepto sobre viabilidad para efectuar el traslado presupuestal interno por inversión	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
324	Consignación de Cuenta Bancaria	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
325	Consolidado movimientos de cuentas 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
334	Contrato de obra civil autenticada en notaria (cesantías para mejoras locativas)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
364	Declaración de Renta de los últimos dos (2) años	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
384	Documento convocando a las actividades del Programa de Seguridad y Salud Ocupacional	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
395	Documento de recolección de necesidades de Bienestar Social	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
394	Documento de notificación de la expedición de la certificación de salario para bono pensional	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
431	Estudio de permanencia de dotaciones	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
449	Evaluación de satisfacción del Programa de Bienestar Social 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
467	Ficha técnica de conciliación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
469	Fichas detalladas de perfiles de clientes	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
482	Formato de seguimiento a requerimientos de actualización Intranet y pagina Web CI-FT-055	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
511	Fotocopia de cédula de ciudadanía del representante legal (Entidad contratante)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
532	Hoja de vida del vehículo	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
534	Incapacidad por maternidad	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
536	Incapacidades Certificados para disminución de la base de retención en la fuente por concepto de salud prepagada 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
583	Informe Derechos de Autor  software- Dirección Nacional de Derechos de Autor	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
596	Informe preliminar de evaluación	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
606	Instrumento que detecte las deficiencias colectivas e individuales de capacitación 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
633	Listado de asistencia a los programas de capacitación (canales de ventas)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
655	Memorando informando a las áreas el cronograma para la proyección de los ingresos y gastos para la siguiente vigencia	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
663	Memorando solicitando relación de los bienes de consumo y devolutivos	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
664	Memorando solicitando suspensión o aplazamiento presupuestal que no afecta los agregados	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
696	Oficio notificando la aprobación a recomendaciones sobre el presupuesto	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
725	Piezas de comunicación promocional  y publicitaria 	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
733	Plan de emergencia	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
741	Plan institucional de gestión ambiental	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
760	Programación de ingresos propios (establecimientos públicos  empresas comerciales e industriales)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
798	Registro civil (hijos) (cesantías para educación)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
825	Relación de Comprobantes-Reembolso Mensual de Caja	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
840	Resolución	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
849	Resolución autorizando o negando la comisión para desempeñar un cargo de libre nombramiento y remoción	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
847	Resolución autorizando o negando la comisión de estudios	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
865	Resolución de insubsistencia del nombramiento de un empleado	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
874	Resolución de retiro del funcionario por no aprobación del periodo de prueba	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
880	Resolución de vacancia definitiva por fallecimiento del titular	0	\N	0	1	1	1	1	\N	0	0	\N	1	1
904	Solicitud de concepto sobre las modificaciones presupuéstales de inversión que afecten los agregados	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
933	Tasación de reconocimientos económicos adicionales (Indemnizaciones)	0	\N	0	1	1	1	1	\N	0	0	\N	\N	1
0	NO definido	0	0	 	0	0	0	1	0	0	0	0	0	0
939	SOPORTE	0	\N	0	1	1	1	1	0	0	0	0	0	1
940	PRUEBAS ARCHIVO	0	\N	0	0	0	0	1	\N	0	0	0	0	0
941	EXPEDIENTES DOCUMENTOS	0	\N	0	0	0	0	1	\N	0	0	0	0	0
942	EXPEDIENTE SOPORTE	0	\N	0	1	1	1	1	\N	0	0	0	0	1
943	PRUEBAS CAPACITACION ARCHIVO MODIFICADA	0	\N	0	0	1	0	1	0	0	0	1	0	0
946	ACTAS DE PRUEBA	0	\N	0	0	0	0	1	\N	0	0	0	0	1
944	PRUEBAS SUEÑO	0	\N	0	0	0	0	1	0	0	0	0	0	0
945	FUSIL	0	\N	0	0	0	1	1	0	0	0	0	0	1
947	DOCUMENTO TAREA	0	\N	0	0	0	0	1	\N	0	0	0	0	1
948	CITACIONES	0	\N	0	1	1	1	1	\N	0	0	0	0	0
949	PRUEBA ARCHIVO	0	\N	0	0	0	0	1	\N	0	0	0	0	0
952	ACTAS DE CONTRATOS 	0	\N	0	0	0	0	1	\N	0	0	0	0	1
950	GESTION DOCUMENTOS4	0	\N	0	1	0	0	1	0	0	0	0	0	0
951	CAJAS X 400	0	\N	0	0	0	1	1	0	0	0	0	0	0
953	ACTA DE CONTRATO ALEJANDRO	0	\N	0	0	0	0	1	0	0	0	0	0	0
954	BOMBAS CUMPLEAñOS	0	\N	0	1	0	0	1	\N	0	0	0	0	0
955	BOMBAS CON AGUA	0	\N	0	1	0	1	1	\N	0	0	0	0	0
956	ACATAS ALEJANDRO	0	\N	0	0	0	1	1	\N	0	0	0	0	0
957	CHEQUES POR AñO	0	\N	0	0	1	0	1	\N	0	0	0	0	0
\.


--
-- TOC entry 3027 (class 0 OID 18317)
-- Dependencies: 282
-- Data for Name: sgd_trad_tiporad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_trad_tiporad (sgd_trad_codigo, sgd_trad_descr, sgd_trad_icono, sgd_trad_genradsal) FROM stdin;
1	Salida	RadSalida.gif	1
2	Entrada	RadEntrada.gif	1
3	Memorando	RadInterna.gif	1
5	Resoluciones	RadInterna.gif	1
4	Transferencias	RadInterna.gif	1
9	Documentos de trabajo	RadInterna.gif	1
\.


--
-- TOC entry 3028 (class 0 OID 18325)
-- Dependencies: 283
-- Data for Name: sgd_ttr_transaccion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sgd_ttr_transaccion (sgd_ttr_codigo, sgd_ttr_descrip) FROM stdin;
61	Cambio de Etapa del Expediente
40	Firma Digital de Documento
41	Eliminacion solicitud de Firma Digital
50	Cambio de Estado Expediente
51	Creacion Expediente
1	Recuperacion Radicado
8	Informar
19	Cambiar Tipo de Documento
20	Crear Registro
21	Editar Registro
10	Movimiento entre Carpetas
7	Borrar Informado
13	Archivar
14	Agendar
15	Sacar de la agenda
0	--
16	Reasignar para Vo.Bo.
2	Radicacion
22	Digitalizacion de Radicado
23	Digitalizacion - Modificacion
24	Asociacion Imagen fax
30	Radicacion Masiva
17	Modificacion de Causal
18	Modificacion del Sector
25	Solicitud de Anulacion
26	Anulacion Rad
27	Rechazo de Anulacion
37	Cambio de Estado del Documento
28	Devolucion de correo
29	Digitalizacion de Anexo
31	Borrado de Anexo a radicado
32	Modificacion TRD
33	Eliminar TRD
35	Tipificacion de la decision
36	Cambio en la Notificacion
38	Cambio Vinculacion Documento
39	Solicitud de Firma
42	Digitalizacion Radicado(Asoc. Imagen Web)
60	Cambio seguridad Expediente
52	Excluir radicado de expediente
53	Incluir radicado en expediente
54	Cambio Seguridad del Documento
57	Ingreso al Archivo Fisico
65	Archivar NRR
55	Creación Subexpediente
56	Cambio de Responsable
58	Expediente Cerrado
59	Expediente Reabierto
90	Devolucion Correspondencia por No entrega de Fisico a tiempo
70	Edición de formulario
9	Enviado
12	Devuelto
11	Modificación Radicado
91	Anexo
\.


--
-- TOC entry 3029 (class 0 OID 18334)
-- Dependencies: 284
-- Data for Name: tipo_doc_identificacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipo_doc_identificacion (tdid_codi, tdid_desc) FROM stdin;
0	Cedula de Ciudadania
1	Tarjeta de Identidad
2	Cedula de Extranjeria
3	Pasaporte
4	Nit
5	Nuir
\.


--
-- TOC entry 3030 (class 0 OID 18337)
-- Dependencies: 285
-- Data for Name: tipo_remitente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipo_remitente (trte_codi, trte_desc) FROM stdin;
0	ENTIDAD
1	OTRA EMPRESA
2	PERSONA NATURAL
5	PREDIO
3	OTRO
\.


--
-- TOC entry 3031 (class 0 OID 18340)
-- Dependencies: 286
-- Data for Name: ubicacion_fisica; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ubicacion_fisica (ubic_depe_radi, ubic_depe_arch) FROM stdin;
\.


--
-- TOC entry 3032 (class 0 OID 18343)
-- Dependencies: 287
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY usuario (id, usua_codi, depe_codi, usua_login, usua_fech_crea, usua_pasw, usua_esta, usua_nomb, usua_admin, usua_nuevo, usua_doc, codi_nivel, usua_sesion, usua_fech_sesion, usua_ext, usua_nacim, usua_email, usua_at, usua_piso, usu_telefono1, id_pais, id_cont, sgd_rol_codigo, usua_email_1, usua_email_2) FROM stdin;
4	4	900	PRUEBAS200	2014-06-04 20:21:03	02cb962ac59075b964b07152d2	1	Pruebas200	0	0	4999999	1	FIN  2014:06:11 20:0650:32	2014-06-11 20:33:23.794507	\N	0001-02-03	pruebas200orfeo@midominio.com	\N	\N	\N	170	1	0	\N	\N
2	2	900	PRUEBAS100	2008-08-13 10:10:31.822753	02cb962ac59075b964b07152d2	1	Pruebas100 	1	0	2999999	1	40412084406o186116247141PRUEBA	2014-04-12 20:44:06.300562	\N	2008-05-09	pruebas100orfeo@midominio.com	\N	\N	\N	170	1	0	\N	\N
3	3	900	RADICADOR	2014-04-03 16:33:51	1521322cd50f15e9c3293b3b0f	1	Radicador	0	0	3999999	1	140723031526o19216810186RADICADOR	2014-07-23 15:15:26.542792	\N	\N	radicadororfeo@midominio.com	\N	\N	\N	170	1	1	\N	\N
1	1	900	ADMON	2007-09-21 00:00:00	27ccb0eea8a706c4c34a16891f	1	Administrador	1	1	1999999	5	FIN  2016:04:13 10:0451:37	2016-04-13 10:51:33.605501	1111	\N	admonorfeo@midominio.com	\N	4	\N	170	1	0	\N	\N
\.


--
-- TOC entry 3081 (class 0 OID 0)
-- Dependencies: 288
-- Name: usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('usuario_id_seq', 4, true);


--
-- TOC entry 2586 (class 2606 OID 18465)
-- Name: anex_pk_anex_codigo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY anexos
    ADD CONSTRAINT anex_pk_anex_codigo PRIMARY KEY (anex_codigo);


--
-- TOC entry 2589 (class 2606 OID 18467)
-- Name: anex_pk_anex_tipo_codi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY anexos_tipo
    ADD CONSTRAINT anex_pk_anex_tipo_codi PRIMARY KEY (anex_tipo_codi);


--
-- TOC entry 2595 (class 2606 OID 18485)
-- Name: carpetas_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY carpeta
    ADD CONSTRAINT carpetas_pk PRIMARY KEY (carp_codi);


--
-- TOC entry 2597 (class 2606 OID 18493)
-- Name: departamento_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY departamento
    ADD CONSTRAINT departamento_pk PRIMARY KEY (dpto_codi);


--
-- TOC entry 2602 (class 2606 OID 18495)
-- Name: dependencia_visibilidad_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dependencia_visibilidad
    ADD CONSTRAINT dependencia_visibilidad_pk PRIMARY KEY (codigo_visibilidad);


--
-- TOC entry 2604 (class 2606 OID 18497)
-- Name: estados_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estado
    ADD CONSTRAINT estados_pk PRIMARY KEY (esta_codi);


--
-- TOC entry 2709 (class 2606 OID 18505)
-- Name: pk_Parexp_Id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_parexp_paramexpediente
    ADD CONSTRAINT "pk_Parexp_Id" PRIMARY KEY (id);


--
-- TOC entry 2626 (class 2606 OID 18507)
-- Name: pk_anu_naludos; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_anu_anulados
    ADD CONSTRAINT pk_anu_naludos PRIMARY KEY (sgd_anu_id);


--
-- TOC entry 2593 (class 2606 OID 18509)
-- Name: pk_bodega_empresas_secue; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY bodega_empresas
    ADD CONSTRAINT pk_bodega_empresas_secue PRIMARY KEY (identificador_empresa);


--
-- TOC entry 2591 (class 2606 OID 18511)
-- Name: pk_constrain_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY autg_grupos
    ADD CONSTRAINT pk_constrain_id PRIMARY KEY (id);


--
-- TOC entry 2600 (class 2606 OID 18513)
-- Name: pk_depe; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dependencia
    ADD CONSTRAINT pk_depe PRIMARY KEY (depe_codi);


--
-- TOC entry 2608 (class 2606 OID 18517)
-- Name: pk_medio_recepcion; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY medio_recepcion
    ADD CONSTRAINT pk_medio_recepcion PRIMARY KEY (mrec_codi);


--
-- TOC entry 2611 (class 2606 OID 18519)
-- Name: pk_municipio; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY municipio
    ADD CONSTRAINT pk_municipio PRIMARY KEY (muni_codi, dpto_codi);


--
-- TOC entry 2613 (class 2606 OID 18521)
-- Name: pk_par_serv_servicios; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY par_serv_servicios
    ADD CONSTRAINT pk_par_serv_servicios PRIMARY KEY (par_serv_secue);


--
-- TOC entry 2615 (class 2606 OID 18525)
-- Name: pk_prestamo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY prestamo
    ADD CONSTRAINT pk_prestamo PRIMARY KEY (pres_id);


--
-- TOC entry 2622 (class 2606 OID 18527)
-- Name: pk_seri; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY series
    ADD CONSTRAINT pk_seri PRIMARY KEY (depe_codi, seri_tipo, seri_ano);


--
-- TOC entry 2624 (class 2606 OID 18531)
-- Name: pk_sgd_anar_anexarg; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_anar_anexarg
    ADD CONSTRAINT pk_sgd_anar_anexarg PRIMARY KEY (sgd_anar_codi);


--
-- TOC entry 2628 (class 2606 OID 18543)
-- Name: pk_sgd_argd_argdoc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_argd_argdoc
    ADD CONSTRAINT pk_sgd_argd_argdoc PRIMARY KEY (sgd_argd_codi);


--
-- TOC entry 2630 (class 2606 OID 18547)
-- Name: pk_sgd_camexp_campoexpediente; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_camexp_campoexpediente
    ADD CONSTRAINT pk_sgd_camexp_campoexpediente PRIMARY KEY (sgd_camexp_codigo);


--
-- TOC entry 2634 (class 2606 OID 18549)
-- Name: pk_sgd_cau_causal; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_cau_causal
    ADD CONSTRAINT pk_sgd_cau_causal PRIMARY KEY (sgd_cau_codigo);


--
-- TOC entry 2636 (class 2606 OID 18551)
-- Name: pk_sgd_caux_causales; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_caux_causales
    ADD CONSTRAINT pk_sgd_caux_causales PRIMARY KEY (sgd_caux_codigo);


--
-- TOC entry 2639 (class 2606 OID 18553)
-- Name: pk_sgd_ciu_ciudadano; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_ciu_ciudadano
    ADD CONSTRAINT pk_sgd_ciu_ciudadano PRIMARY KEY (sgd_ciu_codigo);


--
-- TOC entry 2641 (class 2606 OID 18555)
-- Name: pk_sgd_cob_campobliga; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_cob_campobliga
    ADD CONSTRAINT pk_sgd_cob_campobliga PRIMARY KEY (sgd_cob_codi);


--
-- TOC entry 2643 (class 2606 OID 18557)
-- Name: pk_sgd_dcau_causal; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_dcau_causal
    ADD CONSTRAINT pk_sgd_dcau_causal PRIMARY KEY (sgd_dcau_codigo);


--
-- TOC entry 2645 (class 2606 OID 18559)
-- Name: pk_sgd_ddca_ddsgrgdo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_ddca_ddsgrgdo
    ADD CONSTRAINT pk_sgd_ddca_ddsgrgdo PRIMARY KEY (sgd_ddca_codigo);


--
-- TOC entry 2647 (class 2606 OID 18561)
-- Name: pk_sgd_def_continentes; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_def_continentes
    ADD CONSTRAINT pk_sgd_def_continentes PRIMARY KEY (id_cont);


--
-- TOC entry 2649 (class 2606 OID 18563)
-- Name: pk_sgd_def_paises; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_def_paises
    ADD CONSTRAINT pk_sgd_def_paises PRIMARY KEY (id_pais);


--
-- TOC entry 2651 (class 2606 OID 18565)
-- Name: pk_sgd_deve; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_deve_dev_envio
    ADD CONSTRAINT pk_sgd_deve PRIMARY KEY (sgd_deve_codigo);


--
-- TOC entry 2655 (class 2606 OID 18567)
-- Name: pk_sgd_dir; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_dir_drecciones
    ADD CONSTRAINT pk_sgd_dir PRIMARY KEY (sgd_dir_codigo);


--
-- TOC entry 2657 (class 2606 OID 18569)
-- Name: pk_sgd_dnufe_docnufe; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_dnufe_docnufe
    ADD CONSTRAINT pk_sgd_dnufe_docnufe PRIMARY KEY (sgd_dnufe_codi);


--
-- TOC entry 2663 (class 2606 OID 18571)
-- Name: pk_sgd_empus_usuario; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_empus_empusuario
    ADD CONSTRAINT pk_sgd_empus_usuario PRIMARY KEY (sgd_empus_codigo);


--
-- TOC entry 2669 (class 2606 OID 18577)
-- Name: pk_sgd_fenv; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_fenv_frmenvio
    ADD CONSTRAINT pk_sgd_fenv PRIMARY KEY (sgd_fenv_codigo);


--
-- TOC entry 2671 (class 2606 OID 18579)
-- Name: pk_sgd_fexp_descrip; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_fexp_flujoexpedientes
    ADD CONSTRAINT pk_sgd_fexp_descrip PRIMARY KEY (sgd_fexp_codigo);


--
-- TOC entry 2673 (class 2606 OID 18581)
-- Name: pk_sgd_firrad_firmarads; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_firrad_firmarads
    ADD CONSTRAINT pk_sgd_firrad_firmarads PRIMARY KEY (sgd_firrad_id);


--
-- TOC entry 2675 (class 2606 OID 18583)
-- Name: pk_sgd_fun_funciones; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_fun_funciones
    ADD CONSTRAINT pk_sgd_fun_funciones PRIMARY KEY (sgd_fun_codigo);


--
-- TOC entry 2679 (class 2606 OID 18585)
-- Name: pk_sgd_hmtd_hismatdoc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_hmtd_hismatdoc
    ADD CONSTRAINT pk_sgd_hmtd_hismatdoc PRIMARY KEY (sgd_hmtd_codigo);


--
-- TOC entry 2684 (class 2606 OID 18589)
-- Name: pk_sgd_mat_matriz; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_mat_matriz
    ADD CONSTRAINT pk_sgd_mat_matriz PRIMARY KEY (sgd_mat_codigo);


--
-- TOC entry 2689 (class 2606 OID 18593)
-- Name: pk_sgd_mrd_matrird; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_mrd_matrird
    ADD CONSTRAINT pk_sgd_mrd_matrird PRIMARY KEY (sgd_mrd_codigo);


--
-- TOC entry 2693 (class 2606 OID 18597)
-- Name: pk_sgd_msg_mensaje; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_msg_mensaje
    ADD CONSTRAINT pk_sgd_msg_mensaje PRIMARY KEY (sgd_msg_codi);


--
-- TOC entry 2695 (class 2606 OID 18599)
-- Name: pk_sgd_mtd_matriz_doc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_mtd_matriz_doc
    ADD CONSTRAINT pk_sgd_mtd_matriz_doc PRIMARY KEY (sgd_mtd_codigo);


--
-- TOC entry 2697 (class 2606 OID 18601)
-- Name: pk_sgd_not; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_not_notificacion
    ADD CONSTRAINT pk_sgd_not PRIMARY KEY (sgd_not_codi);


--
-- TOC entry 2702 (class 2606 OID 18603)
-- Name: pk_sgd_oem_oempresas; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_oem_oempresas
    ADD CONSTRAINT pk_sgd_oem_oempresas PRIMARY KEY (sgd_oem_codigo);


--
-- TOC entry 2711 (class 2606 OID 18605)
-- Name: pk_sgd_pexp_procexpedientes; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_pexp_procexpedientes
    ADD CONSTRAINT pk_sgd_pexp_procexpedientes PRIMARY KEY (sgd_pexp_codigo);


--
-- TOC entry 2713 (class 2606 OID 18607)
-- Name: pk_sgd_pnufe_procnumfe; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_pnufe_procnumfe
    ADD CONSTRAINT pk_sgd_pnufe_procnumfe PRIMARY KEY (sgd_pnufe_codi);


--
-- TOC entry 2715 (class 2606 OID 18611)
-- Name: pk_sgd_prc_proceso; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_prc_proceso
    ADD CONSTRAINT pk_sgd_prc_proceso PRIMARY KEY (sgd_prc_codigo);


--
-- TOC entry 2717 (class 2606 OID 18613)
-- Name: pk_sgd_prd_prcdmentos; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_prd_prcdmentos
    ADD CONSTRAINT pk_sgd_prd_prcdmentos PRIMARY KEY (sgd_prd_codigo);


--
-- TOC entry 2721 (class 2606 OID 18615)
-- Name: pk_sgd_rmr_radmasivre; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_rmr_radmasivre
    ADD CONSTRAINT pk_sgd_rmr_radmasivre PRIMARY KEY (sgd_rmr_grupo, sgd_rmr_radi);


--
-- TOC entry 2723 (class 2606 OID 18617)
-- Name: pk_sgd_san_sancionados; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_san_sancionados
    ADD CONSTRAINT pk_sgd_san_sancionados PRIMARY KEY (sgd_san_ref);


--
-- TOC entry 2731 (class 2606 OID 18623)
-- Name: pk_sgd_srd_seriesrd; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_srd_seriesrd
    ADD CONSTRAINT pk_sgd_srd_seriesrd PRIMARY KEY (sgd_srd_codigo);


--
-- TOC entry 2735 (class 2606 OID 18625)
-- Name: pk_sgd_tdec_tipodecision; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_tdec_tipodecision
    ADD CONSTRAINT pk_sgd_tdec_tipodecision PRIMARY KEY (sgd_tdec_codigo);


--
-- TOC entry 2737 (class 2606 OID 18629)
-- Name: pk_sgd_tip_tipotercero; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_tip3_tipotercero
    ADD CONSTRAINT pk_sgd_tip_tipotercero PRIMARY KEY (sgd_tip3_codigo);


--
-- TOC entry 2739 (class 2606 OID 18631)
-- Name: pk_sgd_tma_temas; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_tma_temas
    ADD CONSTRAINT pk_sgd_tma_temas PRIMARY KEY (sgd_tma_codigo);


--
-- TOC entry 2741 (class 2606 OID 18633)
-- Name: pk_sgd_tme_tipmen; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_tme_tipmen
    ADD CONSTRAINT pk_sgd_tme_tipmen PRIMARY KEY (sgd_tme_codi);


--
-- TOC entry 2745 (class 2606 OID 18635)
-- Name: pk_sgd_tpr_tpdcumento; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_tpr_tpdcumento
    ADD CONSTRAINT pk_sgd_tpr_tpdcumento PRIMARY KEY (sgd_tpr_codigo);


--
-- TOC entry 2750 (class 2606 OID 18637)
-- Name: pk_sgd_ttr_transaccion; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_ttr_transaccion
    ADD CONSTRAINT pk_sgd_ttr_transaccion PRIMARY KEY (sgd_ttr_codigo);


--
-- TOC entry 2619 (class 2606 OID 18641)
-- Name: radicado_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY radicado
    ADD CONSTRAINT radicado_pk PRIMARY KEY (radi_nume_radi);


--
-- TOC entry 2632 (class 2606 OID 18643)
-- Name: sgd_carp_descripcion_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_carp_descripcion
    ADD CONSTRAINT sgd_carp_descripcion_pk PRIMARY KEY (sgd_carp_depecodi, sgd_carp_tiporad);


--
-- TOC entry 2659 (class 2606 OID 18647)
-- Name: sgd_einv_inventario_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_einv_inventario
    ADD CONSTRAINT sgd_einv_inventario_pk PRIMARY KEY (sgd_einv_codigo);


--
-- TOC entry 2661 (class 2606 OID 18649)
-- Name: sgd_eit_items_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_eit_items
    ADD CONSTRAINT sgd_eit_items_pk PRIMARY KEY (sgd_eit_codigo);


--
-- TOC entry 2667 (class 2606 OID 18651)
-- Name: sgd_exp_expediente_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_exp_expediente
    ADD CONSTRAINT sgd_exp_expediente_pk PRIMARY KEY (sgd_exp_numero, radi_nume_radi);


--
-- TOC entry 2677 (class 2606 OID 18653)
-- Name: sgd_hfld_histflujodoc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_hfld_histflujodoc
    ADD CONSTRAINT sgd_hfld_histflujodoc_pkey PRIMARY KEY (id);


--
-- TOC entry 2681 (class 2606 OID 18655)
-- Name: sgd_masiva_codigo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_masiva_excel
    ADD CONSTRAINT sgd_masiva_codigo PRIMARY KEY (sgd_masiva_codigo);


--
-- TOC entry 2700 (class 2606 OID 18659)
-- Name: sgd_novedad_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_novedad_usuario
    ADD CONSTRAINT sgd_novedad_usuario_pkey PRIMARY KEY (usua_doc);


--
-- TOC entry 2705 (class 2606 OID 18661)
-- Name: sgd_param_admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_param_admin
    ADD CONSTRAINT sgd_param_admin_pkey PRIMARY KEY (param_codigo);


--
-- TOC entry 2707 (class 2606 OID 18663)
-- Name: sgd_parametro_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_parametro
    ADD CONSTRAINT sgd_parametro_pk PRIMARY KEY (param_nomb, param_codi);


--
-- TOC entry 2728 (class 2606 OID 18665)
-- Name: sgd_sexp_secexpedientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_sexp_secexpedientes
    ADD CONSTRAINT sgd_sexp_secexpedientes_pkey PRIMARY KEY (id);


--
-- TOC entry 2747 (class 2606 OID 18671)
-- Name: sgd_trad_tiporad_codigo_inx; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_trad_tiporad
    ADD CONSTRAINT sgd_trad_tiporad_codigo_inx PRIMARY KEY (sgd_trad_codigo);


--
-- TOC entry 2752 (class 2606 OID 18675)
-- Name: tipo_doc_identificacion_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_doc_identificacion
    ADD CONSTRAINT tipo_doc_identificacion_pk PRIMARY KEY (tdid_codi);


--
-- TOC entry 2754 (class 2606 OID 18677)
-- Name: tipo_remitente_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_remitente
    ADD CONSTRAINT tipo_remitente_pk PRIMARY KEY (trte_codi);


--
-- TOC entry 2686 (class 2606 OID 18681)
-- Name: uk_sgd_mat; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_mat_matriz
    ADD CONSTRAINT uk_sgd_mat UNIQUE (depe_codi, sgd_fun_codigo, sgd_prc_codigo, sgd_prd_codigo);


--
-- TOC entry 2691 (class 2606 OID 18683)
-- Name: uk_sgd_mrd_matrird; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_mrd_matrird
    ADD CONSTRAINT uk_sgd_mrd_matrird UNIQUE (depe_codi, sgd_srd_codigo, sgd_sbrd_codigo, sgd_tpr_codigo);


--
-- TOC entry 2719 (class 2606 OID 18685)
-- Name: uk_sgd_rdf_retdocf; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_rdf_retdocf
    ADD CONSTRAINT uk_sgd_rdf_retdocf UNIQUE (radi_nume_radi, depe_codi, sgd_mrd_codigo);


--
-- TOC entry 2733 (class 2606 OID 18687)
-- Name: uk_sgd_srd_descrip; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_srd_seriesrd
    ADD CONSTRAINT uk_sgd_srd_descrip UNIQUE (sgd_srd_descrip);


--
-- TOC entry 2758 (class 2606 OID 18689)
-- Name: unique_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT unique_id UNIQUE (id);


--
-- TOC entry 2760 (class 2606 OID 18691)
-- Name: unique_usua_login; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT unique_usua_login UNIQUE (usua_login);


--
-- TOC entry 2762 (class 2606 OID 18693)
-- Name: usuario_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_pk PRIMARY KEY (id);


--
-- TOC entry 2764 (class 2606 OID 18695)
-- Name: usuario_uk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_uk UNIQUE (usua_codi, depe_codi);


--
-- TOC entry 2587 (class 1259 OID 18707)
-- Name: idxAnexos; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idxAnexos" ON anexos USING btree (anex_radi_nume, anex_codigo, anex_fech_anex);


--
-- TOC entry 2652 (class 1259 OID 18708)
-- Name: idxDirDrecciones; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idxDirDrecciones" ON sgd_dir_drecciones USING btree (sgd_dir_codigo, sgd_trd_codigo, radi_nume_radi);


--
-- TOC entry 2616 (class 1259 OID 18709)
-- Name: idxRadicado; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idxRadicado" ON radicado USING btree (radi_nume_radi, radi_fech_radi, tdoc_codi);


--
-- TOC entry 2664 (class 1259 OID 18710)
-- Name: idxSgdExpediente; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idxSgdExpediente" ON sgd_exp_expediente USING btree (sgd_exp_numero, radi_nume_radi, sgd_exp_estado);


--
-- TOC entry 2605 (class 1259 OID 18711)
-- Name: idx_RadiUsuaDoc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_RadiUsuaDoc" ON hist_eventos USING btree (radi_nume_radi, usua_doc);


--
-- TOC entry 2755 (class 1259 OID 18712)
-- Name: idx_UsuarioUsuaDoc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_UsuarioUsuaDoc" ON usuario USING btree (usua_doc, usua_esta, depe_codi, usua_codi);


--
-- TOC entry 2637 (class 1259 OID 18713)
-- Name: idx_ciuCodigo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_ciuCodigo" ON sgd_ciu_ciudadano USING btree (sgd_ciu_codigo, sgd_ciu_cedula, sgd_ciu_nombre, sgd_ciu_apell1, sgd_ciu_apell2);


--
-- TOC entry 2598 (class 1259 OID 18714)
-- Name: idx_deptoCodi; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_deptoCodi" ON departamento USING btree (dpto_codi, id_pais, id_cont);


--
-- TOC entry 2665 (class 1259 OID 18715)
-- Name: idx_expNumeroDepeUsuaMuni; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_expNumeroDepeUsuaMuni" ON sgd_exp_expediente USING btree (sgd_exp_numero, radi_nume_radi, depe_codi, usua_codi, usua_doc, sgd_exp_estado);


--
-- TOC entry 2606 (class 1259 OID 18716)
-- Name: idx_histEventos; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_histEventos" ON hist_eventos USING btree (radi_nume_radi, hist_fech, depe_codi, usua_codi, sgd_ttr_codigo);


--
-- TOC entry 2682 (class 1259 OID 18717)
-- Name: idx_matCodigo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_matCodigo" ON sgd_mat_matriz USING btree (sgd_mat_codigo, sgd_prd_codigo);


--
-- TOC entry 2687 (class 1259 OID 18718)
-- Name: idx_mrd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_mrd ON sgd_mrd_matrird USING btree (sgd_mrd_codigo, depe_codi, depe_codi_aplica, sgd_srd_codigo, sgd_sbrd_codigo, sgd_mrd_esta);


--
-- TOC entry 2609 (class 1259 OID 18719)
-- Name: idx_municipio; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_municipio ON municipio USING btree (dpto_codi, muni_codi, id_cont, id_pais);


--
-- TOC entry 2698 (class 1259 OID 18720)
-- Name: idx_novedad_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_novedad_usuario ON sgd_novedad_usuario USING btree (usua_doc);


--
-- TOC entry 2703 (class 1259 OID 18721)
-- Name: idx_param_admin; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_param_admin ON sgd_param_admin USING btree (param_codigo);


--
-- TOC entry 2653 (class 1259 OID 18722)
-- Name: idx_radiTipoName; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_radiTipoName" ON sgd_dir_drecciones USING btree (radi_nume_radi, sgd_dir_tipo, muni_codi, dpto_codi);


--
-- TOC entry 2617 (class 1259 OID 18723)
-- Name: idx_radicadoCarpetas; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_radicadoCarpetas" ON radicado USING btree (radi_nume_radi, carp_codi, carp_per);


--
-- TOC entry 2724 (class 1259 OID 18724)
-- Name: idx_sbrd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sbrd ON sgd_sbrd_subserierd USING btree (sgd_srd_codigo, sgd_sbrd_codigo, sgd_sbrd_fechini, sgd_sbrd_fechfin, sgd_sbrd_procedi);


--
-- TOC entry 2725 (class 1259 OID 18725)
-- Name: idx_sexp; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sexp ON sgd_sexp_secexpedientes USING btree (sgd_exp_numero, sgd_srd_codigo, sgd_sbrd_codigo, sgd_pexp_codigo, sgd_sexp_fech);


--
-- TOC entry 2729 (class 1259 OID 18726)
-- Name: idx_srdCodi; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_srdCodi" ON sgd_srd_seriesrd USING btree (sgd_srd_codigo, sgd_srd_fechini, sgd_srd_fechfin);


--
-- TOC entry 2742 (class 1259 OID 18727)
-- Name: idx_tpr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_tpr ON sgd_tpr_tpdcumento USING btree (sgd_tpr_codigo, sgd_tpr_estado);


--
-- TOC entry 2743 (class 1259 OID 18728)
-- Name: idx_tprCodigoName; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_tprCodigoName" ON sgd_tpr_tpdcumento USING btree (sgd_tpr_codigo, sgd_tpr_estado);


--
-- TOC entry 2748 (class 1259 OID 18729)
-- Name: idx_ttr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ttr ON sgd_ttr_transaccion USING btree (sgd_ttr_codigo);


--
-- TOC entry 2756 (class 1259 OID 18730)
-- Name: idx_usuaCodi; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_usuaCodi" ON usuario USING btree (usua_codi, depe_codi, usua_esta);


--
-- TOC entry 2726 (class 1259 OID 18731)
-- Name: ndx_numero_fexp; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ndx_numero_fexp ON sgd_sexp_secexpedientes USING btree (sgd_fexp_codigo, sgd_exp_numero);


--
-- TOC entry 2620 (class 1259 OID 18733)
-- Name: radicado_radi_nume_radi_ra_asun_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX radicado_radi_nume_radi_ra_asun_idx ON radicado USING btree (radi_nume_radi, ra_asun);


--
-- TOC entry 2765 (class 2606 OID 18769)
-- Name: fk_depe_padre; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dependencia
    ADD CONSTRAINT fk_depe_padre FOREIGN KEY (depe_codi_padre) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2766 (class 2606 OID 18774)
-- Name: fk_hist_depe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY hist_eventos
    ADD CONSTRAINT fk_hist_depe FOREIGN KEY (depe_codi) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2767 (class 2606 OID 18779)
-- Name: fk_info_depe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY informados
    ADD CONSTRAINT fk_info_depe FOREIGN KEY (depe_codi) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2768 (class 2606 OID 18784)
-- Name: fk_municipi_ref_128_departam; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY municipio
    ADD CONSTRAINT fk_municipi_ref_128_departam FOREIGN KEY (dpto_codi) REFERENCES departamento(dpto_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2783 (class 2606 OID 18789)
-- Name: fk_paises_continentes; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_def_paises
    ADD CONSTRAINT fk_paises_continentes FOREIGN KEY (id_cont) REFERENCES sgd_def_continentes(id_cont) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2769 (class 2606 OID 18794)
-- Name: fk_prestamo_depe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY prestamo
    ADD CONSTRAINT fk_prestamo_depe FOREIGN KEY (depe_codi) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2770 (class 2606 OID 18799)
-- Name: fk_prestamo_depe_arch; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY prestamo
    ADD CONSTRAINT fk_prestamo_depe_arch FOREIGN KEY (pres_depe_arch) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2771 (class 2606 OID 18809)
-- Name: fk_radi_esta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY radicado
    ADD CONSTRAINT fk_radi_esta FOREIGN KEY (esta_codi) REFERENCES estado(esta_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2772 (class 2606 OID 18814)
-- Name: fk_radi_mrec; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY radicado
    ADD CONSTRAINT fk_radi_mrec FOREIGN KEY (mrec_codi) REFERENCES medio_recepcion(mrec_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2773 (class 2606 OID 18819)
-- Name: fk_radi_muni; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY radicado
    ADD CONSTRAINT fk_radi_muni FOREIGN KEY (muni_codi, dpto_codi) REFERENCES municipio(muni_codi, dpto_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2777 (class 2606 OID 18824)
-- Name: fk_radicado_nume; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_anu_anulados
    ADD CONSTRAINT fk_radicado_nume FOREIGN KEY (radi_nume_radi) REFERENCES radicado(radi_nume_radi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2774 (class 2606 OID 18829)
-- Name: fk_radicado_par_serv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY radicado
    ADD CONSTRAINT fk_radicado_par_serv FOREIGN KEY (par_serv_secue) REFERENCES par_serv_servicios(par_serv_secue) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2807 (class 2606 OID 18834)
-- Name: fk_sexp_secexp_pexp_codigo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_sexp_secexpedientes
    ADD CONSTRAINT fk_sexp_secexp_pexp_codigo FOREIGN KEY (sgd_pexp_codigo) REFERENCES sgd_pexp_procexpedientes(sgd_pexp_codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2776 (class 2606 OID 18839)
-- Name: fk_sgd_anar_anexos; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_anar_anexarg
    ADD CONSTRAINT fk_sgd_anar_anexos FOREIGN KEY (anex_codigo) REFERENCES anexos(anex_codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2779 (class 2606 OID 18854)
-- Name: fk_sgd_caux_radicado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_caux_causales
    ADD CONSTRAINT fk_sgd_caux_radicado FOREIGN KEY (radi_nume_radi) REFERENCES radicado(radi_nume_radi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2780 (class 2606 OID 18859)
-- Name: fk_sgd_dcau_sgd_cau_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_dcau_causal
    ADD CONSTRAINT fk_sgd_dcau_sgd_cau_ FOREIGN KEY (sgd_cau_codigo) REFERENCES sgd_cau_causal(sgd_cau_codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2781 (class 2606 OID 18864)
-- Name: fk_sgd_ddca_ref_678_par_serv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_ddca_ddsgrgdo
    ADD CONSTRAINT fk_sgd_ddca_ref_678_par_serv FOREIGN KEY (par_serv_secue) REFERENCES par_serv_servicios(par_serv_secue) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2782 (class 2606 OID 18869)
-- Name: fk_sgd_ddca_sgd_dcau; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_ddca_ddsgrgdo
    ADD CONSTRAINT fk_sgd_ddca_sgd_dcau FOREIGN KEY (sgd_dcau_codigo) REFERENCES sgd_dcau_causal(sgd_dcau_codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2784 (class 2606 OID 18874)
-- Name: fk_sgd_dir_municipio; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_dir_drecciones
    ADD CONSTRAINT fk_sgd_dir_municipio FOREIGN KEY (muni_codi, dpto_codi) REFERENCES municipio(muni_codi, dpto_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2785 (class 2606 OID 18879)
-- Name: fk_sgd_dir_radicado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_dir_drecciones
    ADD CONSTRAINT fk_sgd_dir_radicado FOREIGN KEY (radi_nume_radi) REFERENCES radicado(radi_nume_radi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2786 (class 2606 OID 18884)
-- Name: fk_sgd_dir_sgd_ciu; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_dir_drecciones
    ADD CONSTRAINT fk_sgd_dir_sgd_ciu FOREIGN KEY (sgd_ciu_codigo) REFERENCES sgd_ciu_ciudadano(sgd_ciu_codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2787 (class 2606 OID 18889)
-- Name: fk_sgd_dnufe_anex_tipo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_dnufe_docnufe
    ADD CONSTRAINT fk_sgd_dnufe_anex_tipo FOREIGN KEY (anex_tipo_codi) REFERENCES anexos_tipo(anex_tipo_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2788 (class 2606 OID 18899)
-- Name: fk_sgd_exp_dependencia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_exp_expediente
    ADD CONSTRAINT fk_sgd_exp_dependencia FOREIGN KEY (depe_codi) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2789 (class 2606 OID 18904)
-- Name: fk_sgd_exp_radicado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_exp_expediente
    ADD CONSTRAINT fk_sgd_exp_radicado FOREIGN KEY (radi_nume_radi) REFERENCES radicado(radi_nume_radi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2790 (class 2606 OID 18909)
-- Name: fk_sgd_firr_ref_82_radicado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_firrad_firmarads
    ADD CONSTRAINT fk_sgd_firr_ref_82_radicado FOREIGN KEY (radi_nume_radi) REFERENCES radicado(radi_nume_radi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2791 (class 2606 OID 18914)
-- Name: fk_sgd_hmtd_depe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_hmtd_hismatdoc
    ADD CONSTRAINT fk_sgd_hmtd_depe FOREIGN KEY (depe_codi) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2792 (class 2606 OID 18919)
-- Name: fk_sgd_hmtd_radicado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_hmtd_hismatdoc
    ADD CONSTRAINT fk_sgd_hmtd_radicado FOREIGN KEY (radi_nume_radi) REFERENCES radicado(radi_nume_radi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2793 (class 2606 OID 18929)
-- Name: fk_sgd_mat_depe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_mat_matriz
    ADD CONSTRAINT fk_sgd_mat_depe FOREIGN KEY (depe_codi) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2794 (class 2606 OID 18934)
-- Name: fk_sgd_mat_sgd_fun; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_mat_matriz
    ADD CONSTRAINT fk_sgd_mat_sgd_fun FOREIGN KEY (sgd_fun_codigo) REFERENCES sgd_fun_funciones(sgd_fun_codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2795 (class 2606 OID 18939)
-- Name: fk_sgd_mrd_depe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_mrd_matrird
    ADD CONSTRAINT fk_sgd_mrd_depe FOREIGN KEY (depe_codi) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2796 (class 2606 OID 18944)
-- Name: fk_sgd_msde_ref_27_dependen; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_msdep_msgdep
    ADD CONSTRAINT fk_sgd_msde_ref_27_dependen FOREIGN KEY (depe_codi) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2797 (class 2606 OID 18949)
-- Name: fk_sgd_mtd_sgd_mtd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_mtd_matriz_doc
    ADD CONSTRAINT fk_sgd_mtd_sgd_mtd FOREIGN KEY (sgd_mat_codigo) REFERENCES sgd_mat_matriz(sgd_mat_codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2798 (class 2606 OID 18954)
-- Name: fk_sgd_ntrd_notifrad_radicado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_ntrd_notifrad
    ADD CONSTRAINT fk_sgd_ntrd_notifrad_radicado FOREIGN KEY (radi_nume_radi) REFERENCES radicado(radi_nume_radi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2799 (class 2606 OID 18959)
-- Name: fk_sgd_oem_municipio; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_oem_oempresas
    ADD CONSTRAINT fk_sgd_oem_municipio FOREIGN KEY (muni_codi, dpto_codi) REFERENCES municipio(muni_codi, dpto_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2800 (class 2606 OID 18964)
-- Name: fk_sgd_pnun_depe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_pnun_procenum
    ADD CONSTRAINT fk_sgd_pnun_depe FOREIGN KEY (depe_codi) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2801 (class 2606 OID 18969)
-- Name: fk_sgd_pnun_sgd_pnufe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_pnun_procenum
    ADD CONSTRAINT fk_sgd_pnun_sgd_pnufe FOREIGN KEY (sgd_pnufe_codi) REFERENCES sgd_pnufe_procnumfe(sgd_pnufe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2802 (class 2606 OID 18974)
-- Name: fk_sgd_rdf_depe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_rdf_retdocf
    ADD CONSTRAINT fk_sgd_rdf_depe FOREIGN KEY (depe_codi) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2803 (class 2606 OID 18979)
-- Name: fk_sgd_rdf_trd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_rdf_retdocf
    ADD CONSTRAINT fk_sgd_rdf_trd FOREIGN KEY (sgd_mrd_codigo) REFERENCES sgd_mrd_matrird(sgd_mrd_codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2804 (class 2606 OID 18984)
-- Name: fk_sgd_renv_dependecia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_renv_regenvio
    ADD CONSTRAINT fk_sgd_renv_dependecia FOREIGN KEY (depe_codi) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2805 (class 2606 OID 18989)
-- Name: fk_sgd_renv_sgd_deve; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_renv_regenvio
    ADD CONSTRAINT fk_sgd_renv_sgd_deve FOREIGN KEY (sgd_deve_codigo) REFERENCES sgd_deve_dev_envio(sgd_deve_codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2806 (class 2606 OID 18994)
-- Name: fk_sgd_renv_sgd_dir; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_renv_regenvio
    ADD CONSTRAINT fk_sgd_renv_sgd_dir FOREIGN KEY (sgd_dir_codigo) REFERENCES sgd_dir_drecciones(sgd_dir_codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2808 (class 2606 OID 19004)
-- Name: fk_sgd_tma_depe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_tma_temas
    ADD CONSTRAINT fk_sgd_tma_depe FOREIGN KEY (depe_codi) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2809 (class 2606 OID 19009)
-- Name: fk_sgd_tma_sgd_prc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_tma_temas
    ADD CONSTRAINT fk_sgd_tma_sgd_prc FOREIGN KEY (sgd_prc_codigo) REFERENCES sgd_prc_proceso(sgd_prc_codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2810 (class 2606 OID 19019)
-- Name: fk_usua_depe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT fk_usua_depe FOREIGN KEY (depe_codi) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2775 (class 2606 OID 19024)
-- Name: sgd_agen_agendados_r01; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_agen_agendados
    ADD CONSTRAINT sgd_agen_agendados_r01 FOREIGN KEY (radi_nume_radi) REFERENCES radicado(radi_nume_radi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2778 (class 2606 OID 19034)
-- Name: sgd_carp_descripcion_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_carp_descripcion
    ADD CONSTRAINT sgd_carp_descripcion_fk1 FOREIGN KEY (sgd_carp_depecodi) REFERENCES dependencia(depe_codi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3040 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- TOC entry 3042 (class 0 OID 0)
-- Dependencies: 180
-- Name: anexos; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE anexos FROM PUBLIC;
REVOKE ALL ON TABLE anexos FROM postgres;
GRANT ALL ON TABLE anexos TO postgres;


-- Completed on 2016-04-13 11:36:54 COT

--
-- PostgreSQL database dump complete
--

