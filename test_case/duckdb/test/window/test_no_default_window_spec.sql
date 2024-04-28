PRAGMA enable_verification;
create table tenk1d(ten int4, four int4);
insert into tenk1d values (0,0), (1,1), (3,3), (2,2), (4,2), (9,1), (4,0), (7,3), (0,2), (2,0), (5,1), (1,3), (3,1), (6,0), (8,0), (9,3), (8,2), (6,2), (7,1), (5,3);
SELECT four, ten, sum(ten) over (partition by four order by ten) st, last_value(ten) over (partition by four order by ten) lt FROM tenk1d ORDER BY four, ten;
SELECT four, ten, sum(ten) over (partition by four order by ten range between unbounded preceding and current row) st, last_value(ten) over (partition by four order by ten range between unbounded preceding and current row) lt FROM tenk1d order by four, ten;
SELECT four, ten, sum(ten) over (partition by four order by ten range between unbounded preceding and unbounded following) st, last_value(ten) over (partition by four order by ten range between unbounded preceding and unbounded following) lt FROM tenk1d order by four, ten;
SELECT four, ten//4 as two, 	sum(ten//4) over (partition by four order by ten//4 range between unbounded preceding and current row) st, last_value(ten//4) over (partition by four order by ten//4 range between unbounded preceding and current row) lt FROM tenk1d order by four, ten//4;
SELECT four, ten//4 as two, sum(ten//4) OVER w st, last_value(ten//4) OVER w lt FROM tenk1d WINDOW w AS (partition by four order by ten//4 range between unbounded preceding and current row) order by four, ten//4;
