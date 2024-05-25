truncate table order_by_const;
system stop merges order_by_const;
INSERT INTO order_by_const(a, b, c, d) VALUES (1, 1, 101, 1), (1, 2, 102, 1), (1, 3, 103, 1), (1, 4, 104, 1);
INSERT INTO order_by_const(a, b, c, d) VALUES (1, 5, 104, 1), (1, 6, 105, 1), (2, 1, 106, 2), (2, 1, 107, 2);
INSERT INTO order_by_const(a, b, c, d) VALUES (2, 2, 107, 2), (2, 3, 108, 2), (2, 4, 109, 2);
SELECT row_number() OVER (order by 1, a) FROM order_by_const SETTINGS query_plan_enable_multithreading_after_window_functions=0;
drop table order_by_const;
select count() over (rows between 1 + 1 preceding and 1 + 1 following) from numbers(10);
-- default arguments of lagInFrame can be a subtype of the argument
select number,
    lagInFrame(toNullable(number), 2, null) over w,
    lagInFrame(number, 2, 1) over w
from numbers(10)
window w as (order by number);
select number, row_number() over (partition by number rows between unbounded preceding and 1 preceding) from numbers(4) settings max_block_size = 2;
