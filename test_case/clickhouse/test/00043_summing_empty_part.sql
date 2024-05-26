OPTIMIZE TABLE empty_summing;
SELECT * FROM empty_summing;
INSERT INTO empty_summing VALUES ('2015-01-01', 1, 4),('2015-01-01', 2, -9),('2015-01-01', 3, -14);
INSERT INTO empty_summing VALUES ('2015-01-01', 1, -2),('2015-01-01', 1, -2),('2015-01-01', 3, 14);
INSERT INTO empty_summing VALUES ('2015-01-01', 1, 0),('2015-01-01', 3, 0);
OPTIMIZE TABLE empty_summing;
SELECT * FROM empty_summing;
DROP TABLE empty_summing;
