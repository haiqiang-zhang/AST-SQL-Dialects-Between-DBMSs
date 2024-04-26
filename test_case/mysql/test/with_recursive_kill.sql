
-- Save id of con1
connection con1;
let $ID= `SELECT @id := CONNECTION_ID()`;
let $ignore= `SELECT @id := $ID`;

-- Need to allow many iterations, so that:
-- we have time to switch to other connection and kill (test 1)
-- and one second can pass (test 2).

SET @@SESSION.cte_max_recursion_depth = 1000000000;

SET DEBUG_SYNC='in_WITH_RECURSIVE SIGNAL with_recursive_has_started';
 select 1, "a"
 union all select 1+num, "b" from q where mark="a"
 union all select 1+num, "a" from q where mark="b"
)
select num from q;

-- Wait until the above SELECT is in WITH-RECURSIVE algorithm

SET DEBUG_SYNC='now WAIT_FOR with_recursive_has_started';
SET DEBUG_SYNC= 'RESET';
SELECT 1;
SET DEBUG_SYNC= 'RESET';

SET @@SESSION.max_execution_time= 1000;

-- Should get the first error, sometimes get 2nd, bug#81212
--error ER_QUERY_TIMEOUT,ER_QUERY_INTERRUPTED
with recursive q (b) as (select 1 union all select 1+b from q)
select b from q;

SELECT 1;
