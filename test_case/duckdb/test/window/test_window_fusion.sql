select 
	l_extendedprice, 
	l_partkey, 
	l_orderkey, 
	sum(l_extendedprice) over(), 
from lineitem 
order by l_partkey, l_orderkey;
select 
	l_extendedprice, 
	l_partkey, 
	l_orderkey, 
	sum(l_extendedprice) over(order by l_partkey), 
from lineitem 
order by l_partkey, l_orderkey;
select 
	l_extendedprice, 
	l_partkey, 
	l_orderkey, 
	sum(l_extendedprice) over(order by l_partkey, l_orderkey), 
from lineitem 
order by l_partkey, l_orderkey;
select 
	l_extendedprice, 
	l_partkey, 
	l_orderkey, 
	sum(l_extendedprice) over(order by l_partkey, l_orderkey desc), 
from lineitem 
order by l_partkey, l_orderkey;
select 
	l_extendedprice, 
	l_partkey, 
	l_orderkey, 
	sum(l_extendedprice) over(), 
	sum(l_extendedprice) over(order by l_partkey), 
	sum(l_extendedprice) over(order by l_partkey, l_orderkey), 
	sum(l_extendedprice) over(order by l_partkey, l_orderkey desc), 
from lineitem 
order by l_partkey, l_orderkey;
select 
	l_extendedprice, 
	l_partkey, 
	l_orderkey, 
	sum(l_extendedprice) over(partition by l_partkey),
from lineitem 
order by l_partkey, l_orderkey;
select 
	l_extendedprice, 
	l_partkey, 
	l_orderkey, 
	sum(l_extendedprice) over(partition by l_partkey order by l_orderkey),
from lineitem 
order by l_partkey, l_orderkey;
select 
	l_extendedprice, 
	l_partkey, 
	l_orderkey, 
	sum(l_extendedprice) over(partition by l_partkey order by l_orderkey desc),
from lineitem 
order by l_partkey, l_orderkey, l_extendedprice desc;
select 
	l_extendedprice, 
	l_partkey, 
	l_orderkey, 
	sum(l_extendedprice) over(partition by l_partkey),
	sum(l_extendedprice) over(partition by l_partkey order by l_orderkey),
	sum(l_extendedprice) over(partition by l_partkey order by l_orderkey desc),
from lineitem 
order by l_partkey, l_orderkey, l_extendedprice desc;
select 
	l_extendedprice, 
	l_partkey, 
	l_orderkey, 
	sum(l_extendedprice) over(),
	sum(l_extendedprice) over(order by l_partkey),
	sum(l_extendedprice) over(order by l_partkey, l_orderkey),
	sum(l_extendedprice) over(partition by l_partkey order by l_orderkey desc),
from lineitem 
order by l_partkey, l_orderkey, l_extendedprice desc;
