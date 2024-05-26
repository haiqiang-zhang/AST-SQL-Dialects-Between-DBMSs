SELECT depname, empno,
	nth_value(empno, 2) OVER (
		PARTITION BY depname ORDER BY empno ASC
		ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
		) fv
FROM empsalary
ORDER BY 1, 2;
SELECT depname, empno,
	nth_value(empno, NULL) OVER (
		PARTITION BY depname ORDER BY empno ASC
		ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
		) fv
FROM empsalary
ORDER BY 1, 2;
SELECT depname, empno,
	nth_value(NULL, 2) OVER (
		PARTITION BY depname ORDER BY empno ASC
		ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
		) fv
FROM empsalary
ORDER BY 1, 2;
SELECT depname, empno,
	nth_value(empno, case empno % 3 when 1 then 2 else NULL end) OVER (
		PARTITION BY depname ORDER BY empno ASC
		ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
		) fv
FROM empsalary
ORDER BY 1, 2;
SELECT depname, empno,
	nth_value(empno, 2) OVER (
		PARTITION BY depname ORDER BY empno ASC
		ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
		) fv
FROM empno_nulls
ORDER BY 1, 2;
SELECT depname, empno, 1 + empno %3 as offset,
	nth_value(empno, 1 + empno %3) OVER (
		PARTITION BY depname ORDER BY empno ASC
		ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
		) fv
FROM empsalary
ORDER BY 1, 2;
SELECT depname, empno, empno %3 as offset,
	nth_value(empno, empno %3) OVER (
		PARTITION BY depname ORDER BY empno ASC
		ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
		) fv
FROM empsalary
ORDER BY 1, 2;
SELECT depname, empno,
	nth_value(-1, 2) OVER (
		PARTITION BY depname ORDER BY empno ASC
		ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
		) fv
FROM empsalary
ORDER BY 1, 2;
