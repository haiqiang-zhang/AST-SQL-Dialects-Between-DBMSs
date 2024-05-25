select * from data prewhere indexHint(_partition_id = '1');
select count() from data prewhere indexHint(_partition_id = '1') settings optimize_use_implicit_projections = 0;
select * from data where indexHint(_partition_id = '1');
select count() from data where indexHint(_partition_id = '1') settings optimize_use_implicit_projections = 0;
