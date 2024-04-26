CREATE TABLE t1 (i int, b JSON DEFAULT (JSON_OBJECT("key", i)));
INSERT INTO t1(i) VALUES (1);
INSERT INTO t1 SET i = 10;
INSERT INTO t1(i, b) VALUES (2, DEFAULT);
INSERT INTO t1 SET i = 20, b = DEFAULT;
INSERT INTO t1(i, b) VALUES (3, JSON_OBJECT("key", 3));
INSERT INTO t1 SET i = 30, b = JSON_OBJECT("key", 30);
SELECT * FROM t1;
ALTER TABLE t1 DROP COLUMN b;
DROP TABLE t1;
CREATE TABLE t1 (i int, b char(255) DEFAULT (sha2(i, 0)), INDEX (b(10)));
INSERT INTO t1(i) VALUES (1);
INSERT INTO t1(i, b) VALUES (2, DEFAULT);
INSERT INTO t1(i, b) VALUES (3, "some string");
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (i int);
INSERT INTO t1(i) VALUES (1),(2);
ALTER TABLE t1 ADD COLUMN b JSON DEFAULT (JSON_OBJECT("key",i));
INSERT INTO t1(i) VALUES (3);
INSERT INTO t1(i, b) VALUES (4, DEFAULT);
INSERT INTO t1(i, b) VALUES (5, JSON_OBJECT("key", 5));
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (i int);
INSERT INTO t1(i) VALUES (1),(2);
ALTER TABLE t1 ADD COLUMN b JSON;
ALTER TABLE t1 ALTER COLUMN b SET DEFAULT (JSON_OBJECT("key",i));
INSERT INTO t1(i) VALUES (3);
INSERT INTO t1(i, b) VALUES (4, DEFAULT);
INSERT INTO t1(i, b) VALUES (5, JSON_OBJECT("key", 5));
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (i int);
INSERT INTO t1(i) VALUES (1),(2);
ALTER TABLE t1 ADD COLUMN b JSON DEFAULT (JSON_ARRAY());
INSERT INTO t1(i) VALUES (4);
ALTER TABLE t1 CHANGE COLUMN b new_b JSON DEFAULT (JSON_OBJECT("key",i));
INSERT INTO t1(i) VALUES (5);
INSERT INTO t1(i, new_b) VALUES (6, DEFAULT);
INSERT INTO t1(i, new_b) VALUES (7, JSON_OBJECT("key", 7));
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (i int, b int DEFAULT (123 * 1));
ALTER TABLE t1 CHANGE COLUMN i new_i JSON DEFAULT (JSON_ARRAY(b));
DROP TABLE t1;
CREATE TABLE t1 (i int);
INSERT INTO t1(i) VALUES (1),(2);
ALTER TABLE t1 ADD COLUMN b JSON DEFAULT (JSON_ARRAY());
INSERT INTO t1(i) VALUES (4);
ALTER TABLE t1 MODIFY COLUMN b JSON DEFAULT (JSON_OBJECT("key",i)) FIRST;
INSERT INTO t1(i) VALUES (5);
INSERT INTO t1(i, b) VALUES (6, DEFAULT);
INSERT INTO t1(i, b) VALUES (7, JSON_OBJECT("key", 7));
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (i int, b int DEFAULT (123 * 1));
ALTER TABLE t1 MODIFY COLUMN i JSON DEFAULT (JSON_ARRAY(b)) FIRST;
DROP TABLE t1;
CREATE TABLE t1 (i JSON DEFAULT (JSON_ARRAY(b)), b int DEFAULT 123);
DROP TABLE t1;
CREATE TABLE t1 (b int DEFAULT 123, i JSON DEFAULT (JSON_ARRAY(b)));
DROP TABLE t1;
CREATE TABLE t1 (i JSON DEFAULT (JSON_ARRAY(b)), b int DEFAULT (123 * 1));
CREATE TABLE t1 (b int DEFAULT (123 * 1), i JSON DEFAULT (JSON_ARRAY(b)));
DROP TABLE t1;
CREATE TABLE t1 (i int, b JSON);
INSERT INTO t1(i) VALUES (1),(2);
ALTER TABLE t1 ALTER COLUMN b SET DEFAULT (JSON_OBJECT("key",i));
INSERT INTO t1(i) VALUES (3);
INSERT INTO t1(i, b) VALUES (4, DEFAULT);
INSERT INTO t1(i, b) VALUES (5, JSON_OBJECT("key", 5));
ALTER TABLE t1 ALTER COLUMN b DROP DEFAULT;
INSERT INTO t1(i, b) VALUES (6, NULL);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (id int(11) PRIMARY KEY auto_increment,
                 f1 JSON DEFAULT (JSON_OBJECT("key", id)));
CREATE TABLE t1 (a varchar(64), b varchar(1024) DEFAULT (load_file(a)));
CREATE TABLE t1 (f1 JSON DEFAULT (JSON_OBJECT("key", id)), id int(11));
INSERT INTO t1(id) VALUES(1), (2), (3);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (id char(2) DEFAULT (uuid()));
INSERT INTO t1 VALUES (),(),();
DROP TABLE t1;
CREATE TABLE t3 (a INT PRIMARY KEY,
                 b INT GENERATED ALWAYS AS (-a) VIRTUAL UNIQUE DEFAULT (-1 * 128));
CREATE TABLE t3 (a INT PRIMARY KEY,
                 c INT GENERATED ALWAYS AS (-a) STORED DEFAULT (-1 * 128));
CREATE TABLE t1 (id char(36) DEFAULT (uuid()));
INSERT INTO t1 VALUES (),(),();
CREATE TABLE t2 as SELECT * from t1;
CREATE TABLE t3 LIKE t1;
SELECT LENGTH(id) FROM t1;
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;
CREATE TABLE t3 (a INT PRIMARY KEY,
d INT DEFAULT (-a + 1),
c INT DEFAULT (DEFAULT(d))
);
CREATE TABLE t3 (a INT PRIMARY KEY,
d INT DEFAULT (-a + 1),
c INT DEFAULT (-d)
);
SELECT DEFAULT(d) from t3;
SELECT DEFAULT(c) from t3;
ALTER TABLE t3 DROP COLUMN d;
DROP TABLE t3;
CREATE TABLE `t1` (i varchar(200) DEFAULT (_utf8mb4"\U+1F9DB♀"));
SELECT COLUMN_NAME, COLUMN_DEFAULT, DATA_TYPE, EXTRA, GENERATION_EXPRESSION
FROM information_schema.columns WHERE table_name= "t1";
INSERT INTO t1 values (),();
SELECT * from t1;
DROP TABLE t1;

CREATE TABLE test (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  data VARCHAR(64) DEFAULT NULL,
  something VARCHAR(64) NOT NULL DEFAULT (CONCAT ('[', data, ']')),
  PRIMARY KEY (id)
);
SELECT * FROM test;
SELECT * FROM test;
DROP TABLE test;

CREATE TABLE t(i INT, b TINYBLOB  DEFAULT (repeat('b', i)));
INSERT INTO t values(254, DEFAULT);
INSERT INTO t values(255, DEFAULT);
INSERT INTO t values(256, DEFAULT);
SELECT i, length(b) FROM t;
DROP TABLE t;

CREATE TABLE t(i INT);
INSERT INTO t values(254), (255), (256);
ALTER TABLE t ADD COLUMN b TINYBLOB DEFAULT (repeat('b', i));
SELECT * FROM t;
DELETE FROM t where i = 256;
ALTER TABLE t ADD COLUMN b TINYBLOB;
SELECT i, length(b) FROM t;
ALTER TABLE t ALTER COLUMN b SET DEFAULT (repeat('b', i));
SELECT i, length(b) FROM t;
INSERT INTO t values(254, DEFAULT);
INSERT INTO t values(255, DEFAULT);
INSERT INTO t values(256, DEFAULT);
ALTER TABLE t ALTER COLUMN b DROP DEFAULT;
INSERT INTO t(i) values(128);
SELECT i, length(b) FROM t;
DROP TABLE t;

SET GLOBAL max_allowed_packet = 1073741824;

CREATE TABLE t(i BIGINT, b MEDIUMBLOB  DEFAULT (repeat('b', i)));
INSERT INTO t values(16777214, DEFAULT);
INSERT INTO t values(16777215, DEFAULT);
INSERT INTO t values(16777216, DEFAULT);
SELECT i, length(b) FROM t;
DROP TABLE t;

CREATE TABLE t(i BIGINT);
INSERT INTO t values(16777214), (16777215), (16777216);
ALTER TABLE t ADD COLUMN b MEDIUMBLOB DEFAULT (repeat('b', i));
SELECT * FROM t;
DELETE FROM t where i = 16777216;
ALTER TABLE t ADD COLUMN b MEDIUMBLOB;
SELECT i, length(b) FROM t;
ALTER TABLE t ALTER COLUMN b SET DEFAULT (repeat('b', i));
SELECT i, length(b) FROM t;
INSERT INTO t values(16777214, DEFAULT);
INSERT INTO t values(16777215, DEFAULT);
INSERT INTO t values(16777216, DEFAULT);
ALTER TABLE t ALTER COLUMN b DROP DEFAULT;
INSERT INTO t(i) values(128);
SELECT i, length(b) FROM t;
DROP TABLE t;

SET GLOBAL max_allowed_packet=default;

CREATE TABLE t(i INT, b BLOB DEFAULT (repeat('b', i)));
INSERT INTO t values(65534, DEFAULT);
INSERT INTO t values(65535, DEFAULT);
INSERT INTO t values(65536, DEFAULT);
SELECT i, length(b) FROM t;
DROP TABLE t;

CREATE TABLE t(i INT);
INSERT INTO t values(65534), (65535), (65536);
ALTER TABLE t ADD COLUMN b BLOB DEFAULT (repeat('b', i));
SELECT * FROM t;
DELETE FROM t where i = 65536;
ALTER TABLE t ADD COLUMN b BLOB;
SELECT i, length(b) FROM t;
ALTER TABLE t ALTER COLUMN b SET DEFAULT (repeat('b', i));
SELECT i, length(b) FROM t;
INSERT INTO t values(65534, DEFAULT);
INSERT INTO t values(65535, DEFAULT);
INSERT INTO t values(65536, DEFAULT);
ALTER TABLE t ALTER COLUMN b DROP DEFAULT;
INSERT INTO t(i) values(128);
SELECT i, length(b) FROM t;
DROP TABLE t;

CREATE TABLE t(i BIGINT, b LONGBLOB  DEFAULT (repeat('b', i)));
INSERT INTO t values(4294967295, DEFAULT);
DROP TABLE t;

CREATE TABLE t(i INT, b BLOB DEFAULT (repeat('b', i)));
INSERT INTO t values(65534, DEFAULT);
INSERT INTO t values(65535, DEFAULT);
INSERT INTO t values(65536, DEFAULT);
SELECT i, length(b) FROM t;
DROP TABLE t;

CREATE TABLE t(i INT);
INSERT INTO t values(65534), (65535), (65536);
ALTER TABLE t ADD COLUMN b BLOB DEFAULT (repeat('b', i));
SELECT * FROM t;
DELETE FROM t where i = 65536;
ALTER TABLE t ADD COLUMN b BLOB;
SELECT i, length(b) FROM t;
ALTER TABLE t ALTER COLUMN b SET DEFAULT (repeat('b', i));
SELECT i, length(b) FROM t;
INSERT INTO t values(65534, DEFAULT);
INSERT INTO t values(65535, DEFAULT);
INSERT INTO t values(65536, DEFAULT);
ALTER TABLE t ALTER COLUMN b DROP DEFAULT;
INSERT INTO t(i) values(128);
SELECT i, length(b) FROM t;
DROP TABLE t;
CREATE TABLE t(i INT, b VARCHAR(20) DEFAULT (repeat('b', i)));
INSERT INTO t values(14, DEFAULT);
INSERT INTO t values(16, DEFAULT);
SELECT * FROM t;
DROP TABLE t;

CREATE TABLE t1(a INT PRIMARY KEY, b GEOMETRY NOT NULL DEFAULT
                (ST_GEOMFROMTEXT('LINESTRING(0 0,9.299720368548e18 0,0 0,0 0)')));
INSERT INTO t1 VALUES(1, DEFAULT);
INSERT INTO t1 VALUES(2, DEFAULT);
INSERT INTO t1 VALUES(3, (ST_GEOMFROMTEXT('LINESTRING(0 0,9.2234818 0,0 0,0 0)')));
SELECT a, ST_AsText(b) FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a INT, b TIMESTAMP DEFAULT (TIMESTAMPADD(MINUTE, 1,'2003-01-02'))
                 ON UPDATE NOW());
INSERT INTO t1(a) VALUES (5);
SELECT * FROM t1;
SET timestamp= 1038401397;
UPDATE t1 SET a = 10 WHERE a = 5;
SELECT * FROM t1;
DROP TABLE t1;


CREATE TABLE t1 (a INT, b TIMESTAMP NOT NULL DEFAULT (TIMESTAMPADD(MINUTE, 1,'2003-01-02')));
insert into t1(a) values (1);
DROP TABLE t1;

CREATE TABLE t1 (a INT, c TIMESTAMP DEFAULT (TIMESTAMPADD(MINUTE, 5,'2003-01-02')));
INSERT INTO t1(a) VALUES (5),(6);
ALTER TABLE t1 ADD COLUMN d TIMESTAMP DEFAULT (TIMESTAMPADD(MINUTE, 10,'2003-01-03')) ON UPDATE CURRENT_TIMESTAMP;
SELECT * from t1;
UPDATE t1 SET a = 10 WHERE a = 5;
SELECT * from t1;
ALTER TABLE t1 DROP COLUMN d;
ALTER TABLE t1 ADD COLUMN d TIMESTAMP DEFAULT (TIMESTAMPADD(MINUTE, 15,'2003-01-04'));
SELECT * from t1;
DROP TABLE t1;
CREATE TABLE t1 (i INT, b char(255) DEFAULT (sha2(i, 0)));
INSERT INTO t1(i) VALUES (1);
INSERT INTO t1(i, b) VALUES (2, DEFAULT);
INSERT INTO t1(i, b) VALUES (3, "some string");
INSERT INTO t1(i, b) VALUES (NULL, DEFAULT);
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (i INT, b char(255) DEFAULT (sha2(i, 0)), j INT GENERATED ALWAYS AS (i*2));
INSERT INTO t1(i) VALUES (1);
INSERT INTO t1(i, b) VALUES (2, DEFAULT);
INSERT INTO t1(i, b) VALUES (3, "some string");
INSERT INTO t1(i, b) VALUES (NULL, DEFAULT);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t(a int);
ALTER TABLE t ADD COLUMN b int DEFAULT(
date_sub(a, INTERVAL A MONTH));
ALTER TABLE t ADD COLUMN c int DEFAULT (SUM(a));
DROP TABLE t;

CREATE TABLE t1 (b double DEFAULT (rand()));
INSERT INTO t1 VALUES ();
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a varchar(30), b VARCHAR(100) DEFAULT (statement_digest(a)));
INSERT INTO t1 (a) VALUES ("SELECT 1;
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a varchar(30), b varchar(100) DEFAULT (statement_digest_text(a)));
INSERT INTO t1 (a) VALUES ("SELECT 2;
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a datetime DEFAULT (curdate()));
INSERT INTO t1 VALUES ();
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a datetime DEFAULT (current_date()));
INSERT INTO t1 VALUES ();
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a datetime DEFAULT (current_date));
INSERT INTO t1 VALUES ();
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a datetime DEFAULT (current_time()));
INSERT INTO t1 VALUES ();
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a datetime DEFAULT (current_time));
INSERT INTO t1 VALUES ();
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a datetime DEFAULT (current_timestamp()));
INSERT INTO t1 VALUES ();
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a datetime DEFAULT (current_timestamp));
INSERT INTO t1 VALUES ();
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a datetime DEFAULT (localtime()));
INSERT INTO t1 VALUES ();
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a datetime DEFAULT (localtime));
INSERT INTO t1 VALUES ();
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a datetime DEFAULT (curtime()));
INSERT INTO t1 VALUES ();
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a datetime, b varchar(20) DEFAULT (localtimestamp()));
INSERT INTO t1(a) VALUES (now());
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a datetime, b varchar(20) DEFAULT (localtimestamp));
INSERT INTO t1(a) VALUES (now());
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a datetime, b varchar(20) DEFAULT (now()));
INSERT INTO t1(a) VALUES (now());
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (b varchar(100) DEFAULT (sysdate()));
INSERT INTO t1() VALUES ();
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a datetime, b INT DEFAULT (unix_timestamp()));
INSERT INTO t1() VALUES ();
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a datetime, b datetime DEFAULT (utc_date()));
INSERT INTO t1(a) VALUES (now());
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a datetime, b datetime DEFAULT (utc_time()));
INSERT INTO t1(a) VALUES (now());
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a datetime, b datetime DEFAULT (utc_timestamp()));
INSERT INTO t1(a) VALUES (now());
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a int DEFAULT (connection_id()));
INSERT INTO t1 VALUES ();
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a varchar(1024), b varchar(1024) DEFAULT (database()));
INSERT INTO t1 VALUES ();
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a varchar(288) DEFAULT (CURRENT_USER()));
INSERT INTO t1 VALUES ();
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a varchar(288) DEFAULT (SESSION_USER()));
INSERT INTO t1 VALUES ();
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a varchar(288) DEFAULT (USER()));
INSERT INTO t1 VALUES ();
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a varchar(64), b varchar(1024) DEFAULT (load_file(a)));
CREATE TABLE t1 (a varchar(1024), b varchar(1024) DEFAULT (found_rows()));
CREATE TABLE t1 (a varchar(1024), b varchar(1024) DEFAULT (get_lock(a,10)));
CREATE TABLE t1 (a varchar(1024), b varchar(1024) DEFAULT (is_free_lock(a)));
CREATE TABLE t1 (a varchar(1024), b varchar(1024) DEFAULT (is_used_lock(a)));
CREATE TABLE t1 (a int DEFAULT (last_insert_id()));
CREATE TABLE t1 (a int DEFAULT (row_count()));
CREATE TABLE t1 (a int, b int DEFAULT (sleep(a)));
CREATE TABLE t1 (a varchar(1024), b varchar(1024) DEFAULT (version()));

-- error ER_INVALID_DEFAULT
CREATE TABLE t1 (id char(40) DEFAULT (uuid()) DEFAULT 4);
CREATE TABLE t1 (id char(40) DEFAULT 4 DEFAULT (uuid()));
CREATE TABLE t1 (id char(40) DEFAULT 4 DEFAULT (uuid()) DEFAULT 10);
CREATE TABLE t1 (id char(40) DEFAULT 4 DEFAULT 5);
DROP TABLE t1;
CREATE FUNCTION CURRENT_TIMESTAMPfoo() RETURNS INT BEGIN RETURN 1;
CREATE TABLE t1 (a INT DEFAULT (CURRENT_TIMESTAMPfoo()));
DROP FUNCTION CURRENT_TIMESTAMPfoo;

-- error ER_DEFAULT_VAL_GENERATED_FUNCTION_IS_NOT_ALLOWED
CREATE TABLE t1 (a VARCHAR(32) DEFAULT (NAME_CONST('test',1)));

-- error ER_DEFAULT_VAL_GENERATED_ROW_VALUE
CREATE TABLE t1 (a VARCHAR(32) DEFAULT ((1,1)));

-- error ER_DEFAULT_VAL_GENERATED_NAMED_FUNCTION_IS_NOT_ALLOWED
CREATE TABLE t1 (a VARCHAR(1024), b VARCHAR(1024) DEFAULT (VALUES(a)));
CREATE PROCEDURE p1()
BEGIN
  SELECT 42;
END //

CREATE FUNCTION f1()
RETURNS INT
BEGIN
 RETURN 42;
END //

DELIMITER ;

-- error ER_DEFAULT_VAL_GENERATED_NAMED_FUNCTION_IS_NOT_ALLOWED
CREATE TABLE t1 (a INT DEFAULT (p1()));
CREATE TABLE t1 (a INT DEFAULT (f1()));

-- error ER_DEFAULT_VAL_GENERATED_NAMED_FUNCTION_IS_NOT_ALLOWED
CREATE TABLE t1 (a INT DEFAULT (1 + f1()));

CREATE TABLE t1 (a INT);
ALTER TABLE t1 ADD COLUMN b INT DEFAULT (1 + f1());
ALTER TABLE t1 ALTER COLUMN a SET DEFAULT (1 + f1());
DROP TABLE t1;

DROP PROCEDURE p1;
DROP FUNCTION f1;


-- echo --
-- echo -- UDFs
-- echo --

--source include/have_udf.inc
--
-- To run this test, "sql/udf_example.cc" need to be compiled into
-- udf_example.so and LD_LIBRARY_PATH should be setup to point out where
-- the library are. The regular CMake build system takes care of this
-- automatically.
--

DROP FUNCTION IF EXISTS metaphon;
CREATE TABLE t1 (a VARCHAR(128) DEFAULT (metaphon("testval")));
CREATE TABLE t1 (a VARCHAR(128) DEFAULT (concat("1", metaphon("testval"))));
CREATE TABLE t1 (a VARCHAR(100));
ALTER TABLE t1 ADD COLUMN b VARCHAR(256) DEFAULT (concat("1", metaphon("testval")));
ALTER TABLE t1 ALTER COLUMN a SET DEFAULT (concat("1", metaphon("testval")));
DROP TABLE t1;

DROP FUNCTION metaphon;

CREATE TABLE t1 (a INT);
CREATE TABLE t2 (a INT, b INT DEFAULT (select count(*) from t1));
CREATE TABLE t2 (a INT, b INT DEFAULT (select * from t1));
CREATE TABLE t2 (a INT, b INT DEFAULT (select 1));
DROP TABLE t1;

SET @my_var= "something";

-- error ER_DEFAULT_VAL_GENERATED_VARIABLES
CREATE TABLE t1 (i INT, b VARCHAR(256) DEFAULT (@my_var));
CREATE TABLE t1 (i INT, b VARCHAR(256) DEFAULT (@my_var + 1));
CREATE TABLE t1 (i INT, b VARCHAR(256) DEFAULT (@@global.sort_buffer_size));
CREATE TABLE t1 (i INT, b VARCHAR(256) DEFAULT (@@session.sort_buffer_size));

CREATE TABLE t1(i INT);

-- error ER_DEFAULT_VAL_GENERATED_VARIABLES
ALTER TABLE t1 ADD COLUMN b VARCHAR(256) DEFAULT (@@session.sort_buffer_size);
ALTER TABLE t1 ADD COLUMN b VARCHAR(256) DEFAULT (@@global.sort_buffer_size);
ALTER TABLE t1 ADD COLUMN b VARCHAR(256) DEFAULT (@my_var);
ALTER TABLE t1 ADD COLUMN b VARCHAR(256) DEFAULT (@my_var + 1);

-- error ER_DEFAULT_VAL_GENERATED_VARIABLES
ALTER TABLE t1 ALTER COLUMN i SET DEFAULT (@@session.sort_buffer_size);
ALTER TABLE t1 ALTER COLUMN i SET DEFAULT (@@global.sort_buffer_size);
ALTER TABLE t1 ALTER COLUMN i SET DEFAULT (@my_var);
ALTER TABLE t1 ALTER COLUMN i SET DEFAULT (@my_var + 1);

DROP TABLE t1;

CREATE TABLE t2 (i INT, j DOUBLE DEFAULT (i)) PARTITION BY KEY(j) PARTITIONS 4;
INSERT INTO t2(i) VALUES (1),(2);
DROP TABLE t2;
CREATE TABLE t2 (i INT, j DOUBLE DEFAULT (SQRT(i)),
                 k DOUBLE DEFAULT (DEFAULT(j)));
create table t1 ( i int, j int default ( i * i ), primary key(j));
insert into t1 (i) values (4), (5);
insert into t1 values (4, DEFAULT), (5, DEFAULT);
insert into t1 values (6, DEFAULT), (7, DEFAULT);
select * from t1;
DROP TABLE t1;
CREATE TABLE IF NOT EXISTS D1 (i2 INT DEFAULT 568447044, d1 DOUBLE,
                               d2 DOUBLE DEFAULT 0.0, c2 CHAR(255),
                               def2 DOUBLE DEFAULT( i2 DIV d2 ),
                               v1 INT AS ( d2 = c2 % ASIN( d1 ) > i2 ) VIRTUAL);
INSERT ignore INTO D1 (  i2, d1, d2, c2, def2)
VALUES ( 1548385958 , d1 ,128158532 , 0.0 , DEFAULT);
ALTER TABLE D1 ADD UNIQUE KEY uidx ( def2 , v1 , d2 );
DROP TABLE D1;

CREATE TABLE IF NOT EXISTS D1 (def2 DOUBLE DEFAULT( 100 DIV 0 ),
                               v1 INT AS (1) VIRTUAL);
INSERT IGNORE INTO D1 (def2) VALUES (1);
ALTER TABLE D1 ADD UNIQUE KEY uidx ( def2 , v1 );
DROP TABLE D1;
CREATE TABLE t1 ( i int, j int DEFAULT (i) ) ;
INSERT INTO t1(i) VALUES (4),(5),(6) ;
SELECT * FROM t1 ;
ALTER TABLE t1 MODIFY COLUMN j DOUBLE DEFAULT(i*i);
SELECT * FROM t1 ;
INSERT INTO t1(i) VALUES (7);
SELECT * FROM t1 ;
DROP TABLE t1;

CREATE TABLE t2 ( i int, j int DEFAULT (i) ) ;
INSERT INTO t2(i) VALUES (4),(5),(6) ;
SELECT * FROM t2 ;
ALTER TABLE t2 MODIFY COLUMN j INT DEFAULT(i*i);
SELECT * FROM t2 ;
INSERT INTO t2(i) VALUES (7);
ALTER TABLE t2 MODIFY COLUMN j DOUBLE DEFAULT(i*100);
INSERT INTO t2(i) VALUES (8);
SELECT * FROM t2 ;
DROP TABLE t2;
CREATE TABLE t1 ( i INT, j INT DEFAULT( i * i) ) ;
ALTER TABLE t1 RENAME COLUMN i to i1 ;
DROP TABLE t1;

CREATE TABLE t1 ( i INT, j INT DEFAULT (i * i) ) ;
ALTER TABLE t1 CHANGE COLUMN i i1 DOUBLE DEFAULT ( 4 * 4 ) ;
DROP TABLE t1;

create table t1 (i int, j double DEFAULT (i * i) ) ;
alter table t1 add column k double DEFAULT (SQRT(z)) ;
DROP TABLE t1;


CREATE TABLE t1 (
  i1 INTEGER,
  i2 INTEGER DEFAULT (i1 + i1)
);
INSERT INTO t1 (i1, i2) SELECT 5, 6;
INSERT INTO t1 (i1) SELECT 5;
INSERT INTO t1 (i1) SELECT 5 ON DUPLICATE KEY UPDATE i2= 4;
INSERT INTO t1 (i1) SELECT 5 ON DUPLICATE KEY UPDATE i2= DEFAULT;
SELECT * FROM t1;

DROP TABLE t1;

CREATE TABLE t1 (
  i1 INTEGER,
  i2 INTEGER DEFAULT (i1 + RAND())
);
INSERT INTO t1 (i1, i2) SELECT 5, 6;
INSERT INTO t1 (i1) SELECT 5;
INSERT INTO t1 (i1) SELECT 5 ON DUPLICATE KEY UPDATE i2= 4;
INSERT INTO t1 (i1) SELECT 5 ON DUPLICATE KEY UPDATE i2= DEFAULT;
SELECT count(*) FROM t1;

DROP TABLE t1;

CREATE TABLE t1 (a INT UNIQUE DEFAULT (PI() + 3), b INT DEFAULT (-a));
INSERT INTO t1 (a) VALUES (1), (2);
SELECT * FROM t1;
INSERT INTO t1(a) VALUES (1) ON DUPLICATE KEY UPDATE a=DEFAULT;
SELECT * FROM t1;
DELETE FROM t1 WHERE a = 6;
UPDATE t1 SET a=DEFAULT WHERE a=2;
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a datetime, b varchar(10) DEFAULT (localtimestamp()));
INSERT INTO t1(a) VALUES (now());
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (truth ENUM('y','n') DEFAULT('y'));
CREATE TABLE t2 (truths SET('y','n') DEFAULT('y'));
INSERT INTO t1 values (DEFAULT);
INSERT INTO t1 values ();
INSERT INTO t2 values (DEFAULT);
INSERT INTO t2 values ();
SELECT * from t1;
SELECT * from t2;
DROP TABLE t1;
DROP TABLE t2;

CREATE TABLE t1 (truth ENUM('y','n') DEFAULT('s'));
CREATE TABLE t2 (truths SET('y','n') DEFAULT('p'));
INSERT INTO t1 values (DEFAULT);
INSERT INTO t1 values ();
INSERT INTO t2 values (DEFAULT);
INSERT INTO t2 values ();
SELECT * from t1;
SELECT * from t2;
DROP TABLE t1;
DROP TABLE t2;
CREATE TEMPORARY TABLE t1 (pk INT PRIMARY KEY);
ALTER TABLE t1 ADD COLUMN i INT DEFAULT ( "foobar" ), ALGORITHM=COPY;
DROP TEMPORARY TABLE t1;
CREATE TABLE bug(`id` binary(16) NOT NULL DEFAULT (uuid_to_bin(uuid())),
                 PRIMARY KEY (`id`));
DROP TABLE bug;
CREATE TABLE pk_t1(i INT NOT NULL);
INSERT INTO pk_t1 VALUES (1),(2),(3),(4);
ALTER TABLE pk_t1 ADD COLUMN
    (`id` BINARY(16) DEFAULT (uuid_to_bin(uuid())) PRIMARY KEY NOT NULL);
ALTER TABLE pk_t1 ADD COLUMN
    (`id` INT DEFAULT (10 + i) PRIMARY KEY NOT NULL);
INSERT INTO pk_t1(i) VALUES (5);
INSERT INTO pk_t1(i, id) VALUES (6, DEFAULT);
SELECT * FROM pk_t1;
ALTER TABLE  pk_t1 DROP COLUMN  id;
DROP TABLE pk_t1;
CREATE TABLE t2 (a INT AUTO_INCREMENT DEFAULT(0));
CREATE TABLE t1 (i INT);
ALTER TABLE t1 MODIFY COLUMN i INT AUTO_INCREMENT PRIMARY KEY DEFAULT(GROUPING(r));
ALTER TABLE t1 MODIFY COLUMN i INT AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE t1 ALTER COLUMN i SET DEFAULT(GROUPING(r));
DROP TABLE t1;
CREATE TABLE t1 (a INT PRIMARY KEY);
CREATE TABLE t2 LIKE t1;
CREATE TABLE t3 LIKE t1;
INSERT INTO t1 VALUES (1), (2);
INSERT INTO t2 SELECT * FROM t1;
INSERT INTO t3 SELECT * FROM t1;
ALTER TABLE t1 ADD COLUMN b INT DEFAULT (a), ADD COLUMN c INT GENERATED ALWAYS AS (-b) STORED;
ALTER TABLE t2 ADD COLUMN b INT DEFAULT (a), ADD COLUMN c INT GENERATED ALWAYS AS (-b) STORED, ALGORITHM=COPY;
ALTER TABLE t3 ADD COLUMN b INT DEFAULT (a), ADD COLUMN c INT GENERATED ALWAYS AS (-b) STORED, ALGORITHM=INPLACE;
SELECT * FROM t1;
SELECT * FROM t2;
SELECT * FROM t3;
DROP TABLES t1, t2, t3;
CREATE TABLE t1 (a INT, b INT);
CREATE TABLE t2 LIKE t1;
CREATE TABLE t3 LIKE t1;
INSERT INTO t1 VALUES (1, 1), (2, 2);
INSERT INTO t2 SELECT * FROM t1;
INSERT INTO t3 SELECT * FROM t1;
ALTER TABLE t1 DROP COLUMN b, ADD COLUMN c INT DEFAULT (a);
ALTER TABLE t2 DROP COLUMN b, ADD COLUMN c INT DEFAULT (a), ALGORITHM=COPY;
ALTER TABLE t3 DROP COLUMN b, ADD COLUMN c INT DEFAULT (a), ALGORITHM=INPLACE;
SELECT * FROM t1;
SELECT * FROM t2;
SELECT * FROM t3;
DROP TABLES t1, t2, t3;
CREATE TABLE t1 (a INT, b INT DEFAULT (1+1));
CREATE TABLE t2 LIKE t1;
CREATE TABLE t3 LIKE t1;
INSERT INTO t1 VALUES (1, 0), (2, 0);
INSERT INTO t2 SELECT * FROM t1;
INSERT INTO t3 SELECT * FROM t1;
ALTER TABLE t1 ADD COLUMN c INT AFTER a;
ALTER TABLE t2 ADD COLUMN c INT AFTER a, ALGORITHM=COPY;
ALTER TABLE t3 ADD COLUMN c INT AFTER a, ALGORITHM=INPLACE;
SELECT * FROM t1;
SELECT * FROM t2;
SELECT * FROM t3;
DROP TABLES t1, t2, t3;
CREATE TABLE t1 (a INT PRIMARY KEY);
CREATE TABLE t2 LIKE t1;
CREATE TABLE t3 LIKE t1;
INSERT INTO t1 VALUES (1), (2), (3);
INSERT INTO t2 SELECT * FROM t1;
INSERT INTO t3 SELECT * FROM t1;
ALTER TABLE t1 ADD COLUMN b INT DEFAULT (a),
               ADD COLUMN c INT GENERATED ALWAYS AS (-b) STORED,
               ADD COLUMN d INT DEFAULT (c),
               ADD COLUMN e INT GENERATED ALWAYS AS (-d) STORED;
ALTER TABLE t2 ADD COLUMN b INT DEFAULT (a),
               ADD COLUMN c INT GENERATED ALWAYS AS (-b) STORED,
               ADD COLUMN d INT DEFAULT (c),
               ADD COLUMN e INT GENERATED ALWAYS AS (-d) STORED,
               ALGORITHM=COPY;
ALTER TABLE t3 ADD COLUMN b INT DEFAULT (a),
               ADD COLUMN c INT GENERATED ALWAYS AS (-b) STORED,
               ADD COLUMN d INT DEFAULT (c),
               ADD COLUMN e INT GENERATED ALWAYS AS (-d) STORED,
               ALGORITHM=INPLACE;
SELECT * FROM t1;
SELECT * FROM t2;
SELECT * FROM t3;
DROP TABLES t1, t2, t3;

CREATE TABLE t1(i INT, j INT DEFAULT("foobar"));
ALTER TABLE t1 DROP COLUMN i ;
DROP TABLE  t1;

CREATE TABLE t2(i INT, j DATETIME DEFAULT(0) );
ALTER TABLE t2 DROP COLUMN i ;
DROP TABLE  t2;


--
-- Bug#31856459 MISSING COLUMN DEFAULT VALUES FROM INFORMATION_SCHEMA.COLUMNS
--
-- Verify if BLOB and TEXT field display default expression using
-- I_S.COLUNMNS and SHOW COLUMNS command.
--

CREATE TABLE t1 (
   pk_col      INT NOT NULL AUTO_INCREMENT,
   json_col    JSON,
   blob_col    BLOB,
   text_col    TEXT,
   tblob_col   TINYBLOB,
   ttext_col   TINYTEXT,
   json_col_d  JSON DEFAULT (JSON_OBJECT('key','val')),
   blob_col_d  BLOB DEFAULT ('asda'),
   text_col_d  TEXT DEFAULT (CONCAT('adasdada','ds')),
   tblob_col_d TINYBLOB DEFAULT ('asda'),
   ttext_col_d TINYTEXT DEFAULT (CONCAT('adasdada','ds')),
   PRIMARY KEY (`pk_col`));

SELECT COLUMN_NAME, COLUMN_DEFAULT, DATA_TYPE, EXTRA
  FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='t1'
  ORDER BY COLUMN_NAME;

DROP TABLE t1;
CREATE TABLE t1 (created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP);
ALTER TABLE t1 ADD COLUMN c1 VARCHAR(45) NULL;
DROP TABLE t1;
CREATE TABLE t1 (created DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP()));
ALTER TABLE t1 ADD COLUMN c1 VARCHAR(45) NULL;
DROP TABLE t1;

CREATE TABLE t1 (created DATETIME NOT NULL DEFAULT (CURTIME()));
ALTER TABLE t1 ADD COLUMN c1 VARCHAR(45) NULL;
DROP TABLE t1;

CREATE TABLE t1 (created DATETIME NOT NULL DEFAULT (CURRENT_TIME()));
ALTER TABLE t1 ADD COLUMN c1 VARCHAR(45) NULL;
DROP TABLE t1;

CREATE TABLE t1 (created DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP()));
ALTER TABLE t1 ADD COLUMN c1 VARCHAR(45) NULL;
DROP TABLE t1;

CREATE TABLE t1 (created DATETIME NOT NULL DEFAULT (LOCALTIME()));
ALTER TABLE t1 ADD COLUMN c1 VARCHAR(45) NULL;
DROP TABLE t1;

CREATE TABLE t1 (created DATETIME NOT NULL DEFAULT (LOCALTIMESTAMP()));
ALTER TABLE t1 ADD COLUMN c1 VARCHAR(45) NULL;
DROP TABLE t1;

CREATE TABLE t1 (created DATETIME NOT NULL DEFAULT (NOW()));
ALTER TABLE t1 ADD COLUMN c1 VARCHAR(45) NULL;
DROP TABLE t1;

CREATE TABLE t1 (created DATETIME NOT NULL DEFAULT (SYSDATE()));
ALTER TABLE t1 ADD COLUMN c1 VARCHAR(45) NULL;
DROP TABLE t1;

CREATE TABLE t1 (created DATETIME NOT NULL DEFAULT (UNIX_TIMESTAMP()));
ALTER TABLE t1 ADD COLUMN c1 VARCHAR(45) NULL;
DROP TABLE t1;

CREATE TABLE t1 (created DATETIME NOT NULL DEFAULT (UTC_DATE()));
ALTER TABLE t1 ADD COLUMN c1 VARCHAR(45) NULL;
DROP TABLE t1;

CREATE TABLE t1 (created DATETIME NOT NULL DEFAULT (UTC_TIME()));
ALTER TABLE t1 ADD COLUMN c1 VARCHAR(45) NULL;
DROP TABLE t1;
CREATE TABLE t (a INT,
                b INT GENERATED ALWAYS AS (DEFAULT(b)));
DROP TABLE IF EXISTS t;
CREATE TABLE t (a INT,
                b INT GENERATED ALWAYS AS (5*8),
                c INT GENERATED ALWAYS AS (DEFAULT(b)));
DROP TABLE IF EXISTS t;
CREATE TABLE t (a INT);
ALTER TABLE t ADD COLUMN b INT
  GENERATED ALWAYS AS (DEFAULT(b)), ALGORITHM=INPLACE;
DROP TABLE IF EXISTS t;
CREATE TABLE t (a INT,
                b INT,
                c INT DEFAULT (a*77));
DROP TABLE t;
CREATE TABLE t (a INT,
                b INT,
                c INT DEFAULT (a*77),
                d INT GENERATED ALWAYS AS (DEFAULT(c)));
CREATE TABLE t (a INT,
                b INT,
                c INT DEFAULT 77,
                d INT GENERATED ALWAYS AS (DEFAULT(c)));
INSERT INTO t VALUES(1,2,3,DEFAULT);
SELECT * FROM t;
DROP TABLE IF EXISTS t;
CREATE TABLE t (a INT,
                b INT GENERATED ALWAYS AS (a*5));
INSERT INTO t VALUES(7,DEFAULT);
SELECT * FROM t;
DROP TABLE IF EXISTS t;
