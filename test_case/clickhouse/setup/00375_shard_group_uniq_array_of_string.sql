DROP TABLE IF EXISTS group_uniq_str;
CREATE TABLE group_uniq_str ENGINE = Memory AS SELECT number % 10 as id, toString(intDiv((number%10000), 10)) as v FROM system.numbers LIMIT 10000000;
INSERT INTO group_uniq_str SELECT 2 as id, toString(number % 100) as v FROM system.numbers LIMIT 1000000;
INSERT INTO group_uniq_str SELECT 5 as id, toString(number % 100) as v FROM system.numbers LIMIT 10000000;
