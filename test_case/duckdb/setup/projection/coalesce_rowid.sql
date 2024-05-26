PRAGMA enable_verification;
create table tbl as select case when i%2=0 then null else i end as i from range(10) tbl(i);
