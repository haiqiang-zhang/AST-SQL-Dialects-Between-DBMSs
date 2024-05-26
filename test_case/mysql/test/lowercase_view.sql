select Aaa.col1 from t1Aa as AaA;
create view v1Aa as select Aaa.col1 from t1Aa as AaA;
drop view v1AA;
create view v1Aa as select AaA.col1 from t1Aa as AaA;
drop view v1AA;
drop table t1Aa;
CREATE TABLE  t1 (a int, b int);
CREATE OR REPLACE VIEW v1 AS
select X.a from t1 AS X group by X.b having (X.a = 1);
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE `ttt` (
  `f1` char(3) NOT NULL,
  PRIMARY KEY (`f1`)
)DEFAULT CHARSET=latin1;
SELECT count(COLUMN_NAME) FROM INFORMATION_SCHEMA.STATISTICS WHERE TABLE_NAME =
'TTT';
DROP TABLE `ttt`;
