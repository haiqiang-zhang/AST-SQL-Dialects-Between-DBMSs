GRANT ALL ON SCHEMA regress_rls_schema to public;
SET search_path = regress_rls_schema;
CREATE TABLE uaccount (
    pguser      name primary key,
    seclv       int
);
GRANT SELECT ON uaccount TO public;
INSERT INTO uaccount VALUES
    ('regress_rls_alice', 99),
    ('regress_rls_bob', 1),
    ('regress_rls_carol', 2),
    ('regress_rls_dave', 3);
CREATE TABLE category (
    cid        int primary key,
    cname      text
);
GRANT ALL ON category TO public;
INSERT INTO category VALUES
    (11, 'novel'),
    (22, 'science fiction'),
    (33, 'technology'),
    (44, 'manga');
CREATE TABLE document (
    did         int primary key,
    cid         int references category(cid),
    dlevel      int not null,
    dauthor     name,
    dtitle      text
);
GRANT ALL ON document TO public;
INSERT INTO document VALUES
    ( 1, 11, 1, 'regress_rls_bob', 'my first novel'),
    ( 2, 11, 2, 'regress_rls_bob', 'my second novel'),
    ( 3, 22, 2, 'regress_rls_bob', 'my science fiction'),
    ( 4, 44, 1, 'regress_rls_bob', 'my first manga'),
    ( 5, 44, 2, 'regress_rls_bob', 'my second manga'),
    ( 6, 22, 1, 'regress_rls_carol', 'great science fiction'),
    ( 7, 33, 2, 'regress_rls_carol', 'great technology book'),
    ( 8, 44, 1, 'regress_rls_carol', 'great manga'),
    ( 9, 22, 1, 'regress_rls_dave', 'awesome science fiction'),
    (10, 33, 2, 'regress_rls_dave', 'awesome technology book');
ALTER TABLE document ENABLE ROW LEVEL SECURITY;
CREATE POLICY p1 ON document AS PERMISSIVE
    USING (dlevel <= (SELECT seclv FROM uaccount WHERE pguser = current_user));
SELECT * FROM pg_policies WHERE schemaname = 'regress_rls_schema' AND tablename = 'document' ORDER BY policyname;
SET row_security TO ON;
INSERT INTO document VALUES (100, 44, 1, 'regress_rls_dave', 'testing sorting of policies');
ALTER POLICY p1 ON document USING (true);
DROP POLICY p1 ON document;
CREATE POLICY p2 ON category
    USING (CASE WHEN current_user = 'regress_rls_bob' THEN cid IN (11, 33)
           WHEN current_user = 'regress_rls_carol' THEN cid IN (22, 44)
           ELSE false END);
ALTER TABLE category ENABLE ROW LEVEL SECURITY;
SELECT * FROM document d FULL OUTER JOIN category c on d.cid = c.cid ORDER BY d.did, c.cid;
SELECT * FROM document d FULL OUTER JOIN category c on d.cid = c.cid ORDER BY d.did, c.cid;
INSERT INTO document VALUES (11, 33, 1, current_user, 'hoge');
SELECT * FROM document WHERE did = 8;
RESET SESSION AUTHORIZATION;
SET row_security TO ON;
SELECT * FROM document;
SELECT * FROM category;
RESET SESSION AUTHORIZATION;
SET row_security TO OFF;
SELECT * FROM document;
SELECT * FROM category;
SET row_security TO OFF;
SELECT * FROM document;
SELECT * FROM category;
SET row_security TO ON;
SELECT * FROM document;
SELECT * FROM category;
SET row_security TO OFF;
SELECT * FROM document;
SELECT * FROM category;
SET row_security TO ON;
CREATE TABLE t1 (id int not null primary key, a int, junk1 text, b text);
ALTER TABLE t1 DROP COLUMN junk1;
GRANT ALL ON t1 TO public;
ALTER TABLE t1 ENABLE ROW LEVEL SECURITY;
SELECT * FROM t1;
EXPLAIN (COSTS OFF) SELECT * FROM t1;
SELECT tableoid::regclass, * FROM t1;
EXPLAIN (COSTS OFF) SELECT *, t1 FROM t1;
SELECT *, t1 FROM t1;
EXPLAIN (COSTS OFF) SELECT *, t1 FROM t1;
SELECT * FROM t1 FOR SHARE;
EXPLAIN (COSTS OFF) SELECT * FROM t1 FOR SHARE;
RESET SESSION AUTHORIZATION;
SET row_security TO OFF;
SET row_security TO OFF;
CREATE TABLE part_document (
    did         int,
    cid         int,
    dlevel      int not null,
    dauthor     name,
    dtitle      text
) PARTITION BY RANGE (cid);
GRANT ALL ON part_document TO public;
CREATE TABLE part_document_fiction PARTITION OF part_document FOR VALUES FROM (11) to (12);
CREATE TABLE part_document_satire PARTITION OF part_document FOR VALUES FROM (55) to (56);
CREATE TABLE part_document_nonfiction PARTITION OF part_document FOR VALUES FROM (99) to (100);
GRANT ALL ON part_document_fiction TO public;
GRANT ALL ON part_document_satire TO public;
GRANT ALL ON part_document_nonfiction TO public;
INSERT INTO part_document VALUES
    ( 1, 11, 1, 'regress_rls_bob', 'my first novel'),
    ( 2, 11, 2, 'regress_rls_bob', 'my second novel'),
    ( 3, 99, 2, 'regress_rls_bob', 'my science textbook'),
    ( 4, 55, 1, 'regress_rls_bob', 'my first satire'),
    ( 5, 99, 2, 'regress_rls_bob', 'my history book'),
    ( 6, 11, 1, 'regress_rls_carol', 'great science fiction'),
    ( 7, 99, 2, 'regress_rls_carol', 'great technology book'),
    ( 8, 55, 2, 'regress_rls_carol', 'great satire'),
    ( 9, 11, 1, 'regress_rls_dave', 'awesome science fiction'),
    (10, 99, 2, 'regress_rls_dave', 'awesome technology book');
ALTER TABLE part_document ENABLE ROW LEVEL SECURITY;
CREATE POLICY pp1 ON part_document AS PERMISSIVE
    USING (dlevel <= (SELECT seclv FROM uaccount WHERE pguser = current_user));
SELECT * FROM pg_policies WHERE schemaname = 'regress_rls_schema' AND tablename like '%part_document%' ORDER BY policyname;
SET row_security TO ON;
INSERT INTO part_document VALUES (100, 11, 5, 'regress_rls_dave', 'testing pp1');
INSERT INTO part_document VALUES (100, 99, 1, 'regress_rls_dave', 'testing pp1r');
INSERT INTO part_document VALUES (100, 55, 1, 'regress_rls_dave', 'testing RLS with partitions');
INSERT INTO part_document_satire VALUES (100, 55, 1, 'regress_rls_dave', 'testing RLS with partitions');
ALTER TABLE part_document_satire ENABLE ROW LEVEL SECURITY;
CREATE POLICY pp3 ON part_document_satire AS RESTRICTIVE
    USING (cid < 55);
INSERT INTO part_document_satire VALUES (101, 55, 1, 'regress_rls_dave', 'testing RLS with partitions');
ALTER POLICY pp1 ON part_document USING (true);
DROP POLICY pp1 ON part_document;
RESET SESSION AUTHORIZATION;
SET row_security TO ON;
SELECT * FROM part_document ORDER BY did;
SELECT * FROM part_document_satire ORDER by did;
SET row_security TO OFF;
SELECT * FROM part_document ORDER BY did;
SELECT * FROM part_document_satire ORDER by did;
SET row_security TO ON;
SELECT * FROM part_document ORDER by did;
SELECT * FROM part_document_satire ORDER by did;
SET row_security TO OFF;
SELECT * FROM part_document ORDER by did;
SELECT * FROM part_document_satire ORDER by did;
SET row_security TO ON;
CREATE POLICY pp3 ON part_document AS RESTRICTIVE
    USING ((SELECT dlevel <= seclv FROM uaccount WHERE pguser = current_user));
INSERT INTO part_document VALUES (100, 11, 5, 'regress_rls_carol', 'testing pp3');
SET row_security TO ON;
CREATE TABLE dependee (x integer, y integer);
CREATE TABLE dependent (x integer, y integer);
CREATE POLICY d1 ON dependent FOR ALL
    TO PUBLIC
    USING (x = (SELECT d.x FROM dependee d WHERE d.y = y));
DROP TABLE dependee CASCADE;
EXPLAIN (COSTS OFF) SELECT * FROM dependent;
CREATE TABLE rec1 (x integer, y integer);
CREATE POLICY r1 ON rec1 USING (x = (SELECT r.x FROM rec1 r WHERE y = r.y));
ALTER TABLE rec1 ENABLE ROW LEVEL SECURITY;
SELECT * FROM rec1;
CREATE TABLE rec2 (a integer, b integer);
ALTER POLICY r1 ON rec1 USING (x = (SELECT a FROM rec2 WHERE b = y));
CREATE POLICY r2 ON rec2 USING (a = (SELECT x FROM rec1 WHERE y = b));
ALTER TABLE rec2 ENABLE ROW LEVEL SECURITY;
SELECT * FROM rec1;
CREATE VIEW rec1v AS SELECT * FROM rec1;
CREATE VIEW rec2v AS SELECT * FROM rec2;
ALTER POLICY r1 ON rec1 USING (x = (SELECT a FROM rec2v WHERE b = y));
ALTER POLICY r2 ON rec2 USING (a = (SELECT x FROM rec1v WHERE y = b));
SELECT * FROM rec1;
DROP VIEW rec1v, rec2v CASCADE;
CREATE VIEW rec1v WITH (security_barrier) AS SELECT * FROM rec1;
CREATE VIEW rec2v WITH (security_barrier) AS SELECT * FROM rec2;
CREATE POLICY r1 ON rec1 USING (x = (SELECT a FROM rec2v WHERE b = y));
CREATE POLICY r2 ON rec2 USING (a = (SELECT x FROM rec1v WHERE y = b));
SELECT * FROM rec1;
CREATE TABLE s1 (a int, b text);
CREATE TABLE s2 (x int, y text);
CREATE POLICY p1 ON s1 USING (a in (select x from s2 where y like '%2f%'));
CREATE POLICY p2 ON s2 USING (x in (select a from s1 where b like '%22%'));
CREATE POLICY p3 ON s1 FOR INSERT WITH CHECK (a = (SELECT a FROM s1));
ALTER TABLE s1 ENABLE ROW LEVEL SECURITY;
ALTER TABLE s2 ENABLE ROW LEVEL SECURITY;
CREATE VIEW v2 AS SELECT * FROM s2 WHERE y like '%af%';
INSERT INTO s1 VALUES (1, 'foo');
DROP POLICY p3 on s1;
ALTER POLICY p2 ON s2 USING (x % 2 = 0);
ALTER POLICY p1 ON s1 USING (a in (select x from v2));
SELECT (SELECT x FROM s1 LIMIT 1) xx, * FROM s2 WHERE y like '%28%';
EXPLAIN (COSTS OFF) SELECT (SELECT x FROM s1 LIMIT 1) xx, * FROM s2 WHERE y like '%28%';
ALTER POLICY p2 ON s2 USING (x in (select a from s1 where b like '%d2%'));
PREPARE p1(int) AS SELECT * FROM t1 WHERE a <= $1;
EXECUTE p1(2);
EXPLAIN (COSTS OFF) EXECUTE p1(2);
RESET SESSION AUTHORIZATION;
SET row_security TO OFF;
PREPARE p2(int) AS SELECT * FROM t1 WHERE a = $1;
EXECUTE p2(2);
EXPLAIN (COSTS OFF) EXECUTE p2(2);
SET row_security TO ON;
RESET SESSION AUTHORIZATION;
SET row_security TO OFF;
SELECT * FROM t1 ORDER BY a,b;
SET row_security TO ON;
CREATE TABLE b1 (a int, b text);
CREATE POLICY p1 ON b1 USING (a % 2 = 0);
ALTER TABLE b1 ENABLE ROW LEVEL SECURITY;
CREATE VIEW bv1 WITH (security_barrier) AS SELECT * FROM b1 WHERE a > 0 WITH CHECK OPTION;
INSERT INTO bv1 VALUES (11, 'xxx');
INSERT INTO bv1 VALUES (12, 'xxx');
SELECT * FROM b1;
CREATE POLICY p1 ON document FOR SELECT USING (true);
CREATE POLICY p2 ON document FOR INSERT WITH CHECK (dauthor = current_user);
CREATE POLICY p3 ON document FOR UPDATE
  USING (cid = (SELECT cid from category WHERE cname = 'novel'))
  WITH CHECK (dauthor = current_user);
SELECT * FROM document WHERE did = 2;
INSERT INTO document VALUES (2, (SELECT cid from category WHERE cname = 'novel'), 1, 'regress_rls_carol', 'my first novel')
    ON CONFLICT (did) DO UPDATE SET dtitle = EXCLUDED.dtitle, dauthor = EXCLUDED.dauthor;
INSERT INTO document VALUES (33, 22, 1, 'regress_rls_bob', 'okay science fiction');
INSERT INTO document VALUES (33, (SELECT cid from category WHERE cname = 'novel'), 1, 'regress_rls_bob', 'Some novel, replaces sci-fi') 
    ON CONFLICT (did) DO UPDATE SET dtitle = EXCLUDED.dtitle;
INSERT INTO document VALUES (2, (SELECT cid from category WHERE cname = 'novel'), 1, 'regress_rls_bob', 'my first novel')
    ON CONFLICT (did) DO UPDATE SET dtitle = EXCLUDED.dtitle RETURNING *;
INSERT INTO document VALUES (78, (SELECT cid from category WHERE cname = 'novel'), 1, 'regress_rls_bob', 'some technology novel')
    ON CONFLICT (did) DO UPDATE SET dtitle = EXCLUDED.dtitle, cid = 33 RETURNING *;
INSERT INTO document VALUES (78, (SELECT cid from category WHERE cname = 'novel'), 1, 'regress_rls_bob', 'some technology novel')
    ON CONFLICT (did) DO UPDATE SET dtitle = EXCLUDED.dtitle, cid = 33 RETURNING *;
INSERT INTO document VALUES (78, (SELECT cid from category WHERE cname = 'novel'), 1, 'regress_rls_bob', 'some technology novel')
    ON CONFLICT (did) DO UPDATE SET dtitle = EXCLUDED.dtitle, cid = 33 RETURNING *;
INSERT INTO document VALUES (79, (SELECT cid from category WHERE cname = 'technology'), 1, 'regress_rls_bob', 'technology book, can only insert')
    ON CONFLICT (did) DO UPDATE SET dtitle = EXCLUDED.dtitle RETURNING *;
INSERT INTO document VALUES (79, (SELECT cid from category WHERE cname = 'technology'), 1, 'regress_rls_bob', 'technology book, can only insert')
    ON CONFLICT (did) DO UPDATE SET dtitle = EXCLUDED.dtitle RETURNING *;
DROP POLICY p1 ON document;
DROP POLICY p2 ON document;
DROP POLICY p3 ON document;
CREATE POLICY p3_with_default ON document FOR UPDATE
  USING (cid = (SELECT cid from category WHERE cname = 'novel'));
INSERT INTO document VALUES (79, (SELECT cid from category WHERE cname = 'technology'), 1, 'regress_rls_bob', 'technology book, can only insert')
    ON CONFLICT (did) DO UPDATE SET dtitle = EXCLUDED.dtitle RETURNING *;
INSERT INTO document VALUES (2, (SELECT cid from category WHERE cname = 'technology'), 1, 'regress_rls_bob', 'my first novel')
    ON CONFLICT (did) DO UPDATE SET cid = EXCLUDED.cid, dtitle = EXCLUDED.dtitle RETURNING *;
DROP POLICY p3_with_default ON document;
CREATE POLICY p3_with_all ON document FOR ALL
  USING (cid = (SELECT cid from category WHERE cname = 'novel'))
  WITH CHECK (dauthor = current_user);
INSERT INTO document VALUES (80, (SELECT cid from category WHERE cname = 'novel'), 1, 'regress_rls_carol', 'my first novel')
    ON CONFLICT (did) DO UPDATE SET dtitle = EXCLUDED.dtitle, cid = 33;
INSERT INTO document VALUES (4, (SELECT cid from category WHERE cname = 'novel'), 1, 'regress_rls_bob', 'my first novel')
    ON CONFLICT (did) DO UPDATE SET dtitle = EXCLUDED.dtitle;
INSERT INTO document VALUES (1, (SELECT cid from category WHERE cname = 'novel'), 1, 'regress_rls_bob', 'my first novel')
    ON CONFLICT (did) DO UPDATE SET dauthor = 'regress_rls_carol';
RESET SESSION AUTHORIZATION;
DROP POLICY p3_with_all ON document;
ALTER TABLE document ADD COLUMN dnotes text DEFAULT '';
CREATE POLICY p1 ON document FOR SELECT USING (true);
CREATE POLICY p2 ON document FOR INSERT WITH CHECK (dauthor = current_user);
CREATE POLICY p3 ON document FOR UPDATE
  USING (cid = (SELECT cid from category WHERE cname = 'novel'))
  WITH CHECK (dlevel > 0);
CREATE POLICY p4 ON document FOR DELETE
  USING (cid = (SELECT cid from category WHERE cname = 'manga'));
SELECT * FROM document;
MERGE INTO document d
USING (SELECT 1 as sdid) s
ON did = s.sdid
WHEN MATCHED THEN
	UPDATE SET dnotes = dnotes || ' notes added by merge1 ', dlevel = 0;
MERGE INTO document d
USING (SELECT 1 as sdid) s
ON did = s.sdid
WHEN MATCHED THEN
	UPDATE SET dnotes = dnotes || ' notes added by merge2 ';
MERGE INTO document d
USING (SELECT 1 as sdid) s
ON did = s.sdid
WHEN MATCHED THEN
	UPDATE SET dnotes = dnotes || ' notes added by merge3 ', dlevel = 1;
MERGE INTO document d
USING (SELECT 3 as sdid) s
ON did = s.sdid
WHEN MATCHED THEN
	UPDATE SET dnotes = dnotes || ' notes added by merge ';
MERGE INTO document d
USING (SELECT 3 as sdid) s
ON did = s.sdid
WHEN MATCHED THEN
	DELETE;
MERGE INTO document d
USING (SELECT 4 as sdid) s
ON did = s.sdid
WHEN MATCHED AND dnotes = '' THEN
	UPDATE SET dnotes = dnotes || ' notes added by merge '
WHEN MATCHED THEN
	DELETE;
MERGE INTO document d
USING (SELECT 4 as sdid) s
ON did = s.sdid
WHEN MATCHED AND dnotes <> '' THEN
	UPDATE SET dnotes = dnotes || ' notes added by merge '
WHEN MATCHED THEN
	DELETE;
MERGE INTO document d
USING (SELECT 4 as sdid) s
ON did = s.sdid
WHEN MATCHED AND dnotes <> '' THEN
	UPDATE SET dnotes = dnotes || ' notes added by merge '
WHEN MATCHED THEN
	DO NOTHING;
SELECT * FROM document WHERE did = 4;
RESET SESSION AUTHORIZATION;
MERGE INTO document d
USING (SELECT 4 as sdid) s
ON did = s.sdid
WHEN MATCHED AND dnotes <> '' THEN
	UPDATE SET dnotes = dnotes || ' notes added by merge '
WHEN MATCHED THEN
	DELETE;
RESET SESSION AUTHORIZATION;
MERGE INTO document d
USING (SELECT 12 as sdid) s
ON did = s.sdid
WHEN MATCHED THEN
	DELETE
WHEN NOT MATCHED THEN
	INSERT VALUES (12, 11, 1, 'regress_rls_dave', 'another novel');
MERGE INTO document d
USING (SELECT 12 as sdid) s
ON did = s.sdid
WHEN MATCHED THEN
	DELETE
WHEN NOT MATCHED THEN
	INSERT VALUES (12, 11, 1, 'regress_rls_bob', 'another novel');
MERGE INTO document d
USING (SELECT 1 as sdid) s
ON did = s.sdid
WHEN MATCHED THEN
	UPDATE SET dnotes = dnotes || ' notes added by merge4 '
WHEN NOT MATCHED THEN
	INSERT VALUES (12, 11, 1, 'regress_rls_bob', 'another novel');
RESET SESSION AUTHORIZATION;
DROP POLICY p1 ON document;
CREATE POLICY p1 ON document FOR SELECT
  USING (cid = (SELECT cid from category WHERE cname = 'novel'));
MERGE INTO document d
USING (SELECT 7 as sdid) s
ON did = s.sdid
WHEN MATCHED THEN
	UPDATE SET dnotes = dnotes || ' notes added by merge5 '
WHEN NOT MATCHED THEN
	INSERT VALUES (12, 11, 1, 'regress_rls_bob', 'another novel');
MERGE INTO document d
USING (SELECT 1 as sdid) s
ON did = s.sdid
WHEN MATCHED THEN
	UPDATE SET dnotes = dnotes || ' notes added by merge6 ',
			   cid = (SELECT cid from category WHERE cname = 'technology');
MERGE INTO document d
USING (SELECT 1 as sdid) s
ON did = s.sdid
WHEN MATCHED THEN
	UPDATE SET dnotes = dnotes || ' notes added by merge7 ',
			   cid = (SELECT cid from category WHERE cname = 'novel');
MERGE INTO document d
USING (SELECT 13 as sdid) s
ON did = s.sdid
WHEN MATCHED THEN
	UPDATE SET dnotes = dnotes || ' notes added by merge8 '
WHEN NOT MATCHED THEN
	INSERT VALUES (13, 44, 1, 'regress_rls_bob', 'new manga');
SELECT * FROM document WHERE did = 13;
RESET SESSION AUTHORIZATION;
DROP POLICY p1 ON document;
SELECT * FROM document;
CREATE TABLE z1 (a int, b text);
CREATE TABLE z2 (a int, b text);
INSERT INTO z1 VALUES
    (1, 'aba'),
    (2, 'bbb'),
    (3, 'ccc'),
    (4, 'dad');
ALTER TABLE z1 ENABLE ROW LEVEL SECURITY;
CREATE TABLE z1_blacklist (a int);
INSERT INTO z1_blacklist VALUES (3), (4);
CREATE POLICY p3 ON z1 AS RESTRICTIVE USING (a NOT IN (SELECT a FROM z1_blacklist));
DROP POLICY p3 ON z1;
CREATE POLICY p3 ON z1 AS RESTRICTIVE USING (a NOT IN (SELECT a FROM z1_blacklist));
CREATE TABLE x1 (a int, b text, c text);
GRANT ALL ON x1 TO PUBLIC;
INSERT INTO x1 VALUES
    (1, 'abc', 'regress_rls_bob'),
    (2, 'bcd', 'regress_rls_bob'),
    (3, 'cde', 'regress_rls_carol'),
    (4, 'def', 'regress_rls_carol'),
    (5, 'efg', 'regress_rls_bob'),
    (6, 'fgh', 'regress_rls_bob'),
    (7, 'fgh', 'regress_rls_carol'),
    (8, 'fgh', 'regress_rls_carol');
CREATE POLICY p0 ON x1 FOR ALL USING (c = current_user);
CREATE POLICY p1 ON x1 FOR SELECT USING (a % 2 = 0);
CREATE POLICY p2 ON x1 FOR INSERT WITH CHECK (a % 2 = 1);
CREATE POLICY p3 ON x1 FOR UPDATE USING (a % 2 = 0);
CREATE POLICY p4 ON x1 FOR DELETE USING (a < 8);
ALTER TABLE x1 ENABLE ROW LEVEL SECURITY;
CREATE TABLE y1 (a int, b text);
CREATE TABLE y2 (a int, b text);
CREATE POLICY p1 ON y1 FOR ALL USING (a % 2 = 0);
CREATE POLICY p2 ON y1 FOR SELECT USING (a > 2);
CREATE POLICY p1 ON y2 FOR ALL USING (a % 2 = 0);
ALTER TABLE y1 ENABLE ROW LEVEL SECURITY;
ALTER TABLE y2 ENABLE ROW LEVEL SECURITY;
CREATE POLICY p2 ON y2 USING (a % 3 = 0);
CREATE POLICY p3 ON y2 USING (a % 4 = 0);
CREATE TABLE test_qual_pushdown (
    abc text
);
INSERT INTO test_qual_pushdown VALUES ('abc'),('def');
DROP TABLE test_qual_pushdown;
RESET SESSION AUTHORIZATION;
DROP TABLE t1 CASCADE;
CREATE TABLE t1 (a integer);
ALTER TABLE t1 ENABLE ROW LEVEL SECURITY;
PREPARE role_inval AS SELECT * FROM t1;
EXPLAIN (COSTS OFF) EXECUTE role_inval;
EXPLAIN (COSTS OFF) EXECUTE role_inval;
EXPLAIN (COSTS OFF) EXECUTE role_inval;
RESET SESSION AUTHORIZATION;
DROP TABLE t1 CASCADE;
CREATE TABLE t1 (a integer, b text);
CREATE POLICY p1 ON t1 USING (a % 2 = 0);
ALTER TABLE t1 ENABLE ROW LEVEL SECURITY;
WITH cte1 AS (UPDATE t1 SET a = a + 1 RETURNING *) SELECT * FROM cte1;
WITH cte1 AS (UPDATE t1 SET a = a RETURNING *) SELECT * FROM cte1;
WITH cte1 AS (INSERT INTO t1 VALUES (21, 'Fail') RETURNING *) SELECT * FROM cte1;
WITH cte1 AS (INSERT INTO t1 VALUES (20, 'Success') RETURNING *) SELECT * FROM cte1;
RESET SESSION AUTHORIZATION;
SELECT polname, relname
    FROM pg_policy pol
    JOIN pg_class pc ON (pc.oid = pol.polrelid)
    WHERE relname = 't1';
ALTER POLICY p1 ON t1 RENAME TO p2;
SELECT polname, relname
    FROM pg_policy pol
    JOIN pg_class pc ON (pc.oid = pol.polrelid)
    WHERE relname = 't1';
CREATE TABLE t2 (a integer, b text);
INSERT INTO t2 (SELECT * FROM t1);
EXPLAIN (COSTS OFF) INSERT INTO t2 (SELECT * FROM t1);
SELECT * FROM t2;
EXPLAIN (COSTS OFF) SELECT * FROM t2;
CREATE TABLE t3 AS SELECT * FROM t1;
SELECT * FROM t3;
SELECT * INTO t4 FROM t1;
SELECT * FROM t4;
CREATE TABLE blog (id integer, author text, post text);
CREATE TABLE comment (blog_id integer, message text);
CREATE POLICY blog_1 ON blog USING (id % 2 = 0);
ALTER TABLE blog ENABLE ROW LEVEL SECURITY;
INSERT INTO blog VALUES
    (1, 'alice', 'blog #1'),
    (2, 'bob', 'blog #1'),
    (3, 'alice', 'blog #2'),
    (4, 'alice', 'blog #3'),
    (5, 'john', 'blog #1');
INSERT INTO comment VALUES
    (1, 'cool blog'),
    (1, 'fun blog'),
    (3, 'crazy blog'),
    (5, 'what?'),
    (4, 'insane!'),
    (2, 'who did it?');
SELECT id, author, message FROM blog JOIN comment ON id = blog_id;
SELECT id, author, message FROM comment JOIN blog ON id = blog_id;
CREATE POLICY comment_1 ON comment USING (blog_id < 4);
ALTER TABLE comment ENABLE ROW LEVEL SECURITY;
SELECT id, author, message FROM blog JOIN comment ON id = blog_id;
SELECT id, author, message FROM comment JOIN blog ON id = blog_id;
DROP TABLE blog, comment;
RESET SESSION AUTHORIZATION;
DROP POLICY p2 ON t1;
RESET SESSION AUTHORIZATION;
SELECT * FROM t1;
EXPLAIN (COSTS OFF) SELECT * FROM t1;
SELECT * FROM t1;
EXPLAIN (COSTS OFF) SELECT * FROM t1;
SET row_security TO ON;
SELECT * FROM t1;
EXPLAIN (COSTS OFF) SELECT * FROM t1;
SELECT * FROM t1;
EXPLAIN (COSTS OFF) SELECT * FROM t1;
RESET SESSION AUTHORIZATION;
CREATE TABLE copy_t (a integer, b text);
CREATE POLICY p1 ON copy_t USING (a % 2 = 0);
ALTER TABLE copy_t ENABLE ROW LEVEL SECURITY;
RESET SESSION AUTHORIZATION;
SET row_security TO OFF;
SET row_security TO ON;
SET row_security TO OFF;
SET row_security TO ON;
SET row_security TO OFF;
SET row_security TO ON;
SET row_security TO OFF;
SET row_security TO ON;
RESET SESSION AUTHORIZATION;
SET row_security TO ON;
CREATE TABLE copy_rel_to (a integer, b text);
CREATE POLICY p1 ON copy_rel_to USING (a % 2 = 0);
ALTER TABLE copy_rel_to ENABLE ROW LEVEL SECURITY;
RESET SESSION AUTHORIZATION;
SET row_security TO OFF;
SET row_security TO ON;
SET row_security TO OFF;
SET row_security TO ON;
SET row_security TO OFF;
SET row_security TO ON;
SET row_security TO OFF;
SET row_security TO ON;
RESET SESSION AUTHORIZATION;
SET row_security TO ON;
CREATE TABLE copy_rel_to_child () INHERITS (copy_rel_to);
INSERT INTO copy_rel_to_child VALUES (1, 'one'), (2, 'two');
RESET SESSION AUTHORIZATION;
SET row_security TO OFF;
SET row_security TO ON;
SET row_security TO OFF;
SET row_security TO ON;
SET row_security TO OFF;
SET row_security TO ON;
SET row_security TO OFF;
SET row_security TO ON;
RESET SESSION AUTHORIZATION;
SET row_security TO OFF;
SET row_security TO OFF;
SET row_security TO ON;
SET row_security TO ON;
SET row_security TO OFF;
SET row_security TO ON;
RESET SESSION AUTHORIZATION;
DROP TABLE copy_t;
DROP TABLE copy_rel_to CASCADE;
CREATE TABLE current_check (currentid int, payload text, rlsuser text);
GRANT ALL ON current_check TO PUBLIC;
INSERT INTO current_check VALUES
    (1, 'abc', 'regress_rls_bob'),
    (2, 'bcd', 'regress_rls_bob'),
    (3, 'cde', 'regress_rls_bob'),
    (4, 'def', 'regress_rls_bob');
CREATE POLICY p1 ON current_check FOR SELECT USING (currentid % 2 = 0);
CREATE POLICY p2 ON current_check FOR DELETE USING (currentid = 4 AND rlsuser = current_user);
CREATE POLICY p3 ON current_check FOR UPDATE USING (currentid = 4) WITH CHECK (rlsuser = current_user);
ALTER TABLE current_check ENABLE ROW LEVEL SECURITY;
SELECT * FROM current_check;
UPDATE current_check SET payload = payload || '_new' WHERE currentid = 2 RETURNING *;
BEGIN;
DECLARE current_check_cursor SCROLL CURSOR FOR SELECT * FROM current_check;
FETCH ABSOLUTE 1 FROM current_check_cursor;
UPDATE current_check SET payload = payload || '_new' WHERE CURRENT OF current_check_cursor RETURNING *;
FETCH RELATIVE 1 FROM current_check_cursor;
UPDATE current_check SET payload = payload || '_new' WHERE CURRENT OF current_check_cursor RETURNING *;
SELECT * FROM current_check;
EXPLAIN (COSTS OFF) UPDATE current_check SET payload = payload WHERE CURRENT OF current_check_cursor;
FETCH ABSOLUTE 1 FROM current_check_cursor;
DELETE FROM current_check WHERE CURRENT OF current_check_cursor RETURNING *;
FETCH RELATIVE 1 FROM current_check_cursor;
DELETE FROM current_check WHERE CURRENT OF current_check_cursor RETURNING *;
SELECT * FROM current_check;
COMMIT;
SET row_security TO ON;
ANALYZE current_check;
SELECT row_security_active('current_check');
SELECT attname, most_common_vals FROM pg_stats
  WHERE tablename = 'current_check'
  ORDER BY 1;
SELECT attname, most_common_vals FROM pg_stats
  WHERE tablename = 'current_check'
  ORDER BY 1;
BEGIN;
CREATE TABLE coll_t (c) AS VALUES ('bar'::text);
CREATE POLICY coll_p ON coll_t USING (c < ('foo'::text COLLATE "C"));
ALTER TABLE coll_t ENABLE ROW LEVEL SECURITY;
ROLLBACK;
RESET SESSION AUTHORIZATION;
BEGIN;
ROLLBACK;
BEGIN;
CREATE TABLE t (c) AS VALUES ('bar'::text);
ROLLBACK;
CREATE TABLE r1 (a int);
CREATE TABLE r2 (a int);
INSERT INTO r1 VALUES (10), (20);
INSERT INTO r2 VALUES (10), (20);
CREATE POLICY p1 ON r1 USING (true);
ALTER TABLE r1 ENABLE ROW LEVEL SECURITY;
CREATE POLICY p1 ON r2 FOR SELECT USING (true);
CREATE POLICY p2 ON r2 FOR INSERT WITH CHECK (false);
CREATE POLICY p3 ON r2 FOR UPDATE USING (false);
CREATE POLICY p4 ON r2 FOR DELETE USING (false);
ALTER TABLE r2 ENABLE ROW LEVEL SECURITY;
SELECT * FROM r1;
SELECT * FROM r2;
INSERT INTO r2 VALUES (2);
UPDATE r2 SET a = 2 RETURNING *;
DELETE FROM r2 RETURNING *;
INSERT INTO r1 SELECT a + 1 FROM r2 RETURNING *;
UPDATE r1 SET a = r2.a + 2 FROM r2 WHERE r1.a = r2.a RETURNING *;
DELETE FROM r1 USING r2 WHERE r1.a = r2.a + 2 RETURNING *;
SELECT * FROM r1;
SELECT * FROM r2;
DROP TABLE r1;
DROP TABLE r2;
SET row_security = on;
CREATE TABLE r1 (a int);
INSERT INTO r1 VALUES (10), (20);
CREATE POLICY p1 ON r1 USING (false);
ALTER TABLE r1 ENABLE ROW LEVEL SECURITY;
ALTER TABLE r1 FORCE ROW LEVEL SECURITY;
TABLE r1;
UPDATE r1 SET a = 1;
TABLE r1;
DELETE FROM r1;
TABLE r1;
SET row_security = off;
DROP TABLE r1;
SET row_security = on;
CREATE TABLE r1 (a int PRIMARY KEY);
CREATE TABLE r2 (a int REFERENCES r1);
INSERT INTO r1 VALUES (10), (20);
INSERT INTO r2 VALUES (10), (20);
CREATE POLICY p1 ON r2 USING (false);
ALTER TABLE r2 ENABLE ROW LEVEL SECURITY;
ALTER TABLE r2 FORCE ROW LEVEL SECURITY;
DROP POLICY p1 ON r2;
ALTER TABLE r2 NO FORCE ROW LEVEL SECURITY;
ALTER TABLE r2 DISABLE ROW LEVEL SECURITY;
DELETE FROM r2;
CREATE POLICY p1 ON r1 USING (false);
ALTER TABLE r1 ENABLE ROW LEVEL SECURITY;
ALTER TABLE r1 FORCE ROW LEVEL SECURITY;
TABLE r1;
INSERT INTO r2 VALUES (10);
DROP TABLE r2;
DROP TABLE r1;
CREATE TABLE r1 (a int PRIMARY KEY);
CREATE TABLE r2 (a int REFERENCES r1 ON DELETE CASCADE);
INSERT INTO r1 VALUES (10), (20);
INSERT INTO r2 VALUES (10), (20);
CREATE POLICY p1 ON r2 USING (false);
ALTER TABLE r2 ENABLE ROW LEVEL SECURITY;
ALTER TABLE r2 FORCE ROW LEVEL SECURITY;
DELETE FROM r1;
ALTER TABLE r2 NO FORCE ROW LEVEL SECURITY;
TABLE r2;
DROP TABLE r2;
DROP TABLE r1;
CREATE TABLE r1 (a int PRIMARY KEY);
CREATE TABLE r2 (a int REFERENCES r1 ON UPDATE CASCADE);
INSERT INTO r1 VALUES (10), (20);
INSERT INTO r2 VALUES (10), (20);
CREATE POLICY p1 ON r2 USING (false);
ALTER TABLE r2 ENABLE ROW LEVEL SECURITY;
ALTER TABLE r2 FORCE ROW LEVEL SECURITY;
UPDATE r1 SET a = a+5;
ALTER TABLE r2 NO FORCE ROW LEVEL SECURITY;
TABLE r2;
DROP TABLE r2;
DROP TABLE r1;
SET row_security = on;
CREATE TABLE r1 (a int);
CREATE POLICY p1 ON r1 FOR SELECT USING (false);
CREATE POLICY p2 ON r1 FOR INSERT WITH CHECK (true);
ALTER TABLE r1 ENABLE ROW LEVEL SECURITY;
ALTER TABLE r1 FORCE ROW LEVEL SECURITY;
INSERT INTO r1 VALUES (10), (20);
TABLE r1;
SET row_security = off;
SET row_security = on;
DROP TABLE r1;
SET row_security = on;
CREATE TABLE r1 (a int PRIMARY KEY);
CREATE POLICY p1 ON r1 FOR SELECT USING (a < 20);
CREATE POLICY p2 ON r1 FOR UPDATE USING (a < 20) WITH CHECK (true);
CREATE POLICY p3 ON r1 FOR INSERT WITH CHECK (true);
INSERT INTO r1 VALUES (10);
ALTER TABLE r1 ENABLE ROW LEVEL SECURITY;
ALTER TABLE r1 FORCE ROW LEVEL SECURITY;
UPDATE r1 SET a = 30;
ALTER TABLE r1 NO FORCE ROW LEVEL SECURITY;
TABLE r1;
UPDATE r1 SET a = 10;
TABLE r1;
ALTER TABLE r1 FORCE ROW LEVEL SECURITY;
DROP TABLE r1;
RESET SESSION AUTHORIZATION;
CREATE TABLE dep1 (c1 int);
CREATE TABLE dep2 (c1 int);
SELECT count(*) = 1 FROM pg_depend
				   WHERE objid = (SELECT oid FROM pg_policy WHERE polname = 'dep_p1')
					 AND refobjid = (SELECT oid FROM pg_class WHERE relname = 'dep2');
SELECT count(*) = 0 FROM pg_depend
				   WHERE objid = (SELECT oid FROM pg_policy WHERE polname = 'dep_p1')
					 AND refobjid = (SELECT oid FROM pg_class WHERE relname = 'dep2');
RESET SESSION AUTHORIZATION;
CREATE TABLE dob_t1 (c1 int);
CREATE TABLE dob_t2 (c1 int) PARTITION BY RANGE (c1);
CREATE TABLE ref_tbl (a int);
INSERT INTO ref_tbl VALUES (1);
CREATE TABLE rls_tbl (a int);
INSERT INTO rls_tbl VALUES (10);
ALTER TABLE rls_tbl ENABLE ROW LEVEL SECURITY;
CREATE POLICY p1 ON rls_tbl USING (EXISTS (SELECT 1 FROM ref_tbl));
CREATE VIEW rls_view AS SELECT * FROM rls_tbl;
SELECT * FROM ref_tbl;
SELECT * FROM rls_tbl;
SELECT * FROM rls_view;
RESET SESSION AUTHORIZATION;
DROP VIEW rls_view;
DROP TABLE rls_tbl;
DROP TABLE ref_tbl;
CREATE TABLE rls_tbl (a int);
INSERT INTO rls_tbl SELECT x/10 FROM generate_series(1, 100) x;
ANALYZE rls_tbl;
ALTER TABLE rls_tbl ENABLE ROW LEVEL SECURITY;
RESET SESSION AUTHORIZATION;
DROP TABLE rls_tbl;
CREATE TABLE rls_tbl (a int, b int, c int);
CREATE POLICY p1 ON rls_tbl USING (rls_tbl >= ROW(1,1,1));
ALTER TABLE rls_tbl ENABLE ROW LEVEL SECURITY;
ALTER TABLE rls_tbl FORCE ROW LEVEL SECURITY;
INSERT INTO rls_tbl SELECT 10, 20, 30;
EXPLAIN (VERBOSE, COSTS OFF)
INSERT INTO rls_tbl
  SELECT * FROM (SELECT b, c FROM rls_tbl ORDER BY a) ss;
INSERT INTO rls_tbl
  SELECT * FROM (SELECT b, c FROM rls_tbl ORDER BY a) ss;
SELECT * FROM rls_tbl;
DROP TABLE rls_tbl;
RESET SESSION AUTHORIZATION;
create table rls_t (c text);
insert into rls_t values ('invisible to bob');
alter table rls_t enable row level security;
create function rls_f () returns setof rls_t
  stable language sql
  as $$ select * from rls_t $$;
prepare q as select current_user, * from rls_f();
execute q;
execute q;
RESET ROLE;
DROP FUNCTION rls_f();
DROP TABLE rls_t;
RESET SESSION AUTHORIZATION;
DROP SCHEMA regress_rls_schema CASCADE;
CREATE SCHEMA regress_rls_schema;
CREATE TABLE rls_tbl (c1 int);
ALTER TABLE rls_tbl ENABLE ROW LEVEL SECURITY;
CREATE POLICY p1 ON rls_tbl USING (c1 > 5);
CREATE POLICY p2 ON rls_tbl FOR SELECT USING (c1 <= 3);
CREATE POLICY p3 ON rls_tbl FOR UPDATE USING (c1 <= 3) WITH CHECK (c1 > 5);
CREATE POLICY p4 ON rls_tbl FOR DELETE USING (c1 <= 3);
CREATE TABLE rls_tbl_force (c1 int);
ALTER TABLE rls_tbl_force ENABLE ROW LEVEL SECURITY;
ALTER TABLE rls_tbl_force FORCE ROW LEVEL SECURITY;
CREATE POLICY p1 ON rls_tbl_force USING (c1 = 5) WITH CHECK (c1 < 5);
CREATE POLICY p2 ON rls_tbl_force FOR SELECT USING (c1 = 8);
CREATE POLICY p3 ON rls_tbl_force FOR UPDATE USING (c1 = 8) WITH CHECK (c1 >= 5);
CREATE POLICY p4 ON rls_tbl_force FOR DELETE USING (c1 = 8);
