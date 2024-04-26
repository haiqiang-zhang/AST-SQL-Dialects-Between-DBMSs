
SET SESSION debug= '+d,skip_dd_table_access_check';
CREATE TABLE t1(a int,KEY(a));

-- Select from I_S.tables should create entry in mysql.table_stats
SELECT TABLE_NAME, ENGINE, ROW_FORMAT, TABLE_ROWS, AVG_ROW_LENGTH, DATA_LENGTH,
  MAX_DATA_LENGTH, INDEX_LENGTH, DATA_FREE, AUTO_INCREMENT from
  information_schema.tables WHERE table_name='t1';
SELECT table_name, table_rows, avg_row_length, data_length, max_data_length,
  index_length, data_free, auto_increment from mysql.table_stats where table_name='t1';


-- Select from I_S.statistics should create entry in mysql.index_stats
SELECT TABLE_NAME,COLUMN_NAME, INDEX_NAME, CARDINALITY from
  information_schema.statistics where table_name='t1' ORDER BY COLUMN_NAME;
SELECT table_name, column_name, index_name, cardinality from mysql.index_stats
  where table_name='t1' ORDER bY column_name;

SET SESSION information_schema_stats_expiry=1;
INSERT INTO t1 VALUES(3);
SELECT SLEEP(2);

-- Select from I_S.tables should update entry in mysql.table_stats
SELECT TABLE_NAME, ENGINE, ROW_FORMAT, TABLE_ROWS, AVG_ROW_LENGTH, DATA_LENGTH,
  MAX_DATA_LENGTH, INDEX_LENGTH, DATA_FREE, AUTO_INCREMENT from
  information_schema.tables WHERE table_name='t1';
SELECT table_name, table_rows, avg_row_length, data_length, max_data_length,
  index_length, data_free, auto_increment from mysql.table_stats where table_name='t1';

-- Select from I_S.statistics should update entry in mysql.index_stats
SELECT TABLE_NAME,COLUMN_NAME, INDEX_NAME, CARDINALITY from
  information_schema.statistics where table_name='t1' ORDER BY COLUMN_NAME;
SELECT table_name, column_name, index_name, cardinality from mysql.index_stats
  where table_name='t1' ORDER BY column_name;

DELETE FROM mysql.table_stats;
DELETE FROM mysql.index_stats;
DROP TABLE t1;

CREATE TABLE t2(a int,KEY(a));
CREATE TABLE t3(b int, KEY(b));


-- Test with information_schema_stats_expiry=0
SET SESSION information_schema_stats_expiry=0;
SELECT TABLE_NAME, ENGINE, ROW_FORMAT, TABLE_ROWS, AVG_ROW_LENGTH, DATA_LENGTH,
  MAX_DATA_LENGTH, INDEX_LENGTH, DATA_FREE, AUTO_INCREMENT from
  information_schema.tables WHERE table_name='t2';
SELECT table_name, table_rows, avg_row_length, data_length, max_data_length,
  index_length, data_free, auto_increment from mysql.table_stats where table_name='t2';
SET SESSION information_schema_stats_expiry=default;

-- Tests with User Transaction ON AND COMMIT/ROLLBACK

-- Rollback
START TRANSACTION;
INSERT INTO t2 VALUES(1);
SELECT TABLE_NAME, ENGINE, ROW_FORMAT, TABLE_ROWS, AVG_ROW_LENGTH, DATA_LENGTH,
  MAX_DATA_LENGTH, INDEX_LENGTH, DATA_FREE, AUTO_INCREMENT from
  information_schema.tables WHERE table_name='t2';

-- Select should write to mysql.table_stats but not commit change to t2
SELECT * FROM t2;
SELECT table_name, table_rows, avg_row_length, data_length, max_data_length,
  index_length, data_free, auto_increment from mysql.table_stats where table_name='t2';

-- Commit
START TRANSACTION;
INSERT INTO t3 VALUES(1);
SELECT TABLE_NAME, ENGINE, ROW_FORMAT, TABLE_ROWS, AVG_ROW_LENGTH, DATA_LENGTH,
  MAX_DATA_LENGTH, INDEX_LENGTH, DATA_FREE, AUTO_INCREMENT from
  information_schema.tables WHERE table_name='t2';

-- Select should write to mysql.table_stats and t3
SELECT * FROM t3;
SELECT TABLE_NAME, ENGINE, ROW_FORMAT, TABLE_ROWS, AVG_ROW_LENGTH, DATA_LENGTH,
  MAX_DATA_LENGTH, INDEX_LENGTH, DATA_FREE, AUTO_INCREMENT from
  information_schema.tables WHERE table_name='t3';

DELETE FROM mysql.table_stats;
DELETE FROM mysql.index_stats;
DROP TABLE t2,t3;
SET SESSION information_schema_stats_expiry= default;
--         statistics cache.
-- Case 2: Make sure I_S query under AUTOCOMMIT=0 doesn't write to
--         statistics cache.

CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES
  (0),(1),(2),(3),(4),(5),(6),(7),(8),(9),
  (10),(11),(12),(13),(14),(15),(16),(17),(18),(19);
SELECT table_rows FROM information_schema.tables WHERE table_name = "t1";
SELECT schema_name, table_name, table_rows
  FROM mysql.table_stats WHERE table_name="t1";
SET AUTOCOMMIT=0;
INSERT INTO t1 VALUES
  (0),(1),(2),(3),(4),(5),(6),(7),(8),(9),
  (10),(11),(12),(13),(14),(15),(16),(17),(18),(19);
SELECT table_rows FROM information_schema.tables WHERE table_name = "t1";
SET AUTOCOMMIT=1;
SELECT schema_name, table_name, table_rows
  FROM mysql.table_stats WHERE table_name="t1";
SELECT table_rows FROM information_schema.tables WHERE table_name = "t1";
SELECT schema_name, table_name, table_rows
  FROM mysql.table_stats WHERE table_name="t1";

DROP table t1;
set global debug=RESET;
