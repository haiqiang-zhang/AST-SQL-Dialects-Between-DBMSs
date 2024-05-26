create table quantiles as select range r, random() FROM range(100) union all values (NULL, 0.1), (NULL, 0.5), (NULL, 0.9) order by 2;
