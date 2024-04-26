drop table if exists t1,t2;


create table t1(str varchar(10) default 'def',strnull varchar(10),intg int default '10',rel double default '3.14');

insert into t1 values ('','',0,0.0);
select default(str), default(strnull), default(intg), default(rel) from t1;
select * from t1 where str <> default(str);

drop table t1;

-- End of 4.1 tests

--
-- Bug #11314 (HAVING DEFAULT() hangs)
--
CREATE TABLE t1 (id int(11), s varchar(20));
INSERT INTO t1 VALUES (1, 'one'), (2, 'two'), (3, 'three');
SELECT s, 32 AS mi FROM t1 GROUP BY s HAVING DEFAULT(mi) IS NULL;
DROP TABLE t1;
