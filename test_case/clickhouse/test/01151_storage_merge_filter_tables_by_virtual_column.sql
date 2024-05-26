select count(), sum(n) from merge(currentDatabase(), 'src_table');
drop table src_table_1;
drop table src_table_2;
drop table src_table_3;
drop table set;
