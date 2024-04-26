drop table if exists t1;

CREATE TABLE t1 (
  a char(5) NOT NULL,
  b char(4) NOT NULL,
  KEY (a),
  KEY (b)
) charset utf8mb4;

INSERT INTO t1 VALUES ('A','B'),('b','A'),('C','c'),('D','E'),('a','a');
select * from t1,t1 as t2;
select t1.*,t2.* from t1,t1 as t2 where t1.A=t2.B order by binary t1.a,t2.a;
select * from t1 where a='a';
drop table t1;
