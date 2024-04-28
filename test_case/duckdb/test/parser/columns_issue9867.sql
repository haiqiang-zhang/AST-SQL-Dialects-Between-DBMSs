PRAGMA enable_verification;
CREATE TABLE df1 AS
  SELECT
    UNNEST(['K0', 'K1', 'K2', 'K3', 'K4', 'K5']) AS key,
    UNNEST([11, 12, 13, 14, 15, 16]) AS A,
    UNNEST([21, 22, 23, 24, 25, 26]) AS B;
CREATE TABLE df2 AS
  SELECT
    UNNEST(['K0', 'K2', 'K5']) AS key,
    UNNEST([2, 3, 5]) AS C;
select sin(columns(dfxx.* exclude (key))) from df1 join df2 using(key);
select sin(columns(df1.* exclude (key))) from df1 join df2 using(key);
