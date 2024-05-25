OPTIMIZE TABLE table_with_column_ttl FINAL;
SELECT UserID, Age FROM table_with_column_ttl ORDER BY UserID;
ALTER TABLE table_with_column_ttl MODIFY COLUMN Age REMOVE TTL;
SHOW CREATE TABLE table_with_column_ttl;
INSERT INTO table_with_column_ttl VALUES (now() - INTERVAL 10 MONTH, 3, 27);
OPTIMIZE TABLE table_with_column_ttl FINAL;
SELECT UserID, Age FROM table_with_column_ttl ORDER BY UserID;
DROP TABLE table_with_column_ttl;
