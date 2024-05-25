SELECT date, argMax(name, clicks) FROM lc GROUP BY date;
drop table if exists lc;
