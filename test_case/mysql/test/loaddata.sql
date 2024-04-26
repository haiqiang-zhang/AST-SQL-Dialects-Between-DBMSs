--

create table t1 (a date, b date, c date not null, d date);
SELECT * from t1;

-- Support optional FROM keyword in syntax
load data from infile '../../std_data/loaddata1.dat'
into table t1 fields terminated by ',' ignore 2 lines;
SELECT * from t1;

-- Support but ignore directive about file sorted in primary key order:
load data infile '../../std_data/loaddata1.dat' in primary key order
into table t1 fields terminated by ',' ignore 2 lines;
SELECT * from t1;

-- Using multiple files is not allowed without BULK
--error ER_WRONG_USAGE
load data infile '../../std_data/loaddata1.dat' count 1 into table t1;

-- Source other than file is not allowed without BULK
--error ER_WRONG_USAGE
load data url '../../std_data/loaddata1.dat' into table t1;
SELECT * from t1;
drop table t1;

create table t1 (a text, b text);
select concat('|',a,'|'), concat('|',b,'|') from t1;
drop table t1;

create table t1 (a int, b char(10)) charset latin1;
select * from t1;

-- The empty line last comes from the end line field in the file
select * from t1;
drop table t1;

--
-- Bug #12053 LOAD DATA INFILE ignores NO_AUTO_VALUE_ON_ZERO setting
--
SET @OLD_SQL_MODE=@@SQL_MODE, @@SQL_MODE=NO_AUTO_VALUE_ON_ZERO;
create table t1(id integer not null auto_increment primary key);
insert into t1 values(0);
delete from t1;
select * from t1;
delete from t1;
select * from t1;
SET @@SQL_MODE=@OLD_SQL_MODE;
drop table t1;

--
-- Bug #11203: LOAD DATA does not accept same characters for ESCAPED and
-- ENCLOSED
--
create table t1 (a varchar(20), b varchar(20));
select * from t1;
drop table t1;

--
-- Bug #29294 SELECT INTO OUTFILE/LOAD DATA INFILE with special
-- characters in the FIELDS ENCLOSED BY clause
--

CREATE TABLE t1 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  c1 VARCHAR(255)
);

CREATE TABLE t2 (
  id INT,
  c2 VARCHAR(255)
);

INSERT INTO t1 (c1) VALUES
  ('r'),   ('rr'),   ('rrr'),   ('rrrr'),
  ('.r'),  ('.rr'),  ('.rrr'),  ('.rrrr'),
  ('r.'),  ('rr.'),  ('rrr.'),  ('rrrr.'),
  ('.r.'), ('.rr.'), ('.rrr.'), ('.rrrr.');
SELECT * FROM t1;
SELECT t1.id, c1, c2 FROM t1 LEFT  JOIN t2 ON t1.id=t2.id WHERE c1 != c2;
SELECT t1.id, c1, c2 FROM t1 RIGHT JOIN t2 ON t1.id=t2.id WHERE c1 != c2;
DROP TABLE t1,t2;

-- End of 4.1 tests

--
-- Let us test extended LOAD DATA features
--
create table t1 (a int default 100, b int, c varchar(60));
select * from t1;
select * from t1;
set @c:=123;
select * from t1;
select * from t1;
select @a, @b;
select * from t1;
select * from t1;
select * from t1;

-- Now let us test LOAD DATA with subselect
create table t2 (num int primary key, str varchar(10));
insert into t2 values (10,'Ten'), (15,'Fifteen');
select * from t1;

--
-- Bug#18628 mysql-test-run: security problem
--
-- It should not be possible to load from a file outside of vardir

--error 1238
set @@secure_file_priv= 0;

-- Test "load data"
truncate table t1;
select * from t1;

-- Test "load_file" returns NULL
--replace_result $MYSQL_TEST_DIR MYSQL_TEST_DIR
eval select load_file("$MYSQL_TEST_DIR/t/loaddata.test");

-- cleanup
drop table t1, t2;

--
-- Bug#27586: Wrong autoinc value assigned by LOAD DATA in the
--            NO_AUTO_VALUE_ON_ZERO mode
--
create table t1(f1 int);
insert into t1 values(1),(null);
create table t2(f2 int auto_increment primary key);
SET @OLD_SQL_MODE=@@SQL_MODE, @@SQL_MODE=NO_AUTO_VALUE_ON_ZERO;
select * from t2;
SET @@SQL_MODE=@OLD_SQL_MODE;
drop table t1,t2;

--
-- Bug#27670: LOAD DATA does not set CURRENT_TIMESTAMP default value for a
--            TIMESTAMP field when no value has been provided.
--
create table t1(f1 int, f2 timestamp not null default current_timestamp);
create table t2(f1 int);
insert into t2 values(1),(2);
SET @previous_sql_mode = @@sql_mode;
SET sql_mode = 'ALLOW_INVALID_DATES';
select f1 from t1 where f2 <> '0000-00-00 00:00:00' order by f1;
delete from t1;
select f1 from t1 where f2 <> '0000-00-00 00:00:00' order by f1;
SET sql_mode = @previous_sql_mode;
drop table t1,t2;

--
-- Bug#29442: SELECT INTO OUTFILE FIELDS ENCLOSED BY digit, minus sign etc
--            corrupts non-string fields containing this character.
--

CREATE TABLE t1 (c1 INT, c2 TIMESTAMP, c3 REAL, c4 DOUBLE);

INSERT INTO t1 (c1, c2, c3, c4) VALUES (10, '1970-02-01 01:02:03', 1.1E-100, 1.1E+100);
SELECT * FROM t1;
SELECT * FROM t1;
DROP TABLE t1;
DROP TABLE IF EXISTS t1;
DROP VIEW IF EXISTS v1;
DROP VIEW IF EXISTS v2;
DROP VIEW IF EXISTS v3;
CREATE TABLE t1(c1 INT, c2 VARCHAR(255));
CREATE VIEW v1 AS SELECT * FROM t1;
CREATE VIEW v2 AS SELECT 1 + 2 AS c0, c1, c2 FROM t1;
CREATE VIEW v3 AS SELECT 1 AS d1, 2 AS d2;
SELECT * FROM t1;
SELECT * FROM v1;
DELETE FROM t1;
SELECT * FROM t1;
SELECT * FROM v2;
DELETE FROM t1;
DROP TABLE t1;
DROP VIEW v1;
DROP VIEW v2;
DROP VIEW v3;

--
-- Bug#37114: sql_mode NO_BACKSLASH_ESCAPES does not work properly with
--            LOAD DATA INFILE
--

-- - For each plain "SELECT id,...", the 1st pair ("before" SELECT...OUTFILE,
--   LOAD...INFILE) and the 2nd pair of lines ("after") in the result should
--   look the same, otherwise we broke the dumpe/restore cycle!
--
-- - the \r is always { '\\', 'r' } in memory, but on-disk format changes
--
-- - the \t is { '\t' } or { '\\', 't' } in memory depending on whether \
--    is magic (that is, NO_BACKSLASH_ESCAPES is not set) at INSERT-time.
--    on-disk format varies.
--
-- - while INFILE/OUTFILE behaviour changes according to NO_BACKSLASH_ESCAPES,
--   we can override these defaults using ESCAPED BY '...'
--   1:  NO_BACKSLASH_ESCAPES default,  \  on-disk:  \,t,x,\r
--   2:  NO_BACKSLASH_ESCAPES override, \\ on-disk:  \,\,t,x,\,\,r
--   3: !NO_BACKSLASH_ESCAPES default,  \\ on-disk:  tab,\,\,r
--   3: !NO_BACKSLASH_ESCAPES override, \  on-disk:  tab,\,r

--echo Bug--37114

SET SESSION character_set_client=latin1;
SET SESSION character_set_server=latin1;
SET SESSION character_set_connection=latin1;
SET @OLD_SQL_MODE=@@SESSION.SQL_MODE;

-- 0. test LOAD DATA INFILE first;
--    SELECT INTO OUTFILE / LOAD DATA INFILE cycles below are
--    arguably in the saving.

--echo test LOAD DATA INFILE

--let $file=$MYSQLTEST_VARDIR/tmp/bug37114.txt
--let $file2=$MYSQLTEST_VARDIR/tmp/bug37114_out.txt

SET sql_mode = '';

CREATE TABLE t1 (id INT, val1 CHAR(3));

SET sql_mode = 'NO_BACKSLASH_ESCAPES';
SELECT * FROM t1;

-- show we can write this with OUTFILE, forcing the parameters for now
--replace_result $MYSQLTEST_VARDIR MYSQLTEST_VARDIR
--eval SELECT * INTO OUTFILE '$file2' FIELDS ESCAPED BY '' TERMINATED BY ' ' FROM t1
--diff_files $file $file2
--remove_file $file2

-- now show the OUTFILE defaults are correct with NO_BACKSLASH_ESCAPES
--replace_result $MYSQLTEST_VARDIR MYSQLTEST_VARDIR
--eval SELECT * INTO OUTFILE '$file2' FIELDS               TERMINATED BY ' ' FROM t1
--diff_files $file $file2
--remove_file $file2

INSERT INTO t1 (id, val1) VALUES (1, '\aa');
SELECT * FROM t1;

SET sql_mode='';
INSERT INTO t1 (id, val1) VALUES (1, '\aa');
SELECT * FROM t1;

DROP TABLE t1;

CREATE TABLE t1 (id INT PRIMARY KEY, val1 CHAR(4));
CREATE TABLE t2 LIKE t1;

-- 1. with NO_BACKSLASH_ESCAPES on

SET sql_mode = '';
INSERT INTO t1 (id, val1) VALUES (5, '\ttab');
INSERT INTO t1 (id, val1) VALUES (4, '\\r');
SET sql_mode = 'NO_BACKSLASH_ESCAPES';
INSERT INTO t1 (id, val1) VALUES (3, '\tx');

SELECT 'before' AS t, id, val1, hex(val1) FROM t1 UNION
 SELECT 'after' AS t, id, val1, hex(val1) FROM t2 ORDER BY id,t DESC;

SELECT 'before' AS t, id, val1, hex(val1) FROM t1 UNION
 SELECT 'after' AS t, id, val1, hex(val1) FROM t2 ORDER BY id,t DESC;



-- 2. with NO_BACKSLASH_ESCAPES off

SET sql_mode = '';

SELECT 'before' AS t, id, val1, hex(val1) FROM t1 UNION
 SELECT 'after' AS t, id, val1, hex(val1) FROM t2 ORDER BY id,t DESC;

SET sql_mode = 'NO_BACKSLASH_ESCAPES';

SET sql_mode = '';

SELECT 'before' AS t, id, val1, hex(val1) FROM t1 UNION
 SELECT 'after' AS t, id, val1, hex(val1) FROM t2 ORDER BY id,t DESC;

SET sql_mode = 'NO_BACKSLASH_ESCAPES';

-- clean up
set session sql_mode=@OLD_SQL_MODE;
DROP TABLE t1,t2;

select load_file(0x0A9FB76C661B409C4BEC88098C5DD71B1072F9691F2E827D7EC8F092B299868A3CE196C04F0FB18CAB4E1557EB72331D812379DE7A75CA21C32E7C722C59E5CC33EF262EF04187B0F0EE756FA984DF2EAD37B1E4ADB064C3C5038F2E3B2D661B1C1150AAEB5425512E14D7506166D92D4533872E662F4B2D1428AAB5CCA72E75AA2EF325E196A5A02E2E8278873C64375845994B0F39BE2FF7B478332A7B0AA5E48877C47B6F513E997848AF8CCB8A899F3393AB35333CF0871E36698193862D486B4B9078B70C0A0A507B8A250F3F876F5A067632D5E65193E4445A1EC3A2C9B4C6F07AC334F0F62BC33357CB502E9B1C19D2398B6972AEC2EF21630F8C9134C4F7DD662D8AD7BDC9E19C46720F334B66C22D4BF32ED275144E20E7669FFCF6FC143667C9F02A577F32960FA9F2371BE1FA90E49CBC69C01531F140556854D588DD0E55E1307D78CA38E975CD999F9AEA604266329EE62BFB5ADDA67F549E211ECFBA906C60063696352ABB82AA782D25B17E872EA587871F450446DB1BAE0123D20404A8F2D2698B371002E986C8FCB969A99FF0E150A2709E2ED7633D02ADA87D5B3C9487D27B2BD9D21E2EC3215DCC3CDCD884371281B95A2E9987AAF82EB499C058D9C3E7DC1B66635F60DB121C72F929622DD47B6B2E69F59FF2AE6B63CC2EC60FFBA20EA50569DBAB5DAEFAEB4F03966C9637AB55662EDD28439155A82D053A5299448EDB2E7BEB0F62889E2F84E6C7F34B3212C9AAC32D521D5AB8480993F1906D5450FAB342A0FA6ED223E178BAC036B81E15783604C32A961EA1EF20BE2EBB93D34ED37BC03142B7583303E4557E48551E4BD7CBDDEA146D5485A5D212C35189F0BD6497E66912D2780A59A53B532E12C0A5ED1EC0445D96E8F2DD825221CFE4A65A87AA21DC8750481B9849DD81694C3357A0ED9B78D608D8EDDE28FAFBEC17844DE5709F41E121838DB55639D77E32A259A416D7013B2EB1259FDE1B498CBB9CAEE1D601DF3C915EA91C69B44E6B72062F5F4B3C73F06F2D5AD185E1692E2E0A01E7DD5133693681C52EE13B2BE42D03BDCF48E4E133CF06662339B778E1C3034F9939A433E157449172F7969ACCE1F5D2F65A4E09E4A5D5611EBEDDDBDB0C0C0A);



--
-- Bug#12448 LOAD DATA / SELECT INTO OUTFILE
-- doesn't work with multibyte path name
--
CREATE TABLE t1 (a int);
INSERT INTO t1 VALUES (1);
SET NAMES latin1;
SET character_set_filesystem=binary;
select @@character_set_filesystem;
SELECT * INTO OUTFILE 't-1' FROM t1;
DELETE FROM t1;
SELECT * FROM t1;
DELETE FROM t1;
SET character_set_filesystem=latin1;
select @@character_set_filesystem;
SELECT * FROM t1;
DROP TABLE t1;
let $MYSQLD_DATADIR= `select @@datadir`;
SET character_set_filesystem=default;
select @@character_set_filesystem;

CREATE TABLE t1(col0 LONGBLOB);
SELECT 'test' INTO OUTFILE 't1.txt';
SELECT * FROM t1;

DROP TABLE t1;
let $MYSQLD_DATADIR= `select @@datadir`;

CREATE TABLE t1 (id INT NOT NULL);
DROP TABLE t1;
--           The below protion is moved to ctype_ucs.test                    #
--############################################################################
----echo #
----echo # Bug #51876 : crash/memory underrun when loading data with ucs2 
----echo #   and reverse() function
----echo #

----echo # Problem # 1 (original report): wrong parsing of ucs2 data
--SELECT '00' UNION SELECT '10' INTO OUTFILE 'tmpp.txt';

CREATE TABLE t1(f1 INT);

DROP TABLE t1;
let $MYSQLD_DATADIR= `select @@datadir`;

create table t1(a point);
drop table t1;

CREATE TABLE t1(a INTEGER);

CREATE VIEW v1 AS SELECT t1.a FROM t1, t1 AS t2;

DROP VIEW v1;
DROP TABLE t1;
SET @old_mode= @@sql_mode;
CREATE TABLE t1 (fld1 INT);
SET sql_mode=default;
     FIELDS TERMINATED BY 't' LINES TERMINATED BY '';

SET @@sql_mode= @old_mode;
DROP TABLE t1;

CREATE DATABASE d1 CHARSET latin1;
USE d1;
CREATE TABLE t1 (val TEXT);
SELECT COUNT(*) FROM t1;
SELECT HEX(val) FROM t1;

CREATE DATABASE d2 CHARSET utf8mb3;
USE d2;
CREATE TABLE t1 (val TEXT);
SELECT COUNT(*) FROM t1;
SELECT HEX(val) FROM t1;


DROP TABLE d1.t1, d2.t1;
DROP DATABASE d1;
DROP DATABASE d2;
USE test;

CREATE TABLE t(a INTEGER PRIMARY KEY, b INTEGER, c INTEGER);
CREATE VIEW v AS SELECT a, b+c AS d FROM t;

DROP VIEW v;
DROP TABLE t;
CREATE TABLE t1(a VARCHAR(20)) CHARSET utf8mb4;
SELECT HEX(a) FROM t1;
DROP TABLE t1;
CREATE TABLE t1(a VARCHAR(20)) CHARSET gb18030;
SELECT HEX(a) FROM t1;
DROP TABLE t1;

CREATE TABLE t1(a VARCHAR(20));
CREATE PROCEDURE p1() LOAD DATA INFILE '../../std_data/loaddata_utf8.dat' INTO TABLE t1;


SET @save_local_infile = @@local_infile;
SET GLOBAL local_infile = OFF;

SET GLOBAL local_infile = @save_local_infile;


DROP TABLE t1;

CREATE TABLE t2(a BLOB);

DROP TABLE t2;


CREATE TABLE t3(a VARCHAR(20), i INT NOT NULL);

DROP TABLE t3;
CREATE TABLE t1 (x DOUBLE, y DOUBLE, g GEOMETRY NOT NULL SRID 4326);
  (x, y);
  (x, y) SET g = ST_SRID(POINT(x, y), 4326);
SELECT x, y, ST_AsText(g), ST_SRID(g) FROM t1;

DROP TABLE t1;
SET @old_sql_mode = @@sql_mode;
SET @@sql_mode = 'NO_AUTO_VALUE_ON_ZERO';
CREATE TABLE t1 (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, j INT);
INSERT INTO t1 VALUES (0, 1);
SELECT * FROM t1;
DELETE FROM t1;
SELECT * FROM t1;
DELETE FROM t1;
SELECT * FROM t1;
DELETE FROM t1;
SELECT * FROM t1;
DROP TABLE t1;
SET sql_mode=@old_sql_mode;

CREATE TABLE t1 (
 json_col JSON , KEY json_col ((CAST(json_col -> '$' AS UNSIGNED ARRAY)))
);
INSERT INTO t1 VALUES('[]');
SELECT * FROM t1;
DELETE FROM t1;
SELECT * FROM t1;
DELETE FROM t1;
SELECT * FROM t1;

DROP TABLE t1;

CREATE TABLE t1 (c1 varchar(5), c2 varchar(5));
INSERT INTO t1 VALUES ('a','a');
CREATE TABLE t2 (d1 varchar(5), d2 varchar(5));
INSERT INTO t2 VALUES ('a','a'), ('b','b');
DELETE FROM t2;

-- load data back into t2 with a condition
--replace_result $MYSQLTEST_VARDIR MYSQLTEST_VARDIR
--eval LOAD DATA INFILE '$MYSQLTEST_VARDIR/tmp/t2.csv' INTO TABLE t2 FIELDS TERMINATED BY ',' SET d1=(SELECT 1 FROM t1 WHERE c1=d2);
SELECT * FROM t2;

DROP TABLE t1, t2;

CREATE TABLE t1 (c1 CHAR(10) NOT NULL);
INSERT INTO t1 VALUES ('236451');
CREATE TABLE t2(c1 SMALLINT, c2 CHAR(10));
INSERT INTO t2 VALUES (0,'236451');
INSERT INTO t2 VALUES (1,'236451');
CREATE TABLE t3(c1 SMALLINT, c2 CHAR(10));
INSERT INTO t3 VALUES (0,'236451');

-- dump t1 into a file
--replace_result $MYSQLTEST_VARDIR MYSQLTEST_VARDIR
--eval SELECT * FROM t1 INTO OUTFILE '$MYSQLTEST_VARDIR/tmp/t1.csv';
DELETE FROM t1;

-- load data back into t1
--replace_result $MYSQLTEST_VARDIR MYSQLTEST_VARDIR
--eval LOAD DATA LOCAL INFILE '$MYSQLTEST_VARDIR/tmp/t1.csv' INTO TABLE t1 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' SET c1 = (SELECT t2.c2 FROM t2 INNER JOIN t3 ON t3.c1=t2.c1 where t3.c2='236451');
SELECT * FROM t1;

DROP TABLE t1,t2,t3;

CREATE TABLE ibstd_03 (
  a INT NOT NULL,
  d INT NOT NULL,
  b BLOB NOT NULL,
  c TEXT,
  vadcol INT AS (a+length(d)) STORED,
  vbcol CHAR(2) AS (substr(b,2,2)) VIRTUAL,
  vbidxcol CHAR(3) AS (substr(b,1,3)) VIRTUAL
  )
;

DROP TABLE ibstd_03;
