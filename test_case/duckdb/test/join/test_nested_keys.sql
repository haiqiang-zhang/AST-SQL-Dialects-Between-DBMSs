SET default_null_order='nulls_first';;
PRAGMA enable_verification;
CREATE VIEW intlistdim AS SELECT * FROM (VALUES
	([1]),
	([NULL]),
	([]),
	([9,10,11]),
	(NULL)
	) lv(pk);;
CREATE VIEW intlists AS SELECT * FROM (VALUES
	(1, [1]),
	(2, [NULL]),
	(3, []),
	(4, [2, 3]),
	(5, [9,10,11]),
	(NULL::INTEGER, [13])
	) lv(i, fk);;
CREATE VIEW strlistdim AS SELECT * FROM (VALUES
	(['a']),
	([NULL]),
	([]),
	(['i','j','k']),
	(NULL)
	) lv(pk);;
CREATE VIEW strlists AS SELECT * FROM (VALUES
	(1, ['a']),
	(2, [NULL]),
	(3, []),
	(4, ['Branta Canadensis', 'c']),
	(5, ['i','j','k']),
	(NULL::INTEGER, ['Somateria mollissima'])
	) lv(i, fk);;
CREATE VIEW structdim AS SELECT * FROM (VALUES
	({'x': 1, 'y': 'a'}),
	({'x': NULL, 'y': NULL}),
	({'x': 0, 'y': ''}),
	({'x': 9, 'y': 'i'}),
	(NULL)
	) sd(pk);;
CREATE VIEW structs AS SELECT * FROM (VALUES
	(1, {'x': 1, 'y': 'a'}),
	(2, {'x': NULL, 'y': NULL}),
	(3, {'x': 0, 'y': ''}),
	(4, {'x': 2, 'y': 'c'}),
	(5, {'x': 9, 'y': 'i'}),
	(NULL::INTEGER, {'x': 13, 'y': 'Somateria mollissima'})
	) sv(i, fk);;
CREATE VIEW struct_lint_lstr_dim AS SELECT * FROM (VALUES
	({'x': [1], 'y': ['a']}),
	({'x': [NULL], 'y': [NULL]}),
	({'x': [], 'y': []}),
	({'x': [2, 3], 'y': ['Branta Canadensis', 'c']}),
	(NULL)
	) dim(pk);;
CREATE VIEW struct_lint_lstr AS SELECT * FROM (VALUES
	(1, {'x': [1], 'y': ['a']}),
	(2, {'x': [NULL], 'y': [NULL]}),
	(3, {'x': [], 'y': []}),
	(4, {'x': [2, 3], 'y': ['Branta Canadensis', 'c']}),
	(5, {'x': [9,10,11], 'y': ['i','j','k']}),
	(NULL::INTEGER, {'x': [13], 'y': ['Somateria mollissima']})
	) fact(i, fk);;
CREATE VIEW r2l3r4l5i4i2l3v AS SELECT * FROM (VALUES
	(1, {'x': [{'l4': [51], 'i4': 41}], 'y': ['a']}),
	(2, {'x': [NULL], 'y': [NULL]}),
	(3, {'x': [], 'y': []}),
	(4, {'x': [{'l4': [52, 53], 'i4': 42}, {'l4': [54, 55], 'i4': 43}], 'y': ['Branta Canadensis', 'c']}),
	(5, {'x': [{'l4': [56], 'i4': 44}, {'l4': [57, 58], 'i4': 45}, {'l4': [59, 60, 61], 'i4': 46}], 'y': ['i','j','k']}),
	(NULL::INTEGER, {'x': [{'l4': [62], 'i4': 47}], 'y': ['Somateria mollissima']})
	) fact(i, fk);;
CREATE VIEW r2l3r4l5i4i2l3v_dim AS SELECT * FROM (VALUES
	({'x': [{'l4': [51], 'i4': 41}], 'y': ['a']}),
	({'x': [NULL], 'y': [NULL]}),
	({'x': [], 'y': []}),
	({'x': [{'l4': [52, 53], 'i4': 42}, {'l4': [54, 55], 'i4': 43}], 'y': ['Branta Canadensis', 'c']}),
	(NULL)
	) dim(pk);;
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
) lv(i, fk);;
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
) dim(pk);;
SELECT i, pk, fk FROM intlistdim, intlists WHERE pk = fk ORDER BY i;
SELECT i, pk, fk FROM intlistdim LEFT OUTER JOIN intlists ON intlistdim.pk=intlists.fk ORDER BY i;
SELECT i, pk, fk FROM intlists RIGHT OUTER JOIN intlistdim ON intlistdim.pk=intlists.fk ORDER BY i;
SELECT i, pk, fk FROM intlistdim FULL OUTER JOIN intlists ON intlistdim.pk=intlists.fk ORDER BY ALL;
SELECT i, pk, fk FROM strlistdim, strlists WHERE pk = fk ORDER BY i;
SELECT i, pk, fk FROM strlistdim LEFT OUTER JOIN strlists ON strlistdim.pk=strlists.fk ORDER BY i;
SELECT i, pk, fk FROM strlists RIGHT OUTER JOIN strlistdim ON strlistdim.pk=strlists.fk ORDER BY i;
SELECT i, pk, fk FROM strlistdim FULL OUTER JOIN strlists ON strlistdim.pk=strlists.fk ORDER BY ALL;
SELECT i, pk, fk FROM structdim, structs WHERE pk = fk ORDER BY i;
SELECT i, pk, fk FROM structdim LEFT OUTER JOIN structs ON structdim.pk=structs.fk ORDER BY i;
SELECT i, pk, fk FROM structs RIGHT OUTER JOIN structdim ON structdim.pk=structs.fk ORDER BY i;
SELECT i, pk, fk FROM structdim FULL OUTER JOIN structs ON structdim.pk=structs.fk ORDER BY ALL;
SELECT i, pk, fk
FROM struct_lint_lstr_dim, struct_lint_lstr
WHERE pk = fk
ORDER BY i;
SELECT i, pk, fk
FROM struct_lint_lstr_dim
LEFT OUTER JOIN struct_lint_lstr
ON struct_lint_lstr_dim.pk = struct_lint_lstr.fk
ORDER BY i;
SELECT i, pk, fk
FROM struct_lint_lstr
RIGHT OUTER JOIN struct_lint_lstr_dim
ON struct_lint_lstr_dim.pk = struct_lint_lstr.fk
ORDER BY i;
SELECT i, pk, fk
FROM struct_lint_lstr_dim
FULL OUTER JOIN struct_lint_lstr
ON struct_lint_lstr_dim.pk=struct_lint_lstr.fk
ORDER BY ALL;
SELECT i, pk, fk
FROM r2l3r4l5i4i2l3v_dim, r2l3r4l5i4i2l3v
WHERE fk = pk
ORDER BY i;
SELECT i, pk, fk
FROM r2l3r4l5i4i2l3v_dim
LEFT OUTER JOIN r2l3r4l5i4i2l3v
ON r2l3r4l5i4i2l3v_dim.pk = r2l3r4l5i4i2l3v.fk
ORDER BY i;
SELECT i, pk, fk
FROM r2l3r4l5i4i2l3v_dim
RIGHT OUTER JOIN r2l3r4l5i4i2l3v
ON r2l3r4l5i4i2l3v_dim.pk = r2l3r4l5i4i2l3v.fk
ORDER BY i;
SELECT i, pk, fk
FROM r2l3r4l5i4i2l3v_dim
FULL OUTER JOIN r2l3r4l5i4i2l3v
ON r2l3r4l5i4i2l3v_dim.pk = r2l3r4l5i4i2l3v.fk
ORDER BY ALL;
SELECT i, pk, fk
FROM longlists_dim, longlists
WHERE fk = pk
ORDER BY 1, 2, 3;
SELECT i, pk, fk
FROM longlists_dim
LEFT OUTER JOIN longlists
ON longlists.fk = longlists_dim.pk
ORDER BY 1, 2, 3;
SELECT i, pk, fk
FROM longlists_dim
RIGHT OUTER JOIN longlists
ON longlists.fk = longlists_dim.pk
ORDER BY 1, 2, 3;
SELECT i, pk, fk
FROM longlists_dim
FULL OUTER JOIN longlists
ON longlists.fk = longlists_dim.pk
ORDER BY 1, 2, 3;
select * from (
	(select [1,2,3] a from range(3))) tbl(i)
	join
	((select [1,2,3] a from range(3))) tbl2(j)
	on (i=j);;
select * from (
	(select {'x': 1, 'y': 2, 'z': 3} a from range(3))) tbl(i)
	join
	((select {'x': 1, 'y': 2, 'z': 3} a from range(3))) tbl2(j)
	on (i=j);;
