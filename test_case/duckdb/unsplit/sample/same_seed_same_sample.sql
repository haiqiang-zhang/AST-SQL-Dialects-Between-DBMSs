CREATE or replace TABLE t1 as select range a, [1, a, 2] b, a::VARCHAR || 'ducktastic' c, get_current_time() c from range(1000);
CREATE or replace TABLE t1 as select range a, [1, a, 2] b, a::VARCHAR || 'ducktastic' c, get_current_time() c from range(100000);
SELECT * from t1 using sample reservoir(100) repeatable (1) order by a;
SELECT * from t1 using sample reservoir(100) repeatable (1) order by a;
SELECT * from t1 using sample reservoir(6000) repeatable (1) order by a;
SELECT * from t1 using sample reservoir(6000) repeatable (1) order by a;
