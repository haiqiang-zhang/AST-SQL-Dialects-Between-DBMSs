PRAGMA enable_verification;
from (
  (values (1), (2)) as t1 (a)
  cross join
  (values (3), (4)) as t2 (b)
) as t(x, y, z);
select t.*
from (
  (values (1), (2)) as t1 (a)
  cross join
  (values (3), (4)) as t2 (b)
) as t;
select x, y
from (
  (values (1), (2)) as t1 (a)
  cross join
  (values (3), (4)) as t2 (b)
) as t(x, y);
