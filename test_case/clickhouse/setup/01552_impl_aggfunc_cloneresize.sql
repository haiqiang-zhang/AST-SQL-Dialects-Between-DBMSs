drop table if EXISTS test_bm;
drop table if EXISTS test_bm_join;
create table test_bm(
	dim UInt64,
	id UInt64 ) 
ENGINE = MergeTree()
ORDER BY( dim, id )
SETTINGS index_granularity = 8192;
create table test_bm_join( 
  dim UInt64,
  id UInt64 )
ENGINE = MergeTree()
ORDER BY(dim,id)
SETTINGS index_granularity = 8192;
insert into test_bm VALUES (1,1),(2,2),(3,3),(4,4);
