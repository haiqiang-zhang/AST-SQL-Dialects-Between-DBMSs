SYSTEM STOP MERGES ttl_table;
INSERT INTO ttl_table VALUES(toDate('2020-10-01'), 144);
SELECT * FROM ttl_table;
SYSTEM START MERGES ttl_table;
OPTIMIZE TABLE ttl_table FINAL;
SELECT * FROM ttl_table;
OPTIMIZE TABLE ttl_table FINAL;
SELECT * FROM ttl_table;
DROP TABLE IF EXISTS ttl_table;
