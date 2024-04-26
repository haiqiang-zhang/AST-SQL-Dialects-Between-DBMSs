
CREATE USER wl12475@localhost;

SELECT @@global.protocol_compression_algorithms;

-- check for invalid level
--exec $MYSQL --compression-algorithms="zstd" --zstd-compression-level=23 -e "select * from performance_schema.session_status where variable_name like 'COMPRESSION%' order by 1"

--echo -- check all possible client compression-algorithm/level for default server configuration
SET @@global.protocol_compression_algorithms=default;
select * from performance_schema.session_status where variable_name like 'COMPRESSION%' order by 1;
select * from performance_schema.session_status where variable_name like 'COMPRESSION%' order by 1;
select * from performance_schema.session_status where variable_name like 'COMPRESSION%' order by 1;
SET GLOBAL protocol_compression_algorithms="zstd";
select * from performance_schema.session_status where variable_name like 'COMPRESSION%' order by 1;
SET GLOBAL protocol_compression_algorithms="zstd,uncompressed";
select * from performance_schema.session_status where variable_name like 'COMPRESSION%' order by 1;
select * from performance_schema.session_status where variable_name like 'COMPRESSION%' order by 1;
SET GLOBAL protocol_compression_algorithms="zlib";
select * from performance_schema.session_status where variable_name like 'COMPRESSION%' order by 1;
SET GLOBAL protocol_compression_algorithms="zlib,uncompressed";
select * from performance_schema.session_status where variable_name like 'COMPRESSION%' order by 1;
select * from performance_schema.session_status where variable_name like 'COMPRESSION%' order by 1;
SET GLOBAL protocol_compression_algorithms="zlib,zstd";
select * from performance_schema.session_status where variable_name like 'COMPRESSION%' order by 1;
select * from performance_schema.session_status where variable_name like 'COMPRESSION%' order by 1;
SET GLOBAL protocol_compression_algorithms="uncompressed";
select * from performance_schema.session_status where variable_name like 'COMPRESSION%' order by 1;

SET @@global.protocol_compression_algorithms=default;
CREATE DATABASE wl12475;
USE wl12475;
CREATE TABLE t1(a LONGTEXT);
INSERT INTO t1 VALUES (REPEAT('1',200));
INSERT INTO t1 VALUES (REPEAT('2', 1800));
DROP TABLE t1;
SELECT COUNT(*) FROM wl12475.t1;
DROP TABLE wl12475.t1;
SELECT COUNT(*) FROM wl12475.t1;

-- check mysqladmin client
--exec $MYSQLADMIN -uroot -h localhost --password="" -S $MASTER_MYSOCK -P $MASTER_MYPORT --compression-algorithms="zstd" --zstd-compression-level=7  --skip-verbose ping 2>&1

-- check mysqlcheck client
--exec $MYSQL_CHECK --repair --compression-algorithms="zstd" --zstd-compression-level=7 --databases wl12475 > /dev/null 2>&1

-- check mysqlimport client
let $str = `SELECT REPEAT('X', 1024*64)`;
EOF
--exec $MYSQL_IMPORT -uroot --password="" --compression-algorithms="zstd" --zstd-compression-level=7 wl12475 $MYSQLTEST_VARDIR/tmp/t1.data
-- should output 3
SELECT COUNT(*) FROM wl12475.t1;

-- check mysqlshow client
--exec $MYSQL_SHOW  --compression-algorithms="zstd" --zstd-compression-level=7 wl12475

-- check mysqlslap client
--exec $MYSQL_SLAP --silent --delimiter=";
SELECT @@global.protocol_compression_algorithms;

DROP USER wl12475@localhost;
DROP DATABASE wl12475;

CREATE DATABASE wl13292;
CREATE TABLE wl13292.t1(a INT);
INSERT INTO wl13292.t1 VALUES (1);

DROP DATABASE wl13292;
