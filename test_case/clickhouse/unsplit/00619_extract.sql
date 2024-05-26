SELECT EXTRACT(DAY FROM toDate('2017-06-15'));
SELECT EXTRACT (MONTH FROM toDate('2017-06-15'));
SELECT extract(MONTH FROM toDateTime('2017-12-31 18:59:58'));
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (OrderId UInt64, OrderName String, OrderDate DateTime) engine = Log;
insert into Orders values (1,   'Jarlsberg Cheese',    toDateTime('2008-10-11 13:23:44'));
DROP TABLE Orders;
