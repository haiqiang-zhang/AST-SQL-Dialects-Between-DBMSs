SELECT * FROM monthly_sales
    UNPIVOT(sales FOR month IN (jan, feb, mar, april))
    ORDER BY empid;
SELECT empid, dept, april, month, sales FROM monthly_sales
    UNPIVOT(sales FOR month IN (jan, feb, mar))
    ORDER BY empid;
SELECT * FROM monthly_sales
    UNPIVOT(sales FOR month IN (jan AS January, feb AS February, mar AS March, april))
    ORDER BY empid;
SELECT p.id, p.type, p.m, p.vals FROM monthly_sales
    UNPIVOT(sales FOR month IN (jan, feb, mar, april)) AS p(id, type, m, vals);
SELECT empid, dept, month, sales_jan_feb, sales_mar_apr FROM monthly_sales
    UNPIVOT((sales_jan_feb, sales_mar_apr) FOR month IN ((jan, feb), (mar, april)));
UNPIVOT (SELECT * FROM monthly_sales)
    ON jan, feb, mar april
    INTO
        NAME month
        VALUE sales;
