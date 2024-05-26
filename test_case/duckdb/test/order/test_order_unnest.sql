SELECT UNNEST(s1), s1.a AS id FROM tbl_structs ORDER BY id;
SELECT s1, s1.a FROM tbl_structs ORDER BY 1;
SELECT UNNEST(s1), s1.a AS id FROM tbl_structs ORDER BY 1;
SELECT UNNEST(s1), UNNEST(s2), i FROM tbl_structs ORDER BY i;
SELECT UNNEST(s1), UNNEST(s2), i FROM tbl_structs ORDER BY 2 DESC;
SELECT i, UNNEST(s1), UNNEST(s2) FROM tbl_structs ORDER BY 5 DESC;
