create table t1 (id int(10)) ENGINE=MyISAM;
insert into t1 values (1);
CREATE  VIEW v1 AS select t1.id as id from t1;
CREATE  VIEW v2 AS select t1.id as renamed from t1;
CREATE  VIEW v3 AS select t1.id + 12 as renamed from t1;
