pragma enable_verification;;
PREPARE q1 AS
	COPY (
		select $1 as 'col'
	) to '__TEST_DIR__/res.csv' (
		FORMAT csv
	);;
execute q1 (42);;
PREPARE q2 AS
	COPY (
		select 42 as 'col'
	) to $1 (
		FORMAT csv
	);;
select i from '__TEST_DIR__/res.csv' tbl(i);;
