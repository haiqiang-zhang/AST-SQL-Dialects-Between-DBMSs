SELECT * FROM m PREWHERE a = 'OK' ORDER BY a, f;
SELECT * FROM m PREWHERE f = 1 ORDER BY a, f;
SELECT * FROM m WHERE f = 0 SETTINGS optimize_move_to_prewhere=0;
SELECT * FROM m WHERE f = 0 SETTINGS optimize_move_to_prewhere=1;
