SET send_logs_level = 'fatal';
drop database if exists db_01517_atomic;
create database db_01517_atomic Engine=Atomic;
create table db_01517_atomic.source (key Int) engine=Null;
create materialized view db_01517_atomic.mv engine=Null as select * from db_01517_atomic.source;
drop table db_01517_atomic.mv;
drop table db_01517_atomic.source sync;
