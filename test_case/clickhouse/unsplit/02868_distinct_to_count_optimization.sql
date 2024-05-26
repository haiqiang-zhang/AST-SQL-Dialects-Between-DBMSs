drop table if exists test_rewrite_uniq_to_count;
CREATE TABLE test_rewrite_uniq_to_count
(
    `a` UInt8,
    `b` UInt8,
    `c` UInt8
) ENGINE = MergeTree ORDER BY `a`;
INSERT INTO test_rewrite_uniq_to_count values ('1', '1', '1'), ('1', '1', '1');
INSERT INTO test_rewrite_uniq_to_count values ('2', '2', '2'), ('2', '2', '2');
INSERT INTO test_rewrite_uniq_to_count values ('3', '3', '3'), ('3', '3', '3');
set optimize_uniq_to_count=true;
SELECT '1. test simple distinct';
SELECT uniq(a) FROM (SELECT DISTINCT a FROM test_rewrite_uniq_to_count) settings allow_experimental_analyzer=0;
EXPLAIN SYNTAX SELECT uniq(a) FROM (SELECT DISTINCT a FROM test_rewrite_uniq_to_count) settings allow_experimental_analyzer=0;
SELECT '2. test distinct with subquery alias';
SELECT '3. test distinct with compound column name';
SELECT '4. test distinct with select expression alias';
SELECT '5. test simple group by';
SELECT '6. test group by with subquery alias';
SELECT '7. test group by with compound column name';
SELECT '8. test group by with select expression alias';
drop table if exists test_rewrite_uniq_to_count;
