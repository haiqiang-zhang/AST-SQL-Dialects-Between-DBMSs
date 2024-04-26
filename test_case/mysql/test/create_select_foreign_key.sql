--    with request to create FK.
--
-- R2 The behavior of atomic CTAS and request to create FK is rejected if
--    following conditions are true,
--    - SE supports foreign keys.
--    - SE supports atomic DDL.
--    - The binlogging is enabled.
--    - The binlog format is 'row'.
--
-- ==== Implementation ====
--
-- TC1 The behavior of non-atomic CTAS remains the same
--     with request to create FK.
-- 1) Allow creation of FK on table using MyISAM engine. Using rows which
--    violate FK constraint. Make sure that the FK constraint is ignored.
-- 2) Allow creation of FK on table using MyISAM engine. Using rows which
--    do not violate FK constraint.
--
-- TC2 The behavior of atomic CTAS, with sql_log_bin OFF.
-- 1) Attempt to create FK on table using InnoDB engine. Using rows which
--    violate FK constraint. Make sure we get ER_NO_REFERENCED_ROW_2.
-- 2) Allow creation of FK on table using InnoDB engine. Using rows which
--    do not violate FK constraint.
--
-- TC3 The behavior of CTAS, with sql_log_bin ON and format STATEMENT.
-- 1) Attempt to create FK on table using InnoDB engine. Using rows which
--    violate FK constraint. Make sure we get ER_NO_REFERENCED_ROW_2.
-- 2) Allow creation of FK on table using InnoDB engine. Using rows which
--    do not violate FK constraint.
--
-- TC4 The behavior of CTAS, with sql_log_bin ON and format MIXED.
-- 1) Steps are same as TC3 and the behavior too would be same.
--
-- TC5 The behavior of CTAS, with sql_log_bin ON and format ROW.
-- 1) Attempt to create FK on table using InnoDB engine and using rows which
--    violate FK constraint results in
--    ER_FOREIGN_KEY_WITH_ATOMIC_CREATE_SELECT.
-- 2) Attempt to create FK on table using InnoDB engine and using rows which
--    do not violate FK constraint results in
--    ER_FOREIGN_KEY_WITH_ATOMIC_CREATE_SELECT.
-- 3) Attempt to create FK on table using InnoDB engine with CREATE TABLE ...
--    START TRANSACTION is rejected with
--    ER_FOREIGN_KEY_WITH_ATOMIC_CREATE_SELECT.
--
-- ==== References ====
--
-- WL#13355 Make CREATE TABLE...SELECT atomic and crash-safe
--

-- Skip ps protocol because CREATE TABLE ... START TRANSACTION is not
-- allowed to be run with ps protocol.
--source include/no_ps_protocol.inc
--source include/have_log_bin.inc

SET @saved_sql_log_bin = @@SESSION.sql_log_bin;

CREATE TABLE t0 (f1 INT PRIMARY KEY);
INSERT INTO t0 VALUES (1),(2),(3),(4);
CREATE TABLE myisam_table1 (m INT, n INT, FOREIGN KEY (n) REFERENCES t0(f1))
  ENGINE=MyISAM AS SELECT 101 as m, 5 as n;
CREATE TABLE myisam_table2 (m INT, n INT, FOREIGN KEY (n) REFERENCES t0(f1))
  ENGINE=MyISAM AS SELECT 101 as m, 2 as n;

DROP TABLE myisam_table1;
DROP TABLE myisam_table2;

SET sql_log_bin = OFF;
CREATE TABLE innodb_table1 (m INT, n INT, FOREIGN KEY (n) REFERENCES t0(f1))
  AS SELECT 101 as m, 5 as n;
CREATE TABLE innodb_table1 (m INT, n INT, FOREIGN KEY (n) REFERENCES t0(f1))
  AS SELECT 101 as m, 2 as n;
CREATE TABLE innodb_table2 as SELECT m, 4 FROM innodb_table1;
DROP TABLE innodb_table1;
DROP TABLE innodb_table2;

SET sql_log_bin = ON;
SET @@SESSION.binlog_format=STATEMENT;
CREATE TABLE innodb_table1 (m INT, n INT, FOREIGN KEY (n) REFERENCES t0(f1))
  AS SELECT 101 as m, 5 as n;

CREATE TABLE innodb_table1 (m INT, n INT, FOREIGN KEY (n) REFERENCES t0(f1))
  AS SELECT 101 as m, 2 as n;
DROP TABLE innodb_table1;

SET @@SESSION.binlog_format=MIXED;
CREATE TABLE innodb_table1 (m INT, n INT, FOREIGN KEY (n) REFERENCES t0(f1))
  AS SELECT 101 as m, 5 as n;

CREATE TABLE innodb_table1 (m INT, n INT, FOREIGN KEY (n) REFERENCES t0(f1))
  AS SELECT 101 as m, 2 as n;
DROP TABLE innodb_table1;

SET @@SESSION.binlog_format=ROW;
CREATE TABLE innodb_table1 (m INT, n INT, FOREIGN KEY (n) REFERENCES t0(f1))
  AS SELECT 101 as m, 5 as n;
CREATE TABLE innodb_table1 (m INT, n INT, FOREIGN KEY (n) REFERENCES t0(f1))
  AS SELECT 101 as m, 2 as n;
CREATE TABLE innodb_table1 (m INT, n INT,
  FOREIGN KEY (n) REFERENCES t0(f1)) START TRANSACTION;

SET sql_log_bin = @saved_sql_log_bin;
DROP TABLE t0;
