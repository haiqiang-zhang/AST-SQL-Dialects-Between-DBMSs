SELECT s FROM t1 WHERE f AND (e = 1);
SELECT s FROM t1 WHERE f AND (e = 1) SETTINGS optimize_move_to_prewhere=true;
SELECT s FROM t1 WHERE f AND (e = 1) SETTINGS optimize_move_to_prewhere=false;
SELECT s FROM t1 PREWHERE f AND (e = 1);
SELECT s FROM t1 WHERE e AND (e = 1);
