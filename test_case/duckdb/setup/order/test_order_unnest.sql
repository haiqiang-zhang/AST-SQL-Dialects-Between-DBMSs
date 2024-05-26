CREATE TABLE tbl_structs AS SELECT
	{'a': 2.0, 'b': 'hello', 'c': [1, 2]} AS s1,
	1::BIGINT AS i,
	{'k': 1::TINYINT, 'j': 0::BOOL} AS s2;
INSERT INTO tbl_structs VALUES (
	{'a': 1.0, 'b': 'yay', 'c': [10, 20]},
	42,
	{'k': 2, 'j': 1});
