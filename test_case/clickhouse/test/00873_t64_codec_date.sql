SELECT * FROM t64 ORDER BY date_32;
SELECT * FROM t64 WHERE date16 != t_date16;
SELECT * FROM t64 WHERE date_32 != t_date32;
OPTIMIZE TABLE t64 FINAL;
SELECT * FROM t64 WHERE date16 != t_date16;
SELECT * FROM t64 WHERE date_32 != t_date32;
DROP TABLE t64;
