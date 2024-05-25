SELECT * FROM partition_and_primary_keys_using_same_expression ORDER BY dt;
SELECT '---';
ALTER TABLE partition_and_primary_keys_using_same_expression DROP PARTITION '2018-02-20';
SELECT * FROM partition_and_primary_keys_using_same_expression ORDER BY dt;
DROP TABLE partition_and_primary_keys_using_same_expression;
