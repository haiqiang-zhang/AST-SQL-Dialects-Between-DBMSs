
SET GLOBAL EVENT_SCHEDULER = OFF;

LET $OLD_DB= `SELECT DATABASE()`;

CREATE DATABASE db1;
USE db1;
CREATE TABLE t1 (a INT, KEY a(a)) ENGINE=INNODB;
INSERT INTO t1 VALUES (1),(2),(3),(4),(5);
CREATE TABLE t3 (a INT) ENGINE=InnoDB;
INSERT INTO t3 SELECT * FROM t1;
CREATE TABLE trans (a INT) ENGINE=INNODB;

CREATE PROCEDURE test_if_commit()
BEGIN
  ROLLBACK;
  SELECT IF (COUNT(*) > 0, "YES", "NO") AS "IMPLICIT COMMIT" FROM trans;
  DELETE FROM trans;

SET AUTOCOMMIT = FALSE;

let $statement=
  select 1 as res from t1 where (1) in (select * from t1);

let $statement=
  create table t2 like t1;

let $statement=
  show create table t2;

let $statement=
  drop table t2;

let $statement=
  create temporary table t2 as select * from t1;

let $statement=
  drop temporary table t2;

let $statement=
  create table t2 as select * from t1;

let $statement=
  update t2 set a=a+1 where (1) in (select * from t1);

let $statement=
  insert into t2 set a=((1) in (select * from t1));

let $statement=
  insert into t2 select * from t1;

let $statement=
  replace t2 set a=((1) in (select * from t1));

let $statement=
  replace t2 select * from t1;

let $statement=
  delete from t2 where (1) in (select * from t1);

let $statement=
  delete t2, t3 from t2, t3 where (1) in (select * from t1);

select * from t2;
let $statement=
  update t2, t3 set t3.a=t2.a, t2.a=null where (1) in (select * from t1);

create table t4 (a varchar(100));

let $statement=
  load data infile '../../std_data/words.dat' into table t4;

drop table t4;

let $statement=
  show databases where (1) in (select * from t1);

let $statement=
  show tables where (1) in (select * from t1);

let $statement=
  show fields from t1 where (1) in (select * from t1);

let $statement=
  show keys from t1 where (1) in (select * from t1);

let $statement=
  show variables where (1) in (select * from t1);

let $statement=
  show status where (1) in (select * from t1);

let $statement=
  show engine all mutex;

let $statement=
  show processlist;

let $statement=
  show engine all logs;

let $statement=
  show engine all status;

let $statement=
  show charset where (1) in (select * from t1);

let $statement=
  show collation where (1) in (select * from t1);

let $statement=
  show table status where (1) in (select * from t1);

let $statement=
  show triggers where (1) in (select * from t1);

let $statement=
  show open tables where (1) in (select * from t1);

let $statement=
  show procedure status where (1) in (select * from t1);

let $statement=
  show function status where (1) in (select * from t1);

let $statement=
  set @a=((1) in (select * from t1));

let $statement=
  do ((1) in (select * from t1));

create procedure p1(a int) begin end;

let $statement=
  call p1((1) in (select * from t1));

drop procedure p1;

let $statement=
  create view v1 as select * from t1;

let $statement=
  alter view v1 as select 2;

let $statement=
  drop view v1;

let $statement=
  create index idx1 on t1(a);

let $statement=
  drop index idx1 on t1;

let $statement=
  alter table t1 add column b int;

let $statement=
  alter table t1 change b c int;

let $statement=
  alter table t1 drop column c;

create temporary table t4 (a int);

let $statement=
  alter table t1 add column b int;

let $statement=
  alter table t1 change b c int;

let $statement=
  alter table t1 drop column c;

drop table t4;

insert into t2 select * from t1;
let $statement=
  truncate table t2;
insert into t2 select * from t1;

create temporary table t4 as select * from t1;
let $statement=
  truncate table t4;
drop temporary table t4;

let $statement=
  show binary log status;

let $statement=
  show slave status;

create user mysqltest_2@localhost;
let $statement=
  grant all on test.t1 to mysqltest_2@localhost with grant option;
let $statement=
  revoke select on test.t1 from mysqltest_2@localhost;

let $statement=
  revoke all on test.t1 from mysqltest_2@localhost;

drop user mysqltest_2@localhost;

let $statement=
  show grants;

let $statement=
  show grants for current_user();

let $statement=
  lock tables t1 write, trans write;

let $statement=
  unlock tables;

--
-- Missing test for lock tables transactional.
--

--echo --
--echo -- SQLCOM_CREATE_DB
--echo --

let $statement=
  create database db2;

create table db2.t1 (a int);
insert into db2.t1 values (1);

let $statement=
  use db2;

let $statement=
  show create database db2;
--  alter database db2 character set koi8r;
--  alter database db2 collate cp1251_general_cs;

use db1;

let $statement=
  drop database db2;

let $statement=
  repair table t2;

let $statement=
  repair table t2 use_frm;

let $statement=
  optimize table t1;

let $statement=
  check table t1;

let $statement=
  check table t1 extended;

set global keycache.key_buffer_size=128*1024;

let $statement=
  cache index t3 in keycache;

set global keycache.key_buffer_size=0;

let $statement=
  load index into cache t3;

let $statement=
  flush local privileges;

let $statement=
  flush privileges;

let $statement=
  analyze table t1;

let $statement=
  rollback;

let $statement=
  commit;

let $statement=
  savepoint sp1;

let $statement=
  begin;

let $statement=
  rename table t3 to t4;

let $statement=
  rename table t4 to t3;

let $statement=
  handler t1 open as ha1;

let $statement=
  handler ha1 read a first;

let $statement=
  handler ha1 close;

let $statement=
  show slave hosts;

let $statement=
  show binlog events;

let $statement=
  show warnings;

let $statement=
  show errors;

let $statement=
  show engines;

let $statement=
  show privileges;

let $statement=
  help 'foo';

let $statement=
  create user trxusr1;

let $statement=
  rename user 'trxusr1' to 'trxusr2';

let $statement=
  drop user trxusr2;

let $statement=
  checksum table t1;

let $statement=
  create procedure p1(a int) begin end;

let $statement=
  alter procedure p1 comment 'foobar';

let $statement=
  show create procedure p1;

let $statement=
  show procedure status;

--
-- Available only on servers with debugging support.
--

--disable_abort_on_error
let $statement=
  show procedure code p1;

let $statement=
  drop procedure p1;

let $statement=
  create function f1() returns int return 69;

let $statement=
  alter function f1 comment 'comment';

let $statement=
  show create function f1;

let $statement=
  show function status like '%f%';

--
-- Available only on servers with debugging support.
--

--disable_abort_on_error
let $statement=
  show function code f1;

let $statement=
  prepare stmt1 from "insert into t1 values (5)";

let $statement=
  execute stmt1;

let $statement=
  deallocate prepare stmt1;

let $statement=
  create trigger trg1 before insert on t1 for each row set @a:=1;

let $statement=
  show create trigger trg1;

let $statement=
  drop trigger trg1;

let $statement=
  CREATE TABLESPACE ts1 ADD DATAFILE './ts1.ibd' ENGINE=INNODB;

let $statement=
  DROP TABLESPACE ts1  ENGINE=INNODB;

let $statement=
  create event ev1 on schedule every 1 second do insert into t1 values (6);

let $statement=
  alter event ev1 rename to ev2 disable;

let $statement=
  show create event ev2;

let $statement=
  show events;

let $statement=
  drop event ev2;
--  backup database db1 to 'backup_db1.ba';

--
-- --error ER_NOT_ALLOWED_COMMAND
--
--let $statement=
--  show backup 'backup_db1.ba';
--

--echo --
--echo -- SQLCOM_RESTORE
--echo --

--let $statement=
--  restore from 'backup_db1.ba';

-- BACKUP_TEST

--echo --
--echo -- SQLCOM_SHOW_PROFILE
--echo --

let $statement=
  show profile memory;

let $statement=
  show profiles;

DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;
DROP DATABASE db1;

SET GLOBAL EVENT_SCHEDULER = ON;
