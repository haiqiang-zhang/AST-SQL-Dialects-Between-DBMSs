
CREATE TABLE t1(c1 DATETIME, c2 INT, KEY(c1));

DROP TABLE t1;

CREATE TABLE A (
  col_date date DEFAULT NULL,
  col_datetime_key datetime DEFAULT NULL,
  col_time_key time DEFAULT NULL,
  col_varchar_key varchar(1) DEFAULT NULL,
  col_int_key int(11) DEFAULT NULL,
  col_blob_key blob,
  col_varchar varchar(1) DEFAULT NULL,
  col_date_key date DEFAULT NULL,
  col_time time DEFAULT NULL,
  col_blob blob,
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_int int(11) DEFAULT NULL,
  col_datetime datetime DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY col_datetime_key (col_datetime_key),
  KEY col_time_key (col_time_key),
  KEY col_varchar_key (col_varchar_key),
  KEY col_int_key (col_int_key),
  KEY col_blob_key (col_blob_key(255)),
  KEY col_date_key (col_date_key)
) DEFAULT CHARSET=latin1;

CREATE TABLE AA (
  col_varchar varchar(1) DEFAULT NULL,
  col_date date DEFAULT NULL,
  col_varchar_key varchar(1) DEFAULT NULL,
  col_date_key date DEFAULT NULL,
  col_datetime_key datetime DEFAULT NULL,
  col_time_key time DEFAULT NULL,
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_time time DEFAULT NULL,
  col_int_key int(11) DEFAULT NULL,
  col_datetime datetime DEFAULT NULL,
  col_int int(11) DEFAULT NULL,
  col_blob blob,
  col_blob_key blob,
  PRIMARY KEY (pk),
  KEY col_varchar_key (col_varchar_key),
  KEY col_date_key (col_date_key),
  KEY col_datetime_key (col_datetime_key),
  KEY col_time_key (col_time_key),
  KEY col_int_key (col_int_key),
  KEY col_blob_key (col_blob_key(255))
) DEFAULT CHARSET=latin1;

CREATE TABLE BB (
  col_date date DEFAULT NULL,
  col_blob_key blob,
  col_time time DEFAULT NULL,
  col_varchar_key varchar(1) DEFAULT NULL,
  col_varchar varchar(1) DEFAULT NULL,
  col_blob blob,
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_int_key int(11) DEFAULT NULL,
  col_datetime datetime DEFAULT NULL,
  col_time_key time DEFAULT NULL,
  col_datetime_key datetime DEFAULT NULL,
  col_date_key date DEFAULT NULL,
  col_int int(11) DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY col_blob_key (col_blob_key(255)),
  KEY col_varchar_key (col_varchar_key),
  KEY col_int_key (col_int_key),
  KEY col_time_key (col_time_key),
  KEY col_datetime_key (col_datetime_key),
  KEY col_date_key (col_date_key)
) AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

CREATE TABLE D (
  col_varchar_key varchar(1) DEFAULT NULL,
  col_datetime datetime DEFAULT NULL,
  col_date_key date DEFAULT NULL,
  col_int int(11) DEFAULT NULL,
  col_time time DEFAULT NULL,
  col_blob blob,
  col_int_key int(11) DEFAULT NULL,
  col_blob_key blob,
  col_varchar varchar(1) DEFAULT NULL,
  col_datetime_key datetime DEFAULT NULL,
  col_date date DEFAULT NULL,
  col_time_key time DEFAULT NULL,
  pk int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (pk),
  KEY col_varchar_key (col_varchar_key),
  KEY col_date_key (col_date_key),
  KEY col_int_key (col_int_key),
  KEY col_blob_key (col_blob_key(255)),
  KEY col_datetime_key (col_datetime_key),
  KEY col_time_key (col_time_key)
) DEFAULT CHARSET=latin1;
SELECT    alias1 . `col_blob_key` AS field1, 0 AS cycle
FROM ( BB AS alias1 , ( D AS alias2 , AA AS alias3 ) )
WHERE (
alias1 . pk = 225
OR ( alias1 . col_int_key = 69 AND alias1 . col_blob_key = 'p' )
)
UNION ALL
SELECT t1.pk, t2.cycle
FROM cte AS t2 JOIN A AS t1
WHERE t2.field1 = t1.`col_int_key`
AND t2.cycle =1 ) SELECT  * FROM cte;

DROP TABLE IF EXISTS A, AA, BB, D;

create table t1(a int);

-- empty table
with recursive cte as (select * from t1 union select * from cte)
 select * from cte;
insert into t1 values(1),(2);
 select * from cte;
 select * from cte;

drop table t1;

CREATE TABLE D (col_int INT);

CREATE TABLE C (
  col_int2 INT,
  pk INT NOT NULL,
  col_int INT,
  PRIMARY KEY (pk)
);
INSERT INTO C VALUES
(7,1,3),(7,2,3),(5,3,4),(1,4,6),(5,5,2),
(5,6,9),(4,7,9),(7,8,3),(3,9,0),(5,10,3);

CREATE TABLE BB (
  pk INT NOT NULL,
  col_int INT,
  PRIMARY KEY (pk)
);
INSERT INTO BB VALUES (1,0),(2,6),(3,2),(4,5),(5,0);
SELECT alias2 . col_int2 AS field1 FROM
D AS alias1 RIGHT  JOIN
  ( ( C AS alias2 LEFT  JOIN BB AS alias3
      ON (( alias3 . pk = alias2 . col_int ) AND ( alias3 . pk = alias2 . pk ) ) ) )
ON (alias3 . col_int <> alias2 . col_int2 )
HAVING field1 <= 0
UNION
SELECT cte.field1 FROM cte
)
SELECT * FROM cte;

DROP TABLE BB,C,D;

SET SQL_BUFFER_RESULT = 1;
SELECT * FROM cte;
SELECT * FROM cte;

SET SQL_BUFFER_RESULT = DEFAULT;
(
  SELECT 1
  UNION ALL
  SELECT n + 1 FROM cte WHERE n < 5
)
SELECT * FROM cte;

-- The CTE artificially depends on the outer table 'dt', and
-- it contains two rows, 0 (seed) and 1 (recursively generated).
-- Before the bug was fixed, this happened:
-- - for the first outer row (dt.a=1), we correctly saw a match
-- - for the second outer row, the CTE was re-materialized:
--    * it was emptied,
--    * 0 (seed) was written to it,
--    * but when doing the recursive row generation, the read cursor positioned
--    on the CTE was still where it was in the previous execution, i.e. after
--    "row#2", so thought there was nothing in the CTE (while there was the seed
--    at row#1!). So this cursor didn't read the seed and didn't generate 1.
--    * So there was no match, wrongly.
--    * As a result, only one row was returned by the query.

-- Semi-join:

SELECT *
FROM
(VALUES ROW(1),ROW(1)) AS dt(a)
WHERE
EXISTS(
  WITH RECURSIVE qn AS (SELECT a*0 AS b UNION ALL SELECT b+1 FROM qn WHERE b=0)
  SELECT * FROM qn WHERE b=a
  );

-- Anti-join:

SELECT *
FROM
(VALUES ROW(1),ROW(1)) AS dt(a)
WHERE
NOT EXISTS(
  WITH RECURSIVE qn AS (SELECT a*0 AS b UNION ALL SELECT b+1 FROM qn WHERE b=0)
  SELECT * FROM qn WHERE b=a
  );

CREATE TABLE t1 (a INTEGER);
(
  SELECT 1 FROM t1
  UNION ALL
  SELECT 2 FROM cte1 WHERE FALSE
)
SELECT * FROM cte1;

DROP TABLE t1;
