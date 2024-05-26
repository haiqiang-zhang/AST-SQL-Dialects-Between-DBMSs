select 'optimize_move_to_prewhere_if_final = 1';
SET optimize_move_to_prewhere_if_final = 1;
SELECT replaceRegexpAll(explain, '__table1\.|_UInt8|_UInt16', '') FROM (EXPLAIN actions=1 SELECT * FROM prewhere_move_select_final WHERE x > 100) WHERE explain LIKE '%Prewhere%';
SELECT * FROM (EXPLAIN actions=1 SELECT * FROM prewhere_move_select_final FINAL WHERE z > 400) WHERE explain LIKE '%Prewhere filter';
select 'optimize_move_to_prewhere_if_final = 0';
SET optimize_move_to_prewhere_if_final = 0;
DROP TABLE prewhere_move_select_final;
