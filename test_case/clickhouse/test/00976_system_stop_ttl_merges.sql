system stop ttl merges ttl;
optimize table ttl partition 10 final;
select * from ttl order by d, a;
system start ttl merges ttl;
optimize table ttl partition 10 final;
select * from ttl order by d, a;
drop table if exists ttl;
