--

--disable_warnings
drop table if exists t1;

create table t1 (a int, key (a));
insert into t1 values (NULL), (0), (1), (2), (3), (4), (5), (6), (7), (8), (9),
(10), (11), (12), (13), (14), (15), (16), (17), (18), (19);
select * from t1 where not(not(a));
select * from t1 where not(not(not(a > 10)));
select * from t1 where not(not(not(a < 5) and not(a > 10)));
select * from t1 where not(a = 10);
select * from t1 where not(a != 1);
select * from t1 where not(a < 10);
select * from t1 where not(a >= 10);
select * from t1 where not(a > 10);
select * from t1 where not(a <= 10);
select * from t1 where not(a is null);
select * from t1 where not(a is not null);
select * from t1 where not(a < 5 or a > 15);
select * from t1 where not(a < 15 and a > 5);
select * from t1 where a = 2 or not(a < 10);
select * from t1 where a > 5 and not(a > 10);
select * from t1 where a > 5 xor a < 10;
select * from t1 where a = 2 or not(a < 5 or a > 15);
select * from t1 where a = 7 or not(a < 15 and a > 5);
select * from t1 where NULL or not(a < 15 and a > 5);
select * from t1 where not(NULL and a > 5);
select * from t1 where not(NULL or a);
select * from t1 where not(NULL and a);
select * from t1 where not((a < 5 or a < 10) and (not(a > 16) or a > 17));
select * from t1 where not((a < 5 and a < 10) and (not(a > 16) or a > 17));
select * from t1 where ((a between 5 and 15) and (not(a like 10)));
SELECT * FROM t1 WHERE ((a > 5) XOR (a > 7));
SELECT * FROM t1 WHERE ((NOT (a > 5)) XOR (a > 7));
SELECT * FROM t1 WHERE ((a > 5) XOR (NOT (a > 7)));
SELECT * FROM t1 WHERE NOT ((a > 5) XOR (a > 7));
SELECT * FROM t1 WHERE NOT ((NOT (a > 5)) XOR (a > 7));
SELECT * FROM t1 WHERE NOT ((a > 5) XOR (NOT (a > 7)));
SELECT * FROM t1 WHERE NOT ((NOT (a > 5)) XOR (NOT (a > 7)));
SELECT * FROM t1 WHERE (NULL XOR (a > 7));
SELECT * FROM t1 WHERE NOT (NULL XOR (a > 7));

delete from t1 where a > 3;
select a, not(not(a)) from t1;

drop table t1;
