SELECT dictGet('db_01526.dict1', 'third_column', (number, number + 1)) FROM numbers(4);
SELECT dictHas('db_01526.dict1', (toUInt64(1), toUInt64(3)));
DROP DICTIONARY db_01526.dict1;
DROP TABLE db_01526.table_for_dict1;
DROP DATABASE db_01526;
