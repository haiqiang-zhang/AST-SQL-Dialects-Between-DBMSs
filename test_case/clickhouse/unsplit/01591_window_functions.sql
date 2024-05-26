SET allow_experimental_analyzer = 1;
SET max_bytes_before_external_sort = 0;
SET max_bytes_before_external_group_by = 0;
select number, count() over (partition by intDiv(number, 3) order by number rows unbounded preceding) from numbers(10);
select number, max(number) over (partition by intDiv(number, 3) order by number desc rows unbounded preceding) from numbers(10) settings max_block_size = 2;
select number, avg(number) over (order by number rows unbounded preceding) from numbers(10);
select number, quantileExact(number) over (partition by intDiv(number, 3) AS value order by number rows unbounded preceding) from numbers(10);
select number, quantileExact(number) over (partition by intDiv(number, 3) AS value order by number rows unbounded preceding) q from numbers(10);
select * from (select count(*) over (rows unbounded preceding) c from numbers(3)) where c > 0;
select * from (select count(*) over (rows unbounded preceding) c from numbers(3)) order by c;
select sum(any(number)) over (rows unbounded preceding) from numbers(1);
select number, max(number) over (partition by intDiv(number, 3) order by number desc rows unbounded preceding), count(number) over (partition by intDiv(number, 5) order by number rows unbounded preceding) as m from numbers(31) order by number settings max_block_size = 2;
select median(x) over (partition by x) from (select 1 x);
select groupArray(number) over (rows unbounded preceding) from numbers(3);
select count(1) over (rows unbounded preceding), max(number + 1) over () from numbers(3);
select distinct any(number) over (rows unbounded preceding) from numbers(2);
with number + 1 as x select intDiv(number, 3) as y, sum(x + y) over (partition by y order by x rows unbounded preceding) from numbers(7);
select 1 window w1 as ();
select min(number) over (partition by p)  from (select number, intDiv(number, 3) p from numbers(10));
select
    min(number) over wa, min(number) over wo,
    max(number) over wa, max(number) over wo
from
    (select number, intDiv(number, 3) p, mod(number, 5) o
        from numbers(31))
window
    wa as (partition by p order by o
        range between unbounded preceding and unbounded following),
    wo as (partition by p order by o
        rows between unbounded preceding and unbounded following)
settings max_block_size = 2;
select number, p,
    count(*) over (partition by p order by number
        rows between 1 preceding and unbounded following),
    count(*) over (partition by p order by number
        rows between current row and unbounded following),
    count(*) over (partition by p order by number
        rows between 1 following and unbounded following)
from (select number, intDiv(number, 5) p from numbers(31))
order by p, number
settings max_block_size = 2;
select x, min(x) over w, max(x) over w, count(x) over w from (
    select toUInt8(number) x from numbers(11))
window w as (order by x asc range between 1 preceding and 2 following)
order by x;
explain select
    count(*) over (partition by p),
    count(*) over (),
    count(*) over (partition by p order by o)
from
    (select number, intDiv(number, 3) p, mod(number, 5) o
        from numbers(16)) t;
drop table if exists window_mt;
create table window_mt engine MergeTree order by number
    as select number, mod(number, 3) p from numbers(100);
drop table window_mt;
select number, p, o,
    count(*) over w,
    rank() over w,
    dense_rank() over w,
    row_number() over w
from (select number, intDiv(number, 5) p, mod(number, 3) o
    from numbers(31) order by o, number) t
window w as (partition by p order by o, number)
order by p, o, number
settings max_block_size = 2;
select
    anyOrNull(number)
        over (order by number rows between 1 preceding and 1 preceding),
    anyOrNull(number)
        over (order by number rows between 1 following and 1 following)
from numbers(5);
select number, p, pp,
    lagInFrame(number) over w as lag1,
    lagInFrame(number, number - pp) over w as lag2,
    lagInFrame(number, number - pp, number * 11) over w as lag,
    leadInFrame(number, number - pp, number * 11) over w as lead
from (select number, intDiv(number, 5) p, p * 5 pp from numbers(16))
window w as (partition by p order by number
    rows between unbounded preceding and unbounded following)
order by number
settings max_block_size = 3;
select lagInFrame(toNullable(1)) over ();
select intDiv(1, NULL) x, toTypeName(x), max(x) over ();
select
    number,
    fIrSt_VaLue(number) over w,
    lAsT_vAlUe(number) over w
from numbers(10)
window w as (order by number range between 1 preceding and 1 following)
order by number;
SELECT nth_value(1, /* INT64_MAX */ 0x7fffffffffffffff) OVER ();
SELECT leadInFrame(1, 0) OVER ();
select sum(a[length(a)])
from (
    select groupArray(number) over (partition by modulo(number, 11)
            order by modulo(number, 1111), number) a
    from numbers_mt(10000)
) settings max_block_size = 7;
select bitmapCardinality(bs)
from
    (
        select groupBitmapMergeState(bm) over (order by k asc rows between unbounded preceding and current row) as bs
        from
            (
                select
                    groupBitmapState(number) as bm, k
                from
                    (
                        select
                            number,
                            number % 3 as k
                        from numbers(3)
                    )
                group by k
            )
    );
