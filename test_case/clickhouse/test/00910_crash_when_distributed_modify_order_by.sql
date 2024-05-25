set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE union1 ( date Date, a Int32, b Int32, c Int32, d Int32) ENGINE = MergeTree(date, (a, date), 8192);
DROP TABLE union1;