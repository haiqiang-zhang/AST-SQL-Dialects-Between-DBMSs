select count() from (select y from t_mv group by y);
drop table if exists t;
drop table if exists t_mv;
