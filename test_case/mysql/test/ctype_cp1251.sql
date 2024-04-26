
-- Test of charset cp1251

--disable_warnings
drop table if exists t1;

SET NAMES cp1251;

--
-- Test problem with LEFT() (Bug #514)
--

create table t1 (a varchar(10) not null) character set cp1251;
insert into t1 values ("a"),("ab"),("abc");
select * from t1;
select a, left(a,1) as b from t1;
select a, left(a,1) as b from t1 group by a;
SELECT DISTINCT RIGHT(a,1) from t1;
drop table t1;

--
-- Test of binary and upper/lower
--
create table t1 (a char(3) binary, b binary(3)) character set cp1251;
insert into t1 values ('aaa','bbb'),('AAA','BBB');
select upper(a),upper(b) from t1;
select lower(a),lower(b) from t1;
select * from t1 where upper(a)='AAA';
select * from t1 where lower(a)='aaa';
select * from t1 where upper(b)='BBB';
select * from t1 where lower(b)='bbb';
select charset(a), charset(b), charset(binary 'ccc') from t1 limit 1;
select collation(a), collation(b), collation(binary 'ccc') from t1 limit 1;
drop table t1;

-- Test for BUG#8560
create table t1 (
 a varchar(16) character set cp1251 collate cp1251_bin not null,
 b int(10) default null,
 primary key(a)
) charset=cp1251;
insert into t1 (a) values ('air'),
  ('we'),('g'),('we_toshko'), ('s0urce'),('we_ivo'),('we_iliyan'),
  ('we_martin'),('vw_grado'),('vw_vasko'),('tn_vili'),('tn_kalina'),
  ('tn_fakira'),('vw_silvia'),('vw_starshi'),('vw_geo'),('vw_b0x1');

SELECT * FROM t1 WHERE a LIKE 'we_%' ORDER BY a;
drop table t1;

--
-- Bug #48053 String::c_ptr has a race and/or does an invalid 
--            memory reference
--            (triggered by Valgrind tests)
--  (see also ctype_eucjpms.test, ctype_cp1250.test, ctype_cp1251.test)
--
--error 1649
set global LC_TIME_NAMES=convert((-8388608) using cp1251);
CREATE TABLE t1 (test1 INT, test2 VARCHAR(255));
SELECT COALESCE(IF(test1=1, 1, NULL), test2) FROM t1;
SELECT COALESCE(IF(test1=1, NULL, 1), test2) FROM t1;
DROP TABLE t1;

--
-- Bugs#12635232: VALGRIND WARNINGS: IS_IPV6, IS_IPV4, INET6_ATON,
-- INET6_NTOA + MULTIBYTE CHARSET.
--

SET NAMES cp1251;
