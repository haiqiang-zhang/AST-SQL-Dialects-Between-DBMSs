CREATE TABLE t1(a INT) ENGINE=ARCHIVE;
INSERT INTO t1 VALUES(1);
SET SESSION debug='d,simulate_archive_open_failure';
SET SESSION debug=DEFAULT;
DROP TABLE t1;
