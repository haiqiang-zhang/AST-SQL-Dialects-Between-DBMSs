SET allow_experimental_analyzer = 1;
SET max_bytes_before_external_sort = 0;
SET max_bytes_before_external_group_by = 0;
-- just something basic
select number, count() over (partition by intDiv(number, 3) order by number rows unbounded preceding) from numbers(10);
select number, max(number) over (partition by intDiv(number, 3) order by number desc rows unbounded preceding) from numbers(10) settings max_block_size = 2;
-- no partition by
select number, avg(number) over (order by number rows unbounded preceding) from numbers(10);
select number, quantileExact(number) over (partition by intDiv(number, 3) AS value order by number rows unbounded preceding) from numbers(10);
select number, quantileExact(number) over (partition by intDiv(number, 3) AS value order by number rows unbounded preceding) q from numbers(10);
select number, q * 10, quantileExact(number) over (partition by intDiv(number, 3) order by number rows unbounded preceding) q from numbers(10) order by number;
select * from (select count(*) over (rows unbounded preceding) c from numbers(3)) where c > 0;
select number, max(number) over (partition by intDiv(number, 3) order by number desc rows unbounded preceding) m from numbers(10) order by m desc, number;
select * from (select count(*) over (rows unbounded preceding) c from numbers(3)) order by c;
select sum(any(number)) over (rows unbounded preceding) from numbers(1);
select sum(any(number) + 1) over (rows unbounded preceding) from numbers(1);
select sum(any(number + 1)) over (rows unbounded preceding) from numbers(1);
-- an explain test would also be helpful, but it's too immature now and I don't
-- want to change reference all the time
select number, max(number) over (partition by intDiv(number, 3) order by number desc rows unbounded preceding), count(number) over (partition by intDiv(number, 5) order by number rows unbounded preceding) as m from numbers(31) order by number settings max_block_size = 2;
-- an explain test would also be helpful, but it's too immature now and I don't
-- want to change reference all the time
select number, max(number) over (partition by intDiv(number, 3) order by number desc rows unbounded preceding), count(number) over (partition by intDiv(number, 3) order by number desc rows unbounded preceding) as m from numbers(7) order by number settings max_block_size = 2;
select median(x) over (partition by x) from (select 1 x);
select groupArray(number) over (rows unbounded preceding) from numbers(3);
select groupArray(number) over () from numbers(3);
-- Seen errors like 'column `1` not found' from count(1).
select count(1) over (rows unbounded preceding), max(number + 1) over () from numbers(3);
select distinct sum(0) over (rows unbounded preceding) from numbers(2);
select distinct any(number) over (rows unbounded preceding) from numbers(2);
-- function definition.
with number + 1 as x select intDiv(number, 3) as y, sum(x + y) over (partition by y order by x rows unbounded preceding) from numbers(7);
select 1 window w1 as ();
select sum(number) over w1, sum(number) over w2
from numbers(10)
window
    w1 as (rows unbounded preceding),
    w2 as (partition by intDiv(number, 3) as value order by number rows unbounded preceding);
-- EXPLAIN test for this.
select
    sum(number) over w1,
    sum(number) over (partition by intDiv(number, 3) as value order by number rows unbounded preceding)
from numbers(10)
window
    w1 as (partition by intDiv(number, 3) rows unbounded preceding);
-- It's the default
select sum(number) over () from numbers(3);
-- of rows that is their least common multiple + 1, so that we see all the
-- interesting corner cases.
select number, intDiv(number, 3) p, mod(number, 2) o, count(number) over w as c
from numbers(31)
window w as (partition by p order by o, number range unbounded preceding)
order by number
settings max_block_size = 5;
select number, intDiv(number, 5) p, mod(number, 3) o, count(number) over w as c
from numbers(31)
window w as (partition by p order by o, number range unbounded preceding)
order by number
settings max_block_size = 2;
select number, intDiv(number, 5) p, mod(number, 2) o, count(number) over w as c
from numbers(31)
window w as (partition by p order by o, number range unbounded preceding)
order by number
settings max_block_size = 3;
select number, intDiv(number, 3) p, mod(number, 5) o, count(number) over w as c
from numbers(31)
window w as (partition by p order by o, number range unbounded preceding)
order by number
settings max_block_size = 2;
select number, intDiv(number, 2) p, mod(number, 5) o, count(number) over w as c
from numbers(31)
window w as (partition by p order by o, number range unbounded preceding)
order by number
settings max_block_size = 3;
select number, intDiv(number, 2) p, mod(number, 3) o, count(number) over w as c
from numbers(31)
window w as (partition by p order by o range unbounded preceding)
order by number
settings max_block_size = 5;
-- is triggered by the partition end.
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
select number, p,
    count(*) over (partition by p order by number
        rows between 2 preceding and 2 following)
from (select number, intDiv(number, 7) p from numbers(71))
order by p, number
settings max_block_size = 2;
SELECT count(*) OVER (ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) FROM numbers(4);
select
    count() over (partition by intDiv(number, 3)
        rows between 100 following and unbounded following),
    count() over (partition by intDiv(number, 3)
        rows between current row and 100 following)
from numbers(10);
select count() over ();
select number, p, o,
    count(*) over (partition by p order by o
        range between current row and unbounded following)
from (select number, intDiv(number, 5) p, mod(number, 3) o
    from numbers(31))
order by p, o, number
settings max_block_size = 2;
select
    count(*) over (rows between  current row and current row),
    count(*) over (range between  current row and current row)
from numbers(3);
-- a basic RANGE OFFSET frame
select x, min(x) over w, max(x) over w, count(x) over w from (
    select toUInt8(number) x from numbers(11))
window w as (order by x asc range between 1 preceding and 2 following)
order by x;
select x, min(x) over w, max(x) over w, count(x) over w
from (
    select toUInt8(if(mod(number, 2),
        toInt64(255 - intDiv(number, 2)),
        toInt64(intDiv(number, 2)))) x
    from numbers(10)
)
window w as (order by x range between 1 preceding and 2 following)
order by x;
select x, min(x) over w, max(x) over w, count(x) over w
from (
    select toInt8(multiIf(
        mod(number, 3) == 0, toInt64(intDiv(number, 3)),
        mod(number, 3) == 1, toInt64(127 - intDiv(number, 3)),
        toInt64(-128 + intDiv(number, 3)))) x
    from numbers(15)
)
window w as (order by x range between 1 preceding and 2 following)
order by x;
-- else the frame end runs into partition end w/o overflow and doesn't move
-- after that. The frame from this query is equivalent to the entire partition.
select x, min(x) over w, max(x) over w, count(x) over w
from (
    select toUInt8(if(mod(number, 2),
        toInt64(255 - intDiv(number, 2)),
        toInt64(intDiv(number, 2)))) x
    from numbers(10)
)
window w as (order by x range between 255 preceding and 255 following)
order by x;
select x, min(x) over w, max(x) over w, count(x) over w from (
    select toUInt8(number) x from numbers(11)) t
window w as (order by x desc range between 1 preceding and 2 following)
order by x
settings max_block_size = 1;
select x, min(x) over w, max(x) over w, count(x) over w from (
    select toUInt8(number) x from numbers(11)) t
window w as (order by x desc range between 1 preceding and unbounded following)
order by x
settings max_block_size = 2;
select x, min(x) over w, max(x) over w, count(x) over w from (
    select toUInt8(number) x from numbers(11)) t
window w as (order by x desc range between unbounded preceding and 2 following)
order by x
settings max_block_size = 3;
select x, min(x) over w, max(x) over w, count(x) over w from (
    select toUInt8(number) x from numbers(11)) t
window w as (order by x desc range between unbounded preceding and 2 preceding)
order by x
settings max_block_size = 4;
-- First, check that at least the result is correct when we have many windows
-- with different sort order.
select
    number,
    count(*) over (partition by p order by number),
    count(*) over (partition by p order by number, o),
    count(*) over (),
    count(*) over (order by number),
    count(*) over (order by o),
    count(*) over (order by o, number),
    count(*) over (order by number, o),
    count(*) over (partition by p order by o, number),
    count(*) over (partition by p),
    count(*) over (partition by p order by o),
    count(*) over (partition by p, o order by number)
from
    (select number, intDiv(number, 3) p, mod(number, 5) o
        from numbers(16)) t
order by number;
-- simple cases instead.
explain select
    count(*) over (partition by p),
    count(*) over (),
    count(*) over (partition by p order by o)
from
    (select number, intDiv(number, 3) p, mod(number, 5) o
        from numbers(16)) t;
explain select
    count(*) over (order by o, number),
    count(*) over (order by number)
from
    (select number, intDiv(number, 3) p, mod(number, 5) o
        from numbers(16)) t;
SELECT
    max(number) OVER (ORDER BY number DESC NULLS FIRST),
    max(number) OVER (ORDER BY number ASC NULLS FIRST)
FROM numbers(2);
-- it is disabled.
drop table if exists window_mt;
create table window_mt engine MergeTree order by number
    as select number, mod(number, 3) p from numbers(100);
select number, count(*) over (partition by p)
    from window_mt order by number limit 10 settings optimize_read_in_order = 0;
select number, count(*) over (partition by p)
    from window_mt order by number limit 10 settings optimize_read_in_order = 1;
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
-- this is the same as `select max(Null::Nullable(Nothing))`
select intDiv(1, NULL) x, toTypeName(x), max(x) over ();
select
    number,
    fIrSt_VaLue(number) over w,
    lAsT_vAlUe(number) over w
from numbers(10)
window w as (order by number range between 1 preceding and 1 following)
order by number;
select
    number,
    nth_value(number, 1) over w as firstValue,
    nth_value(number, 2) over w as secondValue,
    nth_value(number, 3) over w as thirdValue,
    nth_value(number, 4) over w as fourthValue
from numbers(10)
window w as (order by number)
order by number;
select
    number,
    nth_value(number, 1) over w as firstValue,
    nth_value(number, 2) over w as secondValue,
    nth_value(number, 3) over w as thirdValue,
    nth_value(number, 4) over w as fourthValue
from numbers(10)
window w as (order by number range between 1 preceding and 1 following)
order by number;
SELECT nth_value(1, /* INT64_MAX */ 0x7fffffffffffffff) OVER ();
SELECT nth_value(1, 1) OVER ();
SELECT lagInFrame(1, 0) OVER ();
SELECT lagInFrame(1, /* INT64_MAX */ 0x7fffffffffffffff) OVER ();
SELECT lagInFrame(1, 1) OVER ();
SELECT leadInFrame(1, 0) OVER ();
SELECT leadInFrame(1, /* INT64_MAX */ 0x7fffffffffffffff) OVER ();
SELECT leadInFrame(1, 1) OVER ();
-- In this case, we had a problem with PartialSortingTransform returning zero-row
-- chunks for input chunks w/o columns.
select count() over () from numbers(4) where number < 2;
select
    count(*) over (order by toFloat32(number) range 5 preceding),
    count(*) over (order by toFloat64(number) range 5 preceding),
    count(*) over (order by toFloat32(number) range between current row and 5 following),
    count(*) over (order by toFloat64(number) range between current row and 5 following)
from numbers(7);
-- a test with aggregate function that allocates memory in arena
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
-- Somehow in this case WindowTransform gets empty input chunks not marked as
-- input end, and then two (!) empty input chunks marked as input end. Whatever.
select count() over () from (select 1 a) l inner join (select 2 a) r using a;
select count() over () where null;
select number, count() over (w1 rows unbounded preceding) from numbers(10)
window
    w0 as (partition by intDiv(number, 5) as p),
    w1 as (w0 order by mod(number, 3) as o, number)
order by p, o, number;
-- looks weird but probably should work -- this is a window that inherits and changes nothing
select count() over (w) from numbers(1) window w as ();
