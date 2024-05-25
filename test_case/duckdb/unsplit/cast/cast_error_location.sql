PRAGMA enable_verification;
CREATE TABLE cast_table(i INTEGER, s VARCHAR, d DECIMAL(5,1), l INT[], int_struct ROW(i INTEGER), dbl DOUBLE, hge HUGEINT, invalid_blob_str VARCHAR);
INSERT INTO cast_table VALUES (1000, 'hello', 1000.0, [1000], {'i': 1000}, 1e308, 1000000000000000000000000000000, '\x');
