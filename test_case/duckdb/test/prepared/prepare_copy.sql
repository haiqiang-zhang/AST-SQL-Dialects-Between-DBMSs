PREPARE q1 AS
	COPY (
		select $1 as 'col'
	) to '__TEST_DIR__/res.csv' (
		FORMAT csv
	);
execute q1 (42);
select i from '__TEST_DIR__/res.csv' tbl(i);
