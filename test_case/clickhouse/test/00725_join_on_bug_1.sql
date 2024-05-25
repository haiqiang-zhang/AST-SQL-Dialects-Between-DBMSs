SELECT * FROM a1 as a left JOIN a2 as b on a.a=b.a ORDER BY b SETTINGS join_default_strictness='ANY';
SELECT '-';
SELECT a1.*, a2.* FROM a1 ANY LEFT JOIN a2 USING a ORDER BY b;
DROP TABLE IF EXISTS a1;
DROP TABLE IF EXISTS a2;
