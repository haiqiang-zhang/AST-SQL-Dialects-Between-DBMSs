SELECT COUNT(*) FROM big_table_slow;
SELECT COUNT(*) FROM big_table_slow;
SELECT COUNT(*) FROM big_table_slow WHERE id>100 AND id<200;
SELECT * FROM big_table_slow WHERE id=2;
SELECT COUNT(*) FROM big_table_slow WHERE id>100;
SELECT COUNT(*) FROM big_table_slow WHERE id<100;
DROP TABLE big_table_slow;
