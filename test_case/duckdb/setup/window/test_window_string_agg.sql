PRAGMA enable_verification;
create table a as select range%3 j, range::varchar AS s, case when range%3=0 then '-' else '|' end sep from range(1, 7, 1);
