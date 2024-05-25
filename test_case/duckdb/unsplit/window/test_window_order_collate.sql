PRAGMA enable_verification;
CREATE TABLE db_city (name VARCHAR, city VARCHAR COLLATE NOCASE);
INSERT INTO db_city VALUES
	('DuckDB', 'Amsterdam'), 
	('MonetDB','amsterdam'),
	('VectorWise', 'AmstÃÂÃÂÃÂÃÂ«rdam');
select
    *,
    array_agg(col) over(partition by id order by col collate nocase) as lead_col_nocase
from (
	select 
		unnest(array[1, 1, 1, 1]) as id, 
		unnest(array['A', 'a', 'b', 'B']) as col
);
SELECT name, city, row_number() OVER (PARTITION BY city) AS row_id 
FROM db_city;
SELECT name, city, row_number() OVER (PARTITION BY city COLLATE NOCASE) AS row_id 
FROM db_city;
