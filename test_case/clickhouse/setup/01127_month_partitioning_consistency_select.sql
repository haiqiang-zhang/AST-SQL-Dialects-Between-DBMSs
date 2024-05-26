DROP TABLE IF EXISTS mt;
set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE mt (d Date, x String) ENGINE = MergeTree(d, x, 8192);
INSERT INTO mt VALUES ('2106-02-07', 'Hello'), ('1970-01-01', 'World');
