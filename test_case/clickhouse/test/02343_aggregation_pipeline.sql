explain pipeline select * from (select * from numbers(1e8) group by number) group by number;
explain pipeline select * from (select * from numbers_mt(1e8) group by number) group by number;
explain pipeline select * from (select * from numbers_mt(1e8) group by number) order by number;
DROP TABLE IF EXISTS proj_agg_02343;
CREATE TABLE proj_agg_02343
(
    k1 UInt32,
    k2 UInt32,
    k3 UInt32,
    value UInt32,
    PROJECTION aaaa
    (
        SELECT
            k1,
            k2,
            k3,
            sum(value)
        GROUP BY k1, k2, k3
    )
)
ENGINE = MergeTree
ORDER BY tuple();
INSERT INTO proj_agg_02343 SELECT 1, number % 2, number % 4, number FROM numbers(100000);
OPTIMIZE TABLE proj_agg_02343 FINAL;
create table t(a UInt64) engine = MergeTree order by (a);
system stop merges t;
system stop merges dist_t;
