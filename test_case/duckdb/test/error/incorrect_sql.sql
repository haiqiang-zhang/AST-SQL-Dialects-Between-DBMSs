SELEC 42;;
SELEC 42, 'thisisareallylongstringloremipsumblablathisisareallylongstringloremipsumblablalthisisareallylongstringloremipsumblablalthisisareallylongstringloremipsumblablal';;
SELEC 42, '🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆';;
SELECT '🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆', x, '🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆';;
SELECT FUNFUNFUN();;
CREATE VIEW v1
AS SELECT FUNFUNFUN();;
SELECT SUM(42, 84, 11, 'hello');
SELECT cos(0, 1, 2, 3);;
SELECT * FROM RANG();;
SELECT * FROM RANGE(1, hello=3);;
SELECT * FROM READ_CSV('x', hello=3);;
SELECT 42 WHERE 1=1 WHERE 1=0;;
SELECT 42
SELECT 42;;
SELECT 42; SELEC 42;;
SELECT * FROM integers2;;
SELECT * FROM bla.integers2;;
CREATE VIEW v1 AS SELECT * FROM integers2;;
with cte1 as (select 42 as j), cte2 as (select ref.j as k from cte1 as ref), cte3 as (select ref2.j+1 as i from cte1 as ref2) SELECT * FROM integers9;;
with cte1 as (select 42 as j), cte2 as (select ref.j as k from cte1 as ref), cte3 as (select ref2.j+1 as i from cte1 as ref2) SELECT * FROM integers9 where x=3 order by x+1+1+1+1+1+1+1+1+1+1+1;;
SELECT
    l_returnflag,
    l_linestatus,
    sum(l_quantity) AS sum_qty,
    sum(l_extendedprice) AS sum_base_price,
    sum(l_extendedprice * (1 - l_discount)) AS sum_disc_price,
    sum(l_extendedprice * (1 - l_discount) * (1 + l_tax)) AS sum_charge,
    avg(l_quantity) AS avg_qty,
    avg(l_extendedprice) AS avg_price,
    avg(l_discount) AS avg_disc,
    count(*) AS count_order
FROM
    lineitem
WHERE
    l_shipdate <= CAST('1998-09-02' AS date)
GROUP BY
    l_returnflag,
    l_linestatus
ORDER BY
    l_returnflag,
    l_linestatus;;
select 🦆🍞 from 🦆🍞;;
with 🍞🍞 as (select 'bread' as 🍞), 🦆🦆 as (select ref.🍞 as "🍞" from 🍞🍞 as ref) SELECT * FROM integers9 where x LIKE '🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆🦆' order by x+1+1+1+1+1+1+1+1+1+1+1;;
CREATE TABLE integers(integ INTEGER);;
CREATE TABLE strings(str VARCHAR);;
CREATE TABLE chickens(feather INTEGER, beak INTEGER);;
SELECT * FROM integres;;
SELECT feathe FROM chickens;;
SELECT feathe FROM chickens, integers, strings;;
SELECT st FROM chickens, integers, strings;;
SELECT chicken.feather FROM chickens;
SELECT chicken.st FROM chickens, integers, strings;;
CREATE TABLE 🦆🍞(🦆🦆🦆 INTEGER, 🍞🍞🍞 INTEGER);;
SELECT 🦆.🦆🦆🦆 FROM 🦆🍞;
SELECT 🦆🦆 FROM 🦆🍞, chickens;