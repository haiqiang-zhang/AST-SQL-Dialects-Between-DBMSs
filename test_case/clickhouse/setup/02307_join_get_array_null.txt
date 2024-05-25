drop table if exists id_val;
create table id_val(id Int32, val Array(Int32)) engine Join(ANY, LEFT, id) settings join_use_nulls = 1;
