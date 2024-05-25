create index idx1 on edges (s);
create index idx2 on edges (e);
select * from edges where s=@start_node order by e;
drop table edges;
