create table gist_point_tbl(id int4, p point);
create index gist_pointidx on gist_point_tbl using gist(p);
create index gist_pointidx2 on gist_point_tbl using gist(p) with (buffering = on, fillfactor=50);
create index gist_pointidx3 on gist_point_tbl using gist(p) with (buffering = off);
create index gist_pointidx4 on gist_point_tbl using gist(p) with (buffering = auto);
drop index gist_pointidx2, gist_pointidx3, gist_pointidx4;
insert into gist_point_tbl (id, p)
select g,        point(g*10, g*10) from generate_series(1, 10000) g;
insert into gist_point_tbl (id, p)
select g+100000, point(g*10+1, g*10+1) from generate_series(1, 10000) g;
delete from gist_point_tbl where id % 2 = 1;
delete from gist_point_tbl where id > 5000;
