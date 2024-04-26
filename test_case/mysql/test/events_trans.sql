--

--disable_warnings
drop database if exists events_test;
drop database if exists mysqltest_no_such_database;
create database events_test;
use events_test;
set autocommit=off;
select @@autocommit;
create table t1 (a varchar(255)) engine=innodb;
insert into t1 (a) values ("OK: create event");
create event e1 on schedule every 1 day do select 1;
select * from t1;
delete from t1;
insert into t1 (a) values ("OK: alter event");
alter event e1 on schedule every 2 day do select 2;
select * from t1;
delete from t1;
insert into t1 (a) values ("OK: alter event rename");
alter event e1 rename to e2;
select * from t1;
delete from t1;
insert into t1 (a) values ("OK: drop event");
drop event e2;
select * from t1;
delete from t1;
insert into t1 (a) values ("OK: drop event if exists");
drop event if exists e2;
select * from t1;
delete from t1;
create event e1 on schedule every 1 day do select 1;
insert into t1 (a) values ("OK: create event if not exists");
create event if not exists e1 on schedule every 2 day do select 2;
select * from t1;
delete from t1;
insert into t1 (a) values ("OK: create event: event already exists");
create event e1 on schedule every 2 day do select 2;
select * from t1;
delete from t1;
insert into t1 (a) values ("OK: alter event rename: rename to same name");
alter event e1 rename to e1;
select * from t1;
delete from t1;
create event e2 on schedule every 3 day do select 3;
insert into t1 (a) values ("OK: alter event rename: destination exists");
alter event e2 rename to e1;
select * from t1;
delete from t1;
insert into t1 (a) values ("OK: create event: database does not exist");
create event mysqltest_no_such_database.e1 on schedule every 1 day do select 1;
select * from t1;
delete from t1;

--
-- Cleanup
--

let $wait_condition=
  select count(*) = 0 from information_schema.processlist
  where db='events_test' and command = 'Connect' and user=current_user();

USE test;
DROP TABLE IF EXISTS t1, t2;
DROP EVENT IF EXISTS e1;

CREATE TABLE t1 (a INT) ENGINE=InnoDB;
CREATE TABLE t2 (a INT);
CREATE EVENT e1 ON SCHEDULE EVERY 1 DAY DO SELECT 1;
INSERT INTO t1 VALUES (1);
SELECT * FROM t2;

DROP TABLE t1, t2;
DROP EVENT e1;
drop database if exists mysqltest_db2;
use events_test;
create user mysqltest_user1@localhost;
  to mysqltest_user1@localhost;
create database mysqltest_db2;
set autocommit=off;
select @@autocommit;
create table t1 (a varchar(255)) engine=innodb;
insert into t1 (a) values ("OK: create event: insufficient privileges");
create event e1 on schedule every 1 day do select 1;
select * from t1;
delete from t1;
insert into t1 (a) values ("OK: alter event: insufficient privileges");
alter event e1 on schedule every 1 day do select 1;
select * from t1;
delete from t1;
insert into t1 (a) values ("OK: drop event: insufficient privileges");
drop event e1;
select * from t1;
delete from t1;
drop user mysqltest_user1@localhost;
drop database mysqltest_db2;

--
-- Cleanup
--
let $wait_condition=
  select count(*) = 0 from information_schema.processlist
  where db='events_test' and command = 'Connect' and user=current_user();

drop database events_test;
