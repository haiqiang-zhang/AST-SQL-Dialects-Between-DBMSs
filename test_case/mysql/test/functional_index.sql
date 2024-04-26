CREATE TABLE t1 (int_col INTEGER, string_col VARCHAR(255));
INSERT INTO t1 (int_col, string_col) VALUES (-1, "foo"), (1, "bar");

CREATE INDEX int_func_index ON t1 ((ABS(int_col)));
CREATE INDEX string_func_index ON t1 ((SUBSTRING(string_col, 1, 2)));
SELECT * FROM INFORMATION_SCHEMA.STATISTICS
WHERE INDEX_NAME IN ('int_func_index', 'string_func_index');
SELECT COUNT(*) AS should_be_2 FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = "t1";
SELECT COUNT(*) AS should_be_2 FROM INFORMATION_SCHEMA.INNODB_COLUMNS c
JOIN INFORMATION_SCHEMA.INNODB_TABLES t ON (c.TABLE_ID = t.TABLE_ID)
WHERE t.NAME = "test/t1";
CREATE TABLE t2 (
  col1 INT,
  INDEX ((col1 * 2)),
  INDEX ((col1 * 4)),
  INDEX ((col1 * 6)));
DROP TABLE t2;
CREATE INDEX combined_index ON t1 ((int_col + int_col), string_col);
ALTER TABLE t1 ADD COLUMN rand VARCHAR(255);
CREATE INDEX name_collision ON t1 ((rand(2)));
CREATE INDEX name_collision ON t1 ((`rand`(2)));
DROP TABLE t1;
CREATE TABLE t1 (f1 JSON, f2 VARCHAR(255));
CREATE INDEX my_functional_index ON t1 ((CAST(f1 AS DECIMAL(2, 1))));
CREATE INDEX my_functional_index_2 ON t1 ((CAST(f2 AS CHAR(1))));
CREATE INDEX idx1 ON t1 ((CAST(f2 AS JSON)));
INSERT INTO t1 (f1) VALUES (CAST(1000 AS JSON));
INSERT INTO t1 (f2) VALUES ("lorem ipsum");
SET @@sql_mode='';
INSERT INTO t1 (f1) VALUES (CAST(1000 AS JSON));
INSERT INTO t1 (f2) VALUES ("lorem ipsum");

DROP TABLE t1;
SET @@sql_mode=DEFAULT;

CREATE TABLE t1 (t1_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY);
CREATE INDEX idx1 ON t1 ((t1_id + t1_id));
DROP TABLE t1;
CREATE TABLE t1 (col1 INT, col2 INT);
CREATE INDEX idx1 ON t1 (col1, (col1 + col2));
CREATE INDEX idx2
  ON t1 ((col1 + 1), (col1 + 2), (col1 + 3), (col1 + 4), (col1 + 5));
ALTER TABLE t1 ADD COLUMN `!hidden!idx1!1!0` INT NOT NULL;

-- Conversely, adding a column which the same name that a future
-- functional index will pick, does not prevent the index from being
-- added.
ALTER TABLE t1 ADD COLUMN `!hidden!idx3!0!0` INT NOT NULL;
CREATE INDEX idx3 ON t1 ((col1-col2));
ALTER TABLE t1 ADD COLUMN `!hidden!idx3!0!1` INT NOT NULL;

DROP TABLE t1;
CREATE TABLE t1 (col1 INT, col2 INT);
ALTER TABLE t1 ADD INDEX ((ABS(col1))), ADD INDEX ((ABS(col2)));
ALTER TABLE t1 ADD COLUMN col3 INT, ADD INDEX ((col1 - col3));

DROP TABLE t1;
CREATE TABLE t1 (col1 INT, INDEX ((ABS(col1))));
DROP TABLE t1;
CREATE TEMPORARY TABLE t1(a INT);
CREATE INDEX idx ON t1 ((ABS(a)));
DROP TABLE t1;
CREATE TABLE t1 (col1 INT, INDEX ((CONCAT(''))));
CREATE TABLE t1 (col1 INT, PRIMARY KEY ((ABS(col1))));
CREATE TABLE t1 (col1 INT, PRIMARY KEY (col1, (ABS(col1))));
CREATE TABLE t1 (col1 INT, col2 INT, PRIMARY KEY (col1, (ABS(col1)), col2));

CREATE TABLE t1 (col1 INT, col2 INT);
ALTER TABLE t1 ADD PRIMARY KEY ((ABS(col1)));
ALTER TABLE t1 ADD PRIMARY KEY (col2, (ABS(col1)));
ALTER TABLE t1 ADD PRIMARY KEY (col1, col2, (ABS(col1)));
DROP TABLE t1;
CREATE TABLE t1 (col1 INT, INDEX ((ABS(col1)) DESC));
DROP TABLE t1;
CREATE TABLE t1(f1 JSON, INDEX idx1 ((CAST(f1->"$.id" AS UNSIGNED))));
INSERT INTO t1 VALUES(CAST('{"id":1}' AS JSON)), (CAST('{"id":2}' AS JSON)),
  (CAST('{"id":3}' AS JSON)), (CAST('{"id":4}' AS JSON)),
  (CAST('{"id":5}' AS JSON)), (CAST('{"id":6}' AS JSON)),
  (CAST('{"id":7}' AS JSON)), (CAST('{"id":8}' AS JSON)),
  (CAST('{"id":9}' AS JSON)), (CAST('{"id":10}' AS JSON));
SELECT * FROM t1 WHERE f1->"$.id"= 5;
SELECT * FROM t1 WHERE f1->"$.id" IN (1,2,3);

DROP TABLE t1;

CREATE TABLE t1(f1 JSON, INDEX idx1 ((CAST(f1->>"$.id" AS CHAR(10)))));

INSERT INTO t1 VALUES
  (CAST('{"id":"a"}' AS JSON)), (CAST('{"id":"b"}' AS JSON)),
  (CAST('{"id":"v"}' AS JSON)), (CAST('{"id":"c"}' AS JSON)),
  (CAST('{"id":"x"}' AS JSON)), (CAST('{"id":"\'z"}' AS JSON)),
  (JSON_OBJECT("id",JSON_QUOTE("n"))), (CAST('{"id":"w"}' AS JSON)),
  (CAST('{"id":"m"}' AS JSON)), (CAST('{"id":"q"}' AS JSON));
SELECT * FROM t1 WHERE CAST(f1->>"$.id" AS CHAR(10)) = "\"n\"";
SELECT * FROM t1 WHERE CAST(f1->>"$.id" AS CHAR(10)) IN ("'z", "\"n\"","a");

DROP TABLE t1;

CREATE TABLE t1(f1 JSON, INDEX idx1 ((CAST(f1->>"$.name" AS CHAR(30)) COLLATE utf8mb4_bin)));

INSERT INTO t1 VALUES
  ('{"name": "james"}'),
  ('{"name": "JAMES"}'),
  ('{"name": "Peter"}'),
  ('{"name": "parker"}');
SELECT * FROM t1 WHERE f1->>"$.name" = "James";
SELECT * FROM t1 WHERE f1->>"$.name" = "james";
SELECT * FROM t1 WHERE CAST(f1->>"$.name" AS CHAR(30)) COLLATE utf8mb4_bin = "james";

DROP TABLE t1;

CREATE TABLE t1 (col1 INT, INDEX idx1 ((col1 + col1)));
UPDATE t1 SET `!hidden!idx1!0!0` = 123;
DROP TABLE t1;
CREATE TABLE t3 (c1 INT);
CREATE INDEX int_func_index ON t3 ((ABS(c1)));
SELECT * FROM t3 WHERE `!hidden!int_func_index!0!0`=1;
DROP TABLE t3;
CREATE TABLE t6 (c1 INT, c2 INT);
CREATE INDEX int_func_index ON t6 ((ABS(c1)));
ALTER TABLE t6 DROP COLUMN c2;
DROP TABLE t6;
CREATE TABLE t1(x VARCHAR(100), KEY ((ST_GeomFromText(x))));
CREATE TABLE t1(x VARCHAR(30), INDEX idx ((CAST(x->>'$.name' AS CHAR(30)))));
INSERT INTO t1 VALUES ('{"name":"knut"}');
DROP TABLE t1;
CREATE TABLE t(x INT, KEY((1+1)));
ALTER TABLE t DROP COLUMN x;
DROP TABLE t;
CREATE TABLE t (x INT);
CREATE INDEX idx ON t ((x+1));
CREATE INDEX idx ON t ((x+2));
DROP TABLE t;
CREATE TABLE t2(a INT, b INT, INDEX id2 ((a)));
CREATE TABLE t2(a INT, b INT, INDEX id2 ((a+b+c)));
CREATE TABLE IF NOT EXISTS table470 ( pk INTEGER AUTO_INCREMENT, a1
VARCHAR(3) NOT NULL, b1 DATETIME NOT NULL, c1 TEXT NOT NULL, d1 TEXT NULL,
PRIMARY KEY (a1), KEY ((VALUES(d1))));
CREATE TABLE  table44 ( pk INTEGER AUTO_INCREMENT, a1 TEXT NOT NULL, b1
DATETIME NOT NULL, c1 TIME NOT NULL, d1 BLOB NOT NULL, PRIMARY KEY (a1), KEY
((VALUES(d1))));
CREATE TABLE t1 (
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_int_nokey int(11) DEFAULT NULL,
  col_int_key int(11) DEFAULT NULL,
  col_date_key date DEFAULT NULL,
  col_date_nokey date DEFAULT NULL,
  col_time_key time DEFAULT NULL,
  col_time_nokey time DEFAULT NULL,
  col_datetime_key datetime DEFAULT NULL,
  col_datetime_nokey datetime DEFAULT NULL,
  col_varchar_key varchar(1) DEFAULT NULL,
  col_varchar_nokey varchar(1) DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY col_int_key (col_int_key),
  KEY col_date_key (col_date_key),
  KEY col_time_key (col_time_key),
  KEY col_datetime_key (col_datetime_key),
  KEY col_varchar_key (col_varchar_key,col_int_key),
  KEY ind25 ((dayofmonth(col_time_nokey))),
  KEY ind211 ((cast(col_date_nokey as date))),
  KEY ind602 ((is_uuid(col_time_nokey)))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;
CREATE INDEX ind320 ON t1 ((pk >= col_time_nokey LIKE
ST_GeomFromGeoJSON(col_varchar_key) ));
DROP TABLE t1;
CREATE TABLE t(a INT, b INT, INDEX c((null)));
CREATE TABLE t1(x INT, KEY `` ((x + 1)));
CREATE TABLE t(x VARCHAR(10), KEY k ((CAST(CONCAT(x,x) AS BINARY))));
INSERT INTO t VALUES ('x');
DROP TABLE t;
CREATE PROCEDURE p1() BEGIN
  CREATE TABLE t(a INT,b INT,UNIQUE INDEX i((a+b)));
DROP TABLE t;
DROP TABLE t;
DROP PROCEDURE p1;
CREATE TABLE t1 (
  col1 FLOAT
, col2 TIMESTAMP
, col3 YEAR
, INDEX ((ABS(col1)))
, INDEX ((ADDDATE(col2, INTERVAL 2 DAY)))
, INDEX ((ABS(col3)))
);

DROP TABLE t1;
CREATE TABLE t1 (
  col4 TEXT NOT NULL
, INDEX ((ST_AsBinary(col4)))
);
CREATE TABLE t1 (col1 INT, col2 INT, col3 INT, INDEX idx ((col1 + col2 + col3)));
ALTER TABLE t1 DROP COLUMN col2;
ALTER TABLE t1 DROP COLUMN col3;
ALTER TABLE t1 DROP INDEX idx;
ALTER TABLE t1 DROP COLUMN col3;
DROP TABLE t1;
CREATE TABLE t (
  col1 INT
, UNIQUE INDEX regular_index (col1)
, UNIQUE INDEX functional_index ((ABS(col1))));
SELECT CONSTRAINT_NAME FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE table_name = "t";
DROP TABLE t;
CREATE TABLE t1 (x INT);
CREATE TABLE t2 (y INT, KEY (((SELECT * FROM t1))));
CREATE TABLE t2 (y INT, KEY (((SELECT x FROM t1))));
CREATE TABLE t2 (y INT, KEY (((SELECT 1 FROM t1))));
DROP TABLE t1;
CREATE TABLE t (j JSON, KEY k (((j,j))));
CREATE TABLE t1 (
  j1 JSON,
  j3 JSON,
  KEY my_idx ((CAST(j1->'$[0]' as SIGNED))),
  KEY my_idx_char ((CAST(j3->'$[0]' as CHAR(10))))
);
ALTER TABLE t1 RENAME KEY my_idx_char TO my_idx;

DROP TABLE t1;
CREATE TABLE t1 (col1 INT, INDEX ((col1 + col1)));

SELECT COLUMN_NAME, ORDINAL_POSITION FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_NAME = "t1";

ALTER TABLE t1 ADD COLUMN col2 INT;

SELECT COLUMN_NAME, ORDINAL_POSITION FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_NAME = "t1";

DROP TABLE t1;
CREATE TABLE t1 (col1 INT, col2 INT AS (col1 + col1), INDEX (col2));
ALTER TABLE t1 ADD COLUMN new_col INT AFTER col1, ALGORITHM=INSTANT;
DROP TABLE t1;
CREATE TABLE t0(c0 INT UNSIGNED, INDEX idx ((ABS(c0))));
INSERT INTO t0 (c0) VALUES (4294967294);
DROP TABLE t0;
CREATE TABLE t(j JSON);
INSERT INTO t VALUES ('{"x":"abc"}'), ('{"x":"ABC"}');
CREATE INDEX idx ON t((CAST(j->>'$.x' AS CHAR(100))));
ALTER TABLE t DROP INDEX idx;
CREATE INDEX idx ON t((CAST(j->'$.x' AS CHAR(100))));
DROP TABLE t;

    CREATE TEMPORARY TABLE issue_functional_key_part (
      sold_on DATETIME NOT NULL DEFAULT NOW(),
      INDEX sold_on_date ((DATE(sold_on)))
    )
    SELECT NOW() `sold_on`;

CREATE TABLE t1(x INT, KEY k ((x+1)));

-- "used_columns" in the EXPLAIN output used to contain the hidden
-- virtual column backing the functional index. Verify that only the
-- visible column (x) is used now.
CREATE TABLE t2(j JSON);
SELECT j->'$**.used_columns' FROM t2;

DROP TABLE t1, t2;
CREATE TABLE t1 (id INT, name VARCHAR(50), INDEX (NAME));
CREATE TABLE t2 (id INT, name VARCHAR(50), INDEX (name));
CREATE TABLE t3 (id INT, NAME VARCHAR(50), INDEX (name));
CREATE TABLE t4 (id INT, NAME VARCHAR(50), INDEX (NAME));
CREATE TABLE t5 (id INT, name VARCHAR(50),
INDEX ((SUBSTR(name, 1, 2))));
CREATE TABLE t6 (id INT, name VARCHAR(50),
INDEX ((SUBSTR(NAME, 1, 2))));
CREATE TABLE t7 (id INT, NAME VARCHAR(50),
INDEX ((SUBSTR(name, 1, 2))));
CREATE TABLE t8 (id INT, NAME VARCHAR(50),
INDEX ((SUBSTR(NAME, 1, 2))));
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;
DROP TABLE t4;
DROP TABLE t5;
DROP TABLE t6;
DROP TABLE t7;
DROP TABLE t8;

CREATE TABLE t (
  id INT DEFAULT NULL,
  KEY functional_index ((id * id))
);

CREATE TABLE t2 (
  id INT NOT NULL AUTO_INCREMENT,
  val INT,
  PRIMARY KEY (id)
);

INSERT INTO t(id) VALUES (1), (1), (2), (-1), (-2);
INSERT INTO t2(val) VALUES (1), (2), (3), (4);

-- BETWEEN
--let $query= SELECT id, val, (SELECT id FROM t WHERE (id * id) BETWEEN val and val + 2 LIMIT 1) AS tid FROM t2
--eval EXPLAIN $query
--eval $query

-- IN
--let $query= SELECT id, val, (SELECT id FROM t WHERE (id * id) IN (val) LIMIT 1) AS tid FROM t2
--eval EXPLAIN $query
--eval $query

--let $query= SELECT id, val, (SELECT id FROM t WHERE (id * id) = val + (SELECT 1 FROM t WHERE id > 1) LIMIT 1) AS tid FROM t2
--eval EXPLAIN $query
--eval $query
DROP TABLE t, t2;
