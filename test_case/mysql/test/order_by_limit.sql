
CREATE TABLE t1 (
  pk INT PRIMARY KEY AUTO_INCREMENT,
  i INT,
  j INT,
  INDEX (i),
  INDEX (j)
);

INSERT INTO t1 (i,j) VALUES (1,1);

let $1=7;
set @d=1;
{
  eval INSERT INTO t1 (i,j) SELECT i+@d, j+@d from t1;
  dec $1;

let $query= SELECT * FROM t1
            WHERE i<100 AND j<10
            ORDER BY i LIMIT 5;
DROP TABLE t1;

CREATE TABLE t0 (
  i0 INTEGER NOT NULL
);

INSERT INTO t0 VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);

CREATE TABLE t1 (
  pk INTEGER PRIMARY KEY,
  i1 INTEGER NOT NULL,
  i2 INTEGER NOT NULL,
  INDEX k1 (i1),
  INDEX k2 (i1,i2)
) ENGINE=InnoDB;

INSERT INTO t1
SELECT a0.i0 + 10*a1.i0 + 100*a0.i0 + 1000*a1.i0,
       (a0.i0 + 10*a1.i0 + 100*a0.i0 + 1000*a1.i0) % 1000,
       (a0.i0 + 10*a1.i0 + 100*a0.i0 + 1000*a1.i0) % 1000
FROM t0 AS a0, t0 AS a1;

CREATE TABLE t2 (
  pk INTEGER PRIMARY KEY,
  i1 INTEGER NOT NULL,
  INDEX k1 (i1)
) ENGINE=InnoDB;

INSERT INTO t2
SELECT a0.i0 + 10*a1.i0 + 100*a0.i0 + 1000*a1.i0,
              (a0.i0 + 10*a1.i0 + 100*a0.i0 + 1000*a1.i0) % 500
  FROM t0 AS a0, t0 AS a1;

let query=
SELECT * FROM t1 STRAIGHT_JOIN t2 ON t1.i1=t2.i1
WHERE t1.pk > 7000 and t1.i1 > 2
ORDER BY t1.i1 LIMIT 2;

let query=
SELECT * FROM t1 STRAIGHT_JOIN t2 ON t1.i1=t2.i1
WHERE t1.pk > 7000 and t1.i1 > 2
ORDER BY t1.i1 LIMIT 5;

let query=
SELECT * FROM t1 STRAIGHT_JOIN t2 ON t1.i1=t2.i1
WHERE t1.pk > 7000 and t1.i1 > 800
ORDER BY t1.i1 LIMIT 5;

let query=
SELECT * FROM t1 STRAIGHT_JOIN t2 ON t1.i1=t2.i1
WHERE t1.pk > 7000 ORDER BY t1.i1 LIMIT 5;

let query=
SELECT * FROM t1 STRAIGHT_JOIN t2 ON t1.i1=t2.i1
WHERE t1.pk > 1000 ORDER BY t1.i1 LIMIT 5;

let query=
SELECT t1.i1,t1.i2 FROM t1 STRAIGHT_JOIN t2 ON t1.i1=t2.i1 
WHERE t1.pk > 100 ORDER BY t1.i1 LIMIT 5;

let query=
SELECT * FROM t1 STRAIGHT_JOIN t2 ON t1.i1=t2.i1
WHERE t1.pk > 7000 and t2.pk = 100 ORDER BY t1.i1 LIMIT 5;

INSERT INTO t2
SELECT a0.i0 + 10*a1.i0 + 100*a0.i0 + 1000*a1.i0 + 1,
              (a0.i0 + 10*a1.i0 + 100*a0.i0 + 1000*a1.i0) % 500
  FROM t0 AS a0, t0 AS a1;

let query=
SELECT * FROM t1 STRAIGHT_JOIN t2 ON t1.i1=t2.i1
WHERE t1.pk > 7000 ORDER BY t1.i1 LIMIT 5;

let query=
SELECT * FROM t1 FORCE INDEX FOR ORDER BY (k2) STRAIGHT_JOIN t2 ON
t1.i1=t2.i1 WHERE t1.pk > 7000 ORDER BY t1.i1 LIMIT 5;

DROP TABLE t0, t1, t2;

CREATE TABLE t1 (
  pk int(11) NOT NULL,
  col_int int(11),
  col_varchar_key varchar(20),
  PRIMARY KEY (pk),
  KEY col_varchar_key (col_varchar_key),
  KEY col_varchar_key_2 (col_varchar_key(5))
);

-- Note: The optimizer is free to pick either one of the rows with
-- col_int=3, so they need to sort the same on col_varchar_key.
INSERT INTO t1 VALUES (1,2,'t'), (2,5,'efqsdksj'),
       (3,NULL,'fqsdksjijcs'),(4,8,'qsdksjijc'),
       (5,40,NULL),(6,3,'dkz'),(7,2,NULL),
       (8,3,'dks'),(9,0,'ksjijcsz'),
       (10,84,'sjijcszxwbjj');

let query1=
SELECT DISTINCT col_int
FROM t1
WHERE col_varchar_key <> 'c'
   OR col_varchar_key > 'w'
ORDER BY col_varchar_key
LIMIT 100;
SET @@SESSION.sql_mode='NO_ENGINE_SUBSTITUTION';

DROP TABLE t1;

CREATE TABLE t1 (
  col_int_unique INT DEFAULT NULL,
  col_int_key INT DEFAULT NULL,
  UNIQUE KEY col_int_unique (col_int_unique),
  KEY col_int_key (col_int_key)
);

INSERT INTO t1 VALUES (49,49), (9,7), (0,1), (2,42);

CREATE TABLE t2 (
  col_int_unique INT DEFAULT NULL,
  pk INT NOT NULL,
  PRIMARY KEY (pk),
  UNIQUE KEY col_int_unique (col_int_unique)
);

INSERT INTO t2 VALUES (2,8), (5,2), (6,1);
SELECT STRAIGHT_JOIN t1.col_int_key AS field1
FROM t1 JOIN t2
  ON t2.pk = t1.col_int_unique OR
     t2.col_int_unique = t1.col_int_key
ORDER BY field1 LIMIT 2;

DROP TABLE t1,t2;

CREATE TABLE t (id BIGINT NOT NULL, other_id BIGINT NOT NULL,
 covered_column VARCHAR(50) NOT NULL, non_covered_column VARCHAR(50) NOT NULL,
 PRIMARY KEY (id),
 INDEX index_other_id_covered_column (other_id, covered_column));

let $n = 10;
{
  eval INSERT INTO t (id, other_id, covered_column, non_covered_column)
       VALUES ($n, $n, '$n', '$n');
  dec $n;

SET
  optimizer_trace = "enabled=on",
  optimizer_trace_max_mem_size = 1000000,
  end_markers_in_json = ON;
SET optimizer_switch = "prefer_ordering_index=on";
SELECT (trace LIKE '%"plan_changed": true%') AS should_be_1 FROM information_schema.optimizer_trace;
SET optimizer_switch = "prefer_ordering_index=off";
SELECT (trace LIKE '%"plan_changed": true%') AS should_be_0 FROM information_schema.optimizer_trace;
SET optimizer_switch = default;
SELECT (trace LIKE '%"plan_changed": true%') AS should_be_1 FROM information_schema.optimizer_trace;
SET optimizer_switch = "prefer_ordering_index=on";
SELECT (trace LIKE '%"plan_changed": true%') AS should_be_1 FROM information_schema.optimizer_trace;

SET optimizer_switch = "prefer_ordering_index=off";
SELECT (trace LIKE '%"plan_changed": true%') AS should_be_1 FROM information_schema.optimizer_trace;
let $n = 10;
{
  eval INSERT INTO t (id, other_id, covered_column, non_covered_column)
       VALUES ($n+1+10, $n, '$n', '$n');
  dec $n;
SET optimizer_switch = "prefer_ordering_index=on";
SELECT (trace LIKE '%"plan_changed": true%') AS should_be_1 FROM information_schema.optimizer_trace;
SET optimizer_switch = "prefer_ordering_index=off";
SELECT (trace LIKE '%"plan_changed": true%') AS should_be_0 FROM information_schema.optimizer_trace;
SET optimizer_switch = default;
SELECT (trace LIKE '%"plan_changed": true%') AS should_be_1 FROM information_schema.optimizer_trace;
SET optimizer_switch = "prefer_ordering_index=on";
SELECT (trace LIKE '%"plan_changed": true%') AS should_be_1 FROM information_schema.optimizer_trace;

SET optimizer_switch = "prefer_ordering_index=off";
SELECT (trace LIKE '%"plan_changed": true%') AS should_be_1 FROM information_schema.optimizer_trace;

DROP TABLE t;

CREATE TABLE p (
  pid int unsigned NOT NULL AUTO_INCREMENT,
  cid int unsigned NOT NULL,
  pl char(255) DEFAULT '',
  PRIMARY KEY (pid),
  KEY cid (cid)
);
INSERT INTO p (cid) VALUES (1), (2), (3), (4), (5), (6), (7), (8);
INSERT INTO p (cid) SELECT 1 FROM p;
INSERT INTO p (cid) SELECT 2 FROM p;
INSERT INTO p (cid) SELECT 3 FROM p;
INSERT INTO p (cid) SELECT 4 FROM p;
INSERT INTO p (cid) SELECT 5 FROM p;
INSERT INTO p (cid) SELECT 4 FROM p;

let $q = SELECT pid, cid, pl FROM p WHERE cid = 4 ORDER BY pid DESC LIMIT 1;
let $p = SELECT pid, cid, pl FROM p WHERE cid = ? ORDER BY pid DESC LIMIT 1;

SET @client_id = 4;

SET @@optimizer_switch="prefer_ordering_index=off";

DROP TABLE p;

SET optimizer_switch = DEFAULT;

CREATE TABLE t (x INTEGER PRIMARY KEY, y INTEGER);
INSERT INTO t VALUES (1, 2), (2, 3), (3, 4);
SELECT * FROM t ORDER BY x LIMIT 18446744073709551614;
DROP TABLE t;

CREATE TABLE test (
a bigint NOT NULL AUTO_INCREMENT,
b int not null,
c date NOT NULL,
d int NOT NULL,
PRIMARY KEY (a),
KEY ix_ordered_date (c,a)
);
CREATE PROCEDURE insertProc(input_date varchar(10))
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE (i <= 1000)
    DO
        INSERT INTO test VALUE (0, 0, input_date, 0);
        SET i = i + 1;
    END WHILE;

DROP PROCEDURE insertProc;
DROP TABLE test;

CREATE TABLE t1 (f1 INTEGER, f2 INTEGER, PRIMARY KEY (f1), KEY(f2, f1));

INSERT INTO t1 (
WITH RECURSIVE
a(i) AS (SELECT 0 UNION ALL SELECT i+1 FROM a WHERE i < 9 ),
b(i) AS (SELECT x.i + y.i * 10 + z.i * 100 FROM a x, a y, a z)
SELECT b.i, b.i %2 FROM b ORDER BY i);

let query =
SELECT * FROM t1 WHERE f2 = 1 AND f1 <= 100 ORDER BY f1 DESC LIMIT 1;

CREATE TABLE t2 (
 f1 INTEGER,
 f2 INTEGER,
 f3 INTEGER,
 f4 INTEGER,
 f5 INTEGER,
PRIMARY KEY (f1), KEY(f2,f3,f4,f5,f1));

INSERT INTO t2 (
WITH RECURSIVE a (i) AS (SELECT 0 UNION ALL SELECT i+1 FROM a WHERE i < 9 ),
b (i) AS (SELECT x.i + y.i * 10 + z.i * 100 FROM a x, a y, a z)
SELECT b.i, b.i%2, b.i%3, b.i%4, b.i%5 FROM b ORDER BY i);

let query =
SELECT * FROM t2
WHERE f3 = 1 AND f2 = 1 AND f4 = 3 AND f5 IN(2,3) ORDER BY f4 DESC LIMIT 1;

let query =
SELECT * FROM t2
WHERE f2 = 1 AND f3 = 2 AND f4 = 3 AND f5 IN(2,3) ORDER BY f3,f4 DESC LIMIT 1;

let query =
SELECT * FROM t2
WHERE f2 = 1 AND f3 > 1 AND f4 = 3 AND f5 IN(2,3) ORDER BY f2,f3 DESC LIMIT 1;

let query =
SELECT * FROM t2
WHERE f2 = 1 AND f3 > 1 AND f4 = 3 ORDER BY f2,f3,f5 DESC LIMIT 1;

let query =
SELECT * FROM t2
WHERE f2 = 1 AND f3 > 1 AND f4 = 3 ORDER BY f2 DESC ,f3 DESC ,f5 DESC LIMIT 1;

DROP TABLE t1,t2;
