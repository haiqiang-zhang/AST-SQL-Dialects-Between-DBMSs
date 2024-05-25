DROP TABLE IF EXISTS alter_attach;
CREATE TABLE alter_attach (x UInt64, p UInt8) ENGINE = MergeTree ORDER BY tuple() PARTITION BY p;
INSERT INTO alter_attach VALUES (1, 1), (2, 1), (3, 1);
ALTER TABLE alter_attach DETACH PARTITION 1;
ALTER TABLE alter_attach ADD COLUMN s String;
INSERT INTO alter_attach VALUES (4, 2, 'Hello'), (5, 2, 'World');
ALTER TABLE alter_attach ATTACH PARTITION 1;
SELECT * FROM alter_attach ORDER BY x;
ALTER TABLE alter_attach DETACH PARTITION 2;
ALTER TABLE alter_attach DROP COLUMN s;
INSERT INTO alter_attach VALUES (6, 3), (7, 3);
ALTER TABLE alter_attach ATTACH PARTITION 2;
SELECT * FROM alter_attach ORDER BY x;
ALTER TABLE alter_attach DETACH PARTITION ALL;
SELECT * FROM alter_attach ORDER BY x;
ALTER TABLE alter_attach ATTACH PARTITION 2;
SELECT * FROM alter_attach ORDER BY x;
DROP TABLE IF EXISTS detach_all_no_partition;
CREATE TABLE detach_all_no_partition (x UInt64, p UInt8) ENGINE = MergeTree ORDER BY tuple();
INSERT INTO detach_all_no_partition VALUES (1, 1), (2, 1), (3, 1);
SELECT * FROM detach_all_no_partition ORDER BY x;
ALTER TABLE detach_all_no_partition DETACH PARTITION ALL;
SELECT * FROM detach_all_no_partition ORDER BY x;
ALTER TABLE detach_all_no_partition ATTACH PARTITION tuple();
SELECT * FROM detach_all_no_partition ORDER BY x;
DROP TABLE alter_attach;
DROP TABLE detach_all_no_partition;
DROP TABLE IF EXISTS replicated_table_detach_all1;
DROP TABLE IF EXISTS replicated_table_detach_all2;
DROP TABLE IF EXISTS partition_all;
DROP TABLE IF EXISTS partition_all2;
CREATE TABLE partition_all (x UInt64, p UInt8, q UInt8) ENGINE = MergeTree ORDER BY tuple() PARTITION BY p;
INSERT INTO partition_all VALUES (4, 1, 2), (5, 1, 3), (3, 1, 4);
CREATE TABLE partition_all2 (x UInt64, p UInt8, q UInt8) ENGINE = MergeTree ORDER BY tuple() PARTITION BY p;
INSERT INTO partition_all2 VALUES (4, 1, 2), (5, 1, 3), (3, 1, 4);
DROP TABLE partition_all;
DROP TABLE partition_all2;
CREATE TABLE partition_attach_all (x UInt64, p UInt8) ENGINE = MergeTree ORDER BY x PARTITION BY p;
INSERT INTO partition_attach_all VALUES (1, 1), (2, 2), (3, 3);
ALTER TABLE partition_attach_all DETACH PARTITION ALL;
SELECT * FROM partition_attach_all ORDER BY x;
ALTER TABLE partition_attach_all ATTACH PARTITION ALL;
SELECT * FROM partition_attach_all ORDER BY x;
ALTER TABLE partition_attach_all DETACH PARTITION 1;
SELECT * FROM partition_attach_all ORDER BY x;
ALTER TABLE partition_attach_all ATTACH PARTITION ALL;
SELECT * FROM partition_attach_all ORDER BY x;
ALTER TABLE partition_attach_all DROP PARTITION ALL;
SELECT * FROM partition_attach_all ORDER BY x;
ALTER TABLE partition_attach_all ATTACH PARTITION ALL;
SELECT * FROM partition_attach_all ORDER BY x;
DROP TABLE partition_attach_all;
