PRAGMA enable_verification;
create table a as select case when range%2==0 then interval '1 year' else interval '2 years' end j, range::integer AS i from range(1, 5, 1);
