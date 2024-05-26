SELECT a, count() FROM low_null_float GROUP BY a ORDER BY count() desc, a LIMIT 10;
drop table if exists low_null_float;
