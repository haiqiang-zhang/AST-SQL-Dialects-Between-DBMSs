drop table if exists t0;
CREATE TABLE t0 (`c0` String, `c1` Int32 CODEC(NONE), `c2` Int32) ENGINE = MergeTree() ORDER BY tuple();
insert into t0 values ('a', 1, 2);
drop table if exists t0;
