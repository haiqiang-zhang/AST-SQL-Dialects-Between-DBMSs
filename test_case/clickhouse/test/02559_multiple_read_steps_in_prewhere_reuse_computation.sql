SET enable_multiple_prewhere_read_steps = 1;
SELECT a FROM t_02559 PREWHERE sin(a) < b AND sin(a) < c;
SELECT sin(a) > 2 FROM t_02559 PREWHERE sin(a) < b AND sin(a) < c;
SELECT sin(a) < a FROM t_02559 PREWHERE sin(a) < b AND sin(a) < c AND sin(a) > -a;
SELECT sin(a) < a FROM t_02559 PREWHERE sin(a) < b AND a <= c AND sin(a) > -a;
DROP TABLE t_02559;
