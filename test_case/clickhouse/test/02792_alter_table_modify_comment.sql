SELECT comment FROM system.tables WHERE database = currentDatabase() AND table = 't';
ALTER TABLE t MODIFY COMMENT 'World';
SELECT comment FROM system.tables WHERE database = currentDatabase() AND table = 't';
DROP TABLE t;
CREATE TABLE t (x UInt8) ENGINE = MergeTree ORDER BY () COMMENT 'Hello';
SELECT comment FROM system.tables WHERE database = currentDatabase() AND table = 't';
ALTER TABLE t MODIFY COMMENT 'World';
SELECT comment FROM system.tables WHERE database = currentDatabase() AND table = 't';
DROP TABLE t;
# The case when there are many operations in one ALTER

CREATE TABLE t (x UInt8) ENGINE = MergeTree ORDER BY () COMMENT 'Hello';
SELECT comment FROM system.tables WHERE database = currentDatabase() AND table = 't';
ALTER TABLE t MODIFY COMMENT 'World', MODIFY COLUMN x UInt16;
SELECT comment FROM system.tables WHERE database = currentDatabase() AND table = 't';
DROP TABLE t;
SELECT comment FROM system.tables WHERE database = currentDatabase() AND table = 't';
SELECT comment FROM system.tables WHERE database = currentDatabase() AND table = 't';
SELECT comment FROM system.tables WHERE database = currentDatabase() AND table = 't';
SELECT comment FROM system.tables WHERE database = currentDatabase() AND table = 't';
# The cases when there is no comment on creation

CREATE TABLE t (x UInt8) ENGINE = Memory;
SELECT comment FROM system.tables WHERE database = currentDatabase() AND table = 't';
ALTER TABLE t MODIFY COMMENT 'World';
SELECT comment FROM system.tables WHERE database = currentDatabase() AND table = 't';
DROP TABLE t;
CREATE TABLE t (x UInt8) ENGINE = MergeTree ORDER BY ();
SELECT comment FROM system.tables WHERE database = currentDatabase() AND table = 't';
ALTER TABLE t MODIFY COMMENT 'World';
SELECT comment FROM system.tables WHERE database = currentDatabase() AND table = 't';
DROP TABLE t;
CREATE TABLE t (x UInt8) ENGINE = MergeTree ORDER BY ();
SELECT comment FROM system.tables WHERE database = currentDatabase() AND table = 't';
ALTER TABLE t MODIFY COMMENT 'World', MODIFY COLUMN x UInt16;
SELECT comment FROM system.tables WHERE database = currentDatabase() AND table = 't';
DROP TABLE t;
SELECT comment FROM system.tables WHERE database = currentDatabase() AND table = 't';
SELECT comment FROM system.tables WHERE database = currentDatabase() AND table = 't';
SELECT comment FROM system.tables WHERE database = currentDatabase() AND table = 't';
SELECT comment FROM system.tables WHERE database = currentDatabase() AND table = 't';
