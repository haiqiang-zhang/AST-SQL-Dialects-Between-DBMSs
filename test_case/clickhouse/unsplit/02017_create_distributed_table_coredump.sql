drop table if exists t;
drop table if exists td1;
drop table if exists td2;
drop table if exists td3;
create table t (val UInt32) engine = MergeTree order by val;
drop table if exists t;
drop table if exists td1;
drop table if exists td2;
drop table if exists td3;
