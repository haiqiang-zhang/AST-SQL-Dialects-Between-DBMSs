drop table if exists dummy;
CREATE TABLE dummy ( num1 Int32, num2 Enum8('foo' = 0, 'bar' = 1, 'tar' = 2) )
ENGINE = MergeTree ORDER BY num1 as select 5, 'bar';
set compile_aggregate_expressions=1;
set min_count_to_compile_aggregate_expression=0;
