create table test as select range % 10 i, range % 30 j from range(100);
select stats(i), stats(j) from test limit 1;
select stats(i), stats(j) from test limit 1;
