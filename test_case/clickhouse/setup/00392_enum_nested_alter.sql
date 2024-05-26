DROP TABLE IF EXISTS enum_nested_alter;
set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE enum_nested_alter
(d Date DEFAULT '2000-01-01', x UInt64, n Nested(a String, e Enum8('Hello' = 1), b UInt8)) 
ENGINE = MergeTree(d, x, 1);
INSERT INTO enum_nested_alter (x, n.e) VALUES (1, ['Hello']);
