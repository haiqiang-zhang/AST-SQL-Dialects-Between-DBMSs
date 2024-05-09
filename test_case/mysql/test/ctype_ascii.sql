select 'e'='`';
select 'y'='~';
create table t1 (a char(1) character set ascii);
select t1a.a, t1b.a from t1 as t1a, t1 as t1b where t1a.a=t1b.a order by binary t1a.a, binary t1b.a;
drop table t1;
CREATE TABLE t1 (v VARCHAR(10) CHARACTER SET ASCII);
INSERT INTO t1 VALUES('a');
SELECT HEX(v) FROM t1;
DROP TABLE t1;
