SELECT '=============== INNER QUERY (NO PARALLEL) ===============';
SELECT '=============== INNER QUERY (PARALLEL) ===============';
SELECT '=============== QUERIES EXECUTED BY PARALLEL INNER QUERY ALONE ===============';
SYSTEM FLUSH LOGS;
DROP TABLE IF EXISTS join_outer_table SYNC;
SELECT '=============== OUTER QUERY (NO PARALLEL) ===============';
SELECT '=============== OUTER QUERY (PARALLEL) ===============';
SYSTEM FLUSH LOGS;
