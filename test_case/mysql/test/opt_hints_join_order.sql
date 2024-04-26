
CREATE TABLE t1 (f1 INT NOT NULL);
INSERT INTO t1 VALUES (9),(0), (7);

CREATE TABLE t2 (f1 INT NOT NULL);
INSERT INTO t2 VALUES
(5),(3),(0),(3),(1),(0),(1),(7),(1),(0),(0),(8),(4),(9),(0),(2),(0),(8),(5),(1);

CREATE TABLE t3 (f1 INT NOT NULL);
INSERT INTO t3 VALUES (9),(0), (7), (4), (5);

CREATE TABLE t4 (f1 INT NOT NULL);
INSERT INTO t4 VALUES (0), (7);

CREATE TABLE t5 (f1 INT NOT NULL, PRIMARY KEY(f1));
INSERT INTO t5 VALUES (7);

CREATE TABLE t6(f1 INT NOT NULL, PRIMARY KEY(f1));
INSERT INTO t6 VALUES (7);

let $query= SELECT count(*) FROM t1 JOIN t2 JOIN t3
              WHERE t1.f1 IN (SELECT f1 FROM t4) AND t2.f1 IN (SELECT f1 FROM t5);

-- Check name resolving
let $query= SELECT /*+ QB_NAME(q1) JOIN_PREFIX(t3, t2, t2@subq2) */ count(*) FROM t1 JOIN t2 JOIN t3
              WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t2) AND
                    t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t2);

-- Check conflicting hints

--echo -- Second JOIN_PREFIX is conflicting
let $query= SELECT /*+ JOIN_PREFIX(t3, t2, t1) JOIN_PREFIX(t2, t1) */ count(*) FROM t1 JOIN t2 JOIN t3
              WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4)
                AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
let $query= SELECT /*+ JOIN_SUFFIX(t3, t2) JOIN_SUFFIX(t2, t1) */ count(*) FROM t1 JOIN t2 JOIN t3
              WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4)
                AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
let $query= SELECT /*+ JOIN_ORDER(t3, t2) JOIN_ORDER(t1, t2, t5) */ count(*) FROM t1 JOIN t2 JOIN t3
              WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4)
                AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
let $query= SELECT /*+ JOIN_ORDER(t1, t7, t5) */ count(*) FROM t1 JOIN t2 JOIN t3
              WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4)
                AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
let $query= SELECT /*+ JOIN_PREFIX(t2, t5@subq2, t4@subq1) JOIN_ORDER(t4@subq1, t3) JOIN_SUFFIX(t1) */ count(*) 
             FROM t1 JOIN t2 JOIN t3
               WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4)
                 AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
let $query= SELECT /*+ JOIN_ORDER(t3, t2) JOIN_ORDER(t2, t3) */ count(*) FROM t1 JOIN t2 JOIN t3
              WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4)
                AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
let $query= SELECT /*+ JOIN_ORDER(t3, t2) JOIN_SUFFIX(t3) */ count(*) FROM t1 JOIN t2 JOIN t3
              WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4)
                AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
let $query= SELECT /*+ JOIN_ORDER(t3, t2) JOIN_PREFIX(t2) */ count(*) FROM t1 JOIN t2 JOIN t3
              WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4)
                AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
let $query= SELECT /*+ JOIN_ORDER(t4@subq1, t3) JOIN_SUFFIX(t1) JOIN_PREFIX(t2, t5@subq2, t4@subq1) */ count(*)
             FROM t1 JOIN t2 JOIN t3
               WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4)
                 AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);

-- JOIN_PREFIX with all tables.

let $query= SELECT /*+ JOIN_PREFIX(t2, t5@subq2, t4@subq1, t3, t1) */ count(*)
             FROM t1 JOIN t2 JOIN t3
               WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4)
                 AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);

-- JOIN_SUFFIX with all tables.

let $query= SELECT /*+ JOIN_SUFFIX(t2, t5@subq2, t4@subq1, t3, t1) */ count(*)
             FROM t1 JOIN t2 JOIN t3
               WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4)
                 AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);

-- JOIN_ORDER with all tables.

let $query= SELECT /*+ JOIN_ORDER(t2, t5@subq2, t4@subq1, t3, t1) */ count(*)
             FROM t1 JOIN t2 JOIN t3
               WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4)
                 AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);

-- JOIN_PREFIX, JOIN_ORDER, JOIN_SUFFIX with all tables.

let $query= SELECT /*+  JOIN_SUFFIX(t2, t5@subq2, t4@subq1, t3, t1)
                        JOIN_ORDER(t2, t5@subq2, t4@subq1, t3, t1)
                        JOIN_PREFIX(t2, t5@subq2, t4@subq1, t3, t1) */ count(*)
             FROM t1 JOIN t2 JOIN t3
               WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4)
                 AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
let $query= SELECT STRAIGHT_JOIN /*+  QB_NAME(q1) JOIN_ORDER(t2, t1) */ count(*) FROM t1 JOIN t2 JOIN t3
              WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4)
                AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);


-- Test JOIN_FIXED_ORDER.
let $query= SELECT /*+  QB_NAME(q1) JOIN_FIXED_ORDER(@q1) */ count(*) FROM t1 JOIN t2 JOIN t3
              WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4)
                AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);

let $query= SELECT /*+  QB_NAME(q1) */ count(*) FROM t1 JOIN t2 JOIN t3
              WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4)
                AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);

-- Testing STRAIGHT_JOIN

let $query= SELECT count(*) FROM t1 JOIN t2 STRAIGHT_JOIN t3
            WHERE t1.f1 IN (SELECT f1 FROM t4) AND t2.f1 IN (SELECT f1 FROM t5);
let $query= SELECT /*+ JOIN_PREFIX(t3, t1) */ count(*) FROM t1 JOIN t2 STRAIGHT_JOIN t3
            WHERE t1.f1 IN (SELECT f1 FROM t4) AND t2.f1 IN (SELECT f1 FROM t5);
let $query= SELECT /*+ JOIN_PREFIX(t1, t2, t3) */ count(*) FROM t1 JOIN t2 STRAIGHT_JOIN t3
            WHERE t1.f1 IN (SELECT f1 FROM t4) AND t2.f1 IN (SELECT f1 FROM t5);
let $query= SELECT /*+ JOIN_SUFFIX(t4, t5) */ count(*) FROM t1 JOIN t2 STRAIGHT_JOIN t3
            WHERE t1.f1 IN (SELECT f1 FROM t4) AND t2.f1 IN (SELECT f1 FROM t5);

-- alternative syntax
let $query= SELECT /*+ QB_NAME(q1) JOIN_ORDER(@q1 t2, t3, t1) */ count(*)
             FROM t1 JOIN t2 JOIN t3
               WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4)
                 AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);

-- alternative syntax
let $query= SELECT /*+ QB_NAME(q1) JOIN_PREFIX(@q1 t2, t3, t1) */ count(*)
             FROM t1 JOIN t2 JOIN t3
               WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4)
                 AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);

-- alternative syntax
let $query= SELECT /*+ QB_NAME(q1) JOIN_SUFFIX(@q1 t2, t3, t1) */ count(*)
             FROM t1 JOIN t2 JOIN t3
               WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4)
                 AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);


DROP TABLE t1, t2, t3, t4 ,t5, t6;

-- Testing embedded join

CREATE TABLE t1 (f1 INT);
CREATE TABLE t2 (f1 INT);
CREATE TABLE t3 (f1 INT);
CREATE TABLE t4 (f1 INT);
    JOIN t2 ON 1
      RIGHT JOIN t3 ON 1
    JOIN t4 ON  1;
    JOIN t2 ON 1
      RIGHT JOIN t3 ON 1
    JOIN t4 ON  1;
    JOIN t2 ON 1
      RIGHT JOIN t3 ON 1
    JOIN t4 ON  1;
    JOIN t2 ON 1
      RIGHT JOIN t3 ON 1
    JOIN t4 ON  1;
    JOIN t2 ON 1
      RIGHT JOIN t3 ON 1
    JOIN t4 ON  1;
    JOIN t2 ON 1
      RIGHT JOIN t3 ON 1
    JOIN t4 ON  1;
    JOIN t2 ON 1
      RIGHT JOIN t3 ON 1
    JOIN t4 ON  1;

DROP TABLE t1, t2, t3, t4;

CREATE TABLE t1
(
  f1 INT(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (f1)
);

CREATE TABLE t2
(
  f1 INT(11) DEFAULT NULL
);

CREATE TABLE t3
(
  f1 INT(11) DEFAULT NULL
);

-- Original query
EXPLAIN DELETE
FROM ta1.* USING t1 AS ta1 JOIN t1 AS ta2 ON 1
    RIGHT OUTER JOIN t2 ON (ta1.f1 = t2.f1)
WHERE (9) IN (SELECT f1 FROM t3);
    RIGHT OUTER JOIN t2 ON (ta1.f1 = t2.f1)
WHERE (9) IN (SELECT f1 FROM t3);
    RIGHT OUTER JOIN t2 ON (ta1.f1 = t2.f1)
WHERE (9) IN (SELECT f1 FROM t3);
    RIGHT OUTER JOIN t2 ON (ta1.f1 = t2.f1)
WHERE (9) IN (SELECT f1 FROM t3);
    RIGHT OUTER JOIN t2 ON (ta1.f1 = t2.f1)
WHERE (9) IN (SELECT f1 FROM t3);
    RIGHT OUTER JOIN t2 ON (ta1.f1 = t2.f1)
WHERE (9) IN (SELECT f1 FROM t3);

DROP TABLE t1, t2, t3;

-- Const table behavior, table order is not changed, hint is applicable

CREATE TABLE t1(f1 INT) ENGINE=MyISAM;
INSERT INTO t1 VALUES (1);

CREATE TABLE t2(f1 INT) ENGINE=InnoDB;
INSERT INTO t2 VALUES (1);

DROP TABLE t1, t2;

CREATE TABLE t1 (
f1 int(11) NOT NULL AUTO_INCREMENT,
f2 varchar(255) DEFAULT NULL,
PRIMARY KEY (f1));

CREATE TABLE t2 (
f1 int(11) NOT NULL AUTO_INCREMENT,
f2 varchar(255) CHARACTER SET utf8mb3 DEFAULT NULL,
f3 varchar(10) DEFAULT NULL,
PRIMARY KEY (f1),
KEY f3(f3));
 ON t2.f1 = t1.f1 WHERE t1.f2 NOT LIKE ('FMGAU') OR t2.f2 > 't';

DROP TABLE t1, t2;


CREATE TABLE t1
(
  f1 int(11) DEFAULT NULL,
  KEY f1 (f1)
);

CREATE TABLE t2
(
  f1 int(11) DEFAULT NULL,
  f2 varchar(255) CHARACTER SET utf8mb3 DEFAULT NULL,
  KEY f2 (f2),
  KEY f1 (f1)
);

CREATE TABLE t3 (
  f1 int(11) DEFAULT NULL,
  f2 varchar(255) CHARACTER SET cp932 DEFAULT NULL,
  KEY f1 (f1),
  KEY f2 (f2)
);

DROP TABLE t1, t2, t3;

CREATE TABLE t1 (
  f1 INT(11) NOT NULL AUTO_INCREMENT,
  f2 INT(11) DEFAULT NULL,
  PRIMARY KEY (f1)
);

CREATE TABLE t2 (
  f1 INT(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (f1)
);

DROP TABLE t1, t2;

CREATE TABLE t1
(
  f1 DATETIME,
  f2 DATE,
  f3 VARCHAR(1),
  KEY (f1)
) ENGINE=myisam;

CREATE TABLE t2
(
  f1 VARCHAR(1),
  f2 INT,
  f3 VARCHAR(1),
  KEY (f1)
) ENGINE=innodb;

CREATE TABLE t3
(
  f1 VARCHAR(1),
  f2 DATE,
  f3 DATETIME,
  f4 INT
) ENGINE=myisam;
UPDATE /*+ JOIN_ORDER(t2, als1, als3) JOIN_FIXED_ORDER()  */ t3 AS als1
   JOIN t1 AS als2 ON (als1.f3 = als2 .f1)
     JOIN t1 AS als3 ON (als1.f1 = als3.f3)
       RIGHT OUTER JOIN t3 AS als4 ON (als1.f3 = als4.f2)
SET als1.f4 = 'eogqjvbhzodzimqahyzlktkbexkhdwxwgifikhcgblhgswxyutepc'
WHERE ('i','b') IN (SELECT f3, f1 FROM t2 WHERE f2 <> f2 AND als2.f2 IS NULL);

DROP TABLE t1, t2, t3;


CREATE TABLE t1(
f1 VARCHAR(1)) ENGINE=myisam;

CREATE TABLE t2(
f1 VARCHAR(1),
f2 VARCHAR(1),
f3 DATETIME,
KEY(f2)) ENGINE=innodb;

CREATE TABLE t3(
f1 INT,
f2 DATE,
f3 VARCHAR(1),
KEY(f3)) ENGINE=myisam;

CREATE TABLE t4(
f1 VARCHAR(1),
KEY(f1)) ENGINE=innodb;
ALTER TABLE t4 DISABLE KEYS;
INSERT INTO t4 VALUES ('x'), (NULL), ('d'), ('x'), ('u');
ALTER TABLE t4 ENABLE KEYS;

CREATE TABLE t5(
f1 VARCHAR(1),
KEY(f1) ) ENGINE=myisam;
INSERT INTO t5 VALUES  (NULL), ('s'), ('c'), ('x'), ('z');
    JOIN t3 AS alias3 ON (alias1.f2 = alias3.f2 )
      RIGHT OUTER JOIN t1 ON (alias1.f3 = t1.f1)
SET alias1.f1 = -1
WHERE ( 'v', 'o' )  IN
(SELECT DISTINCT t2.f1, t2.f2 FROM t4 RIGHT OUTER JOIN t2 ON (t4.f1 = t2.f1)
 WHERE t2.f3 BETWEEN '2001-10-04' AND '2003-05-15');

DROP TABLE t1, t2, t3, t4, t5;

CREATE TABLE t1 (
  f1 INT(11) DEFAULT NULL,
  f3 VARCHAR(1) DEFAULT NULL,
  f2 INT(11) DEFAULT NULL,
  KEY (f1)
) ENGINE=MyISAM;

CREATE TABLE t2(
  f1 INT(11) DEFAULT NULL
) ENGINE=MyISAM;

CREATE TABLE t3 (
  f1 VARCHAR(1) DEFAULT NULL,
  f2 VARCHAR(1) DEFAULT NULL,
  KEY (f2)
) ENGINE=InnoDB;
  t1 AS ta1 JOIN t1 AS ta2 ON ta1.f1 = ta2.f1 RIGHT JOIN t2 ON (ta1.f1 = t2.f1)
SET ta1.f2 = '', ta2.f3 = ''
WHERE ('n', 'r') IN (SELECT f2, f1 FROM t3 WHERE f1 <> f2 XOR ta2.f3 IS NULL);

DROP TABLE t1, t2, t3;


CREATE TABLE t2(f1 VARCHAR(255) DEFAULT NULL, f2 INT(11) DEFAULT NULL,
  KEY (f1), KEY (f2)) charset latin1 ENGINE=MyISAM;

CREATE TABLE t4(f1 INT(11) DEFAULT NULL, f2 INT(11) DEFAULT NULL, KEY (f1))
charset latin1 ENGINE=MyISAM;
CREATE TABLE t5(f1 INT(11) NOT NULL AUTO_INCREMENT, f2 INT(11) DEFAULT NULL, PRIMARY KEY (f1))
charset latin1 ENGINE=InnoDB;
CREATE TABLE t6(f1 INT(11) NOT NULL AUTO_INCREMENT, PRIMARY KEY (f1))
charset latin1 ENGINE=InnoDB;
CREATE TABLE t7 (f1 VARCHAR(255) DEFAULT NULL)
charset latin1 ENGINE=InnoDB;

CREATE TABLE t10(f1 INT(11) NOT NULL AUTO_INCREMENT,f2 INT(11) DEFAULT NULL,f3 VARCHAR(10) DEFAULT NULL,
  PRIMARY KEY (f1),KEY (f2),KEY (f3)) charset latin1 ENGINE=MyISAM;

CREATE TABLE t11(f1 INT(11) DEFAULT NULL,f2 VARCHAR(10) DEFAULT NULL,
  KEY (f1),KEY (f2)) charset latin1 ENGINE=InnoDB;
SELECT /*+ JOIN_ORDER(alias11, alias8) */ 1
FROM t4 AS alias4
  LEFT JOIN t5 AS alias5 JOIN t6 AS alias6 ON alias5.f2 = alias6.f1
  LEFT JOIN t7 AS alias7 JOIN t2 AS alias8 ON alias7.f1 = alias8.f1
    ON alias5.f1 = alias8.f2 ON alias4.f2 = alias6.f1
  JOIN t10 AS alias10 JOIN t11 AS alias11 ON alias10.f1 = alias11.f1
    ON alias4.f2 = alias11.f2;
SELECT /*+ JOIN_ORDER(alias11, alias10, alias8, alias7) */ 1
FROM t4 AS alias4
  LEFT JOIN t5 AS alias5 JOIN t6 AS alias6 ON alias5.f2 = alias6.f1
  LEFT JOIN t7 AS alias7 JOIN t2 AS alias8 ON alias7.f1 = alias8.f1
    ON alias5.f1 = alias8.f2 ON alias4.f2 = alias6.f1
  JOIN t10 AS alias10 JOIN t11 AS alias11 ON alias10.f1 = alias11.f1
    ON alias4.f2 = alias11.f2;

DROP TABLES t2, t4, t5, t6, t7, t10, t11;

CREATE TABLE t1 (f1 VARCHAR(255) DEFAULT NULL, f2 VARCHAR(255) DEFAULT NULL,
  KEY (f1), KEY (f2)) ENGINE=InnoDB;

CREATE TABLE t2(f1 VARCHAR(255) DEFAULT NULL, f2 INT(11) DEFAULT NULL,
  KEY (f1), KEY (f2)) ENGINE=InnoDB;

CREATE TABLE t3(
  f1 INT(11) NOT NULL AUTO_INCREMENT, f2 VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (f1), KEY (f2)) ENGINE=InnoDB;

CREATE TABLE t4(f1 INT(11) DEFAULT NULL, f2 INT(11) DEFAULT NULL, KEY (f1)) ENGINE=InnoDB;
CREATE TABLE t6(f1 INT(11) NOT NULL AUTO_INCREMENT, PRIMARY KEY (f1)) ENGINE=InnoDB;
CREATE TABLE t7 (f1 VARCHAR(255) DEFAULT NULL) ENGINE=InnoDB;

CREATE TABLE t10(f1 INT(11) NOT NULL AUTO_INCREMENT,f2 INT(11) DEFAULT NULL,f3 VARCHAR(10) DEFAULT NULL,
  PRIMARY KEY (f1),KEY (f2),KEY (f3)) ENGINE=InnoDB;
    JOIN t2 AS alias2
      LEFT JOIN t3 AS alias3 JOIN t4 AS alias4 ON alias4.f2 = alias3.f1
      ON alias4.f1 =  alias2.f1
    ON alias2.f2 = alias7.f1
    JOIN t10 AS alias5
      LEFT JOIN t6 AS alias6 JOIN t2 AS alias8 ON alias6.f1 = alias8.f2
      ON alias6.f1 =  alias5.f1
    ON alias5.f3 = alias7.f1
  ON alias1.f2 = alias7.f1;

DROP TABLES t1, t2, t3, t4, t6, t7, t10;

CREATE TABLE t1 (
f1 int(11) NOT NULL AUTO_INCREMENT,
f2 int(11) DEFAULT NULL,
f3 int(11) DEFAULT NULL,
PRIMARY KEY (f1),
KEY f2 (f2))
ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

CREATE TABLE t2 (
f1 int(11) NOT NULL AUTO_INCREMENT,
f2 int(11) DEFAULT NULL,
f3 int(11) DEFAULT NULL,
PRIMARY KEY (f1),
KEY f2 (f2))
ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
    ON alias1.f2 = alias2.f3
WHERE alias2.f2 IS NULL HAVING (field1 != 3 AND field1 >= 8);

DROP TABLE t1, t2;

--
-- JOIN_FIXED_ORDER and JOIN_ORDER, JOIN_PREFIX, JOIN_SUFFIX can not be used at the
-- same time. 'conflicting hint' warning is issued in this case.
CREATE TABLE t1
(
  f1 int(11) NOT NULL AUTO_INCREMENT,
  f2 INT(11) DEFAULT NULL,
  PRIMARY KEY (f1)
);

CREATE TABLE t2
(
  f1 int(11) NOT NULL AUTO_INCREMENT,
  f2 INT(11) DEFAULT NULL,
  PRIMARY KEY (f1),
  KEY (f2)
);

DROP TABLE t1, t2;

CREATE TABLE t1
(
  f1 INT(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (f1)
) ENGINE=InnoDB;

CREATE TABLE t2
(
  f1 VARCHAR(1) DEFAULT NULL
) ENGINE=MyISAM;

CREATE TABLE t3
(
  f1 VARCHAR(1) DEFAULT NULL
) ENGINE=MyISAM;

DROP TABLE t1, t2, t3;

CREATE TABLE t1(f1 INT(11) NOT NULL);
INSERT INTO t1 VALUES (10);

CREATE TABLE t2
(
  f1 INT(11) NOT NULL AUTO_INCREMENT,
  f2 INT(11) DEFAULT NULL,
  PRIMARY KEY (f1),
  KEY (f2)
);
INSERT INTO t2 VALUES (1, 7), (2, 1), (4, 7);

CREATE TABLE t4(f1 INT DEFAULT NULL);
INSERT INTO t4 VALUES (2);

let $query=
SELECT
COUNT(*) FROM t1 JOIN t2 AS ta3 JOIN t2 AS ta4
WHERE ta4.f1 IN (SELECT /*+ QB_NAME(qb1) */ f1 FROM t4) AND
      ta3.f2 IN (SELECT /*+ QB_NAME(qb2) */ f2 FROM t2);

let $query=
SELECT /*+ JOIN_PREFIX(t2@qb2, t4@qb1, ta3, ta4) */
COUNT(*) FROM t1 JOIN t2 AS ta3 JOIN t2 AS ta4
WHERE ta4.f1 IN (SELECT /*+ QB_NAME(qb1) */ f1 FROM t4) AND
      ta3.f2 IN (SELECT /*+ QB_NAME(qb2) */ f2 FROM t2);

DROP TABLE t1, t2, t4;
