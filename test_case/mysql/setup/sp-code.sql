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
