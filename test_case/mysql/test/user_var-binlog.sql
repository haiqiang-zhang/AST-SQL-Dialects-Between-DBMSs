
-- Check that user variables are binlogged correctly (BUG#3875)
create table t1 (a varchar(50));
SET TIMESTAMP=10000;
SET @`a b`='hello';
INSERT INTO t1 VALUES(@`a b`);
set @var1= "';
SET @var2=char(ascii('a'));
insert into t1 values (@var1),(@var2);

-- more important than SHOW BINLOG EVENTS, mysqlbinlog (where we
-- absolutely need variables names to be quoted and strings to be
-- escaped).
let $MYSQLD_DATADIR= `select @@datadir`;
drop table t1;
