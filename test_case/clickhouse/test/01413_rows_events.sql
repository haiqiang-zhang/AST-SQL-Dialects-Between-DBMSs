SYSTEM FLUSH LOGS;
INSERT INTO /* test 01413, query 2 */ rows_events_test VALUES (2,2), (3,3);
SYSTEM FLUSH LOGS;
SELECT * FROM /* test 01413, query 3 */ rows_events_test WHERE v = 2;
SYSTEM FLUSH LOGS;
DROP TABLE rows_events_test;
