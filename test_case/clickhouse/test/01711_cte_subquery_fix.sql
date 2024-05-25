create view view1 as with t as (select number n from numbers(3)) select n from t;
drop table view1;
