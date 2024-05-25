SET wal_autocheckpoint='1TB';;
CREATE TABLE t(i int, j int);;
INSERT INTO t SELECT ii, NULL FROM range(1024) tbl(ii);;
CHECKPOINT;;
UPDATE t SET j = 1;;
select COUNT(j), MIN(j), MAX(j) from t;;
select COUNT(j), MIN(j), MAX(j) from t;;
select COUNT(j), MIN(j), MAX(j) from t;;
