select a, count(b) from group_by_all group by all order by a;
select substring(a, 1, 3), count(b) from group_by_all group by all;
select substring(a, 1, 3), substring(substring(a, 1, 2), 1, count(b)) from group_by_all group by all;
SET allow_experimental_analyzer = 1;
