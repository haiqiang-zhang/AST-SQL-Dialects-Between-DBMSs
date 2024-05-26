OPTIMIZE TABLE decimal_sum;
SELECT * FROM decimal_sum;
INSERT INTO decimal_sum VALUES ('2001-01-01', -2, 1, 2);
OPTIMIZE TABLE decimal_sum;
SELECT * FROM decimal_sum;
INSERT INTO decimal_sum VALUES ('2001-01-01', 0, -1, 0);
OPTIMIZE TABLE decimal_sum;
SELECT * FROM decimal_sum;
drop table decimal_sum;
