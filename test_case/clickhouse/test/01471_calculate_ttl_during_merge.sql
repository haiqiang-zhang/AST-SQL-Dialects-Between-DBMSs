SELECT count() FROM table_for_ttl;
ALTER TABLE table_for_ttl MODIFY TTL d + INTERVAL 1 YEAR SETTINGS materialize_ttl_after_modify = 0;
SELECT count() FROM table_for_ttl;
OPTIMIZE TABLE table_for_ttl FINAL;
SELECT count() FROM table_for_ttl;
ALTER TABLE table_for_ttl MODIFY COLUMN value String TTL d + INTERVAL 1 DAY SETTINGS materialize_ttl_after_modify = 0;
SELECT count(distinct value) FROM table_for_ttl;
OPTIMIZE TABLE table_for_ttl FINAL;
SELECT count(distinct value) FROM table_for_ttl;
OPTIMIZE TABLE table_for_ttl FINAL;
DROP TABLE IF EXISTS table_for_ttl;
