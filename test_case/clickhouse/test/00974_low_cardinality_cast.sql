SET cast_keep_nullable = 0;
SELECT CAST('Hello' AS LowCardinality(Nullable(String)));
SELECT CAST(Null AS LowCardinality(Nullable(String)));
SELECT CAST(CAST('Hello' AS LowCardinality(Nullable(String))) AS String);
SELECT CAST(CAST('Hello' AS Nullable(String)) AS String);
