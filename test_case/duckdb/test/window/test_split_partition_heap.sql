PRAGMA enable_verification;
create table partsupp as select uuid()::varchar as c5 from range(8000);;
SELECT (ntile(5002) OVER (ROWS BETWEEN CURRENT ROW AND CURRENT ROW) >= 0), c5 FROM partsupp;;