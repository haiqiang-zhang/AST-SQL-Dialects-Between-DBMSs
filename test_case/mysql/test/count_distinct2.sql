drop table if exists t1;

SET @big_tables_save=@@big_tables;

create table t1(n1 int, n2 int, s char(20), vs varchar(20), t text);
insert into t1 values (1,11, 'one','eleven', 'eleven'),
 (1,11, 'one','eleven', 'eleven'),
 (2,11, 'two','eleven', 'eleven'),
 (2,12, 'two','twevle', 'twelve'),
 (2,13, 'two','thirteen', 'foo'),
 (2,13, 'two','thirteen', 'foo'),
 (2,13, 'two','thirteen', 'bar'),
 (NULL,13, 'two','thirteen', 'bar'),
 (2,NULL, 'two','thirteen', 'bar'),
 (2,13, NULL,'thirteen', 'bar'),
 (2,13, 'two',NULL, 'bar'),
 (2,13, 'two','thirteen', NULL);
select distinct n1 from t1;
select count(distinct n1) from t1;
select distinct n2 from t1;
select count(distinct n2) from t1;
select distinct s from t1;
select count(distinct s) from t1;
select distinct vs from t1;
select count(distinct vs) from t1;
select distinct t from t1;
select count(distinct t) from t1;
select distinct n1,n2 from t1;
select count(distinct n1,n2) from t1;
select distinct n1,s from t1;
select count(distinct n1,s) from t1;
select distinct s,n1,vs from t1;
select count(distinct s,n1,vs) from t1;
select distinct s,t from t1;
select count(distinct s,t) from t1;

select count(distinct n1), count(distinct n2) from t1;

select count(distinct n2), n1 from t1 group by n1;
drop table t1;

-- test the conversion from tree to MyISAM
create table t1 (n int default NULL);
let $1=5000;
 dec $1;
select count(distinct n) from t1;
drop table t1;

-- Test use of MyISAM tmp tables
SET SESSION big_tables=1;
create table t1 (s text);
let $1=5000;
 dec $1;
select count(distinct s) from t1;
drop table t1;
SET SESSION big_tables=@big_tables_save;
