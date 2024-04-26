--


--
-- Test for bug #17164: ORed FALSE blocked conversion of outer join into join
-- 

CREATE TABLE t1 (id int(11) NOT NULL PRIMARY KEY, name varchar(20),
                 INDEX (name)) charset utf8mb4 ENGINE=InnoDB;
CREATE TABLE t2 (id int(11) NOT NULL PRIMARY KEY, fkey int(11),
                 FOREIGN KEY (fkey) REFERENCES t2(id)) ENGINE=InnoDB;
INSERT INTO t1 VALUES (1,'A1'),(2,'A2'),(3,'B');
INSERT INTO t2 VALUES (1,1),(2,2),(3,2),(4,3),(5,3);

-- disable_result_log
ANALYZE TABLE t1;
SELECT COUNT(*) FROM t2 LEFT JOIN t1 ON t2.fkey = t1.id 
  WHERE t1.name LIKE 'A%';
SELECT COUNT(*) FROM t2 LEFT JOIN t1 ON t2.fkey = t1.id 
  WHERE t1.name LIKE 'A%' OR FALSE;

DROP TABLE t1,t2;

CREATE TABLE t1 (
  col_int INT,
  col_int_key INT,
  pk INT NOT NULL,
  PRIMARY KEY (pk),
  KEY col_int_key (col_int_key)
) ENGINE=InnoDB;

INSERT INTO t1 VALUES (NULL,1,1), (6,2,2), (5,3,3), (NULL,4,4);
INSERT INTO t1 VALUES (1,NULL,6), (8,5,7), (NULL,8,8), (8,NULL,5);

-- disable_result_log
ANALYZE TABLE t1;

CREATE TABLE t2 (
  pk INT PRIMARY KEY
) ENGINE=InnoDB;

let $query=
SELECT t1.pk
FROM t2 LEFT JOIN t1 ON t2.pk = t1.col_int
WHERE t1.col_int_key BETWEEN 5 AND 6 
      AND t1.pk IS NULL OR t1.pk IN (5)
ORDER BY pk;

DROP TABLE t1,t2;
CREATE  TABLE t1 (c1 INT, c2 INT, c3 INT, PRIMARY KEY (c1,c2) );
CREATE  TABLE t2 (c1 INT, c2 INT, c3 INT, PRIMARY KEY (c1), KEY (c2));
INSERT INTO t1 VALUES (1,2,3),(2,3,4),(3,4,5);
INSERT INTO t2 SELECT * FROM t1;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT * FROM t1 LEFT JOIN t2 ON t1.c2=t2.c2 AND t2.c1=1 FOR UPDATE;
UPDATE t1 LEFT JOIN t2 ON t1.c1 = t2.c2 AND t2.c1 = 3 SET t1.c3 = RAND()*10;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
DROP TABLE t1,t2;
