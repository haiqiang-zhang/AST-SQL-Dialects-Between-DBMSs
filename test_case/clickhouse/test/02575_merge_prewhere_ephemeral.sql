SELECT * FROM m PREWHERE a = 'OK' ORDER BY a;
SELECT * FROM m WHERE a = 'OK' SETTINGS optimize_move_to_prewhere=0;
SELECT * FROM m WHERE a = 'OK' SETTINGS optimize_move_to_prewhere=1;
