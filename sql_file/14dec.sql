--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.1)

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
-- Name: inventory_productcategorymaster; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_productcategorymaster (
    product_cat_id integer NOT NULL,
    product_type character varying(20) NOT NULL,
    product_cat_name character varying(250) NOT NULL
);


ALTER TABLE public.inventory_productcategorymaster OWNER TO postgres;

--
-- Name: inventory_productcompanymaster; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_productcompanymaster (
    product_com_id integer NOT NULL,
    product_com_name character varying(250) NOT NULL,
    product_cat_id integer NOT NULL
);


ALTER TABLE public.inventory_productcompanymaster OWNER TO postgres;

--
-- Name: inventory_productdetails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_productdetails (
    product_id integer NOT NULL,
    product_serialno character varying(250) NOT NULL,
    entry_date date NOT NULL,
    initial_quantity integer NOT NULL,
    current_quantity integer NOT NULL,
    cartridge_toner character varying(250) NOT NULL,
    remarks character varying(300) NOT NULL,
    product_new_or_open character varying(20) NOT NULL,
    product_mod_id integer NOT NULL,
    propur_id integer NOT NULL
);


ALTER TABLE public.inventory_productdetails OWNER TO postgres;

--
-- Name: inventory_productmodelmaster; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_productmodelmaster (
    product_mod_id integer NOT NULL,
    product_mod_name character varying(250) NOT NULL,
    product_com_id integer NOT NULL
);


ALTER TABLE public.inventory_productmodelmaster OWNER TO postgres;

--
-- Name: completeproductdetail; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.completeproductdetail AS
 SELECT a.product_cat_id,
    a.product_type,
    a.product_cat_name,
    b.product_com_id,
    b.product_com_name,
    c.product_mod_id,
    c.product_mod_name,
    d.product_id,
    d.product_serialno,
    d.entry_date,
    d.current_quantity,
    d.cartridge_toner,
    d.remarks,
    d.product_new_or_open,
    d.propur_id
   FROM public.inventory_productcategorymaster a,
    public.inventory_productcompanymaster b,
    public.inventory_productmodelmaster c,
    public.inventory_productdetails d
  WHERE ((d.product_mod_id = c.product_mod_id) AND (c.product_com_id = b.product_com_id) AND (b.product_cat_id = a.product_cat_id));


ALTER TABLE public.completeproductdetail OWNER TO postgres;

--
-- Name: inventory_employee_journey; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_employee_journey (
    emp_jou_id integer NOT NULL,
    doj date NOT NULL,
    dot date NOT NULL,
    current_status character varying(10) NOT NULL,
    sdm_id integer NOT NULL,
    usr_id integer NOT NULL,
    verified character varying(10) NOT NULL,
    pawatidoc character varying(100) NOT NULL
);


ALTER TABLE public.inventory_employee_journey OWNER TO postgres;

--
-- Name: inventory_producttransactiondetails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_producttransactiondetails (
    pro_trans_id integer NOT NULL,
    trans_flag integer NOT NULL,
    no_of_item_issue integer NOT NULL,
    issue_remarks character varying(250) NOT NULL,
    trans_return_date date NOT NULL,
    no_of_item_return integer NOT NULL,
    return_remarks character varying(250) NOT NULL,
    return_received_status character varying(3) NOT NULL,
    productid_id integer NOT NULL,
    trans_id integer NOT NULL
);


ALTER TABLE public.inventory_producttransactiondetails OWNER TO postgres;

--
-- Name: inventory_sectiondesignationmapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_sectiondesignationmapper (
    sdm_id integer NOT NULL,
    section_id integer NOT NULL,
    staff_id integer NOT NULL,
    ip_address character varying(250) NOT NULL
);


ALTER TABLE public.inventory_sectiondesignationmapper OWNER TO postgres;

--
-- Name: inventory_sectiondetails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_sectiondetails (
    section_id integer NOT NULL,
    section_type character varying(10) NOT NULL,
    section_name character varying(250) NOT NULL,
    floor character varying(250) NOT NULL,
    roomno character varying(250) NOT NULL,
    landmark character varying(250) NOT NULL,
    deleted boolean NOT NULL,
    building_id integer NOT NULL
);


ALTER TABLE public.inventory_sectiondetails OWNER TO postgres;

--
-- Name: inventory_staffdesignationmaster; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_staffdesignationmaster (
    staff_id integer NOT NULL,
    staff_des_name character varying(250) NOT NULL,
    staff_type character varying(10) NOT NULL
);


ALTER TABLE public.inventory_staffdesignationmaster OWNER TO postgres;

--
-- Name: inventory_transactiondetails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_transactiondetails (
    trans_id integer NOT NULL,
    trans_issue_date date NOT NULL,
    issue_received_status character varying(3) NOT NULL,
    sdm_id integer NOT NULL
);


ALTER TABLE public.inventory_transactiondetails OWNER TO postgres;

--
-- Name: inventory_userdetails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_userdetails (
    usr_id integer NOT NULL,
    usr_name character varying(250) NOT NULL,
    usr_mobile character varying(250) NOT NULL,
    entry_date date NOT NULL,
    usr_type character varying(10) NOT NULL,
    deleted boolean NOT NULL
);


ALTER TABLE public.inventory_userdetails OWNER TO postgres;

--
-- Name: alldetails; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.alldetails AS
 SELECT a.trans_issue_date,
    a.issue_received_status,
    b.pro_trans_id,
    b.trans_flag,
    b.no_of_item_issue,
    b.issue_remarks,
    b.trans_return_date,
    b.no_of_item_return,
    b.return_remarks,
    b.return_received_status,
    b.productid_id,
    c.product_cat_id,
    c.product_type,
    c.product_cat_name,
    c.product_com_id,
    c.product_com_name,
    c.product_mod_id,
    c.product_mod_name,
    c.product_id,
    c.product_serialno,
    c.current_quantity,
    c.cartridge_toner,
    c.remarks,
    c.product_new_or_open,
    c.propur_id,
    d.ip_address,
    e.section_type,
    e.section_name,
    e.floor,
    e.roomno,
    e.landmark,
    e.building_id,
    f.staff_des_name,
    f.staff_type,
    g.emp_jou_id,
    g.doj,
    g.dot,
    g.current_status,
    h.usr_name,
    h.usr_mobile,
    h.usr_type,
    d.sdm_id,
    e.section_id,
    h.usr_id
   FROM public.inventory_transactiondetails a,
    public.inventory_producttransactiondetails b,
    public.completeproductdetail c,
    public.inventory_sectiondesignationmapper d,
    public.inventory_sectiondetails e,
    public.inventory_staffdesignationmaster f,
    public.inventory_employee_journey g,
    public.inventory_userdetails h
  WHERE ((a.trans_id = b.trans_id) AND (b.productid_id = c.product_id) AND (a.sdm_id = d.sdm_id) AND (d.section_id = e.section_id) AND (d.staff_id = f.staff_id) AND (a.sdm_id = g.sdm_id) AND (d.sdm_id = g.sdm_id) AND (g.usr_id = h.usr_id) AND (b.trans_flag = 0))
  ORDER BY c.product_serialno DESC;


ALTER TABLE public.alldetails OWNER TO postgres;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO postgres;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: inventory_buildingmaster; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_buildingmaster (
    building_id integer NOT NULL,
    building_name character varying(250) NOT NULL,
    est_id integer NOT NULL
);


ALTER TABLE public.inventory_buildingmaster OWNER TO postgres;

--
-- Name: inventory_buildingmaster_building_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inventory_buildingmaster ALTER COLUMN building_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.inventory_buildingmaster_building_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inventory_courtestablishmentmaster; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_courtestablishmentmaster (
    est_id integer NOT NULL,
    est_name character varying(250) NOT NULL
);


ALTER TABLE public.inventory_courtestablishmentmaster OWNER TO postgres;

--
-- Name: inventory_courtestablishmentmaster_est_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inventory_courtestablishmentmaster ALTER COLUMN est_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.inventory_courtestablishmentmaster_est_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inventory_employee_journey_emp_jou_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inventory_employee_journey ALTER COLUMN emp_jou_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.inventory_employee_journey_emp_jou_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inventory_healthstatusdetails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_healthstatusdetails (
    health_id integer NOT NULL,
    product_healthy character varying(10) NOT NULL,
    health_remarks character varying(250) NOT NULL,
    product_status character varying(50) NOT NULL,
    status_date date NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE public.inventory_healthstatusdetails OWNER TO postgres;

--
-- Name: inventory_healthstatusdetails_health_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inventory_healthstatusdetails ALTER COLUMN health_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.inventory_healthstatusdetails_health_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inventory_productcategorymaster_product_cat_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inventory_productcategorymaster ALTER COLUMN product_cat_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.inventory_productcategorymaster_product_cat_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inventory_productcompanymaster_product_com_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inventory_productcompanymaster ALTER COLUMN product_com_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.inventory_productcompanymaster_product_com_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inventory_productdetails_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inventory_productdetails ALTER COLUMN product_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.inventory_productdetails_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inventory_productmodelmaster_product_mod_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inventory_productmodelmaster ALTER COLUMN product_mod_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.inventory_productmodelmaster_product_mod_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inventory_productpuchasedetails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_productpuchasedetails (
    propur_id integer NOT NULL,
    propur_remarks character varying(350) NOT NULL,
    box_detail character varying(100) NOT NULL,
    purchase_id integer NOT NULL,
    no_of_item character varying(250) NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE public.inventory_productpuchasedetails OWNER TO postgres;

--
-- Name: inventory_productpuchasedetails_propur_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inventory_productpuchasedetails ALTER COLUMN propur_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.inventory_productpuchasedetails_propur_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inventory_producttransactiondetails_pro_trans_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inventory_producttransactiondetails ALTER COLUMN pro_trans_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.inventory_producttransactiondetails_pro_trans_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inventory_purchasedetails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_purchasedetails (
    purchase_id integer NOT NULL,
    purchase_date date NOT NULL,
    billmemono character varying(50) NOT NULL,
    purchased_by character varying(50) NOT NULL,
    purchased_for character varying(50) NOT NULL,
    purchase_remarks character varying(350) NOT NULL,
    billmemodoc character varying(100) NOT NULL
);


ALTER TABLE public.inventory_purchasedetails OWNER TO postgres;

--
-- Name: inventory_purchasedetails_purchase_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inventory_purchasedetails ALTER COLUMN purchase_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.inventory_purchasedetails_purchase_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inventory_secdesview; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_secdesview (
    id bigint NOT NULL,
    sdm_id integer NOT NULL,
    staff integer NOT NULL,
    section integer NOT NULL,
    staff_des_name character varying(250) NOT NULL,
    section_type character varying(250) NOT NULL,
    section_name character varying(250) NOT NULL,
    floor character varying(250) NOT NULL,
    roomno character varying(250) NOT NULL,
    landmark character varying(250) NOT NULL
);


ALTER TABLE public.inventory_secdesview OWNER TO postgres;

--
-- Name: inventory_secdesview_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inventory_secdesview ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.inventory_secdesview_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inventory_sectiondesignationmapper_sdm_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inventory_sectiondesignationmapper ALTER COLUMN sdm_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.inventory_sectiondesignationmapper_sdm_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inventory_sectiondetails_section_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inventory_sectiondetails ALTER COLUMN section_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.inventory_sectiondetails_section_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inventory_staffdesignationmaster_staff_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inventory_staffdesignationmaster ALTER COLUMN staff_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.inventory_staffdesignationmaster_staff_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inventory_transactiondetails_trans_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inventory_transactiondetails ALTER COLUMN trans_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.inventory_transactiondetails_trans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inventory_userdetails_usr_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.inventory_userdetails ALTER COLUMN usr_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.inventory_userdetails_usr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: issuedsaudetails; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.issuedsaudetails AS
 SELECT a.trans_issue_date,
    a.issue_received_status,
    b.pro_trans_id,
    b.trans_flag,
    b.no_of_item_issue,
    b.issue_remarks,
    b.trans_return_date,
    b.no_of_item_return,
    b.return_remarks,
    b.return_received_status,
    b.productid_id,
    c.product_cat_id,
    c.product_type,
    c.product_cat_name,
    c.product_com_id,
    c.product_com_name,
    c.product_mod_id,
    c.product_mod_name,
    c.product_id,
    c.product_serialno,
    c.current_quantity,
    c.cartridge_toner,
    c.remarks,
    c.product_new_or_open,
    c.propur_id,
    d.ip_address,
    e.section_type,
    e.section_name,
    e.floor,
    e.roomno,
    e.landmark,
    e.building_id,
    f.staff_des_name,
    f.staff_type,
    g.emp_jou_id,
    g.doj,
    g.dot,
    g.current_status,
    h.usr_name,
    h.usr_mobile,
    h.usr_type,
    d.sdm_id,
    e.section_id,
    h.usr_id
   FROM public.inventory_transactiondetails a,
    public.inventory_producttransactiondetails b,
    public.completeproductdetail c,
    public.inventory_sectiondesignationmapper d,
    public.inventory_sectiondetails e,
    public.inventory_staffdesignationmaster f,
    public.inventory_employee_journey g,
    public.inventory_userdetails h
  WHERE ((a.trans_id = b.trans_id) AND (b.productid_id = c.product_id) AND (a.sdm_id = d.sdm_id) AND (d.section_id = e.section_id) AND (d.staff_id = f.staff_id) AND (a.sdm_id = g.sdm_id) AND (d.sdm_id = g.sdm_id) AND (g.usr_id = h.usr_id) AND ((c.product_type)::text = 'Non-Consumable'::text) AND (b.trans_flag = 0))
  ORDER BY c.product_serialno DESC;


ALTER TABLE public.issuedsaudetails OWNER TO postgres;

--
-- Name: mappeduser; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.mappeduser AS
 SELECT b.emp_jou_id,
    b.doj,
    b.dot,
    b.current_status,
    b.sdm_id,
    b.usr_id,
    a.usr_name,
    a.usr_type
   FROM public.inventory_userdetails a,
    public.inventory_employee_journey b
  WHERE ((a.usr_id = b.usr_id) AND ((b.current_status)::text = 'D'::text));


ALTER TABLE public.mappeduser OWNER TO postgres;

--
-- Name: sectiondesignationview; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.sectiondesignationview AS
 SELECT a.sdm_id,
    b.section_id,
    c.staff_id,
    a.ip_address,
    b.section_type,
    b.section_name,
    b.floor,
    b.roomno,
    b.landmark,
    b.building_id,
    c.staff_des_name,
    c.staff_type
   FROM public.inventory_sectiondesignationmapper a,
    public.inventory_sectiondetails b,
    public.inventory_staffdesignationmaster c
  WHERE ((a.section_id = b.section_id) AND (a.staff_id = c.staff_id) AND (a.staff_id <> 37));


ALTER TABLE public.sectiondesignationview OWNER TO postgres;

--
-- Name: transactiondesignationview; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.transactiondesignationview AS
 SELECT a.sdm_id,
    a.section_id,
    a.staff_id,
    a.ip_address,
    b.trans_id,
    b.trans_issue_date,
    b.issue_received_status,
    c.pro_trans_id,
    c.trans_flag,
    c.no_of_item_issue,
    c.issue_remarks,
    c.trans_return_date,
    c.no_of_item_return,
    c.return_remarks,
    c.return_received_status,
    c.productid_id
   FROM public.inventory_sectiondesignationmapper a,
    public.inventory_transactiondetails b,
    public.inventory_producttransactiondetails c
  WHERE ((a.sdm_id = b.sdm_id) AND (b.trans_id = c.trans_id));


ALTER TABLE public.transactiondesignationview OWNER TO postgres;

--
-- Name: unallocatedusers; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.unallocatedusers AS
 SELECT inventory_userdetails.usr_id,
    inventory_userdetails.usr_name,
    inventory_userdetails.usr_mobile,
    inventory_userdetails.entry_date,
    inventory_userdetails.usr_type,
    inventory_userdetails.deleted
   FROM public.inventory_userdetails
  WHERE (NOT (inventory_userdetails.usr_id IN ( SELECT inventory_employee_journey.usr_id
           FROM public.inventory_employee_journey
          WHERE ((inventory_employee_journey.current_status)::text = 'D'::text))));


ALTER TABLE public.unallocatedusers OWNER TO postgres;

--
-- Name: userdesignationview; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.userdesignationview AS
 SELECT a.sdm_id,
    a.section_id,
    a.staff_id,
    a.ip_address,
    b.emp_jou_id,
    b.doj,
    b.dot,
    b.current_status,
    c.usr_id,
    c.usr_name,
    c.usr_mobile,
    c.entry_date,
    c.usr_type,
    d.staff_des_name,
    b.verified,
    e.section_name,
    b.pawatidoc
   FROM public.inventory_sectiondesignationmapper a,
    public.inventory_employee_journey b,
    public.inventory_userdetails c,
    public.inventory_staffdesignationmaster d,
    public.inventory_sectiondetails e
  WHERE ((a.sdm_id = b.sdm_id) AND (b.usr_id = c.usr_id) AND (a.staff_id = d.staff_id) AND (a.section_id = e.section_id));


ALTER TABLE public.userdesignationview OWNER TO postgres;

--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.auth_permission VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO public.auth_permission VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO public.auth_permission VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO public.auth_permission VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO public.auth_permission VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO public.auth_permission VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO public.auth_permission VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO public.auth_permission VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO public.auth_permission VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO public.auth_permission VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO public.auth_permission VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO public.auth_permission VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO public.auth_permission VALUES (13, 'Can add user', 4, 'add_user');
INSERT INTO public.auth_permission VALUES (14, 'Can change user', 4, 'change_user');
INSERT INTO public.auth_permission VALUES (15, 'Can delete user', 4, 'delete_user');
INSERT INTO public.auth_permission VALUES (16, 'Can view user', 4, 'view_user');
INSERT INTO public.auth_permission VALUES (17, 'Can add content type', 5, 'add_contenttype');
INSERT INTO public.auth_permission VALUES (18, 'Can change content type', 5, 'change_contenttype');
INSERT INTO public.auth_permission VALUES (19, 'Can delete content type', 5, 'delete_contenttype');
INSERT INTO public.auth_permission VALUES (20, 'Can view content type', 5, 'view_contenttype');
INSERT INTO public.auth_permission VALUES (21, 'Can add session', 6, 'add_session');
INSERT INTO public.auth_permission VALUES (22, 'Can change session', 6, 'change_session');
INSERT INTO public.auth_permission VALUES (23, 'Can delete session', 6, 'delete_session');
INSERT INTO public.auth_permission VALUES (24, 'Can view session', 6, 'view_session');
INSERT INTO public.auth_permission VALUES (25, 'Can add building master', 7, 'add_buildingmaster');
INSERT INTO public.auth_permission VALUES (26, 'Can change building master', 7, 'change_buildingmaster');
INSERT INTO public.auth_permission VALUES (27, 'Can delete building master', 7, 'delete_buildingmaster');
INSERT INTO public.auth_permission VALUES (28, 'Can view building master', 7, 'view_buildingmaster');
INSERT INTO public.auth_permission VALUES (29, 'Can add court establishment master', 8, 'add_courtestablishmentmaster');
INSERT INTO public.auth_permission VALUES (30, 'Can change court establishment master', 8, 'change_courtestablishmentmaster');
INSERT INTO public.auth_permission VALUES (31, 'Can delete court establishment master', 8, 'delete_courtestablishmentmaster');
INSERT INTO public.auth_permission VALUES (32, 'Can view court establishment master', 8, 'view_courtestablishmentmaster');
INSERT INTO public.auth_permission VALUES (33, 'Can add product category master', 9, 'add_productcategorymaster');
INSERT INTO public.auth_permission VALUES (34, 'Can change product category master', 9, 'change_productcategorymaster');
INSERT INTO public.auth_permission VALUES (35, 'Can delete product category master', 9, 'delete_productcategorymaster');
INSERT INTO public.auth_permission VALUES (36, 'Can view product category master', 9, 'view_productcategorymaster');
INSERT INTO public.auth_permission VALUES (37, 'Can add product company master', 10, 'add_productcompanymaster');
INSERT INTO public.auth_permission VALUES (38, 'Can change product company master', 10, 'change_productcompanymaster');
INSERT INTO public.auth_permission VALUES (39, 'Can delete product company master', 10, 'delete_productcompanymaster');
INSERT INTO public.auth_permission VALUES (40, 'Can view product company master', 10, 'view_productcompanymaster');
INSERT INTO public.auth_permission VALUES (41, 'Can add product details', 11, 'add_productdetails');
INSERT INTO public.auth_permission VALUES (42, 'Can change product details', 11, 'change_productdetails');
INSERT INTO public.auth_permission VALUES (43, 'Can delete product details', 11, 'delete_productdetails');
INSERT INTO public.auth_permission VALUES (44, 'Can view product details', 11, 'view_productdetails');
INSERT INTO public.auth_permission VALUES (45, 'Can add purchase details', 12, 'add_purchasedetails');
INSERT INTO public.auth_permission VALUES (46, 'Can change purchase details', 12, 'change_purchasedetails');
INSERT INTO public.auth_permission VALUES (47, 'Can delete purchase details', 12, 'delete_purchasedetails');
INSERT INTO public.auth_permission VALUES (48, 'Can view purchase details', 12, 'view_purchasedetails');
INSERT INTO public.auth_permission VALUES (49, 'Can add staff designation master', 13, 'add_staffdesignationmaster');
INSERT INTO public.auth_permission VALUES (50, 'Can change staff designation master', 13, 'change_staffdesignationmaster');
INSERT INTO public.auth_permission VALUES (51, 'Can delete staff designation master', 13, 'delete_staffdesignationmaster');
INSERT INTO public.auth_permission VALUES (52, 'Can view staff designation master', 13, 'view_staffdesignationmaster');
INSERT INTO public.auth_permission VALUES (53, 'Can add user details', 14, 'add_userdetails');
INSERT INTO public.auth_permission VALUES (54, 'Can change user details', 14, 'change_userdetails');
INSERT INTO public.auth_permission VALUES (55, 'Can delete user details', 14, 'delete_userdetails');
INSERT INTO public.auth_permission VALUES (56, 'Can view user details', 14, 'view_userdetails');
INSERT INTO public.auth_permission VALUES (57, 'Can add section details', 15, 'add_sectiondetails');
INSERT INTO public.auth_permission VALUES (58, 'Can change section details', 15, 'change_sectiondetails');
INSERT INTO public.auth_permission VALUES (59, 'Can delete section details', 15, 'delete_sectiondetails');
INSERT INTO public.auth_permission VALUES (60, 'Can view section details', 15, 'view_sectiondetails');
INSERT INTO public.auth_permission VALUES (61, 'Can add section designation mapper', 16, 'add_sectiondesignationmapper');
INSERT INTO public.auth_permission VALUES (62, 'Can change section designation mapper', 16, 'change_sectiondesignationmapper');
INSERT INTO public.auth_permission VALUES (63, 'Can delete section designation mapper', 16, 'delete_sectiondesignationmapper');
INSERT INTO public.auth_permission VALUES (64, 'Can view section designation mapper', 16, 'view_sectiondesignationmapper');
INSERT INTO public.auth_permission VALUES (65, 'Can add product transaction details', 17, 'add_producttransactiondetails');
INSERT INTO public.auth_permission VALUES (66, 'Can change product transaction details', 17, 'change_producttransactiondetails');
INSERT INTO public.auth_permission VALUES (67, 'Can delete product transaction details', 17, 'delete_producttransactiondetails');
INSERT INTO public.auth_permission VALUES (68, 'Can view product transaction details', 17, 'view_producttransactiondetails');
INSERT INTO public.auth_permission VALUES (69, 'Can add product puchase details', 18, 'add_productpuchasedetails');
INSERT INTO public.auth_permission VALUES (70, 'Can change product puchase details', 18, 'change_productpuchasedetails');
INSERT INTO public.auth_permission VALUES (71, 'Can delete product puchase details', 18, 'delete_productpuchasedetails');
INSERT INTO public.auth_permission VALUES (72, 'Can view product puchase details', 18, 'view_productpuchasedetails');
INSERT INTO public.auth_permission VALUES (73, 'Can add product model master', 19, 'add_productmodelmaster');
INSERT INTO public.auth_permission VALUES (74, 'Can change product model master', 19, 'change_productmodelmaster');
INSERT INTO public.auth_permission VALUES (75, 'Can delete product model master', 19, 'delete_productmodelmaster');
INSERT INTO public.auth_permission VALUES (76, 'Can view product model master', 19, 'view_productmodelmaster');
INSERT INTO public.auth_permission VALUES (77, 'Can add health status details', 20, 'add_healthstatusdetails');
INSERT INTO public.auth_permission VALUES (78, 'Can change health status details', 20, 'change_healthstatusdetails');
INSERT INTO public.auth_permission VALUES (79, 'Can delete health status details', 20, 'delete_healthstatusdetails');
INSERT INTO public.auth_permission VALUES (80, 'Can view health status details', 20, 'view_healthstatusdetails');
INSERT INTO public.auth_permission VALUES (81, 'Can add employee_ journey', 21, 'add_employee_journey');
INSERT INTO public.auth_permission VALUES (82, 'Can change employee_ journey', 21, 'change_employee_journey');
INSERT INTO public.auth_permission VALUES (83, 'Can delete employee_ journey', 21, 'delete_employee_journey');
INSERT INTO public.auth_permission VALUES (84, 'Can view employee_ journey', 21, 'view_employee_journey');
INSERT INTO public.auth_permission VALUES (85, 'Can add transaction details', 22, 'add_transactiondetails');
INSERT INTO public.auth_permission VALUES (86, 'Can change transaction details', 22, 'change_transactiondetails');
INSERT INTO public.auth_permission VALUES (87, 'Can delete transaction details', 22, 'delete_transactiondetails');
INSERT INTO public.auth_permission VALUES (88, 'Can view transaction details', 22, 'view_transactiondetails');
INSERT INTO public.auth_permission VALUES (89, 'Can add unallocated users', 23, 'add_unallocatedusers');
INSERT INTO public.auth_permission VALUES (90, 'Can change unallocated users', 23, 'change_unallocatedusers');
INSERT INTO public.auth_permission VALUES (91, 'Can delete unallocated users', 23, 'delete_unallocatedusers');
INSERT INTO public.auth_permission VALUES (92, 'Can view unallocated users', 23, 'view_unallocatedusers');
INSERT INTO public.auth_permission VALUES (93, 'Can add sec des view', 24, 'add_secdesview');
INSERT INTO public.auth_permission VALUES (94, 'Can change sec des view', 24, 'change_secdesview');
INSERT INTO public.auth_permission VALUES (95, 'Can delete sec des view', 24, 'delete_secdesview');
INSERT INTO public.auth_permission VALUES (96, 'Can view sec des view', 24, 'view_secdesview');


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.auth_user VALUES (1, 'pbkdf2_sha256$390000$ncLlZrD6yg0ywlpRKVssp3$ieipm+s5Nn+D2L7SUNrJQ9kqEH1MWjo7fw0LgVtVJww=', '2024-12-11 17:36:34.794452+05:30', true, 'admin', '', '', 'admin@gmail.com', true, true, '2023-04-05 16:24:22.743137+05:30');


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.django_content_type VALUES (1, 'admin', 'logentry');
INSERT INTO public.django_content_type VALUES (2, 'auth', 'permission');
INSERT INTO public.django_content_type VALUES (3, 'auth', 'group');
INSERT INTO public.django_content_type VALUES (4, 'auth', 'user');
INSERT INTO public.django_content_type VALUES (5, 'contenttypes', 'contenttype');
INSERT INTO public.django_content_type VALUES (6, 'sessions', 'session');
INSERT INTO public.django_content_type VALUES (7, 'inventory', 'buildingmaster');
INSERT INTO public.django_content_type VALUES (8, 'inventory', 'courtestablishmentmaster');
INSERT INTO public.django_content_type VALUES (9, 'inventory', 'productcategorymaster');
INSERT INTO public.django_content_type VALUES (10, 'inventory', 'productcompanymaster');
INSERT INTO public.django_content_type VALUES (11, 'inventory', 'productdetails');
INSERT INTO public.django_content_type VALUES (12, 'inventory', 'purchasedetails');
INSERT INTO public.django_content_type VALUES (13, 'inventory', 'staffdesignationmaster');
INSERT INTO public.django_content_type VALUES (14, 'inventory', 'userdetails');
INSERT INTO public.django_content_type VALUES (15, 'inventory', 'sectiondetails');
INSERT INTO public.django_content_type VALUES (16, 'inventory', 'sectiondesignationmapper');
INSERT INTO public.django_content_type VALUES (17, 'inventory', 'producttransactiondetails');
INSERT INTO public.django_content_type VALUES (18, 'inventory', 'productpuchasedetails');
INSERT INTO public.django_content_type VALUES (19, 'inventory', 'productmodelmaster');
INSERT INTO public.django_content_type VALUES (20, 'inventory', 'healthstatusdetails');
INSERT INTO public.django_content_type VALUES (21, 'inventory', 'employee_journey');
INSERT INTO public.django_content_type VALUES (22, 'inventory', 'transactiondetails');
INSERT INTO public.django_content_type VALUES (23, 'inventory', 'unallocatedusers');
INSERT INTO public.django_content_type VALUES (24, 'inventory', 'secdesview');


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.django_migrations VALUES (1, 'contenttypes', '0001_initial', '2024-01-08 15:15:28.098434+05:30');
INSERT INTO public.django_migrations VALUES (2, 'auth', '0001_initial', '2024-01-08 15:15:28.773072+05:30');
INSERT INTO public.django_migrations VALUES (3, 'admin', '0001_initial', '2024-01-08 15:15:28.939721+05:30');
INSERT INTO public.django_migrations VALUES (4, 'admin', '0002_logentry_remove_auto_add', '2024-01-08 15:15:28.956549+05:30');
INSERT INTO public.django_migrations VALUES (5, 'admin', '0003_logentry_add_action_flag_choices', '2024-01-08 15:15:28.968216+05:30');
INSERT INTO public.django_migrations VALUES (6, 'contenttypes', '0002_remove_content_type_name', '2024-01-08 15:15:28.994948+05:30');
INSERT INTO public.django_migrations VALUES (7, 'auth', '0002_alter_permission_name_max_length', '2024-01-08 15:15:29.016978+05:30');
INSERT INTO public.django_migrations VALUES (8, 'auth', '0003_alter_user_email_max_length', '2024-01-08 15:15:29.039944+05:30');
INSERT INTO public.django_migrations VALUES (9, 'auth', '0004_alter_user_username_opts', '2024-01-08 15:15:29.052172+05:30');
INSERT INTO public.django_migrations VALUES (10, 'auth', '0005_alter_user_last_login_null', '2024-01-08 15:15:29.071075+05:30');
INSERT INTO public.django_migrations VALUES (11, 'auth', '0006_require_contenttypes_0002', '2024-01-08 15:15:29.080082+05:30');
INSERT INTO public.django_migrations VALUES (12, 'auth', '0007_alter_validators_add_error_messages', '2024-01-08 15:15:29.094025+05:30');
INSERT INTO public.django_migrations VALUES (13, 'auth', '0008_alter_user_username_max_length', '2024-01-08 15:15:29.148155+05:30');
INSERT INTO public.django_migrations VALUES (14, 'auth', '0009_alter_user_last_name_max_length', '2024-01-08 15:15:29.174834+05:30');
INSERT INTO public.django_migrations VALUES (15, 'auth', '0010_alter_group_name_max_length', '2024-01-08 15:15:29.186936+05:30');
INSERT INTO public.django_migrations VALUES (16, 'auth', '0011_update_proxy_permissions', '2024-01-08 15:15:29.203967+05:30');
INSERT INTO public.django_migrations VALUES (17, 'auth', '0012_alter_user_first_name_max_length', '2024-01-08 15:15:29.218652+05:30');
INSERT INTO public.django_migrations VALUES (18, 'inventory', '0001_initial', '2024-01-08 15:15:30.777526+05:30');
INSERT INTO public.django_migrations VALUES (19, 'sessions', '0001_initial', '2024-01-08 15:15:30.909183+05:30');
INSERT INTO public.django_migrations VALUES (20, 'inventory', '0002_sectiondesignationmapper_ip_address', '2024-01-09 12:38:11.423637+05:30');
INSERT INTO public.django_migrations VALUES (21, 'inventory', '0003_alter_productpuchasedetails_box_detail_and_more', '2024-01-19 13:56:11.872305+05:30');
INSERT INTO public.django_migrations VALUES (22, 'inventory', '0004_productpuchasedetails_no_of_item_and_more', '2024-01-25 11:29:33.456273+05:30');
INSERT INTO public.django_migrations VALUES (24, 'inventory', '0005_alter_employee_journey_dot_and_more', '2024-02-13 13:00:31.725507+05:30');
INSERT INTO public.django_migrations VALUES (25, 'inventory', '0006_unallocatedusers', '2024-02-13 13:00:31.742031+05:30');
INSERT INTO public.django_migrations VALUES (26, 'inventory', '0007_transactiondetails_producttransactiondetails', '2024-02-13 13:16:51.353293+05:30');
INSERT INTO public.django_migrations VALUES (27, 'inventory', '0008_secdesview', '2024-08-13 12:18:24.553764+05:30');
INSERT INTO public.django_migrations VALUES (28, 'inventory', '0009_alter_secdesview_options', '2024-08-13 12:18:24.60172+05:30');
INSERT INTO public.django_migrations VALUES (29, 'inventory', '0010_alter_secdesview_table', '2024-08-13 12:18:24.61007+05:30');
INSERT INTO public.django_migrations VALUES (30, 'inventory', '0011_employee_journey_verified_and_more', '2024-08-13 12:18:24.684825+05:30');
INSERT INTO public.django_migrations VALUES (31, 'inventory', '0012_employee_journey_pawatidoc', '2024-11-25 12:09:42.393062+05:30');


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.django_session VALUES ('xyjgigx4lcev30pll94qrv120s1j1yt2', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1rN6lm:TAO0B0bZtGmfaFLaabaWVYOZwL9ujsUy1BsJsFlN3LQ', '2024-01-23 13:13:30.535925+05:30');
INSERT INTO public.django_session VALUES ('40adrbqlol96uhk3pn8z34dop6q8hxmv', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1rTbnw:PDK0maYAPuQGOLQHWpUpurXYgI7iEUqag-ZRtzvtl1M', '2024-02-10 11:34:36.939145+05:30');
INSERT INTO public.django_session VALUES ('5ubul2i23r21lej6gmod0k2ujqa4xnmm', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1raWzl:G-siursDEXh-O9qyT0Ruj51779iuup75KVqb_KV7-_M', '2024-02-29 13:51:25.730554+05:30');
INSERT INTO public.django_session VALUES ('o721dgtsqghaf28tb38bfqyrqrq6rb7l', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1rwFxR:MOtuX9wE5qDuBV3gBRdX3BD3ZI0PpxujIlrNSL3qU5g', '2024-04-29 12:06:49.052674+05:30');
INSERT INTO public.django_session VALUES ('nqup1bufo7koclignbd6srkq0a3snmgt', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1s27dm:JabMieiYqUbABsi9B9egvGEejavAK3JwOgxv1BGyjZ8', '2024-05-15 16:26:46.846133+05:30');
INSERT INTO public.django_session VALUES ('g7pkoqj0i4w76xztmejkb193koeblh0c', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1s9Lo9:0vbRFvQiOdp2v18Qse0V3DEGyhwBabmRHhw-gYUGmZs', '2024-06-04 14:59:21.853403+05:30');
INSERT INTO public.django_session VALUES ('ukgccagljpmpfte2iknwgo2j360logxo', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1sB82o:k0KQ-rqylcEa9n4C0HOdkoQcEiEJn3GPlqzWkXlO1OA', '2024-06-09 12:41:50.139258+05:30');
INSERT INTO public.django_session VALUES ('f1oattsuf3l7n1idyosoy4hlsufkfzts', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1sBTr8:ki6sjBq9SoP628e24cduAA7D6qdpj2cjWXkLyFwqMzI', '2024-06-10 11:59:14.015018+05:30');
INSERT INTO public.django_session VALUES ('b53jv40yetwaj6redfbfnnvjz46b9876', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1sGYjK:YJOmwskldurJOjSPugnZS31RDHNH3fgSTtZbdihekDM', '2024-06-24 12:12:10.1123+05:30');
INSERT INTO public.django_session VALUES ('t2b4mgisbochx9n4jkgintsumngohmci', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1sJTcd:ne2Row9789QkxDrWCIE7mwrJ6H1ZAFMmZ4hE16XhX8A', '2024-07-02 13:21:19.820271+05:30');
INSERT INTO public.django_session VALUES ('w92rohxvz25t3oigzxti8pmfoaygl06b', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1sOYRw:EIUL3t2bdhi3OFNb1R7u7UMb9aNjAIKPgzjW36phX9g', '2024-07-16 13:31:16.543485+05:30');
INSERT INTO public.django_session VALUES ('817kqboidlvozg3k2eolveqvjkt8ixy1', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1sYLKn:mW0ZB06oG06tR11V91jbiHOZQIZds5J70kUjhe9MYfs', '2024-08-12 13:32:21.657338+05:30');
INSERT INTO public.django_session VALUES ('o3eg7ortvov38qev6p0tkfg5eh5nddwd', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1sbHRe:VQWXw29G1siABSAYAsRG1E2PWLBNv8ftQ--hVC0X0n8', '2024-08-20 15:59:34.976644+05:30');
INSERT INTO public.django_session VALUES ('rvctzv0p6ircekcl1rjzwvjto4p1bdre', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1sbK2o:XZWBdpNRUB0qIWAK-4W8JDEc4hRp2da-koKJsBuY-5k', '2024-08-20 18:46:06.953295+05:30');
INSERT INTO public.django_session VALUES ('57w34mt2d0ikypaewrjmx7abeyquuz23', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1sbeAk:g2zMYhi1ozJR-uUXIc7ClLX1FqFlCRygVZK2FAUqrQ8', '2024-08-21 16:15:38.321842+05:30');
INSERT INTO public.django_session VALUES ('1yaica6ifsmyhimojgk39q2zxxdwgdjn', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1sgjj3:q3_hQ2ovvXS6IQZvnJHxSorjgZIpZWEa4fo-5Be83eQ', '2024-09-04 17:12:05.602045+05:30');
INSERT INTO public.django_session VALUES ('ldky7lik99rhy2dn3vf6bsz7hr4fh8k6', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1sm5bu:Xs005J2t0BQkU13sknYnKBQ0NENmfsEuwE1g4a1Pb1A', '2024-09-19 11:34:50.660757+05:30');
INSERT INTO public.django_session VALUES ('ruqc3tv3hlq1bx2nvrpgr9twt53okx26', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1smUUZ:sPxkdQwcIcE7SzoJdMLJwp0xoSSNrZ8qInyMa0oWADs', '2024-09-20 14:08:55.155196+05:30');
INSERT INTO public.django_session VALUES ('5x7rdq9gog8weyclq8tf4mz1lro56p3f', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1snbkB:Y9FOVoOv0SnEi4llS0hF99TZbWQ7VJd76tx4_Kv9IpE', '2024-09-23 16:05:39.563053+05:30');
INSERT INTO public.django_session VALUES ('wyyp16nq0n827d95owoadxk7wj6bagv7', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1sncpA:YMht7vgiczSrBHKTHHGylAT8Rm6MwK4_IwJZDQKR8qQ', '2024-09-23 17:14:52.11476+05:30');
INSERT INTO public.django_session VALUES ('t3idu5d9c173jeix3u3tvt9s9oadkien', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1ssyrg:sC37LP7vxR27L_MXTvQtF5c90pykR3YblSEoE6WIKFc', '2024-10-08 11:47:36.00226+05:30');
INSERT INTO public.django_session VALUES ('60ywqnmmpoo7xietmlm1xb1yosv966um', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1sy6ST:7tEaqiAe-Itt52yNvBb1ZHc-SOYMSMj4Luj3W7fa2go', '2024-10-22 14:54:45.478066+05:30');
INSERT INTO public.django_session VALUES ('762dtmhjme2uk5xcssuljikqs0g98hs1', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1tDLDK:XTLBk8p6ypzRCN_r6ZQpGUzKOHtm-zAUpWP5ZOvMzg8', '2024-12-03 15:42:06.074591+05:30');
INSERT INTO public.django_session VALUES ('b1a1qb10yryfak6qnitgqdnsw2g6k32n', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1tDjDG:Pp8XyIiJIU2WDrZ60ZrTruVf6rUOJyBNcPY-wTJ4_eA', '2024-12-04 17:19:38.313825+05:30');
INSERT INTO public.django_session VALUES ('q7jip46mryh2dg82visbq9o0qb57ib9n', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1tFTC0:QFpfUbHRp8i8aQ1IWD0Auhlifivkvy34Z1WgZCQ_JwE', '2024-12-09 12:37:32.927138+05:30');
INSERT INTO public.django_session VALUES ('8egu7pxay5reswmfzehxywv0auj6vm5q', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1tFTEX:bPnOxP7978mM3dZZ-DqSf4G124TYlhrPeVWGGtSz5Fs', '2024-12-09 12:40:09.408593+05:30');
INSERT INTO public.django_session VALUES ('yb6b4qcwhkrw478ilwei0mraz9betab7', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1tFsMp:mzuh-jPsAbL2xW-LaA9NQg3dfH0Gz3suwitjrdtpEbo', '2024-12-10 15:30:23.088372+05:30');
INSERT INTO public.django_session VALUES ('d2hdxxl4pjdofs3h8f2w0ouzii0bplnk', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1tFtMQ:0nGBDYQDCgv-86LM_bb1o_XXjTbMcaMjV8u9tLsgctU', '2024-12-10 16:34:02.997537+05:30');
INSERT INTO public.django_session VALUES ('rya68b60ynzeveb8dem5kgmcyxkpjkdn', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1tFtZ2:o9OTnULqeFPeaTck19ON62_NgNOAaoq5V2x62PrRpyQ', '2024-12-10 16:47:04.199491+05:30');
INSERT INTO public.django_session VALUES ('rkzo6100o5pdipc49pml88ewgsxcyamy', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1tGBHc:2AP1SaUKYYcfwsMFqm_HHSlJlUwayj8wCUX0NdgRI-E', '2024-12-11 11:42:16.150905+05:30');
INSERT INTO public.django_session VALUES ('pnljbnrig15qgalg4r3g2euh44ul6n5n', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1tGDk8:Fl3hIlUX6jdseQlxsJe8YOLOBOoH-oQAFgp9CElj9gY', '2024-12-11 14:19:52.655229+05:30');
INSERT INTO public.django_session VALUES ('g411vi72ry3ggrbp9hfe1ggc0tumbds1', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1tGdbv:z8DqN9X-rO5nqsk6nOdjVK07jjlYQYRVNmo6lMR98Mk', '2024-12-12 17:57:07.245269+05:30');
INSERT INTO public.django_session VALUES ('7houe13wh88oxfenzg1fvdproer1lqe7', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1tI4Sx:gxaNBvSeC-ayMTqw-y5UesyOfyW-NNEgT5r50JECQ0w', '2024-12-16 16:49:47.008924+05:30');
INSERT INTO public.django_session VALUES ('32r8pxlxz2ae9fm81o2jg0lgkdpdiwvf', '.eJxVjMEOwiAQBf-FsyHQAgsevfcbCAuLVA0kpT0Z_9026UGvM_Pem_mwrcVvnRY_J3Zlkl1-GYb4pHqI9Aj13nhsdV1m5EfCT9v51BK9bmf7d1BCL_va6TGSGxKMIoOFnA0pNyoFdgc6IgxGOx0QSEokZYUzIptsLRoVdQb2-QLKFDdE:1tInXa:l-AQulof5BdNuwJO8PYR32eAdT9GKelHN3h7_sCypyg', '2024-12-18 16:57:34.37649+05:30');
INSERT INTO public.django_session VALUES ('9qmhn3j1c09i3sbro8anm0w33aqdxxoz', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1tInl8:3UkKoQ88fuFnX9sqbPG8Swmvop5yBbUt9BBpJWVUc5E', '2024-12-18 17:11:34.198375+05:30');
INSERT INTO public.django_session VALUES ('hxa0kv145r4l9pybbtrr8uj25wa4b50s', '.eJxVjEkOAiEUBe_C2hBohg8u3XuGDsNHcICkh5Xx7kLSC91WvVdvMrt9y_O-4jKXSM6Ek9Mv8y48sA4R767eGg2tbkvxdEzoYVd6bRGfl2P7F8huzf1tlQhopwiCJTCQkkZphZRgOlDBw6SVVc4Dcu5RGmY1SzoZ47UMKkGPjlwvufgqlXy-KVY7-g:1tLLUA:VaIB5y3-KTvLGPRh47_M2qKpb3oZaC-SV334nJjG4rY', '2024-12-25 17:36:34.80372+05:30');


--
-- Data for Name: inventory_buildingmaster; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.inventory_buildingmaster VALUES (1, 'Old Building', 1);
INSERT INTO public.inventory_buildingmaster VALUES (5, 'Building-I', 3);
INSERT INTO public.inventory_buildingmaster VALUES (3, 'Building-I', 4);
INSERT INTO public.inventory_buildingmaster VALUES (6, 'Building-I', 5);
INSERT INTO public.inventory_buildingmaster VALUES (2, 'New Building-I', 1);
INSERT INTO public.inventory_buildingmaster VALUES (12, 'New Building-II', 1);
INSERT INTO public.inventory_buildingmaster VALUES (4, 'Building-I ', 2);


--
-- Data for Name: inventory_courtestablishmentmaster; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.inventory_courtestablishmentmaster VALUES (1, 'District Court Durg');
INSERT INTO public.inventory_courtestablishmentmaster VALUES (2, 'Bhilai-3 Court');
INSERT INTO public.inventory_courtestablishmentmaster VALUES (3, 'Patan Court');
INSERT INTO public.inventory_courtestablishmentmaster VALUES (4, 'Family Court Durg');
INSERT INTO public.inventory_courtestablishmentmaster VALUES (5, 'JJB  Durg');


--
-- Data for Name: inventory_employee_journey; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.inventory_employee_journey VALUES (2, '2024-05-23', '1900-01-01', 'D', 59, 77, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (3, '2024-05-23', '1900-01-01', 'D', 58, 155, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (4, '2024-05-23', '1900-01-01', 'D', 60, 23, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (5, '2024-05-23', '1900-01-01', 'D', 61, 195, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (7, '2024-05-23', '1900-01-01', 'D', 65, 202, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (8, '2024-05-23', '1900-01-01', 'D', 63, 131, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (9, '2024-05-23', '1900-01-01', 'D', 64, 1, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (10, '2024-05-23', '1900-01-01', 'D', 66, 203, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (11, '2024-05-23', '1900-01-01', 'D', 67, 91, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (12, '2024-05-23', '1900-01-01', 'D', 68, 55, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (13, '2024-05-23', '1900-01-01', 'D', 69, 93, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (14, '2024-05-23', '1900-01-01', 'D', 70, 154, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (15, '2024-05-23', '1900-01-01', 'D', 71, 204, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (16, '2024-05-23', '1900-01-01', 'D', 73, 206, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (17, '2024-05-23', '1900-01-01', 'D', 72, 205, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (18, '2024-05-23', '1900-01-01', 'D', 74, 168, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (19, '2024-05-23', '1900-01-01', 'D', 75, 20, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (20, '2024-05-23', '1900-01-01', 'D', 76, 18, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (21, '2024-05-23', '1900-01-01', 'D', 77, 200, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (22, '2024-05-23', '1900-01-01', 'D', 78, 82, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (23, '2024-05-23', '1900-01-01', 'D', 79, 14, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (24, '2024-05-23', '1900-01-01', 'D', 80, 118, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (25, '2024-05-23', '1900-01-01', 'D', 81, 121, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (26, '2024-05-24', '1900-01-01', 'D', 85, 207, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (27, '2024-05-24', '1900-01-01', 'D', 86, 89, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (28, '2024-05-24', '1900-01-01', 'D', 87, 208, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (29, '2024-05-24', '1900-01-01', 'D', 88, 107, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (38, '2024-05-24', '1900-01-01', 'D', 97, 140, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (39, '2024-05-24', '1900-01-01', 'D', 98, 166, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (40, '2024-05-24', '1900-01-01', 'D', 99, 94, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (41, '2024-05-24', '1900-01-01', 'D', 103, 209, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (42, '2024-05-24', '1900-01-01', 'D', 102, 51, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (43, '2024-05-24', '1900-01-01', 'D', 100, 123, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (44, '2024-05-24', '1900-01-01', 'D', 101, 187, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (45, '2024-05-24', '1900-01-01', 'D', 104, 211, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (46, '2024-05-24', '1900-01-01', 'D', 105, 210, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (47, '2024-05-24', '1900-01-01', 'D', 82, 212, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (48, '2024-05-24', '1900-01-01', 'D', 83, 213, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (49, '2024-05-24', '1900-01-01', 'D', 84, 184, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (50, '2024-05-25', '1900-01-01', 'D', 106, 16, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (53, '2024-05-25', '1900-01-01', 'D', 108, 2, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (54, '2024-05-25', '1900-01-01', 'D', 110, 163, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (55, '2024-05-25', '1900-01-01', 'D', 112, 214, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (56, '2024-05-25', '1900-01-01', 'D', 113, 143, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (57, '2024-05-25', '1900-01-01', 'D', 114, 201, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (58, '2024-05-25', '1900-01-01', 'D', 111, 119, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (59, '2024-05-25', '1900-01-01', 'D', 119, 70, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (60, '2024-05-25', '1900-01-01', 'D', 117, 151, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (61, '2024-05-25', '1900-01-01', 'D', 116, 60, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (62, '2024-05-25', '1900-01-01', 'D', 115, 39, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (63, '2024-05-25', '1900-01-01', 'D', 118, 149, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (64, '2024-05-25', '1900-01-01', 'D', 120, 215, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (65, '2024-05-25', '1900-01-01', 'D', 123, 32, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (66, '2024-05-25', '1900-01-01', 'D', 122, 216, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (67, '2024-05-25', '1900-01-01', 'D', 121, 66, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (68, '2024-05-25', '1900-01-01', 'D', 125, 217, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (69, '2024-05-25', '1900-01-01', 'D', 126, 177, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (70, '2024-05-25', '1900-01-01', 'D', 124, 158, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (71, '2024-06-18', '1900-01-01', 'D', 127, 218, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (72, '2024-06-18', '1900-01-01', 'D', 130, 219, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (73, '2024-06-18', '1900-01-01', 'D', 128, 156, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (74, '2024-06-18', '1900-01-01', 'D', 129, 169, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (75, '2024-06-18', '1900-01-01', 'D', 131, 97, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (76, '2024-06-18', '1900-01-01', 'D', 132, 7, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (32, '2024-05-24', '1900-01-01', 'D', 92, 84, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (33, '2024-05-24', '1900-01-01', 'D', 91, 112, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (30, '2024-05-24', '1900-01-01', 'D', 89, 5, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (77, '2024-06-19', '1900-01-01', 'D', 138, 189, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (78, '2024-06-19', '1900-01-01', 'D', 135, 221, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (79, '2024-06-19', '1900-01-01', 'D', 133, 13, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (80, '2024-06-19', '1900-01-01', 'D', 134, 100, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (81, '2024-06-19', '1900-01-01', 'D', 139, 183, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (82, '2024-06-19', '1900-01-01', 'D', 137, 102, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (83, '2024-06-19', '1900-01-01', 'D', 136, 10, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (84, '2024-06-20', '1900-01-01', 'D', 140, 170, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (85, '2024-06-20', '1900-01-01', 'D', 143, 223, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (86, '2024-06-20', '1900-01-01', 'D', 141, 150, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (87, '2024-06-20', '1900-01-01', 'D', 142, 222, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (88, '2024-06-20', '1900-01-01', 'D', 144, 40, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (89, '2024-06-20', '1900-01-01', 'D', 145, 74, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (90, '2024-06-20', '1900-01-01', 'D', 148, 224, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (91, '2024-06-20', '1900-01-01', 'D', 146, 67, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (93, '2024-06-21', '1900-01-01', 'D', 149, 225, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (94, '2024-06-21', '1900-01-01', 'D', 150, 226, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (95, '2024-06-21', '1900-01-01', 'D', 151, 90, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (96, '2024-06-21', '1900-01-01', 'D', 152, 227, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (97, '2024-06-21', '1900-01-01', 'D', 153, 199, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (98, '2024-06-21', '1900-01-01', 'D', 154, 135, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (99, '2024-06-21', '1900-01-01', 'D', 155, 125, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (100, '2024-06-21', '1900-01-01', 'D', 156, 229, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (101, '2024-06-21', '1900-01-01', 'D', 157, 230, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (102, '2024-06-21', '1900-01-01', 'D', 158, 130, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (103, '2024-06-21', '1900-01-01', 'D', 159, 124, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (104, '2024-06-21', '1900-01-01', 'D', 161, 173, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (105, '2024-06-21', '1900-01-01', 'D', 160, 17, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (106, '2024-06-21', '1900-01-01', 'D', 162, 136, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (107, '2024-06-21', '1900-01-01', 'D', 163, 37, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (121, '2024-06-25', '1900-01-01', 'D', 177, 198, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (113, '2024-06-25', '1900-01-01', 'D', 173, 171, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (115, '2024-06-25', '1900-01-01', 'D', 171, 233, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (116, '2024-06-25', '1900-01-01', 'D', 170, 8, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (117, '2024-06-25', '1900-01-01', 'D', 169, 30, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (118, '2024-06-25', '1900-01-01', 'D', 168, 109, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (119, '2024-06-25', '1900-01-01', 'D', 167, 73, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (120, '2024-06-25', '1900-01-01', 'D', 176, 83, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (135, '2024-06-29', '1900-01-01', 'D', 190, 237, 'YES', 'Shahid Hussain_135.pdf');
INSERT INTO public.inventory_employee_journey VALUES (126, '2024-06-28', '1900-01-01', 'D', 180, 236, 'YES', 'Shivangi Verma_126.pdf');
INSERT INTO public.inventory_employee_journey VALUES (133, '2024-06-28', '1900-01-01', 'D', 189, 41, 'YES', 'Ghanshyam_133.pdf');
INSERT INTO public.inventory_employee_journey VALUES (130, '2024-06-28', '1900-01-01', 'D', 186, 142, 'YES', 'Shreya Tiwari_130.pdf');
INSERT INTO public.inventory_employee_journey VALUES (132, '2024-06-28', '1900-01-01', 'D', 188, 196, 'YES', 'Janeshwar Singh Bharatwaj_132.pdf');
INSERT INTO public.inventory_employee_journey VALUES (34, '2024-05-24', '1900-01-01', 'D', 93, 190, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (137, '2024-06-29', '1900-01-01', 'D', 194, 238, 'YES', 'Sushant Bepari _137.pdf');
INSERT INTO public.inventory_employee_journey VALUES (139, '2024-06-29', '1900-01-01', 'D', 193, 180, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (140, '2024-07-08', '1900-01-01', 'D', 198, 3, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (141, '2024-07-08', '1900-01-01', 'D', 197, 239, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (142, '2024-07-08', '1900-01-01', 'D', 196, 164, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (143, '2024-07-08', '1900-01-01', 'D', 200, 36, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (144, '2024-07-08', '1900-01-01', 'D', 199, 240, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (145, '2024-07-10', '1900-01-01', 'D', 201, 98, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (108, '2024-06-22', '1900-01-01', 'D', 166, 178, 'YES', 'Vijay Kumar Tidke_108.pdf');
INSERT INTO public.inventory_employee_journey VALUES (109, '2024-06-22', '1900-01-01', 'D', 165, 232, 'YES', 'Lokesh Khare_109.pdf');
INSERT INTO public.inventory_employee_journey VALUES (146, '2024-07-18', '1900-01-01', 'D', 202, 48, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (147, '2024-07-18', '1900-01-01', 'D', 203, 38, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (31, '2024-05-24', '1900-01-01', 'D', 90, 21, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (131, '2024-06-28', '2024-08-05', 'T', 187, 31, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (35, '2024-05-24', '1900-01-01', 'D', 94, 58, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (36, '2024-05-24', '1900-01-01', 'D', 95, 28, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (37, '2024-05-24', '1900-01-01', 'D', 96, 42, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (149, '2024-08-01', '1900-01-01', 'D', 204, 243, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (52, '2024-05-25', '2024-08-01', 'T', 107, 103, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (150, '2024-08-01', '1900-01-01', 'D', 107, 24, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (51, '2024-05-25', '2024-08-01', 'T', 109, 182, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (151, '2024-08-01', '1900-01-01', 'D', 109, 103, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (152, '2024-09-09', '2024-10-08', 'T', 205, 99, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (111, '2024-06-25', '1900-01-01', 'D', 175, 25, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (112, '2024-06-25', '1900-01-01', 'D', 174, 147, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (134, '2024-06-29', '2024-08-05', 'T', 191, 162, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (125, '2024-06-28', '1900-01-01', 'D', 179, 235, 'YES', 'Sonu Ram Lahare_125.pdf');
INSERT INTO public.inventory_employee_journey VALUES (136, '2024-06-29', '2024-10-04', 'T', 195, 71, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (6, '2024-05-23', '2024-07-27', 'T', 62, 78, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (124, '2024-06-28', '1900-01-01', 'D', 181, 172, 'YES', 'Vanita Borekar_124.pdf');
INSERT INTO public.inventory_employee_journey VALUES (153, '2024-09-05', '1900-01-01', 'D', 147, 182, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (148, '2024-08-05', '2024-09-18', 'T', 187, 241, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (155, '2024-10-08', '1900-01-01', 'D', 205, 27, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (114, '2024-06-25', '1900-01-01', 'D', 172, 110, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (156, '2024-06-25', '1900-01-01', 'D', 207, 250, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (157, '2024-06-25', '1900-01-01', 'D', 206, 251, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (1, '2024-05-23', '1900-01-01', 'D', 57, 105, 'YES', 'Poonam Patel_1.pdf');
INSERT INTO public.inventory_employee_journey VALUES (159, '2024-07-23', '1900-01-01', 'D', 62, 253, 'YES', 'Narayan_159.pdf');
INSERT INTO public.inventory_employee_journey VALUES (127, '2024-06-28', '1900-01-01', 'D', 183, 197, 'YES', 'Fagooram Verma_127.pdf');
INSERT INTO public.inventory_employee_journey VALUES (122, '2024-06-28', '1900-01-01', 'D', 178, 234, 'YES', 'Prameshwari Sahu_122.pdf');
INSERT INTO public.inventory_employee_journey VALUES (158, '2024-11-25', '1900-01-01', 'D', 208, 252, 'YES', 'Dileshwari Bharti_158.pdf');
INSERT INTO public.inventory_employee_journey VALUES (123, '2024-06-28', '1900-01-01', 'D', 182, 59, 'YES', 'Khelan Singh Verma_123.pdf');
INSERT INTO public.inventory_employee_journey VALUES (92, '2024-06-20', '2024-09-05', 'T', 147, 57, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (161, '2024-08-05', '1900-01-01', 'D', 191, 57, 'YES', 'Kanak Kumar Bhaina_161.pdf');
INSERT INTO public.inventory_employee_journey VALUES (154, '2024-09-18', '2024-12-06', 'T', 187, 244, 'NO', '');
INSERT INTO public.inventory_employee_journey VALUES (163, '2023-11-09', '1900-01-01', 'D', 210, 254, 'YES', 'Yadunandan Kaushik_163.pdf');
INSERT INTO public.inventory_employee_journey VALUES (162, '2024-02-01', '1900-01-01', 'D', 209, 160, 'YES', 'Swarnalata Chandra_162.pdf');
INSERT INTO public.inventory_employee_journey VALUES (110, '2024-06-22', '1900-01-01', 'D', 164, 231, 'YES', 'Prakash Patel_110.pdf');
INSERT INTO public.inventory_employee_journey VALUES (129, '2024-06-28', '1900-01-01', 'D', 185, 129, 'YES', 'Sameer Soni_129.pdf');
INSERT INTO public.inventory_employee_journey VALUES (128, '2024-06-28', '1900-01-01', 'D', 184, 76, 'YES', 'Mahendra Kumar Deshmukh_128.pdf');
INSERT INTO public.inventory_employee_journey VALUES (164, '2024-12-06', '1900-01-01', 'D', 187, 245, 'YES', 'Binu Vaish_164.pdf');
INSERT INTO public.inventory_employee_journey VALUES (138, '2024-06-29', '1900-01-01', 'D', 192, 116, 'YES', 'Puran Singh_138.pdf');
INSERT INTO public.inventory_employee_journey VALUES (165, '2024-10-04', '1900-01-01', 'D', 195, 157, 'YES', 'Surendra Kumar Kurre_165.pdf');


--
-- Data for Name: inventory_healthstatusdetails; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.inventory_healthstatusdetails VALUES (1533, 'Yes', 'New Product', 'Working', '2024-07-08', 981);
INSERT INTO public.inventory_healthstatusdetails VALUES (1539, 'Yes', 'New Product', 'Working', '2024-07-29', 987);
INSERT INTO public.inventory_healthstatusdetails VALUES (1545, 'Yes', 'New Product', 'Working', '2024-08-02', 993);
INSERT INTO public.inventory_healthstatusdetails VALUES (1547, 'Yes', 'New Product', 'Dead Stock', '2024-08-07', 995);
INSERT INTO public.inventory_healthstatusdetails VALUES (1552, 'Yes', 'New Product', 'Working', '2024-08-13', 1000);
INSERT INTO public.inventory_healthstatusdetails VALUES (1553, 'Yes', 'New Product', 'Working', '2024-09-06', 1001);
INSERT INTO public.inventory_healthstatusdetails VALUES (1554, 'Yes', 'New Product', 'Working', '2024-09-09', 1002);
INSERT INTO public.inventory_healthstatusdetails VALUES (1563, 'Yes', 'New Product', 'Working', '2024-09-12', 1011);
INSERT INTO public.inventory_healthstatusdetails VALUES (1568, 'Yes', 'New Product', 'Working', '2024-09-19', 1016);
INSERT INTO public.inventory_healthstatusdetails VALUES (1569, 'Yes', 'Screen Damage', 'Dead Stock', '2024-09-20', 1017);
INSERT INTO public.inventory_healthstatusdetails VALUES (1572, 'Yes', 'New Product', 'Working', '2024-10-10', 1020);
INSERT INTO public.inventory_healthstatusdetails VALUES (1573, 'Yes', 'New Product', 'Working', '2024-11-20', 1021);
INSERT INTO public.inventory_healthstatusdetails VALUES (1576, 'Yes', 'New Product', 'Working', '2024-11-25', 1024);
INSERT INTO public.inventory_healthstatusdetails VALUES (1580, 'Yes', 'New Product', 'Working', '2024-12-05', 1028);
INSERT INTO public.inventory_healthstatusdetails VALUES (1590, 'Yes', 'New Product', 'Working', '2024-12-07', 1038);
INSERT INTO public.inventory_healthstatusdetails VALUES (1600, 'Yes', '', 'Needs To Repair', '2024-12-11', 1048);
INSERT INTO public.inventory_healthstatusdetails VALUES (1610, 'Yes', '', 'Needs To Repair', '2024-12-12', 1058);
INSERT INTO public.inventory_healthstatusdetails VALUES (1, 'NA', 'New Product', 'Working', '2024-04-23', 1);
INSERT INTO public.inventory_healthstatusdetails VALUES (2, 'NA', 'New Product', 'Working', '2024-04-23', 2);
INSERT INTO public.inventory_healthstatusdetails VALUES (3, 'NA', 'New Product', 'Working', '2024-04-23', 3);
INSERT INTO public.inventory_healthstatusdetails VALUES (4, 'NA', 'New Product', 'Working', '2024-04-23', 4);
INSERT INTO public.inventory_healthstatusdetails VALUES (5, 'NA', 'New Product', 'Working', '2024-04-23', 5);
INSERT INTO public.inventory_healthstatusdetails VALUES (6, 'NA', 'New Product', 'Working', '2024-04-23', 6);
INSERT INTO public.inventory_healthstatusdetails VALUES (7, 'NA', 'New Product', 'Working', '2024-04-23', 7);
INSERT INTO public.inventory_healthstatusdetails VALUES (8, 'NA', 'New Product', 'Working', '2024-04-23', 8);
INSERT INTO public.inventory_healthstatusdetails VALUES (9, 'NA', 'New Product', 'Working', '2024-04-23', 9);
INSERT INTO public.inventory_healthstatusdetails VALUES (10, 'NA', 'New Product', 'Working', '2024-04-23', 10);
INSERT INTO public.inventory_healthstatusdetails VALUES (11, 'NA', 'New Product', 'Working', '2024-04-23', 11);
INSERT INTO public.inventory_healthstatusdetails VALUES (12, 'NA', 'New Product', 'Working', '2024-04-23', 12);
INSERT INTO public.inventory_healthstatusdetails VALUES (13, 'NA', 'New Product', 'Working', '2024-04-23', 13);
INSERT INTO public.inventory_healthstatusdetails VALUES (14, 'NA', 'New Product', 'Working', '2024-04-23', 14);
INSERT INTO public.inventory_healthstatusdetails VALUES (15, 'NA', 'New Product', 'Working', '2024-04-23', 15);
INSERT INTO public.inventory_healthstatusdetails VALUES (16, 'NA', 'New Product', 'Working', '2024-04-23', 16);
INSERT INTO public.inventory_healthstatusdetails VALUES (17, 'NA', 'New Product', 'Working', '2024-04-23', 17);
INSERT INTO public.inventory_healthstatusdetails VALUES (19, 'NA', 'New Product', 'Working', '2024-04-23', 19);
INSERT INTO public.inventory_healthstatusdetails VALUES (1534, 'Yes', 'New Product', 'Working', '2024-07-10', 982);
INSERT INTO public.inventory_healthstatusdetails VALUES (1540, 'Yes', 'New Product', 'Working', '2024-07-29', 988);
INSERT INTO public.inventory_healthstatusdetails VALUES (1546, 'Yes', 'New Product', 'Working', '2024-08-02', 994);
INSERT INTO public.inventory_healthstatusdetails VALUES (1548, 'Yes', 'New Product', 'Working', '2024-08-07', 996);
INSERT INTO public.inventory_healthstatusdetails VALUES (1555, 'Yes', 'New Product', 'Working', '2024-09-09', 1003);
INSERT INTO public.inventory_healthstatusdetails VALUES (1564, 'Yes', 'New Product', 'Working', '2024-09-12', 1012);
INSERT INTO public.inventory_healthstatusdetails VALUES (1570, 'Yes', 'New Product', 'Working', '2024-09-20', 1018);
INSERT INTO public.inventory_healthstatusdetails VALUES (1574, 'Yes', 'New Product', 'Working', '2024-11-21', 1022);
INSERT INTO public.inventory_healthstatusdetails VALUES (1577, 'Yes', 'New Product', 'Working', '2024-11-25', 1025);
INSERT INTO public.inventory_healthstatusdetails VALUES (1581, 'Yes', 'New Product', 'Working', '2024-12-05', 1029);
INSERT INTO public.inventory_healthstatusdetails VALUES (1591, 'Yes', 'New Product', 'Working', '2024-12-07', 1039);
INSERT INTO public.inventory_healthstatusdetails VALUES (1601, 'Yes', '', 'Needs To Repair', '2024-12-11', 1049);
INSERT INTO public.inventory_healthstatusdetails VALUES (121, 'NA', 'New Product', 'Working', '2024-04-23', 121);
INSERT INTO public.inventory_healthstatusdetails VALUES (1535, 'Yes', 'New Product', 'Working', '2024-07-11', 983);
INSERT INTO public.inventory_healthstatusdetails VALUES (1409, 'NA', 'Blank Print', 'Needs To Repair', '2024-06-14', 857);
INSERT INTO public.inventory_healthstatusdetails VALUES (787, 'NA', 'Replaced with New system', 'Working', '2024-08-02', 235);
INSERT INTO public.inventory_healthstatusdetails VALUES (1556, 'Yes', 'New Product', 'Working', '2024-09-09', 1004);
INSERT INTO public.inventory_healthstatusdetails VALUES (1565, 'Yes', 'New Product', 'Working', '2024-09-12', 1013);
INSERT INTO public.inventory_healthstatusdetails VALUES (1571, 'Yes', 'New Product', 'Working', '2024-09-21', 1019);
INSERT INTO public.inventory_healthstatusdetails VALUES (1575, 'Yes', 'New Product', 'Working', '2024-11-21', 1023);
INSERT INTO public.inventory_healthstatusdetails VALUES (1578, 'Yes', 'New Product', 'Working', '2024-11-25', 1026);
INSERT INTO public.inventory_healthstatusdetails VALUES (1582, 'Yes', 'New Product', 'Working', '2024-12-05', 1030);
INSERT INTO public.inventory_healthstatusdetails VALUES (1592, 'Yes', 'New Product', 'Working', '2024-12-07', 1040);
INSERT INTO public.inventory_healthstatusdetails VALUES (1549, 'Yes', '', 'Needs To Repair', '2024-08-07', 997);
INSERT INTO public.inventory_healthstatusdetails VALUES (1602, 'Yes', 'New Product', 'Working', '2024-12-11', 1050);
INSERT INTO public.inventory_healthstatusdetails VALUES (794, 'NA', 'Opened Product', 'Working', '2024-05-22', 242);
INSERT INTO public.inventory_healthstatusdetails VALUES (1225, 'NA', 'No issue', 'Working', '2024-06-14', 673);
INSERT INTO public.inventory_healthstatusdetails VALUES (885, 'NA', 'Replaced with New system', 'Working', '2024-08-02', 333);
INSERT INTO public.inventory_healthstatusdetails VALUES (789, 'NA', 'Replaced with New system', 'Working', '2024-08-02', 237);
INSERT INTO public.inventory_healthstatusdetails VALUES (1557, 'Yes', 'New Product', 'Working', '2024-09-10', 1005);
INSERT INTO public.inventory_healthstatusdetails VALUES (1566, 'Yes', 'New Product', 'Working', '2024-09-12', 1014);
INSERT INTO public.inventory_healthstatusdetails VALUES (1116, 'NA', 'Returned due to Extra', 'Working', '2024-09-17', 564);
INSERT INTO public.inventory_healthstatusdetails VALUES (1579, 'Yes', 'New Product', 'Working', '2024-11-27', 1027);
INSERT INTO public.inventory_healthstatusdetails VALUES (1583, 'Yes', 'New Product', 'Working', '2024-12-05', 1031);
INSERT INTO public.inventory_healthstatusdetails VALUES (1550, 'NA', 'Paper Pickup Problem', 'Needs To Repair', '2024-11-18', 998);
INSERT INTO public.inventory_healthstatusdetails VALUES (1593, 'Yes', '', 'Needs To Repair', '2024-12-11', 1041);
INSERT INTO public.inventory_healthstatusdetails VALUES (1603, 'Yes', '', 'Needs To Repair', '2024-12-12', 1051);
INSERT INTO public.inventory_healthstatusdetails VALUES (1536, 'Yes', 'Blank Print', 'Needs To Repair', '2024-07-11', 984);
INSERT INTO public.inventory_healthstatusdetails VALUES (1551, 'Yes', 'Old Product', 'Needs To Repair', '2024-08-08', 999);
INSERT INTO public.inventory_healthstatusdetails VALUES (1558, 'Yes', 'New Product', 'Working', '2024-09-11', 1006);
INSERT INTO public.inventory_healthstatusdetails VALUES (1567, 'Yes', 'New Product', 'Working', '2024-09-12', 1015);
INSERT INTO public.inventory_healthstatusdetails VALUES (1541, 'NA', 'Working', 'Working', '2024-09-06', 989);
INSERT INTO public.inventory_healthstatusdetails VALUES (1584, 'Yes', 'New Product', 'Working', '2024-12-05', 1032);
INSERT INTO public.inventory_healthstatusdetails VALUES (1594, 'Yes', 'New Product', 'Working', '2024-12-11', 1042);
INSERT INTO public.inventory_healthstatusdetails VALUES (1604, 'Yes', '', 'Needs To Repair', '2024-12-12', 1052);
INSERT INTO public.inventory_healthstatusdetails VALUES (1042, 'NA', 'New Product', 'Working', '2024-05-24', 490);
INSERT INTO public.inventory_healthstatusdetails VALUES (1537, 'Yes', 'New Product', 'Working', '2024-07-11', 985);
INSERT INTO public.inventory_healthstatusdetails VALUES (1542, 'NA', 'VGA Port Not Working', 'Needs To Repair', '2024-08-01', 990);
INSERT INTO public.inventory_healthstatusdetails VALUES (1559, 'Yes', 'New Product', 'Working', '2024-09-11', 1007);
INSERT INTO public.inventory_healthstatusdetails VALUES (1585, 'Yes', 'New Product', 'Working', '2024-12-05', 1033);
INSERT INTO public.inventory_healthstatusdetails VALUES (1595, 'Yes', 'New Product', 'Working', '2024-12-11', 1043);
INSERT INTO public.inventory_healthstatusdetails VALUES (1605, 'Yes', '', 'Needs To Repair', '2024-12-12', 1053);
INSERT INTO public.inventory_healthstatusdetails VALUES (1164, 'NA', 'New Product', 'Working', '2024-05-28', 612);
INSERT INTO public.inventory_healthstatusdetails VALUES (909, 'N', 'Teflon Problem', 'Dead Stock', '2024-05-22', 357);
INSERT INTO public.inventory_healthstatusdetails VALUES (1560, 'Yes', 'New Product', 'Working', '2024-09-11', 1008);
INSERT INTO public.inventory_healthstatusdetails VALUES (1543, 'NA', '', 'Working', '2024-09-06', 991);
INSERT INTO public.inventory_healthstatusdetails VALUES (1586, 'Yes', 'New Product', 'Working', '2024-12-05', 1034);
INSERT INTO public.inventory_healthstatusdetails VALUES (1596, 'Yes', 'New Product', 'Working', '2024-12-11', 1044);
INSERT INTO public.inventory_healthstatusdetails VALUES (1606, 'Yes', '', 'Needs To Repair', '2024-12-12', 1054);
INSERT INTO public.inventory_healthstatusdetails VALUES (1284, 'NA', 'Opened Product', 'Working', '2024-06-14', 732);
INSERT INTO public.inventory_healthstatusdetails VALUES (1285, 'NA', 'Opened Product', 'Working', '2024-06-14', 733);
INSERT INTO public.inventory_healthstatusdetails VALUES (1538, 'Yes', 'New Product', 'Working', '2024-07-11', 986);
INSERT INTO public.inventory_healthstatusdetails VALUES (1030, 'N', 'Not Working', 'Working', '2024-05-23', 478);
INSERT INTO public.inventory_healthstatusdetails VALUES (1040, 'NA', 'Working', 'Working', '2024-11-25', 488);
INSERT INTO public.inventory_healthstatusdetails VALUES (1587, 'Yes', 'New Product', 'Working', '2024-12-05', 1035);
INSERT INTO public.inventory_healthstatusdetails VALUES (1597, 'Yes', 'New Product', 'Working', '2024-12-11', 1045);
INSERT INTO public.inventory_healthstatusdetails VALUES (1607, 'Yes', '', 'Needs To Repair', '2024-12-12', 1055);
INSERT INTO public.inventory_healthstatusdetails VALUES (784, 'NA', 'New Product', 'Working', '2024-05-22', 232);
INSERT INTO public.inventory_healthstatusdetails VALUES (1588, 'Yes', 'New Product', 'Working', '2024-12-05', 1036);
INSERT INTO public.inventory_healthstatusdetails VALUES (1561, 'Yes', 'New Product', 'Working', '2024-09-12', 1009);
INSERT INTO public.inventory_healthstatusdetails VALUES (1524, 'NA', 'Working', 'Working', '2024-11-25', 972);
INSERT INTO public.inventory_healthstatusdetails VALUES (1031, 'NA', 'Working', 'Working', '2024-11-25', 479);
INSERT INTO public.inventory_healthstatusdetails VALUES (1598, 'Yes', 'New Product', 'Working', '2024-12-11', 1046);
INSERT INTO public.inventory_healthstatusdetails VALUES (1608, 'Yes', '', 'Needs To Repair', '2024-12-12', 1056);
INSERT INTO public.inventory_healthstatusdetails VALUES (1525, 'NA', 'New Product', 'Working', '2024-06-18', 973);
INSERT INTO public.inventory_healthstatusdetails VALUES (20, 'NA', 'New Product', 'Working', '2024-04-23', 20);
INSERT INTO public.inventory_healthstatusdetails VALUES (21, 'NA', 'New Product', 'Working', '2024-04-23', 21);
INSERT INTO public.inventory_healthstatusdetails VALUES (22, 'NA', 'New Product', 'Working', '2024-04-23', 22);
INSERT INTO public.inventory_healthstatusdetails VALUES (24, 'NA', 'New Product', 'Working', '2024-04-23', 24);
INSERT INTO public.inventory_healthstatusdetails VALUES (25, 'NA', 'New Product', 'Working', '2024-04-23', 25);
INSERT INTO public.inventory_healthstatusdetails VALUES (26, 'NA', 'New Product', 'Working', '2024-04-23', 26);
INSERT INTO public.inventory_healthstatusdetails VALUES (27, 'NA', 'New Product', 'Working', '2024-04-23', 27);
INSERT INTO public.inventory_healthstatusdetails VALUES (28, 'NA', 'New Product', 'Working', '2024-04-23', 28);
INSERT INTO public.inventory_healthstatusdetails VALUES (30, 'NA', 'New Product', 'Working', '2024-04-23', 30);
INSERT INTO public.inventory_healthstatusdetails VALUES (31, 'NA', 'New Product', 'Working', '2024-04-23', 31);
INSERT INTO public.inventory_healthstatusdetails VALUES (32, 'NA', 'New Product', 'Working', '2024-04-23', 32);
INSERT INTO public.inventory_healthstatusdetails VALUES (35, 'NA', 'New Product', 'Working', '2024-04-23', 35);
INSERT INTO public.inventory_healthstatusdetails VALUES (38, 'NA', 'New Product', 'Working', '2024-04-23', 38);
INSERT INTO public.inventory_healthstatusdetails VALUES (40, 'NA', 'New Product', 'Working', '2024-04-23', 40);
INSERT INTO public.inventory_healthstatusdetails VALUES (41, 'NA', 'New Product', 'Working', '2024-04-23', 41);
INSERT INTO public.inventory_healthstatusdetails VALUES (42, 'NA', 'New Product', 'Working', '2024-04-23', 42);
INSERT INTO public.inventory_healthstatusdetails VALUES (43, 'NA', 'New Product', 'Working', '2024-04-23', 43);
INSERT INTO public.inventory_healthstatusdetails VALUES (44, 'NA', 'New Product', 'Working', '2024-04-23', 44);
INSERT INTO public.inventory_healthstatusdetails VALUES (45, 'NA', 'New Product', 'Working', '2024-04-23', 45);
INSERT INTO public.inventory_healthstatusdetails VALUES (46, 'NA', 'New Product', 'Working', '2024-04-23', 46);
INSERT INTO public.inventory_healthstatusdetails VALUES (47, 'NA', 'New Product', 'Working', '2024-04-23', 47);
INSERT INTO public.inventory_healthstatusdetails VALUES (48, 'NA', 'New Product', 'Working', '2024-04-23', 48);
INSERT INTO public.inventory_healthstatusdetails VALUES (49, 'NA', 'New Product', 'Working', '2024-04-23', 49);
INSERT INTO public.inventory_healthstatusdetails VALUES (50, 'NA', 'New Product', 'Working', '2024-04-23', 50);
INSERT INTO public.inventory_healthstatusdetails VALUES (51, 'NA', 'New Product', 'Working', '2024-04-23', 51);
INSERT INTO public.inventory_healthstatusdetails VALUES (52, 'NA', 'New Product', 'Working', '2024-04-23', 52);
INSERT INTO public.inventory_healthstatusdetails VALUES (53, 'NA', 'New Product', 'Working', '2024-04-23', 53);
INSERT INTO public.inventory_healthstatusdetails VALUES (54, 'NA', 'New Product', 'Working', '2024-04-23', 54);
INSERT INTO public.inventory_healthstatusdetails VALUES (55, 'NA', 'New Product', 'Working', '2024-04-23', 55);
INSERT INTO public.inventory_healthstatusdetails VALUES (56, 'NA', 'New Product', 'Working', '2024-04-23', 56);
INSERT INTO public.inventory_healthstatusdetails VALUES (57, 'NA', 'New Product', 'Working', '2024-04-23', 57);
INSERT INTO public.inventory_healthstatusdetails VALUES (58, 'NA', 'New Product', 'Working', '2024-04-23', 58);
INSERT INTO public.inventory_healthstatusdetails VALUES (59, 'NA', 'New Product', 'Working', '2024-04-23', 59);
INSERT INTO public.inventory_healthstatusdetails VALUES (60, 'NA', 'New Product', 'Working', '2024-04-23', 60);
INSERT INTO public.inventory_healthstatusdetails VALUES (62, 'NA', 'New Product', 'Working', '2024-04-23', 62);
INSERT INTO public.inventory_healthstatusdetails VALUES (63, 'NA', 'New Product', 'Working', '2024-04-23', 63);
INSERT INTO public.inventory_healthstatusdetails VALUES (64, 'NA', 'New Product', 'Working', '2024-04-23', 64);
INSERT INTO public.inventory_healthstatusdetails VALUES (65, 'NA', 'New Product', 'Working', '2024-04-23', 65);
INSERT INTO public.inventory_healthstatusdetails VALUES (66, 'NA', 'New Product', 'Working', '2024-04-23', 66);
INSERT INTO public.inventory_healthstatusdetails VALUES (67, 'NA', 'New Product', 'Working', '2024-04-23', 67);
INSERT INTO public.inventory_healthstatusdetails VALUES (68, 'NA', 'New Product', 'Working', '2024-04-23', 68);
INSERT INTO public.inventory_healthstatusdetails VALUES (69, 'NA', 'New Product', 'Working', '2024-04-23', 69);
INSERT INTO public.inventory_healthstatusdetails VALUES (70, 'NA', 'New Product', 'Working', '2024-04-23', 70);
INSERT INTO public.inventory_healthstatusdetails VALUES (71, 'NA', 'New Product', 'Working', '2024-04-23', 71);
INSERT INTO public.inventory_healthstatusdetails VALUES (72, 'NA', 'New Product', 'Working', '2024-04-23', 72);
INSERT INTO public.inventory_healthstatusdetails VALUES (73, 'NA', 'New Product', 'Working', '2024-04-23', 73);
INSERT INTO public.inventory_healthstatusdetails VALUES (74, 'NA', 'New Product', 'Working', '2024-04-23', 74);
INSERT INTO public.inventory_healthstatusdetails VALUES (75, 'NA', 'New Product', 'Working', '2024-04-23', 75);
INSERT INTO public.inventory_healthstatusdetails VALUES (77, 'NA', 'New Product', 'Working', '2024-04-23', 77);
INSERT INTO public.inventory_healthstatusdetails VALUES (78, 'NA', 'New Product', 'Working', '2024-04-23', 78);
INSERT INTO public.inventory_healthstatusdetails VALUES (79, 'NA', 'New Product', 'Working', '2024-04-23', 79);
INSERT INTO public.inventory_healthstatusdetails VALUES (80, 'NA', 'New Product', 'Working', '2024-04-23', 80);
INSERT INTO public.inventory_healthstatusdetails VALUES (81, 'NA', 'New Product', 'Working', '2024-04-23', 81);
INSERT INTO public.inventory_healthstatusdetails VALUES (82, 'NA', 'New Product', 'Working', '2024-04-23', 82);
INSERT INTO public.inventory_healthstatusdetails VALUES (83, 'NA', 'New Product', 'Working', '2024-04-23', 83);
INSERT INTO public.inventory_healthstatusdetails VALUES (84, 'NA', 'New Product', 'Working', '2024-04-23', 84);
INSERT INTO public.inventory_healthstatusdetails VALUES (85, 'NA', 'New Product', 'Working', '2024-04-23', 85);
INSERT INTO public.inventory_healthstatusdetails VALUES (86, 'NA', 'New Product', 'Working', '2024-04-23', 86);
INSERT INTO public.inventory_healthstatusdetails VALUES (87, 'NA', 'New Product', 'Working', '2024-04-23', 87);
INSERT INTO public.inventory_healthstatusdetails VALUES (88, 'NA', 'New Product', 'Working', '2024-04-23', 88);
INSERT INTO public.inventory_healthstatusdetails VALUES (90, 'NA', 'New Product', 'Working', '2024-04-23', 90);
INSERT INTO public.inventory_healthstatusdetails VALUES (91, 'NA', 'New Product', 'Working', '2024-04-23', 91);
INSERT INTO public.inventory_healthstatusdetails VALUES (92, 'NA', 'New Product', 'Working', '2024-04-23', 92);
INSERT INTO public.inventory_healthstatusdetails VALUES (93, 'NA', 'New Product', 'Working', '2024-04-23', 93);
INSERT INTO public.inventory_healthstatusdetails VALUES (94, 'NA', 'New Product', 'Working', '2024-04-23', 94);
INSERT INTO public.inventory_healthstatusdetails VALUES (95, 'NA', 'New Product', 'Working', '2024-04-23', 95);
INSERT INTO public.inventory_healthstatusdetails VALUES (96, 'NA', 'New Product', 'Working', '2024-04-23', 96);
INSERT INTO public.inventory_healthstatusdetails VALUES (98, 'NA', 'New Product', 'Working', '2024-04-23', 98);
INSERT INTO public.inventory_healthstatusdetails VALUES (99, 'NA', 'New Product', 'Working', '2024-04-23', 99);
INSERT INTO public.inventory_healthstatusdetails VALUES (100, 'NA', 'New Product', 'Working', '2024-04-23', 100);
INSERT INTO public.inventory_healthstatusdetails VALUES (101, 'NA', 'New Product', 'Working', '2024-04-23', 101);
INSERT INTO public.inventory_healthstatusdetails VALUES (102, 'NA', 'New Product', 'Working', '2024-04-23', 102);
INSERT INTO public.inventory_healthstatusdetails VALUES (103, 'NA', 'New Product', 'Working', '2024-04-23', 103);
INSERT INTO public.inventory_healthstatusdetails VALUES (104, 'NA', 'New Product', 'Working', '2024-04-23', 104);
INSERT INTO public.inventory_healthstatusdetails VALUES (106, 'NA', 'New Product', 'Working', '2024-04-23', 106);
INSERT INTO public.inventory_healthstatusdetails VALUES (108, 'NA', 'New Product', 'Working', '2024-04-23', 108);
INSERT INTO public.inventory_healthstatusdetails VALUES (111, 'NA', 'New Product', 'Working', '2024-04-23', 111);
INSERT INTO public.inventory_healthstatusdetails VALUES (115, 'NA', 'New Product', 'Working', '2024-04-23', 115);
INSERT INTO public.inventory_healthstatusdetails VALUES (117, 'NA', 'New Product', 'Working', '2024-04-23', 117);
INSERT INTO public.inventory_healthstatusdetails VALUES (118, 'NA', 'New Product', 'Working', '2024-04-23', 118);
INSERT INTO public.inventory_healthstatusdetails VALUES (119, 'NA', 'New Product', 'Working', '2024-04-23', 119);
INSERT INTO public.inventory_healthstatusdetails VALUES (120, 'NA', 'New Product', 'Working', '2024-04-23', 120);
INSERT INTO public.inventory_healthstatusdetails VALUES (122, 'NA', 'New Product', 'Working', '2024-04-23', 122);
INSERT INTO public.inventory_healthstatusdetails VALUES (123, 'NA', 'New Product', 'Working', '2024-04-23', 123);
INSERT INTO public.inventory_healthstatusdetails VALUES (124, 'NA', 'New Product', 'Working', '2024-04-23', 124);
INSERT INTO public.inventory_healthstatusdetails VALUES (125, 'NA', 'New Product', 'Working', '2024-04-23', 125);
INSERT INTO public.inventory_healthstatusdetails VALUES (126, 'NA', 'New Product', 'Working', '2024-04-23', 126);
INSERT INTO public.inventory_healthstatusdetails VALUES (127, 'NA', 'New Product', 'Working', '2024-04-23', 127);
INSERT INTO public.inventory_healthstatusdetails VALUES (128, 'NA', 'New Product', 'Working', '2024-04-23', 128);
INSERT INTO public.inventory_healthstatusdetails VALUES (129, 'NA', 'New Product', 'Working', '2024-04-23', 129);
INSERT INTO public.inventory_healthstatusdetails VALUES (130, 'NA', 'New Product', 'Working', '2024-04-23', 130);
INSERT INTO public.inventory_healthstatusdetails VALUES (131, 'NA', 'New Product', 'Working', '2024-04-23', 131);
INSERT INTO public.inventory_healthstatusdetails VALUES (132, 'NA', 'New Product', 'Working', '2024-04-23', 132);
INSERT INTO public.inventory_healthstatusdetails VALUES (133, 'NA', 'New Product', 'Working', '2024-04-23', 133);
INSERT INTO public.inventory_healthstatusdetails VALUES (134, 'NA', 'New Product', 'Working', '2024-04-23', 134);
INSERT INTO public.inventory_healthstatusdetails VALUES (135, 'NA', 'New Product', 'Working', '2024-04-23', 135);
INSERT INTO public.inventory_healthstatusdetails VALUES (136, 'NA', 'New Product', 'Working', '2024-04-23', 136);
INSERT INTO public.inventory_healthstatusdetails VALUES (137, 'NA', 'New Product', 'Working', '2024-04-23', 137);
INSERT INTO public.inventory_healthstatusdetails VALUES (138, 'NA', 'New Product', 'Working', '2024-04-23', 138);
INSERT INTO public.inventory_healthstatusdetails VALUES (139, 'NA', 'New Product', 'Working', '2024-04-23', 139);
INSERT INTO public.inventory_healthstatusdetails VALUES (1526, 'NA', 'New Product', 'Working', '2024-06-18', 974);
INSERT INTO public.inventory_healthstatusdetails VALUES (1527, 'NA', 'New Product', 'Working', '2024-06-19', 975);
INSERT INTO public.inventory_healthstatusdetails VALUES (1528, 'NA', 'New Product', 'Working', '2024-06-24', 976);
INSERT INTO public.inventory_healthstatusdetails VALUES (140, 'NA', 'New Product', 'Working', '2024-04-23', 140);
INSERT INTO public.inventory_healthstatusdetails VALUES (141, 'NA', 'New Product', 'Working', '2024-04-23', 141);
INSERT INTO public.inventory_healthstatusdetails VALUES (142, 'NA', 'New Product', 'Working', '2024-04-23', 142);
INSERT INTO public.inventory_healthstatusdetails VALUES (143, 'NA', 'New Product', 'Working', '2024-04-23', 143);
INSERT INTO public.inventory_healthstatusdetails VALUES (144, 'NA', 'New Product', 'Working', '2024-04-23', 144);
INSERT INTO public.inventory_healthstatusdetails VALUES (145, 'NA', 'New Product', 'Working', '2024-04-23', 145);
INSERT INTO public.inventory_healthstatusdetails VALUES (146, 'NA', 'New Product', 'Working', '2024-04-23', 146);
INSERT INTO public.inventory_healthstatusdetails VALUES (147, 'NA', 'New Product', 'Working', '2024-04-23', 147);
INSERT INTO public.inventory_healthstatusdetails VALUES (148, 'NA', 'New Product', 'Working', '2024-04-23', 148);
INSERT INTO public.inventory_healthstatusdetails VALUES (149, 'NA', 'New Product', 'Working', '2024-04-23', 149);
INSERT INTO public.inventory_healthstatusdetails VALUES (150, 'NA', 'New Product', 'Working', '2024-04-23', 150);
INSERT INTO public.inventory_healthstatusdetails VALUES (151, 'NA', 'New Product', 'Working', '2024-04-23', 151);
INSERT INTO public.inventory_healthstatusdetails VALUES (152, 'NA', 'New Product', 'Working', '2024-04-23', 152);
INSERT INTO public.inventory_healthstatusdetails VALUES (153, 'NA', 'New Product', 'Working', '2024-04-23', 153);
INSERT INTO public.inventory_healthstatusdetails VALUES (154, 'NA', 'New Product', 'Working', '2024-04-23', 154);
INSERT INTO public.inventory_healthstatusdetails VALUES (155, 'NA', 'New Product', 'Working', '2024-04-23', 155);
INSERT INTO public.inventory_healthstatusdetails VALUES (156, 'NA', 'New Product', 'Working', '2024-04-23', 156);
INSERT INTO public.inventory_healthstatusdetails VALUES (157, 'NA', 'New Product', 'Working', '2024-04-23', 157);
INSERT INTO public.inventory_healthstatusdetails VALUES (158, 'NA', 'New Product', 'Working', '2024-04-23', 158);
INSERT INTO public.inventory_healthstatusdetails VALUES (159, 'NA', 'New Product', 'Working', '2024-04-23', 159);
INSERT INTO public.inventory_healthstatusdetails VALUES (160, 'NA', 'New Product', 'Working', '2024-04-23', 160);
INSERT INTO public.inventory_healthstatusdetails VALUES (161, 'NA', 'New Product', 'Working', '2024-04-23', 161);
INSERT INTO public.inventory_healthstatusdetails VALUES (162, 'NA', 'New Product', 'Working', '2024-04-23', 162);
INSERT INTO public.inventory_healthstatusdetails VALUES (163, 'NA', 'New Product', 'Working', '2024-04-23', 163);
INSERT INTO public.inventory_healthstatusdetails VALUES (164, 'NA', 'New Product', 'Working', '2024-04-23', 164);
INSERT INTO public.inventory_healthstatusdetails VALUES (165, 'NA', 'New Product', 'Working', '2024-04-23', 165);
INSERT INTO public.inventory_healthstatusdetails VALUES (166, 'NA', 'New Product', 'Working', '2024-04-23', 166);
INSERT INTO public.inventory_healthstatusdetails VALUES (167, 'NA', 'New Product', 'Working', '2024-04-23', 167);
INSERT INTO public.inventory_healthstatusdetails VALUES (168, 'NA', 'New Product', 'Working', '2024-04-23', 168);
INSERT INTO public.inventory_healthstatusdetails VALUES (169, 'NA', 'New Product', 'Working', '2024-04-23', 169);
INSERT INTO public.inventory_healthstatusdetails VALUES (170, 'NA', 'New Product', 'Working', '2024-04-23', 170);
INSERT INTO public.inventory_healthstatusdetails VALUES (171, 'NA', 'New Product', 'Working', '2024-04-23', 171);
INSERT INTO public.inventory_healthstatusdetails VALUES (172, 'NA', 'New Product', 'Working', '2024-04-23', 172);
INSERT INTO public.inventory_healthstatusdetails VALUES (173, 'NA', 'New Product', 'Working', '2024-04-23', 173);
INSERT INTO public.inventory_healthstatusdetails VALUES (174, 'NA', 'New Product', 'Working', '2024-04-23', 174);
INSERT INTO public.inventory_healthstatusdetails VALUES (175, 'NA', 'New Product', 'Working', '2024-04-23', 175);
INSERT INTO public.inventory_healthstatusdetails VALUES (176, 'NA', 'New Product', 'Working', '2024-04-23', 176);
INSERT INTO public.inventory_healthstatusdetails VALUES (177, 'NA', 'New Product', 'Working', '2024-04-23', 177);
INSERT INTO public.inventory_healthstatusdetails VALUES (178, 'NA', 'New Product', 'Working', '2024-04-23', 178);
INSERT INTO public.inventory_healthstatusdetails VALUES (179, 'NA', 'New Product', 'Working', '2024-04-23', 179);
INSERT INTO public.inventory_healthstatusdetails VALUES (180, 'NA', 'New Product', 'Working', '2024-04-23', 180);
INSERT INTO public.inventory_healthstatusdetails VALUES (181, 'NA', 'New Product', 'Working', '2024-04-23', 181);
INSERT INTO public.inventory_healthstatusdetails VALUES (182, 'NA', 'New Product', 'Working', '2024-04-23', 182);
INSERT INTO public.inventory_healthstatusdetails VALUES (183, 'NA', 'New Product', 'Working', '2024-04-23', 183);
INSERT INTO public.inventory_healthstatusdetails VALUES (184, 'NA', 'New Product', 'Working', '2024-04-23', 184);
INSERT INTO public.inventory_healthstatusdetails VALUES (185, 'NA', 'New Product', 'Working', '2024-04-23', 185);
INSERT INTO public.inventory_healthstatusdetails VALUES (186, 'NA', 'New Product', 'Working', '2024-04-23', 186);
INSERT INTO public.inventory_healthstatusdetails VALUES (187, 'NA', 'New Product', 'Working', '2024-04-23', 187);
INSERT INTO public.inventory_healthstatusdetails VALUES (188, 'NA', 'New Product', 'Working', '2024-04-23', 188);
INSERT INTO public.inventory_healthstatusdetails VALUES (189, 'NA', 'New Product', 'Working', '2024-04-23', 189);
INSERT INTO public.inventory_healthstatusdetails VALUES (190, 'NA', 'New Product', 'Working', '2024-04-23', 190);
INSERT INTO public.inventory_healthstatusdetails VALUES (191, 'NA', 'New Product', 'Working', '2024-04-23', 191);
INSERT INTO public.inventory_healthstatusdetails VALUES (192, 'NA', 'New Product', 'Working', '2024-04-23', 192);
INSERT INTO public.inventory_healthstatusdetails VALUES (193, 'NA', 'New Product', 'Working', '2024-04-23', 193);
INSERT INTO public.inventory_healthstatusdetails VALUES (194, 'NA', 'New Product', 'Working', '2024-04-23', 194);
INSERT INTO public.inventory_healthstatusdetails VALUES (195, 'NA', 'New Product', 'Working', '2024-04-23', 195);
INSERT INTO public.inventory_healthstatusdetails VALUES (196, 'NA', 'New Product', 'Working', '2024-04-23', 196);
INSERT INTO public.inventory_healthstatusdetails VALUES (749, 'NA', 'Opened Product', 'Working', '2024-05-22', 197);
INSERT INTO public.inventory_healthstatusdetails VALUES (750, 'NA', 'Opened Product', 'Working', '2024-05-22', 198);
INSERT INTO public.inventory_healthstatusdetails VALUES (751, 'NA', 'Opened Product', 'Working', '2024-05-22', 199);
INSERT INTO public.inventory_healthstatusdetails VALUES (752, 'NA', 'Opened Product', 'Working', '2024-05-22', 200);
INSERT INTO public.inventory_healthstatusdetails VALUES (753, 'NA', 'Opened Product', 'Working', '2024-05-22', 201);
INSERT INTO public.inventory_healthstatusdetails VALUES (754, 'NA', 'Opened Product', 'Working', '2024-05-22', 202);
INSERT INTO public.inventory_healthstatusdetails VALUES (755, 'NA', 'Opened Product', 'Working', '2024-05-22', 203);
INSERT INTO public.inventory_healthstatusdetails VALUES (756, 'NA', 'Opened Product', 'Working', '2024-05-22', 204);
INSERT INTO public.inventory_healthstatusdetails VALUES (757, 'NA', 'Opened Product', 'Working', '2024-05-22', 205);
INSERT INTO public.inventory_healthstatusdetails VALUES (759, 'NA', 'Opened Product', 'Working', '2024-05-22', 207);
INSERT INTO public.inventory_healthstatusdetails VALUES (760, 'NA', 'Opened Product', 'Working', '2024-05-22', 208);
INSERT INTO public.inventory_healthstatusdetails VALUES (761, 'NA', 'Opened Product', 'Working', '2024-05-22', 209);
INSERT INTO public.inventory_healthstatusdetails VALUES (762, 'NA', 'Opened Product', 'Working', '2024-05-22', 210);
INSERT INTO public.inventory_healthstatusdetails VALUES (763, 'NA', 'Opened Product', 'Working', '2024-05-22', 211);
INSERT INTO public.inventory_healthstatusdetails VALUES (765, 'NA', 'Opened Product', 'Working', '2024-05-22', 213);
INSERT INTO public.inventory_healthstatusdetails VALUES (766, 'NA', 'Opened Product', 'Working', '2024-05-22', 214);
INSERT INTO public.inventory_healthstatusdetails VALUES (767, 'NA', 'Opened Product', 'Working', '2024-05-22', 215);
INSERT INTO public.inventory_healthstatusdetails VALUES (768, 'NA', 'Opened Product', 'Working', '2024-05-22', 216);
INSERT INTO public.inventory_healthstatusdetails VALUES (769, 'NA', 'Opened Product', 'Working', '2024-05-22', 217);
INSERT INTO public.inventory_healthstatusdetails VALUES (770, 'NA', 'Opened Product', 'Working', '2024-05-22', 218);
INSERT INTO public.inventory_healthstatusdetails VALUES (771, 'NA', 'Opened Product', 'Working', '2024-05-22', 219);
INSERT INTO public.inventory_healthstatusdetails VALUES (772, 'NA', 'Opened Product', 'Working', '2024-05-22', 220);
INSERT INTO public.inventory_healthstatusdetails VALUES (773, 'NA', 'Opened Product', 'Working', '2024-05-22', 221);
INSERT INTO public.inventory_healthstatusdetails VALUES (774, 'NA', 'Opened Product', 'Working', '2024-05-22', 222);
INSERT INTO public.inventory_healthstatusdetails VALUES (775, 'NA', 'Opened Product', 'Working', '2024-05-22', 223);
INSERT INTO public.inventory_healthstatusdetails VALUES (776, 'NA', 'Opened Product', 'Working', '2024-05-22', 224);
INSERT INTO public.inventory_healthstatusdetails VALUES (777, 'NA', 'Opened Product', 'Working', '2024-05-22', 225);
INSERT INTO public.inventory_healthstatusdetails VALUES (778, 'NA', 'Opened Product', 'Working', '2024-05-22', 226);
INSERT INTO public.inventory_healthstatusdetails VALUES (779, 'NA', 'Opened Product', 'Working', '2024-05-22', 227);
INSERT INTO public.inventory_healthstatusdetails VALUES (780, 'NA', 'Opened Product', 'Working', '2024-05-22', 228);
INSERT INTO public.inventory_healthstatusdetails VALUES (781, 'NA', 'Opened Product', 'Working', '2024-05-22', 229);
INSERT INTO public.inventory_healthstatusdetails VALUES (782, 'NA', 'Opened Product', 'Working', '2024-05-22', 230);
INSERT INTO public.inventory_healthstatusdetails VALUES (783, 'NA', 'Opened Product', 'Working', '2024-05-22', 231);
INSERT INTO public.inventory_healthstatusdetails VALUES (785, 'NA', 'Opened Product', 'Working', '2024-05-22', 233);
INSERT INTO public.inventory_healthstatusdetails VALUES (786, 'NA', 'Opened Product', 'Working', '2024-05-22', 234);
INSERT INTO public.inventory_healthstatusdetails VALUES (790, 'NA', 'Opened Product', 'Working', '2024-05-22', 238);
INSERT INTO public.inventory_healthstatusdetails VALUES (791, 'NA', 'Opened Product', 'Working', '2024-05-22', 239);
INSERT INTO public.inventory_healthstatusdetails VALUES (792, 'NA', 'Opened Product', 'Working', '2024-05-22', 240);
INSERT INTO public.inventory_healthstatusdetails VALUES (793, 'NA', 'Opened Product', 'Working', '2024-05-22', 241);
INSERT INTO public.inventory_healthstatusdetails VALUES (795, 'NA', 'Opened Product', 'Working', '2024-05-22', 243);
INSERT INTO public.inventory_healthstatusdetails VALUES (796, 'NA', 'Opened Product', 'Working', '2024-05-22', 244);
INSERT INTO public.inventory_healthstatusdetails VALUES (797, 'NA', 'Opened Product', 'Working', '2024-05-22', 245);
INSERT INTO public.inventory_healthstatusdetails VALUES (798, 'NA', 'Opened Product', 'Working', '2024-05-22', 246);
INSERT INTO public.inventory_healthstatusdetails VALUES (799, 'NA', 'Opened Product', 'Working', '2024-05-22', 247);
INSERT INTO public.inventory_healthstatusdetails VALUES (800, 'NA', 'Opened Product', 'Working', '2024-05-22', 248);
INSERT INTO public.inventory_healthstatusdetails VALUES (801, 'NA', 'Opened Product', 'Working', '2024-05-22', 249);
INSERT INTO public.inventory_healthstatusdetails VALUES (802, 'NA', 'Opened Product', 'Working', '2024-05-22', 250);
INSERT INTO public.inventory_healthstatusdetails VALUES (803, 'NA', 'Opened Product', 'Working', '2024-05-22', 251);
INSERT INTO public.inventory_healthstatusdetails VALUES (804, 'NA', 'Opened Product', 'Working', '2024-05-22', 252);
INSERT INTO public.inventory_healthstatusdetails VALUES (805, 'NA', 'Opened Product', 'Working', '2024-05-22', 253);
INSERT INTO public.inventory_healthstatusdetails VALUES (806, 'NA', 'Opened Product', 'Working', '2024-05-22', 254);
INSERT INTO public.inventory_healthstatusdetails VALUES (807, 'NA', 'Opened Product', 'Working', '2024-05-22', 255);
INSERT INTO public.inventory_healthstatusdetails VALUES (808, 'NA', 'Opened Product', 'Working', '2024-05-22', 256);
INSERT INTO public.inventory_healthstatusdetails VALUES (809, 'NA', 'Opened Product', 'Working', '2024-05-22', 257);
INSERT INTO public.inventory_healthstatusdetails VALUES (810, 'NA', 'Opened Product', 'Working', '2024-05-22', 258);
INSERT INTO public.inventory_healthstatusdetails VALUES (811, 'NA', 'Opened Product', 'Working', '2024-05-22', 259);
INSERT INTO public.inventory_healthstatusdetails VALUES (812, 'NA', 'Opened Product', 'Working', '2024-05-22', 260);
INSERT INTO public.inventory_healthstatusdetails VALUES (813, 'NA', 'Opened Product', 'Working', '2024-05-22', 261);
INSERT INTO public.inventory_healthstatusdetails VALUES (814, 'NA', 'Opened Product', 'Working', '2024-05-22', 262);
INSERT INTO public.inventory_healthstatusdetails VALUES (788, 'NA', '', 'Working', '2024-09-09', 236);
INSERT INTO public.inventory_healthstatusdetails VALUES (764, 'NA', 'Power Issue', 'Dead Stock', '2024-08-13', 212);
INSERT INTO public.inventory_healthstatusdetails VALUES (815, 'NA', 'Opened Product', 'Working', '2024-05-22', 263);
INSERT INTO public.inventory_healthstatusdetails VALUES (816, 'NA', 'Opened Product', 'Working', '2024-05-22', 264);
INSERT INTO public.inventory_healthstatusdetails VALUES (817, 'NA', 'Opened Product', 'Working', '2024-05-22', 265);
INSERT INTO public.inventory_healthstatusdetails VALUES (818, 'NA', 'Opened Product', 'Working', '2024-05-22', 266);
INSERT INTO public.inventory_healthstatusdetails VALUES (820, 'NA', 'Opened Product', 'Working', '2024-05-22', 268);
INSERT INTO public.inventory_healthstatusdetails VALUES (821, 'NA', 'Opened Product', 'Working', '2024-05-22', 269);
INSERT INTO public.inventory_healthstatusdetails VALUES (822, 'NA', 'Opened Product', 'Working', '2024-05-22', 270);
INSERT INTO public.inventory_healthstatusdetails VALUES (823, 'NA', 'Opened Product', 'Working', '2024-05-22', 271);
INSERT INTO public.inventory_healthstatusdetails VALUES (824, 'NA', 'Opened Product', 'Working', '2024-05-22', 272);
INSERT INTO public.inventory_healthstatusdetails VALUES (825, 'NA', 'Opened Product', 'Working', '2024-05-22', 273);
INSERT INTO public.inventory_healthstatusdetails VALUES (826, 'NA', 'Opened Product', 'Working', '2024-05-22', 274);
INSERT INTO public.inventory_healthstatusdetails VALUES (827, 'NA', 'Opened Product', 'Working', '2024-05-22', 275);
INSERT INTO public.inventory_healthstatusdetails VALUES (829, 'NA', 'Opened Product', 'Working', '2024-05-22', 277);
INSERT INTO public.inventory_healthstatusdetails VALUES (830, 'NA', 'Opened Product', 'Working', '2024-05-22', 278);
INSERT INTO public.inventory_healthstatusdetails VALUES (831, 'NA', 'Opened Product', 'Working', '2024-05-22', 279);
INSERT INTO public.inventory_healthstatusdetails VALUES (832, 'NA', 'Opened Product', 'Working', '2024-05-22', 280);
INSERT INTO public.inventory_healthstatusdetails VALUES (833, 'NA', 'Opened Product', 'Working', '2024-05-22', 281);
INSERT INTO public.inventory_healthstatusdetails VALUES (834, 'NA', 'Opened Product', 'Working', '2024-05-22', 282);
INSERT INTO public.inventory_healthstatusdetails VALUES (835, 'NA', 'Opened Product', 'Working', '2024-05-22', 283);
INSERT INTO public.inventory_healthstatusdetails VALUES (836, 'NA', 'Opened Product', 'Working', '2024-05-22', 284);
INSERT INTO public.inventory_healthstatusdetails VALUES (837, 'NA', 'Opened Product', 'Working', '2024-05-22', 285);
INSERT INTO public.inventory_healthstatusdetails VALUES (838, 'NA', 'Opened Product', 'Working', '2024-05-22', 286);
INSERT INTO public.inventory_healthstatusdetails VALUES (839, 'NA', 'Opened Product', 'Working', '2024-05-22', 287);
INSERT INTO public.inventory_healthstatusdetails VALUES (840, 'NA', 'Opened Product', 'Working', '2024-05-22', 288);
INSERT INTO public.inventory_healthstatusdetails VALUES (841, 'NA', 'Opened Product', 'Working', '2024-05-22', 289);
INSERT INTO public.inventory_healthstatusdetails VALUES (842, 'NA', 'Opened Product', 'Working', '2024-05-22', 290);
INSERT INTO public.inventory_healthstatusdetails VALUES (843, 'NA', 'Opened Product', 'Working', '2024-05-22', 291);
INSERT INTO public.inventory_healthstatusdetails VALUES (846, 'NA', 'Opened Product', 'Working', '2024-05-22', 294);
INSERT INTO public.inventory_healthstatusdetails VALUES (847, 'NA', 'Opened Product', 'Working', '2024-05-22', 295);
INSERT INTO public.inventory_healthstatusdetails VALUES (848, 'NA', 'Opened Product', 'Working', '2024-05-22', 296);
INSERT INTO public.inventory_healthstatusdetails VALUES (850, 'NA', 'Opened Product', 'Working', '2024-05-22', 298);
INSERT INTO public.inventory_healthstatusdetails VALUES (851, 'NA', 'Opened Product', 'Working', '2024-05-22', 299);
INSERT INTO public.inventory_healthstatusdetails VALUES (853, 'NA', 'Opened Product', 'Working', '2024-05-22', 301);
INSERT INTO public.inventory_healthstatusdetails VALUES (854, 'NA', 'Opened Product', 'Working', '2024-05-22', 302);
INSERT INTO public.inventory_healthstatusdetails VALUES (855, 'NA', 'Opened Product', 'Working', '2024-05-22', 303);
INSERT INTO public.inventory_healthstatusdetails VALUES (856, 'NA', 'Opened Product', 'Working', '2024-05-22', 304);
INSERT INTO public.inventory_healthstatusdetails VALUES (857, 'NA', 'Opened Product', 'Working', '2024-05-22', 305);
INSERT INTO public.inventory_healthstatusdetails VALUES (858, 'NA', 'Opened Product', 'Working', '2024-05-22', 306);
INSERT INTO public.inventory_healthstatusdetails VALUES (859, 'NA', 'Opened Product', 'Working', '2024-05-22', 307);
INSERT INTO public.inventory_healthstatusdetails VALUES (860, 'NA', 'Opened Product', 'Working', '2024-05-22', 308);
INSERT INTO public.inventory_healthstatusdetails VALUES (861, 'NA', 'Opened Product', 'Working', '2024-05-22', 309);
INSERT INTO public.inventory_healthstatusdetails VALUES (862, 'NA', 'Opened Product', 'Working', '2024-05-22', 310);
INSERT INTO public.inventory_healthstatusdetails VALUES (863, 'NA', 'Opened Product', 'Working', '2024-05-22', 311);
INSERT INTO public.inventory_healthstatusdetails VALUES (864, 'NA', 'Opened Product', 'Working', '2024-05-22', 312);
INSERT INTO public.inventory_healthstatusdetails VALUES (865, 'NA', 'Opened Product', 'Working', '2024-05-22', 313);
INSERT INTO public.inventory_healthstatusdetails VALUES (866, 'NA', 'Opened Product', 'Working', '2024-05-22', 314);
INSERT INTO public.inventory_healthstatusdetails VALUES (867, 'NA', 'Opened Product', 'Working', '2024-05-22', 315);
INSERT INTO public.inventory_healthstatusdetails VALUES (868, 'NA', 'Opened Product', 'Working', '2024-05-22', 316);
INSERT INTO public.inventory_healthstatusdetails VALUES (869, 'NA', 'Opened Product', 'Working', '2024-05-22', 317);
INSERT INTO public.inventory_healthstatusdetails VALUES (870, 'NA', 'Opened Product', 'Working', '2024-05-22', 318);
INSERT INTO public.inventory_healthstatusdetails VALUES (872, 'NA', 'Opened Product', 'Working', '2024-05-22', 320);
INSERT INTO public.inventory_healthstatusdetails VALUES (873, 'NA', 'Opened Product', 'Working', '2024-05-22', 321);
INSERT INTO public.inventory_healthstatusdetails VALUES (874, 'NA', 'Opened Product', 'Working', '2024-05-22', 322);
INSERT INTO public.inventory_healthstatusdetails VALUES (875, 'NA', 'Opened Product', 'Working', '2024-05-22', 323);
INSERT INTO public.inventory_healthstatusdetails VALUES (876, 'NA', 'Opened Product', 'Working', '2024-05-22', 324);
INSERT INTO public.inventory_healthstatusdetails VALUES (877, 'NA', 'Opened Product', 'Working', '2024-05-22', 325);
INSERT INTO public.inventory_healthstatusdetails VALUES (878, 'NA', 'Opened Product', 'Working', '2024-05-22', 326);
INSERT INTO public.inventory_healthstatusdetails VALUES (879, 'NA', 'Opened Product', 'Working', '2024-05-22', 327);
INSERT INTO public.inventory_healthstatusdetails VALUES (881, 'NA', 'Opened Product', 'Working', '2024-05-22', 329);
INSERT INTO public.inventory_healthstatusdetails VALUES (882, 'NA', 'Opened Product', 'Working', '2024-05-22', 330);
INSERT INTO public.inventory_healthstatusdetails VALUES (888, 'NA', 'Opened Product', 'Working', '2024-05-22', 336);
INSERT INTO public.inventory_healthstatusdetails VALUES (889, 'NA', 'Opened Product', 'Working', '2024-05-22', 337);
INSERT INTO public.inventory_healthstatusdetails VALUES (890, 'NA', 'Opened Product', 'Working', '2024-05-22', 338);
INSERT INTO public.inventory_healthstatusdetails VALUES (891, 'NA', 'Opened Product', 'Working', '2024-05-22', 339);
INSERT INTO public.inventory_healthstatusdetails VALUES (892, 'NA', 'Opened Product', 'Working', '2024-05-22', 340);
INSERT INTO public.inventory_healthstatusdetails VALUES (893, 'NA', 'Opened Product', 'Working', '2024-05-22', 341);
INSERT INTO public.inventory_healthstatusdetails VALUES (894, 'NA', 'Opened Product', 'Working', '2024-05-22', 342);
INSERT INTO public.inventory_healthstatusdetails VALUES (895, 'NA', 'Opened Product', 'Working', '2024-05-22', 343);
INSERT INTO public.inventory_healthstatusdetails VALUES (897, 'NA', 'Opened Product', 'Working', '2024-05-22', 345);
INSERT INTO public.inventory_healthstatusdetails VALUES (898, 'NA', 'Opened Product', 'Working', '2024-05-22', 346);
INSERT INTO public.inventory_healthstatusdetails VALUES (901, 'NA', 'Opened Product', 'Working', '2024-05-22', 349);
INSERT INTO public.inventory_healthstatusdetails VALUES (904, 'NA', 'Opened Product', 'Working', '2024-05-22', 352);
INSERT INTO public.inventory_healthstatusdetails VALUES (907, 'NA', 'Opened Product', 'Working', '2024-05-22', 355);
INSERT INTO public.inventory_healthstatusdetails VALUES (908, 'NA', 'Opened Product', 'Working', '2024-05-22', 356);
INSERT INTO public.inventory_healthstatusdetails VALUES (911, 'NA', 'Opened Product', 'Working', '2024-05-22', 359);
INSERT INTO public.inventory_healthstatusdetails VALUES (912, 'NA', 'Opened Product', 'Working', '2024-05-22', 360);
INSERT INTO public.inventory_healthstatusdetails VALUES (914, 'NA', 'Opened Product', 'Working', '2024-05-22', 362);
INSERT INTO public.inventory_healthstatusdetails VALUES (916, 'NA', 'Opened Product', 'Working', '2024-05-22', 364);
INSERT INTO public.inventory_healthstatusdetails VALUES (918, 'NA', 'Opened Product', 'Working', '2024-05-22', 366);
INSERT INTO public.inventory_healthstatusdetails VALUES (913, 'NA', 'Power Problem', 'Dead Stock', '2024-05-22', 361);
INSERT INTO public.inventory_healthstatusdetails VALUES (919, 'NA', 'Opened Product', 'Working', '2024-05-22', 367);
INSERT INTO public.inventory_healthstatusdetails VALUES (920, 'NA', 'Opened Product', 'Working', '2024-05-22', 368);
INSERT INTO public.inventory_healthstatusdetails VALUES (921, 'NA', 'Opened Product', 'Working', '2024-05-22', 369);
INSERT INTO public.inventory_healthstatusdetails VALUES (922, 'NA', 'Opened Product', 'Working', '2024-05-22', 370);
INSERT INTO public.inventory_healthstatusdetails VALUES (923, 'NA', 'Opened Product', 'Working', '2024-05-22', 371);
INSERT INTO public.inventory_healthstatusdetails VALUES (925, 'NA', 'Opened Product', 'Working', '2024-05-22', 373);
INSERT INTO public.inventory_healthstatusdetails VALUES (926, 'NA', 'Opened Product', 'Working', '2024-05-22', 374);
INSERT INTO public.inventory_healthstatusdetails VALUES (927, 'NA', 'Opened Product', 'Working', '2024-05-22', 375);
INSERT INTO public.inventory_healthstatusdetails VALUES (928, 'NA', 'Opened Product', 'Working', '2024-05-22', 376);
INSERT INTO public.inventory_healthstatusdetails VALUES (929, 'NA', 'Opened Product', 'Working', '2024-05-22', 377);
INSERT INTO public.inventory_healthstatusdetails VALUES (930, 'NA', 'Opened Product', 'Working', '2024-05-22', 378);
INSERT INTO public.inventory_healthstatusdetails VALUES (931, 'NA', 'Opened Product', 'Working', '2024-05-22', 379);
INSERT INTO public.inventory_healthstatusdetails VALUES (932, 'NA', 'Opened Product', 'Working', '2024-05-22', 380);
INSERT INTO public.inventory_healthstatusdetails VALUES (934, 'NA', 'Opened Product', 'Working', '2024-05-22', 382);
INSERT INTO public.inventory_healthstatusdetails VALUES (935, 'NA', 'Opened Product', 'Working', '2024-05-22', 383);
INSERT INTO public.inventory_healthstatusdetails VALUES (936, 'NA', 'Opened Product', 'Working', '2024-05-22', 384);
INSERT INTO public.inventory_healthstatusdetails VALUES (937, 'NA', 'Opened Product', 'Working', '2024-05-22', 385);
INSERT INTO public.inventory_healthstatusdetails VALUES (939, 'NA', 'Opened Product', 'Working', '2024-05-22', 387);
INSERT INTO public.inventory_healthstatusdetails VALUES (940, 'NA', 'Opened Product', 'Working', '2024-05-22', 388);
INSERT INTO public.inventory_healthstatusdetails VALUES (900, 'N', 'No Problem', 'Working', '2024-05-22', 348);
INSERT INTO public.inventory_healthstatusdetails VALUES (886, 'NA', '1N12060207 is given in alternative', 'Working', '2024-05-22', 334);
INSERT INTO public.inventory_healthstatusdetails VALUES (883, 'NA', 'Replaced with New system', 'Working', '2024-08-02', 331);
INSERT INTO public.inventory_healthstatusdetails VALUES (933, 'NA', 'Dead Stock', 'Dead Stock', '2024-08-02', 381);
INSERT INTO public.inventory_healthstatusdetails VALUES (924, 'NA', 'Dead Stock', 'Dead Stock', '2024-08-02', 372);
INSERT INTO public.inventory_healthstatusdetails VALUES (849, 'NA', 'Motherboard Issue', 'Dead Stock', '2024-08-03', 297);
INSERT INTO public.inventory_healthstatusdetails VALUES (905, 'NA', '', 'Working', '2024-05-22', 353);
INSERT INTO public.inventory_healthstatusdetails VALUES (884, 'NA', '', 'Working', '2024-09-09', 332);
INSERT INTO public.inventory_healthstatusdetails VALUES (819, 'NA', 'Screen Damaged', 'Dead Stock', '2024-08-23', 267);
INSERT INTO public.inventory_healthstatusdetails VALUES (871, 'NA', '', 'Working', '2024-08-27', 319);
INSERT INTO public.inventory_healthstatusdetails VALUES (899, 'NA', 'Head Break', 'Needs To Repair', '2024-09-24', 347);
INSERT INTO public.inventory_healthstatusdetails VALUES (938, 'NA', 'Board Problem', 'Dead Stock', '2024-10-03', 386);
INSERT INTO public.inventory_healthstatusdetails VALUES (887, 'NA', 'MotherBoard Issue', 'Dead Stock', '2024-10-05', 335);
INSERT INTO public.inventory_healthstatusdetails VALUES (852, 'NA', 'Motherboard Problem', 'Dead Stock', '2024-09-26', 300);
INSERT INTO public.inventory_healthstatusdetails VALUES (880, 'NA', 'Working', 'Working', '2024-11-25', 328);
INSERT INTO public.inventory_healthstatusdetails VALUES (903, 'NA', '', 'Working', '2024-06-25', 351);
INSERT INTO public.inventory_healthstatusdetails VALUES (917, 'NA', '', 'Needs To Repair', '2024-05-22', 365);
INSERT INTO public.inventory_healthstatusdetails VALUES (906, 'NA', '', 'Needs To Repair', '2024-05-22', 354);
INSERT INTO public.inventory_healthstatusdetails VALUES (941, 'NA', 'Opened Product', 'Working', '2024-05-22', 389);
INSERT INTO public.inventory_healthstatusdetails VALUES (942, 'NA', 'Opened Product', 'Working', '2024-05-22', 390);
INSERT INTO public.inventory_healthstatusdetails VALUES (943, 'NA', 'Opened Product', 'Working', '2024-05-22', 391);
INSERT INTO public.inventory_healthstatusdetails VALUES (944, 'NA', 'Opened Product', 'Working', '2024-05-22', 392);
INSERT INTO public.inventory_healthstatusdetails VALUES (945, 'NA', 'Opened Product', 'Working', '2024-05-22', 393);
INSERT INTO public.inventory_healthstatusdetails VALUES (946, 'NA', 'Opened Product', 'Working', '2024-05-22', 394);
INSERT INTO public.inventory_healthstatusdetails VALUES (947, 'NA', 'Opened Product', 'Working', '2024-05-22', 395);
INSERT INTO public.inventory_healthstatusdetails VALUES (948, 'NA', 'Opened Product', 'Working', '2024-05-22', 396);
INSERT INTO public.inventory_healthstatusdetails VALUES (949, 'NA', 'Opened Product', 'Working', '2024-05-22', 397);
INSERT INTO public.inventory_healthstatusdetails VALUES (950, 'NA', 'Opened Product', 'Working', '2024-05-22', 398);
INSERT INTO public.inventory_healthstatusdetails VALUES (951, 'NA', 'Opened Product', 'Working', '2024-05-22', 399);
INSERT INTO public.inventory_healthstatusdetails VALUES (952, 'NA', 'Opened Product', 'Working', '2024-05-22', 400);
INSERT INTO public.inventory_healthstatusdetails VALUES (953, 'NA', 'Opened Product', 'Working', '2024-05-22', 401);
INSERT INTO public.inventory_healthstatusdetails VALUES (954, 'NA', 'Opened Product', 'Working', '2024-05-22', 402);
INSERT INTO public.inventory_healthstatusdetails VALUES (955, 'NA', 'Opened Product', 'Working', '2024-05-22', 403);
INSERT INTO public.inventory_healthstatusdetails VALUES (956, 'NA', 'Opened Product', 'Working', '2024-05-22', 404);
INSERT INTO public.inventory_healthstatusdetails VALUES (957, 'NA', 'Opened Product', 'Working', '2024-05-22', 405);
INSERT INTO public.inventory_healthstatusdetails VALUES (958, 'NA', 'Opened Product', 'Working', '2024-05-22', 406);
INSERT INTO public.inventory_healthstatusdetails VALUES (959, 'NA', 'Opened Product', 'Working', '2024-05-22', 407);
INSERT INTO public.inventory_healthstatusdetails VALUES (960, 'NA', 'Opened Product', 'Working', '2024-05-22', 408);
INSERT INTO public.inventory_healthstatusdetails VALUES (961, 'NA', 'Opened Product', 'Working', '2024-05-22', 409);
INSERT INTO public.inventory_healthstatusdetails VALUES (962, 'NA', 'Opened Product', 'Working', '2024-05-22', 410);
INSERT INTO public.inventory_healthstatusdetails VALUES (963, 'NA', 'Opened Product', 'Working', '2024-05-22', 411);
INSERT INTO public.inventory_healthstatusdetails VALUES (964, 'NA', 'Opened Product', 'Working', '2024-05-22', 412);
INSERT INTO public.inventory_healthstatusdetails VALUES (965, 'NA', 'Opened Product', 'Working', '2024-05-22', 413);
INSERT INTO public.inventory_healthstatusdetails VALUES (966, 'NA', 'Opened Product', 'Working', '2024-05-22', 414);
INSERT INTO public.inventory_healthstatusdetails VALUES (967, 'NA', 'Opened Product', 'Working', '2024-05-22', 415);
INSERT INTO public.inventory_healthstatusdetails VALUES (968, 'NA', 'Opened Product', 'Working', '2024-05-22', 416);
INSERT INTO public.inventory_healthstatusdetails VALUES (969, 'NA', 'Opened Product', 'Working', '2024-05-22', 417);
INSERT INTO public.inventory_healthstatusdetails VALUES (970, 'NA', 'Opened Product', 'Working', '2024-05-22', 418);
INSERT INTO public.inventory_healthstatusdetails VALUES (971, 'NA', 'Opened Product', 'Working', '2024-05-22', 419);
INSERT INTO public.inventory_healthstatusdetails VALUES (972, 'NA', 'Opened Product', 'Working', '2024-05-22', 420);
INSERT INTO public.inventory_healthstatusdetails VALUES (973, 'NA', 'Opened Product', 'Working', '2024-05-22', 421);
INSERT INTO public.inventory_healthstatusdetails VALUES (974, 'NA', 'Opened Product', 'Working', '2024-05-22', 422);
INSERT INTO public.inventory_healthstatusdetails VALUES (975, 'NA', 'Opened Product', 'Working', '2024-05-22', 423);
INSERT INTO public.inventory_healthstatusdetails VALUES (976, 'NA', 'Opened Product', 'Working', '2024-05-22', 424);
INSERT INTO public.inventory_healthstatusdetails VALUES (977, 'NA', 'Opened Product', 'Working', '2024-05-22', 425);
INSERT INTO public.inventory_healthstatusdetails VALUES (978, 'NA', 'Opened Product', 'Working', '2024-05-22', 426);
INSERT INTO public.inventory_healthstatusdetails VALUES (979, 'NA', 'Opened Product', 'Working', '2024-05-22', 427);
INSERT INTO public.inventory_healthstatusdetails VALUES (980, 'NA', 'Opened Product', 'Working', '2024-05-22', 428);
INSERT INTO public.inventory_healthstatusdetails VALUES (981, 'NA', 'Opened Product', 'Working', '2024-05-22', 429);
INSERT INTO public.inventory_healthstatusdetails VALUES (982, 'NA', 'Opened Product', 'Working', '2024-05-22', 430);
INSERT INTO public.inventory_healthstatusdetails VALUES (983, 'NA', 'Opened Product', 'Working', '2024-05-22', 431);
INSERT INTO public.inventory_healthstatusdetails VALUES (984, 'NA', 'Opened Product', 'Working', '2024-05-22', 432);
INSERT INTO public.inventory_healthstatusdetails VALUES (985, 'NA', 'Opened Product', 'Working', '2024-05-22', 433);
INSERT INTO public.inventory_healthstatusdetails VALUES (986, 'NA', 'Opened Product', 'Working', '2024-05-22', 434);
INSERT INTO public.inventory_healthstatusdetails VALUES (987, 'NA', 'Opened Product', 'Working', '2024-05-22', 435);
INSERT INTO public.inventory_healthstatusdetails VALUES (989, 'NA', 'Opened Product', 'Working', '2024-05-22', 437);
INSERT INTO public.inventory_healthstatusdetails VALUES (990, 'NA', 'Opened Product', 'Working', '2024-05-22', 438);
INSERT INTO public.inventory_healthstatusdetails VALUES (993, 'NA', 'Opened Product', 'Working', '2024-05-22', 441);
INSERT INTO public.inventory_healthstatusdetails VALUES (995, 'NA', 'Opened Product', 'Working', '2024-05-22', 443);
INSERT INTO public.inventory_healthstatusdetails VALUES (996, 'NA', 'Opened Product', 'Working', '2024-05-22', 444);
INSERT INTO public.inventory_healthstatusdetails VALUES (997, 'NA', 'Opened Product', 'Working', '2024-05-22', 445);
INSERT INTO public.inventory_healthstatusdetails VALUES (998, 'NA', 'Opened Product', 'Working', '2024-05-22', 446);
INSERT INTO public.inventory_healthstatusdetails VALUES (999, 'NA', 'Opened Product', 'Working', '2024-05-22', 447);
INSERT INTO public.inventory_healthstatusdetails VALUES (1000, 'NA', 'Opened Product', 'Working', '2024-05-22', 448);
INSERT INTO public.inventory_healthstatusdetails VALUES (1001, 'NA', 'Opened Product', 'Working', '2024-05-22', 449);
INSERT INTO public.inventory_healthstatusdetails VALUES (1002, 'NA', 'Opened Product', 'Working', '2024-05-22', 450);
INSERT INTO public.inventory_healthstatusdetails VALUES (1003, 'NA', 'Opened Product', 'Working', '2024-05-22', 451);
INSERT INTO public.inventory_healthstatusdetails VALUES (1004, 'NA', 'Opened Product', 'Working', '2024-05-22', 452);
INSERT INTO public.inventory_healthstatusdetails VALUES (1005, 'NA', 'Opened Product', 'Working', '2024-05-22', 453);
INSERT INTO public.inventory_healthstatusdetails VALUES (1006, 'NA', 'Opened Product', 'Working', '2024-05-22', 454);
INSERT INTO public.inventory_healthstatusdetails VALUES (1007, 'NA', 'Opened Product', 'Working', '2024-05-22', 455);
INSERT INTO public.inventory_healthstatusdetails VALUES (1008, 'NA', 'Opened Product', 'Working', '2024-05-22', 456);
INSERT INTO public.inventory_healthstatusdetails VALUES (1009, 'NA', 'Opened Product', 'Working', '2024-05-22', 457);
INSERT INTO public.inventory_healthstatusdetails VALUES (1010, 'NA', 'Opened Product', 'Working', '2024-05-22', 458);
INSERT INTO public.inventory_healthstatusdetails VALUES (1011, 'NA', 'Opened Product', 'Working', '2024-05-22', 459);
INSERT INTO public.inventory_healthstatusdetails VALUES (1012, 'NA', 'Opened Product', 'Working', '2024-05-22', 460);
INSERT INTO public.inventory_healthstatusdetails VALUES (1013, 'NA', 'Opened Product', 'Working', '2024-05-22', 461);
INSERT INTO public.inventory_healthstatusdetails VALUES (1014, 'NA', 'Opened Product', 'Working', '2024-05-22', 462);
INSERT INTO public.inventory_healthstatusdetails VALUES (1015, 'NA', 'Opened Product', 'Working', '2024-05-22', 463);
INSERT INTO public.inventory_healthstatusdetails VALUES (1016, 'NA', 'Opened Product', 'Working', '2024-05-22', 464);
INSERT INTO public.inventory_healthstatusdetails VALUES (1017, 'NA', 'Opened Product', 'Working', '2024-05-22', 465);
INSERT INTO public.inventory_healthstatusdetails VALUES (1018, 'NA', 'Opened Product', 'Working', '2024-05-22', 466);
INSERT INTO public.inventory_healthstatusdetails VALUES (1019, 'NA', 'Opened Product', 'Working', '2024-05-22', 467);
INSERT INTO public.inventory_healthstatusdetails VALUES (1020, 'NA', 'Opened Product', 'Working', '2024-05-22', 468);
INSERT INTO public.inventory_healthstatusdetails VALUES (1021, 'NA', 'Opened Product', 'Working', '2024-05-22', 469);
INSERT INTO public.inventory_healthstatusdetails VALUES (1022, 'NA', 'Opened Product', 'Working', '2024-05-22', 470);
INSERT INTO public.inventory_healthstatusdetails VALUES (1023, 'NA', 'Opened Product', 'Working', '2024-05-22', 471);
INSERT INTO public.inventory_healthstatusdetails VALUES (1024, 'NA', 'New Product', 'Working', '2024-05-23', 472);
INSERT INTO public.inventory_healthstatusdetails VALUES (1034, 'NA', 'New Product', 'Working', '2024-05-23', 482);
INSERT INTO public.inventory_healthstatusdetails VALUES (1035, 'NA', 'New Product', 'Working', '2024-05-23', 483);
INSERT INTO public.inventory_healthstatusdetails VALUES (1036, 'NA', 'New Product', 'Working', '2024-05-23', 484);
INSERT INTO public.inventory_healthstatusdetails VALUES (1038, 'NA', 'New Product', 'Working', '2024-05-23', 486);
INSERT INTO public.inventory_healthstatusdetails VALUES (1039, 'NA', 'New Product', 'Working', '2024-05-23', 487);
INSERT INTO public.inventory_healthstatusdetails VALUES (1041, 'NA', 'New Product', 'Working', '2024-04-23', 489);
INSERT INTO public.inventory_healthstatusdetails VALUES (1043, 'NA', 'New Product', 'Working', '2024-05-24', 491);
INSERT INTO public.inventory_healthstatusdetails VALUES (1044, 'NA', 'Opened Product', 'Working', '2024-05-25', 492);
INSERT INTO public.inventory_healthstatusdetails VALUES (1045, 'NA', 'Opened Product', 'Working', '2024-05-25', 493);
INSERT INTO public.inventory_healthstatusdetails VALUES (1046, 'NA', 'Opened Product', 'Working', '2024-05-25', 494);
INSERT INTO public.inventory_healthstatusdetails VALUES (1047, 'NA', 'Opened Product', 'Working', '2024-05-25', 495);
INSERT INTO public.inventory_healthstatusdetails VALUES (1048, 'NA', 'Opened Product', 'Working', '2024-05-25', 496);
INSERT INTO public.inventory_healthstatusdetails VALUES (1049, 'NA', 'Opened Product', 'Working', '2024-05-25', 497);
INSERT INTO public.inventory_healthstatusdetails VALUES (1050, 'NA', 'Opened Product', 'Working', '2024-05-25', 498);
INSERT INTO public.inventory_healthstatusdetails VALUES (1051, 'NA', 'Opened Product', 'Working', '2024-05-25', 499);
INSERT INTO public.inventory_healthstatusdetails VALUES (1052, 'NA', 'Opened Product', 'Working', '2024-05-25', 500);
INSERT INTO public.inventory_healthstatusdetails VALUES (1053, 'NA', 'Opened Product', 'Working', '2024-05-25', 501);
INSERT INTO public.inventory_healthstatusdetails VALUES (1055, 'NA', 'Opened Product', 'Working', '2024-05-25', 503);
INSERT INTO public.inventory_healthstatusdetails VALUES (1056, 'NA', 'Opened Product', 'Working', '2024-05-25', 504);
INSERT INTO public.inventory_healthstatusdetails VALUES (1057, 'NA', 'Opened Product', 'Working', '2024-05-25', 505);
INSERT INTO public.inventory_healthstatusdetails VALUES (1058, 'NA', 'Opened Product', 'Working', '2024-05-25', 506);
INSERT INTO public.inventory_healthstatusdetails VALUES (1059, 'NA', 'Opened Product', 'Working', '2024-05-25', 507);
INSERT INTO public.inventory_healthstatusdetails VALUES (1060, 'NA', 'Opened Product', 'Working', '2024-05-25', 508);
INSERT INTO public.inventory_healthstatusdetails VALUES (1061, 'NA', 'Opened Product', 'Working', '2024-05-25', 509);
INSERT INTO public.inventory_healthstatusdetails VALUES (1062, 'NA', 'Opened Product', 'Working', '2024-05-25', 510);
INSERT INTO public.inventory_healthstatusdetails VALUES (1063, 'NA', 'Opened Product', 'Working', '2024-05-25', 511);
INSERT INTO public.inventory_healthstatusdetails VALUES (1064, 'NA', 'Opened Product', 'Working', '2024-05-25', 512);
INSERT INTO public.inventory_healthstatusdetails VALUES (1033, 'NA', '', 'Working', '2024-10-08', 481);
INSERT INTO public.inventory_healthstatusdetails VALUES (1037, 'NA', 'Working', 'Working', '2024-08-01', 485);
INSERT INTO public.inventory_healthstatusdetails VALUES (1032, 'NA', '', 'Working', '2024-09-30', 480);
INSERT INTO public.inventory_healthstatusdetails VALUES (1054, 'NA', 'Power Issue', 'Needs To Repair', '2024-05-25', 502);
INSERT INTO public.inventory_healthstatusdetails VALUES (1025, 'NA', '', 'Working', '2024-09-09', 473);
INSERT INTO public.inventory_healthstatusdetails VALUES (1028, 'NA', '', 'Working', '2024-09-30', 476);
INSERT INTO public.inventory_healthstatusdetails VALUES (1027, 'NA', '', 'Working', '2024-10-05', 475);
INSERT INTO public.inventory_healthstatusdetails VALUES (1029, 'NA', 'Button Jam', 'Working', '2024-09-05', 477);
INSERT INTO public.inventory_healthstatusdetails VALUES (1026, 'NA', '', 'Working', '2024-10-05', 474);
INSERT INTO public.inventory_healthstatusdetails VALUES (1065, 'NA', 'Opened Product', 'Working', '2024-05-25', 513);
INSERT INTO public.inventory_healthstatusdetails VALUES (1066, 'NA', 'Opened Product', 'Working', '2024-05-25', 514);
INSERT INTO public.inventory_healthstatusdetails VALUES (1067, 'NA', 'Opened Product', 'Working', '2024-05-25', 515);
INSERT INTO public.inventory_healthstatusdetails VALUES (1068, 'NA', 'Opened Product', 'Working', '2024-05-25', 516);
INSERT INTO public.inventory_healthstatusdetails VALUES (1069, 'NA', 'Opened Product', 'Working', '2024-05-25', 517);
INSERT INTO public.inventory_healthstatusdetails VALUES (1070, 'NA', 'Opened Product', 'Working', '2024-05-25', 518);
INSERT INTO public.inventory_healthstatusdetails VALUES (1071, 'NA', 'Opened Product', 'Working', '2024-05-25', 519);
INSERT INTO public.inventory_healthstatusdetails VALUES (1072, 'NA', 'Opened Product', 'Working', '2024-05-25', 520);
INSERT INTO public.inventory_healthstatusdetails VALUES (1073, 'NA', 'Opened Product', 'Working', '2024-05-25', 521);
INSERT INTO public.inventory_healthstatusdetails VALUES (1074, 'NA', 'Opened Product', 'Working', '2024-05-25', 522);
INSERT INTO public.inventory_healthstatusdetails VALUES (1075, 'NA', 'Opened Product', 'Working', '2024-05-25', 523);
INSERT INTO public.inventory_healthstatusdetails VALUES (1076, 'NA', 'Opened Product', 'Working', '2024-05-25', 524);
INSERT INTO public.inventory_healthstatusdetails VALUES (1077, 'NA', 'Opened Product', 'Working', '2024-05-25', 525);
INSERT INTO public.inventory_healthstatusdetails VALUES (1078, 'NA', 'Opened Product', 'Working', '2024-05-25', 526);
INSERT INTO public.inventory_healthstatusdetails VALUES (1079, 'NA', 'Opened Product', 'Working', '2024-05-25', 527);
INSERT INTO public.inventory_healthstatusdetails VALUES (1080, 'NA', 'Opened Product', 'Working', '2024-05-25', 528);
INSERT INTO public.inventory_healthstatusdetails VALUES (1081, 'NA', 'Opened Product', 'Working', '2024-05-25', 529);
INSERT INTO public.inventory_healthstatusdetails VALUES (1082, 'NA', 'Opened Product', 'Working', '2024-05-25', 530);
INSERT INTO public.inventory_healthstatusdetails VALUES (1083, 'NA', 'Opened Product', 'Working', '2024-05-25', 531);
INSERT INTO public.inventory_healthstatusdetails VALUES (1085, 'NA', 'Opened Product', 'Working', '2024-05-25', 533);
INSERT INTO public.inventory_healthstatusdetails VALUES (1086, 'NA', 'Opened Product', 'Working', '2024-05-25', 534);
INSERT INTO public.inventory_healthstatusdetails VALUES (1087, 'NA', 'Opened Product', 'Working', '2024-05-25', 535);
INSERT INTO public.inventory_healthstatusdetails VALUES (1088, 'NA', 'Opened Product', 'Working', '2024-05-25', 536);
INSERT INTO public.inventory_healthstatusdetails VALUES (1089, 'NA', 'Opened Product', 'Working', '2024-05-25', 537);
INSERT INTO public.inventory_healthstatusdetails VALUES (1091, 'NA', 'Opened Product', 'Working', '2024-05-25', 539);
INSERT INTO public.inventory_healthstatusdetails VALUES (1092, 'NA', 'Opened Product', 'Working', '2024-05-25', 540);
INSERT INTO public.inventory_healthstatusdetails VALUES (1093, 'NA', 'Opened Product', 'Working', '2024-05-25', 541);
INSERT INTO public.inventory_healthstatusdetails VALUES (1094, 'NA', 'Opened Product', 'Working', '2024-05-25', 542);
INSERT INTO public.inventory_healthstatusdetails VALUES (1095, 'NA', 'Opened Product', 'Working', '2024-05-25', 543);
INSERT INTO public.inventory_healthstatusdetails VALUES (1096, 'NA', 'Opened Product', 'Working', '2024-05-25', 544);
INSERT INTO public.inventory_healthstatusdetails VALUES (1097, 'NA', 'Opened Product', 'Working', '2024-05-25', 545);
INSERT INTO public.inventory_healthstatusdetails VALUES (1098, 'NA', 'Opened Product', 'Working', '2024-05-25', 546);
INSERT INTO public.inventory_healthstatusdetails VALUES (1099, 'NA', 'Opened Product', 'Working', '2024-05-25', 547);
INSERT INTO public.inventory_healthstatusdetails VALUES (1100, 'NA', 'Opened Product', 'Working', '2024-05-25', 548);
INSERT INTO public.inventory_healthstatusdetails VALUES (1101, 'NA', 'Opened Product', 'Working', '2024-05-25', 549);
INSERT INTO public.inventory_healthstatusdetails VALUES (1102, 'NA', 'Opened Product', 'Working', '2024-05-25', 550);
INSERT INTO public.inventory_healthstatusdetails VALUES (1103, 'NA', 'Opened Product', 'Working', '2024-05-25', 551);
INSERT INTO public.inventory_healthstatusdetails VALUES (1105, 'NA', 'Opened Product', 'Working', '2024-05-25', 553);
INSERT INTO public.inventory_healthstatusdetails VALUES (1106, 'NA', 'Opened Product', 'Working', '2024-05-25', 554);
INSERT INTO public.inventory_healthstatusdetails VALUES (1107, 'NA', 'Opened Product', 'Working', '2024-05-25', 555);
INSERT INTO public.inventory_healthstatusdetails VALUES (1108, 'NA', 'Opened Product', 'Working', '2024-05-25', 556);
INSERT INTO public.inventory_healthstatusdetails VALUES (1110, 'NA', 'Opened Product', 'Working', '2024-05-25', 558);
INSERT INTO public.inventory_healthstatusdetails VALUES (1111, 'NA', 'Opened Product', 'Working', '2024-05-25', 559);
INSERT INTO public.inventory_healthstatusdetails VALUES (1112, 'NA', 'Opened Product', 'Working', '2024-05-25', 560);
INSERT INTO public.inventory_healthstatusdetails VALUES (1113, 'NA', 'Opened Product', 'Working', '2024-05-25', 561);
INSERT INTO public.inventory_healthstatusdetails VALUES (1114, 'NA', 'Opened Product', 'Working', '2024-05-25', 562);
INSERT INTO public.inventory_healthstatusdetails VALUES (1115, 'NA', 'Opened Product', 'Working', '2024-05-25', 563);
INSERT INTO public.inventory_healthstatusdetails VALUES (1117, 'NA', 'Opened Product', 'Working', '2024-05-25', 565);
INSERT INTO public.inventory_healthstatusdetails VALUES (1118, 'NA', 'Opened Product', 'Working', '2024-05-25', 566);
INSERT INTO public.inventory_healthstatusdetails VALUES (1119, 'NA', 'Opened Product', 'Working', '2024-05-25', 567);
INSERT INTO public.inventory_healthstatusdetails VALUES (1120, 'NA', 'Opened Product', 'Working', '2024-05-25', 568);
INSERT INTO public.inventory_healthstatusdetails VALUES (1121, 'NA', 'Opened Product', 'Working', '2024-05-25', 569);
INSERT INTO public.inventory_healthstatusdetails VALUES (1122, 'NA', 'Opened Product', 'Working', '2024-05-25', 570);
INSERT INTO public.inventory_healthstatusdetails VALUES (1123, 'NA', 'Opened Product', 'Working', '2024-05-25', 571);
INSERT INTO public.inventory_healthstatusdetails VALUES (1124, 'NA', 'Opened Product', 'Working', '2024-05-25', 572);
INSERT INTO public.inventory_healthstatusdetails VALUES (1125, 'NA', 'Opened Product', 'Working', '2024-05-25', 573);
INSERT INTO public.inventory_healthstatusdetails VALUES (1126, 'NA', 'Opened Product', 'Working', '2024-05-25', 574);
INSERT INTO public.inventory_healthstatusdetails VALUES (1127, 'NA', 'Opened Product', 'Working', '2024-05-25', 575);
INSERT INTO public.inventory_healthstatusdetails VALUES (1128, 'NA', 'Opened Product', 'Working', '2024-05-25', 576);
INSERT INTO public.inventory_healthstatusdetails VALUES (1129, 'NA', 'Opened Product', 'Working', '2024-05-25', 577);
INSERT INTO public.inventory_healthstatusdetails VALUES (1130, 'NA', 'Opened Product', 'Working', '2024-05-25', 578);
INSERT INTO public.inventory_healthstatusdetails VALUES (1131, 'NA', 'Opened Product', 'Working', '2024-05-25', 579);
INSERT INTO public.inventory_healthstatusdetails VALUES (1132, 'NA', 'Opened Product', 'Working', '2024-05-25', 580);
INSERT INTO public.inventory_healthstatusdetails VALUES (1133, 'NA', 'Opened Product', 'Working', '2024-05-25', 581);
INSERT INTO public.inventory_healthstatusdetails VALUES (1134, 'NA', 'Opened Product', 'Working', '2024-05-25', 582);
INSERT INTO public.inventory_healthstatusdetails VALUES (1135, 'NA', 'Opened Product', 'Working', '2024-05-25', 583);
INSERT INTO public.inventory_healthstatusdetails VALUES (1136, 'NA', 'Opened Product', 'Working', '2024-05-25', 584);
INSERT INTO public.inventory_healthstatusdetails VALUES (1137, 'NA', 'Opened Product', 'Working', '2024-05-25', 585);
INSERT INTO public.inventory_healthstatusdetails VALUES (1138, 'NA', 'Opened Product', 'Working', '2024-05-25', 586);
INSERT INTO public.inventory_healthstatusdetails VALUES (1139, 'NA', 'Opened Product', 'Working', '2024-05-25', 587);
INSERT INTO public.inventory_healthstatusdetails VALUES (1140, 'NA', 'Opened Product', 'Working', '2024-05-25', 588);
INSERT INTO public.inventory_healthstatusdetails VALUES (1141, 'NA', 'Opened Product', 'Working', '2024-05-25', 589);
INSERT INTO public.inventory_healthstatusdetails VALUES (1142, 'NA', 'Opened Product', 'Working', '2024-05-25', 590);
INSERT INTO public.inventory_healthstatusdetails VALUES (1143, 'NA', 'Opened Product', 'Working', '2024-05-25', 591);
INSERT INTO public.inventory_healthstatusdetails VALUES (1144, 'NA', 'Opened Product', 'Working', '2024-05-25', 592);
INSERT INTO public.inventory_healthstatusdetails VALUES (1145, 'NA', 'Opened Product', 'Working', '2024-05-25', 593);
INSERT INTO public.inventory_healthstatusdetails VALUES (1146, 'NA', 'Opened Product', 'Working', '2024-05-25', 594);
INSERT INTO public.inventory_healthstatusdetails VALUES (1147, 'NA', 'Opened Product', 'Working', '2024-05-25', 595);
INSERT INTO public.inventory_healthstatusdetails VALUES (1148, 'NA', 'Opened Product', 'Working', '2024-05-25', 596);
INSERT INTO public.inventory_healthstatusdetails VALUES (1149, 'NA', 'Opened Product', 'Working', '2024-05-25', 597);
INSERT INTO public.inventory_healthstatusdetails VALUES (1150, 'NA', 'Opened Product', 'Working', '2024-05-25', 598);
INSERT INTO public.inventory_healthstatusdetails VALUES (1151, 'NA', 'Opened Product', 'Working', '2024-05-25', 599);
INSERT INTO public.inventory_healthstatusdetails VALUES (1152, 'NA', 'Opened Product', 'Working', '2024-05-25', 600);
INSERT INTO public.inventory_healthstatusdetails VALUES (1153, 'NA', 'Opened Product', 'Working', '2024-05-25', 601);
INSERT INTO public.inventory_healthstatusdetails VALUES (1154, 'NA', 'Opened Product', 'Working', '2024-05-25', 602);
INSERT INTO public.inventory_healthstatusdetails VALUES (1155, 'NA', 'Opened Product', 'Working', '2024-05-25', 603);
INSERT INTO public.inventory_healthstatusdetails VALUES (1156, 'NA', 'Opened Product', 'Working', '2024-05-25', 604);
INSERT INTO public.inventory_healthstatusdetails VALUES (1157, 'NA', 'New Product', 'Working', '2024-05-26', 605);
INSERT INTO public.inventory_healthstatusdetails VALUES (1158, 'NA', 'New Product', 'Working', '2024-05-26', 606);
INSERT INTO public.inventory_healthstatusdetails VALUES (1159, 'NA', 'New Product', 'Working', '2024-05-28', 607);
INSERT INTO public.inventory_healthstatusdetails VALUES (1160, 'NA', 'New Product', 'Working', '2024-05-28', 608);
INSERT INTO public.inventory_healthstatusdetails VALUES (1161, 'NA', 'New Product', 'Working', '2024-05-28', 609);
INSERT INTO public.inventory_healthstatusdetails VALUES (1162, 'NA', 'New Product', 'Working', '2024-05-28', 610);
INSERT INTO public.inventory_healthstatusdetails VALUES (1163, 'NA', 'New Product', 'Working', '2024-05-28', 611);
INSERT INTO public.inventory_healthstatusdetails VALUES (1165, 'NA', 'New Product', 'Working', '2024-05-28', 613);
INSERT INTO public.inventory_healthstatusdetails VALUES (1166, 'NA', 'New Product', 'Working', '2024-05-28', 614);
INSERT INTO public.inventory_healthstatusdetails VALUES (1167, 'NA', 'New Product', 'Working', '2024-05-28', 615);
INSERT INTO public.inventory_healthstatusdetails VALUES (1168, 'NA', 'New Product', 'Working', '2024-05-28', 616);
INSERT INTO public.inventory_healthstatusdetails VALUES (1169, 'NA', 'New Product', 'Working', '2024-05-28', 617);
INSERT INTO public.inventory_healthstatusdetails VALUES (1170, 'NA', 'New Product', 'Working', '2024-05-28', 618);
INSERT INTO public.inventory_healthstatusdetails VALUES (1171, 'NA', 'New Product', 'Working', '2024-05-28', 619);
INSERT INTO public.inventory_healthstatusdetails VALUES (1172, 'NA', 'New Product', 'Working', '2024-05-28', 620);
INSERT INTO public.inventory_healthstatusdetails VALUES (1173, 'NA', 'New Product', 'Working', '2024-05-28', 621);
INSERT INTO public.inventory_healthstatusdetails VALUES (1174, 'NA', 'New Product', 'Working', '2024-05-28', 622);
INSERT INTO public.inventory_healthstatusdetails VALUES (1175, 'NA', 'New Product', 'Working', '2024-05-28', 623);
INSERT INTO public.inventory_healthstatusdetails VALUES (1176, 'NA', 'New Product', 'Working', '2024-05-28', 624);
INSERT INTO public.inventory_healthstatusdetails VALUES (1177, 'NA', 'Opened Product', 'Working', '2024-06-14', 625);
INSERT INTO public.inventory_healthstatusdetails VALUES (1178, 'NA', 'Opened Product', 'Working', '2024-06-14', 626);
INSERT INTO public.inventory_healthstatusdetails VALUES (1179, 'NA', 'Opened Product', 'Working', '2024-06-14', 627);
INSERT INTO public.inventory_healthstatusdetails VALUES (1180, 'NA', 'Opened Product', 'Working', '2024-06-14', 628);
INSERT INTO public.inventory_healthstatusdetails VALUES (1181, 'NA', 'Opened Product', 'Working', '2024-06-14', 629);
INSERT INTO public.inventory_healthstatusdetails VALUES (1182, 'NA', 'Opened Product', 'Working', '2024-06-14', 630);
INSERT INTO public.inventory_healthstatusdetails VALUES (1183, 'NA', 'Opened Product', 'Working', '2024-06-14', 631);
INSERT INTO public.inventory_healthstatusdetails VALUES (1184, 'NA', 'Opened Product', 'Working', '2024-06-14', 632);
INSERT INTO public.inventory_healthstatusdetails VALUES (1185, 'NA', 'Opened Product', 'Working', '2024-06-14', 633);
INSERT INTO public.inventory_healthstatusdetails VALUES (1186, 'NA', 'Opened Product', 'Working', '2024-06-14', 634);
INSERT INTO public.inventory_healthstatusdetails VALUES (1187, 'NA', 'Opened Product', 'Working', '2024-06-14', 635);
INSERT INTO public.inventory_healthstatusdetails VALUES (1188, 'NA', 'Opened Product', 'Working', '2024-06-14', 636);
INSERT INTO public.inventory_healthstatusdetails VALUES (1104, 'NA', 'Working', 'Working', '2024-11-25', 552);
INSERT INTO public.inventory_healthstatusdetails VALUES (1189, 'NA', 'Opened Product', 'Working', '2024-06-14', 637);
INSERT INTO public.inventory_healthstatusdetails VALUES (1190, 'NA', 'Opened Product', 'Working', '2024-06-14', 638);
INSERT INTO public.inventory_healthstatusdetails VALUES (1191, 'NA', 'Opened Product', 'Working', '2024-06-14', 639);
INSERT INTO public.inventory_healthstatusdetails VALUES (1192, 'NA', 'Opened Product', 'Working', '2024-06-14', 640);
INSERT INTO public.inventory_healthstatusdetails VALUES (1193, 'NA', 'Opened Product', 'Working', '2024-06-14', 641);
INSERT INTO public.inventory_healthstatusdetails VALUES (1194, 'NA', 'Opened Product', 'Working', '2024-06-14', 642);
INSERT INTO public.inventory_healthstatusdetails VALUES (1195, 'NA', 'Opened Product', 'Working', '2024-06-14', 643);
INSERT INTO public.inventory_healthstatusdetails VALUES (1196, 'NA', 'Opened Product', 'Working', '2024-06-14', 644);
INSERT INTO public.inventory_healthstatusdetails VALUES (1198, 'NA', 'Opened Product', 'Working', '2024-06-14', 646);
INSERT INTO public.inventory_healthstatusdetails VALUES (1199, 'NA', 'Opened Product', 'Working', '2024-06-14', 647);
INSERT INTO public.inventory_healthstatusdetails VALUES (1201, 'NA', 'Opened Product', 'Working', '2024-06-14', 649);
INSERT INTO public.inventory_healthstatusdetails VALUES (1202, 'NA', 'Opened Product', 'Working', '2024-06-14', 650);
INSERT INTO public.inventory_healthstatusdetails VALUES (1203, 'NA', 'Opened Product', 'Working', '2024-06-14', 651);
INSERT INTO public.inventory_healthstatusdetails VALUES (1204, 'NA', 'Opened Product', 'Working', '2024-06-14', 652);
INSERT INTO public.inventory_healthstatusdetails VALUES (1205, 'NA', 'Opened Product', 'Working', '2024-06-14', 653);
INSERT INTO public.inventory_healthstatusdetails VALUES (1206, 'NA', 'Opened Product', 'Working', '2024-06-14', 654);
INSERT INTO public.inventory_healthstatusdetails VALUES (1207, 'NA', 'Opened Product', 'Working', '2024-06-14', 655);
INSERT INTO public.inventory_healthstatusdetails VALUES (1208, 'NA', 'Opened Product', 'Working', '2024-06-14', 656);
INSERT INTO public.inventory_healthstatusdetails VALUES (1209, 'NA', 'Opened Product', 'Working', '2024-06-14', 657);
INSERT INTO public.inventory_healthstatusdetails VALUES (1210, 'NA', 'Opened Product', 'Working', '2024-06-14', 658);
INSERT INTO public.inventory_healthstatusdetails VALUES (1211, 'NA', 'Opened Product', 'Working', '2024-06-14', 659);
INSERT INTO public.inventory_healthstatusdetails VALUES (1212, 'NA', 'Opened Product', 'Working', '2024-06-14', 660);
INSERT INTO public.inventory_healthstatusdetails VALUES (1213, 'NA', 'Opened Product', 'Working', '2024-06-14', 661);
INSERT INTO public.inventory_healthstatusdetails VALUES (1214, 'NA', 'Opened Product', 'Working', '2024-06-14', 662);
INSERT INTO public.inventory_healthstatusdetails VALUES (1215, 'NA', 'Opened Product', 'Working', '2024-06-14', 663);
INSERT INTO public.inventory_healthstatusdetails VALUES (1216, 'NA', 'Opened Product', 'Working', '2024-06-14', 664);
INSERT INTO public.inventory_healthstatusdetails VALUES (1217, 'NA', 'Opened Product', 'Working', '2024-06-14', 665);
INSERT INTO public.inventory_healthstatusdetails VALUES (1218, 'NA', 'Opened Product', 'Working', '2024-06-14', 666);
INSERT INTO public.inventory_healthstatusdetails VALUES (1219, 'NA', 'Opened Product', 'Working', '2024-06-14', 667);
INSERT INTO public.inventory_healthstatusdetails VALUES (1220, 'NA', 'Opened Product', 'Working', '2024-06-14', 668);
INSERT INTO public.inventory_healthstatusdetails VALUES (1221, 'NA', 'Opened Product', 'Working', '2024-06-14', 669);
INSERT INTO public.inventory_healthstatusdetails VALUES (1222, 'NA', 'Opened Product', 'Working', '2024-06-14', 670);
INSERT INTO public.inventory_healthstatusdetails VALUES (1223, 'NA', 'Opened Product', 'Working', '2024-06-14', 671);
INSERT INTO public.inventory_healthstatusdetails VALUES (1224, 'NA', 'Opened Product', 'Working', '2024-06-14', 672);
INSERT INTO public.inventory_healthstatusdetails VALUES (1226, 'NA', 'Opened Product', 'Working', '2024-06-14', 674);
INSERT INTO public.inventory_healthstatusdetails VALUES (1227, 'NA', 'Opened Product', 'Working', '2024-06-14', 675);
INSERT INTO public.inventory_healthstatusdetails VALUES (1228, 'NA', 'Opened Product', 'Working', '2024-06-14', 676);
INSERT INTO public.inventory_healthstatusdetails VALUES (1229, 'NA', 'Opened Product', 'Working', '2024-06-14', 677);
INSERT INTO public.inventory_healthstatusdetails VALUES (1230, 'NA', 'Opened Product', 'Working', '2024-06-14', 678);
INSERT INTO public.inventory_healthstatusdetails VALUES (1231, 'NA', 'Opened Product', 'Working', '2024-06-14', 679);
INSERT INTO public.inventory_healthstatusdetails VALUES (1232, 'NA', 'Opened Product', 'Working', '2024-06-14', 680);
INSERT INTO public.inventory_healthstatusdetails VALUES (1233, 'NA', 'Opened Product', 'Working', '2024-06-14', 681);
INSERT INTO public.inventory_healthstatusdetails VALUES (1234, 'NA', 'Opened Product', 'Working', '2024-06-14', 682);
INSERT INTO public.inventory_healthstatusdetails VALUES (1235, 'NA', 'Opened Product', 'Working', '2024-06-14', 683);
INSERT INTO public.inventory_healthstatusdetails VALUES (1236, 'NA', 'Opened Product', 'Working', '2024-06-14', 684);
INSERT INTO public.inventory_healthstatusdetails VALUES (1237, 'NA', 'Opened Product', 'Working', '2024-06-14', 685);
INSERT INTO public.inventory_healthstatusdetails VALUES (1238, 'NA', 'Opened Product', 'Working', '2024-06-14', 686);
INSERT INTO public.inventory_healthstatusdetails VALUES (1239, 'NA', 'Opened Product', 'Working', '2024-06-14', 687);
INSERT INTO public.inventory_healthstatusdetails VALUES (1241, 'NA', 'Opened Product', 'Working', '2024-06-14', 689);
INSERT INTO public.inventory_healthstatusdetails VALUES (1242, 'NA', 'Opened Product', 'Working', '2024-06-14', 690);
INSERT INTO public.inventory_healthstatusdetails VALUES (1243, 'NA', 'Opened Product', 'Working', '2024-06-14', 691);
INSERT INTO public.inventory_healthstatusdetails VALUES (1244, 'NA', 'Opened Product', 'Working', '2024-06-14', 692);
INSERT INTO public.inventory_healthstatusdetails VALUES (1245, 'NA', 'Opened Product', 'Working', '2024-06-14', 693);
INSERT INTO public.inventory_healthstatusdetails VALUES (1246, 'NA', 'Opened Product', 'Working', '2024-06-14', 694);
INSERT INTO public.inventory_healthstatusdetails VALUES (1247, 'NA', 'Opened Product', 'Working', '2024-06-14', 695);
INSERT INTO public.inventory_healthstatusdetails VALUES (1248, 'NA', 'Opened Product', 'Working', '2024-06-14', 696);
INSERT INTO public.inventory_healthstatusdetails VALUES (1249, 'NA', 'Opened Product', 'Working', '2024-06-14', 697);
INSERT INTO public.inventory_healthstatusdetails VALUES (1250, 'NA', 'Opened Product', 'Working', '2024-06-14', 698);
INSERT INTO public.inventory_healthstatusdetails VALUES (1251, 'NA', 'Opened Product', 'Working', '2024-06-14', 699);
INSERT INTO public.inventory_healthstatusdetails VALUES (1252, 'NA', 'Opened Product', 'Working', '2024-06-14', 700);
INSERT INTO public.inventory_healthstatusdetails VALUES (1253, 'NA', 'Opened Product', 'Working', '2024-06-14', 701);
INSERT INTO public.inventory_healthstatusdetails VALUES (1254, 'NA', 'Opened Product', 'Working', '2024-06-14', 702);
INSERT INTO public.inventory_healthstatusdetails VALUES (1255, 'NA', 'Opened Product', 'Working', '2024-06-14', 703);
INSERT INTO public.inventory_healthstatusdetails VALUES (1256, 'NA', 'Opened Product', 'Working', '2024-06-14', 704);
INSERT INTO public.inventory_healthstatusdetails VALUES (1257, 'NA', 'Opened Product', 'Working', '2024-06-14', 705);
INSERT INTO public.inventory_healthstatusdetails VALUES (1258, 'NA', 'Opened Product', 'Working', '2024-06-14', 706);
INSERT INTO public.inventory_healthstatusdetails VALUES (1259, 'NA', 'Opened Product', 'Working', '2024-06-14', 707);
INSERT INTO public.inventory_healthstatusdetails VALUES (1260, 'NA', 'Opened Product', 'Working', '2024-06-14', 708);
INSERT INTO public.inventory_healthstatusdetails VALUES (1261, 'NA', 'Opened Product', 'Working', '2024-06-14', 709);
INSERT INTO public.inventory_healthstatusdetails VALUES (1262, 'NA', 'Opened Product', 'Working', '2024-06-14', 710);
INSERT INTO public.inventory_healthstatusdetails VALUES (1263, 'NA', 'Opened Product', 'Working', '2024-06-14', 711);
INSERT INTO public.inventory_healthstatusdetails VALUES (1264, 'NA', 'Opened Product', 'Working', '2024-06-14', 712);
INSERT INTO public.inventory_healthstatusdetails VALUES (1265, 'NA', 'Opened Product', 'Working', '2024-06-14', 713);
INSERT INTO public.inventory_healthstatusdetails VALUES (1266, 'NA', 'Opened Product', 'Working', '2024-06-14', 714);
INSERT INTO public.inventory_healthstatusdetails VALUES (1267, 'NA', 'Opened Product', 'Working', '2024-06-14', 715);
INSERT INTO public.inventory_healthstatusdetails VALUES (1268, 'NA', 'Opened Product', 'Working', '2024-06-14', 716);
INSERT INTO public.inventory_healthstatusdetails VALUES (1269, 'NA', 'Opened Product', 'Working', '2024-06-14', 717);
INSERT INTO public.inventory_healthstatusdetails VALUES (1270, 'NA', 'Opened Product', 'Working', '2024-06-14', 718);
INSERT INTO public.inventory_healthstatusdetails VALUES (1271, 'NA', 'Opened Product', 'Working', '2024-06-14', 719);
INSERT INTO public.inventory_healthstatusdetails VALUES (1272, 'NA', 'Opened Product', 'Working', '2024-06-14', 720);
INSERT INTO public.inventory_healthstatusdetails VALUES (1273, 'NA', 'Opened Product', 'Working', '2024-06-14', 721);
INSERT INTO public.inventory_healthstatusdetails VALUES (1274, 'NA', 'Opened Product', 'Working', '2024-06-14', 722);
INSERT INTO public.inventory_healthstatusdetails VALUES (1275, 'NA', 'Opened Product', 'Working', '2024-06-14', 723);
INSERT INTO public.inventory_healthstatusdetails VALUES (1276, 'NA', 'Opened Product', 'Working', '2024-06-14', 724);
INSERT INTO public.inventory_healthstatusdetails VALUES (1277, 'NA', 'Opened Product', 'Working', '2024-06-14', 725);
INSERT INTO public.inventory_healthstatusdetails VALUES (1278, 'NA', 'Opened Product', 'Working', '2024-06-14', 726);
INSERT INTO public.inventory_healthstatusdetails VALUES (1279, 'NA', 'Opened Product', 'Working', '2024-06-14', 727);
INSERT INTO public.inventory_healthstatusdetails VALUES (1280, 'NA', 'Opened Product', 'Working', '2024-06-14', 728);
INSERT INTO public.inventory_healthstatusdetails VALUES (1281, 'NA', 'Opened Product', 'Working', '2024-06-14', 729);
INSERT INTO public.inventory_healthstatusdetails VALUES (1282, 'NA', 'Opened Product', 'Working', '2024-06-14', 730);
INSERT INTO public.inventory_healthstatusdetails VALUES (1283, 'NA', 'Opened Product', 'Working', '2024-06-14', 731);
INSERT INTO public.inventory_healthstatusdetails VALUES (1286, 'NA', 'Opened Product', 'Working', '2024-06-14', 734);
INSERT INTO public.inventory_healthstatusdetails VALUES (1287, 'NA', 'Opened Product', 'Working', '2024-06-14', 735);
INSERT INTO public.inventory_healthstatusdetails VALUES (1288, 'NA', 'Opened Product', 'Working', '2024-06-14', 736);
INSERT INTO public.inventory_healthstatusdetails VALUES (1289, 'NA', 'Opened Product', 'Working', '2024-06-14', 737);
INSERT INTO public.inventory_healthstatusdetails VALUES (1290, 'NA', 'Opened Product', 'Working', '2024-06-14', 738);
INSERT INTO public.inventory_healthstatusdetails VALUES (1291, 'NA', 'Opened Product', 'Working', '2024-06-14', 739);
INSERT INTO public.inventory_healthstatusdetails VALUES (1292, 'NA', 'Opened Product', 'Working', '2024-06-14', 740);
INSERT INTO public.inventory_healthstatusdetails VALUES (1293, 'NA', 'Opened Product', 'Working', '2024-06-14', 741);
INSERT INTO public.inventory_healthstatusdetails VALUES (1294, 'NA', 'Opened Product', 'Working', '2024-06-14', 742);
INSERT INTO public.inventory_healthstatusdetails VALUES (1295, 'NA', 'Opened Product', 'Working', '2024-06-14', 743);
INSERT INTO public.inventory_healthstatusdetails VALUES (1296, 'NA', 'Opened Product', 'Working', '2024-06-14', 744);
INSERT INTO public.inventory_healthstatusdetails VALUES (1297, 'NA', 'Opened Product', 'Working', '2024-06-14', 745);
INSERT INTO public.inventory_healthstatusdetails VALUES (1298, 'NA', 'Opened Product', 'Working', '2024-06-14', 746);
INSERT INTO public.inventory_healthstatusdetails VALUES (1299, 'NA', 'Opened Product', 'Working', '2024-06-14', 747);
INSERT INTO public.inventory_healthstatusdetails VALUES (1300, 'NA', 'Opened Product', 'Working', '2024-06-14', 748);
INSERT INTO public.inventory_healthstatusdetails VALUES (1301, 'NA', 'Opened Product', 'Working', '2024-06-14', 749);
INSERT INTO public.inventory_healthstatusdetails VALUES (1302, 'NA', 'Opened Product', 'Working', '2024-06-14', 750);
INSERT INTO public.inventory_healthstatusdetails VALUES (1304, 'NA', 'Opened Product', 'Working', '2024-06-14', 752);
INSERT INTO public.inventory_healthstatusdetails VALUES (1305, 'NA', 'Opened Product', 'Working', '2024-06-14', 753);
INSERT INTO public.inventory_healthstatusdetails VALUES (1306, 'NA', 'Opened Product', 'Working', '2024-06-14', 754);
INSERT INTO public.inventory_healthstatusdetails VALUES (1308, 'NA', 'Opened Product', 'Working', '2024-06-14', 756);
INSERT INTO public.inventory_healthstatusdetails VALUES (1309, 'NA', 'Opened Product', 'Working', '2024-06-14', 757);
INSERT INTO public.inventory_healthstatusdetails VALUES (1310, 'NA', 'Opened Product', 'Working', '2024-06-14', 758);
INSERT INTO public.inventory_healthstatusdetails VALUES (1311, 'NA', 'Opened Product', 'Working', '2024-06-14', 759);
INSERT INTO public.inventory_healthstatusdetails VALUES (1312, 'NA', 'Opened Product', 'Working', '2024-06-14', 760);
INSERT INTO public.inventory_healthstatusdetails VALUES (1197, 'NA', 'Working', 'Working', '2024-09-05', 645);
INSERT INTO public.inventory_healthstatusdetails VALUES (1303, 'NA', 'Working', 'Working', '2024-09-05', 751);
INSERT INTO public.inventory_healthstatusdetails VALUES (1240, 'NA', 'Screen Damaged', 'Dead Stock', '2024-10-03', 688);
INSERT INTO public.inventory_healthstatusdetails VALUES (1313, 'NA', 'Opened Product', 'Working', '2024-06-14', 761);
INSERT INTO public.inventory_healthstatusdetails VALUES (1314, 'NA', 'Opened Product', 'Working', '2024-06-14', 762);
INSERT INTO public.inventory_healthstatusdetails VALUES (1315, 'NA', 'Opened Product', 'Working', '2024-06-14', 763);
INSERT INTO public.inventory_healthstatusdetails VALUES (1316, 'NA', 'Opened Product', 'Working', '2024-06-14', 764);
INSERT INTO public.inventory_healthstatusdetails VALUES (1317, 'NA', 'Opened Product', 'Working', '2024-06-14', 765);
INSERT INTO public.inventory_healthstatusdetails VALUES (1319, 'NA', 'Opened Product', 'Working', '2024-06-14', 767);
INSERT INTO public.inventory_healthstatusdetails VALUES (1320, 'NA', 'Opened Product', 'Working', '2024-06-14', 768);
INSERT INTO public.inventory_healthstatusdetails VALUES (1321, 'NA', 'Opened Product', 'Working', '2024-06-14', 769);
INSERT INTO public.inventory_healthstatusdetails VALUES (1322, 'NA', 'Opened Product', 'Working', '2024-06-14', 770);
INSERT INTO public.inventory_healthstatusdetails VALUES (1323, 'NA', 'Opened Product', 'Working', '2024-06-14', 771);
INSERT INTO public.inventory_healthstatusdetails VALUES (1324, 'NA', 'Opened Product', 'Working', '2024-06-14', 772);
INSERT INTO public.inventory_healthstatusdetails VALUES (1325, 'NA', 'Opened Product', 'Working', '2024-06-14', 773);
INSERT INTO public.inventory_healthstatusdetails VALUES (1326, 'NA', 'Opened Product', 'Working', '2024-06-14', 774);
INSERT INTO public.inventory_healthstatusdetails VALUES (1327, 'NA', 'Opened Product', 'Working', '2024-06-14', 775);
INSERT INTO public.inventory_healthstatusdetails VALUES (1328, 'NA', 'Opened Product', 'Working', '2024-06-14', 776);
INSERT INTO public.inventory_healthstatusdetails VALUES (1329, 'NA', 'Opened Product', 'Working', '2024-06-14', 777);
INSERT INTO public.inventory_healthstatusdetails VALUES (1330, 'NA', 'Opened Product', 'Working', '2024-06-14', 778);
INSERT INTO public.inventory_healthstatusdetails VALUES (1331, 'NA', 'Opened Product', 'Working', '2024-06-14', 779);
INSERT INTO public.inventory_healthstatusdetails VALUES (1333, 'NA', 'Opened Product', 'Working', '2024-06-14', 781);
INSERT INTO public.inventory_healthstatusdetails VALUES (1334, 'NA', 'Opened Product', 'Working', '2024-06-14', 782);
INSERT INTO public.inventory_healthstatusdetails VALUES (1335, 'NA', 'Opened Product', 'Working', '2024-06-14', 783);
INSERT INTO public.inventory_healthstatusdetails VALUES (1336, 'NA', 'Opened Product', 'Working', '2024-06-14', 784);
INSERT INTO public.inventory_healthstatusdetails VALUES (1337, 'NA', 'Opened Product', 'Working', '2024-06-14', 785);
INSERT INTO public.inventory_healthstatusdetails VALUES (1338, 'NA', 'Opened Product', 'Working', '2024-06-14', 786);
INSERT INTO public.inventory_healthstatusdetails VALUES (1339, 'NA', 'Opened Product', 'Working', '2024-06-14', 787);
INSERT INTO public.inventory_healthstatusdetails VALUES (1341, 'NA', 'Opened Product', 'Working', '2024-06-14', 789);
INSERT INTO public.inventory_healthstatusdetails VALUES (1342, 'NA', 'Opened Product', 'Working', '2024-06-14', 790);
INSERT INTO public.inventory_healthstatusdetails VALUES (1344, 'NA', 'Opened Product', 'Working', '2024-06-14', 792);
INSERT INTO public.inventory_healthstatusdetails VALUES (1345, 'NA', 'Opened Product', 'Working', '2024-06-14', 793);
INSERT INTO public.inventory_healthstatusdetails VALUES (1346, 'NA', 'Opened Product', 'Working', '2024-06-14', 794);
INSERT INTO public.inventory_healthstatusdetails VALUES (1347, 'NA', 'Opened Product', 'Working', '2024-06-14', 795);
INSERT INTO public.inventory_healthstatusdetails VALUES (1348, 'NA', 'Opened Product', 'Working', '2024-06-14', 796);
INSERT INTO public.inventory_healthstatusdetails VALUES (1349, 'NA', 'Opened Product', 'Working', '2024-06-14', 797);
INSERT INTO public.inventory_healthstatusdetails VALUES (1350, 'NA', 'Opened Product', 'Working', '2024-06-14', 798);
INSERT INTO public.inventory_healthstatusdetails VALUES (1351, 'NA', 'Opened Product', 'Working', '2024-06-14', 799);
INSERT INTO public.inventory_healthstatusdetails VALUES (1352, 'NA', 'Opened Product', 'Working', '2024-06-14', 800);
INSERT INTO public.inventory_healthstatusdetails VALUES (1353, 'NA', 'Opened Product', 'Working', '2024-06-14', 801);
INSERT INTO public.inventory_healthstatusdetails VALUES (1354, 'NA', 'Opened Product', 'Working', '2024-06-14', 802);
INSERT INTO public.inventory_healthstatusdetails VALUES (1355, 'NA', 'Opened Product', 'Working', '2024-06-14', 803);
INSERT INTO public.inventory_healthstatusdetails VALUES (1357, 'NA', 'Opened Product', 'Working', '2024-06-14', 805);
INSERT INTO public.inventory_healthstatusdetails VALUES (1358, 'NA', 'Opened Product', 'Working', '2024-06-14', 806);
INSERT INTO public.inventory_healthstatusdetails VALUES (1360, 'NA', 'Opened Product', 'Working', '2024-06-14', 808);
INSERT INTO public.inventory_healthstatusdetails VALUES (1361, 'NA', 'Opened Product', 'Working', '2024-06-14', 809);
INSERT INTO public.inventory_healthstatusdetails VALUES (1362, 'NA', 'Opened Product', 'Working', '2024-06-14', 810);
INSERT INTO public.inventory_healthstatusdetails VALUES (1363, 'NA', 'Opened Product', 'Working', '2024-06-14', 811);
INSERT INTO public.inventory_healthstatusdetails VALUES (1365, 'NA', 'Opened Product', 'Working', '2024-06-14', 813);
INSERT INTO public.inventory_healthstatusdetails VALUES (1366, 'NA', 'Opened Product', 'Working', '2024-06-14', 814);
INSERT INTO public.inventory_healthstatusdetails VALUES (1367, 'NA', 'Opened Product', 'Working', '2024-06-14', 815);
INSERT INTO public.inventory_healthstatusdetails VALUES (1368, 'NA', 'Opened Product', 'Working', '2024-06-14', 816);
INSERT INTO public.inventory_healthstatusdetails VALUES (1369, 'NA', 'Opened Product', 'Working', '2024-06-14', 817);
INSERT INTO public.inventory_healthstatusdetails VALUES (1370, 'NA', 'Opened Product', 'Working', '2024-06-14', 818);
INSERT INTO public.inventory_healthstatusdetails VALUES (1371, 'NA', 'Opened Product', 'Working', '2024-06-14', 819);
INSERT INTO public.inventory_healthstatusdetails VALUES (1372, 'NA', 'Opened Product', 'Working', '2024-06-14', 820);
INSERT INTO public.inventory_healthstatusdetails VALUES (1373, 'NA', 'Opened Product', 'Working', '2024-06-14', 821);
INSERT INTO public.inventory_healthstatusdetails VALUES (1374, 'NA', 'Opened Product', 'Working', '2024-06-14', 822);
INSERT INTO public.inventory_healthstatusdetails VALUES (1375, 'NA', 'Opened Product', 'Working', '2024-06-14', 823);
INSERT INTO public.inventory_healthstatusdetails VALUES (1376, 'NA', 'Opened Product', 'Working', '2024-06-14', 824);
INSERT INTO public.inventory_healthstatusdetails VALUES (1377, 'NA', 'Opened Product', 'Working', '2024-06-14', 825);
INSERT INTO public.inventory_healthstatusdetails VALUES (1378, 'NA', 'Opened Product', 'Working', '2024-06-14', 826);
INSERT INTO public.inventory_healthstatusdetails VALUES (1379, 'NA', 'Opened Product', 'Working', '2024-06-14', 827);
INSERT INTO public.inventory_healthstatusdetails VALUES (1380, 'NA', 'Opened Product', 'Working', '2024-06-14', 828);
INSERT INTO public.inventory_healthstatusdetails VALUES (1381, 'NA', 'Opened Product', 'Working', '2024-06-14', 829);
INSERT INTO public.inventory_healthstatusdetails VALUES (1382, 'NA', 'Opened Product', 'Working', '2024-06-14', 830);
INSERT INTO public.inventory_healthstatusdetails VALUES (1384, 'NA', 'Opened Product', 'Working', '2024-06-14', 832);
INSERT INTO public.inventory_healthstatusdetails VALUES (1385, 'NA', 'Opened Product', 'Working', '2024-06-14', 833);
INSERT INTO public.inventory_healthstatusdetails VALUES (1387, 'NA', 'Opened Product', 'Working', '2024-06-14', 835);
INSERT INTO public.inventory_healthstatusdetails VALUES (1388, 'NA', 'Opened Product', 'Working', '2024-06-14', 836);
INSERT INTO public.inventory_healthstatusdetails VALUES (1389, 'NA', 'Opened Product', 'Working', '2024-06-14', 837);
INSERT INTO public.inventory_healthstatusdetails VALUES (1390, 'NA', 'Opened Product', 'Working', '2024-06-14', 838);
INSERT INTO public.inventory_healthstatusdetails VALUES (1391, 'NA', 'Opened Product', 'Working', '2024-06-14', 839);
INSERT INTO public.inventory_healthstatusdetails VALUES (1392, 'NA', 'Opened Product', 'Working', '2024-06-14', 840);
INSERT INTO public.inventory_healthstatusdetails VALUES (1393, 'NA', 'Opened Product', 'Working', '2024-06-14', 841);
INSERT INTO public.inventory_healthstatusdetails VALUES (1394, 'NA', 'Opened Product', 'Working', '2024-06-14', 842);
INSERT INTO public.inventory_healthstatusdetails VALUES (1395, 'NA', 'Opened Product', 'Working', '2024-06-14', 843);
INSERT INTO public.inventory_healthstatusdetails VALUES (1396, 'NA', 'Opened Product', 'Working', '2024-06-14', 844);
INSERT INTO public.inventory_healthstatusdetails VALUES (1397, 'NA', 'Opened Product', 'Working', '2024-06-14', 845);
INSERT INTO public.inventory_healthstatusdetails VALUES (1398, 'NA', 'Opened Product', 'Working', '2024-06-14', 846);
INSERT INTO public.inventory_healthstatusdetails VALUES (1399, 'NA', 'Opened Product', 'Working', '2024-06-14', 847);
INSERT INTO public.inventory_healthstatusdetails VALUES (1400, 'NA', 'Opened Product', 'Working', '2024-06-14', 848);
INSERT INTO public.inventory_healthstatusdetails VALUES (1402, 'NA', 'Opened Product', 'Working', '2024-06-14', 850);
INSERT INTO public.inventory_healthstatusdetails VALUES (1403, 'NA', 'Opened Product', 'Working', '2024-06-14', 851);
INSERT INTO public.inventory_healthstatusdetails VALUES (1404, 'NA', 'Opened Product', 'Working', '2024-06-14', 852);
INSERT INTO public.inventory_healthstatusdetails VALUES (1405, 'NA', 'Opened Product', 'Working', '2024-06-14', 853);
INSERT INTO public.inventory_healthstatusdetails VALUES (1406, 'NA', 'Opened Product', 'Working', '2024-06-14', 854);
INSERT INTO public.inventory_healthstatusdetails VALUES (1408, 'NA', 'Opened Product', 'Working', '2024-06-14', 856);
INSERT INTO public.inventory_healthstatusdetails VALUES (1410, 'NA', 'Opened Product', 'Working', '2024-06-14', 858);
INSERT INTO public.inventory_healthstatusdetails VALUES (1411, 'NA', 'Opened Product', 'Working', '2024-06-14', 859);
INSERT INTO public.inventory_healthstatusdetails VALUES (1412, 'NA', 'Opened Product', 'Working', '2024-06-14', 860);
INSERT INTO public.inventory_healthstatusdetails VALUES (1414, 'NA', 'Opened Product', 'Working', '2024-06-14', 862);
INSERT INTO public.inventory_healthstatusdetails VALUES (1415, 'NA', 'Opened Product', 'Working', '2024-06-14', 863);
INSERT INTO public.inventory_healthstatusdetails VALUES (1416, 'NA', 'Opened Product', 'Working', '2024-06-14', 864);
INSERT INTO public.inventory_healthstatusdetails VALUES (1417, 'NA', 'Opened Product', 'Working', '2024-06-14', 865);
INSERT INTO public.inventory_healthstatusdetails VALUES (1419, 'NA', 'Opened Product', 'Working', '2024-06-14', 867);
INSERT INTO public.inventory_healthstatusdetails VALUES (1420, 'NA', 'Opened Product', 'Working', '2024-06-14', 868);
INSERT INTO public.inventory_healthstatusdetails VALUES (1421, 'NA', 'Opened Product', 'Working', '2024-06-14', 869);
INSERT INTO public.inventory_healthstatusdetails VALUES (1422, 'NA', 'Opened Product', 'Working', '2024-06-14', 870);
INSERT INTO public.inventory_healthstatusdetails VALUES (1424, 'NA', 'Opened Product', 'Working', '2024-06-14', 872);
INSERT INTO public.inventory_healthstatusdetails VALUES (1425, 'NA', 'Opened Product', 'Working', '2024-06-14', 873);
INSERT INTO public.inventory_healthstatusdetails VALUES (1426, 'NA', 'Opened Product', 'Working', '2024-06-14', 874);
INSERT INTO public.inventory_healthstatusdetails VALUES (1427, 'NA', 'Opened Product', 'Working', '2024-06-14', 875);
INSERT INTO public.inventory_healthstatusdetails VALUES (1428, 'NA', 'Opened Product', 'Working', '2024-06-14', 876);
INSERT INTO public.inventory_healthstatusdetails VALUES (1429, 'NA', 'Opened Product', 'Working', '2024-06-14', 877);
INSERT INTO public.inventory_healthstatusdetails VALUES (1430, 'NA', 'Opened Product', 'Working', '2024-06-14', 878);
INSERT INTO public.inventory_healthstatusdetails VALUES (1431, 'NA', 'Opened Product', 'Working', '2024-06-14', 879);
INSERT INTO public.inventory_healthstatusdetails VALUES (1432, 'NA', 'Opened Product', 'Working', '2024-06-14', 880);
INSERT INTO public.inventory_healthstatusdetails VALUES (1433, 'NA', 'Opened Product', 'Working', '2024-06-14', 881);
INSERT INTO public.inventory_healthstatusdetails VALUES (1332, 'NA', 'No issue', 'Working', '2024-06-14', 780);
INSERT INTO public.inventory_healthstatusdetails VALUES (1318, 'NA', 'Motherboard dead', 'Dead Stock', '2024-07-29', 766);
INSERT INTO public.inventory_healthstatusdetails VALUES (1418, 'NA', 'Fuser Error', 'Needs To Repair', '2024-08-01', 866);
INSERT INTO public.inventory_healthstatusdetails VALUES (1340, 'NA', 'Motherboard Issue', 'Dead Stock', '2024-08-03', 788);
INSERT INTO public.inventory_healthstatusdetails VALUES (1364, 'NA', 'Teflon Damaged', 'Needs To Repair', '2024-08-08', 812);
INSERT INTO public.inventory_healthstatusdetails VALUES (1356, 'NA', '', 'Needs To Repair', '2024-08-27', 804);
INSERT INTO public.inventory_healthstatusdetails VALUES (1423, 'NA', 'Dead', 'Dead Stock', '2024-09-05', 871);
INSERT INTO public.inventory_healthstatusdetails VALUES (1383, 'NA', 'Working', 'Working', '2024-09-05', 831);
INSERT INTO public.inventory_healthstatusdetails VALUES (1407, 'NA', 'Working', 'Working', '2024-11-25', 855);
INSERT INTO public.inventory_healthstatusdetails VALUES (1401, 'NA', 'Teflon, pressure roller  Problem', 'Dead Stock', '2024-09-24', 849);
INSERT INTO public.inventory_healthstatusdetails VALUES (1343, 'NA', '', 'Working', '2024-09-13', 791);
INSERT INTO public.inventory_healthstatusdetails VALUES (1359, 'NA', 'Working', 'Working', '2024-11-22', 807);
INSERT INTO public.inventory_healthstatusdetails VALUES (1434, 'NA', 'Opened Product', 'Working', '2024-06-14', 882);
INSERT INTO public.inventory_healthstatusdetails VALUES (1435, 'NA', 'Opened Product', 'Working', '2024-06-14', 883);
INSERT INTO public.inventory_healthstatusdetails VALUES (1436, 'NA', 'Opened Product', 'Working', '2024-06-14', 884);
INSERT INTO public.inventory_healthstatusdetails VALUES (1437, 'NA', 'Opened Product', 'Working', '2024-06-14', 885);
INSERT INTO public.inventory_healthstatusdetails VALUES (1438, 'NA', 'Opened Product', 'Working', '2024-06-14', 886);
INSERT INTO public.inventory_healthstatusdetails VALUES (1439, 'NA', 'Opened Product', 'Working', '2024-06-14', 887);
INSERT INTO public.inventory_healthstatusdetails VALUES (1440, 'NA', 'Opened Product', 'Working', '2024-06-14', 888);
INSERT INTO public.inventory_healthstatusdetails VALUES (1441, 'NA', 'Opened Product', 'Working', '2024-06-14', 889);
INSERT INTO public.inventory_healthstatusdetails VALUES (1443, 'NA', 'Opened Product', 'Working', '2024-06-14', 891);
INSERT INTO public.inventory_healthstatusdetails VALUES (1445, 'NA', 'Opened Product', 'Working', '2024-06-14', 893);
INSERT INTO public.inventory_healthstatusdetails VALUES (1446, 'NA', 'Opened Product', 'Working', '2024-06-14', 894);
INSERT INTO public.inventory_healthstatusdetails VALUES (1447, 'NA', 'Opened Product', 'Working', '2024-06-14', 895);
INSERT INTO public.inventory_healthstatusdetails VALUES (1448, 'NA', 'Opened Product', 'Working', '2024-06-14', 896);
INSERT INTO public.inventory_healthstatusdetails VALUES (1449, 'NA', 'Opened Product', 'Working', '2024-06-14', 897);
INSERT INTO public.inventory_healthstatusdetails VALUES (1450, 'NA', 'Opened Product', 'Working', '2024-06-14', 898);
INSERT INTO public.inventory_healthstatusdetails VALUES (1451, 'NA', 'Opened Product', 'Working', '2024-06-14', 899);
INSERT INTO public.inventory_healthstatusdetails VALUES (1452, 'NA', 'Opened Product', 'Working', '2024-06-14', 900);
INSERT INTO public.inventory_healthstatusdetails VALUES (1453, 'NA', 'Opened Product', 'Working', '2024-06-14', 901);
INSERT INTO public.inventory_healthstatusdetails VALUES (1454, 'NA', 'Opened Product', 'Working', '2024-06-14', 902);
INSERT INTO public.inventory_healthstatusdetails VALUES (1455, 'NA', 'Opened Product', 'Working', '2024-06-14', 903);
INSERT INTO public.inventory_healthstatusdetails VALUES (1456, 'NA', 'Opened Product', 'Working', '2024-06-14', 904);
INSERT INTO public.inventory_healthstatusdetails VALUES (1457, 'NA', 'Opened Product', 'Working', '2024-06-14', 905);
INSERT INTO public.inventory_healthstatusdetails VALUES (1458, 'NA', 'Opened Product', 'Working', '2024-06-14', 906);
INSERT INTO public.inventory_healthstatusdetails VALUES (1459, 'NA', 'Opened Product', 'Working', '2024-06-14', 907);
INSERT INTO public.inventory_healthstatusdetails VALUES (1461, 'NA', 'Opened Product', 'Working', '2024-06-14', 909);
INSERT INTO public.inventory_healthstatusdetails VALUES (1462, 'NA', 'Opened Product', 'Working', '2024-06-14', 910);
INSERT INTO public.inventory_healthstatusdetails VALUES (1463, 'NA', 'Opened Product', 'Working', '2024-06-14', 911);
INSERT INTO public.inventory_healthstatusdetails VALUES (1464, 'NA', 'Opened Product', 'Working', '2024-06-14', 912);
INSERT INTO public.inventory_healthstatusdetails VALUES (1465, 'NA', 'Opened Product', 'Working', '2024-06-14', 913);
INSERT INTO public.inventory_healthstatusdetails VALUES (1467, 'NA', 'Opened Product', 'Working', '2024-06-14', 915);
INSERT INTO public.inventory_healthstatusdetails VALUES (1468, 'NA', 'Opened Product', 'Working', '2024-06-14', 916);
INSERT INTO public.inventory_healthstatusdetails VALUES (1469, 'NA', 'Opened Product', 'Working', '2024-06-14', 917);
INSERT INTO public.inventory_healthstatusdetails VALUES (1470, 'NA', 'Opened Product', 'Working', '2024-06-14', 918);
INSERT INTO public.inventory_healthstatusdetails VALUES (1471, 'NA', 'Opened Product', 'Working', '2024-06-14', 919);
INSERT INTO public.inventory_healthstatusdetails VALUES (1472, 'NA', 'Opened Product', 'Working', '2024-06-14', 920);
INSERT INTO public.inventory_healthstatusdetails VALUES (1473, 'NA', 'Opened Product', 'Working', '2024-06-14', 921);
INSERT INTO public.inventory_healthstatusdetails VALUES (1474, 'NA', 'Opened Product', 'Working', '2024-06-14', 922);
INSERT INTO public.inventory_healthstatusdetails VALUES (1476, 'NA', 'Opened Product', 'Working', '2024-06-14', 924);
INSERT INTO public.inventory_healthstatusdetails VALUES (1477, 'NA', 'Opened Product', 'Working', '2024-06-14', 925);
INSERT INTO public.inventory_healthstatusdetails VALUES (1478, 'NA', 'Opened Product', 'Working', '2024-06-14', 926);
INSERT INTO public.inventory_healthstatusdetails VALUES (1479, 'NA', 'Opened Product', 'Working', '2024-06-14', 927);
INSERT INTO public.inventory_healthstatusdetails VALUES (1480, 'NA', 'Opened Product', 'Working', '2024-06-14', 928);
INSERT INTO public.inventory_healthstatusdetails VALUES (1481, 'NA', 'Opened Product', 'Working', '2024-06-14', 929);
INSERT INTO public.inventory_healthstatusdetails VALUES (1484, 'NA', 'Opened Product', 'Working', '2024-06-14', 932);
INSERT INTO public.inventory_healthstatusdetails VALUES (1485, 'NA', 'Opened Product', 'Working', '2024-06-14', 933);
INSERT INTO public.inventory_healthstatusdetails VALUES (1486, 'NA', 'Opened Product', 'Working', '2024-06-14', 934);
INSERT INTO public.inventory_healthstatusdetails VALUES (1487, 'NA', 'Opened Product', 'Working', '2024-06-14', 935);
INSERT INTO public.inventory_healthstatusdetails VALUES (1488, 'NA', 'Opened Product', 'Working', '2024-06-14', 936);
INSERT INTO public.inventory_healthstatusdetails VALUES (1490, 'NA', 'Opened Product', 'Working', '2024-06-14', 938);
INSERT INTO public.inventory_healthstatusdetails VALUES (1491, 'NA', 'Opened Product', 'Working', '2024-06-14', 939);
INSERT INTO public.inventory_healthstatusdetails VALUES (1492, 'NA', 'Opened Product', 'Working', '2024-06-14', 940);
INSERT INTO public.inventory_healthstatusdetails VALUES (1494, 'NA', 'Opened Product', 'Working', '2024-06-14', 942);
INSERT INTO public.inventory_healthstatusdetails VALUES (1495, 'NA', 'Opened Product', 'Working', '2024-06-14', 943);
INSERT INTO public.inventory_healthstatusdetails VALUES (1496, 'NA', 'Opened Product', 'Working', '2024-06-14', 944);
INSERT INTO public.inventory_healthstatusdetails VALUES (1497, 'NA', 'Opened Product', 'Working', '2024-06-14', 945);
INSERT INTO public.inventory_healthstatusdetails VALUES (1498, 'NA', 'Opened Product', 'Working', '2024-06-14', 946);
INSERT INTO public.inventory_healthstatusdetails VALUES (1499, 'NA', 'Opened Product', 'Working', '2024-06-14', 947);
INSERT INTO public.inventory_healthstatusdetails VALUES (1500, 'NA', 'Opened Product', 'Working', '2024-06-14', 948);
INSERT INTO public.inventory_healthstatusdetails VALUES (1501, 'NA', 'Opened Product', 'Working', '2024-06-14', 949);
INSERT INTO public.inventory_healthstatusdetails VALUES (1502, 'NA', 'Opened Product', 'Working', '2024-06-14', 950);
INSERT INTO public.inventory_healthstatusdetails VALUES (1503, 'NA', 'Opened Product', 'Working', '2024-06-14', 951);
INSERT INTO public.inventory_healthstatusdetails VALUES (1504, 'NA', 'Opened Product', 'Working', '2024-06-14', 952);
INSERT INTO public.inventory_healthstatusdetails VALUES (1505, 'NA', 'Opened Product', 'Working', '2024-06-14', 953);
INSERT INTO public.inventory_healthstatusdetails VALUES (1506, 'NA', 'Opened Product', 'Working', '2024-06-14', 954);
INSERT INTO public.inventory_healthstatusdetails VALUES (1507, 'NA', 'Opened Product', 'Working', '2024-06-14', 955);
INSERT INTO public.inventory_healthstatusdetails VALUES (1508, 'NA', 'Opened Product', 'Working', '2024-06-14', 956);
INSERT INTO public.inventory_healthstatusdetails VALUES (1509, 'NA', 'Opened Product', 'Working', '2024-06-14', 957);
INSERT INTO public.inventory_healthstatusdetails VALUES (1510, 'NA', 'Opened Product', 'Working', '2024-06-14', 958);
INSERT INTO public.inventory_healthstatusdetails VALUES (1511, 'NA', 'Opened Product', 'Working', '2024-06-14', 959);
INSERT INTO public.inventory_healthstatusdetails VALUES (1512, 'NA', 'Opened Product', 'Working', '2024-06-14', 960);
INSERT INTO public.inventory_healthstatusdetails VALUES (1513, 'NA', 'Opened Product', 'Working', '2024-06-14', 961);
INSERT INTO public.inventory_healthstatusdetails VALUES (1514, 'NA', 'Opened Product', 'Working', '2024-06-14', 962);
INSERT INTO public.inventory_healthstatusdetails VALUES (1515, 'NA', 'Opened Product', 'Working', '2024-06-14', 963);
INSERT INTO public.inventory_healthstatusdetails VALUES (1516, 'NA', 'Opened Product', 'Working', '2024-06-14', 964);
INSERT INTO public.inventory_healthstatusdetails VALUES (1517, 'NA', 'Opened Product', 'Working', '2024-06-14', 965);
INSERT INTO public.inventory_healthstatusdetails VALUES (1518, 'NA', 'Opened Product', 'Working', '2024-06-14', 966);
INSERT INTO public.inventory_healthstatusdetails VALUES (1519, 'NA', 'Opened Product', 'Working', '2024-06-14', 967);
INSERT INTO public.inventory_healthstatusdetails VALUES (1520, 'NA', 'Opened Product', 'Working', '2024-06-14', 968);
INSERT INTO public.inventory_healthstatusdetails VALUES (1521, 'NA', 'Opened Product', 'Working', '2024-06-14', 969);
INSERT INTO public.inventory_healthstatusdetails VALUES (1522, 'NA', 'Opened Product', 'Working', '2024-06-14', 970);
INSERT INTO public.inventory_healthstatusdetails VALUES (1523, 'NA', 'Opened Product', 'Working', '2024-06-14', 971);
INSERT INTO public.inventory_healthstatusdetails VALUES (1529, 'NA', 'New Product', 'Working', '2024-06-25', 977);
INSERT INTO public.inventory_healthstatusdetails VALUES (1530, 'NA', 'New Product', 'Working', '2024-06-26', 978);
INSERT INTO public.inventory_healthstatusdetails VALUES (1531, 'NA', 'New Product', 'Working', '2024-06-29', 979);
INSERT INTO public.inventory_healthstatusdetails VALUES (1532, 'NA', 'New Product', 'Working', '2024-06-29', 980);
INSERT INTO public.inventory_healthstatusdetails VALUES (915, 'NA', 'Blank Print', 'Needs To Repair', '2024-05-22', 363);
INSERT INTO public.inventory_healthstatusdetails VALUES (1493, 'NA', '', 'Working', '2024-12-07', 941);
INSERT INTO public.inventory_healthstatusdetails VALUES (910, 'NA', 'Teflon Problem.', 'Dead Stock', '2024-05-22', 358);
INSERT INTO public.inventory_healthstatusdetails VALUES (1562, 'Yes', 'New Product', 'Working', '2024-09-12', 1010);
INSERT INTO public.inventory_healthstatusdetails VALUES (1589, 'Yes', 'New Product', 'Working', '2024-12-07', 1037);
INSERT INTO public.inventory_healthstatusdetails VALUES (1090, 'NA', 'Network Port Not Working', 'Needs To Repair', '2024-09-06', 538);
INSERT INTO public.inventory_healthstatusdetails VALUES (1460, 'NA', 'Need To repair', 'Needs To Repair', '2024-09-06', 908);
INSERT INTO public.inventory_healthstatusdetails VALUES (1444, 'NA', 'Working', 'Working', '2024-09-05', 892);
INSERT INTO public.inventory_healthstatusdetails VALUES (1466, 'NA', 'Circuit Problem', 'Dead Stock', '2024-09-19', 914);
INSERT INTO public.inventory_healthstatusdetails VALUES (1442, 'NA', 'Working', 'Working', '2024-07-16', 890);
INSERT INTO public.inventory_healthstatusdetails VALUES (1599, 'Yes', '', 'Needs To Repair', '2024-12-11', 1047);
INSERT INTO public.inventory_healthstatusdetails VALUES (1609, 'Yes', '', 'Needs To Repair', '2024-12-12', 1057);


--
-- Data for Name: inventory_productcategorymaster; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.inventory_productcategorymaster VALUES (1, 'Non-Consumable', 'CPU');
INSERT INTO public.inventory_productcategorymaster VALUES (2, 'Non-Consumable', 'MONITOR');
INSERT INTO public.inventory_productcategorymaster VALUES (3, 'Non-Consumable', 'UPS');
INSERT INTO public.inventory_productcategorymaster VALUES (6, 'Consumable', 'SPLITTER');
INSERT INTO public.inventory_productcategorymaster VALUES (8, 'Non-Consumable', 'PRINTER');
INSERT INTO public.inventory_productcategorymaster VALUES (9, 'Non-Consumable', 'SCANNER');
INSERT INTO public.inventory_productcategorymaster VALUES (10, 'Non-Consumable', 'ALL IN ONE DESKTOP');
INSERT INTO public.inventory_productcategorymaster VALUES (12, 'Non-Consumable', 'PHOTOCOPY MACHINE');
INSERT INTO public.inventory_productcategorymaster VALUES (13, 'Non-Consumable', 'KIOSK MACHINE');
INSERT INTO public.inventory_productcategorymaster VALUES (14, 'Non-Consumable', 'SERVER');
INSERT INTO public.inventory_productcategorymaster VALUES (15, 'Non-Consumable', 'THIN CLIENT');
INSERT INTO public.inventory_productcategorymaster VALUES (16, 'Non-Consumable', 'PROJECTOR');
INSERT INTO public.inventory_productcategorymaster VALUES (17, 'Consumable', 'SPEAKER');
INSERT INTO public.inventory_productcategorymaster VALUES (18, 'Non-Consumable', 'DG SET');
INSERT INTO public.inventory_productcategorymaster VALUES (19, 'Non-Consumable', 'BIOMETRIC');
INSERT INTO public.inventory_productcategorymaster VALUES (20, 'Non-Consumable', 'TV');
INSERT INTO public.inventory_productcategorymaster VALUES (21, 'Non-Consumable', 'SWITCH');
INSERT INTO public.inventory_productcategorymaster VALUES (4, 'Consumable', 'KEYBOARD');
INSERT INTO public.inventory_productcategorymaster VALUES (22, 'Consumable', 'LAN Cable');
INSERT INTO public.inventory_productcategorymaster VALUES (7, 'Non-Consumable', '8-PORT SWITCH');
INSERT INTO public.inventory_productcategorymaster VALUES (23, 'Consumable', 'USB HUB');
INSERT INTO public.inventory_productcategorymaster VALUES (24, 'Consumable', 'Dongle');
INSERT INTO public.inventory_productcategorymaster VALUES (25, 'Consumable', 'Wireless Keyboard Mouse');
INSERT INTO public.inventory_productcategorymaster VALUES (11, 'Non-Consumable', 'WEB CAMERA');
INSERT INTO public.inventory_productcategorymaster VALUES (5, 'Consumable', 'MOUSE');
INSERT INTO public.inventory_productcategorymaster VALUES (26, 'DUMMY', 'DUMMY');


--
-- Data for Name: inventory_productcompanymaster; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.inventory_productcompanymaster VALUES (1, 'HP', 1);
INSERT INTO public.inventory_productcompanymaster VALUES (2, 'ACER', 1);
INSERT INTO public.inventory_productcompanymaster VALUES (3, 'HCL', 1);
INSERT INTO public.inventory_productcompanymaster VALUES (4, 'WIPRO', 1);
INSERT INTO public.inventory_productcompanymaster VALUES (5, 'DELL', 1);
INSERT INTO public.inventory_productcompanymaster VALUES (6, 'ACER', 2);
INSERT INTO public.inventory_productcompanymaster VALUES (7, 'WIPRO', 2);
INSERT INTO public.inventory_productcompanymaster VALUES (8, 'AOC', 2);
INSERT INTO public.inventory_productcompanymaster VALUES (9, 'HP', 2);
INSERT INTO public.inventory_productcompanymaster VALUES (10, 'DELL', 2);
INSERT INTO public.inventory_productcompanymaster VALUES (11, 'LENOVO', 2);
INSERT INTO public.inventory_productcompanymaster VALUES (12, 'HCL', 2);
INSERT INTO public.inventory_productcompanymaster VALUES (13, 'LG', 2);
INSERT INTO public.inventory_productcompanymaster VALUES (14, 'RS Power', 3);
INSERT INTO public.inventory_productcompanymaster VALUES (15, 'NUMERIC', 3);
INSERT INTO public.inventory_productcompanymaster VALUES (16, 'Uniline', 3);
INSERT INTO public.inventory_productcompanymaster VALUES (17, 'Intex', 3);
INSERT INTO public.inventory_productcompanymaster VALUES (18, 'Keptron', 3);
INSERT INTO public.inventory_productcompanymaster VALUES (19, 'Battery ', 3);
INSERT INTO public.inventory_productcompanymaster VALUES (21, 'LENOVO', 4);
INSERT INTO public.inventory_productcompanymaster VALUES (22, 'DELL', 4);
INSERT INTO public.inventory_productcompanymaster VALUES (23, 'FRONTECH', 4);
INSERT INTO public.inventory_productcompanymaster VALUES (24, 'LOGITECH', 4);
INSERT INTO public.inventory_productcompanymaster VALUES (25, 'HP', 5);
INSERT INTO public.inventory_productcompanymaster VALUES (26, 'LENOVO', 5);
INSERT INTO public.inventory_productcompanymaster VALUES (27, 'DELL', 5);
INSERT INTO public.inventory_productcompanymaster VALUES (28, 'FRONTECH', 5);
INSERT INTO public.inventory_productcompanymaster VALUES (29, 'LOGITECH', 5);
INSERT INTO public.inventory_productcompanymaster VALUES (30, 'SPLITTER', 6);
INSERT INTO public.inventory_productcompanymaster VALUES (31, 'DLINK', 7);
INSERT INTO public.inventory_productcompanymaster VALUES (32, 'DIGISOL', 7);
INSERT INTO public.inventory_productcompanymaster VALUES (33, 'HP', 8);
INSERT INTO public.inventory_productcompanymaster VALUES (34, 'LEXMARK', 8);
INSERT INTO public.inventory_productcompanymaster VALUES (35, 'EPSON', 8);
INSERT INTO public.inventory_productcompanymaster VALUES (36, 'SAMSANG', 8);
INSERT INTO public.inventory_productcompanymaster VALUES (37, 'EPSON', 9);
INSERT INTO public.inventory_productcompanymaster VALUES (38, 'HP', 9);
INSERT INTO public.inventory_productcompanymaster VALUES (39, 'CANON', 9);
INSERT INTO public.inventory_productcompanymaster VALUES (40, 'AVISION', 9);
INSERT INTO public.inventory_productcompanymaster VALUES (41, 'HP', 10);
INSERT INTO public.inventory_productcompanymaster VALUES (42, 'DELL', 10);
INSERT INTO public.inventory_productcompanymaster VALUES (43, 'LENOVO', 10);
INSERT INTO public.inventory_productcompanymaster VALUES (44, 'LOGITECH', 11);
INSERT INTO public.inventory_productcompanymaster VALUES (45, 'TOSHIBA', 12);
INSERT INTO public.inventory_productcompanymaster VALUES (46, 'HBL', 13);
INSERT INTO public.inventory_productcompanymaster VALUES (47, 'DELL', 14);
INSERT INTO public.inventory_productcompanymaster VALUES (48, 'HCL', 14);
INSERT INTO public.inventory_productcompanymaster VALUES (49, 'WIPRO', 14);
INSERT INTO public.inventory_productcompanymaster VALUES (50, 'HP', 15);
INSERT INTO public.inventory_productcompanymaster VALUES (51, 'ACER', 15);
INSERT INTO public.inventory_productcompanymaster VALUES (52, 'HITACHI', 16);
INSERT INTO public.inventory_productcompanymaster VALUES (53, 'need to check', 16);
INSERT INTO public.inventory_productcompanymaster VALUES (54, 'LOGITECH', 17);
INSERT INTO public.inventory_productcompanymaster VALUES (55, 'JABRA', 17);
INSERT INTO public.inventory_productcompanymaster VALUES (56, 'KIRLOSKAR', 18);
INSERT INTO public.inventory_productcompanymaster VALUES (57, 'MAHINDRA', 18);
INSERT INTO public.inventory_productcompanymaster VALUES (58, 'HIK VISION', 19);
INSERT INTO public.inventory_productcompanymaster VALUES (59, 'SAMSANG', 20);
INSERT INTO public.inventory_productcompanymaster VALUES (60, 'GLOBUS', 20);
INSERT INTO public.inventory_productcompanymaster VALUES (61, 'CISCO', 21);
INSERT INTO public.inventory_productcompanymaster VALUES (62, 'DLINK', 21);
INSERT INTO public.inventory_productcompanymaster VALUES (20, 'HP', 4);
INSERT INTO public.inventory_productcompanymaster VALUES (63, 'iBall', 5);
INSERT INTO public.inventory_productcompanymaster VALUES (64, 'Video Spliter', 6);
INSERT INTO public.inventory_productcompanymaster VALUES (65, '1 Meter LAN Cable', 22);
INSERT INTO public.inventory_productcompanymaster VALUES (66, '2 Meter LAN Cable', 22);
INSERT INTO public.inventory_productcompanymaster VALUES (67, 'OTHER UPS', 3);
INSERT INTO public.inventory_productcompanymaster VALUES (68, 'ACER', 5);
INSERT INTO public.inventory_productcompanymaster VALUES (69, 'ACER', 4);
INSERT INTO public.inventory_productcompanymaster VALUES (70, 'iBall', 4);
INSERT INTO public.inventory_productcompanymaster VALUES (71, 'DLink changeto Other', 7);
INSERT INTO public.inventory_productcompanymaster VALUES (72, 'Lapcare', 23);
INSERT INTO public.inventory_productcompanymaster VALUES (73, 'Lenovo', 4);
INSERT INTO public.inventory_productcompanymaster VALUES (74, 'DLink', 24);
INSERT INTO public.inventory_productcompanymaster VALUES (75, 'ProDot', 25);
INSERT INTO public.inventory_productcompanymaster VALUES (76, 'LLOYD', 20);
INSERT INTO public.inventory_productcompanymaster VALUES (77, 'DUMMY', 26);
INSERT INTO public.inventory_productcompanymaster VALUES (78, 'Optima', 16);
INSERT INTO public.inventory_productcompanymaster VALUES (79, 'Polycom', 11);
INSERT INTO public.inventory_productcompanymaster VALUES (81, 'LG', 20);
INSERT INTO public.inventory_productcompanymaster VALUES (82, 'WIPRO', 4);


--
-- Data for Name: inventory_productdetails; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.inventory_productdetails VALUES (1, '9QJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (2, '61HCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (3, '3QJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (4, '1SJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (5, 'DQJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (6, '32HCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (7, '1RJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (8, 'CRJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (9, 'CTJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (10, '4SJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (11, 'HQJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (12, '9VJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (13, '2RJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (14, 'GZGCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (15, '31HCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (16, '8ZGCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (17, '7SJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (866, 'VNC4L89186', '2024-06-14', 1, 1, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (19, 'BVJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (20, 'BZGCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (21, 'D1HCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (22, 'CQJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (995, 'X68K001697', '2024-08-07', 1, 1, 'Ink 5', '', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (24, 'BQJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (25, '2QJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (26, '5RJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (27, 'BNJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (28, 'BXGCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (30, '41HCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (31, '52HCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (32, 'C1HCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (1000, '3CQ41104KT', '2024-08-13', 1, 0, '', '', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (35, 'GXGCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (1001, 'VNC3J10320', '2024-09-06', 1, 0, '88A', '', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (38, '21HCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (40, 'FXGCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (41, 'DXGCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (43, 'F1HCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (44, '42HCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (45, '82HCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (46, '51HCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (47, '81HCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (48, '3SJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (49, '72HCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (50, '4VJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (51, 'GRJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (52, '62HCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (53, '8VJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (54, 'B1HCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (56, '9PJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (57, 'BRJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (58, '2VJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (59, '6SJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (60, '6TJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (1009, 'UXVQVSI104I4785494', '2024-09-12', 1, 0, '', '', 'OPENED', 6, 1);
INSERT INTO public.inventory_productdetails VALUES (62, '71HCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (63, 'CSJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (64, '7VJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (65, '5QJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (66, 'CVJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (67, 'FSJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (68, '4TJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (69, 'C2HCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (70, 'HNJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (71, '6VJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (72, 'DSJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (73, '8SJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (74, '91HCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (871, 'S70157GLM1G1DR', '2024-06-14', 1, 1, ' ', ' ', 'OPENED', 34, 1);
INSERT INTO public.inventory_productdetails VALUES (77, '1QJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (78, 'DPJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (79, '3VJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (80, '5PJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (81, 'BTJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (82, '6QJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (83, '8TJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (84, '5VJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (85, '1PJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (86, 'GPJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (87, '7TJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (88, '3RJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (1002, '3CQ20214NC', '2024-09-09', 1, 0, '', '', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (90, 'DTJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (91, '4RJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (92, '8QJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (93, '90HCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (94, 'BPJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (95, '8PJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (96, '7QJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (98, 'GSJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (99, 'CNJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (100, '5SJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (101, '20HCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (102, '5TJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (103, '4QJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (104, '3TJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (1027, '12211117466', '2024-11-27', 1, 0, '', '', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (106, 'GNJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (1031, '18050382', '2024-12-05', 1, 1, '', '', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (108, 'GQJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (55, '4PJCS14', '2024-04-23', 1, 0, '', '', 'OPENED', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (42, '8NJCS14', '2024-04-23', 1, 0, '', '', 'OPENED', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (1039, 'QS7L312023850', '2024-12-07', 1, 0, '', 'With Power Adapter', 'OPENED', 113, 1);
INSERT INTO public.inventory_productdetails VALUES (1047, 'VNC3508460', '2024-12-11', 1, 1, '88A', '', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (1054, 'X68K001727', '2024-12-12', 1, 1, 'black ink 005', '', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (111, 'GTJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (996, 'VNC3508240', '2024-08-07', 1, 0, '88A', '', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (212, 'AOCCM5D94101498', '2024-05-22', 1, 1, ' ', ' ', 'OPENED', 18, 1);
INSERT INTO public.inventory_productdetails VALUES (115, 'HPJCS14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (1010, 'INA609YWB2', '2024-09-12', 1, 0, '', '', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (117, 'FX28S14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 98, 3);
INSERT INTO public.inventory_productdetails VALUES (118, '1V28S14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 98, 3);
INSERT INTO public.inventory_productdetails VALUES (119, '7V28S14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 98, 3);
INSERT INTO public.inventory_productdetails VALUES (120, 'G338S14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 98, 3);
INSERT INTO public.inventory_productdetails VALUES (121, 'BS28S14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 98, 3);
INSERT INTO public.inventory_productdetails VALUES (122, '6Y28S14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 98, 3);
INSERT INTO public.inventory_productdetails VALUES (123, 'FC28S14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 98, 3);
INSERT INTO public.inventory_productdetails VALUES (124, '1X28S14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 98, 3);
INSERT INTO public.inventory_productdetails VALUES (125, '1Z28S14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 98, 3);
INSERT INTO public.inventory_productdetails VALUES (126, 'GT28S14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 98, 3);
INSERT INTO public.inventory_productdetails VALUES (127, '1W28S14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 98, 3);
INSERT INTO public.inventory_productdetails VALUES (128, '7T28S14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 98, 3);
INSERT INTO public.inventory_productdetails VALUES (129, '4T28S14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 98, 3);
INSERT INTO public.inventory_productdetails VALUES (130, '2V28S14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 98, 3);
INSERT INTO public.inventory_productdetails VALUES (131, '2S28S14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 98, 3);
INSERT INTO public.inventory_productdetails VALUES (132, 'H138S14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 98, 3);
INSERT INTO public.inventory_productdetails VALUES (133, '9S28S14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 98, 3);
INSERT INTO public.inventory_productdetails VALUES (134, '6T28S14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 98, 3);
INSERT INTO public.inventory_productdetails VALUES (135, '5X28S14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 98, 3);
INSERT INTO public.inventory_productdetails VALUES (136, 'DT28S14', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 98, 3);
INSERT INTO public.inventory_productdetails VALUES (137, 'CN0YY9P2QDC003BA0GXI', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 99, 4);
INSERT INTO public.inventory_productdetails VALUES (138, 'CN0YY9P2QDC003BA0I2I', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 99, 4);
INSERT INTO public.inventory_productdetails VALUES (139, 'CN0YY9P2QDC003BA0GWI', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 99, 4);
INSERT INTO public.inventory_productdetails VALUES (140, 'CN0YY9P2QDC003BA0I8I', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 99, 4);
INSERT INTO public.inventory_productdetails VALUES (141, 'CN0YY9P2QDC003BA0HBI', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 99, 4);
INSERT INTO public.inventory_productdetails VALUES (142, 'CN0YY9P2QDC003BD1PVI', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 99, 4);
INSERT INTO public.inventory_productdetails VALUES (143, 'CN0YY9P2QDC003BD1P6I', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 99, 4);
INSERT INTO public.inventory_productdetails VALUES (144, 'CN0YY9P2QDC003BD1ONI', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 99, 4);
INSERT INTO public.inventory_productdetails VALUES (145, 'CN0YY9P2QDC003BA0G2I', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 99, 4);
INSERT INTO public.inventory_productdetails VALUES (146, 'CN0YY9P2QDC003BD1PTI', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 99, 4);
INSERT INTO public.inventory_productdetails VALUES (147, 'CN0YY9P2QDC003BD1PEI', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 99, 4);
INSERT INTO public.inventory_productdetails VALUES (148, 'CN0YY9P2QDC003BD1P2I', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 99, 4);
INSERT INTO public.inventory_productdetails VALUES (149, 'CN0YY9P2QDC003BA0HNI', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 99, 4);
INSERT INTO public.inventory_productdetails VALUES (150, 'CN0YY9P2QDC003BD1PLI', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 99, 4);
INSERT INTO public.inventory_productdetails VALUES (151, 'CN0YY9P2QDC003BA0GLI', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 99, 4);
INSERT INTO public.inventory_productdetails VALUES (152, 'CN0YY9P2QDC003BG0P0I', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 99, 4);
INSERT INTO public.inventory_productdetails VALUES (153, 'CN0YY9P2QDC003BD1DBI', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 99, 4);
INSERT INTO public.inventory_productdetails VALUES (154, 'CN0YY9P2QDC003BA0GPI', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 99, 4);
INSERT INTO public.inventory_productdetails VALUES (155, 'CN0YY9P2QDC003BA0HWI', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 99, 4);
INSERT INTO public.inventory_productdetails VALUES (156, 'CN0YY9P2QDC003BD1PSI', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 99, 4);
INSERT INTO public.inventory_productdetails VALUES (157, 'PHMZQ03520', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 100, 5);
INSERT INTO public.inventory_productdetails VALUES (158, 'PHMZQ03237', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 100, 5);
INSERT INTO public.inventory_productdetails VALUES (159, 'PHMZQ03402', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 100, 5);
INSERT INTO public.inventory_productdetails VALUES (160, 'PHMZQ03643', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 100, 5);
INSERT INTO public.inventory_productdetails VALUES (161, 'PHMZQ03582', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 100, 5);
INSERT INTO public.inventory_productdetails VALUES (163, 'PHMZQ03473', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 100, 5);
INSERT INTO public.inventory_productdetails VALUES (164, 'PHMZQ03442', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 100, 5);
INSERT INTO public.inventory_productdetails VALUES (165, 'PHMZQ03419', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 100, 5);
INSERT INTO public.inventory_productdetails VALUES (166, 'PHMZQ03450', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 100, 5);
INSERT INTO public.inventory_productdetails VALUES (167, 'PHMZQ03440', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 100, 5);
INSERT INTO public.inventory_productdetails VALUES (168, 'PHMZQ03228', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 100, 5);
INSERT INTO public.inventory_productdetails VALUES (169, 'PHMZQ03553', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 100, 5);
INSERT INTO public.inventory_productdetails VALUES (170, 'PHMZQ03633', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 100, 5);
INSERT INTO public.inventory_productdetails VALUES (171, 'PHMZQ03522', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 100, 5);
INSERT INTO public.inventory_productdetails VALUES (172, 'PHMZQ03569', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 100, 5);
INSERT INTO public.inventory_productdetails VALUES (174, 'PHMZQ03451', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 100, 5);
INSERT INTO public.inventory_productdetails VALUES (175, 'PHMZQ03544', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 100, 5);
INSERT INTO public.inventory_productdetails VALUES (177, '0AT2HPAWA00340', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 101, 6);
INSERT INTO public.inventory_productdetails VALUES (178, '0AT2HPAW900168', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 101, 6);
INSERT INTO public.inventory_productdetails VALUES (179, '0AT2HPAW900164', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 101, 6);
INSERT INTO public.inventory_productdetails VALUES (180, '0AT2HPAWA00405', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 101, 6);
INSERT INTO public.inventory_productdetails VALUES (181, '0AT2HPAWA00306', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 101, 6);
INSERT INTO public.inventory_productdetails VALUES (182, '0AT2HPAWA00335', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 101, 6);
INSERT INTO public.inventory_productdetails VALUES (183, '0AT2HPAWA00393', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 101, 6);
INSERT INTO public.inventory_productdetails VALUES (184, '0AT2HPAWA00353', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 101, 6);
INSERT INTO public.inventory_productdetails VALUES (185, '2322LV000A48', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 53, 7);
INSERT INTO public.inventory_productdetails VALUES (186, '2320LV0074W8', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 53, 7);
INSERT INTO public.inventory_productdetails VALUES (187, '2322LV000A38', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 53, 7);
INSERT INTO public.inventory_productdetails VALUES (188, '2320LV0074E8', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 53, 7);
INSERT INTO public.inventory_productdetails VALUES (189, '2320LV0070Z8', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 53, 7);
INSERT INTO public.inventory_productdetails VALUES (190, '2322LV000A18', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 53, 7);
INSERT INTO public.inventory_productdetails VALUES (191, '2322LV0009Z8', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 53, 7);
INSERT INTO public.inventory_productdetails VALUES (192, '2320LV007358', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 53, 7);
INSERT INTO public.inventory_productdetails VALUES (193, 'X9ZG000486', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 102, 8);
INSERT INTO public.inventory_productdetails VALUES (194, 'X9ZG000509', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 102, 8);
INSERT INTO public.inventory_productdetails VALUES (195, 'X9ZG000502', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 102, 8);
INSERT INTO public.inventory_productdetails VALUES (196, 'X9ZG000508', '2024-04-23', 1, 1, '', '', 'NEW PRODUCT', 102, 8);
INSERT INTO public.inventory_productdetails VALUES (198, 'MMLXNSS00271700F744212', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (199, 'TJPG0990051J0849A', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 77, 1);
INSERT INTO public.inventory_productdetails VALUES (202, '3CQ4410YQB', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (203, 'TJPG0990051J3324A', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 77, 1);
INSERT INTO public.inventory_productdetails VALUES (201, '3CQ20216M8', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (204, '3CQ4410YNP', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (173, 'PHMZQ03519', '2024-04-23', 1, 0, '', '', 'OPENED', 100, 5);
INSERT INTO public.inventory_productdetails VALUES (249, 'TJPG0990051J2619A', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 77, 1);
INSERT INTO public.inventory_productdetails VALUES (275, 'TJPG0990051J3271A', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 77, 1);
INSERT INTO public.inventory_productdetails VALUES (250, '3CQ4410YPF', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (251, 'TJPG0990051J0451A', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 77, 1);
INSERT INTO public.inventory_productdetails VALUES (200, '3CQ20214LV', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (645, '6CM6041KZ6', '2024-06-14', 1, 1, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (162, 'PHMZQ03389', '2024-04-23', 1, 0, '', '', 'OPENED', 100, 5);
INSERT INTO public.inventory_productdetails VALUES (993, 'INA507Q55K', '2024-08-02', 1, 0, '', '', 'OPENED', 3, 1);
INSERT INTO public.inventory_productdetails VALUES (1048, 'VNC3J10865', '2024-12-11', 1, 1, '88A', '', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (277, 'TJPG0990051J3279A', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 77, 1);
INSERT INTO public.inventory_productdetails VALUES (252, '6CM6041M2L', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (278, 'MMLXNSS002721058664212', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (205, '3CQ20216PH', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (253, '3CQ20214N6', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (207, '3CQ20212R4', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (211, 'TJPG0990051J3252A', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 77, 1);
INSERT INTO public.inventory_productdetails VALUES (208, '6CM6041KMJ', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (254, '6CM6041KGJ', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (279, 'UR147010028410831C9F00', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 15, 1);
INSERT INTO public.inventory_productdetails VALUES (209, '6CM6041KZ9', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (255, '3CQ4433PD9', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (280, 'MMLXNSS00272105A2A4212', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (210, 'UR147010028320607B9F00', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 15, 1);
INSERT INTO public.inventory_productdetails VALUES (213, '3CQ20216LW', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (256, ' MMLY6SS0100170ED90850E', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 103, 1);
INSERT INTO public.inventory_productdetails VALUES (281, ' MMLY6SS0100170ED50850E', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 103, 1);
INSERT INTO public.inventory_productdetails VALUES (214, '3CQ20214N1', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (257, '3CQ20216MP', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (282, '3CQ20212QD', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (215, 'TJPG0990051J2575A', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 77, 1);
INSERT INTO public.inventory_productdetails VALUES (216, '3CQ20214KP', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (217, '6CM6041KFX', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (258, '6CM6041KZ2', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (218, 'MMLXNSS00272105A774212', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (259, 'UR147010028410838D9F00', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 15, 1);
INSERT INTO public.inventory_productdetails VALUES (219, '3CQ20216NL', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (220, '6CM6041K8V', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (260, '6CM6041LLC', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (283, '6CM6041KG8', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (221, 'UR14701002841082D19F00', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 15, 1);
INSERT INTO public.inventory_productdetails VALUES (261, '3CQ4462P5P', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (222, '6CM6041KM4', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (226, '3CQ4410YPT', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (263, '6CM6041KHS', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (285, 'CN0657PN6418045T0LRI', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 104, 1);
INSERT INTO public.inventory_productdetails VALUES (227, '6CM6041KFT', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (264, 'MMLY0SS011838036678525', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (228, 'AOCCM5D94101605', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 18, 1);
INSERT INTO public.inventory_productdetails VALUES (229, '3CQ4410YP2', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (230, 'MMLY6SS0100170ED66850E ', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 103, 1);
INSERT INTO public.inventory_productdetails VALUES (265, 'MMLY6SS0100170ED96850E ', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 103, 1);
INSERT INTO public.inventory_productdetails VALUES (286, 'MMLY6SS0100170ED83850E', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 103, 1);
INSERT INTO public.inventory_productdetails VALUES (231, 'MMLY6SS0100170ED91850E ', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 103, 1);
INSERT INTO public.inventory_productdetails VALUES (266, 'MMLY6SS0100170ED7C850E', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 103, 1);
INSERT INTO public.inventory_productdetails VALUES (994, '04156208', '2024-08-02', 1, 1, '', '', 'OPENED', 65, 1);
INSERT INTO public.inventory_productdetails VALUES (233, '3CQ4410YPL', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (287, 'TJPG0990051J3245A', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 77, 1);
INSERT INTO public.inventory_productdetails VALUES (234, '3CQ20216LL', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (268, '6CM6041KZ3', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (238, '3CQ4433QRC', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (269, '3CQ20214LT', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (288, '3CQ20214KB', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (239, 'UR14701002841073CA9F00', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 15, 1);
INSERT INTO public.inventory_productdetails VALUES (270, 'MMLY0SS011838036588525', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (289, '3CQ20214MJ', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (240, 'UR14701002841082E99F00', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 15, 1);
INSERT INTO public.inventory_productdetails VALUES (241, 'MMLXNSS002721059094212', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (242, 'MMLXNSS002721058454212', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (244, '3CQ4433PBY', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (243, '6CM6041L39', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (271, '3CQ4410YQM', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (290, '6CM6041KYZ', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (245, '3CQ4390V0N', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (272, '8CM6041M3Q', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (246, '6CM6041KGK', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (273, 'UR14701002841083839F00', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 15, 1);
INSERT INTO public.inventory_productdetails VALUES (291, 'UR14701002841082FF9F00', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 15, 1);
INSERT INTO public.inventory_productdetails VALUES (247, '6CM6041KGL', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (274, 'UR147010028410837A9F00', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 15, 1);
INSERT INTO public.inventory_productdetails VALUES (223, 'MMLXNSS0027210594E4212', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (262, '6CM6041M2Y', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (284, 'MMLXNSS0027170ABBE4212', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (224, 'UR147010028410781C9F00', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 15, 1);
INSERT INTO public.inventory_productdetails VALUES (225, '6CM6041L8D', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (300, 'UXVQVSI104I4785572', '2024-05-22', 1, 1, ' ', ' ', 'OPENED', 6, 1);
INSERT INTO public.inventory_productdetails VALUES (295, '1N120602XZ', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (296, '1N120601VT', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (346, 'VNC3508629', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (299, '1N120602YX', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (349, 'S45147PLM3Z7F7', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 33, 1);
INSERT INTO public.inventory_productdetails VALUES (298, 'UXVQVSI104I4785643', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 6, 1);
INSERT INTO public.inventory_productdetails VALUES (301, 'INA507Q4YS', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 3, 1);
INSERT INTO public.inventory_productdetails VALUES (302, '1N12070D7Y', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (352, 'VNC4L89044', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (303, '1N120602Y3', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (307, 'LT00300174', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 10, 1);
INSERT INTO public.inventory_productdetails VALUES (308, 'INA609YVVY', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 3, 1);
INSERT INTO public.inventory_productdetails VALUES (237, '3CQ20214M6', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (358, 'S45147PLM3Z5PD', '2024-05-22', 1, 1, ' ', ' ', 'OPENED', 33, 1);
INSERT INTO public.inventory_productdetails VALUES (353, 'VNC3J10422', '2024-05-22', 1, 1, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (357, 'S45147PLM3Z5P2', '2024-05-22', 1, 1, ' ', ' ', 'OPENED', 33, 1);
INSERT INTO public.inventory_productdetails VALUES (997, 'VNC3J10419', '2024-08-07', 1, 1, '88A', '', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (348, 'VNC3508235', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (1040, '1211117598', '2024-12-07', 1, 0, '', '', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (236, '3CQ4410YPP', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (1003, '12211117042', '2024-09-09', 1, 0, '', '', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (347, 'X68K001718', '2024-05-22', 1, 1, ' ', ' ', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (351, 'VNC3508237', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (304, 'INA609YW7V', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (354, 'VNC3J10746', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (305, '1N120602YC', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (355, 'X68K001969', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (306, 'UXVQVSI104I4785595', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 6, 1);
INSERT INTO public.inventory_productdetails VALUES (356, 'VNC488846', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (309, '1N120601V6', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (359, 'VNC3508454', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (310, '1N120601V9', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (360, 'VNC3J10796', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (311, 'INA609YW8W', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (312, '1N12070D8D', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (362, 'VNC3508614', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (313, '1N120601VJ', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (314, 'UXVPNSI530I4801229', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 8, 1);
INSERT INTO public.inventory_productdetails VALUES (364, 'X68K001705', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (315, '1N120602Y1', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (316, 'INA609YVXZ', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (365, 'VNC3J10676', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (317, 'UXVQVSI104I4785728', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 6, 1);
INSERT INTO public.inventory_productdetails VALUES (366, 'VNC3J10832', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (318, 'INA609YVR6', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (367, 'VNC3508241', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (322, 'UXVQVSI104I4785596', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 6, 1);
INSERT INTO public.inventory_productdetails VALUES (371, 'VNC4L88829', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (323, 'UXVQVSI104I4785600', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 6, 1);
INSERT INTO public.inventory_productdetails VALUES (324, '380LG32', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 11, 1);
INSERT INTO public.inventory_productdetails VALUES (373, 'VNC3J10807', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (325, '1N120601V5', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (374, 'VNC3507066', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (326, '1N120601Y0', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (375, 'VNC3508461', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (327, '1N1206035G', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (376, 'VNC3J10658', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (377, 'CNCHB78519', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 30, 1);
INSERT INTO public.inventory_productdetails VALUES (378, 'S45147PLM3Z6BW', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 33, 1);
INSERT INTO public.inventory_productdetails VALUES (329, '1N1206020N', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (379, 'VNC3J10535', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (330, 'INA609YW4P', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (380, 'VNC4L89489', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (382, 'X68K001669', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (383, 'VNC4L84546', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (384, 'VNC4L34450', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (385, 'VNC4L88900', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (336, 'UXVQVSI104I4785698', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 6, 1);
INSERT INTO public.inventory_productdetails VALUES (337, 'INA609YW2R', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (387, 'CNCHB78511', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 30, 1);
INSERT INTO public.inventory_productdetails VALUES (338, 'INA609YVM1', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (388, 'X68K001620', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (340, 'INA609YVYX', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (339, 'INA506Q4ZD', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 3, 1);
INSERT INTO public.inventory_productdetails VALUES (389, 'VNC4L89090', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (341, '1N120601YQ', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (342, '1N1206020G', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (343, 'UXVQVSI104I4785566', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 6, 1);
INSERT INTO public.inventory_productdetails VALUES (368, 'X68K001602', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (320, '1N120601VF', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (369, 'S45147PLM3Z5NL', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 33, 1);
INSERT INTO public.inventory_productdetails VALUES (321, 'INA609YVNM', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (370, 'X68K001724', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (444, '0AJYHPBRC00214A', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (424, '12211117026', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (449, '0AJYHPBRC00373B', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (394, '18050449', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (395, '1adj1', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (458, '2104LZ953EP8', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (396, '1adjsteno1', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (393, '7cj2dw1', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (457, '0AJYHPBRC00420H', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (445, '0AJYHPBRC00232D', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (459, '2104LZ96S848', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (401, 'Iadjcr1', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (437, '1adj2', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (446, '0AJYHPBRC00096N', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (438, '1adjsteno2', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (402, '1adjcrr1', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (460, '2104LZ953GG8', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (397, '12211117480', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (405, '6adjpw1', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (443, '007X3GC004682', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 89, 1);
INSERT INTO public.inventory_productdetails VALUES (404, '12211117031', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (398, '12211117494', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (403, '12211117030', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (408, '3cj2dw1', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (399, '3A1cj1dw1', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (411, '12211116887', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (447, '0AJYHPBRC00364T', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (461, '2104LZ96RZNB', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (400, '3A1cj1cvr1', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (390, 'VNC3508243', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (361, 'S45147PLM3Z6N4', '2024-05-22', 1, 1, ' ', ' ', 'OPENED', 33, 1);
INSERT INTO public.inventory_productdetails VALUES (331, 'INA507Q4ZH', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 3, 1);
INSERT INTO public.inventory_productdetails VALUES (334, '1N12060207', '2024-05-22', 1, 1, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (478, '', '2024-05-23', 50, 49, '', '', 'OPENED', 78, 1);
INSERT INTO public.inventory_productdetails VALUES (381, 'S45147PLM3Z653', '2024-05-22', 1, 1, ' ', ' ', 'OPENED', 33, 1);
INSERT INTO public.inventory_productdetails VALUES (372, 'S45147PLM3Z6NW', '2024-05-22', 1, 1, ' ', ' ', 'OPENED', 33, 1);
INSERT INTO public.inventory_productdetails VALUES (333, 'INA609YVJX', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (235, 'MMLXNSS00272105A034212', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (332, 'INA609YWB3', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (267, 'TJPG0990051J2620A', '2024-05-22', 1, 1, ' ', ' ', 'OPENED', 77, 1);
INSERT INTO public.inventory_productdetails VALUES (386, 'CNCHD26699', '2024-05-22', 1, 1, ' ', ' ', 'OPENED', 30, 1);
INSERT INTO public.inventory_productdetails VALUES (335, 'UXVPNSI530I4801212', '2024-05-22', 1, 1, ' ', ' ', 'OPENED', 6, 1);
INSERT INTO public.inventory_productdetails VALUES (328, 'INA609YW10', '2024-05-22', 1, 1, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (448, '0AJYHPBRC00231R', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (462, '2104LZ96S8A8', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (418, 'AsjcrR1', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (453, '0AJYHPBRC00363A', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (429, '12211117032', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (406, '6adjcrR1', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (407, '12211116916', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (410, '4cj1dw1', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (417, 'Asjftcdw1', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (463, '2104LZ96RU38', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (409, '12211117037', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (416, '12211117737', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (450, '0AJYHPBRC00411R', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (430, '12211116863', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (464, '2104LZ96RZX8', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (412, '14811113288', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (428, '12211117471', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (419, '12211116885', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (452, '0AJYHPBRC00095J', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (466, '2104LZ953GC8', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (414, '4cj2steno1', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (420, '12211117742', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (421, '12211117478', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (467, '2104LZ9653GF8', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (422, '8adjdw1', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (426, '14cj2dw1', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (423, '8adjsteno1', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (425, '8adjchamber1', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 65, 1);
INSERT INTO public.inventory_productdetails VALUES (454, '0AJYHPBRC00221W', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (468, '210L2953EQ8', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (455, '0AJYHPBRC00265L', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (469, '2113LZ92TFF8', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (427, '12211117472', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (431, '10cj1', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (432, '12211117043', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (413, '12211116862', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (456, '0AJYHPBRC00417B', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (433, '1221116864', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (441, '9cj2dw1', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (470, '2113LZ92TFCB', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (391, 'VVC4L89423', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (434, '12211117469', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (471, '2113LZ92TFJ8', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (392, 'VNC3508598', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (435, '12211117470', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (451, '0AJYHPBRC00421X', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (465, '2113LZ92TCV8', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (415, '4cj2crR1', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (75, '2TJCS14', '2024-04-23', 1, 0, '', '', 'OPENED', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (484, '3A1cj1st1', '2024-05-23', 1, 0, '', '', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (486, 'DRJCS14', '2024-05-23', 1, 0, '', '', 'OPENED', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (489, 'MMLY6SS0100170ED4D850E', '2024-05-22', 1, 0, '', '', 'OPENED', 103, 1);
INSERT INTO public.inventory_productdetails VALUES (490, '1TJCS14', '2024-05-24', 1, 0, '', '', 'OPENED', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (491, '9cj2dw2', '2024-05-24', 1, 0, '', '', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (514, '6CM6041M45', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (495, '3CQ20216MD', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (496, 'UR14701002832061019F00', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 15, 1);
INSERT INTO public.inventory_productdetails VALUES (494, '3CQ20215SF', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (493, 'UR14701002841082D39F00', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 15, 1);
INSERT INTO public.inventory_productdetails VALUES (515, 'MMLXNSS002721059384212', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (507, 'MMLXNSS002721058234212', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (498, '6CM6041KH7', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (499, 'MMLXNSS00272105A344212', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (505, '6CM6041KHL', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (509, 'TJPG0990051J0406A', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 77, 1);
INSERT INTO public.inventory_productdetails VALUES (497, '3CQ20216NG', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (516, '6CM6041LLJ', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (504, '3CQ20216P0', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (503, '6CM6041KGH', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (517, '6CM6041KZ4', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (501, '3CQ4410YP1', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (500, '6CM6041KH8', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (513, 'MMLXNSS0027170ABDC4212', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (518, '6CM6041K88', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (510, 'UR14701002841082FB9F00', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 15, 1);
INSERT INTO public.inventory_productdetails VALUES (506, '6CM6041KZ0', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (248, 'TJPG0990051J3258A', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 77, 1);
INSERT INTO public.inventory_productdetails VALUES (511, 'MMLXNSS002721058574212', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (512, 'MMLXNSS00272105A314212', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (482, '', '2024-05-23', 100, 83, '', '', 'OPENED', 86, 1);
INSERT INTO public.inventory_productdetails VALUES (508, '3CQ20216LR', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (485, '', '2024-05-23', 50, 31, '', '', 'OPENED', 73, 1);
INSERT INTO public.inventory_productdetails VALUES (345, 'S45147PLM3Z6V0', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 33, 1);
INSERT INTO public.inventory_productdetails VALUES (472, '1cj2dw1', '2024-05-23', 1, 0, '', '', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (492, '6CM6041M4J', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (526, '3CQ20214L8', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (533, 'UXVQVSI104I4785659', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 6, 1);
INSERT INTO public.inventory_productdetails VALUES (558, 'CNCHB78524', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 30, 1);
INSERT INTO public.inventory_productdetails VALUES (574, '12211117463', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (595, 'AJYHPBRC00419E', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (600, '2113L Z92TFQ8', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (534, '1N120601Z9', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (474, '', '2024-05-23', 100, 27, '', '', 'OPENED', 67, 1);
INSERT INTO public.inventory_productdetails VALUES (502, '3CQ20214KQ', '2024-05-25', 1, 1, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (473, '', '2024-05-23', 100, 65, '', '', 'OPENED', 71, 1);
INSERT INTO public.inventory_productdetails VALUES (488, '', '2024-05-24', 50, 25, '', '', 'OPENED', 68, 1);
INSERT INTO public.inventory_productdetails VALUES (481, '', '2024-05-23', 100, 65, '', '', 'OPENED', 76, 1);
INSERT INTO public.inventory_productdetails VALUES (487, '', '2024-05-23', 50, 47, '', '', 'OPENED', 69, 1);
INSERT INTO public.inventory_productdetails VALUES (477, '', '2024-05-23', 100, 88, '', '', 'OPENED', 87, 1);
INSERT INTO public.inventory_productdetails VALUES (480, '', '2024-05-23', 50, 44, '', '', 'OPENED', 75, 1);
INSERT INTO public.inventory_productdetails VALUES (476, '', '2024-05-23', 50, 44, '', '', 'OPENED', 88, 1);
INSERT INTO public.inventory_productdetails VALUES (475, '', '2024-05-23', 100, 97, '', '', 'OPENED', 70, 1);
INSERT INTO public.inventory_productdetails VALUES (559, 'VNC4L88678', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (575, '16cj2dw1', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (535, 'INA609YWD5', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (536, '1N12070D8G', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (537, 'INA609YW8M', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (562, 'VNC3J10756', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (576, '12211117464', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (527, '3CQ20214NB', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (577, '12211117486', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (579, '12cj2st1', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (528, '3CQ4462P6K', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (539, '1N1206035C', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (563, 'VNC4L89441', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (578, '12211117485', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (580, '12cj2dw1', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (596, '0AJYHPBRC00362E', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (601, '2106LZ91U6N8', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (605, 'SwetaPatel', '2024-05-26', 1, 0, '', '', 'OPENED', 89, 1);
INSERT INTO public.inventory_productdetails VALUES (540, 'UXVQVSI104I4785547', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 6, 1);
INSERT INTO public.inventory_productdetails VALUES (581, '12cj2cvr1', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (541, 'INA609YVSY', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (529, '6CM6041L2S', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (542, '1N1206020Z', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (565, 'VNC3J10659', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (583, '4adjdw1', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (597, '0AJYHPBRC00104H', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (602, '2104LZ953GE8', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (519, '3CQ20216LK', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (543, 'INA609YVZ7', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (566, 'VNC4L89546', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (584, '4adjst1', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (520, '3CQ20216P7', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (544, 'INA609YVTM', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (567, 'X68K001613', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (582, '12211117493', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (545, '1N120601WF', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (585, '4adjcvr1', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (606, 'SunitaToppo', '2024-05-26', 1, 0, '', '', 'OPENED', 89, 1);
INSERT INTO public.inventory_productdetails VALUES (546, 'INA609YVL6', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (568, 'VNC3508247', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (587, '4adjcrr1', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (521, 'TJPG0990051J2114A', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 77, 1);
INSERT INTO public.inventory_productdetails VALUES (547, '1N1206034X', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (569, 'VNC3508457', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (589, '3cj1dw1', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (598, '0AJYHPBRC00353N', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (603, '2104LZ96S4J8', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (549, 'INA609YVLF', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (590, '3cj1dw2', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (522, 'MMLXNSS00272105A414212', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (548, 'UXVQVSI104I4785661', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 6, 1);
INSERT INTO public.inventory_productdetails VALUES (570, 'VNC4L89086', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (586, '12211117487', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (550, '1N120601VV', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (551, 'INA609YVZF', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (571, 'X68K001639', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (588, '12211117488', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (523, '3CQ20214LK', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (530, '3CQ4433PC7', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (555, 'INA609YW3Q', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (176, 'PHMZQ03523', '2024-04-23', 1, 0, '', '', 'OPENED', 100, 5);
INSERT INTO public.inventory_productdetails VALUES (560, 'VNC4L28478', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (591, '4ftcst1', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (593, '4ftcst2', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (524, '6CM6041JZV', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (531, 'MMLXNSS00272105A524212', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (553, '1N1206034G', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (556, '1N12070DCQ', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (572, 'VNC4L28519', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (592, '4ftcdw1', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (594, '12211117506', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (599, '0AJYHPBRC00158F', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (604, '2104LZ953EU8', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (561, 'S70157PLM1H0CW', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 34, 1);
INSERT INTO public.inventory_productdetails VALUES (525, 'AOCCM5D94101603', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 18, 1);
INSERT INTO public.inventory_productdetails VALUES (554, 'INA609YVQG', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (573, 'VNC4L89553', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (197, 'TJPG0990051J0062A', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 77, 1);
INSERT INTO public.inventory_productdetails VALUES (294, 'UXVQVSI104I4785541', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 7, 1);
INSERT INTO public.inventory_productdetails VALUES (607, '1VJCS14', '2024-05-28', 1, 1, '', '', 'NEW', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (608, '2SJCS14', '2024-05-28', 1, 1, '', '', 'NEW', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (609, '6RJCS14', '2024-05-28', 1, 1, '', '', 'NEW', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (610, '7PJCS14', '2024-05-28', 1, 1, '', '', 'NEW', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (611, '7RJCS14', '2024-05-28', 1, 1, '', '', 'NEW', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (612, '8RJCS14', '2024-05-28', 1, 1, '', '', 'NEW', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (613, '9NJCS14', '2024-05-28', 1, 1, '', '', 'NEW', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (614, '9RJCS14', '2024-05-28', 1, 1, '', '', 'NEW', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (615, '9SJCS14', '2024-05-28', 1, 1, '', '', 'NEW', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (616, '9TJCS14', '2024-05-28', 1, 1, '', '', 'NEW', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (618, 'BSJCS14', '2024-05-28', 1, 1, '', '', 'NEW', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (619, 'CZGCS14', '2024-05-28', 1, 1, '', '', 'NEW', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (620, 'FNJCS14', '2024-05-28', 1, 1, '', '', 'NEW', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (621, 'FPJCS14', '2024-05-28', 1, 1, '', '', 'NEW', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (622, 'FQJCS14', '2024-05-28', 1, 1, '', '', 'NEW', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (623, 'FRJCS14', '2024-05-28', 1, 1, '', '', 'NEW', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (624, 'FTJCS14', '2024-05-28', 1, 1, '', '', 'NEW', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (788, 'INA609YVW1', '2024-06-14', 1, 1, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (1004, '6CM6041KLD', '2024-09-09', 1, 0, '', '', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (1012, 'UR14701002832060E59F00', '2024-09-12', 1, 0, '', '', 'OPENED', 15, 1);
INSERT INTO public.inventory_productdetails VALUES (538, 'INA609YVRJ', '2024-05-25', 1, 2, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (564, 'X68K000771', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (552, 'UXVQVSI104I4785569', '2024-05-25', 1, 0, ' ', ' ', 'OPENED', 6, 1);
INSERT INTO public.inventory_productdetails VALUES (998, 'VNC3J10809', '2024-08-07', 1, 1, '88A', '', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (617, 'B2HCS14', '2024-05-28', 1, 0, '', '', 'OPENED', 97, 2);
INSERT INTO public.inventory_productdetails VALUES (1041, 'VNC3J10524', '2024-12-11', 1, 1, '88A', '', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (626, 'UR14701002832060ED9F00', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 15, 1);
INSERT INTO public.inventory_productdetails VALUES (999, 'VNC4L35584', '2024-08-08', 1, 1, '88A', '', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (1005, '1N120601VP', '2024-09-10', 1, 0, '', '', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (1013, 'VNC3J10810', '2024-09-12', 1, 0, '88A', '', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (1035, '6CM6041KHB', '2024-12-05', 1, 1, '', '', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (1042, 'VNC3J10415', '2024-12-11', 1, 1, '88A', '', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (1049, 'VNC3508607', '2024-12-11', 1, 1, '88A', '', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (1055, 'X68K000345', '2024-12-12', 1, 1, 'black ink 005', '', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (687, 'Q74F818AAAAAC0034', '2024-06-14', 1, 1, ' ', ' ', 'OPENED PRODUCT', 105, 1);
INSERT INTO public.inventory_productdetails VALUES (718, '3CQ20214M0', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (701, '6CM6041M29', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (719, 'UR1470100284107AB09F00', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 15, 1);
INSERT INTO public.inventory_productdetails VALUES (702, 'TJPG0990051J0017A', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 77, 1);
INSERT INTO public.inventory_productdetails VALUES (720, 'AOCCM5D94101407', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 18, 1);
INSERT INTO public.inventory_productdetails VALUES (812, 'VNC4L89207', '2024-06-14', 1, 1, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (319, 'INA609YVZ1', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (1014, '10011117489', '2024-09-12', 1, 0, '', '', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (1036, 'INA609YVX1', '2024-12-05', 1, 1, '', '', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (1043, 'VNC3J10841', '2024-12-11', 1, 1, '88A', '', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (1050, 'VNC4L38780', '2024-12-11', 1, 1, '88A', '', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (1056, 'X68K001637', '2024-12-12', 1, 1, 'black ink 005', '', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (794, '1N12060217', '2024-06-14', 1, 1, ' ', ' ', 'OPENED PRODUCT', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (808, 'INA507Q50Z', '2024-06-14', 1, 1, ' ', ' ', 'OPENED PRODUCT', 3, 1);
INSERT INTO public.inventory_productdetails VALUES (809, '1S10QHS0DU00PC0V55Z0', '2024-06-14', 1, 1, ' ', ' ', 'OPENED PRODUCT', 46, 1);
INSERT INTO public.inventory_productdetails VALUES (810, 'SGH452SLM3', '2024-06-14', 1, 1, ' ', ' ', 'OPENED PRODUCT', 44, 1);
INSERT INTO public.inventory_productdetails VALUES (811, '8212310F4DB5CN', '2024-06-14', 1, 1, ' ', ' ', 'OPENED PRODUCT', 106, 1);
INSERT INTO public.inventory_productdetails VALUES (1006, '6CM6041L8G', '2024-09-11', 1, 0, '', '', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (1015, '18050583', '2024-09-12', 1, 0, '', '', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (1017, 'AOCCM5D94101417', '2024-09-20', 1, 1, '', '', 'OPENED', 18, 1);
INSERT INTO public.inventory_productdetails VALUES (1016, 'INA507Q4YX', '2024-09-19', 1, 0, '', '', 'OPENED', 3, 1);
INSERT INTO public.inventory_productdetails VALUES (859, 'CNCHB78510', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 30, 1);
INSERT INTO public.inventory_productdetails VALUES (1020, 'MMLXNSS002721070ED4212', '2024-10-10', 1, 0, '', '', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (1021, '12211117496', '2024-11-20', 1, 0, '', '', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (1024, '007X3I1009875', '2024-11-25', 1, 0, '', 'With Power Adapter', 'OPENED', 107, 1);
INSERT INTO public.inventory_productdetails VALUES (1032, 'INA609YW2H', '2024-12-05', 1, 0, '', '', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (1033, 'X68K001720', '2024-12-05', 1, 0, 'black ink 005', '', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (1034, '18051168', '2024-12-05', 1, 0, '', '', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (1028, '3CQ20216LD', '2024-12-05', 1, 0, '', '', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (1044, 'VNC3J10418', '2024-12-11', 1, 1, '88A', '', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (1051, 'X68K000632', '2024-12-12', 1, 1, 'black ink 005', '', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (1057, 'X68K001647', '2024-12-12', 1, 1, 'black ink 005', '', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (874, '12211117028', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (876, '12211117025', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (875, 'Cjmst2', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (877, 'Cjmcvr1', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (816, 'VNC3508526', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (878, 'djdw1', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (297, 'UXVQVSI104I4785686', '2024-05-22', 1, 1, ' ', ' ', 'OPENED', 7, 1);
INSERT INTO public.inventory_productdetails VALUES (1007, 'MMLXNSS0027170ABB84212', '2024-09-11', 1, 0, '', '', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (1011, 'UR14701002832060879F00', '2024-09-12', 1, 0, '', '', 'OPENED', 15, 1);
INSERT INTO public.inventory_productdetails VALUES (1018, 'kept123', '2024-09-20', 1, 1, '', '', 'OPENED', 65, 1);
INSERT INTO public.inventory_productdetails VALUES (1022, '1N1206034T', '2024-11-21', 1, 0, '', '', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (1025, 'rec1', '2024-11-25', 1, 0, '', '', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (1029, '6CM6041JZ7', '2024-12-05', 1, 0, '', '', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (479, '', '2024-05-23', 100, 4, '', '', 'OPENED', 72, 1);
INSERT INTO public.inventory_productdetails VALUES (1037, '', '2024-12-07', 3, 2, '', '', 'OPENED', 112, 1);
INSERT INTO public.inventory_productdetails VALUES (1045, 'VNC3508251', '2024-12-11', 1, 1, '88A', '', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (1052, 'X68K001652', '2024-12-12', 1, 1, 'black ink 005', '', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (1058, 'X68K001728', '2024-12-12', 1, 1, 'black ink 005', '', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (232, '3CQ4433PBH', '2024-05-22', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (363, 'X68K001623', '2024-05-22', 1, 1, ' ', ' ', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (483, '', '2024-05-23', 200, 146, '', '', 'OPENED', 79, 1);
INSERT INTO public.inventory_productdetails VALUES (628, '6CM6041KJM', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (627, '3CQ4433PFD', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (629, '6CM6041LSB', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (630, 'TJPG0990051J3261A', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 77, 1);
INSERT INTO public.inventory_productdetails VALUES (631, '6CM6041LSY', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (636, 'MMLXNSS0027210584E4212', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (632, '6CM6041M44', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (633, 'TJPG0990051J0168A', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 77, 1);
INSERT INTO public.inventory_productdetails VALUES (634, 'MMLXNSS002721058EF4212', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (635, '3CQ2410SH1', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (942, '2113L Z92TFQ8', '2024-06-14', 1, 1, ' ', ' ', 'OPENED PRODUCT', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (637, 'MMLXNSS002721059474212', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (703, 'MMLY0SS011838036598525', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (721, '6CM6041LLN', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (638, '6CM6041KKD', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (704, '6CM6041KG9', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (639, 'UR14701002841082D79F00', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 15, 1);
INSERT INTO public.inventory_productdetails VALUES (640, 'AOCCM5D94101335', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 18, 1);
INSERT INTO public.inventory_productdetails VALUES (641, 'MMLXNSS00272105A2C4212', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (642, 'MMLXNSS002721059F54212', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (705, 'MMLXNSS002721058ED4212', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (643, 'TJPJ0990051J324A', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 77, 1);
INSERT INTO public.inventory_productdetails VALUES (706, 'TJPJ0990051J0436A', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 77, 1);
INSERT INTO public.inventory_productdetails VALUES (644, '3CQ20216P8', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (646, 'TJPG0990051J0189A', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 77, 1);
INSERT INTO public.inventory_productdetails VALUES (707, 'TJPG0990051J0920A', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 77, 1);
INSERT INTO public.inventory_productdetails VALUES (647, '3CQ20214L1', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (708, '3CQ20214LN', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (709, 'MMLXNSS00272105A024212', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (649, '3CQ44512VC', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (710, '6CM6041LS3', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (650, 'MMLXNSS00272105A3F4212', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (711, '3CQ4462P65', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (651, '6CM6041KHP', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (652, 'MMLXNSS00272105A294212', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (712, '6CM6041KHD', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (653, '6CM6041M2R', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (713, '6CM6041KLB', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (654, '6CM6041LLP', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (655, '6CM6041M3R', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (714, '6CM6041L3Q', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (656, 'UR14701002841078249F00', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 15, 1);
INSERT INTO public.inventory_productdetails VALUES (715, 'MMLXNSS0027170ABD64212', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (657, 'MMLY0SS01183803AC68525', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (658, 'UR147010028320610D9F00', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 15, 1);
INSERT INTO public.inventory_productdetails VALUES (659, 'UR14701002841082D89F00', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 15, 1);
INSERT INTO public.inventory_productdetails VALUES (660, '3CQ4410YP6', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (661, '3CQ4433PCX', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (662, '6CM6041KFR', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (663, '3CQ4410YRW', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (664, 'TJPG0990051J0152', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 77, 1);
INSERT INTO public.inventory_productdetails VALUES (665, '3CQ306051Z', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (666, 'MMLY0SS01183803ABE8525', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (667, '6CM6041KZD', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (716, 'KJLF92035M', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 41, 1);
INSERT INTO public.inventory_productdetails VALUES (668, 'TJpg0990051J2622A', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 77, 1);
INSERT INTO public.inventory_productdetails VALUES (669, 'TJPG0990051J3237A', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 77, 1);
INSERT INTO public.inventory_productdetails VALUES (672, 'TJPG0990051J3232A', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 77, 1);
INSERT INTO public.inventory_productdetails VALUES (671, 'AOCCM5D94101512', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 18, 1);
INSERT INTO public.inventory_productdetails VALUES (670, 'MMLY0SS0118380385F8525', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (674, '3CQ13011KJ', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (675, '6CM6041KH5', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (676, ' 60B8AAR6NPV900LZE9', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 110, 1);
INSERT INTO public.inventory_productdetails VALUES (677, '3CQ20216NS', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (678, '3CQ20214LM', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (679, 'MMLXNSS002721059544212', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (680, '3CQ20214L9', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (694, '3CQ20214N5', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (695, '3CQ9491L6F', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 21, 1);
INSERT INTO public.inventory_productdetails VALUES (696, '6CM6041LRX', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (697, '6CM6041LSX', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (698, '3CQ4433PCR', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (699, '6CM6041KFQ', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (681, '3CQ4410ZFG', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (682, '6CM6041KY6', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (683, '3CQ4433PDC', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (684, 'UR1470100283205FFE9F00', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 15, 1);
INSERT INTO public.inventory_productdetails VALUES (685, '3CQ9491L5Z', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 21, 1);
INSERT INTO public.inventory_productdetails VALUES (686, '3CQ44630CL', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (689, '3CQ5194170 ', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (690, '3CQ4433PDV', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (691, '6CM6041K08', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (692, '3CQ4433PCJ', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (693, '6CM6041JZD', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (717, '6CM6041M9G', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (673, 'TJPG0990051J0192A', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 77, 1);
INSERT INTO public.inventory_productdetails VALUES (732, '1N120601ZW', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (813, 'VNC3508244', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (734, 'UXVPNSI530I4801265', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 6, 1);
INSERT INTO public.inventory_productdetails VALUES (815, 'VNC3506992', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (733, 'INA507Q4XN', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 3, 1);
INSERT INTO public.inventory_productdetails VALUES (814, 'VNC3J10816', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (735, 'INA609YVJZ', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (736, 'INA507Q4XP', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 3, 1);
INSERT INTO public.inventory_productdetails VALUES (737, '1N120601W9', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (742, 'INA609YW9Y', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (738, 'INA609YW5S', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (739, 'UXVQVSI104I4785725', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 6, 1);
INSERT INTO public.inventory_productdetails VALUES (740, 'UXVQVSI104I4785574', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 6, 1);
INSERT INTO public.inventory_productdetails VALUES (741, 'INA609YVR1', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (743, '1N120601VK', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (722, '6CM6041LSV', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (744, 'INA609YW4K', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (745, 'INA609YVK4', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (746, '1N120601X4', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (747, 'INA609YVX4', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (723, '3CQ4433PBL', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (748, '1N12060360', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (724, 'TJPJ0990051J2815A', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 77, 1);
INSERT INTO public.inventory_productdetails VALUES (688, 'MMLXNSS0027170ABC74212', '2024-06-14', 1, 1, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (807, 'UXVQVSI104I4785732', '2024-06-14', 1, 1, ' ', ' ', 'OPENED', 6, 1);
INSERT INTO public.inventory_productdetails VALUES (749, 'UXVQVSI104I4785700', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 6, 1);
INSERT INTO public.inventory_productdetails VALUES (750, '1N120601ZM', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (725, 'TJPG0990051J3241A', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 77, 1);
INSERT INTO public.inventory_productdetails VALUES (752, '1N1206034M', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (753, 'UXVQVSI104I4785680', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 6, 1);
INSERT INTO public.inventory_productdetails VALUES (754, 'INA946QC44 ', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 5, 1);
INSERT INTO public.inventory_productdetails VALUES (726, 'MMLXNSS0027170ABB54212', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (756, '1N120601XX', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (757, 'INA507Q4YV', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 3, 1);
INSERT INTO public.inventory_productdetails VALUES (758, 'INA609YVKB', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (727, '6CM6041KGX', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (759, '1N120601W5', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (728, 'MMLY0SS0118380365E8525', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (760, 'UXVQVSI104I4785599', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 6, 1);
INSERT INTO public.inventory_productdetails VALUES (761, 'INA609YW0X', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (729, '3CQ20214M8', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (762, 'INA609YVPH', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (730, 'MMLXNSS002721058414212', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (763, '1N1206034R', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (764, 'INA609YWD4', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (765, 'UXVQVSI104I4785424', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 6, 1);
INSERT INTO public.inventory_productdetails VALUES (767, 'INA609YVWX', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (768, 'INA609YW7K', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (769, 'INA609YW22', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (770, 'INA507Q546', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 3, 1);
INSERT INTO public.inventory_productdetails VALUES (771, 'INA609YW8B', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (772, 'INA609YW0Y', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (773, '2UA6332N8J', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 3, 1);
INSERT INTO public.inventory_productdetails VALUES (774, 'INA609YVQ4', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (775, '1N12070DBJ', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (776, 'INA609YVV0', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (779, 'INA609YVSC', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (778, 'INA507Q552', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 3, 1);
INSERT INTO public.inventory_productdetails VALUES (777, '1N12070D81', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (766, 'UXVQVSI104I4785621', '2024-06-14', 1, 1, ' ', ' ', 'OPENED', 7, 1);
INSERT INTO public.inventory_productdetails VALUES (781, '1N120601VC', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (782, '1N1206035N', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (783, '1N120601WX', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (784, '1N120601WZ', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (785, 'UXVQVSI104I4785567', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 6, 1);
INSERT INTO public.inventory_productdetails VALUES (786, 'INA609YVT3', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (787, '1N12060215', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (801, '1N120602ZC', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (802, 'UXVPNSI530I4801246', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 8, 1);
INSERT INTO public.inventory_productdetails VALUES (803, 'INA609YW9W', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (805, 'INA609YVWQ', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (806, 'INA609YVT8', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (789, 'INA609YWBV', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (790, 'INA507Q4X9', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 3, 1);
INSERT INTO public.inventory_productdetails VALUES (792, 'UXVPNSI530I4801205', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 8, 1);
INSERT INTO public.inventory_productdetails VALUES (793, 'INA507Q4ZP', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 3, 1);
INSERT INTO public.inventory_productdetails VALUES (795, '1N12070D8B', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (796, 'UXVQVSI104I4785565', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 6, 1);
INSERT INTO public.inventory_productdetails VALUES (797, 'INA507Q51V', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 3, 1);
INSERT INTO public.inventory_productdetails VALUES (798, 'INA609YW3H', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (799, 'INA609YVLL', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (800, 'INA609YWCF', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (780, '1N12060356', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (821, 'CNBRPD140R', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 28, 1);
INSERT INTO public.inventory_productdetails VALUES (817, 'VNC3508631', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (879, '241906530105', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (823, 'VNC4L89538', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (818, 'VNC3J10824', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (872, '18M04393400000106VL4', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 36, 1);
INSERT INTO public.inventory_productdetails VALUES (880, 'djpw1', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (824, 'VNC3J10521', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (885, '12211117468', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (819, 'S45147PLM3Z6T6', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 33, 1);
INSERT INTO public.inventory_productdetails VALUES (881, 'Djcrr1', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (820, 'X68K001959', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (882, 'Djcrv1', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (822, 'VNC4L88847', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (884, '12211117741', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (825, 'CNBRPD09V3', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 28, 1);
INSERT INTO public.inventory_productdetails VALUES (886, '12211117752', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (883, '10cj2dw1', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (826, 'VNC4L89552', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (887, '10ch2st1', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (827, 'X68K001610', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (888, '10cj2pw1', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (828, 'VNC3508330', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (889, '12211117751', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (829, 'VNC3508252', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (830, 'VNC4L88836', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (891, '12211117462', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (832, 'S45147PLM3Z7CN', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 33, 1);
INSERT INTO public.inventory_productdetails VALUES (893, '1acj2st1', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (833, 'VNC3J10322', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (894, '1acj2st2', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (895, '1acj2cvr1', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (835, 'VNC3508455', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (896, '6cj2dw1', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (836, 'VNC4L85092', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (897, '12211117495', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (837, 'X68K001629', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (838, 'VNC3508605', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (898, '12211116886', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (804, 'INA609YW70', '2024-06-14', 1, 1, ' ', ' ', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (831, 'X68K001715', '2024-06-14', 1, 1, ' ', ' ', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (751, '1N12070D8M', '2024-06-14', 1, 1, ' ', ' ', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (892, '12211116861', '2024-06-14', 1, 1, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (791, 'INA507Q4YL', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 3, 1);
INSERT INTO public.inventory_productdetails VALUES (890, '12211117461', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (839, 'VNC3J10548', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (899, '3adjst1', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (840, 'VNC3J10802', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (900, '3adjcvr1', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (841, 'X68K001658', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (901, '3adjcrr1', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (842, 'VNC3J10664', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (902, '12211117749', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (843, 'X68K001768', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (903, '5cj2dw1', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (904, '5cj2st1', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (844, 'X68K001595', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (905, '12211117750', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (845, 'X68K001775', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (906, 'naza1', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (907, 'naza2', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (846, 'VNC3508249', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (847, 'VNC3J10817', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (909, 'off1', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (910, '12211117041', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (848, 'VNC3J10794', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (911, 'off2', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (850, 'CNCHB78508', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 30, 1);
INSERT INTO public.inventory_productdetails VALUES (851, 'X68K001674', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (852, 'X68K001696', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (854, 'VNC3J10437', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (853, 'X68K001603', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (856, 'X68K001628', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (865, 'CNBRPD099W', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 28, 1);
INSERT INTO public.inventory_productdetails VALUES (867, 'VNC4L88806', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (868, 'CNBRPD81VB', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 28, 1);
INSERT INTO public.inventory_productdetails VALUES (869, '18M01391400000106ZWY', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 35, 1);
INSERT INTO public.inventory_productdetails VALUES (858, 'VNC4L84494', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (860, 'VNC4L28486', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (857, 'X68K001632', '2024-06-14', 1, 1, ' ', ' ', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (862, 'VNC3J10869', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (863, '6AG00008997 CZAM53518', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 47, 1);
INSERT INTO public.inventory_productdetails VALUES (864, 'X68K001730', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (870, '6AG00008997 CZLL48856', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 47, 1);
INSERT INTO public.inventory_productdetails VALUES (943, '2106LZ91U6N8', '2024-06-14', 1, 1, ' ', ' ', 'OPENED PRODUCT', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (944, '2104LZ953GE8', '2024-06-14', 1, 1, ' ', ' ', 'OPENED PRODUCT', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (945, '2104LZ96S4J8', '2024-06-14', 1, 1, ' ', ' ', 'OPENED PRODUCT', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (946, '2104LZ953EU8', '2024-06-14', 1, 1, ' ', ' ', 'OPENED PRODUCT', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (956, '1433LZ0ETZJ8', '2024-06-14', 1, 1, ' ', ' ', 'OPENED PRODUCT', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (957, 'AJYHPBRC00419E', '2024-06-14', 1, 1, ' ', ' ', 'OPENED PRODUCT', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (958, '0AJYHPBRC00362E', '2024-06-14', 1, 1, ' ', ' ', 'OPENED PRODUCT', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (959, '0AJYHPBRC00104H', '2024-06-14', 1, 1, ' ', ' ', 'OPENED PRODUCT', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (960, '0AJYHPBRC00353N', '2024-06-14', 1, 1, ' ', ' ', 'OPENED PRODUCT', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (961, '0AJYHPBRC00158F', '2024-06-14', 1, 1, ' ', ' ', 'OPENED PRODUCT', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (970, '805KCKJLG805 ', '2024-06-14', 1, 1, ' ', ' ', 'OPENED PRODUCT', 108, 1);
INSERT INTO public.inventory_productdetails VALUES (971, '1750GG01D308', '2024-06-14', 1, 1, ' ', ' ', 'OPENED PRODUCT', 109, 1);
INSERT INTO public.inventory_productdetails VALUES (625, 'MMLXNSS0027170ABC24212', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 14, 1);
INSERT INTO public.inventory_productdetails VALUES (700, '3CQ4433QQZ', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 20, 1);
INSERT INTO public.inventory_productdetails VALUES (731, 'INA507Q4WZ', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 3, 1);
INSERT INTO public.inventory_productdetails VALUES (873, 'Cjmst1', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (917, 'off6', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (962, '0AJYHPBRC00267X', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (947, '2104LZ96S7Y8', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (968, '0AJYHPBRC00213E', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (973, 'INA609YW91', '2024-06-18', 1, 0, '', '', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (974, '5adjpw1', '2024-06-18', 1, 0, '', '', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (954, '2104LZ953ET8', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (964, '0AJYHPBRC00412D', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (966, '0AJYHPBRC00102Y', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (975, '8CC2470H02', '2024-06-19', 1, 0, '', '', 'OPENED', 45, 1);
INSERT INTO public.inventory_productdetails VALUES (952, '2104LZ963GJ8', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (963, '0AJYHPAT100311L', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (948, '1805LZ0A8WZ8', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (949, '2104LZ96SCC8', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (979, 'coping_DG1', '2024-06-29', 1, 0, '', '', 'OPENED', 107, 1);
INSERT INTO public.inventory_productdetails VALUES (977, '007X3I1009861', '2024-06-25', 1, 0, '', '', 'OPENED', 107, 1);
INSERT INTO public.inventory_productdetails VALUES (950, '007X3I1009846', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 107, 1);
INSERT INTO public.inventory_productdetails VALUES (912, 'off3', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (913, '12211117481', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (965, '0AJYHPBRC00365J', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (951, '2104LZ95RZK8', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (969, '0AJYHPBRC00374M', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (955, '2104LZ96RV68', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (967, '0AJYHPBRC00377T', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 51, 1);
INSERT INTO public.inventory_productdetails VALUES (953, '2104LZ96RYF8', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 53, 1);
INSERT INTO public.inventory_productdetails VALUES (939, 'cop2', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (920, '3adjdw1', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (915, 'off4', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (976, 'X68K001667', '2024-06-24', 1, 0, 'Ink 5', '', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (921, '18051265', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (916, 'off5', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (978, 'S45147PLM3Z6TN', '2024-06-26', 1, 0, '', '', 'OPENED', 33, 1);
INSERT INTO public.inventory_productdetails VALUES (919, 'off8', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (983, 'CNCHB78366', '2024-07-11', 1, 0, '12A', '', 'OPENED', 30, 1);
INSERT INTO public.inventory_productdetails VALUES (918, 'off7', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (928, 'cf2', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (924, 'off9', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (940, '18051483', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (929, 'cf3', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (938, 'cop1', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (914, '18051201', '2024-06-14', 1, 1, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (849, 'S70157GLM1G1DN', '2024-06-14', 1, 1, ' ', ' ', 'OPENED', 34, 1);
INSERT INTO public.inventory_productdetails VALUES (922, 'rec2', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (972, 'TJPG0990051J2592A', '2024-06-18', 1, 0, '', '', 'OPENED', 77, 1);
INSERT INTO public.inventory_productdetails VALUES (855, 'VNC3508236', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (981, 'courtmanager1', '2024-07-08', 1, 0, '', '', 'OPENED', 107, 1);
INSERT INTO public.inventory_productdetails VALUES (936, '12211117597', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (980, 'INA609YVR5', '2024-06-29', 1, 0, '', '', 'OPENED', 1, 1);
INSERT INTO public.inventory_productdetails VALUES (926, 'off10', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (927, 'cf1', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (932, 'sw1', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (984, 'X68K001971', '2024-07-11', 1, 1, '', '', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (933, '12211117483', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (934, '12211117071', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (935, '12211117027', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (985, 'S45147PLM3Z5NB', '2024-07-11', 1, 0, '', '', 'OPENED', 33, 1);
INSERT INTO public.inventory_productdetails VALUES (982, 'CN12F6M14Y', '2024-07-10', 1, 0, 'Color Printer', '', 'OPENED', 90, 1);
INSERT INTO public.inventory_productdetails VALUES (925, '18051308', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (986, 'VNC3508606', '2024-07-11', 1, 0, '88A', '', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (987, '1N12060358', '2024-07-29', 1, 0, '', '', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (988, 'X68K001634', '2024-07-29', 1, 0, '', '', 'OPENED', 37, 1);
INSERT INTO public.inventory_productdetails VALUES (990, '6CM6041MQD', '2024-07-29', 1, 1, '', '', 'OPENED', 19, 1);
INSERT INTO public.inventory_productdetails VALUES (1008, '12211117467', '2024-09-11', 1, 0, '', '', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (908, '12211117070', '2024-06-14', 1, 1, ' ', ' ', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (991, '10211117044', '2024-07-29', 1, 0, '', '', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (989, '1N120601ZC', '2024-07-29', 1, 0, '', '', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (1019, '241907540762', '2024-09-21', 1, 0, '', '', 'OPENED', 61, 1);
INSERT INTO public.inventory_productdetails VALUES (1023, '3CQ20216NR', '2024-11-21', 1, 0, '', '', 'OPENED', 84, 1);
INSERT INTO public.inventory_productdetails VALUES (1026, 'R3UR1E3013549', '2024-11-25', 1, 1, '', 'With Power Adapter', 'OPENED', 111, 1);
INSERT INTO public.inventory_productdetails VALUES (1030, '1N120601VR', '2024-12-05', 1, 0, '', '', 'OPENED', 13, 1);
INSERT INTO public.inventory_productdetails VALUES (941, 'cop3', '2024-06-14', 1, 0, ' ', ' ', 'OPENED', 60, 1);
INSERT INTO public.inventory_productdetails VALUES (1038, 'QS7L312023840', '2024-12-07', 1, 0, '', 'With Power Adapter', 'OPENED', 113, 1);
INSERT INTO public.inventory_productdetails VALUES (1046, 'VNC3J10828', '2024-12-11', 1, 1, '88A', '', 'OPENED', 27, 1);
INSERT INTO public.inventory_productdetails VALUES (1053, 'X68K001553', '2024-12-12', 1, 1, 'black ink 005', '', 'OPENED', 37, 1);


--
-- Data for Name: inventory_productmodelmaster; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.inventory_productmodelmaster VALUES (1, 'HP 406G1 MT Bussiness PC', 1);
INSERT INTO public.inventory_productmodelmaster VALUES (2, 'HP 507G1 MT Bussiness PC', 1);
INSERT INTO public.inventory_productmodelmaster VALUES (3, 'HP Elight-Desk 800 G1 PC', 1);
INSERT INTO public.inventory_productmodelmaster VALUES (4, 'HP 480Bussinesh PC', 1);
INSERT INTO public.inventory_productmodelmaster VALUES (6, 'Acer Veriton 4660 PC', 2);
INSERT INTO public.inventory_productmodelmaster VALUES (7, 'Acer Veriton 6545 PC', 2);
INSERT INTO public.inventory_productmodelmaster VALUES (8, 'Acer M2640G PC', 2);
INSERT INTO public.inventory_productmodelmaster VALUES (9, 'HCL PC', 3);
INSERT INTO public.inventory_productmodelmaster VALUES (10, 'Wipro 37515 PC', 4);
INSERT INTO public.inventory_productmodelmaster VALUES (11, 'Dell PC', 5);
INSERT INTO public.inventory_productmodelmaster VALUES (12, 'HP Prodesk 400 G7 Small Form Factor PC i5', 1);
INSERT INTO public.inventory_productmodelmaster VALUES (13, 'HP Prodesk 400 G7 Small Form Factor PC i3', 1);
INSERT INTO public.inventory_productmodelmaster VALUES (14, 'ACER V196 HQL', 6);
INSERT INTO public.inventory_productmodelmaster VALUES (15, 'ACER EV196 HQL', 6);
INSERT INTO public.inventory_productmodelmaster VALUES (16, 'ACER V226 HQL', 6);
INSERT INTO public.inventory_productmodelmaster VALUES (18, 'AOC LM725', 8);
INSERT INTO public.inventory_productmodelmaster VALUES (19, 'HP V192', 9);
INSERT INTO public.inventory_productmodelmaster VALUES (20, 'HP V193', 9);
INSERT INTO public.inventory_productmodelmaster VALUES (21, 'HP V194', 9);
INSERT INTO public.inventory_productmodelmaster VALUES (22, 'HP COMPAQ LE1902X', 9);
INSERT INTO public.inventory_productmodelmaster VALUES (23, 'DELL', 10);
INSERT INTO public.inventory_productmodelmaster VALUES (24, 'LENOVO 6122', 11);
INSERT INTO public.inventory_productmodelmaster VALUES (25, 'HCL', 12);
INSERT INTO public.inventory_productmodelmaster VALUES (26, 'LG', 13);
INSERT INTO public.inventory_productmodelmaster VALUES (29, 'HP LJ 1020 ', 33);
INSERT INTO public.inventory_productmodelmaster VALUES (30, 'HP LJ 1020-PLUS', 33);
INSERT INTO public.inventory_productmodelmaster VALUES (31, 'HP MFP M126nw', 33);
INSERT INTO public.inventory_productmodelmaster VALUES (32, 'HP P1505', 33);
INSERT INTO public.inventory_productmodelmaster VALUES (33, 'LEXMARK MX312dn', 34);
INSERT INTO public.inventory_productmodelmaster VALUES (34, 'LEXMARK MX310dn', 34);
INSERT INTO public.inventory_productmodelmaster VALUES (35, 'LEXMARK B2236dw', 34);
INSERT INTO public.inventory_productmodelmaster VALUES (36, 'LEXMARK B2236adw', 34);
INSERT INTO public.inventory_productmodelmaster VALUES (37, 'EPSON M1170', 35);
INSERT INTO public.inventory_productmodelmaster VALUES (38, 'SAMSANG 2245', 36);
INSERT INTO public.inventory_productmodelmaster VALUES (39, 'EPSON WORK FORCE DS770II', 37);
INSERT INTO public.inventory_productmodelmaster VALUES (40, 'EPSON ELPDC21', 37);
INSERT INTO public.inventory_productmodelmaster VALUES (41, 'CANON LIDE120', 39);
INSERT INTO public.inventory_productmodelmaster VALUES (42, 'HP SCANJET-PRO 2000S2', 38);
INSERT INTO public.inventory_productmodelmaster VALUES (43, 'AVISION AV610C2', 40);
INSERT INTO public.inventory_productmodelmaster VALUES (44, 'HP ProOne 400G1 AiO Bussiness PC', 41);
INSERT INTO public.inventory_productmodelmaster VALUES (45, 'HP 24-cb1237 AiO', 41);
INSERT INTO public.inventory_productmodelmaster VALUES (47, 'TOSHIBA eSTUDIO 3518A', 45);
INSERT INTO public.inventory_productmodelmaster VALUES (48, 'POWER EDGE R540', 47);
INSERT INTO public.inventory_productmodelmaster VALUES (49, 'HP VC4725 LNX', 50);
INSERT INTO public.inventory_productmodelmaster VALUES (50, 'ACER VERITON E220M26XXX', 51);
INSERT INTO public.inventory_productmodelmaster VALUES (52, 'GLOBUS', 60);
INSERT INTO public.inventory_productmodelmaster VALUES (54, 'LOGITECH C922 PRO HD', 44);
INSERT INTO public.inventory_productmodelmaster VALUES (55, 'LOGITECH Z120 COMPACT STERO ', 54);
INSERT INTO public.inventory_productmodelmaster VALUES (56, 'JABRA', 55);
INSERT INTO public.inventory_productmodelmaster VALUES (57, 'HIK VISION', 58);
INSERT INTO public.inventory_productmodelmaster VALUES (58, 'KIRLOSKAR', 56);
INSERT INTO public.inventory_productmodelmaster VALUES (59, 'MAHINDRA', 57);
INSERT INTO public.inventory_productmodelmaster VALUES (60, 'RS POWER', 14);
INSERT INTO public.inventory_productmodelmaster VALUES (61, 'NUMERIC DIGITAL 600EX', 15);
INSERT INTO public.inventory_productmodelmaster VALUES (62, 'NUMERIC DIGITAL 1000HR-V', 15);
INSERT INTO public.inventory_productmodelmaster VALUES (63, 'UNILINE', 16);
INSERT INTO public.inventory_productmodelmaster VALUES (64, 'Intex', 17);
INSERT INTO public.inventory_productmodelmaster VALUES (65, 'Keptron', 18);
INSERT INTO public.inventory_productmodelmaster VALUES (66, 'Battery E02-EP26-12N', 19);
INSERT INTO public.inventory_productmodelmaster VALUES (53, 'LOGITECH BCC950', 44);
INSERT INTO public.inventory_productmodelmaster VALUES (77, 'WIPRO WLG171t', 7);
INSERT INTO public.inventory_productmodelmaster VALUES (79, 'VS-400', 64);
INSERT INTO public.inventory_productmodelmaster VALUES (5, 'HP 280 G4 MT ', 1);
INSERT INTO public.inventory_productmodelmaster VALUES (81, 'HP ProDesk 600 G2 SFF', 1);
INSERT INTO public.inventory_productmodelmaster VALUES (82, 'Veriton M4660G', 2);
INSERT INTO public.inventory_productmodelmaster VALUES (27, 'HP Laser Jet Pro M202dw', 33);
INSERT INTO public.inventory_productmodelmaster VALUES (28, 'HP Laser Jet Pro  MFP M226dw', 33);
INSERT INTO public.inventory_productmodelmaster VALUES (80, 'LC', 65);
INSERT INTO public.inventory_productmodelmaster VALUES (83, 'LC', 66);
INSERT INTO public.inventory_productmodelmaster VALUES (85, 'OTHER', 67);
INSERT INTO public.inventory_productmodelmaster VALUES (51, 'Samsung Bussiness TV 43''''', 59);
INSERT INTO public.inventory_productmodelmaster VALUES (67, 'HP', 20);
INSERT INTO public.inventory_productmodelmaster VALUES (68, 'LENOVO', 21);
INSERT INTO public.inventory_productmodelmaster VALUES (69, 'DELL', 22);
INSERT INTO public.inventory_productmodelmaster VALUES (70, 'FRONTECH', 23);
INSERT INTO public.inventory_productmodelmaster VALUES (71, 'LOGITECH', 24);
INSERT INTO public.inventory_productmodelmaster VALUES (78, 'iBall', 63);
INSERT INTO public.inventory_productmodelmaster VALUES (72, 'HP', 25);
INSERT INTO public.inventory_productmodelmaster VALUES (73, 'LENOVO', 26);
INSERT INTO public.inventory_productmodelmaster VALUES (74, 'DELL', 27);
INSERT INTO public.inventory_productmodelmaster VALUES (75, 'FRONTECH', 28);
INSERT INTO public.inventory_productmodelmaster VALUES (76, 'LOGITECH', 29);
INSERT INTO public.inventory_productmodelmaster VALUES (86, 'ACER', 68);
INSERT INTO public.inventory_productmodelmaster VALUES (87, 'ACER', 69);
INSERT INTO public.inventory_productmodelmaster VALUES (88, 'iBall', 70);
INSERT INTO public.inventory_productmodelmaster VALUES (89, 'dlink8ps', 31);
INSERT INTO public.inventory_productmodelmaster VALUES (90, 'HP INK TANK 316', 33);
INSERT INTO public.inventory_productmodelmaster VALUES (91, '4.0 Port', 72);
INSERT INTO public.inventory_productmodelmaster VALUES (92, 'DLink', 74);
INSERT INTO public.inventory_productmodelmaster VALUES (93, 'DS-530', 37);
INSERT INTO public.inventory_productmodelmaster VALUES (94, 'ProDot', 75);
INSERT INTO public.inventory_productmodelmaster VALUES (95, 'LLOYD TV', 76);
INSERT INTO public.inventory_productmodelmaster VALUES (96, 'DUMMY', 77);
INSERT INTO public.inventory_productmodelmaster VALUES (97, 'H74H2 (All In One Desktop)', 42);
INSERT INTO public.inventory_productmodelmaster VALUES (98, 'Optiplex 7010 SFF', 5);
INSERT INTO public.inventory_productmodelmaster VALUES (99, 'E2020H', 10);
INSERT INTO public.inventory_productmodelmaster VALUES (100, 'Laser Printer 4004dw', 33);
INSERT INTO public.inventory_productmodelmaster VALUES (101, 'BE43C-H', 59);
INSERT INTO public.inventory_productmodelmaster VALUES (102, 'WorkForce DS-790WN', 38);
INSERT INTO public.inventory_productmodelmaster VALUES (103, 'ACER-206 ', 6);
INSERT INTO public.inventory_productmodelmaster VALUES (104, 'E1914HC', 10);
INSERT INTO public.inventory_productmodelmaster VALUES (105, 'x335', 78);
INSERT INTO public.inventory_productmodelmaster VALUES (46, 'V310Z', 43);
INSERT INTO public.inventory_productmodelmaster VALUES (106, 'HDX 7000', 79);
INSERT INTO public.inventory_productmodelmaster VALUES (108, '49LX761H', 81);
INSERT INTO public.inventory_productmodelmaster VALUES (109, 'P710e', 54);
INSERT INTO public.inventory_productmodelmaster VALUES (107, 'DGFS1008DG/IS', 32);
INSERT INTO public.inventory_productmodelmaster VALUES (111, 'DES1008A', 32);
INSERT INTO public.inventory_productmodelmaster VALUES (110, 'Think vision E1922 ', 11);
INSERT INTO public.inventory_productmodelmaster VALUES (84, 'HP P204V', 9);
INSERT INTO public.inventory_productmodelmaster VALUES (112, 'wipro', 82);
INSERT INTO public.inventory_productmodelmaster VALUES (113, 'DES-1008C', 31);


--
-- Data for Name: inventory_productpuchasedetails; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.inventory_productpuchasedetails VALUES (1, 'DUMMY', 'DUMMY', 1, '0', 96);
INSERT INTO public.inventory_productpuchasedetails VALUES (2, '', '/media/productBoxDetails/IMG20240227141545_qF2nr6f.jpg', 2, '116', 97);
INSERT INTO public.inventory_productpuchasedetails VALUES (3, 'With Keyboard and Mouse', '/media/productBoxDetails/dellCPU.jpg', 3, '20', 98);
INSERT INTO public.inventory_productpuchasedetails VALUES (4, '', '/media/productBoxDetails/monitor.jpg', 3, '20', 99);
INSERT INTO public.inventory_productpuchasedetails VALUES (5, '', '/media/productBoxDetails/printer.jpg', 3, '20', 100);
INSERT INTO public.inventory_productpuchasedetails VALUES (6, 'With Remote', '/media/productBoxDetails/tv.jpg', 3, '8', 101);
INSERT INTO public.inventory_productpuchasedetails VALUES (7, 'With Remote and Adapter', '/media/productBoxDetails/camera.jpg', 3, '8', 53);
INSERT INTO public.inventory_productpuchasedetails VALUES (8, '', '/media/productBoxDetails/scanner.jpg', 3, '4', 102);


--
-- Data for Name: inventory_producttransactiondetails; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.inventory_producttransactiondetails VALUES (41, 0, 1, 'With Power and VGA cable', '1900-01-01', 0, '', 'No', 197, 1);
INSERT INTO public.inventory_producttransactiondetails VALUES (42, 0, 1, 'With Power and VGA cable', '1900-01-01', 0, '', 'No', 248, 1);
INSERT INTO public.inventory_producttransactiondetails VALUES (43, 0, 1, 'With Power and VGA cable', '1900-01-01', 0, '', 'No', 275, 1);
INSERT INTO public.inventory_producttransactiondetails VALUES (44, 0, 1, 'With Power cable', '1900-01-01', 0, '', 'No', 294, 1);
INSERT INTO public.inventory_producttransactiondetails VALUES (45, 0, 1, 'With Power and printer cable', '1900-01-01', 0, '', 'No', 345, 1);
INSERT INTO public.inventory_producttransactiondetails VALUES (46, 0, 1, '', '1900-01-01', 0, '', 'No', 472, 1);
INSERT INTO public.inventory_producttransactiondetails VALUES (47, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 1);
INSERT INTO public.inventory_producttransactiondetails VALUES (48, 0, 2, '', '1900-01-01', 0, '', 'No', 481, 1);
INSERT INTO public.inventory_producttransactiondetails VALUES (49, 0, 1, '', '1900-01-01', 0, '', 'No', 483, 1);
INSERT INTO public.inventory_producttransactiondetails VALUES (50, 0, 1, 'With Power and VGA cable', '1900-01-01', 0, '', 'No', 198, 2);
INSERT INTO public.inventory_producttransactiondetails VALUES (51, 0, 1, 'With Power cable', '1900-01-01', 0, '', 'No', 295, 2);
INSERT INTO public.inventory_producttransactiondetails VALUES (52, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 2);
INSERT INTO public.inventory_producttransactiondetails VALUES (53, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 2);
INSERT INTO public.inventory_producttransactiondetails VALUES (54, 0, 1, 'With Power and VGA cable', '1900-01-01', 0, '', 'No', 199, 3);
INSERT INTO public.inventory_producttransactiondetails VALUES (55, 0, 1, 'With Power and VGA cable', '1900-01-01', 0, '', 'No', 249, 3);
INSERT INTO public.inventory_producttransactiondetails VALUES (56, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 296, 3);
INSERT INTO public.inventory_producttransactiondetails VALUES (57, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 346, 3);
INSERT INTO public.inventory_producttransactiondetails VALUES (58, 0, 1, 'With Adapter', '1900-01-01', 0, '', 'No', 483, 3);
INSERT INTO public.inventory_producttransactiondetails VALUES (59, 0, 1, 'With Power Adapter,HDMI cable 10m  and Remote', '1900-01-01', 0, '', 'No', 444, 3);
INSERT INTO public.inventory_producttransactiondetails VALUES (60, 0, 1, 'With Power Adapter and Remote', '1900-01-01', 0, '', 'No', 458, 3);
INSERT INTO public.inventory_producttransactiondetails VALUES (61, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 3);
INSERT INTO public.inventory_producttransactiondetails VALUES (62, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 3);
INSERT INTO public.inventory_producttransactiondetails VALUES (63, 0, 1, '', '1900-01-01', 0, '', 'No', 481, 3);
INSERT INTO public.inventory_producttransactiondetails VALUES (64, 0, 1, 'With Power and VGA Cable ', '1900-01-01', 0, '', 'No', 202, 4);
INSERT INTO public.inventory_producttransactiondetails VALUES (65, 0, 1, 'With Power and VGA Cable ', '1900-01-01', 0, '', 'No', 250, 4);
INSERT INTO public.inventory_producttransactiondetails VALUES (66, 0, 1, 'With Power and VGA Cable ', '1900-01-01', 0, '', 'No', 203, 4);
INSERT INTO public.inventory_producttransactiondetails VALUES (67, 0, 1, 'With Power and VGA Cable ', '1900-01-01', 0, '', 'No', 251, 4);
INSERT INTO public.inventory_producttransactiondetails VALUES (68, 0, 1, 'With Power and VGA Cable ', '1900-01-01', 0, '', 'No', 277, 4);
INSERT INTO public.inventory_producttransactiondetails VALUES (69, 0, 1, 'With Power Cable ', '1900-01-01', 0, '', 'No', 299, 4);
INSERT INTO public.inventory_producttransactiondetails VALUES (71, 0, 1, 'With Power and USB Cable ', '1900-01-01', 0, '', 'No', 349, 4);
INSERT INTO public.inventory_producttransactiondetails VALUES (72, 0, 1, '', '1900-01-01', 0, '', 'No', 393, 4);
INSERT INTO public.inventory_producttransactiondetails VALUES (73, 0, 1, '', '1900-01-01', 0, '', 'No', 394, 4);
INSERT INTO public.inventory_producttransactiondetails VALUES (74, 0, 2, '', '1900-01-01', 0, '', 'No', 473, 4);
INSERT INTO public.inventory_producttransactiondetails VALUES (75, 0, 1, '', '1900-01-01', 0, '', 'No', 481, 4);
INSERT INTO public.inventory_producttransactiondetails VALUES (77, 0, 1, 'With Power Cable,HDMI 10m Cable and Remote', '1900-01-01', 0, '', 'No', 445, 4);
INSERT INTO public.inventory_producttransactiondetails VALUES (78, 0, 1, 'With Power Cable and Remote', '1900-01-01', 0, '', 'No', 459, 4);
INSERT INTO public.inventory_producttransactiondetails VALUES (79, 0, 1, 'With Power cable and VGA Cable', '1900-01-01', 0, '', 'No', 201, 5);
INSERT INTO public.inventory_producttransactiondetails VALUES (80, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 298, 5);
INSERT INTO public.inventory_producttransactiondetails VALUES (82, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 5);
INSERT INTO public.inventory_producttransactiondetails VALUES (83, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 5);
INSERT INTO public.inventory_producttransactiondetails VALUES (84, 0, 2, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 6);
INSERT INTO public.inventory_producttransactiondetails VALUES (85, 0, 1, 'With Power And VGA Cable', '1900-01-01', 0, '', 'No', 204, 7);
INSERT INTO public.inventory_producttransactiondetails VALUES (86, 0, 1, 'With Power And VGA Cable', '1900-01-01', 0, '', 'No', 252, 7);
INSERT INTO public.inventory_producttransactiondetails VALUES (87, 0, 1, 'With Power And VGA Cable', '1900-01-01', 0, '', 'No', 278, 7);
INSERT INTO public.inventory_producttransactiondetails VALUES (88, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 301, 7);
INSERT INTO public.inventory_producttransactiondetails VALUES (90, 0, 1, '', '1900-01-01', 0, '', 'No', 395, 7);
INSERT INTO public.inventory_producttransactiondetails VALUES (91, 0, 1, '', '1900-01-01', 0, '', 'No', 437, 7);
INSERT INTO public.inventory_producttransactiondetails VALUES (92, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 7);
INSERT INTO public.inventory_producttransactiondetails VALUES (93, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 7);
INSERT INTO public.inventory_producttransactiondetails VALUES (94, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 7);
INSERT INTO public.inventory_producttransactiondetails VALUES (95, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 205, 8);
INSERT INTO public.inventory_producttransactiondetails VALUES (96, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 253, 8);
INSERT INTO public.inventory_producttransactiondetails VALUES (97, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 302, 8);
INSERT INTO public.inventory_producttransactiondetails VALUES (98, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 173, 8);
INSERT INTO public.inventory_producttransactiondetails VALUES (99, 0, 1, '', '1900-01-01', 0, '', 'No', 396, 8);
INSERT INTO public.inventory_producttransactiondetails VALUES (100, 0, 1, '', '1900-01-01', 0, '', 'No', 438, 8);
INSERT INTO public.inventory_producttransactiondetails VALUES (101, 0, 2, '', '1900-01-01', 0, '', 'No', 474, 8);
INSERT INTO public.inventory_producttransactiondetails VALUES (102, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 8);
INSERT INTO public.inventory_producttransactiondetails VALUES (103, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 8);
INSERT INTO public.inventory_producttransactiondetails VALUES (104, 0, 1, 'With Power Adapter,HDMI 10m cable and Remote', '1900-01-01', 0, '', 'No', 446, 8);
INSERT INTO public.inventory_producttransactiondetails VALUES (105, 0, 1, 'With Power Adapter and Remote', '1900-01-01', 0, '', 'No', 460, 8);
INSERT INTO public.inventory_producttransactiondetails VALUES (106, 0, 1, 'With Keyboard and Mouse and Power Cable', '1900-01-01', 0, '', 'No', 75, 9);
INSERT INTO public.inventory_producttransactiondetails VALUES (107, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 352, 9);
INSERT INTO public.inventory_producttransactiondetails VALUES (108, 0, 1, '', '1900-01-01', 0, '', 'No', 397, 9);
INSERT INTO public.inventory_producttransactiondetails VALUES (109, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 207, 10);
INSERT INTO public.inventory_producttransactiondetails VALUES (110, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 303, 10);
INSERT INTO public.inventory_producttransactiondetails VALUES (112, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 10);
INSERT INTO public.inventory_producttransactiondetails VALUES (113, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 10);
INSERT INTO public.inventory_producttransactiondetails VALUES (114, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 211, 11);
INSERT INTO public.inventory_producttransactiondetails VALUES (115, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 307, 11);
INSERT INTO public.inventory_producttransactiondetails VALUES (117, 0, 1, '', '1900-01-01', 0, '', 'No', 401, 11);
INSERT INTO public.inventory_producttransactiondetails VALUES (118, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 443, 11);
INSERT INTO public.inventory_producttransactiondetails VALUES (119, 0, 1, '', '1900-01-01', 0, '', 'No', 477, 11);
INSERT INTO public.inventory_producttransactiondetails VALUES (120, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 11);
INSERT INTO public.inventory_producttransactiondetails VALUES (122, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 308, 12);
INSERT INTO public.inventory_producttransactiondetails VALUES (124, 0, 1, '', '1900-01-01', 0, '', 'No', 402, 12);
INSERT INTO public.inventory_producttransactiondetails VALUES (125, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 12);
INSERT INTO public.inventory_producttransactiondetails VALUES (126, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 12);
INSERT INTO public.inventory_producttransactiondetails VALUES (127, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 208, 13);
INSERT INTO public.inventory_producttransactiondetails VALUES (128, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 254, 13);
INSERT INTO public.inventory_producttransactiondetails VALUES (129, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 279, 13);
INSERT INTO public.inventory_producttransactiondetails VALUES (130, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 304, 13);
INSERT INTO public.inventory_producttransactiondetails VALUES (131, 0, 1, 'With Power and USB  Cable', '1900-01-01', 0, '', 'No', 354, 13);
INSERT INTO public.inventory_producttransactiondetails VALUES (132, 0, 1, '', '1900-01-01', 0, '', 'No', 398, 13);
INSERT INTO public.inventory_producttransactiondetails VALUES (133, 0, 1, '', '1900-01-01', 0, '', 'No', 484, 13);
INSERT INTO public.inventory_producttransactiondetails VALUES (134, 0, 1, '', '1900-01-01', 0, '', 'No', 483, 13);
INSERT INTO public.inventory_producttransactiondetails VALUES (135, 0, 1, '', '1900-01-01', 0, '', 'No', 476, 13);
INSERT INTO public.inventory_producttransactiondetails VALUES (136, 0, 1, '', '1900-01-01', 0, '', 'No', 485, 13);
INSERT INTO public.inventory_producttransactiondetails VALUES (137, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 209, 14);
INSERT INTO public.inventory_producttransactiondetails VALUES (138, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 255, 14);
INSERT INTO public.inventory_producttransactiondetails VALUES (438, 0, 1, '', '1900-01-01', 0, '', 'No', 481, 54);
INSERT INTO public.inventory_producttransactiondetails VALUES (639, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 78);
INSERT INTO public.inventory_producttransactiondetails VALUES (76, 1, 1, '', '2024-07-11', 1, 'Not Working', 'No', 478, 4);
INSERT INTO public.inventory_producttransactiondetails VALUES (116, 1, 1, 'With Power and USB Cable', '2024-07-11', 1, 'With Power and USB Cable', 'No', 357, 11);
INSERT INTO public.inventory_producttransactiondetails VALUES (81, 1, 1, 'With Power and USB  Cable', '2024-07-11', 1, 'With Power and USB Cable', 'No', 348, 5);
INSERT INTO public.inventory_producttransactiondetails VALUES (89, 1, 1, 'With Power and USB  Cable', '2024-06-25', 1, 'Gear Problem', 'No', 351, 7);
INSERT INTO public.inventory_producttransactiondetails VALUES (121, 1, 1, 'With Power and VGA Cable', '2024-08-13', 1, 'Power Issue', 'No', 212, 12);
INSERT INTO public.inventory_producttransactiondetails VALUES (70, 1, 1, 'With Power Cable ', '2024-09-26', 1, 'Motherboard Problem', 'No', 300, 4);
INSERT INTO public.inventory_producttransactiondetails VALUES (139, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 280, 14);
INSERT INTO public.inventory_producttransactiondetails VALUES (140, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 305, 14);
INSERT INTO public.inventory_producttransactiondetails VALUES (141, 0, 1, 'With Power and Printer Cable', '1900-01-01', 0, '', 'No', 355, 14);
INSERT INTO public.inventory_producttransactiondetails VALUES (142, 0, 1, '', '1900-01-01', 0, '', 'No', 399, 14);
INSERT INTO public.inventory_producttransactiondetails VALUES (143, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 14);
INSERT INTO public.inventory_producttransactiondetails VALUES (144, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 14);
INSERT INTO public.inventory_producttransactiondetails VALUES (145, 0, 1, '', '1900-01-01', 0, '', 'No', 482, 14);
INSERT INTO public.inventory_producttransactiondetails VALUES (146, 0, 1, 'With Power,HDMI 10m,Remote', '1900-01-01', 0, '', 'No', 447, 14);
INSERT INTO public.inventory_producttransactiondetails VALUES (147, 0, 1, 'With Power cable ,Remote', '1900-01-01', 0, '', 'No', 461, 14);
INSERT INTO public.inventory_producttransactiondetails VALUES (148, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 210, 15);
INSERT INTO public.inventory_producttransactiondetails VALUES (149, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 306, 15);
INSERT INTO public.inventory_producttransactiondetails VALUES (150, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 356, 15);
INSERT INTO public.inventory_producttransactiondetails VALUES (151, 0, 1, '', '1900-01-01', 0, '', 'No', 400, 15);
INSERT INTO public.inventory_producttransactiondetails VALUES (154, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 213, 16);
INSERT INTO public.inventory_producttransactiondetails VALUES (155, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 256, 16);
INSERT INTO public.inventory_producttransactiondetails VALUES (156, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 281, 16);
INSERT INTO public.inventory_producttransactiondetails VALUES (157, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 309, 16);
INSERT INTO public.inventory_producttransactiondetails VALUES (158, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 359, 16);
INSERT INTO public.inventory_producttransactiondetails VALUES (159, 0, 1, '', '1900-01-01', 0, '', 'No', 403, 16);
INSERT INTO public.inventory_producttransactiondetails VALUES (160, 0, 1, 'With Power and HDMI 10m Cable and Remote', '1900-01-01', 0, '', 'No', 448, 16);
INSERT INTO public.inventory_producttransactiondetails VALUES (161, 0, 1, 'With Power Cable and Remote', '1900-01-01', 0, '', 'No', 462, 16);
INSERT INTO public.inventory_producttransactiondetails VALUES (162, 0, 1, '', '1900-01-01', 0, '', 'No', 483, 16);
INSERT INTO public.inventory_producttransactiondetails VALUES (163, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 16);
INSERT INTO public.inventory_producttransactiondetails VALUES (164, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 16);
INSERT INTO public.inventory_producttransactiondetails VALUES (165, 0, 1, 'With Power and VGA cable', '1900-01-01', 0, '', 'No', 214, 17);
INSERT INTO public.inventory_producttransactiondetails VALUES (166, 0, 1, 'With Power and VGA cable', '1900-01-01', 0, '', 'No', 257, 17);
INSERT INTO public.inventory_producttransactiondetails VALUES (167, 0, 1, 'With Power and VGA cable', '1900-01-01', 0, '', 'No', 282, 17);
INSERT INTO public.inventory_producttransactiondetails VALUES (168, 0, 1, 'With Power cable', '1900-01-01', 0, '', 'No', 310, 17);
INSERT INTO public.inventory_producttransactiondetails VALUES (169, 0, 1, 'With Power and USB cable', '1900-01-01', 0, '', 'No', 360, 17);
INSERT INTO public.inventory_producttransactiondetails VALUES (170, 0, 1, '', '1900-01-01', 0, '', 'No', 404, 17);
INSERT INTO public.inventory_producttransactiondetails VALUES (171, 0, 1, '', '1900-01-01', 0, '', 'No', 483, 17);
INSERT INTO public.inventory_producttransactiondetails VALUES (172, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 17);
INSERT INTO public.inventory_producttransactiondetails VALUES (173, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 17);
INSERT INTO public.inventory_producttransactiondetails VALUES (174, 0, 1, 'With Power and VGA cable', '1900-01-01', 0, '', 'No', 215, 18);
INSERT INTO public.inventory_producttransactiondetails VALUES (175, 0, 1, 'With Power cable', '1900-01-01', 0, '', 'No', 311, 18);
INSERT INTO public.inventory_producttransactiondetails VALUES (176, 0, 1, '', '1900-01-01', 0, '', 'No', 405, 18);
INSERT INTO public.inventory_producttransactiondetails VALUES (177, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 18);
INSERT INTO public.inventory_producttransactiondetails VALUES (178, 0, 1, '', '1900-01-01', 0, '', 'No', 480, 18);
INSERT INTO public.inventory_producttransactiondetails VALUES (179, 0, 1, 'With Keyboard and Mouse', '1900-01-01', 0, '', 'No', 486, 19);
INSERT INTO public.inventory_producttransactiondetails VALUES (181, 0, 1, '', '1900-01-01', 0, '', 'No', 406, 19);
INSERT INTO public.inventory_producttransactiondetails VALUES (182, 0, 1, 'With power and VGA Cable', '1900-01-01', 0, '', 'No', 216, 20);
INSERT INTO public.inventory_producttransactiondetails VALUES (183, 0, 1, 'With power Cable', '1900-01-01', 0, '', 'No', 312, 20);
INSERT INTO public.inventory_producttransactiondetails VALUES (184, 0, 1, 'With power and USB Cable', '1900-01-01', 0, '', 'No', 362, 20);
INSERT INTO public.inventory_producttransactiondetails VALUES (185, 0, 1, '', '1900-01-01', 0, '', 'No', 407, 20);
INSERT INTO public.inventory_producttransactiondetails VALUES (186, 0, 1, '', '1900-01-01', 0, '', 'No', 487, 20);
INSERT INTO public.inventory_producttransactiondetails VALUES (187, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 20);
INSERT INTO public.inventory_producttransactiondetails VALUES (188, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 217, 21);
INSERT INTO public.inventory_producttransactiondetails VALUES (189, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 258, 21);
INSERT INTO public.inventory_producttransactiondetails VALUES (190, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 313, 21);
INSERT INTO public.inventory_producttransactiondetails VALUES (192, 0, 1, '', '1900-01-01', 0, '', 'No', 408, 21);
INSERT INTO public.inventory_producttransactiondetails VALUES (193, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 21);
INSERT INTO public.inventory_producttransactiondetails VALUES (194, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 21);
INSERT INTO public.inventory_producttransactiondetails VALUES (195, 0, 1, '', '1900-01-01', 0, '', 'No', 481, 21);
INSERT INTO public.inventory_producttransactiondetails VALUES (196, 0, 1, 'With Power,HDMI 10m cable and Remote ', '1900-01-01', 0, '', 'No', 449, 21);
INSERT INTO public.inventory_producttransactiondetails VALUES (197, 0, 1, 'With Power cable and Remote ', '1900-01-01', 0, '', 'No', 463, 21);
INSERT INTO public.inventory_producttransactiondetails VALUES (198, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 218, 22);
INSERT INTO public.inventory_producttransactiondetails VALUES (199, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 259, 22);
INSERT INTO public.inventory_producttransactiondetails VALUES (200, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 314, 22);
INSERT INTO public.inventory_producttransactiondetails VALUES (201, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 364, 22);
INSERT INTO public.inventory_producttransactiondetails VALUES (202, 0, 1, '', '1900-01-01', 0, '', 'No', 409, 22);
INSERT INTO public.inventory_producttransactiondetails VALUES (203, 0, 1, '', '1900-01-01', 0, '', 'No', 483, 22);
INSERT INTO public.inventory_producttransactiondetails VALUES (204, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 22);
INSERT INTO public.inventory_producttransactiondetails VALUES (205, 0, 1, '', '1900-01-01', 0, '', 'No', 482, 22);
INSERT INTO public.inventory_producttransactiondetails VALUES (206, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 219, 23);
INSERT INTO public.inventory_producttransactiondetails VALUES (207, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 315, 23);
INSERT INTO public.inventory_producttransactiondetails VALUES (208, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 23);
INSERT INTO public.inventory_producttransactiondetails VALUES (209, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 23);
INSERT INTO public.inventory_producttransactiondetails VALUES (210, 0, 1, 'with power and VGA cable', '1900-01-01', 0, '', 'No', 220, 24);
INSERT INTO public.inventory_producttransactiondetails VALUES (211, 0, 1, 'with power and VGA cable', '1900-01-01', 0, '', 'No', 260, 24);
INSERT INTO public.inventory_producttransactiondetails VALUES (212, 0, 1, 'with power and VGA cable', '1900-01-01', 0, '', 'No', 283, 24);
INSERT INTO public.inventory_producttransactiondetails VALUES (213, 0, 1, 'with power  cable', '1900-01-01', 0, '', 'No', 316, 24);
INSERT INTO public.inventory_producttransactiondetails VALUES (214, 0, 1, 'with power and usb  cable', '1900-01-01', 0, '', 'No', 365, 24);
INSERT INTO public.inventory_producttransactiondetails VALUES (215, 0, 1, '', '1900-01-01', 0, '', 'No', 410, 24);
INSERT INTO public.inventory_producttransactiondetails VALUES (216, 0, 1, '', '1900-01-01', 0, '', 'No', 483, 24);
INSERT INTO public.inventory_producttransactiondetails VALUES (217, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 24);
INSERT INTO public.inventory_producttransactiondetails VALUES (218, 0, 1, '', '1900-01-01', 0, '', 'No', 481, 24);
INSERT INTO public.inventory_producttransactiondetails VALUES (219, 0, 1, '', '1900-01-01', 0, '', 'No', 482, 24);
INSERT INTO public.inventory_producttransactiondetails VALUES (220, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 221, 25);
INSERT INTO public.inventory_producttransactiondetails VALUES (221, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 261, 25);
INSERT INTO public.inventory_producttransactiondetails VALUES (222, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 317, 25);
INSERT INTO public.inventory_producttransactiondetails VALUES (223, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 366, 25);
INSERT INTO public.inventory_producttransactiondetails VALUES (224, 0, 1, '', '1900-01-01', 0, '', 'No', 411, 25);
INSERT INTO public.inventory_producttransactiondetails VALUES (225, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 25);
INSERT INTO public.inventory_producttransactiondetails VALUES (226, 0, 1, '', '1900-01-01', 0, '', 'No', 481, 25);
INSERT INTO public.inventory_producttransactiondetails VALUES (227, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 25);
INSERT INTO public.inventory_producttransactiondetails VALUES (229, 0, 1, 'With Power and HDMI10M cable and Remote', '1900-01-01', 0, '', 'No', 450, 26);
INSERT INTO public.inventory_producttransactiondetails VALUES (230, 0, 1, 'With Power  cable and Remote', '1900-01-01', 0, '', 'No', 464, 26);
INSERT INTO public.inventory_producttransactiondetails VALUES (231, 0, 1, 'with Power and VGA Cable', '1900-01-01', 0, '', 'No', 222, 27);
INSERT INTO public.inventory_producttransactiondetails VALUES (232, 0, 1, 'with Power Cable', '1900-01-01', 0, '', 'No', 318, 27);
INSERT INTO public.inventory_producttransactiondetails VALUES (233, 0, 1, 'with Power and USB Cable', '1900-01-01', 0, '', 'No', 367, 27);
INSERT INTO public.inventory_producttransactiondetails VALUES (234, 0, 1, '', '1900-01-01', 0, '', 'No', 412, 27);
INSERT INTO public.inventory_producttransactiondetails VALUES (235, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 27);
INSERT INTO public.inventory_producttransactiondetails VALUES (236, 0, 1, '', '1900-01-01', 0, '', 'No', 481, 27);
INSERT INTO public.inventory_producttransactiondetails VALUES (237, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 226, 28);
INSERT INTO public.inventory_producttransactiondetails VALUES (238, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 263, 28);
INSERT INTO public.inventory_producttransactiondetails VALUES (239, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 285, 28);
INSERT INTO public.inventory_producttransactiondetails VALUES (228, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 25);
INSERT INTO public.inventory_producttransactiondetails VALUES (152, 1, 1, '', '2024-08-05', 1, 'Button Jam', 'No', 477, 15);
INSERT INTO public.inventory_producttransactiondetails VALUES (153, 1, 1, '', '2024-08-05', 1, 'Dead', 'No', 479, 15);
INSERT INTO public.inventory_producttransactiondetails VALUES (240, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 322, 28);
INSERT INTO public.inventory_producttransactiondetails VALUES (241, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 371, 28);
INSERT INTO public.inventory_producttransactiondetails VALUES (242, 0, 1, '', '1900-01-01', 0, '', 'No', 416, 28);
INSERT INTO public.inventory_producttransactiondetails VALUES (243, 0, 1, '', '1900-01-01', 0, '', 'No', 488, 28);
INSERT INTO public.inventory_producttransactiondetails VALUES (244, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 28);
INSERT INTO public.inventory_producttransactiondetails VALUES (245, 0, 1, '', '1900-01-01', 0, '', 'No', 483, 28);
INSERT INTO public.inventory_producttransactiondetails VALUES (246, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 227, 29);
INSERT INTO public.inventory_producttransactiondetails VALUES (247, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 264, 29);
INSERT INTO public.inventory_producttransactiondetails VALUES (248, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 323, 29);
INSERT INTO public.inventory_producttransactiondetails VALUES (250, 0, 1, '', '1900-01-01', 0, '', 'No', 417, 29);
INSERT INTO public.inventory_producttransactiondetails VALUES (251, 0, 1, 'With Power and HDMI 10m Cable and Remote', '1900-01-01', 0, '', 'No', 452, 29);
INSERT INTO public.inventory_producttransactiondetails VALUES (252, 0, 1, 'With Power  Cable and Remote', '1900-01-01', 0, '', 'No', 466, 29);
INSERT INTO public.inventory_producttransactiondetails VALUES (253, 0, 1, '', '1900-01-01', 0, '', 'No', 488, 29);
INSERT INTO public.inventory_producttransactiondetails VALUES (254, 0, 1, '', '1900-01-01', 0, '', 'No', 480, 29);
INSERT INTO public.inventory_producttransactiondetails VALUES (255, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 228, 30);
INSERT INTO public.inventory_producttransactiondetails VALUES (256, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 324, 30);
INSERT INTO public.inventory_producttransactiondetails VALUES (257, 0, 1, 'With Power and USB  Cable', '1900-01-01', 0, '', 'No', 373, 30);
INSERT INTO public.inventory_producttransactiondetails VALUES (258, 0, 1, '', '1900-01-01', 0, '', 'No', 418, 30);
INSERT INTO public.inventory_producttransactiondetails VALUES (259, 0, 1, '', '1900-01-01', 0, '', 'No', 488, 30);
INSERT INTO public.inventory_producttransactiondetails VALUES (260, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 30);
INSERT INTO public.inventory_producttransactiondetails VALUES (261, 0, 1, 'With Power and VGA cable', '1900-01-01', 0, '', 'No', 229, 31);
INSERT INTO public.inventory_producttransactiondetails VALUES (262, 0, 1, 'With Power cable', '1900-01-01', 0, '', 'No', 325, 31);
INSERT INTO public.inventory_producttransactiondetails VALUES (263, 0, 1, 'With Power and USB cable', '1900-01-01', 0, '', 'No', 374, 31);
INSERT INTO public.inventory_producttransactiondetails VALUES (264, 0, 1, '', '1900-01-01', 0, '', 'No', 487, 31);
INSERT INTO public.inventory_producttransactiondetails VALUES (265, 0, 1, '', '1900-01-01', 0, '', 'No', 485, 31);
INSERT INTO public.inventory_producttransactiondetails VALUES (266, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 230, 32);
INSERT INTO public.inventory_producttransactiondetails VALUES (267, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 265, 32);
INSERT INTO public.inventory_producttransactiondetails VALUES (268, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 286, 32);
INSERT INTO public.inventory_producttransactiondetails VALUES (269, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 326, 32);
INSERT INTO public.inventory_producttransactiondetails VALUES (270, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 375, 32);
INSERT INTO public.inventory_producttransactiondetails VALUES (271, 0, 1, '', '1900-01-01', 0, '', 'No', 419, 32);
INSERT INTO public.inventory_producttransactiondetails VALUES (272, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 32);
INSERT INTO public.inventory_producttransactiondetails VALUES (273, 0, 1, 'With Power,HDMI 10m cable and Remote', '1900-01-01', 0, '', 'No', 453, 32);
INSERT INTO public.inventory_producttransactiondetails VALUES (274, 0, 1, 'With Power cable and Remote', '1900-01-01', 0, '', 'No', 467, 32);
INSERT INTO public.inventory_producttransactiondetails VALUES (275, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 32);
INSERT INTO public.inventory_producttransactiondetails VALUES (276, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 32);
INSERT INTO public.inventory_producttransactiondetails VALUES (277, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 231, 33);
INSERT INTO public.inventory_producttransactiondetails VALUES (278, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 266, 33);
INSERT INTO public.inventory_producttransactiondetails VALUES (279, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 489, 33);
INSERT INTO public.inventory_producttransactiondetails VALUES (280, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 327, 33);
INSERT INTO public.inventory_producttransactiondetails VALUES (281, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 376, 33);
INSERT INTO public.inventory_producttransactiondetails VALUES (282, 0, 1, '', '1900-01-01', 0, '', 'No', 420, 33);
INSERT INTO public.inventory_producttransactiondetails VALUES (283, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 33);
INSERT INTO public.inventory_producttransactiondetails VALUES (284, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 33);
INSERT INTO public.inventory_producttransactiondetails VALUES (285, 0, 1, '', '1900-01-01', 0, '', 'No', 483, 33);
INSERT INTO public.inventory_producttransactiondetails VALUES (286, 0, 1, 'With Keyboad,mouse and Power Cable', '1900-01-01', 0, '', 'No', 490, 34);
INSERT INTO public.inventory_producttransactiondetails VALUES (287, 0, 1, 'With  Power and USB Cable', '1900-01-01', 0, '', 'No', 377, 34);
INSERT INTO public.inventory_producttransactiondetails VALUES (288, 0, 1, '', '1900-01-01', 0, '', 'No', 421, 34);
INSERT INTO public.inventory_producttransactiondetails VALUES (291, 0, 1, 'With Power and USB cable', '1900-01-01', 0, '', 'No', 378, 35);
INSERT INTO public.inventory_producttransactiondetails VALUES (294, 0, 1, 'With Power and VGA cable', '1900-01-01', 0, '', 'No', 233, 36);
INSERT INTO public.inventory_producttransactiondetails VALUES (296, 0, 1, 'With Power and VGA cable', '1900-01-01', 0, '', 'No', 287, 36);
INSERT INTO public.inventory_producttransactiondetails VALUES (298, 0, 1, 'With Power cable
With Power cable', '1900-01-01', 0, '', 'No', 329, 36);
INSERT INTO public.inventory_producttransactiondetails VALUES (300, 0, 1, 'With Power cable
With Power and USB cable ', '1900-01-01', 0, '', 'No', 379, 36);
INSERT INTO public.inventory_producttransactiondetails VALUES (301, 0, 1, 'With Power cable
', '1900-01-01', 0, '', 'No', 422, 36);
INSERT INTO public.inventory_producttransactiondetails VALUES (302, 0, 1, 'IN CHAMBER', '1900-01-01', 0, '', 'No', 425, 36);
INSERT INTO public.inventory_producttransactiondetails VALUES (303, 0, 1, 'With power,HDMI 10m cable and remote', '1900-01-01', 0, '', 'No', 454, 37);
INSERT INTO public.inventory_producttransactiondetails VALUES (304, 0, 1, 'With power cable and remote', '1900-01-01', 0, '', 'No', 468, 37);
INSERT INTO public.inventory_producttransactiondetails VALUES (305, 0, 1, 'With power adapter', '1900-01-01', 0, '', 'No', 483, 37);
INSERT INTO public.inventory_producttransactiondetails VALUES (306, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 37);
INSERT INTO public.inventory_producttransactiondetails VALUES (308, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 37);
INSERT INTO public.inventory_producttransactiondetails VALUES (310, 0, 1, 'With Power and VGA cable', '1900-01-01', 0, '', 'No', 234, 38);
INSERT INTO public.inventory_producttransactiondetails VALUES (311, 0, 1, 'With Power and VGA cable', '1900-01-01', 0, '', 'No', 268, 38);
INSERT INTO public.inventory_producttransactiondetails VALUES (312, 0, 1, 'With Power  cable', '1900-01-01', 0, '', 'No', 330, 38);
INSERT INTO public.inventory_producttransactiondetails VALUES (313, 0, 1, 'With Power and USB  cable', '1900-01-01', 0, '', 'No', 380, 38);
INSERT INTO public.inventory_producttransactiondetails VALUES (315, 0, 1, '', '1900-01-01', 0, '', 'No', 423, 38);
INSERT INTO public.inventory_producttransactiondetails VALUES (316, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 38);
INSERT INTO public.inventory_producttransactiondetails VALUES (317, 0, 1, '', '1900-01-01', 0, '', 'No', 476, 38);
INSERT INTO public.inventory_producttransactiondetails VALUES (318, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 38);
INSERT INTO public.inventory_producttransactiondetails VALUES (321, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 382, 39);
INSERT INTO public.inventory_producttransactiondetails VALUES (322, 0, 1, '', '1900-01-01', 0, '', 'No', 424, 39);
INSERT INTO public.inventory_producttransactiondetails VALUES (323, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 39);
INSERT INTO public.inventory_producttransactiondetails VALUES (324, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 39);
INSERT INTO public.inventory_producttransactiondetails VALUES (327, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 383, 40);
INSERT INTO public.inventory_producttransactiondetails VALUES (330, 0, 1, 'With power and vga cable', '1900-01-01', 0, '', 'No', 238, 41);
INSERT INTO public.inventory_producttransactiondetails VALUES (331, 0, 1, 'With power and vga cable', '1900-01-01', 0, '', 'No', 269, 41);
INSERT INTO public.inventory_producttransactiondetails VALUES (333, 0, 1, 'With power and USB cable', '1900-01-01', 0, '', 'No', 384, 42);
INSERT INTO public.inventory_producttransactiondetails VALUES (334, 0, 1, '', '1900-01-01', 0, '', 'No', 426, 42);
INSERT INTO public.inventory_producttransactiondetails VALUES (335, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 42);
INSERT INTO public.inventory_producttransactiondetails VALUES (336, 0, 1, '', '1900-01-01', 0, '', 'No', 480, 42);
INSERT INTO public.inventory_producttransactiondetails VALUES (337, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 42);
INSERT INTO public.inventory_producttransactiondetails VALUES (640, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 78);
INSERT INTO public.inventory_producttransactiondetails VALUES (840, 0, 1, '', '1900-01-01', 0, '', 'No', 920, 106);
INSERT INTO public.inventory_producttransactiondetails VALUES (320, 1, 1, 'With Power Cable', '2024-08-02', 1, 'Replaced with New system', 'No', 331, 39);
INSERT INTO public.inventory_producttransactiondetails VALUES (299, 1, 1, 'With Power cable
With Power cable (IN CHAMBER)', '2024-08-02', 1, 'Replaced with New system', 'No', 333, 36);
INSERT INTO public.inventory_producttransactiondetails VALUES (297, 1, 1, 'With Power and VGA cable
(IN CHAMBER)', '2024-08-02', 1, 'Replaced with New system', 'No', 237, 36);
INSERT INTO public.inventory_producttransactiondetails VALUES (314, 1, 1, 'With Power and USB  cable', '2024-08-02', 1, 'Dead Stock', 'No', 381, 38);
INSERT INTO public.inventory_producttransactiondetails VALUES (249, 1, 1, 'With Power and USB Cable', '2024-08-02', 1, 'Dead Stock', 'No', 372, 29);
INSERT INTO public.inventory_producttransactiondetails VALUES (325, 1, 1, 'With Power and VGA Cable', '2024-09-09', 1, 'Charge Change', 'No', 236, 40);
INSERT INTO public.inventory_producttransactiondetails VALUES (328, 1, 1, '', '2024-09-09', 1, 'Charge Change', 'No', 473, 40);
INSERT INTO public.inventory_producttransactiondetails VALUES (329, 1, 1, '', '2024-09-09', 1, 'Charge Change', 'No', 479, 40);
INSERT INTO public.inventory_producttransactiondetails VALUES (295, 1, 1, 'With Power and VGA cable', '2024-08-23', 1, 'Screen Damaged', 'No', 267, 36);
INSERT INTO public.inventory_producttransactiondetails VALUES (309, 1, 1, 'IN CHAMBER', '2024-08-01', 1, 'Extra', 'No', 485, 37);
INSERT INTO public.inventory_producttransactiondetails VALUES (290, 1, 1, 'With Power cable', '2024-11-25', 1, 'Extra', 'No', 328, 35);
INSERT INTO public.inventory_producttransactiondetails VALUES (292, 1, 1, '', '2024-11-25', 1, 'Extra', 'No', 488, 35);
INSERT INTO public.inventory_producttransactiondetails VALUES (293, 1, 1, '', '2024-11-25', 1, 'Extra', 'No', 479, 35);
INSERT INTO public.inventory_producttransactiondetails VALUES (338, 0, 1, 'With Power and HDMI 10M cable, Remote', '1900-01-01', 0, '', 'No', 455, 42);
INSERT INTO public.inventory_producttransactiondetails VALUES (339, 0, 1, 'With Power cable, Remote', '1900-01-01', 0, '', 'No', 469, 42);
INSERT INTO public.inventory_producttransactiondetails VALUES (340, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 288, 43);
INSERT INTO public.inventory_producttransactiondetails VALUES (341, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 239, 44);
INSERT INTO public.inventory_producttransactiondetails VALUES (342, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 270, 44);
INSERT INTO public.inventory_producttransactiondetails VALUES (343, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 289, 44);
INSERT INTO public.inventory_producttransactiondetails VALUES (345, 0, 1, 'With Power and USB  Cable', '1900-01-01', 0, '', 'No', 385, 44);
INSERT INTO public.inventory_producttransactiondetails VALUES (346, 0, 1, '', '1900-01-01', 0, '', 'No', 427, 44);
INSERT INTO public.inventory_producttransactiondetails VALUES (349, 0, 1, '', '1900-01-01', 0, '', 'No', 477, 44);
INSERT INTO public.inventory_producttransactiondetails VALUES (350, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 44);
INSERT INTO public.inventory_producttransactiondetails VALUES (351, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 240, 45);
INSERT INTO public.inventory_producttransactiondetails VALUES (352, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 336, 45);
INSERT INTO public.inventory_producttransactiondetails VALUES (354, 0, 1, '', '1900-01-01', 0, '', 'No', 428, 45);
INSERT INTO public.inventory_producttransactiondetails VALUES (355, 0, 1, '', '1900-01-01', 0, '', 'No', 477, 45);
INSERT INTO public.inventory_producttransactiondetails VALUES (356, 0, 1, '', '1900-01-01', 0, '', 'No', 482, 45);
INSERT INTO public.inventory_producttransactiondetails VALUES (357, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 241, 46);
INSERT INTO public.inventory_producttransactiondetails VALUES (358, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 337, 46);
INSERT INTO public.inventory_producttransactiondetails VALUES (359, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 387, 46);
INSERT INTO public.inventory_producttransactiondetails VALUES (360, 0, 1, '', '1900-01-01', 0, '', 'No', 429, 46);
INSERT INTO public.inventory_producttransactiondetails VALUES (361, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 46);
INSERT INTO public.inventory_producttransactiondetails VALUES (362, 0, 1, '', '1900-01-01', 0, '', 'No', 481, 46);
INSERT INTO public.inventory_producttransactiondetails VALUES (363, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 242, 47);
INSERT INTO public.inventory_producttransactiondetails VALUES (364, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 338, 47);
INSERT INTO public.inventory_producttransactiondetails VALUES (365, 0, 1, 'With Power and USB  Cable', '1900-01-01', 0, '', 'No', 388, 47);
INSERT INTO public.inventory_producttransactiondetails VALUES (366, 0, 1, '', '1900-01-01', 0, '', 'No', 430, 47);
INSERT INTO public.inventory_producttransactiondetails VALUES (367, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 47);
INSERT INTO public.inventory_producttransactiondetails VALUES (368, 0, 1, '', '1900-01-01', 0, '', 'No', 482, 47);
INSERT INTO public.inventory_producttransactiondetails VALUES (369, 0, 1, 'With Power and VGA Cable (IN CHAMBER)', '1900-01-01', 0, '', 'No', 244, 47);
INSERT INTO public.inventory_producttransactiondetails VALUES (370, 0, 1, 'With Power  Cable (IN CHAMBER)', '1900-01-01', 0, '', 'No', 340, 47);
INSERT INTO public.inventory_producttransactiondetails VALUES (371, 0, 1, ' (IN CHAMBER)', '1900-01-01', 0, '', 'No', 432, 47);
INSERT INTO public.inventory_producttransactiondetails VALUES (372, 0, 1, ' (IN CHAMBER)', '1900-01-01', 0, '', 'No', 474, 47);
INSERT INTO public.inventory_producttransactiondetails VALUES (373, 0, 1, ' (IN CHAMBER)', '1900-01-01', 0, '', 'No', 481, 47);
INSERT INTO public.inventory_producttransactiondetails VALUES (374, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 243, 48);
INSERT INTO public.inventory_producttransactiondetails VALUES (375, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 271, 48);
INSERT INTO public.inventory_producttransactiondetails VALUES (376, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 290, 48);
INSERT INTO public.inventory_producttransactiondetails VALUES (377, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 339, 48);
INSERT INTO public.inventory_producttransactiondetails VALUES (378, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 389, 48);
INSERT INTO public.inventory_producttransactiondetails VALUES (379, 0, 1, '', '1900-01-01', 0, '', 'No', 431, 48);
INSERT INTO public.inventory_producttransactiondetails VALUES (380, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 48);
INSERT INTO public.inventory_producttransactiondetails VALUES (381, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 48);
INSERT INTO public.inventory_producttransactiondetails VALUES (382, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 48);
INSERT INTO public.inventory_producttransactiondetails VALUES (383, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 245, 49);
INSERT INTO public.inventory_producttransactiondetails VALUES (384, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 272, 49);
INSERT INTO public.inventory_producttransactiondetails VALUES (385, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 341, 49);
INSERT INTO public.inventory_producttransactiondetails VALUES (386, 0, 1, 'With Power and USB  Cable', '1900-01-01', 0, '', 'No', 390, 49);
INSERT INTO public.inventory_producttransactiondetails VALUES (387, 0, 1, '', '1900-01-01', 0, '', 'No', 433, 49);
INSERT INTO public.inventory_producttransactiondetails VALUES (388, 0, 1, '', '1900-01-01', 0, '', 'No', 441, 49);
INSERT INTO public.inventory_producttransactiondetails VALUES (389, 0, 1, '', '1900-01-01', 0, '', 'No', 491, 49);
INSERT INTO public.inventory_producttransactiondetails VALUES (390, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 49);
INSERT INTO public.inventory_producttransactiondetails VALUES (391, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 49);
INSERT INTO public.inventory_producttransactiondetails VALUES (392, 0, 1, '', '1900-01-01', 0, '', 'No', 481, 49);
INSERT INTO public.inventory_producttransactiondetails VALUES (393, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 49);
INSERT INTO public.inventory_producttransactiondetails VALUES (394, 0, 1, 'With Power, HDMI 10m cable  and Remote', '1900-01-01', 0, '', 'No', 456, 49);
INSERT INTO public.inventory_producttransactiondetails VALUES (395, 0, 1, 'With Power cable  and Remote', '1900-01-01', 0, '', 'No', 470, 49);
INSERT INTO public.inventory_producttransactiondetails VALUES (396, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 246, 50);
INSERT INTO public.inventory_producttransactiondetails VALUES (397, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 273, 50);
INSERT INTO public.inventory_producttransactiondetails VALUES (398, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 291, 50);
INSERT INTO public.inventory_producttransactiondetails VALUES (399, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 342, 50);
INSERT INTO public.inventory_producttransactiondetails VALUES (400, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 391, 50);
INSERT INTO public.inventory_producttransactiondetails VALUES (401, 0, 1, '', '1900-01-01', 0, '', 'No', 434, 50);
INSERT INTO public.inventory_producttransactiondetails VALUES (402, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 50);
INSERT INTO public.inventory_producttransactiondetails VALUES (403, 0, 1, '', '1900-01-01', 0, '', 'No', 488, 50);
INSERT INTO public.inventory_producttransactiondetails VALUES (404, 0, 1, '', '1900-01-01', 0, '', 'No', 481, 50);
INSERT INTO public.inventory_producttransactiondetails VALUES (405, 0, 1, '', '1900-01-01', 0, '', 'No', 482, 50);
INSERT INTO public.inventory_producttransactiondetails VALUES (406, 0, 1, 'With Power and HDMI 10m Cable and Remote', '1900-01-01', 0, '', 'No', 457, 50);
INSERT INTO public.inventory_producttransactiondetails VALUES (407, 0, 1, 'With Power  Cable and Remote', '1900-01-01', 0, '', 'No', 471, 50);
INSERT INTO public.inventory_producttransactiondetails VALUES (408, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 247, 51);
INSERT INTO public.inventory_producttransactiondetails VALUES (409, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 274, 51);
INSERT INTO public.inventory_producttransactiondetails VALUES (410, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 343, 51);
INSERT INTO public.inventory_producttransactiondetails VALUES (411, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 392, 51);
INSERT INTO public.inventory_producttransactiondetails VALUES (412, 0, 1, '', '1900-01-01', 0, '', 'No', 435, 51);
INSERT INTO public.inventory_producttransactiondetails VALUES (413, 0, 1, '', '1900-01-01', 0, '', 'No', 488, 51);
INSERT INTO public.inventory_producttransactiondetails VALUES (414, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 51);
INSERT INTO public.inventory_producttransactiondetails VALUES (415, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 51);
INSERT INTO public.inventory_producttransactiondetails VALUES (416, 0, 1, 'With power and VGA cable', '1900-01-01', 0, '', 'No', 223, 52);
INSERT INTO public.inventory_producttransactiondetails VALUES (417, 0, 1, 'With power and VGA cable', '1900-01-01', 0, '', 'No', 262, 52);
INSERT INTO public.inventory_producttransactiondetails VALUES (418, 0, 1, 'With power and VGA cable', '1900-01-01', 0, '', 'No', 284, 52);
INSERT INTO public.inventory_producttransactiondetails VALUES (420, 0, 1, 'With power and USB cable', '1900-01-01', 0, '', 'No', 368, 52);
INSERT INTO public.inventory_producttransactiondetails VALUES (421, 0, 1, 'With power adapter', '1900-01-01', 0, '', 'No', 483, 52);
INSERT INTO public.inventory_producttransactiondetails VALUES (422, 0, 1, '', '1900-01-01', 0, '', 'No', 413, 52);
INSERT INTO public.inventory_producttransactiondetails VALUES (423, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 52);
INSERT INTO public.inventory_producttransactiondetails VALUES (424, 0, 1, '', '1900-01-01', 0, '', 'No', 485, 52);
INSERT INTO public.inventory_producttransactiondetails VALUES (425, 0, 1, 'with Power and VGA Cable', '1900-01-01', 0, '', 'No', 224, 53);
INSERT INTO public.inventory_producttransactiondetails VALUES (426, 0, 1, 'with Power  Cable', '1900-01-01', 0, '', 'No', 320, 53);
INSERT INTO public.inventory_producttransactiondetails VALUES (427, 0, 1, 'with Power and USB Cable', '1900-01-01', 0, '', 'No', 369, 53);
INSERT INTO public.inventory_producttransactiondetails VALUES (428, 0, 1, '', '1900-01-01', 0, '', 'No', 414, 53);
INSERT INTO public.inventory_producttransactiondetails VALUES (429, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 53);
INSERT INTO public.inventory_producttransactiondetails VALUES (430, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 53);
INSERT INTO public.inventory_producttransactiondetails VALUES (431, 0, 1, 'with Power,HDMI 10m Cable and Remote', '1900-01-01', 0, '', 'No', 451, 53);
INSERT INTO public.inventory_producttransactiondetails VALUES (432, 0, 1, 'with Power Cable and Remote', '1900-01-01', 0, '', 'No', 465, 53);
INSERT INTO public.inventory_producttransactiondetails VALUES (433, 0, 1, 'With power and VGA Cable', '1900-01-01', 0, '', 'No', 225, 54);
INSERT INTO public.inventory_producttransactiondetails VALUES (434, 0, 1, 'With power Cable', '1900-01-01', 0, '', 'No', 321, 54);
INSERT INTO public.inventory_producttransactiondetails VALUES (435, 0, 1, 'With power and USB  Cable', '1900-01-01', 0, '', 'No', 370, 54);
INSERT INTO public.inventory_producttransactiondetails VALUES (436, 0, 1, '', '1900-01-01', 0, '', 'No', 415, 54);
INSERT INTO public.inventory_producttransactiondetails VALUES (437, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 54);
INSERT INTO public.inventory_producttransactiondetails VALUES (348, 1, 1, '', '2024-10-05', 1, '', 'No', 475, 44);
INSERT INTO public.inventory_producttransactiondetails VALUES (347, 1, 1, '', '2024-10-05', 1, '', 'No', 474, 44);
INSERT INTO public.inventory_producttransactiondetails VALUES (344, 1, 1, 'With Power  Cable', '2024-10-05', 1, 'Not Working', 'No', 335, 44);
INSERT INTO public.inventory_producttransactiondetails VALUES (439, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 492, 55);
INSERT INTO public.inventory_producttransactiondetails VALUES (440, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 514, 55);
INSERT INTO public.inventory_producttransactiondetails VALUES (441, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 526, 55);
INSERT INTO public.inventory_producttransactiondetails VALUES (442, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 533, 55);
INSERT INTO public.inventory_producttransactiondetails VALUES (443, 0, 1, 'With Power and USB  Cable', '1900-01-01', 0, '', 'No', 558, 55);
INSERT INTO public.inventory_producttransactiondetails VALUES (444, 0, 1, '', '1900-01-01', 0, '', 'No', 574, 55);
INSERT INTO public.inventory_producttransactiondetails VALUES (446, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 55);
INSERT INTO public.inventory_producttransactiondetails VALUES (447, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 55);
INSERT INTO public.inventory_producttransactiondetails VALUES (448, 0, 1, 'With Power,HDMI 10m cable and Remote ', '1900-01-01', 0, '', 'No', 595, 55);
INSERT INTO public.inventory_producttransactiondetails VALUES (449, 0, 1, 'With Power cable and Remote ', '1900-01-01', 0, '', 'No', 600, 55);
INSERT INTO public.inventory_producttransactiondetails VALUES (450, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 493, 56);
INSERT INTO public.inventory_producttransactiondetails VALUES (451, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 515, 56);
INSERT INTO public.inventory_producttransactiondetails VALUES (452, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 534, 56);
INSERT INTO public.inventory_producttransactiondetails VALUES (453, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 559, 56);
INSERT INTO public.inventory_producttransactiondetails VALUES (454, 0, 1, '', '1900-01-01', 0, '', 'No', 575, 56);
INSERT INTO public.inventory_producttransactiondetails VALUES (455, 0, 1, '', '1900-01-01', 0, '', 'No', 477, 56);
INSERT INTO public.inventory_producttransactiondetails VALUES (456, 0, 1, '', '1900-01-01', 0, '', 'No', 481, 56);
INSERT INTO public.inventory_producttransactiondetails VALUES (457, 0, 1, 'With Powe Adapter', '1900-01-01', 0, '', 'No', 483, 56);
INSERT INTO public.inventory_producttransactiondetails VALUES (458, 0, 1, 'With Powe and VGA Cable', '1900-01-01', 0, '', 'No', 494, 57);
INSERT INTO public.inventory_producttransactiondetails VALUES (459, 0, 1, 'With Powe Cable', '1900-01-01', 0, '', 'No', 535, 57);
INSERT INTO public.inventory_producttransactiondetails VALUES (460, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 57);
INSERT INTO public.inventory_producttransactiondetails VALUES (461, 0, 1, '', '1900-01-01', 0, '', 'No', 481, 57);
INSERT INTO public.inventory_producttransactiondetails VALUES (462, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 495, 58);
INSERT INTO public.inventory_producttransactiondetails VALUES (463, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 536, 58);
INSERT INTO public.inventory_producttransactiondetails VALUES (464, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 58);
INSERT INTO public.inventory_producttransactiondetails VALUES (465, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 58);
INSERT INTO public.inventory_producttransactiondetails VALUES (466, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 496, 59);
INSERT INTO public.inventory_producttransactiondetails VALUES (467, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 537, 59);
INSERT INTO public.inventory_producttransactiondetails VALUES (468, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 562, 59);
INSERT INTO public.inventory_producttransactiondetails VALUES (469, 0, 1, '', '1900-01-01', 0, '', 'No', 576, 59);
INSERT INTO public.inventory_producttransactiondetails VALUES (470, 0, 1, '', '1900-01-01', 0, '', 'No', 477, 59);
INSERT INTO public.inventory_producttransactiondetails VALUES (471, 0, 1, '', '1900-01-01', 0, '', 'No', 482, 59);
INSERT INTO public.inventory_producttransactiondetails VALUES (472, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 497, 60);
INSERT INTO public.inventory_producttransactiondetails VALUES (473, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 516, 60);
INSERT INTO public.inventory_producttransactiondetails VALUES (474, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 527, 60);
INSERT INTO public.inventory_producttransactiondetails VALUES (476, 0, 1, '', '1900-01-01', 0, '', 'No', 577, 60);
INSERT INTO public.inventory_producttransactiondetails VALUES (477, 0, 1, '', '1900-01-01', 0, '', 'No', 579, 60);
INSERT INTO public.inventory_producttransactiondetails VALUES (478, 0, 1, '', '1900-01-01', 0, '', 'No', 488, 60);
INSERT INTO public.inventory_producttransactiondetails VALUES (479, 0, 2, '', '1900-01-01', 0, '', 'No', 479, 60);
INSERT INTO public.inventory_producttransactiondetails VALUES (480, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 60);
INSERT INTO public.inventory_producttransactiondetails VALUES (481, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 498, 61);
INSERT INTO public.inventory_producttransactiondetails VALUES (482, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 517, 61);
INSERT INTO public.inventory_producttransactiondetails VALUES (483, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 528, 61);
INSERT INTO public.inventory_producttransactiondetails VALUES (484, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 539, 61);
INSERT INTO public.inventory_producttransactiondetails VALUES (485, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 563, 61);
INSERT INTO public.inventory_producttransactiondetails VALUES (486, 0, 1, '


', '1900-01-01', 0, '', 'No', 578, 61);
INSERT INTO public.inventory_producttransactiondetails VALUES (487, 0, 1, '


', '1900-01-01', 0, '', 'No', 580, 61);
INSERT INTO public.inventory_producttransactiondetails VALUES (488, 0, 1, '


', '1900-01-01', 0, '', 'No', 473, 61);
INSERT INTO public.inventory_producttransactiondetails VALUES (489, 0, 1, '


', '1900-01-01', 0, '', 'No', 485, 61);
INSERT INTO public.inventory_producttransactiondetails VALUES (490, 0, 1, '


', '1900-01-01', 0, '', 'No', 480, 61);
INSERT INTO public.inventory_producttransactiondetails VALUES (491, 0, 1, 'with Power Adapter', '1900-01-01', 0, '', 'No', 483, 61);
INSERT INTO public.inventory_producttransactiondetails VALUES (492, 0, 1, 'with Power, HDMI 10M Cable and Remote', '1900-01-01', 0, '', 'No', 596, 61);
INSERT INTO public.inventory_producttransactiondetails VALUES (493, 0, 1, 'with Power Cable and Remote', '1900-01-01', 0, '', 'No', 601, 61);
INSERT INTO public.inventory_producttransactiondetails VALUES (494, 0, 1, 'with Power Adapter', '1900-01-01', 0, '', 'No', 605, 61);
INSERT INTO public.inventory_producttransactiondetails VALUES (495, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 499, 62);
INSERT INTO public.inventory_producttransactiondetails VALUES (496, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 540, 62);
INSERT INTO public.inventory_producttransactiondetails VALUES (498, 0, 1, '', '1900-01-01', 0, '', 'No', 581, 62);
INSERT INTO public.inventory_producttransactiondetails VALUES (499, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 62);
INSERT INTO public.inventory_producttransactiondetails VALUES (500, 0, 1, '', '1900-01-01', 0, '', 'No', 480, 62);
INSERT INTO public.inventory_producttransactiondetails VALUES (501, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 500, 63);
INSERT INTO public.inventory_producttransactiondetails VALUES (502, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 541, 63);
INSERT INTO public.inventory_producttransactiondetails VALUES (503, 0, 1, '', '1900-01-01', 0, '', 'No', 488, 63);
INSERT INTO public.inventory_producttransactiondetails VALUES (504, 0, 1, '', '1900-01-01', 0, '', 'No', 485, 63);
INSERT INTO public.inventory_producttransactiondetails VALUES (505, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 501, 64);
INSERT INTO public.inventory_producttransactiondetails VALUES (506, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 518, 64);
INSERT INTO public.inventory_producttransactiondetails VALUES (507, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 529, 64);
INSERT INTO public.inventory_producttransactiondetails VALUES (508, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 542, 64);
INSERT INTO public.inventory_producttransactiondetails VALUES (509, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 565, 64);
INSERT INTO public.inventory_producttransactiondetails VALUES (510, 0, 1, '', '1900-01-01', 0, '', 'No', 583, 64);
INSERT INTO public.inventory_producttransactiondetails VALUES (511, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 64);
INSERT INTO public.inventory_producttransactiondetails VALUES (512, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 64);
INSERT INTO public.inventory_producttransactiondetails VALUES (513, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 64);
INSERT INTO public.inventory_producttransactiondetails VALUES (514, 0, 1, 'With Power,HDMI 10m Cable and Remote', '1900-01-01', 0, '', 'No', 597, 64);
INSERT INTO public.inventory_producttransactiondetails VALUES (515, 0, 1, 'With Power Cable and Remote', '1900-01-01', 0, '', 'No', 602, 64);
INSERT INTO public.inventory_producttransactiondetails VALUES (517, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 519, 65);
INSERT INTO public.inventory_producttransactiondetails VALUES (518, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 543, 65);
INSERT INTO public.inventory_producttransactiondetails VALUES (519, 0, 1, 'With Power and USB  Cable', '1900-01-01', 0, '', 'No', 566, 65);
INSERT INTO public.inventory_producttransactiondetails VALUES (520, 0, 1, '', '1900-01-01', 0, '', 'No', 584, 65);
INSERT INTO public.inventory_producttransactiondetails VALUES (521, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 65);
INSERT INTO public.inventory_producttransactiondetails VALUES (522, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 65);
INSERT INTO public.inventory_producttransactiondetails VALUES (523, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 65);
INSERT INTO public.inventory_producttransactiondetails VALUES (524, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 503, 66);
INSERT INTO public.inventory_producttransactiondetails VALUES (525, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 520, 66);
INSERT INTO public.inventory_producttransactiondetails VALUES (526, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 544, 66);
INSERT INTO public.inventory_producttransactiondetails VALUES (527, 0, 1, 'With Power and USB  Cable', '1900-01-01', 0, '', 'No', 567, 66);
INSERT INTO public.inventory_producttransactiondetails VALUES (528, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 66);
INSERT INTO public.inventory_producttransactiondetails VALUES (529, 0, 1, '', '1900-01-01', 0, '', 'No', 582, 66);
INSERT INTO public.inventory_producttransactiondetails VALUES (530, 0, 1, '', '1900-01-01', 0, '', 'No', 488, 66);
INSERT INTO public.inventory_producttransactiondetails VALUES (531, 0, 1, '', '1900-01-01', 0, '', 'No', 485, 66);
INSERT INTO public.inventory_producttransactiondetails VALUES (532, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 504, 67);
INSERT INTO public.inventory_producttransactiondetails VALUES (533, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 545, 67);
INSERT INTO public.inventory_producttransactiondetails VALUES (534, 0, 1, '', '1900-01-01', 0, '', 'No', 585, 67);
INSERT INTO public.inventory_producttransactiondetails VALUES (535, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 67);
INSERT INTO public.inventory_producttransactiondetails VALUES (536, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 67);
INSERT INTO public.inventory_producttransactiondetails VALUES (537, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 606, 67);
INSERT INTO public.inventory_producttransactiondetails VALUES (538, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 505, 68);
INSERT INTO public.inventory_producttransactiondetails VALUES (839, 0, 1, '', '1900-01-01', 0, '', 'No', 898, 106);
INSERT INTO public.inventory_producttransactiondetails VALUES (445, 1, 1, '', '2024-09-05', 1, 'Button Jam', 'No', 477, 55);
INSERT INTO public.inventory_producttransactiondetails VALUES (497, 1, 1, 'With Power and USB  Cable', '2024-09-17', 1, 'Returned due to Extra', 'No', 564, 62);
INSERT INTO public.inventory_producttransactiondetails VALUES (539, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 546, 68);
INSERT INTO public.inventory_producttransactiondetails VALUES (540, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 568, 68);
INSERT INTO public.inventory_producttransactiondetails VALUES (541, 0, 1, '', '1900-01-01', 0, '', 'No', 587, 68);
INSERT INTO public.inventory_producttransactiondetails VALUES (542, 0, 1, '', '1900-01-01', 0, '', 'No', 477, 68);
INSERT INTO public.inventory_producttransactiondetails VALUES (543, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 68);
INSERT INTO public.inventory_producttransactiondetails VALUES (544, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 506, 69);
INSERT INTO public.inventory_producttransactiondetails VALUES (545, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 521, 69);
INSERT INTO public.inventory_producttransactiondetails VALUES (546, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 547, 69);
INSERT INTO public.inventory_producttransactiondetails VALUES (547, 0, 1, 'With Power and USB  Cable', '1900-01-01', 0, '', 'No', 569, 69);
INSERT INTO public.inventory_producttransactiondetails VALUES (548, 0, 1, '', '1900-01-01', 0, '', 'No', 589, 69);
INSERT INTO public.inventory_producttransactiondetails VALUES (549, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 69);
INSERT INTO public.inventory_producttransactiondetails VALUES (550, 0, 1, '', '1900-01-01', 0, '', 'No', 485, 69);
INSERT INTO public.inventory_producttransactiondetails VALUES (551, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 69);
INSERT INTO public.inventory_producttransactiondetails VALUES (552, 0, 1, 'With Power, HDMI 10m Cable and Remote', '1900-01-01', 0, '', 'No', 598, 69);
INSERT INTO public.inventory_producttransactiondetails VALUES (553, 0, 1, 'With Power Cable and Remote', '1900-01-01', 0, '', 'No', 603, 69);
INSERT INTO public.inventory_producttransactiondetails VALUES (554, 0, 1, 'With Power Cable ', '1900-01-01', 0, '', 'No', 549, 69);
INSERT INTO public.inventory_producttransactiondetails VALUES (555, 0, 1, '', '1900-01-01', 0, '', 'No', 590, 69);
INSERT INTO public.inventory_producttransactiondetails VALUES (556, 0, 1, '', '1900-01-01', 0, '', 'No', 488, 69);
INSERT INTO public.inventory_producttransactiondetails VALUES (557, 0, 1, '', '1900-01-01', 0, '', 'No', 482, 69);
INSERT INTO public.inventory_producttransactiondetails VALUES (558, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 507, 70);
INSERT INTO public.inventory_producttransactiondetails VALUES (559, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 522, 70);
INSERT INTO public.inventory_producttransactiondetails VALUES (560, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 548, 70);
INSERT INTO public.inventory_producttransactiondetails VALUES (561, 0, 1, 'With Power  Adapter', '1900-01-01', 0, '', 'No', 483, 70);
INSERT INTO public.inventory_producttransactiondetails VALUES (562, 0, 1, 'With Power  and USB Cable', '1900-01-01', 0, '', 'No', 570, 70);
INSERT INTO public.inventory_producttransactiondetails VALUES (563, 0, 1, '', '1900-01-01', 0, '', 'No', 586, 70);
INSERT INTO public.inventory_producttransactiondetails VALUES (564, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 70);
INSERT INTO public.inventory_producttransactiondetails VALUES (565, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 70);
INSERT INTO public.inventory_producttransactiondetails VALUES (566, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 509, 71);
INSERT INTO public.inventory_producttransactiondetails VALUES (567, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 550, 71);
INSERT INTO public.inventory_producttransactiondetails VALUES (568, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 71);
INSERT INTO public.inventory_producttransactiondetails VALUES (569, 0, 1, '', '1900-01-01', 0, '', 'No', 485, 71);
INSERT INTO public.inventory_producttransactiondetails VALUES (570, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 510, 72);
INSERT INTO public.inventory_producttransactiondetails VALUES (571, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 551, 72);
INSERT INTO public.inventory_producttransactiondetails VALUES (572, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 571, 72);
INSERT INTO public.inventory_producttransactiondetails VALUES (573, 0, 1, '', '1900-01-01', 0, '', 'No', 588, 72);
INSERT INTO public.inventory_producttransactiondetails VALUES (574, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 72);
INSERT INTO public.inventory_producttransactiondetails VALUES (575, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 72);
INSERT INTO public.inventory_producttransactiondetails VALUES (576, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 511, 73);
INSERT INTO public.inventory_producttransactiondetails VALUES (577, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 523, 73);
INSERT INTO public.inventory_producttransactiondetails VALUES (578, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 530, 73);
INSERT INTO public.inventory_producttransactiondetails VALUES (580, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 555, 73);
INSERT INTO public.inventory_producttransactiondetails VALUES (581, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 176, 73);
INSERT INTO public.inventory_producttransactiondetails VALUES (582, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 560, 73);
INSERT INTO public.inventory_producttransactiondetails VALUES (583, 0, 1, '', '1900-01-01', 0, '', 'No', 591, 73);
INSERT INTO public.inventory_producttransactiondetails VALUES (584, 0, 1, '', '1900-01-01', 0, '', 'No', 593, 73);
INSERT INTO public.inventory_producttransactiondetails VALUES (585, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 73);
INSERT INTO public.inventory_producttransactiondetails VALUES (586, 0, 1, '', '1900-01-01', 0, '', 'No', 476, 73);
INSERT INTO public.inventory_producttransactiondetails VALUES (587, 0, 2, '', '1900-01-01', 0, '', 'No', 479, 73);
INSERT INTO public.inventory_producttransactiondetails VALUES (588, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 73);
INSERT INTO public.inventory_producttransactiondetails VALUES (589, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 512, 74);
INSERT INTO public.inventory_producttransactiondetails VALUES (590, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 524, 74);
INSERT INTO public.inventory_producttransactiondetails VALUES (591, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 531, 74);
INSERT INTO public.inventory_producttransactiondetails VALUES (592, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 508, 74);
INSERT INTO public.inventory_producttransactiondetails VALUES (593, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 553, 74);
INSERT INTO public.inventory_producttransactiondetails VALUES (594, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 556, 74);
INSERT INTO public.inventory_producttransactiondetails VALUES (595, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 572, 74);
INSERT INTO public.inventory_producttransactiondetails VALUES (596, 0, 1, '', '1900-01-01', 0, '', 'No', 592, 74);
INSERT INTO public.inventory_producttransactiondetails VALUES (597, 0, 1, '', '1900-01-01', 0, '', 'No', 594, 74);
INSERT INTO public.inventory_producttransactiondetails VALUES (598, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 74);
INSERT INTO public.inventory_producttransactiondetails VALUES (599, 0, 2, '', '1900-01-01', 0, '', 'No', 474, 74);
INSERT INTO public.inventory_producttransactiondetails VALUES (600, 0, 1, '', '1900-01-01', 0, '', 'No', 488, 74);
INSERT INTO public.inventory_producttransactiondetails VALUES (601, 0, 2, '', '1900-01-01', 0, '', 'No', 479, 74);
INSERT INTO public.inventory_producttransactiondetails VALUES (602, 0, 1, '', '1900-01-01', 0, '', 'No', 485, 74);
INSERT INTO public.inventory_producttransactiondetails VALUES (603, 0, 1, 'With Power,HDMI 10M Cable and Remote', '1900-01-01', 0, '', 'No', 599, 74);
INSERT INTO public.inventory_producttransactiondetails VALUES (604, 0, 1, 'With Power Cable and Remote', '1900-01-01', 0, '', 'No', 604, 74);
INSERT INTO public.inventory_producttransactiondetails VALUES (605, 0, 1, 'With Power and USB Cable ', '1900-01-01', 0, '', 'No', 561, 74);
INSERT INTO public.inventory_producttransactiondetails VALUES (606, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 513, 75);
INSERT INTO public.inventory_producttransactiondetails VALUES (607, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 525, 75);
INSERT INTO public.inventory_producttransactiondetails VALUES (608, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 554, 75);
INSERT INTO public.inventory_producttransactiondetails VALUES (609, 0, 1, 'With Power and USB  Cable', '1900-01-01', 0, '', 'No', 573, 75);
INSERT INTO public.inventory_producttransactiondetails VALUES (610, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 75);
INSERT INTO public.inventory_producttransactiondetails VALUES (611, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 75);
INSERT INTO public.inventory_producttransactiondetails VALUES (612, 0, 1, 'With Power And VGA Cable', '1900-01-01', 0, '', 'No', 625, 76);
INSERT INTO public.inventory_producttransactiondetails VALUES (613, 0, 1, 'With Power And VGA Cable', '1900-01-01', 0, '', 'No', 700, 76);
INSERT INTO public.inventory_producttransactiondetails VALUES (614, 0, 1, 'With Power And VGA Cable', '1900-01-01', 0, '', 'No', 718, 76);
INSERT INTO public.inventory_producttransactiondetails VALUES (615, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 731, 76);
INSERT INTO public.inventory_producttransactiondetails VALUES (617, 0, 1, '', '1900-01-01', 0, '', 'No', 873, 76);
INSERT INTO public.inventory_producttransactiondetails VALUES (618, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 76);
INSERT INTO public.inventory_producttransactiondetails VALUES (619, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 76);
INSERT INTO public.inventory_producttransactiondetails VALUES (620, 0, 1, '', '1900-01-01', 0, '', 'No', 481, 76);
INSERT INTO public.inventory_producttransactiondetails VALUES (621, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 626, 77);
INSERT INTO public.inventory_producttransactiondetails VALUES (622, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 701, 77);
INSERT INTO public.inventory_producttransactiondetails VALUES (623, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 719, 77);
INSERT INTO public.inventory_producttransactiondetails VALUES (624, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 732, 77);
INSERT INTO public.inventory_producttransactiondetails VALUES (626, 0, 1, 'With Power and USB  Cable', '1900-01-01', 0, '', 'No', 813, 77);
INSERT INTO public.inventory_producttransactiondetails VALUES (627, 0, 1, '', '1900-01-01', 0, '', 'No', 874, 77);
INSERT INTO public.inventory_producttransactiondetails VALUES (628, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 77);
INSERT INTO public.inventory_producttransactiondetails VALUES (629, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 77);
INSERT INTO public.inventory_producttransactiondetails VALUES (630, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 77);
INSERT INTO public.inventory_producttransactiondetails VALUES (631, 0, 1, '', '1900-01-01', 0, '', 'No', 481, 77);
INSERT INTO public.inventory_producttransactiondetails VALUES (632, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 77);
INSERT INTO public.inventory_producttransactiondetails VALUES (633, 0, 1, 'With Power Adapter,stand  and Remote', '1900-01-01', 0, '', 'No', 962, 77);
INSERT INTO public.inventory_producttransactiondetails VALUES (634, 0, 1, 'With Power Adapter  and Remote', '1900-01-01', 0, '', 'No', 947, 77);
INSERT INTO public.inventory_producttransactiondetails VALUES (635, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 628, 78);
INSERT INTO public.inventory_producttransactiondetails VALUES (636, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 734, 78);
INSERT INTO public.inventory_producttransactiondetails VALUES (637, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 815, 78);
INSERT INTO public.inventory_producttransactiondetails VALUES (638, 0, 1, '', '1900-01-01', 0, '', 'No', 876, 78);
INSERT INTO public.inventory_producttransactiondetails VALUES (579, 1, 1, 'With Power Cable', '2024-11-25', 1, 'Extra', 'No', 552, 73);
INSERT INTO public.inventory_producttransactiondetails VALUES (625, 1, 1, 'With Power Cable', '2024-11-22', 1, 'Returned due to Extra.', 'No', 807, 77);
INSERT INTO public.inventory_producttransactiondetails VALUES (641, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 627, 79);
INSERT INTO public.inventory_producttransactiondetails VALUES (642, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 733, 79);
INSERT INTO public.inventory_producttransactiondetails VALUES (643, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 814, 79);
INSERT INTO public.inventory_producttransactiondetails VALUES (644, 0, 1, '', '1900-01-01', 0, '', 'No', 875, 79);
INSERT INTO public.inventory_producttransactiondetails VALUES (645, 0, 1, '', '1900-01-01', 0, '', 'No', 477, 79);
INSERT INTO public.inventory_producttransactiondetails VALUES (646, 0, 1, '', '1900-01-01', 0, '', 'No', 480, 79);
INSERT INTO public.inventory_producttransactiondetails VALUES (647, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 629, 80);
INSERT INTO public.inventory_producttransactiondetails VALUES (648, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 735, 80);
INSERT INTO public.inventory_producttransactiondetails VALUES (649, 0, 1, '', '1900-01-01', 0, '', 'No', 877, 80);
INSERT INTO public.inventory_producttransactiondetails VALUES (650, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 80);
INSERT INTO public.inventory_producttransactiondetails VALUES (651, 0, 1, '', '1900-01-01', 0, '', 'No', 481, 80);
INSERT INTO public.inventory_producttransactiondetails VALUES (289, 1, 1, 'With Power and VGA cable', '2024-06-18', 1, '', 'No', 232, 35);
INSERT INTO public.inventory_producttransactiondetails VALUES (653, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 973, 82);
INSERT INTO public.inventory_producttransactiondetails VALUES (654, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 232, 82);
INSERT INTO public.inventory_producttransactiondetails VALUES (655, 0, 1, '', '1900-01-01', 0, '', 'No', 974, 82);
INSERT INTO public.inventory_producttransactiondetails VALUES (656, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 82);
INSERT INTO public.inventory_producttransactiondetails VALUES (657, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 82);
INSERT INTO public.inventory_producttransactiondetails VALUES (658, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 630, 83);
INSERT INTO public.inventory_producttransactiondetails VALUES (659, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 702, 83);
INSERT INTO public.inventory_producttransactiondetails VALUES (660, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 720, 83);
INSERT INTO public.inventory_producttransactiondetails VALUES (661, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 736, 83);
INSERT INTO public.inventory_producttransactiondetails VALUES (662, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 816, 83);
INSERT INTO public.inventory_producttransactiondetails VALUES (663, 0, 1, '', '1900-01-01', 0, '', 'No', 878, 83);
INSERT INTO public.inventory_producttransactiondetails VALUES (664, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 83);
INSERT INTO public.inventory_producttransactiondetails VALUES (665, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 83);
INSERT INTO public.inventory_producttransactiondetails VALUES (666, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 83);
INSERT INTO public.inventory_producttransactiondetails VALUES (668, 0, 1, 'With Power and USB Cable (In Chamber)', '1900-01-01', 0, '', 'No', 821, 83);
INSERT INTO public.inventory_producttransactiondetails VALUES (667, 0, 1, 'With Power Cable (In Chamber)', '1900-01-01', 0, '', 'No', 975, 83);
INSERT INTO public.inventory_producttransactiondetails VALUES (669, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 631, 84);
INSERT INTO public.inventory_producttransactiondetails VALUES (670, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 737, 84);
INSERT INTO public.inventory_producttransactiondetails VALUES (671, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 817, 84);
INSERT INTO public.inventory_producttransactiondetails VALUES (672, 0, 1, '', '1900-01-01', 0, '', 'No', 879, 84);
INSERT INTO public.inventory_producttransactiondetails VALUES (673, 0, 1, '', '1900-01-01', 0, '', 'No', 488, 84);
INSERT INTO public.inventory_producttransactiondetails VALUES (674, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 84);
INSERT INTO public.inventory_producttransactiondetails VALUES (675, 0, 1, 'With Power Cable and Remote ', '1900-01-01', 0, '', 'No', 963, 84);
INSERT INTO public.inventory_producttransactiondetails VALUES (676, 0, 1, 'With Power Adapter ', '1900-01-01', 0, '', 'No', 948, 84);
INSERT INTO public.inventory_producttransactiondetails VALUES (677, 0, 1, 'With Power and USB Cable ', '1900-01-01', 0, '', 'No', 636, 84);
INSERT INTO public.inventory_producttransactiondetails VALUES (678, 0, 1, 'With Power  Cable ', '1900-01-01', 0, '', 'No', 742, 84);
INSERT INTO public.inventory_producttransactiondetails VALUES (679, 0, 1, 'With Power  and USB Cable ', '1900-01-01', 0, '', 'No', 823, 84);
INSERT INTO public.inventory_producttransactiondetails VALUES (680, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 632, 85);
INSERT INTO public.inventory_producttransactiondetails VALUES (681, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 738, 85);
INSERT INTO public.inventory_producttransactiondetails VALUES (682, 0, 1, 'With Power and USB  Cable', '1900-01-01', 0, '', 'No', 818, 85);
INSERT INTO public.inventory_producttransactiondetails VALUES (683, 0, 1, 'With Power and USB  Cable', '1900-01-01', 0, '', 'No', 872, 85);
INSERT INTO public.inventory_producttransactiondetails VALUES (684, 0, 1, '', '1900-01-01', 0, '', 'No', 880, 85);
INSERT INTO public.inventory_producttransactiondetails VALUES (685, 0, 1, '', '1900-01-01', 0, '', 'No', 488, 85);
INSERT INTO public.inventory_producttransactiondetails VALUES (687, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 55, 86);
INSERT INTO public.inventory_producttransactiondetails VALUES (688, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 824, 86);
INSERT INTO public.inventory_producttransactiondetails VALUES (689, 0, 1, '', '1900-01-01', 0, '', 'No', 885, 86);
INSERT INTO public.inventory_producttransactiondetails VALUES (690, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 633, 87);
INSERT INTO public.inventory_producttransactiondetails VALUES (691, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 739, 87);
INSERT INTO public.inventory_producttransactiondetails VALUES (692, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 819, 87);
INSERT INTO public.inventory_producttransactiondetails VALUES (693, 0, 1, '', '1900-01-01', 0, '', 'No', 881, 87);
INSERT INTO public.inventory_producttransactiondetails VALUES (694, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 87);
INSERT INTO public.inventory_producttransactiondetails VALUES (695, 0, 1, '', '1900-01-01', 0, '', 'No', 485, 87);
INSERT INTO public.inventory_producttransactiondetails VALUES (696, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 634, 88);
INSERT INTO public.inventory_producttransactiondetails VALUES (697, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 740, 88);
INSERT INTO public.inventory_producttransactiondetails VALUES (698, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 820, 88);
INSERT INTO public.inventory_producttransactiondetails VALUES (699, 0, 1, '', '1900-01-01', 0, '', 'No', 882, 88);
INSERT INTO public.inventory_producttransactiondetails VALUES (700, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 88);
INSERT INTO public.inventory_producttransactiondetails VALUES (701, 0, 1, '', '1900-01-01', 0, '', 'No', 481, 88);
INSERT INTO public.inventory_producttransactiondetails VALUES (702, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 635, 89);
INSERT INTO public.inventory_producttransactiondetails VALUES (703, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 741, 89);
INSERT INTO public.inventory_producttransactiondetails VALUES (704, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 822, 89);
INSERT INTO public.inventory_producttransactiondetails VALUES (705, 0, 1, '', '1900-01-01', 0, '', 'No', 884, 89);
INSERT INTO public.inventory_producttransactiondetails VALUES (706, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 89);
INSERT INTO public.inventory_producttransactiondetails VALUES (707, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 89);
INSERT INTO public.inventory_producttransactiondetails VALUES (708, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 637, 90);
INSERT INTO public.inventory_producttransactiondetails VALUES (709, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 703, 90);
INSERT INTO public.inventory_producttransactiondetails VALUES (710, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 721, 90);
INSERT INTO public.inventory_producttransactiondetails VALUES (711, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 743, 90);
INSERT INTO public.inventory_producttransactiondetails VALUES (712, 0, 1, 'With Power  and USB Cable', '1900-01-01', 0, '', 'No', 825, 90);
INSERT INTO public.inventory_producttransactiondetails VALUES (713, 0, 1, '', '1900-01-01', 0, '', 'No', 886, 90);
INSERT INTO public.inventory_producttransactiondetails VALUES (714, 0, 1, '', '1900-01-01', 0, '', 'No', 883, 90);
INSERT INTO public.inventory_producttransactiondetails VALUES (716, 0, 1, '', '1900-01-01', 0, '', 'No', 482, 90);
INSERT INTO public.inventory_producttransactiondetails VALUES (717, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 90);
INSERT INTO public.inventory_producttransactiondetails VALUES (718, 0, 1, 'With Power Cable and Remote', '1900-01-01', 0, '', 'No', 964, 90);
INSERT INTO public.inventory_producttransactiondetails VALUES (719, 0, 1, 'With Power,USB Cable and  Remote', '1900-01-01', 0, '', 'No', 949, 90);
INSERT INTO public.inventory_producttransactiondetails VALUES (720, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 638, 91);
INSERT INTO public.inventory_producttransactiondetails VALUES (721, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 704, 91);
INSERT INTO public.inventory_producttransactiondetails VALUES (722, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 722, 91);
INSERT INTO public.inventory_producttransactiondetails VALUES (723, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 744, 91);
INSERT INTO public.inventory_producttransactiondetails VALUES (724, 0, 1, 'With Power and USB  Cable', '1900-01-01', 0, '', 'No', 826, 91);
INSERT INTO public.inventory_producttransactiondetails VALUES (725, 0, 1, '', '1900-01-01', 0, '', 'No', 887, 91);
INSERT INTO public.inventory_producttransactiondetails VALUES (726, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 91);
INSERT INTO public.inventory_producttransactiondetails VALUES (727, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 91);
INSERT INTO public.inventory_producttransactiondetails VALUES (728, 0, 1, '', '1900-01-01', 0, '', 'No', 481, 91);
INSERT INTO public.inventory_producttransactiondetails VALUES (729, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 91);
INSERT INTO public.inventory_producttransactiondetails VALUES (730, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 639, 92);
INSERT INTO public.inventory_producttransactiondetails VALUES (731, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 745, 92);
INSERT INTO public.inventory_producttransactiondetails VALUES (732, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 827, 92);
INSERT INTO public.inventory_producttransactiondetails VALUES (733, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 92);
INSERT INTO public.inventory_producttransactiondetails VALUES (734, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 92);
INSERT INTO public.inventory_producttransactiondetails VALUES (735, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 640, 93);
INSERT INTO public.inventory_producttransactiondetails VALUES (736, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 746, 93);
INSERT INTO public.inventory_producttransactiondetails VALUES (737, 0, 1, '', '1900-01-01', 0, '', 'No', 888, 93);
INSERT INTO public.inventory_producttransactiondetails VALUES (738, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 93);
INSERT INTO public.inventory_producttransactiondetails VALUES (739, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 93);
INSERT INTO public.inventory_producttransactiondetails VALUES (686, 1, 0, '', '2024-07-29', 1, 'New Mouse', 'No', 479, 85);
INSERT INTO public.inventory_producttransactiondetails VALUES (715, 1, 1, '', '2024-09-10', 1, '', 'No', 488, 90);
INSERT INTO public.inventory_producttransactiondetails VALUES (740, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 950, 93);
INSERT INTO public.inventory_producttransactiondetails VALUES (741, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 641, 94);
INSERT INTO public.inventory_producttransactiondetails VALUES (742, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 747, 94);
INSERT INTO public.inventory_producttransactiondetails VALUES (743, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 828, 94);
INSERT INTO public.inventory_producttransactiondetails VALUES (744, 0, 1, '', '1900-01-01', 0, '', 'No', 889, 94);
INSERT INTO public.inventory_producttransactiondetails VALUES (745, 0, 1, '', '1900-01-01', 0, '', 'No', 477, 94);
INSERT INTO public.inventory_producttransactiondetails VALUES (746, 0, 1, '', '1900-01-01', 0, '', 'No', 481, 94);
INSERT INTO public.inventory_producttransactiondetails VALUES (747, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 642, 95);
INSERT INTO public.inventory_producttransactiondetails VALUES (748, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 705, 95);
INSERT INTO public.inventory_producttransactiondetails VALUES (749, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 723, 95);
INSERT INTO public.inventory_producttransactiondetails VALUES (750, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 748, 95);
INSERT INTO public.inventory_producttransactiondetails VALUES (751, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 829, 95);
INSERT INTO public.inventory_producttransactiondetails VALUES (753, 0, 1, '', '1900-01-01', 0, '', 'No', 476, 95);
INSERT INTO public.inventory_producttransactiondetails VALUES (754, 0, 2, '', '1900-01-01', 0, '', 'No', 479, 95);
INSERT INTO public.inventory_producttransactiondetails VALUES (755, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 95);
INSERT INTO public.inventory_producttransactiondetails VALUES (756, 0, 1, 'With Power, HDMI Cable and Remote', '1900-01-01', 0, '', 'No', 965, 95);
INSERT INTO public.inventory_producttransactiondetails VALUES (757, 0, 1, 'With Power,USB Cable and Remote', '1900-01-01', 0, '', 'No', 951, 95);
INSERT INTO public.inventory_producttransactiondetails VALUES (758, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 643, 96);
INSERT INTO public.inventory_producttransactiondetails VALUES (759, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 706, 96);
INSERT INTO public.inventory_producttransactiondetails VALUES (760, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 724, 96);
INSERT INTO public.inventory_producttransactiondetails VALUES (761, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 749, 96);
INSERT INTO public.inventory_producttransactiondetails VALUES (762, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 830, 96);
INSERT INTO public.inventory_producttransactiondetails VALUES (763, 0, 1, '', '1900-01-01', 0, '', 'No', 891, 96);
INSERT INTO public.inventory_producttransactiondetails VALUES (764, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 96);
INSERT INTO public.inventory_producttransactiondetails VALUES (765, 0, 2, '', '1900-01-01', 0, '', 'No', 479, 96);
INSERT INTO public.inventory_producttransactiondetails VALUES (766, 0, 1, '', '1900-01-01', 0, '', 'No', 488, 96);
INSERT INTO public.inventory_producttransactiondetails VALUES (767, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 644, 97);
INSERT INTO public.inventory_producttransactiondetails VALUES (768, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 750, 97);
INSERT INTO public.inventory_producttransactiondetails VALUES (769, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 97);
INSERT INTO public.inventory_producttransactiondetails VALUES (770, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 97);
INSERT INTO public.inventory_producttransactiondetails VALUES (778, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 646, 99);
INSERT INTO public.inventory_producttransactiondetails VALUES (779, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 707, 99);
INSERT INTO public.inventory_producttransactiondetails VALUES (780, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 725, 99);
INSERT INTO public.inventory_producttransactiondetails VALUES (781, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 752, 99);
INSERT INTO public.inventory_producttransactiondetails VALUES (782, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 832, 99);
INSERT INTO public.inventory_producttransactiondetails VALUES (783, 0, 1, '', '1900-01-01', 0, '', 'No', 893, 99);
INSERT INTO public.inventory_producttransactiondetails VALUES (784, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 99);
INSERT INTO public.inventory_producttransactiondetails VALUES (785, 0, 1, '', '1900-01-01', 0, '', 'No', 481, 99);
INSERT INTO public.inventory_producttransactiondetails VALUES (786, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 99);
INSERT INTO public.inventory_producttransactiondetails VALUES (787, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 99);
INSERT INTO public.inventory_producttransactiondetails VALUES (788, 0, 1, 'With Power Adapter and Remote', '1900-01-01', 0, '', 'No', 966, 99);
INSERT INTO public.inventory_producttransactiondetails VALUES (789, 0, 1, 'With Power and USB Cable and Remote', '1900-01-01', 0, '', 'No', 952, 99);
INSERT INTO public.inventory_producttransactiondetails VALUES (790, 0, 1, 'With Power and VGA cable', '1900-01-01', 0, '', 'No', 647, 100);
INSERT INTO public.inventory_producttransactiondetails VALUES (791, 0, 1, 'With Power and VGA cable', '1900-01-01', 0, '', 'No', 708, 100);
INSERT INTO public.inventory_producttransactiondetails VALUES (792, 0, 1, 'With Power cable', '1900-01-01', 0, '', 'No', 753, 100);
INSERT INTO public.inventory_producttransactiondetails VALUES (793, 0, 1, 'With Power and USB cable', '1900-01-01', 0, '', 'No', 833, 100);
INSERT INTO public.inventory_producttransactiondetails VALUES (794, 0, 1, '', '1900-01-01', 0, '', 'No', 894, 100);
INSERT INTO public.inventory_producttransactiondetails VALUES (795, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 100);
INSERT INTO public.inventory_producttransactiondetails VALUES (796, 0, 1, '', '1900-01-01', 0, '', 'No', 475, 100);
INSERT INTO public.inventory_producttransactiondetails VALUES (797, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 100);
INSERT INTO public.inventory_producttransactiondetails VALUES (799, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 100);
INSERT INTO public.inventory_producttransactiondetails VALUES (800, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 709, 101);
INSERT INTO public.inventory_producttransactiondetails VALUES (801, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 754, 101);
INSERT INTO public.inventory_producttransactiondetails VALUES (802, 0, 1, '', '1900-01-01', 0, '', 'No', 895, 101);
INSERT INTO public.inventory_producttransactiondetails VALUES (803, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 101);
INSERT INTO public.inventory_producttransactiondetails VALUES (804, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 101);
INSERT INTO public.inventory_producttransactiondetails VALUES (805, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 200, 102);
INSERT INTO public.inventory_producttransactiondetails VALUES (808, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 102);
INSERT INTO public.inventory_producttransactiondetails VALUES (809, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 102);
INSERT INTO public.inventory_producttransactiondetails VALUES (810, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 649, 103);
INSERT INTO public.inventory_producttransactiondetails VALUES (811, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 710, 103);
INSERT INTO public.inventory_producttransactiondetails VALUES (812, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 726, 103);
INSERT INTO public.inventory_producttransactiondetails VALUES (813, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 756, 103);
INSERT INTO public.inventory_producttransactiondetails VALUES (814, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 835, 103);
INSERT INTO public.inventory_producttransactiondetails VALUES (815, 0, 1, '', '1900-01-01', 0, '', 'No', 896, 103);
INSERT INTO public.inventory_producttransactiondetails VALUES (816, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 103);
INSERT INTO public.inventory_producttransactiondetails VALUES (817, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 103);
INSERT INTO public.inventory_producttransactiondetails VALUES (818, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 103);
INSERT INTO public.inventory_producttransactiondetails VALUES (819, 0, 1, 'With Power,HDMI Cable and  Remote', '1900-01-01', 0, '', 'No', 967, 103);
INSERT INTO public.inventory_producttransactiondetails VALUES (820, 0, 1, 'With Power,USB Cable and  Remote', '1900-01-01', 0, '', 'No', 953, 103);
INSERT INTO public.inventory_producttransactiondetails VALUES (821, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 650, 104);
INSERT INTO public.inventory_producttransactiondetails VALUES (822, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 711, 104);
INSERT INTO public.inventory_producttransactiondetails VALUES (823, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 757, 104);
INSERT INTO public.inventory_producttransactiondetails VALUES (824, 0, 1, 'With Power and USB  Cable', '1900-01-01', 0, '', 'No', 836, 104);
INSERT INTO public.inventory_producttransactiondetails VALUES (825, 0, 1, '', '1900-01-01', 0, '', 'No', 897, 104);
INSERT INTO public.inventory_producttransactiondetails VALUES (826, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 104);
INSERT INTO public.inventory_producttransactiondetails VALUES (827, 0, 2, '', '1900-01-01', 0, '', 'No', 479, 104);
INSERT INTO public.inventory_producttransactiondetails VALUES (828, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 104);
INSERT INTO public.inventory_producttransactiondetails VALUES (829, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 651, 105);
INSERT INTO public.inventory_producttransactiondetails VALUES (830, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 758, 105);
INSERT INTO public.inventory_producttransactiondetails VALUES (831, 0, 1, 'With Power and USB  Cable', '1900-01-01', 0, '', 'No', 837, 105);
INSERT INTO public.inventory_producttransactiondetails VALUES (832, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 105);
INSERT INTO public.inventory_producttransactiondetails VALUES (833, 0, 1, '', '1900-01-01', 0, '', 'No', 485, 105);
INSERT INTO public.inventory_producttransactiondetails VALUES (834, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 652, 106);
INSERT INTO public.inventory_producttransactiondetails VALUES (835, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 712, 106);
INSERT INTO public.inventory_producttransactiondetails VALUES (836, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 727, 106);
INSERT INTO public.inventory_producttransactiondetails VALUES (837, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 759, 106);
INSERT INTO public.inventory_producttransactiondetails VALUES (838, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 838, 106);
INSERT INTO public.inventory_producttransactiondetails VALUES (806, 1, 1, 'With Power  Cable', '2024-08-03', 1, 'Motherboard Issue', 'No', 297, 102);
INSERT INTO public.inventory_producttransactiondetails VALUES (774, 1, 1, 'With Power and USB Cable', '2024-09-05', 1, 'Dead', 'No', 871, 98);
INSERT INTO public.inventory_producttransactiondetails VALUES (772, 0, 1, 'With Power  Cable', '1900-01-01', 0, ' ', 'No', 751, 98);
INSERT INTO public.inventory_producttransactiondetails VALUES (775, 0, 1, '', '1900-01-01', 0, ' ', 'No', 892, 98);
INSERT INTO public.inventory_producttransactiondetails VALUES (776, 0, 1, '', '1900-01-01', 0, ' ', 'No', 474, 98);
INSERT INTO public.inventory_producttransactiondetails VALUES (777, 0, 1, '', '1900-01-01', 0, ' ', 'No', 479, 98);
INSERT INTO public.inventory_producttransactiondetails VALUES (807, 1, 1, 'With Power and USB Cable', '2024-09-24', 1, 'Head Break', 'No', 347, 102);
INSERT INTO public.inventory_producttransactiondetails VALUES (771, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, ' ', 'No', 645, 98);
INSERT INTO public.inventory_producttransactiondetails VALUES (752, 1, 1, '', '2024-07-16', 1, 'Working', 'No', 890, 95);
INSERT INTO public.inventory_producttransactiondetails VALUES (841, 0, 1, '', '1900-01-01', 0, '', 'No', 483, 106);
INSERT INTO public.inventory_producttransactiondetails VALUES (842, 0, 1, '', '1900-01-01', 0, '', 'No', 488, 106);
INSERT INTO public.inventory_producttransactiondetails VALUES (843, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 106);
INSERT INTO public.inventory_producttransactiondetails VALUES (844, 0, 1, 'With Power,HDMI Cable and Remote', '1900-01-01', 0, '', 'No', 968, 106);
INSERT INTO public.inventory_producttransactiondetails VALUES (845, 0, 1, 'With Power,USB Cable and Remote', '1900-01-01', 0, '', 'No', 954, 106);
INSERT INTO public.inventory_producttransactiondetails VALUES (846, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 653, 107);
INSERT INTO public.inventory_producttransactiondetails VALUES (847, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 713, 107);
INSERT INTO public.inventory_producttransactiondetails VALUES (848, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 728, 107);
INSERT INTO public.inventory_producttransactiondetails VALUES (849, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 760, 107);
INSERT INTO public.inventory_producttransactiondetails VALUES (850, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 839, 107);
INSERT INTO public.inventory_producttransactiondetails VALUES (851, 0, 1, '', '1900-01-01', 0, '', 'No', 899, 107);
INSERT INTO public.inventory_producttransactiondetails VALUES (852, 0, 1, '', '1900-01-01', 0, '', 'No', 488, 107);
INSERT INTO public.inventory_producttransactiondetails VALUES (853, 0, 1, '', '1900-01-01', 0, '', 'No', 485, 107);
INSERT INTO public.inventory_producttransactiondetails VALUES (854, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 107);
INSERT INTO public.inventory_producttransactiondetails VALUES (855, 0, 1, 'With Power Adapter Keyboard and Mouse', '1900-01-01', 0, '', 'No', 617, 107);
INSERT INTO public.inventory_producttransactiondetails VALUES (856, 0, 1, 'With Power Adapter Keyboard and Mouse', '1900-01-01', 0, '', 'No', 42, 108);
INSERT INTO public.inventory_producttransactiondetails VALUES (857, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 840, 108);
INSERT INTO public.inventory_producttransactiondetails VALUES (858, 0, 1, '', '1900-01-01', 0, '', 'No', 900, 108);
INSERT INTO public.inventory_producttransactiondetails VALUES (859, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 654, 109);
INSERT INTO public.inventory_producttransactiondetails VALUES (860, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 761, 109);
INSERT INTO public.inventory_producttransactiondetails VALUES (861, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 841, 109);
INSERT INTO public.inventory_producttransactiondetails VALUES (862, 0, 1, '', '1900-01-01', 0, '', 'No', 901, 109);
INSERT INTO public.inventory_producttransactiondetails VALUES (864, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 109);
INSERT INTO public.inventory_producttransactiondetails VALUES (865, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 655, 110);
INSERT INTO public.inventory_producttransactiondetails VALUES (866, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 714, 110);
INSERT INTO public.inventory_producttransactiondetails VALUES (867, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 729, 110);
INSERT INTO public.inventory_producttransactiondetails VALUES (868, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 762, 110);
INSERT INTO public.inventory_producttransactiondetails VALUES (869, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 842, 110);
INSERT INTO public.inventory_producttransactiondetails VALUES (870, 0, 1, '', '1900-01-01', 0, '', 'No', 902, 110);
INSERT INTO public.inventory_producttransactiondetails VALUES (871, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 110);
INSERT INTO public.inventory_producttransactiondetails VALUES (872, 0, 1, '', '1900-01-01', 0, '', 'No', 477, 110);
INSERT INTO public.inventory_producttransactiondetails VALUES (873, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 110);
INSERT INTO public.inventory_producttransactiondetails VALUES (874, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 656, 111);
INSERT INTO public.inventory_producttransactiondetails VALUES (875, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 715, 111);
INSERT INTO public.inventory_producttransactiondetails VALUES (876, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 730, 111);
INSERT INTO public.inventory_producttransactiondetails VALUES (877, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 763, 111);
INSERT INTO public.inventory_producttransactiondetails VALUES (878, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 843, 111);
INSERT INTO public.inventory_producttransactiondetails VALUES (879, 0, 1, '', '1900-01-01', 0, '', 'No', 903, 111);
INSERT INTO public.inventory_producttransactiondetails VALUES (882, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 111);
INSERT INTO public.inventory_producttransactiondetails VALUES (883, 0, 1, 'With Power,HDMI cable and  Remote', '1900-01-01', 0, '', 'No', 969, 111);
INSERT INTO public.inventory_producttransactiondetails VALUES (884, 0, 1, 'With Power,USB Cable and  Remote', '1900-01-01', 0, '', 'No', 955, 111);
INSERT INTO public.inventory_producttransactiondetails VALUES (885, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 657, 112);
INSERT INTO public.inventory_producttransactiondetails VALUES (886, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 764, 112);
INSERT INTO public.inventory_producttransactiondetails VALUES (887, 0, 1, '', '1900-01-01', 0, '', 'No', 904, 112);
INSERT INTO public.inventory_producttransactiondetails VALUES (888, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 112);
INSERT INTO public.inventory_producttransactiondetails VALUES (889, 0, 1, '', '1900-01-01', 0, '', 'No', 482, 112);
INSERT INTO public.inventory_producttransactiondetails VALUES (890, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 658, 113);
INSERT INTO public.inventory_producttransactiondetails VALUES (891, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 765, 113);
INSERT INTO public.inventory_producttransactiondetails VALUES (892, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 844, 113);
INSERT INTO public.inventory_producttransactiondetails VALUES (893, 0, 1, '', '1900-01-01', 0, '', 'No', 905, 113);
INSERT INTO public.inventory_producttransactiondetails VALUES (894, 0, 1, '', '1900-01-01', 0, '', 'No', 488, 113);
INSERT INTO public.inventory_producttransactiondetails VALUES (895, 0, 1, '', '1900-01-01', 0, '', 'No', 485, 113);
INSERT INTO public.inventory_producttransactiondetails VALUES (896, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 659, 114);
INSERT INTO public.inventory_producttransactiondetails VALUES (898, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 845, 114);
INSERT INTO public.inventory_producttransactiondetails VALUES (899, 0, 1, '', '1900-01-01', 0, '', 'No', 906, 114);
INSERT INTO public.inventory_producttransactiondetails VALUES (900, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 114);
INSERT INTO public.inventory_producttransactiondetails VALUES (901, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 114);
INSERT INTO public.inventory_producttransactiondetails VALUES (902, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 660, 115);
INSERT INTO public.inventory_producttransactiondetails VALUES (903, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 767, 115);
INSERT INTO public.inventory_producttransactiondetails VALUES (904, 0, 1, '', '1900-01-01', 0, '', 'No', 907, 115);
INSERT INTO public.inventory_producttransactiondetails VALUES (905, 0, 1, '', '1900-01-01', 0, '', 'No', 487, 115);
INSERT INTO public.inventory_producttransactiondetails VALUES (906, 0, 1, '', '1900-01-01', 0, '', 'No', 482, 115);
INSERT INTO public.inventory_producttransactiondetails VALUES (907, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 661, 116);
INSERT INTO public.inventory_producttransactiondetails VALUES (908, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 768, 116);
INSERT INTO public.inventory_producttransactiondetails VALUES (909, 0, 1, 'With Power and USB  Cable', '1900-01-01', 0, '', 'No', 846, 116);
INSERT INTO public.inventory_producttransactiondetails VALUES (911, 0, 1, '', '1900-01-01', 0, '', 'No', 488, 116);
INSERT INTO public.inventory_producttransactiondetails VALUES (912, 0, 1, '', '1900-01-01', 0, '', 'No', 485, 116);
INSERT INTO public.inventory_producttransactiondetails VALUES (191, 1, 1, 'With Power and USB  Cable', '2024-06-24', 1, '', 'No', 363, 21);
INSERT INTO public.inventory_producttransactiondetails VALUES (913, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 976, 117);
INSERT INTO public.inventory_producttransactiondetails VALUES (914, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 662, 118);
INSERT INTO public.inventory_producttransactiondetails VALUES (915, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 769, 118);
INSERT INTO public.inventory_producttransactiondetails VALUES (917, 0, 1, '', '1900-01-01', 0, '', 'No', 909, 118);
INSERT INTO public.inventory_producttransactiondetails VALUES (918, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 118);
INSERT INTO public.inventory_producttransactiondetails VALUES (919, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 118);
INSERT INTO public.inventory_producttransactiondetails VALUES (920, 0, 1, 'Power and VGA Cable', '1900-01-01', 0, '', 'No', 663, 119);
INSERT INTO public.inventory_producttransactiondetails VALUES (921, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 770, 119);
INSERT INTO public.inventory_producttransactiondetails VALUES (922, 0, 1, '', '1900-01-01', 0, '', 'No', 910, 119);
INSERT INTO public.inventory_producttransactiondetails VALUES (924, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 119);
INSERT INTO public.inventory_producttransactiondetails VALUES (925, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 664, 120);
INSERT INTO public.inventory_producttransactiondetails VALUES (926, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 771, 120);
INSERT INTO public.inventory_producttransactiondetails VALUES (927, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 848, 120);
INSERT INTO public.inventory_producttransactiondetails VALUES (928, 0, 1, '', '1900-01-01', 0, '', 'No', 911, 120);
INSERT INTO public.inventory_producttransactiondetails VALUES (929, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 120);
INSERT INTO public.inventory_producttransactiondetails VALUES (930, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 120);
INSERT INTO public.inventory_producttransactiondetails VALUES (931, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 977, 120);
INSERT INTO public.inventory_producttransactiondetails VALUES (932, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 665, 121);
INSERT INTO public.inventory_producttransactiondetails VALUES (933, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 772, 121);
INSERT INTO public.inventory_producttransactiondetails VALUES (936, 0, 1, '', '1900-01-01', 0, '', 'No', 488, 121);
INSERT INTO public.inventory_producttransactiondetails VALUES (937, 0, 1, '', '1900-01-01', 0, '', 'No', 481, 121);
INSERT INTO public.inventory_producttransactiondetails VALUES (938, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 666, 122);
INSERT INTO public.inventory_producttransactiondetails VALUES (939, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 773, 122);
INSERT INTO public.inventory_producttransactiondetails VALUES (897, 1, 1, 'With Power  Cable', '2024-07-29', 1, 'Motherboard not working', 'No', 766, 114);
INSERT INTO public.inventory_producttransactiondetails VALUES (910, 1, 1, '', '2024-09-06', 1, 'Need To repair', 'No', 908, 116);
INSERT INTO public.inventory_producttransactiondetails VALUES (934, 1, 1, 'With Power and USB Cable', '2024-09-24', 1, 'Teflon, pressure roller  Problem', 'No', 849, 121);
INSERT INTO public.inventory_producttransactiondetails VALUES (880, 1, 1, '', '2024-09-30', 1, '', 'No', 476, 111);
INSERT INTO public.inventory_producttransactiondetails VALUES (923, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 119);
INSERT INTO public.inventory_producttransactiondetails VALUES (935, 0, 1, '', '1900-01-01', 0, '', 'No', 913, 121);
INSERT INTO public.inventory_producttransactiondetails VALUES (940, 0, 1, '', '1900-01-01', 0, '', 'No', 912, 122);
INSERT INTO public.inventory_producttransactiondetails VALUES (941, 0, 1, '', '1900-01-01', 0, '', 'No', 477, 122);
INSERT INTO public.inventory_producttransactiondetails VALUES (942, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 122);
INSERT INTO public.inventory_producttransactiondetails VALUES (943, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 667, 123);
INSERT INTO public.inventory_producttransactiondetails VALUES (944, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 716, 123);
INSERT INTO public.inventory_producttransactiondetails VALUES (945, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 774, 123);
INSERT INTO public.inventory_producttransactiondetails VALUES (946, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 850, 123);
INSERT INTO public.inventory_producttransactiondetails VALUES (948, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 123);
INSERT INTO public.inventory_producttransactiondetails VALUES (949, 0, 1, '', '1900-01-01', 0, '', 'No', 482, 123);
INSERT INTO public.inventory_producttransactiondetails VALUES (950, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 668, 124);
INSERT INTO public.inventory_producttransactiondetails VALUES (951, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 775, 124);
INSERT INTO public.inventory_producttransactiondetails VALUES (954, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 124);
INSERT INTO public.inventory_producttransactiondetails VALUES (955, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 124);
INSERT INTO public.inventory_producttransactiondetails VALUES (956, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 669, 125);
INSERT INTO public.inventory_producttransactiondetails VALUES (957, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 776, 125);
INSERT INTO public.inventory_producttransactiondetails VALUES (959, 0, 1, '', '1900-01-01', 0, '', 'No', 916, 125);
INSERT INTO public.inventory_producttransactiondetails VALUES (960, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 125);
INSERT INTO public.inventory_producttransactiondetails VALUES (961, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 125);
INSERT INTO public.inventory_producttransactiondetails VALUES (962, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 672, 126);
INSERT INTO public.inventory_producttransactiondetails VALUES (963, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 779, 126);
INSERT INTO public.inventory_producttransactiondetails VALUES (964, 0, 1, 'With Power and USB  Cable', '1900-01-01', 0, '', 'No', 854, 126);
INSERT INTO public.inventory_producttransactiondetails VALUES (965, 0, 1, '', '1900-01-01', 0, '', 'No', 919, 126);
INSERT INTO public.inventory_producttransactiondetails VALUES (966, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 126);
INSERT INTO public.inventory_producttransactiondetails VALUES (967, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 126);
INSERT INTO public.inventory_producttransactiondetails VALUES (968, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 671, 127);
INSERT INTO public.inventory_producttransactiondetails VALUES (969, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 778, 127);
INSERT INTO public.inventory_producttransactiondetails VALUES (970, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 853, 127);
INSERT INTO public.inventory_producttransactiondetails VALUES (971, 0, 1, '', '1900-01-01', 0, '', 'No', 918, 127);
INSERT INTO public.inventory_producttransactiondetails VALUES (972, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 127);
INSERT INTO public.inventory_producttransactiondetails VALUES (973, 0, 1, '', '1900-01-01', 0, '', 'No', 481, 127);
INSERT INTO public.inventory_producttransactiondetails VALUES (976, 0, 1, '', '1900-01-01', 0, '', 'No', 917, 128);
INSERT INTO public.inventory_producttransactiondetails VALUES (123, 1, 1, 'With Power and USB Cable', '2024-06-26', 1, '', 'No', 358, 12);
INSERT INTO public.inventory_producttransactiondetails VALUES (988, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 978, 129);
INSERT INTO public.inventory_producttransactiondetails VALUES (111, 1, 1, 'With Power and USB  Cable', '2024-06-27', 1, 'With Power and USB Cable', 'No', 353, 10);
INSERT INTO public.inventory_producttransactiondetails VALUES (989, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 675, 130);
INSERT INTO public.inventory_producttransactiondetails VALUES (990, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 782, 130);
INSERT INTO public.inventory_producttransactiondetails VALUES (991, 0, 1, '', '1900-01-01', 0, '', 'No', 922, 130);
INSERT INTO public.inventory_producttransactiondetails VALUES (992, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 130);
INSERT INTO public.inventory_producttransactiondetails VALUES (993, 0, 1, '', '1900-01-01', 0, '', 'No', 482, 130);
INSERT INTO public.inventory_producttransactiondetails VALUES (994, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 676, 131);
INSERT INTO public.inventory_producttransactiondetails VALUES (995, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 783, 131);
INSERT INTO public.inventory_producttransactiondetails VALUES (996, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 131);
INSERT INTO public.inventory_producttransactiondetails VALUES (997, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 131);
INSERT INTO public.inventory_producttransactiondetails VALUES (998, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 677, 132);
INSERT INTO public.inventory_producttransactiondetails VALUES (999, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 784, 132);
INSERT INTO public.inventory_producttransactiondetails VALUES (1000, 0, 1, '', '1900-01-01', 0, '', 'No', 924, 132);
INSERT INTO public.inventory_producttransactiondetails VALUES (1001, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 132);
INSERT INTO public.inventory_producttransactiondetails VALUES (1002, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 132);
INSERT INTO public.inventory_producttransactiondetails VALUES (1003, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 678, 133);
INSERT INTO public.inventory_producttransactiondetails VALUES (1004, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 785, 133);
INSERT INTO public.inventory_producttransactiondetails VALUES (1006, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 133);
INSERT INTO public.inventory_producttransactiondetails VALUES (1007, 0, 1, '', '1900-01-01', 0, '', 'No', 481, 133);
INSERT INTO public.inventory_producttransactiondetails VALUES (1008, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 679, 134);
INSERT INTO public.inventory_producttransactiondetails VALUES (1009, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 786, 134);
INSERT INTO public.inventory_producttransactiondetails VALUES (1010, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 856, 134);
INSERT INTO public.inventory_producttransactiondetails VALUES (1011, 0, 1, '', '1900-01-01', 0, '', 'No', 477, 134);
INSERT INTO public.inventory_producttransactiondetails VALUES (1012, 0, 1, '', '1900-01-01', 0, '', 'No', 482, 134);
INSERT INTO public.inventory_producttransactiondetails VALUES (1013, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 680, 135);
INSERT INTO public.inventory_producttransactiondetails VALUES (1014, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 787, 135);
INSERT INTO public.inventory_producttransactiondetails VALUES (1015, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 135);
INSERT INTO public.inventory_producttransactiondetails VALUES (1016, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 135);
INSERT INTO public.inventory_producttransactiondetails VALUES (180, 1, 1, 'With Power and USB Cable', '2024-06-28', 1, 'With Power and USB Cable', 'No', 361, 19);
INSERT INTO public.inventory_producttransactiondetails VALUES (1017, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 694, 136);
INSERT INTO public.inventory_producttransactiondetails VALUES (1018, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 801, 136);
INSERT INTO public.inventory_producttransactiondetails VALUES (1019, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 865, 136);
INSERT INTO public.inventory_producttransactiondetails VALUES (1020, 0, 1, '', '1900-01-01', 0, '', 'No', 938, 136);
INSERT INTO public.inventory_producttransactiondetails VALUES (1022, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 136);
INSERT INTO public.inventory_producttransactiondetails VALUES (1023, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 979, 136);
INSERT INTO public.inventory_producttransactiondetails VALUES (1024, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 695, 137);
INSERT INTO public.inventory_producttransactiondetails VALUES (1025, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 802, 137);
INSERT INTO public.inventory_producttransactiondetails VALUES (1027, 0, 1, '', '1900-01-01', 0, '', 'No', 939, 137);
INSERT INTO public.inventory_producttransactiondetails VALUES (1028, 0, 1, '', '1900-01-01', 0, '', 'No', 477, 137);
INSERT INTO public.inventory_producttransactiondetails VALUES (1029, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 137);
INSERT INTO public.inventory_producttransactiondetails VALUES (1030, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 696, 138);
INSERT INTO public.inventory_producttransactiondetails VALUES (1031, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 803, 138);
INSERT INTO public.inventory_producttransactiondetails VALUES (1032, 0, 1, 'With Power and USB  Cable', '1900-01-01', 0, '', 'No', 867, 138);
INSERT INTO public.inventory_producttransactiondetails VALUES (981, 1, 1, '', '2024-07-29', 1, 'Extra', 'No', 474, 128);
INSERT INTO public.inventory_producttransactiondetails VALUES (977, 1, 1, '', '2024-07-29', 1, 'Extra', 'No', 474, 128);
INSERT INTO public.inventory_producttransactiondetails VALUES (980, 1, 1, 'With Power  Cable (Extra)', '2024-07-29', 1, 'Extra', 'No', 780, 128);
INSERT INTO public.inventory_producttransactiondetails VALUES (982, 1, 1, '', '2024-07-29', 1, 'Extra', 'No', 479, 128);
INSERT INTO public.inventory_producttransactiondetails VALUES (1036, 1, 1, 'With Power Cable', '2024-08-27', 1, '', 'No', 804, 139);
INSERT INTO public.inventory_producttransactiondetails VALUES (1033, 1, 1, '', '2024-09-02', 1, '', 'No', 474, 138);
INSERT INTO public.inventory_producttransactiondetails VALUES (1035, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 697, 139);
INSERT INTO public.inventory_producttransactiondetails VALUES (1034, 1, 1, '', '2024-09-02', 1, '', 'No', 479, 138);
INSERT INTO public.inventory_producttransactiondetails VALUES (947, 1, 1, '', '2024-09-19', 1, 'Circuit Problem', 'No', 914, 123);
INSERT INTO public.inventory_producttransactiondetails VALUES (952, 0, 1, 'With Power and USB  Cable', '1900-01-01', 0, '', 'No', 851, 121);
INSERT INTO public.inventory_producttransactiondetails VALUES (958, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 852, 124);
INSERT INTO public.inventory_producttransactiondetails VALUES (953, 0, 1, '', '1900-01-01', 0, '', 'No', 915, 121);
INSERT INTO public.inventory_producttransactiondetails VALUES (984, 0, 1, 'With Power Cable (Used By Cofc)', '1900-01-01', 0, '', 'No', 781, 128);
INSERT INTO public.inventory_producttransactiondetails VALUES (983, 0, 1, 'With Power and VGA Cable (Used By Cofc)', '1900-01-01', 0, '', 'No', 674, 128);
INSERT INTO public.inventory_producttransactiondetails VALUES (985, 0, 1, 'Used By Cofc', '1900-01-01', 0, '', 'No', 921, 128);
INSERT INTO public.inventory_producttransactiondetails VALUES (986, 0, 1, 'Used By Cofc', '1900-01-01', 0, '', 'No', 488, 128);
INSERT INTO public.inventory_producttransactiondetails VALUES (987, 0, 1, 'Used By Cofc', '1900-01-01', 0, '', 'No', 485, 128);
INSERT INTO public.inventory_producttransactiondetails VALUES (978, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 207);
INSERT INTO public.inventory_producttransactiondetails VALUES (975, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 777, 207);
INSERT INTO public.inventory_producttransactiondetails VALUES (974, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 670, 207);
INSERT INTO public.inventory_producttransactiondetails VALUES (1005, 1, 1, 'With Power and USB  Cable', '2024-11-25', 1, 'Given to other employee', 'No', 855, 133);
INSERT INTO public.inventory_producttransactiondetails VALUES (1021, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 136);
INSERT INTO public.inventory_producttransactiondetails VALUES (1041, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 698, 140);
INSERT INTO public.inventory_producttransactiondetails VALUES (1042, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 805, 140);
INSERT INTO public.inventory_producttransactiondetails VALUES (1043, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 140);
INSERT INTO public.inventory_producttransactiondetails VALUES (1044, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 140);
INSERT INTO public.inventory_producttransactiondetails VALUES (1045, 0, 1, 'With Power  and VGA cable', '1900-01-01', 0, '', 'No', 699, 141);
INSERT INTO public.inventory_producttransactiondetails VALUES (1046, 0, 1, 'With Power cable', '1900-01-01', 0, '', 'No', 806, 141);
INSERT INTO public.inventory_producttransactiondetails VALUES (1047, 0, 1, 'With Power and UBS  cable', '1900-01-01', 0, '', 'No', 869, 141);
INSERT INTO public.inventory_producttransactiondetails VALUES (1049, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 141);
INSERT INTO public.inventory_producttransactiondetails VALUES (1050, 0, 1, '', '1900-01-01', 0, '', 'No', 481, 141);
INSERT INTO public.inventory_producttransactiondetails VALUES (475, 1, 1, 'With Power  Cable', '2024-06-29', 1, 'With Power Cable', 'No', 538, 60);
INSERT INTO public.inventory_producttransactiondetails VALUES (1051, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 980, 142);
INSERT INTO public.inventory_producttransactiondetails VALUES (1052, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 681, 143);
INSERT INTO public.inventory_producttransactiondetails VALUES (1054, 0, 1, '', '1900-01-01', 0, '', 'No', 926, 143);
INSERT INTO public.inventory_producttransactiondetails VALUES (1055, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 143);
INSERT INTO public.inventory_producttransactiondetails VALUES (1056, 0, 1, '', '1900-01-01', 0, '', 'No', 482, 143);
INSERT INTO public.inventory_producttransactiondetails VALUES (1057, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 682, 144);
INSERT INTO public.inventory_producttransactiondetails VALUES (1058, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 789, 144);
INSERT INTO public.inventory_producttransactiondetails VALUES (1060, 0, 1, '', '1900-01-01', 0, '', 'No', 488, 144);
INSERT INTO public.inventory_producttransactiondetails VALUES (1061, 0, 1, '', '1900-01-01', 0, '', 'No', 485, 144);
INSERT INTO public.inventory_producttransactiondetails VALUES (1062, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 683, 145);
INSERT INTO public.inventory_producttransactiondetails VALUES (1063, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 790, 145);
INSERT INTO public.inventory_producttransactiondetails VALUES (1064, 0, 1, '', '1900-01-01', 0, '', 'No', 927, 145);
INSERT INTO public.inventory_producttransactiondetails VALUES (1065, 0, 1, '', '1900-01-01', 0, '', 'No', 476, 145);
INSERT INTO public.inventory_producttransactiondetails VALUES (1066, 0, 1, '', '1900-01-01', 0, '', 'No', 485, 145);
INSERT INTO public.inventory_producttransactiondetails VALUES (1067, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 684, 146);
INSERT INTO public.inventory_producttransactiondetails VALUES (1069, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 146);
INSERT INTO public.inventory_producttransactiondetails VALUES (1070, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 146);
INSERT INTO public.inventory_producttransactiondetails VALUES (1071, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 685, 147);
INSERT INTO public.inventory_producttransactiondetails VALUES (1072, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 792, 147);
INSERT INTO public.inventory_producttransactiondetails VALUES (1073, 0, 1, '', '1900-01-01', 0, '', 'No', 928, 147);
INSERT INTO public.inventory_producttransactiondetails VALUES (1075, 0, 1, '', '1900-01-01', 0, '', 'No', 482, 147);
INSERT INTO public.inventory_producttransactiondetails VALUES (1076, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 686, 148);
INSERT INTO public.inventory_producttransactiondetails VALUES (1077, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 793, 148);
INSERT INTO public.inventory_producttransactiondetails VALUES (1078, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 858, 148);
INSERT INTO public.inventory_producttransactiondetails VALUES (1079, 0, 1, '', '1900-01-01', 0, '', 'No', 929, 148);
INSERT INTO public.inventory_producttransactiondetails VALUES (1080, 0, 1, '', '1900-01-01', 0, '', 'No', 476, 148);
INSERT INTO public.inventory_producttransactiondetails VALUES (1081, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 148);
INSERT INTO public.inventory_producttransactiondetails VALUES (1083, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 795, 149);
INSERT INTO public.inventory_producttransactiondetails VALUES (1084, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 860, 149);
INSERT INTO public.inventory_producttransactiondetails VALUES (1085, 0, 1, '', '1900-01-01', 0, '', 'No', 932, 149);
INSERT INTO public.inventory_producttransactiondetails VALUES (1086, 0, 1, '', '1900-01-01', 0, '', 'No', 488, 149);
INSERT INTO public.inventory_producttransactiondetails VALUES (1087, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 149);
INSERT INTO public.inventory_producttransactiondetails VALUES (1089, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 796, 150);
INSERT INTO public.inventory_producttransactiondetails VALUES (1091, 0, 1, '', '1900-01-01', 0, '', 'No', 933, 150);
INSERT INTO public.inventory_producttransactiondetails VALUES (1092, 0, 1, '', '1900-01-01', 0, '', 'No', 488, 150);
INSERT INTO public.inventory_producttransactiondetails VALUES (1093, 0, 1, '', '1900-01-01', 0, '', 'No', 481, 150);
INSERT INTO public.inventory_producttransactiondetails VALUES (1095, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 797, 151);
INSERT INTO public.inventory_producttransactiondetails VALUES (1096, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 862, 151);
INSERT INTO public.inventory_producttransactiondetails VALUES (1097, 0, 1, '', '1900-01-01', 0, '', 'No', 934, 151);
INSERT INTO public.inventory_producttransactiondetails VALUES (1098, 0, 1, '', '1900-01-01', 0, '', 'No', 488, 151);
INSERT INTO public.inventory_producttransactiondetails VALUES (1099, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 151);
INSERT INTO public.inventory_producttransactiondetails VALUES (1101, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 691, 153);
INSERT INTO public.inventory_producttransactiondetails VALUES (1102, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 798, 153);
INSERT INTO public.inventory_producttransactiondetails VALUES (1103, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 864, 153);
INSERT INTO public.inventory_producttransactiondetails VALUES (1104, 0, 1, '', '1900-01-01', 0, '', 'No', 935, 153);
INSERT INTO public.inventory_producttransactiondetails VALUES (1106, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 153);
INSERT INTO public.inventory_producttransactiondetails VALUES (1108, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 692, 154);
INSERT INTO public.inventory_producttransactiondetails VALUES (1109, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 799, 154);
INSERT INTO public.inventory_producttransactiondetails VALUES (1110, 0, 1, '', '1900-01-01', 0, '', 'No', 936, 154);
INSERT INTO public.inventory_producttransactiondetails VALUES (1111, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 154);
INSERT INTO public.inventory_producttransactiondetails VALUES (1112, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 154);
INSERT INTO public.inventory_producttransactiondetails VALUES (1113, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 154);
INSERT INTO public.inventory_producttransactiondetails VALUES (1114, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 693, 155);
INSERT INTO public.inventory_producttransactiondetails VALUES (1115, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 717, 155);
INSERT INTO public.inventory_producttransactiondetails VALUES (1116, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 800, 155);
INSERT INTO public.inventory_producttransactiondetails VALUES (1117, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 982, 155);
INSERT INTO public.inventory_producttransactiondetails VALUES (1118, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 870, 155);
INSERT INTO public.inventory_producttransactiondetails VALUES (1119, 0, 1, '', '1900-01-01', 0, '', 'No', 925, 155);
INSERT INTO public.inventory_producttransactiondetails VALUES (1120, 0, 1, '', '1900-01-01', 0, '', 'No', 488, 155);
INSERT INTO public.inventory_producttransactiondetails VALUES (1121, 0, 1, '', '1900-01-01', 0, '', 'No', 475, 155);
INSERT INTO public.inventory_producttransactiondetails VALUES (1122, 0, 2, '', '1900-01-01', 0, '', 'No', 479, 155);
INSERT INTO public.inventory_producttransactiondetails VALUES (1123, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 483, 155);
INSERT INTO public.inventory_producttransactiondetails VALUES (1074, 1, 1, '', '2024-07-11', 1, 'Key zam', 'No', 474, 147);
INSERT INTO public.inventory_producttransactiondetails VALUES (1124, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 156);
INSERT INTO public.inventory_producttransactiondetails VALUES (1053, 1, 1, 'With Power Cable', '2024-08-03', 1, 'Motherboard Issue', 'No', 788, 143);
INSERT INTO public.inventory_producttransactiondetails VALUES (1125, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 983, 157);
INSERT INTO public.inventory_producttransactiondetails VALUES (1127, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 985, 159);
INSERT INTO public.inventory_producttransactiondetails VALUES (1128, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 986, 160);
INSERT INTO public.inventory_producttransactiondetails VALUES (1129, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 348, 161);
INSERT INTO public.inventory_producttransactiondetails VALUES (881, 1, 1, '', '2024-07-11', 1, 'Not Working', 'No', 479, 111);
INSERT INTO public.inventory_producttransactiondetails VALUES (1131, 0, 1, 'Issued for Replacement', '2024-07-29', 0, '', 'No', 987, 163);
INSERT INTO public.inventory_producttransactiondetails VALUES (332, 1, 0, 'With power cable', '2024-07-29', 1, '1N12060207 is given in alternative', 'No', 334, 42);
INSERT INTO public.inventory_producttransactiondetails VALUES (1132, 0, 1, 'Issued for Replacement', '2024-07-29', 0, '', 'No', 481, 164);
INSERT INTO public.inventory_producttransactiondetails VALUES (1133, 0, 1, 'Issued for Replacement', '2024-07-29', 0, '', 'No', 481, 165);
INSERT INTO public.inventory_producttransactiondetails VALUES (798, 1, 0, '', '2024-07-29', 1, 'New Mouse Given', 'No', 481, 100);
INSERT INTO public.inventory_producttransactiondetails VALUES (1134, 0, 1, 'Issued for Replacement', '2024-07-29', 0, '', 'No', 988, 166);
INSERT INTO public.inventory_producttransactiondetails VALUES (1059, 1, 0, 'With Power and USB Cable', '2024-07-29', 1, 'Blank Print', 'No', 857, 144);
INSERT INTO public.inventory_producttransactiondetails VALUES (979, 1, 1, 'With Power and VGA Cable (Extra)', '2024-07-29', 1, 'Extra', 'No', 673, 128);
INSERT INTO public.inventory_producttransactiondetails VALUES (1135, 0, 1, 'With Power and VGA Cable ', '1900-01-01', 0, '', 'No', 673, 167);
INSERT INTO public.inventory_producttransactiondetails VALUES (1068, 1, 1, 'With Power Cable', '2024-09-13', 1, 'Motherboard issue', 'No', 791, 146);
INSERT INTO public.inventory_producttransactiondetails VALUES (1040, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 139);
INSERT INTO public.inventory_producttransactiondetails VALUES (1130, 1, 1, '', '2024-09-30', 1, '', 'No', 480, 162);
INSERT INTO public.inventory_producttransactiondetails VALUES (1126, 1, 1, '', '2024-10-08', 1, '', 'No', 481, 158);
INSERT INTO public.inventory_producttransactiondetails VALUES (1088, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 690, 150);
INSERT INTO public.inventory_producttransactiondetails VALUES (1094, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 689, 151);
INSERT INTO public.inventory_producttransactiondetails VALUES (1048, 1, 1, '', '2024-12-07', 1, 'Logic Card Issue', 'No', 941, 141);
INSERT INTO public.inventory_producttransactiondetails VALUES (1100, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 863, 150);
INSERT INTO public.inventory_producttransactiondetails VALUES (1105, 1, 0, '', '2024-12-03', 1, 'Hardness in  Keyboard ', 'No', 475, 153);
INSERT INTO public.inventory_producttransactiondetails VALUES (1107, 0, 1, 'With Power Adapter', '1900-01-01', 0, '', 'No', 1038, 153);
INSERT INTO public.inventory_producttransactiondetails VALUES (1136, 0, 1, 'With Power  Cable ', '1900-01-01', 0, '', 'No', 780, 167);
INSERT INTO public.inventory_producttransactiondetails VALUES (1137, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 167);
INSERT INTO public.inventory_producttransactiondetails VALUES (1138, 0, 1, '', '1900-01-01', 0, '', 'No', 478, 167);
INSERT INTO public.inventory_producttransactiondetails VALUES (1026, 1, 1, 'With Power and USB  Cable', '2024-08-01', 1, 'Fuser Error', 'No', 866, 137);
INSERT INTO public.inventory_producttransactiondetails VALUES (1140, 1, 1, 'With Power and VGA Cable', '2024-08-01', 1, 'VGA Port Not Working', 'No', 990, 168);
INSERT INTO public.inventory_producttransactiondetails VALUES (319, 1, 1, 'With Power and VGA Cable', '2024-08-02', 1, 'Replaced with New system', 'No', 235, 39);
INSERT INTO public.inventory_producttransactiondetails VALUES (1145, 0, 1, 'INA609YVW1 Harddisk changed to new', '1900-01-01', 0, '', 'No', 333, 170);
INSERT INTO public.inventory_producttransactiondetails VALUES (1146, 0, 1, '', '1900-01-01', 0, '', 'No', 331, 171);
INSERT INTO public.inventory_producttransactiondetails VALUES (1147, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 996, 174);
INSERT INTO public.inventory_producttransactiondetails VALUES (616, 1, 1, 'With Power and USB Cable', '2024-08-08', 1, 'Teflon Damaged', 'No', 812, 76);
INSERT INTO public.inventory_producttransactiondetails VALUES (863, 1, 1, '', '2024-08-13', 1, 'Button Not working', 'No', 488, 109);
INSERT INTO public.inventory_producttransactiondetails VALUES (1149, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 176);
INSERT INTO public.inventory_producttransactiondetails VALUES (1150, 0, 1, 'Issued for Replacement', '2024-08-13', 0, '', 'No', 1000, 177);
INSERT INTO public.inventory_producttransactiondetails VALUES (516, 1, 0, 'With Power and VGA Cable', '2024-08-13', 1, 'Power Issue', 'No', 502, 65);
INSERT INTO public.inventory_producttransactiondetails VALUES (1151, 0, 1, '', '1900-01-01', 0, '', 'No', 1001, 178);
INSERT INTO public.inventory_producttransactiondetails VALUES (326, 1, 1, 'With Power Cable', '2024-09-09', 1, 'Charge Change', 'No', 332, 40);
INSERT INTO public.inventory_producttransactiondetails VALUES (1152, 0, 1, '', '1900-01-01', 0, '', 'No', 236, 179);
INSERT INTO public.inventory_producttransactiondetails VALUES (1153, 0, 1, '', '1900-01-01', 0, '', 'No', 332, 179);
INSERT INTO public.inventory_producttransactiondetails VALUES (1154, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 179);
INSERT INTO public.inventory_producttransactiondetails VALUES (1155, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 179);
INSERT INTO public.inventory_producttransactiondetails VALUES (1156, 0, 1, '', '1900-01-01', 0, '', 'No', 473, 180);
INSERT INTO public.inventory_producttransactiondetails VALUES (1157, 0, 1, '', '1900-01-01', 0, '', 'No', 481, 180);
INSERT INTO public.inventory_producttransactiondetails VALUES (1158, 0, 1, '', '1900-01-01', 0, '', 'No', 235, 181);
INSERT INTO public.inventory_producttransactiondetails VALUES (1159, 0, 1, '', '1900-01-01', 0, '', 'No', 1003, 182);
INSERT INTO public.inventory_producttransactiondetails VALUES (1160, 0, 1, '', '1900-01-01', 0, '', 'No', 1004, 183);
INSERT INTO public.inventory_producttransactiondetails VALUES (1037, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 868, 139);
INSERT INTO public.inventory_producttransactiondetails VALUES (1038, 0, 1, '', '1900-01-01', 0, '', 'No', 940, 139);
INSERT INTO public.inventory_producttransactiondetails VALUES (1039, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 139);
INSERT INTO public.inventory_producttransactiondetails VALUES (1161, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 184);
INSERT INTO public.inventory_producttransactiondetails VALUES (419, 1, 1, 'With power  cable', '2024-08-27', 1, '', 'No', 319, 52);
INSERT INTO public.inventory_producttransactiondetails VALUES (1162, 0, 1, '', '1900-01-01', 0, '', 'No', 1005, 185);
INSERT INTO public.inventory_producttransactiondetails VALUES (1163, 0, 1, '', '1900-01-01', 0, '', 'No', 319, 186);
INSERT INTO public.inventory_producttransactiondetails VALUES (1164, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 1006, 187);
INSERT INTO public.inventory_producttransactiondetails VALUES (1165, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 1007, 188);
INSERT INTO public.inventory_producttransactiondetails VALUES (1166, 0, 1, '', '1900-01-01', 0, '', 'No', 1008, 189);
INSERT INTO public.inventory_producttransactiondetails VALUES (1167, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 190);
INSERT INTO public.inventory_producttransactiondetails VALUES (1168, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 190);
INSERT INTO public.inventory_producttransactiondetails VALUES (1169, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 191);
INSERT INTO public.inventory_producttransactiondetails VALUES (1170, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 1009, 192);
INSERT INTO public.inventory_producttransactiondetails VALUES (1171, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 1010, 192);
INSERT INTO public.inventory_producttransactiondetails VALUES (1172, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 1011, 192);
INSERT INTO public.inventory_producttransactiondetails VALUES (1173, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 1012, 192);
INSERT INTO public.inventory_producttransactiondetails VALUES (1174, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 1013, 192);
INSERT INTO public.inventory_producttransactiondetails VALUES (1175, 0, 1, '', '1900-01-01', 0, '', 'No', 1014, 192);
INSERT INTO public.inventory_producttransactiondetails VALUES (1176, 0, 1, '', '1900-01-01', 0, '', 'No', 1015, 192);
INSERT INTO public.inventory_producttransactiondetails VALUES (1177, 0, 2, '', '1900-01-01', 0, '', 'No', 474, 192);
INSERT INTO public.inventory_producttransactiondetails VALUES (1178, 0, 1, '', '1900-01-01', 0, '', 'No', 482, 192);
INSERT INTO public.inventory_producttransactiondetails VALUES (1179, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 192);
INSERT INTO public.inventory_producttransactiondetails VALUES (1144, 1, 1, '', '2024-09-06', 1, 'Network Port Not Working', 'No', 538, 169);
INSERT INTO public.inventory_producttransactiondetails VALUES (1141, 1, 1, '', '2024-09-06', 1, '', 'No', 991, 168);
INSERT INTO public.inventory_producttransactiondetails VALUES (1180, 0, 1, '', '1900-01-01', 0, '', 'No', 991, 193);
INSERT INTO public.inventory_producttransactiondetails VALUES (1139, 1, 1, 'With Power Cable', '2024-09-06', 1, 'Working', 'No', 989, 168);
INSERT INTO public.inventory_producttransactiondetails VALUES (1181, 0, 1, '', '1900-01-01', 0, '', 'No', 989, 194);
INSERT INTO public.inventory_producttransactiondetails VALUES (1142, 1, 1, '', '2024-09-06', 1, '', 'No', 474, 168);
INSERT INTO public.inventory_producttransactiondetails VALUES (1143, 1, 1, '', '2024-09-06', 1, '', 'No', 479, 168);
INSERT INTO public.inventory_producttransactiondetails VALUES (652, 1, 1, 'With Power and VGA Cable', '2024-11-25', 1, 'Extra', 'No', 972, 81);
INSERT INTO public.inventory_producttransactiondetails VALUES (773, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, ' ', 'No', 831, 98);
INSERT INTO public.inventory_producttransactiondetails VALUES (1182, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 162, 195);
INSERT INTO public.inventory_producttransactiondetails VALUES (1183, 0, 1, '', '1900-01-01', 0, '', 'No', 1016, 196);
INSERT INTO public.inventory_producttransactiondetails VALUES (1185, 0, 1, 'With Power and USB cable', '1900-01-01', 0, '', 'No', 564, 198);
INSERT INTO public.inventory_producttransactiondetails VALUES (307, 1, 1, 'IN CHAMBER', '2024-08-01', 1, 'Extra', 'No', 488, 37);
INSERT INTO public.inventory_producttransactiondetails VALUES (1186, 0, 1, '', '1900-01-01', 0, '', 'No', 488, 199);
INSERT INTO public.inventory_producttransactiondetails VALUES (1187, 0, 1, '', '1900-01-01', 0, '', 'No', 485, 199);
INSERT INTO public.inventory_producttransactiondetails VALUES (353, 1, 1, 'With Power and USB Cable', '2024-10-03', 1, 'Board Problem', 'No', 386, 45);
INSERT INTO public.inventory_producttransactiondetails VALUES (1188, 0, 1, '', '1900-01-01', 0, '', 'No', 859, 200);
INSERT INTO public.inventory_producttransactiondetails VALUES (1082, 1, 1, 'With Power and VGA Cable', '2024-10-03', 1, 'Screen Damaged', 'No', 688, 149);
INSERT INTO public.inventory_producttransactiondetails VALUES (1189, 0, 1, '', '1900-01-01', 0, '', 'No', 1020, 201);
INSERT INTO public.inventory_producttransactiondetails VALUES (1190, 0, 1, '', '1900-01-01', 0, '', 'No', 791, 202);
INSERT INTO public.inventory_producttransactiondetails VALUES (1191, 0, 1, '', '1900-01-01', 0, '', 'No', 485, 203);
INSERT INTO public.inventory_producttransactiondetails VALUES (1192, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 1002, 204);
INSERT INTO public.inventory_producttransactiondetails VALUES (1193, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 237, 204);
INSERT INTO public.inventory_producttransactiondetails VALUES (1194, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 993, 205);
INSERT INTO public.inventory_producttransactiondetails VALUES (916, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 847, 119);
INSERT INTO public.inventory_producttransactiondetails VALUES (1195, 0, 1, '', '1900-01-01', 0, '', 'No', 1021, 206);
INSERT INTO public.inventory_producttransactiondetails VALUES (1196, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 207);
INSERT INTO public.inventory_producttransactiondetails VALUES (1184, 0, 1, '', '1900-01-01', 0, '', 'No', 1019, 207);
INSERT INTO public.inventory_producttransactiondetails VALUES (1197, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 1022, 208);
INSERT INTO public.inventory_producttransactiondetails VALUES (1198, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 1023, 208);
INSERT INTO public.inventory_producttransactiondetails VALUES (1199, 0, 1, '', '1900-01-01', 0, '', 'No', 890, 208);
INSERT INTO public.inventory_producttransactiondetails VALUES (1200, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 208);
INSERT INTO public.inventory_producttransactiondetails VALUES (1201, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 208);
INSERT INTO public.inventory_producttransactiondetails VALUES (1202, 0, 1, 'With Power Cable', '1900-01-01', 0, '', 'No', 552, 209);
INSERT INTO public.inventory_producttransactiondetails VALUES (1203, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 972, 209);
INSERT INTO public.inventory_producttransactiondetails VALUES (1204, 0, 1, 'With Power and USB Cable', '1900-01-01', 0, '', 'No', 855, 209);
INSERT INTO public.inventory_producttransactiondetails VALUES (1205, 0, 1, 'With Power adapter', '1900-01-01', 0, '', 'No', 1024, 209);
INSERT INTO public.inventory_producttransactiondetails VALUES (1206, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 209);
INSERT INTO public.inventory_producttransactiondetails VALUES (1207, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 209);
INSERT INTO public.inventory_producttransactiondetails VALUES (1208, 0, 1, '', '1900-01-01', 0, '', 'No', 1025, 209);
INSERT INTO public.inventory_producttransactiondetails VALUES (1209, 0, 1, '', '1900-01-01', 0, '', 'No', 1027, 210);
INSERT INTO public.inventory_producttransactiondetails VALUES (1210, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 1029, 211);
INSERT INTO public.inventory_producttransactiondetails VALUES (1211, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 1032, 211);
INSERT INTO public.inventory_producttransactiondetails VALUES (1212, 0, 1, 'With Power and USB  Cable', '1900-01-01', 0, '', 'No', 1033, 211);
INSERT INTO public.inventory_producttransactiondetails VALUES (1213, 0, 1, '', '1900-01-01', 0, '', 'No', 1034, 211);
INSERT INTO public.inventory_producttransactiondetails VALUES (1214, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 211);
INSERT INTO public.inventory_producttransactiondetails VALUES (1215, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 211);
INSERT INTO public.inventory_producttransactiondetails VALUES (1216, 0, 1, 'With Power and VGA Cable', '1900-01-01', 0, '', 'No', 1028, 212);
INSERT INTO public.inventory_producttransactiondetails VALUES (1217, 0, 1, 'With Power  Cable', '1900-01-01', 0, '', 'No', 1030, 212);
INSERT INTO public.inventory_producttransactiondetails VALUES (1218, 0, 1, '', '1900-01-01', 0, '', 'No', 474, 212);
INSERT INTO public.inventory_producttransactiondetails VALUES (1219, 0, 1, '', '1900-01-01', 0, '', 'No', 479, 212);
INSERT INTO public.inventory_producttransactiondetails VALUES (1220, 0, 1, '', '1900-01-01', 0, '', 'No', 941, 213);
INSERT INTO public.inventory_producttransactiondetails VALUES (1148, 1, 1, '', '2024-11-18', 1, 'Paper Pickup Problem', 'No', 998, 175);
INSERT INTO public.inventory_producttransactiondetails VALUES (1221, 0, 1, '', '1900-01-01', 0, '', 'No', 351, 214);
INSERT INTO public.inventory_producttransactiondetails VALUES (1222, 0, 1, 'Issued for Replacement', '2024-12-03', 0, '', 'No', 1037, 215);
INSERT INTO public.inventory_producttransactiondetails VALUES (1223, 0, 1, 'With power adpater', '1900-01-01', 0, '', 'No', 1039, 216);
INSERT INTO public.inventory_producttransactiondetails VALUES (1224, 0, 1, '', '1900-01-01', 0, '', 'No', 1040, 217);


--
-- Data for Name: inventory_purchasedetails; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.inventory_purchasedetails VALUES (1, '1900-01-01', '0000', 'DUMMY', 'DUMMY', 'DUMMY', 'DUMMY');
INSERT INTO public.inventory_purchasedetails VALUES (2, '2024-04-23', 'HCD2401', 'High Court Bilaspur', 'District Court Durg', '', 'all in one_new.pdf');
INSERT INTO public.inventory_purchasedetails VALUES (3, '2024-04-23', 'HCP2401', 'High Court Bilaspur', 'District Court Durg - POCSO COURT', '', 'Dell Pocso_merged_new.pdf');


--
-- Data for Name: inventory_secdesview; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: inventory_sectiondesignationmapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.inventory_sectiondesignationmapper VALUES (1, 1, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (2, 2, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (3, 3, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (4, 4, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (5, 5, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (6, 6, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (7, 7, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (8, 8, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (9, 9, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (10, 10, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (11, 11, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (12, 12, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (13, 13, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (14, 14, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (15, 15, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (16, 16, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (17, 17, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (18, 18, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (19, 19, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (20, 20, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (21, 21, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (22, 22, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (23, 23, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (24, 24, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (25, 25, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (27, 27, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (28, 28, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (29, 29, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (30, 30, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (31, 31, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (32, 32, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (33, 33, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (34, 34, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (35, 35, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (36, 36, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (37, 37, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (38, 38, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (39, 39, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (40, 40, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (41, 41, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (42, 42, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (43, 43, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (44, 44, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (45, 45, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (46, 46, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (47, 47, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (48, 48, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (50, 50, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (51, 51, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (52, 52, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (53, 53, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (54, 54, 37, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (123, 14, 8, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (124, 12, 1, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (125, 12, 4, '10.131.212.91');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (126, 12, 8, '10.132.212.93');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (62, 3, 1, '10.132.212.41');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (64, 3, 5, '10.132.212.42');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (65, 3, 2, '10.132.212.43');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (66, 3, 7, '10.132.212.43');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (67, 3, 8, '10.132.212.43');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (63, 3, 4, '10.132.212.151');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (58, 17, 8, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (60, 24, 1, '10.132.212.183');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (61, 24, 8, '172.17.136.231');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (68, 16, 1, '10.132.212.188');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (69, 16, 4, '10.132.212.188');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (71, 9, 1, '10.132.212.77');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (72, 9, 4, '10.132.212.78');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (73, 9, 2, '10.132.212.63');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (74, 9, 7, '172.17.136.78');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (75, 9, 8, '10.132.212.245');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (76, 20, 1, '10.132.212.60');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (77, 20, 2, '10.132.212.155');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (78, 20, 4, '10.132.212.159');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (79, 19, 1, '10.132.212.181');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (80, 19, 4, '10.132.212.183');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (81, 19, 8, '172.17.136.183');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (82, 21, 1, '10.132.212.159');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (83, 21, 4, '10.132.212.160');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (84, 21, 7, '10.132.212.120');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (85, 4, 1, '10.132.212.74');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (86, 4, 4, '10.132.212.144');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (87, 4, 5, '10.132.212.119');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (88, 4, 8, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (89, 8, 1, '10.132.212.58');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (90, 8, 4, '10.132.212.57');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (91, 8, 8, '172.17.136.59');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (92, 8, 7, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (93, 11, 1, '172.17.136.69');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (94, 11, 4, '10.132.212.70 ');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (95, 11, 7, '10.132.212.71');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (96, 11, 8, '10.132.212.70');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (97, 30, 1, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (98, 30, 4, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (99, 30, 8, '10.132.212.205');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (100, 28, 7, '10.132.212.192');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (101, 28, 8, '10.132.212.192');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (102, 28, 4, '10.132.212.153');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (103, 28, 1, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (104, 31, 1, '10.132.212.208');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (105, 31, 4, '172.17.136.214');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (57, 17, 1, '172.17.136.232');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (59, 17, 4, '10.132.212.146');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (70, 16, 7, '10.132.212.65');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (106, 32, 38, '10.132.212.213');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (107, 32, 1, '10.132.212.212');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (108, 32, 8, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (109, 32, 7, '10.132.212.212');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (110, 32, 4, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (111, 29, 1, '10.132.212.139');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (112, 29, 2, '10.132.212.141');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (113, 29, 4, '10.132.212.141');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (114, 29, 7, '10.132.212.155');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (115, 7, 1, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (116, 7, 4, '10.132.212.55');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (117, 7, 5, '172.17.136.54');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (118, 7, 7, '10.132.212.56');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (119, 7, 8, '10.132.212.54');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (120, 14, 1, '10.132.212.125');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (121, 14, 4, '10.132.212.124');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (122, 14, 2, '10.132.212.124');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (127, 13, 1, '10.132.212.98');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (128, 13, 4, '10.132.212.95');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (129, 13, 5, '10.132.212.98');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (130, 13, 2, '10.132.212.97');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (131, 13, 7, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (132, 8, 2, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (135, 1, 2, '10.132.212.49');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (133, 1, 4, '10.132.212.52');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (134, 1, 5, '10.132.212.66');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (137, 1, 7, '10.132.212.228');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (136, 1, 8, '10.132.212.30');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (138, 1, 1, '10.132.212.52');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (139, 1, 6, '10.132.212.32');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (140, 27, 1, '10.132.212.186');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (141, 27, 4, '10.132.212.185');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (142, 27, 7, '10.132.212.187');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (143, 27, 2, '10.132.212.188');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (144, 27, 8, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (145, 18, 1, '10.132.212.165');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (146, 18, 4, '10.132.212.150');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (148, 18, 2, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (147, 18, 8, '10.132.212.152');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (149, 33, 1, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (150, 33, 4, '172.17.136.143');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (151, 33, 7, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (152, 33, 8, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (153, 23, 1, '10.132.212.169');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (154, 23, 4, '10.132.212.169');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (155, 23, 8, '10.132.212.170');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (156, 6, 1, '10.132.212.38');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (157, 6, 4, '172.17.136.139');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (158, 6, 7, '10.132.212.39');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (159, 6, 8, '10.132.212.63');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (160, 22, 4, '10.132.212.164');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (161, 22, 1, '10.132.212.163');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (162, 22, 5, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (163, 22, 7, '10.132.212.164');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (164, 47, 12, '10.132.212.252');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (165, 47, 12, '10.212.132.212');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (166, 47, 11, '10.132.212.121');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (167, 34, 12, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (168, 34, 12, '172.17.136.219');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (169, 34, 12, '10.132.212.233');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (170, 34, 12, '10.132.212.232');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (171, 34, 12, '10.132.212.197');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (172, 34, 12, '10.132.212.222');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (173, 34, 11, '172.17.136.178');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (174, 34, 11, '10.132.212.237');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (175, 34, 10, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (176, 34, 39, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (177, 34, 11, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (189, 41, 12, '10.132.212.224 | 172.17.136.223');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (188, 41, 12, '172.17.136.177');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (187, 41, 12, '10.132.212.223');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (186, 41, 12, '10.132.212.218');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (185, 41, 12, '10.132.212.219');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (184, 41, 12, '10.132.212.222');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (196, 35, 12, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (197, 35, 12, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (198, 35, 11, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (199, 39, 12, '10.132.212.253');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (200, 39, 12, '10.132.212.253');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (201, 38, 28, '10.132.212.90');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (202, 47, 12, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (203, 47, 12, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (204, 11, 2, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (205, 25, 8, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (206, 34, 12, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (207, 34, 12, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (182, 37, 11, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (181, 37, 11, '10.132.212.192');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (179, 37, 12, '172.17.136.245');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (180, 37, 12, '172.17.136.202');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (183, 37, 12, '10.132.212.233');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (178, 37, 12, '172.17.136.201');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (208, 37, 12, '172.17.136.245');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (191, 36, 9, '10.132.212.152');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (190, 36, 12, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (209, 42, 11, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (210, 42, 12, '');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (195, 43, 11, '10.132.212.24');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (192, 43, 11, '10.132.212.242 | 172.17.136.242');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (194, 43, 12, '10.132.212.207');
INSERT INTO public.inventory_sectiondesignationmapper VALUES (193, 43, 40, '10.132.212.241 | 172.17.136.241');


--
-- Data for Name: inventory_sectiondetails; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.inventory_sectiondetails VALUES (35, 'Section', 'SW Section', '', '', '', false, 1);
INSERT INTO public.inventory_sectiondetails VALUES (37, 'Section', 'Record Room', '', '', '', false, 1);
INSERT INTO public.inventory_sectiondetails VALUES (38, 'Section', 'Court Manager Room', '', '', '', false, 2);
INSERT INTO public.inventory_sectiondetails VALUES (39, 'Section', 'Help Desk', '', '', '', false, 1);
INSERT INTO public.inventory_sectiondetails VALUES (40, 'Section', 'Judicial Sservice Center', '', '', '', false, 2);
INSERT INTO public.inventory_sectiondetails VALUES (41, 'Section', 'Copying Section', '', '', '', false, 1);
INSERT INTO public.inventory_sectiondetails VALUES (42, 'Section', 'Library Section', '', '', '', false, 1);
INSERT INTO public.inventory_sectiondetails VALUES (43, 'Section', 'Central Filling Section', '', '', '', false, 1);
INSERT INTO public.inventory_sectiondetails VALUES (44, 'Section', 'VC Room', '', '', '', false, 1);
INSERT INTO public.inventory_sectiondetails VALUES (45, 'Section', 'Exam Cell', '', '', '', false, 2);
INSERT INTO public.inventory_sectiondetails VALUES (46, 'Section', 'Server Room', '', '', '', false, 1);
INSERT INTO public.inventory_sectiondetails VALUES (36, 'Section', 'Malkhana', 'Ground', '21', '', false, 1);
INSERT INTO public.inventory_sectiondetails VALUES (53, 'Section', 'Abhilekhagar', 'Ground', '19', '', false, 1);
INSERT INTO public.inventory_sectiondetails VALUES (52, 'Section', 'Abhilekhagar', 'Ground', '16', '', false, 1);
INSERT INTO public.inventory_sectiondetails VALUES (54, 'Section', 'Statistical Section', '', '', '', false, 1);
INSERT INTO public.inventory_sectiondetails VALUES (34, 'Section', 'Office Section', '', '', '', false, 12);
INSERT INTO public.inventory_sectiondetails VALUES (2, 'Court', 'SPECIAL JUDGE UNDER SC/ST (P.A.) ACT', 'Ground Floor', '23', '', false, 2);
INSERT INTO public.inventory_sectiondetails VALUES (10, 'Court', 'VII ADDITIONAL DISTRICT AND SESSIONS JUDGE', '', '', '', false, 2);
INSERT INTO public.inventory_sectiondetails VALUES (47, 'Section', 'Nazarat', '', '', '', false, 2);
INSERT INTO public.inventory_sectiondetails VALUES (1, 'Court', 'PRINCIPAL DISTRICT & SESSIONS JUDGE, DURG', '1st', '1', '', false, 2);
INSERT INTO public.inventory_sectiondetails VALUES (3, 'Court', 'I DISTRICT & ADDITIONAL SESSIONS JUDGE, DURG', '', '', '', false, 2);
INSERT INTO public.inventory_sectiondetails VALUES (4, 'Court', 'DISTRICT & ADDITIONAL SESSIONS JUDGE (F.T.C.), DURG', '', '', '', false, 2);
INSERT INTO public.inventory_sectiondetails VALUES (5, 'Court', 'II DISTRICT & ADDITIONAL SESSIONS JUDGE, DURG', '', '', '', false, 2);
INSERT INTO public.inventory_sectiondetails VALUES (6, 'Court', 'III DISTRICT & ADDITIONAL SESSIONS JUDGE, DURG', '', '', '', false, 2);
INSERT INTO public.inventory_sectiondetails VALUES (7, 'Court', 'IV DISTRICT & ADDITIONAL SESSIONS JUDGE, DURG', '', '', '', false, 12);
INSERT INTO public.inventory_sectiondetails VALUES (8, 'Court', 'V DISTRICT & ADDITIONAL SESSIONS JUDGE, DURG', '', '', '', false, 12);
INSERT INTO public.inventory_sectiondetails VALUES (9, 'Court', 'VI DISTRICT & ADDITIONAL SESSIONS JUDGE, DURG', '', '', '', false, 2);
INSERT INTO public.inventory_sectiondetails VALUES (11, 'Court', 'VIII DISTRICT & ADDITIONAL SESSIONS JUDGE, DURG', '', '', '', false, 3);
INSERT INTO public.inventory_sectiondetails VALUES (12, 'Court', 'DISTRICT & ADDITIONAL SESSIONS JUDGE, IV FTSC (POCSO), DURG', '', '', '', false, 3);
INSERT INTO public.inventory_sectiondetails VALUES (13, 'Court', 'I CIVIL JUDGE SR. DIVISION & CHIEF JUDICIAL MAGISTRATE, DURG', '', '', '', false, 3);
INSERT INTO public.inventory_sectiondetails VALUES (18, 'Court', 'II CIVIL JUDGE SENIOR DIVISION, DURG', '', '', '', false, 2);
INSERT INTO public.inventory_sectiondetails VALUES (14, 'Court', 'III CIVIL JUDGE SENIOR DIVISION, DURG', '', '', '', false, 2);
INSERT INTO public.inventory_sectiondetails VALUES (19, 'Court', 'IV CIVIL JUDGE SENIOR DIVISION, DURG', '', '', '', false, 6);
INSERT INTO public.inventory_sectiondetails VALUES (30, 'Court', 'V CIVIL JUDGE SENIOR DIVISION, DURG', '', '', '', false, 2);
INSERT INTO public.inventory_sectiondetails VALUES (15, 'Court', 'I ADDL. JUDGE TO THE COURT OF I CIVIL JUDGE SR. DIVISION, DURG', '', '', '', false, 2);
INSERT INTO public.inventory_sectiondetails VALUES (16, 'Court', 'II ADDL. JUDGE TO THE COURT OF I CIVIL JUDGE SR. DIV., DURG', '', '', '', false, 2);
INSERT INTO public.inventory_sectiondetails VALUES (28, 'Court', 'III ADDL. JUDGE TO THE COURT I CIVIL JUDGE SR. DIV., DURG', '', '', '', false, 1);
INSERT INTO public.inventory_sectiondetails VALUES (29, 'Court', 'IV ADDL. JUDGE TO THE COURT OF I CIVIL JUDGE SR. DIVISION, DURG', '', '', '', false, 1);
INSERT INTO public.inventory_sectiondetails VALUES (17, 'Court', 'I CIVIL JUDGE JUNIOR DIVISION, DURG', '', '', '', false, 2);
INSERT INTO public.inventory_sectiondetails VALUES (20, 'Court', 'III CIVIL JUDGE JUNIOR DIVISION, DURG', '', '', '', false, 1);
INSERT INTO public.inventory_sectiondetails VALUES (21, 'Court', 'IV CIVIL JUDGE JUNIOR DIVISION, DURG', '', '', '', false, 2);
INSERT INTO public.inventory_sectiondetails VALUES (22, 'Court', 'V CIVIL JUDGE JUNIOR DIVISION, DURG', '', '', '', false, 2);
INSERT INTO public.inventory_sectiondetails VALUES (23, 'Court', 'VI CIVIL JUDGE JUNIOR DIVISION, DURG', '', '', '', false, 2);
INSERT INTO public.inventory_sectiondetails VALUES (24, 'Court', 'VII CIVIL JUDGE JUNIOR DIVISION, DURG', '', '', '', false, 1);
INSERT INTO public.inventory_sectiondetails VALUES (25, 'Court', 'VIII CIVIL JUDGE JUNIOR DIVISION, DURG', '', '', '', false, 1);
INSERT INTO public.inventory_sectiondetails VALUES (27, 'Court', 'X CIVIL JUDGE JUNIOR DIVISION, DURG', '', '', '', false, 2);
INSERT INTO public.inventory_sectiondetails VALUES (31, 'Court', 'XV CIVIL JUDGE JUNIOR DIVISION, DURG', '', '', '', false, 1);
INSERT INTO public.inventory_sectiondetails VALUES (32, 'Court', 'XVI CIVIL JUDGE JUNIOR DIVISION, DURG', '', '', '', false, 1);
INSERT INTO public.inventory_sectiondetails VALUES (33, 'Court', 'I ADDL. JUDGE TO THE COURT OF I CIVIL JUDGE JR. DIVISION, DURG', '', '', '', false, 3);
INSERT INTO public.inventory_sectiondetails VALUES (51, 'Court', 'I ADDL. JUDGE TO THE COURT OF CIVIL JUDGE SR. DIV., BHILAI-3', '', '', '', false, 4);
INSERT INTO public.inventory_sectiondetails VALUES (48, 'Court', 'CIVIL JUDGE SENIOR DIVISION, PATAN', '', '', '', false, 1);
INSERT INTO public.inventory_sectiondetails VALUES (50, 'Court', 'CIVIL JUDGE JUNIOR DIVISION, DHAMDHA', '', '', '', false, 12);


--
-- Data for Name: inventory_staffdesignationmaster; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.inventory_staffdesignationmaster VALUES (9, 'Reader Grade-I', 'Section');
INSERT INTO public.inventory_staffdesignationmaster VALUES (10, 'Reader Grade-II', 'Section');
INSERT INTO public.inventory_staffdesignationmaster VALUES (11, 'Assistant Grade-II', 'Section');
INSERT INTO public.inventory_staffdesignationmaster VALUES (12, 'Assistant Grade-III', 'Section');
INSERT INTO public.inventory_staffdesignationmaster VALUES (13, 'Deputy Registrar', 'Section');
INSERT INTO public.inventory_staffdesignationmaster VALUES (14, 'Bill Clerk', 'Section');
INSERT INTO public.inventory_staffdesignationmaster VALUES (15, 'Assistant Grade-I', 'Section');
INSERT INTO public.inventory_staffdesignationmaster VALUES (16, 'Statistical Writer', 'Section');
INSERT INTO public.inventory_staffdesignationmaster VALUES (17, 'Assistant Statistical Writer', 'Section');
INSERT INTO public.inventory_staffdesignationmaster VALUES (18, 'Process Writer', 'Section');
INSERT INTO public.inventory_staffdesignationmaster VALUES (19, 'System Officer', 'Section');
INSERT INTO public.inventory_staffdesignationmaster VALUES (20, 'System Assistant', 'Section');
INSERT INTO public.inventory_staffdesignationmaster VALUES (21, 'District Nazir', 'Section');
INSERT INTO public.inventory_staffdesignationmaster VALUES (22, 'Nayab Nazir', 'Section');
INSERT INTO public.inventory_staffdesignationmaster VALUES (23, 'Selamin', 'Section');
INSERT INTO public.inventory_staffdesignationmaster VALUES (24, 'Malkhana Nazir', 'Section');
INSERT INTO public.inventory_staffdesignationmaster VALUES (25, 'Assistant Programmer', 'Section');
INSERT INTO public.inventory_staffdesignationmaster VALUES (26, 'Head Copiest', 'Section');
INSERT INTO public.inventory_staffdesignationmaster VALUES (27, 'Assistant Copyist', 'Section');
INSERT INTO public.inventory_staffdesignationmaster VALUES (28, 'Court Manager', 'Section');
INSERT INTO public.inventory_staffdesignationmaster VALUES (29, 'Administrative Officer', 'Section');
INSERT INTO public.inventory_staffdesignationmaster VALUES (30, 'Deputy Court Of Cleark', 'Section');
INSERT INTO public.inventory_staffdesignationmaster VALUES (31, 'Librarian', 'Section');
INSERT INTO public.inventory_staffdesignationmaster VALUES (32, 'Record Keeper', 'Section');
INSERT INTO public.inventory_staffdesignationmaster VALUES (33, 'Assistant Record Keeper', 'Section');
INSERT INTO public.inventory_staffdesignationmaster VALUES (34, 'Registrar', 'Section');
INSERT INTO public.inventory_staffdesignationmaster VALUES (35, 'Assistant Registrar', 'Section');
INSERT INTO public.inventory_staffdesignationmaster VALUES (36, 'Office Typist', 'Section');
INSERT INTO public.inventory_staffdesignationmaster VALUES (37, 'NOT ASSIGNED', 'Section');
INSERT INTO public.inventory_staffdesignationmaster VALUES (1, 'Deposition Writer', 'Court');
INSERT INTO public.inventory_staffdesignationmaster VALUES (2, 'Process Writer-1', 'Court');
INSERT INTO public.inventory_staffdesignationmaster VALUES (3, 'Process Writer-2', 'Court');
INSERT INTO public.inventory_staffdesignationmaster VALUES (4, 'Stenographer-1', 'Court');
INSERT INTO public.inventory_staffdesignationmaster VALUES (5, 'Stenographer-2', 'Court');
INSERT INTO public.inventory_staffdesignationmaster VALUES (6, 'Stenographer (English)', 'Court');
INSERT INTO public.inventory_staffdesignationmaster VALUES (7, 'Civil Reader', 'Court');
INSERT INTO public.inventory_staffdesignationmaster VALUES (8, 'Criminal  Reader', 'Court');
INSERT INTO public.inventory_staffdesignationmaster VALUES (38, 'Steno Typist', 'Court');
INSERT INTO public.inventory_staffdesignationmaster VALUES (39, 'Accountant', 'Section');
INSERT INTO public.inventory_staffdesignationmaster VALUES (40, 'Stenographer', 'Section');


--
-- Data for Name: inventory_transactiondetails; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.inventory_transactiondetails VALUES (1, '2024-05-23', 'Yes', 57);
INSERT INTO public.inventory_transactiondetails VALUES (2, '2024-05-23', 'Yes', 58);
INSERT INTO public.inventory_transactiondetails VALUES (3, '2024-05-23', 'Yes', 59);
INSERT INTO public.inventory_transactiondetails VALUES (4, '2024-05-23', 'Yes', 60);
INSERT INTO public.inventory_transactiondetails VALUES (5, '2024-05-23', 'Yes', 61);
INSERT INTO public.inventory_transactiondetails VALUES (6, '2024-05-23', 'Yes', 60);
INSERT INTO public.inventory_transactiondetails VALUES (7, '2024-05-23', 'Yes', 62);
INSERT INTO public.inventory_transactiondetails VALUES (8, '2024-05-23', 'Yes', 63);
INSERT INTO public.inventory_transactiondetails VALUES (9, '2024-05-23', 'Yes', 64);
INSERT INTO public.inventory_transactiondetails VALUES (10, '2024-05-23', 'Yes', 65);
INSERT INTO public.inventory_transactiondetails VALUES (11, '2024-05-23', 'Yes', 67);
INSERT INTO public.inventory_transactiondetails VALUES (12, '2024-05-23', 'Yes', 66);
INSERT INTO public.inventory_transactiondetails VALUES (13, '2024-05-23', 'Yes', 69);
INSERT INTO public.inventory_transactiondetails VALUES (14, '2024-05-23', 'Yes', 68);
INSERT INTO public.inventory_transactiondetails VALUES (15, '2024-05-23', 'Yes', 70);
INSERT INTO public.inventory_transactiondetails VALUES (16, '2024-05-23', 'Yes', 71);
INSERT INTO public.inventory_transactiondetails VALUES (17, '2024-05-23', 'Yes', 72);
INSERT INTO public.inventory_transactiondetails VALUES (18, '2024-05-23', 'Yes', 73);
INSERT INTO public.inventory_transactiondetails VALUES (19, '2024-05-23', 'Yes', 75);
INSERT INTO public.inventory_transactiondetails VALUES (20, '2024-05-23', 'Yes', 74);
INSERT INTO public.inventory_transactiondetails VALUES (21, '2024-05-23', 'Yes', 76);
INSERT INTO public.inventory_transactiondetails VALUES (22, '2024-05-23', 'Yes', 78);
INSERT INTO public.inventory_transactiondetails VALUES (23, '2024-05-23', 'Yes', 77);
INSERT INTO public.inventory_transactiondetails VALUES (24, '2024-05-23', 'Yes', 79);
INSERT INTO public.inventory_transactiondetails VALUES (25, '2024-05-23', 'Yes', 80);
INSERT INTO public.inventory_transactiondetails VALUES (26, '2024-05-23', 'Yes', 80);
INSERT INTO public.inventory_transactiondetails VALUES (27, '2024-05-23', 'Yes', 81);
INSERT INTO public.inventory_transactiondetails VALUES (28, '2024-05-24', 'Yes', 86);
INSERT INTO public.inventory_transactiondetails VALUES (29, '2024-05-24', 'Yes', 85);
INSERT INTO public.inventory_transactiondetails VALUES (30, '2024-05-24', 'Yes', 88);
INSERT INTO public.inventory_transactiondetails VALUES (31, '2024-05-24', 'Yes', 87);
INSERT INTO public.inventory_transactiondetails VALUES (32, '2024-05-24', 'Yes', 89);
INSERT INTO public.inventory_transactiondetails VALUES (34, '2024-05-24', 'Yes', 91);
INSERT INTO public.inventory_transactiondetails VALUES (35, '2024-05-24', 'Yes', 92);
INSERT INTO public.inventory_transactiondetails VALUES (33, '2024-05-24', 'Yes', 90);
INSERT INTO public.inventory_transactiondetails VALUES (36, '2024-05-24', 'Yes', 93);
INSERT INTO public.inventory_transactiondetails VALUES (37, '2024-05-24', 'Yes', 93);
INSERT INTO public.inventory_transactiondetails VALUES (38, '2024-05-24', 'Yes', 94);
INSERT INTO public.inventory_transactiondetails VALUES (39, '2024-05-24', 'Yes', 95);
INSERT INTO public.inventory_transactiondetails VALUES (40, '2024-05-24', 'Yes', 96);
INSERT INTO public.inventory_transactiondetails VALUES (41, '2024-05-24', 'Yes', 97);
INSERT INTO public.inventory_transactiondetails VALUES (42, '2024-05-24', 'Yes', 97);
INSERT INTO public.inventory_transactiondetails VALUES (43, '2024-05-24', 'Yes', 97);
INSERT INTO public.inventory_transactiondetails VALUES (44, '2024-05-24', 'Yes', 98);
INSERT INTO public.inventory_transactiondetails VALUES (45, '2024-05-24', 'Yes', 99);
INSERT INTO public.inventory_transactiondetails VALUES (46, '2024-05-24', 'Yes', 100);
INSERT INTO public.inventory_transactiondetails VALUES (47, '2024-05-24', 'Yes', 101);
INSERT INTO public.inventory_transactiondetails VALUES (48, '2024-05-24', 'Yes', 102);
INSERT INTO public.inventory_transactiondetails VALUES (49, '2024-05-24', 'Yes', 103);
INSERT INTO public.inventory_transactiondetails VALUES (50, '2024-05-24', 'Yes', 104);
INSERT INTO public.inventory_transactiondetails VALUES (51, '2024-05-24', 'Yes', 105);
INSERT INTO public.inventory_transactiondetails VALUES (52, '2024-05-24', 'Yes', 82);
INSERT INTO public.inventory_transactiondetails VALUES (53, '2024-05-24', 'Yes', 83);
INSERT INTO public.inventory_transactiondetails VALUES (54, '2024-05-24', 'Yes', 84);
INSERT INTO public.inventory_transactiondetails VALUES (55, '2024-05-26', 'Yes', 106);
INSERT INTO public.inventory_transactiondetails VALUES (56, '2024-05-26', 'Yes', 107);
INSERT INTO public.inventory_transactiondetails VALUES (57, '2024-05-26', 'Yes', 108);
INSERT INTO public.inventory_transactiondetails VALUES (58, '2024-05-26', 'Yes', 109);
INSERT INTO public.inventory_transactiondetails VALUES (59, '2024-05-26', 'Yes', 110);
INSERT INTO public.inventory_transactiondetails VALUES (60, '2024-05-26', 'Yes', 113);
INSERT INTO public.inventory_transactiondetails VALUES (61, '2024-05-26', 'Yes', 111);
INSERT INTO public.inventory_transactiondetails VALUES (62, '2024-05-26', 'Yes', 114);
INSERT INTO public.inventory_transactiondetails VALUES (63, '2024-05-26', 'Yes', 112);
INSERT INTO public.inventory_transactiondetails VALUES (64, '2024-05-26', 'Yes', 115);
INSERT INTO public.inventory_transactiondetails VALUES (65, '2024-05-26', 'Yes', 116);
INSERT INTO public.inventory_transactiondetails VALUES (66, '2024-05-26', 'Yes', 117);
INSERT INTO public.inventory_transactiondetails VALUES (67, '2024-05-26', 'Yes', 118);
INSERT INTO public.inventory_transactiondetails VALUES (68, '2024-05-26', 'Yes', 119);
INSERT INTO public.inventory_transactiondetails VALUES (69, '2024-05-26', 'Yes', 120);
INSERT INTO public.inventory_transactiondetails VALUES (70, '2024-05-26', 'Yes', 121);
INSERT INTO public.inventory_transactiondetails VALUES (71, '2024-05-26', 'Yes', 123);
INSERT INTO public.inventory_transactiondetails VALUES (72, '2024-05-26', 'Yes', 122);
INSERT INTO public.inventory_transactiondetails VALUES (73, '2024-05-26', 'Yes', 125);
INSERT INTO public.inventory_transactiondetails VALUES (74, '2024-05-26', 'Yes', 124);
INSERT INTO public.inventory_transactiondetails VALUES (75, '2024-05-26', 'Yes', 126);
INSERT INTO public.inventory_transactiondetails VALUES (76, '2024-06-18', 'No', 128);
INSERT INTO public.inventory_transactiondetails VALUES (77, '2024-06-18', 'No', 127);
INSERT INTO public.inventory_transactiondetails VALUES (78, '2024-06-18', 'No', 130);
INSERT INTO public.inventory_transactiondetails VALUES (79, '2024-06-18', 'No', 129);
INSERT INTO public.inventory_transactiondetails VALUES (80, '2024-06-18', 'No', 131);
INSERT INTO public.inventory_transactiondetails VALUES (81, '2024-06-18', 'No', 92);
INSERT INTO public.inventory_transactiondetails VALUES (82, '2024-06-18', 'No', 132);
INSERT INTO public.inventory_transactiondetails VALUES (83, '2024-06-19', 'No', 138);
INSERT INTO public.inventory_transactiondetails VALUES (84, '2024-06-19', 'No', 133);
INSERT INTO public.inventory_transactiondetails VALUES (85, '2024-06-19', 'No', 135);
INSERT INTO public.inventory_transactiondetails VALUES (86, '2024-06-19', 'No', 139);
INSERT INTO public.inventory_transactiondetails VALUES (87, '2024-06-19', 'No', 136);
INSERT INTO public.inventory_transactiondetails VALUES (88, '2024-06-19', 'No', 137);
INSERT INTO public.inventory_transactiondetails VALUES (89, '2024-06-19', 'No', 134);
INSERT INTO public.inventory_transactiondetails VALUES (90, '2024-06-20', 'No', 140);
INSERT INTO public.inventory_transactiondetails VALUES (91, '2024-06-20', 'No', 141);
INSERT INTO public.inventory_transactiondetails VALUES (92, '2024-06-20', 'No', 142);
INSERT INTO public.inventory_transactiondetails VALUES (93, '2024-06-20', 'No', 143);
INSERT INTO public.inventory_transactiondetails VALUES (94, '2024-06-20', 'No', 144);
INSERT INTO public.inventory_transactiondetails VALUES (95, '2024-06-20', 'No', 145);
INSERT INTO public.inventory_transactiondetails VALUES (96, '2024-06-20', 'No', 146);
INSERT INTO public.inventory_transactiondetails VALUES (97, '2024-06-20', 'No', 148);
INSERT INTO public.inventory_transactiondetails VALUES (98, '2024-06-20', 'No', 147);
INSERT INTO public.inventory_transactiondetails VALUES (99, '2024-06-21', 'No', 149);
INSERT INTO public.inventory_transactiondetails VALUES (100, '2024-06-21', 'No', 150);
INSERT INTO public.inventory_transactiondetails VALUES (101, '2024-06-21', 'No', 151);
INSERT INTO public.inventory_transactiondetails VALUES (102, '2024-06-21', 'No', 152);
INSERT INTO public.inventory_transactiondetails VALUES (103, '2024-06-21', 'No', 153);
INSERT INTO public.inventory_transactiondetails VALUES (104, '2024-06-21', 'No', 154);
INSERT INTO public.inventory_transactiondetails VALUES (105, '2024-06-21', 'No', 155);
INSERT INTO public.inventory_transactiondetails VALUES (106, '2024-06-21', 'No', 156);
INSERT INTO public.inventory_transactiondetails VALUES (107, '2024-06-21', 'No', 157);
INSERT INTO public.inventory_transactiondetails VALUES (108, '2024-06-21', 'No', 158);
INSERT INTO public.inventory_transactiondetails VALUES (109, '2024-06-21', 'No', 159);
INSERT INTO public.inventory_transactiondetails VALUES (110, '2024-06-21', 'No', 160);
INSERT INTO public.inventory_transactiondetails VALUES (111, '2024-06-21', 'No', 161);
INSERT INTO public.inventory_transactiondetails VALUES (112, '2024-06-21', 'No', 162);
INSERT INTO public.inventory_transactiondetails VALUES (113, '2024-06-21', 'No', 163);
INSERT INTO public.inventory_transactiondetails VALUES (114, '2024-06-24', 'No', 164);
INSERT INTO public.inventory_transactiondetails VALUES (115, '2024-06-24', 'No', 165);
INSERT INTO public.inventory_transactiondetails VALUES (116, '2024-06-24', 'No', 166);
INSERT INTO public.inventory_transactiondetails VALUES (117, '2024-06-24', 'No', 76);
INSERT INTO public.inventory_transactiondetails VALUES (118, '2024-06-25', 'No', 167);
INSERT INTO public.inventory_transactiondetails VALUES (119, '2024-06-25', 'No', 168);
INSERT INTO public.inventory_transactiondetails VALUES (120, '2024-06-25', 'No', 173);
INSERT INTO public.inventory_transactiondetails VALUES (121, '2024-06-25', 'No', 169);
INSERT INTO public.inventory_transactiondetails VALUES (122, '2024-06-25', 'No', 174);
INSERT INTO public.inventory_transactiondetails VALUES (123, '2024-06-25', 'No', 170);
INSERT INTO public.inventory_transactiondetails VALUES (124, '2024-06-25', 'No', 171);
INSERT INTO public.inventory_transactiondetails VALUES (125, '2024-06-26', 'No', 172);
INSERT INTO public.inventory_transactiondetails VALUES (126, '2024-06-26', 'No', 177);
INSERT INTO public.inventory_transactiondetails VALUES (127, '2024-06-26', 'No', 175);
INSERT INTO public.inventory_transactiondetails VALUES (128, '2024-06-26', 'No', 176);
INSERT INTO public.inventory_transactiondetails VALUES (129, '2024-06-26', 'No', 66);
INSERT INTO public.inventory_transactiondetails VALUES (130, '2024-06-28', 'No', 178);
INSERT INTO public.inventory_transactiondetails VALUES (131, '2024-06-28', 'No', 179);
INSERT INTO public.inventory_transactiondetails VALUES (132, '2024-06-28', 'No', 180);
INSERT INTO public.inventory_transactiondetails VALUES (133, '2024-06-28', 'No', 181);
INSERT INTO public.inventory_transactiondetails VALUES (134, '2024-06-28', 'No', 182);
INSERT INTO public.inventory_transactiondetails VALUES (135, '2024-06-28', 'No', 183);
INSERT INTO public.inventory_transactiondetails VALUES (136, '2024-06-29', 'No', 184);
INSERT INTO public.inventory_transactiondetails VALUES (137, '2024-06-29', 'No', 185);
INSERT INTO public.inventory_transactiondetails VALUES (138, '2024-06-29', 'No', 186);
INSERT INTO public.inventory_transactiondetails VALUES (139, '2024-06-29', 'No', 187);
INSERT INTO public.inventory_transactiondetails VALUES (140, '2024-06-29', 'No', 188);
INSERT INTO public.inventory_transactiondetails VALUES (141, '2024-06-29', 'No', 189);
INSERT INTO public.inventory_transactiondetails VALUES (142, '2024-06-29', 'No', 113);
INSERT INTO public.inventory_transactiondetails VALUES (143, '2024-06-29', 'No', 190);
INSERT INTO public.inventory_transactiondetails VALUES (144, '2024-06-29', 'No', 191);
INSERT INTO public.inventory_transactiondetails VALUES (145, '2024-06-29', 'No', 192);
INSERT INTO public.inventory_transactiondetails VALUES (146, '2024-06-29', 'No', 193);
INSERT INTO public.inventory_transactiondetails VALUES (147, '2024-06-29', 'No', 194);
INSERT INTO public.inventory_transactiondetails VALUES (148, '2024-06-29', 'No', 195);
INSERT INTO public.inventory_transactiondetails VALUES (149, '2024-07-08', 'No', 197);
INSERT INTO public.inventory_transactiondetails VALUES (150, '2024-07-08', 'No', 198);
INSERT INTO public.inventory_transactiondetails VALUES (151, '2024-07-08', 'No', 196);
INSERT INTO public.inventory_transactiondetails VALUES (152, '2024-07-08', 'No', 196);
INSERT INTO public.inventory_transactiondetails VALUES (153, '2024-07-10', 'No', 200);
INSERT INTO public.inventory_transactiondetails VALUES (154, '2024-07-10', 'No', 199);
INSERT INTO public.inventory_transactiondetails VALUES (155, '2024-07-10', 'No', 201);
INSERT INTO public.inventory_transactiondetails VALUES (156, '2024-07-11', 'No', 194);
INSERT INTO public.inventory_transactiondetails VALUES (157, '2024-07-11', 'No', 198);
INSERT INTO public.inventory_transactiondetails VALUES (158, '2024-07-11', 'No', 60);
INSERT INTO public.inventory_transactiondetails VALUES (159, '2024-07-11', 'No', 67);
INSERT INTO public.inventory_transactiondetails VALUES (160, '2024-07-11', 'No', 61);
INSERT INTO public.inventory_transactiondetails VALUES (161, '2024-07-11', 'No', 60);
INSERT INTO public.inventory_transactiondetails VALUES (162, '2024-07-11', 'No', 161);
INSERT INTO public.inventory_transactiondetails VALUES (163, '2024-07-29', 'No', 97);
INSERT INTO public.inventory_transactiondetails VALUES (164, '2024-07-29', 'No', 135);
INSERT INTO public.inventory_transactiondetails VALUES (165, '2024-07-29', 'No', 150);
INSERT INTO public.inventory_transactiondetails VALUES (166, '2024-07-29', 'No', 191);
INSERT INTO public.inventory_transactiondetails VALUES (167, '2024-07-29', 'No', 202);
INSERT INTO public.inventory_transactiondetails VALUES (168, '2024-07-29', 'No', 203);
INSERT INTO public.inventory_transactiondetails VALUES (169, '2024-07-29', 'No', 164);
INSERT INTO public.inventory_transactiondetails VALUES (170, '2024-08-03', 'No', 190);
INSERT INTO public.inventory_transactiondetails VALUES (171, '2024-08-03', 'No', 152);
INSERT INTO public.inventory_transactiondetails VALUES (172, '2024-08-07', 'No', 113);
INSERT INTO public.inventory_transactiondetails VALUES (173, '2024-08-07', 'No', 113);
INSERT INTO public.inventory_transactiondetails VALUES (174, '2024-08-07', 'No', 113);
INSERT INTO public.inventory_transactiondetails VALUES (175, '2024-08-08', 'No', 185);
INSERT INTO public.inventory_transactiondetails VALUES (176, '2024-08-13', 'No', 159);
INSERT INTO public.inventory_transactiondetails VALUES (177, '2024-08-13', 'No', 116);
INSERT INTO public.inventory_transactiondetails VALUES (178, '2024-09-06', 'No', 62);
INSERT INTO public.inventory_transactiondetails VALUES (179, '2024-09-09', 'No', 204);
INSERT INTO public.inventory_transactiondetails VALUES (180, '2024-09-09', 'No', 70);
INSERT INTO public.inventory_transactiondetails VALUES (181, '2024-09-09', 'No', 66);
INSERT INTO public.inventory_transactiondetails VALUES (182, '2024-09-09', 'No', 60);
INSERT INTO public.inventory_transactiondetails VALUES (183, '2024-09-09', 'No', 93);
INSERT INTO public.inventory_transactiondetails VALUES (184, '2024-09-10', 'No', 106);
INSERT INTO public.inventory_transactiondetails VALUES (185, '2024-09-11', 'No', 82);
INSERT INTO public.inventory_transactiondetails VALUES (186, '2024-08-27', 'No', 187);
INSERT INTO public.inventory_transactiondetails VALUES (187, '2024-08-28', 'No', 76);
INSERT INTO public.inventory_transactiondetails VALUES (188, '2024-09-11', 'No', 78);
INSERT INTO public.inventory_transactiondetails VALUES (189, '2024-09-11', 'No', 123);
INSERT INTO public.inventory_transactiondetails VALUES (190, '2024-09-02', 'No', 186);
INSERT INTO public.inventory_transactiondetails VALUES (191, '2024-09-10', 'No', 140);
INSERT INTO public.inventory_transactiondetails VALUES (192, '2024-09-09', 'No', 205);
INSERT INTO public.inventory_transactiondetails VALUES (193, '2024-09-12', 'No', 166);
INSERT INTO public.inventory_transactiondetails VALUES (194, '2024-09-06', 'No', 164);
INSERT INTO public.inventory_transactiondetails VALUES (195, '2024-09-13', 'No', 150);
INSERT INTO public.inventory_transactiondetails VALUES (196, '2024-09-21', 'No', 193);
INSERT INTO public.inventory_transactiondetails VALUES (197, '2024-09-19', 'No', 170);
INSERT INTO public.inventory_transactiondetails VALUES (198, '2024-09-24', 'No', 152);
INSERT INTO public.inventory_transactiondetails VALUES (199, '2024-09-30', 'No', 161);
INSERT INTO public.inventory_transactiondetails VALUES (200, '2024-10-10', 'No', 99);
INSERT INTO public.inventory_transactiondetails VALUES (201, '2024-10-03', 'No', 197);
INSERT INTO public.inventory_transactiondetails VALUES (202, '2024-10-10', 'No', 98);
INSERT INTO public.inventory_transactiondetails VALUES (203, '2024-10-08', 'No', 60);
INSERT INTO public.inventory_transactiondetails VALUES (204, '2024-10-03', 'No', 60);
INSERT INTO public.inventory_transactiondetails VALUES (205, '2024-09-26', 'No', 60);
INSERT INTO public.inventory_transactiondetails VALUES (206, '2024-06-25', 'No', 171);
INSERT INTO public.inventory_transactiondetails VALUES (207, '2024-06-26', 'No', 207);
INSERT INTO public.inventory_transactiondetails VALUES (208, '2024-10-09', 'No', 206);
INSERT INTO public.inventory_transactiondetails VALUES (209, '2024-11-25', 'No', 208);
INSERT INTO public.inventory_transactiondetails VALUES (210, '2024-11-27', 'No', 179);
INSERT INTO public.inventory_transactiondetails VALUES (211, '2024-12-07', 'No', 209);
INSERT INTO public.inventory_transactiondetails VALUES (212, '2024-12-07', 'No', 210);
INSERT INTO public.inventory_transactiondetails VALUES (213, '2024-12-07', 'No', 189);
INSERT INTO public.inventory_transactiondetails VALUES (214, '2024-11-18', 'No', 185);
INSERT INTO public.inventory_transactiondetails VALUES (215, '2024-12-03', 'No', 200);
INSERT INTO public.inventory_transactiondetails VALUES (216, '2024-07-10', 'No', 201);
INSERT INTO public.inventory_transactiondetails VALUES (217, '2024-07-10', 'No', 201);


--
-- Data for Name: inventory_userdetails; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.inventory_userdetails VALUES (2, 'Ajay Kumar Sahu', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (3, 'Ajay Kumar Sharma', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (5, 'Anand Lanjewar', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (6, 'Anil Sahu', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (7, 'Anita Markande', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (8, 'Anup Singh Thakur', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (9, 'Apoorva Ujjalvkar', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (10, 'Arun Kumar Warde', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (11, 'Asha Dewangan', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (12, 'Asha Singh', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (13, 'Ashish Kumar Yadav', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (14, 'Ashish Soni', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (16, 'Atul Kumar Lokhande', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (17, 'B. Vijayalakshmi', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (18, 'Balram Das Manikpuri', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (19, 'Bharti Das', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (20, 'Bharti Dewangan', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (21, 'Bharti Sonteke', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (22, 'Bhavna Deshmukh', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (23, 'Bhupendra Dewangan', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (24, 'Bhupendra Kumar', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (25, 'Brajmohan Singh Nataraj', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (26, 'Chirag Sharma', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (27, 'Chitrarekha Soni', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (28, 'Damini Dhruve', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (32, 'Devendra Kumar Chaturvedi', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (33, 'Devendra Kumar Soni', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (34, 'Dhaniram', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (35, 'Dilip Singh Rajput', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (36, 'Doman Lal', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (37, 'Durgesh Verma', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (38, 'Gagan Pratap Yadav', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (39, 'Gajendra Kumar Deshmukh', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (40, 'Geeta Rahangdale', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (42, 'Ghanshyam Patel', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (43, 'Giriraj Kumar', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (44, 'Govinda Prasad', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (45, 'Hem Singh Dhruv', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (46, 'Hemanandini Sinha', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (48, 'Intekhab Ahmed Khan', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (50, 'Jitendra Kumar Swarnakar', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (51, 'Jyoti Dewangan', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (52, 'Jyoti Thakur', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (53, 'K.K.Bile', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (54, 'Kajal Bhelave', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (55, 'Kamini Deshlahre', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (57, 'Kanak Kumar Bhaina', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (58, 'Kavita Dewangan', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (60, 'Khelendra Kumar Dewangan', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (61, 'Khemraj Delhiwar', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (62, 'Khushboo Dewangan', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (63, 'Khushbu Thakur', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (64, 'Kiran Gendre', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (65, 'Komal Chand Uike', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (66, 'Krishna Kumar Yadav', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (67, 'Kunjulal', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (68, 'Kusumlata Sahu', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (69, 'L.N.Rai', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (70, 'Lalit Kumar Borkar', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (72, 'Lokendra Kumar', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (73, 'Lubna Siddiqui', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (74, 'Madhubala Soni', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (75, 'Madhukar Rao Pawar', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (76, 'Mahendra Kumar Deshmukh', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (77, 'Mahendra Pratap', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (78, 'Mahesh Kumar Yadav', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (79, 'Mamta Dhabre', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (80, 'Mamta Ganveer', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (81, 'Mamta Singh', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (82, 'Manju Yadav', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (83, 'Manohar Kumar Khadgi', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (84, 'Manoj Kumar Malhotra', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (85, 'Maya Tiwari', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (86, 'Md. Sajid Qureshi', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (88, 'Monika Dewangan', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (89, 'Mr. R.K.Thakur', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (90, 'Mrs. Seema Singh Rajput', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (91, 'Ms. seema sahu', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (92, 'Nandkishore Mate', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (93, 'Naresh Kumar Sahu', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (94, 'Neelam Pandey', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (95, 'Neetu Singh Karma', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (96, 'Nemkumari Dewangan', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (97, 'Nidhi Bali', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (99, 'Nohar Lal Dewangan', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (100, 'Nohar Singh Bisen', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (101, 'Parakh Deshmukh', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (102, 'Pawan Kumar Singh', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (103, 'Pileshwari Soni', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (104, 'Pooja Pawar', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (105, 'Poonam Patel', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (106, 'Poornima Tulsikar', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (107, 'Prabha Tiwari', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (108, 'Prachi Hariharno', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (109, 'Pradeep Kumar Sharma', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (111, 'Pramod Kumar Achintya', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (113, 'Premlata Panche', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (114, 'priya kalousia', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (115, 'Progress', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (117, 'Purnanand Thakur', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (118, 'Raju Nirmalkar', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (120, 'Ramesh Kumar Kannauj', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (121, 'Ranjana Patel', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (122, 'Ranjana Thakur', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (4, 'Amit Kumar Sahu', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (123, 'Reena Nirmalkar', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (124, 'Richa Jachak', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (119, 'Ramesh Kumar Verma', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (56, 'Kamlesh Kumar Paikra', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (112, 'Pramod Kumar Soni', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (31, 'Deepika Kumbhare', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (87, 'Mohd. Shafiq', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (71, 'Laxman Prasad Dewangan', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (116, 'Puran Singh', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (15, 'Asif Ali', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (98, 'Nidhi Dua', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (110, 'Pradeep Kumar Verma', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (30, 'Deepak Kumar', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (125, 'Roshni Soni', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (126, 'Rukhsana Parveen', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (49, 'null', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (127, 'Rupesh Kumar Sahu', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (128, 'Sadhna Rao', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (129, 'Sameer Soni', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (130, 'Sanat Kumar Pandey', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (131, 'Sanjay Kumar', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (132, 'Sanjaydhar Dewan', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (133, 'Sanjeev Kumar Ojha', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (134, 'Santosh Kumar Jaiswal', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (135, 'Saraswati Dhankar', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (136, 'Savitri Tiwari', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (137, 'Shailbala Ramteke', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (138, 'Sharad Agarwal', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (139, 'Shashikala', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (140, 'Shivendra Sahu', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (141, 'Shomita Bhattacharya', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (142, 'Shreya Tiwari', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (143, 'Shyam Sundar Sahu', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (144, 'Siyaram Dilharan Verma', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (145, 'Smriti Srivastava', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (146, 'Smt. Dnyaneshwari Sahu', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (149, 'Sohan Pradhan', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (150, 'Suchitra Nishad', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (151, 'Sudha Dwivedi', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (152, 'Sudhakar Baghmare', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (153, 'Sulakshana Ratnakar', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (154, 'Sulochana Sahu', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (156, 'Suraj Singh', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (157, 'Surendra Kumar Kurre', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (158, 'Suresh Kumar', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (159, 'Sushma Mishra', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (160, 'Swarnalata Chandra', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (161, 'Tarun Kumar Chandrakar', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (162, 'Tarun Kumar Sahu', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (163, 'Tatu Singh Thakur', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (166, 'Triveni Yadav', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (167, 'Tushar Kumar Dupare', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (168, 'Umesh Dewangan', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (169, 'Umesh Kumar Kaushik', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (173, 'Varsha Sahu', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (174, 'Varun Kumar Tembhere', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (175, 'Venu Sonteke', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (176, 'Vijay Kumar Kaushik', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (177, 'Vijay Kumar Shukla', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (179, 'Vijaypal Singh Sisodia', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (180, 'Vikas Kumar Dewangan', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (181, 'Vikas Kumar Soni', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (182, 'Vikesh Kumar Sharma', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (183, 'Vimal Tiwari', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (184, 'Virendra Kumar Kabire', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (185, 'Vishambhar Bhateria', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (186, 'Vishwas Yadav', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (187, 'Yamini Vaika', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (188, 'Yashwanti Singh', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (189, 'Yogesh Bhanduria', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (191, 'Yogesh Kumar', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (192, 'Yugal Kumar', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (193, 'Yugank Tiwari', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (194, 'Test', '', '2023-03-16', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (165, 'Tikesh Kumar Sahu ', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (47, 'Rishikesh Nirmalkar ', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (1, 'Ajay Kumar Dewangan', '', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (155, 'Suman Sahu', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (195, 'Janki', '', '2023-10-06', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (172, 'Vanita Borekar', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (59, 'Khelan Singh Verma', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (148, 'Snigdha Vaishnav', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (178, 'Vijay Kumar Tidke', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (197, 'Fagooram Verma', '', '2023-10-16', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (147, 'Snehlata Sharma', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (164, 'Tekeshwari', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (171, 'Yupendra Kumar Dewangan', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (198, 'Didaro Kaur Sandhu', '', '2023-10-18', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (199, 'Akash kumar Gupta', '', '2023-12-26', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (200, 'Tiresh Kumar Banjare', '', '2023-12-26', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (201, 'Sangeeta sahu', '', '2023-12-26', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (203, 'Anupama kujjur', '', '2024-05-23', '', false);
INSERT INTO public.inventory_userdetails VALUES (202, 'Kirtidhwaj', '', '2024-05-23', '', false);
INSERT INTO public.inventory_userdetails VALUES (205, 'Dipesh Nawrange', '', '2024-05-23', '', false);
INSERT INTO public.inventory_userdetails VALUES (206, 'Prerna Dave', '', '2024-05-23', '', false);
INSERT INTO public.inventory_userdetails VALUES (207, 'Gyaneshwari sahu', '', '2024-05-24', '', false);
INSERT INTO public.inventory_userdetails VALUES (208, 'Pallavi Patel', '', '2024-05-24', '', false);
INSERT INTO public.inventory_userdetails VALUES (190, 'Yogesh Barle', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (209, 'Manish', '', '2024-05-24', '', false);
INSERT INTO public.inventory_userdetails VALUES (210, 'Pragati', '', '2024-05-24', '', false);
INSERT INTO public.inventory_userdetails VALUES (211, 'Akshay Patel', '', '2024-05-24', '', false);
INSERT INTO public.inventory_userdetails VALUES (212, 'Aman Gupta', '', '2024-05-24', '', false);
INSERT INTO public.inventory_userdetails VALUES (213, 'Kumkum', '', '2024-05-24', '', false);
INSERT INTO public.inventory_userdetails VALUES (214, 'Harshita', '', '2024-05-25', '', false);
INSERT INTO public.inventory_userdetails VALUES (215, 'Neha Jaiswar', '', '2024-05-25', '', false);
INSERT INTO public.inventory_userdetails VALUES (216, 'Priyanka Khute', '', '2024-05-25', '', false);
INSERT INTO public.inventory_userdetails VALUES (217, 'Indira Thakur', '', '2024-05-25', '', false);
INSERT INTO public.inventory_userdetails VALUES (218, 'Siddharth', '', '2024-06-18', '', false);
INSERT INTO public.inventory_userdetails VALUES (219, 'Durgesh kumar dewangan', '', '2024-06-18', '', false);
INSERT INTO public.inventory_userdetails VALUES (220, 'Bharti Bhaujdar', '', '2024-06-18', '', false);
INSERT INTO public.inventory_userdetails VALUES (221, 'Shahnawaz Ansari', '', '2024-06-19', '', false);
INSERT INTO public.inventory_userdetails VALUES (222, 'Khusbu Thakur', '', '2024-06-20', '', false);
INSERT INTO public.inventory_userdetails VALUES (223, 'Mukesh', '', '2024-06-20', '', false);
INSERT INTO public.inventory_userdetails VALUES (224, 'Sheetal kumar kashyap', '', '2024-06-20', '', false);
INSERT INTO public.inventory_userdetails VALUES (225, 'Pooja Singh', '', '2024-06-21', '', false);
INSERT INTO public.inventory_userdetails VALUES (226, 'Malti Barnwal', '', '2024-06-21', '', false);
INSERT INTO public.inventory_userdetails VALUES (227, 'Bhawna Deshmukh', '', '2024-06-21', '', false);
INSERT INTO public.inventory_userdetails VALUES (228, 'Pinki Karmakar', '', '2024-06-21', '', false);
INSERT INTO public.inventory_userdetails VALUES (229, 'Linima Lahare', '', '2024-06-21', '', false);
INSERT INTO public.inventory_userdetails VALUES (230, 'Mamta Nanda', '', '2024-06-21', '', false);
INSERT INTO public.inventory_userdetails VALUES (231, 'Prakash Patel', '', '2024-06-22', '', false);
INSERT INTO public.inventory_userdetails VALUES (232, 'Lokesh Khare', '', '2024-06-22', '', false);
INSERT INTO public.inventory_userdetails VALUES (233, 'Magal Ram Sahu', '', '2024-06-25', '', false);
INSERT INTO public.inventory_userdetails VALUES (235, 'Sonu Ram Lahare', '', '2024-06-28', '', false);
INSERT INTO public.inventory_userdetails VALUES (236, 'Shivangi Verma', '', '2024-06-28', '', false);
INSERT INTO public.inventory_userdetails VALUES (196, 'Janeshwar Singh Bharatwaj', '', '2023-10-13', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (41, 'Ghanshyam', ' ', '2023-03-15', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (238, 'Sushant Bepari ', '', '2024-06-29', '', false);
INSERT INTO public.inventory_userdetails VALUES (204, 'Yuvraj', '', '2024-05-23', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (239, 'Chandramohan', '', '2024-07-08', '', false);
INSERT INTO public.inventory_userdetails VALUES (240, 'Suresh Sahu', '', '2024-07-08', '', false);
INSERT INTO public.inventory_userdetails VALUES (241, 'Jayanti Gadatiya', '', '2024-08-07', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (242, 'Dishan Dahariya', '', '2024-08-07', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (243, 'Dinesh Kumar Ajay', '', '2024-09-09', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (170, 'Umeshwari Deshlahre', ' ', '2023-03-15', '', false);
INSERT INTO public.inventory_userdetails VALUES (0, 'VACANT', ' ', '1900-01-01', ' ', false);
INSERT INTO public.inventory_userdetails VALUES (244, 'Surendra Prashad', '', '2024-09-21', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (246, 'Pawan deep', '', '2024-10-08', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (247, 'Arun Kumar Dewangan', '', '2024-10-08', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (248, 'Mamta', '', '2024-10-08', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (249, 'M. Krishna Veni', '', '2024-10-08', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (237, 'Shahid Hussain', '', '2024-06-29', '', false);
INSERT INTO public.inventory_userdetails VALUES (245, 'Binu Vaish', '', '2024-10-08', '', false);
INSERT INTO public.inventory_userdetails VALUES (250, 'Rajendra', '', '2024-11-20', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (251, 'Mithlesh Kumar', '', '2024-11-20', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (252, 'Dileshwari Bharti', '', '2024-11-25', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (234, 'Prameshwari Sahu', '', '2024-06-28', '', false);
INSERT INTO public.inventory_userdetails VALUES (253, 'Narayan', '', '2024-11-27', 'Staff', false);
INSERT INTO public.inventory_userdetails VALUES (254, 'Yadunandan Kaushik', '', '2024-12-06', 'Staff', false);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 96, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 1, false);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 24, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 31, true);


--
-- Name: inventory_buildingmaster_building_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventory_buildingmaster_building_id_seq', 13, true);


--
-- Name: inventory_courtestablishmentmaster_est_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventory_courtestablishmentmaster_est_id_seq', 6, false);


--
-- Name: inventory_employee_journey_emp_jou_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventory_employee_journey_emp_jou_id_seq', 165, true);


--
-- Name: inventory_healthstatusdetails_health_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventory_healthstatusdetails_health_id_seq', 1610, true);


--
-- Name: inventory_productcategorymaster_product_cat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventory_productcategorymaster_product_cat_id_seq', 26, false);


--
-- Name: inventory_productcompanymaster_product_com_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventory_productcompanymaster_product_com_id_seq', 82, true);


--
-- Name: inventory_productdetails_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventory_productdetails_product_id_seq', 1058, true);


--
-- Name: inventory_productmodelmaster_product_mod_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventory_productmodelmaster_product_mod_id_seq', 113, true);


--
-- Name: inventory_productpuchasedetails_propur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventory_productpuchasedetails_propur_id_seq', 8, true);


--
-- Name: inventory_producttransactiondetails_pro_trans_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventory_producttransactiondetails_pro_trans_id_seq1', 1224, true);


--
-- Name: inventory_purchasedetails_purchase_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventory_purchasedetails_purchase_id_seq', 3, true);


--
-- Name: inventory_secdesview_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventory_secdesview_id_seq', 1, false);


--
-- Name: inventory_sectiondesignationmapper_sdm_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventory_sectiondesignationmapper_sdm_id_seq', 210, true);


--
-- Name: inventory_sectiondetails_section_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventory_sectiondetails_section_id_seq', 58, true);


--
-- Name: inventory_staffdesignationmaster_staff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventory_staffdesignationmaster_staff_id_seq', 40, true);


--
-- Name: inventory_transactiondetails_trans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventory_transactiondetails_trans_id_seq', 217, true);


--
-- Name: inventory_userdetails_usr_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventory_userdetails_usr_id_seq', 254, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: inventory_buildingmaster inventory_buildingmaster_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_buildingmaster
    ADD CONSTRAINT inventory_buildingmaster_pkey PRIMARY KEY (building_id);


--
-- Name: inventory_courtestablishmentmaster inventory_courtestablishmentmaster_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_courtestablishmentmaster
    ADD CONSTRAINT inventory_courtestablishmentmaster_pkey PRIMARY KEY (est_id);


--
-- Name: inventory_employee_journey inventory_employee_journey_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_employee_journey
    ADD CONSTRAINT inventory_employee_journey_pkey PRIMARY KEY (emp_jou_id);


--
-- Name: inventory_healthstatusdetails inventory_healthstatusdetails_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_healthstatusdetails
    ADD CONSTRAINT inventory_healthstatusdetails_pkey PRIMARY KEY (health_id);


--
-- Name: inventory_productcategorymaster inventory_productcategorymaster_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_productcategorymaster
    ADD CONSTRAINT inventory_productcategorymaster_pkey PRIMARY KEY (product_cat_id);


--
-- Name: inventory_productcompanymaster inventory_productcompanymaster_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_productcompanymaster
    ADD CONSTRAINT inventory_productcompanymaster_pkey PRIMARY KEY (product_com_id);


--
-- Name: inventory_productdetails inventory_productdetails_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_productdetails
    ADD CONSTRAINT inventory_productdetails_pkey PRIMARY KEY (product_id);


--
-- Name: inventory_productmodelmaster inventory_productmodelmaster_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_productmodelmaster
    ADD CONSTRAINT inventory_productmodelmaster_pkey PRIMARY KEY (product_mod_id);


--
-- Name: inventory_productpuchasedetails inventory_productpuchasedetails_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_productpuchasedetails
    ADD CONSTRAINT inventory_productpuchasedetails_pkey PRIMARY KEY (propur_id);


--
-- Name: inventory_producttransactiondetails inventory_producttransactiondetails_pkey1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_producttransactiondetails
    ADD CONSTRAINT inventory_producttransactiondetails_pkey1 PRIMARY KEY (pro_trans_id);


--
-- Name: inventory_purchasedetails inventory_purchasedetails_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_purchasedetails
    ADD CONSTRAINT inventory_purchasedetails_pkey PRIMARY KEY (purchase_id);


--
-- Name: inventory_secdesview inventory_secdesview_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_secdesview
    ADD CONSTRAINT inventory_secdesview_pkey PRIMARY KEY (id);


--
-- Name: inventory_sectiondesignationmapper inventory_sectiondesignationmapper_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_sectiondesignationmapper
    ADD CONSTRAINT inventory_sectiondesignationmapper_pkey PRIMARY KEY (sdm_id);


--
-- Name: inventory_sectiondetails inventory_sectiondetails_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_sectiondetails
    ADD CONSTRAINT inventory_sectiondetails_pkey PRIMARY KEY (section_id);


--
-- Name: inventory_staffdesignationmaster inventory_staffdesignationmaster_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_staffdesignationmaster
    ADD CONSTRAINT inventory_staffdesignationmaster_pkey PRIMARY KEY (staff_id);


--
-- Name: inventory_transactiondetails inventory_transactiondetails_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_transactiondetails
    ADD CONSTRAINT inventory_transactiondetails_pkey PRIMARY KEY (trans_id);


--
-- Name: inventory_userdetails inventory_userdetails_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_userdetails
    ADD CONSTRAINT inventory_userdetails_pkey PRIMARY KEY (usr_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: inventory_buildingmaster_est_id_b3bc2290; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inventory_buildingmaster_est_id_b3bc2290 ON public.inventory_buildingmaster USING btree (est_id);


--
-- Name: inventory_employee_journey_sdm_id_873fddb9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inventory_employee_journey_sdm_id_873fddb9 ON public.inventory_employee_journey USING btree (sdm_id);


--
-- Name: inventory_employee_journey_usr_id_cf4ef38b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inventory_employee_journey_usr_id_cf4ef38b ON public.inventory_employee_journey USING btree (usr_id);


--
-- Name: inventory_healthstatusdetails_product_id_d8f07cae; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inventory_healthstatusdetails_product_id_d8f07cae ON public.inventory_healthstatusdetails USING btree (product_id);


--
-- Name: inventory_productcompanymaster_product_cat_id_4c95d812; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inventory_productcompanymaster_product_cat_id_4c95d812 ON public.inventory_productcompanymaster USING btree (product_cat_id);


--
-- Name: inventory_productdetails_product_mod_id_8db622f4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inventory_productdetails_product_mod_id_8db622f4 ON public.inventory_productdetails USING btree (product_mod_id);


--
-- Name: inventory_productdetails_propur_id_b5464de4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inventory_productdetails_propur_id_b5464de4 ON public.inventory_productdetails USING btree (propur_id);


--
-- Name: inventory_productmodelmaster_product_com_id_ce5a7d6b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inventory_productmodelmaster_product_com_id_ce5a7d6b ON public.inventory_productmodelmaster USING btree (product_com_id);


--
-- Name: inventory_productpuchasedetails_product_id_dc58953d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inventory_productpuchasedetails_product_id_dc58953d ON public.inventory_productpuchasedetails USING btree (product_id);


--
-- Name: inventory_productpuchasedetails_purchase_id_b7732065; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inventory_productpuchasedetails_purchase_id_b7732065 ON public.inventory_productpuchasedetails USING btree (purchase_id);


--
-- Name: inventory_producttransactiondetails_productid_id_0e733838; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inventory_producttransactiondetails_productid_id_0e733838 ON public.inventory_producttransactiondetails USING btree (productid_id);


--
-- Name: inventory_producttransactiondetails_trans_id_ac39b32f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inventory_producttransactiondetails_trans_id_ac39b32f ON public.inventory_producttransactiondetails USING btree (trans_id);


--
-- Name: inventory_sectiondesignationmapper_section_id_178f215b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inventory_sectiondesignationmapper_section_id_178f215b ON public.inventory_sectiondesignationmapper USING btree (section_id);


--
-- Name: inventory_sectiondesignationmapper_staff_id_73779617; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inventory_sectiondesignationmapper_staff_id_73779617 ON public.inventory_sectiondesignationmapper USING btree (staff_id);


--
-- Name: inventory_sectiondetails_building_id_9893d197; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inventory_sectiondetails_building_id_9893d197 ON public.inventory_sectiondetails USING btree (building_id);


--
-- Name: inventory_transactiondetails_sdm_id_f98cac0e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inventory_transactiondetails_sdm_id_f98cac0e ON public.inventory_transactiondetails USING btree (sdm_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_buildingmaster inventory_buildingma_est_id_b3bc2290_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_buildingmaster
    ADD CONSTRAINT inventory_buildingma_est_id_b3bc2290_fk_inventory FOREIGN KEY (est_id) REFERENCES public.inventory_courtestablishmentmaster(est_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_employee_journey inventory_employee_j_sdm_id_873fddb9_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_employee_journey
    ADD CONSTRAINT inventory_employee_j_sdm_id_873fddb9_fk_inventory FOREIGN KEY (sdm_id) REFERENCES public.inventory_sectiondesignationmapper(sdm_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_employee_journey inventory_employee_j_usr_id_cf4ef38b_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_employee_journey
    ADD CONSTRAINT inventory_employee_j_usr_id_cf4ef38b_fk_inventory FOREIGN KEY (usr_id) REFERENCES public.inventory_userdetails(usr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_healthstatusdetails inventory_healthstat_product_id_d8f07cae_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_healthstatusdetails
    ADD CONSTRAINT inventory_healthstat_product_id_d8f07cae_fk_inventory FOREIGN KEY (product_id) REFERENCES public.inventory_productdetails(product_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_productcompanymaster inventory_productcom_product_cat_id_4c95d812_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_productcompanymaster
    ADD CONSTRAINT inventory_productcom_product_cat_id_4c95d812_fk_inventory FOREIGN KEY (product_cat_id) REFERENCES public.inventory_productcategorymaster(product_cat_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_productdetails inventory_productdet_product_mod_id_8db622f4_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_productdetails
    ADD CONSTRAINT inventory_productdet_product_mod_id_8db622f4_fk_inventory FOREIGN KEY (product_mod_id) REFERENCES public.inventory_productmodelmaster(product_mod_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_productdetails inventory_productdet_propur_id_b5464de4_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_productdetails
    ADD CONSTRAINT inventory_productdet_propur_id_b5464de4_fk_inventory FOREIGN KEY (propur_id) REFERENCES public.inventory_productpuchasedetails(propur_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_productmodelmaster inventory_productmod_product_com_id_ce5a7d6b_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_productmodelmaster
    ADD CONSTRAINT inventory_productmod_product_com_id_ce5a7d6b_fk_inventory FOREIGN KEY (product_com_id) REFERENCES public.inventory_productcompanymaster(product_com_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_productpuchasedetails inventory_productpuc_product_id_dc58953d_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_productpuchasedetails
    ADD CONSTRAINT inventory_productpuc_product_id_dc58953d_fk_inventory FOREIGN KEY (product_id) REFERENCES public.inventory_productmodelmaster(product_mod_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_productpuchasedetails inventory_productpuc_purchase_id_b7732065_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_productpuchasedetails
    ADD CONSTRAINT inventory_productpuc_purchase_id_b7732065_fk_inventory FOREIGN KEY (purchase_id) REFERENCES public.inventory_purchasedetails(purchase_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_producttransactiondetails inventory_producttra_productid_id_0e733838_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_producttransactiondetails
    ADD CONSTRAINT inventory_producttra_productid_id_0e733838_fk_inventory FOREIGN KEY (productid_id) REFERENCES public.inventory_productdetails(product_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_producttransactiondetails inventory_producttra_trans_id_ac39b32f_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_producttransactiondetails
    ADD CONSTRAINT inventory_producttra_trans_id_ac39b32f_fk_inventory FOREIGN KEY (trans_id) REFERENCES public.inventory_transactiondetails(trans_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_sectiondesignationmapper inventory_sectiondes_section_id_178f215b_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_sectiondesignationmapper
    ADD CONSTRAINT inventory_sectiondes_section_id_178f215b_fk_inventory FOREIGN KEY (section_id) REFERENCES public.inventory_sectiondetails(section_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_sectiondesignationmapper inventory_sectiondes_staff_id_73779617_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_sectiondesignationmapper
    ADD CONSTRAINT inventory_sectiondes_staff_id_73779617_fk_inventory FOREIGN KEY (staff_id) REFERENCES public.inventory_staffdesignationmaster(staff_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_sectiondetails inventory_sectiondet_building_id_9893d197_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_sectiondetails
    ADD CONSTRAINT inventory_sectiondet_building_id_9893d197_fk_inventory FOREIGN KEY (building_id) REFERENCES public.inventory_buildingmaster(building_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inventory_transactiondetails inventory_transactio_sdm_id_f98cac0e_fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_transactiondetails
    ADD CONSTRAINT inventory_transactio_sdm_id_f98cac0e_fk_inventory FOREIGN KEY (sdm_id) REFERENCES public.inventory_sectiondesignationmapper(sdm_id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

