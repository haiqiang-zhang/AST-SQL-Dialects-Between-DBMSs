SELECT attrelid, attname, attgenerated FROM pg_attribute WHERE attgenerated NOT IN ('', 's');
CREATE TABLE gtest0 (a int PRIMARY KEY, b int GENERATED ALWAYS AS (55) STORED);
CREATE TABLE gtest1 (a int PRIMARY KEY, b int GENERATED ALWAYS AS (a * 2) STORED);
SELECT table_name, column_name, column_default, is_nullable, is_generated, generation_expression FROM information_schema.columns WHERE table_name LIKE 'gtest_' ORDER BY 1, 2;
SELECT table_name, column_name, dependent_column FROM information_schema.column_column_usage ORDER BY 1, 2, 3;
CREATE TABLE gtest2 (a int, b text GENERATED ALWAYS AS (a || ' sec') STORED);
DROP TABLE gtest2;
INSERT INTO gtest1 VALUES (1);
INSERT INTO gtest1 VALUES (2, DEFAULT);
INSERT INTO gtest1 VALUES (3, DEFAULT), (4, DEFAULT);
SELECT * FROM gtest1 ORDER BY a;
DELETE FROM gtest1 WHERE a >= 3;
UPDATE gtest1 SET b = DEFAULT WHERE a = 1;
SELECT * FROM gtest1 ORDER BY a;
SELECT a, b, b * 2 AS b2 FROM gtest1 ORDER BY a;
SELECT a, b FROM gtest1 WHERE b = 4 ORDER BY a;
SELECT * FROM gtest1;
DELETE FROM gtest1 WHERE a = 2000000000;
CREATE TABLE gtestx (x int, y int);
INSERT INTO gtestx VALUES (11, 1), (22, 2), (33, 3);
SELECT * FROM gtestx, gtest1 WHERE gtestx.y = gtest1.a;
DROP TABLE gtestx;
SELECT * FROM gtest1 ORDER BY a;
UPDATE gtest1 SET a = 3 WHERE b = 4;
SELECT * FROM gtest1 ORDER BY a;
DELETE FROM gtest1 WHERE b = 2;
SELECT * FROM gtest1 ORDER BY a;
CREATE TABLE gtestm (
  id int PRIMARY KEY,
  f1 int,
  f2 int,
  f3 int GENERATED ALWAYS AS (f1 * 2) STORED,
  f4 int GENERATED ALWAYS AS (f2 * 2) STORED
);
INSERT INTO gtestm VALUES (1, 5, 100);
MERGE INTO gtestm t USING (VALUES (1, 10), (2, 20)) v(id, f1) ON t.id = v.id
  WHEN MATCHED THEN UPDATE SET f1 = v.f1
  WHEN NOT MATCHED THEN INSERT VALUES (v.id, v.f1, 200);
SELECT * FROM gtestm ORDER BY id;
DROP TABLE gtestm;
CREATE VIEW gtest1v AS SELECT * FROM gtest1;
SELECT * FROM gtest1v;
INSERT INTO gtest1v VALUES (5, DEFAULT);
INSERT INTO gtest1v VALUES (6, DEFAULT), (7, DEFAULT);
ALTER VIEW gtest1v ALTER COLUMN b SET DEFAULT 100;
SELECT * FROM gtest1v;
DELETE FROM gtest1v WHERE a >= 5;
DROP VIEW gtest1v;
WITH foo AS (SELECT * FROM gtest1) SELECT * FROM foo;
CREATE TABLE gtest1_1 () INHERITS (gtest1);
SELECT * FROM gtest1_1;
INSERT INTO gtest1_1 VALUES (4);
SELECT * FROM gtest1_1;
SELECT * FROM gtest1;
CREATE TABLE gtest_normal (a int, b int);
CREATE TABLE gtest_normal_child (a int, b int GENERATED ALWAYS AS (a * 2) STORED);
DROP TABLE gtest_normal, gtest_normal_child;
CREATE TABLE gtestx (x int, b int GENERATED ALWAYS AS (a * 22) STORED) INHERITS (gtest1);
CREATE TABLE gtestxx_1 (a int NOT NULL, b int);
CREATE TABLE gtestxx_3 (a int NOT NULL, b int GENERATED ALWAYS AS (a * 2) STORED);
ALTER TABLE gtestxx_3 INHERIT gtest1;
CREATE TABLE gtestxx_4 (b int GENERATED ALWAYS AS (a * 2) STORED, a int NOT NULL);
ALTER TABLE gtestxx_4 INHERIT gtest1;
CREATE TABLE gtesty (x int, b int DEFAULT 55);
DROP TABLE gtesty;
CREATE TABLE gtesty (x int, b int);
DROP TABLE gtesty;
CREATE TABLE gtesty (x int, b int GENERATED ALWAYS AS (x * 22) STORED);
CREATE TABLE gtest1_y (b int GENERATED ALWAYS AS (x + 1) STORED) INHERITS (gtest1, gtesty);
CREATE TABLE gtestp (f1 int);
CREATE TABLE gtestc (f2 int GENERATED ALWAYS AS (f1+1) STORED) INHERITS(gtestp);
INSERT INTO gtestc values(42);
TABLE gtestc;
UPDATE gtestp SET f1 = f1 * 10;
TABLE gtestc;
DROP TABLE gtestp CASCADE;
CREATE TABLE gtest3 (a int, b int GENERATED ALWAYS AS (a * 3) STORED);
INSERT INTO gtest3 (a) VALUES (1), (2), (3), (NULL);
SELECT * FROM gtest3 ORDER BY a;
UPDATE gtest3 SET a = 22 WHERE a = 2;
SELECT * FROM gtest3 ORDER BY a;
CREATE TABLE gtest3a (a text, b text GENERATED ALWAYS AS (a || '+' || a) STORED);
INSERT INTO gtest3a (a) VALUES ('a'), ('b'), ('c'), (NULL);
SELECT * FROM gtest3a ORDER BY a;
UPDATE gtest3a SET a = 'bb' WHERE a = 'b';
SELECT * FROM gtest3a ORDER BY a;
TRUNCATE gtest1;
INSERT INTO gtest1 (a) VALUES (1), (2);
SELECT * FROM gtest1 ORDER BY a;
TRUNCATE gtest3;
INSERT INTO gtest3 (a) VALUES (1), (2);
SELECT * FROM gtest3 ORDER BY a;
CREATE TABLE gtest2 (a int PRIMARY KEY, b int GENERATED ALWAYS AS (NULL) STORED);
INSERT INTO gtest2 VALUES (1);
SELECT * FROM gtest2;
CREATE TABLE gtest_varlena (a varchar, b varchar GENERATED ALWAYS AS (a) STORED);
INSERT INTO gtest_varlena (a) VALUES('01234567890123456789');
INSERT INTO gtest_varlena (a) VALUES(NULL);
SELECT * FROM gtest_varlena ORDER BY a;
DROP TABLE gtest_varlena;
CREATE TYPE double_int as (a int, b int);
CREATE TABLE gtest4 (
    a int,
    b double_int GENERATED ALWAYS AS ((a * 2, a * 3)) STORED
);
INSERT INTO gtest4 VALUES (1), (6);
SELECT * FROM gtest4;
DROP TABLE gtest4;
DROP TYPE double_int;
CREATE TABLE gtest_tableoid (
  a int PRIMARY KEY,
  b bool GENERATED ALWAYS AS (tableoid = 'gtest_tableoid'::regclass) STORED
);
INSERT INTO gtest_tableoid VALUES (1), (2);
ALTER TABLE gtest_tableoid ADD COLUMN
  c regclass GENERATED ALWAYS AS (tableoid) STORED;
SELECT * FROM gtest_tableoid;
CREATE TABLE gtest10 (a int PRIMARY KEY, b int, c int GENERATED ALWAYS AS (b * 2) STORED);
ALTER TABLE gtest10 DROP COLUMN b CASCADE;
CREATE TABLE gtest10a (a int PRIMARY KEY, b int GENERATED ALWAYS AS (a * 2) STORED);
ALTER TABLE gtest10a DROP COLUMN b;
INSERT INTO gtest10a (a) VALUES (1);
CREATE TABLE gtest11s (a int PRIMARY KEY, b int, c int GENERATED ALWAYS AS (b * 2) STORED);
INSERT INTO gtest11s VALUES (1, 10), (2, 20);
CREATE FUNCTION gf1(a int) RETURNS int AS $$ SELECT a * 3 $$ IMMUTABLE LANGUAGE SQL;
REVOKE ALL ON FUNCTION gf1(int) FROM PUBLIC;
CREATE TABLE gtest12s (a int PRIMARY KEY, b int, c int GENERATED ALWAYS AS (gf1(b)) STORED);
INSERT INTO gtest12s VALUES (1, 10), (2, 20);
SELECT a, b FROM gtest11s;
SELECT a, c FROM gtest11s;
SELECT gf1(10);
SELECT a, c FROM gtest12s;
RESET ROLE;
DROP TABLE gtest11s, gtest12s;
DROP FUNCTION gf1(int);
CREATE TABLE gtest20 (a int PRIMARY KEY, b int GENERATED ALWAYS AS (a * 2) STORED CHECK (b < 50));
INSERT INTO gtest20 (a) VALUES (10);
CREATE TABLE gtest20a (a int PRIMARY KEY, b int GENERATED ALWAYS AS (a * 2) STORED);
INSERT INTO gtest20a (a) VALUES (10);
INSERT INTO gtest20a (a) VALUES (30);
CREATE TABLE gtest20b (a int PRIMARY KEY, b int GENERATED ALWAYS AS (a * 2) STORED);
INSERT INTO gtest20b (a) VALUES (10);
INSERT INTO gtest20b (a) VALUES (30);
ALTER TABLE gtest20b ADD CONSTRAINT chk CHECK (b < 50) NOT VALID;
CREATE TABLE gtest21a (a int PRIMARY KEY, b int GENERATED ALWAYS AS (nullif(a, 0)) STORED NOT NULL);
INSERT INTO gtest21a (a) VALUES (1);
CREATE TABLE gtest21b (a int PRIMARY KEY, b int GENERATED ALWAYS AS (nullif(a, 0)) STORED);
ALTER TABLE gtest21b ALTER COLUMN b SET NOT NULL;
INSERT INTO gtest21b (a) VALUES (1);
ALTER TABLE gtest21b ALTER COLUMN b DROP NOT NULL;
INSERT INTO gtest21b (a) VALUES (0);
CREATE TABLE gtest22a (a int PRIMARY KEY, b int GENERATED ALWAYS AS (a / 2) STORED UNIQUE);
INSERT INTO gtest22a VALUES (2);
INSERT INTO gtest22a VALUES (4);
CREATE TABLE gtest22b (a int, b int GENERATED ALWAYS AS (a / 2) STORED, PRIMARY KEY (a, b));
INSERT INTO gtest22b VALUES (2);
CREATE TABLE gtest22c (a int, b int GENERATED ALWAYS AS (a * 2) STORED);
CREATE INDEX gtest22c_b_idx ON gtest22c (b);
CREATE INDEX gtest22c_expr_idx ON gtest22c ((b * 3));
CREATE INDEX gtest22c_pred_idx ON gtest22c (a) WHERE b > 0;
INSERT INTO gtest22c VALUES (1), (2), (3);
SET enable_seqscan TO off;
SET enable_bitmapscan TO off;
EXPLAIN (COSTS OFF) SELECT * FROM gtest22c WHERE b = 4;
SELECT * FROM gtest22c WHERE b = 4;
EXPLAIN (COSTS OFF) SELECT * FROM gtest22c WHERE b * 3 = 6;
SELECT * FROM gtest22c WHERE b * 3 = 6;
EXPLAIN (COSTS OFF) SELECT * FROM gtest22c WHERE a = 1 AND b > 0;
SELECT * FROM gtest22c WHERE a = 1 AND b > 0;
ANALYZE gtest22c;
EXPLAIN (COSTS OFF) SELECT * FROM gtest22c WHERE b = 8;
SELECT * FROM gtest22c WHERE b = 8;
EXPLAIN (COSTS OFF) SELECT * FROM gtest22c WHERE b * 3 = 12;
SELECT * FROM gtest22c WHERE b * 3 = 12;
EXPLAIN (COSTS OFF) SELECT * FROM gtest22c WHERE a = 1 AND b > 0;
SELECT * FROM gtest22c WHERE a = 1 AND b > 0;
RESET enable_seqscan;
RESET enable_bitmapscan;
CREATE TABLE gtest23a (x int PRIMARY KEY, y int);
INSERT INTO gtest23a VALUES (1, 11), (2, 22), (3, 33);
CREATE TABLE gtest23b (a int PRIMARY KEY, b int GENERATED ALWAYS AS (a * 2) STORED REFERENCES gtest23a (x));
INSERT INTO gtest23b VALUES (1);
DROP TABLE gtest23b;
DROP TABLE gtest23a;
CREATE TABLE gtest23p (x int, y int GENERATED ALWAYS AS (x * 2) STORED, PRIMARY KEY (y));
INSERT INTO gtest23p VALUES (1), (2), (3);
CREATE TABLE gtest23q (a int PRIMARY KEY, b int REFERENCES gtest23p (y));
INSERT INTO gtest23q VALUES (1, 2);
CREATE DOMAIN gtestdomain1 AS int CHECK (VALUE < 10);
CREATE TABLE gtest24 (a int PRIMARY KEY, b gtestdomain1 GENERATED ALWAYS AS (a * 2) STORED);
INSERT INTO gtest24 (a) VALUES (4);
CREATE TYPE gtest_type AS (f1 integer, f2 text, f3 bigint);
DROP TYPE gtest_type CASCADE;
CREATE TABLE gtest_parent (f1 date NOT NULL, f2 bigint, f3 bigint) PARTITION BY RANGE (f1);
CREATE TABLE gtest_child (f1 date NOT NULL, f2 bigint, f3 bigint GENERATED ALWAYS AS (f2 * 2) STORED);
DROP TABLE gtest_parent, gtest_child;
CREATE TABLE gtest_parent (f1 date NOT NULL, f2 bigint, f3 bigint GENERATED ALWAYS AS (f2 * 2) STORED) PARTITION BY RANGE (f1);
CREATE TABLE gtest_child PARTITION OF gtest_parent
  FOR VALUES FROM ('2016-07-01') TO ('2016-08-01');
CREATE TABLE gtest_child2 PARTITION OF gtest_parent (
    f3 WITH OPTIONS GENERATED ALWAYS AS (f2 * 22) STORED  
) FOR VALUES FROM ('2016-08-01') TO ('2016-09-01');
CREATE TABLE gtest_child3 (f1 date NOT NULL, f2 bigint, f3 bigint);
DROP TABLE gtest_child3;
CREATE TABLE gtest_child3 (f1 date NOT NULL, f2 bigint, f3 bigint DEFAULT 42);
DROP TABLE gtest_child3;
CREATE TABLE gtest_child3 (f1 date NOT NULL, f2 bigint, f3 bigint GENERATED ALWAYS AS IDENTITY);
DROP TABLE gtest_child3;
CREATE TABLE gtest_child3 (f1 date NOT NULL, f2 bigint, f3 bigint GENERATED ALWAYS AS (f2 * 33) STORED);
ALTER TABLE gtest_parent ATTACH PARTITION gtest_child3 FOR VALUES FROM ('2016-09-01') TO ('2016-10-01');
INSERT INTO gtest_parent (f1, f2) VALUES ('2016-07-15', 1);
INSERT INTO gtest_parent (f1, f2) VALUES ('2016-07-15', 2);
INSERT INTO gtest_parent (f1, f2) VALUES ('2016-08-15', 3);
SELECT tableoid::regclass, * FROM gtest_parent ORDER BY 1, 2, 3;
UPDATE gtest_parent SET f1 = f1 + 60 WHERE f2 = 1;
SELECT tableoid::regclass, * FROM gtest_parent ORDER BY 1, 2, 3;
SELECT tableoid::regclass, * FROM gtest_parent ORDER BY 1, 2, 3;
SELECT tableoid::regclass, * FROM gtest_parent ORDER BY 1, 2, 3;
CREATE TABLE gtest25 (a int PRIMARY KEY);
INSERT INTO gtest25 VALUES (3), (4);
SELECT * FROM gtest25 ORDER BY a;
ALTER TABLE gtest25 ADD COLUMN c int DEFAULT 42,
  ADD COLUMN x int GENERATED ALWAYS AS (c * 4) STORED;
ALTER TABLE gtest25 ADD COLUMN d int DEFAULT 101;
ALTER TABLE gtest25 ALTER COLUMN d SET DATA TYPE float8,
  ADD COLUMN y float8 GENERATED ALWAYS AS (d * 4) STORED;
SELECT * FROM gtest25 ORDER BY a;
CREATE TABLE gtest27 (
    a int,
    b int,
    x int GENERATED ALWAYS AS ((a + b) * 2) STORED
);
INSERT INTO gtest27 (a, b) VALUES (3, 7), (4, 11);
ALTER TABLE gtest27 ALTER COLUMN x TYPE numeric;
SELECT * FROM gtest27;
ALTER TABLE gtest27
  DROP COLUMN x,
  ALTER COLUMN a TYPE bigint,
  ALTER COLUMN b TYPE bigint,
  ADD COLUMN x bigint GENERATED ALWAYS AS ((a + b) * 2) STORED;
SELECT * FROM gtest27;
CREATE TABLE gtest29 (
    a int,
    b int GENERATED ALWAYS AS (a * 2) STORED
);
INSERT INTO gtest29 (a) VALUES (3), (4);
SELECT * FROM gtest29;
ALTER TABLE gtest29 ALTER COLUMN a DROP EXPRESSION IF EXISTS;
SELECT * FROM gtest29;
ALTER TABLE gtest29 ALTER COLUMN b DROP EXPRESSION;
INSERT INTO gtest29 (a) VALUES (5);
INSERT INTO gtest29 (a, b) VALUES (6, 66);
SELECT * FROM gtest29;
ALTER TABLE gtest29 DROP COLUMN a;
CREATE TABLE gtest30 (
    a int,
    b int GENERATED ALWAYS AS (a * 2) STORED
);
CREATE TABLE gtest30_1 () INHERITS (gtest30);
ALTER TABLE gtest30 ALTER COLUMN b DROP EXPRESSION;
DROP TABLE gtest30 CASCADE;
CREATE TABLE gtest30 (
    a int,
    b int GENERATED ALWAYS AS (a * 2) STORED
);
CREATE TABLE gtest30_1 () INHERITS (gtest30);
CREATE TABLE gtest26 (
    a int PRIMARY KEY,
    b int GENERATED ALWAYS AS (a * 2) STORED
);
CREATE FUNCTION gtest_trigger_func() RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  IF tg_op IN ('DELETE', 'UPDATE') THEN
    RAISE INFO '%: %: old = %', TG_NAME, TG_WHEN, OLD;
  END IF;
  IF tg_op IN ('INSERT', 'UPDATE') THEN
    RAISE INFO '%: %: new = %', TG_NAME, TG_WHEN, NEW;
  END IF;
  IF tg_op = 'DELETE' THEN
    RETURN OLD;
  ELSE
    RETURN NEW;
  END IF;
END
$$;
CREATE TRIGGER gtest1 BEFORE DELETE OR UPDATE ON gtest26
  FOR EACH ROW
  WHEN (OLD.b < 0)  
  EXECUTE PROCEDURE gtest_trigger_func();
CREATE TRIGGER gtest2 BEFORE INSERT ON gtest26
  FOR EACH ROW
  WHEN (NEW.a < 0)
  EXECUTE PROCEDURE gtest_trigger_func();
CREATE TRIGGER gtest3 AFTER DELETE OR UPDATE ON gtest26
  FOR EACH ROW
  WHEN (OLD.b < 0)  
  EXECUTE PROCEDURE gtest_trigger_func();
CREATE TRIGGER gtest4 AFTER INSERT OR UPDATE ON gtest26
  FOR EACH ROW
  WHEN (NEW.b < 0)  
  EXECUTE PROCEDURE gtest_trigger_func();
INSERT INTO gtest26 (a) VALUES (-2), (0), (3);
SELECT * FROM gtest26 ORDER BY a;
UPDATE gtest26 SET a = a * -2;
SELECT * FROM gtest26 ORDER BY a;
DELETE FROM gtest26 WHERE a = -6;
SELECT * FROM gtest26 ORDER BY a;
DROP TRIGGER gtest1 ON gtest26;
DROP TRIGGER gtest2 ON gtest26;
DROP TRIGGER gtest3 ON gtest26;
CREATE FUNCTION gtest_trigger_func3() RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  RAISE NOTICE 'OK';
  RETURN NEW;
END
$$;
CREATE TRIGGER gtest11 BEFORE UPDATE OF b ON gtest26
  FOR EACH ROW
  EXECUTE PROCEDURE gtest_trigger_func3();
UPDATE gtest26 SET a = 1 WHERE a = 0;
DROP TRIGGER gtest11 ON gtest26;
TRUNCATE gtest26;
CREATE FUNCTION gtest_trigger_func4() RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.a = 10;
  NEW.b = 300;
  RETURN NEW;
END;
$$;
CREATE TRIGGER gtest12_01 BEFORE UPDATE ON gtest26
  FOR EACH ROW
  EXECUTE PROCEDURE gtest_trigger_func();
CREATE TRIGGER gtest12_02 BEFORE UPDATE ON gtest26
  FOR EACH ROW
  EXECUTE PROCEDURE gtest_trigger_func4();
CREATE TRIGGER gtest12_03 BEFORE UPDATE ON gtest26
  FOR EACH ROW
  EXECUTE PROCEDURE gtest_trigger_func();
INSERT INTO gtest26 (a) VALUES (1);
UPDATE gtest26 SET a = 11 WHERE a = 1;
SELECT * FROM gtest26 ORDER BY a;
CREATE TABLE gtest28a (
  a int,
  b int,
  c int,
  x int GENERATED ALWAYS AS (b * 2) STORED
);
ALTER TABLE gtest28a DROP COLUMN a;
CREATE TABLE gtest28b (LIKE gtest28a INCLUDING GENERATED);
