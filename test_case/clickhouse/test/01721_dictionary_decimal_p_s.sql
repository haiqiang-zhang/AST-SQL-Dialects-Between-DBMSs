select '-------- 42 --------';
SELECT * from db_01721.table_decimal_dict where KeyField = 42;
SELECT * from db_01721.decimal_dict	where KeyField = 42;
SELECT dictGet('db_01721.decimal_dict', 'Decimal32_', toUInt64(42)),
       dictGet('db_01721.decimal_dict', 'Decimal64_', toUInt64(42)),
       dictGet('db_01721.decimal_dict', 'Decimal128_', toUInt64(42))
       -- ,dictGet('db_01721.decimal_dict', 'Decimal256_', toUInt64(42));
select '-------- 4999 --------';
SELECT * from db_01721.table_decimal_dict where KeyField = 4999;
SELECT * from db_01721.decimal_dict	where KeyField = 4999;
select '-------- 5000 --------';
SELECT * from db_01721.table_decimal_dict where KeyField = 5000;
SELECT * from db_01721.decimal_dict	where KeyField = 5000;
drop table if exists table_decimal_dict;
drop dictionary if exists cache_dict;
drop database if exists db_01721;
