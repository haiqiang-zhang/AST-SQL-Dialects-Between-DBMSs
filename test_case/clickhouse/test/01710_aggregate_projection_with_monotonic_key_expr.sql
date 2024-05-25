SELECT count() FROM t0 GROUP BY gcd(-sign(c0), -c0) SETTINGS optimize_use_implicit_projections = 1;
create table t1 (c0 Int32) engine = MergeTree order by sin(c0);
insert into t1 values (-1), (1);
select c0 from t1 order by sin(-c0) settings optimize_read_in_order=0;
select c0 from t1 order by sin(-c0) settings optimize_read_in_order=1;
DROP TABLE t0;
DROP TABLE t1;
