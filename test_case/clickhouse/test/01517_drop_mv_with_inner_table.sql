SET send_logs_level = 'fatal';
-- Atomic no SYNC
-- (should go first to check that thread for DROP TABLE does not hang)
--
drop database if exists db_01517_atomic;
create database db_01517_atomic Engine=Atomic;
create table db_01517_atomic.source (key Int) engine=Null;
create materialized view db_01517_atomic.mv engine=Null as select * from db_01517_atomic.source;
drop table db_01517_atomic.mv;
drop table db_01517_atomic.source sync;
show tables from db_01517_atomic;
-- Atomic
--
drop database if exists db_01517_atomic_sync;
create database db_01517_atomic_sync Engine=Atomic;
create table db_01517_atomic_sync.source (key Int) engine=Null;
create materialized view db_01517_atomic_sync.mv engine=Null as select * from db_01517_atomic_sync.source;
drop table db_01517_atomic_sync.mv sync;
show tables from db_01517_atomic_sync;
-- Ordinary
---
drop database if exists db_01517_ordinary;
set allow_deprecated_database_ordinary=1;
create database db_01517_ordinary Engine=Ordinary;
create table db_01517_ordinary.source (key Int) engine=Null;
create materialized view db_01517_ordinary.mv engine=Null as select * from db_01517_ordinary.source;
drop table db_01517_ordinary.mv sync;
show tables from db_01517_ordinary;
drop table db_01517_atomic_sync.source;
drop table db_01517_ordinary.source;
drop database db_01517_atomic;
drop database db_01517_atomic_sync;
drop database db_01517_ordinary;
