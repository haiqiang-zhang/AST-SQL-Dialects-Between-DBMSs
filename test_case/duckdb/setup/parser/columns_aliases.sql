PRAGMA enable_verification;
CREATE TABLE integers AS SELECT 42 i, 84 j UNION ALL SELECT 13, 14;
CREATE TABLE numerics AS SELECT 42 a42, 84 b84, 126 c126, 1000 d;
CREATE TABLE tbl (
	price INTEGER,
	amount_sold INTEGER,
	total_profit AS (price * amount_sold),
);
INSERT INTO tbl VALUES (5,4);
create table a as select 42 as i, 80 as j;
create table b as select 43 as i, 84 as k;
create table c as select 44 as i, 84 as l;
