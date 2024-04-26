
-- part of sp_trans test that appeared to be sensitive to binlog format
--source include/have_binlog_format_mixed_or_row.inc
--source include/force_myisam_default.inc
--source include/have_myisam.inc

--
-- Bug#13270 INSERT,UPDATE,etc that calls func with side-effect does not binlog
-- Bug#23333 stored function + non-transac table + transac table =
--           breaks stmt-based binlog
-- Bug#27395 OPTION_STATUS_NO_TRANS_UPDATE is not preserved at the end of SF()
--
--disable_warnings
drop function if exists bug23333;
drop table if exists t1,t2;
CREATE TABLE t1 (a int  NOT NULL auto_increment primary key) ENGINE=MyISAM;
CREATE TABLE t2 (a int  NOT NULL auto_increment, b int, PRIMARY KEY (a)) ENGINE=InnoDB;

insert into t2 values (1,1);
create function bug23333() 
RETURNS int(11)
DETERMINISTIC
begin
  insert into t1 values (null);
  select count(*) from t1 into @a;
insert into t2 values (bug23333(),1);
let $binlog_limit= 2, 4;
select count(*),@a from t1 /* must be 1,1 */;

-- clean-up

drop table t1,t2;
drop function if exists bug23333;