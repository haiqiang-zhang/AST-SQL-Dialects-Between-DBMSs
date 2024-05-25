insert ignore into t1 select col1_idx, col2_idx, col3, col4, 'germany england america', 'germany england america' from t1;
insert into t1 select col1_idx, col2_idx, col3, col4, 'norway sweden', 'norway sweden' from t1 limit 5;
insert into t2 select col1_idx,col2_idx,col3 from t1;
DROP TABLE t1,t2;
