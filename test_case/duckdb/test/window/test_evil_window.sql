PRAGMA enable_verification;
CREATE TABLE empsalary (depname varchar, empno bigint, salary int, enroll_date date);
INSERT INTO empsalary VALUES ('develop', 10, 5200, '2007-08-01'), ('sales', 1, 5000, '2006-10-01'), ('personnel', 5, 3500, '2007-12-10'), ('sales', 4, 4800, '2007-08-08'), ('personnel', 2, 3900, '2006-12-23'), ('develop', 7, 4200, '2008-01-01'), ('develop', 9, 4500, '2008-01-01'), ('sales', 3, 4800, '2007-08-01'), ('develop', 8, 6000, '2006-10-01'), ('develop', 11, 5200, '2007-08-15');
select *
from (
    select lag(i, -1) over () as negative, lead(i, 1) over () as positive
    from generate_series(0, 10, 1) tbl(i)
    ) w
where negative <> positive;
SELECT depname, sum(sum(salary)) over (partition by depname order by salary) FROM empsalary group by depname, salary order by depname, salary;
SELECT empno, sum(salary*2) OVER (PARTITION BY depname ORDER BY empno) FROM empsalary ORDER BY depname, empno;
SELECT empno, 2*sum(salary) OVER (PARTITION BY depname ORDER BY empno) FROM empsalary ORDER BY depname, empno;
SELECT depname, sum(salary)*100.0000/sum(sum(salary)) OVER (PARTITION BY depname ORDER BY salary) AS revenueratio FROM empsalary GROUP BY depname, salary ORDER BY depname, revenueratio;
