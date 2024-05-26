SELECT (
	SELECT ref_1.nested_int_array
) AS c0
FROM range(3), nested AS ref_1;
SELECT DISTINCT * FROM intlists ORDER BY ALL;
SELECT pk, p FROM intlists ORDER BY pk;
SELECT fk, pk, p FROM integers, intlists WHERE fk = pk ORDER BY ALL;
SELECT fk, pk, p FROM integers LEFT OUTER JOIN intlists ON integers.fk=intlists.pk ORDER BY ALL;
SELECT fk, pk, p
FROM integers LEFT OUTER JOIN intlists ON integers.fk=intlists.pk
WHERE pk < 5 AND fk > 1
ORDER BY ALL;
SELECT fk, pk, p FROM intlists RIGHT OUTER JOIN integers ON integers.fk=intlists.pk ORDER BY ALL;
SELECT fk, pk, p FROM integers FULL OUTER JOIN intlists ON integers.fk=intlists.pk ORDER BY ALL;
SELECT DISTINCT * FROM strlists ORDER BY ALL;
SELECT fk, pk, p FROM integers, strlists WHERE fk = pk ORDER BY fk;
SELECT fk, pk, p FROM integers LEFT OUTER JOIN strlists ON integers.fk=strlists.pk ORDER BY fk;
SELECT fk, pk, p
FROM integers LEFT OUTER JOIN strlists ON integers.fk=strlists.pk
WHERE pk < 5 AND fk > 1
ORDER BY fk;
SELECT fk, pk, p FROM strlists RIGHT OUTER JOIN integers ON integers.fk=strlists.pk ORDER BY fk;
SELECT fk, pk, p FROM integers FULL OUTER JOIN strlists ON integers.fk=strlists.pk ORDER BY ALL;
SELECT DISTINCT * FROM structs ORDER BY ALL;
SELECT pk, p FROM structs ORDER BY pk;
SELECT fk, pk, p FROM integers, structs WHERE fk = pk ORDER BY ALL;
SELECT fk, pk, p FROM integers LEFT OUTER JOIN structs ON integers.fk=structs.pk ORDER BY ALL;
SELECT fk, pk, p
FROM integers LEFT OUTER JOIN structs ON integers.fk=structs.pk
WHERE pk < 5 AND fk > 1
ORDER BY ALL;
SELECT fk, pk, p FROM structs RIGHT OUTER JOIN integers ON integers.fk=structs.pk ORDER BY ALL;
SELECT fk, pk, p FROM integers FULL OUTER JOIN structs ON integers.fk=structs.pk ORDER BY ALL;
SELECT DISTINCT * FROM struct_lint_lstr ORDER BY ALL;
SELECT fk, pk, p FROM integers, struct_lint_lstr WHERE fk = pk ORDER BY ALL;
SELECT fk, pk, p
FROM integers LEFT OUTER JOIN struct_lint_lstr ON integers.fk=struct_lint_lstr.pk
ORDER BY ALL;
SELECT fk, pk, p
FROM integers LEFT OUTER JOIN struct_lint_lstr ON integers.fk=struct_lint_lstr.pk
WHERE pk < 5 AND fk > 1
ORDER BY ALL;
SELECT fk, pk, p
FROM struct_lint_lstr RIGHT OUTER JOIN integers ON integers.fk=struct_lint_lstr.pk
ORDER BY ALL;
SELECT fk, pk, p
FROM integers FULL OUTER JOIN struct_lint_lstr ON integers.fk=struct_lint_lstr.pk
ORDER BY ALL;
SELECT DISTINCT * FROM r2l3r4l5i4i2l3v ORDER BY ALL;
SELECT fk, pk, p FROM integers, r2l3r4l5i4i2l3v WHERE fk = pk ORDER BY ALL;
SELECT fk, pk, p
FROM integers LEFT OUTER JOIN r2l3r4l5i4i2l3v ON integers.fk=r2l3r4l5i4i2l3v.pk
ORDER BY ALL;
SELECT fk, pk, p
FROM integers LEFT OUTER JOIN r2l3r4l5i4i2l3v ON integers.fk=r2l3r4l5i4i2l3v.pk
WHERE pk < 5 AND fk > 1
ORDER BY ALL;
SELECT fk, pk, p
FROM r2l3r4l5i4i2l3v RIGHT OUTER JOIN integers ON integers.fk=r2l3r4l5i4i2l3v.pk
ORDER BY ALL;
SELECT fk, pk, p
FROM integers FULL OUTER JOIN r2l3r4l5i4i2l3v ON integers.fk=r2l3r4l5i4i2l3v.pk
ORDER BY ALL;
SELECT DISTINCT * FROM longlists ORDER BY ALL;
SELECT pk, p FROM longlists ORDER BY pk;
SELECT fk, pk, p FROM integers, longlists WHERE fk = pk ORDER BY ALL;
SELECT fk, pk, p FROM integers LEFT OUTER JOIN longlists ON integers.fk=longlists.pk ORDER BY ALL;
SELECT fk, pk, p
FROM integers LEFT OUTER JOIN longlists ON integers.fk=longlists.pk
WHERE pk < 5 AND fk > 1
ORDER BY ALL;
SELECT fk, pk, p FROM longlists RIGHT OUTER JOIN integers ON integers.fk=longlists.pk ORDER BY ALL;
SELECT fk, pk, p FROM integers FULL OUTER JOIN longlists ON integers.fk=longlists.pk ORDER BY ALL;
SELECT ref_1.nested_int_array AS c0
FROM all_types AS ref_1
INNER JOIN (SELECT NULL AS c8 FROM range(3)) AS subq_1 ON (ref_1."varchar" = ref_1."varchar")
INNER JOIN range(3) AS ref_4(time_tz) ON (subq_1.c8 = ref_4.time_tz);
