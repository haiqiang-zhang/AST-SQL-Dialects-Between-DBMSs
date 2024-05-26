SELECT * FROM test;
SELECT test.* FROM test;
SELECT t.* FROM test t;
select t1.i, t1.j as a, t2.j as b from r4 t1 inner join r4 t2 using(i,j) ORDER BY a;
select t1.i, t1.j as a, t2.j as b from r4 t1 inner join r4 t2 on t1.i=t2.i and t1.j=t2.j ORDER BY a;
select t1.*, t2.j b from r4 t1 inner join r4 t2 using(i,j) ORDER BY t1.j;
select t1.*, t2.j b from r4 t1 inner join r4 t2 on t1.i=t2.i and t1.j=t2.j ORDER BY t1.j;
