SET cast_keep_nullable = 0;
SELECT CAST(CAST(NULL AS Nullable(String)) AS Nullable(Enum8('Hello' = 1)));
