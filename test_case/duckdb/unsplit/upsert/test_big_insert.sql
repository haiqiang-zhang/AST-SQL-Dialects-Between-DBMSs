pragma enable_verification;
SET preserve_insertion_order=false;
CREATE TABLE integers(
	i INTEGER unique,
	j INTEGER DEFAULT 0,
	k INTEGER DEFAULT 0
);
INSERT INTO integers(i) SELECT i from range(5000) tbl(i);
INSERT INTO integers SELECT * FROM integers on conflict do nothing;
INSERT INTO integers SELECT * FROM integers on conflict do update set j = 10;
INSERT INTO integers(i,j) select i%5,i from range(4995, 5000) tbl(i) on conflict do update set j = excluded.j, k = excluded.i;
insert into integers(i,j)
	select
		CASE WHEN i % 2 = 0
			THEN
				4999 - (i//2)
			ELSE
				i - ((i//2)+1)
		END,
		i
	from range(5000) tbl(i)
on conflict do update set j = excluded.j;
update integers set j = 0;
insert into integers(i,j)
	select
		CASE WHEN i % 2 = 0
			THEN
				4999 - (i//2)
			ELSE
				i - ((i//2)+1)
		END,
		i
	from range(5000) tbl(i)
on conflict do update set j = excluded.j where i % 2 = 0 AND excluded.j % 2 = 0;
SELECT COUNT(*) FROM integers;
SELECT COUNT(*) FILTER (WHERE j = 10) FROM integers;
select j from integers limit 5;
select j from integers limit 5;
select j from integers limit 5 offset 4995;
select COUNT(j) filter (where j != 0) from integers;
