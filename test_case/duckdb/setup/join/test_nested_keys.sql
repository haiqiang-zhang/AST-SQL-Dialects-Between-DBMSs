SET default_null_order='nulls_first';
PRAGMA enable_verification;
CREATE VIEW intlistdim AS SELECT * FROM (VALUES
	([1]),
	([NULL]),
	([]),
	([9,10,11]),
	(NULL)
	) lv(pk);
CREATE VIEW intlists AS SELECT * FROM (VALUES
	(1, [1]),
	(2, [NULL]),
	(3, []),
	(4, [2, 3]),
	(5, [9,10,11]),
	(NULL::INTEGER, [13])
	) lv(i, fk);
CREATE VIEW strlistdim AS SELECT * FROM (VALUES
	(['a']),
	([NULL]),
	([]),
	(['i','j','k']),
	(NULL)
	) lv(pk);
CREATE VIEW strlists AS SELECT * FROM (VALUES
	(1, ['a']),
	(2, [NULL]),
	(3, []),
	(4, ['Branta Canadensis', 'c']),
	(5, ['i','j','k']),
	(NULL::INTEGER, ['Somateria mollissima'])
	) lv(i, fk);
CREATE VIEW structdim AS SELECT * FROM (VALUES
	({'x': 1, 'y': 'a'}),
	({'x': NULL, 'y': NULL}),
	({'x': 0, 'y': ''}),
	({'x': 9, 'y': 'i'}),
	(NULL)
	) sd(pk);
CREATE VIEW structs AS SELECT * FROM (VALUES
	(1, {'x': 1, 'y': 'a'}),
	(2, {'x': NULL, 'y': NULL}),
	(3, {'x': 0, 'y': ''}),
	(4, {'x': 2, 'y': 'c'}),
	(5, {'x': 9, 'y': 'i'}),
	(NULL::INTEGER, {'x': 13, 'y': 'Somateria mollissima'})
	) sv(i, fk);
CREATE VIEW struct_lint_lstr_dim AS SELECT * FROM (VALUES
	({'x': [1], 'y': ['a']}),
	({'x': [NULL], 'y': [NULL]}),
	({'x': [], 'y': []}),
	({'x': [2, 3], 'y': ['Branta Canadensis', 'c']}),
	(NULL)
	) dim(pk);
CREATE VIEW struct_lint_lstr AS SELECT * FROM (VALUES
	(1, {'x': [1], 'y': ['a']}),
	(2, {'x': [NULL], 'y': [NULL]}),
	(3, {'x': [], 'y': []}),
	(4, {'x': [2, 3], 'y': ['Branta Canadensis', 'c']}),
	(5, {'x': [9,10,11], 'y': ['i','j','k']}),
	(NULL::INTEGER, {'x': [13], 'y': ['Somateria mollissima']})
	) fact(i, fk);
CREATE VIEW r2l3r4l5i4i2l3v AS SELECT * FROM (VALUES
	(1, {'x': [{'l4': [51], 'i4': 41}], 'y': ['a']}),
	(2, {'x': [NULL], 'y': [NULL]}),
	(3, {'x': [], 'y': []}),
	(4, {'x': [{'l4': [52, 53], 'i4': 42}, {'l4': [54, 55], 'i4': 43}], 'y': ['Branta Canadensis', 'c']}),
	(5, {'x': [{'l4': [56], 'i4': 44}, {'l4': [57, 58], 'i4': 45}, {'l4': [59, 60, 61], 'i4': 46}], 'y': ['i','j','k']}),
	(NULL::INTEGER, {'x': [{'l4': [62], 'i4': 47}], 'y': ['Somateria mollissima']})
	) fact(i, fk);
CREATE VIEW r2l3r4l5i4i2l3v_dim AS SELECT * FROM (VALUES
	({'x': [{'l4': [51], 'i4': 41}], 'y': ['a']}),
	({'x': [NULL], 'y': [NULL]}),
	({'x': [], 'y': []}),
	({'x': [{'l4': [52, 53], 'i4': 42}, {'l4': [54, 55], 'i4': 43}], 'y': ['Branta Canadensis', 'c']}),
	(NULL)
	) dim(pk);
CREATE VIEW longlists AS
SELECT *
FROM ((VALUES
	(1, [1]),
	(2, [NULL]),
	(3, []),
	(4, [2, 3]),
	(NULL::INTEGER, [13])
	)
UNION ALL
	select 5 as i, list(r) as pk from range(2000) tbl(r)
) lv(i, fk);
CREATE VIEW longlists_dim AS
SELECT *
FROM ((VALUES
	([1]),
	([NULL]),
	([]),
	([2, 3]),
	(NULL)
	)
UNION ALL
	select list(r) as pk from range(2000) tbl(r)
UNION ALL
	select list(r) as pk from range(1050) tbl(r)
) dim(pk);
