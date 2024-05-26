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
	on (i=j);
select * from (
	(select {'x': 1, 'y': 2, 'z': 3} a from range(3))) tbl(i)
	join
	((select {'x': 1, 'y': 2, 'z': 3} a from range(3))) tbl2(j)
	on (i=j);
