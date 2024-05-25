select sum(toUInt64(str)), sum(toUInt64(s)) from lc_prewhere prewhere val == 1;
drop table if exists lc_prewhere;
