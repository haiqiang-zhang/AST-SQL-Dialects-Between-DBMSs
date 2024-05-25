alter table ttl modify ttl d + interval 1 day;
optimize table ttl partition 10 final;
select * from ttl order by d, a;
drop table if exists ttl;
