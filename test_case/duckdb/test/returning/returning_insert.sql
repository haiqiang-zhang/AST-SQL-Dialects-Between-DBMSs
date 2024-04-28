CREATE TABLE table1 (a INTEGER DEFAULT -1, b INTEGER DEFAULT -2, c INTEGER DEFAULT -3);;
INSERT INTO table1 VALUES (1, 1, 1), (2, 2, 2), (3, 3, 3) RETURNING SUM(a);;
INSERT INTO table1 (a, b, c) VALUES (10, 1000, 1000) RETURNING a IN (SELECT a from table1 where b = -2);;
INSERT INTO table1(a) VALUES (SELECT 42) RETURNING a, b, (select 10);;
INSERT INTO table1 VALUES (1,2,3) RETURNING d, e, f;
INSERT INTO table1 SELECT * from table1 RETURNING row_number() OVER (ORDER BY a) as row_number, a, b FROM table1;;
INSERT INTO table1 VALUES (1, 2, 3) RETURNING [1, 2] IN (SELECT [a, b] from table1);;
INSERT INTO table1(a, b) VALUES (42, 43) RETURNING (SELECT a), (SELECT b), NULL;;
INSERT INTO table1 VALUES (-10, -20, -30)
    RETURNING '-10.-20' IN (SELECT group_concat(a) OVER (ORDER BY b) as GC FROM table1);;
CREATE TABLE table2 (a VARCHAR DEFAULT 'hello world', b INT);;
CREATE SEQUENCE seq;;
CREATE TABLE table3 (a INTEGER DEFAULT nextval('seq'), b INTEGER);;
INSERT INTO table1 VALUES (1, 2, 3);;
INSERT INTO table1 VALUES (1, 2, 3) RETURNING a;;
INSERT INTO table1 VALUES (1, 2, 3) RETURNING *;;
INSERT INTO table1 VALUES (1, 2, 3) RETURNING COLUMNS('a|c');;
INSERT INTO table1 VALUES (1, 2, 3) RETURNING COLUMNS('a|c') + 42;;
INSERT INTO table1 VALUES (10, 20, 30), (40, 50, 60), (70, 80, 90) RETURNING *, c, b, a;;
INSERT INTO table1 VALUES (1, 2, 3) RETURNING c, a, b;;
INSERT INTO table1 (c, b, a) VALUES (3, 2, 1) RETURNING a, b, c;;
INSERT INTO table1 VALUES (1, 2, 3) RETURNING a AS alias1, b AS alias2;;
INSERT INTO table1(a) VALUES (10) RETURNING *;;
INSERT INTO table1 (a, b, c) SELECT * from table1 WHERE a = 10 and b=-2 and c=-3 RETURNING *;;
INSERT INTO table1 (SELECT row_number() OVER (ORDER BY a) as row_number, b, c FROM table1 LIMIT 1) RETURNING *;;
INSERT INTO table1 (a, b, c) SELECT * from table1 WHERE a = 100000 and b = 10000 and c=100000 RETURNING a, b, c;;
INSERT INTO table1 VALUES (1, 2, 3) RETURNING CASE WHEN b=2 THEN a ELSE b END;;
INSERT INTO table1 VALUES (1, 2, 3) RETURNING CASE WHEN b=3 THEN a ELSE b END;;
INSERT INTO table1 VALUES (1, 1, -3) RETURNING a + b + c;;
INSERT INTO table1 VALUES (1, 2, 3) RETURNING 'hello';;
INSERT INTO table1 VALUES (1, 2, 3) RETURNING [a, b, c];;
INSERT INTO table1 VALUES (1, 2, 3) RETURNING {'a':a, 'b':b, 'c':c};;
INSERT INTO table1(a) (SELECT 42) RETURNING a, b;;
INSERT INTO table2(a,b) VALUES ('hello duckdb', 1) RETURNING b, a;;
INSERT INTO table2(b) VALUES (97) RETURNING b::VARCHAR;;
INSERT INTO table2(a, b) VALUES ('duckdb', 97) RETURNING {'a': a, 'b': b};;
INSERT INTO table3(b) VALUES (4), (5) RETURNING a, b;;
