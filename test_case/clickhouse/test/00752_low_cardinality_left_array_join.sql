select *, arr from lc_left_aj left array join str as arr;
select '-';
select *, arr from lc_left_aj left array join null_str as arr;
select '-';
select *, arr from lc_left_aj left array join val as arr;
select '-';
select *, arr from lc_left_aj left array join null_val as arr;
drop table if exists lc_left_aj;
