select * from data_02021 prewhere 1 or ignore(key);
select * from data_02021 prewhere 1 or ignore(key) where key = 1;
select * from data_02021 prewhere 0 or ignore(key);
select * from data_02021 prewhere 0 or ignore(key) where key = 1;
drop table data_02021;
