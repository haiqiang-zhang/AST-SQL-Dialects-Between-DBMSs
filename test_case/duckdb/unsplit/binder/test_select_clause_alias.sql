PRAGMA enable_verification;
CREATE TABLE integers(i INTEGER);
INSERT INTO integers VALUES (1), (2), (3);
create table orders as
select
    cast(random()*100 as integer) + 1 as customer_id,
    date '2020-01-01' + interval (cast(random()*365*10 as integer)) days as order_date,
    cast(random()*1000 as integer) as order_amount,
from range(0, 1000)
order by order_date;
SELECT i + 1 AS a, a + 1 AS b FROM integers ORDER BY b;
SELECT i + 1 AS a, a + a AS b, b + b AS c, c + c AS d FROM integers ORDER BY b;
SELECT i + 1 AS i, i + 1 AS b FROM integers ORDER BY b;
