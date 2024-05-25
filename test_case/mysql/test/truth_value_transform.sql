select id, a=1 is false from t1;
select id, not (a=1 is true) from t1;
select id, (not a=1) is true from t1;
select id, not (a=1 is false) from t1;
select id, not (a=1 is unknown) from t1;
select id, ((not a=1) is true) is false from t1;
select id, 3 + (not (a=1 is false)) from t1;
drop table t1;
