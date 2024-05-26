SET client_min_messages TO 'warning';
SELECT lo_unlink(oid) FROM pg_largeobject_metadata WHERE oid >= 1000 AND oid < 3000 ORDER BY oid;
RESET client_min_messages;
BEGIN;
ROLLBACK;
RESET ROLE;
RESET SESSION AUTHORIZATION;
RESET ROLE;
RESET SESSION AUTHORIZATION;
RESET ROLE;
RESET SESSION AUTHORIZATION;
RESET SESSION AUTHORIZATION;
SELECT session_user, current_user;
CREATE TABLE atest1 ( a int, b text );
SELECT * FROM atest1;
INSERT INTO atest1 VALUES (1, 'one');
DELETE FROM atest1;
UPDATE atest1 SET a = 1 WHERE b = 'blech';
TRUNCATE atest1;
BEGIN;
LOCK atest1 IN ACCESS EXCLUSIVE MODE;
COMMIT;
REVOKE ALL ON atest1 FROM PUBLIC;
SELECT * FROM atest1;
SELECT * FROM atest1;
CREATE TABLE atest2 (col1 varchar(10), col2 boolean);
SELECT session_user, current_user;
SELECT * FROM atest1;
SELECT * FROM atest2;
INSERT INTO atest1 VALUES (2, 'two');
INSERT INTO atest2 VALUES ('foo', true);
INSERT INTO atest1 SELECT 1, b FROM atest1;
UPDATE atest1 SET a = 1 WHERE a = 2;
UPDATE atest2 SET col2 = NOT col2;
SELECT * FROM atest1 FOR UPDATE;
SELECT * FROM atest2 FOR UPDATE;
DELETE FROM atest2;
TRUNCATE atest2;
BEGIN;
LOCK atest2 IN ACCESS EXCLUSIVE MODE;
COMMIT;
GRANT ALL ON atest1 TO PUBLIC;
SELECT * FROM atest1 WHERE ( b IN ( SELECT col1 FROM atest2 ) );
SELECT * FROM atest2 WHERE ( col1 IN ( SELECT b FROM atest1 ) );
SELECT * FROM atest1;
SELECT * FROM atest2;
INSERT INTO atest2 VALUES ('foo', true);
SELECT * FROM atest1;
SELECT * FROM atest2;
INSERT INTO atest2 VALUES ('foo', true);
UPDATE atest2 SET col2 = true;
DELETE FROM atest2;
SELECT session_user, current_user;
SELECT * FROM atest1;
SELECT * FROM atest2;
INSERT INTO atest1 VALUES (2, 'two');
INSERT INTO atest2 VALUES ('foo', true);
INSERT INTO atest1 SELECT 1, b FROM atest1;
UPDATE atest1 SET a = 1 WHERE a = 2;
UPDATE atest2 SET col2 = NULL;
UPDATE atest2 SET col2 = NOT col2;
UPDATE atest2 SET col2 = true FROM atest1 WHERE atest1.a = 5;
SELECT * FROM atest1 FOR UPDATE;
SELECT * FROM atest2 FOR UPDATE;
DELETE FROM atest2;
TRUNCATE atest2;
BEGIN;
LOCK atest2 IN ACCESS EXCLUSIVE MODE;
COMMIT;
SELECT * FROM atest1 WHERE ( b IN ( SELECT col1 FROM atest2 ) );
SELECT * FROM atest2 WHERE ( col1 IN ( SELECT b FROM atest1 ) );
CREATE TABLE atest12 as
  SELECT x AS a, 10001 - x AS b FROM generate_series(1,10000) x;
CREATE INDEX ON atest12 (a);
CREATE INDEX ON atest12 (abs(a));
ALTER TABLE atest12 SET (autovacuum_enabled = off);
SET default_statistics_target = 10000;
VACUUM ANALYZE atest12;
RESET default_statistics_target;
GRANT SELECT (a, b) ON atest12 TO PUBLIC;
CREATE TABLE atest3 (one int, two int, three int);
SELECT * FROM atest3;
DELETE FROM atest3;
BEGIN;
RESET SESSION AUTHORIZATION;
ROLLBACK;
CREATE VIEW atestv1 AS SELECT * FROM atest1;
CREATE VIEW atestv2 AS SELECT * FROM atest2;
CREATE VIEW atestv3 AS SELECT * FROM atest3;
CREATE VIEW atestv0 AS SELECT 0 as x WHERE false;
SELECT * FROM atestv1;
SELECT * FROM atestv2;
SELECT * FROM atestv1;
SELECT * FROM atestv2;
SELECT * FROM atestv3;
SELECT * FROM atestv0;
set constraint_exclusion = on;
reset constraint_exclusion;
CREATE VIEW atestv4 AS SELECT * FROM atestv3;
SELECT * FROM atestv4;
SELECT * FROM atestv3;
SELECT * FROM atestv4;
SELECT * FROM atest2;
SELECT * FROM atestv2;
CREATE TABLE atest5 (one int, two int unique, three int, four int unique);
CREATE TABLE atest6 (one int, two int, blue int);
INSERT INTO atest5 VALUES (1,2,3);
SELECT * FROM atest5;
SELECT one FROM atest5;
SELECT two FROM atest5;
SELECT atest5 FROM atest5;
SELECT 1 FROM atest5;
SELECT 1 FROM atest5 a JOIN atest5 b USING (one);
SELECT 1 FROM atest5 a JOIN atest5 b USING (two);
SELECT 1 FROM atest5 a NATURAL JOIN atest5 b;
SELECT * FROM (atest5 a JOIN atest5 b USING (one)) j;
SELECT j.* FROM (atest5 a JOIN atest5 b USING (one)) j;
SELECT (j.*) IS NULL FROM (atest5 a JOIN atest5 b USING (one)) j;
SELECT one FROM (atest5 a JOIN atest5 b(one,x,y,z) USING (one)) j;
SELECT j.one FROM (atest5 a JOIN atest5 b(one,x,y,z) USING (one)) j;
SELECT two FROM (atest5 a JOIN atest5 b(one,x,y,z) USING (one)) j;
SELECT j.two FROM (atest5 a JOIN atest5 b(one,x,y,z) USING (one)) j;
SELECT y FROM (atest5 a JOIN atest5 b(one,x,y,z) USING (one)) j;
SELECT j.y FROM (atest5 a JOIN atest5 b(one,x,y,z) USING (one)) j;
SELECT * FROM (atest5 a JOIN atest5 b USING (one));
SELECT a.* FROM (atest5 a JOIN atest5 b USING (one));
SELECT (a.*) IS NULL FROM (atest5 a JOIN atest5 b USING (one));
SELECT two FROM (atest5 a JOIN atest5 b(one,x,y,z) USING (one));
SELECT a.two FROM (atest5 a JOIN atest5 b(one,x,y,z) USING (one));
SELECT y FROM (atest5 a JOIN atest5 b(one,x,y,z) USING (one));
SELECT b.y FROM (atest5 a JOIN atest5 b(one,x,y,z) USING (one));
SELECT y FROM (atest5 a LEFT JOIN atest5 b(one,x,y,z) USING (one));
SELECT b.y FROM (atest5 a LEFT JOIN atest5 b(one,x,y,z) USING (one));
SELECT y FROM (atest5 a FULL JOIN atest5 b(one,x,y,z) USING (one));
SELECT b.y FROM (atest5 a FULL JOIN atest5 b(one,x,y,z) USING (one));
SELECT 1 FROM atest5 WHERE two = 2;
SELECT * FROM atest1, atest5;
SELECT atest1.* FROM atest1, atest5;
SELECT atest1.*,atest5.one FROM atest1, atest5;
SELECT atest1.*,atest5.one FROM atest1 JOIN atest5 ON (atest1.a = atest5.two);
SELECT atest1.*,atest5.one FROM atest1 JOIN atest5 ON (atest1.a = atest5.one);
SELECT one, two FROM atest5;
SELECT one, two FROM atest5 NATURAL JOIN atest6;
SELECT one, two FROM atest5 NATURAL JOIN atest6;
INSERT INTO atest5 (two) VALUES (3);
INSERT INTO atest5 VALUES (5,5,5);
UPDATE atest5 SET three = 10;
UPDATE atest5 SET one = 8;
UPDATE atest5 SET three = 5, one = 2;
INSERT INTO atest5(two) VALUES (6) ON CONFLICT (two) DO UPDATE set three = 10;
INSERT INTO atest5(two) VALUES (6) ON CONFLICT (two) DO UPDATE set three = 10 RETURNING atest5.three;
INSERT INTO atest5(two) VALUES (6) ON CONFLICT (two) DO UPDATE set three = 10 RETURNING atest5.one;
INSERT INTO atest5(two) VALUES (6) ON CONFLICT (two) DO UPDATE set three = EXCLUDED.one;
INSERT INTO atest5(two) VALUES (6) ON CONFLICT (two) DO UPDATE set three = EXCLUDED.three;
INSERT INTO atest5(two) VALUES (6) ON CONFLICT (two) DO UPDATE set one = 8;
INSERT INTO atest5(three) VALUES (4) ON CONFLICT (two) DO UPDATE set three = 10;
INSERT INTO atest5(four) VALUES (4);
INSERT INTO atest5(four) VALUES (4) ON CONFLICT (four) DO UPDATE set three = 3;
INSERT INTO atest5(four) VALUES (4) ON CONFLICT ON CONSTRAINT atest5_four_key DO UPDATE set three = 3;
INSERT INTO atest5(four) VALUES (4) ON CONFLICT (four) DO UPDATE set three = 3;
INSERT INTO atest5(four) VALUES (4) ON CONFLICT ON CONSTRAINT atest5_four_key DO UPDATE set three = 3;
SELECT one FROM atest5;
UPDATE atest5 SET one = 1;
SELECT atest6 FROM atest6;
CREATE TABLE mtarget (a int, b text);
CREATE TABLE msource (a int, b text);
INSERT INTO mtarget VALUES (1, 'init1'), (2, 'init2');
INSERT INTO msource VALUES (1, 'source1'), (2, 'source2'), (3, 'source3');
MERGE INTO mtarget t USING msource s ON t.a = s.a
WHEN MATCHED THEN
	UPDATE SET b = s.b
WHEN NOT MATCHED THEN
	INSERT VALUES (a, NULL);
MERGE INTO mtarget t USING msource s ON t.a = s.a
WHEN MATCHED THEN
	UPDATE SET b = 'x'
WHEN NOT MATCHED THEN
	INSERT VALUES (a, b);
MERGE INTO mtarget t USING msource s ON t.a = s.a
WHEN MATCHED AND s.b = 'x' THEN
	UPDATE SET b = 'x'
WHEN NOT MATCHED THEN
	INSERT VALUES (a, NULL);
BEGIN;
MERGE INTO mtarget t USING msource s ON t.a = s.a
WHEN MATCHED THEN
	UPDATE SET b = 'ok'
WHEN NOT MATCHED THEN
	INSERT VALUES (a, NULL);
ROLLBACK;
BEGIN;
MERGE INTO mtarget t USING msource s ON t.a = s.a
WHEN MATCHED THEN
	UPDATE SET b = s.b
WHEN NOT MATCHED THEN
	INSERT VALUES (a, b);
ROLLBACK;
MERGE INTO mtarget t USING msource s ON t.a = s.a
WHEN MATCHED THEN
	UPDATE SET b = t.b
WHEN NOT MATCHED THEN
	INSERT VALUES (a, NULL);
MERGE INTO mtarget t USING msource s ON t.a = s.a
WHEN MATCHED THEN
	UPDATE SET b = s.b, a = t.a + 1
WHEN NOT MATCHED THEN
	INSERT VALUES (a, b);
MERGE INTO mtarget t USING msource s ON t.a = s.a
WHEN MATCHED AND t.b IS NOT NULL THEN
	UPDATE SET b = s.b
WHEN NOT MATCHED THEN
	INSERT VALUES (a, b);
BEGIN;
MERGE INTO mtarget t USING msource s ON t.a = s.a
WHEN MATCHED THEN
	UPDATE SET b = s.b;
ROLLBACK;
MERGE INTO mtarget t USING msource s ON t.a = s.a
WHEN MATCHED AND t.b IS NOT NULL THEN
	DELETE;
BEGIN;
MERGE INTO mtarget t USING msource s ON t.a = s.a
WHEN MATCHED AND t.b IS NOT NULL THEN
	DELETE;
ROLLBACK;
CREATE TABLE t1 (c1 int, c2 int, c3 int check (c3 < 5), primary key (c1, c2));
INSERT INTO t1 VALUES (1, 1, 1);
INSERT INTO t1 VALUES (1, 2, 1);
INSERT INTO t1 VALUES (2, 1, 2);
INSERT INTO t1 VALUES (2, 2, 2);
INSERT INTO t1 VALUES (3, 1, 3);
DROP TABLE t1;
CREATE TABLE errtst(a text, b text NOT NULL, c text, secret1 text, secret2 text) PARTITION BY LIST (a);
CREATE TABLE errtst_part_1(secret2 text, c text, a text, b text NOT NULL, secret1 text);
CREATE TABLE errtst_part_2(secret1 text, secret2 text, a text, c text, b text NOT NULL);
ALTER TABLE errtst ATTACH PARTITION errtst_part_1 FOR VALUES IN ('aaa');
ALTER TABLE errtst ATTACH PARTITION errtst_part_2 FOR VALUES IN ('aaaa');
INSERT INTO errtst_part_1 (a, b, c, secret1, secret2)
VALUES ('aaa', 'bbb', 'ccc', 'the body', 'is in the attic');
DROP TABLE errtst;
ALTER TABLE atest6 ADD COLUMN three integer;
SELECT atest6 FROM atest6;
SELECT one FROM atest5 NATURAL JOIN atest6;
ALTER TABLE atest6 DROP COLUMN three;
SELECT atest6 FROM atest6;
SELECT one FROM atest5 NATURAL JOIN atest6;
ALTER TABLE atest6 DROP COLUMN two;
SELECT * FROM atest6;
SELECT 1 FROM atest6;
DELETE FROM atest5 WHERE one = 1;
DELETE FROM atest5 WHERE two = 2;
CREATE TABLE atestp1 (f1 int, f2 int);
CREATE TABLE atestp2 (fx int, fy int);
CREATE TABLE atestc (fz int) INHERITS (atestp1, atestp2);
SELECT fx FROM atestp2;
SELECT fy FROM atestp2;
SELECT atestp2 FROM atestp2;
SELECT tableoid FROM atestp2;
SELECT fy FROM atestc;
SELECT fx FROM atestp2;
SELECT fy FROM atestp2;
SELECT atestp2 FROM atestp2;
SELECT tableoid FROM atestp2;
SELECT f2 FROM atestp1;
SELECT f2 FROM atestc;
DELETE FROM atestp1;
DELETE FROM atestc;
UPDATE atestp1 SET f1 = 1;
UPDATE atestc SET f1 = 1;
TRUNCATE atestp1;
TRUNCATE atestc;
BEGIN;
LOCK atestp1;
END;
BEGIN;
LOCK atestc;
END;
REVOKE ALL PRIVILEGES ON LANGUAGE sql FROM PUBLIC;
CREATE AGGREGATE priv_testagg1(int) (sfunc = int4pl, stype = int4);
SELECT priv_testagg1(x) FROM (VALUES (1), (2), (3)) _(x);
SELECT priv_testagg1(x) FROM (VALUES (1), (2), (3)) _(x);
SELECT col1 FROM atest2 WHERE col2 = true;
SELECT priv_testagg1(x) FROM (VALUES (1), (2), (3)) _(x);
DROP AGGREGATE priv_testagg1(int);
GRANT ALL PRIVILEGES ON LANGUAGE sql TO PUBLIC;
BEGIN;
SELECT '{1}'::int4[]::int8[];
REVOKE ALL ON FUNCTION int8(integer) FROM PUBLIC;
SELECT '{1}'::int4[]::int8[];
ROLLBACK;
CREATE TYPE priv_testtype1 AS (a int, b text);
REVOKE USAGE ON TYPE priv_testtype1 FROM PUBLIC;
CREATE DOMAIN priv_testdomain1 AS int;
REVOKE USAGE on DOMAIN priv_testdomain1 FROM PUBLIC;
CREATE AGGREGATE priv_testagg1a(priv_testdomain1) (sfunc = int4_sum, stype = bigint);
CREATE DOMAIN priv_testdomain2a AS priv_testdomain1;
CREATE DOMAIN priv_testdomain3a AS int;
CREATE FUNCTION castfunc(int) RETURNS priv_testdomain3a AS $$ SELECT $1::priv_testdomain3a $$ LANGUAGE SQL;
CREATE CAST (priv_testdomain1 AS priv_testdomain3a) WITH FUNCTION castfunc(int);
DROP FUNCTION castfunc(int) CASCADE;
DROP DOMAIN priv_testdomain3a;
CREATE FUNCTION priv_testfunc5a(a priv_testdomain1) RETURNS int LANGUAGE SQL AS $$ SELECT $1 $$;
CREATE FUNCTION priv_testfunc6a(b int) RETURNS priv_testdomain1 LANGUAGE SQL AS $$ SELECT $1::priv_testdomain1 $$;
CREATE TABLE test5a (a int, b priv_testdomain1);
CREATE TABLE test6a OF priv_testtype1;
CREATE TABLE test10a (a int[], b priv_testtype1[]);
CREATE TABLE test9a (a int, b int);
ALTER TABLE test9a ADD COLUMN c priv_testdomain1;
ALTER TABLE test9a ALTER COLUMN b TYPE priv_testdomain1;
CREATE TYPE test7a AS (a int, b priv_testdomain1);
CREATE TYPE test8a AS (a int, b int);
ALTER TYPE test8a ADD ATTRIBUTE c priv_testdomain1;
ALTER TYPE test8a ALTER ATTRIBUTE b TYPE priv_testdomain1;
CREATE TABLE test11a AS (SELECT 1::priv_testdomain1 AS a);
REVOKE ALL ON TYPE priv_testtype1 FROM PUBLIC;
CREATE AGGREGATE priv_testagg1b(priv_testdomain1) (sfunc = int4_sum, stype = bigint);
CREATE DOMAIN priv_testdomain2b AS priv_testdomain1;
CREATE DOMAIN priv_testdomain3b AS int;
CREATE FUNCTION castfunc(int) RETURNS priv_testdomain3b AS $$ SELECT $1::priv_testdomain3b $$ LANGUAGE SQL;
CREATE CAST (priv_testdomain1 AS priv_testdomain3b) WITH FUNCTION castfunc(int);
CREATE FUNCTION priv_testfunc5b(a priv_testdomain1) RETURNS int LANGUAGE SQL AS $$ SELECT $1 $$;
CREATE FUNCTION priv_testfunc6b(b int) RETURNS priv_testdomain1 LANGUAGE SQL AS $$ SELECT $1::priv_testdomain1 $$;
CREATE OPERATOR !! (PROCEDURE = priv_testfunc5b, RIGHTARG = priv_testdomain1);
CREATE TABLE test5b (a int, b priv_testdomain1);
CREATE TABLE test6b OF priv_testtype1;
CREATE TABLE test10b (a int[], b priv_testtype1[]);
CREATE TABLE test9b (a int, b int);
ALTER TABLE test9b ADD COLUMN c priv_testdomain1;
ALTER TABLE test9b ALTER COLUMN b TYPE priv_testdomain1;
CREATE TYPE test7b AS (a int, b priv_testdomain1);
CREATE TYPE test8b AS (a int, b int);
ALTER TYPE test8b ADD ATTRIBUTE c priv_testdomain1;
ALTER TYPE test8b ALTER ATTRIBUTE b TYPE priv_testdomain1;
CREATE TABLE test11b AS (SELECT 1::priv_testdomain1 AS a);
REVOKE ALL ON TYPE priv_testtype1 FROM PUBLIC;
DROP AGGREGATE priv_testagg1b(priv_testdomain1);
DROP DOMAIN priv_testdomain2b;
DROP OPERATOR !! (NONE, priv_testdomain1);
DROP FUNCTION priv_testfunc5b(a priv_testdomain1);
DROP FUNCTION priv_testfunc6b(b int);
DROP TABLE test5b;
DROP TABLE test6b;
DROP TABLE test9b;
DROP TABLE test10b;
DROP TYPE test7b;
DROP TYPE test8b;
DROP CAST (priv_testdomain1 AS priv_testdomain3b);
DROP FUNCTION castfunc(int) CASCADE;
DROP DOMAIN priv_testdomain3b;
DROP TABLE test11b;
TRUNCATE atest2;
TRUNCATE atest3;
select has_table_privilege(NULL,'pg_authid','select');
select has_table_privilege(-999999,'pg_authid','update');
select has_table_privilege(1,'select');
select has_table_privilege(current_user,'pg_authid','select');
select has_table_privilege(current_user,'pg_authid','insert');
select has_table_privilege(t2.oid,'pg_authid','update')
from (select oid from pg_roles where rolname = current_user) as t2;
select has_table_privilege(t2.oid,'pg_authid','delete')
from (select oid from pg_roles where rolname = current_user) as t2;
select has_table_privilege(current_user,t1.oid,'rule')
from (select oid from pg_class where relname = 'pg_authid') as t1;
select has_table_privilege(current_user,t1.oid,'references')
from (select oid from pg_class where relname = 'pg_authid') as t1;
select has_table_privilege(t2.oid,t1.oid,'select')
from (select oid from pg_class where relname = 'pg_authid') as t1,
  (select oid from pg_roles where rolname = current_user) as t2;
select has_table_privilege(t2.oid,t1.oid,'insert')
from (select oid from pg_class where relname = 'pg_authid') as t1,
  (select oid from pg_roles where rolname = current_user) as t2;
select has_table_privilege('pg_authid','update');
select has_table_privilege('pg_authid','delete');
select has_table_privilege('pg_authid','truncate');
select has_table_privilege(t1.oid,'select')
from (select oid from pg_class where relname = 'pg_authid') as t1;
select has_table_privilege(t1.oid,'trigger')
from (select oid from pg_class where relname = 'pg_authid') as t1;
select has_table_privilege(current_user,'pg_class','select');
select has_table_privilege(current_user,'pg_class','insert');
select has_table_privilege(t2.oid,'pg_class','update')
from (select oid from pg_roles where rolname = current_user) as t2;
select has_table_privilege(t2.oid,'pg_class','delete')
from (select oid from pg_roles where rolname = current_user) as t2;
select has_table_privilege(current_user,t1.oid,'references')
from (select oid from pg_class where relname = 'pg_class') as t1;
select has_table_privilege(t2.oid,t1.oid,'select')
from (select oid from pg_class where relname = 'pg_class') as t1,
  (select oid from pg_roles where rolname = current_user) as t2;
select has_table_privilege(t2.oid,t1.oid,'insert')
from (select oid from pg_class where relname = 'pg_class') as t1,
  (select oid from pg_roles where rolname = current_user) as t2;
select has_table_privilege('pg_class','update');
select has_table_privilege('pg_class','delete');
select has_table_privilege('pg_class','truncate');
select has_table_privilege(t1.oid,'select')
from (select oid from pg_class where relname = 'pg_class') as t1;
select has_table_privilege(t1.oid,'trigger')
from (select oid from pg_class where relname = 'pg_class') as t1;
select has_table_privilege(current_user,'atest1','select');
select has_table_privilege(current_user,'atest1','insert');
select has_table_privilege(t2.oid,'atest1','update')
from (select oid from pg_roles where rolname = current_user) as t2;
select has_table_privilege(t2.oid,'atest1','delete')
from (select oid from pg_roles where rolname = current_user) as t2;
select has_table_privilege(current_user,t1.oid,'references')
from (select oid from pg_class where relname = 'atest1') as t1;
select has_table_privilege(t2.oid,t1.oid,'select')
from (select oid from pg_class where relname = 'atest1') as t1,
  (select oid from pg_roles where rolname = current_user) as t2;
select has_table_privilege(t2.oid,t1.oid,'insert')
from (select oid from pg_class where relname = 'atest1') as t1,
  (select oid from pg_roles where rolname = current_user) as t2;
select has_table_privilege('atest1','update');
select has_table_privilege('atest1','delete');
select has_table_privilege('atest1','truncate');
select has_table_privilege(t1.oid,'select')
from (select oid from pg_class where relname = 'atest1') as t1;
select has_table_privilege(t1.oid,'trigger')
from (select oid from pg_class where relname = 'atest1') as t1;
select has_column_privilege('pg_authid',NULL,'select');
select has_column_privilege(9999,'nosuchcol','select');
select has_column_privilege(9999,99::int2,'select');
select has_column_privilege('pg_authid',99::int2,'select');
select has_column_privilege(9999,99::int2,'select');
create temp table mytable(f1 int, f2 int, f3 int);
alter table mytable drop column f2;
select has_column_privilege('mytable','........pg.dropped.2........','select');
select has_column_privilege('mytable',2::int2,'select');
select has_column_privilege('mytable',99::int2,'select');
select has_column_privilege('mytable',2::int2,'select');
select has_column_privilege('mytable',99::int2,'select');
drop table mytable;
CREATE TABLE atest4 (a int);
END;
CREATE TABLE sro_tab (a int);
INSERT INTO sro_tab VALUES (1), (2), (3);
REINDEX TABLE sro_tab;
REINDEX TABLE CONCURRENTLY sro_tab;
DROP TABLE sro_tab;
CREATE TABLE sro_ptab (a int) PARTITION BY RANGE (a);
CREATE TABLE sro_part PARTITION OF sro_ptab FOR VALUES FROM (1) TO (10);
INSERT INTO sro_ptab VALUES (1), (2), (3);
REINDEX TABLE sro_ptab;
CREATE FUNCTION unwanted_grant() RETURNS void LANGUAGE sql AS
	'GRANT regress_priv_group2 TO regress_sro_user';
CREATE TABLE sro_trojan_table ();
BEGIN;
SET CONSTRAINTS ALL IMMEDIATE;
COMMIT;
CREATE MATERIALIZED VIEW sro_index_mv AS SELECT 1 AS c;
REFRESH MATERIALIZED VIEW sro_index_mv;
CREATE FUNCTION dogrant_ok() RETURNS void LANGUAGE sql SECURITY DEFINER AS
	'GRANT regress_priv_group2 TO regress_priv_user5';
DROP FUNCTION dogrant_ok();
CREATE SEQUENCE x_seq;
SELECT has_sequence_privilege('x_seq', 'USAGE');
SELECT lo_create(1001);
SELECT lo_create(1002);
SELECT lo_create(1003);
SELECT lo_create(1004);
SELECT lo_create(1005);
GRANT ALL ON LARGE OBJECT 1001 TO PUBLIC;
SELECT lo_create(2001);
SELECT lo_create(2002);
SELECT lowrite(lo_open(1001, x'20000'::int), 'abcd');
SELECT lowrite(lo_open(1002, x'20000'::int), 'abcd');
SELECT lowrite(lo_open(1003, x'20000'::int), 'abcd');
SELECT lowrite(lo_open(1004, x'20000'::int), 'abcd');
REVOKE ALL ON LARGE OBJECT 2001, 2002 FROM PUBLIC;
SELECT lo_unlink(1001);
SELECT lo_unlink(2002);
SELECT oid, pg_get_userbyid(lomowner) ownername, lomacl FROM pg_largeobject_metadata WHERE oid >= 1000 AND oid < 3000 ORDER BY oid;
SELECT lo_truncate(lo_open(1005, x'20000'::int), 10);
SELECT lo_truncate(lo_open(2001, x'20000'::int), 10);
SELECT lowrite(lo_open(1002, x'20000'::int), 'abcd');
SELECT lo_truncate(lo_open(1002, x'20000'::int), 10);
SELECT lo_put(1002, 1, 'abcd');
SELECT lo_unlink(1002);
RESET SESSION AUTHORIZATION;
BEGIN;
ROLLBACK;
RESET SESSION AUTHORIZATION;
CREATE TABLE datdba_only ();
ALTER TABLE datdba_only OWNER TO pg_database_owner;
REVOKE DELETE ON datdba_only FROM pg_database_owner;
BEGIN;
ROLLBACK;
CREATE SCHEMA testns;
CREATE TABLE testns.acltest1 (x int);
ALTER DEFAULT PRIVILEGES IN SCHEMA testns,testns GRANT SELECT ON TABLES TO public,public;
DROP TABLE testns.acltest1;
CREATE TABLE testns.acltest1 (x int);
DROP TABLE testns.acltest1;
CREATE TABLE testns.acltest1 (x int);
DROP TABLE testns.acltest1;
CREATE TABLE testns.acltest1 (x int);
SELECT pg_input_is_valid('regress_priv_user1=r/regress_priv_user2', 'aclitem');
SELECT pg_input_is_valid('regress_priv_user1=r/', 'aclitem');
SELECT * FROM pg_input_error_info('regress_priv_user1=r/', 'aclitem');
SELECT pg_input_is_valid('regress_priv_user1=r/regress_no_such_user', 'aclitem');
SELECT * FROM pg_input_error_info('regress_priv_user1=r/regress_no_such_user', 'aclitem');
SELECT pg_input_is_valid('regress_priv_user1=rY', 'aclitem');
SELECT * FROM pg_input_error_info('regress_priv_user1=rY', 'aclitem');
BEGIN;
COMMIT;
BEGIN;
ROLLBACK;
CREATE SCHEMA testns5;
CREATE FUNCTION testns.foo() RETURNS int AS 'select 1' LANGUAGE sql;
CREATE AGGREGATE testns.agg1(int) (sfunc = int4pl, stype = int4);
CREATE PROCEDURE testns.bar() AS 'select 1' LANGUAGE sql;
ALTER DEFAULT PRIVILEGES IN SCHEMA testns GRANT EXECUTE ON ROUTINES to public;
DROP FUNCTION testns.foo();
CREATE FUNCTION testns.foo() RETURNS int AS 'select 1' LANGUAGE sql;
DROP AGGREGATE testns.agg1(int);
CREATE AGGREGATE testns.agg1(int) (sfunc = int4pl, stype = int4);
DROP PROCEDURE testns.bar();
CREATE PROCEDURE testns.bar() AS 'select 1' LANGUAGE sql;
DROP FUNCTION testns.foo();
DROP AGGREGATE testns.agg1(int);
DROP PROCEDURE testns.bar();
CREATE DOMAIN testns.priv_testdomain1 AS int;
ALTER DEFAULT PRIVILEGES IN SCHEMA testns GRANT USAGE ON TYPES to public;
DROP DOMAIN testns.priv_testdomain1;
CREATE DOMAIN testns.priv_testdomain1 AS int;
DROP DOMAIN testns.priv_testdomain1;
RESET ROLE;
SELECT count(*)
  FROM pg_default_acl d LEFT JOIN pg_namespace n ON defaclnamespace = n.oid
  WHERE nspname = 'testns';
DROP SCHEMA testns CASCADE;
DROP SCHEMA testns5 CASCADE;
SELECT d.*     
  FROM pg_default_acl d LEFT JOIN pg_namespace n ON defaclnamespace = n.oid
  WHERE nspname IS NULL AND defaclnamespace != 0;
CREATE SCHEMA testns;
CREATE TABLE testns.t1 (f1 int);
CREATE TABLE testns.t2 (f1 int);
CREATE AGGREGATE testns.priv_testagg(int) (sfunc = int4pl, stype = int4);
CREATE PROCEDURE testns.priv_testproc(int) AS 'select 3' LANGUAGE sql;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA testns FROM PUBLIC;
REVOKE ALL ON ALL PROCEDURES IN SCHEMA testns FROM PUBLIC;
GRANT ALL ON ALL ROUTINES IN SCHEMA testns TO PUBLIC;
DROP SCHEMA testns CASCADE;
CREATE SCHEMA testns;
SELECT nspname, rolname FROM pg_namespace, pg_roles WHERE pg_namespace.nspname = 'testns' AND pg_namespace.nspowner = pg_roles.oid;
SELECT nspname, rolname FROM pg_namespace, pg_roles WHERE pg_namespace.nspname = 'testns' AND pg_namespace.nspowner = pg_roles.oid;
DROP SCHEMA testns CASCADE;
create table dep_priv_test (a int);
drop table dep_priv_test;
drop sequence x_seq;
DROP VIEW atestv0;
DROP VIEW atestv1;
DROP VIEW atestv2;
DROP VIEW atestv3 CASCADE;
DROP TABLE atest1;
DROP TABLE atest2;
DROP TABLE atest3;
DROP TABLE atest4;
DROP TABLE atest5;
DROP TABLE atest6;
DROP TABLE atestc;
DROP TABLE atestp1;
DROP TABLE atestp2;
SELECT lo_unlink(oid) FROM pg_largeobject_metadata WHERE oid >= 1000 AND oid < 3000 ORDER BY oid;
CREATE TABLE lock_table (a int);
BEGIN;
LOCK TABLE lock_table IN ACCESS SHARE MODE;
COMMIT;
BEGIN;
LOCK TABLE lock_table IN ROW EXCLUSIVE MODE;
ROLLBACK;
BEGIN;
LOCK TABLE lock_table IN ACCESS EXCLUSIVE MODE;
ROLLBACK;
BEGIN;
LOCK TABLE lock_table IN ACCESS SHARE MODE;
ROLLBACK;
BEGIN;
LOCK TABLE lock_table IN ROW EXCLUSIVE MODE;
COMMIT;
BEGIN;
LOCK TABLE lock_table IN ACCESS EXCLUSIVE MODE;
ROLLBACK;
BEGIN;
LOCK TABLE lock_table IN ACCESS SHARE MODE;
ROLLBACK;
BEGIN;
LOCK TABLE lock_table IN ROW EXCLUSIVE MODE;
COMMIT;
BEGIN;
LOCK TABLE lock_table IN ACCESS EXCLUSIVE MODE;
COMMIT;
BEGIN;
LOCK TABLE lock_table IN ACCESS SHARE MODE;
ROLLBACK;
BEGIN;
LOCK TABLE lock_table IN ROW EXCLUSIVE MODE;
COMMIT;
BEGIN;
LOCK TABLE lock_table IN ACCESS EXCLUSIVE MODE;
COMMIT;
BEGIN;
LOCK TABLE lock_table IN ACCESS SHARE MODE;
ROLLBACK;
BEGIN;
LOCK TABLE lock_table IN ROW EXCLUSIVE MODE;
COMMIT;
BEGIN;
LOCK TABLE lock_table IN ACCESS EXCLUSIVE MODE;
COMMIT;
BEGIN;
LOCK TABLE lock_table IN ACCESS SHARE MODE;
ROLLBACK;
BEGIN;
LOCK TABLE lock_table IN ROW EXCLUSIVE MODE;
COMMIT;
BEGIN;
LOCK TABLE lock_table IN ACCESS EXCLUSIVE MODE;
COMMIT;
DROP TABLE lock_table;
RESET ROLE;
RESET SESSION AUTHORIZATION;
CREATE SCHEMA regress_roleoption;
GRANT CREATE, USAGE ON SCHEMA regress_roleoption TO PUBLIC;
CREATE TABLE regress_roleoption.t1 (a int);
CREATE TABLE regress_roleoption.t2 (a int);
CREATE TABLE regress_roleoption.t3 (a int);
CREATE TABLE regress_roleoption.t4 (a int);
RESET SESSION AUTHORIZATION;
DROP TABLE regress_roleoption.t1;
DROP TABLE regress_roleoption.t2;
DROP TABLE regress_roleoption.t3;
DROP TABLE regress_roleoption.t4;
DROP SCHEMA regress_roleoption;
CREATE TABLE maintain_test (a INT);
CREATE INDEX ON maintain_test (a);
CREATE MATERIALIZED VIEW refresh_test AS SELECT 1;
CREATE SCHEMA reindex_test;
VACUUM maintain_test;
ANALYZE maintain_test;
VACUUM (ANALYZE) maintain_test;
CLUSTER maintain_test USING maintain_test_a_idx;
REFRESH MATERIALIZED VIEW refresh_test;
REINDEX TABLE maintain_test;
REINDEX INDEX maintain_test_a_idx;
REINDEX SCHEMA reindex_test;
RESET ROLE;
VACUUM maintain_test;
ANALYZE maintain_test;
VACUUM (ANALYZE) maintain_test;
CLUSTER maintain_test USING maintain_test_a_idx;
REFRESH MATERIALIZED VIEW refresh_test;
REINDEX TABLE maintain_test;
REINDEX INDEX maintain_test_a_idx;
REINDEX SCHEMA reindex_test;
RESET ROLE;
VACUUM maintain_test;
ANALYZE maintain_test;
VACUUM (ANALYZE) maintain_test;
CLUSTER maintain_test USING maintain_test_a_idx;
REFRESH MATERIALIZED VIEW refresh_test;
REINDEX TABLE maintain_test;
REINDEX INDEX maintain_test_a_idx;
REINDEX SCHEMA reindex_test;
RESET ROLE;
DROP TABLE maintain_test;
DROP MATERIALIZED VIEW refresh_test;
DROP SCHEMA reindex_test;