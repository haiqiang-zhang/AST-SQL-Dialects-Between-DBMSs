
let $MYSQLD_DATADIR= `SELECT @@datadir`;
CREATE TABLE t1 (
  id bigint NOT NULL AUTO_INCREMENT,
  time date,
  id2 bigint not null,
  PRIMARY KEY (id,time)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb3
/*!50100 PARTITION BY RANGE(TO_DAYS(time))
(PARTITION p10 VALUES LESS THAN (734708) ENGINE = InnoDB,
 PARTITION p20 VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */;

INSERT INTO t1 (time,id2) VALUES ('2011-07-24',1);
INSERT INTO t1 (time,id2) VALUES ('2011-07-25',1);
INSERT INTO t1 (time,id2) VALUES ('2011-07-25',1);
CREATE UNIQUE INDEX uk_time_id2 on t1(time,id2);

SELECT COUNT(*) FROM t1;

DROP TABLE t1;

CREATE TABLE t1 (id INT NOT NULL
PRIMARY KEY,
user_num CHAR(10)
) ENGINE = InnoDB
KEY_BLOCK_SIZE=4
PARTITION BY HASH(id) PARTITIONS 1;

SET GLOBAL innodb_file_per_table = OFF;
ALTER TABLE t1 ADD PARTITION PARTITIONS 1;
SET innodb_strict_mode = OFF;

ALTER TABLE t1 ADD PARTITION PARTITIONS 2;

-- really bug#56172
ALTER TABLE t1 REBUILD PARTITION p0;
DROP TABLE t1;
SET GLOBAL innodb_file_per_table = default;

--
-- Bug#32430 - show engine innodb status causes errors
-- This test is not stable, also the tested function explain_filename()
-- is tested in an own unit test instead.
if (0)
{
SET NAMES utf8mb3;
CREATE TABLE `t``\""e` (a INT, PRIMARY KEY (a))
ENGINE=InnoDB
PARTITION BY RANGE (a)
SUBPARTITION BY HASH (a)
(PARTITION `p0``\""e` VALUES LESS THAN (100)
 (SUBPARTITION `sp0``\""e`,
  SUBPARTITION `sp1``\""e`),
 PARTITION `p1``\""e` VALUES LESS THAN (MAXVALUE)
 (SUBPARTITION `sp2``\""e`,
  SUBPARTITION `sp3``\""e`));
INSERT INTO `t``\""e` VALUES (0), (2), (6), (10), (14), (18), (22);
SET NAMES utf8mb3;
UPDATE `t``\""e` SET a = 16 WHERE a = 0;
UPDATE `t``\""e` SET a = 8 WHERE a = 22;
let $id_1= `SELECT CONNECTION_ID()`;
UPDATE `t``\""e` SET a = 12 WHERE a = 0;
let $wait_timeout= 2;
let $wait_condition= SELECT 1 FROM INFORMATION_SCHEMA.PROCESSLIST
WHERE ID = $id_1 AND STATE = 'Searching rows for update';
SELECT lock_table, COUNT(*) FROM INFORMATION_SCHEMA.INNODB_LOCKS
GROUP BY lock_table;
set @old_sql_mode = @@sql_mode;
set sql_mode = 'ANSI_QUOTES';
SELECT lock_table, COUNT(*) FROM INFORMATION_SCHEMA.INNODB_LOCKS
GROUP BY lock_table;
set @@sql_mode = @old_sql_mode;
UPDATE `t``\""e` SET a = 4 WHERE a = 22;
set @old_sql_mode = @@sql_mode;
set sql_mode = 'ANSI_QUOTES';
set @@sql_mode = @old_sql_mode;
DROP TABLE `t``\""e`;
SET NAMES DEFAULT;
