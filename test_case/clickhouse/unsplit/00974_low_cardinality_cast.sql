SET cast_keep_nullable = 0;
SELECT CAST('Hello' AS LowCardinality(Nullable(String)));
