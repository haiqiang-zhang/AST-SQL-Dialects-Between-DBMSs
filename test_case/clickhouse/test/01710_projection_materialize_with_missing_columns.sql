alter table x add column j int;
alter table x add projection p_agg (select sum(j));
alter table x materialize projection p_agg settings mutations_sync = 1;
drop table x;
