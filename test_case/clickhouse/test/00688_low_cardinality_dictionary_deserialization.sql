select sum(toUInt64(str)), sum(toUInt64(pat)) from lc_dict_reading where val < 8129 or val > 8192 * 4;
drop table if exists lc_dict_reading;
