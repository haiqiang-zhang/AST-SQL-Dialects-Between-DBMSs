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
