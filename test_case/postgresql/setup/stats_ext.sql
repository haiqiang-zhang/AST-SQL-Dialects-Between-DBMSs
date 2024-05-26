end;
CREATE TABLE ext_stats_test (x text, y int, z int);
DROP TABLE ext_stats_test;
CREATE TABLE ab1 (a INTEGER, b INTEGER, c INTEGER);
CREATE STATISTICS IF NOT EXISTS ab1_a_b_stats ON a, b FROM ab1;
