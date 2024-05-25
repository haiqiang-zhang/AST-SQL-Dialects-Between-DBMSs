drop table if exists z;
create table z (pk Int64, d Date, id UInt64, c UInt64) Engine MergeTree partition by d order by pk settings ratio_of_defaults_for_sparse_serialization = 1.0;
insert into z  select number, '2021-10-24', intDiv (number, 10000), 1 from numbers(1000000);
optimize table z final;
alter table z add projection pp (select id, sum(c) group by id);
alter table z materialize projection pp settings mutations_sync=1;
drop table z;
