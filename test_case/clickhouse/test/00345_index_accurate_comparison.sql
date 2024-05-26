select * from index where key = 1;
select * from index where key = -1;
OPTIMIZE TABLE index;
select * from index where key = 1;
select * from index where key = -1;
select * from index where key < -0.5;
DROP TABLE index;
