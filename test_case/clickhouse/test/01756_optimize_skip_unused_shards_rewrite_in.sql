set prefer_localhost_replica=0;
set force_optimize_skip_unused_shards=2;
set optimize_skip_unused_shards=1;
set optimize_skip_unused_shards_rewrite_in=0;
set log_queries=1;
-- w/o optimize_skip_unused_shards_rewrite_in=1
--
select '(0, 2)';
system flush logs;
-- w/ optimize_skip_unused_shards_rewrite_in=1
--

set optimize_skip_unused_shards_rewrite_in=1;
select 'optimize_skip_unused_shards_rewrite_in(0, 2)';
system flush logs;
select 'optimize_skip_unused_shards_rewrite_in(2,)';
system flush logs;
select 'optimize_skip_unused_shards_rewrite_in(0,)';
system flush logs;
select 'signed column';
create table data_01756_signed (key Int) engine=Null;
system flush logs;
-- errors
--
select 'errors';
--
-- others
--
select 'others';
select 'different types -- prohibited';
create table data_01756_str (key String) engine=Memory();
insert into data_01756_str values (0)(1);
-- different type #2
select 'different types -- conversion';
select 'optimize_skip_unused_shards_limit';
drop table data_01756_str;
drop table data_01756_signed;
