drop table if exists dist_01757;
create table dist_01757 as system.one engine=Distributed(test_cluster_two_shards, system, one, dummy);
set optimize_skip_unused_shards=1;
set force_optimize_skip_unused_shards=2;
select * from dist_01757 where dummy in (0, 1) settings optimize_skip_unused_shards_limit=1;
-- or negative
select * from dist_01757 where dummy = 0 or dummy = 1 settings optimize_skip_unused_shards_limit=1;
-- disabled for analyzer cause new implementation consider `dummy = 0 and dummy = 1` as constant False.
select * from dist_01757 where dummy = 0 and dummy = 1 settings optimize_skip_unused_shards_limit=1, allow_experimental_analyzer=0;
select * from dist_01757 where dummy = 0 and dummy = 2 and dummy = 3 settings optimize_skip_unused_shards_limit=1, allow_experimental_analyzer=0;
select * from dist_01757 where dummy = 0 and dummy = 2 and dummy = 3 settings optimize_skip_unused_shards_limit=2, allow_experimental_analyzer=0;
-- and
select * from dist_01757 where dummy = 0 and dummy = 1 settings optimize_skip_unused_shards_limit=2;
select * from dist_01757 where dummy = 0 and dummy = 1 and dummy = 3 settings optimize_skip_unused_shards_limit=3;
select * from dist_01757 where dummy in (0, 1) settings optimize_skip_unused_shards_limit=0;
select * from dist_01757 where dummy in (0, 1) settings optimize_skip_unused_shards_limit=9223372036854775808;
drop table dist_01757;