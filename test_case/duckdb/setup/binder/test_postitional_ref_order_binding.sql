PRAGMA enable_verification;
create table test as select * from (values (42, 43), (44, 45)) v(i, j);
