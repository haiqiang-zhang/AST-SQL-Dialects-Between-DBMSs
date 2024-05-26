SELECT ID, Value FROM Table1
         UNION SELECT ID, max(Value) FROM Table2 GROUP BY 1
      ORDER BY 1, 2;
create table a(key varchar, data varchar);
create table b(key varchar, period integer);
insert into a values('01','data01');
insert into a values('+1','data+1');
insert into b values ('01',1);
insert into b values ('01',2);
insert into b values ('+1',3);
insert into b values ('+1',4);
select a.*, x.*
        from a, (select key,sum(period) from b group by key) as x
        where a.key=x.key order by 1 desc;
CREATE TABLE ab(a TEXT, b TEXT);
INSERT INTO ab VALUES('01', '1');
select * from ab, (select b from ab) as x where x.b = ab.a;
create table t4(a,b);
create table t5(a,c);
insert into t4 values (1,2);
insert into t5 values (1,3);
create view myview as select t4.a a from t4 inner join t5 on t4.a=t5.a;
create table problem as select * from myview;
select * FROM problem;
create table t6 as select * from t4, t5;
select * from t6;
CREATE TABLE abc(a);
INSERT INTO abc VALUES(1);
CREATE TABLE def(d, e, f, PRIMARY KEY(d, e));
SELECT a FROM abc LEFT JOIN def ON (abc.a=def.d);
CREATE TABLE t7(x);
PRAGMA writable_schema=ON;
UPDATE sqlite_master SET sql='CREATE TABLE [M%s%s%s%s%s%s%s%s%s%s%s%s%s';
CREATE TABLE t0(a,b);
INSERT INTO t0 VALUES(1,0),(2,0);
UPDATE t0 SET b=9 WHERE a AND (SELECT a FROM t0 WHERE a);
SELECT * FROM t0 ORDER BY +a;
