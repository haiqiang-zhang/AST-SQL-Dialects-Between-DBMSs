
-- Test for bug #5894 "Triggers with altered tables cause corrupt databases"
-- Also tests basic error handling for various kinds of triggers.
create table t1 (i int, at int, k int, key(k)) engine=myisam;
create table t2 (i int);
insert into t1 values (1, 1, 1);
insert into t2 values (1), (2), (3);
create trigger ai after insert on t1 for each row set @a:= new.at;
create trigger au after update on t1 for each row set @a:= new.at;
create trigger ad after delete on t1 for each row set @a:= old.at;
alter table t1 drop column at;
select * from t1;
insert into t1 values (2, 1);
select * from t1;
update t1 set k = 2 where i = 2;
select * from t1;
delete from t1 where i = 2;
select * from t1;
select * from t1;
insert into t1 select 3, 3;
select * from t1;
update t1, t2 set k = k + 10 where t1.i = t2.i;
select * from t1;
update t1, t2 set k = k + 10 where t1.i = t2.i and k < 3;
select * from t1;
delete t1, t2 from t1 straight_join t2 where t1.i = t2.i;
select * from t1;
delete t2, t1 from t2 straight_join t1 where t1.i = t2.i;
select * from t1;
alter table t1 add primary key (i);
insert into t1 values (3, 4) on duplicate key update k= k + 10;
select * from t1;
select * from t1;
drop table t1, t2;


--
-- Bug #26162: Trigger DML ignores low_priority_updates setting
--"LOW_PRIORITY_UPDATES" used by the test is not supported by Innodb
--
CREATE TABLE t1 (id INTEGER) ENGINE=MyISAM;
CREATE TABLE t2 (id INTEGER) ENGINE=MyISAM;

INSERT INTO t2 VALUES (1),(2);

-- trigger that produces the high priority insert, but should be low, adding
-- LOW_PRIORITY fixes this
CREATE TRIGGER t1_test AFTER INSERT ON t1 FOR EACH ROW
  INSERT INTO t2 VALUES (new.id);
SELECT GET_LOCK('B26162',120);
SELECT 'rl_acquirer', GET_LOCK('B26162',120), id FROM t2 WHERE id = 1;
SET SESSION LOW_PRIORITY_UPDATES=1;
SET GLOBAL LOW_PRIORITY_UPDATES=1;
INSERT INTO t1 VALUES (5);
SELECT 'rl_contender', id FROM t2 WHERE id > 1;
SELECT RELEASE_LOCK('B26162');
SELECT RELEASE_LOCK('B26162');

DROP TRIGGER t1_test;
DROP TABLE t1,t2;
SET SESSION LOW_PRIORITY_UPDATES=DEFAULT;
SET GLOBAL LOW_PRIORITY_UPDATES=DEFAULT;

--
-- Bug #48525: trigger changes "Column 'id' cannot be null" behaviour
--
CREATE TABLE t1 (id INT NOT NULL) ENGINE=MyISAM;
CREATE TABLE t2 (id INT NOT NULL) ENGINE=MyISAM;
INSERT t1 VALUES (1),(2),(3);
UPDATE IGNORE t1 SET id=NULL;
CREATE TRIGGER t1_bu BEFORE UPDATE ON t1 FOR EACH ROW
  INSERT INTO t2 VALUES (3);
UPDATE t1 SET id=NULL;
DROP TRIGGER t1_bu;
DROP TABLE t1,t2;