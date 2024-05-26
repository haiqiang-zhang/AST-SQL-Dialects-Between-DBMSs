SELECT count() FROM bloom_filter_not_has WHERE has(ary, 'a');
SELECT * FROM bloom_filter_not_has WHERE NOT has(ary, 'b') ORDER BY ary;
SELECT * FROM bloom_filter_not_has WHERE NOT has(ary, 'c') ORDER BY ary;
SELECT * FROM bloom_filter_not_has WHERE NOT has(ary, 'd') ORDER BY ary;
SELECT * FROM bloom_filter_not_has WHERE NOT has(ary, 'f') ORDER BY ary;
DROP TABLE IF EXISTS bloom_filter_not_has;
