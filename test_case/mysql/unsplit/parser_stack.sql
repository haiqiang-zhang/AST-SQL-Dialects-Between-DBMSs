SELECT
((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
1
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
prepare stmt from
"
SELECT
((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
1
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
";
drop view if exists view_overflow;
CREATE VIEW view_overflow AS
SELECT
((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
1
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
SELECT * from view_overflow;
drop view view_overflow;
drop procedure if exists proc_overflow;
select 2;
select 3;
drop function if exists func_overflow;
drop table if exists table_overflow;
create table table_overflow(a int, b int);
insert into table_overflow set a=10;
insert into table_overflow set a=20;
select * from table_overflow;
drop table table_overflow;
drop procedure if exists proc_35577;
drop procedure if exists p_37269;
select now();
select now();
select now();
select now();
select now();
select now();
select now();
select now();
select now();
select now();
select now();
select now();
select now();
select now();
select now();
select now();
select now();
select now();
select now();
select now();
select now();
select now();
select now();
drop procedure if exists p_37228;
