WITH 10 as k SELECT k as key, * FROM repl_tbl WHERE key = k;
DROP TABLE IF EXISTS repl_tbl;
