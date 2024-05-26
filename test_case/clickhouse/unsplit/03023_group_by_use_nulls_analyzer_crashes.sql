set allow_experimental_analyzer = 1, group_by_use_nulls = 1;
SELECT tuple(tuple(number)) as x FROM numbers(10) GROUP BY (number, tuple(number)) with cube order by x;
select tuple(array(number)) as x FROM numbers(10) GROUP BY number, array(number) WITH ROLLUP order by x;
SELECT toLowCardinality(materialize('a' AS key)),  'b' AS value GROUP BY key WITH CUBE SETTINGS group_by_use_nulls = 1;
SELECT  materialize('a'), 'a' AS key GROUP BY key WITH CUBE WITH TOTALS SETTINGS group_by_use_nulls = 1;
