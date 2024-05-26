SELECT COUNT(*) FROM (SELECT DISTINCT c1 FROM t_myisam) dt, t_myisam;
SELECT 1 AS c1, (SELECT COUNT(*) FROM t_innodb HAVING c1 > 0) FROM DUAL;
SELECT 1 FROM t_innodb HAVING COUNT(*) > 1;
SELECT COUNT(*) c FROM t_innodb HAVING c > 1;
SELECT COUNT(*) c FROM t_innodb HAVING c > 7;
SELECT COUNT(*) c FROM t_innodb LIMIT 10 OFFSET 5;
DROP TABLE t_innodb, t_myisam;
