--                                                                   #
-- Aim of the test is to test compression between the mysql client   #
-- and server using the zstd library. It does the following :-       #
--  - Loads table with appropriate data.                             #
--  - Recieves it through the client using different compression     #
--    levels.                                                        #
--  - Compares the number of bytes sent from the server for each     #
--    instance.                                                      #
-- Creation Date: 2019-05-29                                         #
-- Author: Srikanth B R                                              #
--                                                                   #
--####################################################################

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

-- Create and populate the table to be used
CREATE TABLE t1 (
 id int,
 c2 int,
 c3 varchar(20),
 c4 varchar(20),
 c5 int,
 c6 int,
 c7 varchar(20),
 c8 varchar(20),
 c9 varchar(20),
 c10 int,
 c11 double,
 c12 varchar(20),
 c13 varchar(20),
 c14 double,
 c15 varchar(20),
 c16 int,
 c17 varchar(20)
) ENGINE = InnoDB;

-- Test without compression
SHOW STATUS LIKE 'Compression%';
SELECT * FROM t1;


SET GLOBAL protocol_compression_algorithms="zstd";
SELECT * FROM t1;

-- Validate size of data transferred between the highest compression level offered by zstd and uncompressed data.
--let $assert_cond = $size_compressed_level22 < $size_uncompressed
--let $assert_text = Size of data transferred with default zstd level 22 compression should be less than the uncompressed data.
--source include/assert.inc

SET @@global.protocol_compression_algorithms=default;

DROP TABLE t1;
