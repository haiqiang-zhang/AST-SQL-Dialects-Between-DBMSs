
--
-- Test KILL and KILL QUERY statements.
--

connect (con1, localhost, root,,);


--
-- Bug#27563: Stored functions and triggers wasn't throwing an error when killed.
--
CREATE TABLE t1 (f1 INT);
CREATE FUNCTION bug27563() RETURNS INT(11)
DETERMINISTIC
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLSTATE '70100' SET @a:= 'killed';
  SET DEBUG_SYNC= 'now SIGNAL in_sync WAIT_FOR kill';
let $ID= `SELECT @id := CONNECTION_ID()`;
let $ignore= `SELECT @id := $ID`;
SET DEBUG_SYNC= 'now WAIT_FOR in_sync';
SELECT * FROM t1;
SET DEBUG_SYNC = 'RESET';

-- Test UPDATE
INSERT INTO t1 VALUES(0);
SET DEBUG_SYNC= 'now WAIT_FOR in_sync';
SELECT * FROM t1;
SET DEBUG_SYNC = 'RESET';

-- Test DELETE
INSERT INTO t1 VALUES(1);
SET DEBUG_SYNC= 'now WAIT_FOR in_sync';
SELECT * FROM t1;
SET DEBUG_SYNC = 'RESET';

-- Test SELECT
connection con1;
SET DEBUG_SYNC= 'now WAIT_FOR in_sync';
SELECT * FROM t1;
SET DEBUG_SYNC = 'RESET';
DROP FUNCTION bug27563;

-- Test TRIGGERS
CREATE TABLE t2 (f2 INT) engine myisam;
CREATE TRIGGER trg27563 BEFORE INSERT ON t1 FOR EACH ROW
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLSTATE '70100' SET @a:= 'killed';
  INSERT INTO t2 VALUES(0);
  SET DEBUG_SYNC= 'now SIGNAL in_sync WAIT_FOR kill';
  INSERT INTO t2 VALUES(1);
SET DEBUG_SYNC= 'now WAIT_FOR in_sync';
SELECT * FROM t1;
SELECT * FROM t2;
SET DEBUG_SYNC = 'RESET';
DROP TABLE t1, t2;


create table t1 (i int primary key) engine myisam;
let $ID= `select connection_id()`;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t1 to t2";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "drop table t1";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "create trigger t1_bi before insert on t1 for each row set @a:=1";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add column j int";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 rename to t2";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 disable keys";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 alter column i set default 100";
create table t2 (i int primary key) engine=merge union=(t1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t2 alter column i set default 100";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "truncate table t1";
let $ID2= `select connection_id()`;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "insert into t1 values (1)";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table flush" and
        info = "flush tables";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table flush" and
        info = "select * from t1";
drop table t1;
drop table t2;
