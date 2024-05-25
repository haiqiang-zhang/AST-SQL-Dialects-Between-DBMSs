select visitor_id,max(ts) as mts from t1 group by visitor_id
having mts < DATE_SUB(NOW(),INTERVAL 3 MONTH);
select visitor_id,max(ts) as mts from t1 group by visitor_id
having DATE_ADD(mts,INTERVAL 3 MONTH) < NOW();
drop table t1;
