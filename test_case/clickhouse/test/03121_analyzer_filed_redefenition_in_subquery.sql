SET allow_experimental_analyzer=1;
drop table if exists test_subquery;
CREATE TABLE test_subquery
ENGINE = Memory AS
SELECT 'base' AS my_field;
SELECT my_field
FROM
(
    SELECT
        *,
        'redefined' AS my_field
	from test_subquery
);
SELECT my_field
FROM
(
    SELECT
        'redefined' AS my_field,
        *
	from test_subquery
);
