-- https://github.com/ClickHouse/ClickHouse/issues/1059

SET distributed_foreground_insert = 1;
DROP TABLE IF EXISTS union1;
DROP TABLE IF EXISTS union2;
DROP TABLE IF EXISTS union3;
set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE union1 ( date Date, a Int32, b Int32, c Int32, d Int32) ENGINE = MergeTree(date, (a, date), 8192);
INSERT INTO union1 VALUES (1,  2, 3, 4, 5);
INSERT INTO union1 VALUES (11,12,13,14,15);
select b, sum(c) from ( select a, b, sum(c) as c from union1 where a>1 group by a,b UNION ALL select a, b, sum(c) as c from union1 where b>1 group by a, b order by a, b) as a group by b order by b;
DROP TABLE union1;
