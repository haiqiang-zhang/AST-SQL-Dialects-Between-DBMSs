SELECT * FROM range(0, 10, 0);
SELECT * FROM range(0, 10, -1);
SELECT * FROM range(10, 0, 1);
SELECT * FROM range('hello');
SELECT * FROM range(10, 'hello');
SELECT * FROM range(10, 10, 'hello');
SELECT * FROM range(0, 10, 1);
SELECT * FROM generate_series(0, 10, 1);
SELECT * FROM range(10, 0, -1) ORDER BY 1 ASC;
SELECT * FROM generate_series(10, 0, -1) ORDER BY 1 ASC;
SELECT * FROM range(0, -5, -1);
SELECT * FROM range(10);
SELECT * FROM range(0, 10);
SELECT EXISTS(SELECT * FROM range(10));
SELECT EXISTS(SELECT * FROM range(0));
SELECT * FROM range(10) t1(j) WHERE j=3;
select * from generate_series(-2305843009213693951, 2305843009213693951, 2305843009213693951);
select * from generate_series(2305843009213693951, -2305843009213693951, -2305843009213693951);
select * from generate_series(0, 10, 9223372036854775807);;
select * from generate_series(0, 9223372036854775807, 9223372036854775807);;
select * from generate_series(0, -9223372036854775807, -9223372036854775807);;
select * from generate_series(-9223372036854775808, 9223372036854775807, 9223372036854775807);;
select * from generate_series(-9223372036854775807, -9223372036854775808, -1);;
select * from generate_series(-9223372036854775808, 9223372036854775807, 9223372036854775807);;
select * from generate_series(0, -9223372036854775808, -9223372036854775808);;
select * from generate_series(0, 9223372036854775807, 9223372036854775807);;
select * from generate_series(0, 10, 9223372036854775807);;
