SELECT * FROM m PREWHERE a = 'OK' ORDER BY a, f;
SELECT * FROM m PREWHERE f = 1 ORDER BY a, f;
SELECT * FROM m WHERE f = 0 SETTINGS optimize_move_to_prewhere=0;
SELECT * FROM m WHERE f = 0 SETTINGS optimize_move_to_prewhere=1;
DROP TABLE m;
DROP TABLE t1;
DROP TABLE t2;
