SELECT * FROM information_schema.table_constraints
WHERE table_schema = 'mysql' AND table_name != 'ndb_binlog_index'
ORDER BY table_schema,table_name,constraint_name COLLATE utf8mb3_general_ci;
CREATE TABLE t1 (
  pk int(11) NOT NULL DEFAULT '0',
  col_int_key int(11) DEFAULT NULL,
  col_varchar_key varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO t1 VALUES
(22,0,NULL),
(17,9,NULL),
(29,8,'c'),
(23,4,'d'),
(11,7,'d'),
(26,NULL,'f'),
(13,7,'f'),
(24,8,'g'),
(28,NULL,'j'),
(16,1,'m'),
(20,2,'m'),
(18,2,'o'),
(27,0,'p'),
(21,4,'q'),
(12,1,'r'),
(15,NULL,'u'),
(19,9,'w'),
(25,NULL,'x'),
(10,8,'x'),
(14,9,'y');
SELECT *
FROM (
  SELECT DISTINCT SUBQUERY1_t1.*
  FROM (
    t1 AS SUBQUERY1_t1
    LEFT OUTER JOIN
    t1 AS SUBQUERY1_t2
    ON (SUBQUERY1_t2.`pk` = SUBQUERY1_t1.`col_int_key`)
  )
) AS table1
WHERE table1.`col_varchar_key` IS NULL;
DROP TABLE t1;
CREATE TABLE t1 (
  id INT NOT NULL AUTO_INCREMENT,
  c1 CHAR(60) NOT NULL,
  c2 CHAR(60),
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO t1 (c1, c2) VALUES
('abcdefghij', 'ABCDEFGHIJ'),
('mnopqrstuv', 'MNOPQRSTUV');
SELECT DISTINCT c1, c2 FROM t1 WHERE id BETWEEN 1 And 2 ORDER BY 1;
DROP TABLE t1;
CREATE TABLE t1 (c1 VARCHAR(10) COLLATE utf8mb4_bin) ENGINE = InnoDB;
INSERT INTO t1 VALUES (''), (' ');
SELECT DISTINCT(c1) FROM t1;
DROP TABLE t1;
DROP DATABASE temptable_test;
