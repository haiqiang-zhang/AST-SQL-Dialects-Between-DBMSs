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
