drop procedure if exists `empty`;
drop procedure if exists code_sample;
create procedure `empty`()
begin
end;
drop procedure `empty`;
drop procedure if exists sudoku_solve;
create temporary table sudoku_work
  (
    `row` smallint not null,
    col smallint not null,
    dig smallint not null,
    cnt smallint,
    key using btree (cnt),
    key using btree (`row`),
    key using btree (col),
    unique key using hash (`row`,col)
  );
create temporary table sudoku_schedule
  (
    idx int not null auto_increment primary key,
    `row` smallint not null,
    col smallint not null
  );
update sudoku_work set cnt = 0 where dig = 0;
insert into sudoku_schedule (`row`,col)
    select `row`,col from sudoku_work where cnt is not null order by cnt desc;
select dig from sudoku_work;
drop temporary table sudoku_work, sudoku_schedule;
DROP PROCEDURE IF EXISTS proc_19194_simple;
DROP PROCEDURE IF EXISTS proc_19194_searched;
DROP PROCEDURE IF EXISTS proc_19194_nested_1;
DROP PROCEDURE IF EXISTS proc_19194_nested_2;
DROP PROCEDURE IF EXISTS proc_19194_nested_3;
DROP PROCEDURE IF EXISTS proc_19194_nested_4;
select "i was 20";
select "i was 20";
select "i was 20";
select "i was 20";
DROP PROCEDURE IF EXISTS p1;
CREATE PROCEDURE p1() CREATE INDEX idx ON t1 (c1);
DROP PROCEDURE p1;
drop table if exists t1;
drop procedure if exists proc_26977_broken;
drop procedure if exists proc_26977_works;
create table t1(a int unique);
select 'caught something';
select 'do something';
select 'do something again';
select 'caught something';
select 'optimizer: keep hreturn';
select 'do something';
select 'do something again';
drop table t1;
drop procedure if exists proc_33618_h;
drop procedure if exists proc_33618_c;
drop procedure if exists p_20906_a;
drop procedure if exists p_20906_b;
create procedure p_20906_a() SET @a=@a+1, @b=@b+1;
select @a, @b;
create procedure p_20906_b() SET @a=@a+1, @b=@b+1, @c=@c+1;
select @a, @b, @c;
drop procedure p_20906_a;
drop procedure p_20906_b;
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES (1), (2), (3);
SELECT "Warning found!";
SELECT @err_no, @err_txt;
SELECT "End of Result Set found!";
SELECT @err_no, @err_txt;
SELECT a INTO @foo FROM t1 LIMIT 1;
DROP TABLE t1;
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES (10);
CREATE TEMPORARY TABLE t2(a INT);
INSERT INTO t2 VALUES (20);
CREATE VIEW t3 AS SELECT 30;
DROP TABLE t1;
DROP TEMPORARY TABLE t2;
DROP VIEW t3;
