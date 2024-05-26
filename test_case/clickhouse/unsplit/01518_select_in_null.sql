DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (`cA` String, `c1` String) ENGINE = MergeTree ORDER BY (cA, c1);
insert into t1 select 'AAAAAAAAAAA', 'BBBBBB';
select count() from t1 where c1 in (select 'BBBBBB' union all select null);
DROP TABLE t1;
