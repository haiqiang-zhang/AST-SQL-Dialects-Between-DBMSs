SET max_ast_depth = 10_000_000;
SELECT
    val,
    val + 1 as prev,
    val + prev as val2
FROM ( SELECT 1 as val );
