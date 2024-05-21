set allow_suspicious_low_cardinality_types=1;
set allow_experimental_analyzer=1;
create table tab (x LowCardinality(Nullable(Float64))) engine = MergeTree order by x settings allow_nullable_key=1;
insert into tab select number from numbers(2);
SELECT [(arrayJoin([x]), x)] AS row FROM tab;
CREATE TABLE t__fuzz_307 (`k1` DateTime, `k2` LowCardinality(Nullable(Float64)), `v` Nullable(UInt32)) ENGINE =
 ReplacingMergeTree ORDER BY (k1, k2) settings allow_nullable_key=1;
insert into t__fuzz_307 select * from generateRandom() limit 10;
CREATE TABLE t__fuzz_282 (`k1` DateTime, `k2` LowCardinality(Nullable(Float64)), `v` Nullable(UInt32)) ENGINE = ReplacingMergeTree ORDER BY (k1, k2) SETTINGS allow_nullable_key = 1;
INSERT INTO t__fuzz_282 VALUES (1, 2, 3) (1, 2, 4) (2, 3, 4), (2, 3, 5);
