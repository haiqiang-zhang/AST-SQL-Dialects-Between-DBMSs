
create table t1(a int) engine=innodb;
create table t2(a int) engine=innodb;
insert into t1 values(10),(11),(12),(13),(14),(15),(16);
insert into t2 values(100),(11),(120);

-- Single-table statement can be spotted by running EXPLAIN FORMAT=TREE
-- which cannot explain it.

-- Remains single-table if there is only a scalar subquery:

--skip_if_hypergraph  -- Always uses multi-table code path.
explain format=tree update t1 set t1.a=3 where a=(select a from t2);

-- becomes multi-table if there is IN(subquery), we see the
-- semijoin strategy in EXPLAIN:

explain update t1 set t1.a=3 where a in (select a from t2);
update t1 set t1.a=3 where a in (select a from t2);
select * from t1;

-- restore the data for next test
delete from t1;
insert into t1 values(10),(11),(12),(13),(14),(15),(16);
delete from t1 where a in (select a from t2);
select * from t1;

delete from t1;
insert into t1 values(10),(11),(12),(13),(14),(15),(16);

-- Verify that hints which disallow interesting subquery strategies
-- allow to keep using a single-table statement. First,
-- we disable semijoin, but subquery materialization remains possible,
-- so we still transform to multi-table and subquery materialization is used:

explain update t1 set t1.a=3 where a in (select /*+ no_semijoin() */ a from t2);

-- Remove some rows from t1, it now picks IN-to-EXISTS, which shows
-- it's a cost-based choice (a benefit of this WL):

delete from t1;
insert into t1 values(10),(11),(12);

delete from t1;
insert into t1 values(10),(11),(12),(13),(14),(15),(16);

-- now we also disable subquery materialization and it is not transformed
-- anymore - remains a single-table statement:

--skip_if_hypergraph  -- Always uses multi-table code path.
explain format=tree update t1 set t1.a=3 where a in (select /*+ subquery(intoexists) */ a from t2);

-- Remove hints and use @@optimizer_switch:
set optimizer_switch='semijoin=off,materialization=off';
set optimizer_switch=default;

-- Verify that the conversion to multi-table works with MyISAM too:

alter table t1 engine=myisam;
alter table t2 engine=myisam;
update t1 set t1.a=3 where a in (select a from t2);
select * from t1;

-- restore the data for next test
delete from t1;
insert into t1 values(10),(11),(12),(13),(14),(15),(16);
delete from t1 where a in (select a from t2);
select * from t1;

delete from t1;
insert into t1 values(10),(11),(12),(13),(14),(15),(16);

-- Verify that the conversion to multi-table works with MEMORY too:

alter table t1 engine=memory;
alter table t2 engine=memory;
update t1 set t1.a=3 where a in (select a from t2);
select * from t1;

-- restore the data for next test
delete from t1;
insert into t1 values(10),(11),(12),(13),(14),(15),(16);
delete from t1 where a in (select a from t2);
select * from t1;

delete from t1;
insert into t1 values(10),(11),(12),(13),(14),(15),(16);

-- Now we want to test that in READ COMMITTED isolation level, the conversion is
-- also done, even if the engine potentially can do semi-consistent read,
-- as multi-table UPDATE now supports this feature.

alter table t1 engine=innodb;

set transaction isolation level repeatable read;

set transaction isolation level read committed;

alter table t1 engine=myisam;

drop table t1,t2;
