WITH
    arrayJoin([1, 2, 3, nan, 4, 5]) AS data,
    arrayJoin([nan, 1, 2, 3, 4]) AS data2,
    arrayJoin([1, 2, 3, 4, nan]) AS data3,
    arrayJoin([nan, nan, nan]) AS data4,
    arrayJoin([nan, 1, 2, 3, nan]) AS data5
SELECT
    min(data),
    min(data2),
    min(data3),
    min(data4),
    min(data5);
WITH
    arrayJoin([1, 2, 3, nan, 4, 5]) AS data,
    arrayJoin([nan, 1, 2, 3, 4]) AS data2,
    arrayJoin([1, 2, 3, 4, nan]) AS data3,
    arrayJoin([nan, nan, nan]) AS data4,
    arrayJoin([nan, 1, 2, 3, nan]) AS data5
SELECT
    max(data),
    max(data2),
    max(data3),
    max(data4),
    max(data5);
Select max(number) from numbers(100) settings max_threads=1, max_block_size=10;
Select max(-number) from numbers(100);
Select min(number) from numbers(100) settings max_threads=1, max_block_size=10;
Select min(-number) from numbers(100);
SELECT minIf(number::String, number < 10) as number from numbers(10, 1000);
SELECT maxIf(number::String, number % 3), maxIf(number::String, number % 5), minIf(number::String, number % 3), minIf(number::String, number > 10) from numbers(400);
SELECT argMax(number, now()) FROM (Select number as number from numbers(10, 10000)) settings max_threads=1, max_block_size=100;
SELECT argMaxIf(number, now() + number, number % 10 < 20) FROM (Select number as number from numbers(10, 10000)) settings max_threads=1, max_block_size=100;
SELECT argMax(number, number::Float64) from numbers(2029);
SELECT argMaxIf(number, number::Float64, number > 2030) from numbers(2029);
SELECT argMin(number, now()) FROM (Select number as number from numbers(10, 10000)) settings max_threads=1, max_block_size=100;
SELECT argMinIf(number, now() + number, number % 10 < 20) FROM (Select number as number from numbers(10, 10000)) settings max_threads=1, max_block_size=100;
SELECT argMin(number, number::Float64) from numbers(2029);
SELECT argMinIf(number, number::Float64, number > 2030) from numbers(2029);
Select argMax((n, n), n) t, toTypeName(t) FROM (Select if(number % 3 == 0, NULL, number) as n from numbers(10));
SET compile_aggregate_expressions=1;
SET min_count_to_compile_aggregate_expression=0;
