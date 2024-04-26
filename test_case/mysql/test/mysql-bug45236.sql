--           on debx86-b in PB
--


--disable_warnings
DROP TABLE IF EXISTS t1;

-- Have to change the global variable as the session variable is
-- read-only.
SET @old_max_allowed_packet= @@global.max_allowed_packet;
SET @@global.max_allowed_packet = 1024 * 1024 + 1024;

-- Create a new connection since the global max_allowed_packet
-- has no effect onr the current one
connect (con1, localhost, root,,);

CREATE TABLE t1(data LONGBLOB);
INSERT INTO t1 SELECT CONCAT(REPEAT('1', 1024*1024 - 27), 
                             "\'\r dummydb dummyhost");

let $outfile= $MYSQLTEST_VARDIR/tmp/bug41486.sql;

DROP TABLE t1;

-- Cleanup
disconnect con1;
SET @@global.max_allowed_packet = @old_max_allowed_packet;
