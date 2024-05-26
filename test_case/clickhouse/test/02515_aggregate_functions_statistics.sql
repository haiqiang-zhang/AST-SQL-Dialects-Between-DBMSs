SELECT corrMatrix(a_value) FROM (select a_value from fh limit 0);
SELECT arrayMap(x -> arrayMap(y -> round(y, 5), x), corrMatrix(a_value, b_value, c_value, d_value))  FROM fh;
SELECT round(abs(corr(x1,x2) - corrMatrix(x1,x2)[1][2]), 5), round(abs(corr(x1,x1) - corrMatrix(x1,x2)[1][1]), 5), round(abs(corr(x2,x2) - corrMatrix(x1,x2)[2][2]), 5) from (select randNormal(100, 1) as x1, randNormal(100,5) as x2 from numbers(100000));
SELECT covarSampMatrix(a_value) FROM (select a_value from fh limit 0);
SELECT covarPopMatrix(a_value) FROM (select a_value from fh limit 0);
