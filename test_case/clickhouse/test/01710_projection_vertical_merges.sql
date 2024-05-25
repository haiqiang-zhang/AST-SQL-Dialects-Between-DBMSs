alter table t add projection p_norm (select * order by c1);
optimize table t final;
alter table t materialize projection p_norm settings mutations_sync = 1;
set optimize_use_projections = 1, max_rows_to_read = 3;
select c18 from t where c1 < 0;
drop table t;
