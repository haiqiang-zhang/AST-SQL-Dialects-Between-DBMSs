SET allow_experimental_analyzer=0;
select os_name, count() from (SELECT CAST('iphone' AS Enum8('iphone' = 1, 'android' = 2)) AS os_name) group by os_name WITH TOTALS;
