select * from t1;
select a, left(a,1) as b from t1;
select a, left(a,1) as b from t1 group by a;
SELECT DISTINCT RIGHT(a,1) from t1;
drop table t1;
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
CREATE TABLE t1 (test1 INT, test2 VARCHAR(255));
SELECT COALESCE(IF(test1=1, 1, NULL), test2) FROM t1;
DROP TABLE t1;
