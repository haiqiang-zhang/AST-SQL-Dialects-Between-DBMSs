DROP TABLE IF EXISTS nullable_00431;
CREATE VIEW nullable_00431
AS SELECT
    1 AS constant_true,
    0 AS constant_false,
    NULL AS constant_null,
    number % 3 = 1 AS cond_non_constant,
    number % 3 = 2 ? NULL : (number % 3 = 1) AS cond_non_constant_nullable,
    'Hello' AS then_constant,
    'World' AS else_constant,
    toString(number) AS then_non_constant,
    toString(-number) AS else_non_constant,
    nullIf(toString(number), '5') AS then_non_constant_nullable,
    nullIf(toString(-number), '-5') AS else_non_constant_nullable
FROM system.numbers LIMIT 10;
