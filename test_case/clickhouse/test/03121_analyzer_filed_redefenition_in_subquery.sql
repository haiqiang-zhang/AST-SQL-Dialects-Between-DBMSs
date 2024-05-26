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
