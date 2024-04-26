
set cte_max_recursion_depth = 1000000;

-- This builds a graph of randomly connected nodes (random number
-- generator is using a seed for repeatability). Then it computes the
-- transitive closure of a node. The result has been validated against
-- another DBMS.

set @node_count=100000;
set @edge_count=floor(@node_count*2.4);

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

set @start_node=60308;
select * from edges where s=@start_node order by e;

-- uni-directional edges.
-- The sums are used as digests of the thousand-rows result.

with recursive closure as
(select @start_node as n union select e from edges, closure where s=closure.n)
select count(*),sum(n),sum(floor(n/20)*(n%20)) from closure;

-- bi-directional edges

-- Skip in hypergraph mode since it chooses a very inefficient query plan,
-- due to not being able to push the condition into an index yet.
--skip_if_hypergraph
with recursive closure as (select @start_node as n union select case when s=closure.n then e else s end from edges, closure where s=closure.n or e=closure.n) select count(*),sum(n),sum(floor(n/20)*(n%20)) from closure;

-- equivalent query with two recursive members

with recursive closure as (select @start_node as n union select e from edges, closure where s=closure.n union select s from edges, closure where e=closure.n) select count(*),sum(n),sum(floor(n/20)*(n%20)) from closure;

-- uni-directional edges, again, just to test overflow-to-disk: we
-- start with a low limit on the MEMORY table.

set @@tmp_table_size=1024,@@max_heap_table_size=16384;
set session internal_tmp_mem_storage_engine='memory';
select count(*),sum(n),sum(floor(n/20)*(n%20)) from closure;

set session internal_tmp_mem_storage_engine=default;
drop table edges;
