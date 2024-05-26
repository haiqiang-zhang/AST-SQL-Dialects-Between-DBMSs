create table spgist_point_tbl(id int4, p point);
create index spgist_point_idx on spgist_point_tbl using spgist(p) with (fillfactor = 75);
insert into spgist_point_tbl (id, p)
select g, point(g*10, g*10) from generate_series(1, 10) g;
delete from spgist_point_tbl where id < 5;
