alter table cardinality add column y LowCardinality(String);
select * from cardinality;
drop table if exists cardinality;
