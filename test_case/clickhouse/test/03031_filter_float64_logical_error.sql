SELECT
    count('9223372036854775806'),
    7
FROM 03031_test
PREWHERE (id = NULL) AND 1024
WHERE 0.0001
GROUP BY '0.03'
    WITH ROLLUP
SETTINGS force_primary_key = 1, force_data_skipping_indices = 'value_1_idx, value_2_idx', allow_experimental_analyzer=0;
