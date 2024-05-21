SET search_path = fast_default;
CREATE SCHEMA fast_default;
CREATE TABLE m(id OID);
INSERT INTO m VALUES (NULL::OID);
END;
END;
end;
CREATE TABLE has_volatile AS
SELECT * FROM generate_series(1,10) id;
ALTER TABLE has_volatile ADD col1 int;
ALTER TABLE has_volatile ADD col2 int DEFAULT 1;
ALTER TABLE has_volatile ADD col3 timestamptz DEFAULT current_timestamp;
ALTER TABLE has_volatile ADD col4 int DEFAULT (random() * 10000)::int;
CREATE TABLE T(pk INT NOT NULL PRIMARY KEY, c_int INT DEFAULT 1);
INSERT INTO T VALUES (1), (2);
ALTER TABLE T ADD COLUMN c_bpchar BPCHAR(5) DEFAULT 'hello',
              ALTER COLUMN c_int SET DEFAULT 2;
INSERT INTO T VALUES (3), (4);
ALTER TABLE T ADD COLUMN c_text TEXT  DEFAULT 'world',
              ALTER COLUMN c_bpchar SET DEFAULT 'dog';
INSERT INTO T VALUES (5), (6);
ALTER TABLE T ADD COLUMN c_date DATE DEFAULT '2016-06-02',
              ALTER COLUMN c_text SET DEFAULT 'cat';
INSERT INTO T VALUES (7), (8);
ALTER TABLE T ADD COLUMN c_timestamp TIMESTAMP DEFAULT '2016-09-01 12:00:00',
              ADD COLUMN c_timestamp_null TIMESTAMP,
              ALTER COLUMN c_date SET DEFAULT '2010-01-01';
INSERT INTO T VALUES (9), (10);
ALTER TABLE T ADD COLUMN c_array TEXT[]
                  DEFAULT '{"This", "is", "the", "real", "world"}',
              ALTER COLUMN c_timestamp SET DEFAULT '1970-12-31 11:12:13',
              ALTER COLUMN c_timestamp_null SET DEFAULT '2016-09-29 12:00:00';
INSERT INTO T VALUES (11), (12);
ALTER TABLE T ADD COLUMN c_small SMALLINT DEFAULT -5,
              ADD COLUMN c_small_null SMALLINT,
              ALTER COLUMN c_array
                  SET DEFAULT '{"This", "is", "no", "fantasy"}';
INSERT INTO T VALUES (13), (14);
ALTER TABLE T ADD COLUMN c_big BIGINT DEFAULT 180000000000018,
              ALTER COLUMN c_small SET DEFAULT 9,
              ALTER COLUMN c_small_null SET DEFAULT 13;
INSERT INTO T VALUES (15), (16);
ALTER TABLE T ADD COLUMN c_num NUMERIC DEFAULT 1.00000000001,
              ALTER COLUMN c_big SET DEFAULT -9999999999999999;
INSERT INTO T VALUES (17), (18);
ALTER TABLE T ADD COLUMN c_time TIME DEFAULT '12:00:00',
              ALTER COLUMN c_num SET DEFAULT 2.000000000000002;
INSERT INTO T VALUES (19), (20);
ALTER TABLE T ADD COLUMN c_interval INTERVAL DEFAULT '1 day',
              ALTER COLUMN c_time SET DEFAULT '23:59:59';
INSERT INTO T VALUES (21), (22);
ALTER TABLE T ADD COLUMN c_hugetext TEXT DEFAULT repeat('abcdefg',1000),
              ALTER COLUMN c_interval SET DEFAULT '3 hours';
INSERT INTO T VALUES (23), (24);
ALTER TABLE T ALTER COLUMN c_interval DROP DEFAULT,
              ALTER COLUMN c_hugetext SET DEFAULT repeat('poiuyt', 1000);
INSERT INTO T VALUES (25), (26);
ALTER TABLE T ALTER COLUMN c_bpchar    DROP DEFAULT,
              ALTER COLUMN c_date      DROP DEFAULT,
              ALTER COLUMN c_text      DROP DEFAULT,
              ALTER COLUMN c_timestamp DROP DEFAULT,
              ALTER COLUMN c_array     DROP DEFAULT,
              ALTER COLUMN c_small     DROP DEFAULT,
              ALTER COLUMN c_big       DROP DEFAULT,
              ALTER COLUMN c_num       DROP DEFAULT,
              ALTER COLUMN c_time      DROP DEFAULT,
              ALTER COLUMN c_hugetext  DROP DEFAULT;
INSERT INTO T VALUES (27), (28);
SELECT pk, c_int, c_bpchar, c_text, c_date, c_timestamp,
       c_timestamp_null, c_array, c_small, c_small_null,
       c_big, c_num, c_time, c_interval,
       c_hugetext = repeat('abcdefg',1000) as c_hugetext_origdef,
       c_hugetext = repeat('poiuyt', 1000) as c_hugetext_newdef
FROM T ORDER BY pk;
DROP TABLE T;
END;
CREATE TABLE T(pk INT NOT NULL PRIMARY KEY);
INSERT INTO T VALUES (1);
ALTER TABLE T ADD COLUMN c1 TIMESTAMP DEFAULT now();
ALTER TABLE T ADD COLUMN c2 TIMESTAMP DEFAULT clock_timestamp();
CREATE FUNCTION foolme(timestamptz DEFAULT clock_timestamp())
  RETURNS timestamptz
  IMMUTABLE AS 'select $1' LANGUAGE sql;
ALTER TABLE T ADD COLUMN c3 timestamptz DEFAULT foolme();
SELECT attname, atthasmissing, attmissingval FROM pg_attribute
  WHERE attrelid = 't'::regclass AND attnum > 0
  ORDER BY attnum;
DROP TABLE T;
DROP FUNCTION foolme(timestamptz);
CREATE TABLE T (pk INT NOT NULL PRIMARY KEY);
INSERT INTO T SELECT * FROM generate_series(1, 10) a;
ALTER TABLE T ADD COLUMN c_bigint BIGINT NOT NULL DEFAULT -1;
INSERT INTO T SELECT b, b - 10 FROM generate_series(11, 20) a(b);
ALTER TABLE T ADD COLUMN c_text TEXT DEFAULT 'hello';
INSERT INTO T SELECT b, b - 10, (b + 10)::text FROM generate_series(21, 30) a(b);
SELECT c_bigint, c_text FROM T WHERE c_bigint = -1 LIMIT 1;
EXPLAIN (VERBOSE TRUE, COSTS FALSE)
SELECT c_bigint, c_text FROM T WHERE c_bigint = -1 LIMIT 1;
SELECT c_bigint, c_text FROM T WHERE c_text = 'hello' LIMIT 1;
EXPLAIN (VERBOSE TRUE, COSTS FALSE) SELECT c_bigint, c_text FROM T WHERE c_text = 'hello' LIMIT 1;
SELECT COALESCE(c_bigint, pk), COALESCE(c_text, pk::text)
FROM T
ORDER BY pk LIMIT 10;
SELECT SUM(c_bigint), MAX(c_text COLLATE "C" ), MIN(c_text COLLATE "C") FROM T;
SELECT * FROM T ORDER BY c_bigint, c_text, pk LIMIT 10;
EXPLAIN (VERBOSE TRUE, COSTS FALSE)
SELECT * FROM T ORDER BY c_bigint, c_text, pk LIMIT 10;
SELECT * FROM T WHERE c_bigint > -1 ORDER BY c_bigint, c_text, pk LIMIT 10;
EXPLAIN (VERBOSE TRUE, COSTS FALSE)
SELECT * FROM T WHERE c_bigint > -1 ORDER BY c_bigint, c_text, pk LIMIT 10;
DELETE FROM T WHERE pk BETWEEN 10 AND 20 RETURNING *;
EXPLAIN (VERBOSE TRUE, COSTS FALSE)
DELETE FROM T WHERE pk BETWEEN 10 AND 20 RETURNING *;
UPDATE T SET c_text = '"' || c_text || '"'  WHERE pk < 10;
SELECT * FROM T WHERE c_text LIKE '"%"' ORDER BY PK;
DROP TABLE T;
CREATE TABLE T(pk INT NOT NULL PRIMARY KEY);
INSERT INTO T VALUES (1), (2);
ALTER TABLE T ADD COLUMN c_int INT NOT NULL DEFAULT -1;
INSERT INTO T VALUES (3), (4);
ALTER TABLE T ADD COLUMN c_text TEXT DEFAULT 'Hello';
INSERT INTO T VALUES (5), (6);
ALTER TABLE T ALTER COLUMN c_text SET DEFAULT 'world',
              ALTER COLUMN c_int  SET DEFAULT 1;
INSERT INTO T VALUES (7), (8);
SELECT * FROM T ORDER BY pk;
CREATE INDEX i ON T(c_int, c_text);
SELECT c_text FROM T WHERE c_int = -1;
CREATE TABLE t1 AS
SELECT 1::int AS a , 2::int AS b
FROM generate_series(1,20) q;
ALTER TABLE t1 ADD COLUMN c text;
SELECT a,
       stddev(cast((SELECT sum(1) FROM generate_series(1,20) x) AS float4))
          OVER (PARTITION BY a,b,c ORDER BY b)
       AS z
FROM t1;
DROP TABLE T;
CREATE TABLE t (id serial PRIMARY KEY, a int, b int, c int);
INSERT INTO t (a,b,c) VALUES (1,2,3);
ALTER TABLE t ADD COLUMN x int NOT NULL DEFAULT 4;
ALTER TABLE t ADD COLUMN y int NOT NULL DEFAULT 5;
SELECT * FROM t;
UPDATE t SET y = 2;
SELECT * FROM t;
DROP TABLE t;
CREATE TABLE t (id serial PRIMARY KEY, a int, b int, c int);
INSERT INTO t (a,b,c) VALUES (1,2,3);
ALTER TABLE t ADD COLUMN x int NOT NULL DEFAULT 4;
ALTER TABLE t ADD COLUMN y int;
SELECT * FROM t;
UPDATE t SET y = 2;
SELECT * FROM t;
DROP TABLE t;
CREATE TABLE t (id serial PRIMARY KEY, a int, b int, c int);
INSERT INTO t (a,b,c) VALUES (1,2,3);
ALTER TABLE t ADD COLUMN x int;
ALTER TABLE t ADD COLUMN y int NOT NULL DEFAULT 5;
SELECT * FROM t;
UPDATE t SET y = 2;
SELECT * FROM t;
DROP TABLE t;
CREATE TABLE t (id serial PRIMARY KEY, a int, b int, c int);
INSERT INTO t (a,b,c) VALUES (1,2,3);
ALTER TABLE t ADD COLUMN x int;
ALTER TABLE t ADD COLUMN y int;
SELECT * FROM t;
UPDATE t SET y = 2;
SELECT * FROM t;
DROP TABLE t;
CREATE TABLE t (id serial PRIMARY KEY, a int, b int, c int);
INSERT INTO t (a,b,c) VALUES (1,2,NULL);
ALTER TABLE t ADD COLUMN x int NOT NULL DEFAULT 4;
ALTER TABLE t ADD COLUMN y int NOT NULL DEFAULT 5;
SELECT * FROM t;
UPDATE t SET y = 2;
SELECT * FROM t;
DROP TABLE t;
CREATE TABLE t (id serial PRIMARY KEY, a int, b int, c int);
INSERT INTO t (a,b,c) VALUES (1,2,NULL);
ALTER TABLE t ADD COLUMN x int NOT NULL DEFAULT 4;
ALTER TABLE t ADD COLUMN y int;
SELECT * FROM t;
UPDATE t SET y = 2;
SELECT * FROM t;
DROP TABLE t;
CREATE TABLE t (id serial PRIMARY KEY, a int, b int, c int);
INSERT INTO t (a,b,c) VALUES (1,2,NULL);
ALTER TABLE t ADD COLUMN x int;
ALTER TABLE t ADD COLUMN y int NOT NULL DEFAULT 5;
SELECT * FROM t;
UPDATE t SET y = 2;
SELECT * FROM t;
DROP TABLE t;
CREATE TABLE t (id serial PRIMARY KEY, a int, b int, c int);
INSERT INTO t (a,b,c) VALUES (1,2,NULL);
ALTER TABLE t ADD COLUMN x int;
ALTER TABLE t ADD COLUMN y int;
SELECT * FROM t;
UPDATE t SET y = 2;
SELECT * FROM t;
DROP TABLE t;
CREATE TABLE leader (a int PRIMARY KEY, b int);
CREATE TABLE follower (a int REFERENCES leader ON DELETE CASCADE, b int);
INSERT INTO leader VALUES (1, 1), (2, 2);
ALTER TABLE leader ADD c int;
ALTER TABLE leader DROP c;
DELETE FROM leader;
CREATE TABLE vtype( a integer);
INSERT INTO vtype VALUES (1);
ALTER TABLE vtype ADD COLUMN b DOUBLE PRECISION DEFAULT 0.2;
ALTER TABLE vtype ADD COLUMN c BOOLEAN DEFAULT true;
SELECT * FROM vtype;
ALTER TABLE vtype
      ALTER b TYPE text USING b::text,
      ALTER c TYPE text USING c::text;
SELECT * FROM vtype;
CREATE TABLE vtype2 (a int);
INSERT INTO vtype2 VALUES (1);
ALTER TABLE vtype2 ADD COLUMN b varchar(10) DEFAULT 'xxx';
ALTER TABLE vtype2 ALTER COLUMN b SET DEFAULT 'yyy';
INSERT INTO vtype2 VALUES (2);
ALTER TABLE vtype2 ALTER COLUMN b TYPE varchar(20) USING b::varchar(20);
SELECT * FROM vtype2;
BEGIN;
CREATE TABLE t();
INSERT INTO t DEFAULT VALUES;
ALTER TABLE t ADD COLUMN a int DEFAULT 1;
CREATE INDEX ON t(a);
UPDATE t SET a = NULL;
SET LOCAL enable_seqscan = true;
SELECT * FROM t WHERE a IS NULL;
SET LOCAL enable_seqscan = false;
SELECT * FROM t WHERE a IS NULL;
ROLLBACK;
DROP TABLE vtype;
DROP TABLE vtype2;
DROP TABLE follower;
DROP TABLE leader;
DROP TABLE t1;
DROP TABLE m;
DROP TABLE has_volatile;
DROP SCHEMA fast_default;
set search_path = public;
create table has_fast_default(f1 int);
insert into has_fast_default values(1);
alter table has_fast_default add column f2 int default 42;
table has_fast_default;
