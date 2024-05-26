SELECT schema_name, HEX(schema_name)
  FROM information_schema.schemata
  WHERE schema_name NOT IN ('mtr', 'sys')
  ORDER BY schema_name;
CREATE TABLE t1a (c CHAR(1) PRIMARY KEY) DEFAULT CHARSET = gb18030;
CREATE TABLE t1b (c CHAR(1) PRIMARY KEY) DEFAULT CHARSET = gb18030;
CREATE TABLE t2a (c CHAR(1) PRIMARY KEY) DEFAULT CHARSET = gb18030;
CREATE TABLE t2b (c CHAR(1) PRIMARY KEY) DEFAULT CHARSET = gb18030;
SELECT c FROM t1a WHERE c IN (SELECT c FROM t1b);
SELECT c FROM t1a WHERE EXISTS (SELECT c FROM t1b WHERE t1a.c = t1b.c);
SELECT c FROM t1a WHERE NOT EXISTS (SELECT c FROM t1b WHERE t1a.c = t1b.c);
SELECT c FROM t2a WHERE c IN (SELECT c FROM t2b);
SELECT c FROM t2a WHERE EXISTS (SELECT c FROM t2b WHERE t2a.c = t2b.c);
SELECT c FROM t2a WHERE NOT EXISTS (SELECT c FROM t2b WHERE t2a.c = t2b.c);
SELECT * FROM t1a JOIN t1b;
SELECT * FROM t1a INNER JOIN t1b;
SELECT * FROM t1a JOIN t1b USING (c);
SELECT * FROM t1a INNER JOIN t1b USING (c);
SELECT * FROM t1a CROSS JOIN t1b;
SELECT * FROM t1a LEFT JOIN t1b USING (c);
SELECT * FROM t1a LEFT JOIN t1b ON (t1a.c = t1b.c);
SELECT * FROM t1b RIGHT JOIN t1a USING (c);
SELECT * FROM t1b RIGHT JOIN t1a ON (t1a.c = t1b.c);
SELECT * FROM t2a JOIN t2b;
SELECT * FROM t2a INNER JOIN t2b;
SELECT * FROM t2a JOIN t2b USING (c);
SELECT * FROM t2a INNER JOIN t2b USING (c);
SELECT * FROM t2a CROSS JOIN t2b;
SELECT * FROM t2a LEFT JOIN t2b USING (c);
SELECT * FROM t2a LEFT JOIN t2b ON (t2a.c = t2b.c);
SELECT * FROM t2b RIGHT JOIN t2a USING (c);
SELECT * FROM t2b RIGHT JOIN t2a ON (t2a.c = t2b.c);
DROP TABLE t1a, t1b, t2a, t2b;
CREATE TABLE t1 (c VARCHAR(10)) DEFAULT CHARSET = gb18030;
SELECT c, COUNT(c) FROM t1 GROUP BY c;
DROP TABLE t1;
CREATE TABLE t1 (c1 CHAR(3)) DEFAULT CHARSET = gb18030;
CREATE TABLE t2 (c1 CHAR(3)) DEFAULT CHARSET = gb18030;
CREATE TABLE t4 (c1 CHAR(3)) DEFAULT CHARSET = gb18030;
INSERT INTO t1 VALUES ('xxx');
PREPARE stmt4 FROM 'SELECT CHAR_LENGTH(?)';
PREPARE stmt5 FROM 'SELECT CHARSET(?)';
PREPARE stmt6 FROM 'SELECT INSERT(c1,1,1,?) FROM t1';
PREPARE stmt7 FROM 'SELECT INSTR(c1,?) FROM t2';
PREPARE stmt8 FROM 'SELECT LOCATE(?,c1) FROM t2';
PREPARE stmt9 FROM 'SELECT LPAD(c1,9,?) FROM t1';
PREPARE stmt10 FROM 'SELECT REPLACE(c1,?,\'x\') FROM t2';
PREPARE stmt11 FROM 'SELECT REPLACE(c1,\'x\',?) FROM t1';
PREPARE stmt12 FROM 'SELECT RPAD(c1,9,?) FROM t1';
PREPARE stmt13 FROM 'UPDATE t4 SET c1=\'x\' WHERE c1=?';
PREPARE stmt14 FROM 'UPDATE t4 SET c1=? WHERE c1=\'x\'';
SELECT * FROM t4;
SELECT * FROM t4;
SELECT * FROM t4;
SELECT * FROM t4;
SELECT * FROM t4;
SELECT * FROM t4;
DEALLOCATE PREPARE stmt4;
DEALLOCATE PREPARE stmt5;
DEALLOCATE PREPARE stmt6;
DEALLOCATE PREPARE stmt7;
DEALLOCATE PREPARE stmt8;
DEALLOCATE PREPARE stmt9;
DEALLOCATE PREPARE stmt10;
DEALLOCATE PREPARE stmt11;
DEALLOCATE PREPARE stmt12;
DEALLOCATE PREPARE stmt13;
DEALLOCATE PREPARE stmt14;
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t4;
