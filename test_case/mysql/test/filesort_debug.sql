
let GREP_START=`SELECT DATE_FORMAT(CONVERT_TZ(SYSDATE(6),'SYSTEM','UTC'),'%Y%m%d%H%i%s%f');

SET @old_debug= @@session.debug;

CREATE TABLE t1(f0 int auto_increment primary key, f1 int, f2 varchar(200));
INSERT INTO t1(f1, f2) VALUES 
(0,"0"),(1,"1"),(2,"2"),(3,"3"),(4,"4"),(5,"5"),
(6,"6"),(7,"7"),(8,"8"),(9,"9"),(10,"10");

set debug= '+d,bounded_queue_init_fail';
SELECT * FROM t1 ORDER BY f1 ASC, f0 LIMIT 1;
SET session debug= @old_debug;

DROP TABLE t1;

CREATE TABLE t1(f0 int auto_increment primary key, f1 int);
INSERT INTO t1(f1) VALUES (0),(1),(2),(3),(4),(5);

SET session debug= '+d,alloc_sort_buffer_fail';
SELECT * FROM t1 ORDER BY f1 ASC, f0;
SET session debug= @old_debug;

CREATE FUNCTION f1() RETURNS INT RETURN 1;
DELETE FROM t1 ORDER BY (f1(10)) LIMIT 1;

DROP TABLE t1;
DROP FUNCTION f1;
CREATE TABLE t1(f0 int auto_increment primary key, f1 int);
INSERT INTO t1(f1) VALUES (0),(1),(2),(3),(4),(5);

let $ID= `SELECT @id := CONNECTION_ID()`;

SET DEBUG_SYNC='filesort_start SIGNAL filesort_started WAIT_FOR filesort_killed';
let $ignore= `SELECT @id := $ID`;
SET DEBUG_SYNC='now WAIT_FOR filesort_started';
SET DEBUG_SYNC='now SIGNAL filesort_killed';
SET DEBUG_SYNC= "RESET";
DROP TABLE t1;

CREATE TABLE t1 (
  c1 BLOB,
  c2 TEXT,
  c3 TEXT,
  c4 TEXT,
  c5 TEXT,
  c6 TEXT,
  c7 TEXT,
  c8 BLOB,
  c9 TEXT,
  c19 TEXT,
  pk INT,
  c20 TEXT,
  c21 BLOB,
  c22 TEXT,
  c23 TEXT,
  c24 TEXT,
  c25 TEXT,
  c26 BLOB,
  c27 TEXT,
  c28 TEXT,
  primary key (pk)
) ENGINE=InnoDB
;

INSERT INTO t1 VALUES (REPEAT('x', 4096), REPEAT('x', 4096), REPEAT('x', 4096),
REPEAT('x', 4096), REPEAT('x', 4096), REPEAT('x', 4096), REPEAT('x', 4096),
REPEAT('x', 4096), REPEAT('x', 4096), REPEAT('x', 4096), 1, REPEAT('x', 4096),
REPEAT('x', 4096), REPEAT('x', 4096), REPEAT('x', 4096), REPEAT('x', 4096),
REPEAT('x', 4096), REPEAT('x', 4096), REPEAT('x', 4096), REPEAT('x', 4096));
INSERT INTO t1 VALUES (REPEAT('x', 4096), REPEAT('x', 4096), REPEAT('x', 4096),
REPEAT('x', 4096), REPEAT('x', 4096), REPEAT('x', 4096), REPEAT('x', 4096),
REPEAT('x', 4096), REPEAT('x', 4096), REPEAT('x', 4096), 2, REPEAT('x', 4096),
REPEAT('x', 4096), REPEAT('x', 4096), REPEAT('x', 4096), REPEAT('x', 4096),
REPEAT('x', 4096), REPEAT('x', 4096), REPEAT('x', 4096), REPEAT('x', 4096));
INSERT INTO t1 VALUES (REPEAT('x', 4096), REPEAT('x', 4096), REPEAT('x', 4096),
REPEAT('x', 4096), REPEAT('x', 4096), REPEAT('x', 4096), REPEAT('x', 4096),
REPEAT('x', 4096), REPEAT('x', 4096), REPEAT('x', 4096), 3, REPEAT('x', 4096),
REPEAT('x', 4096), REPEAT('x', 4096), REPEAT('x', 4096), REPEAT('x', 4096),
REPEAT('x', 4096), REPEAT('x', 4096), REPEAT('x', 4096), REPEAT('x', 4096));

SET SESSION sort_buffer_size=32768;
DELETE IGNORE FROM t1 ORDER BY c26,c7,c23,c4,c25,c5,c20,
c19,c21,c8,c1,c27,c28,c3,c9,c22,c24,c6,c2,pk LIMIT 2;
DELETE FROM t1 ORDER BY c26,c7,c23,c4,c25,c5,c20,
c19,c21,c8,c1,c27,c28,c3,c9,c22,c24,c6,c2,pk LIMIT 2;

SET SESSION sort_buffer_size=DEFAULT;

DROP TABLE t1;

CREATE TABLE g(b INT NOT NULL, UNIQUE(b)) ENGINE=INNODB;
CREATE TABLE t(a int, c int) ENGINE=INNODB;
INSERT INTO t VALUES(1,1);

SELECT 1
FROM t
GROUP BY a
HAVING (SELECT a
      FROM g
      GROUP BY b, a);

DROP TABLE t, g;

-- group by d below is incompatible with sql_mode=only_full_group_by
SET sql_mode="";

CREATE TABLE t1(a_t1 INT, c INT, d INT) ENGINE=INNODB;
CREATE TABLE t2(a_t2 INT NOT NULL, UNIQUE KEY (a_t2)) ENGINE=INNODB;
INSERT INTO t1 VALUES();
SELECT (SELECT 1 FROM t2 GROUP BY d, a_t2 HAVING c) FROM t1 GROUP BY (1=2);
DROP TABLE t1, t2;

SET sql_mode=default;
CREATE TABLE t1(a DATE);
INSERT INTO t1 VALUES('1000-01-01'), ('2017-10-31');
SELECT HEX(WEIGHT_STRING(a)) FROM t1;
SELECT HEX(WEIGHT_STRING(a COLLATE utf8mb4_0900_ai_ci, 3, 3, 0xC0)) FROM t1;
SELECT HEX(WEIGHT_STRING(a COLLATE utf8mb4_0900_ai_ci, 4, 3, 0xC0)) FROM t1;
DROP TABLE t1;
SET NAMES utf8mb3,@@character_set_results=NULL;
CREATE TEMPORARY TABLE t1(a INT);
INSERT INTO t1 VALUES(1);
SELECT 1 FROM t1 ORDER BY @x:=makedate(a,a);
DROP TABLE t1;

CREATE TABLE t1 AS SELECT 1 AS a WHERE false;
CREATE TABLE t2 AS SELECT @x:=makedate(a,a) FROM t1;
DROP TABLE t2;
CREATE TABLE t2 AS SELECT @a:=@b:=@x:=makedate(a,a) FROM t1;
DROP TABLE t2;
DROP TABLE t1;
