UPDATE t SET f=100 WHERE i=2;
SELECT COUNT(*) = 2 FROM information_schema.processlist 
  WHERE state = 'Optimizing' and info = 'SELECT MAX(i) FROM t FOR UPDATE';
DROP TABLE t;
