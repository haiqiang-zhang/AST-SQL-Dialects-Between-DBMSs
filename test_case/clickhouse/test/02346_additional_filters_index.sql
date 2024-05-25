set max_rows_to_read = 2;
select * from table_1 order by x settings additional_table_filters={'table_1' : 'x > 3'};
select * from table_1 order by x settings additional_table_filters={'table_1' : 'x < 3'};
select * from table_1 order by x settings additional_table_filters={'table_1' : 'length(y) >= 3'};
select * from table_1 order by x settings additional_table_filters={'table_1' : 'length(y) < 3'};
set max_rows_to_read = 4;
