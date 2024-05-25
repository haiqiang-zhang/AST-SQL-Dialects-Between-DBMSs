PRAGMA enable_verification;
CREATE TABLE tenk1 ( unique1 int4, unique2 int4, two int4, four int4, ten int4, twenty int4, hundred int4, thousand int4, twothousand int4, fivethous int4, tenthous int4, odd int4, even int4, stringu1 string, stringu2 string, string4 string );
insert into tenk1 values (4, 1621, 0, 0, 4, 4, 4, 4, 4, 4, 4, 8 ,9 ,'EAAAAA', 'JKCAAA', 'HHHHxx'), (2, 2716, 0, 2, 2, 2, 2, 2, 2, 2, 2, 4 ,5 ,'CAAAAA', 'MAEAAA', 'AAAAxx'), (1, 2838, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2 ,3 ,'BAAAAA', 'EFEAAA', 'OOOOxx'), (6, 2855, 0, 2, 6, 6, 6, 6, 6, 6, 6, 12 ,13 ,'GAAAAA', 'VFEAAA', 'VVVVxx'), (9, 4463, 1, 1, 9, 9, 9, 9, 9, 9, 9, 18 ,19 ,'JAAAAA', 'RPGAAA', 'VVVVxx'),(8, 5435, 0, 0, 8, 8, 8, 8, 8, 8, 8, 16 ,17 ,'IAAAAA', 'BBIAAA', 'VVVVxx'), (5, 5557, 1, 1, 5, 5, 5, 5, 5, 5, 5, 10 ,11,'FAAAAA', 'TFIAAA', 'HHHHxx'), (3, 5679, 1, 3, 3, 3, 3, 3, 3, 3, 3, 6 ,7 ,'DAAAAA', 'LKIAAA', 'VVVVxx'), (7, 8518, 1,3, 7, 7, 7, 7, 7, 7, 7, 14 ,15 ,'HAAAAA', 'QPMAAA', 'OOOOxx'), (0, 9998, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ,1 ,'AAAAAA','OUOAAA', 'OOOOxx');
create table issue1472 (permno real, date date, ret real);
insert into issue1472 values
    (10000.0, '1986-02-28'::date, -0.2571428716182709),
    (10000.0, '1986-03-31'::date, 0.36538460850715637),
    (10000.0, '1986-04-30'::date, -0.09859155118465424),
    (10000.0, '1986-05-30'::date, -0.22265625),
    (10000.0, '1986-06-30'::date, -0.005025125574320555);
create table issue1697 as
    select mod(b, 100) as a, b from (select b from range(10000) tbl(b)) t;
select avg(a) over (
    order by b asc
    rows between mod(b * 1023, 11) preceding and 23 - mod(b * 1023, 11) following)
from issue1697;
SELECT sum(unique1) over (order by unique1 rows between 2 preceding and 2 following) su FROM tenk1 order by unique1;
SELECT sum(unique1) over (order by unique1 rows between 2 preceding and 1 preceding) su FROM tenk1 order by unique1;
SELECT sum(unique1) over (order by unique1 rows between 1 following and 3 following) su FROM tenk1 order by unique1;
SELECT sum(unique1) over (order by unique1 rows between unbounded preceding and 1 following) su FROM tenk1 order by unique1;
SELECT sum(unique1) over (order by unique1 rows between 5 following and 10 following) su FROM tenk1 order by unique1;
select permno,
    sum(log(ret+1)) over (PARTITION BY permno ORDER BY date rows between 12 preceding and 2 preceding),
    ret
from issue1472
ORDER BY permno, date;
