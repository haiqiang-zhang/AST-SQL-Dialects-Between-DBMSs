
--
-- Tests for "LOAD XML" - a contributed patch from Erik Wetterberg.
--

--disable_warnings
drop table if exists t1, t2;

create table t1 (a int, b varchar(64));
select * from t1 order by a;
delete from t1;
select * from t1 order by a;
delete from t1;
select * from t1 order by a;
delete from t1;
select * from t1 order by a;
select 1 as xml;


--
-- Bug #42520    killing load .. infile Assertion failed: ! is_set(), file .\sql_error.cc, line 8
--

--disable_query_log
delete from t1;
insert into t1 values (1, '12345678900987654321'), (2, 'asdfghjkl;
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
create table t2(fl text);
drop table t1;
drop table t2;

--
-- Bug #36750    LOAD XML doesn't understand new line (feed) characters in multi line text fields
--

create table t1 (
  id int(11) not null,
  text text,
  primary key (id)
) default charset=latin1;
select * from t1;
drop table t1;
CREATE TABLE t1 (a text, b text);
SELECT * FROM t1 ORDER BY a;
DROP TABLE t1;
CREATE TABLE t1 (col1 VARCHAR(3), col2 VARCHAR(3), col3 VARCHAR(3), col4 VARCHAR(4));
SELECT * FROM t1 ORDER BY col1, col2, col3, col4;
DROP TABLE t1;

CREATE TABLE t1 (col1 VARCHAR(3), col2 VARCHAR(3), col3 INTEGER);
SELECT * FROM t1 ORDER BY col1, col2, col3;
DROP TABLE t1;

CREATE TABLE t1 (col1 VARCHAR(3), col2 VARCHAR(3), col3 INTEGER);
CREATE TABLE t2(i INT NOT NULL);
CREATE TRIGGER t1_ai AFTER INSERT ON t1 FOR EACH ROW INSERT INTO t2 VALUES (NULL);

DROP TABLE t1, t2;


CREATE TABLE t3 (col1 VARCHAR(3), col2 VARCHAR(3), col3 INTEGER);
CREATE VIEW v3 AS SELECT * FROM t3 WHERE col3 < 0 WITH CHECK OPTION;

DROP VIEW v3;
DROP TABLE t3;


CREATE TABLE t4 (col1 VARCHAR(3), col2 VARCHAR(3), col3 INTEGER, col4 INT NOT NULL);

DROP TABLE t4;
CREATE TABLE t1(a INT NOT NULL PRIMARY KEY, p INT NULL);
SELECT * FROM t1 ORDER BY a;
DROP TABLE t1;

CREATE TABLE t1(a INT NOT NULL PRIMARY KEY, p INT NULL, s VARCHAR(100));
SELECT * FROM t1 ORDER BY a;
DROP TABLE t1;
