DROP TABLE IF EXISTS enum_pk;
set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE enum_pk (date Date DEFAULT '0000-00-00', x Enum8('0' = 0, '1' = 1, '2' = 2), d Enum8('0' = 0, '1' = 1, '2' = 2)) ENGINE = MergeTree(date, x, 1);
INSERT INTO enum_pk (x, d) VALUES ('0', '0')('1', '1')('0', '0')('1', '1')('1', '1')('0', '0')('0', '0')('2', '2')('0', '0')('1', '1')('1', '1')('1', '1')('1', '1')('0', '0');
