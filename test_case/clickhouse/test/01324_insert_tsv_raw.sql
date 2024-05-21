drop table if exists tsv_raw;
create table tsv_raw (strval String, intval Int64, b1 String, b2 String, b3 String, b4 String) engine = Memory;
drop table tsv_raw;