
CREATE TABLE t1(
 pk INTEGER PRIMARY KEY,
 uk INTEGER UNIQUE,
 ukn INTEGER UNIQUE NOT NULL,
 ik INTEGER,
 d INTEGER,
 INDEX ik(ik));

INSERT INTO t1 VALUES
(0, NULL, 0, NULL, NULL),
(1, 10, 20, 30, 40),
(2, 20, 40, 60, 80);

CREATE TABLE t2(
 pk INTEGER PRIMARY KEY);

INSERT INTO t2 VALUES
 (1), (2), (3), (4), (5), (6), (7), (8), (9),(10),
(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),
(21),(22),(23),(24),(25),(26),(27),(28),(29),(30),
(31),(32),(33),(34),(35),(36),(37),(38),(39),(40),
(41),(42),(43),(44),(45),(46),(47),(48),(49),(50),
(51),(52),(53),(54),(55),(56),(57),(58),(59),(60),
(61),(62),(63),(64),(65),(66),(67),(68),(69),(70),
(71),(72),(73),(74),(75),(76),(77),(78),(79),(80);

let $c=2;
set optimizer_switch="firstmatch=on,materialization=off";
set optimizer_switch="firstmatch=off,materialization=on";
select @@optimizer_switch;

let $query=
SELECT 1 as a FROM dual
WHERE NOT EXISTS (SELECT * FROM t1 AS it);

let $query=
SELECT 1 as a FROM t2 as ot
WHERE NOT EXISTS (SELECT * FROM t1 AS it);

-- Correlated:

let $query=
SELECT pk FROM t2 as ot
WHERE NOT EXISTS (SELECT * FROM t1 AS it WHERE it.uk=ot.pk)
AND ot.pk<25;

-- In LEFT JOIN ... ON
let $query=
SELECT ot.pk, ot2.pk FROM t2 as ot
LEFT JOIN t2 as ot2
ON NOT EXISTS (SELECT * FROM t1 AS it WHERE it.uk=ot.pk+ot2.pk);

dec $c;

DROP TABLE t1,t2;

-- Verify that if SJ-mat is on right side of LEFT JOIN,
-- subquery's WHERE is attached to SJ-inner tables for execution
-- (t3.a>2, here).

CREATE TABLE t1(a INT, b INT);
INSERT INTO t1 VALUES(1,1),(2,2),(3,3);
let $query=
SELECT * FROM t1 LEFT JOIN t1 t2
ON (t1.a IN
(SELECT /*+ NO_SEMIJOIN(FIRSTMATCH,LOOSESCAN,DUPSWEEDOUT) */ a FROM
t1 t3 WHERE a > 2));

-- Verify that AJ nest isn't in SJ-or-AJ nest: the middle-level
-- subquery is handled as a subquery.

ALTER TABLE t1 MODIFY a INT NOT NULL;

-- Verify that if the subquery's WHERE depends on an outer table (t1
-- here), AJ inner tables don't go before t1 in the plan.

EXPLAIN SELECT * FROM t1 JOIN t1 t2 ON t1.a>t2.a
 AND NOT EXISTS(SELECT * FROM t1 t3, t1 t4 WHERE t3.a=t1.a);

-- Verify that wrapping in IS TRUE/etc doesn't prevent semijoin

ALTER TABLE t1 MODIFY a INT NULL;

-- EXISTS

EXPLAIN SELECT * FROM t1 WHERE EXISTS(SELECT * FROM t1 t3);

-- IN

EXPLAIN SELECT * FROM t1 WHERE t1.a IN (SELECT t3.a FROM t1 t3);

-- just as a side-check: equivalent of above with EXISTS, allows AJ:
EXPLAIN SELECT * FROM t1 WHERE NOT EXISTS (SELECT t3.a FROM t1 t3 WHERE t3.a=t1.a);
SELECT * FROM t1 WHERE ISNULL(t1.a IN (SELECT t3.a FROM t1 t3));

-- NOT IN

EXPLAIN SELECT * FROM t1 WHERE (NOT t1.a IN (SELECT t3.a FROM t1 t3)) IS TRUE;

-- Demonstrate simplifications like
-- (NOT IN) IS FALSE <=> IN IS TRUE.

EXPLAIN SELECT * FROM t1 WHERE (NOT t1.a IN (SELECT /*+ NO_SEMIJOIN() */ t3.a FROM t1 t3)) IS FALSE;

-- Verify that NOT (IN IS TRUE) is not understood as (NOT IN) IS TRUE

EXPLAIN SELECT * FROM t1 WHERE NOT ((t1.a IN (SELECT /*+ NO_SEMIJOIN() */ t3.a FROM t1 t3)) IS TRUE);

DROP TABLE t1;

CREATE TABLE t1 (
  pk int NOT NULL,
  col_varchar_key varchar(1),
  PRIMARY KEY (pk),
  KEY idx_cc_col_varchar_key (col_varchar_key)
);
INSERT INTO t1 VALUES (2,"a");
CREATE TABLE t2 LIKE t1;

let $query=
SELECT col_varchar_key FROM t1
WHERE NOT EXISTS
   (SELECT /*+ NO_SEMIJOIN(FIRSTMATCH) */
           subquery2_t1.col_varchar_key AS subquery2_field1
    FROM t2 AS subquery2_t1 LEFT JOIN 
           t1 AS subquery2_t2 INNER JOIN t1 AS subquery2_t3
           ON TRUE
         ON TRUE
    WHERE subquery2_t2.col_varchar_key <> subquery2_t1. col_varchar_key OR
          subquery2_t1.col_varchar_key >= '2'
   ) AND
     t1.pk IN (2);
DROP TABLE t1, t2;

CREATE TABLE t1 (
  pk int NOT NULL AUTO_INCREMENT,
  col_int_key int,
  PRIMARY KEY (pk),
  KEY idx_cc_col_int_key (col_int_key));

INSERT INTO t1 VALUES(1,1);
INSERT INTO t1 (col_int_key) SELECT col_int_key*2 from t1;
INSERT INTO t1 (col_int_key) SELECT col_int_key*2 from t1;
INSERT INTO t1 (col_int_key) SELECT col_int_key*2 from t1;
INSERT INTO t1 (col_int_key) SELECT col_int_key*2 from t1;
INSERT INTO t1 (col_int_key) SELECT col_int_key*2 from t1;
INSERT INTO t1 (col_int_key) SELECT col_int_key*2 from t1;
DROP TABLE t1;

CREATE TABLE t1 (
  pk INT NOT NULL,
  col_int INT NOT NULL,
  PRIMARY KEY (pk)
);

let $query=
SELECT alias1.pk
FROM t1 AS alias1 LEFT JOIN
     (SELECT alias2.*
      FROM t1 LEFT JOIN t1 AS alias2 ON TRUE
      WHERE NOT EXISTS (SELECT pk FROM t1 AS sj1)
     ) AS alias3
     ON alias3.pk = alias1.col_int AND
        NOT EXISTS (SELECT * FROM t1 AS sj2 WHERE (SELECT 1) IS NULL);

DROP TABLE t1;

CREATE TABLE t1 (
  col_int INT NOT NULL,
  col_int2 INT NOT NULL
);

SELECT * FROM
t1 AS alias1 LEFT JOIN t1 AS alias2
ON NOT EXISTS
   ( SELECT *
     FROM
     ( SELECT * FROM t1
       WHERE col_int NOT IN
                     ( SELECT sq1_alias1 . col_int2
                       FROM t1 AS sq1_alias1 )
     ) AS alias3
   );

DROP TABLE t1;

CREATE TABLE t1 (
  col_int INT,
  col_int2 INT,
  key(col_int)
);
INSERT INTO t1 VALUES(1,1),(2,2),(null,null);
SET OPTIMIZER_SWITCH="semijoin=off";

let $c=2;
{
  SET OPTIMIZER_SWITCH="materialization=off";
{
  SET OPTIMIZER_SWITCH="materialization=on,subquery_materialization_cost_based=off";
dec $c;

let $query=
SELECT * FROM t1 WHERE
t1.col_int+1 IN (SELECT col_int FROM t1 t2);

let $query=
SELECT * FROM t1 WHERE
t1.col_int+1 IN (SELECT col_int FROM t1 t2) IS TRUE;

let $query=
SELECT * FROM t1 WHERE
t1.col_int+1 IN (SELECT col_int FROM t1 t2) IS FALSE;

let $query=
SELECT * FROM t1 WHERE
t1.col_int+1 NOT IN (SELECT col_int FROM t1 t2);

let $query=
SELECT * FROM t1 WHERE
t1.col_int+1 IN (SELECT col_int FROM t1 t2) IS UNKNOWN;

}

SET OPTIMIZER_SWITCH=DEFAULT;
DROP TABLE t1;

CREATE TABLE t1 (
  pk INT NOT NULL,
  col_int INT NOT NULL,
  PRIMARY KEY (pk)
) ;

-- Turn BNL off or iterator executor won't be used. Force
-- materialization to repeat bug.
SET OPTIMIZER_SWITCH="block_nested_loop=off,firstmatch=off";

let $query=
SELECT * FROM t1 LEFT JOIN t1 AS t2
ON 1 AND t1.col_int > ( SELECT @var FROM t1 as t3 ) AND
NOT EXISTS ( SELECT * FROM t1 as t4);

-- Also crashed without any antijoin

SELECT * FROM t1 LEFT JOIN (t1 AS t2 LEFT JOIN t1 AS sq ON 1=1)
ON 1 AND t1.col_int > ( SELECT @var FROM t1 AS t4 )
WHERE sq.pk IS NULL;

SET OPTIMIZER_SWITCH=DEFAULT;

DROP TABLE t1;

CREATE TABLE t1(id INT);

INSERT INTO t1 VALUES(1),(2),(3),(4),(5);

let $query=
SELECT ID FROM t1 WHERE id IN ( SELECT 1 );

let $query=
SELECT ID FROM t1 WHERE id NOT IN ( SELECT 1 );

let $query=
SELECT id, id IN (SELECT NULL) IS TRUE AS test FROM t1;

DROP TABLE t1;

CREATE TABLE t1 (
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_int int(11) NOT NULL,
  col_int_key int(11) NOT NULL,
  col_date date NOT NULL,
  col_date_key date NOT NULL,
  col_time time NOT NULL,
  col_time_key time NOT NULL,
  col_datetime datetime NOT NULL,
  col_datetime_key datetime NOT NULL,
  col_varchar varchar(1) NOT NULL,
  col_varchar_key varchar(1) NOT NULL,
  PRIMARY KEY (pk),
  KEY idx_C_col_int_key (col_int_key),
  KEY idx_C_col_date_key (col_date_key),
  KEY idx_C_col_time_key (col_time_key),
  KEY idx_C_col_datetime_key (col_datetime_key),
  KEY idx_C_col_varchar_key (col_varchar_key)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO t1 VALUES (1,1065483706,383929458,'1979-10-05','1976-08-21','22:00:27','23:05:58','1974-07-25 16:05:18','2015-12-02 10:01:50','k','9'),(2,-171723561,486531981,'1980-09-14','2027-01-15','00:57:31','00:12:08','2036-10-28 14:25:40','2010-09-04 08:25:26','M','Z');

-- WHERE is false, NOT EXISTS is TRUE.

let $query=
SELECT alias1.col_int AS field1 , alias2.col_varchar_key AS field2 ,
       alias1.col_datetime_key AS field3
FROM t1 AS alias1 LEFT JOIN t1 AS alias2
  ON NOT EXISTS ( SELECT * FROM t1 AS alias3 WHERE ( SELECT 1 FROM DUAL ) IS NULL );

DROP TABLE t1;

CREATE TABLE t1 (c1 INT, c2 INT);
SELECT c1 FROM t1
 WHERE NOT EXISTS (SELECT /*+ NO_MERGE() */ c2
                   FROM (SELECT c1 FROM t1) AS dt
                   WHERE FALSE);
DROP TABLE t1;

CREATE TABLE t1(a INT NOT NULL, index (a));
CREATE TABLE t2(a INT NOT NULL);
INSERT INTO t1 VALUES(1),(2);
INSERT INTO t2 VALUES(2),(3);
SELECT MAX(t1.a) FROM t1 WHERE a NOT IN (SELECT a FROM t2);
DROP TABLE t1, t2;

create table t(a int, b int);
insert into t values(1,1),(2,2),(3,3),(4,4),(5,5);

-- Should not transform subquery to antijoin and should evaluate it at
-- optimization time
--skip_if_hypergraph  -- Different plan;
select a from t where (not exists (select b from t));
select a from t where 1 not in (select 1 from t);

drop table t;

CREATE TABLE t (a TIME);
CREATE TABLE s (b INT);
INSERT INTO t VALUES('11:11:11.1111'),('22:22:22.2222');
INSERT INTO t VALUES('11:11:11.1111'),('22:22:22.2222');
INSERT INTO t VALUES('11:11:11.1111'),('22:22:22.2222');
INSERT INTO s VALUES(1),(2),(3),(4);
SELECT 1 FROM t WHERE NOT EXISTS
  (
    SELECT 1 FROM s
    WHERE a=FROM_UNIXTIME(1536999178)
  );
DROP TABLE t,s;
