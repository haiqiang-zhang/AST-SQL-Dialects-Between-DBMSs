SET distributed_foreground_insert = 1;
DROP TABLE IF EXISTS union1;
DROP TABLE IF EXISTS union2;
DROP TABLE IF EXISTS union3;
set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE union1 ( date Date, a Int32, b Int32, c Int32, d Int32) ENGINE = MergeTree(date, (a, date), 8192);
INSERT INTO union1 VALUES (1,  2, 3, 4, 5);
INSERT INTO union1 VALUES (11,12,13,14,15);
