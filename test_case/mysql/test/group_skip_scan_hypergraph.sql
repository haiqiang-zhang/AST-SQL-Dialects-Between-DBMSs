
-- The include statement below is a temp one for tests that are yet to
-- be ported to run with InnoDB,
-- but needs to be kept for tests that would need MyISAM in future.
--source include/force_myisam_default.inc
--source include/have_myisam.inc
--source include/group_skip_scan_test.inc

CREATE TABLE t(a INT, b INT, c INT, KEY k1 (a,b));
INSERT INTO t(a,b) VALUES (1,1),(1,2),(1,3),(2,1),(2,2),(2,2),(2,2),(2,3),(2,3),(2,4);

DROP TABLE t;
