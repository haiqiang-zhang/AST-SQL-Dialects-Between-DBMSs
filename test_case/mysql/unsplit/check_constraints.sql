CREATE TABLE t1 (f1 int CHECK(f1 < 10),
                 f2 int CONSTRAINT t1_f2_ck CHECK (f2 < 10));
DROP TABLE t1;
CREATE TABLE t1 (f1 int CHECK(f1 < 10), f2 int CHECK(f2 < 10),
                 f3 int CONSTRAINT t1_f3_ck CHECK (f3  < 10));
DROP TABLE t1;
CREATE TABLE t1(f1 int, CONSTRAINT t1_ck CHECK(f1 < 10));
DROP TABLE t1;
CREATE TABLE t1(f1 int, CHECK(f1<10), CONSTRAINT t2_ck CHECK(f1 > 1));
DROP TABLE t1;
CREATE TABLE t1(c1 INT, c2 INT, CONSTRAINT `ck_1$` CHECK (c2 < 10));
DROP TABLE t1;
CREATE TABLE t1(c1 INT, c2 INT, CONSTRAINT ` ck_2$ ` CHECK (c2 < 10));
ALTER TABLE t1 DROP CHECK ` ck_2$ `;
ALTER TABLE t1 ADD COLUMN c3 INTEGER , ADD CONSTRAINT ` c 3 ` CHECK ( c3 > 10 );
DROP TABLE t1;
CREATE TABLE t1(c1 INT, c2 INT, CONSTRAINT `FLOAT` CHECK (c2 < 10));
DROP TABLE t1;
CREATE TABLE t1(c1 INT, c2 INT,
                CONSTRAINT ckkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
                CHECK (c2 < 10));
DROP TABLE t1;
CREATE TABLE t1 (f1 INT CHECK (f1 < 10));
DROP TABLE t1;
CREATE TABLE t123456789012345678901234567890123456789012345678901234567890(f1 INT);
DROP TABLE t123456789012345678901234567890123456789012345678901234567890;
CREATE TABLE t(c1 INT CONSTRAINT t2_chk_1 CHECK (c1 > 10));
CREATE TABLE t1(c1 INT CHECK (c1 > 10), CONSTRAINT ck CHECK(c1 > 10));
DROP TABLE t;
CREATE DATABASE db1;
CREATE TABLE db1.t(c1 INT CONSTRAINT t2_chk_1 CHECK (c1 > 10));
DROP DATABASE db1;
DROP TABLE t1;
create table t1 (f1 int,
                 CONSTRAINT cafe CHECK (f1 < 10),
                 CONSTRAINT cafÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ© CHECK (f1 < 10));
DROP TABLE t1;
CREATE TABLE t1(CHECK((f1 + f2) > 10), f1 int CHECK (f1 < 10), f2 int);
SELECT * FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS;
DROP TABLE t1;
CREATE TABLE t1(c1 INT, c2 INT, c3 INT, c4 INT);
ALTER TABLE t1 ADD CONSTRAINT ck11 CHECK(c1 > 1),
      ADD CONSTRAINT ck12 CHECK(c1 < 1),
      ADD CONSTRAINT ck21 CHECK(c2 > 1),
      ADD CONSTRAINT ck22 CHECK(c2 < 1),
      ADD CONSTRAINT ck31 CHECK(c3 > 1),
      ADD CONSTRAINT ck32 CHECK(c3 < 1),
      ADD CONSTRAINT ck41 CHECK(c4 > 1),
      ADD CONSTRAINT ck42 CHECK(c4 < 1);
DROP TABLE t1;
CREATE TABLE t1(c1 INT,
  c2 INT,
  c3 INT GENERATED ALWAYS AS (c1 + c2),
  CONSTRAINT ck CHECK (c3 > 10)
);
INSERT INTO t1(c1,c2) VALUES(10,10);
DROP TABLE t1;
CREATE TABLE t1(c1 INT DEFAULT 100 CHECK(c1 > 10));
INSERT INTO t1() VALUES();
DROP TABLE t1;
CREATE TABLE t1(c1 int DEFAULT 1, CONSTRAINT CHECK(c1 IS NOT NULL));
INSERT INTO t1() VALUES();
DROP TABLE t1;
CREATE TABLE t1(c1 VARCHAR(1) CHARSET ASCII CHECK(c1 = 'a'),
   c2 VARCHAR(1) CHARSET ASCII DEFAULT('b'));
INSERT INTO t1(c1) VALUES('a');
DROP TABLE t1;
CREATE TABLE t1 (CHECK (1 < 1), f1 int);
DROP TABLE t1;
CREATE TABLE t1(f1 INT PRIMARY KEY, f2 INT CHECK (f2 < 10),
                CONSTRAINT t2_cc1 CHECK (f1 + SQRT(f2) > 6174));
SELECT * FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS;
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME='t1';
DROP TABLE t1;
CREATE TEMPORARY TABLE tmp_t1(CHECK((f1 + f2) > 10), f1 int CHECK (f1 < 12),
                              f2 int);
SELECT * FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS;
DROP TABLE tmp_t1;
CREATE TABLE t1(f1 INT CHECK (f1 < 10), f2 INT, CHECK (f2 < 10),
                CONSTRAINT min CHECK (f1 + f2 > 10),
                CONSTRAINT max CHECK (f1 + f2 < 929));
CREATE TABLE t2 LIKE t1;
CREATE TEMPORARY TABLE tmp_t2 LIKE t2;
CREATE TABLE t3 LIKE tmp_t2;
DROP TABLE t1, t2, t3, tmp_t2;
CREATE TABLE t1(f1 INT PRIMARY KEY, f2 INT CHECK (f2 < 10));
CREATE TABLE t2(f1 INT, f2 INT);
INSERT INTO t2 VALUES(101, 1);
INSERT INTO t2 VALUES(102, NULL);
INSERT INTO t2 VALUES(103, 1000);
INSERT INTO t1 VALUES(1, 1);
INSERT INTO t1 VALUES(2, NULL);
INSERT IGNORE INTO t1 VALUES (3, 1000);
SELECT * FROM t1;
SELECT * FROM t1;
INSERT IGNORE INTO t1 SELECT * FROM t2;
SELECT * FROM t1;
SELECT * FROM t1;
UPDATE t1 SET f2 = 2;
SELECT * FROM t1;
UPDATE t1 SET f2 = NULL;
UPDATE IGNORE t1 SET f2 = 1000;
SELECT * FROM t1;
DROP TABLE t1, t2;
CREATE TABLE t2(f1 INT,f2 INT);
INSERT INTO t2 VALUES(1,1);
INSERT INTO t2 VALUES(2,NULL);
CREATE TABLE t1(f1 INT PRIMARY KEY, f2 INT CHECK (f2 < 10));
SELECT * FROM t2;
SELECT * FROM t1;
DELETE FROM t1;
INSERT INTO t2 VALUES(3,20);
SELECT * FROM t2;
SELECT * FROM t1;
SELECT * FROM t1;
DROP TABLE t1,t2;
CREATE TABLE t1 (a INT CHECK(a < 3), b CHAR(10)) CHARSET latin1;
DROP TABLE t1;
CREATE TABLE t2(f1 INT,f2 INT);
INSERT INTO t2 VALUES(1,1);
INSERT INTO t2 VALUES(2,NULL);
CREATE TABLE t1(f1 INT PRIMARY KEY, f2 INT CHECK (f2 < 10));
SELECT * FROM t2;
SELECT * FROM t1;
DELETE FROM t1;
INSERT INTO t2 VALUES(3,20);
SELECT * FROM t2;
SELECT * FROM t1;
SELECT * FROM t1;
DROP TABLE t1,t2;
CREATE TABLE t1(f1 INT PRIMARY KEY, f2 INT CHECK (f2 < 10));
INSERT INTO t1 VALUES (1, 1);
INSERT INTO t1 VALUES (1, 2) ON DUPLICATE KEY UPDATE f2 = 4;
SELECT * FROM t1;
INSERT IGNORE INTO t1 VALUES (1, 1) ON DUPLICATE KEY UPDATE f2 = 20;
DROP TABLE t1;
CREATE TABLE t1(f1 INT, f2 INT CHECK(f2 < 20));
INSERT INTO t1 VALUES (4, 4);
CREATE TABLE t2(f1 INT, f2 INT);
INSERT INTO t2 VALUES (4, 24);
UPDATE IGNORE t1,t2  SET t1.f2 = t1.f2 + 20 WHERE t1.f1 = t2.f1;
DROP TABLE t1, t2;
CREATE TABLE t1 (
   `f1` int(10) unsigned NOT NULL auto_increment,
   `f2` int(11) NOT NULL default '0',
   PRIMARY KEY  (`f1`)
);
INSERT INTO t1 VALUES (4433,5424);
CREATE TABLE t2 (
  `f3` int(10) unsigned NOT NULL default '0',
  `f4` int(10) unsigned NOT NULL default '0' CHECK (f4 <= 500),
  PRIMARY KEY  (`f3`,`f4`)
);
INSERT INTO t2 VALUES (495,500);
INSERT INTO t2 VALUES (496,500);
UPDATE IGNORE t2,t1 set t2.f4 = t2.f4 + 1;
DROP TABLE t1, t2;
CREATE TABLE t1 (f1 INT CHECK(f1 < 10));
SELECT * FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS;
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME='t1';
DROP TABLE t1;
CREATE TABLE t1 (f1 INT CHECK (f1 < 10));
CREATE TEMPORARY TABLE t3(f1 INT CHECK (f1 < 10));
ALTER TABLE t1 ADD CONSTRAINT CHECK (f1 > 1), ADD CONSTRAINT `t1_p_ck` CHECK (f1 > 1);
ALTER TABLE t3 ADD CONSTRAINT CHECK (f1 > 1), ADD CONSTRAINT `t3_p_ck` CHECK (f1 > 1);
ALTER TABLE t1 ADD f2 INT CHECK (f2 < 10), RENAME TO t6, ALGORITHM=COPY;
ALTER TABLE t3 ADD f2 INT CHECK (f2 < 10), RENAME TO t7, ALGORITHM=COPY;
ALTER TABLE t6 RENAME TO t1;
ALTER TABLE t7 RENAME TO t3;
ALTER TABLE t1 ADD f3 INT CHECK (f3 < 10) NOT ENFORCED, ALGORITHM=INPLACE;
ALTER TABLE t1 ADD CONSTRAINT CHECK (f2 < 10) NOT ENFORCED, ALGORITHM=INPLACE;
ALTER TABLE t3 DROP CHECK t3_chk_3;
ALTER TABLE t3 DROP CHECK t3_p_ck, ADD CONSTRAINT t3_p_ck CHECK (f1 > 38);
INSERT INTO t1 VALUES (5, 5, 5);
ALTER TABLE t1 ALTER CHECK t1_chk_1 NOT ENFORCED, ALGORITHM=INPLACE;
INSERT INTO t1 VALUES (8, 8, 8);
ALTER TABLE t1 ALTER CHECK t1_chk_1 ENFORCED, ALGORITHM=COPY;
ALTER TABLE t1 ALTER CHECK t1_chk_1 ENFORCED, ALGORITHM=INPLACE;
ALTER TABLE t1 ALTER CHECK t1_chk_1 NOT ENFORCED, ALGORITHM=INPLACE;
INSERT INTO t1 VALUES (12, 5, 5);
DROP TABLE t1, t3;
CREATE TABLE t1(c1 INT);
ALTER TABLE t1 ADD CONSTRAINT CHECK (C1 > 10), ALGORITHM=COPY;
DROP TABLE t1;
CREATE TABLE t1 (f1 INT CHECK (f1 < 10));
ALTER TABLE t1 DROP CHECK t1_chk_1, ALGORITHM=INPLACE;
DROP TABLE t1;
CREATE TABLE t1 (c1 INT, CONSTRAINT ck1 CHECK (c1 > 10));
ALTER TABLE t1 ADD COLUMN c2 INT,
               ADD CONSTRAINT ck2 CHECK (c2 > 10);
ALTER TABLE t1 DROP CHECK ck2, DROP COLUMN c2;
ALTER TABLE t1 ADD COLUMN c3 INT,
               ADD CONSTRAINT ck3 CHECK (c3 < 10);
ALTER TABLE t1 DROP CHECK ck3, DROP COLUMN c3,
               ADD COLUMN c4 INT, ADD CONSTRAINT ck4 CHECK( c4 > 10);
DROP TABLE t1;
CREATE TABLE t1(f1 INT,
                f2 INT CHECK (f2 < 10),
                f3 INT CHECK (f3 < 10) NOT ENFORCED,
                CONSTRAINT ck CHECK (f1 > 10),
                CONSTRAINT CHECK (f1 > 10) NOT ENFORCED);
SELECT * FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS ORDER BY CONSTRAINT_NAME;
ALTER TABLE t1 ALTER CHECK ck NOT ENFORCED;
SELECT * FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS ORDER BY CONSTRAINT_NAME;
ALTER TABLE t1 ALTER CHECK ck ENFORCED;
SELECT * FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS ORDER BY CONSTRAINT_NAME;
ALTER TABLE t1 ADD CONSTRAINT ck1 CHECK(f1<10) NOT ENFORCED;
SELECT * FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS ORDER BY CONSTRAINT_NAME;
ALTER TABLE t1 ALTER CHECK ck1 ENFORCED;
SELECT * FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS ORDER BY CONSTRAINT_NAME;
ALTER TABLE t1 ALTER CHECK t1_chk_2 ENFORCED;
SELECT * FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS ORDER BY CONSTRAINT_NAME;
ALTER TABLE t1 ADD f4 INT CONSTRAINT t1_f4_chk CHECK (f4 < 10) NOT ENFORCED;
SELECT * FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS ORDER BY CONSTRAINT_NAME;
ALTER TABLE t1 ALTER CHECK t1_f4_chk ENFORCED;
SELECT * FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS ORDER BY CONSTRAINT_NAME;
DROP TABLE t1;
CREATE TABLE t1(c1 INT, c2 INT, c3 INT, c4 INT);
DROP TABLE t1;
CREATE TABLE t1(c1 INT, c2 INT, c3 INT, c4 INT);
ALTER TABLE t1 ADD CONSTRAINT ck11 CHECK(c1 > 1),
      ADD CONSTRAINT ck12 CHECK(c1 < 1),
      ADD CONSTRAINT ck21 CHECK(c2 > 1),
      ADD CONSTRAINT ck22 CHECK(c2 < 1),
      ADD CONSTRAINT ck31 CHECK(c3 > 1),
      ADD CONSTRAINT ck32 CHECK(c3 < 1),
      ADD CONSTRAINT ck41 CHECK(c4 > 1),
      ADD CONSTRAINT ck42 CHECK(c4 < 1);
ALTER TABLE t1
      DROP CHECK ck21, ADD CONSTRAINT ck21 CHECK (c1 > 10),
      DROP CHECK ck22, ADD CONSTRAINT ck22 CHECK (c1 < 10),
      DROP CHECK ck31, ADD CONSTRAINT ck31 CHECK (c1 > 10),
      DROP CHECK ck32, ADD CONSTRAINT ck32 CHECK (c1 < 10),
      DROP CHECK ck41, ADD CONSTRAINT ck41 CHECK (c1 > 10),
      DROP CHECK ck42, ADD CONSTRAINT ck42 CHECK (c1 < 10),
      ALTER CHECK ck11 NOT ENFORCED,
      ALTER CHECK ck12 NOT ENFORCED,
      ALTER CHECK ck11 ENFORCED;
DROP TABLE t1;
CREATE TABLE t1 (f1 INT check (f1 < 10), f2 INT);
ALTER TABLE t1 DROP COLUMN f1;
ALTER TABLE t1 ADD COLUMN f1 INT check(f1 < 10),
               ADD CONSTRAINT check(f1 + f2 < 10),
               ADD CONSTRAINT check(f2 < 10);
ALTER TABLE t1 DROP CHECK t1_chk_2, DROP COLUMN f1;
DROP TABLE t1;
CREATE TABLE t1(c1 CHAR(1), CHECK (c1 > 'A'));
INSERT INTO t1 VALUES('B');
DELETE FROM t1;
ALTER TABLE t1 MODIFY COLUMN c1 FLOAT(10.3), DROP CHECK t1_chk_1, ADD CONSTRAINT CHECK(C1 > 10.1) ENFORCED;
DROP TABLE t1;
CREATE TABLE t1 (f1 INT CHECK (f1 = default(f1)));
INSERT INTO t1 VALUES (10);
DROP TABLE t1;
CREATE TABLE t1(c1 CHAR(1), CHECK (c1 > 'A'));
ALTER TABLE t1 DROP CHECK t1_chk_1, CHANGE c1 c2 VARCHAR(20), ADD CONSTRAINT CHECK(c2 > 'B');
DROP TABLE t1;
CREATE TABLE t (a INT, b INT, CHECK(a != b));
INSERT INTO t VALUES (2000000000, 2000000001);
DROP TABLE t;
CREATE TABLE t1(f1 int CHECK (f1 IN (10, 20, 30)), f2 int, CHECK(f2 IN (100, 120, 450)));
INSERT INTO t1 VALUES(10, 100);
DROP TABLE t1;
CREATE TABLE t1(f1 int CHECK(f1 BETWEEN 10 AND 30),
                f2 int, CHECK(f2 BETWEEN 100 AND 450));
INSERT INTO t1 VALUES(20, 200);
DROP TABLE t1;
CREATE TABLE t1 (f1 int CHECK(f1 IS NOT NULL));
INSERT INTO t1 VALUES(10);
DROP TABLE t1;
CREATE TABLE t1 (f1 int CHECK(f1 IS NULL));
INSERT INTO t1 VALUES(NULL);
DROP TABLE t1;
CREATE TABLE t1(c1 INT, c2 INT);
ALTER TABLE t1 ADD CONSTRAINT CHECK( (CASE WHEN c1 > 10 THEN c2 = 20 END) = 1);
INSERT INTO t1 VALUES(1,1);
INSERT INTO t1 VALUES(15,20);
SELECT * FROM t1;
DROP TABLE t1;
CREATE PROCEDURE proc() SELECT 1;
DROP PROCEDURE proc;
CREATE TABLE t1 (
  c1 BIT(7) CHECK(c1 < B'1111100'),
  c2 BOOLEAN CHECK(c2 > 0),
  c3 TINYINT CHECK(c3 > 10),
  c4 SMALLINT CHECK(c4 > 10),
  c5 MEDIUMINT CHECK(c5 > 10),
  c6 INT CHECK(c6 > 10),
  c7 BIGINT CHECK(c7 > 10),
  c8 DECIMAL(6,2) CHECK(c8 > 10.1),
  c9 FLOAT(6,2) CHECK(c9 > 10.1),
  c10 DOUBLE(6,2) CHECK(c10 > 10.1));
INSERT INTO t1(c1,c2,c3,c4,c5,c6,c7,c8,c9,c10)
  VALUES(B'1111000',1,11,11,11,11,11,10.2,10.2,10.2);
DROP TABLE t1;
CREATE TABLE t1(c1 CHAR(1) CHECK(c1 > 'a'),
  c2 VARCHAR(1) CHECK(c2 > 'a'),
  c3 BINARY(1) CHECK(c3 > 'a'),
  c4 VARBINARY(1) CHECK(c4 > 'a'),
  c5 TINYBLOB CHECK(c5 > 'a'),
  c6 TINYTEXT CHECK(c6 > 'a'),
  c7 BLOB CHECK(c7 > 'a'),
  c8 TEXT CHECK(c8 > 'a'),
  c9 MEDIUMBLOB CHECK(c9 > 'a'),
  c10 MEDIUMTEXT CHECK(c10 > 'a'),
  c11 LONGBLOB CHECK(c11 > 'a'),
  c12 LONGTEXT CHECK(c12 > 'a'));
INSERT INTO t1(c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12)
  VALUES('b',"b","b","b","b","b","b","b","b","b","b","b");
DROP TABLE t1;
CREATE TABLE t1 (c1 DATE CHECK(c1 > '2007-01-01'),
  c2 DATETIME CHECK(c2 > '2007-01-01 12:00:01'),
  c3 TIMESTAMP CHECK(c3 > '2007-01-01 00:00:01.000000'),
  c4 TIME CHECK(c4 > '12:00:01.000000'),
  c5 YEAR CHECK(c5 > '2007'));
INSERT INTO t1(c1,c2,c3,c4,c5)
  VALUES('2008-01-01','2007-01-01 12:00:02','2007-01-01 00:00:02.000000',
        '12:00:02.000000','2008');
DROP TABLE t1;
CREATE TABLE t1(
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255),
  browser JSON CHECK( browser->'$.name' = "Chrome" ));
INSERT INTO t1(name,browser)
  VALUES('pageview','{ "name": "Chrome", "os": "Mac" }');
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (c1 ENUM ('a','b') CHECK (c1 IN ('c', 'd')) );
DROP TABLE t1;
CREATE TABLE t1 (c1 SET ('a','b') CHECK (c1 IN ('c', 'd')) );
DROP TABLE t1;
CREATE TABLE t1(
  pt POINT CHECK(ST_Equals(pt, ST_GEOMFROMTEXT('POINT(10 20)')) = TRUE),
  lnstr LINESTRING CHECK(ST_Equals(lnstr, ST_GEOMFROMTEXT('LINESTRING(0 0,5 5,6 6)'))),
  mlnstr MULTILINESTRING CHECK(ST_Equals(mlnstr, ST_GEOMFROMTEXT('MULTILINESTRING((0 0,2 3,4 5),
                                                                  (6 6,8 8,9 9,10 10))'))),
  poly POLYGON CHECK(ST_Equals(poly, ST_GEOMFROMTEXT('POLYGON((0 0,6 7,8 8,3 9,0 0),
                                                     (3 6,4 6,4 7,3 6))'))),
  mpoly MULTIPOLYGON CHECK(ST_Equals(mpoly, ST_GEOMFROMTEXT('MULTIPOLYGON(((0 0,0 5,5 5,5 0,0 0)),
                                                             ((2 2,4 5,6 2,2 2)))'))));
INSERT INTO t1(pt) VALUES (ST_GEOMFROMTEXT('POINT(10 20)'));
INSERT INTO t1(lnstr) VALUES (ST_GEOMFROMTEXT('LINESTRING(0 0,5 5,6 6)'));
INSERT INTO t1(mlnstr) VALUES (ST_GEOMFROMTEXT('MULTILINESTRING((0 0,2 3,4 5),(6 6,8 8,9 9,10 10))'));
INSERT INTO t1(poly) VALUES (ST_GEOMFROMTEXT('POLYGON((0 0,6 7,8 8,3 9,0 0),(3 6,4 6,4 7,3 6))'));
INSERT INTO t1(mpoly) VALUES (ST_GEOMFROMTEXT('MULTIPOLYGON(((0 0,0 5,5 5,5 0,0 0)),((2 2,4 5,6 2,2 2)))'));
DROP TABLE t1;
CREATE TABLE student
(
   id      	INT,
   stu_code 	VARCHAR(10),
   name    	VARCHAR(14),
   email   	VARCHAR(20),
   scholarship 	INT,
   country 	VARCHAR(20),
   CONSTRAINT ck1 CHECK (id != 0),
   CONSTRAINT ck2 CHECK (stu_code like 'j%'),
   CONSTRAINT ck3 CHECK (lower(name) != "noname"),
   CONSTRAINT ck4 CHECK (REGEXP_LIKE(email,'@')),
   CONSTRAINT ck5 CHECK (scholarship BETWEEN 5000 AND 20000),
   CONSTRAINT ck6 CHECK (country IN ('usa','uk'))
);
INSERT INTO student VALUES(1,"j001","name1","name1@oracle.com",6000,'usa');
SELECT * FROM student;
DROP TABLE student;
CREATE TABLE t1(c1 INT, c2 VARCHAR(20));
ALTER TABLE t1 ADD CONSTRAINT ck1 CHECK ( c1 > c2 );
DROP TABLE t1;
CREATE TABLE t1(c1 INT , CHECK ( c1 <=> NULL ));
INSERT INTO t1 VALUES(NULL);
SELECT * FROM t1;
ALTER TABLE t1 ADD COLUMN c2 INT, ADD CONSTRAINT CHECK( c2 > 10 );
INSERT INTO t1(c2) VALUES(11);
ALTER TABLE t1 ADD COLUMN c3 INT, ADD CONSTRAINT CHECK( c3 >= 10 );
INSERT INTO t1(c3) VALUES(10);
ALTER TABLE t1 ADD COLUMN c4 INT, ADD CONSTRAINT CHECK( c4 < 10 );
INSERT INTO t1(c4) VALUES(9);
ALTER TABLE t1 ADD COLUMN c5 INT, ADD CONSTRAINT CHECK( c5 <= 10 );
INSERT INTO t1(c5) VALUES(10);
ALTER TABLE t1 ADD COLUMN c6 INT, ADD CONSTRAINT CHECK( c6 != 10 );
INSERT INTO t1(c6) VALUES(20);
ALTER TABLE t1 ADD COLUMN c7 INT, ADD CONSTRAINT CHECK( c7 <> 10 );
INSERT INTO t1(c7) VALUES(20);
ALTER TABLE t1 ADD COLUMN c8 INT, ADD CONSTRAINT CHECK( c8 = GREATEST(1,2,3) );
INSERT INTO t1(c8) VALUES(3);
ALTER TABLE t1 ADD COLUMN c9 INT, ADD CONSTRAINT CHECK( c9 = LEAST(1,2,3) );
INSERT INTO t1(c9) VALUES(1);
ALTER TABLE t1 ADD COLUMN c10 INT, ADD CONSTRAINT CHECK( c10 NOT IN (1,2,3) );
INSERT INTO t1(c10) VALUES(10);
ALTER TABLE t1 ADD COLUMN c11 YEAR, ADD CONSTRAINT CHECK ( c11 > '2007-01-01' + INTERVAL +1 YEAR);
INSERT INTO t1(c11) VALUES(2009);
ALTER TABLE t1 ADD COLUMN c12 INT, ADD CONSTRAINT CHECK ( c12 NOT BETWEEN 10 AND 20);
INSERT INTO t1(c12) VALUES(25);
ALTER TABLE t1 ADD COLUMN c13 INT, ADD CONSTRAINT CHECK ( c13 NOT IN (1, 2, 3));
INSERT INTO t1(c13) VALUES(15);
ALTER TABLE t1 ADD COLUMN c14 CHAR(10), ADD CONSTRAINT CHECK ( c14 LIKE 'A%');
INSERT INTO t1(c14) VALUES('All');
ALTER TABLE t1 ADD COLUMN c15 INT, ADD CONSTRAINT CHECK ( c15 = STRCMP('A','A'));
INSERT INTO t1(c15) VALUES(0);
DROP TABLE t1;
CREATE TABLE t1(c1 INT, c2 INT);
ALTER TABLE t1 ADD CONSTRAINT CHECK( (c1 > 10) AND (c2 < 20) );
ALTER TABLE t1 ADD CONSTRAINT CHECK( (c1 > 10) && (c2 < 20) );
ALTER TABLE t1 DROP CHECK `t1_chk_1`;
ALTER TABLE t1 DROP CHECK `t1_chk_2`;
ALTER TABLE t1 ADD CONSTRAINT CHECK( (c1 > 10) || (c2 < 20) );
ALTER TABLE t1 ADD CONSTRAINT CHECK( (c1 > 10) OR (c2 < 20) );
INSERT INTO t1 VALUES(15,25);
INSERT INTO t1 VALUES(5,10);
ALTER TABLE t1 DROP CHECK `t1_chk_1`;
ALTER TABLE t1 DROP CHECK `t1_chk_2`;
DELETE FROM t1;
ALTER TABLE t1 ADD CONSTRAINT CHECK( (c1 > 10) XOR (c2 < 20) );
DROP TABLE t1;
CREATE TABLE t1(c1 INT DEFAULT 2 PRIMARY KEY CHECK(c1 > 1 OR c1 IS NOT NULL));
INSERT INTO t1 VALUES(1);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(c1 INT DEFAULT 2 PRIMARY KEY CHECK(c1 > 1 OR c1 > 2));
INSERT INTO t1 VALUES(2);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(c1 INT DEFAULT 2 PRIMARY KEY CHECK(c1 > 1 AND c1 IS NOT NULL));
DROP TABLE t1;
CREATE DATABASE test1;
CREATE DATABASE test2;
CREATE TABLE t1(c1 INT, c2 INT CHECK (c2 < 10));
INSERT INTO t1 VALUES(1,1);
SELECT * FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS;
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME='t1';
SELECT * FROM t1;
SELECT * FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS;
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME='t1';
DROP DATABASE test2;
DROP DATABASE test1;
CREATE DATABASE test1;
CREATE DATABASE test2;
INSERT INTO t1 VALUES(1,1);
SELECT * FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS;
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME='t1';
SELECT * FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS;
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME='t2';
DROP DATABASE test2;
DROP DATABASE test1;
CREATE TABLE parent(pid INT NOT NULL PRIMARY KEY CHECK(pid > 1));
CREATE TABLE child(cid INT CHECK(cid > 1),
  CONSTRAINT fk FOREIGN KEY (cid) REFERENCES parent(pid));
INSERT INTO parent VALUES(2);
INSERT INTO child VALUES(2);
SELECT * FROM parent;
SELECT * FROM child;
DROP TABLE child;
DROP TABLE parent;
CREATE TABLE parent (a INT PRIMARY KEY);
CREATE TABLE child (
                    b INT,
                    c INT CHECK (c < 10),
                    INDEX(b),
                    FOREIGN KEY (b) REFERENCES parent(a) ON DELETE SET NULL
                   );
ALTER TABLE child DROP FOREIGN KEY child_ibfk_1;
DROP TABLE child;
CREATE TABLE child (
                    b INT,
                    c INT CHECK (c < 10),
                    INDEX(b),
                    FOREIGN KEY (b) REFERENCES parent(a) ON UPDATE SET NULL
                   );
ALTER TABLE child DROP FOREIGN KEY child_ibfk_1;
DROP TABLE child;
CREATE TABLE child (
                    b INT,
                    c INT CHECK (c < 10),
                    INDEX(b),
                    FOREIGN KEY (b) REFERENCES parent(a) ON UPDATE CASCADE
                   );
ALTER TABLE child DROP FOREIGN KEY child_ibfk_1;
DROP TABLE child;
DROP TABLE parent;
CREATE TABLE t2(c1 INT, c2 INT);
INSERT INTO t2 VALUES(1,20);
SELECT * FROM t1;
SELECT * FROM t2;
INSERT INTO t2 VALUES(1,30);
SELECT * FROM t1;
SELECT * FROM t2;
INSERT INTO t2 VALUES(1,5);
INSERT INTO t1 VALUES(1,5);
UPDATE t2 SET c2=20 WHERE c1=1;
SELECT * FROM t1;
SELECT * FROM t2;
UPDATE t2 SET c2=20 WHERE c1=1;
SELECT * FROM t1;
SELECT * FROM t2;
DROP TABLE t1,t2;
CREATE TABLE t1(c1 int CONSTRAINT ck1 CHECK(c1 < 5));
INSERT INTO t1 VALUES(4);
DROP TABLE t1;
CREATE DATABASE test1;
CREATE TABLE t1 (
  c1 BIT(7) CHECK(c1 < B'1111100') NOT ENFORCED,
  c2 BOOLEAN CHECK(c2 > 0) NOT ENFORCED,
  c3 TINYINT CHECK(c3 > 10) NOT ENFORCED,
  c4 SMALLINT CHECK(c4 > 10) NOT ENFORCED,
  c5 MEDIUMINT CHECK(c5 > 10) NOT ENFORCED,
  c6 INT CHECK(c6 > 10),
  c7 BIGINT CHECK(c7 > 10),
  c8 DECIMAL(6,2) CHECK(c8 > 10.1),
  c9 FLOAT(6,2) CHECK(c9 > 10.1),
  c10 DOUBLE(6,2) CHECK(c10 > 10.1),
  c11 CHAR(6) CHECK (c11 IS NULL));
DROP DATABASE test1;
INSERT INTO t1(c1,c2,c3,c4,c5,c6,c7,c8,c9,c10)
    VALUES(B'1111111',0,5,5,5,11,11,10.2,10.2,10.2);
SELECT HEX(c1), c2, c3, c4, c5, c6, c7, c8, c9, c10, c11 FROM t1;
DROP TABLE t1;
CREATE DATABASE test2;
CREATE TABLE t2 (
  c1 BIT(7) CHECK(c1 < B'1111100'),
  c2 BOOLEAN CHECK(c2 > 0),
  c3 TINYINT CHECK(c3 > 10),
  c4 SMALLINT CHECK(c4 > 10),
  c5 MEDIUMINT CHECK(c5 > 10),
  c6 INT CHECK(c6 > 10) NOT ENFORCED,
  c7 BIGINT CHECK(c7 > 10) NOT ENFORCED,
  c8 DECIMAL(6,2) CHECK(c8 > 10.1) NOT ENFORCED,
  c9 FLOAT(6,2) CHECK(c9 > 10.1) NOT ENFORCED,
  c10 DOUBLE(6,2) CHECK(c10 > 10.1) NOT ENFORCED);
DROP DATABASE test2;
INSERT INTO t2(c1,c2,c3,c4,c5,c6,c7,c8,c9,c10)
    VALUES(B'1111000',1,11,11,11,5,5,9.1,9.1,9.1);
SELECT HEX(c1), c2, c3, c4, c5, c6, c7, c8, c9, c10 FROM t2;
DROP TABLE t2;
CREATE TABLE t1(c1 INT CHECK(c1 > 10));
PREPARE stmt1 FROM 'INSERT INTO t1 VALUES(1)';
DEALLOCATE PREPARE stmt1;
PREPARE stmt2 FROM 'INSERT INTO t1 VALUES(20)';
DEALLOCATE PREPARE stmt2;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(c1 INT);
CREATE TABLE t2(c1 INT CHECK(c1 > 10));
INSERT INTO t1 VALUES(1);
SELECT * FROM t1;
SELECT * FROM t2;
DROP TABLE t1,t2;
CREATE TABLE t1(
  d DATE NOT NULL CHECK(YEAR(d) > '1950')
)
PARTITION BY RANGE( YEAR(d) ) (
PARTITION p0 VALUES LESS THAN (1960),
PARTITION p1 VALUES LESS THAN (1970),
PARTITION p2 VALUES LESS THAN (1980),
PARTITION p3 VALUES LESS THAN (1990)
);
INSERT INTO t1 VALUES('1960-01-01');
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(
  id INT NOT NULL CHECK(id BETWEEN 10 AND 50),
  name VARCHAR(10)
)
PARTITION BY LIST(id) (
PARTITION p0 VALUES IN (10,19),
PARTITION p1 VALUES IN (20,29),
PARTITION p2 VALUES IN (30,39),
PARTITION p3 VALUES IN (40,49)
);
INSERT INTO t1 VALUES(30,'aaa');
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(id INT NOT NULL CHECK(id > 10),
                 name VARCHAR(40)
)
PARTITION BY HASH(id)
PARTITIONS 4;
INSERT INTO t1 VALUES(60,'aaa');
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(id INT PRIMARY KEY NOT NULL CHECK(id > 10),
                 name VARCHAR(40)
)
PARTITION BY KEY()
PARTITIONS 4;
INSERT INTO t1 VALUES(60,'aaa');
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(c1 INT, c2 INT CHECK (c2 < 10));
CREATE VIEW v1 AS SELECT * FROM t1;
INSERT INTO v1 VALUES(1,5);
SELECT * FROM t1;
SELECT * FROM v1;
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 (f1 CHAR(10) CHECK (f1 < 10));
DROP TABLE t1;
CREATE TABLE t1(a INTEGER CHECK (a > 0) NOT NULL);
CREATE TABLE t2(a INTEGER CHECK (a > 0) UNIQUE);
CREATE TABLE t3(a INTEGER CHECK (a > 0) PRIMARY KEY);
CREATE TABLE t4(a INTEGER CHECK (a > 0) ENFORCED NOT NULL);
CREATE TABLE t5(a INTEGER CHECK (a > 0) NOT ENFORCED NOT NULL);
CREATE TABLE t6(a INTEGER CHECK (a > 0) UNIQUE CHECK (a IS NOT NULL) NULL CHECK (a < 100));
CREATE TABLE t7(a INTEGER CHECK (a > 0) ENFORCED NOT NULL);
DROP TABLE t1,t2,t3,t4,t5,t6,t7;
CREATE TABLE tst (
  id INT,
  start_date DATE,
  end_date DATE,
  PRIMARY KEY (id),
  CONSTRAINT chk_dat CHECK (end_date > start_date)
);
INSERT INTO tst (id, start_date, end_date) VALUES (1, '2019-04-25', '2019-04-30');
UPDATE tst SET id = 5 WHERE start_date = '2019-04-25';
UPDATE tst SET id = 6, start_date = '2019-05-02', end_date = '2049-04-23' WHERE id = 5;
DROP TABLE tst;
CREATE TABLE t1 (f1 INT CONSTRAINT ck1 CHECK (f1 > 0), f2 INT);
ALTER TABLE t1 ADD CONSTRAINT ck1 CHECK (f2 > 0), DROP CHECK ck1;
ALTER TABLE t1 DROP COLUMN f2, ADD CONSTRAINT ck1 CHECK (f1 > 0);
ALTER TABLE t1 DROP COLUMN f1, ADD COLUMN f1 BIGINT, ADD CONSTRAINT CHECK (f1!= 0);
DROP TABLE t1;
CREATE TABLE tst (
  id INT,
  start_date DATE,
  end_date DATE,
  created DATE DEFAULT (CURDATE()),
  PRIMARY KEY (id),
  CONSTRAINT chk_dat CHECK (start_date >= created)
);
INSERT INTO tst (id, start_date) VALUES (1, CURDATE());
DROP TABLE tst;
CREATE TABLE tst (id INT PRIMARY KEY,
                  scol DATE DEFAULT(CURDATE()),
                  col DATE,
                  CHECK ( scol < col));
CREATE TABLE tmp(id INT, col DATE);
INSERT INTO tmp VALUES(3, '2019-05-06');
DROP TABLE tmp;
DELETE FROM tst;
ALTER TABLE tst MODIFY COLUMN scol TIME DEFAULT(CURTIME()), MODIFY COLUMN col TIME;
CREATE TABLE tmp(id INT, col TIME);
INSERT INTO tmp VALUES(3, '15:15:15');
DROP TABLE tmp;
DELETE FROM tst;
ALTER TABLE tst MODIFY COLUMN scol timestamp DEFAULT(CURRENT_TIMESTAMP()),
                MODIFY COLUMN col  timestamp;
CREATE TABLE tmp(id INT, col TIMESTAMP);
INSERT INTO tmp VALUES(3, '2019-05-06 12:12:12');
ALTER TABLE tst MODIFY COLUMN scol timestamp ON UPDATE CURRENT_TIMESTAMP;
INSERT INTO tst(id, col) VALUES (1, '2019-05-20 12:12:12') ON DUPLICATE KEY UPDATE id=3;
CREATE TABLE tst1 (id INT, col timestamp DEFAULT('2019-05-21 12:12:12'));
INSERT INTO tst1(id) VALUES(1);
DROP TABLE tmp;
DELETE FROM tst;
DELETE FROM tst1;
ALTER TABLE tst MODIFY COLUMN scol datetime DEFAULT(CURRENT_TIMESTAMP()),
                MODIFY COLUMN col  datetime;
CREATE TABLE tmp(id INT, col TIMESTAMP);
INSERT INTO tmp VALUES(3, '2019-05-06 12:12:12');
ALTER TABLE tst MODIFY COLUMN scol datetime ON UPDATE CURRENT_TIMESTAMP;
INSERT INTO tst(id, col) VALUES (1, '2019-05-20 12:12:12') ON DUPLICATE KEY UPDATE id=3;
ALTER TABLE tst1 MODIFY COLUMN col datetime DEFAULT('2019-05-21 12:12:12');
INSERT INTO tst1(id) VALUES(1);
DROP TABLE tmp, tst, tst1;
CREATE TABLE tst (id INT PRIMARY KEY,
                  scol INT DEFAULT(col * col),
                  col INT,
                  CHECK ( scol < col));
INSERT INTO tst VALUES (1, 10, 20);
SELECT * FROM tst;
CREATE TABLE tmp(id INT, col INT);
INSERT INTO tmp VALUES(3, 10);
DROP TABLE tst, tmp;
CREATE TABLE t1 (f1 INT PRIMARY KEY,
                 f2 TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                 CHECK (f2 < '2018-01-01 00:00:00'));
INSERT INTO t1 VALUES (4, '2017-06-06 00:00:00'),
                      (5, '2017-06-06 00:00:00'),
                      (6, '2017-06-06 00:00:00');
CREATE VIEW v1 AS SELECT f1, f2 FROM t1 WHERE f2 < '2019-01-01 00:00:00' WITH CHECK OPTION;
DELETE FROM v1 WHERE f1 = 7;
UPDATE v1 SET f1 = 4, f2 = '2017-06-06 00:00:00' WHERE f1 = 7;
CREATE TABLE t2 (f1 INT);
INSERT INTO t2 VALUES (1);
DELETE FROM t1 WHERE f1 = 1;
DELETE FROM t1 WHERE f1 = 1;
DELETE FROM t2;
INSERT INTO t2 VALUES (2);
DELETE FROM t2;
INSERT INTO t2 VALUES (3);
DROP TABLE t1, t2;
DROP VIEW v1;
CREATE TABLE t1 (f1 INT CHECK (f1 < 10), f2 CHAR(100));
CREATE TABLE t2(f1 INT, f2 INT);
INSERT INTO t2 VALUES (1, 10), (20, 20), (3, 30), (4, 40);
SELECT * FROM t1;
DELETE FROM t1;
SELECT * FROM t1;
DELETE FROM t1;
SELECT * FROM t1;
DELETE FROM t1;
CREATE VIEW v1 AS SELECT f1, f2 FROM t1 WHERE f1 < 10 WITH CHECK OPTION;
SELECT * FROM v1;
DROP VIEW v1;
DROP TABLE t1, t2;
CREATE TABLE t1 (id INT PRIMARY KEY AUTO_INCREMENT, b INT, CONSTRAINT c CHECK (b IS NULL)) IGNORE AS SELECT 1 AS id, 1 AS b;
DROP TABLE t1;
CREATE TABLE t1 (f1 INT, f2 INT, f3 INT, f4 FLOAT AS (f3 * 0.01), f5 INT,
                 CHECK (f1 < f2));
ALTER TABLE t1 RENAME COLUMN f1 TO f1;
ALTER TABLE t1 CHANGE f1 f1 FLOAT;
ALTER TABLE t1 RENAME COLUMN f2 TO f2, ADD CONSTRAINT CHECK(f2 < 1105);
ALTER TABLE t1 CHANGE f2 f2 FLOAT, ADD CONSTRAINT CHECK(f2 < 1105);
ALTER TABLE t1 RENAME COLUMN f5 to f6, ADD CONSTRAINT CHECK (f6 < 10);
ALTER TABLE t1 DROP CONSTRAINT t1_chk_1, RENAME COLUMN f1 to f11,
               ADD CONSTRAINT t1_chk_1 CHECK (f11 < 10);
DROP TABLE t1;
CREATE TABLE t1 (f1 INT, f2 INT);
INSERT INTO t1 VALUES (1, 1);
ALTER TABLE t1 CHANGE f1 f3 INT CHECK (f3 > 0), ALGORITHM = COPY;
ALTER TABLE t1 MODIFY f2 INT CHECK (f2 > 0), ALGORITHM = COPY;
DROP TABLE t1;