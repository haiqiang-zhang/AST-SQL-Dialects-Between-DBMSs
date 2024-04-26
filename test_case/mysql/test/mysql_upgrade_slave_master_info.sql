 -- === Purpose ===
 --
 -- This test case will verify that the mysql_upgrade script
 -- corrects the order of the columns Channel_name and Tls_version
 -- in the table mysql.slave_master_info if their order was wrong.
 -- In case of mysql_upgrade happening from a release where the above
 -- two columns are not present in the table, the test case certifies
 -- that the upgrade script adds them in the correct order.
 --
 -- ==== Related Bugs and Worklogs ====
 --
 -- Bug #24384561: 5.7.14 COMPLAINS ABOUT WRONG
 --                SLAVE_MASTER_INFO AFTER UPGRADE FROM 5.7.13
 --
--source include/big_test.inc
--source include/not_valgrind.inc
--source include/mysql_upgrade_preparation.inc

USE test;

-- Preserve the original state of the table so that it can be restored at the end of the test.
ALTER TABLE mysql.slave_master_info TABLESPACE innodb_file_per_table;
CREATE TABLE test.slave_master_info_backup LIKE mysql.slave_master_info;
ALTER TABLE mysql.slave_master_info TABLESPACE mysql;
INSERT INTO test.slave_master_info_backup SELECT * FROM mysql.slave_master_info;

CREATE TABLE test.original
SELECT COLUMN_NAME, ORDINAL_POSITION
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_NAME = "slave_master_info"
  AND TABLE_SCHEMA = "mysql";

CREATE TABLE test.upgraded
SELECT COLUMN_NAME, ORDINAL_POSITION
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_NAME = "slave_master_info"
  AND TABLE_SCHEMA = "mysql";
DROP TABLE test.upgraded;

ALTER TABLE mysql.slave_master_info
  MODIFY COLUMN Channel_name char(64) NOT NULL COMMENT
  'The channel on which the slave is connected to a source. Used in Multisource Replication'
  AFTER Tls_version;
CREATE TABLE test.upgraded
SELECT COLUMN_NAME, ORDINAL_POSITION
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_NAME = "slave_master_info"
  AND TABLE_SCHEMA = "mysql";
DROP TABLE test.upgraded;

DROP table mysql.slave_master_info;

CREATE TABLE `mysql`.`slave_master_info` (
  `Number_of_lines` int(10) unsigned NOT NULL COMMENT 'Number of lines in the file.',
  `Master_log_name` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'The name of the master binary log currently being read from the master.',
  `Master_log_pos` bigint(20) unsigned NOT NULL COMMENT 'The master log position of the last read event.',
  `Host` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL DEFAULT '' COMMENT 'The host name of the source.',
  `User_name` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin COMMENT 'The user name used to connect to the master.',
  `User_password` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin COMMENT 'The password used to connect to the master.',
  `Port` int(10) unsigned NOT NULL COMMENT 'The network port used to connect to the master.',
  `Connect_retry` int(10) unsigned NOT NULL COMMENT 'The period (in seconds) that the slave will wait before trying to reconnect to the master.',
  `Enabled_ssl` tinyint(1) NOT NULL COMMENT 'Indicates whether the server supports SSL connections.',
  `Ssl_ca` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin COMMENT 'The file used for the Certificate Authority (CA) certificate.',
  `Ssl_capath` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin COMMENT 'The path to the Certificate Authority (CA) certificates.',
  `Ssl_cert` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin COMMENT 'The name of the SSL certificate file.',
  `Ssl_cipher` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin COMMENT 'The name of the cipher in use for the SSL connection.',
  `Ssl_key` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin COMMENT 'The name of the SSL key file.',
  `Ssl_verify_server_cert` tinyint(1) NOT NULL COMMENT 'Whether to verify the server certificate.',
  `Heartbeat` float NOT NULL,
  `Bind` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin COMMENT 'Displays which interface is employed when connecting to the MySQL server',
  `Ignored_server_ids` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin COMMENT 'The number of server IDs to be ignored, followed by the actual server IDs',
  `Uuid` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin COMMENT 'The master server uuid.',
  `Retry_count` bigint(20) unsigned NOT NULL COMMENT 'Number of reconnect attempts, to the master, before giving up.',
  `Ssl_crl` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin COMMENT 'The file used for the Certificate Revocation List (CRL)',
  `Ssl_crlpath` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin COMMENT 'The path used for Certificate Revocation List (CRL) files',
  `Enabled_auto_position` tinyint(1) NOT NULL COMMENT 'Indicates whether GTIDs will be used to retrieve events from the master.',
  PRIMARY KEY (`Host`,`Port`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 STATS_PERSISTENT=0 COMMENT='Master Information';
CREATE TABLE test.upgraded
SELECT COLUMN_NAME, ORDINAL_POSITION
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_NAME = "slave_master_info"
  AND TABLE_SCHEMA = "mysql";
DROP TABLE test.upgraded;

-- Cleanup:
TRUNCATE TABLE mysql.slave_master_info;
INSERT INTO mysql.slave_master_info SELECT * FROM test.slave_master_info_backup;

ALTER TABLE mysql.slave_master_info
  MODIFY Host VARCHAR(255) CHARACTER SET ASCII NULL COMMENT 'The host name of the source.',
  ALTER COLUMN Channel_name DROP DEFAULT;

DROP TABLE test.slave_master_info_backup;
DROP TABLE test.original;
