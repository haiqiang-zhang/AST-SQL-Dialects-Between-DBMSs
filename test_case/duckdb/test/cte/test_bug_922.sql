WITH my_list(value) AS (VALUES (1), (2), (3))
    SELECT * FROM my_list LIMIT 0 OFFSET 1;
