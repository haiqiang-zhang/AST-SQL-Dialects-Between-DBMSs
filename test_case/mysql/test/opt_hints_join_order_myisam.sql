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
