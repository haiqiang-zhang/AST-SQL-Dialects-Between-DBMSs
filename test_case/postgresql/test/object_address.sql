SET client_min_messages TO 'warning';
RESET client_min_messages;
CREATE SCHEMA addr_nsp;
SET search_path TO 'addr_nsp';
CREATE TEXT SEARCH DICTIONARY addr_ts_dict (template=simple);
CREATE TEXT SEARCH CONFIGURATION addr_ts_conf (copy=english);
CREATE TABLE addr_nsp.gentable (
    a serial primary key CONSTRAINT a_chk CHECK (a > 0),
    b text DEFAULT 'hello'
);
CREATE TABLE addr_nsp.parttable (
    a int PRIMARY KEY
) PARTITION BY RANGE (a);
CREATE VIEW addr_nsp.genview AS SELECT * from addr_nsp.gentable;
CREATE MATERIALIZED VIEW addr_nsp.genmatview AS SELECT * FROM addr_nsp.gentable;
CREATE TYPE addr_nsp.gencomptype AS (a int);
CREATE TYPE addr_nsp.genenum AS ENUM ('one', 'two');
CREATE AGGREGATE addr_nsp.genaggr(int4) (sfunc = int4pl, stype = int4);
CREATE DOMAIN addr_nsp.gendomain AS int4 CONSTRAINT domconstr CHECK (value > 0);
CREATE POLICY genpol ON addr_nsp.gentable;
CREATE PROCEDURE addr_nsp.proc(int4) LANGUAGE SQL AS $$ $$;
SET client_min_messages = 'ERROR';
CREATE PUBLICATION addr_pub FOR TABLE addr_nsp.gentable;
RESET client_min_messages;
CREATE STATISTICS addr_nsp.gentable_stat ON a, b FROM addr_nsp.gentable;
END;
END;
DROP PUBLICATION addr_pub;
DROP SCHEMA addr_nsp CASCADE;
WITH objects (classid, objid, objsubid) AS (VALUES
    ('pg_class'::regclass, 0, 0), 
    ('pg_class'::regclass, 'pg_class'::regclass, 100), 
    ('pg_proc'::regclass, 0, 0), 
    ('pg_type'::regclass, 0, 0), 
    ('pg_cast'::regclass, 0, 0), 
    ('pg_collation'::regclass, 0, 0), 
    ('pg_constraint'::regclass, 0, 0), 
    ('pg_conversion'::regclass, 0, 0), 
    ('pg_attrdef'::regclass, 0, 0), 
    ('pg_language'::regclass, 0, 0), 
    ('pg_largeobject'::regclass, 0, 0), 
    ('pg_operator'::regclass, 0, 0), 
    ('pg_opclass'::regclass, 0, 0), 
    ('pg_opfamily'::regclass, 0, 0), 
    ('pg_am'::regclass, 0, 0), 
    ('pg_amop'::regclass, 0, 0), 
    ('pg_amproc'::regclass, 0, 0), 
    ('pg_rewrite'::regclass, 0, 0), 
    ('pg_trigger'::regclass, 0, 0), 
    ('pg_namespace'::regclass, 0, 0), 
    ('pg_statistic_ext'::regclass, 0, 0), 
    ('pg_ts_parser'::regclass, 0, 0), 
    ('pg_ts_dict'::regclass, 0, 0), 
    ('pg_ts_template'::regclass, 0, 0), 
    ('pg_ts_config'::regclass, 0, 0), 
    ('pg_authid'::regclass, 0, 0), 
    ('pg_auth_members'::regclass, 0, 0),  
    ('pg_database'::regclass, 0, 0), 
    ('pg_tablespace'::regclass, 0, 0), 
    ('pg_foreign_data_wrapper'::regclass, 0, 0), 
    ('pg_foreign_server'::regclass, 0, 0), 
    ('pg_user_mapping'::regclass, 0, 0), 
    ('pg_default_acl'::regclass, 0, 0), 
    ('pg_extension'::regclass, 0, 0), 
    ('pg_event_trigger'::regclass, 0, 0), 
    ('pg_parameter_acl'::regclass, 0, 0), 
    ('pg_policy'::regclass, 0, 0), 
    ('pg_publication'::regclass, 0, 0), 
    ('pg_publication_namespace'::regclass, 0, 0), 
    ('pg_publication_rel'::regclass, 0, 0), 
    ('pg_subscription'::regclass, 0, 0), 
    ('pg_transform'::regclass, 0, 0) 
  )
SELECT ROW(pg_identify_object(objects.classid, objects.objid, objects.objsubid))
         AS ident,
       ROW(pg_identify_object_as_address(objects.classid, objects.objid, objects.objsubid))
         AS addr,
       pg_describe_object(objects.classid, objects.objid, objects.objsubid)
         AS descr
FROM objects
ORDER BY objects.classid, objects.objid, objects.objsubid;
