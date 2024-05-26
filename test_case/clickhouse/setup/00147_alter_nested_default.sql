DROP TABLE IF EXISTS alter_00147;
set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE alter_00147 (d Date DEFAULT toDate('2015-01-01'), n Nested(x String)) ENGINE = MergeTree(d, d, 8192);
INSERT INTO alter_00147 (`n.x`) VALUES (['Hello', 'World']);
