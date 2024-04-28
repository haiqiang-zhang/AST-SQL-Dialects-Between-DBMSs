PRAGMA enable_verification;
CREATE TABLE emp (empno INTEGER PRIMARY KEY,
                  ename VARCHAR,
				  job VARCHAR,
				  mgr INTEGER,
				  hiredate DATE,
				  sal DOUBLE,
				  comm DOUBLE,
				  deptno INTEGER);;
INSERT INTO emp VALUES (7839, 'KING', 'PRESIDENT', NULL, DATE '1981-11-17', 5000.00, NULL, 10);
INSERT INTO emp VALUES (7698, 'BLAKE', 'MANAGER', 7839, DATE '1981-05-01', 2850.00, NULL, 30);
INSERT INTO emp VALUES (7782, 'CLARK', 'MANAGER', 7839, DATE '1981-06-09', 2450.00, NULL, 10);
INSERT INTO emp VALUES (7566, 'JONES', 'MANAGER', 7839, DATE '1981-04-02', 2975.00, NULL, 20);
INSERT INTO emp VALUES (7902, 'FORD', 'ANALYST', 7566, DATE '1981-12-03', 3000.00, NULL, 20);
INSERT INTO emp VALUES (7369, 'SMITH', 'CLERK', 7902, DATE '1980-12-17', 800.00, NULL, 20);
INSERT INTO emp VALUES (7499, 'ALLEN', 'SALESMAN', 7698, DATE '1981-02-20', 1600.00, 300.00, 30);
INSERT INTO emp VALUES (7521, 'WARD', 'SALESMAN', 7698, DATE '1981-02-22', 1250.00, 500.00, 30);
INSERT INTO emp VALUES (7654, 'MARTIN', 'SALESMAN', 7698, DATE '1981-09-28', 1250.00, 1400.00, 30);
INSERT INTO emp VALUES (7844, 'TURNER', 'SALESMAN', 7698, DATE '1981-09-08', 1500.00, 0.00, 30);
INSERT INTO emp VALUES (7900, 'JAMES', 'CLERK', 7698, DATE '1981-12-03', 950.00, NULL, 30);
INSERT INTO emp VALUES (7934, 'MILLER', 'CLERK', 7782, DATE '1982-01-23', 1300.00, NULL, 10);;
CREATE VIEW ctenames AS (
  WITH RECURSIVE ctename AS (
      SELECT empno, ename,
             ename AS path
      FROM emp
      WHERE empno = 7566
     UNION ALL
      SELECT emp.empno, emp.ename,
             ctename.path || ' -> ' || emp.ename
      FROM emp
         JOIN ctename ON emp.mgr = ctename.empno
  )
  SELECT * FROM ctename
);;
WITH RECURSIVE ctename AS (
      SELECT empno, ename
      FROM emp
      WHERE empno = 7566
   UNION ALL
      SELECT emp.empno, emp.ename
      FROM emp
         JOIN ctename ON emp.mgr = ctename.empno
)
SELECT * FROM ctename;;
WITH RECURSIVE ctename AS (
      SELECT empno, ename,
             0 AS level
      FROM emp
      WHERE empno = 7566
   UNION ALL
      SELECT emp.empno, emp.ename,
             ctename.level + 1
      FROM emp
         JOIN ctename ON emp.mgr = ctename.empno
)
SELECT * FROM ctename;;
WITH RECURSIVE ctename AS (
      SELECT empno, ename,
             ename AS path
      FROM emp
      WHERE empno = 7566
   UNION ALL
      SELECT emp.empno, emp.ename,
             ctename.path || ' -> ' || emp.ename
      FROM emp
         JOIN ctename ON emp.mgr = ctename.empno
)
SELECT * FROM ctename;;
SELECT * FROM ctenames;;
WITH RECURSIVE fib AS (
      SELECT 1 AS n,
             1::bigint AS "fibₙ",
             1::bigint AS "fibₙ₊₁"
   UNION ALL
      SELECT n+1,
             "fibₙ₊₁",
             "fibₙ" + "fibₙ₊₁"
      FROM fib
)
SELECT n, "fibₙ" FROM fib
LIMIT 20;;