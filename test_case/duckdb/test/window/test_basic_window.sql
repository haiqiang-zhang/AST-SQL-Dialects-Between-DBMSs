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
