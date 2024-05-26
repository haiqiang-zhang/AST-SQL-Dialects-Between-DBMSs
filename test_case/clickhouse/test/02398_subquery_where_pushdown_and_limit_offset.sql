select number from (select number from t order by number desc offset 3) where number < 18;
explain syntax select number from (select number from t order by number desc offset 3) where number < 18;
select number from (select number from t order by number limit 5) where number % 2;
explain syntax select number from (select number from t order by number limit 5) where number % 2;
drop table t;
