
SET @save_sql_mode=@@sql_mode$
--echo -- "||" is nicer and shorter to read than concat():
set sql_mode = pipes_as_concat$

--echo -- A procedure is used to wrap WITH RECURSIVE, because we want to
--echo -- call the query for different input set of equations.

--echo -- Parameters: left and right member of equations, as in example above.

create procedure solver(initial_leftm varchar(200), initial_rightm varchar(200))

begin
declare initial_leftm_j  json;
set initial_leftm_j  = cast(initial_leftm as json),
    initial_rightm_j = cast(initial_rightm as json);

-- Number of equations
number_of_lines (value) as
(select json_length(initial_rightm_j)),

-- Number of unknowns
number_of_columns (value) as
(select json_length(json_extract(initial_leftm_j,"$[0]"))),

-- Sequence tables
line_numbers (n) as
(
select 0
union all
select n+1 from line_numbers, number_of_lines where n<(value-1)
),

column_numbers (n) as
(
select 0
union all
select n+1 from line_numbers, number_of_columns where n<(value-1)
),

-- The recursive CTE: one row per step, a row contains the complete set of
-- equations. Rows get transformed iteratively. Columns of the CTE:
-- null_if_done: gets NULL when process is finished,
-- leftm: left member,
-- rightm: right member,
-- pivot_lines: comma-separated list of number of lines which have been used as
-- "pivot" (i.e. substracted to other lines to zero their numbers and
-- make some unknowns disappear).
-- pivot_columns: similar.
-- We must locate, in the current set of
-- equations, a line/column which can be used as pivot;
select 0, initial_leftm_j, initial_rightm_j,
       cast("" as char(200)), cast("" as char(200))

union all

select

cur_pivot.cur_pivot_line
,

(
-- Transform the left member

select
"[" ||

group_concat(

(
select
"[" ||

group_concat(

-- numbers in the left member are changed: we substract to

json_extract(json_extract(eq.leftm, "$[" || ln.n || "]"),
             "$[" || cn.n || "]")
-

-- a certain number of times the number at the pivot line and at the
-- same column;
                  "$[" || cur_pivot.cur_pivot_column || "]") *
     json_extract(json_extract(eq.leftm, "$[" || cur_pivot.cur_pivot_line || "]"),
                  "$[" || cn.n || "]") /
     cur_pivot.cur_pivot_value
else 0 end)

-- To scan each number as we do here, we have joined with
-- "column_numbers", to do the splitting;

)

-- We have split the set first in lines, then each line in numbers;
),

(
-- Transform the right member (simpler job)

select
"[" ||

group_concat(
json_extract(eq.rightm, "$[" || ln.n || "]")
-
(case when find_in_set(ln.n,eq.pivot_lines)=0 and ln.n<>cur_pivot.cur_pivot_line
then json_extract(json_extract(eq.leftm, "$[" || ln.n || "]"),
                  "$[" || cur_pivot.cur_pivot_column || "]") *
     json_extract(eq.rightm, "$[" || cur_pivot.cur_pivot_line || "]") /
     cur_pivot.cur_pivot_value
else 0 end)

order by ln.n separator ',')
|| "]"

from line_numbers
ln
),

coalesce(cur_pivot.cur_pivot_line, "") || "," || eq.pivot_lines,

coalesce(cur_pivot.cur_pivot_column, "") || "," || eq.pivot_columns

from equations eq
left join
lateral
(
-- Locate new pivot
select
ln.n as cur_pivot_line,
cn.n as cur_pivot_column,
(
 -- Extract the ln.n-th line of the left member, and from it, extract the
 -- cn.n-th column, getting a number
 json_extract(json_extract(eq.leftm, "$[" || ln.n || "]"),
              "$[" || cn.n || "]")
) as cur_pivot_value
from line_numbers ln join column_numbers cn
where
-- We're looking for lines which haven't been used as pivot yet:
find_in_set(ln.n,eq.pivot_lines)=0 and
-- and in those lines, for a non-zero number which can serve as pivot:
json_extract(json_extract(eq.leftm, "$[" || ln.n || "]"),
             "$[" || cn.n || "]") <> 0
-- and we want the first found pivot:
order by cur_pivot_line,cur_pivot_column
limit 1
) as cur_pivot

on 1

where eq.null_if_done is not null

),

-- Resolution is finished: grab the last set of equations:

final_equations as
(
select * from equations where null_if_done is null
)

-- And present it to the user;

select
json_extract(eq.leftm, "$[" || ln.n || "]")  as left_member,
json_extract(eq.rightm, "$[" || ln.n || "]") as right_member,
free.value as list_of_free_unknowns
from final_equations eq, line_numbers ln,
(
--+1 because user naturally counts from 1, not 0
select group_concat(cn.n+1) as value
from final_equations eq, column_numbers cn
where find_in_set(cn.n,eq.pivot_columns)=0
) as free

-- Equations which the user should look at first are the last ones
-- used as pivot as they have the least number of unknowns;

end

$

SET @@sql_mode=@save_sql_mode$

delimiter ;

drop procedure solver;
