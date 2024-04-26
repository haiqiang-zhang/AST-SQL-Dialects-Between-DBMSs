
--
-- Test nchar/nvarchar
--
--disable_warnings
drop table if exists t1;

create table t1 (c nchar(10));
drop table t1;

create table t1 (c national char(10));
drop table t1;

create table t1 (c national varchar(10));
drop table t1;

create table t1 (c nvarchar(10));
drop table t1;

create table t1 (c nchar varchar(10));
drop table t1;

create table t1 (c national character varying(10));
drop table t1;

create table t1 (c nchar varying(10));
drop table t1;
