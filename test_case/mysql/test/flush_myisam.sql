select * from tm;
select * from t1;
select * from t2;
unlock tables;
select * from tm;
select * from t1;
select * from t2;
unlock tables;
drop tables tm, t1, t2;
