PRAGMA enable_verification;
CREATE TABLE empsalary (depname varchar, empno bigint, salary int, enroll_date date);
INSERT INTO empsalary VALUES ('develop', 10, 5200, '2007-08-01'), ('sales', 1, 5000, '2006-10-01'), ('personnel', 5, 3500, '2007-12-10'), ('sales', 4, 4800, '2007-08-08'), ('personnel', 2, 3900, '2006-12-23'), ('develop', 7, 4200, '2008-01-01'), ('develop', 9, 4500, '2008-01-01'), ('sales', 3, 4800, '2007-08-01'), ('develop', 8, 6000, '2006-10-01'), ('develop', 11, 5200, '2007-08-15');
SELECT depname, empno, salary, sum(salary) OVER (PARTITION BY depname ORDER BY empno) FROM empsalary ORDER BY depname, empno;
SELECT sum(salary) OVER (PARTITION BY depname ORDER BY salary) ss FROM empsalary ORDER BY depname, ss;
SELECT row_number() OVER (PARTITION BY depname ORDER BY salary) rn FROM empsalary ORDER BY depname, rn;
SELECT empno, first_value(empno) OVER (PARTITION BY depname ORDER BY empno) fv FROM empsalary ORDER BY 2 DESC, 1 ASC;
SELECT depname, empno,
	last_value(empno) OVER (
		PARTITION BY depname ORDER BY empno ASC
		ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
		) fv
FROM empsalary
ORDER BY 1, 2;
SELECT depname, salary, dense_rank() OVER (PARTITION BY depname ORDER BY salary) FROM empsalary order by depname, salary;
SELECT depname, salary, rank() OVER (PARTITION BY depname ORDER BY salary) FROM empsalary order by depname, salary;
SELECT depname, min(salary) OVER (PARTITION BY depname ORDER BY salary, empno) m1, max(salary) OVER (PARTITION BY depname ORDER BY salary, empno) m2, AVG(salary) OVER (PARTITION BY depname ORDER BY salary, empno) m3 FROM empsalary ORDER BY depname, empno;
SELECT depname, STDDEV_POP(salary) OVER (PARTITION BY depname ORDER BY salary, empno) s FROM empsalary ORDER BY depname, empno;
SELECT depname, COVAR_POP(salary, empno) OVER (PARTITION BY depname ORDER BY salary, empno) c FROM empsalary ORDER BY depname, empno;
