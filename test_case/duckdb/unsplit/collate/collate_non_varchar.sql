PRAGMA enable_verification;
PRAGMA default_collation=NOCASE;
select typeof(x) from (select 1::INT as x group by x);
