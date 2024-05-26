select sum(e) from (select * from merged order by t limit 10) SETTINGS optimize_read_in_order = 0;
DROP TABLE IF EXISTS short;
DROP TABLE IF EXISTS long;
DROP TABLE IF EXISTS merged;
