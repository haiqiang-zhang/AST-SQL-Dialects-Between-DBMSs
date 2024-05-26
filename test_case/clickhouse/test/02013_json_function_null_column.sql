SELECT JSONExtract('{"string_value":null}', 'string_value', 'Nullable(String)') as x, toTypeName(x);
SELECT JSONExtractString('["a", "b", "c", "d", "e"]', idx) FROM (SELECT arrayJoin([2, NULL, 2147483646, 65535, 65535, 3]) AS idx);
SELECT JSONExtractInt('[1]', toNullable(1));
SELECT JSONExtractBool('[1]', toNullable(1));
SELECT JSONExtractFloat('[1]', toNullable(1));
SELECT JSONExtract('[1]', toNullable(1), 'Nullable(Int)');
