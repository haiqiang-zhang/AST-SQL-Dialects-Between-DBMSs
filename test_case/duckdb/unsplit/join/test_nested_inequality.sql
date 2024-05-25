PRAGMA enable_verification;
CREATE VIEW list_int AS
SELECT i, i%2 as i2, [i, i + 1, i + 2] as l3
FROM range(10) tbl(i);
select lhs.*, rhs.*
from list_int lhs, list_int rhs
where lhs.i2 = rhs.i2 and lhs.l3 <> rhs.l3
order by lhs.i, rhs.i;
select lhs.*, rhs.*
from list_int lhs, list_int rhs
where lhs.i2 = rhs.i2 and lhs.l3 <= rhs.l3
order by lhs.i, rhs.i;
select lhs.*, rhs.*
from list_int lhs, list_int rhs
where lhs.i2 = rhs.i2 and lhs.l3 < rhs.l3
order by lhs.i, rhs.i;
select lhs.*, rhs.*
from list_int lhs, list_int rhs
where lhs.i2 = rhs.i2 and lhs.l3 >= rhs.l3
order by lhs.i, rhs.i;
select lhs.*, rhs.*
from list_int lhs, list_int rhs
where lhs.i2 = rhs.i2 and lhs.l3 > rhs.l3
order by lhs.i, rhs.i;
