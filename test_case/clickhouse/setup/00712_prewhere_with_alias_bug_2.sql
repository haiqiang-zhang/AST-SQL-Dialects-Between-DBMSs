drop table if exists table;
set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE table (a UInt32,  date Date, b UInt64,  c UInt64, str String, d Int8, arr Array(UInt64), arr_alias Array(UInt64) ALIAS arr) ENGINE = MergeTree(date, intHash32(c), (a, date, intHash32(c), b), 8192);
