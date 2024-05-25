SET allow_experimental_analyzer=1;
SELECT concatWithSeparator('a', 'b') GROUP BY 'a';
SELECT concatWithSeparator('|', 'a', concatWithSeparator('|', CAST('a', 'LowCardinality(String)'))) GROUP BY 'a';
SELECT concatWithSeparator('|', 'a', concatWithSeparator('|', CAST('x', 'LowCardinality(String)'))) GROUP BY 'a';
select dumpColumnStructure('x') GROUP BY 'x';
select dumpColumnStructure('x');
SELECT cityHash64('limit', _CAST(materialize('World'), 'LowCardinality(String)')) FROM system.one GROUP BY GROUPING SETS ('limit');
