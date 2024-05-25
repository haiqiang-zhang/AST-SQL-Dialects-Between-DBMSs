set allow_experimental_analyzer = 1;
set enable_positional_arguments = 0;
select 40 as z from (select * from system.numbers limit 3) group by z;
select 11 AS z from (SELECT 2 UNION ALL SELECT 3) group by 42, 43, 44;
select 40 as z from (select * from system.numbers limit 3) group by z WITH TOTALS;
select 11 AS z from (SELECT 1 UNION ALL SELECT 2) group by 42, 43, 44 WITH TOTALS;
select 11 AS z from (SELECT 2 UNION ALL SELECT 3) group by 42, 43, 44 WITH TOTALS;
SELECT count() WITH TOTALS;
