--           mysqldump/import
--
-- This test consumes a significant amount of resources.
-- Therefore it should be kept separated from other tests.
-- Otherwise we might suffer from problems like
-- Bug#43801 mysql.test takes too long, fails due to expired timeout
--           on debx86-b in PB
--


--disable_warnings
DROP TABLE IF EXISTS t1;

-- Have to change the global variable as the session variable is
-- read-only.
SET @old_max_allowed_packet= @@global.max_allowed_packet;
SET @@global.max_allowed_packet = 2 * 1024 * 1024 + 1024;

-- Create a new connection since the global max_allowed_packet
-- has no effect for the current connection
connect (con1, localhost, root,,);

CREATE TABLE t1(data LONGBLOB);
INSERT INTO t1 SELECT REPEAT('1', 2*1024*1024);

let $outfile= $MYSQLTEST_VARDIR/tmp/bug41486.sql;
SET @old_general_log = @@global.general_log;
SET @@global.general_log = 0;
SET @@global.general_log = @old_general_log;
SELECT LENGTH(data) FROM t1;

DROP TABLE t1;

-- Cleanup
disconnect con1;
SET @@global.max_allowed_packet = @old_max_allowed_packet;
