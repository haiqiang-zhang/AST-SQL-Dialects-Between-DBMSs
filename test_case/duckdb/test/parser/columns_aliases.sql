PRAGMA enable_verification;
CREATE TABLE integers AS SELECT 42 i, 84 j UNION ALL SELECT 13, 14;
CREATE TABLE numerics AS SELECT 42 a42, 84 b84, 126 c126, 1000 d;
SELECT MIN(COLUMNS('([a-z])\d+')) AS "\" FROM numerics;
SELECT MIN(COLUMNS('([a-z])\d+')) AS "\a" FROM numerics;
SELECT MIN(COLUMNS(*)) AS "min_\1" FROM numerics;
CREATE TABLE tbl (
	price INTEGER,
	amount_sold INTEGER,
	total_profit AS (price * amount_sold),
);;
INSERT INTO tbl VALUES (5,4);;
create table a as select 42 as i, 80 as j;;
create table b as select 43 as i, 84 as k;;
create table c as select 44 as i, 84 as l;;
SELECT i, j FROM (SELECT COLUMNS(*)::VARCHAR FROM integers);
SELECT min_i, min_j, max_i, max_j FROM (SELECT MIN(COLUMNS(*)) AS "min_\0", MAX(COLUMNS(*)) AS "max_\0" FROM integers);
SELECT min_a, min_b, min_c FROM (SELECT MIN(COLUMNS('([a-z])\d+')) AS "min_\1" FROM numerics);
SELECT min_, "min__1", "min__2" FROM (SELECT MIN(COLUMNS('([a-z])\d+')) AS "min_\2" FROM numerics);
SELECT "min_\a\", "min_\b\", "min_\c\" FROM (SELECT MIN(COLUMNS('([a-z])\d+')) AS "min_\\\1\\" FROM numerics);
SELECT "a42aa", "b84bb", "c126cc" FROM (SELECT MIN(COLUMNS('([a-z])(\d+)')) AS "\1\2\1\1" FROM numerics);
SELECT price, amount_sold, total_profit FROM (SELECT COLUMNS(*)::VARCHAR FROM tbl);
SELECT varchar_price, varchar_amount_sold, varchar_total_profit FROM (SELECT COLUMNS(*)::VARCHAR AS "varchar_\0" FROM tbl);
select i, j, k from (select columns(*)::VARCHAR from a full outer join b using (i)) order by 1;;
select i, j, k, l from (select columns(*)::VARCHAR from a full outer join b using (i) full outer join c using (i)) order by 1;;
