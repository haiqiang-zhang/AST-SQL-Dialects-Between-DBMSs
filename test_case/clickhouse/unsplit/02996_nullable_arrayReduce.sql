-- { echoOn }
SELECT arrayReduce('sum', []::Array(UInt8)) as a, toTypeName(a);
SELECT arrayReduce('sumOrNull', []::Array(UInt8)) as a, toTypeName(a);
SELECT arrayReduce('sum', [NULL]::Array(Nullable(UInt8))) as a, toTypeName(a);
SELECT arrayReduce('sum', [NULL, 10]::Array(Nullable(UInt8))) as a, toTypeName(a);
SELECT arrayReduce('any_respect_nulls', [NULL, 10]::Array(Nullable(UInt8))) as a, toTypeName(a);
SELECT arrayReduce('any_respect_nulls', [10, NULL]::Array(Nullable(UInt8))) as a, toTypeName(a);
SELECT arrayReduce('median', [toLowCardinality(toNullable(8))]) as t, toTypeName(t);
