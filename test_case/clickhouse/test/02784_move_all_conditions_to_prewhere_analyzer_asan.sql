SET allow_experimental_analyzer=1;
SET move_all_conditions_to_prewhere=1;
SELECT c1, c2 FROM t_02784 WHERE c1 = 0 AND c2 = 0;
SELECT c1, c2 FROM t_02784 WHERE c2 = 0 AND c1 = 0;
SELECT c2, c1 FROM t_02784 WHERE c1 = 0 AND c2 = 0;
SELECT c2, c1 FROM t_02784 WHERE c2 = 0 AND c1 = 0;
DROP TABLE t_02784;
