
-- This test case verifies that the mysqlbinlog --base64-output=X flags
-- work as expected, and that BINLOG statements with row events fail if
-- they are not preceded by BINLOG statements with Format description
-- events.
--
-- See also BUG#32407.

--source include/force_myisam_default.inc
--source include/have_myisam.inc


disable_warnings;
DROP TABLE IF EXISTS t1;

-- Test to show BUG#32407.  This reads a binlog created with the
-- mysql-5.1-telco-6.1 tree, specifically at the tag
-- mysql-5.1.15-ndb-6.1.23, and applies it to the database.  The test
-- should fail before BUG#32407 was fixed and succeed afterwards.
--echo ==== Test BUG--32407 ====

-- The binlog contains row events equivalent to:
-- CREATE TABLE t1 (a int) engine = myisam
-- INSERT INTO t1 VALUES (1), (1)
exec $MYSQL_BINLOG suite/binlog/std_data/bug32407.001 | $MYSQL;
select * from t1;


-- Test that a BINLOG statement encoding a row event fails unless a
-- Format_description_event as been supplied with an earlier BINLOG
-- statement.
--echo ==== Test BINLOG statement w/o FD event ====

-- This is a binlog statement consisting of one Table_map_log_event and
-- one Write_rows_log_event.  Together, they correspond to the
-- following query:
-- INSERT INTO TABLE test.t1 VALUES (2)

error ER_NO_FORMAT_DESCRIPTION_EVENT_BEFORE_BINLOG_STATEMENT;
select * from t1;


-- Test that it works to read a Format_description_log_event with a
-- BINLOG statement, followed by a row-event in base64 from the same
-- version.
--echo ==== Test BINLOG statement with FD event ====

-- This is a binlog statement containing a Format_description_log_event
-- from the same version as the Table_map and Write_rows_log_event.
BINLOG '
ODdYRw8BAAAAZgAAAGoAAAABAAQANS4xLjIzLXJjLWRlYnVnLWxvZwAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAA4N1hHEzgNAAgAEgAEBAQEEgAAUwAEGggAAAAICAgC
';

-- This is a Table_map_log_event+Write_rows_log_event corresponding to:
-- INSERT INTO TABLE test.t1 VALUES (3)
BINLOG '
TFtYRxMBAAAAKQAAAH8BAAAAABAAAAAAAAAABHRlc3QAAnQxAAEDAAE=
TFtYRxcBAAAAIgAAAKEBAAAQABAAAAAAAAEAAf/+AwAAAA==
';
select * from t1;


-- Test that mysqlbinlog stops with an error message when the
-- --base64-output=never flag is used on a binlog with base64 events.
--echo ==== Test --base64-output=never on a binlog with row events ====

-- mysqlbinlog should fail
--replace_regex /--[0-9][0-9][0-9][0-9][0-9][0-9] .*/<#>/   /SET \@\@session.pseudo_thread_id.*/<#>/
error 1;


-- Test that the following fails cleanly: "First, read a
-- Format_description event which has N event types. Then, read an
-- event of type M>N"
--echo ==== Test non-matching FD event and Row event ====

-- This is the Format_description_log_event from
-- bug32407.001, encoded in base64. It contains only the old
-- row events (number of event types is 22)
BINLOG '
4CdYRw8BAAAAYgAAAGYAAAAAAAQANS4xLjE1LW5kYi02LjEuMjQtZGVidWctbG9nAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAADgJ1hHEzgNAAgAEgAEBAQEEgAATwAEGggICAg=
';

-- The following is a Write_rows_log_event with event type 23, i.e.,
-- not supported by the Format_description_log_event above.  It
-- corresponds to the following query:
-- INSERT INTO t1 VALUES (5)
error 1149;
select * from t1;

drop table t1;
