create table edges(s int, e int)
with recursive tmp(s,e,d) as
(
select 1, 2, 1
union all
select floor(1+rand(3565659)*@node_count),
       floor(1+rand(2344291)*@node_count),
       d+1
from tmp
where d<@edge_count
)
select s,e from tmp;
create index idx1 on edges (s);
create index idx2 on edges (e);
select * from edges where s=@start_node order by e;
drop table edges;
