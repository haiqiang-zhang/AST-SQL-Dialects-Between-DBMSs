--

--echo --
--echo -- Bug#13335170 - ASSERT IN
--echo -- PLAN_CHANGE_WATCHDOG::~PLAN_CHANGE_WATCHDOG() ON SELECT DISTINCT 
--echo --

CREATE TABLE t1 (
  col_int_key int(11) NOT NULL,
  col_time_key time NOT NULL,
  col_datetime_key datetime NOT NULL,
  KEY col_int_key (col_int_key),
  KEY col_time_key (col_time_key),
  KEY col_datetime_key (col_datetime_key)
) ENGINE=InnoDB;

INSERT INTO t1 VALUES (7,'06:17:39','2003-08-21 00:00:00');

SELECT DISTINCT col_int_key
FROM t1
WHERE col_int_key IN  ( 18, 6, 84, 4, 0, 2, 8, 3, 7, 9, 1 )
  AND col_datetime_key BETWEEN '2001-08-04' AND '2003-06-13'
ORDER BY col_time_key
LIMIT 3;
DROP TABLE t1;

create table t1(a int, b int, c int) engine=InnoDB;
create table t2(a int, b int, c int) engine=InnoDB;
insert into t2 values();
let $source=t1;
let $source_no_alias=t1;
create view v1 as select t1.* from t1 left join t2 on 1;
let $source=v1;
let $source_no_alias=v1;
drop view v1;
create view v1 as select t1.a*2 as a, t1.b*2 as b, t1.c*2 as c from t1;
let $source=v1;
let $source_no_alias=v1;
drop view v1;
let $source=(SELECT t1.* FROM t1 left join t2 on 1) AS derived;
let $source_no_alias=(SELECT t1.* FROM t1 left join t2 on 1);
select distinct t1_outer.a from t1 t1_outer
order by t1_outer.b;
select distinct t1_outer.a from t1 t1_outer
order by (select max(t1_outer.b+t1_inner.b) from t1 t1_inner);
select
 (select distinct 1 from t1 t1_inner
  group by t1_inner.a order by max(t1_outer.b))
 from t1 t1_outer;

drop table t1, t2;
