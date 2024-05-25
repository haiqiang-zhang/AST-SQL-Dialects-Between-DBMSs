optimize table z final;
alter table z add projection pp (select id, sum(c) group by id);
alter table z materialize projection pp settings mutations_sync=1;
drop table z;
