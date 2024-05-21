SET allow_experimental_analyzer=1;
CREATE TABLE l (y String) Engine Memory;
CREATE TABLE r (d Date, y String, ty UInt16 MATERIALIZED toYear(d)) Engine Memory;
select * from l L left join r R on  L.y = R.y  where R.ty >= 2019;
select * from l left join r  on  l.y = r.y  where r.ty >= 2019;
