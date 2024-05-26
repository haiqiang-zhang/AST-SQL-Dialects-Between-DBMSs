PREPARE v1 AS SELECT *
  FROM monthly_sales
    PIVOT(SUM(amount + ?) FOR MONTH IN ('1-JAN', '2-FEB', '3-MAR', '4-APR'))
      AS p
  ORDER BY EMPID;
PREPARE v2 AS
   PIVOT monthly_sales ON MONTH USING SUM(AMOUNT + ?);
EXECUTE v1(0);
EXECUTE v1(1);
EXECUTE v2(1);
