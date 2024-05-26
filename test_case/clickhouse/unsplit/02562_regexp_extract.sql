select regexpExtract('100-200', '(\\d+)-(\\d+)', 1);
select REGEXP_EXTRACT('100-200', '(\\d+)-(\\d+)', 1);
select regexpExtract('100-200', '(\\d+)-(\\d+)', number) from numbers(3);
