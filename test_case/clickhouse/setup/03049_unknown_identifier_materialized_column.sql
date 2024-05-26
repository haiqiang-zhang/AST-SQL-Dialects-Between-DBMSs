SET allow_experimental_analyzer=1;
CREATE TABLE l (y String) Engine Memory;
CREATE TABLE r (d Date, y String, ty UInt16 MATERIALIZED toYear(d)) Engine Memory;
