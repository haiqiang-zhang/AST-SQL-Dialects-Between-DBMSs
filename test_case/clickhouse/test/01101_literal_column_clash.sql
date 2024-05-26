select cast(1 as String)
from (select 1 as iid) as t1
join (select '1' as sid) as t2 on t2.sid = cast(t1.iid as String);
SELECT concat('xyz', 'abc'), * FROM (SELECT 2 AS "'xyz'");
select 1, * from (select 2 x) a left join (select 1, 3 y) b on y = x;
select 1, * from (select 2 x, 1) a right join (select 3 y) b on y = x;
select null, isConstant(null), * from (select 2 x) a left join (select null, 3 y) b on y = x;
select 2 as `toString(x)`, x from (select 1 as x);
