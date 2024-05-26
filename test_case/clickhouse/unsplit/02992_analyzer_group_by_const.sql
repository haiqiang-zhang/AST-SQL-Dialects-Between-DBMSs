SET allow_experimental_analyzer=1;
SELECT concatWithSeparator('a', 'b') GROUP BY 'a';
select dumpColumnStructure('x') GROUP BY 'x';
SELECT cityHash64('limit', _CAST(materialize('World'), 'LowCardinality(String)')) FROM system.one GROUP BY GROUPING SETS ('limit');
