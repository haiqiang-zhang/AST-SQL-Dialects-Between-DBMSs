SELECT count() FROM big_array ARRAY JOIN x;
SELECT countIf(has(x, 10)), sum(y) FROM big_array ARRAY JOIN x AS y;
SELECT countIf(has(x, 10)) FROM big_array ARRAY JOIN x AS y;
DROP TABLE big_array;
